Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BFE18021
	for <mptcp@lists.linux.dev>; Fri,  6 Oct 2023 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyWTg5G/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA51EC433C9;
	Fri,  6 Oct 2023 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696603646;
	bh=yM7KjXTObWwFAt0kkYCB/fRJosZ7h5UaoJgfYR7hptI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QyWTg5G/lkEDV5cI7P9tAbViWXJID91JUbE3FzUcp5ZyOYQbB7cpJDq8bocblrmrk
	 E9ehEy1wRUmBFGdiUZcfzLhCAC2H84TF/ZQnRC8zBHYeVF4ZjH0JbZ7nIK/9jds/gf
	 bIoQz1C7yZXGnutueP02rS1rzH6GQsF/+VUEze2gRcdLGP66RaT60mElTSYz3JX4Z6
	 FQSrEkvJrEbsNrUcpP7ZifmB0XjcxCdqZyMw/9yTefVxXZBYlTD1NLmDoNLmI/5fsu
	 v8JFOrZljy07/RKInfbZGbljjjsIT6ZKAYRC1FET/BJw/DeMobsGqKlV3YDD05m3VP
	 1iFTQsWjt/BQA==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Fri, 06 Oct 2023 16:46:37 +0200
Subject: [PATCH net-next 2/6] net: mptcp: convert netlink from small_ops to
 ops
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231006-upstream-net-next-20231006-mptcp-ynl-v1-2-0a97f2f5410e@kernel.org>
References: <20231006-upstream-net-next-20231006-mptcp-ynl-v1-0-0a97f2f5410e@kernel.org>
In-Reply-To: <20231006-upstream-net-next-20231006-mptcp-ynl-v1-0-0a97f2f5410e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11837; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xJIQUgvyWS794R7SPkEw/jyO1hGLyVubPRydeRZdkVw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlIB35FPucH48cE04RdUgeHSGF70aksfAmNVcIX
 a/hF6sRdEaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZSAd+QAKCRD2t4JPQmmg
 c8oPEADSBqqsh3agW6ZsWxckHU2HAdhGY5Iv7ANnUwpCM5MnhTcNmYb23vW8Fy+D5bEV0bvblO5
 lUpPA/vbtWKDF3GKEmbsyRx2nxwugIzAQbL1+aA8b18MC7dYDOGYNHZKhxf9VcSWW0k4aWjAMqK
 EEKPw7488qucuv2/25N3OvgPGrFC83PyHpi8ER57j+jpZHRDI1J35goRqGFyElvv4aQxy5O2VcE
 1AFKxQRPoBjtOyct28ohd8uHMQY95efHtKofFwMJ/97eiIZeMcE/bqWmozDhrSfb2RSjgcMJ8gr
 Sf7nnVwehARx6j/p1aQe77Lgz+qPF6BLkC+UobgEgirbZpBRS8UtMsYe74aOmRGOJ1Ryz4aRFzR
 eJW9BLGzK5DGIsenAEB56bpRkxyc/GakreNmYHJiHkRq116lSV3X3sIvWNAYJp2ndkR4GY0oC/l
 mQvLuOgf587cGqEhNT9bdWO/EW6/nfeo92VTM7D2+kpt724wk8TMwKZIFDOiqhABy2+npQ2pcRZ
 4aB8Gi+Yta2cFjhRafZ2qkQv1SfeIBV5hV5t4eoBwDF0NzrnE6Najqpf4dUffzxoG63GfQXS4vu
 WYvPnQIH3udNlZbctl9HSDI355m6Muh69BvufO42eH7b71DC5AAT2sZnSOPDHES2/sqJwgrz5tZ
 PM3bzCMQ2X7qayg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Davide Caratti <dcaratti@redhat.com>

in the current MPTCP control plane, all operations use a netlink
attribute of the same type "MPTCP_PM_ATTR". However, add/del/get/flush
operations only parse the first element in the message _ the one that
describes MPTCP endpoints (that was named MPTCP_PM_ATTR_ADDR and
mostly used in ADD_ADDR operations _ probably the similarity of "attr",
"addr" and "add" might cause some confusion to human readers).
Convert MPTCP from 'small_ops' to 'ops', thus allowing different attributes
for each single operation, hopefully makes all this clearer to human
readers.

- use a separate attribute set for add/del/get/flush address operation,
  binary compatible with the existing one, to store the endpoint address.
  MPTCP_PM_ENDPOINT_ADDR is added to the uAPI (with the same value as
  MPTCP_PM_ATTR_ADDR) for these operations.
- convert mptcp_pm_ops[] and add policy files accordingly.

this prepares MPTCP control plane to be described as YAML spec.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h |   8 ++
 net/mptcp/pm_netlink.c     | 191 ++++++++++++++++++++++++++++++---------------
 2 files changed, 135 insertions(+), 64 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index ee9c49f949a2..0e62937ab17c 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -65,6 +65,14 @@ enum {
 
 #define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
 
+enum {
+	MPTCP_PM_ENDPOINT_ADDR = 1,
+
+	__MPTCP_PM_ENDPOINT_MAX
+};
+
+#define MPTCP_PM_ENDPOINT_MAX (__MPTCP_PM_ENDPOINT_MAX - 1)
+
 enum {
 	MPTCP_PM_ADDR_ATTR_UNSPEC,
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9661f3812682..32976cf7c82b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -48,6 +48,60 @@ struct pm_nl_pernet {
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
+static
+const struct nla_policy mptcp_pm_address_nl_policy[MPTCP_PM_ADDR_ATTR_IF_IDX + 1] = {
+	[MPTCP_PM_ADDR_ATTR_FAMILY] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_ID] = { .type = NLA_U8, },
+	[MPTCP_PM_ADDR_ATTR_ADDR4] = { .type = NLA_U32, },
+	[MPTCP_PM_ADDR_ATTR_ADDR6] = { .len = 16, },
+	[MPTCP_PM_ADDR_ATTR_PORT] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_FLAGS] = { .type = NLA_U32, },
+	[MPTCP_PM_ADDR_ATTR_IF_IDX] = { .type = NLA_S32, },
+};
+
+/* MPTCP_PM_CMD_ADD_ADDR / DEL / GET / FLUSH - do */
+static
+const struct nla_policy mptcp_pm_endpoint_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1] = {
+	[MPTCP_PM_ENDPOINT_ADDR] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+};
+
+/* MPTCP_PM_CMD_SET_LIMITS - do */
+static
+const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
+	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+};
+
+/* MPTCP_PM_CMD_SET_FLAGS - do */
+static
+const struct nla_policy mptcp_pm_set_flags_nl_policy[MPTCP_PM_ATTR_ADDR_REMOTE + 1] = {
+	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_ADDR_REMOTE] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+};
+
+/* MPTCP_PM_CMD_ANNOUNCE - do */
+static
+const struct nla_policy mptcp_pm_announce_nl_policy[MPTCP_PM_ATTR_TOKEN + 1] = {
+	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+};
+
+/* MPTCP_PM_CMD_REMOVE - do */
+static
+const struct nla_policy mptcp_pm_remove_nl_policy[MPTCP_PM_ATTR_LOC_ID + 1] = {
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_LOC_ID] = { .type = NLA_U8, },
+};
+
+/* MPTCP_PM_CMD_SUBFLOW_CREATE / DESTROY - do */
+static
+const struct nla_policy mptcp_pm_subflow_create_nl_policy[MPTCP_PM_ATTR_ADDR_REMOTE + 1] = {
+	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_ADDR_REMOTE] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+};
+
 static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
 {
 	return net_generic(net, pm_nl_pernet_id);
@@ -1104,29 +1158,6 @@ static const struct genl_multicast_group mptcp_pm_mcgrps[] = {
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
@@ -1188,7 +1219,7 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 
 	/* no validation needed - was already done via nested policy */
 	err = nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
-					  mptcp_pm_addr_policy, info->extack);
+					  mptcp_pm_address_nl_policy, info->extack);
 	if (err)
 		return err;
 
@@ -1305,7 +1336,7 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
 
 static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
 	int ret;
@@ -1486,7 +1517,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 
 static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
 	unsigned int addr_max;
@@ -1677,7 +1708,7 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
 
 static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
 	struct sk_buff *msg;
@@ -2283,72 +2314,104 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 	nlmsg_free(skb);
 }
 
-static const struct genl_small_ops mptcp_pm_ops[] = {
+static const struct genl_ops mptcp_pm_ops[] = {
 	{
-		.cmd    = MPTCP_PM_CMD_ADD_ADDR,
-		.doit   = mptcp_nl_cmd_add_addr,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_ADD_ADDR,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_add_addr,
+		.policy		= mptcp_pm_endpoint_nl_policy,
+		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
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
+		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
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
+		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
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
+		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
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
+		.policy		= mptcp_pm_set_flags_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
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

-- 
2.40.1

