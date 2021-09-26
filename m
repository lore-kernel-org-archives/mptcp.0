Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EA93FCB
	for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 14:29:47 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id x191so8273232pgd.9
        for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8pEVYQmO+Vs8OD4UzwV8aPzQVxwvvtDwq1B52ddwyoE=;
        b=cn/WzZ47W5siC2ZGMa2HeJ6b5YSFSOajjh5o7L/gs6xUMRyhqwdDS3mCatZuMQcu4t
         8oV1RK1BxZx5ki08HLnoESWtZ9jG9ZY6BSJIeUtlkPYMjZJaxT29gyaVhjMlsYCZD/mG
         iGpGpXlEoXT0c0Pe/UfiJUgwCgv5Xoppen6YfG41KLzWeaFhvOBx8g4gnK66YX6/HcLC
         LViUEzL8t64FgYkFgiBewq9TyLJRPNJNfh3qOcGwkdx0+Q8nU6dNTOiTO3jMcemA1v2s
         Rtry/9JKTiVajIKAD6ZIlVvQXNRHkaKLcOLqtL5hMews4jGkhW3wjMww/uIV3QWH41f7
         nHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8pEVYQmO+Vs8OD4UzwV8aPzQVxwvvtDwq1B52ddwyoE=;
        b=1xZx00lohaX0QgzTO0LNxjnaq0bb4MMBS5HpA94KD+sg4MF6K1/rSJJ04RpM+x1aR9
         v9Gli3q7NdU/Qm7zT2V+F1eNOLNS/+mWifVlV+kYw3tKMoNuAUfHBqxTt4sSU+wbWHwF
         0lJB/iNocH8YLTW9bmef8NodBTv62l/Morad010rAFtgzP6vKpnFIpwbzqjwnM4h2r3Y
         pjxaVTCk05DRrVOQy4HU+h1gfCWXd9NNDepe+foiA4v0xIducYI5TihKDqZ0wF+xDYpE
         YslG9pWXeYbwGzUmpJrgIWsyrh3u4pbCnN0bGrqaUzynItIIHoVOduWgQfndAA7ncwhF
         pE+w==
X-Gm-Message-State: AOAM5302k9wAMDYER8623Uo+8lRGbISjlbbuBIpNysWL49VSU/StDRE5
	h+oXxHKfHoQPPBNanAGwGDkf/uoy6+0=
X-Google-Smtp-Source: ABdhPJzkyM29+0M+nQ9ySBypfj7g6QZZqsXN0NTCe/tDi9ppt6c2G5hHDMbhFC9DWaOEvAF0S+245w==
X-Received: by 2002:aa7:968e:0:b0:447:a593:926e with SMTP id f14-20020aa7968e000000b00447a593926emr18925766pfk.27.1632666587308;
        Sun, 26 Sep 2021 07:29:47 -0700 (PDT)
Received: from MiBook.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x9sm2421082pjr.44.2021.09.26.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 07:29:47 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v5 1/8] mptcp: track and update contiguous data status
Date: Sun, 26 Sep 2021 22:29:31 +0800
Message-Id: <50885831cb65affbe180d3d9be3ba879f8e331f2.1632666254.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632666254.git.geliangtang@gmail.com>
References: <cover.1632666254.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new member last_retrans_seq in mptcp_subflow_context
to track the last retransmitting sequence number.

Add a new helper named mptcp_is_data_contiguous() to check whether the
data is contiguous on a subflow.

When a bad checksum is detected and a single contiguous subflow is in use,
don't send RST + MP_FAIL, send data_ack + MP_FAIL instead.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c |  6 ++++++
 net/mptcp/protocol.h |  8 ++++++++
 net/mptcp/subflow.c  | 12 ++++++------
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f8ad049d6941..cf8cccfefb51 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -729,6 +729,9 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	if (unlikely(subflow->disposable))
 		return;
 
+	if (!subflow->last_retrans_seq || mptcp_is_data_contiguous(ssk))
+		subflow->last_retrans_seq = tcp_sk(ssk)->snd_una - 1;
+
 	ssk_rbuf = READ_ONCE(ssk->sk_rcvbuf);
 	sk_rbuf = READ_ONCE(sk->sk_rcvbuf);
 	if (unlikely(ssk_rbuf > sk_rbuf))
@@ -2415,6 +2418,7 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
 	size_t copied = 0;
@@ -2464,6 +2468,8 @@ static void __mptcp_retrans(struct sock *sk)
 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
+		subflow = mptcp_subflow_ctx(ssk);
+		subflow->last_retrans_seq = tcp_sk(ssk)->snd_nxt;
 	}
 
 	release_sock(ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7379ab580a7e..e090a9244f8b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -416,6 +416,7 @@ struct mptcp_subflow_context {
 	u32	map_data_len;
 	__wsum	map_data_csum;
 	u32	map_csum_len;
+	u32	last_retrans_seq;
 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_join : 1,   /* send MP_JOIN */
 		request_bkup : 1,
@@ -625,6 +626,13 @@ static inline bool mptcp_has_another_subflow(struct sock *ssk)
 	return false;
 }
 
+static inline bool mptcp_is_data_contiguous(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+
+	return before(subflow->last_retrans_seq, tcp_sk(ssk)->snd_una);
+}
+
 void __init mptcp_proto_init(void);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int __init mptcp_proto_v6_init(void);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6172f380dfb7..a8f46a48feb1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1166,15 +1166,15 @@ static bool subflow_check_data_avail(struct sock *ssk)
 fallback:
 	/* RFC 8684 section 3.7. */
 	if (subflow->send_mp_fail) {
-		if (mptcp_has_another_subflow(ssk)) {
+		if (mptcp_has_another_subflow(ssk) || !mptcp_is_data_contiguous(ssk)) {
+			ssk->sk_err = EBADMSG;
+			tcp_set_state(ssk, TCP_CLOSE);
+			subflow->reset_transient = 0;
+			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+			tcp_send_active_reset(ssk, GFP_ATOMIC);
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
 		}
-		ssk->sk_err = EBADMSG;
-		tcp_set_state(ssk, TCP_CLOSE);
-		subflow->reset_transient = 0;
-		subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
-		tcp_send_active_reset(ssk, GFP_ATOMIC);
 		WRITE_ONCE(subflow->data_avail, 0);
 		return true;
 	}
-- 
2.31.1

