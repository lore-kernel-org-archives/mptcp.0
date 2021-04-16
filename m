Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA22F85
	for <mptcp@lists.linux.dev>; Fri, 16 Apr 2021 22:38:21 +0000 (UTC)
IronPort-SDR: JR+mLDmaKayrneqZDLN7A2mDm0Cdh2uCVICzMLPAyAg66tfkG8esSvVNYuL3heshqn4Ma/SLSF
 0RzyfURz+M8Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="175231662"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="175231662"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 15:38:18 -0700
IronPort-SDR: OOOE8frzYuhahQKQVEgjRdv8UbPgch2BuBoNQC41VExiXi0DijYreTrg4DFH/6FOJJhuioHU3+
 uJBbdVGaUkzg==
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="462107396"
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
Subject: [PATCH net-next 6/8] mptcp: add tracepoint in ack_update_msk
Date: Fri, 16 Apr 2021 15:38:06 -0700
Message-Id: <20210416223808.298842-7-mathew.j.martineau@linux.intel.com>
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

This patch added a tracepoint in ack_update_msk() to track the
incoming data_ack and window/snd_una updates.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/trace/events/mptcp.h | 32 ++++++++++++++++++++++++++++++++
 net/mptcp/options.c          |  6 ++++++
 2 files changed, 38 insertions(+)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index ec20350d82eb..b90bfe45d995 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -106,6 +106,38 @@ DEFINE_EVENT(mptcp_dump_mpext, get_mapping_status,
 	TP_PROTO(struct mptcp_ext *mpext),
 	TP_ARGS(mpext));
 
+TRACE_EVENT(ack_update_msk,
+
+	TP_PROTO(u64 data_ack, u64 old_snd_una,
+		 u64 new_snd_una, u64 new_wnd_end,
+		 u64 msk_wnd_end),
+
+	TP_ARGS(data_ack, old_snd_una,
+		new_snd_una, new_wnd_end,
+		msk_wnd_end),
+
+	TP_STRUCT__entry(
+		__field(u64, data_ack)
+		__field(u64, old_snd_una)
+		__field(u64, new_snd_una)
+		__field(u64, new_wnd_end)
+		__field(u64, msk_wnd_end)
+	),
+
+	TP_fast_assign(
+		__entry->data_ack = data_ack;
+		__entry->old_snd_una = old_snd_una;
+		__entry->new_snd_una = new_snd_una;
+		__entry->new_wnd_end = new_wnd_end;
+		__entry->msk_wnd_end = msk_wnd_end;
+	),
+
+	TP_printk("data_ack=%llu old_snd_una=%llu new_snd_una=%llu new_wnd_end=%llu msk_wnd_end=%llu",
+		  __entry->data_ack, __entry->old_snd_una,
+		  __entry->new_snd_una, __entry->new_wnd_end,
+		  __entry->msk_wnd_end)
+);
+
 #endif /* _TRACE_MPTCP_H */
 
 /* This part must be outside protection */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d51c3ad54d9a..99fc21406168 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -13,6 +13,8 @@
 #include "protocol.h"
 #include "mib.h"
 
+#include <trace/events/mptcp.h>
+
 static bool mptcp_cap_flag_sha256(u8 flags)
 {
 	return (flags & MPTCP_CAP_FLAG_MASK) == MPTCP_CAP_HMAC_SHA256;
@@ -943,6 +945,10 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		__mptcp_data_acked(sk);
 	}
 	mptcp_data_unlock(sk);
+
+	trace_ack_update_msk(mp_opt->data_ack,
+			     old_snd_una, new_snd_una,
+			     new_wnd_end, msk->wnd_end);
 }
 
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit)
-- 
2.31.1

