Content-Type: multipart/mixed; boundary="===============1221474993423211656=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 7/7] mptcp: add netlink event support
Date: Thu, 14 Jan 2021 18:36:54 +0100
Message-ID: <20210114173654.7618-8-fw@strlen.de>
In-Reply-To: 20210114173654.7618-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7387

--===============1221474993423211656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow userspace (mptcpd) to subscribe to mptcp genl multicast events.
This implementation reuses the same event API as the mptcp kernel fork
to ease integration of existing tools, e.g. mptcpd.

Supported events include:
1. start and close of an mptcp connection
2. start and close of subflows (joins)
3. announce and withdrawals of addresses
4. subflow priority (backup/non-backup) change.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/uapi/linux/mptcp.h |  70 +++++++++++
 net/mptcp/pm.c             |  20 +++-
 net/mptcp/pm_netlink.c     | 234 ++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.c       |   9 +-
 net/mptcp/protocol.h       |   5 +
 5 files changed, 331 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 3674a451a18c..7ee275a2cfdd 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -36,6 +36,7 @@ enum {
 /* netlink interface */
 #define MPTCP_PM_NAME		"mptcp_pm"
 #define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
+#define MPTCP_PM_EV_GRP_NAME    "mptcp_events"
 #define MPTCP_PM_VER		0x1
 =

 /*
@@ -104,4 +105,73 @@ struct mptcp_info {
 	__u64	mptcpi_rcv_nxt;
 };
 =

+/*
+ * MPTCP_EVENT_CREATED: token, family, saddr4 | saddr6, daddr4 | daddr6,
+ *                         sport, dport
+ *    A new MPTCP connection has been created. It is the good time to allo=
cate
+ *    memory and send ADD_ADDR if needed. Depending on the traffic-patterns
+ *    it can take a long time until the MPTCP_EVENT_ESTABLISHED is sent.
+ *
+ * MPTCP_EVENT_ESTABLISHED: token, family, saddr4 | saddr6, daddr4 | daddr=
6,
+ *			    sport, dport
+ *    A MPTCP connection is established (can start new subflows).
+ *
+ * MPTCP_EVENT_CLOSED: token
+ *    A MPTCP connection has stopped.
+ *
+ * MPTCP_EVENT_ANNOUNCED: token, rem_id, family, daddr4 | daddr6 [, dport]
+ *    A new address has been announced by the peer.
+ *
+ * MPTCP_EVENT_REMOVED: token, rem_id
+ *    An address has been lost by the peer.
+ *
+ * MPTCP_EVENT_SUB_ESTABLISHED: token, family, saddr4 | saddr6,
+ *                              daddr4 | daddr6, sport, dport, backup,
+ *                              if_idx
+ *
+ * MPTCP_EVENT_SUB_CLOSED: token, family, saddr4 | saddr6, daddr4 | daddr6,
+ *                         sport, dport, backup, if_idx
+ *    A subflow has been closed.
+ *
+ * MPTCP_EVENT_SUB_PRIORITY: token, family, saddr4 | saddr6, daddr4 | dadd=
r6,
+ *                              sport, dport, backup, if_idx
+ */
+enum mptcp_event_type {
+	MPTCP_EVENT_UNSPEC =3D 0,
+	MPTCP_EVENT_CREATED =3D 1,
+	MPTCP_EVENT_ESTABLISHED =3D 2,
+	MPTCP_EVENT_CLOSED =3D 3,
+
+	MPTCP_EVENT_ANNOUNCED =3D 6,
+	MPTCP_EVENT_REMOVED =3D 7,
+
+	MPTCP_EVENT_SUB_ESTABLISHED =3D 10,
+	MPTCP_EVENT_SUB_CLOSED =3D 11,
+
+	MPTCP_EVENT_SUB_PRIORITY =3D 13,
+};
+
+enum mptcp_event_attr {
+	MPTCP_ATTR_UNSPEC =3D 0,
+
+	MPTCP_ATTR_TOKEN,	/* u32 */
+	MPTCP_ATTR_FAMILY,	/* u16 */
+	MPTCP_ATTR_LOC_ID,	/* u8 */
+	MPTCP_ATTR_REM_ID,	/* u8 */
+	MPTCP_ATTR_SADDR4,	/* be32 */
+	MPTCP_ATTR_SADDR6,	/* struct in6_addr */
+	MPTCP_ATTR_DADDR4,	/* be32 */
+	MPTCP_ATTR_DADDR6,	/* struct in6_addr */
+	MPTCP_ATTR_SPORT,	/* be16 */
+	MPTCP_ATTR_DPORT,	/* be16 */
+	MPTCP_ATTR_BACKUP,	/* u8 */
+	MPTCP_ATTR_ERROR,	/* u8 */
+	MPTCP_ATTR_FLAGS,	/* u16 */
+	MPTCP_ATTR_TIMEOUT,	/* u32 */
+	MPTCP_ATTR_IF_IDX,	/* s32 */
+
+	__MPTCP_ATTR_AFTER_LAST
+};
+#define MPTCP_ATTR_MAX (__MPTCP_ATTR_AFTER_LAST - 1)
+
 #endif /* _UAPI_MPTCP_H */
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 309c44f13436..dc612d5e2752 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -75,6 +75,7 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, cons=
t struct sock *ssk, int
 	pr_debug("msk=3D%p, token=3D%u side=3D%d", msk, msk->token, server_side);
 =

 	WRITE_ONCE(pm->server_side, server_side);
+	mptcp_event(MPTCP_EVENT_CREATED, msk, ssk, GFP_ATOMIC);
 }
 =

 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
@@ -119,13 +120,10 @@ static bool mptcp_pm_schedule_work(struct mptcp_sock =
*msk,
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock =
*ssk, gfp_t gfp)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
+	bool announce =3D false;
 =

 	pr_debug("msk=3D%p", msk);
 =

-	/* try to avoid acquiring the lock below */
-	if (!READ_ONCE(pm->work_pending))
-		return;
-
 	spin_lock_bh(&pm->lock);
 =

 	/* mptcp_pm_fully_established() can be invoked by multiple
@@ -135,9 +133,15 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk=
, const struct sock *ssk,
 	if (READ_ONCE(pm->work_pending) &&
 	    !(msk->pm.status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
-	msk->pm.status |=3D BIT(MPTCP_PM_ALREADY_ESTABLISHED);
 =

+	if ((msk->pm.status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) =3D=3D 0)
+		announce =3D true;
+
+	msk->pm.status |=3D BIT(MPTCP_PM_ALREADY_ESTABLISHED);
 	spin_unlock_bh(&pm->lock);
+
+	if (announce)
+		mptcp_event(MPTCP_EVENT_ESTABLISHED, msk, ssk, gfp);
 }
 =

 void mptcp_pm_connection_closed(struct mptcp_sock *msk)
@@ -176,6 +180,8 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 	pr_debug("msk=3D%p remote_id=3D%d accept=3D%d", msk, addr->id,
 		 READ_ONCE(pm->accept_addr));
 =

+	mptcp_event_addr_announced(msk, addr);
+
 	spin_lock_bh(&pm->lock);
 =

 	if (!READ_ONCE(pm->accept_addr)) {
@@ -203,6 +209,8 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, =
u8 rm_id)
 =

 	pr_debug("msk=3D%p remote_id=3D%d", msk, rm_id);
 =

+	mptcp_event_addr_removed(msk, rm_id);
+
 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
 	pm->rm_id =3D rm_id;
@@ -215,6 +223,8 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 =

 	pr_debug("subflow->backup=3D%d, bkup=3D%d\n", subflow->backup, bkup);
 	subflow->backup =3D bkup;
+
+	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, mptcp_sk(subflow->conn), sk, GFP_AT=
OMIC);
 }
 =

 /* path manager helpers */
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8d0628590ca8..8c193e009886 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -731,10 +731,14 @@ void mptcp_pm_nl_data_init(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->accept_subflow, subflows);
 }
 =

-#define MPTCP_PM_CMD_GRP_OFFSET	0
+#define MPTCP_PM_CMD_GRP_OFFSET       0
+#define MPTCP_PM_EV_GRP_OFFSET        1
 =

 static const struct genl_multicast_group mptcp_pm_mcgrps[] =3D {
 	[MPTCP_PM_CMD_GRP_OFFSET]	=3D { .name =3D MPTCP_PM_CMD_GRP_NAME, },
+	[MPTCP_PM_EV_GRP_OFFSET]        =3D { .name =3D MPTCP_PM_EV_GRP_NAME,
+					    .flags =3D GENL_UNS_ADMIN_PERM,
+					  },
 };
 =

 static const struct nla_policy
@@ -1274,6 +1278,234 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *s=
kb, struct genl_info *info)
 	return 0;
 }
 =

+static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gf=
p_t gfp)
+{
+	genlmsg_multicast_netns(&mptcp_genl_family, net,
+				nlskb, 0, MPTCP_PM_EV_GRP_OFFSET, gfp);
+}
+
+static int mptcp_event_add_subflow(struct sk_buff *skb, const struct sock =
*ssk)
+{
+	const struct inet_sock *issk =3D inet_sk(ssk);
+	const struct mptcp_subflow_context *sf;
+
+	if (nla_put_u16(skb, MPTCP_ATTR_FAMILY, ssk->sk_family))
+		return -EMSGSIZE;
+
+	switch (ssk->sk_family) {
+	case AF_INET:
+		if (nla_put_in_addr(skb, MPTCP_ATTR_SADDR4, issk->inet_saddr))
+			return -EMSGSIZE;
+		if (nla_put_in_addr(skb, MPTCP_ATTR_DADDR4, issk->inet_daddr))
+			return -EMSGSIZE;
+		break;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	case AF_INET6: {
+		const struct ipv6_pinfo *np =3D inet6_sk(ssk);
+
+		if (nla_put_in6_addr(skb, MPTCP_ATTR_SADDR6, &np->saddr))
+			return -EMSGSIZE;
+		if (nla_put_in6_addr(skb, MPTCP_ATTR_DADDR6, &ssk->sk_v6_daddr))
+			return -EMSGSIZE;
+		break;
+	}
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		return -EMSGSIZE;
+	}
+
+	if (nla_put_be16(skb, MPTCP_ATTR_SPORT, issk->inet_sport))
+		return -EMSGSIZE;
+	if (nla_put_be16(skb, MPTCP_ATTR_DPORT, issk->inet_dport))
+		return -EMSGSIZE;
+
+	sf =3D mptcp_subflow_ctx(ssk);
+	if (WARN_ON_ONCE(!sf))
+		return -EINVAL;
+
+	if (nla_put_u8(skb, MPTCP_ATTR_LOC_ID, sf->local_id))
+		return -EMSGSIZE;
+
+	if (nla_put_u8(skb, MPTCP_ATTR_REM_ID, sf->remote_id))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int mptcp_event_sub_established(struct sk_buff *skb, const struct m=
ptcp_sock *msk, const struct sock *ssk)
+{
+	const struct mptcp_subflow_context *sf;
+
+	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token))
+		return -EMSGSIZE;
+
+	if (mptcp_event_add_subflow(skb, ssk))
+		return -EMSGSIZE;
+
+	sf =3D mptcp_subflow_ctx(ssk);
+	if (WARN_ON_ONCE(!sf))
+		return -EINVAL;
+
+	if (nla_put_u8(skb, MPTCP_ATTR_BACKUP, sf->backup))
+		return -EMSGSIZE;
+
+	if (ssk->sk_bound_dev_if && nla_put_s32(skb, MPTCP_ATTR_IF_IDX, ssk->sk_b=
ound_dev_if))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int mptcp_event_sub_closed(struct sk_buff *skb, const struct mptcp_=
sock *msk, const struct sock *ssk)
+{
+	if (mptcp_event_sub_established(skb, msk, ssk))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int mptcp_event_created(struct sk_buff *skb, const struct mptcp_soc=
k *msk, const struct sock *ssk)
+{
+	int err =3D nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token);
+
+	if (err)
+		return err;
+
+	return mptcp_event_add_subflow(skb, ssk);
+}
+
+void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint8_t id)
+{
+	struct net *net =3D sock_net((const struct sock *)msk);
+        struct nlmsghdr *nlh;
+	struct sk_buff *skb;
+
+	if (!genl_has_listeners(&mptcp_genl_family, net, MPTCP_PM_EV_GRP_OFFSET))
+		return;
+
+	skb =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	nlh =3D genlmsg_put(skb, 0, 0, &mptcp_genl_family, 0, MPTCP_EVENT_REMOVED=
);
+	if (!nlh)
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token))
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, MPTCP_ATTR_REM_ID, id))
+		goto nla_put_failure;
+
+	genlmsg_end(skb, nlh);
+	return mptcp_nl_mcast_send(net, skb, GFP_ATOMIC);
+
+nla_put_failure:
+	kfree_skb(skb);
+}
+
+void mptcp_event_addr_announced(const struct mptcp_sock *msk, const struct=
 mptcp_addr_info *info)
+{
+	struct net *net =3D sock_net((const struct sock *)msk);
+        struct nlmsghdr *nlh;
+	struct sk_buff *skb;
+
+	if (!genl_has_listeners(&mptcp_genl_family, net, MPTCP_PM_EV_GRP_OFFSET))
+		return;
+
+	skb =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	nlh =3D genlmsg_put(skb, 0, 0, &mptcp_genl_family, 0, MPTCP_EVENT_ANNOUNC=
ED);
+	if (!nlh)
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token))
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, MPTCP_ATTR_REM_ID, info->id))
+		goto nla_put_failure;
+
+	if (nla_put_be16(skb, MPTCP_ATTR_DPORT, info->port))
+		goto nla_put_failure;
+
+	switch (info->family) {
+	case AF_INET:
+		if (nla_put_in_addr(skb, MPTCP_ATTR_DADDR4, info->addr.s_addr))
+			goto nla_put_failure;
+		break;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	case AF_INET6:
+		if (nla_put_in6_addr(skb, MPTCP_ATTR_DADDR6, &info->addr6))
+			goto nla_put_failure;
+		break;
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		goto nla_put_failure;
+	}
+
+	genlmsg_end(skb, nlh);
+	return mptcp_nl_mcast_send(net, skb, GFP_ATOMIC);
+
+nla_put_failure:
+	kfree_skb(skb);
+}
+
+void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,=
 const struct sock *ssk, gfp_t gfp)
+{
+	struct net *net =3D sock_net((const struct sock *)msk);
+        struct nlmsghdr *nlh;
+	struct sk_buff *skb;
+
+	if (!genl_has_listeners(&mptcp_genl_family, net, MPTCP_PM_EV_GRP_OFFSET))
+		return;
+
+	skb =3D nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	if (!skb)
+		return;
+
+	nlh =3D genlmsg_put(skb, 0, 0, &mptcp_genl_family, 0, type);
+	if (!nlh)
+		goto nla_put_failure;
+
+	switch (type) {
+	case MPTCP_EVENT_UNSPEC:
+		WARN_ON_ONCE(1);
+		break;
+	case MPTCP_EVENT_CREATED:
+	case MPTCP_EVENT_ESTABLISHED:
+		if (mptcp_event_created(skb, msk, ssk) < 0)
+			goto nla_put_failure;
+		break;
+	case MPTCP_EVENT_CLOSED:
+		if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token) < 0)
+			goto nla_put_failure;
+		break;
+	case MPTCP_EVENT_ANNOUNCED:
+	case MPTCP_EVENT_REMOVED:
+		/* call mptcp_event_addr_announced()/removed instead */
+		WARN_ON_ONCE(1);
+		break;
+	case MPTCP_EVENT_SUB_ESTABLISHED:
+	case MPTCP_EVENT_SUB_PRIORITY:
+		if (mptcp_event_sub_established(skb, msk, ssk) < 0)
+			goto nla_put_failure;
+		break;
+	case MPTCP_EVENT_SUB_CLOSED:
+		if (mptcp_event_sub_closed(skb, msk, ssk) < 0)
+			goto nla_put_failure;
+		break;
+	}
+
+	genlmsg_end(skb, nlh);
+	return mptcp_nl_mcast_send(net, skb, gfp);
+
+nla_put_failure:
+	kfree_skb(skb);
+}
+
 static const struct genl_small_ops mptcp_pm_ops[] =3D {
 	{
 		.cmd    =3D MPTCP_PM_CMD_ADD_ADDR,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d31f92503abf..ef0b54f19d96 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2133,6 +2133,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct=
 sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 	__mptcp_close_ssk(sk, ssk, subflow);
 }
 =

@@ -2570,6 +2571,10 @@ static void mptcp_close(struct sock *sk, long timeou=
t)
 	release_sock(sk);
 	if (do_cancel_work)
 		mptcp_cancel_work(sk);
+
+	if (mptcp_sk(sk)->token)
+		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
+
 	sock_put(sk);
 }
 =

@@ -3022,7 +3027,7 @@ bool mptcp_finish_join(struct sock *ssk)
 		return false;
 =

 	if (!msk->pm.server_side)
-		return true;
+		goto out;
 =

 	if (!mptcp_pm_allow_new_subflow(msk))
 		return false;
@@ -3049,6 +3054,8 @@ bool mptcp_finish_join(struct sock *ssk)
 	if (parent_sock && !ssk->sk_socket)
 		mptcp_sock_graft(ssk, parent_sock);
 	subflow->map_seq =3D READ_ONCE(msk->ack_seq);
+out:
+	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 	return true;
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 419aff080621..191485b8fdfe 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -10,6 +10,7 @@
 #include <linux/random.h>
 #include <net/tcp.h>
 #include <net/inet_connection_sock.h>
+#include <uapi/linux/mptcp.h>
 =

 #define MPTCP_SUPPORTED_VERSION	1
 =

@@ -597,6 +598,10 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
 =

+void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,=
 const struct sock *ssk, gfp_t gfp);
+void mptcp_event_addr_announced(const struct mptcp_sock *msk, const struct=
 mptcp_addr_info *info);
+void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
+
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_SIGNAL);
-- =

2.26.2

--===============1221474993423211656==--
