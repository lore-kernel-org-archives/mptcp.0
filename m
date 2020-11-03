Content-Type: multipart/mixed; boundary="===============8904867075850010002=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 08/10] mptcp: deal with
 MPTCP_PM_ADDR_ATTR_PORT in PM netlink
Date: Tue, 03 Nov 2020 18:29:46 +0100
Message-ID: <cac59bd5-e67b-351f-e043-2dfb281560ec@tessares.net>
In-Reply-To: 043eb9f772ca5b53f35a9553dd101e01f5db3ee6.1604156723.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6523

--===============8904867075850010002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 31/10/2020 16:31, Geliang Tang wrote:
> This patch added the MPTCP_PM_ADDR_ATTR_PORT filling and parsing in PM
> netlink.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>   net/mptcp/pm_netlink.c | 5 +++++
>   1 file changed, 5 insertions(+)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index ab0e68426c9e..069447424ddb 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -725,6 +725,9 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, s=
truct genl_info *info,
>   	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
>   		entry->addr.flags =3D nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
>   =

> +	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
> +		entry->addr.port =3D htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
> +
>   	return 0;
>   }
>   =

> @@ -911,6 +914,8 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
>   =

>   	if (nla_put_u16(skb, MPTCP_PM_ADDR_ATTR_FAMILY, addr->family))
>   		goto nla_put_failure;
> +	if (nla_put_u16(skb, MPTCP_PM_ADDR_ATTR_PORT, ntohs(addr->port)))

It looks strange to me to store something in "network" order. Do we not =

store everything in "host" order, no?

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8904867075850010002==--
