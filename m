Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64BA5F
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 16:54:49 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so1346740pjv.1
        for <mptcp@lists.linux.dev>; Thu, 01 Apr 2021 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9G5HaIvwR5ZoF5OR9NxbRiF+cZZ95i6AuFC0RbhnXy8=;
        b=nN36wJaFXTK421QKZOlr5iGnRMqaSG7z6pmrYUhp+fC2QPnY0ktcgRSfjX6dc2l8dJ
         W4sjAbfALfpWq0bl7vic/4JQPH7u12RYhUF6jidJiGGTX9XgAa0U/QW/l8YWJaquER6f
         nIZ+07miiEc/eW9CxkR7efguFOittPTzh2QaUDOjYzd+r80hs8xAEXtzRubMjtkzLe+f
         CUB5Fa6QgtLZyaqG32bstLNutFknmmqAk3rL7O+ZJYB0ONLMBw3m6aKXy0mj53P5gw7q
         djbKRfIaEXuLdTk+4wAUX6GzenGud4eWnWvp/29n2ZVsGDM3DTD2xS2URtu8kcQCPxbl
         f1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9G5HaIvwR5ZoF5OR9NxbRiF+cZZ95i6AuFC0RbhnXy8=;
        b=baqQgrGc1k7Oishw85QxM/PkY1VGo1bKtprlEUjovvAZY8aOxSwbILvTBYZVm7GTlg
         c6ATdibkAwTMZbQgbgV1wWCD95E1rR9FWGpwUlwbLyrAzHAcY8do88xFOVjefPvpiwVN
         us55DqMgUv7kIopf2j8D7GgQOQQN3k4kpTNMu5bCuxiOZBiwEz1iy529RQTyLPIeoSCh
         MmtLDejFzBEM5acy7gQ2eyKdphuel5h5rTJvr1Yta4ZYzis+lmZziVG4t/cSdQmpVj5k
         aBAuI/342Vdiw+nJBcaQiy/AmiQFEf+AkSz/+dWm7Ko8SUCZErzkek9zftFqBDTDPeAk
         TynQ==
X-Gm-Message-State: AOAM531atlnS2cHMTG6ZWvV+uGHRcJ2g63UiTI0yQt8UeyKIkEPYfw8j
	dMyWhMUvx96oNCOTrlCHfcNJgOEC7sU=
X-Google-Smtp-Source: ABdhPJzsGCcjGI9dABEELrJOQL3HICEuRiEdPLbhLVywkpy3H15nXiEiBPP/9842svMTPQ3vJQ2KQw==
X-Received: by 2002:a17:90a:7a8b:: with SMTP id q11mr9881409pjf.215.1617296088453;
        Thu, 01 Apr 2021 09:54:48 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id d21sm5701502pgj.62.2021.04.01.09.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 09:54:46 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v3 mptcp-next] Squash to "mptcp: add tracepoint in mptcp_subflow_get_send"
Date: Fri,  2 Apr 2021 00:54:44 +0800
Message-Id: <77e57026944d545dc4aaf9a6199ffa39485e1f43.1617296035.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce the indentation level and zero the uninitialized fields.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/trace/events/mptcp.h | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index f1c836573744..b1617a0162da 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -23,22 +23,29 @@ TRACE_EVENT(mptcp_subflow_get_send,
 	),
 
 	TP_fast_assign(
-		bool sk = sk_fullsock(subflow->tcp_sock);
+		struct sock *ssk;
 
 		__entry->active = mptcp_subflow_active(subflow);
 		__entry->backup = subflow->backup;
-		if (sk) {
-			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
+		if (subflow->tcp_sock && sk_fullsock(subflow->tcp_sock))
 			__entry->free = sk_stream_memory_free(subflow->tcp_sock);
-			if (ssk) {
-				__entry->snd_wnd = tcp_sk(ssk)->snd_wnd;
-				__entry->pace = ssk->sk_pacing_rate;
-				if (__entry->pace)
-					__entry->ratio = div_u64((u64)ssk->sk_wmem_queued << 32,
-								 __entry->pace);
-			}
+		else
+			__entry->free = 0;
+
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk && sk_fullsock(ssk)) {
+			__entry->snd_wnd = tcp_sk(ssk)->snd_wnd;
+			__entry->pace = ssk->sk_pacing_rate;
+		} else {
+			__entry->snd_wnd = 0;
+			__entry->pace = 0;
 		}
+
+		if (ssk && sk_fullsock(ssk) && __entry->pace)
+			__entry->ratio = div_u64((u64)ssk->sk_wmem_queued << 32, __entry->pace);
+		else
+			__entry->ratio = 0;
 	),
 
 	TP_printk("active=%d free=%d snd_wnd=%u pace=%u backup=%u ratio=%llu",
-- 
2.30.2

