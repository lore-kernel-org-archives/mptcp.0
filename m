Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3168
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 00:52:25 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="322841463"
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="322841463"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:52:22 -0800
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="677471783"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.83.143])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:52:21 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2 1/6] mptcp: Remove redundant assignments in path manager init
Date: Wed,  1 Dec 2021 16:52:11 -0800
Message-Id: <20211202005216.154787-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202005216.154787-1-mathew.j.martineau@linux.intel.com>
References: <20211202005216.154787-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few members of the mptcp_pm_data struct were assigned to hard-coded
values in mptcp_pm_data_reset(), and then immediately changed in
mptcp_pm_nl_data_init().

Instead, flatten all the assignments in to mptcp_pm_data_reset().

v2: Resolve conflicts due to rename of mptcp_pm_data_reset()

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm.c         | 32 ++++++++++++++++++--------------
 net/mptcp/pm_netlink.c | 12 ------------
 net/mptcp/protocol.h   |  1 -
 3 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 761995a34124..4b79b73aee3c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -364,20 +364,24 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
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
 }
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3186d33b5208..a74eb0444cd2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -957,18 +957,6 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
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
index 47d24478763c..50175e4cbcb8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -821,7 +821,6 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 
 void __init mptcp_pm_nl_init(void);
-void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 				     const struct mptcp_rm_list *rm_list);
-- 
2.34.1

