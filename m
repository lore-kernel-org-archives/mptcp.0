Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7149D6F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 08:51:54 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id g15so16831600pfq.3
        for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=biJr7IG3EcBGhkplBVy525/1CvRfPrf8UuvfC5TPsIk=;
        b=MchZKbpBnGuJ01g+hmaYSTpTQ8qUqwOaeulvTQcH+ZGiEa+gO5uQZ/1+YhBuJcL687
         vRECkfJh3Br3JOsrrnGX/pt7FUza74Rn2wiNZNknLDe7YQTYmzzDh2fpAQMDGmGdnmuh
         4YhFdZuUROy8TsfIdOv/1/YRv8wBd+dIvp82gb1QEghxCWF8dzYpdQkM7GVAyjly5oLD
         8Xk0v8D9gDX29FGyDqL7LwwJ3yO4Q3hzawah9fBSgg+HbDQZbW7zNof1ai+SW7kW/eh+
         0DI+aMadWiDcI/HMbOnFDPc77c6BE1qQO2c9GmQj6RpcXNMrlTRXCa8m6VmwNXBjMyI1
         smEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=biJr7IG3EcBGhkplBVy525/1CvRfPrf8UuvfC5TPsIk=;
        b=c2i/QilErYPJXtjC0xvZlt1AlNEaXH2mv92AexSrtCVst+Fva+sIZDdyT7QyCGU2ER
         KjGTlJpgvKtVVT/e1yhUvg7wWT/Yk/f1AhSnNCwjW5rrFXeoMvAIg4SM/caQZU67uMcC
         IeYJwws4VYQI1uSwqCwGOxssF89W48oTJc8MEZd6jtJbr4tnpDmSOn4OBLPIG3b2esN2
         2i3gLtvDRKlesR9q63LJeD2DfLNwkTKUYV9s3cuhXQUo+X7im+kMrNAP1tmd4+DsxxCg
         M2NWp2ZYA7ir2pAGVlf6RML6Ti9oqFQYAdXWBiUYfL1j8c6dX96ZeWcNmqidlBqTXafm
         KUxg==
X-Gm-Message-State: AOAM530BbICV+UiUmamwMsHTFCxOG2j/fkq9z7LnJ+atDXxG+eDuDl/7
	fUH+nuRyTBAfp24OpPdFnkNRq4NW/ujTHA==
X-Google-Smtp-Source: ABdhPJwgPRa4Meo/KuLMwHCLhAEoKC/6vneJxkD8YMwuWO6scKhvtdaXszPF+pGfvvQFy85OkdAOmQ==
X-Received: by 2002:a63:f00d:: with SMTP id k13mr2131368pgh.295.1616575913920;
        Wed, 24 Mar 2021 01:51:53 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id j13sm1679245pfn.103.2021.03.24.01.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 01:51:53 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.01.org,
	mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v2 mptcp-next 3/5] mptcp: add tracepoint in get_mapping_status
Date: Wed, 24 Mar 2021 16:51:37 +0800
Message-Id: <9b74169474a157c54953de796bc35ef54a710a18.1616575602.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ffa353e9982d4795058abc87f1e2f52bc29e430b.1616575602.git.geliangtang@gmail.com>
References: <cover.1616575602.git.geliangtang@gmail.com> <6e606e2aeb7ea4bdd1618783cb24675bcde693b2.1616575602.git.geliangtang@gmail.com> <ffa353e9982d4795058abc87f1e2f52bc29e430b.1616575602.git.geliangtang@gmail.com>
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
 include/trace/events/mptcp.h | 54 ++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c          |  6 ++--
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 06908ea6afb4..503a6098909d 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -37,6 +37,60 @@ TRACE_EVENT(mptcp_subflow_get_send,
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
+		__field(u32, data_ack32)
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
+		__entry->data_ack = mpext->data_ack;
+		__entry->data_ack32 = mpext->data_ack32;
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
+	TP_printk("data_ack=%llu data_ack32=%u data_seq=%llu subflow_seq=%u data_len=%u use_map=%u dsn64=%u data_fin=%u use_ack=%u ack64=%u mpc_map=%u frozen=%u reset_transient=%u reset_reason=%u",
+		  __entry->data_ack, __entry->data_ack32,
+		  __entry->data_seq, __entry->subflow_seq,
+		  __entry->data_len, __entry->use_map,
+		  __entry->dsn64, __entry->data_fin,
+		  __entry->use_ack, __entry->ack64,
+		  __entry->mpc_map, __entry->frozen,
+		  __entry->reset_transient, __entry->reset_reason)
+);
+
+DEFINE_EVENT(mptcp_dump_mpext, get_mapping_status,
+	TP_PROTO(struct mptcp_ext *mpext),
+	TP_ARGS(mpext));
+
 #endif /* _TRACE_MPTCP_H */
 
 /* This part must be outside protection */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5fc3cada11dd..dc08e5de807e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -25,6 +25,8 @@
 #include "protocol.h"
 #include "mib.h"
 
+#include <trace/events/mptcp.h>
+
 static void mptcp_subflow_ops_undo_override(struct sock *ssk);
 
 static void SUBFLOW_REQ_INC_STATS(struct request_sock *req,
@@ -853,9 +855,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
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

