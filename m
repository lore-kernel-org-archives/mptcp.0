Content-Type: multipart/mixed; boundary="===============4570967661311319979=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 1/2] tcp: factor out tcp_build_frag()
Date: Thu, 15 Oct 2020 17:24:43 -0700
Message-ID: <d1662864-587b-8735-7f48-a49acfa8e5ee@linux.intel.com>
In-Reply-To: 3f6f46cb7133df6f4ef2ffcdc05d9805d46ca939.1602693911.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6324

--===============4570967661311319979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 14 Oct 2020, Paolo Abeni wrote:

> Will be needed by the next patch, as MPTCP needs to handle
> directly the error/memory-allocation-needed path.
>
> No functional changes intented.

Minor: "intended"

Worth mentioning the change to tcp_remove_empty_skb() visibility too?

>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> RFC -> v1:
> - rename do_tcp_sendfrag() -> tcp_buildfrag()
> - changed return type and argument list to
>   simplify the caller
> ---
> include/net/tcp.h |   3 ++
> net/ipv4/tcp.c    | 119 ++++++++++++++++++++++++++--------------------
> 2 files changed, 70 insertions(+), 52 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 3601dea931a6..dbde4ec3cfa3 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -322,6 +322,7 @@ void tcp_shutdown(struct sock *sk, int how);
> int tcp_v4_early_demux(struct sk_buff *skb);
> int tcp_v4_rcv(struct sk_buff *skb);
>
> +void tcp_remove_empty_skb(struct sock *sk, struct sk_buff *skb);
> int tcp_v4_tw_remember_stamp(struct inet_timewait_sock *tw);
> int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
> int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size);
> @@ -329,6 +330,8 @@ int tcp_sendpage(struct sock *sk, struct page *page, =
int offset, size_t size,
> 		 int flags);
> int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
> 			size_t size, int flags);
> +struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
> +			       struct page *page, int offset, size_t *size);
> ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
> 		 size_t size, int flags);
> int tcp_send_mss(struct sock *sk, int *size_goal, int flags);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index bae4284bf542..259dca2bd3dd 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -952,7 +952,7 @@ int tcp_send_mss(struct sock *sk, int *size_goal, int=
 flags)
>  * importantly be able to generate EPOLLOUT for Edge Trigger epoll()
>  * users.
>  */
> -static void tcp_remove_empty_skb(struct sock *sk, struct sk_buff *skb)
> +void tcp_remove_empty_skb(struct sock *sk, struct sk_buff *skb)
> {
> 	if (skb && !skb->len) {
> 		tcp_unlink_write_queue(skb, sk);
> @@ -962,6 +962,68 @@ static void tcp_remove_empty_skb(struct sock *sk, st=
ruct sk_buff *skb)
> 	}
> }
>
> +struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
> +			       struct page *page, int offset, size_t *size)
> +{
> +	struct sk_buff *skb =3D tcp_write_queue_tail(sk);
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	bool can_coalesce;
> +	int copy, i;
> +
> +	if (!skb || (copy =3D size_goal - skb->len) <=3D 0 ||
> +	    !tcp_skb_can_collapse_to(skb)) {
> +new_segment:
> +		if (!sk_stream_memory_free(sk))
> +			return NULL;
> +
> +		skb =3D sk_stream_alloc_skb(sk, 0, sk->sk_allocation,
> +				tcp_rtx_and_write_queues_empty(sk));
> +		if (!skb)
> +			return NULL;
> +
> +#ifdef CONFIG_TLS_DEVICE
> +		skb->decrypted =3D !!(flags & MSG_SENDPAGE_DECRYPTED);
> +#endif
> +		skb_entail(sk, skb);
> +		copy =3D size_goal;
> +	}
> +
> +	if (copy > *size)
> +		copy =3D *size;
> +
> +	i =3D skb_shinfo(skb)->nr_frags;
> +	can_coalesce =3D skb_can_coalesce(skb, i, page, offset);
> +	if (!can_coalesce && i >=3D sysctl_max_skb_frags) {
> +		tcp_mark_push(tp, skb);
> +		goto new_segment;
> +	}
> +	if (!sk_wmem_schedule(sk, copy))
> +		return NULL;
> +
> +	if (can_coalesce) {
> +		skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
> +	} else {
> +		get_page(page);
> +		skb_fill_page_desc(skb, i, page, offset, copy);
> +	}
> +
> +	if (!(flags & MSG_NO_SHARED_FRAGS))
> +		skb_shinfo(skb)->tx_flags |=3D SKBTX_SHARED_FRAG;
> +
> +	skb->len +=3D copy;
> +	skb->data_len +=3D copy;
> +	skb->truesize +=3D copy;
> +	sk_wmem_queued_add(sk, copy);
> +	sk_mem_charge(sk, copy);
> +	skb->ip_summed =3D CHECKSUM_PARTIAL;
> +	WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
> +	TCP_SKB_CB(skb)->end_seq +=3D copy;
> +	tcp_skb_pcount_set(skb, 0);
> +
> +	*size =3D copy;
> +	return skb;
> +}
> +
> ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
> 			 size_t size, int flags)
> {
> @@ -997,60 +1059,13 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct p=
age *page, int offset,
> 		goto out_err;
>
> 	while (size > 0) {
> -		struct sk_buff *skb =3D tcp_write_queue_tail(sk);
> -		int copy, i;
> -		bool can_coalesce;
> -
> -		if (!skb || (copy =3D size_goal - skb->len) <=3D 0 ||
> -		    !tcp_skb_can_collapse_to(skb)) {
> -new_segment:
> -			if (!sk_stream_memory_free(sk))
> -				goto wait_for_space;
> -
> -			skb =3D sk_stream_alloc_skb(sk, 0, sk->sk_allocation,
> -					tcp_rtx_and_write_queues_empty(sk));
> -			if (!skb)
> -				goto wait_for_space;
> -
> -#ifdef CONFIG_TLS_DEVICE
> -			skb->decrypted =3D !!(flags & MSG_SENDPAGE_DECRYPTED);
> -#endif
> -			skb_entail(sk, skb);
> -			copy =3D size_goal;
> -		}
> +		struct sk_buff *skb;
> +		size_t copy =3D size;

This initialization is the only thing that needed a deeper look, but =

following how it's used in tcp_build_frag() the behavior does look the =

same.

This patch (with commit message comments above) and #2 look good to post =

to netdev for feedback.

Thanks,

Mat


>
> -		if (copy > size)
> -			copy =3D size;
> -
> -		i =3D skb_shinfo(skb)->nr_frags;
> -		can_coalesce =3D skb_can_coalesce(skb, i, page, offset);
> -		if (!can_coalesce && i >=3D sysctl_max_skb_frags) {
> -			tcp_mark_push(tp, skb);
> -			goto new_segment;
> -		}
> -		if (!sk_wmem_schedule(sk, copy))
> +		skb =3D tcp_build_frag(sk, size_goal, flags, page, offset, &copy);
> +		if (!skb)
> 			goto wait_for_space;
>
> -		if (can_coalesce) {
> -			skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
> -		} else {
> -			get_page(page);
> -			skb_fill_page_desc(skb, i, page, offset, copy);
> -		}
> -
> -		if (!(flags & MSG_NO_SHARED_FRAGS))
> -			skb_shinfo(skb)->tx_flags |=3D SKBTX_SHARED_FRAG;
> -
> -		skb->len +=3D copy;
> -		skb->data_len +=3D copy;
> -		skb->truesize +=3D copy;
> -		sk_wmem_queued_add(sk, copy);
> -		sk_mem_charge(sk, copy);
> -		skb->ip_summed =3D CHECKSUM_PARTIAL;
> -		WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
> -		TCP_SKB_CB(skb)->end_seq +=3D copy;
> -		tcp_skb_pcount_set(skb, 0);
> -
> 		if (!copied)
> 			TCP_SKB_CB(skb)->tcp_flags &=3D ~TCPHDR_PSH;
>
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============4570967661311319979==--
