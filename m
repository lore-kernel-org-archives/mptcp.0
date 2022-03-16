Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D443D75
	for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 23:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647472607; x=1679008607;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Jh75afoUQCx7xbfDS/OJhrVyFt5z+gVeuWycK/MjvKM=;
  b=j4or4dqSIXxcwLin1F/1a5QfvBbkDQGaaisS2hvYxbp7rHXz0A8iRq09
   HXV2E9yLMFORBxYme7ZnRlnLU8fyNSxKiUBvFdEQdc3REpNaAjvy30lkC
   cENYNahhGX4PUE3xiG35RjAmzxS4FtbXxr64dhoxn/Ys9wd91Web7i194
   U9cA5hhm7v36LAjXDVs84rt2HBpj3wDDhyKq7LzoQYgeb4p3h1nT5hARe
   NDGP0Emwoy81KJC0wWyyVIJXHb2ejdJQvquVsIwGd5sA66PYdgjV5+EjQ
   GEnRFbupDm6YHnMtQKZlhEgnpte9gXGKmz1I3f9oR9+0AUdgoId93V+dW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317453509"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="317453509"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:16:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="613813307"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:16:42 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 05/14] mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
Date: Wed, 16 Mar 2022 19:16:27 -0400
Message-Id: <20220316231636.645625-6-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220316231636.645625-1-kishen.maloor@intel.com>
References: <20220316231636.645625-1-kishen.maloor@intel.com>
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
flags[signal] }.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 include/uapi/linux/mptcp.h |  2 ++
 net/mptcp/pm_netlink.c     | 64 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index e41ea01a94bb..ac66c1263f02 100644
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
index aa1a9ae6b530..2b1d8b3b7891 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1178,6 +1178,7 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
 					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
 	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
+	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
 };
 
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
@@ -1930,6 +1931,64 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
+static int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_pm_addr_entry addr_val;
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
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
+	if (err < 0) {
+		GENL_SET_ERR_MSG(info, "did not match address and id");
+		return err;
+	}
+
+	lock_sock((struct sock *)msk);
+	spin_lock_bh(&msk->pm.lock);
+
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
+		mptcp_pm_nl_addr_send_ack(msk);
+	}
+
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock((struct sock *)msk);
+
+	return 0;
+}
+
 static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, }, *entry;
@@ -2289,6 +2348,11 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
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

