Content-Type: multipart/mixed; boundary="===============4053491924750770870=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v2 3/3] mptcp: Add handling of incoming MP_JOIN
 requests
Date: Thu, 13 Jun 2019 15:29:57 +0200
Message-ID: <5695b306e6973d27de3fe69400c4891abe70271a.camel@redhat.com>
In-Reply-To: 20190612232127.3647-4-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1357

--===============4053491924750770870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi again,

[...]
On Wed, 2019-06-12 at 16:21 -0700, Peter Krystad wrote:
> @@ -419,11 +448,23 @@ bool mptcp_synack_options(const struct request_sock=
 *req, unsigned int *size,
>  		opts->sndr_key =3D subflow_req->local_key;
>  		opts->rcvr_key =3D subflow_req->remote_key;
>  		*size =3D TCPOLEN_MPTCP_MPC_SYNACK;
> -		pr_debug("subflow_req=3D%p, local_key=3D%llu, remote_key=3D%llu",
> +		pr_debug("req=3D%p, local_key=3D%llu, remote_key=3D%llu",
>  			 subflow_req, subflow_req->local_key,
>  			 subflow_req->remote_key);
>  		return true;
>  	}
> +	if (subflow_req->mp_join) {

Here I'm a bit lost... I think we should always enter the previos block
statement. The current relevant code will become:

     if (subflow_req->mp_capable) {
                opts->suboptions =3D OPTION_MPTCP_MPC_SYNACK;
                opts->sndr_key =3D subflow_req->local_key;
                opts->rcvr_key =3D subflow_req->remote_key;
                *size =3D TCPOLEN_MPTCP_MPC_SYNACK;
                pr_debug("local_key=3D%llu", subflow_req->local_key);
                pr_debug("remote_key=3D%llu", subflow_req->remote_key);
                return true;
     }
     if (subflow_req->mp_join) {

and mp_capable should be set, so we should never enter the 'if
(subflow_req->mp_join) {' branch, right? What I'm missing here?!?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a1a42ed7810a..6468f0d8ef04 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -777,6 +777,27 @@ void mptcp_finish_connect(struct sock *sk, int mp_ca=
pable)
>  	inet_sk_state_store(sk, TCP_ESTABLISHED);
>  }
>  =

> +void mptcp_finish_join(struct sock *conn, struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(conn);
> +	struct subflow_context *subflow =3D subflow_ctx(sk);

Very minor thing: we should apply the reverse X-mass tree order to
variable declaration.


> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index a31f58990c86..9a475f83d446 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -69,8 +69,21 @@ static void subflow_v4_init_req(struct request_sock *r=
eq,
>  		token_new_request(req, skb);
>  		pr_debug("syn seq=3D%u", TCP_SKB_CB(skb)->seq);
>  		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
> +	} else if (rx_opt.mptcp.mp_join && listener->request_mptcp) {

Here I'm lost again, aren't we always going to enter only the previous
block statement? I expect to have MP_CAPABLE and MP_JOIN option in the
same packet?!?

> +		subflow_req->mp_join =3D 1;
> +		subflow_req->backup =3D rx_opt.mptcp.backup;
> +		subflow_req->remote_id =3D rx_opt.mptcp.join_id;
> +		subflow_req->token =3D rx_opt.mptcp.token;
> +		subflow_req->remote_nonce =3D rx_opt.mptcp.nonce;
> +		pr_debug("token=3D%u, remote_nonce=3D%u", subflow_req->token,
> +			 subflow_req->remote_nonce);
> +		if (token_join_request(req, skb)) {
> +			subflow_req->mp_join =3D 0;
> +			// @@ need to trigger RST
> +		}
>  	} else {
>  		subflow_req->mp_capable =3D 0;
> +		subflow_req->mp_join =3D 0;
>  	}
>  }
>  =

> @@ -135,6 +148,13 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
>  		    (subflow_req->local_key !=3D opt_rx.mptcp.rcvr_key) ||
>  		    (subflow_req->remote_key !=3D opt_rx.mptcp.sndr_key))
>  			return NULL;
> +	} else if (subflow_req->mp_join) {

Here similar situation... shouldn't we have a single invocation to
mptcp_get_options()?!?

> +		opt_rx.mptcp.mp_join =3D 0;
> +		mptcp_get_options(skb, &opt_rx);
> +		if ((!opt_rx.mptcp.mp_join) ||
> +		    (token_join_valid(req, &opt_rx))) {
> +			return NULL;
> +		}
>  	}
>  =

>  	child =3D tcp_v4_syn_recv_sock(sk, skb, req, dst, req_unhash, own_req);
> @@ -142,18 +162,28 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
>  	if (child && *own_req) {
>  		struct subflow_context *ctx =3D subflow_ctx(child);
>  =

> -		if (!ctx) {
> -			pr_debug("Closing child socket");
> -			inet_sk_set_state(child, TCP_CLOSE);
> -			sock_set_flag(child, SOCK_DEAD);
> -			inet_csk_destroy_sock(child);
> -			child =3D NULL;
> -		} else if (ctx->mp_capable) {
> +		if (!ctx)
> +			goto close_child;
> +
> +		if (ctx->mp_capable) {
>  			token_new_accept(child);
> +		} else if (ctx->mp_join) {
> +			if (token_new_join(child)) {
> +				goto close_child;
> +			} else {
> +				mptcp_finish_join(ctx->conn, child);
> +			}
>  		}
>  	}
>  =

>  	return child;
> +
> +close_child:
> +	pr_debug("closing child socket");
> +	inet_sk_set_state(child, TCP_CLOSE);
> +	sock_set_flag(child, SOCK_DEAD);
> +	inet_csk_destroy_sock(child);
> +	return NULL;
>  }
>  =

>  static struct inet_connection_sock_af_ops subflow_specific;
> @@ -223,6 +253,8 @@ static void subflow_ulp_release(struct sock *sk)
>  =

>  	pr_debug("subflow=3D%p", ctx);
>  =

> +	token_release(ctx->token);
> +
>  	kfree(ctx);
>  }
>  =

> @@ -256,6 +288,14 @@ static void subflow_ulp_clone(const struct request_s=
ock *req,
>  		new_ctx->ssn_offset =3D subflow_req->ssn_offset;
>  		new_ctx->idsn =3D subflow_req->idsn;
>  		pr_debug("token=3D%u", new_ctx->token);
> +	} else if (subflow_req->mp_join) {

Possibly 'else' is not required here ?!? Something alike:

 		pr_debug("token=3D%u", new_ctx->token);
+	}
+	if (subflow_req->mp_join) {


> +		new_ctx->mp_join =3D 1;
> +		new_ctx->fourth_ack =3D 1;
> +		new_ctx->backup =3D subflow_req->backup;
> +		new_ctx->local_id =3D subflow_req->local_id;
> +		new_ctx->token =3D subflow_req->token;
> +		new_ctx->thmac =3D subflow_req->thmac;
> +		pr_debug("token=3D%u", new_ctx->token);
>  	}
>  }

Cheers,

Paolo


--===============4053491924750770870==--
