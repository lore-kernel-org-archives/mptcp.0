Content-Type: multipart/mixed; boundary="===============7540520094181795454=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 6/6] mptcp: add netlink based PM
Date: Tue, 11 Feb 2020 19:12:13 +0100
Message-ID: <88c03932daa25595c8507dbfc1166328e8fb7941.1581444138.git.pabeni@redhat.com>
In-Reply-To: cover.1581444137.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3618

--===============7540520094181795454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Expose to U/S a netlink family to control the PM, setting:

 - list of local addresses to be signaled.
 - list of local addresses used to created subflows.
 - maximum number of add_addr option to react

When the msk is fully established, the PM netlink attempts to
create subflow for each addr in 'local' list, waiting for each
connection to be completed before attempting the next one.

After exausting the 'local' list, the PM tries to announce the
'signal' list via the ADD_ADDR option. Since we currenlty lack
the ADD_ADDR echo (and related event) only the first addr is sent.

Idea is to add an additional PM hook for ADD_ADDR echo, to allow
the PM netlink announcing multiple addresses, in sequence.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/uapi/linux/mptcp.h |  42 +++
 net/mptcp/Makefile         |   3 +-
 net/mptcp/pm.c             |  18 +-
 net/mptcp/pm_netlink.c     | 524 +++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h       |   7 +
 5 files changed, 592 insertions(+), 2 deletions(-)
 create mode 100644 net/mptcp/pm_netlink.c

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 3912a9808fa2..ec176be789fa 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -31,4 +31,46 @@ enum {
 };
 =

 #define MPTCP_SUBFLOW_MAX (__MPTCP_SUBFLOW_MAX - 1)
+
+/* netlink interface */
+#define MPTCP_PM_NAME		"mptcp_pm"
+#define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
+#define MPTCP_PM_VER		0x1
+
+/*
+ * ATTR types defined for MPTCP
+ */
+enum mptcp_pm_attrs {
+	MPTCP_PM_ATTR_UNSPEC,
+
+	MPTCP_PM_ATTR_ADDR_LIST,			/* nested list */
+	MPTCP_PM_ATTR_ADD_ADDR_MAX,			/* u32 */
+
+	__MPTCP_PM_ATTR_MAX
+};
+
+#define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
+
+enum mptcp_pm_addr_addrs {
+	MPTCP_PM_ADDR_ATTR_UNSPEC,
+
+	MPTCP_PM_ADDR_ATTR_FAMILY,			/* u16 */
+	MPTCP_PM_ADDR_ATTR_ADDR4,			/* u32 */
+	MPTCP_PM_ADDR_ATTR_ADDR6,			/* struct in6_addr */
+
+	__MPTCP_PM_ADDR_ATTR_MAX
+};
+
+#define MPTCP_PM_ADDR_ATTR_MAX (__MPTCP_PM_ADDR_ATTR_MAX - 1)
+
+enum {
+	MPTCP_CMD_UNSPEC,
+
+	MPTCP_CMD_NS_SIGNAL,
+	MPTCP_CMD_NS_LOCAL,
+	MPTCP_CMD_NS_ADD_ADDR_MAX,
+
+	__MPTCP_CMD_AFTER_LAST
+};
+
 #endif /* _UAPI_MPTCP_H */
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index faebe8ec9f73..baa0640527c7 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_MPTCP) +=3D mptcp.o
 =

-mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o d=
iag.o mib.o
+mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o d=
iag.o \
+	   mib.o pm_netlink.o
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5323945216f2..a813c090d0c2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -174,7 +174,7 @@ int mptcp_pm_addr_signal(struct mptcp_sock *msk, unsign=
ed int remaining,
 =

 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
-	return 0;
+	return mptcp_pm_nl_get_local_id(msk, skc);
 }
 =

 static void pm_worker(struct work_struct *work)
@@ -185,6 +185,18 @@ static void pm_worker(struct work_struct *work)
 	struct sock *sk =3D (struct sock *)msk;
 =

 	switch (pm->status) {
+	case MPTCP_PM_ADD_ADDR:
+		mptcp_pm_nl_add_addr(msk);
+		break;
+
+	case MPTCP_PM_ESTABLISHED:
+		mptcp_pm_nl_fully_established(msk);
+		break;
+
+	case MPTCP_PM_SUBFLOW_ESTABLISHED:
+		mptcp_pm_nl_subflow_established(msk);
+		break;
+
 	default:
 		break;
 	}
@@ -202,6 +214,8 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 =

 	spin_lock_init(&msk->pm.lock);
 	INIT_WORK(&msk->pm.work, pm_worker);
+
+	mptcp_pm_nl_data_init(msk);
 }
 =

 void mptcp_pm_init(void)
@@ -209,4 +223,6 @@ void mptcp_pm_init(void)
 	pm_wq =3D alloc_workqueue("pm_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 8);
 	if (!pm_wq)
 		panic("Failed to allocate workqueue");
+
+	mptcp_pm_nl_init();
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
new file mode 100644
index 000000000000..2df93b502c9e
--- /dev/null
+++ b/net/mptcp/pm_netlink.c
@@ -0,0 +1,524 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2020, Red Hat, Inc.
+ */
+
+#include <linux/inet.h>
+#include <linux/kernel.h>
+#include <net/tcp.h>
+#include <net/netns/generic.h>
+#include <net/mptcp.h>
+#include <net/genetlink.h>
+#include <uapi/linux/mptcp.h>
+
+#include "protocol.h"
+
+static int pm_nl_pernet_id;
+
+struct mptcp_pm_addr_entry {
+	struct list_head	list;
+	struct mptcp_addr_info	addr;
+	struct rcu_head		rcu;
+};
+
+struct pm_nl_pernet {
+	struct list_head	signal;
+	struct list_head	local;
+	spinlock_t		lock;
+	unsigned		add_addr_signal_max;
+	unsigned		add_addr_accept_max;
+	unsigned		local_addr_max;;
+};
+
+#define MPTCP_PM_ADDR_MAX	8
+
+static void local_address(const struct sock_common *skc,
+			  struct mptcp_addr_info *addr)
+{
+	memset(addr, 0, sizeof(*addr));
+
+	addr->family =3D skc->skc_family;
+	if (addr->family =3D=3D AF_INET)
+		addr->addr.s_addr =3D skc->skc_rcv_saddr;
+#if IS_ENABLED(CONFIG_IPV6)
+	else if (addr->family =3D=3D AF_INET6)
+		addr->addr6 =3D skc->skc_v6_rcv_saddr;
+#endif
+}
+
+static void remote_address(const struct sock_common *skc,
+			   struct mptcp_addr_info *addr)
+{
+	memset(addr, 0, sizeof(*addr));
+
+	addr->family =3D skc->skc_family;
+	addr->port =3D skc->skc_dport;
+	if (addr->family =3D=3D AF_INET)
+		addr->addr.s_addr =3D skc->skc_daddr;
+#if IS_ENABLED(CONFIG_IPV6)
+	else if (addr->family =3D=3D AF_INET6)
+		addr->addr6 =3D skc->skc_v6_daddr;
+#endif
+}
+
+static bool lookup_subflow_by_saddr(const struct mptcp_sock *msk,
+				   struct mptcp_addr_info *saddr)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_addr_info cur;
+	struct sock_common *skc;
+
+	list_for_each_entry(subflow, &msk->conn_list, node) {
+		skc =3D (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
+
+		local_address(skc, &cur);
+		if (!memcpy(&cur, saddr, sizeof(struct mptcp_addr_info)))
+			return true;
+	}
+
+	return false;
+}
+
+static struct mptcp_pm_addr_entry *
+pick_local_address(const struct pm_nl_pernet *pernet,
+		   const struct mptcp_sock *msk)
+{
+	struct mptcp_pm_addr_entry *entry, *ret;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &pernet->local, list) {
+		if (entry->addr.family =3D=3D ((struct sock *)msk)->sk_family &&
+		    !lookup_subflow_by_saddr(msk, &entry->addr)) {
+			ret =3D entry;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static struct mptcp_pm_addr_entry *
+pick_signal_address(struct pm_nl_pernet *pernet, unsigned pos)
+{
+	struct mptcp_pm_addr_entry *entry, *ret =3D NULL;
+	int i =3D 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &pernet->local, list) {
+		if (++i =3D=3D pos) {
+			ret =3D entry;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static void mptcp_pm_create_subflow_or_signal(struct mptcp_sock *msk)
+{
+	unsigned addr_signaled, laddr_used, max;
+	struct sock *sk =3D (struct sock *)msk;
+	struct mptcp_pm_addr_entry *local;
+	struct mptcp_addr_info remote;
+	struct pm_nl_pernet *pernet;
+
+	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+
+	lock_sock(sk);
+
+	spin_lock_bh(&msk->pm.lock);
+	laddr_used =3D READ_ONCE(msk->pm.local_addr_used);
+	max =3D READ_ONCE(msk->pm.local_addr_max);
+
+	/* check first if should create a new subflow */
+	if (max && laddr_used < max) {
+		remote_address((struct sock_common *)sk, &remote);
+
+		local =3D pick_local_address(pernet, msk);
+		if (local) {
+			WRITE_ONCE(msk->pm.local_addr_used, laddr_used + 1);
+			spin_unlock(&msk->pm.lock);
+			__mptcp_subflow_connect(sk, &local->addr, &remote);
+			release_sock(sk);
+			return;
+		}
+
+		/* lookup failed, avoid fourther attemps later */
+		WRITE_ONCE(msk->pm.local_addr_used, max);
+	}
+
+	/* check for announce */
+	addr_signaled =3D READ_ONCE(msk->pm.add_addr_signaled);
+	max =3D READ_ONCE(msk->pm.add_addr_signal_max);
+	if (max && addr_signaled < max) {
+		local =3D pick_signal_address(pernet, addr_signaled);
+
+		if (local) {
+			WRITE_ONCE(msk->pm.local_addr_used, laddr_used + 1);
+			mptcp_pm_announce_addr(msk, &local->addr);
+		} else {
+			/* pick failed, avoid fourther attemps later */
+			WRITE_ONCE(msk->pm.local_addr_used, max);
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+}
+
+void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
+{
+	mptcp_pm_create_subflow_or_signal(msk);
+}
+
+void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
+{
+	mptcp_pm_create_subflow_or_signal(msk);
+}
+
+void mptcp_pm_nl_add_addr(struct mptcp_sock *msk)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	struct mptcp_addr_info remote;
+	struct mptcp_addr_info local;
+	struct pm_nl_pernet *pernet;
+	unsigned accepted;
+
+	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+
+	spin_lock(&msk->pm.lock);
+	accepted =3D READ_ONCE(msk->pm.add_addr_accepted);
+	if (accepted >=3D READ_ONCE(msk->pm.add_addr_accept_max)) {
+		spin_unlock(&msk->pm.lock);
+		return;
+	}
+
+	/* connect to the specified remote address, using whatever
+	 * local address the routing configuration will pick.
+	 */
+	remote =3D msk->pm.remote;
+	memset(&local, 0, sizeof(local));
+	local.family =3D remote.family;
+	WRITE_ONCE(msk->pm.add_addr_accepted, accepted + 1);
+	spin_unlock(&msk->pm.lock);
+
+	lock_sock(sk);
+	__mptcp_subflow_connect((struct sock *)msk, &local, &remote);
+	release_sock(sk);
+}
+
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc)
+{
+	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_addr_info skc_local;
+	struct mptcp_addr_info msk_local;
+	struct pm_nl_pernet *pernet;
+	int ret =3D -1;
+
+	if (WARN_ON_ONCE(!msk))
+		return 0;
+
+	local_address((struct sock_common *)msk, &msk_local);
+	local_address((struct sock_common *)msk, &skc_local);
+	if (!memcmp(&msk_local, &skc_local, sizeof(struct mptcp_addr_info)))
+		return 0;
+
+	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &pernet->local, list) {
+		if (!memcmp(&entry->addr, &skc_local,
+			     sizeof(struct mptcp_addr_info))) {
+			ret =3D entry->addr.id;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	/* TODO: if not found add to local list, marking it as "DO NOT USE
+	 for new subflow", up to MPTCP_PM_ADDR_MAX */
+	return ret;
+}
+
+void mptcp_pm_nl_data_init(struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet;
+
+	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+
+	WRITE_ONCE(msk->pm.add_addr_signal_max, pernet->add_addr_signal_max);
+	WRITE_ONCE(msk->pm.add_addr_accept_max, pernet->add_addr_accept_max);
+	WRITE_ONCE(msk->pm.local_addr_max, pernet->local_addr_max);
+}
+
+#define MPTCP_PM_CMD_GRP_OFFSET	0
+
+static const struct genl_multicast_group mptcp_pm_mcgrps[] =3D {
+	[MPTCP_PM_CMD_GRP_OFFSET]	=3D { .name =3D MPTCP_PM_CMD_GRP_NAME, },
+};
+
+static const struct nla_policy mptcp_pm_addr_policy[MPTCP_PM_ADDR_ATTR_MAX=
 + 1] =3D {
+	[MPTCP_PM_ADDR_ATTR_FAMILY]	=3D { .type	=3D NLA_U16,	},
+	[MPTCP_PM_ADDR_ATTR_ADDR4]	=3D { .type	=3D NLA_U32,	},
+	[MPTCP_PM_ADDR_ATTR_ADDR6]	=3D { .type	=3D NLA_BINARY,
+					    .len   =3D sizeof(struct in6_addr), },
+};
+
+static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] =3D {
+	[MPTCP_PM_ATTR_ADDR_LIST]	=3D
+			   NLA_POLICY_NESTED_ARRAY(mptcp_pm_addr_policy),
+	[MPTCP_PM_ATTR_ADD_ADDR_MAX]	=3D { .type	=3D NLA_U32,	},
+};
+
+static int mptcp_pm_family_to_addr(int family)
+{
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (family =3D=3D AF_INET6)
+		return MPTCP_PM_ADDR_ATTR_ADDR6;
+#endif
+	return MPTCP_PM_ADDR_ATTR_ADDR4;
+}
+
+static int mptcp_pm_parse_addr(struct nlattr *addr,
+			       struct mptcp_addr_info *loc_addr,
+			       struct genl_info *info)
+{
+	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
+	int err, addr_addr;
+
+	/* no validation needed - was already done via nested policy */
+	err =3D nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, addr,
+					  mptcp_pm_addr_policy, info->extack);
+	if (err)
+		return err;
+
+	if (!tb[MPTCP_PM_ADDR_ATTR_FAMILY]) {
+		NL_SET_ERR_MSG_ATTR(info->extack, addr,
+				    "missing family");
+		return -EINVAL;
+	}
+
+	loc_addr->family =3D nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_FAMILY]);
+	if (loc_addr->family !=3D AF_INET
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	    && loc_addr->family !=3D AF_INET6
+#endif
+	    ) {
+		NL_SET_ERR_MSG_ATTR(info->extack, addr,
+				    "unknown address family");
+		return -EINVAL;
+	}
+	addr_addr =3D mptcp_pm_family_to_addr(loc_addr->family);
+	if (!tb[addr_addr])
+		NL_SET_ERR_MSG_ATTR(info->extack, addr,
+				    "missing address data");
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (loc_addr->family =3D=3D AF_INET6)
+		loc_addr->addr6 =3D nla_get_in6_addr(tb[addr_addr]);
+	else
+#endif
+		loc_addr->addr.s_addr =3D nla_get_in_addr(tb[addr_addr]);
+	return 0;
+}
+
+static void __flush_list(struct list_head *head)
+{
+	while (!list_empty(head)) {
+		struct mptcp_pm_addr_entry *cur =3D list_entry(head,
+						     struct mptcp_pm_addr_entry,
+						     list);
+
+		head =3D head->next;
+		list_del_rcu(&cur->list);
+		kfree_rcu(cur, rcu);
+	}
+}
+
+static int mptcp_pm_parse_addr_list(struct nlattr *addrs,
+				    struct list_head *head,
+				    struct genl_info *info,
+				    bool ignore_port)
+{
+	struct mptcp_pm_addr_entry *loc_addr;
+	int err, remaining, len;
+	struct nlattr *addr;
+
+	len =3D 0;
+	nla_for_each_nested(addr, addrs, remaining) {
+		loc_addr =3D kzalloc(sizeof(*loc_addr), GFP_KERNEL);
+		if (!loc_addr) {
+			NL_SET_ERR_MSG(info->extack, "can't allocate addr");
+			err =3D -ENOMEM;
+			goto fail;
+		}
+
+		err =3D mptcp_pm_parse_addr(addr, &loc_addr->addr, info);
+		if (err)
+			goto fail;
+
+		if (ignore_port)
+			loc_addr->addr.port =3D 0;
+
+		list_add_tail(&loc_addr->list, head);
+		if (++len >=3D MPTCP_PM_ADDR_MAX) {
+			NL_SET_ERR_MSG(info->extack, "address list limit exceeded");
+			err =3D -EINVAL;
+			goto fail;
+		}
+	}
+	return len;
+
+fail:
+	__flush_list(head);
+	return err;
+}
+
+static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
+{
+	return net_generic(genl_info_net(info), pm_nl_pernet_id);
+}
+
+static int mptcp_pm_nl_signal(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *addrs =3D info->attrs[MPTCP_PM_ATTR_ADDR_LIST];
+	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
+	struct list_head old_head;
+	LIST_HEAD(head);
+	int len;
+
+	if (addrs) {
+		len =3D mptcp_pm_parse_addr_list(addrs, &head, info, false);
+		if (len < 0)
+			return len;
+	}
+
+	spin_lock(&pernet->lock);
+	pernet->add_addr_signal_max =3D len;
+	old_head =3D pernet->signal;
+	list_replace_rcu(&pernet->signal, &head);
+	spin_unlock(&pernet->lock);
+
+	__flush_list(&old_head);
+	return 0;
+}
+
+static int mptcp_pm_nl_local(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *addrs =3D info->attrs[MPTCP_PM_ATTR_ADDR_LIST];
+	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
+	struct list_head old_head;
+	LIST_HEAD(head);
+	int len;
+
+	if (addrs) {
+		len =3D mptcp_pm_parse_addr_list(addrs, &head, info, true);
+		if (len)
+			return len;
+	}
+
+	spin_lock(&pernet->lock);
+	pernet->local_addr_max =3D len;
+	old_head =3D pernet->local;
+	list_replace_rcu(&pernet->local, &head);
+	spin_unlock(&pernet->lock);
+
+	__flush_list(&old_head);
+	return 0;
+}
+
+static int mptcp_pm_nl_add_addr_max(struct sk_buff *skb, struct genl_info =
*info)
+{
+	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADD_ADDR_MAX];
+	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
+	int limit;
+
+	if (!attr) {
+		NL_SET_ERR_MSG(info->extack, "missing announce accept limit");
+		return -EINVAL;
+	}
+
+	limit =3D nla_get_u16(attr);
+	if (limit > MPTCP_PM_ADDR_MAX) {
+		NL_SET_ERR_MSG(info->extack, "announce accept limit greater than maximum=
");
+		return -EINVAL;
+	}
+
+	WRITE_ONCE(pernet->add_addr_accept_max, limit);
+	return 0;
+}
+
+static struct genl_ops mptcp_pm_ops[] =3D {
+	{
+		.cmd    =3D MPTCP_CMD_NS_SIGNAL,
+		.doit   =3D mptcp_pm_nl_signal,
+		.flags  =3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd    =3D MPTCP_CMD_NS_LOCAL,
+		.doit   =3D mptcp_pm_nl_local,
+		.flags  =3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd    =3D MPTCP_CMD_NS_ADD_ADDR_MAX,
+		.doit   =3D mptcp_pm_nl_add_addr_max,
+		.flags  =3D GENL_ADMIN_PERM,
+	},
+};
+
+static struct genl_family mptcp_genl_family __ro_after_init =3D {
+	.name		=3D MPTCP_PM_NAME,
+	.version	=3D MPTCP_PM_VER,
+	.maxattr	=3D MPTCP_PM_ATTR_MAX,
+	.policy		=3D mptcp_pm_policy,
+	.netnsok	=3D true,
+	.module		=3D THIS_MODULE,
+	.ops		=3D mptcp_pm_ops,
+	.n_ops		=3D ARRAY_SIZE(mptcp_pm_ops),
+	.mcgrps		=3D mptcp_pm_mcgrps,
+	.n_mcgrps	=3D ARRAY_SIZE(mptcp_pm_mcgrps),
+};
+
+static int __net_init pm_nl_init_net(struct net *net)
+{
+	struct pm_nl_pernet *pernet =3D net_generic(net, pm_nl_pernet_id);
+
+	INIT_LIST_HEAD_RCU(&pernet->signal);
+	INIT_LIST_HEAD_RCU(&pernet->local);
+	pernet->add_addr_signal_max =3D 0;
+	pernet->add_addr_accept_max =3D 0;
+	pernet->local_addr_max =3D 0;
+	spin_lock_init(&pernet->lock);
+	return 0;
+}
+
+static void __net_exit pm_nl_exit_net(struct list_head *net_list)
+{
+	struct net *net;
+
+	list_for_each_entry(net, net_list, exit_list) {
+		struct pm_nl_pernet *pernet =3D net_generic(net, pm_nl_pernet_id);
+
+		/* net is removed from namespace list, can't race with
+		 * other modifiers
+		 */
+		__flush_list(&pernet->signal);
+		__flush_list(&pernet->local);
+	}
+}
+
+static struct pernet_operations mptcp_pm_pernet_ops =3D {
+	.init =3D pm_nl_init_net,
+	.exit_batch =3D pm_nl_exit_net,
+	.id =3D &pm_nl_pernet_id,
+	.size =3D sizeof(struct pm_nl_pernet),
+};
+
+void mptcp_pm_nl_init(void)
+{
+	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
+		panic("Failed to register MPTCP PM pernet subsystem.\n");
+
+	if (genl_register_family(&mptcp_genl_family))
+		panic("Failed to register MPTCP PM netlink family");
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2060832123c2..d918e5aeefc1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -384,6 +384,13 @@ int mptcp_pm_addr_signal(struct mptcp_sock *msk, unsig=
ned int remaining,
 			 struct mptcp_addr_info *saddr);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 =

+void mptcp_pm_nl_init(void);
+void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
+void mptcp_pm_nl_fully_established(struct mptcp_sock *msk);
+void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk);
+void mptcp_pm_nl_add_addr(struct mptcp_sock *msk);
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc);
+
 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
 	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
-- =

2.21.1

--===============7540520094181795454==--
