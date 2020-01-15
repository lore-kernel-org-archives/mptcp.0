Content-Type: multipart/mixed; boundary="===============5251565665307708058=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 1/7] Squash-to: "mptcp: Handle MP_CAPABLE
 options for outgoing connections"
Date: Wed, 15 Jan 2020 22:33:55 +0100
Message-ID: <e470cf4e77c5891e5a1570b945fddae8f0a4ed36.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.2001151050440.35155@ndoyal-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3365

--===============5251565665307708058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-01-15 at 10:52 -0800, Mat Martineau wrote:
> On Thu, 9 Jan 2020, Paolo Abeni wrote:
> =

> > After upstream feedback, I just noticed that we actually
> > don't clear the is_mptcp field on clone allocation failure.
> > =

> > Do that and additionally don't allocate at all the subflow if MPC hands=
hake
> > failed.
> > =

> > Note: we need to update accordingly accept on later patch
> > =

> > v1  -> v2:
> > - use sk_is_mptcp() in __mptcp_tcp_fallback() (Mat)
> > =

> > RFC -> v1:
> > - avoid assign statement inside the if statement (Florian)
> > - avoid rendundant  conn =3D NULL  (Mat)
> > - clear ulp data on fallback, or to avoid double free at close
> >   time
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > net/mptcp/protocol.c |  2 +-
> > net/mptcp/subflow.c  | 33 +++++++++++++++++++++------------
> > 2 files changed, 22 insertions(+), 13 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 8bb3ecf87ee5..9120f75659b5 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -42,7 +42,7 @@ static struct socket *__mptcp_tcp_fallback(const stru=
ct mptcp_sock *msk)
> > =

> > 	sock_owned_by_me((const struct sock *)msk);
> > =

> > -	if (!ssock || tcp_sk(ssock->sk)->is_mptcp)
> > +	if (!ssock || sk_is_mptcp(ssock->sk))
> > 		return NULL;
> > =

> > 	return ssock;
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index b9aca17b0b91..cf4c05a6cfac 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -254,6 +254,15 @@ static void subflow_ulp_release(struct sock *sk)
> > 	kfree_rcu(ctx, rcu);
> > }
> > =

> > +static void subflow_ulp_fallback(struct sock *sk)
> > +{
> > +	struct inet_connection_sock *icsk =3D inet_csk(sk);
> > +
> > +	icsk->icsk_ulp_ops =3D NULL;
> > +	rcu_assign_pointer(icsk->icsk_ulp_data, NULL);
> > +	tcp_sk(sk)->is_mptcp =3D 0;
> > +}
> > +
> > static void subflow_ulp_clone(const struct request_sock *req,
> > 			      struct sock *newsk,
> > 			      const gfp_t priority)
> > @@ -262,23 +271,23 @@ static void subflow_ulp_clone(const struct reques=
t_sock *req,
> > 	struct mptcp_subflow_context *old_ctx =3D mptcp_subflow_ctx(newsk);
> > 	struct mptcp_subflow_context *new_ctx;
> > =

> > -	/* newsk->sk_socket is NULL at this point */
> > +	if (!subflow_req->mp_capable) {
> =

> Does this logic need to be updated in patch 7 to allow mp_join? Matthieu =

> ran in to a problem applying the series.

Yes, indeed! Thank you for catching this - I actually missed that while
rebasing - and lack of MP_JOIN self-tests did not help :(

It should become:

	if (!subflow_req->mp_capable && !subflow_req->mp_join) {
		// ...

Thanks

Paolo



--===============5251565665307708058==--
