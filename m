Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9A45F
	for <mptcp@lists.linux.dev>; Wed, 31 Mar 2021 07:23:48 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so708426pjc.2
        for <mptcp@lists.linux.dev>; Wed, 31 Mar 2021 00:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aubw6cphMIgzL1bcUq6IMm421z0tVuR1nQ8+QcPbkXk=;
        b=jhguMQsG8BGASlol8WC3RzLvpixJj0G0+HQqBoesI51S21OsdSYAGRsEsrWqPWf2kj
         ATUvIUL0YhtxZIxwQnuB9OCyPFWbVP6wBPNdjcUXrvUSVi3qrS+Y19aUxbDOl5rqs2DR
         liD6nyVaYGw3wFGTbGCPoPkTe47SGxVnmamjiOCEGjckSwYWYaAe5fLop5A5NUgvTjDQ
         zcCVhcYBdx3NSTMsjVYhQ5t69hBumKCGF/SbHPJDb5py4FRS/CxIPE9Ok69qjCZEZU2D
         Dyf3u9D/x4+MebwbNmoTN0U4z3AczY9ugwMwNCizBdj7OWmH4zYJ0DmtQ/Vjf6ihgvI/
         8eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aubw6cphMIgzL1bcUq6IMm421z0tVuR1nQ8+QcPbkXk=;
        b=rYAEw6QtyKqIOw4A/483n7R8arcRxZmnS3QET+uw9NmHJHg2k6A40z5yWHg3hzoVqS
         cRkPIssUP3bBHp660k+jByDRfYmHHEb/6lOX5EV146wQaZwsDb/IhVimn3cmVB3ClUv3
         cA7G0sEl/BMsySDLa2RlGKbNI3BK9ZY+nc57X7bRysTbaR18F9L0Y83zrNXUDATkYe1S
         c347RJ43xhCyA45Kxh87EE/PJ10gyTP3UrsWxcVB961GGUWiNrCcxN+qeJ/94WEqxUbS
         nnH1n/29VuDx8uRNslGm4paUbb2/BFX0u6ABiMLeUk0wNB9Sq45XT6EnrKqbFq+8IxFi
         ae+Q==
X-Gm-Message-State: AOAM531JpZG6az/qQRYlgBIdmiQfkzZHcWF5rDpRtjn2Q0UlhrxcoedN
	mSzG/FU17DtI0Z6bNrAuceLl8XgG3TA=
X-Google-Smtp-Source: ABdhPJx36Rlr3sLxyHBJbaanRLQMfZ//24NMTd2JPKBEBhRm9gd3UfE87mno2MdOfNcAyanQsXvDqw==
X-Received: by 2002:a17:90b:508:: with SMTP id r8mr2208320pjz.83.1617175427569;
        Wed, 31 Mar 2021 00:23:47 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id h21sm1415544pgi.60.2021.03.31.00.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 00:23:47 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v4 mptcp-next 2/5] mptcp: add tracepoint in mptcp_subflow_get_send
Date: Wed, 31 Mar 2021 15:23:33 +0800
Message-Id: <9a7fe804a654722cab2b7b4cd97f21a5f27ec2cb.1617175133.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <69be5c2c98752dfe6cfe572ef5f13ff701618bd0.1617175133.git.geliangtang@gmail.com>
References: <cover.1617175133.git.geliangtang@gmail.com> <69be5c2c98752dfe6cfe572ef5f13ff701618bd0.1617175133.git.geliangtang@gmail.com>
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
 include/trace/events/mptcp.h | 53 ++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c         |  8 +++---
 2 files changed, 57 insertions(+), 4 deletions(-)
 create mode 100644 include/trace/events/mptcp.h

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
new file mode 100644
index 000000000000..f1c836573744
--- /dev/null
+++ b/include/trace/events/mptcp.h
@@ -0,0 +1,53 @@
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
+	TP_PROTO(struct mptcp_subflow_context *subflow),
+
+	TP_ARGS(subflow),
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
+		bool sk = sk_fullsock(subflow->tcp_sock);
+
+		__entry->active = mptcp_subflow_active(subflow);
+		__entry->backup = subflow->backup;
+		if (sk) {
+			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+			__entry->free = sk_stream_memory_free(subflow->tcp_sock);
+			if (ssk) {
+				__entry->snd_wnd = tcp_sk(ssk)->snd_wnd;
+				__entry->pace = ssk->sk_pacing_rate;
+				if (__entry->pace)
+					__entry->ratio = div_u64((u64)ssk->sk_wmem_queued << 32,
+								 __entry->pace);
+			}
+		}
+	),
+
+	TP_printk("active=%d free=%d snd_wnd=%u pace=%u backup=%u ratio=%llu",
+		  __entry->active, __entry->free,
+		  __entry->snd_wnd, __entry->pace,
+		  __entry->backup, __entry->ratio)
+);
+
+#endif /* _TRACE_MPTCP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a625c4e63152..2d895c3c8746 100644
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
@@ -1381,6 +1384,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		send_info[i].ratio = -1;
 	}
 	mptcp_for_each_subflow(msk, subflow) {
+		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
@@ -1401,10 +1405,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		}
 	}
 
-	pr_debug("msk=%p nr_active=%d ssk=%p:%lld backup=%p:%lld",
-		 msk, nr_active, send_info[0].ssk, send_info[0].ratio,
-		 send_info[1].ssk, send_info[1].ratio);
-
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
 		send_info[0].ssk = send_info[1].ssk;
-- 
2.30.2

