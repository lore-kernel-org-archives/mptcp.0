Content-Type: multipart/mixed; boundary="===============6741336135995580115=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 5/7] Squash-to: "mptcp: Implement MPTCP receive
 path"
Date: Thu, 09 Jan 2020 09:25:11 +0100
Message-ID: <fbddaded229a44d7c06ac4843b4d53abdc205e78.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.2001081628300.27921@fepiepan-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3304

--===============6741336135995580115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-01-08 at 16:42 -0800, Mat Martineau wrote:
> On Wed, 8 Jan 2020, Paolo Abeni wrote:
> =

> > deal with fallback: we must reset sk callback to the TCP one.
> > Use the cached ptr in the old ctx.
> > =

> > RFC -> v1:
> > - since mptcp_incoming_options() callers check for is_mptcp and
> >   the latter is always cleared on fallback, we can drop any additional
> >   check in mptcp_incoming_options()
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > net/mptcp/options.c  |  4 ----
> > net/mptcp/protocol.h | 15 ++++++++++++++-
> > net/mptcp/subflow.c  | 18 ++++++++++++------
> > 3 files changed, 26 insertions(+), 11 deletions(-)
> > =

> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 015162f15576..5845c9a41ebb 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -416,13 +416,9 @@ bool mptcp_synack_options(const struct request_soc=
k *req, unsigned int *size,
> > void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
> > 			    struct tcp_options_received *opt_rx)
> > {
> > -	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> > 	struct mptcp_options_received *mp_opt;
> > 	struct mptcp_ext *mpext;
> > =

> > -	if (!subflow->mp_capable)
> > -		return;
> > -
> > 	mp_opt =3D &opt_rx->mptcp;
> > =

> > 	if (!mp_opt->dss)
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index e4fce9f0ad65..c6d8217e24d4 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -121,7 +121,10 @@ struct mptcp_subflow_context {
> > 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
> > 	struct	sock *conn;	    /* parent mptcp_sock */
> > 	const	struct inet_connection_sock_af_ops *icsk_af_ops;
> > -	void	(*tcp_sk_data_ready)(struct sock *sk);
> > +	void	(*tcp_data_ready)(struct sock *sk);
> > +	void	(*tcp_state_change)(struct sock *sk);
> > +	void	(*tcp_write_space)(struct sock *sk);
> =

> subflow_write_space() ends up with some direct calls to =

> sk_stream_write_space() and sk_stream_is_writeable() - would it be better =

> to use these new pointers for tcp_state_change/tcp_write_space or leave =

> the direct calls?

yep, possibly. I opeted for the simpler change, and to avoid the
indirect call. Perhaps we could use the indirect call wrappers here?

> > +
> > 	struct	rcu_head rcu;
> > };
> > =

> > @@ -159,6 +162,16 @@ bool mptcp_subflow_data_available(struct sock *sk);
> > void mptcp_subflow_init(void);
> > int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_so=
ck);
> > =

> > +static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
> > +					      struct mptcp_subflow_context *ctx)
> > +{
> > +	sk->sk_data_ready =3D ctx->tcp_data_ready;
> > +	sk->sk_state_change =3D ctx->tcp_state_change;
> > +	sk->sk_write_space =3D ctx->tcp_write_space;
> > +
> > +	inet_csk(sk)->icsk_af_ops =3D ctx->icsk_af_ops;
> =

> I'm a little paranoid about changing these back, but if ULP can change th=
e =

> pointers on an existing socket then I guess it should be safe to change =

> them again if the subflow socket is locked.
> =

> I think the subflow callbacks to have the logic to handle fallback when =

> is_mptcp is false, but it's less efficient to do so.

Yes, the subflow callbacks can handle the fallback logic, but they
require a not-NULL subflow ctx. If the ULP clone operation fails, we
will not have one. =


We could handle that, checking for NULL ctx in the subflow specific
icsk_af_ops, but I thought it simpler to just restore the TCP ones.

The TCP_ULP sockopt() already switches the socket icsk_af_ops keeping
the socket lock held, as we do here, so I think it should be safe.

Cheers,

Paolo

--===============6741336135995580115==--
