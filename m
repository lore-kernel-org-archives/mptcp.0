Content-Type: multipart/mixed; boundary="===============7464556165155196981=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH 4/4] mptcp: allow collapsing consecutive
 sendpages on the same substream
Date: Fri, 05 Apr 2019 17:34:48 -0700
Message-ID: <alpine.OSX.2.21.1904051701080.58453@aakhemka-mobl1.amr.corp.intel.com>
In-Reply-To: 308ba2a3dfda306bc5155bb623828abe4151f9ef.1554473233.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1053

--===============7464556165155196981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Paolo,

On Fri, 5 Apr 2019, Paolo Abeni wrote:

> If the current sendmsg() lands on the same subflow we used last, we
> can try to collapse the data.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> include/net/mptcp.h  |  1 +
> net/mptcp/protocol.c | 57 +++++++++++++++++++++++++++++++-------------
> 2 files changed, 41 insertions(+), 17 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 0c0839d9ab38..788d4d5a084c 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -50,6 +50,7 @@ struct mptcp_sock {
> 	spinlock_t	conn_list_lock;
> 	struct hlist_head conn_list;
> 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
> +	struct sock	*last;
> };
>
> #define mptcp_for_each_subflow(__msk, __subflow)			\
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2fbfe3e30630..5df2283de488 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -47,11 +47,19 @@ static struct sock *mptcp_subflow_get_ref(const struc=
t mptcp_sock *msk)
> 	return NULL;
> }
>
> +static inline bool mptcp_skb_can_collapse_to(const struct mptcp_sock *ms=
k,
> +					     const struct sock *ssk,
> +					     const struct sk_buff *skb)
> +{
> +	return tcp_skb_can_collapse_to(skb) && (msk->last =3D=3D ssk);

Even if the last send was on a particular subflow, that doesn't guarantee =

the next send can be collapsed on that subflow. There are other cases like =

MPTCP-level resends or sending duplicate data on different subflows.

I think it would have to make sure the MPTCP-level sequence numbers are =

contiguous before collapsing.

> +}
> +
> static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> -			      struct msghdr *msg)
> +			      struct msghdr *msg, int *pmss_now, int *ps_goal)
> {
> +	int mss_now, avail_size, size_goal, poffset, ret;
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	int mss_now, size_goal, poffset, ret;
> +	bool collapsed, can_collapse =3D false;
> 	struct mptcp_ext *mpext =3D NULL;
> 	struct page_frag *pfrag;
> 	struct sk_buff *skb;
> @@ -78,25 +86,35 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
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
> +		can_collapse =3D mptcp_skb_can_collapse_to(msk, ssk, skb);
> +		if (!can_collapse)
> +			TCP_SKB_CB(skb)->eor =3D 1;
> +		else if (size_goal - skb->len > 0)
> +			avail_size =3D size_goal + size_goal - skb->len;

Can you comment more on the calculation for avail_size here - is this how =

you "allocate at most a new skb" as you mention below?

> +	}
>
> -	mss_now =3D tcp_send_mss(ssk, &size_goal, msg->msg_flags);
> -	psize =3D min_t(int, size_goal, psize);
> +	/* be sure that we are going to allocate at most a new skb, and
> +	 * tell the tcp stack to delay the push so that we can safely
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
> +	if (collapsed)
> +		goto out;

Without the previous commit (moving mpext->data_len assignment), could you =

instead update the existing mpext in the "collapsed =3D=3D true" case?


Mat


>
> 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
>
> @@ -109,24 +127,25 @@ static int mptcp_sendmsg_frag(struct sock *sk, stru=
ct sock *ssk,
> 		mpext->dsn64 =3D 1;
>
> 		pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u checksum=3D%u,=
 dsn64=3D%d",
> -			 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
> +			 mpext->data_seq, mpext->subflow_seq, skb->len,
> 			 mpext->checksum, mpext->dsn64);
> 	} /* TODO: else fallback */
>
> +out:
> 	pfrag->offset +=3D ret;
> +	msk->last =3D ssk;
> 	msk->write_seq +=3D ret;
> 	subflow_ctx(ssk)->rel_write_seq +=3D ret;
>
> -	tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle, size_goal);
> 	return ret;
> }
>
> static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	int mss_now =3D 0, size_goal =3D 0, ret =3D 0;
> 	size_t copied =3D 0;
> 	struct sock *ssk;
> -	int ret =3D 0;
>
> 	pr_debug("msk=3D%p", msk);
> 	if (msk->subflow) {
> @@ -153,15 +172,19 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
>
> 	lock_sock(sk);
> 	lock_sock(ssk);
> +
> 	while (msg_data_left(msg)) {
> -		ret =3D mptcp_sendmsg_frag(sk, ssk, msg);
> +		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, &mss_now, &size_goal);
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
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============7464556165155196981==--
