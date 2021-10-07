Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28F2C88
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 04:37:21 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="249476779"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="249476779"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 21:37:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="568443844"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 21:37:21 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: mptcp@lists.linux.dev,
	mathew.j.martineau@linux.intel.com,
	kishen.maloor@intel.com
Subject: [RFC PATCH 3/4] mptcp: pm_netlink: Add MPTCP_PM_CMD_REMOVE
Date: Thu,  7 Oct 2021 00:36:55 -0400
Message-Id: <20211007043656.261552-4-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211007043656.261552-1-kishen.maloor@intel.com>
References: <20211007043656.261552-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change adds a MPTCP netlink interface command for issuing
REMOVE_ADDR signals for a specific address over the chosen MPTCP
connection from a userspace path manager.

The command requires the following parameters: {token, loc_id}.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 include/uapi/linux/mptcp.h |  2 ++
 net/mptcp/pm_netlink.c     | 43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index e22e891016e3..0ce8abce6d54 100644
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
index 1b41bbc70529..bf92ef605043 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1029,6 +1029,7 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
 	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
 	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
+	[MPTCP_PM_ATTR_LOC_ID]		= { .type	= NLA_U8,	},
 };
 
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
@@ -1736,6 +1737,43 @@ static int mptcp_nl_addr_backup(struct net *net,
 	return ret;
 }
 
+static int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID],
+		*token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct mptcp_sock *msk;
+	struct mptcp_rm_list rm_list = { .nr = 0 };
+	u32 _token;
+	u8 _id;
+
+	if (!id || !token) {
+		GENL_SET_ERR_MSG(info, "missing remove info");
+		return -EINVAL;
+	}
+
+	_id = nla_get_u8(id);
+	_token = nla_get_u32(token);
+
+	msk = mptcp_token_get_sock(sock_net(skb->sk), _token);
+	if (!msk) {
+		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+		return -EINVAL;
+	}
+
+	rm_list.ids[rm_list.nr++] = _id;
+
+	lock_sock((struct sock *)msk);
+	spin_lock_bh(&msk->pm.lock);
+
+	msk->pm.userspace = true;
+	mptcp_pm_remove_addr(msk, &rm_list);
+
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock((struct sock *)msk);
+
+	return 0;
+}
+
 static int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR],
@@ -2112,6 +2150,11 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
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

