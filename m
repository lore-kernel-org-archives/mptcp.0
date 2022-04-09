Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933E652
	for <mptcp@lists.linux.dev>; Sat,  9 Apr 2022 01:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649468323; x=1681004323;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=7C5KAhVtcu+VPueF2/d4JZakThKNv51AxsFa/zNUUzA=;
  b=j8N0hsKIYYjLD9ClLTS/wZqU8hR4UOLsKLL4+Es2YOOwzwLEuwW7FGAk
   PvKxciMJhs3GaTLLBXPKnT4Q54HpMc8XPydkXlpRRsGoA8EMcp8wZxiAy
   g2diTNwPfvKuq4Qv5LZgiWT+Y0+s/jwNoAuEnWIhfjXwFfjYxO9r4cmVs
   O9xlo3GnE71RaKqMVgp+fHl6wVp0EEasTp7YN07/4vn4MKJjG85vFUqek
   qVqP3XaOhzgNW1Cvi02jhRxxoW0TSlnZfMHd+h/Q3lp/w2aCSx+nesbia
   uDeSGkRee13qgUkYEXFXHzC+rcCDC2mW0BGjbPWSL+xSDBmspqGo1ixAq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="261921150"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="261921150"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 18:38:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="698436088"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 18:38:30 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 07/14] mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
Date: Fri,  8 Apr 2022 21:38:18 -0400
Message-Id: <20220409013825.1877395-8-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220409013825.1877395-1-kishen.maloor@intel.com>
References: <20220409013825.1877395-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change adds a MPTCP netlink command for issuing a
REMOVE_ADDR signal for an address over the chosen MPTCP
connection from a userspace path manager.

The command requires the following parameters: {token, loc_id}.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v6:
-Make mptcp_pm_remove_addrs_and_subflows() non-static.
-Move mptcp_nl_cmd_remove() into pm_userspace.c.
---
 include/uapi/linux/mptcp.h |  2 ++
 net/mptcp/pm_netlink.c     | 10 +++++--
 net/mptcp/pm_userspace.c   | 57 ++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h       |  4 +++
 4 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index ac66c1263f02..11f9fa001a3c 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -56,6 +56,7 @@ enum {
 	MPTCP_PM_ATTR_RCV_ADD_ADDRS,			/* u32 */
 	MPTCP_PM_ATTR_SUBFLOWS,				/* u32 */
 	MPTCP_PM_ATTR_TOKEN,				/* u32 */
+	MPTCP_PM_ATTR_LOC_ID,				/* u8 */
 
 	__MPTCP_PM_ATTR_MAX
 };
@@ -95,6 +96,7 @@ enum {
 	MPTCP_PM_CMD_GET_LIMITS,
 	MPTCP_PM_CMD_SET_FLAGS,
 	MPTCP_PM_CMD_ANNOUNCE,
+	MPTCP_PM_CMD_REMOVE,
 
 	__MPTCP_PM_CMD_AFTER_LAST
 };
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index dbe5ccd95ac5..a26750f19f65 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1095,6 +1095,7 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
 	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
 	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
+	[MPTCP_PM_ATTR_LOC_ID]		= { .type	= NLA_U8,	},
 };
 
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
@@ -1504,8 +1505,8 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					       struct list_head *rm_list)
+void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
+					struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
 	struct mptcp_pm_addr_entry *entry;
@@ -2204,6 +2205,11 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
 		.doit   = mptcp_nl_cmd_announce,
 		.flags  = GENL_ADMIN_PERM,
 	},
+	{
+		.cmd    = MPTCP_PM_CMD_REMOVE,
+		.doit   = mptcp_nl_cmd_remove,
+		.flags  = GENL_ADMIN_PERM,
+	},
 };
 
 static struct genl_family mptcp_genl_family __ro_after_init = {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 86d1c83a3f9f..b388c095e73d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -177,3 +177,60 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 
 	return 0;
 }
+
+int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
+	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_sock *msk;
+	LIST_HEAD(free_list);
+	u32 token_val;
+	u8 id_val;
+
+	if (!id || !token) {
+		GENL_SET_ERR_MSG(info, "missing required inputs");
+		return -EINVAL;
+	}
+
+	id_val = nla_get_u8(id);
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
+	lock_sock((struct sock *)msk);
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id == id_val) {
+			match = entry;
+			break;
+		}
+	}
+
+	if (!match) {
+		GENL_SET_ERR_MSG(info, "address with specified id not found");
+		release_sock((struct sock *)msk);
+		return -EINVAL;
+	}
+
+	list_move(&match->list, &free_list);
+
+	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+
+	release_sock((struct sock *)msk);
+
+	list_for_each_entry_safe(match, entry, &free_list, list) {
+		sock_kfree_s((struct sock *)msk, match, sizeof(*match));
+	}
+	return 0;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2abf98e66074..bf499ca81445 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -803,10 +803,14 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
+void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
+					struct list_head *rm_list);
+
 int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 					     struct mptcp_pm_addr_entry *entry);
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info);
+int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.31.1

