Content-Type: multipart/mixed; boundary="===============8374031805154663725=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 7/7] mptcp: drop unnecessary
 CONFIG_MPTCP_IPV6
Date: Tue, 16 Mar 2021 17:55:46 -0700
Message-ID: <3885dfb7-8772-cfa2-88a7-4beba08741f8@linux.intel.com>
In-Reply-To: a9e630765f70579375d3faf731e4b62d78fd1dfa.1615878331.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8177

--===============8374031805154663725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Mar 2021, Geliang Tang wrote:

> This patch dropped all the unnecessary '#if IS_ENABLED(CONFIG_MPTCP_IPV6)'
> and '#endif'.
>

If IPV6 is not enabled, what's the benefit of including the extra IPV6 =

code? I can see a possible benefit to parsing and sending echo responses =

to peers that might send ADD_ADDR with IPv6 (because they would not know =

that the other peer does not have IPv6 enabled), but I don't think that =

accounts for all the removals in this commit. It would help to explain the =

motivation in the commit message!

Thanks,

Mat


> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/options.c    | 6 ------
> net/mptcp/pm_netlink.c | 8 +-------
> 2 files changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index e3fcd2b0ffd7..913cfc83bae4 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -221,22 +221,18 @@ static void mptcp_parse_option(const struct sk_buff=
 *skb,
> 			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR ||
> 			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_PORT)
> 				mp_opt->addr.family =3D AF_INET;
> -#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> 			else if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6 ||
> 				 opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_PORT)
> 				mp_opt->addr.family =3D AF_INET6;
> -#endif
> 			else
> 				break;
> 		} else {
> 			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_BASE ||
> 			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT)
> 				mp_opt->addr.family =3D AF_INET;
> -#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> 			else if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE ||
> 				 opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT)
> 				mp_opt->addr.family =3D AF_INET6;
> -#endif
> 			else
> 				break;
> 		}
> @@ -1155,10 +1151,8 @@ void mptcp_write_options(__be32 *ptr, const struct=
 tcp_sock *tp,
> 		u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> 		u8 echo =3D MPTCP_ADDR_ECHO;
>
> -#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> 		if (opts->addr.family =3D=3D AF_INET6)
> 			len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> -#endif
>
> 		if (opts->addr.port)
> 			len +=3D TCPOLEN_MPTCP_PORT_LEN;
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 181d8048cac1..5691ad101a95 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -889,10 +889,8 @@ static const struct nla_policy mptcp_pm_policy[MPTCP=
_PM_ATTR_MAX + 1] =3D {
>
> static int mptcp_pm_family_to_addr(int family)
> {
> -#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> 	if (family =3D=3D AF_INET6)
> 		return MPTCP_PM_ADDR_ATTR_ADDR6;
> -#endif
> 	return MPTCP_PM_ADDR_ATTR_ADDR4;
> }
>
> @@ -925,11 +923,7 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, =
struct genl_info *info,
> 	}
>
> 	entry->addr.family =3D nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_FAMILY]);
> -	if (entry->addr.family !=3D AF_INET
> -#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -	    && entry->addr.family !=3D AF_INET6
> -#endif
> -	    ) {
> +	if (entry->addr.family !=3D AF_INET && entry->addr.family !=3D AF_INET6=
) {
> 		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> 				    "unknown address family");
> 		return -EINVAL;
> -- =

> 2.30.2

--
Mat Martineau
Intel
--===============8374031805154663725==--
