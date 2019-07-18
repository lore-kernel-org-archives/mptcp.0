Content-Type: multipart/mixed; boundary="===============7621384163756876653=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 7/9] Move setting request_ fields of subflow to
 MPTCP layer
Date: Thu, 18 Jul 2019 10:49:21 -0700
Message-ID: <bdf6da315d586a29bd282505119bac2639775f38.camel@linux.intel.com>
In-Reply-To: 28a920d38fe3d692b0695c34a6316ad14a258269.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1533

--===============7621384163756876653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-07-18 at 09:31 +0200, Paolo Abeni wrote:
> On Wed, 2019-07-17 at 15:12 -0700, Peter Krystad wrote:
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 1664a69c8e30..fe73379a81df 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -853,6 +854,11 @@ static int mptcp_stream_connect(struct socket *soc=
k, struct sockaddr *uaddr,
> >  			return err;
> >  	}
> >  =

> > +	subflow =3D subflow_ctx(msk->subflow->sk);
> > +	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
> > +	subflow->request_cksum =3D 1; /* @@ if checksum enabled */
> > +	subflow->request_version =3D 0; /* only v0 supported */
> > +
> =

> Since this chunck is replicated a few lines below, and possibly some
> more code is going to be added to this section, with time, what about
> adding an helper for that?

OK, will do.

> =

> Cheers,
> =

> Paolo
> =



--===============7621384163756876653==--
