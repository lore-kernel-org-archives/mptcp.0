Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A281D20E5
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 02:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648520050; x=1680056050;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=JFfNMKu2BiP/IalZtdk4SedEQzW3OgEn1gkuHHI+jsU=;
  b=aXgN6Cs1gEFXN7x8caF4RGgbV4/67hhZ9OIievwgfOgcDcK/6mEWUamk
   oeGNFwN8TixnGo9YviYnejKtvCQWPVlDtZIWRk4150gdzP6iWfCK19/D/
   BEcvtbQj+hzJ/vq0DlwmFLd8EXnDtR9dwHCmfugwmDz/gUV6BT+DSuIyH
   DAtrRYqBaMdZSRRypW/TcMic7y0F/VoraeE20rsbQ1+5qeAoGfFm4MYds
   ajuywYk3inBH0DLLz2BGMdfYGFNKHu8FJ4tBtMRkApHvdqpi3P+G/yc3O
   KlaqxjwWbESlhQCaHFTUvZ1wBbyjGJlZkEuRbWa/W8StvuzsM+xnY112C
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="345578743"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="345578743"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="564202542"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:07 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 2/6] mptcp: bypass in-kernel PM restrictions for non-kernel PMs
Date: Mon, 28 Mar 2022 22:13:57 -0400
Message-Id: <20220329021401.1196466-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220329021401.1196466-1-kishen.maloor@intel.com>
References: <20220329021401.1196466-1-kishen.maloor@intel.com>
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
index 10a73898c8db..491aedc486f1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -798,6 +798,9 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (!removed)
 			continue;
 
+		if (!mptcp_pm_is_kernel(msk))
+			continue;
+
 		if (rm_type == MPTCP_MIB_RMADDR) {
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
@@ -1848,6 +1851,13 @@ static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gf
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
2.31.1

