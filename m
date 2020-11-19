Content-Type: multipart/mixed; boundary="===============8222554507538883092=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 07/10] mptcp: deal with
 MPTCP_PM_ADDR_ATTR_PORT in PM netlink
Date: Thu, 19 Nov 2020 18:19:47 +0800
Message-ID: <c8ba71370269c45d3cffab524cdbdb5d803a1549.1605780306.git.geliangtang@gmail.com>
In-Reply-To: d3d9dea1baa419a5fcdbdf1a01770d982c211f2c.1605780306.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6818

--===============8222554507538883092==
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
index 27aff32516dd..bb01b0f3e131 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -797,6 +797,9 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, str=
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

@@ -985,6 +988,8 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
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

--===============8222554507538883092==--
