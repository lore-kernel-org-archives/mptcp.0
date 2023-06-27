Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C5519514
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 14:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687877493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+gRlkEhxaNXtnMneF3gC/ERV2hd7JrruOQywaW1pkjs=;
	b=hHAIaLPEHJm4KCPorLhs4Kas2GiAmQtEXPdvSao/o6zAh1gKBa6teb7skpOlB5FBrCkdz1
	M2tXdkE8Y3X5yQyVlEfvg0y4GavCPwnvFffleXbn0V5+KrfnRL0GVYUp/5r+rn8/G2nE3p
	MnO1sETxWhRo2JpEWSdC6jr/C+bAV20=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-DTd7V7xTNlSEy_p9ygwLrw-1; Tue, 27 Jun 2023 10:51:30 -0400
X-MC-Unique: DTd7V7xTNlSEy_p9ygwLrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B4223823A0E
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 14:51:26 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.226.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 70D48F5CC5;
	Tue, 27 Jun 2023 14:51:25 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com
Subject: [RFC mptcp-next v2] mptcp: convert netlink from small_ops to ops
Date: Tue, 27 Jun 2023 16:51:20 +0200
Message-Id: <ed9c7f0320bb94a4a147d11c447cefa59f128ee1.1687877390.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

this prepares MPTCP control plane to be described as YAML spec.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/mptcp/pm_netlink.c   | 197 +++++++++++++++++++++++++--------------
 net/mptcp/pm_userspace.c |   2 +-
 net/mptcp/protocol.h     |   4 +-
 3 files changed, 131 insertions(+), 72 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3be32f134d2a..ebb93e0eaa57 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -47,6 +47,46 @@ struct pm_nl_pernet {
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
+const struct nla_policy mptcp_pm_add_addr_nl_policy[MPTCP_PM_ADDR_ATTR_IF_IDX + 1] = {
+	[MPTCP_PM_ADDR_ATTR_FAMILY] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_ADDR4] = { .type = NLA_U32, },
+	[MPTCP_PM_ADDR_ATTR_ADDR6] = { .len = 16, },
+	[MPTCP_PM_ADDR_ATTR_ID] = { .type = NLA_U8, },
+	[MPTCP_PM_ADDR_ATTR_PORT] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_IF_IDX] = { .type = NLA_S32, },
+	[MPTCP_PM_ADDR_ATTR_FLAGS] = { .type = NLA_U32, },
+};
+
+/* MPTCP_PM_CMD_ADD_ADDR / DEL / GET / FLUSH - do */
+static const struct nla_policy mptcp_pm_endpoint_nl_policy[MPTCP_PM_ATTR_ADDR + 1] = {
+	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_add_addr_nl_policy),
+};
+
+/* MPTCP_PM_CMD_SET_LIMITS - do */
+static const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
+	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+};
+
+/* MPTCP_PM_CMD_ANNOUNCE - do */
+static const struct nla_policy mptcp_pm_announce_nl_policy[MPTCP_PM_ATTR_TOKEN + 1] = {
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_add_addr_nl_policy),
+};
+
+/* MPTCP_PM_CMD_REMOVE - do */
+static const struct nla_policy mptcp_pm_remove_nl_policy[MPTCP_PM_ATTR_LOC_ID + 1] = {
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_LOC_ID] = { .type = NLA_U8, },
+};
+
+/* MPTCP_PM_CMD_SUBFLOW_CREATE / DESTROY - do */
+static const struct nla_policy mptcp_pm_subflow_create_nl_policy[MPTCP_PM_ATTR_ADDR_REMOTE + 1] = {
+	[MPTCP_PM_ATTR_ADDR_REMOTE] = NLA_POLICY_NESTED(mptcp_pm_add_addr_nl_policy),
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_add_addr_nl_policy),
+};
+
 static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
 {
 	return net_generic(net, pm_nl_pernet_id);
@@ -1100,29 +1140,6 @@ static const struct genl_multicast_group mptcp_pm_mcgrps[] = {
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
-
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
@@ -1172,6 +1189,7 @@ static int mptcp_pm_family_to_addr(int family)
 static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 				       const struct nlattr *attr,
 				       struct genl_info *info,
+				       const struct nla_policy *nla_policy,
 				       struct mptcp_addr_info *addr,
 				       bool require_family)
 {
@@ -1184,7 +1202,7 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 
 	/* no validation needed - was already done via nested policy */
 	err = nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
-					  mptcp_pm_addr_policy, info->extack);
+					  nla_policy, info->extack);
 	if (err)
 		return err;
 
@@ -1237,19 +1255,20 @@ int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 
 	memset(addr, 0, sizeof(*addr));
 
-	return mptcp_pm_parse_pm_addr_attr(tb, attr, info, addr, true);
+	return mptcp_pm_parse_pm_addr_attr(tb, attr, info, mptcp_pm_add_addr_nl_policy, addr, true);
 }
 
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
-			 bool require_family,
-			 struct mptcp_pm_addr_entry *entry)
+			 const struct nla_policy *nla_policy,
+			 bool require_family, struct mptcp_pm_addr_entry *entry)
 {
 	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
 	int err;
 
 	memset(entry, 0, sizeof(*entry));
 
-	err = mptcp_pm_parse_pm_addr_attr(tb, attr, info, &entry->addr, require_family);
+	err = mptcp_pm_parse_pm_addr_attr(tb, attr, info, nla_policy,
+					  &entry->addr, require_family);
 	if (err)
 		return err;
 
@@ -1306,7 +1325,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry addr, *entry;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, true, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, mptcp_pm_add_addr_nl_policy, true, &addr);
 	if (ret < 0)
 		return ret;
 
@@ -1488,7 +1507,8 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	unsigned int addr_max;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, mptcp_pm_add_addr_nl_policy,
+				   false, &addr);
 	if (ret < 0)
 		return ret;
 
@@ -1680,7 +1700,8 @@ static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info *info)
 	void *reply;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, mptcp_pm_add_addr_nl_policy,
+				   false, &addr);
 	if (ret < 0)
 		return ret;
 
@@ -1926,12 +1947,15 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 	u8 bkup = 0;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, mptcp_pm_add_addr_nl_policy,
+				   false, &addr);
 	if (ret < 0)
 		return ret;
 
 	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &remote);
+		ret = mptcp_pm_parse_entry(attr_rem, info,
+					   mptcp_pm_add_addr_nl_policy, false,
+					   &remote);
 		if (ret < 0)
 			return ret;
 	}
@@ -2279,72 +2303,105 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 	nlmsg_free(skb);
 }
 
-static const struct genl_small_ops mptcp_pm_ops[] = {
+
+static const struct genl_ops mptcp_pm_ops[] = {
 	{
-		.cmd    = MPTCP_PM_CMD_ADD_ADDR,
-		.doit   = mptcp_nl_cmd_add_addr,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_ADD_ADDR,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_add_addr,
+		.policy		= mptcp_pm_endpoint_nl_policy,
+		.maxattr	= MPTCP_PM_ADDR_ATTR_IF_IDX,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_DEL_ADDR,
-		.doit   = mptcp_nl_cmd_del_addr,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_DEL_ADDR,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_del_addr,
+		.policy		= mptcp_pm_endpoint_nl_policy,
+		.maxattr	= MPTCP_PM_ADDR_ATTR_IF_IDX,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_FLUSH_ADDRS,
-		.doit   = mptcp_nl_cmd_flush_addrs,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_GET_ADDR,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_get_addr,
+		.dumpit		= mptcp_nl_cmd_dump_addrs,
+		.policy		= mptcp_pm_endpoint_nl_policy,
+		.maxattr	= MPTCP_PM_ADDR_ATTR_IF_IDX,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_GET_ADDR,
-		.doit   = mptcp_nl_cmd_get_addr,
-		.dumpit   = mptcp_nl_cmd_dump_addrs,
+		.cmd		= MPTCP_PM_CMD_FLUSH_ADDRS,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_flush_addrs,
+		.policy		= mptcp_pm_endpoint_nl_policy,
+		.maxattr	= MPTCP_PM_ADDR_ATTR_IF_IDX,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_SET_LIMITS,
-		.doit   = mptcp_nl_cmd_set_limits,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_SET_LIMITS,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_set_limits,
+		.policy		= mptcp_pm_set_limits_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_GET_LIMITS,
-		.doit   = mptcp_nl_cmd_get_limits,
+		.cmd		= MPTCP_PM_CMD_GET_LIMITS,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_get_limits,
+		.policy		= mptcp_pm_set_limits_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_SET_FLAGS,
-		.doit   = mptcp_nl_cmd_set_flags,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_SET_FLAGS,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_set_flags,
+		.policy		= mptcp_pm_endpoint_nl_policy,
+		.maxattr	= MPTCP_PM_ADDR_ATTR_IF_IDX,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_ANNOUNCE,
-		.doit   = mptcp_nl_cmd_announce,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_ANNOUNCE,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_announce,
+		.policy		= mptcp_pm_announce_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_TOKEN,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_REMOVE,
-		.doit   = mptcp_nl_cmd_remove,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_REMOVE,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_remove,
+		.policy		= mptcp_pm_remove_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_LOC_ID,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_SUBFLOW_CREATE,
-		.doit   = mptcp_nl_cmd_sf_create,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_SUBFLOW_CREATE,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_sf_create,
+		.policy		= mptcp_pm_subflow_create_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_SUBFLOW_DESTROY,
-		.doit   = mptcp_nl_cmd_sf_destroy,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_SUBFLOW_DESTROY,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_sf_destroy,
+		.policy		= mptcp_pm_subflow_create_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 };
 
 static struct genl_family mptcp_genl_family __ro_after_init = {
 	.name		= MPTCP_PM_NAME,
 	.version	= MPTCP_PM_VER,
-	.maxattr	= MPTCP_PM_ATTR_MAX,
-	.policy		= mptcp_pm_policy,
 	.netnsok	= true,
 	.module		= THIS_MODULE,
-	.small_ops	= mptcp_pm_ops,
-	.n_small_ops	= ARRAY_SIZE(mptcp_pm_ops),
+	.ops		= mptcp_pm_ops,
+	.n_ops		= ARRAY_SIZE(mptcp_pm_ops),
 	.resv_start_op	= MPTCP_PM_CMD_SUBFLOW_DESTROY + 1,
 	.mcgrps		= mptcp_pm_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(mptcp_pm_mcgrps),
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b5a8aa4c1ebd..2acef867dbbe 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -172,7 +172,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
+	err = mptcp_pm_parse_entry(addr, info, mptcp_pm_add_addr_nl_policy, true, &addr_val);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "error parsing local address");
 		goto announce_err;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e9ca30189731..d6b6b729e148 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -336,6 +336,8 @@ struct mptcp_sock {
 #define mptcp_for_each_subflow_safe(__msk, __subflow, __tmp)			\
 	list_for_each_entry_safe(__subflow, __tmp, &((__msk)->conn_list), node)
 
+extern const struct nla_policy mptcp_pm_add_addr_nl_policy[];
+
 static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 {
 	sock_owned_by_me((const struct sock *)msk);
@@ -800,7 +802,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk);
 int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 			struct mptcp_addr_info *addr);
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
-			 bool require_family,
+			 const struct nla_policy *nlap, bool require_family,
 			 struct mptcp_pm_addr_entry *entry);
 bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
-- 
2.40.1

