Content-Type: multipart/mixed; boundary="===============5539593520641868201=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v1 4/4] mptcp: handle tcp fallback when
 using syn cookies
Date: Tue, 28 Jan 2020 10:17:53 -0800
Message-ID: <20200128181753.GE19649@MacBook-Pro-64.local>
In-Reply-To: 20200128150125.26625-5-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3545

--===============5539593520641868201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I just tested this one as well. Works fine now!


Christoph

On 28/01/20 - 16:01:24, Florian Westphal wrote:
> We can't deal with syncookie mode yet, the syncookie rx path will create
> tcp rsk instead of mptcp rsk, i.e. we get OOB access because we treat
> tcp rsk as mptcp rsk:
> =

> TCP: request_sock_subflow: Possible SYN flooding on port 20002. Sending c=
ookies.  Check SNMP counters.
> BUG: KASAN: slab-out-of-bounds in subflow_syn_recv_sock+0x451/0x4d0 net/m=
ptcp/subflow.c:191
> Read of size 1 at addr ffff8881167bc148 by task syz-executor099/2120
>  subflow_syn_recv_sock+0x451/0x4d0 net/mptcp/subflow.c:191
>  tcp_get_cookie_sock+0xcf/0x520 net/ipv4/syncookies.c:209
>  cookie_v6_check+0x15a5/0x1e90 net/ipv6/syncookies.c:252
>  tcp_v6_cookie_check net/ipv6/tcp_ipv6.c:1123 [inline]
>  [..]
> =

> Bug can be reproduced via "sysctl net.ipv4.tcp_syncookies=3D2".
> =

> Note that MPTCP should work with syncookies (4th ack would carry needed
> state), but it appears better to sort that out in -next so do tcp
> fallback for now.
> =

> I decided to remove the ifdef on tcp_rsk "is_mptcp" member because
> if (IS_ENABLED()) is easier to read than "#ifdef IS_ENABLED()/#endif" pai=
r.
> =

> Reported-by: Christoph Paasch <cpaasch(a)apple.com>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  patch is new in this set.
> =

>  include/linux/tcp.h   | 2 --
>  net/ipv4/syncookies.c | 4 ++++
>  net/ipv4/tcp_input.c  | 3 +++
>  net/ipv6/syncookies.c | 3 +++
>  net/mptcp/subflow.c   | 5 ++++-
>  5 files changed, 14 insertions(+), 3 deletions(-)
> =

> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 1cf73e6f85ca..3dc964010fef 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -148,9 +148,7 @@ struct tcp_request_sock {
>  	const struct tcp_request_sock_ops *af_specific;
>  	u64				snt_synack; /* first SYNACK sent time */
>  	bool				tfo_listener;
> -#if IS_ENABLED(CONFIG_MPTCP)
>  	bool				is_mptcp;
> -#endif
>  	u32				txhash;
>  	u32				rcv_isn;
>  	u32				snt_isn;
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 345b2b0ff618..9a4f6b16c9bc 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -349,6 +349,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct=
 sk_buff *skb)
>  	req->ts_recent		=3D tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
>  	treq->snt_synack	=3D 0;
>  	treq->tfo_listener	=3D false;
> +
> +	if (IS_ENABLED(CONFIG_MPTCP))
> +		treq->is_mptcp =3D 0;
> +
>  	if (IS_ENABLED(CONFIG_SMC))
>  		ireq->smc_ok =3D 0;
>  =

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index e8b840a4767e..e325b4506e25 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6637,6 +6637,9 @@ int tcp_conn_request(struct request_sock_ops *rsk_o=
ps,
>  =

>  	af_ops->init_req(req, sk, skb);
>  =

> +	if (IS_ENABLED(CONFIG_MPTCP) && want_cookie)
> +		tcp_rsk(req)->is_mptcp =3D 0;
> +
>  	if (security_inet_conn_request(sk, skb, req))
>  		goto drop_and_free;
>  =

> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index 30915f6f31e3..13235a012388 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -178,6 +178,9 @@ struct sock *cookie_v6_check(struct sock *sk, struct =
sk_buff *skb)
>  	treq =3D tcp_rsk(req);
>  	treq->tfo_listener =3D false;
>  =

> +	if (IS_ENABLED(CONFIG_MPTCP))
> +		treq->is_mptcp =3D 0;
> +
>  	if (security_inet_conn_request(sk, skb, req))
>  		goto out_free;
>  =

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 1662e1178949..cf9bad97a12a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -186,6 +186,9 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
>  =

>  	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener-=
>conn);
>  =

> +	if (tcp_rsk(req)->is_mptcp =3D=3D 0)
> +		goto create_child;
> +
>  	/* if the sk is MP_CAPABLE, we try to fetch the client key */
>  	subflow_req =3D mptcp_subflow_rsk(req);
>  	if (subflow_req->mp_capable) {
> @@ -767,7 +770,7 @@ static void subflow_ulp_clone(const struct request_so=
ck *req,
>  	struct mptcp_subflow_context *old_ctx =3D mptcp_subflow_ctx(newsk);
>  	struct mptcp_subflow_context *new_ctx;
>  =

> -	if (!subflow_req->mp_capable) {
> +	if (!tcp_rsk(req)->is_mptcp || !subflow_req->mp_capable) {
>  		subflow_ulp_fallback(newsk, old_ctx);
>  		return;
>  	}
> -- =

> 2.24.1
>=20
--===============5539593520641868201==--
