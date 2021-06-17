Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35596D00
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 23:46:35 +0000 (UTC)
IronPort-SDR: t9Xywz/M+MwTl8+2a0W+GWl+0hs56sDYRZf9CIqdW+JmoITWxDGRpXs2ESqYXbZtAglM2Am6mo
 iSxLXz5KFyFA==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="270316978"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="270316978"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 16:46:33 -0700
IronPort-SDR: 3AGix8NmjjkM/Pawxx+T0dMRvvV8OSrBUnXAI9x1GvsBHLglUb+3BvOLw4ess9+sE6HcnOodMX
 CANJ4D7AgyUg==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="452943924"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.250.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 16:46:33 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 13/16] mptcp: add a new sysctl checksum_enabled
Date: Thu, 17 Jun 2021 16:46:19 -0700
Message-Id: <20210617234622.472030-14-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617234622.472030-1-mathew.j.martineau@linux.intel.com>
References: <20210617234622.472030-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@gmail.com>

This patch added a new sysctl, named checksum_enabled, to control
whether DSS checksum can be enabled.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 Documentation/networking/mptcp-sysctl.rst |  8 ++++++++
 net/mptcp/ctrl.c                          | 16 ++++++++++++++++
 net/mptcp/protocol.h                      |  2 +-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 3b352e5f6300..ee06fd782465 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -24,3 +24,11 @@ add_addr_timeout - INTEGER (seconds)
 	sysctl.
 
 	Default: 120
+
+checksum_enabled - BOOLEAN
+	Control whether DSS checksum can be enabled.
+
+	DSS checksum can be enabled if the value is nonzero. This is a
+	per-namespace sysctl.
+
+	Default: 0
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 1ec4d36a39f0..6c2639bb9c19 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -23,6 +23,7 @@ struct mptcp_pernet {
 
 	u8 mptcp_enabled;
 	unsigned int add_addr_timeout;
+	u8 checksum_enabled;
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
@@ -40,10 +41,16 @@ unsigned int mptcp_get_add_addr_timeout(struct net *net)
 	return mptcp_get_pernet(net)->add_addr_timeout;
 }
 
+int mptcp_is_checksum_enabled(struct net *net)
+{
+	return mptcp_get_pernet(net)->checksum_enabled;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
+	pernet->checksum_enabled = 0;
 }
 
 #ifdef CONFIG_SYSCTL
@@ -65,6 +72,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_dointvec_jiffies,
 	},
+	{
+		.procname = "checksum_enabled",
+		.maxlen = sizeof(u8),
+		.mode = 0644,
+		.proc_handler = proc_dou8vec_minmax,
+		.extra1       = SYSCTL_ZERO,
+		.extra2       = SYSCTL_ONE
+	},
 	{}
 };
 
@@ -82,6 +97,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 
 	table[0].data = &pernet->mptcp_enabled;
 	table[1].data = &pernet->add_addr_timeout;
+	table[2].data = &pernet->checksum_enabled;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 12637299b42e..16e50caf200e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -542,7 +542,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
 
 int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
-static inline int mptcp_is_checksum_enabled(struct net *net) { return false; }
+int mptcp_is_checksum_enabled(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- 
2.32.0

