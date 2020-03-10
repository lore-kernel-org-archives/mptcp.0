Content-Type: multipart/mixed; boundary="===============7044965119497639826=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: BUG: KASAN: slab-out-of-bounds in
 subflow_ulp_init+0xa6/0x190
Date: Tue, 10 Mar 2020 09:15:35 -0700
Message-ID: <20200310161535.GA86670@MacBook-Pro-64.local>
In-Reply-To: d37203699e71a91fbab688b416ecad7c683d4808.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3899

--===============7044965119497639826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks, I will try this out as well.

On a different note, I'm not 100% sure if my syzkaller descriptions are
correct for the Netlink-PM.

Should the following be correct?

r0 =3D socket$netlink(0x10, 0x3, 0x0)
r1 =3D syz_genetlink_get_family_id$mptcp(&(0x7f0000000100)=3D'mptcp_pm\x00')
sendmsg$MPTCP_PM_CMD_ADD_ADDR(r0, &(0x7f0000000200)=3D{0x0, 0x0, &(0x7f0000=
0001c0)=3D{&(0x7f0000000140)=3D{0x20, r1, 0x1, 0x0, 0x0, {0x1, 0x2}, [@MPTC=
P_PM_ATTR_ADDR=3D{0xc, 0x1, @MPTCP_PM_ADDR_ATTR_FAMILY=3D{0x5}}]}, 0x20}}, =
0x0)

I will try to add some BUG()s in the PM to verify this.


Christoph



On 09/03/20 - 08:12:23, Paolo Abeni wrote:
> On Fri, 2020-03-06 at 15:08 -0800, Christoph Paasch wrote:
> > Hello,
> > =

> > I wanted to do some testing on netnext so I did a little hack to
> > force-enable MPTCP without the need for the app to use IPPROTO_MPTCP:
> > =

> > diff --git a/net/socket.c b/net/socket.c
> > index b79a05de7c6e..56c656b4f867 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -1374,6 +1374,9 @@ int __sock_create(struct net *net, int family, in=
t type, int protocol,
> >  	if (type < 0 || type >=3D SOCK_MAX)
> >  		return -EINVAL;
> > =

> > +	if (protocol =3D=3D IPPROTO_TCP && type =3D=3D SOCK_STREAM && (family=
 =3D=3D AF_INET || family =3D=3D AF_INET6))
> > +		protocol =3D IPPROTO_MPTCP;
> > +
> >  	/* Compatibility.
> > =

> >  	   This uglymoron is moved from INET layer to here to avoid
> =

> Or you can use this:
> =

> https://github.com/pabeni/mptcp-tools
> =

> cd mptcp-tools
> =

> ./use_mptcp.sh <app> ...
> =

> (will force mptcp usage via syscall hijaking)
> =

> /P
>=20
--===============7044965119497639826==--
