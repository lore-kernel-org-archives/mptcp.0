Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24D72CAA
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330326; x=1674866326;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=sZGkn2tE9zaUpJvQ/5gUaYWEglRQGcKa2DMg+7i0Kis=;
  b=FXXFlmuENlAEoapoG5ImiEAXHSB6yFmivIGbKpTKZiMAUuqk9lqCH4+e
   xA1D7E+4stxoXdhK+66n4x/U+qFqKTQuodpcCNVHlblsBUSloYKXNmHZB
   1UO/aNXrmGCU7yWV/RlLnYPZuuqFmaW2XYbHUbPt4YF+325SkgDCpy8yY
   4LPr7iVUtaSgMTRZgSWzqZGNEtAkfWPiWn6xQhWLTsG/3pjfVCLeRrz0L
   WyHfQK3r2edsRVO90Iw1iz6/ttY+0or9DqcD3ZES4VXDXjHTqyMUQlebX
   0DoCWrpMabh/MazU5wyH32k6lg8B8tkISLVIcNMb8CEltxYRKsZjsBZoU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="333358334"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="333358334"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="480527119"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:41 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 06/14] mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
Date: Thu, 27 Jan 2022 19:38:28 -0500
Message-Id: <20220128003836.2732694-7-kishen.maloor@intel.com>
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
---
 include/uapi/linux/mptcp.h |   2 +
 net/mptcp/pm_netlink.c     | 101 +++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

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
index 829e20a6d0dd..e880177742d3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1312,6 +1312,7 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
 					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
 	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
+	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
 };
 
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
@@ -2072,6 +2073,101 @@ static int mptcp_nl_set_flags(struct net *net,
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
@@ -2425,6 +2521,11 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
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

