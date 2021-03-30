Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C01970
	for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 09:16:54 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so1010406pjb.0
        for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+UoaGjbHUxoxSgkWRfiT350Nbm9uoiW8GCMfnRKc0ng=;
        b=Cp7Fyg7RZOH3yxMn2VavfFLbuJPzOE1VtoesIeECdNWVdqYijZhVN5Mbel4qsfBcpS
         YmYGdKzH+ADgJzm3zFbY+YFpO6J0l2AxXgGzRq94pPlF1fVuMTU4unRocDF7iOaOucNT
         CUH4hhj3pDpZ97asb55Ykc54sBXrIIS55SxtyUMHUUt/WWKiPiWp7XfjBRwfQIsoA5bl
         I4p5NLjA72OTJh/Nwmm3fqel9TMd+ASCqqBoICArGZTGJkgJ8jx1OowmJ5WHCeq1D5V/
         hE08m1ysdM2u74y2pvMd2RFLJ2ECAuiqtLgU3QvcaKF50Qvw8BE6lohRtCOO3BtzU93a
         iquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+UoaGjbHUxoxSgkWRfiT350Nbm9uoiW8GCMfnRKc0ng=;
        b=HNvHaP1m/77SwnQuGxVZtuf4K1W+6bG1BAzPGF6thvuFtrZyrUWZl1XGZQUMR4Yk4T
         Rsu+DQY8mfDJ+kECSotLfSuS00O0p6MjK67FuoQkzri51SFC7QTI2uAMdo/BFH2z8hXC
         KeHbK1dmuHsE+RGhVJ0oK9kAKBDHJ2eHICRfBFjiwkUgqzVu1RYICbpVBP638v2fUYtf
         k0McLa/HhW5rYaQPuwyrdVKnga0AkhB747DMM0r2PH0wpbR4HDkJQ0uVOoMCbjV5Iet+
         RDpsG9Sv059TyeM4v7D+BMshanwwHlJ1NRx0+IeD1iULv+kJzetKCRSgqt/4YdpR5YJA
         6GLQ==
X-Gm-Message-State: AOAM532Uc5ZiPbqXcXUDx6tE/PmIoub/gZRdHOxuhB8JWaC+afDDC1wh
	MavgW8MAz8ueDsHqEWhsTXB+iOQY70c=
X-Google-Smtp-Source: ABdhPJzKefq0XV0mZHPTcS+5FRDGSUuS5b8U0LAraXZnlu3afwLNeIdr0Mx9/Yufk/dYuV+RubaacA==
X-Received: by 2002:a17:90a:d801:: with SMTP id a1mr3364265pjv.84.1617095813504;
        Tue, 30 Mar 2021 02:16:53 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id y194sm19537789pfb.21.2021.03.30.02.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:16:53 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v3 mptcp-next 1/4] mptcp: add tracepoint in mptcp_subflow_get_send
Date: Tue, 30 Mar 2021 17:16:43 +0800
Message-Id: <c69ce9cc277fd134a5254dee68436f6035ab594e.1617095554.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617095554.git.geliangtang@gmail.com>
References: <cover.1617095554.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a tracepoint in the packet scheduler function
mptcp_subflow_get_send().

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/trace/events/mptcp.h | 45 ++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c         |  7 ++++++
 2 files changed, 52 insertions(+)
 create mode 100644 include/trace/events/mptcp.h

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
new file mode 100644
index 000000000000..80c9498b4ad9
--- /dev/null
+++ b/include/trace/events/mptcp.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mptcp
+
+#if !defined(_TRACE_MPTCP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_MPTCP_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(mptcp_subflow_get_send,
+
+	TP_PROTO(bool active, bool free, u32 snd_wnd,
+		 u32 pace, u8 backup, u64 ratio),
+
+	TP_ARGS(active, free, snd_wnd,
+		pace, backup, ratio),
+
+	TP_STRUCT__entry(
+		__field(bool, active)
+		__field(bool, free)
+		__field(u32, snd_wnd)
+		__field(u32, pace)
+		__field(u8, backup)
+		__field(u64, ratio)
+	),
+
+	TP_fast_assign(
+		__entry->active = active;
+		__entry->free = free;
+		__entry->snd_wnd = snd_wnd;
+		__entry->pace = pace;
+		__entry->backup = backup;
+		__entry->ratio = ratio;
+	),
+
+	TP_printk("active=%d free=%d snd_wnd=%u pace=%u backup=%u ratio=%llu",
+		  __entry->active, __entry->free, __entry->snd_wnd,
+		  __entry->pace, __entry->backup,
+		  __entry->ratio)
+);
+
+#endif /* _TRACE_MPTCP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9d7e7e13fba8..eb64d373a7ee 100644
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
@@ -1411,6 +1414,10 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 			send_info[subflow->backup].ssk = ssk;
 			send_info[subflow->backup].ratio = ratio;
 		}
+		trace_mptcp_subflow_get_send(mptcp_subflow_active(subflow),
+					     sk_stream_memory_free(subflow->tcp_sock),
+					     tcp_sk(ssk)->snd_wnd, pace,
+					     subflow->backup, ratio);
 	}
 
 	pr_debug("msk=%p nr_active=%d ssk=%p:%lld backup=%p:%lld",
-- 
2.30.2

