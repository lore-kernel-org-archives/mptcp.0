Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA5B2C81
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 00:00:04 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="226439235"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="226439235"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 16:59:59 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="560351278"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.0.106])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 16:59:58 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	kishen.maloor@intel.com
Subject: [RFC PATCH 2/6] mptcp: Bypass kernel PM when userspace PM is enabled
Date: Wed,  6 Oct 2021 16:59:49 -0700
Message-Id: <20211006235953.212243-3-mathew.j.martineau@linux.intel.com>
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

When a MPTCP connection is managed by a userspace PM, bypass the kernel
PM for incoming advertisements and subflow events. Netlink events are
still sent to userspace.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 79aafcb51756..3fa3c0faed48 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -136,7 +136,7 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk,
 	 * racing paths - accept() and check_fully_established()
 	 * be sure to serve this event only once.
 	 */
-	if (READ_ONCE(pm->work_pending) &&
+	if (READ_ONCE(pm->work_pending) && !READ_ONCE(pm->userspace) &&
 	    !(msk->pm.status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
 
@@ -161,7 +161,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 
 	pr_debug("msk=%p", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	if (!READ_ONCE(pm->work_pending) || READ_ONCE(pm->userspace))
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -187,6 +187,9 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 
 	mptcp_event_addr_announced(msk, addr);
 
+	if (READ_ONCE(pm->userspace))
+		return;
+
 	spin_lock_bh(&pm->lock);
 
 	if (!READ_ONCE(pm->accept_addr)) {
@@ -206,6 +209,9 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	pr_debug("msk=%p", msk);
 
+	if (READ_ONCE(pm->userspace))
+		return;
+
 	spin_lock_bh(&pm->lock);
 
 	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
@@ -233,6 +239,9 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 	for (i = 0; i < rm_list->nr; i++)
 		mptcp_event_addr_removed(msk, rm_list->ids[i]);
 
+	if (READ_ONCE(pm->userspace))
+		return;
+
 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
 	pm->rm_list_rx = *rm_list;
-- 
2.33.0

