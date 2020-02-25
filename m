Content-Type: multipart/mixed; boundary="===============5227829608630111225=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 6/8] mptcp: avoid work queue scheduling
 if possible
Date: Tue, 25 Feb 2020 13:51:21 +0100
Message-ID: <20200225125121.GJ19559@breakpoint.cc>
In-Reply-To: e39273fde8de31e82c35048cd758c48268518bff.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3783

--===============5227829608630111225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> > +/* In most cases we will be able to lock the mptcp socket.  If its alr=
eady
> > + * owned, we need to defer to the work queue to avoid ABBA deadlock.
> > + */
> > +static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
> > +{
> > +	struct sock *sk =3D (struct sock *)msk;
> > +	unsigned int moved =3D 0;
> > +
> > +	if (sock_owned_by_user_nocheck(sk))
> > +		return false;
> > +
> > +	if (unlikely(!spin_trylock_bh(&sk->sk_lock.slock)))
> > +		return false;
> > +
> > +	/* must re-check after taking the lock */
> > +	if (!sock_owned_by_user_nocheck(sk))
> =

> Don't we additionally need a READ_ONCE() here and above ?
> Otherwise the compiler and/or CPU could merge the read?

Oh, right, at least first check needs READ_ONCE annotation, thanks.

> AFAICS sock_owned_by_user_nocheck() does not include the additional
> annotation.
> =

> I think we could simply drop the first check (and always do the
> trylock)

The trylock would succeed however when socket is owned, leading to
a uneeded lock operation.
--===============5227829608630111225==--
