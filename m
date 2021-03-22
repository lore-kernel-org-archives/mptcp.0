Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C726E
	for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 11:37:54 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id v3so8437920pgq.2
        for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 04:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+xLhXZjF8DFuGo5S8iQ7sB2CT/NTSrps+fayhJM0VE=;
        b=Avv7yhwSai5JelLoF2PbboLE1k6mwhIRRZRqAlTIKsOdh9kNzQm4ejTmkWUw6QOuKB
         /j9Y2Rj8DclHy6qk0KE+Jhj7h+0l1Zhg+7TcTgghMZHae3suB3uudTs7Ti6jCQiKLQ0j
         dcZjhY2tkJ7EBrnuOxzIWTiQ6Xu2XgD7ZRrTuLTz5Sqwmy+jgUvYF2MnnYC7oDV4UJpI
         lqJ53u3XBc5rlFLqHbsAF1r4OXwYPsKxwjgE75IKyS2eSnryJpd9X/9pfQucoV3oxMzt
         +hh6wP7z05rC+ptl3Szm3nfQmzBz6YNpfcRuC8sMY/Ez1ErcIcNpLwf9hs+J8wPRtdfj
         DZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+xLhXZjF8DFuGo5S8iQ7sB2CT/NTSrps+fayhJM0VE=;
        b=d/dFUDDPG+D69dPKt8IFapcNOIA+SquuiTNfx/RNla4grAWOv4Nxxy5PbE/0DGvNuR
         jk46wRApgb6QYg1hVtYQAyvS1F9WnuZwhxQwN/RzqJ5dtpW7kw0u1v/awp+CvD57JQAA
         h7g1uCumap4zZiCzfYAoaJWuQ7EFnE4LyCeBYgIhBeOAPKoUh6H10BQVvpxCBInGUiY0
         HnfWBk7PQB19qsEjnOYtmg+oKrTqzIhIjeB93ZPsh6IK70jWJAYeC1EyFB1cUQIseeJK
         or06qRdFlNL2Vl9Ojv/2X1LPJHL+K5ljVJeEp1J3OJVpm5w3j5H3pb4B7VwuRH89/uP2
         aiBA==
X-Gm-Message-State: AOAM531OTeKj7zdrJUWKDYkQOmNs7EfXu0jPM/s/VVMh4Ejn0UlHCi5y
	gZ02Fab+kytxggxwhJ0aHVU=
X-Google-Smtp-Source: ABdhPJzyaAyfamSWu1WrXoYGOWE2P/Rf+luu8jIAsiPPJtqsAksbtD9EgNkdSZcvxZ5tZLeTdR9cwg==
X-Received: by 2002:aa7:860f:0:b029:200:851:1bff with SMTP id p15-20020aa7860f0000b029020008511bffmr21263895pfn.64.1616413073775;
        Mon, 22 Mar 2021 04:37:53 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id w23sm5524566pgm.64.2021.03.22.04.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:37:53 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.01.org,
	mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 6/6] mptcp: add trace event for DSS checksum
Date: Mon, 22 Mar 2021 19:37:30 +0800
Message-Id: <b94a7a3372002661bd5647f93a1fb6d7a60bb70a.1616412490.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <7762b80e2310ae0f1a09ec5a4324293d8e9943eb.1616412490.git.geliangtang@gmail.com>
References: <cover.1616412490.git.geliangtang@gmail.com> <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com> <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com> <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com> <643a31ae30f00dd0d1d49834f6e996b3fe637c47.1616412490.git.geliangtang@gmail.com> <7762b80e2310ae0f1a09ec5a4324293d8e9943eb.1616412490.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the trace event for DSS checksum. Add a tracepoint in
mptcp_generate_dss_csum and a tracepoint in validate_dss_csum.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/trace/events/mptcp.h | 51 ++++++++++++++++++++++++++++++++++++
 net/mptcp/options.c          |  4 +++
 net/mptcp/protocol.c         |  3 +++
 net/mptcp/subflow.c          |  4 +++
 4 files changed, 62 insertions(+)
 create mode 100644 include/trace/events/mptcp.h

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
new file mode 100644
index 000000000000..a5b87e304303
--- /dev/null
+++ b/include/trace/events/mptcp.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mptcp
+
+#if !defined(_TRACE_MPTCP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_MPTCP_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(mptcp_event_dss_csum,
+
+	TP_PROTO(struct csum_pseudo_header *header, __u16 csum),
+
+	TP_ARGS(header, csum),
+
+	TP_STRUCT__entry(
+		__field(__u64, data_seq)
+		__field(__u32, subflow_seq)
+		__field(__u16, data_len)
+		__field(__u16, dss_csum)
+		__field(__u16, csum)
+	),
+
+	TP_fast_assign(
+		__entry->data_seq = header->data_seq;
+		__entry->subflow_seq = header->subflow_seq;
+		__entry->data_len = header->data_len;
+		__entry->dss_csum = header->csum;
+		__entry->csum = csum;
+	),
+
+	TP_printk("data_seq=%llu subflow_seq=%u data_len=%u csum=%u",
+		  __entry->data_seq, __entry->subflow_seq, __entry->data_len,
+		  __entry->csum)
+);
+
+DEFINE_EVENT(mptcp_event_dss_csum, mptcp_generate_dss_csum,
+	TP_PROTO(struct csum_pseudo_header *header, __u16 csum),
+	TP_ARGS(header, csum));
+
+DEFINE_EVENT_PRINT(mptcp_event_dss_csum, validate_dss_csum,
+	TP_PROTO(struct csum_pseudo_header *header, __u16 csum),
+	TP_ARGS(header, csum),
+	TP_printk("data_seq=%llu subflow_seq=%u data_len=%u csum=%u, DSS checksum %s!",
+		  __entry->data_seq, __entry->subflow_seq, __entry->data_len,
+		  __entry->dss_csum, __entry->csum ? "error" : "done"));
+
+#endif /* _TRACE_MPTCP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ed89f6c2ed49..8ec41bf56c3b 100644
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
@@ -548,6 +550,8 @@ static u16 mptcp_generate_dss_csum(struct sk_buff *skb)
 	csum = skb_checksum(skb, 0, skb->len, 0);
 	csum = csum_partial(&header, sizeof(header), csum);
 
+	trace_mptcp_generate_dss_csum(&header, csum_fold(csum));
+
 	return csum_fold(csum);
 }
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 94c3568c7a60..1f767612c917 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -25,6 +25,9 @@
 #include "protocol.h"
 #include "mib.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/mptcp.h>
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 struct mptcp6_sock {
 	struct mptcp_sock msk;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2eeea7d527f0..7e63d902a3de 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -27,6 +27,8 @@
 
 static void mptcp_subflow_ops_undo_override(struct sock *ssk);
 
+#include <trace/events/mptcp.h>
+
 static void SUBFLOW_REQ_INC_STATS(struct request_sock *req,
 				  enum linux_mptcp_mib_field field)
 {
@@ -821,6 +823,8 @@ static bool validate_dss_csum(struct sock *ssk, struct sk_buff *skb)
 	csum = skb_checksum(skb, 0, skb->len, 0);
 	csum = csum_partial(&header, sizeof(header), csum);
 
+	trace_validate_dss_csum(&header, csum_fold(csum));
+
 	if (csum_fold(csum)) {
 		pr_err("DSS checksum error! data_seq=%llu subflow_seq=%u data_len=%u csum=%u %u",
 		       header.data_seq, header.subflow_seq, header.data_len,
-- 
2.30.2

