Content-Type: multipart/mixed; boundary="===============2465142198244214810=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC 10/11] mptcp: enable JOIN requests even if
 cookies are in use
Date: Mon, 27 Jul 2020 11:32:20 +0200
Message-ID: <79ee0796e2bcf48e4d84c119c1118c436b05c6e9.camel@redhat.com>
In-Reply-To: 20200727090250.GJ23458@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 5305

--===============2465142198244214810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-07-27 at 11:02 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > +static bool mptcp_join_store(struct mptcp_subflow_request_sock *req,=
 struct sock *sk_listener)
> > > +{
> > > +	struct mptcp_sock *msk =3D req->msk;
> > > +	struct inet_connection_sock *icsk;
> > > +	struct sock *sk;
> > > +
> > > +	icsk =3D &msk->sk;
> > > +	sk =3D &icsk->icsk_inet.sk;
> > > +
> > > +	if (inet_csk_reqsk_queue_len(sk) >=3D MPTCP_SUBFLOWS_MAX)
> > > +		return false;
> > =

> > Isn't this test a little too relaxed? e.g. shouldn't we check something
> > alike:
> > =

> > 	if (inet_csk_reqsk_queue_len(sk) + READ_ONCE(pm->subflows) >
> > 	    READ_ONCE(pm->subflows_max))
> > =

> > Possibly we can account the pending MP_JOIN subflows in a new PM field,
> > so we could do the above check and the follow-up increment in a
> > consistent way with a single atomic opetation (the pm spinlock)
> =

> Not following here -- inet_csk_reqsk_queue_len() is supposed to return
> the number of all subflows, both established and half-open.
> =

> Why would I need to add pm->subflows?

Currently the PM netlink does not accept any additional subflows
when pm->subflows >=3D pm->subflows_max.

To be reasonable sure the pending syncookied mp_joins will be accepted,
I think we should check that the currently created subflows plus the
pending ones will not exceed the maximum allowed.

Not sure if the above clarify my thinking in any way, please let me
know!

Cheers,

Paolo

--===============2465142198244214810==--
