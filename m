Content-Type: multipart/mixed; boundary="===============1290749416636144581=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 10/13] mptcp: deal with
 MPTCP_PM_ADDR_ATTR_PORT in PM netlink
Date: Tue, 10 Nov 2020 13:14:58 +0800
Message-ID: <32e69c034c3040c9f269cebf2bdafdc393763eae.1604984546.git.geliangtang@gmail.com>
In-Reply-To: c32afb7d145744ba936bf37097c4120bd51c6c1a.1604984546.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6637

--===============1290749416636144581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the MPTCP_PM_ADDR_ATTR_PORT filling and parsing in PM
netlink.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f3d69cc3ab06..b325d04e65e7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -742,6 +742,9 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, str=
uct genl_info *info,
 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
 		entry->addr.flags =3D nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
 =

+	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
+		entry->addr.port =3D htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
+
 	return 0;
 }
 =

@@ -928,6 +931,8 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
 =

 	if (nla_put_u16(skb, MPTCP_PM_ADDR_ATTR_FAMILY, addr->family))
 		goto nla_put_failure;
+	if (nla_put_u16(skb, MPTCP_PM_ADDR_ATTR_PORT, ntohs(addr->port)))
+		goto nla_put_failure;
 	if (nla_put_u8(skb, MPTCP_PM_ADDR_ATTR_ID, addr->id))
 		goto nla_put_failure;
 	if (nla_put_u32(skb, MPTCP_PM_ADDR_ATTR_FLAGS, entry->addr.flags))
-- =

2.26.2

--===============1290749416636144581==--
