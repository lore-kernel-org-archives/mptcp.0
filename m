Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75D6ABC
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 23:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645744950; x=1677280950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LWEmFrZ2U2Fi08dR/mdrOd+Y5WVaan8bzd0gJqYlgCE=;
  b=mEfQ8P3/cAfAr/6Gp0NcRdClM7dmQsw9R4sDBBfxWJuoc+sjkhnM9s16
   4n6PzoNbz+kCdoYgeijQpw3M7OlSKQwY0Td/3yykllkXRPA0jR4oXyKXw
   j0XvR2eKP95VDqHWzgdsbJZ2T15GlhIyg/AzAbwrjZSXHEBUSy0hANCHH
   FTkrbVidZUAzLDC9SHx4SDhSQ3HH5xk3/Xjg35f0N/vKHYANOn2O71o2V
   ZGbZABV5sTIG/NsnvR/vboymhJOlzZANUZfnCq2Bq1mmsz00XHOo97Wd8
   wdTj0Gvz5s9DgpiyJ84scmDCkZfP2/RGC4+j4XmjJohAMTjm/Zd0z4Zpe
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232998394"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="232998394"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 15:22:28 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="491784930"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.28.67])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 15:22:28 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	fw@strlen.de
Subject: [RFC PATCH mptcp-next 1/4] mptcp: Move some symbols to be visible outside the MPTCP subsystem
Date: Thu, 24 Feb 2022 15:22:23 -0800
Message-Id: <20220224232226.259304-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224232226.259304-1-mathew.j.martineau@linux.intel.com>
References: <20220224232226.259304-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Later patches will be checking MPTCP enabled status and a TCP option,
so make those symbols available in TCP code.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/net/mptcp.h  | 18 ++++++++++++++++++
 net/mptcp/protocol.h | 12 ------------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index b8939d7ea12e..211f395d8139 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -16,6 +16,17 @@ struct mptcp_info;
 struct mptcp_sock;
 struct seq_file;
 
+/* MPTCP option subtypes */
+#define MPTCPOPT_MP_CAPABLE	0
+#define MPTCPOPT_MP_JOIN	1
+#define MPTCPOPT_DSS		2
+#define MPTCPOPT_ADD_ADDR	3
+#define MPTCPOPT_RM_ADDR	4
+#define MPTCPOPT_MP_PRIO	5
+#define MPTCPOPT_MP_FAIL	6
+#define MPTCPOPT_MP_FASTCLOSE	7
+#define MPTCPOPT_RST		8
+
 /* MPTCP sk_buff extension data */
 struct mptcp_ext {
 	union {
@@ -100,6 +111,8 @@ extern struct request_sock_ops mptcp_subflow_request_sock_ops;
 
 void mptcp_init(void);
 
+int mptcp_is_enabled(const struct net *net);
+
 static inline bool sk_is_mptcp(const struct sock *sk)
 {
 	return tcp_sk(sk)->is_mptcp;
@@ -219,6 +232,11 @@ static inline void mptcp_init(void)
 {
 }
 
+static inline int mptcp_is_enabled(const struct net *net)
+{
+	return 0;
+}
+
 static inline bool sk_is_mptcp(const struct sock *sk)
 {
 	return false;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7ec2513e1c2f..75c852f0dd3a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -36,17 +36,6 @@
 #define OPTIONS_MPTCP_MPJ	(OPTION_MPTCP_MPJ_SYN | OPTION_MPTCP_MPJ_SYNACK | \
 				 OPTION_MPTCP_MPJ_ACK)
 
-/* MPTCP option subtypes */
-#define MPTCPOPT_MP_CAPABLE	0
-#define MPTCPOPT_MP_JOIN	1
-#define MPTCPOPT_DSS		2
-#define MPTCPOPT_ADD_ADDR	3
-#define MPTCPOPT_RM_ADDR	4
-#define MPTCPOPT_MP_PRIO	5
-#define MPTCPOPT_MP_FAIL	6
-#define MPTCPOPT_MP_FASTCLOSE	7
-#define MPTCPOPT_RST		8
-
 /* MPTCP suboption lengths */
 #define TCPOLEN_MPTCP_MPC_SYN		4
 #define TCPOLEN_MPTCP_MPC_SYNACK	12
@@ -577,7 +566,6 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
 	clear_bit(action, &subflow->delegated_status);
 }
 
-int mptcp_is_enabled(const struct net *net);
 unsigned int mptcp_get_add_addr_timeout(const struct net *net);
 int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
-- 
2.35.1

