Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C82FB3
	for <mptcp@lists.linux.dev>; Tue, 22 Jun 2021 19:25:30 +0000 (UTC)
IronPort-SDR: cb4WxHVZXuF8s8aV2B8SbSSGIkgAnyGErTGIUK3OQYTdU1z+0MolEjF8ZhZ2h+Yxx4rnzOcHr2
 dftHfWBkfyHQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="228686315"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="228686315"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 12:25:29 -0700
IronPort-SDR: c2njpyAPgfhIbF8zpDAHAQTZTfMUjUYuadVGBwIE4BPDCsLsvmWiDBIxdCXnlfiM96vnp0U4qw
 Wc/Z5TGgK/cQ==
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="480909716"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.237.182])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 12:25:28 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/6] mptcp: add sysctl allow_join_initial_addr_port
Date: Tue, 22 Jun 2021 12:25:18 -0700
Message-Id: <20210622192523.90117-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210622192523.90117-1-mathew.j.martineau@linux.intel.com>
References: <20210622192523.90117-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@gmail.com>

This patch added a new sysctl, named allow_join_initial_addr_port, to
control whether allow peers to send join requests to the IP address and
port number used by the initial subflow.

Suggested-by: Florian Westphal <fw@strlen.de>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 Documentation/networking/mptcp-sysctl.rst | 13 +++++++++++++
 net/mptcp/ctrl.c                          | 16 ++++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 30 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index ee06fd782465..76d939e688b8 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -32,3 +32,16 @@ checksum_enabled - BOOLEAN
 	per-namespace sysctl.
 
 	Default: 0
+
+allow_join_initial_addr_port - BOOLEAN
+	Allow peers to send join requests to the IP address and port number used
+	by the initial subflow if the value is 1. This controls a flag that is
+	sent to the peer at connection time, and whether such join requests are
+	accepted or denied.
+
+	Joins to addresses advertised with ADD_ADDR are not affected by this
+	value.
+
+	This is a per-namespace sysctl.
+
+	Default: 1
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 6c2639bb9c19..7d738bd06f2c 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -24,6 +24,7 @@ struct mptcp_pernet {
 	u8 mptcp_enabled;
 	unsigned int add_addr_timeout;
 	u8 checksum_enabled;
+	u8 allow_join_initial_addr_port;
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
@@ -46,11 +47,17 @@ int mptcp_is_checksum_enabled(struct net *net)
 	return mptcp_get_pernet(net)->checksum_enabled;
 }
 
+int mptcp_allow_join_id0(struct net *net)
+{
+	return mptcp_get_pernet(net)->allow_join_initial_addr_port;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
 	pernet->checksum_enabled = 0;
+	pernet->allow_join_initial_addr_port = 1;
 }
 
 #ifdef CONFIG_SYSCTL
@@ -80,6 +87,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.extra1       = SYSCTL_ZERO,
 		.extra2       = SYSCTL_ONE
 	},
+	{
+		.procname = "allow_join_initial_addr_port",
+		.maxlen = sizeof(u8),
+		.mode = 0644,
+		.proc_handler = proc_dou8vec_minmax,
+		.extra1       = SYSCTL_ZERO,
+		.extra2       = SYSCTL_ONE
+	},
 	{}
 };
 
@@ -98,6 +113,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[0].data = &pernet->mptcp_enabled;
 	table[1].data = &pernet->add_addr_timeout;
 	table[2].data = &pernet->checksum_enabled;
+	table[3].data = &pernet->allow_join_initial_addr_port;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 160c2ab09f19..9aab5fb54716 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -540,6 +540,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
 int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
 int mptcp_is_checksum_enabled(struct net *net);
+int mptcp_allow_join_id0(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- 
2.32.0

