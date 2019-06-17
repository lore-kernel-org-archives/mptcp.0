Content-Type: multipart/mixed; boundary="===============8257540392408063873=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v2 3/3] mptcp: Add handling of incoming MP_JOIN
 requests
Date: Sun, 16 Jun 2019 21:06:57 -0700
Message-ID: <e72558b9a2c863dd73b56c3406a522e8b0e596f5.camel@linux.intel.com>
In-Reply-To: 5695b306e6973d27de3fe69400c4891abe70271a.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1407

--===============8257540392408063873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-13 at 15:29 +0200, Paolo Abeni wrote:
> Hi again,
> =

> [...]
> On Wed, 2019-06-12 at 16:21 -0700, Peter Krystad wrote:
> > @@ -419,11 +448,23 @@ bool mptcp_synack_options(const struct request_so=
ck *req, unsigned int *size,
> >  		opts->sndr_key =3D subflow_req->local_key;
> >  		opts->rcvr_key =3D subflow_req->remote_key;
> >  		*size =3D TCPOLEN_MPTCP_MPC_SYNACK;
> > -		pr_debug("subflow_req=3D%p, local_key=3D%llu, remote_key=3D%llu",
> > +		pr_debug("req=3D%p, local_key=3D%llu, remote_key=3D%llu",
> >  			 subflow_req, subflow_req->local_key,
> >  			 subflow_req->remote_key);
> >  		return true;
> >  	}
> > +	if (subflow_req->mp_join) {
> =

> Here I'm a bit lost... I think we should always enter the previos block
> statement. The current relevant code will become:
> =

>      if (subflow_req->mp_capable) {
>                 opts->suboptions =3D OPTION_MPTCP_MPC_SYNACK;
>                 opts->sndr_key =3D subflow_req->local_key;
>                 opts->rcvr_key =3D subflow_req->remote_key;
>                 *size =3D TCPOLEN_MPTCP_MPC_SYNACK;
>                 pr_debug("local_key=3D%llu", subflow_req->local_key);
>                 pr_debug("remote_key=3D%llu", subflow_req->remote_key);
>                 return true;
>      }
>      if (subflow_req->mp_join) {
> =

> and mp_capable should be set, so we should never enter the 'if
> (subflow_req->mp_join) {' branch, right? What I'm missing here?!?

Well, the code is missing an 'else' that would make things more clear. These
meaning of these fields in the request_sock are 'saw an mp_capable option in
the SYN' or 'saw an mp_join option in the SYN'. Only one of them will be tr=
ue
at a time and an else can be used. I will add the else.

> =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index a1a42ed7810a..6468f0d8ef04 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -777,6 +777,27 @@ void mptcp_finish_connect(struct sock *sk, int mp_=
capable)
> >  	inet_sk_state_store(sk, TCP_ESTABLISHED);
> >  }
> >  =

> > +void mptcp_finish_join(struct sock *conn, struct sock *sk)
> > +{
> > +	struct mptcp_sock *msk =3D mptcp_sk(conn);
> > +	struct subflow_context *subflow =3D subflow_ctx(sk);
> =

> Very minor thing: we should apply the reverse X-mass tree order to
> variable declaration.

Will fix.

> =

> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index a31f58990c86..9a475f83d446 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -69,8 +69,21 @@ static void subflow_v4_init_req(struct request_sock =
*req,
> >  		token_new_request(req, skb);
> >  		pr_debug("syn seq=3D%u", TCP_SKB_CB(skb)->seq);
> >  		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
> > +	} else if (rx_opt.mptcp.mp_join && listener->request_mptcp) {
> =

> Here I'm lost again, aren't we always going to enter only the previous
> block statement? I expect to have MP_CAPABLE and MP_JOIN option in the
> same packet?!?

No, MP_CAPABLE and MP_JOIN should never be in the same packet. MP_JOIN carr=
ies
the token that identifies the MPTCP connection that was established with a
MP_CAPABLE exchange. I will add a check here to verify that the packet does
not contain both.

> > +		subflow_req->mp_join =3D 1;
> > +		subflow_req->backup =3D rx_opt.mptcp.backup;
> > +		subflow_req->remote_id =3D rx_opt.mptcp.join_id;
> > +		subflow_req->token =3D rx_opt.mptcp.token;
> > +		subflow_req->remote_nonce =3D rx_opt.mptcp.nonce;
> > +		pr_debug("token=3D%u, remote_nonce=3D%u", subflow_req->token,
> > +			 subflow_req->remote_nonce);
> > +		if (token_join_request(req, skb)) {
> > +			subflow_req->mp_join =3D 0;
> > +			// @@ need to trigger RST
> > +		}
> >  	} else {
> >  		subflow_req->mp_capable =3D 0;
> > +		subflow_req->mp_join =3D 0;
> >  	}
> >  }
> >  =

> > @@ -135,6 +148,13 @@ static struct sock *subflow_syn_recv_sock(const st=
ruct sock *sk,
> >  		    (subflow_req->local_key !=3D opt_rx.mptcp.rcvr_key) ||
> >  		    (subflow_req->remote_key !=3D opt_rx.mptcp.sndr_key))
> >  			return NULL;
> > +	} else if (subflow_req->mp_join) {
> =

> Here similar situation... shouldn't we have a single invocation to
> mptcp_get_options()?!?

No. This is the processing for the final ACK of the 3-way handshake, we are
checking that if we received MP_JOIN in the initial SYN then we also get one
in the final ACK, and that the HMAC checks out. Likewise the previous clause
validates that an MP_CAPABLE was received in the final ACK and the keys are
correct.

> =

> > +		opt_rx.mptcp.mp_join =3D 0;
> > +		mptcp_get_options(skb, &opt_rx);
> > +		if ((!opt_rx.mptcp.mp_join) ||
> > +		    (token_join_valid(req, &opt_rx))) {
> > +			return NULL;
> > +		}
> >  	}
> >  =

> >  	child =3D tcp_v4_syn_recv_sock(sk, skb, req, dst, req_unhash, own_req=
);
> > @@ -142,18 +162,28 @@ static struct sock *subflow_syn_recv_sock(const s=
truct sock *sk,
> >  	if (child && *own_req) {
> >  		struct subflow_context *ctx =3D subflow_ctx(child);
> >  =

> > -		if (!ctx) {
> > -			pr_debug("Closing child socket");
> > -			inet_sk_set_state(child, TCP_CLOSE);
> > -			sock_set_flag(child, SOCK_DEAD);
> > -			inet_csk_destroy_sock(child);
> > -			child =3D NULL;
> > -		} else if (ctx->mp_capable) {
> > +		if (!ctx)
> > +			goto close_child;
> > +
> > +		if (ctx->mp_capable) {
> >  			token_new_accept(child);
> > +		} else if (ctx->mp_join) {
> > +			if (token_new_join(child)) {
> > +				goto close_child;
> > +			} else {
> > +				mptcp_finish_join(ctx->conn, child);
> > +			}
> >  		}
> >  	}
> >  =

> >  	return child;
> > +
> > +close_child:
> > +	pr_debug("closing child socket");
> > +	inet_sk_set_state(child, TCP_CLOSE);
> > +	sock_set_flag(child, SOCK_DEAD);
> > +	inet_csk_destroy_sock(child);
> > +	return NULL;
> >  }
> >  =

> >  static struct inet_connection_sock_af_ops subflow_specific;
> > @@ -223,6 +253,8 @@ static void subflow_ulp_release(struct sock *sk)
> >  =

> >  	pr_debug("subflow=3D%p", ctx);
> >  =

> > +	token_release(ctx->token);
> > +
> >  	kfree(ctx);
> >  }
> >  =

> > @@ -256,6 +288,14 @@ static void subflow_ulp_clone(const struct request=
_sock *req,
> >  		new_ctx->ssn_offset =3D subflow_req->ssn_offset;
> >  		new_ctx->idsn =3D subflow_req->idsn;
> >  		pr_debug("token=3D%u", new_ctx->token);
> > +	} else if (subflow_req->mp_join) {
> =

> Possibly 'else' is not required here ?!? Something alike:

No, it is fine, previous reasons apply.

Peter.


> =

>  		pr_debug("token=3D%u", new_ctx->token);
> +	}
> +	if (subflow_req->mp_join) {
> =

> =

> > +		new_ctx->mp_join =3D 1;
> > +		new_ctx->fourth_ack =3D 1;
> > +		new_ctx->backup =3D subflow_req->backup;
> > +		new_ctx->local_id =3D subflow_req->local_id;
> > +		new_ctx->token =3D subflow_req->token;
> > +		new_ctx->thmac =3D subflow_req->thmac;
> > +		pr_debug("token=3D%u", new_ctx->token);
> >  	}
> >  }
> =

> Cheers,
> =

> Paolo
> =



--===============8257540392408063873==--
