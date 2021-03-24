Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2246F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 08:52:03 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id y5so16834640pfn.1
        for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 01:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+yo6slxNdqSXPtMaMQC/3HAaTl8XiamMVGMEeTYT85U=;
        b=AV7UfQgC2jdf9SnzSsMzWZFquPK5H1T2YHF2HviinwmV/8DHMySos0F4IUQbQcpRIW
         pF352BbpCiEPiZJPKrsbDAo61gVx6E/iyfcyjQRhyDBAJT8hvJra0OmpJHieMce0rhga
         MHn3gE+QbEjw/ODYG40I6LB10R8wa47Pwf9crkvrzPjflio9SDm0415tdoUEaNMQaYNa
         o6F/Wvj/ByujcKXneL3CZTY3iBRzMEQfYN9HwCkBAOPipWia5ywjvUFGw0L4y8HBboww
         S0eltmmFjBTkY/NNZfOk56muBp5vA4wX/PcNL83o3erHDYEDk8fQdU+bfJKkR2ftpitf
         PllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+yo6slxNdqSXPtMaMQC/3HAaTl8XiamMVGMEeTYT85U=;
        b=qKR48+0OwXCWX0vK0AbMv1LurRnTuIAzeX5kMXwmeUx5a6TfsUUSfCY4CHf2jLbVVl
         G3vDPz1X0aMIyi9VhMnqx4EeLB32BYbBlFi7Vn2zGK1UGPIr+a/am1tsgbAu7M27vhKY
         Nsd2oJDPwQDMmth6LsL5cuL3KhWKA6tsJF0kwr3XSV8yQdopm6fp1SFxiEfKe9R19+kS
         Zuyis3DAiqzsmdXCgvXO2kmgfYL2xdc0hpnuTeAsC3XU5LHNncBGYDz+U0nDTUbcy2rx
         h1D6r6Wymk45I/NWHQhgnRgldUOsTHe9/WbBSPU/ipO8nqRqxiEFBTB456MIRcZJ95qa
         2dtg==
X-Gm-Message-State: AOAM530wJq3UtmWAT8Fy0ofKRokQXmG70ALvvToyFBGOYkP1bU8l8N5j
	eltyCLUUKAZCi1gMwYlLymjc3E0aa/qEsA==
X-Google-Smtp-Source: ABdhPJyX7msoUI0JmNw1mduftR6v7OMeyJmD+s1FPiYjzG3/CIJS/GjY32q446b7d2rfMXKx+fy+hw==
X-Received: by 2002:a63:348c:: with SMTP id b134mr2226795pga.86.1616575922845;
        Wed, 24 Mar 2021 01:52:02 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x69sm1718696pfd.161.2021.03.24.01.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 01:52:02 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.01.org,
	mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v2 mptcp-next 5/5] mptcp: add tracepoint in subflow_check_data_avail
Date: Wed, 24 Mar 2021 16:51:39 +0800
Message-Id: <5d104cddc4aa0acc4f9c0b70db33e002043d7118.1616575602.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0662c0637222901b447135bb10aaad7dea9b4a49.1616575602.git.geliangtang@gmail.com>
References: <cover.1616575602.git.geliangtang@gmail.com> <6e606e2aeb7ea4bdd1618783cb24675bcde693b2.1616575602.git.geliangtang@gmail.com> <ffa353e9982d4795058abc87f1e2f52bc29e430b.1616575602.git.geliangtang@gmail.com> <9b74169474a157c54953de796bc35ef54a710a18.1616575602.git.geliangtang@gmail.com> <0662c0637222901b447135bb10aaad7dea9b4a49.1616575602.git.geliangtang@gmail.com>
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
index 2b8ae5e81cd1..5571c45c61f2 100644
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
 
 	TP_PROTO(struct mptcp_subflow_context *subflow, struct sock *ssk),
@@ -116,6 +124,27 @@ TRACE_EVENT(ack_update_msk,
 		  __entry->new_snd_una, __entry->new_wnd_end)
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
index dc08e5de807e..de8f16006fce 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -993,8 +993,6 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	struct mptcp_sock *msk;
 	struct sk_buff *skb;
 
-	pr_debug("msk=%p ssk=%p data_avail=%d skb=%p", subflow->conn, ssk,
-		 subflow->data_avail, skb_peek(&ssk->sk_receive_queue));
 	if (!skb_peek(&ssk->sk_receive_queue))
 		subflow->data_avail = 0;
 	if (subflow->data_avail)
@@ -1006,7 +1004,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		u64 old_ack;
 
 		status = get_mapping_status(ssk, msk);
-		pr_debug("msk=%p ssk=%p status=%d", msk, ssk, status);
+		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
 		if (status == MAPPING_INVALID) {
 			ssk->sk_err = EBADMSG;
 			goto fatal;
-- 
2.30.2

