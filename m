Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE1D322F
	for <mptcp@lists.linux.dev>; Thu, 14 Apr 2022 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649971170; x=1681507170;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=qCv67Ai64zt15CvwOhaIw3G8/pLQ65RGfcCs1qi/48A=;
  b=MSHyrpgA97/7sI0Zp2p6zSDzx3Tq16j5NwvS0qhJNzuCpVNAKIlZoDXY
   B0vXHBakn775t6ZXAhbKIC/okP4+egeCeMwDeDf7m/Qfy8/H9cRpvnDqe
   LvwoIqDoOqmBnrgGBn8ww9WTE8dhh/eJrKvcs/spWw3QVq+5GE6ChYN7O
   8Mtb8bmZF0EnCp/KUwxiEzcgcnAjhrerkkYI/a7Q8p8Nf7tCdbEEaL32V
   tjVg5R6jfu6ACvL/iA69cvMl15rMch3cBIbFH15ffGlWi9ddUTjSdOv0E
   udXfD56FY/2v7RU910GUL9hCKiDksk8q0vdmU1/LltedSc6GutHFmRkE4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="349467253"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="349467253"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 14:19:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="573998128"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 14:19:24 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v10 05/14] mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
Date: Thu, 14 Apr 2022 17:19:11 -0400
Message-Id: <20220414211920.1987961-6-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220414211920.1987961-1-kishen.maloor@intel.com>
References: <20220414211920.1987961-1-kishen.maloor@intel.com>
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
v6:
-Move struct mptcp_pm_addr_entry into protocol.h.
-Make mptcp_pm_alloc_anno_list() and mptcp_pm_parse_entry()
non-static.
-Move mptcp_nl_cmd_announce() into pm_userspace.c.
---
 include/uapi/linux/mptcp.h |  2 ++
 net/mptcp/pm_netlink.c     | 24 ++++++++--------
 net/mptcp/pm_userspace.c   | 58 ++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h       | 17 +++++++++++
 4 files changed, 88 insertions(+), 13 deletions(-)

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
index ece0158519e2..dbe5ccd95ac5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -22,14 +22,6 @@ static struct genl_family mptcp_genl_family;
 
 static int pm_nl_pernet_id;
 
-struct mptcp_pm_addr_entry {
-	struct list_head	list;
-	struct mptcp_addr_info	addr;
-	u8			flags;
-	int			ifindex;
-	struct socket		*lsk;
-};
-
 struct mptcp_pm_add_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
@@ -360,8 +352,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	return entry;
 }
 
-static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-				     const struct mptcp_pm_addr_entry *entry)
+bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+			      const struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -1102,6 +1094,7 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
 					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
 	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
 	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
+	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
 };
 
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
@@ -1211,9 +1204,9 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 	return err;
 }
 
-static int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
-				bool require_family,
-				struct mptcp_pm_addr_entry *entry)
+int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
+			 bool require_family,
+			 struct mptcp_pm_addr_entry *entry)
 {
 	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
 	int err;
@@ -2206,6 +2199,11 @@ static const struct genl_small_ops mptcp_pm_ops[] = {
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
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 910116b0f5b9..86d1c83a3f9f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -119,3 +119,61 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 
 	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
 }
+
+int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
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
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a6ee811e5d02..2abf98e66074 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -11,6 +11,7 @@
 #include <net/tcp.h>
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
+#include <net/genetlink.h>
 
 #define MPTCP_SUPPORTED_VERSION	1
 
@@ -747,6 +748,19 @@ u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum);
 void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
 void mptcp_pm_data_reset(struct mptcp_sock *msk);
+
+struct mptcp_pm_addr_entry {
+	struct list_head	list;
+	struct mptcp_addr_info	addr;
+	u8			flags;
+	int			ifindex;
+	struct socket		*lsk;
+};
+
+int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
+			 bool require_family,
+			 struct mptcp_pm_addr_entry *entry);
+
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
@@ -767,6 +781,8 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
+bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+			      const struct mptcp_pm_addr_entry *entry);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
@@ -790,6 +806,7 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *
 int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 					     struct mptcp_pm_addr_entry *entry);
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
+int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.31.1

