Content-Type: multipart/mixed; boundary="===============7731818681232525613=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC 10/11] mptcp: enable JOIN requests even if
 cookies are in use
Date: Mon, 27 Jul 2020 11:50:25 +0200
Message-ID: <20200727095025.GK23458@breakpoint.cc>
In-Reply-To: 79ee0796e2bcf48e4d84c119c1118c436b05c6e9.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5306

--===============7731818681232525613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Mon, 2020-07-27 at 11:02 +0200, Florian Westphal wrote:
> > Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > > +static bool mptcp_join_store(struct mptcp_subflow_request_sock *re=
q, struct sock *sk_listener)
> > > > +{
> > > > +	struct mptcp_sock *msk =3D req->msk;
> > > > +	struct inet_connection_sock *icsk;
> > > > +	struct sock *sk;
> > > > +
> > > > +	icsk =3D &msk->sk;
> > > > +	sk =3D &icsk->icsk_inet.sk;
> > > > +
> > > > +	if (inet_csk_reqsk_queue_len(sk) >=3D MPTCP_SUBFLOWS_MAX)
> > > > +		return false;
> > > =

> > > Isn't this test a little too relaxed? e.g. shouldn't we check somethi=
ng
> > > alike:
> > > =

> > > 	if (inet_csk_reqsk_queue_len(sk) + READ_ONCE(pm->subflows) >
> > > 	    READ_ONCE(pm->subflows_max))
> > > =

> > > Possibly we can account the pending MP_JOIN subflows in a new PM fiel=
d,
> > > so we could do the above check and the follow-up increment in a
> > > consistent way with a single atomic opetation (the pm spinlock)
> > =

> > Not following here -- inet_csk_reqsk_queue_len() is supposed to return
> > the number of all subflows, both established and half-open.
> > =

> > Why would I need to add pm->subflows?
> =

> Currently the PM netlink does not accept any additional subflows
> when pm->subflows >=3D pm->subflows_max.

You mean:

if (inet_csk_reqsk_queue_len(sk) >=3D MPTCP_SUBFLOWS_MAX ||
      pm->subflows >=3D pm->subflows_max)
	return false;

?
(I ommitted R_ONCE for brevity only).
--===============7731818681232525613==--
