Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0915070
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 06:45:23 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so12870521pjh.3
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 23:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PtUAG3IAgWzSngLGBF4+uY7YKRDIkxHqIh1hfjsiBhg=;
        b=YWr0084xRBL8f4PRB8zPNwjg1YAzyIgLYzVb+3kXJ5nvCp0YnZOtTuy3kZ7wKng89I
         c/nZdyaE46cl4v7G20QyvPLD2BHjDpfEweXwm4K59YZ0u3AIJg1RAudVDBzEfxNSgAb6
         17b/N2fsiMak/oZsZcyu1OlUS0Zr5DePLJiCY7sLqeY1wzZFZYtqj7qHQqGhA4sIGSzy
         p7d7v1S0tUP9LV1St1m8doh5dIsH4JUdRk5N69LgkUKdoW1xfCb2/RATqGmA5nUdNq8Z
         vg0tRrN0jK/FMn9ktwmcCYvPCfLurqTMVQV82vklp7K2JnjNDjQLaRr5vProufOJbTvV
         KvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PtUAG3IAgWzSngLGBF4+uY7YKRDIkxHqIh1hfjsiBhg=;
        b=L3UiKIuxSbpp9eciU4jHmRUIpGvIQUlaqUjAzxoZQmL+ylUaQSjsR+6DjNpemLoGPN
         5RlD7BvvdSYjiE9QvASfaTOa6J9tBA+GMSlNIaLGVtkUsa0UWS17F61aVFi/LU9KLGxt
         wD0iVXplvHJkjlP7BxvndyO8ep+z7YuRzJU1KjzfQamKsNlTB1Ydb+T2tJCuoDnZwkL1
         GtiLj5wufk7/QRS/Dtj7GYxxzd39ecNjR9b+ZjkPjX4diqb1qDraj9R7Bwqek+lKers0
         tsDK8e631T0kkreU8Mw2WdNqGjh9QoQ0j+L/RofB14j8iAHAXBt4t3kcAM+yGJMdKR38
         jmiw==
X-Gm-Message-State: AOAM532bliwgT+MyvOdXxKjY9rhjY26vY3kaonCAxn6RXuTdwbjL7gyZ
	OvBQnIBxAm7VoIDslPPqzktCPHn4gmxrRQ==
X-Google-Smtp-Source: ABdhPJykWF+5Tqac+F2hHGPQoMh9HBtrLQJwqmNtJgII9kHqYy0BIyQAQSLznXUJ/QyGMKIDofEWug==
X-Received: by 2002:a17:903:2445:b029:12b:9d0e:6b97 with SMTP id l5-20020a1709032445b029012b9d0e6b97mr13414974pls.84.1627281923447;
        Sun, 25 Jul 2021 23:45:23 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id k11sm10634697pgc.30.2021.07.25.23.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 23:45:23 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v5 mptcp-next 1/5] mptcp: MP_FAIL suboption sending
Date: Mon, 26 Jul 2021 14:45:11 +0800
Message-Id: <fce3d982e418e791fc38dd2e9f116de84e429d21.1627281326.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627281326.git.geliangtang@xiaomi.com>
References: <cover.1627281326.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added the MP_FAIL suboption sending support.

Add a new flag named send_mp_fail in struct mptcp_subflow_context. If
this flag is set, send out MP_FAIL suboption.

Add a new member fail_seq in struct mptcp_out_options to save the data
sequence number to put into the MP_FAIL suboption.

An MP_FAIL option could be included in a RST or on the subflow-level
ACK.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 include/net/mptcp.h  |  5 +++-
 net/mptcp/options.c  | 61 +++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  3 +++
 3 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d0b9e4a7121f..6c8c8592153d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -60,7 +60,10 @@ struct mptcp_out_options {
 	u16 suboptions;
 	u64 sndr_key;
 	u64 rcvr_key;
-	u64 ahmac;
+	union {
+		u64 ahmac;
+		u64 fail_seq;
+	};
 	struct mptcp_addr_info local;
 	struct mptcp_addr_info remote;
 	struct mptcp_rm_list rm_list;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6803de5d4209..a7365379096d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -754,7 +754,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
 	return true;
 }
 
-static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_buff *skb,
+static noinline bool mptcp_established_options_rst(struct sock *sk, struct sk_buff *skb,
 						   unsigned int *size,
 						   unsigned int remaining,
 						   struct mptcp_out_options *opts)
@@ -762,12 +762,36 @@ static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_bu
 	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
 	if (remaining < TCPOLEN_MPTCP_RST)
-		return;
+		return false;
 
 	*size = TCPOLEN_MPTCP_RST;
 	opts->suboptions |= OPTION_MPTCP_RST;
 	opts->reset_transient = subflow->reset_transient;
 	opts->reset_reason = subflow->reset_reason;
+
+	return true;
+}
+
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
+	opts->fail_seq = subflow->map_seq;
+
+	pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
+
+	return true;
 }
 
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
@@ -786,15 +810,30 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 		return false;
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
-		mptcp_established_options_rst(sk, skb, size, remaining, opts);
+		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
+			*size += opt_size;
+			remaining -= opt_size;
+		}
+		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
+			*size += opt_size;
+			remaining -= opt_size;
+		}
 		return true;
 	}
 
 	snd_data_fin = mptcp_data_fin_enabled(msk);
 	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, remaining, opts))
 		ret = true;
-	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts))
+	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts)) {
 		ret = true;
+		if (opts->ext_copy.use_ack) {
+			if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
+				*size += opt_size;
+				remaining -= opt_size;
+				return true;
+			}
+		}
+	}
 
 	/* we reserved enough space for the above options, and exceeding the
 	 * TCP option space would be fatal
@@ -1343,6 +1382,20 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
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
index 34ad1c4bc29f..ea4ab9b9d6db 100644
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
 
@@ -428,6 +430,7 @@ struct mptcp_subflow_context {
 		mpc_map : 1,
 		backup : 1,
 		send_mp_prio : 1,
+		send_mp_fail : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
-- 
2.31.1

