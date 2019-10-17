Content-Type: multipart/mixed; boundary="===============1776661403537363203=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 2/2] mptcp: Add IPv6 support
Date: Thu, 17 Oct 2019 12:36:50 +0200
Message-ID: <cb02668f5df930fa78cd276d7a31f862a361e1e5.camel@redhat.com>
In-Reply-To: 20191017000206.10559-3-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2207

--===============1776661403537363203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2019-10-16 at 17:02 -0700, Peter Krystad wrote:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4fdcbb0f4285..bc38527209c9 100644
> @@ -1182,6 +1214,53 @@ static int mptcp_getname(struct socket *sock, stru=
ct sockaddr *uaddr,
>  	return ret;
>  }
>  =

> +#if IS_ENABLED(CONFIG_IPV6)
> +static int mptcp_v6_getname(struct socket *sock, struct sockaddr *uaddr,
> +			    int peer)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> +	struct socket *ssock;
> +	struct sock *ssk;
> +	int ret;
> +
> +	if (sock->sk->sk_prot =3D=3D &tcpv6_prot) {
> +		/* we are being invoked from __sys_accept4, after
> +		 * mptcp_accept() has just accepted a non-mp-capable
> +		 * flow: sk is a tcp_sk, not an mptcp one.
> +		 *
> +		 * Hand the socket over to tcp so all further socket ops
> +		 * bypass mptcp.
> +		 */
> +		sock->ops =3D &inet_stream_ops;

Should we have &inet6_stream_ops  here ^^^^^^ ???
Possibly the comments should be adjusted as well.

[...]

> @@ -1311,3 +1409,33 @@ void mptcp_proto_init(void)
>  =

>  	inet_register_protosw(&mptcp_protosw);
>  }
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +static struct proto_ops mptcp_v6_stream_ops;
> +
> +static struct inet_protosw mptcp_v6_protosw =3D {
> +	.type		=3D SOCK_STREAM,
> +	.protocol	=3D IPPROTO_MPTCP,
> +	.prot		=3D &mptcp_prot,
> +	.ops		=3D &mptcp_v6_stream_ops,
> +	.flags		=3D INET_PROTOSW_ICSK,
> +};
> +
> +int mptcp_proto_v6_init(void)
> +{
> +	int err;
> +
> +	mptcp_v6_stream_ops =3D inet6_stream_ops;
> +	mptcp_v6_stream_ops.bind =3D mptcp_v6_bind;
> +	mptcp_v6_stream_ops.connect =3D mptcp_v6_stream_connect;
> +	mptcp_v6_stream_ops.poll =3D mptcp_poll;
> +	mptcp_v6_stream_ops.accept =3D mptcp_stream_accept;
> +	mptcp_v6_stream_ops.getname =3D mptcp_v6_getname;
> +	mptcp_v6_stream_ops.listen =3D mptcp_v6_listen;
> +	mptcp_v6_stream_ops.shutdown =3D mptcp_shutdown;
> +
> +	err =3D inet6_register_protosw(&mptcp_v6_protosw);

For IPv4 we currently do panic, if we can't register the protosw
struct, possibly we could explicitly handle the failure even there?

Overall this looks nice and clean! What about moving the ipv6
protocol.c support into a separate file, to reduce the preprocessor
conditionals?

[...]

> @@ -226,6 +290,26 @@ static int subflow_conn_request(struct sock *sk, str=
uct sk_buff *skb)
>  	return 0;
>  }
>  =

> +static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> +
> +	pr_debug("subflow=3D%p", subflow);

Just to avoid duplicate debug messages for IPv4 packets, what about
moving this one below the next if?

[...]

> @@ -309,7 +393,70 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
>  	return NULL;
>  }
>  =

> -static struct inet_connection_sock_af_ops subflow_specific;
> +#if IS_ENABLED(CONFIG_IPV6)
> +static struct sock *subflow_v6_syn_recv_sock(const struct sock *sk,
> +					     struct sk_buff *skb,
> +					     struct request_sock *req,
> +					     struct dst_entry *dst,
> +					     struct request_sock *req_unhash,
> +					     bool *own_req)
> +{
> +	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk);
> +	struct mptcp_subflow_request_sock *subflow_req;
> +	struct tcp_options_received opt_rx;
> +	struct sock *child;
> +
> +	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener-=
>conn);
> +
> +	/* if the sk is MP_CAPABLE, we already received the client key */
> +	subflow_req =3D mptcp_subflow_rsk(req);
> +	if (!subflow_req->mp_capable && subflow_req->mp_join) {
> +		opt_rx.mptcp.mp_join =3D 0;
> +		mptcp_get_options(skb, &opt_rx);
> +		if (!opt_rx.mptcp.mp_join ||
> +		    !subflow_hmac_valid(req, &opt_rx))
> +			return NULL;
> +	}
> +
> +	child =3D tcp_v6_syn_recv_sock(sk, skb, req, dst, req_unhash, own_req);
> +
> +	if (child && *own_req) {
> +		struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(child);
> +
> +		if (!ctx)
> +			goto close_child;
> +
> +		if (ctx->mp_capable) {
> +			if (mptcp_token_new_accept(ctx->token))
> +				goto close_child;
> +		} else if (ctx->mp_join) {
> +			struct mptcp_sock *owner;
> +
> +			owner =3D mptcp_token_get_sock(ctx->token);
> +			if (!owner)
> +				goto close_child;
> +
> +			ctx->conn =3D (struct sock *)owner;
> +			mptcp_finish_join(child);
> +		}
> +	}
> +
> +	return child;
> +
> +close_child:
> +	pr_debug("closing child socket");
> +	inet_sk_set_state(child, TCP_CLOSE);
> +	sock_set_flag(child, SOCK_DEAD);
> +	inet_csk_destroy_sock(child);
> +	return NULL;
> +}

As this looks quite alike the ipv4 counter part, except for the
tcp_v4_syn_recv_sock() call, replaced here by tcp_v6_syn_recv_sock(),
what about using a function pointer and the same overall code? =


If the additional indirect call overhead is a concern, we can leverage
the indirect call infrastructure ;) [shameless self-promotion;)]

How about moving even the subflow ipv6 code to a separate, ipv6
specific file ? (possibly the same used for ipv6 protocol.c code)

Overall this looks much more clean and self-contained than expected!

Thank you,

Paolo

--===============1776661403537363203==--
