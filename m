Content-Type: multipart/mixed; boundary="===============8544299342359150197=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC 10/11] mptcp: enable JOIN requests even if
 cookies are in use
Date: Mon, 27 Jul 2020 11:02:50 +0200
Message-ID: <20200727090250.GJ23458@breakpoint.cc>
In-Reply-To: 2e429ba0e48baa93a33c52c51abed51eb2ca56d5.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5303

--===============8544299342359150197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> > +static bool mptcp_join_store(struct mptcp_subflow_request_sock *req, s=
truct sock *sk_listener)
> > +{
> > +	struct mptcp_sock *msk =3D req->msk;
> > +	struct inet_connection_sock *icsk;
> > +	struct sock *sk;
> > +
> > +	icsk =3D &msk->sk;
> > +	sk =3D &icsk->icsk_inet.sk;
> > +
> > +	if (inet_csk_reqsk_queue_len(sk) >=3D MPTCP_SUBFLOWS_MAX)
> > +		return false;
> =

> Isn't this test a little too relaxed? e.g. shouldn't we check something
> alike:
> =

> 	if (inet_csk_reqsk_queue_len(sk) + READ_ONCE(pm->subflows) >
> 	    READ_ONCE(pm->subflows_max))
> =

> Possibly we can account the pending MP_JOIN subflows in a new PM field,
> so we could do the above check and the follow-up increment in a
> consistent way with a single atomic opetation (the pm spinlock)

Not following here -- inet_csk_reqsk_queue_len() is supposed to return
the number of all subflows, both established and half-open.

Why would I need to add pm->subflows?
--===============8544299342359150197==--
