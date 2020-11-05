Content-Type: multipart/mixed; boundary="===============4857405494334514532=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 09/12] mptcp: deal with
 MPTCP_PM_ADDR_ATTR_PORT in PM netlink
Date: Thu, 05 Nov 2020 16:01:09 +0800
Message-ID: <3775ed8cff23c75013c20dcd6e32db64c995a739.1604562475.git.geliangtang@gmail.com>
In-Reply-To: cad745590e6ee63e655836915e5ffeddb561108e.1604562475.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6553

--===============4857405494334514532==
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
index ab0e68426c9e..069447424ddb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -725,6 +725,9 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, str=
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

@@ -911,6 +914,8 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
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

--===============4857405494334514532==--
