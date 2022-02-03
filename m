Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910B02CA1
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 03:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643858052; x=1675394052;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=VStxquV6zMaX54HG9zynuf0cuP+D8wfM/I4lygM+qH4=;
  b=L6fedDr9vISrmMeK+CdjIwQPv2TJGYA8VYOm9X+j/MQimS9FqsLm318c
   ezy6Q4tyAsMzqR7YTRg+MSbGZDEUx506ruqkKdMda9OH6lv+VB5+dAbQO
   AK4VpdTmDjnGLV1dNVMoDcRhOQgzlxN/j8Shfs9Vy3VccBponQv9qX9fu
   2DO2xt9kRxxnEvCgtbOXvK0xnMrBJGahjULKfxWFyOJ0w+Jfs8Z9owovV
   HdwRIm/3yh4WisgAkhMgEQlKPSjkXiC7/mm+aAewj2CFsdQOg5kpU7Sr2
   woA+5615tZMZ3GNiMhgLuPrqGSI69EVGKAkOKHeuCkEUjGWcySzwPm5Np
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="235467499"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="235467499"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:14:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="631204629"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:14:09 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 05/13] mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
Date: Wed,  2 Feb 2022 22:13:55 -0500
Message-Id: <20220203031403.2996549-6-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220203031403.2996549-1-kishen.maloor@intel.com>
References: <20220203031403.2996549-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change adds a MPTCP netlink interface for issuing
ADD_ADDR advertisements over the chosen MPTCP connection from a
userspace path manager.

The command requires the following parameters:
{ token, { loc_id, family, daddr4 | daddr6 [, dport] } [, if_idx],
flags[signal|skiplsk] }.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v3: use MPTCP_PM_ADDR_FLAG_NO_LISTEN to skip creating a listening socket
in the kernel for an announced address, use the new helper
lsk_list_find_or_create()
v4: call lsk_list_find() after a failed lsk_list_find_or_create()
for a chance to retrieve a recently created lsk by a simultaneous
call
---
 include/uapi/linux/mptcp.h |   2 +
 net/mptcp/pm_netlink.c     | 104 +++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 0df44a116a31..088bdfbf442c 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -55,6 +55,7 @@ enum {
 	MPTCP_PM_ATTR_ADDR,				/* nested address */
 	MPTCP_PM_ATTR_RCV_ADD_ADDRS,			/* u32 */
 	MPTCP_PM_ATTR_SUBFLOWS,				/* u32 */
+	MPTCP_PM_ATTR_TOKEN,				/* u32 */
 
 	__MPTCP_PM_ATTR_MAX
 };
@@ -93,6 +94,7 @@ enum {
 	MPTCP_PM_CMD_SET_LIMITS,
 	MPTCP_PM_CMD_GET_LIMITS,
 	MPTCP_PM_CMD_SET_FLAGS,
+	MPTCP_PM_CMD_ANNOUNCE,
 
 	__MPTCP_PM_CMD_AFTER_LAST
 };
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4430e4ef8058..b2de0da026b2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1302,6 +1302,7 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
 					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
 	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
+	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
 };
 
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
@@ -2065,6 +2066,104 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
+static int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	struct mptcp_local_lsk *lsk_ref = NULL;
+	struct mptcp_pm_addr_entry addr_val;
+	bool reuse_port = false;
+	struct mptcp_sock *msk;
+	u32 token_val;
+	int err;
+
+	if (!addr || !token) {
+		GENL_SET_ERR_MSG(info, "missing required inputs");
+		return -EINVAL;
+	}
+
+	token_val = nla_get_u32(token);
+
+	msk = mptcp_token_get_sock(sock_net(skb->sk), token_val);
+	if (!msk) {
+		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+		return -EINVAL;
+	}
+
+	if (!mptcp_pm_is_userspace(msk)) {
+		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		return -EINVAL;
+	}
+
+	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
+	if (err < 0) {
+		GENL_SET_ERR_MSG(info, "error parsing local address");
+		return err;
+	}
+
+	if (addr_val.addr.id == 0 || !(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		GENL_SET_ERR_MSG(info, "invalid addr id or flags");
+		return -EINVAL;
+	}
+
+	if (!(addr_val.flags & MPTCP_PM_ADDR_FLAG_NO_LISTEN)) {
+		if (!addr_val.addr.port) {
+			addr_val.addr.port =
+				((struct inet_sock *)inet_sk
+				 ((struct sock *)msk))->inet_sport;
+
+			reuse_port = true;
+		}
+
+		lsk_ref = lsk_list_find_or_create(sock_net(skb->sk), pernet, &addr_val, &err);
+
+		if (!lsk_ref)
+			lsk_ref = lsk_list_find(pernet, &addr_val.addr);
+
+		if ((!lsk_ref && !reuse_port) || (!lsk_ref && (err != -EADDRINUSE) && reuse_port)) {
+			GENL_SET_ERR_MSG(info, "error creating listen socket");
+			err = (err == 0) ? -ENOMEM : err;
+			return err;
+		}
+
+		if (!reuse_port) {
+			addr_val.lsk_ref = lsk_ref;
+			lsk_ref = NULL;
+		} else {
+			addr_val.addr.port = 0;
+		}
+	}
+
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
+	if (err < 0) {
+		if (addr_val.lsk_ref)
+			lsk_list_release(pernet, addr_val.lsk_ref);
+		else if (lsk_ref)
+			lsk_list_release(pernet, lsk_ref);
+		GENL_SET_ERR_MSG(info, "did not match address and id");
+		return err;
+	}
+
+	lock_sock((struct sock *)msk);
+	spin_lock_bh(&msk->pm.lock);
+
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val, lsk_ref)) {
+		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
+		mptcp_pm_nl_addr_send_ack(msk);
+	}
+
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock((struct sock *)msk);
+
+	if (addr_val.lsk_ref)
+		lsk_list_release(pernet, addr_val.lsk_ref);
+	else if (lsk_ref)
+		lsk_list_release(pernet, lsk_ref);
+
+	return 0;
+}
+
 static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, }, *entry;
@@ -2419,6 +2518,11 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
 		.doit   = mptcp_nl_cmd_set_flags,
 		.flags  = GENL_ADMIN_PERM,
 	},
+	{
+		.cmd    = MPTCP_PM_CMD_ANNOUNCE,
+		.doit   = mptcp_nl_cmd_announce,
+		.flags  = GENL_ADMIN_PERM,
+	},
 };
 
 static struct genl_family mptcp_genl_family __ro_after_init = {
-- 
2.31.1

