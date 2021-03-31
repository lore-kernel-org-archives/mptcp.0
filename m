Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA35F
	for <mptcp@lists.linux.dev>; Wed, 31 Mar 2021 07:23:58 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id v186so13553938pgv.7
        for <mptcp@lists.linux.dev>; Wed, 31 Mar 2021 00:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oogI/ctjFITv3D+g9ZqGUocTg86xCI4820f1A1fndLc=;
        b=F3mLE4J48JxAZbyZT2ao6Ko18CYSQTvyiTDCiS8gFCyqkDRlJDomNuS+fGSH7KwHDY
         PGOp3nhGZGm55jeF2sF76276PLhvrZFOLhKECZ1jPAXl2YYYvIQANjVke7Edh6AjKFk4
         zZBIcv31SMlALuwVv6Yup+FcQSUvl+pcIlV0UWoDrJ+mdtG7WUo8Oi/l/kfONbSRe/iK
         hVQYUQr+zaVRufgBUgo7gBT8lR7rTDXi/UZ5Ua9kat8u30KwxjtwaPEa87ISZIZgtYrP
         e9b4Xa0FxFRS2h5JomumyRneRhvUQwPpR7YgQdJYNkjYueZX9PtYYW+CQ/mCPKywFppW
         ttBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oogI/ctjFITv3D+g9ZqGUocTg86xCI4820f1A1fndLc=;
        b=eYeWuWND3Jbq07hP6kB2dt4csu5F8f1N1fE/SMs8k1+Cltp3xZg3qnoOL1pVy9BlY6
         ouvKtoqiZ5klPXez4wtzsCnh8riPLf2uZyknA3WkPY3K/yoG4n6dUZcE7VSjaGag/I1C
         Bgayf4A+JSr7w1rffpwFvRGP9+2WnH1X1euwKAQB5bWU8deS0tkl8TNBMWpdIEyBjjlW
         GfJ5gKPY1b5+oqz/lYA443vjfWiC5+kHlDxScLNwMWJwCaxi92a/3vueZmdjgWETaX7D
         Zecy6qAs3RQScRIKJA9oXZIt5lAX+68nPVTmeCTdYZN3Dq7PMmrJizRtydkAYF+DAmjv
         iKBw==
X-Gm-Message-State: AOAM531j6qZG0sqwn0amlpVOwJVWX+X//gSv1UohW8ejsW2SJDzt5Rss
	oZClb0/ySyU5sbqOS6MB32JaMIQPz+k=
X-Google-Smtp-Source: ABdhPJzMfO7JRj2xmv5cplG3BholtnlSwYUidkdVceTB5ce/AKyRrog4xWWWFqi7X0uq8O6FPmT+zw==
X-Received: by 2002:a63:925a:: with SMTP id s26mr1893773pgn.216.1617175437441;
        Wed, 31 Mar 2021 00:23:57 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id t3sm1132976pfg.176.2021.03.31.00.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 00:23:56 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v4 mptcp-next 5/5] mptcp: add tracepoint in subflow_check_data_avail
Date: Wed, 31 Mar 2021 15:23:36 +0800
Message-Id: <44a5c5c034e3ca4b497133df3186c67ac4455b2b.1617175133.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <5142b94c3a4af83d619c964e96c04decb8907959.1617175133.git.geliangtang@gmail.com>
References: <cover.1617175133.git.geliangtang@gmail.com> <69be5c2c98752dfe6cfe572ef5f13ff701618bd0.1617175133.git.geliangtang@gmail.com> <9a7fe804a654722cab2b7b4cd97f21a5f27ec2cb.1617175133.git.geliangtang@gmail.com> <e2100f55ef22c52ba10b699c8362189d501d4ca1.1617175133.git.geliangtang@gmail.com> <5142b94c3a4af83d619c964e96c04decb8907959.1617175133.git.geliangtang@gmail.com>
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
index b4e6ca941bb7..902772c439dc 100644
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
 
 	TP_PROTO(struct mptcp_subflow_context *subflow),
@@ -131,6 +139,27 @@ TRACE_EVENT(ack_update_msk,
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

