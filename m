Content-Type: multipart/mixed; boundary="===============3903679688115175126=="
MIME-Version: 1.0
From: Krystad, Peter <peter.krystad at intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 7/9] Restructure syncookie code to use pointers
Date: Fri, 30 Mar 2018 17:55:09 +0000
Message-ID: <1522432507.16359.86.camel@intel.com>
In-Reply-To: 1519343401-19027-8-git-send-email-rao.shoaib@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 483

--===============3903679688115175126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


inline ....

On Thu, 2018-02-22 at 15:49 -0800, rao.shoaib(a)oracle.com wrote:
> From: Rao Shoaib <rao.shoaib(a)oracle.com>
> =

> Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
> ---
>  net/ipv4/syncookies.c | 109 ++++++++++++++++++++++++++++++++++++++------=
------
>  net/ipv4/tcp.c        |   1 +
>  net/ipv6/syncookies.c |  40 ++----------------
>  3 files changed, 88 insertions(+), 62 deletions(-)
> =

> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index fda37f2..e0f511e 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -276,6 +276,87 @@ bool cookie_ecn_ok(const struct tcp_options_received=
 *tcp_opt,
>  }
>  EXPORT_SYMBOL(cookie_ecn_ok);
>  =

> +void tcp_cookie_req_init(struct sock *sk, struct sk_buff *skb,
> +			 struct request_sock *req,
> +			 struct tcp_options_received *tcp_opts, __u32 cookie,
> +			 int mss)
> +{
> +	const struct tcphdr *th =3D tcp_hdr(skb);
> +	struct inet_request_sock *ireq;
> +	struct tcp_request_sock *treq;
> +
> +	ireq			=3D inet_rsk(req);
> +	treq			=3D tcp_rsk(req);
> +
> +	req->mss		=3D mss;
> +	req->num_retrans	=3D 0;
> +	req->ts_recent		=3D tcp_opts->saw_tstamp ?
> +				  tcp_opts->rcv_tsval : 0;
> +
> +	treq->tfo_listener	=3D false;
> +	treq->rcv_isn		=3D ntohl(th->seq) - 1;
> +	treq->snt_isn		=3D cookie;
> +	treq->ts_off		=3D 0;
> +	treq->txhash		=3D net_tx_rndhash();
> +	treq->snt_synack	=3D 0;
> +
> +	ireq->ir_num		=3D ntohs(th->dest);
> +	ireq->ir_rmt_port	=3D th->source;
> +	ireq->ir_iif		=3D inet_request_bound_dev_if(sk, skb);
> +
> +	ireq->ir_mark		=3D inet_request_mark(sk, skb);
> +	ireq->snd_wscale	=3D tcp_opts->snd_wscale;
> +	ireq->sack_ok		=3D tcp_opts->sack_ok;
> +	ireq->wscale_ok		=3D tcp_opts->wscale_ok;
> +	ireq->tstamp_ok		=3D tcp_opts->saw_tstamp;
> +
> +	if (sk->sk_family =3D=3D AF_INET) {
> +		sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
> +		sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
> +	}
> +#if IS_ENABLED(CONFIG_IPV6)
> +	else if (sk->sk_family =3D=3D AF_INET6) {
> +		struct ipv6_pinfo *np =3D inet6_sk(sk);
> +
> +		ireq->ir_v6_rmt_addr =3D ipv6_hdr(skb)->saddr;
> +		ireq->ir_v6_loc_addr =3D ipv6_hdr(skb)->daddr;
> +		if (ipv6_opt_accepted(sk, skb,
> +				      &TCP_SKB_CB(skb)->header.h6) ||
> +				      np->rxopt.bits.rxinfo ||
> +				      np->rxopt.bits.rxoinfo ||
> +				      np->rxopt.bits.rxhlim ||
> +				      np->rxopt.bits.rxohlim) {
> +			refcount_inc(&skb->users);
> +			ireq->pktopts =3D skb;
> +		}
> +		/* So that link locals have meaning */
> +		if (!sk->sk_bound_dev_if &&
> +		    ipv6_addr_type(&ireq->ir_v6_rmt_addr) &
> +		    IPV6_ADDR_LINKLOCAL)
> +			ireq->ir_iif =3D tcp_v6_iif(skb);
> +	}
> +#endif
> +}
> +
> +struct request_sock *tcp_cookie_req_alloc(struct sock *sk,
> +					  struct sk_buff *skb,
> +					  struct tcp_options_received *tcp_opts,
> +					  __u32 cookie, int mss)
> +{
> +	struct request_sock *req =3D NULL;
> +
> +	if (sk->sk_family =3D=3D AF_INET)
> +		req =3D inet_reqsk_alloc(&tcp_request_sock_ops, sk, false);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	else
> +		req =3D inet_reqsk_alloc(&tcp_request_sock_ops, sk, false);

The first parameter should be &tcp6_request_sock_ops. Note missing '6'.
See original usage near bottom of this spatch.

> +#endif
> +	if (req)
> +		tcp_cookie_req_init(sk, skb, req, tcp_opts, cookie, mss);
> +	return req;
> +}
> +EXPORT_SYMBOL(tcp_cookie_req_alloc);
> +

All the above is a combination of alloc and init of the request_sock
for both v4 and v6 into a single routine (which will then be replaced
with a single mptcp version as appropriate). A different approach would
be to add another field to struct request_sock_ops that is initialized
to v4 and v6-specific routines. This change would be a standalone TCP
change, unrelated to MPTCP. Then these fields could be replaced with
MPTCP-specific v4 and v6 versions for MPTCP. This would 1) eliminate
one more function pointer member of operational_ops, 2) reduce size of
MPTCP change to TCP, 3) Better maintain existing v4/v6 separation.

>  /* On input, sk is a listener.
>   * Output is listener if incoming packet would not create a child
>   *           NULL if memory could not be allocated.
> @@ -285,7 +366,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
>  	struct ip_options *opt =3D &TCP_SKB_CB(skb)->header.h4.opt;
>  	struct tcp_options_received tcp_opt;
>  	struct inet_request_sock *ireq;
> -	struct tcp_request_sock *treq;
>  	struct tcp_sock *tp =3D tcp_sk(sk);
>  	const struct tcphdr *th =3D tcp_hdr(skb);
>  	__u32 cookie =3D ntohl(th->ack_seq) - 1;
> @@ -326,31 +406,12 @@ struct sock *cookie_v4_check(struct sock *sk, struc=
t sk_buff *skb)
>  		goto out;
>  =

>  	ret =3D NULL;
> -	req =3D inet_reqsk_alloc(&tcp_request_sock_ops, sk, false); /* for safe=
ty */
> +
> +	req =3D tp->op_ops->cookie_req_alloc(sk, skb, &tcp_opt, cookie, mss);
>  	if (!req)
>  		goto out;
>  =

>  	ireq =3D inet_rsk(req);
> -	treq =3D tcp_rsk(req);
> -	treq->rcv_isn		=3D ntohl(th->seq) - 1;
> -	treq->snt_isn		=3D cookie;
> -	treq->ts_off		=3D 0;
> -	treq->txhash		=3D net_tx_rndhash();
> -	req->mss		=3D mss;
> -	ireq->ir_num		=3D ntohs(th->dest);
> -	ireq->ir_rmt_port	=3D th->source;
> -	sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
> -	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
> -	ireq->ir_mark		=3D inet_request_mark(sk, skb);
> -	ireq->snd_wscale	=3D tcp_opt.snd_wscale;
> -	ireq->sack_ok		=3D tcp_opt.sack_ok;
> -	ireq->wscale_ok		=3D tcp_opt.wscale_ok;
> -	ireq->tstamp_ok		=3D tcp_opt.saw_tstamp;
> -	req->ts_recent		=3D tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
> -	treq->snt_synack	=3D 0;
> -	treq->tfo_listener	=3D false;
> -
> -	ireq->ir_iif =3D inet_request_bound_dev_if(sk, skb);
>  =

>  	/* We throwed the options of the initial SYN away, so we hope
>  	 * the ACK carries the same options again (see RFC1122 4.2.3.8)
> @@ -362,8 +423,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
>  		goto out;
>  	}
>  =

> -	req->num_retrans =3D 0;
> -
>  	/*
>  	 * We need to lookup the route here to get at the correct
>  	 * window size. We should better make sure that the window size
> @@ -393,7 +452,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
>  	ireq->rcv_wscale  =3D rcv_wscale;
>  	ireq->ecn_ok =3D cookie_ecn_ok(&tcp_opt, sock_net(sk), &rt->dst);
>  =

> -	ret =3D tcp_get_cookie_sock(sk, skb, req, &rt->dst, tsoff);
> +	ret =3D tp->op_ops->get_cookie_sock(sk, skb, req, &rt->dst, tsoff);
>  	/* ip_queue_xmit() depends on our flow being setup
>  	 * Normal sockets get it right from inet_csk_route_child_sock()
>  	 */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 136be43..ea89a41 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -444,6 +444,7 @@ static const struct tcp_operational_ops __tcp_default=
_op_ops =3D {
>  	.retrans_try_collapse		=3D tcp_retrans_try_collapse,
>  	.fastopen_synack		=3D tcp_rcv_fastopen_synack,
>  	.sendpage_locked		=3D tcp_sendpage_locked,
> +	.cookie_req_alloc		=3D tcp_cookie_req_alloc,
>  	.get_cookie_sock		=3D tcp_get_cookie_sock,
>  };
>  =

> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index e7a3a6b..916792c 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -134,7 +134,6 @@ struct sock *cookie_v6_check(struct sock *sk, struct =
sk_buff *skb)
>  {
>  	struct tcp_options_received tcp_opt;
>  	struct inet_request_sock *ireq;
> -	struct tcp_request_sock *treq;
>  	struct ipv6_pinfo *np =3D inet6_sk(sk);
>  	struct tcp_sock *tp =3D tcp_sk(sk);
>  	const struct tcphdr *th =3D tcp_hdr(skb);
> @@ -175,49 +174,16 @@ struct sock *cookie_v6_check(struct sock *sk, struc=
t sk_buff *skb)
>  		goto out;
>  =

>  	ret =3D NULL;
> -	req =3D inet_reqsk_alloc(&tcp6_request_sock_ops, sk, false);

Here is the use of tcp6_request_sock_ops.

Peter.

> =

> +
> +	req =3D tp->op_ops->cookie_req_alloc(sk, skb, &tcp_opt, cookie, mss);
 	if (!req)
>  		goto out;
>  =

>  	ireq =3D inet_rsk(req);
> -	treq =3D tcp_rsk(req);
> -	treq->tfo_listener =3D false;
>  =

>  	if (security_inet_conn_request(sk, skb, req))
>  		goto out_free;
>  =

> -	req->mss =3D mss;
> -	ireq->ir_rmt_port =3D th->source;
> -	ireq->ir_num =3D ntohs(th->dest);
> -	ireq->ir_v6_rmt_addr =3D ipv6_hdr(skb)->saddr;
> -	ireq->ir_v6_loc_addr =3D ipv6_hdr(skb)->daddr;
> -	if (ipv6_opt_accepted(sk, skb, &TCP_SKB_CB(skb)->header.h6) ||
> -	    np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
> -	    np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim) {
> -		refcount_inc(&skb->users);
> -		ireq->pktopts =3D skb;
> -	}
> -
> -	ireq->ir_iif =3D inet_request_bound_dev_if(sk, skb);
> -	/* So that link locals have meaning */
> -	if (!sk->sk_bound_dev_if &&
> -	    ipv6_addr_type(&ireq->ir_v6_rmt_addr) & IPV6_ADDR_LINKLOCAL)
> -		ireq->ir_iif =3D tcp_v6_iif(skb);
> -
> -	ireq->ir_mark =3D inet_request_mark(sk, skb);
> -
> -	req->num_retrans =3D 0;
> -	ireq->snd_wscale	=3D tcp_opt.snd_wscale;
> -	ireq->sack_ok		=3D tcp_opt.sack_ok;
> -	ireq->wscale_ok		=3D tcp_opt.wscale_ok;
> -	ireq->tstamp_ok		=3D tcp_opt.saw_tstamp;
> -	req->ts_recent		=3D tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
> -	treq->snt_synack	=3D 0;
> -	treq->rcv_isn =3D ntohl(th->seq) - 1;
> -	treq->snt_isn =3D cookie;
> -	treq->ts_off =3D 0;
> -	treq->txhash =3D net_tx_rndhash();
> -
>  	/*
>  	 * We need to lookup the dst_entry to get the correct window size.
>  	 * This is taken from tcp_v6_syn_recv_sock.  Somebody please enlighten
> @@ -252,7 +218,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct =
sk_buff *skb)
>  	ireq->rcv_wscale =3D rcv_wscale;
>  	ireq->ecn_ok =3D cookie_ecn_ok(&tcp_opt, sock_net(sk), dst);
>  =

> -	ret =3D tcp_get_cookie_sock(sk, skb, req, dst, tsoff);
> +	ret =3D tp->op_ops->get_cookie_sock(sk, skb, req, dst, tsoff);
>  out:
>  	return ret;
>  out_free:
--===============3903679688115175126==--
