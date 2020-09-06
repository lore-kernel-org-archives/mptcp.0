Content-Type: multipart/mixed; boundary="===============0016836539010816910=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC mptcp-next 2/3] mptcp: rework poll+nospace handling
Date: Sun, 06 Sep 2020 18:05:55 +0200
Message-ID: <9dd31690f26628eb54bb7ea8716ca675cb646423.camel@redhat.com>
In-Reply-To: a4428c99de218ce78a6128d34e388910dce1dba6.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5735

--===============0016836539010816910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-09-06 at 17:58 +0200, Paolo Abeni wrote:
> On Sat, 2020-09-05 at 12:33 +0200, Florian Westphal wrote:
> > +static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
> > +{
> > +	struct sock *sk =3D (struct sock *)msk;
> > +	__poll_t ret =3D 0;
> > +	bool slow;
> > +
> > +	if (sk->sk_shutdown & SEND_SHUTDOWN)
> > +		return 0;
> > +
> > +	slow =3D lock_sock_fast(sk);
> > +	if (__mptcp_check_writeable(msk))
> > +		ret =3D EPOLLOUT | EPOLLWRNORM;
> > +
> > +	unlock_sock_fast(sk, slow);
> =

> It's a pity we need to acquire the lock in mptcp_poll()... perhaps we
> could try to acquire it only if sk_stream_is_writeable(msk)?

I'm also wondering if checking sk_stream_is_writeable(msk) could be
enough??? perhaps with a different sndbuf auto-tuning strategy. =


e.g. if msk sndbuf <=3D max (ssk sndbuf), I *think*
that sk_stream_is_writeable(msk) implies at least a ssk is writeable,
too

/P

--===============0016836539010816910==--
