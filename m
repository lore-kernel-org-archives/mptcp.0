Content-Type: multipart/mixed; boundary="===============2969179569435900980=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 08/10] mptcp: deal with
 MPTCP_PM_ADDR_ATTR_PORT in PM netlink
Date: Thu, 05 Nov 2020 14:46:35 +0100
Message-ID: <babf110b-0908-c88a-1471-c182ff6c4b04@tessares.net>
In-Reply-To: CA+WQbwvhnyUhr7DNB4rgMmi5Q1SJc7u8cbvyfzMeV3cenW7e8g@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6565

--===============2969179569435900980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 04/11/2020 08:22, Geliang Tang wrote:
> Hi Matt,
> =

> Matthieu Baerts <matthieu.baerts(a)tessares.net =

> <mailto:matthieu.baerts(a)tessares.net>> =E4=BA=8E2020=E5=B9=B411=E6=9C=
=884=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:29=E5=86=99=E9=81=93=EF=
=BC=9A
> =

>     Hi Geliang,
> =

>     On 31/10/2020 16:31, Geliang Tang wrote:
>      > This patch added the MPTCP_PM_ADDR_ATTR_PORT filling and parsing
>     in PM
>      > netlink.
>      >
>      > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com
>     <mailto:geliangtang(a)gmail.com>>
>      > ---
>      >=C2=A0 =C2=A0net/mptcp/pm_netlink.c | 5 +++++
>      >=C2=A0 =C2=A01 file changed, 5 insertions(+)
>      >
>      > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>      > index ab0e68426c9e..069447424ddb 100644
>      > --- a/net/mptcp/pm_netlink.c
>      > +++ b/net/mptcp/pm_netlink.c
>      > @@ -725,6 +725,9 @@ static int mptcp_pm_parse_addr(struct nlattr
>     *attr, struct genl_info *info,
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry->addr.=
flags =3D
>     nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
>      >
>      > +=C2=A0 =C2=A0 =C2=A0if (tb[MPTCP_PM_ADDR_ATTR_PORT])
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry->addr.port =
=3D
>     htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
>      > +
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>      >=C2=A0 =C2=A0}
>      >
>      > @@ -911,6 +914,8 @@ static int mptcp_nl_fill_addr(struct sk_buff
>     *skb,
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0if (nla_put_u16(skb, MPTCP_PM_ADDR_ATTR_=
FAMILY, addr->family))
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto nla_put=
_failure;
>      > +=C2=A0 =C2=A0 =C2=A0if (nla_put_u16(skb, MPTCP_PM_ADDR_ATTR_PORT,
>     ntohs(addr->port)))
> =

>     It looks strange to me to store something in "network" order. Do we n=
ot
>     store everything in "host" order, no?
> =

> =

> I think we can't. Since the 'skc_dport' in struct sock_common and the
> 'sin_port' in struct sockaddr_in are all defined as big-endian order. It's
> simply to keep the 'port' in struct mptcp_addr_info as a big-endian order
> too.

That's right, thank you for pointing this to me! If this is tiddly =

linked with inet_dport and others, that's fine for me.

I have to admit it always confused me having these port numbers stored =

in network byte order... but I guess it is best to keep the same logic!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2969179569435900980==--
