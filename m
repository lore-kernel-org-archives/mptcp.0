Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8244378
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 15:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647531304; x=1679067304;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=sNpLyf0/kmEdFE28G0FiYo3NuGRiHRzo9TrdggqbAbo=;
  b=cHjcCle7PWI3BkgF0Yoxy/HJuXrWtvyzDSQu4rqt0P7nu72fJonUZbQU
   9ofdc2laEqPTjLyRWuSDY9yHWLSFbwjFZ/uEWNBg25EkoWq0ZJy8jrrn5
   +hofQs0D+3qOMKGW0FyqZV56Q4w6M6NJUHvHt8kAHdgSX0v0Bbun4aDR3
   VnHIyXe2AMWIFh9JcsyfSVZmPYi13PHd1bdNmUdc1M64wLpnaj0qQ4aMd
   rCzmNXlhFH4h8LhWX4QZE+zbcgsrdmVvVqTZVZMsCbmP5XtFnezsYGagH
   a1QxG/MHWSK0hjS5QnDZClAk6dFXIIYcpKprtWpJxLxDZ+KEK4ZR+oGnA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237504877"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="237504877"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 08:35:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516804199"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 08:35:01 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v7 1/5] mptcp: bypass in-kernel PM restrictions for non-kernel PMs
Date: Thu, 17 Mar 2022 11:34:49 -0400
Message-Id: <20220317153453.665359-2-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220317153453.665359-1-kishen.maloor@intel.com>
References: <20220317153453.665359-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current limits on the # of addresses/subflows must apply only to
in-kernel PM managed sockets. Thus this change removes such
restrictions on connections overseen by non-kernel (e.g. userspace)
PMs. This change also ensures that the kernel does not record stats
inside struct mptcp_pm_data updated along kernel code paths when exercised
via non-kernel PMs.

Additionally, address announcements are acknolwedged and subflow
requests are honored only when it's deemed that	a userspace path
manager	is active at the time.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm.c         | 13 +++++++++++--
 net/mptcp/pm_netlink.c |  8 ++++++++
 net/mptcp/protocol.h   | 10 ++++++++--
 net/mptcp/subflow.c    |  4 +++-
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d0d31d5c198a..5353340194c0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -87,6 +87,12 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	unsigned int subflows_max;
 	int ret = 0;
 
+	if (mptcp_pm_is_userspace(msk)) {
+		if (mptcp_userspace_pm_active(sock_net((struct sock *)msk)))
+			return true;
+		return false;
+	}
+
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
 	pr_debug("msk=%p subflows=%d max=%d allow=%d", msk, pm->subflows,
@@ -179,7 +185,8 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 	bool update_subflows;
 
 	update_subflows = (ssk->sk_state == TCP_CLOSE) &&
-			  (subflow->request_join || subflow->mp_join);
+			  (subflow->request_join || subflow->mp_join) &&
+			  mptcp_pm_is_kernel(msk);
 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
 		return;
 
@@ -208,7 +215,9 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (!READ_ONCE(pm->accept_addr) || mptcp_pm_is_userspace(msk)) {
+	if (!READ_ONCE(pm->accept_addr) ||
+	    (mptcp_pm_is_userspace(msk) &&
+	     mptcp_userspace_pm_active(sock_net((struct sock *)msk)))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c1f4befb1e45..4f09eb97faff 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -796,6 +796,9 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (!removed)
 			continue;
 
+		if (!mptcp_pm_is_kernel(msk))
+			continue;
+
 		if (rm_type == MPTCP_MIB_RMADDR) {
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
@@ -1846,6 +1849,11 @@ static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gf
 				nlskb, 0, MPTCP_PM_EV_GRP_OFFSET, gfp);
 }
 
+bool mptcp_userspace_pm_active(struct net *net)
+{
+	return genl_has_listeners(&mptcp_genl_family, net, MPTCP_PM_EV_GRP_OFFSET);
+}
+
 static int mptcp_event_add_subflow(struct sk_buff *skb, const struct sock *ssk)
 {
 	const struct inet_sock *issk = inet_sk(ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c8bada4537e2..1d8c58fb8cdc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -781,6 +781,7 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
 void mptcp_event_addr_announced(const struct mptcp_sock *msk, const struct mptcp_addr_info *info);
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
+bool mptcp_userspace_pm_active(struct net *net);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
@@ -803,9 +804,14 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
 }
 
-static inline bool mptcp_pm_is_userspace(struct mptcp_sock *msk)
+static inline bool mptcp_pm_is_userspace(const struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_KERNEL;
+	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_USERSPACE;
+}
+
+static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_KERNEL;
 }
 
 static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 30ffb00661bb..2fb78b4b3ca6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -62,7 +62,9 @@ static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
 {
 	return mptcp_is_fully_established((void *)msk) &&
-	       READ_ONCE(msk->pm.accept_subflow);
+		((mptcp_pm_is_userspace(msk) &&
+		  mptcp_userspace_pm_active(sock_net((struct sock *)msk))) ||
+		 READ_ONCE(msk->pm.accept_subflow));
 }
 
 /* validate received token and create truncated hmac and nonce for SYN-ACK */
-- 
2.31.1

