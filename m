Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CB9C2D8
	for <mptcp@lists.linux.dev>; Fri,  1 Sep 2023 18:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693591847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VP/oJMTWaWyGzFoLwE2FPHHb/JhWoJTlydR2mj7Vzjk=;
	b=XuJAHBbJ+5vE6j5BpK5tkVTczAeF7bDll5ZPohLsduX1RMu6YL3tW9aBX2hMzyXE/yZQpy
	X+xuA0zgtGXw0J+hS+K7NTcKFEEp13GQL5DfQAkj5fIeiHRyI48OO96qUvPHSNj/sbo6s4
	vl7cU0a70csmtafF0OC9z6o9AOKjNbI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-G27O70CeOPqI575Pz6JMsw-1; Fri, 01 Sep 2023 14:10:44 -0400
X-MC-Unique: G27O70CeOPqI575Pz6JMsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE0911C18C7D;
	Fri,  1 Sep 2023 18:10:43 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 435BFD4781D;
	Fri,  1 Sep 2023 18:10:43 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 5/6] net: mptcp: rename netlink handlers to mptcp_pm_nl_<blah>_{doit,dumpit}
Date: Fri,  1 Sep 2023 20:10:34 +0200
Message-Id: <5815cce617ba0d9a55d8dba6aca059d8a11dbedc.1693591676.git.dcaratti@redhat.com>
In-Reply-To: <cover.1693591676.git.dcaratti@redhat.com>
References: <cover.1693591676.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

so that they will match names generated from YAML spec.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/mptcp/pm_netlink.c   | 48 ++++++++++++++++++++--------------------
 net/mptcp/pm_userspace.c |  8 +++----
 net/mptcp/protocol.h     |  8 +++----
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3859a206c298..b4463595ab45 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1327,7 +1327,7 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
 	return 0;
 }
 
-static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1508,7 +1508,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 	return 0;
 }
 
-static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1643,7 +1643,7 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 	pernet->addrs = 0;
 }
 
-static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	LIST_HEAD(free_list);
@@ -1699,7 +1699,7 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1749,8 +1749,8 @@ static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int mptcp_nl_cmd_dump_addrs(struct sk_buff *msg,
-				   struct netlink_callback *cb)
+static int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				       struct netlink_callback *cb)
 {
 	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1808,7 +1808,7 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 }
 
 static int
-mptcp_nl_cmd_set_limits(struct sk_buff *skb, struct genl_info *info)
+mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	unsigned int rcv_addrs, subflows;
@@ -1834,7 +1834,7 @@ mptcp_nl_cmd_set_limits(struct sk_buff *skb, struct genl_info *info)
 }
 
 static int
-mptcp_nl_cmd_get_limits(struct sk_buff *skb, struct genl_info *info)
+mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct sk_buff *msg;
@@ -1943,7 +1943,7 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
 	return 0;
 }
 
-static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry remote = { .addr = { .family = AF_UNSPEC }, };
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
@@ -2308,11 +2308,11 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 }
 
 
-static const struct genl_ops mptcp_pm_ops[] = {
+static const struct genl_ops mptcp_pm_nl_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_ADD_ADDR,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_add_addr,
+		.doit		= mptcp_pm_nl_add_addr_doit,
 		.policy		= mptcp_pm_endpoint_nl_policy,
 		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2320,7 +2320,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_DEL_ADDR,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_del_addr,
+		.doit		= mptcp_pm_nl_del_addr_doit,
 		.policy		= mptcp_pm_endpoint_nl_policy,
 		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2328,8 +2328,8 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_GET_ADDR,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_get_addr,
-		.dumpit		= mptcp_nl_cmd_dump_addrs,
+		.doit		= mptcp_pm_nl_get_addr_doit,
+		.dumpit		= mptcp_pm_nl_get_addr_dumpit,
 		.policy		= mptcp_pm_endpoint_nl_policy,
 		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2337,7 +2337,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_FLUSH_ADDRS,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_flush_addrs,
+		.doit		= mptcp_pm_nl_flush_addrs_doit,
 		.policy		= mptcp_pm_endpoint_nl_policy,
 		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2345,7 +2345,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_SET_LIMITS,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_set_limits,
+		.doit		= mptcp_pm_nl_set_limits_doit,
 		.policy		= mptcp_pm_set_limits_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2353,14 +2353,14 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_GET_LIMITS,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_get_limits,
+		.doit		= mptcp_pm_nl_get_limits_doit,
 		.policy		= mptcp_pm_set_limits_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
 	},
 	{
 		.cmd		= MPTCP_PM_CMD_SET_FLAGS,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_set_flags,
+		.doit		= mptcp_pm_nl_set_flags_doit,
 		.policy		= mptcp_pm_set_flags_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2368,7 +2368,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_ANNOUNCE,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_announce,
+		.doit		= mptcp_pm_nl_announce_doit,
 		.policy		= mptcp_pm_announce_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_TOKEN,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2376,7 +2376,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_REMOVE,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_remove,
+		.doit		= mptcp_pm_nl_remove_doit,
 		.policy		= mptcp_pm_remove_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_LOC_ID,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2384,7 +2384,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_SUBFLOW_CREATE,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_sf_create,
+		.doit		= mptcp_pm_nl_subflow_create_doit,
 		.policy		= mptcp_pm_subflow_create_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2392,7 +2392,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_SUBFLOW_DESTROY,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_sf_destroy,
+		.doit		= mptcp_pm_nl_subflow_destroy_doit,
 		.policy		= mptcp_pm_subflow_create_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2404,8 +2404,8 @@ static struct genl_family mptcp_genl_family __ro_after_init = {
 	.version	= MPTCP_PM_VER,
 	.netnsok	= true,
 	.module		= THIS_MODULE,
-	.ops		= mptcp_pm_ops,
-	.n_ops		= ARRAY_SIZE(mptcp_pm_ops),
+	.ops		= mptcp_pm_nl_ops,
+	.n_ops		= ARRAY_SIZE(mptcp_pm_nl_ops),
 	.resv_start_op	= MPTCP_PM_CMD_SUBFLOW_DESTROY + 1,
 	.mcgrps		= mptcp_pm_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(mptcp_pm_mcgrps),
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b5a8aa4c1ebd..07f602144d5e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -145,7 +145,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
 }
 
-int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -208,7 +208,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
@@ -270,7 +270,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -400,7 +400,7 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 	return NULL;
 }
 
-int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 12d70ce24843..fbe35b74f319 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -873,10 +873,10 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
-int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info);
-int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info);
-int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info);
-int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.40.1

