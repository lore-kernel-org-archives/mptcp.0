Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A063FEC
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 22:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639693460; x=1671229460;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=KkAuwrF0nBkoanEMVoneMM0anhi7gGvevIIY19vd7Pc=;
  b=UR9xeDL6IRc6JajCbd1keDbdSKmUzYuhAzTYzX3oF/hXS3zhKOzXkZ1z
   dwyXhMr2RgAKrE1P0FISgtUZRsmGKWKNPlbDqwiM0uZ6D7mjAUZKq/j8e
   mSFWhnsm9fGD6EsiSA3Ca4ydz/Hhdg17AAT15UnZMhLaCoWILy7iUpTBd
   7867GEJXgfWJo4hi001+Eh4fuzo1vYSH5vO5Razpj/uhMu37TwjnxlL93
   rzuHRRNNiafaj1LFGtmrRVIGlbk0GMvElHeyE8rL8wTnUd8/NBQXLzbbW
   bpKoj19C+Zn++28oTIEOsg5ZUIJ1qqpboevC2d2evxeml4GwBA+QeHYiu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="300393169"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="300393169"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="519461263"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 13/21] mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
Date: Thu, 16 Dec 2021 17:23:06 -0500
Message-Id: <20211216222314.1244708-14-kishen.maloor@intel.com>
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

This change adds a MPTCP netlink interface for issuing
ADD_ADDR advertisements over the chosen MPTCP connection from a
userspace path manager.

The command requires the following parameters:
{ token, { loc_id, family, daddr4 | daddr6 [, dport] } [, if_idx],
flags/signal }.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 include/uapi/linux/mptcp.h |   2 +
 net/mptcp/pm_netlink.c     | 111 +++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index f106a3941cdf..40380be396c8 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -55,6 +55,7 @@ enum {
 	MPTCP_PM_ATTR_ADDR,				/* nested address */
 	MPTCP_PM_ATTR_RCV_ADD_ADDRS,			/* u32 */
 	MPTCP_PM_ATTR_SUBFLOWS,				/* u32 */
+	MPTCP_PM_ATTR_TOKEN,				/* u32 */
 
 	__MPTCP_PM_ATTR_MAX
 };
@@ -92,6 +93,7 @@ enum {
 	MPTCP_PM_CMD_SET_LIMITS,
 	MPTCP_PM_CMD_GET_LIMITS,
 	MPTCP_PM_CMD_SET_FLAGS,
+	MPTCP_PM_CMD_ANNOUNCE,
 
 	__MPTCP_PM_CMD_AFTER_LAST
 };
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 067a74ad7c5c..2e9ca5730b10 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1268,6 +1268,7 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
 					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
 	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
+	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
 };
 
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
@@ -2028,6 +2029,111 @@ static int mptcp_nl_addr_backup(struct net *net,
 	return ret;
 }
 
+static int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	struct mptcp_pm_addr_entry addr_val;
+	struct mptcp_local_lsk *lsk_ref;
+	bool reuse_port = false;
+	struct mptcp_sock *msk;
+	struct socket *lsk;
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
+	if (READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_USERSPACE) {
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
+	if (!addr_val.addr.port) {
+		addr_val.addr.port =
+			((struct inet_sock *)inet_sk
+			 ((struct sock *)msk))->inet_sport;
+
+		reuse_port = true;
+	}
+
+	lsk_ref = lsk_list_find(pernet, &addr_val.addr);
+
+	if (!lsk_ref) {
+		err = mptcp_pm_nl_create_listen_socket(skb->sk, &addr_val, &lsk);
+		if ((err && !reuse_port) || (err && (err != -EADDRINUSE) && reuse_port)) {
+			GENL_SET_ERR_MSG(info, "error creating listen socket");
+			return err;
+		}
+
+		if (lsk) {
+			lsk_ref = lsk_list_add(pernet, &addr_val.addr, lsk);
+			if (!lsk_ref) {
+				GENL_SET_ERR_MSG(info, "can't allocate lsk ref");
+				sock_release(lsk);
+				return -ENOMEM;
+			}
+		}
+	}
+
+	if (!reuse_port) {
+		addr_val.lsk_ref = lsk_ref;
+		lsk_ref = NULL;
+	} else {
+		addr_val.addr.port = 0;
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
@@ -2370,6 +2476,11 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
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

