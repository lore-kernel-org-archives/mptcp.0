Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9C15F
	for <mptcp@lists.linux.dev>; Wed, 31 Mar 2021 07:23:51 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so759606pjv.1
        for <mptcp@lists.linux.dev>; Wed, 31 Mar 2021 00:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8qGl49omGPkSQhwH/Uvlmt03PoYe52lDlzrSoOKr1eo=;
        b=lkIykfs27NrIWEHaQB17nSabMGTX/bLKZ4KwBPF9mmKyQ4qTkb2DsvBQBxsNie6H59
         aztAwoYuKrAIkeZpSz4MERH0Rgdb1Jg/NPUrMb/YWSw+j08iobvhywPdn8d/eI8Kcpdn
         XyDgT+8+L5ImhhBBtzqLZx5oEkIoRGgd5phomI/ZkHx7eFCQi2X6/swTdOgQLeEdb2p3
         j4TMcN+czAQYm4x1FXFuQC7GX8HFLhcDSp82xL0hjWMKAU5jQObyENkrTaDKN/yTR0Al
         nsj3F2d2BAwJFa3DRnGPHh+w12ADxB5AeGd7DT8L3W8u8CARRLq5ud2+mCHZbZGuAAmS
         JxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qGl49omGPkSQhwH/Uvlmt03PoYe52lDlzrSoOKr1eo=;
        b=tcLGkTKyt3KXT7qQrB15mUb09QHNrftMkJzs8lgVBru/713GgBRuX3cwiMb0Byln3g
         yxij7sjGjVBfqVdnLeQg0MkSYYApKnjV2hTfpalnitacfQiCv37LoT6QdDGJPtkc0/WO
         elOVWWs9nm0jsQBwzqTog88PpxSnJLm7bbILm323lyN5R6JD7FVYAUrFuG5gA5wiHa9Q
         8m1XBW3cxMV+Xo21Vt9h4hi5UCdvBuOzldRNNbIW3sgaF2JeFuNsRO5IjwSHZt9zvc8V
         wcRxAE5asygv9tjCr8ztLAsv+zKP9Sx0y6qcmq4hyEO2SbTmEaOAJQ4iUPzO0ZPQfVn9
         FDVg==
X-Gm-Message-State: AOAM533yH7WTyW76DjNX8beb9nfOPWOuVRRkXz1aMMW/DIOCQ0B13Sxj
	dskIrTLp/hlZiK+j6UkEM6Tua83Qdx8=
X-Google-Smtp-Source: ABdhPJy5kYTLZkzwkY1jb9eKu4tl9N8ghC8dpmtWPxMXAh4XGZs11P5ezz6oRz4BjQ2ieyF+9QFIDg==
X-Received: by 2002:a17:902:a404:b029:e6:23d:44ac with SMTP id p4-20020a170902a404b02900e6023d44acmr1923063plq.50.1617175430582;
        Wed, 31 Mar 2021 00:23:50 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id g10sm1412009pgh.36.2021.03.31.00.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 00:23:50 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v4 mptcp-next 3/5] mptcp: add tracepoint in get_mapping_status
Date: Wed, 31 Mar 2021 15:23:34 +0800
Message-Id: <e2100f55ef22c52ba10b699c8362189d501d4ca1.1617175133.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <9a7fe804a654722cab2b7b4cd97f21a5f27ec2cb.1617175133.git.geliangtang@gmail.com>
References: <cover.1617175133.git.geliangtang@gmail.com> <69be5c2c98752dfe6cfe572ef5f13ff701618bd0.1617175133.git.geliangtang@gmail.com> <9a7fe804a654722cab2b7b4cd97f21a5f27ec2cb.1617175133.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a tracepoint in the mapping status function
get_mapping_status() to dump every mpext field.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/trace/events/mptcp.h | 52 ++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c          |  6 ++---
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index f1c836573744..4a6cc475fb73 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -47,6 +47,58 @@ TRACE_EVENT(mptcp_subflow_get_send,
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
index 3c19a5265a0f..a88c2b1e5410 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -25,6 +25,8 @@
 #include "protocol.h"
 #include "mib.h"
 
+#include <trace/events/mptcp.h>
+
 static void mptcp_subflow_ops_undo_override(struct sock *ssk);
 
 static void SUBFLOW_REQ_INC_STATS(struct request_sock *req,
@@ -858,9 +860,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		goto validate_seq;
 	}
 
-	pr_debug("seq=%llu is64=%d ssn=%u data_len=%u data_fin=%d",
-		 mpext->data_seq, mpext->dsn64, mpext->subflow_seq,
-		 mpext->data_len, mpext->data_fin);
+	trace_get_mapping_status(mpext);
 
 	data_len = mpext->data_len;
 	if (data_len == 0) {
-- 
2.30.2

