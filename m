Content-Type: multipart/mixed; boundary="===============4152970295607331545=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 7/7] mptcp: drop unnecessary
 CONFIG_MPTCP_IPV6
Date: Sun, 14 Mar 2021 22:22:57 +0800
Message-ID: <255eec6750e3dd702363e8d3877480f416eb76c7.1615731165.git.geliangtang@gmail.com>
In-Reply-To: 7b6d6574160e98b770e537275175f208cebcae34.1615731165.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8155

--===============4152970295607331545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch dropped all the unnecessary '#if IS_ENABLED(CONFIG_MPTCP_IPV6)'
and '#endif'.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c    | 6 ------
 net/mptcp/pm_netlink.c | 8 +-------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e3fcd2b0ffd7..913cfc83bae4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -221,22 +221,18 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
 			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR ||
 			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_PORT)
 				mp_opt->addr.family =3D AF_INET;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 			else if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6 ||
 				 opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_PORT)
 				mp_opt->addr.family =3D AF_INET6;
-#endif
 			else
 				break;
 		} else {
 			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_BASE ||
 			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT)
 				mp_opt->addr.family =3D AF_INET;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 			else if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE ||
 				 opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT)
 				mp_opt->addr.family =3D AF_INET6;
-#endif
 			else
 				break;
 		}
@@ -1155,10 +1151,8 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 		u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
 		u8 echo =3D MPTCP_ADDR_ECHO;
 =

-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		if (opts->addr.family =3D=3D AF_INET6)
 			len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
-#endif
 =

 		if (opts->addr.port)
 			len +=3D TCPOLEN_MPTCP_PORT_LEN;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 812e0874e276..a24f35dc0217 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -897,10 +897,8 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_P=
M_ATTR_MAX + 1] =3D {
 =

 static int mptcp_pm_family_to_addr(int family)
 {
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (family =3D=3D AF_INET6)
 		return MPTCP_PM_ADDR_ATTR_ADDR6;
-#endif
 	return MPTCP_PM_ADDR_ATTR_ADDR4;
 }
 =

@@ -933,11 +931,7 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, st=
ruct genl_info *info,
 	}
 =

 	entry->addr.family =3D nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_FAMILY]);
-	if (entry->addr.family !=3D AF_INET
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	    && entry->addr.family !=3D AF_INET6
-#endif
-	    ) {
+	if (entry->addr.family !=3D AF_INET && entry->addr.family !=3D AF_INET6) {
 		NL_SET_ERR_MSG_ATTR(info->extack, attr,
 				    "unknown address family");
 		return -EINVAL;
-- =

2.30.2

--===============4152970295607331545==--
