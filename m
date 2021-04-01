Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CFB5F
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 13:10:38 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id bt4so1119192pjb.5
        for <mptcp@lists.linux.dev>; Thu, 01 Apr 2021 06:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ijxTmjdlgxicdkmgADMXVlZyZ1EFgGLvCoRfMwK9taI=;
        b=KOlYSQLu0YZ41SpXoG8/ysFdtDDyvEo5zzrmDipfiZkpQhYKKUlAvl69dxyRjPicnq
         kCmwntnSr/ql1a5feq+VqbeVLrQ+eseJiiaKupKYCbZtV8kF8S8k+u5Way9BOrqV250e
         RAH0EZktjXdaH8/+XAndrJ7HcHfqHWOZOBxjkpnBZKJ+SdTPh8sUMqzHfKWJGkO541Ri
         xEoO4iEQEHh6tw8IheNYDGcOVB0WdTyyq4jTd0QZ2eAtCfTtZ7AZpRwLtDhF8Y8uLsGH
         X2UcNTUdN8O1ONP161O/c0B9pmjtz/2WvEpDi647gvHvq1L9FR8vq9s5W6rw0DfEv2EY
         NthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ijxTmjdlgxicdkmgADMXVlZyZ1EFgGLvCoRfMwK9taI=;
        b=Q0jCGXlgMz2IHnjTQPUxPqBjhuHU0Os+qqrDHGC9EGUGxRudjLMFLTKbLHqhAriA9b
         qbB/A3iHD/3leI4T6BQv+RyIwkAiWbLNpPVKR4gzv/xocqbSXmNBdFPN7s6ZAg1jhtBr
         J4tGAd0CnUKziT4D/PhYdX2Gfycc0li5uQb2CTwk2+TGi7tJKEWwdVh1Ws4QrD9seLkB
         i8/OeWaBMRL8nDW1N0RQOg7baR15tUsCYfpm920sqvwndwKGQeRb8d3NDjwI/rKhoCWg
         ILd/H+EBxLJhDKQDJK6aKzDncEi4HFhLhCGGk3houegENt30poOX7t/rOUqU8f2vTVVH
         hnvw==
X-Gm-Message-State: AOAM532mEMnWQYZumDOXj64rOkBz0C3ZQKa3wIUZpOJ4aN3AyLsqBWtg
	yMJ9va+kTyXMV3qpegnZxR9d2eBouyk=
X-Google-Smtp-Source: ABdhPJzkiqwG17G9FrOKMJetcRaTMuL52yVuEhn0IU84s3FGr/DtDy2rT+eSdNDQODEAp65taYmudQ==
X-Received: by 2002:a17:90a:9f4a:: with SMTP id q10mr8702560pjv.113.1617282637724;
        Thu, 01 Apr 2021 06:10:37 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id v11sm5700492pgg.68.2021.04.01.06.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 06:10:36 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: add tracepoint in mptcp_subflow_get_send"
Date: Thu,  1 Apr 2021 21:10:32 +0800
Message-Id: <75f3ea225debe0e777200cc5b716102d33f66a3c.1617282606.git.geliangtang@gmail.com>
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
 include/trace/events/mptcp.h | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index d07ca1216442..41a27177d59b 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -31,22 +31,28 @@ TRACE_EVENT(mptcp_subflow_get_send,
 	),
 
 	TP_fast_assign(
-		bool sk = sk_fullsock(subflow->tcp_sock);
+		struct sock *ssk;
+		bool sk;
 
 		__entry->active = mptcp_subflow_active(subflow);
+		__entry->free = 0;
+		__entry->snd_wnd = 0;
+		__entry->pace = 0;
 		__entry->backup = subflow->backup;
-		if (sk) {
-			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-
-			__entry->free = sk_stream_memory_free(subflow->tcp_sock);
-			if (ssk) {
-				__entry->snd_wnd = tcp_sk(ssk)->snd_wnd;
-				__entry->pace = ssk->sk_pacing_rate;
-				if (__entry->pace)
-					__entry->ratio = div_u64((u64)ssk->sk_wmem_queued << 32,
-								 __entry->pace);
-			}
-		}
+		__entry->ratio = 0;
+
+		sk = sk_fullsock(subflow->tcp_sock);
+		if (!sk)
+			return;
+		__entry->free = sk_stream_memory_free(subflow->tcp_sock);
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (!ssk)
+			return;
+		__entry->snd_wnd = tcp_sk(ssk)->snd_wnd;
+		__entry->pace = ssk->sk_pacing_rate;
+		if (!__entry->pace)
+			return;
+		__entry->ratio = div_u64((u64)ssk->sk_wmem_queued << 32, __entry->pace);
 	),
 
 	TP_printk("active=%d free=%d snd_wnd=%u pace=%u backup=%u ratio=%llu",
-- 
2.30.2

