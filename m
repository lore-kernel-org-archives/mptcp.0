Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4EA71
	for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 09:16:57 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id ha17so7432784pjb.2
        for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 02:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2Qar1HgGgG8NYzjlqHfe1uo3t38t3/fE1EEt0aq0Y0=;
        b=Pbxvc5nhI7ObjA0uXhzQw8SQAiOXNA/k1lY08c9gZhV66u5jJB9PkFwsCND22K9IM7
         sq+eBC3I8ttMCJ6pVj2W7R5u+QrpqT254rxek/1PpbeUawNb+tEO7I7Qw82qUDOpKz6p
         XEh28gIfucvlH9q8yrYiSAFpZj/0bXUV4GdZp6ClXgb9LOASO7nvCZkarCJZmaomlikO
         L9G/obmToeuWbTpYcYLqt/jr2jlyJBvY72MCw0taXrSjy3Le+3jpyoBsOEX0t62UoSrB
         OyGJkdGJomogooHx3E+2aOGGMfhDChFlzTit8w4PYodKIZ7OLUy0VWNtqCu2eXv5kBjN
         gIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2Qar1HgGgG8NYzjlqHfe1uo3t38t3/fE1EEt0aq0Y0=;
        b=AX/Exj8RDsbMtcvQGBA6N0B9VGcES2Ttf2gm/dAa7VmVhF5oFOGW7tSlDCWmhDO+j3
         1KKykL+NSlLbfpHm7SuOXAJonibDQR/DLiAnwib8qwPylnrkMyha5WHhKlkU4PyIgIGS
         McrN2BCBV+NNMlx3acxVEYYz407HC/WMNRzzxFDYNyF5VWCuG+P8i03YmPEtu10+yp7C
         tR4Qu1p2Bf1epL08crDeoHUDsHbKpj1NU3jse29O5EvYfU64o+Je8OIXgYgSTy3N/9Ju
         JqkZOVjI7gjHX3RPy+rHZpvjSQnCR9kY7mQLX+TBgbVbXy76t3bf/RjCkMTMoal0YWqf
         qQOA==
X-Gm-Message-State: AOAM531ekJTq12dJ1s6Xy7gzqDXyr0R6wYyzva2DRsR7dor9i9SXCxkf
	8B5Y8uIZ3iEc/WTwjDQthZdJHdKsyOY=
X-Google-Smtp-Source: ABdhPJxtl+vc1LXzDBW7yE6ciGNQVmdZSWNnXlOv6NnwZYL/VJ2CpVmrr19s4jjTPQID5RbZYdH5gQ==
X-Received: by 2002:a17:90a:8b16:: with SMTP id y22mr3243430pjn.191.1617095816786;
        Tue, 30 Mar 2021 02:16:56 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id w3sm2192377pjg.7.2021.03.30.02.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:16:56 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v3 mptcp-next 2/4] mptcp: add tracepoint in get_mapping_status
Date: Tue, 30 Mar 2021 17:16:44 +0800
Message-Id: <f4084ca4e2f287461cdf552619b89596a429d042.1617095554.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <c69ce9cc277fd134a5254dee68436f6035ab594e.1617095554.git.geliangtang@gmail.com>
References: <cover.1617095554.git.geliangtang@gmail.com> <c69ce9cc277fd134a5254dee68436f6035ab594e.1617095554.git.geliangtang@gmail.com>
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
index 80c9498b4ad9..02b80cc662f9 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -39,6 +39,58 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		  __entry->ratio)
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

