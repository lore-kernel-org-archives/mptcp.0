Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A013B3B
	for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 19:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647457703; x=1678993703;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=xWghdOG84K88FnnOSSTKNkR8qzNCDGFCbZVW9EVprg0=;
  b=OyvpPxVcdKCnhz2e+K0IoDlhWrLh5mvbDwGDd6TEVPW8pQsb9nLhVTp6
   UPL6oAZAaLzjmGc9P9Acm93Hgorh/luXS4+6FGIUzzvXHLlFJN7w0dnhL
   78m+AsUqPS7rkjRDlwiBjBy3EkDG27K+9K1yMk/iBY+ItkB8xcDJs6V/W
   zim73eitcWvfwKs+zAyu0edHjmZ4VM1Yibei9DwA1CXBvcJvOKcau2vw8
   Vpdw3civ2dYCjSrzocWzRJ4zk57yhiCDbC9/nIS46kupjBewbI0x9Kqpj
   FoIepizMIusx6kJjd8UPhWPxMRC52i5KT375ygTFe0gmAqllCWmN6hS+k
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256880344"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256880344"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:08:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="557595367"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:08:18 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 07/14] mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
Date: Wed, 16 Mar 2022 15:08:06 -0400
Message-Id: <20220316190813.634423-8-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220316190813.634423-1-kishen.maloor@intel.com>
References: <20220316190813.634423-1-kishen.maloor@intel.com>
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
 include/uapi/linux/mptcp.h |  2 ++
 net/mptcp/pm_netlink.c     | 63 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

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
index 90261830cc50..c21551d4fee6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1182,6 +1182,7 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
 	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
 	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
+	[MPTCP_PM_ATTR_LOC_ID]		= { .type	= NLA_U8,	},
 };
 
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
@@ -2204,6 +2205,63 @@ void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint8_t id)
 	kfree_skb(skb);
 }
 
+static int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
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
+	list_for_each_entry(entry, &msk->local_addr_list, list) {
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
+
 void mptcp_event_addr_announced(const struct sock *ssk,
 				const struct mptcp_addr_info *info)
 {
@@ -2356,6 +2414,11 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
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
-- 
2.31.1

