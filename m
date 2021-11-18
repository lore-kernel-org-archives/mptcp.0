Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9048C2C95
	for <mptcp@lists.linux.dev>; Thu, 18 Nov 2021 01:30:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="231577916"
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="231577916"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 17:30:15 -0800
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="568294751"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.27.251])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 17:30:14 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 5/6] mptcp: Add a per-namespace sysctl to set the default path manager type
Date: Wed, 17 Nov 2021 17:30:04 -0800
Message-Id: <20211118013005.263660-6-mathew.j.martineau@linux.intel.com>
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

The new net.mptcp.pm_type sysctl determines which path manager will be
used by each newly-created MPTCP socket.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 Documentation/networking/mptcp-sysctl.rst | 18 ++++++++++++++++++
 net/mptcp/ctrl.c                          | 18 ++++++++++++++++++
 net/mptcp/pm.c                            | 13 +++++++++----
 net/mptcp/protocol.h                      |  1 +
 4 files changed, 46 insertions(+), 4 deletions(-)

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
index 8b235468c88f..64f1366aec5e 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -16,6 +16,8 @@
 #define MPTCP_SYSCTL_PATH "net/mptcp"
 
 static int mptcp_pernet_id;
+static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
+
 struct mptcp_pernet {
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_header *ctl_table_hdr;
@@ -26,6 +28,7 @@ struct mptcp_pernet {
 	u8 mptcp_enabled;
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
+	u8 pm_type;
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
@@ -58,6 +61,11 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
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
@@ -65,6 +73,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->checksum_enabled = 0;
 	pernet->allow_join_initial_addr_port = 1;
 	pernet->stale_loss_cnt = 4;
+	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
 }
 
 #ifdef CONFIG_SYSCTL
@@ -108,6 +117,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
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
 
@@ -128,6 +145,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[2].data = &pernet->checksum_enabled;
 	table[3].data = &pernet->allow_join_initial_addr_port;
 	table[4].data = &pernet->stale_loss_cnt;
+	table[5].data = &pernet->pm_type;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7f96a888e2d5..7ef27d41ad56 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -368,8 +368,12 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
 {
-	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
+	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
 	struct mptcp_pm_data *pm = &msk->pm;
+	bool subflows_allowed;
+
+	subflows_allowed = !!mptcp_pm_get_subflows_max(msk) &&
+		pm_type == MPTCP_PM_TYPE_KERNEL;
 
 	pm->add_addr_signaled = 0;
 	pm->add_addr_accepted = 0;
@@ -377,13 +381,14 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	pm->subflows = 0;
 	pm->rm_list_tx.nr = 0;
 	pm->rm_list_rx.nr = 0;
-	WRITE_ONCE(pm->pm_type, MPTCP_PM_TYPE_KERNEL);
+	WRITE_ONCE(pm->pm_type, pm_type);
 	/* pm->work_pending must be only be set to 'true' when
 	 * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
 	 */
 	WRITE_ONCE(pm->work_pending,
-		   (!!mptcp_pm_get_local_addr_max(msk) && subflows_allowed) ||
-		   !!mptcp_pm_get_add_addr_signal_max(msk));
+		   pm_type == MPTCP_PM_TYPE_KERNEL &&
+		   ((!!mptcp_pm_get_local_addr_max(msk) && subflows_allowed) ||
+		    !!mptcp_pm_get_add_addr_signal_max(msk)));
 	WRITE_ONCE(pm->addr_signal, 0);
 	WRITE_ONCE(pm->accept_addr,
 		   !!mptcp_pm_get_add_addr_accept_max(msk) && subflows_allowed);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index edaf0cc75474..b56ad45703dd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -563,6 +563,7 @@ unsigned int mptcp_get_add_addr_timeout(const struct net *net);
 int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
+int mptcp_get_pm_type(const struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
-- 
2.34.0

