Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E276F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 08:51:51 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id u19so14161544pgh.10
        for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKxZBs9xTEh65g3JhtIa2npNFdBBWHcflY7T3usK1ww=;
        b=WVJ3q85pcj0lne8/Jtw/EwX3cyH/z9Idy0GWZM+wXIZ3ResVju6tSg0XB7MBjTbK+J
         ZcVvaPonukcZiDELYY+n9pqOGSMgvT40xGxImJsqL0j4pdJ5CM5yeYdpAuK1lBw5v7Zl
         8yZP4R8qYokbeL//+54QMS560v5LQVS/cLufC7XGNyPO8KOWiXk308aAFzqRPDeIeOoC
         MOAJPW+A8vQyQKIhP+bLgYVqURmw8U1Kyyux5sF45WBQFK/5N8xHxxnvWgWkIqvN7UNB
         +4szWQ7ORRsQORFhCKvzb36dkRTSUsJKBTm55C26UFqQ/x0qkmf5Hr+exKJEVjFQ7Ruj
         6jfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKxZBs9xTEh65g3JhtIa2npNFdBBWHcflY7T3usK1ww=;
        b=ENKjRKm6hFZ3GFYah69yFmDsM2+8Uc648QiiHxOtmhI/W1aAbf7k9p/FsZItn9PAhw
         it1Vzh1tcEDZJ/iJ2nRyQCritd8wcQm5TyP8aKlePHES5Ca22EKLeXIzPAdLc3StGD8V
         iijimzKHiBdtgA023iCDkfjjyo2hgDkxgZrOflp8LqZUw7JDdgotZr9/nM0o7SUIAnWA
         HYkJRo4YAQfxdUl1tOvKbPgZx+x9pe6mb/gnL2MrbNGrDRdXDH64c/evvxCwP9gHp4NE
         8hPtWJMgV/jxos/PUbFPouQfYFtD44QNL9cGvCKczLPkjgNB1hmnzuMhbC8SC9Am6+Gk
         M8GQ==
X-Gm-Message-State: AOAM533plf5zKtXiprxWQpdMglbMwUsgk7RBnIzP2vt1hiLq7+yLhuK7
	a0gDzg/m9I1m+p366vcWeK0=
X-Google-Smtp-Source: ABdhPJyoFdMnOIZpnqUrv7UUUo3Uw6mM9lqg1fFprxScr/CMkPunakcLcnu7gEhFijtvvcRdM21dQg==
X-Received: by 2002:a63:fb18:: with SMTP id o24mr2062723pgh.55.1616575910674;
        Wed, 24 Mar 2021 01:51:50 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id d2sm1651461pjx.42.2021.03.24.01.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 01:51:50 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.01.org,
	mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v2 mptcp-next 2/5] mptcp: add tracepoint in mptcp_subflow_get_send
Date: Wed, 24 Mar 2021 16:51:36 +0800
Message-Id: <ffa353e9982d4795058abc87f1e2f52bc29e430b.1616575602.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <6e606e2aeb7ea4bdd1618783cb24675bcde693b2.1616575602.git.geliangtang@gmail.com>
References: <cover.1616575602.git.geliangtang@gmail.com> <6e606e2aeb7ea4bdd1618783cb24675bcde693b2.1616575602.git.geliangtang@gmail.com>
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
 include/trace/events/mptcp.h | 43 ++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c         |  4 ++++
 2 files changed, 47 insertions(+)
 create mode 100644 include/trace/events/mptcp.h

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
new file mode 100644
index 000000000000..06908ea6afb4
--- /dev/null
+++ b/include/trace/events/mptcp.h
@@ -0,0 +1,43 @@
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
+	TP_PROTO(struct mptcp_subflow_context *subflow, struct sock *ssk),
+
+	TP_ARGS(subflow, ssk),
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
+		__entry->active = mptcp_subflow_active(subflow);
+		__entry->free = sk_stream_memory_free(subflow->tcp_sock);
+		__entry->snd_wnd = tcp_sk(ssk)->snd_wnd;
+		__entry->pace = ssk->sk_pacing_rate;
+		__entry->backup = subflow->backup;
+		__entry->ratio = div_u64((u64)ssk->sk_wmem_queued << 32, __entry->pace);
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
index 3ad236689480..0265b8be0f84 100644
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
@@ -1394,6 +1397,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	}
 	mptcp_for_each_subflow(msk, subflow) {
 		ssk =  mptcp_subflow_tcp_sock(subflow);
+		trace_mptcp_subflow_get_send(subflow, ssk);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
-- 
2.30.2

