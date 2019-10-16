Content-Type: multipart/mixed; boundary="===============5597617543858171282=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 4/5] mptcp: Update path manager interface commands
 for IPv6
Date: Wed, 16 Oct 2019 07:38:11 -0700
Message-ID: <c953c3ba44ec59bc3996cee3beeb31b78fb52a55.camel@linux.intel.com>
In-Reply-To: cf4861aef4bdd4ef6eee230ecf579022510262ec.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2176

--===============5597617543858171282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Paolo, thanks for reviewing.

On Wed, 2019-10-16 at 16:35 +0200, Paolo Abeni wrote:
> On Wed, 2019-10-16 at 16:21 +0200, Matthieu Baerts wrote:
> > Hi Paolo,
> > =

> > On 16/10/2019 13:00, Paolo Abeni wrote:
> > > Hi,
> > > =

> > > On Tue, 2019-10-15 at 16:06 -0700, Peter Krystad wrote:
> > > > squashto: Implement path manager interface commands
> > > > =

> > > > Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> > > > ---
> > > >   net/mptcp/pm.c | 75 ++++++++++++++++++++++++++++++++++++++++++---=
-----
> > > >   1 file changed, 64 insertions(+), 11 deletions(-)
> > > > =

> > > > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > > > index bc46a0ddd396..b14308ad11a3 100644
> > > > --- a/net/mptcp/pm.c
> > > > +++ b/net/mptcp/pm.c
> > > > @@ -23,11 +23,11 @@ int mptcp_pm_announce_addr(u32 token, u8 local_=
id, struct in_addr *addr)
> > > >   		goto announce_put;
> > > >   	}
> > > >   =

> > > > -	pr_debug("msk=3D%p, local_id=3D%d, addr=3D%x", msk, local_id, add=
r->s_addr);
> > > > +	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
> > > >   	msk->pm.local_valid =3D 1;
> > > >   	msk->pm.local_id =3D local_id;
> > > > -	msk->pm.local_family =3D family;
> > > > -	msk->pm.local_addr.s_addr =3D addr->s_addr;
> > > > +	msk->pm.local_family =3D AF_INET;
> > > > +	msk->pm.local_addr =3D *addr;
> > > >   	msk->addr_signal =3D 1;
> > > =

> > > I think a part of the above chunk belong to patch 1/5. Specifically:
> > >   =

> > > -	msk->pm.local_family =3D family;
> > > +	msk->pm.local_family =3D AF_INET;
> > > =

> > > I think it should be squashed into "mptcp: Add path manager interface=
",
> > > otherwise the build will break, as mptcp_pm_announce_addr() lacks the
> > > 'family' argument after applying 1/5
> > =

> > In "mptcp: Add path manager interface", mptcp_pm_announce_addr() is not =

> > implemented:
> > =

> >   int mptcp_pm_announce_addr(u32 token, u8 local_id, sa_family_t family,
> >                              struct in_addr *addr)
> >   {
> >          return -ENOTSUPP;
> >   }
> =

> whoops, I got lost in the series, sorry!

Yes, there are two patches with very similar titles, I got confused many ti=
mes
rebasing this set.

Peter.

> > > Otherwise looks good to me, thanks!
> > =

> > Is this patch OK for you or the whole series? :)
> =

> With the whole series, actually!
> =

> Thanks,
> =

> Paolo
>=20

--===============5597617543858171282==--
