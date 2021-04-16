Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB682F84
	for <mptcp@lists.linux.dev>; Fri, 16 Apr 2021 22:38:20 +0000 (UTC)
IronPort-SDR: ORi/XF3Qs2OozKRpLg2Ytq4hAV5uK3Q5WHQ+/jUTDZDjWillsU80AHMXnZNEHt5xlVT6MN6CZL
 EpJSQzn8M7IQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="175231661"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="175231661"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 15:38:18 -0700
IronPort-SDR: iK46AJkt+uktLkoYzbNQ2QEMzq970civ8oEgr+lwd5VQw8QmsjypUUPY/2TQ9tbsDyyhdTNKRV
 czEBJW3GKbJw==
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="462107394"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.43.70])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 15:38:17 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 5/8] mptcp: add tracepoint in get_mapping_status
Date: Fri, 16 Apr 2021 15:38:05 -0700
Message-Id: <20210416223808.298842-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416223808.298842-1-mathew.j.martineau@linux.intel.com>
References: <20210416223808.298842-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@gmail.com>

This patch added a tracepoint in the mapping status function
get_mapping_status() to dump every mpext field.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/trace/events/mptcp.h | 52 ++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c          |  6 ++---
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index b1617a0162da..ec20350d82eb 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -54,6 +54,58 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		  __entry->backup, __entry->ratio)
 );
 
+DECLARE_EVENT_CLASS(mptcp_dump_mpext,
+
+	TP_PROTO(struct mptcp_ext *mpext),
+
+	TP_ARGS(mpext),
+
+	TP_STRUCT__entry(
+		__field(u64, data_ack)
+		__field(u64, data_seq)
+		__field(u32, subflow_seq)
+		__field(u16, data_len)
+		__field(u8, use_map)
+		__field(u8, dsn64)
+		__field(u8, data_fin)
+		__field(u8, use_ack)
+		__field(u8, ack64)
+		__field(u8, mpc_map)
+		__field(u8, frozen)
+		__field(u8, reset_transient)
+		__field(u8, reset_reason)
+	),
+
+	TP_fast_assign(
+		__entry->data_ack = mpext->ack64 ? mpext->data_ack : mpext->data_ack32;
+		__entry->data_seq = mpext->data_seq;
+		__entry->subflow_seq = mpext->subflow_seq;
+		__entry->data_len = mpext->data_len;
+		__entry->use_map = mpext->use_map;
+		__entry->dsn64 = mpext->dsn64;
+		__entry->data_fin = mpext->data_fin;
+		__entry->use_ack = mpext->use_ack;
+		__entry->ack64 = mpext->ack64;
+		__entry->mpc_map = mpext->mpc_map;
+		__entry->frozen = mpext->frozen;
+		__entry->reset_transient = mpext->reset_transient;
+		__entry->reset_reason = mpext->reset_reason;
+	),
+
+	TP_printk("data_ack=%llu data_seq=%llu subflow_seq=%u data_len=%u use_map=%u dsn64=%u data_fin=%u use_ack=%u ack64=%u mpc_map=%u frozen=%u reset_transient=%u reset_reason=%u",
+		  __entry->data_ack, __entry->data_seq,
+		  __entry->subflow_seq, __entry->data_len,
+		  __entry->use_map, __entry->dsn64,
+		  __entry->data_fin, __entry->use_ack,
+		  __entry->ack64, __entry->mpc_map,
+		  __entry->frozen, __entry->reset_transient,
+		  __entry->reset_reason)
+);
+
+DEFINE_EVENT(mptcp_dump_mpext, get_mapping_status,
+	TP_PROTO(struct mptcp_ext *mpext),
+	TP_ARGS(mpext));
+
 #endif /* _TRACE_MPTCP_H */
 
 /* This part must be outside protection */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c3da84576b3c..d8a2a55ae916 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -25,6 +25,8 @@
 #include "protocol.h"
 #include "mib.h"
 
+#include <trace/events/mptcp.h>
+
 static void mptcp_subflow_ops_undo_override(struct sock *ssk);
 
 static void SUBFLOW_REQ_INC_STATS(struct request_sock *req,
@@ -862,9 +864,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		goto validate_seq;
 	}
 
-	pr_debug("seq=%llu is64=%d ssn=%u data_len=%u data_fin=%d",
-		 mpext->data_seq, mpext->dsn64, mpext->subflow_seq,
-		 mpext->data_len, mpext->data_fin);
+	trace_get_mapping_status(mpext);
 
 	data_len = mpext->data_len;
 	if (data_len == 0) {
-- 
2.31.1

