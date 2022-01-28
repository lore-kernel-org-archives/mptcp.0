Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4343FCE
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330329; x=1674866329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zZ6+wJj7H7mfapWJABoH0drm3QdC+cEV5371LYb4HsU=;
  b=HFXt4Ei36qGSquKGyZ0NtXfvOIF/EUFIYEoASkrqZ2nKQHDcIrc2lLGQ
   mKPTnMFnBzmFvjZ6WkVSQNPmjzBAEixEG7C0YjxKq7q8riF3la/0dwR/u
   etvyn9haPwXx5mvWFedgslLQumCuBWbJ+s9okjwaS0uRXlJJorOXqvSZc
   68y28dz+zx5IH5n26jcj15Dps0hQ2MqPhqrCFSxMpquWHnkA1ag3EUMUA
   M23iVI+1HQ3tR5qIwYoPhDpO5az71EQijWSccCaxPsHgebXsRJ1sjxtwA
   sWvNRz75wczN0tJBExV7epsSHq9XLXhQl18zwsCWuh3z3LGQYpIL1rbkn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="333358345"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="333358345"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="480527139"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:41 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v3 10/14] mptcp: netlink: allow userspace-driven subflow establishment
Date: Thu, 27 Jan 2022 19:38:32 -0500
Message-Id: <20220128003836.2732694-11-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220128003836.2732694-1-kishen.maloor@intel.com>
References: <20220128003836.2732694-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

This allows userspace to tell kernel to add a new subflow to an existing
mptcp connection.

Userspace provides the token to identify the mptcp-level connection
that needs a change in active subflows and the local and remote
addresses of the new or the to-be-removed subflow.

MPTCP_PM_CMD_SUBFLOW_CREATE requires the following parameters:
{ token, { loc_id, family, loc_addr4 | loc_addr6 }, { family, rem_addr4 |
rem_addr6, rem_port }

MPTCP_PM_CMD_SUBFLOW_DESTROY requires the following parameters:
{ token, { family, loc_addr4 | loc_addr6, loc_port }, { family, rem_addr4 |
rem_addr6, rem_port }

Signed-off-by: Florian Westphal <fw@strlen.de>
Co-developed-by: Kishen Maloor <kishen.maloor@intel.com>
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v2: fix build error when IPv6 is not enabled
---
 include/uapi/linux/mptcp.h |   3 +
 net/mptcp/pm_netlink.c     | 201 +++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index c2d7d3cefd02..b0b1cc7cddbe 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -57,6 +57,7 @@ enum {
 	MPTCP_PM_ATTR_SUBFLOWS,				/* u32 */
 	MPTCP_PM_ATTR_TOKEN,				/* u32 */
 	MPTCP_PM_ATTR_LOC_ID,				/* u8 */
+	MPTCP_PM_ATTR_ADDR_REMOTE,			/* nested address */
 
 	__MPTCP_PM_ATTR_MAX
 };
@@ -97,6 +98,8 @@ enum {
 	MPTCP_PM_CMD_SET_FLAGS,
 	MPTCP_PM_CMD_ANNOUNCE,
 	MPTCP_PM_CMD_REMOVE,
+	MPTCP_PM_CMD_SUBFLOW_CREATE,
+	MPTCP_PM_CMD_SUBFLOW_DESTROY,
 
 	__MPTCP_PM_CMD_AFTER_LAST
 };
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f2130374c5fc..056534761036 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1314,6 +1314,8 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
 	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
 	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
 	[MPTCP_PM_ATTR_LOC_ID]		= { .type	= NLA_U8,	},
+	[MPTCP_PM_ATTR_ADDR_REMOTE]	=
+					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
 };
 
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
@@ -1423,6 +1425,16 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 	return err;
 }
 
+static int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
+			       struct mptcp_addr_info *addr)
+{
+	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
+
+	memset(addr, 0, sizeof(*addr));
+
+	return mptcp_pm_parse_pm_addr_attr(tb, attr, info, addr, true);
+}
+
 static int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 				bool require_family,
 				struct mptcp_pm_addr_entry *entry)
@@ -2552,6 +2564,185 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 	kfree_skb(skb);
 }
 
+static int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
+	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_addr_info addr_r;
+	struct mptcp_addr_info addr_l;
+	struct mptcp_sock *msk;
+	struct sock *sk;
+	u32 token_val;
+	int ret;
+
+	if (!laddr || !raddr || !token) {
+		GENL_SET_ERR_MSG(info, "missing required inputs");
+		return -EINVAL;
+	}
+
+	token_val = nla_get_u32(token);
+
+	msk = mptcp_token_get_sock(genl_info_net(info), token_val);
+	if (!msk) {
+		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+		return -EINVAL;
+	}
+
+	if (READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_USERSPACE) {
+		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		return -EINVAL;
+	}
+
+	ret = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	if (ret < 0) {
+		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
+		return -EINVAL;
+	}
+
+	if (addr_l.id == 0) {
+		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "missing local addr id");
+		return -EINVAL;
+	}
+
+	ret = mptcp_pm_parse_addr(raddr, info, &addr_r);
+	if (ret < 0) {
+		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
+		return -EINVAL;
+	}
+
+	sk = &msk->sk.icsk_inet.sk;
+	lock_sock(sk);
+
+	ret = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
+
+	release_sock(sk);
+
+	return ret;
+}
+
+static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
+				      const struct mptcp_addr_info *local,
+				      const struct mptcp_addr_info *remote)
+{
+	struct sock *sk = &msk->sk.icsk_inet.sk;
+	struct mptcp_subflow_context *subflow;
+	struct sock *found = NULL;
+
+	if (local->family != remote->family)
+		return NULL;
+
+	lock_sock(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		const struct ipv6_pinfo *pinfo;
+		const struct inet_sock *issk;
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (local->family != ssk->sk_family)
+			continue;
+
+		issk = inet_sk(ssk);
+
+		switch (ssk->sk_family) {
+		case AF_INET:
+			if (issk->inet_saddr != local->addr.s_addr ||
+			    issk->inet_daddr != remote->addr.s_addr)
+				continue;
+			break;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		case AF_INET6:
+			pinfo = inet6_sk(ssk);
+			if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
+			    !ipv6_addr_equal(&remote->addr6, &ssk->sk_v6_daddr))
+				continue;
+			break;
+#endif
+		default:
+			continue;
+		}
+
+		if (issk->inet_sport == local->port &&
+		    issk->inet_dport == remote->port) {
+			found = ssk;
+			goto found;
+		}
+	}
+
+found:
+	release_sock(sk);
+
+	return found;
+}
+
+static int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
+	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_addr_info addr_l;
+	struct mptcp_addr_info addr_r;
+	struct mptcp_sock *msk;
+	struct sock *sk, *ssk;
+	u32 token_val;
+	int ret;
+
+	if (!laddr || !raddr || !token) {
+		GENL_SET_ERR_MSG(info, "missing required inputs");
+		return -EINVAL;
+	}
+
+	token_val = nla_get_u32(token);
+
+	msk = mptcp_token_get_sock(genl_info_net(info), token_val);
+	if (!msk) {
+		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+		return -EINVAL;
+	}
+
+	if (READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_USERSPACE) {
+		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		return -EINVAL;
+	}
+
+	ret = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	if (ret < 0) {
+		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
+		return ret;
+	}
+
+	ret = mptcp_pm_parse_addr(raddr, info, &addr_r);
+	if (ret < 0) {
+		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
+		return ret;
+	}
+
+	if (addr_l.family != addr_r.family) {
+		GENL_SET_ERR_MSG(info, "address families do not match");
+		return -EINVAL;
+	}
+
+	if (!addr_l.port || !addr_r.port) {
+		GENL_SET_ERR_MSG(info, "missing local or remote port");
+		return -EINVAL;
+	}
+
+	sk = &msk->sk.icsk_inet.sk;
+	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
+	if (ssk) {
+		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+
+		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
+		mptcp_close_ssk(sk, ssk, subflow);
+	} else {
+		ret = -ESRCH;
+	}
+
+	return ret;
+}
+
 static const struct genl_small_ops mptcp_pm_ops[] = {
 	{
 		.cmd    = MPTCP_PM_CMD_ADD_ADDR,
@@ -2597,6 +2788,16 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
 		.doit   = mptcp_nl_cmd_remove,
 		.flags  = GENL_ADMIN_PERM,
 	},
+	{
+		.cmd    = MPTCP_PM_CMD_SUBFLOW_CREATE,
+		.doit   = mptcp_nl_cmd_sf_create,
+		.flags  = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd    = MPTCP_PM_CMD_SUBFLOW_DESTROY,
+		.doit   = mptcp_nl_cmd_sf_destroy,
+		.flags  = GENL_ADMIN_PERM,
+	},
 };
 
 static struct genl_family mptcp_genl_family __ro_after_init = {
-- 
2.31.1

