Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE8BAD29
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680802371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQ1Zdk1xwx0h2DGYS0+FcVgl2sWAzwC0rPSLw8NfjBA=;
	b=PkIdQ8Qzivgtkv6eI8u0UVaSZm73hie9wTw+o5dTm7jThdbXZcyj70LplStqI5LOhAwpai
	m4CcV7F18nuuYKn5QernIbPy61IWEa3urIa2EAeWRSC7BfnginBjdsthym05Tq4oZm+xt5
	gejzzTbMoDedNR1/oHRzsDmigmZv+Tk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-stsWw49POreQgqrwt23Ydg-1; Thu, 06 Apr 2023 13:32:26 -0400
X-MC-Unique: stsWw49POreQgqrwt23Ydg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8F4D2A5955D
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:19 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.137])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 445F5202701F
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:19 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH RFC mptcp-net-next 5/5] net/mptcp: use netlink policy generated from YAML spec
Date: Thu,  6 Apr 2023 19:31:59 +0200
Message-ID: <c4f10d6368a1bf580dd3b4cbcdafa1a71e398404.1680801697.git.dcaratti@redhat.com>
In-Reply-To: <cover.1680801697.git.dcaratti@redhat.com>
References: <cover.1680801697.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Message-ID: <20230406173159.vjKk7zJ6cyrQl9c5RwemQMbWO6eJd8GHzW-3jvtoa88@z>

 $ ./tools/net/ynl/ynl-gen-c.py --mode kernel  \
 > --spec Documentation/netlink/specs/mptcp.yaml --header \
 > -o net/mptcp/pm_nl.h
 $ ./tools/net/ynl/ynl-gen-c.py --mode kernel  \
 > --spec Documentation/netlink/specs/mptcp.yaml --source \
 > -o net/mptcp/pm_nl.c

and remove the old ones we had in pm_netlink.c/pm_userspace.c

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/mptcp/Makefile       |   3 +-
 net/mptcp/pm_netlink.c   | 107 +++++----------------------------------
 net/mptcp/pm_nl.c        |  91 +++++++++++++++++++++++++++++++++
 net/mptcp/pm_nl.h        |  39 ++++++++++++++
 net/mptcp/pm_userspace.c |   9 ++--
 net/mptcp/protocol.h     |   6 +--
 6 files changed, 152 insertions(+), 103 deletions(-)
 create mode 100644 net/mptcp/pm_nl.c
 create mode 100644 net/mptcp/pm_nl.h

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 84e531f86b82..dedd1bf8d052 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -2,7 +2,8 @@
 obj-$(CONFIG_MPTCP) += mptcp.o
 
 mptcp-y := protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o diag.o \
-	   mib.o pm_netlink.o sockopt.o pm_userspace.o fastopen.o sched.o
+	   mib.o pm_netlink.o sockopt.o pm_userspace.o fastopen.o sched.o \
+	   pm_nl.o
 
 obj-$(CONFIG_SYN_COOKIES) += syncookies.o
 obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e8336b8bd30e..44cb7925aec1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1116,28 +1116,6 @@ static const struct genl_multicast_group mptcp_pm_mcgrps[] = {
 					  },
 };
 
-static const struct nla_policy
-mptcp_pm_addr_policy[MPTCP_PM_ADDR_ATTR_MAX + 1] = {
-	[MPTCP_PM_ADDR_ATTR_FAMILY]	= { .type	= NLA_U16,	},
-	[MPTCP_PM_ADDR_ATTR_ID]		= { .type	= NLA_U8,	},
-	[MPTCP_PM_ADDR_ATTR_ADDR4]	= { .type	= NLA_U32,	},
-	[MPTCP_PM_ADDR_ATTR_ADDR6]	=
-		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
-	[MPTCP_PM_ADDR_ATTR_PORT]	= { .type	= NLA_U16	},
-	[MPTCP_PM_ADDR_ATTR_FLAGS]	= { .type	= NLA_U32	},
-	[MPTCP_PM_ADDR_ATTR_IF_IDX]     = { .type	= NLA_S32	},
-};
-
-static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
-	[MPTCP_PM_ATTR_ADDR]		=
-					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
-	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
-	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
-	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
-	[MPTCP_PM_ATTR_LOC_ID]		= { .type	= NLA_U8,	},
-	[MPTCP_PM_ATTR_ADDR_REMOTE]	=
-					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
-};
 
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
@@ -1200,7 +1178,7 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 
 	/* no validation needed - was already done via nested policy */
 	err = nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
-					  mptcp_pm_addr_policy, info->extack);
+					  mptcp_pm_addr_nl_policy, info->extack);
 	if (err)
 		return err;
 
@@ -1315,7 +1293,7 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
 	return 0;
 }
 
-static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1507,7 +1485,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 	return 0;
 }
 
-static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1624,7 +1602,7 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 	pernet->addrs = 0;
 }
 
-static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	LIST_HEAD(free_list);
@@ -1680,7 +1658,7 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1730,8 +1708,8 @@ static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int mptcp_nl_cmd_dump_addrs(struct sk_buff *msg,
-				   struct netlink_callback *cb)
+int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				struct netlink_callback *cb)
 {
 	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1788,8 +1766,7 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 	return 0;
 }
 
-static int
-mptcp_nl_cmd_set_limits(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	unsigned int rcv_addrs, subflows;
@@ -1814,8 +1791,7 @@ mptcp_nl_cmd_set_limits(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int
-mptcp_nl_cmd_get_limits(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct sk_buff *msg;
@@ -1889,7 +1865,7 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, }, *entry;
 	struct mptcp_pm_addr_entry remote = { .addr = { .family = AF_UNSPEC }, };
@@ -2282,72 +2258,15 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 	nlmsg_free(skb);
 }
 
-static const struct genl_small_ops mptcp_pm_ops[] = {
-	{
-		.cmd    = MPTCP_PM_CMD_ADD_ADDR,
-		.doit   = mptcp_nl_cmd_add_addr,
-		.flags  = GENL_UNS_ADMIN_PERM,
-	},
-	{
-		.cmd    = MPTCP_PM_CMD_DEL_ADDR,
-		.doit   = mptcp_nl_cmd_del_addr,
-		.flags  = GENL_UNS_ADMIN_PERM,
-	},
-	{
-		.cmd    = MPTCP_PM_CMD_FLUSH_ADDRS,
-		.doit   = mptcp_nl_cmd_flush_addrs,
-		.flags  = GENL_UNS_ADMIN_PERM,
-	},
-	{
-		.cmd    = MPTCP_PM_CMD_GET_ADDR,
-		.doit   = mptcp_nl_cmd_get_addr,
-		.dumpit   = mptcp_nl_cmd_dump_addrs,
-	},
-	{
-		.cmd    = MPTCP_PM_CMD_SET_LIMITS,
-		.doit   = mptcp_nl_cmd_set_limits,
-		.flags  = GENL_UNS_ADMIN_PERM,
-	},
-	{
-		.cmd    = MPTCP_PM_CMD_GET_LIMITS,
-		.doit   = mptcp_nl_cmd_get_limits,
-	},
-	{
-		.cmd    = MPTCP_PM_CMD_SET_FLAGS,
-		.doit   = mptcp_nl_cmd_set_flags,
-		.flags  = GENL_UNS_ADMIN_PERM,
-	},
-	{
-		.cmd    = MPTCP_PM_CMD_ANNOUNCE,
-		.doit   = mptcp_nl_cmd_announce,
-		.flags  = GENL_UNS_ADMIN_PERM,
-	},
-	{
-		.cmd    = MPTCP_PM_CMD_REMOVE,
-		.doit   = mptcp_nl_cmd_remove,
-		.flags  = GENL_UNS_ADMIN_PERM,
-	},
-	{
-		.cmd    = MPTCP_PM_CMD_SUBFLOW_CREATE,
-		.doit   = mptcp_nl_cmd_sf_create,
-		.flags  = GENL_UNS_ADMIN_PERM,
-	},
-	{
-		.cmd    = MPTCP_PM_CMD_SUBFLOW_DESTROY,
-		.doit   = mptcp_nl_cmd_sf_destroy,
-		.flags  = GENL_UNS_ADMIN_PERM,
-	},
-};
-
 static struct genl_family mptcp_genl_family __ro_after_init = {
 	.name		= MPTCP_PM_NAME,
 	.version	= MPTCP_PM_VER,
 	.maxattr	= MPTCP_PM_ATTR_MAX,
-	.policy		= mptcp_pm_policy,
+	.policy		= mptcp_pm_attr_nl_policy,
 	.netnsok	= true,
 	.module		= THIS_MODULE,
-	.small_ops	= mptcp_pm_ops,
-	.n_small_ops	= ARRAY_SIZE(mptcp_pm_ops),
+	.small_ops	= mptcp_pm_nl_ops,
+	.n_small_ops	= ARRAY_SIZE(mptcp_pm_nl_ops),
 	.resv_start_op	= MPTCP_PM_CMD_SUBFLOW_DESTROY + 1,
 	.mcgrps		= mptcp_pm_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(mptcp_pm_mcgrps),
diff --git a/net/mptcp/pm_nl.c b/net/mptcp/pm_nl.c
new file mode 100644
index 000000000000..5de927aa8a1d
--- /dev/null
+++ b/net/mptcp/pm_nl.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/mptcp.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "pm_nl.h"
+
+#include <linux/mptcp_pm.h>
+
+/* Common nested types */
+const struct nla_policy mptcp_pm_addr_nl_policy[MPTCP_PM_ADDR_ATTR_IF_IDX + 1] = {
+	[MPTCP_PM_ADDR_ATTR_FAMILY] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_ID] = { .type = NLA_U8, },
+	[MPTCP_PM_ADDR_ATTR_ADDR4] = { .type = NLA_U32, },
+	[MPTCP_PM_ADDR_ATTR_ADDR6] = { .len = 16, },
+	[MPTCP_PM_ADDR_ATTR_PORT] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_FLAGS] = { .type = NLA_U32, },
+	[MPTCP_PM_ADDR_ATTR_IF_IDX] = { .type = NLA_S32, },
+};
+
+/* Global operation policy for mptcp_pm */
+const struct nla_policy mptcp_pm_attr_nl_policy[MPTCP_PM_ATTR_ADDR_REMOTE + 1] = {
+	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_addr_nl_policy),
+	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_LOC_ID] = { .type = NLA_U8, },
+	[MPTCP_PM_ATTR_ADDR_REMOTE] = NLA_POLICY_NESTED(mptcp_pm_addr_nl_policy),
+};
+
+/* Ops table for mptcp_pm */
+const struct genl_small_ops mptcp_pm_nl_ops[11] = {
+	{
+		.cmd	= MPTCP_PM_CMD_ADD_ADDR,
+		.doit	= mptcp_pm_nl_add_addr_doit,
+		.flags	= GENL_UNS_ADMIN_PERM,
+	},
+	{
+		.cmd	= MPTCP_PM_CMD_DEL_ADDR,
+		.doit	= mptcp_pm_nl_del_addr_doit,
+		.flags	= GENL_UNS_ADMIN_PERM,
+	},
+	{
+		.cmd	= MPTCP_PM_CMD_GET_ADDR,
+		.doit	= mptcp_pm_nl_get_addr_doit,
+		.dumpit	= mptcp_pm_nl_get_addr_dumpit,
+		.flags	= GENL_UNS_ADMIN_PERM,
+	},
+	{
+		.cmd	= MPTCP_PM_CMD_FLUSH_ADDRS,
+		.doit	= mptcp_pm_nl_flush_addrs_doit,
+		.flags	= GENL_UNS_ADMIN_PERM,
+	},
+	{
+		.cmd	= MPTCP_PM_CMD_SET_LIMITS,
+		.doit	= mptcp_pm_nl_set_limits_doit,
+		.flags	= GENL_UNS_ADMIN_PERM,
+	},
+	{
+		.cmd	= MPTCP_PM_CMD_GET_LIMITS,
+		.doit	= mptcp_pm_nl_get_limits_doit,
+	},
+	{
+		.cmd	= MPTCP_PM_CMD_SET_FLAGS,
+		.doit	= mptcp_pm_nl_set_flags_doit,
+		.flags	= GENL_UNS_ADMIN_PERM,
+	},
+	{
+		.cmd	= MPTCP_PM_CMD_ANNOUNCE,
+		.doit	= mptcp_pm_nl_announce_doit,
+		.flags	= GENL_UNS_ADMIN_PERM,
+	},
+	{
+		.cmd	= MPTCP_PM_CMD_REMOVE,
+		.doit	= mptcp_pm_nl_remove_doit,
+		.flags	= GENL_UNS_ADMIN_PERM,
+	},
+	{
+		.cmd	= MPTCP_PM_CMD_SUBFLOW_CREATE,
+		.doit	= mptcp_pm_nl_subflow_create_doit,
+		.flags	= GENL_UNS_ADMIN_PERM,
+	},
+	{
+		.cmd	= MPTCP_PM_CMD_SUBFLOW_DESTROY,
+		.doit	= mptcp_pm_nl_subflow_destroy_doit,
+		.flags	= GENL_UNS_ADMIN_PERM,
+	},
+};
diff --git a/net/mptcp/pm_nl.h b/net/mptcp/pm_nl.h
new file mode 100644
index 000000000000..26dd13f3244d
--- /dev/null
+++ b/net/mptcp/pm_nl.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/mptcp.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_MPTCP_PM_GEN_H
+#define _LINUX_MPTCP_PM_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <linux/mptcp_pm.h>
+
+/* Common nested types */
+extern const struct nla_policy mptcp_pm_addr_nl_policy[MPTCP_PM_ADDR_ATTR_IF_IDX + 1];
+
+/* Global operation policy for mptcp_pm */
+extern const struct nla_policy mptcp_pm_attr_nl_policy[MPTCP_PM_ATTR_ADDR_REMOTE + 1];
+
+/* Ops table for mptcp_pm */
+extern const struct genl_small_ops mptcp_pm_nl_ops[11];
+
+int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *skb,
+				struct netlink_callback *cb);
+int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb,
+				    struct genl_info *info);
+int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb,
+				     struct genl_info *info);
+
+#endif /* _LINUX_MPTCP_PM_GEN_H */
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 27a275805c06..8936d0f80884 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -122,7 +122,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
 }
 
-int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -184,7 +184,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
@@ -246,7 +246,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -361,7 +361,8 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 	return NULL;
 }
 
-int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb,
+				     struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5a35c77723e3..ca33d2808b61 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -13,6 +13,8 @@
 #include <uapi/linux/mptcp.h>
 #include <net/genetlink.h>
 
+#include "pm_nl.h" /* for netlink interface */
+
 #define MPTCP_SUPPORTED_VERSION	1
 
 /* MPTCP option bits */
@@ -849,10 +851,6 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
-int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info);
-int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info);
-int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info);
-int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.39.2

