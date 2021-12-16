Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721BE2CAF
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 00:33:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="236907569"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="236907569"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 16:33:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="465835393"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.72.63])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 16:33:29 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v4 5/6] mptcp: Add a per-namespace sysctl to set the default path manager type
Date: Wed, 15 Dec 2021 16:33:23 -0800
Message-Id: <20211216003324.403195-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216003324.403195-1-mathew.j.martineau@linux.intel.com>
References: <20211216003324.403195-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new net.mptcp.pm_type sysctl determines which path manager will be
used by each newly-created MPTCP socket.

v2: Handle builds without CONFIG_SYSCTL
v3: Clarify logic for type-specific PM init (Geliang Tang and Paolo Abeni)

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 Documentation/networking/mptcp-sysctl.rst | 18 ++++++++++++
 net/mptcp/ctrl.c                          | 21 ++++++++++++++
 net/mptcp/pm.c                            | 34 +++++++++++++++--------
 net/mptcp/protocol.h                      |  1 +
 4 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index b0d4da71e68e..e263dfcc4b40 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -46,6 +46,24 @@ allow_join_initial_addr_port - BOOLEAN
 
 	Default: 1
 
+pm_type - INTEGER
+
+	Set the default path manager type to use for each new MPTCP
+	socket. In-kernel path management will control subflow
+	connections and address advertisements according to
+	per-namespace values configured over the MPTCP netlink
+	API. Userspace path management puts per-MPTCP-connection subflow
+	connection decisions and address advertisements under control of
+	a privileged userspace program, at the cost of more netlink
+	traffic to propagate all of the related events and commands.
+
+	This is a per-namespace sysctl.
+
+	* 0 - In-kernel path manager
+	* 1 - Userspace path manager
+
+	Default: 0
+
 stale_loss_cnt - INTEGER
 	The number of MPTCP-level retransmission intervals with no traffic and
 	pending outstanding data on a given subflow required to declare it stale.
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 8b235468c88f..ae20b7d92e28 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -16,6 +16,11 @@
 #define MPTCP_SYSCTL_PATH "net/mptcp"
 
 static int mptcp_pernet_id;
+
+#ifdef CONFIG_SYSCTL
+static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
+#endif
+
 struct mptcp_pernet {
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_header *ctl_table_hdr;
@@ -26,6 +31,7 @@ struct mptcp_pernet {
 	u8 mptcp_enabled;
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
+	u8 pm_type;
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
@@ -58,6 +64,11 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
 	return mptcp_get_pernet(net)->stale_loss_cnt;
 }
 
+int mptcp_get_pm_type(const struct net *net)
+{
+	return mptcp_get_pernet(net)->pm_type;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
@@ -65,6 +76,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->checksum_enabled = 0;
 	pernet->allow_join_initial_addr_port = 1;
 	pernet->stale_loss_cnt = 4;
+	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
 }
 
 #ifdef CONFIG_SYSCTL
@@ -108,6 +120,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_douintvec_minmax,
 	},
+	{
+		.procname = "pm_type",
+		.maxlen = sizeof(u8),
+		.mode = 0644,
+		.proc_handler = proc_dou8vec_minmax,
+		.extra1       = SYSCTL_ZERO,
+		.extra2       = &mptcp_pm_type_max
+	},
 	{}
 };
 
@@ -128,6 +148,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[2].data = &pernet->checksum_enabled;
 	table[3].data = &pernet->allow_join_initial_addr_port;
 	table[4].data = &pernet->stale_loss_cnt;
+	table[5].data = &pernet->pm_type;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 47ac9651e12c..1f8878cc29e3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -383,7 +383,7 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
-	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
+	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
 	struct mptcp_pm_data *pm = &msk->pm;
 
 	pm->add_addr_signaled = 0;
@@ -392,17 +392,29 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	pm->subflows = 0;
 	pm->rm_list_tx.nr = 0;
 	pm->rm_list_rx.nr = 0;
-	WRITE_ONCE(pm->pm_type, MPTCP_PM_TYPE_KERNEL);
-	/* pm->work_pending must be only be set to 'true' when
-	 * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
-	 */
-	WRITE_ONCE(pm->work_pending,
-		   (!!mptcp_pm_get_local_addr_max(msk) && subflows_allowed) ||
-		   !!mptcp_pm_get_add_addr_signal_max(msk));
+	WRITE_ONCE(pm->pm_type, pm_type);
+
+	if (pm_type == MPTCP_PM_TYPE_KERNEL) {
+		bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
+
+		/* pm->work_pending must be only be set to 'true' when
+		 * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
+		 */
+		WRITE_ONCE(pm->work_pending,
+			   (!!mptcp_pm_get_local_addr_max(msk) &&
+			    subflows_allowed) ||
+			   !!mptcp_pm_get_add_addr_signal_max(msk));
+		WRITE_ONCE(pm->accept_addr,
+			   !!mptcp_pm_get_add_addr_accept_max(msk) &&
+			   subflows_allowed);
+		WRITE_ONCE(pm->accept_subflow, subflows_allowed);
+	} else {
+		WRITE_ONCE(pm->work_pending, 0);
+		WRITE_ONCE(pm->accept_addr, 0);
+		WRITE_ONCE(pm->accept_subflow, 0);
+	}
+
 	WRITE_ONCE(pm->addr_signal, 0);
-	WRITE_ONCE(pm->accept_addr,
-		   !!mptcp_pm_get_add_addr_accept_max(msk) && subflows_allowed);
-	WRITE_ONCE(pm->accept_subflow, subflows_allowed);
 	WRITE_ONCE(pm->remote_deny_join_id0, false);
 	pm->status = 0;
 	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0c680a5177eb..517f087f2b3a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -579,6 +579,7 @@ unsigned int mptcp_get_add_addr_timeout(const struct net *net);
 int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
+int mptcp_get_pm_type(const struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
-- 
2.34.1

