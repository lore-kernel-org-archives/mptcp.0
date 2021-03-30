Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E33D72
	for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 09:17:04 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id o2so5832350plg.1
        for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 02:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bokzk5BdbUVu7d+6WvUk3pxTZpGqytJ/GJcVU19y+Kc=;
        b=c5Zc4r6tAhsqG4JY6rYO6uQjrpj1GTqDOp9bH0KlREaqadc71GAldtbIfVZ24r1LDA
         pG4R0RO2cxDhVqh7x9aCo1MNZFxkinO2mzCJ/Ha7KOffYHKVOMrnnTpv69TbfVOHVofs
         Y5w6U63VjFTLuBhjHD2GMov8nmJ+Nwo1d/4Ql44CohJIUN9YJCU+EuW4nb6/yntg/ni8
         DhSSWALxjahdRCx6P7Vqk/VBlugA/IHTYUTQb5yU6uArI1VWGXqoDN32yNIxkGDE1Y9J
         060485jZIDqnojcLrDi+sIu0Dr3XyCFReyIEe2B1W9tbDe8WY5TQm4uAjgs2zUKRTdr2
         AhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bokzk5BdbUVu7d+6WvUk3pxTZpGqytJ/GJcVU19y+Kc=;
        b=LpKqLn4Cbn0eynq+s815It1rBySNxbaUJYZtYv7NEmZV+wOfdoLLb5WchvRwKvBw1P
         xWS1rRLgUEOLYFtHG03wYLV7JEacaDNk26UUJPufk1CrrxvWAHN1o8K137+l/tAo741o
         jHKjf/AuVeDUVSWhkjlaTE919MIYfBy0n2Vq+dvLFS+bdnTfjXmVLRbztwCG89sOFJFi
         za7mQiaRI6nv9XyUjWY5nHk/J40Inbfc1ur13CzdfS9nIHYOMJXrAGLLoZwHT3pcib8U
         V0YtMvQdWYzf4zhXdjZqNV7rqp2MdFZDRaxYYwqA52Bbfi1K0lWjcrvxVwesn370Dv1s
         rNZg==
X-Gm-Message-State: AOAM531EIg8RNcyNOeo+rBVtqMLsqeRPnVu4qLl6BZRWBOzesrLaC7Ea
	RHTJvav4lrzLco+qy7BsRi0uq++1b34=
X-Google-Smtp-Source: ABdhPJwS+uiYiMbJ4LpyAQa+gucPgr4OWyx7a7rc4GMjwFNzn14UcM/56d1yerkiwIL7t0ccUhrb5A==
X-Received: by 2002:a17:902:b942:b029:e4:87be:be8c with SMTP id h2-20020a170902b942b02900e487bebe8cmr32122234pls.81.1617095823331;
        Tue, 30 Mar 2021 02:17:03 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id w17sm17617909pfu.29.2021.03.30.02.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:17:02 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v3 mptcp-next 4/4] mptcp: add tracepoint in subflow_check_data_avail
Date: Tue, 30 Mar 2021 17:16:46 +0800
Message-Id: <4debf3d4aa255b36f992a6fbc37ccc95d491863d.1617095554.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <9ad9ef463c1dff8f022abec2e683f4fbee0f4a96.1617095554.git.geliangtang@gmail.com>
References: <cover.1617095554.git.geliangtang@gmail.com> <c69ce9cc277fd134a5254dee68436f6035ab594e.1617095554.git.geliangtang@gmail.com> <f4084ca4e2f287461cdf552619b89596a429d042.1617095554.git.geliangtang@gmail.com> <9ad9ef463c1dff8f022abec2e683f4fbee0f4a96.1617095554.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a tracepoint in subflow_check_data_avail() to show the
mapping status.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/trace/events/mptcp.h | 29 +++++++++++++++++++++++++++++
 net/mptcp/subflow.c          |  4 +---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index b390317bd98a..0cfbb236d44c 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -7,6 +7,14 @@
 
 #include <linux/tracepoint.h>
 
+#define show_mapping_status(status)					\
+	__print_symbolic(status,					\
+		{ 0, "MAPPING_OK" },					\
+		{ 1, "MAPPING_INVALID" },				\
+		{ 2, "MAPPING_EMPTY" },					\
+		{ 3, "MAPPING_DATA_FIN" },				\
+		{ 4, "MAPPING_DUMMY" })
+
 TRACE_EVENT(mptcp_subflow_get_send,
 
 	TP_PROTO(bool active, bool free, u32 snd_wnd,
@@ -123,6 +131,27 @@ TRACE_EVENT(ack_update_msk,
 		  __entry->msk_wnd_end)
 );
 
+TRACE_EVENT(subflow_check_data_avail,
+
+	TP_PROTO(__u8 status, struct sk_buff *skb),
+
+	TP_ARGS(status, skb),
+
+	TP_STRUCT__entry(
+		__field(u8, status)
+		__field(const void *, skb)
+	),
+
+	TP_fast_assign(
+		__entry->status = status;
+		__entry->skb = skb;
+	),
+
+	TP_printk("mapping_status=%s, skb=%p",
+		  show_mapping_status(__entry->status),
+		  __entry->skb)
+);
+
 #endif /* _TRACE_MPTCP_H */
 
 /* This part must be outside protection */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a88c2b1e5410..d79a99c2bfc4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -998,8 +998,6 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	struct mptcp_sock *msk;
 	struct sk_buff *skb;
 
-	pr_debug("msk=%p ssk=%p data_avail=%d skb=%p", subflow->conn, ssk,
-		 subflow->data_avail, skb_peek(&ssk->sk_receive_queue));
 	if (!skb_peek(&ssk->sk_receive_queue))
 		subflow->data_avail = 0;
 	if (subflow->data_avail)
@@ -1011,7 +1009,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		u64 old_ack;
 
 		status = get_mapping_status(ssk, msk);
-		pr_debug("msk=%p ssk=%p status=%d", msk, ssk, status);
+		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
 		if (status == MAPPING_INVALID) {
 			ssk->sk_err = EBADMSG;
 			goto fatal;
-- 
2.30.2

