Content-Type: multipart/mixed; boundary="===============6336587165397234595=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 1/6] mptcp: separate accouting for wmem
 forward alloc mem
Date: Tue, 10 Nov 2020 17:35:30 -0800
Message-ID: <77ad6c30-4512-76ce-02c-7b5196c35@linux.intel.com>
In-Reply-To: 2e37a154dacbddd63974e5ec744469b05327ff85.1605006569.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6653

--===============6336587165397234595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2020, Paolo Abeni wrote:

> Account separatelly the memory forward allocated
> for write operation. When sendmsg() need more memory
> it looks at wforward_alloc first and if that is
> exaused, move more space from sk_forward_alloc.
>
> This will simplify the next patch
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> TODO:
> - sk_diag_dump() after calling inet_sk_diag_fill()
>  must modify the newly added nlhdr, changing
>  INET_DIAG_MEMINFO addr and specifically
>  .idiag_fmem to sk_forward_alloc + wforward_alloc
> ---
> net/mptcp/protocol.c | 54 ++++++++++++++++++++++++++++++++++++++++----
> net/mptcp/protocol.h |  1 +
> 2 files changed, 50 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0956c7db0fd5..7000560c0cd9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -840,9 +840,50 @@ static bool mptcp_frag_can_collapse_to(const struct =
mptcp_sock *msk,
> 		df->data_seq + df->data_len =3D=3D msk->write_seq;
> }
>
> +static bool mptcp_wmem_alloc(struct sock *sk, int size)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	int amount;
> +	int ret;
> +
> +	if (msk->wforward_alloc >=3D size)
> +		goto account;

'ret' is uninitialized on this 'goto' path.


Mat


> +
> +	ret =3D sk_wmem_schedule(sk, size);
> +	if (!ret)
> +		return false;
> +
> +	/* try to keep half fwd alloc memory for each direction */
> +	amount =3D max(size, sk->sk_forward_alloc >> 1);
> +	sk->sk_forward_alloc -=3D amount;
> +	msk->wforward_alloc +=3D amount;
> +
> +account:
> +	msk->wforward_alloc -=3D size;
> +	return ret;
> +}
> +
> +static void mptcp_wmem_uncharge(struct sock *sk, int size)
> +{
> +	mptcp_sk(sk)->wforward_alloc +=3D size;
> +}
> +
> +static void mptcp_mem_reclaim_partial(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +	sk->sk_forward_alloc +=3D msk->wforward_alloc;
> +	msk->wforward_alloc =3D 0;
> +	sk_mem_reclaim_partial(sk);
> +
> +	/* split the remaining fwd allocated memory between rx and tx */
> +	msk->wforward_alloc =3D sk->sk_forward_alloc >> 1;
> +	sk->sk_forward_alloc -=3D msk->wforward_alloc;
> +}
> +
> static void dfrag_uncharge(struct sock *sk, int len)
> {
> -	sk_mem_uncharge(sk, len);
> +	mptcp_wmem_uncharge(sk, len);
> 	sk_wmem_queued_add(sk, -len);
> }
>
> @@ -897,8 +938,8 @@ static void mptcp_clean_una(struct sock *sk)
> 	}
>
> out:
> -	if (cleaned)
> -		sk_mem_reclaim_partial(sk);
> +	if (cleaned && tcp_under_memory_pressure(sk))
> +		mptcp_mem_reclaim_partial(sk);
> }
>
> static void mptcp_clean_una_wakeup(struct sock *sk)
> @@ -1322,11 +1363,12 @@ static int mptcp_sendmsg(struct sock *sk, struct =
msghdr *msg, size_t len)
> 		offset =3D dfrag->offset + dfrag->data_len;
> 		psize =3D pfrag->size - offset;
> 		psize =3D min_t(size_t, psize, msg_data_left(msg));
> -		if (!sk_wmem_schedule(sk, psize + frag_truesize))
> +		if (!mptcp_wmem_alloc(sk, psize + frag_truesize))
> 			goto wait_for_memory;
>
> 		if (copy_page_from_iter(dfrag->page, offset, psize,
> 					&msg->msg_iter) !=3D psize) {
> +			mptcp_wmem_uncharge(sk, psize + frag_truesize);
> 			ret =3D -EFAULT;
> 			goto out;
> 		}
> @@ -1342,7 +1384,6 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
> 		 * Note: we charge such data both to sk and ssk
> 		 */
> 		sk_wmem_queued_add(sk, frag_truesize);
> -		sk->sk_forward_alloc -=3D frag_truesize;
> 		if (!dfrag_collapsed) {
> 			get_page(dfrag->page);
> 			list_add_tail(&dfrag->list, &msk->rtx_queue);
> @@ -1965,6 +2006,7 @@ static int __mptcp_init_sock(struct sock *sk)
> 	INIT_WORK(&msk->work, mptcp_worker);
> 	msk->out_of_order_queue =3D RB_ROOT;
> 	msk->first_pending =3D NULL;
> +	msk->wforward_alloc =3D 0;
>
> 	msk->ack_hint =3D NULL;
> 	msk->first =3D NULL;
> @@ -2155,6 +2197,8 @@ static void __mptcp_destroy_sock(struct sock *sk)
>
> 	sk->sk_prot->destroy(sk);
>
> +	sk->sk_forward_alloc +=3D msk->wforward_alloc;
> +	msk->wforward_alloc =3D 0;
> 	sk_stream_kill_queues(sk);
> 	xfrm_sk_free_policy(sk);
> 	sk_refcnt_debug_release(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 07542f7b349a..2a842d228950 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -219,6 +219,7 @@ struct mptcp_sock {
> 	u64		ack_seq;
> 	u64		rcv_wnd_sent;
> 	u64		rcv_data_fin_seq;
> +	int		wforward_alloc;
> 	struct sock	*last_snd;
> 	int		snd_burst;
> 	int		old_wspace;
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============6336587165397234595==--
