Content-Type: multipart/mixed; boundary="===============0330753493752960615=="
MIME-Version: 1.0
From: Bo YU <tsu.yubo at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH V2 -next] mptcp/pm_netlink.c : add check for
 nla_put_in/6_addr
Date: Wed, 22 Apr 2020 09:34:38 +0800
Message-ID: <20200422013433.qzlthtmx4c7mmlh3@host>
X-Status: 
X-Keywords:                  
X-UID: 4218

--===============0330753493752960615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Normal there should be checked for nla_put_in6_addr like other
usage in net.

Detected by CoverityScan, CID# 1461639

Fixes: 01cacb00b35c("mptcp: add netlink-based PM")
Signed-off-by: Bo YU <tsu.yubo(a)gmail.com>
---
V2: Add check for nla_put_in_addr suggested by Paolo Abeni
---
 net/mptcp/pm_netlink.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 86d61ab34c7c..0a39f0ebad76 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -599,12 +599,15 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
 	    nla_put_s32(skb, MPTCP_PM_ADDR_ATTR_IF_IDX, entry->ifindex))
 		goto nla_put_failure;

-	if (addr->family =3D=3D AF_INET)
+	if (addr->family =3D=3D AF_INET &&
 		nla_put_in_addr(skb, MPTCP_PM_ADDR_ATTR_ADDR4,
-				addr->addr.s_addr);
+				addr->addr.s_addr))
+		goto nla_put_failure;
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	else if (addr->family =3D=3D AF_INET6)
-		nla_put_in6_addr(skb, MPTCP_PM_ADDR_ATTR_ADDR6, &addr->addr6);
+	else if (addr->family =3D=3D AF_INET6 &&
+		nla_put_in6_addr(skb, MPTCP_PM_ADDR_ATTR_ADDR6, &addr->addr6))
+		goto nla_put_failure;
 #endif
 	nla_nest_end(skb, attr);
 	return 0;
--
2.11.0

--===============0330753493752960615==--
