Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABE972
	for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 07:22:32 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id r2so11888619pgl.10
        for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 00:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=036WBmo2fq/nu8NjUtwi6s/jaUAfswxnt0NAieyWV0k=;
        b=ozCbzENEWqeMIl4UY8+z6BoqzejeBqhCxzk83f7Rw5HsEQK/MnQ0hIhNIo+BSkGPrJ
         A1Pu0mt6cS4zy92a4BZIcE8HMZfjCZFxmzNdOYmedkXW+++9+nmXO3I+PcbAD5SFIqIp
         dzNNrmqGIe4P5zb5kBEAGCw8jDOxRClSwes43EVkemi3qpTa2XIHQMP7cVQpIKQOTjr0
         BPJSGR2EtkWbFeyKObTOdVrzc1XT3H7P7wdjTrJcssRWRtiySNY0/gqFHpk85d9e8YX6
         pl4XvSIr8GMMHbMuc9Rm/ogaAJ6NxnIzDsfNOJlK9167vvsa6yTicOT8UeLB/gcuDehV
         jxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=036WBmo2fq/nu8NjUtwi6s/jaUAfswxnt0NAieyWV0k=;
        b=ej8f6AKRXN93SbyGt9O8R53CaXpyP+5GmfYBxqQz44hhmbuBr5YoJRTppbrwaBIfGB
         EzXDkfkLgMD84X+ZsdMLUQB1AU5bjiOB8HVFxdkaEuJM0p9nAb7O8WF3tib8EwHDZx3x
         pcg+J/11Cj3xHpXPeYEM76ZGScUZ4RBMMaQcDIOqtsHNCPf+yruHFW2phjqN9Gtz3Ek/
         2+uRJD7DecxQ5Sv5zpKAZVx5wwFJ6bYwaJ84YiBeB6UZeI6T8mMgVMUNA5l58bmf8v9y
         2dNDTvR5eikIONJ9FmHxXlQz9AUscPjE8ssy6oLdFsBNfgsaMewv50w2Ppq3Lf64/EV0
         1Udw==
X-Gm-Message-State: AOAM5327oa1phGkQ4Rlcx8jRrjLneGUaRiZyilZFix+iXRe1VA62jV7F
	d39G1Fpj+e/UXV1sHIz7ba6Z9UBjLVQ=
X-Google-Smtp-Source: ABdhPJxV1A/z0dZE0gcByo7ijHvZi1HVsYl9UeKrbCZP4JDkuniYBqeWxM7Ir6TP2o7Mu/Xb9y/cwA==
X-Received: by 2002:aa7:83d8:0:b0:3ef:990f:5525 with SMTP id j24-20020aa783d8000000b003ef990f5525mr14785632pfn.29.1631949752316;
        Sat, 18 Sep 2021 00:22:32 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 77sm8040214pfu.219.2021.09.18.00.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:22:32 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v4 1/8] mptcp: track and update contiguous data status
Date: Sat, 18 Sep 2021 15:22:16 +0800
Message-Id: <60448fc4985b38f168394a8029f74dcba7b81fb6.1631949480.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631949480.git.geliangtang@gmail.com>
References: <cover.1631949480.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new member last_retrans_seq in the msk to track the
last retransmitting sequence number.

Add a new helper named mptcp_is_data_contiguous() to check whether the
data is contiguous on a subflow.

When a bad checksum is detected and a single contiguous subflow is in
use, don't send RST + MP_FAIL, send data_ack + MP_FAIL instead.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c | 15 +++++++++++++--
 net/mptcp/protocol.h |  6 ++++++
 net/mptcp/subflow.c  | 12 ++++++------
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ff574d62073f..b766b36e6c93 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1102,8 +1102,13 @@ static void __mptcp_clean_una(struct sock *sk)
 		msk->recovery = false;
 
 out:
-	if (cleaned && tcp_under_memory_pressure(sk))
-		__mptcp_mem_reclaim_partial(sk);
+	if (cleaned) {
+		if (mptcp_is_data_contiguous(msk))
+			msk->last_retrans_seq = msk->snd_una - 1;
+
+		if (tcp_under_memory_pressure(sk))
+			__mptcp_mem_reclaim_partial(sk);
+	}
 
 	if (snd_una == READ_ONCE(msk->snd_nxt) &&
 	    snd_una == READ_ONCE(msk->write_seq)) {
@@ -2419,6 +2424,7 @@ static void __mptcp_retrans(struct sock *sk)
 	struct mptcp_data_frag *dfrag;
 	size_t copied = 0;
 	struct sock *ssk;
+	u64 retrans_seq;
 	int ret;
 
 	mptcp_clean_una_wakeup(sk);
@@ -2464,6 +2470,9 @@ static void __mptcp_retrans(struct sock *sk)
 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
+		retrans_seq = dfrag->data_seq + info.sent;
+		if (after64(retrans_seq, msk->last_retrans_seq))
+			msk->last_retrans_seq = retrans_seq;
 	}
 
 	release_sock(ssk);
@@ -2889,6 +2898,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una = msk->write_seq;
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
+	msk->last_retrans_seq = subflow_req->idsn - 1;
 
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack = true;
@@ -3145,6 +3155,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 	WRITE_ONCE(msk->can_ack, 1);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
+	WRITE_ONCE(msk->last_retrans_seq, subflow->idsn - 1);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d516fb6578cc..eb3473d128d4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -227,6 +227,7 @@ struct mptcp_sock {
 	u64		ack_seq;
 	u64		rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
+	u64		last_retrans_seq;
 	int		wmem_reserved;
 	struct sock	*last_snd;
 	int		snd_burst;
@@ -625,6 +626,11 @@ static inline bool mptcp_has_another_subflow(struct sock *ssk)
 	return false;
 }
 
+static inline bool mptcp_is_data_contiguous(struct mptcp_sock *msk)
+{
+	return before64(msk->last_retrans_seq, msk->snd_una);
+}
+
 void __init mptcp_proto_init(void);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int __init mptcp_proto_v6_init(void);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1de7ce883c37..b07803ed3053 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1166,15 +1166,15 @@ static bool subflow_check_data_avail(struct sock *ssk)
 fallback:
 	/* RFC 8684 section 3.7. */
 	if (subflow->send_mp_fail) {
-		if (mptcp_has_another_subflow(ssk)) {
+		if (mptcp_has_another_subflow(ssk) || !mptcp_is_data_contiguous(msk)) {
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

