Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8003E18C04
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 10:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686564788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=usUMCNg8lkjBrApxwwjkrM8Hyu+HvifyeeeX2QCVego=;
	b=FLrOXR1nmAc45FKsdw9D10Vg9c4TZhy62/cVtUHG5JD3GeZg1oeyIbxr+2tVZS5w/ZM/ki
	PdaMH2vEk2HbpxSabRfEL/VcyFjg93qrYpCNIw6uIhwQW0hbsrhQOGts3T+JMmaSYfcx6y
	KqmKXaUTG79ZojYyzfM6CIez8lphlyM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-lIgScY41PeSQaIiz9wjl8w-1; Mon, 12 Jun 2023 06:13:07 -0400
X-MC-Unique: lIgScY41PeSQaIiz9wjl8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C09E3849523;
	Mon, 12 Jun 2023 10:13:06 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A9DC32026833;
	Mon, 12 Jun 2023 10:13:05 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3] mptcp: convert netlink from small_ops to ops
Date: Mon, 12 Jun 2023 12:13:01 +0200
Message-Id: <c840f47bde581fcf910f24df6d136293618ba1d6.1686564758.git.dcaratti@redhat.com>
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

this prepares MPTCP control plane to be described as YAML spec.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/mptcp/pm_netlink.c   | 259 +++++++++++++++++++++++++++++----------
 net/mptcp/pm_userspace.c |   2 +-
 net/mptcp/protocol.h     |   2 +-
 3 files changed, 193 insertions(+), 70 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ba1406e601e4..90d77e5fc8b1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -47,6 +47,103 @@ struct pm_nl_pernet {
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
+static const struct nla_policy *mptcp_nl_cmd2policy(int cmd);
+
+#define mptcp_pm_endpoint_nl_policy mptcp_pm_add_addr_nl_policy
+
+/* MPTCP_PM_CMD_ADD_ADDR - do */
+static const struct nla_policy mptcp_pm_add_addr_nl_policy[MPTCP_PM_ADDR_ATTR_IF_IDX + 1] = {
+	[MPTCP_PM_ADDR_ATTR_FAMILY] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_ADDR4] = { .type = NLA_U32, },
+	[MPTCP_PM_ADDR_ATTR_ADDR6] = { .len = 16, },
+	[MPTCP_PM_ADDR_ATTR_ID] = { .type = NLA_U8, },
+	[MPTCP_PM_ADDR_ATTR_PORT] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_IF_IDX] = { .type = NLA_S32, },
+	[MPTCP_PM_ADDR_ATTR_FLAGS] = { .type = NLA_U32, },
+};
+
+/* MPTCP_PM_CMD_DEL_ADDR - do */
+static const struct nla_policy mptcp_pm_del_addr_nl_policy[MPTCP_PM_ADDR_ATTR_IF_IDX + 1] = {
+	[MPTCP_PM_ADDR_ATTR_FAMILY] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_ADDR4] = { .type = NLA_U32, },
+	[MPTCP_PM_ADDR_ATTR_ADDR6] = { .len = 16, },
+	[MPTCP_PM_ADDR_ATTR_ID] = { .type = NLA_U8, },
+	[MPTCP_PM_ADDR_ATTR_PORT] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_IF_IDX] = { .type = NLA_S32, },
+	[MPTCP_PM_ADDR_ATTR_FLAGS] = { .type = NLA_U32, },
+};
+
+/* MPTCP_PM_CMD_GET_ADDR - do */
+static const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ADDR_ATTR_IF_IDX + 1] = {
+	[MPTCP_PM_ADDR_ATTR_FAMILY] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_ADDR4] = { .type = NLA_U32, },
+	[MPTCP_PM_ADDR_ATTR_ADDR6] = { .len = 16, },
+	[MPTCP_PM_ADDR_ATTR_ID] = { .type = NLA_U8, },
+	[MPTCP_PM_ADDR_ATTR_PORT] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_IF_IDX] = { .type = NLA_S32, },
+	[MPTCP_PM_ADDR_ATTR_FLAGS] = { .type = NLA_U32, },
+};
+
+/* MPTCP_PM_CMD_FLUSH_ADDRS - do */
+static const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ADDR_ATTR_IF_IDX + 1] = {
+	[MPTCP_PM_ADDR_ATTR_FAMILY] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_ADDR4] = { .type = NLA_U32, },
+	[MPTCP_PM_ADDR_ATTR_ADDR6] = { .len = 16, },
+	[MPTCP_PM_ADDR_ATTR_ID] = { .type = NLA_U8, },
+	[MPTCP_PM_ADDR_ATTR_PORT] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_IF_IDX] = { .type = NLA_S32, },
+	[MPTCP_PM_ADDR_ATTR_FLAGS] = { .type = NLA_U32, },
+};
+
+/* MPTCP_PM_CMD_SET_LIMITS - do */
+static const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
+	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+};
+
+/* MPTCP_PM_CMD_GET_LIMITS - do */
+static const struct nla_policy mptcp_pm_get_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
+	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+};
+
+/* MPTCP_PM_CMD_SET_FLAGS - do */
+static const struct nla_policy mptcp_pm_set_flags_nl_policy[MPTCP_PM_ADDR_ATTR_IF_IDX + 1] = {
+	[MPTCP_PM_ADDR_ATTR_FAMILY] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_ADDR4] = { .type = NLA_U32, },
+	[MPTCP_PM_ADDR_ATTR_ADDR6] = { .len = 16, },
+	[MPTCP_PM_ADDR_ATTR_ID] = { .type = NLA_U8, },
+	[MPTCP_PM_ADDR_ATTR_PORT] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_IF_IDX] = { .type = NLA_S32, },
+	[MPTCP_PM_ADDR_ATTR_FLAGS] = { .type = NLA_U32, },
+};
+
+/* MPTCP_PM_CMD_ANNOUNCE - do */
+static const struct nla_policy mptcp_pm_announce_nl_policy[MPTCP_PM_ATTR_TOKEN + 1] = {
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_endpoint_nl_policy),
+};
+
+/* MPTCP_PM_CMD_REMOVE - do */
+static const struct nla_policy mptcp_pm_remove_nl_policy[MPTCP_PM_ATTR_LOC_ID + 1] = {
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_LOC_ID] = { .type = NLA_U8, },
+};
+
+/* MPTCP_PM_CMD_SUBFLOW_CREATE - do */
+static const struct nla_policy mptcp_pm_subflow_create_nl_policy[MPTCP_PM_ATTR_ADDR_REMOTE + 1] = {
+	[MPTCP_PM_ATTR_ADDR_REMOTE] = NLA_POLICY_NESTED(mptcp_pm_endpoint_nl_policy),
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_endpoint_nl_policy),
+};
+
+/* MPTCP_PM_CMD_SUBFLOW_DESTROY - do */
+static const struct nla_policy mptcp_pm_subflow_destroy_nl_policy[MPTCP_PM_ATTR_ADDR_REMOTE + 1] = {
+	[MPTCP_PM_ATTR_ADDR_REMOTE] = NLA_POLICY_NESTED(mptcp_pm_endpoint_nl_policy),
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_endpoint_nl_policy),
+};
+
 static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
 {
 	return net_generic(net, pm_nl_pernet_id);
@@ -1099,29 +1196,6 @@ static const struct genl_multicast_group mptcp_pm_mcgrps[] = {
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
@@ -1171,6 +1245,7 @@ static int mptcp_pm_family_to_addr(int family)
 static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 				       const struct nlattr *attr,
 				       struct genl_info *info,
+				       const struct nla_policy *nla_policy,
 				       struct mptcp_addr_info *addr,
 				       bool require_family)
 {
@@ -1183,7 +1258,8 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 
 	/* no validation needed - was already done via nested policy */
 	err = nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
-					  mptcp_pm_addr_policy, info->extack);
+					  nla_policy,
+					  info->extack);
 	if (err)
 		return err;
 
@@ -1236,19 +1312,22 @@ int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 
 	memset(addr, 0, sizeof(*addr));
 
-	return mptcp_pm_parse_pm_addr_attr(tb, attr, info, addr, true);
+	return mptcp_pm_parse_pm_addr_attr(tb, attr, info, mptcp_pm_endpoint_nl_policy, addr, true);
 }
 
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
-			 bool require_family,
+			 int cmd, bool require_family,
 			 struct mptcp_pm_addr_entry *entry)
 {
 	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
+	const struct nla_policy *nla_policy = mptcp_nl_cmd2policy(cmd);
 	int err;
 
 	memset(entry, 0, sizeof(*entry));
 
-	err = mptcp_pm_parse_pm_addr_attr(tb, attr, info, &entry->addr, require_family);
+	err = mptcp_pm_parse_pm_addr_attr(tb, attr, info,
+					  nla_policy,
+					  &entry->addr, require_family);
 	if (err)
 		return err;
 
@@ -1305,7 +1384,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry addr, *entry;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, true, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, MPTCP_PM_CMD_ADD_ADDR, true, &addr);
 	if (ret < 0)
 		return ret;
 
@@ -1487,7 +1566,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	unsigned int addr_max;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, MPTCP_PM_CMD_DEL_ADDR, false, &addr);
 	if (ret < 0)
 		return ret;
 
@@ -1679,7 +1758,7 @@ static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info *info)
 	void *reply;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, MPTCP_PM_CMD_GET_ADDR, false, &addr);
 	if (ret < 0)
 		return ret;
 
@@ -1925,12 +2004,12 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 	u8 bkup = 0;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, MPTCP_PM_CMD_SET_FLAGS, false, &addr);
 	if (ret < 0)
 		return ret;
 
 	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &remote);
+		ret = mptcp_pm_parse_entry(attr_rem, info, MPTCP_PM_CMD_SET_FLAGS, false, &remote);
 		if (ret < 0)
 			return ret;
 	}
@@ -2278,72 +2357,116 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
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
+		.policy		= mptcp_pm_add_addr_nl_policy,
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
+		.policy		= mptcp_pm_del_addr_nl_policy,
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
+		.policy		= mptcp_pm_get_addr_nl_policy,
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
+		.policy		= mptcp_pm_flush_addrs_nl_policy,
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
+		.policy		= mptcp_pm_get_limits_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_SET_FLAGS,
-		.doit   = mptcp_nl_cmd_set_flags,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_SET_FLAGS,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_set_flags,
+		.policy		= mptcp_pm_set_flags_nl_policy,
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
+		.policy		= mptcp_pm_subflow_destroy_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 };
 
+static const struct nla_policy *mptcp_nl_cmd2policy(int cmd)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mptcp_pm_ops); i++)
+		if (mptcp_pm_ops[i].cmd == cmd)
+			return mptcp_pm_ops[i].policy;
+	return NULL;
+}
+
 static struct genl_family mptcp_genl_family __ro_after_init = {
 	.name		= MPTCP_PM_NAME,
 	.version	= MPTCP_PM_VER,
 	.maxattr	= MPTCP_PM_ATTR_MAX,
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
index 47a883a16c11..7e30213eaaf1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -172,7 +172,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
+	err = mptcp_pm_parse_entry(addr, info, MPTCP_PM_CMD_ADD_ADDR, true, &addr_val);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "error parsing local address");
 		goto announce_err;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d2e59cf33f57..e45e4a9e73c8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -803,7 +803,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk);
 int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 			struct mptcp_addr_info *addr);
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
-			 bool require_family,
+			 int cmd, bool require_family,
 			 struct mptcp_pm_addr_entry *entry);
 bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
-- 
2.40.1

