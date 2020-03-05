Content-Type: multipart/mixed; boundary="===============0998263933424433471=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 10/12] Squash-to: "mptcp: add netlink based PM"
Date: Thu, 05 Mar 2020 15:46:47 +0100
Message-ID: <49babca922e5470d11d4277eddde792fa9e3d2d0.1583418573.git.pabeni@redhat.com>
In-Reply-To: cover.1583418571.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3884

--===============0998263933424433471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement support for max subflow limits, updating the APIs.
Be sure to avoid any pending work if the subflows limit will
block that.

Fix an issue in local address lookup: we must traverse also
the join_list.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/uapi/linux/mptcp.h |  5 +-
 net/mptcp/pm_netlink.c     | 93 +++++++++++++++++++++++++++-----------
 2 files changed, 69 insertions(+), 29 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 92414f3d1463..d061c5a6ae05 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -45,6 +45,7 @@ enum mptcp_pm_attrs {
 =

 	MPTCP_PM_ATTR_ADDR,				/* nested address */
 	MPTCP_PM_ATTR_RCV_ADD_ADDRS,			/* u32 */
+	MPTCP_PM_ATTR_SUBFLOWS,				/* u32 */
 =

 	__MPTCP_PM_ATTR_MAX
 };
@@ -78,8 +79,8 @@ enum {
 	MPTCP_PM_CMD_DEL_ADDR,
 	MPTCP_PM_CMD_GET_ADDR,
 	MPTCP_PM_CMD_FLUSH_ADDRS,
-	MPTCP_PM_CMD_SET_RCV_ADD_ADDRS,
-	MPTCP_PM_CMD_GET_RCV_ADD_ADDRS,
+	MPTCP_PM_CMD_SET_LIMITS,
+	MPTCP_PM_CMD_GET_LIMITS,
 =

 	__MPTCP_PM_CMD_AFTER_LAST
 };
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0887fae982fc..adfea3b85606 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -35,6 +35,7 @@ struct pm_nl_pernet {
 	unsigned int		add_addr_signal_max;
 	unsigned int		add_addr_accept_max;
 	unsigned int		local_addr_max;
+	unsigned int		subflows_max;
 	unsigned int		next_id;
 };
 =

@@ -89,14 +90,14 @@ static void remote_address(const struct sock_common *sk=
c,
 #endif
 }
 =

-static bool lookup_subflow_by_saddr(const struct mptcp_sock *msk,
+static bool lookup_subflow_by_saddr(const struct list_head *list,
 				    struct mptcp_addr_info *saddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
 	struct sock_common *skc;
 =

-	list_for_each_entry(subflow, &msk->conn_list, node) {
+	list_for_each_entry(subflow, list, node) {
 		skc =3D (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 =

 		local_address(skc, &cur);
@@ -109,20 +110,27 @@ static bool lookup_subflow_by_saddr(const struct mptc=
p_sock *msk,
 =

 static struct mptcp_pm_addr_entry *
 select_local_address(const struct pm_nl_pernet *pernet,
-		     const struct mptcp_sock *msk)
+		     struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *ret =3D NULL;
 =

 	rcu_read_lock();
+	spin_lock_bh(&msk->join_list_lock);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
+
+		/* avoid any address already in use by subflows and
+		 * pending join
+		 */
 		if (entry->addr.family =3D=3D ((struct sock *)msk)->sk_family &&
-		    !lookup_subflow_by_saddr(msk, &entry->addr)) {
+		    !lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
+		    !lookup_subflow_by_saddr(&msk->join_list, &entry->addr)) {
 			ret =3D entry;
 			break;
 		}
 	}
+	spin_unlock_bh(&msk->join_list_lock);
 	rcu_read_unlock();
 	return ret;
 }
@@ -154,7 +162,8 @@ select_signal_address(struct pm_nl_pernet *pernet, unsi=
gned int pos)
 static void check_work_pending(struct mptcp_sock *msk)
 {
 	if (msk->pm.add_addr_signaled =3D=3D msk->pm.add_addr_signal_max &&
-	    msk->pm.local_addr_used =3D=3D msk->pm.local_addr_max)
+	    (msk->pm.local_addr_used =3D=3D msk->pm.local_addr_max ||
+	     (msk->pm.subflows =3D=3D msk->pm.subflows_max)))
 		WRITE_ONCE(msk->pm.work_pending, false);
 }
 =

@@ -192,12 +201,14 @@ static void mptcp_pm_create_subflow_or_signal_addr(st=
ruct mptcp_sock *msk)
 	}
 =

 	/* check if should create a new subflow */
-	if (msk->pm.local_addr_used < msk->pm.local_addr_max) {
+	if (msk->pm.local_addr_used < msk->pm.local_addr_max &&
+	    msk->pm.subflows < msk->pm.subflows_max) {
 		remote_address((struct sock_common *)sk, &remote);
 =

 		local =3D select_local_address(pernet, msk);
 		if (local) {
 			msk->pm.local_addr_used++;
+			msk->pm.subflows++;
 			check_work_pending(msk);
 			spin_unlock_bh(&msk->pm.lock);
 			__mptcp_subflow_connect(sk, local->ifindex,
@@ -239,7 +250,10 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *=
msk)
 	pr_debug("accepted %d:%d remote family %d",
 		 msk->pm.add_addr_accepted, msk->pm.add_addr_accept_max,
 		 msk->pm.remote.family);
-	if (++msk->pm.add_addr_accepted >=3D msk->pm.add_addr_accept_max)
+	msk->pm.add_addr_accepted++;
+	msk->pm.subflows++;
+	if (msk->pm.add_addr_accepted >=3D msk->pm.add_addr_accept_max ||
+	    msk->pm.subflows >=3D msk->pm.subflows_max)
 		WRITE_ONCE(msk->pm.accept_addr, false);
 =

 	/* connect to the specified remote address, using whatever
@@ -352,16 +366,21 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, =
struct sock_common *skc)
 =

 void mptcp_pm_nl_data_init(struct mptcp_sock *msk)
 {
+	struct mptcp_pm_data *pm =3D &msk->pm;
 	struct pm_nl_pernet *pernet;
+	bool subflows;
 =

 	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 =

-	msk->pm.add_addr_signal_max =3D READ_ONCE(pernet->add_addr_signal_max);
-	msk->pm.add_addr_accept_max =3D READ_ONCE(pernet->add_addr_accept_max);
-	msk->pm.local_addr_max =3D READ_ONCE(pernet->local_addr_max);
-	WRITE_ONCE(msk->pm.work_pending,
-		   !!msk->pm.local_addr_max || !!msk->pm.add_addr_signal_max);
-	WRITE_ONCE(msk->pm.accept_addr, !!msk->pm.add_addr_accept_max);
+	pm->add_addr_signal_max =3D READ_ONCE(pernet->add_addr_signal_max);
+	pm->add_addr_accept_max =3D READ_ONCE(pernet->add_addr_accept_max);
+	pm->local_addr_max =3D READ_ONCE(pernet->local_addr_max);
+	pm->subflows_max =3D READ_ONCE(pernet->subflows_max);
+	subflows =3D !!pm->subflows_max;
+	WRITE_ONCE(pm->work_pending, (!!pm->local_addr_max && subflows) ||
+		   !!pm->add_addr_signal_max);
+	WRITE_ONCE(pm->accept_addr, !!pm->add_addr_accept_max && subflows);
+	WRITE_ONCE(pm->accept_subflow, subflows);
 }
 =

 #define MPTCP_PM_CMD_GRP_OFFSET	0
@@ -386,6 +405,7 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM=
_ATTR_MAX + 1] =3D {
 	[MPTCP_PM_ATTR_ADDR]		=3D
 					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	=3D { .type	=3D NLA_U32,	},
+	[MPTCP_PM_ATTR_SUBFLOWS]	=3D { .type	=3D NLA_U32,	},
 };
 =

 static int mptcp_pm_family_to_addr(int family)
@@ -690,31 +710,46 @@ static int mptcp_nl_cmd_dump_addrs(struct sk_buff *ms=
g,
 	return msg->len;
 }
 =

-static int
-mptcp_nl_cmd_set_rcv_add_addrs(struct sk_buff *skb, struct genl_info *info)
+static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 {
-	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_RCV_ADD_ADDRS];
-	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
-	int limit;
+	struct nlattr *attr =3D info->attrs[id];
 =

 	if (!attr) {
 		GENL_SET_ERR_MSG(info, "missing announce accept limit");
 		return -EINVAL;
 	}
 =

-	limit =3D nla_get_u32(attr);
-	if (limit > MPTCP_PM_ADDR_MAX) {
+	*limit =3D nla_get_u32(attr);
+	if (*limit > MPTCP_PM_ADDR_MAX) {
 		GENL_SET_ERR_MSG(info,
 				 "announce accept limit greater than maximum");
 		return -EINVAL;
 	}
+	return 0;
+}
 =

-	WRITE_ONCE(pernet->add_addr_accept_max, limit);
+static int
+mptcp_nl_cmd_set_limits(struct sk_buff *skb, struct genl_info *info)
+{
+	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
+	unsigned int rcv_addrs, subflows;
+	int ret;
+
+	ret =3D parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs);
+	if (ret)
+		return ret;
+
+	ret =3D parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(pernet->add_addr_accept_max, rcv_addrs);
+	WRITE_ONCE(pernet->subflows_max, subflows);
 	return 0;
 }
 =

 static int
-mptcp_nl_cmd_get_rcv_add_addrs(struct sk_buff *skb, struct genl_info *info)
+mptcp_nl_cmd_get_limits(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
 	struct sk_buff *msg;
@@ -725,7 +760,7 @@ mptcp_nl_cmd_get_rcv_add_addrs(struct sk_buff *skb, str=
uct genl_info *info)
 		return -ENOMEM;
 =

 	reply =3D genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
-				  MPTCP_PM_CMD_GET_RCV_ADD_ADDRS);
+				  MPTCP_PM_CMD_GET_LIMITS);
 	if (!reply)
 		goto fail;
 =

@@ -733,6 +768,10 @@ mptcp_nl_cmd_get_rcv_add_addrs(struct sk_buff *skb, st=
ruct genl_info *info)
 			READ_ONCE(pernet->add_addr_accept_max)))
 		goto fail;
 =

+	if (nla_put_u32(msg, MPTCP_PM_ATTR_SUBFLOWS,
+			READ_ONCE(pernet->subflows_max)))
+		goto fail;
+
 	genlmsg_end(msg, reply);
 	return genlmsg_reply(msg, info);
 =

@@ -765,13 +804,13 @@ static struct genl_ops mptcp_pm_ops[] =3D {
 		.flags  =3D GENL_ADMIN_PERM,
 	},
 	{
-		.cmd    =3D MPTCP_PM_CMD_SET_RCV_ADD_ADDRS,
-		.doit   =3D mptcp_nl_cmd_set_rcv_add_addrs,
+		.cmd    =3D MPTCP_PM_CMD_SET_LIMITS,
+		.doit   =3D mptcp_nl_cmd_set_limits,
 		.flags  =3D GENL_ADMIN_PERM,
 	},
 	{
-		.cmd    =3D MPTCP_PM_CMD_GET_RCV_ADD_ADDRS,
-		.doit   =3D mptcp_nl_cmd_get_rcv_add_addrs,
+		.cmd    =3D MPTCP_PM_CMD_GET_LIMITS,
+		.doit   =3D mptcp_nl_cmd_get_limits,
 		.flags  =3D GENL_ADMIN_PERM,
 	},
 };
-- =

2.21.1

--===============0998263933424433471==--
