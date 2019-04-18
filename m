Content-Type: multipart/mixed; boundary="===============5750458740144619590=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 3/3] mptcp: allow collapsing consecutive sendpages
 on the same substream
Date: Thu, 18 Apr 2019 16:56:00 -0700
Message-ID: <alpine.OSX.2.21.1904181637170.41859@scottgi-mobl.amr.corp.intel.com>
In-Reply-To: dc523dc2ca06423b41b316c7770760322489e557.1555342070.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1078

--===============5750458740144619590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Apr 2019, Paolo Abeni wrote:

> If the current sendmsg() lands on the same subflow we used last, we
> can try to collapse the data.
>
> RFC -> v1
> - claried collasping schema
> - update data_len for collapsed skb in mptcp_sendmsg_frag()
> - fix collapsing decision on mptcp-level OoO
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 77 ++++++++++++++++++++++++++++++++++----------
> 1 file changed, 60 insertions(+), 17 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 085d658af772..0a947f44f712 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -47,11 +47,24 @@ static struct sock *mptcp_subflow_get_ref(const struc=
t mptcp_sock *msk)
> 	return NULL;
> }
>
> +static inline bool mptcp_skb_can_collapse_to(const struct mptcp_sock *ms=
k,
> +					     const struct sk_buff *skb,
> +					     const struct mptcp_ext *mpext)
> +{
> +	if (!tcp_skb_can_collapse_to(skb))
> +		return false;
> +
> +	/* can't collapse if there is a MPTCP level out-of-order */
> +	return mpext->data_seq + mpext->data_len =3D=3D msk->write_seq;

Ok, looks like a good in-order check.

> +}
> +
> static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> -			      struct msghdr *msg, long *timeo)
> +			      struct msghdr *msg, long *timeo, int *pmss_now,
> +			      int *ps_goal)
> {
> +	int mss_now, avail_size, size_goal, poffset, ret;
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	int mss_now, size_goal, poffset, ret;
> +	bool collapsed, can_collapse =3D false;
> 	struct mptcp_ext *mpext =3D NULL;
> 	struct page_frag *pfrag;
> 	struct sk_buff *skb;
> @@ -78,25 +91,48 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
> 	if (!psize)
> 		return -EINVAL;
>
> -	/* Mark the end of the previous write so the beginning of the
> -	 * next write (with its own mptcp skb extension data) is not
> -	 * collapsed.
> -	 */
> +	mss_now =3D tcp_send_mss(ssk, &size_goal, msg->msg_flags);
> +	*pmss_now =3D mss_now;
> +	*ps_goal =3D size_goal;
> +	avail_size =3D size_goal;
> 	skb =3D tcp_write_queue_tail(ssk);
> -	if (skb)
> -		TCP_SKB_CB(skb)->eor =3D 1;
> +	if (skb) {
> +		mpext =3D skb_ext_find(skb, SKB_EXT_MPTCP);
> +		BUG_ON(!mpext);
> +
> +		/* Limit the write to the size available in the
> +		 * current skb, if any, so that we create at most a new skb.
> +		 * If we run out of space in the current skb (e.g. the window
> +		 * size shrunk from last sent) a new skb will be allocated even
> +		 * is collapsing was allowed: collapsing is effectively
> +		 * disabled.
> +		 */
> +		can_collapse =3D mptcp_skb_can_collapse_to(msk, skb, mpext);
> +		if (!can_collapse)
> +			TCP_SKB_CB(skb)->eor =3D 1;
> +		else if (size_goal - skb->len > 0)
> +			avail_size =3D size_goal - skb->len;
> +		else
> +			can_collapse =3D false;

In this final clause, should it set eor as well? If we're not expecting a =

collapse, it might be better to make sure it does not happen.

> +	}
>
> -	mss_now =3D tcp_send_mss(ssk, &size_goal, msg->msg_flags);
> -	psize =3D min_t(int, size_goal, psize);
> +	/* tell the TCP stack to delay the push so that we can safely
> +	 * access the skb after the sendpages call
> +	 */
> +	psize =3D min_t(int, avail_size, psize);
> 	ret =3D do_tcp_sendpages(ssk, pfrag->page, poffset, psize,
> 			       msg->msg_flags | MSG_SENDPAGE_NOTLAST);
> 	if (ret <=3D 0)
> 		return ret;
>
> -	if (skb =3D=3D tcp_write_queue_tail(ssk))
> -		pr_err("no new skb %p/%p", sk, ssk);
> +	collapsed =3D skb =3D=3D tcp_write_queue_tail(ssk);
> +	BUG_ON(collapsed && !can_collapse);
>
> 	skb =3D tcp_write_queue_tail(ssk);

Minor: seems like this skb assignment is coupled with the mpext line below =

rather than the conditional to update mpext and exit, and could be moved =

after the collapse check.

Thanks,

Mat


> +	if (collapsed) {
> +		mpext->data_len +=3D ret;
> +		goto out;
> +	}
>
> 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
>
> @@ -112,22 +148,25 @@ static int mptcp_sendmsg_frag(struct sock *sk, stru=
ct sock *ssk,
> 		pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u checksum=3D%u,=
 dsn64=3D%d",
> 			 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
> 			 mpext->checksum, mpext->dsn64);
> -	} /* TODO: else fallback */
> +	}
> +	/* TODO: else fallback; allocation can fail, but we can't easily retire
> +	 * skbs from the write_queue, as we need to roll-back TCP status
> +	 */
>
> +out:
> 	pfrag->offset +=3D ret;
> 	msk->write_seq +=3D ret;
> 	subflow_ctx(ssk)->rel_write_seq +=3D ret;
>
> -	tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle, size_goal);
> 	return ret;
> }
>
> static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> {
> +	int mss_now =3D 0, size_goal =3D 0, ret =3D 0;
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> 	size_t copied =3D 0;
> 	struct sock *ssk;
> -	int ret =3D 0;
> 	long timeo;
>
> 	pr_debug("msk=3D%p", msk);
> @@ -157,14 +196,18 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
> 	lock_sock(ssk);
> 	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
> 	while (msg_data_left(msg)) {
> -		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, &timeo);
> +		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, &timeo, &mss_now,
> +					 &size_goal);
> 		if (ret < 0)
> 			break;
>
> 		copied +=3D ret;
> 	}
> -	if (copied > 0)
> +	if (copied) {
> 		ret =3D copied;
> +		tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle,
> +			 size_goal);
> +	}
>
> 	release_sock(ssk);
> 	release_sock(sk);
> -- =

> 2.20.1

--
Mat Martineau
Intel

--===============5750458740144619590==--
