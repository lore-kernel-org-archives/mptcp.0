Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94BC72
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 06:40:01 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id ge1so2807495pjb.2
        for <mptcp@lists.linux.dev>; Wed, 05 May 2021 23:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vtOUOV4yeQ1B5Q9SExm0XgIDX2qz2MsnQsGRDOzJW/A=;
        b=MIRDmF6H7yyvhQXAv2M9DJ2+h13ZK7yvhCL3YcjT0c2FetVeiwXak3eRtmbMTIpaXw
         q0CxH3rXQExqv9qzLgT7iMp0avjgciD1DOyoFy11a4fphUEihA3gYwSonSErCsPHG2OS
         ng28uddkMZAiDvZMNwLWjj2qyETvtZIiuNv/iBQvDUbKfwUdAocu7EtMErQBH1dDWIic
         arJ+BoXlrNdoOyaeeXCfIJVpI9nJo8wAdHl0oBDQwVEJ2ADQEtSVv5cLwpzH6UeSNc7J
         obf9mA29sCtir5e1Lu78hHuM4Y60GbFcdkAoKdaHtaao5HeXbT5XQP6MXjuoEAQbAm73
         pyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vtOUOV4yeQ1B5Q9SExm0XgIDX2qz2MsnQsGRDOzJW/A=;
        b=iwaqVp9QFtjpbLMyIqMHCjWL5EdasFF4+RW+J9WwrkZ2CUoqHPC/VwyiO4e/qcM7LA
         Wi9oEc1ycGskiR3rOVQAojTd3xyRE38C5kAXZMKPrM3iAX3ouewyugxGcWYX1NjcOBjf
         YQiGAQUuKPhbdsVABJ49we9IrmYh16PTleA1xTuSjfQVGC9Io56HbUQZCdifRDIkHXoU
         fDQZPzDBCj/zvJdcgfTY108LESsbjGHH7vpMZRseblYa4LPMXGhbvxz+B29FprcLAZxq
         jl02HLbXL5+O9xKJZmz2NWgtOreFn72u9D2hbe3JhP3CNOquC7lizBzOVVZ2u5uqOWLD
         NIUw==
X-Gm-Message-State: AOAM53340rKmCadIwNqB9fzhdOEOt12/dahBLzbaRIdaBzClvdzBXujN
	0AWQn5naHOUXPUYeoq+prjj33f59h+k=
X-Google-Smtp-Source: ABdhPJzz9jbF8s9IwrXchQgV1BPEmg1bQgiBxJZJ3/+wgYqEset3uSvuvKKg+NPh/IpkvDyNQeu3vQ==
X-Received: by 2002:a17:902:a515:b029:eb:2723:3fde with SMTP id s21-20020a170902a515b02900eb27233fdemr2773197plq.56.1620283201422;
        Wed, 05 May 2021 23:40:01 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id t133sm1130925pgb.0.2021.05.05.23.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 23:40:01 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 1/3] mptcp: MP_FAIL suboption sending
Date: Thu,  6 May 2021 14:39:51 +0800
Message-Id: <f158cbfcb748b9b6792d9b316b8fa810e5cb044a.1620282929.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620282929.git.geliangtang@gmail.com>
References: <cover.1620282929.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the MP_FAIL suboption sending support.

Add a new flag named send_mp_fail in struct mptcp_subflow_context. If
this flag is set, send out MP_FAIL suboption.

Add a new member fail_seq in struct mptcp_out_options to save the data
sequence number to put into the MP_FAIL suboption.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/options.c  | 46 +++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  4 ++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index cb580b06152f..f48d3b5a3fd4 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -72,6 +72,7 @@ struct mptcp_out_options {
 	u32 nonce;
 	u64 thmac;
 	u32 token;
+	u64 fail_seq;
 	u8 hmac[20];
 	struct mptcp_ext ext_copy;
 #endif
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4179287bd647..485c5a77e71b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -777,6 +777,28 @@ static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_bu
 	opts->reset_reason = subflow->reset_reason;
 }
 
+static bool mptcp_established_options_mp_fail(struct sock *sk,
+					      unsigned int *size,
+					      unsigned int remaining,
+					      struct mptcp_out_options *opts)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+
+	if (!subflow->send_mp_fail)
+		return false;
+
+	if (remaining < TCPOLEN_MPTCP_FAIL)
+		return false;
+
+	*size = TCPOLEN_MPTCP_FAIL;
+	opts->suboptions |= OPTION_MPTCP_FAIL;
+	opts->fail_seq = subflow->fail_seq;
+
+	pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
+
+	return true;
+}
+
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts)
@@ -792,8 +814,16 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	if (unlikely(__mptcp_check_fallback(msk)))
 		return false;
 
+	if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
+		*size += opt_size;
+		remaining -= opt_size;
+		ret = true;
+	}
+
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
-		mptcp_established_options_rst(sk, skb, size, remaining, opts);
+		mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts);
+		*size += opt_size;
+		remaining -= opt_size;
 		return true;
 	}
 
@@ -1338,6 +1368,20 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 				      opts->backup, TCPOPT_NOP);
 	}
 
+	if (OPTION_MPTCP_FAIL & opts->suboptions) {
+		const struct sock *ssk = (const struct sock *)tp;
+		struct mptcp_subflow_context *subflow;
+
+		subflow = mptcp_subflow_ctx(ssk);
+		subflow->send_mp_fail = 0;
+
+		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
+				      TCPOLEN_MPTCP_FAIL,
+				      0, 0);
+		put_unaligned_be64(opts->fail_seq, ptr);
+		ptr += 2;
+	}
+
 	if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
 		*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
 				      TCPOLEN_MPTCP_MPJ_SYN,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 41baa2ffc9a9..ff70b3e97dd0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -26,6 +26,7 @@
 #define OPTION_MPTCP_FASTCLOSE	BIT(8)
 #define OPTION_MPTCP_PRIO	BIT(9)
 #define OPTION_MPTCP_RST	BIT(10)
+#define OPTION_MPTCP_FAIL	BIT(11)
 
 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -67,6 +68,7 @@
 #define TCPOLEN_MPTCP_PRIO_ALIGN	4
 #define TCPOLEN_MPTCP_FASTCLOSE		12
 #define TCPOLEN_MPTCP_RST		4
+#define TCPOLEN_MPTCP_FAIL		12
 
 #define TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM	(TCPOLEN_MPTCP_DSS_CHECKSUM + TCPOLEN_MPTCP_MPC_ACK_DATA)
 
@@ -419,6 +421,7 @@ struct mptcp_subflow_context {
 		mpc_map : 1,
 		backup : 1,
 		send_mp_prio : 1,
+		send_mp_fail : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1;	    /* ctx can be free at ulp release time */
@@ -433,6 +436,7 @@ struct mptcp_subflow_context {
 	u8	reset_seen:1;
 	u8	reset_transient:1;
 	u8	reset_reason:4;
+	u64	fail_seq;
 
 	long	delegated_status;
 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
-- 
2.31.1

