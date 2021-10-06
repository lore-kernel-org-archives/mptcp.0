Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D992C81
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 00:00:00 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="249414258"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="249414258"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 16:59:59 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="560351292"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.0.106])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 16:59:59 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	kishen.maloor@intel.com
Subject: [RFC PATCH 6/6] DO-NOT-MERGE: debug: mptcp: Warn on unexpected events when userspace PM is active
Date: Wed,  6 Oct 2021 16:59:53 -0700
Message-Id: <20211006235953.212243-7-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006235953.212243-1-mathew.j.martineau@linux.intel.com>
References: <20211006235953.212243-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to confirm the previous commits work as expected, not sure if
such checks will be needed upstream.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 45 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index affa84099bdd..f6299bda6eb2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -753,14 +753,10 @@ void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 	mptcp_pm_nl_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
 }
 
-void mptcp_pm_nl_work(struct mptcp_sock *msk)
+static void mptcp_pm_kernel_work(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	msk_owned_by_me(msk);
-
-	spin_lock_bh(&msk->pm.lock);
-
 	pr_debug("msk=%p status=%x", msk, pm->status);
 	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
@@ -782,6 +778,45 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
 		mptcp_pm_nl_subflow_established(msk);
 	}
+}
+
+static void mptcp_pm_userspace_work(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	pr_debug("msk=%p status=%x", msk, pm->status);
+	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
+		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
+		WARN_ONCE(1, "Unexpected ADD_ADDR status in userspace PM mode");
+	}
+	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
+		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
+		WARN_ONCE(1, "Unexpected ADD_ADDR retransmit status in userspace PM mode");
+	}
+	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
+		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
+		WARN_ONCE(1, "Unexpected RM_ADDR status in userspace PM mode");
+	}
+	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
+		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
+		WARN_ONCE(1, "Unexpected established status in userspace PM mode");
+	}
+	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
+		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
+		WARN_ONCE(1, "Unexpected subflow established status in userspace PM mode");
+	}
+}
+
+void mptcp_pm_nl_work(struct mptcp_sock *msk)
+{
+	msk_owned_by_me(msk);
+
+	spin_lock_bh(&msk->pm.lock);
+
+	if (READ_ONCE(msk->pm.userspace))
+		mptcp_pm_userspace_work(msk);
+	else
+		mptcp_pm_kernel_work(msk);
 
 	spin_unlock_bh(&msk->pm.lock);
 }
-- 
2.33.0

