Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72113FCE
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330330; x=1674866330;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=N4Wtfs10/xwhz7JQbfBy4TpK6nNT1cDJBUbKdZvQ4zw=;
  b=dbXqHBbasMrpmXmePzAnxQqi0PGMCHWBw/CnmKzhMUlXJzR70yXtNUpo
   ah5TJfessOULI9jHSRx4ajOUM2l7lgBDn1okQeOX+0MbP0R5mIAAyd+Ak
   7PH5a4yTzBdBSlPFkGHZCrCyKplDNAGK1dIgZ3oPC+odBCTBHU4XyL6Ed
   XncgascN7VuCuSN8bX1HYQOalG04d1Sx7Ac8fPyYT58J+Wr6N1QDjiF5q
   N1uLh0tGZNGevLDH2rfagbyQe/POLAdy1GTUUK1Tm02Gee2cNYO42quJa
   Aen/T6KjtKrSnoqMfB05k8xOz0G1PlDe5/YpJf9U8u32AfVFabpUv2nEY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="333358330"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="333358330"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="480527106"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:41 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 01/14] mptcp: add sysctl param to limit userspace PM activity
Date: Thu, 27 Jan 2022 19:38:23 -0500
Message-Id: <20220128003836.2732694-2-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220128003836.2732694-1-kishen.maloor@intel.com>
References: <20220128003836.2732694-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change adds a new configurable param userspace_pm_local_addr_max
to set a limit on the number of local addresses that may be recorded
by a userspace path manager in the context of any MPTCP connection.
Consequently, it also limits the # of subflows, i.e. to as many that
could be established via the bounded set of local addresses.

The patch also ensures that other stats inside struct mptcp_pm_data
that are updated along kernel code paths exercised by userspace PMs
remain untouched for userspace PM managed sockets.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/ctrl.c       | 17 +++++++++++++++++
 net/mptcp/pm.c         |  4 +++-
 net/mptcp/pm_netlink.c |  3 +++
 net/mptcp/protocol.h   |  1 +
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index ae20b7d92e28..dffc2da6d713 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -19,6 +19,7 @@ static int mptcp_pernet_id;
 
 #ifdef CONFIG_SYSCTL
 static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
+static int mptcp_max_addrs = MPTCP_PM_MAX_ADDR_ID;
 #endif
 
 struct mptcp_pernet {
@@ -32,6 +33,7 @@ struct mptcp_pernet {
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
 	u8 pm_type;
+	u8 userspace_pm_local_addr_max;
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
@@ -69,6 +71,11 @@ int mptcp_get_pm_type(const struct net *net)
 	return mptcp_get_pernet(net)->pm_type;
 }
 
+unsigned int mptcp_get_userspace_pm_local_addr_max(const struct net *net)
+{
+	return mptcp_get_pernet(net)->userspace_pm_local_addr_max;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
@@ -77,6 +84,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->allow_join_initial_addr_port = 1;
 	pernet->stale_loss_cnt = 4;
 	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
+	pernet->userspace_pm_local_addr_max = 10;
 }
 
 #ifdef CONFIG_SYSCTL
@@ -128,6 +136,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.extra1       = SYSCTL_ZERO,
 		.extra2       = &mptcp_pm_type_max
 	},
+	{
+		.procname = "userspace_pm_local_addr_max",
+		.maxlen = sizeof(u8),
+		.mode = 0644,
+		.proc_handler = proc_dou8vec_minmax,
+		.extra1       = SYSCTL_ONE,
+		.extra2       = &mptcp_max_addrs
+	},
 	{}
 };
 
@@ -149,6 +165,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[3].data = &pernet->allow_join_initial_addr_port;
 	table[4].data = &pernet->stale_loss_cnt;
 	table[5].data = &pernet->pm_type;
+	table[6].data = &pernet->userspace_pm_local_addr_max;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e5d5cb847209..24839cd7025c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -182,7 +182,9 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 	bool update_subflows;
 
 	update_subflows = (ssk->sk_state == TCP_CLOSE) &&
-			  (subflow->request_join || subflow->mp_join);
+			  (subflow->request_join || subflow->mp_join) &&
+			  READ_ONCE(pm->pm_type) == MPTCP_PM_TYPE_KERNEL;
+
 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
 		return;
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 126cc961a4fd..882988e43d76 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -933,6 +933,9 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (!removed)
 			continue;
 
+		if (READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_KERNEL)
+			continue;
+
 		if (rm_type == MPTCP_MIB_RMADDR) {
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 30006735afb7..6cfa8ec26482 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -852,6 +852,7 @@ unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
+unsigned int mptcp_get_userspace_pm_local_addr_max(const struct net *net);
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
-- 
2.31.1

