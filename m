Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A92F56
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 20:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651524765; x=1683060765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tl84NCpOr253pS4c/uwm4WkevvE9XpfGA0+EjXDUaKM=;
  b=IvDtM510XZrjMPZCJYHWD/ecEcPR/Xexrt4DrZN0xTGufECT7oAHZR4R
   2OwIBkbY8hR+oBldHu2U9LIK3gIE8Wh8oXdKxkFEQ/JenI1P7bSLw/63a
   do8XZp2LFi4JpMxh9GAOsCd+soE7y4Jn8/Vyzh1kt6M/yLMMCyke1MG5T
   qfZ3sJMMkm579xkUa5uG99aTbZ5MDgpJJyAEHsV2vo23LcAv4EEoZ0vwu
   qK0PFbjp8kw/L9BJtcWsgEJw0Wa3+SgjUlDVZwS76kNus/p/W6mhfJj3Y
   u3cwUdhQT7yOeqmeEoXo8kyFNyyqXoN5KV8lWPoZ/EX8GLDahSzjaFSlM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247875181"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="247875181"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 13:52:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="733619568"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.141.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 13:52:43 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Kishen Maloor <kishen.maloor@intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/7] mptcp: bypass in-kernel PM restrictions for non-kernel PMs
Date: Mon,  2 May 2022 13:52:31 -0700
Message-Id: <20220502205237.129297-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220502205237.129297-1-mathew.j.martineau@linux.intel.com>
References: <20220502205237.129297-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kishen Maloor <kishen.maloor@intel.com>

Current limits on the # of addresses/subflows must apply only to
in-kernel PM managed sockets. Thus this change removes such
restrictions on connections overseen by non-kernel (e.g. userspace)
PMs. This change also ensures that the kernel does not record stats
inside struct mptcp_pm_data updated along kernel code paths when exercised
via non-kernel PMs.

Additionally, address announcements are acknolwedged and subflow
requests are honored only when it's deemed that	a userspace path
manager	is active at the time.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm.c         | 15 +++++++++++++--
 net/mptcp/pm_netlink.c | 10 ++++++++++
 net/mptcp/protocol.h   |  6 ++++++
 net/mptcp/subflow.c    |  4 +++-
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 57f67578a47f..8df9cb28d970 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -87,6 +87,9 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	unsigned int subflows_max;
 	int ret = 0;
 
+	if (mptcp_pm_is_userspace(msk))
+		return mptcp_userspace_pm_active(msk);
+
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
 	pr_debug("msk=%p subflows=%d max=%d allow=%d", msk, pm->subflows,
@@ -179,7 +182,8 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 	bool update_subflows;
 
 	update_subflows = (ssk->sk_state == TCP_CLOSE) &&
-			  (subflow->request_join || subflow->mp_join);
+			  (subflow->request_join || subflow->mp_join) &&
+			  mptcp_pm_is_kernel(msk);
 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
 		return;
 
@@ -208,7 +212,14 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (!READ_ONCE(pm->accept_addr) || mptcp_pm_is_userspace(msk)) {
+	if (mptcp_pm_is_userspace(msk)) {
+		if (mptcp_userspace_pm_active(msk)) {
+			mptcp_pm_announce_addr(msk, addr, true);
+			mptcp_pm_add_addr_send_ack(msk);
+		} else {
+			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
+		}
+	} else if (!READ_ONCE(pm->accept_addr)) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 473e5aa7baf4..d2b63529bfee 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -805,6 +805,9 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (!removed)
 			continue;
 
+		if (!mptcp_pm_is_kernel(msk))
+			continue;
+
 		if (rm_type == MPTCP_MIB_RMADDR) {
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
@@ -1855,6 +1858,13 @@ static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gf
 				nlskb, 0, MPTCP_PM_EV_GRP_OFFSET, gfp);
 }
 
+bool mptcp_userspace_pm_active(const struct mptcp_sock *msk)
+{
+	return genl_has_listeners(&mptcp_genl_family,
+				  sock_net((const struct sock *)msk),
+				  MPTCP_PM_EV_GRP_OFFSET);
+}
+
 static int mptcp_event_add_subflow(struct sk_buff *skb, const struct sock *ssk)
 {
 	const struct inet_sock *issk = inet_sk(ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 54d2b3b2d100..85390146944d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -784,6 +784,7 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
 void mptcp_event_addr_announced(const struct mptcp_sock *msk, const struct mptcp_addr_info *info);
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
+bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
@@ -811,6 +812,11 @@ static inline bool mptcp_pm_is_userspace(const struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_USERSPACE;
 }
 
+static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_KERNEL;
+}
+
 static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
 {
 	u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 75c824b67ca9..9567231a4bfa 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -62,7 +62,9 @@ static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
 {
 	return mptcp_is_fully_established((void *)msk) &&
-	       READ_ONCE(msk->pm.accept_subflow);
+		((mptcp_pm_is_userspace(msk) &&
+		  mptcp_userspace_pm_active(msk)) ||
+		 READ_ONCE(msk->pm.accept_subflow));
 }
 
 /* validate received token and create truncated hmac and nonce for SYN-ACK */
-- 
2.36.0

