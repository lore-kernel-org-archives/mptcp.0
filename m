Content-Type: multipart/mixed; boundary="===============2473067625973479121=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v3] Squash-to: "mptcp: add netlink-based PM"
Date: Thu, 26 Mar 2020 12:53:56 +0100
Message-ID: <b733f047245027ea51dfc99e02d56fe8ff6aa13c.1585223512.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4073

--===============2473067625973479121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let user space set a single limit at once and drop bogus
NL extack error message.

v2 -> v3:
 - better error message (Mat)
 - add spinlock
 - relax admin constraint on 'getters'

v1 -> v2:
 - do not include dumb dbg messages

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/pm_netlink.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 743c3c58f826..a0ce7f324499 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -702,15 +702,12 @@ static int parse_limit(struct genl_info *info, int id=
, unsigned int *limit)
 {
 	struct nlattr *attr =3D info->attrs[id];
 =

-	if (!attr) {
-		GENL_SET_ERR_MSG(info, "missing announce accept limit");
-		return -EINVAL;
-	}
+	if (!attr)
+		return 0;
 =

 	*limit =3D nla_get_u32(attr);
 	if (*limit > MPTCP_PM_ADDR_MAX) {
-		GENL_SET_ERR_MSG(info,
-				 "announce accept limit greater than maximum");
+		GENL_SET_ERR_MSG(info, "limit greater than maximum");
 		return -EINVAL;
 	}
 	return 0;
@@ -723,17 +720,23 @@ mptcp_nl_cmd_set_limits(struct sk_buff *skb, struct g=
enl_info *info)
 	unsigned int rcv_addrs, subflows;
 	int ret;
 =

+	spin_lock_bh(&pernet->lock);
+	rcv_addrs =3D pernet->add_addr_accept_max;
 	ret =3D parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs);
 	if (ret)
-		return ret;
+		goto unlock;
 =

+	subflows =3D pernet->subflows_max;
 	ret =3D parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows);
 	if (ret)
-		return ret;
+		goto unlock;
 =

 	WRITE_ONCE(pernet->add_addr_accept_max, rcv_addrs);
 	WRITE_ONCE(pernet->subflows_max, subflows);
-	return 0;
+
+unlock:
+	spin_unlock_bh(&pernet->lock);
+	return ret;
 }
 =

 static int
@@ -789,7 +792,6 @@ static struct genl_ops mptcp_pm_ops[] =3D {
 		.cmd    =3D MPTCP_PM_CMD_GET_ADDR,
 		.doit   =3D mptcp_nl_cmd_get_addr,
 		.dumpit   =3D mptcp_nl_cmd_dump_addrs,
-		.flags  =3D GENL_ADMIN_PERM,
 	},
 	{
 		.cmd    =3D MPTCP_PM_CMD_SET_LIMITS,
@@ -799,7 +801,6 @@ static struct genl_ops mptcp_pm_ops[] =3D {
 	{
 		.cmd    =3D MPTCP_PM_CMD_GET_LIMITS,
 		.doit   =3D mptcp_nl_cmd_get_limits,
-		.flags  =3D GENL_ADMIN_PERM,
 	},
 };
 =

-- =

2.21.1

--===============2473067625973479121==--
