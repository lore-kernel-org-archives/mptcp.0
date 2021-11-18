Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B5B2C89
	for <mptcp@lists.linux.dev>; Thu, 18 Nov 2021 01:30:15 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="231577911"
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="231577911"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 17:30:14 -0800
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="568294740"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.27.251])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 17:30:14 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 1/6] mptcp: Remove redundant assignments in path manager init
Date: Wed, 17 Nov 2021 17:30:00 -0800
Message-Id: <20211118013005.263660-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211118013005.263660-1-mathew.j.martineau@linux.intel.com>
References: <20211118013005.263660-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few members of the mptcp_pm_data struct were assigned to hard-coded
values in mptcp_pm_data_init(), and then immediately changed in
mptcp_pm_nl_data_init().

Instead, flatten all the initialization in to mptcp_pm_data_init().

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm.c         | 38 +++++++++++++++++++++-----------------
 net/mptcp/pm_netlink.c | 12 ------------
 net/mptcp/protocol.h   |  1 -
 3 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 86b38a830b4c..467fbb2a4eba 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -364,23 +364,27 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
 {
-	msk->pm.add_addr_signaled = 0;
-	msk->pm.add_addr_accepted = 0;
-	msk->pm.local_addr_used = 0;
-	msk->pm.subflows = 0;
-	msk->pm.rm_list_tx.nr = 0;
-	msk->pm.rm_list_rx.nr = 0;
-	WRITE_ONCE(msk->pm.work_pending, false);
-	WRITE_ONCE(msk->pm.addr_signal, 0);
-	WRITE_ONCE(msk->pm.accept_addr, false);
-	WRITE_ONCE(msk->pm.accept_subflow, false);
-	WRITE_ONCE(msk->pm.remote_deny_join_id0, false);
-	msk->pm.status = 0;
-
-	spin_lock_init(&msk->pm.lock);
-	INIT_LIST_HEAD(&msk->pm.anno_list);
-
-	mptcp_pm_nl_data_init(msk);
+	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	pm->add_addr_signaled = 0;
+	pm->add_addr_accepted = 0;
+	pm->local_addr_used = 0;
+	pm->subflows = 0;
+	pm->rm_list_tx.nr = 0;
+	pm->rm_list_rx.nr = 0;
+	WRITE_ONCE(pm->work_pending,
+		   (!!mptcp_pm_get_local_addr_max(msk) && subflows_allowed) ||
+		   !!mptcp_pm_get_add_addr_signal_max(msk));
+	WRITE_ONCE(pm->addr_signal, 0);
+	WRITE_ONCE(pm->accept_addr,
+		   !!mptcp_pm_get_add_addr_accept_max(msk) && subflows_allowed);
+	WRITE_ONCE(pm->accept_subflow, subflows_allowed);
+	WRITE_ONCE(pm->remote_deny_join_id0, false);
+	pm->status = 0;
+
+	spin_lock_init(&pm->lock);
+	INIT_LIST_HEAD(&pm->anno_list);
 }
 
 void __init mptcp_pm_init(void)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7b96be1e9f14..bab78e2f5299 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -954,18 +954,6 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	return ret;
 }
 
-void mptcp_pm_nl_data_init(struct mptcp_sock *msk)
-{
-	struct mptcp_pm_data *pm = &msk->pm;
-	bool subflows;
-
-	subflows = !!mptcp_pm_get_subflows_max(msk);
-	WRITE_ONCE(pm->work_pending, (!!mptcp_pm_get_local_addr_max(msk) && subflows) ||
-		   !!mptcp_pm_get_add_addr_signal_max(msk));
-	WRITE_ONCE(pm->accept_addr, !!mptcp_pm_get_add_addr_accept_max(msk) && subflows);
-	WRITE_ONCE(pm->accept_subflow, subflows);
-}
-
 #define MPTCP_PM_CMD_GRP_OFFSET       0
 #define MPTCP_PM_EV_GRP_OFFSET        1
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 906509c6cde5..092cb77a64d8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -803,7 +803,6 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 
 void __init mptcp_pm_nl_init(void);
-void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 				     const struct mptcp_rm_list *rm_list);
-- 
2.34.0

