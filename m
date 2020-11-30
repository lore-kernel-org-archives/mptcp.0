Content-Type: multipart/mixed; boundary="===============3283632381377850342=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 4/7] mptcp: deal with
 MPTCP_PM_ADDR_ATTR_PORT in PM netlink
Date: Mon, 30 Nov 2020 14:17:52 +0800
Message-ID: <71b221fa770a0c60949e788017dedb56fff3394d.1606716547.git.geliangtang@gmail.com>
In-Reply-To: 8778018030d1dc833b40fb8ff1afa1bbe02551b0.1606716547.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6975

--===============3283632381377850342==
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
index a41c41974eb9..ba31065ef462 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -759,6 +759,9 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, str=
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

@@ -1002,6 +1005,8 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
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

--===============3283632381377850342==--
