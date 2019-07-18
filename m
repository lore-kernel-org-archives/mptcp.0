Content-Type: multipart/mixed; boundary="===============1556533800486325650=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 8/9] mptcp: Add handling of outgoing MP_JOIN
 requests
Date: Thu, 18 Jul 2019 10:50:50 -0700
Message-ID: <666ae3671e65f677581abce37c959389ab2d77d8.camel@linux.intel.com>
In-Reply-To: 19a9b1bf594828a7fe016576ce03cd0b2f35ea52.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1534

--===============1556533800486325650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-07-18 at 09:50 +0200, Paolo Abeni wrote:
> On Wed, 2019-07-17 at 15:12 -0700, Peter Krystad wrote:
> > @@ -329,6 +381,17 @@ int token_new_join(struct sock *sk)
> >  	return -1;
> >  }
> >  =

> > +struct sock *token_lookup(u32 token)
> > +{
> > +	struct sock *conn;
> > +
> > +	conn =3D lookup_token(token);
> > +	if (conn)
> > +		sock_hold(conn);
> > +
> > +	return conn;
> > +}
> > +
> =

> Really not a big deal, but this is small, unused in this patch and
> looks unrelated to the code added here. As it will be used by the next
> one, possibly it's cleaner move definition and declaration there.

Yes, if we split the next patch as you suggest then I can move this to the
"keeper" of those two patches.

Peter.

> =

> Paolo
> =

> =

> =



--===============1556533800486325650==--
