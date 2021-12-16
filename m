Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842EB3FFB
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 22:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639693461; x=1671229461;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0m9IZ8Sn61grdD31UBb+b0qJnn02HsmyoaV1kfpOkHU=;
  b=fhHrfm5OP1aBPkMAKgi9x0V2mUyIMGtY6QmVbNIreH1yMkBaH7nqDvi4
   AqhigRFjCkppsw5q0wDPxG0FEcmOar7FuuDCu4w0GUolA4dQ2gF3YhEu/
   PLDodtF7cAoIp41tlBlumlfuwnlRZ8+QRhlLyIXk1dnUYULT29KvBQVwu
   kCqKf24cE9Xalx+lJp5ZlcZpGsz8GxrmfymDh4uLEUWooM//Yxznxp8Sj
   uh7jnuL7Bo+xWI5pCDPBj9zbduamvQbh+0EzKUsgtwHN0ieKOTL5faCIZ
   PaKqrVR4lLTgNe6CHq+VJk/UY5QbFo/h+gzGAc/B3TI6SI8UAX1sWaZNb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="300393172"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="300393172"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="519461271"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 15/21] mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
Date: Thu, 16 Dec 2021 17:23:08 -0500
Message-Id: <20211216222314.1244708-16-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216222314.1244708-1-kishen.maloor@intel.com>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change adds a MPTCP netlink command for issuing
REMOVE_ADDR signals for a specific address over the chosen MPTCP
connection from a userspace path manager.

The command requires the following parameters: {token, loc_id}.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 include/uapi/linux/mptcp.h |  2 ++
 net/mptcp/pm_netlink.c     | 67 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 40380be396c8..ec63f9382dbe 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -56,6 +56,7 @@ enum {
 	MPTCP_PM_ATTR_RCV_ADD_ADDRS,			/* u32 */
 	MPTCP_PM_ATTR_SUBFLOWS,				/* u32 */
 	MPTCP_PM_ATTR_TOKEN,				/* u32 */
+	MPTCP_PM_ATTR_LOC_ID,				/* u8 */
 
 	__MPTCP_PM_ATTR_MAX
 };
@@ -94,6 +95,7 @@ enum {
 	MPTCP_PM_CMD_GET_LIMITS,
 	MPTCP_PM_CMD_SET_FLAGS,
 	MPTCP_PM_CMD_ANNOUNCE,
+	MPTCP_PM_CMD_REMOVE,
 
 	__MPTCP_PM_CMD_AFTER_LAST
 };
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2e9ca5730b10..66462ac706f2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1269,6 +1269,7 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
 	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
 	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
+	[MPTCP_PM_ATTR_LOC_ID]		= { .type	= NLA_U8,	},
 };
 
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
@@ -1719,6 +1720,7 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 		    slist.nr < MPTCP_RM_IDS_MAX) {
 			alist.ids[alist.nr++] = entry->addr.id;
 			slist.ids[slist.nr++] = entry->addr.id;
+			remove_anno_list_by_saddr(msk, &entry->addr);
 		} else if (remove_anno_list_by_saddr(msk, &entry->addr) &&
 			 alist.nr < MPTCP_RM_IDS_MAX) {
 			alist.ids[alist.nr++] = entry->addr.id;
@@ -2330,6 +2332,66 @@ void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint8_t id)
 	kfree_skb(skb);
 }
 
+static int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
+	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
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
+	if (READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_USERSPACE) {
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
+		if (match->lsk_ref)
+			lsk_list_release(pernet, match->lsk_ref);
+		kfree(match);
+	}
+	return 0;
+}
+
 void mptcp_event_addr_announced(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *info,
 				const struct sock *ssk)
@@ -2481,6 +2543,11 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
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

