Content-Type: multipart/mixed; boundary="===============3342594375512895868=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v10 mptcp-next 6/9] mptcp: deal with
 MPTCP_PM_ADDR_ATTR_PORT in PM netlink
Date: Thu, 14 Jan 2021 13:25:03 +0800
Message-ID: <156b2f822d4a239fef135c3258946666f2604427.1610598621.git.geliangtang@gmail.com>
In-Reply-To: 6bd93e6f42bf90df04a1092aa68d9cc4ffbea53f.1610598621.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7363

--===============3342594375512895868==
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
index e924204d28e7..5a6d4753fba8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -910,6 +910,9 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, str=
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

@@ -1176,6 +1179,8 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
 =

 	if (nla_put_u16(skb, MPTCP_PM_ADDR_ATTR_FAMILY, addr->family))
 		goto nla_put_failure;
+	if (nla_put_u16(skb, MPTCP_PM_ADDR_ATTR_PORT, ntohs(addr->port)))
+		goto nla_put_failure;
 	if (nla_put_u8(skb, MPTCP_PM_ADDR_ATTR_ID, addr->id))
 		goto nla_put_failure;
 	if (nla_put_u32(skb, MPTCP_PM_ADDR_ATTR_FLAGS, entry->addr.flags))
-- =

2.29.2

--===============3342594375512895868==--
