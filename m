Content-Type: multipart/mixed; boundary="===============1688971765162211666=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Allow ip mptcp endpoint show
Date: Mon, 03 Aug 2020 10:38:12 -0700
Message-ID: <20200803173812.GG1761@MacBook-Pro-64.local>
In-Reply-To: f6a2eb52b418c5985e0d39c749e0c52a4fffe1af.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5450

--===============1688971765162211666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 08/03/20 - 19:23, Davide Caratti wrote:
> On Mon, 2020-08-03 at 10:10 -0700, Christoph Paasch wrote:
> > The intention was to dump the entire address-list when no ID is given.
> > However, the condition needs to rather check on argc as argv will always
> > be !=3D NULL.
> > =

> > Fixes: 7e0767cd862b ("add support for mptcp netlink interface")
> > Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> > ---
> >  ip/ipmptcp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > =

> > diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> > index bc12418bd39c..df38754c82b6 100644
> > --- a/ip/ipmptcp.c
> > +++ b/ip/ipmptcp.c
> > @@ -273,7 +273,7 @@ static int mptcp_addr_show(int argc, char **argv)
> >  	struct nlmsghdr *answer;
> >  	int ret;
> >  =

> > -	if (!argv)
> > +	if (argc =3D=3D 0)
> >  		return mptcp_addr_dump();
> >  =

> >  	ret =3D mptcp_parse_opt(argc, argv, &req.n, false);
> =

> I think I saw already this patch :-)

Interesting, I was on origin/master and not origin/main ... well, well... :=
-)


Christoph

> =

> https://lore.kernel.org/netdev/20200724121718.2180511-1-matthieu.baerts(a=
)tessares.net
> =

> -- =

> davide
>=20
--===============1688971765162211666==--
