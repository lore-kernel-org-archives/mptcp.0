Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956846D00
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 23:54:41 +0000 (UTC)
IronPort-SDR: znYlkNuG/Ge4QPerhwpA98PlQ5Bn/ezUVGS3Mv9mij2HujrHaZMdi8fGauBBx+mq7JTwyzJJdi
 x8eXh/ctrLHQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="288450528"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="288450528"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:54:37 -0700
IronPort-SDR: t3u/MX9qEWH5cn9zygcy9VTz7vQeeKtSBoD1Fp+aYCcfN6Nd6UwGnspPmsNURtMSC5vBlCiYpm
 NGOCTr0aFPmA==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="443774262"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.84.136])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:54:36 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 6/7] mptcp: support SYSCTL only if enabled
Date: Thu, 27 May 2021 16:54:29 -0700
Message-Id: <20210527235430.183465-7-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527235430.183465-1-mathew.j.martineau@linux.intel.com>
References: <20210527235430.183465-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

Since the introduction of the sysctl support in MPTCP with
commit 784325e9f037 ("mptcp: new sysctl to control the activation per NS"),
we don't check CONFIG_SYSCTL.

Until now, that was not an issue: the register and unregister functions
were replaced by NO-OP one if SYSCTL was not enabled in the config. The
only thing we could have avoid is not to reserve memory for the table
but that's for the moment only a small table per net-ns.

But the following commit is going to use SYSCTL_ZERO and SYSCTL_ONE
which are not be defined if SYSCTL is not enabled in the config. This
causes 'undefined reference' errors from the linker.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/ctrl.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 96ba616f59bf..a3b15ed60b77 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -4,7 +4,9 @@
  * Copyright (c) 2019, Tessares SA.
  */
 
+#ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
+#endif
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
@@ -15,7 +17,9 @@
 
 static int mptcp_pernet_id;
 struct mptcp_pernet {
+#ifdef CONFIG_SYSCTL
 	struct ctl_table_header *ctl_table_hdr;
+#endif
 
 	int mptcp_enabled;
 	unsigned int add_addr_timeout;
@@ -36,6 +40,13 @@ unsigned int mptcp_get_add_addr_timeout(struct net *net)
 	return mptcp_get_pernet(net)->add_addr_timeout;
 }
 
+static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
+{
+	pernet->mptcp_enabled = 1;
+	pernet->add_addr_timeout = TCP_RTO_MAX;
+}
+
+#ifdef CONFIG_SYSCTL
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -55,12 +66,6 @@ static struct ctl_table mptcp_sysctl_table[] = {
 	{}
 };
 
-static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
-{
-	pernet->mptcp_enabled = 1;
-	pernet->add_addr_timeout = TCP_RTO_MAX;
-}
-
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 {
 	struct ctl_table_header *hdr;
@@ -100,6 +105,17 @@ static void mptcp_pernet_del_table(struct mptcp_pernet *pernet)
 	kfree(table);
 }
 
+#else
+
+static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
+{
+	return 0;
+}
+
+static void mptcp_pernet_del_table(struct mptcp_pernet *pernet) {}
+
+#endif /* CONFIG_SYSCTL */
+
 static int __net_init mptcp_net_init(struct net *net)
 {
 	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
-- 
2.31.1

