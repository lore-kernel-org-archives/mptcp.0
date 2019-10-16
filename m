Content-Type: multipart/mixed; boundary="===============3263053835338325447=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 4/5] mptcp: Update path manager interface commands
 for IPv6
Date: Wed, 16 Oct 2019 16:35:53 +0200
Message-ID: <cf4861aef4bdd4ef6eee230ecf579022510262ec.camel@redhat.com>
In-Reply-To: 8718e478-911c-a542-3784-738fdacac3c2@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2177

--===============3263053835338325447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-16 at 16:21 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 16/10/2019 13:00, Paolo Abeni wrote:
> > Hi,
> > =

> > On Tue, 2019-10-15 at 16:06 -0700, Peter Krystad wrote:
> > > squashto: Implement path manager interface commands
> > > =

> > > Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> > > ---
> > >   net/mptcp/pm.c | 75 ++++++++++++++++++++++++++++++++++++++++++-----=
---
> > >   1 file changed, 64 insertions(+), 11 deletions(-)
> > > =

> > > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > > index bc46a0ddd396..b14308ad11a3 100644
> > > --- a/net/mptcp/pm.c
> > > +++ b/net/mptcp/pm.c
> > > @@ -23,11 +23,11 @@ int mptcp_pm_announce_addr(u32 token, u8 local_id=
, struct in_addr *addr)
> > >   		goto announce_put;
> > >   	}
> > >   =

> > > -	pr_debug("msk=3D%p, local_id=3D%d, addr=3D%x", msk, local_id, addr-=
>s_addr);
> > > +	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
> > >   	msk->pm.local_valid =3D 1;
> > >   	msk->pm.local_id =3D local_id;
> > > -	msk->pm.local_family =3D family;
> > > -	msk->pm.local_addr.s_addr =3D addr->s_addr;
> > > +	msk->pm.local_family =3D AF_INET;
> > > +	msk->pm.local_addr =3D *addr;
> > >   	msk->addr_signal =3D 1;
> > =

> > I think a part of the above chunk belong to patch 1/5. Specifically:
> >   =

> > -	msk->pm.local_family =3D family;
> > +	msk->pm.local_family =3D AF_INET;
> > =

> > I think it should be squashed into "mptcp: Add path manager interface",
> > otherwise the build will break, as mptcp_pm_announce_addr() lacks the
> > 'family' argument after applying 1/5
> =

> In "mptcp: Add path manager interface", mptcp_pm_announce_addr() is not =

> implemented:
> =

>   int mptcp_pm_announce_addr(u32 token, u8 local_id, sa_family_t family,
>                              struct in_addr *addr)
>   {
>          return -ENOTSUPP;
>   }

whoops, I got lost in the series, sorry!

> > Otherwise looks good to me, thanks!
> =

> Is this patch OK for you or the whole series? :)

With the whole series, actually!

Thanks,

Paolo

--===============3263053835338325447==--
