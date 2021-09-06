Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63212FB6
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 07:58:14 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id g184so5986263pgc.6
        for <mptcp@lists.linux.dev>; Mon, 06 Sep 2021 00:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WVrvNqfHSWjrH1vjE2sONj5OfBOz/ynCKbMy/GXaOtM=;
        b=mCiKn5JJhAu/K71Nh5PQZ67S46WaJ7jzhgvDimIWq7iYRu1mmDhKGt3dMvB3qxsgrr
         F8FQ01jVIWSHYaKt05XWBo6weR6JZG6bcrnUpS042j/ThFf3hnpem1IFhZDwvBdlryBt
         e1YDSnpVCttAswQt6h7kmL3S0RUJEJTkApGFh2M5qvBcPNX8q8qFTLjzFFrDgrhK390s
         Il2hkH3i4nA0yV4kPKG3nIIavhyoB9xygn8q6JjUREv1OdIr1HwOtZJAdpmfHmEuBlqg
         7+LN7yL8K9IdJbHVR9HpfQ8832+f6CdDEu6/WFfcW0TUTRpFsjuzNK1eEB7iZHi4ghb5
         Bguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WVrvNqfHSWjrH1vjE2sONj5OfBOz/ynCKbMy/GXaOtM=;
        b=FYH6hBGeOLrmWkdE2gh3cRBM15wP8W/LYA0C40nwbSYbFWRO9424CB+de5BUwbEyvo
         i9MRhszq4DVk9IZlzzmOL5jzG9vPqSwD9BYFGx7xdu3eUHgDq/K1iSeICvqFTqqvJY0U
         ngvziAeP+91b43CTEONz56B183T0EVo2MjfvZYV0i0dn6rt9CMEZwbLaJYFf9cUsYZn5
         vuLofc2g6BrIvCsChDsjxpV6eLX54NVZ/0/ifNzcmk2uAw5sEzPy3qcmC2wQuxaAio8U
         oGxWMpACjMpGqLzboEpo5jpXVym9VDNnTjJb1kkSWaKxUg5cfAtUBojFUKFDzbBwhel/
         2oXQ==
X-Gm-Message-State: AOAM5338848I4ODP08SuYpUJufpat+K3idFc0sdXhXvjQV5WcGBD9vWX
	eLNXa7jSRZpkvQRAi5iPspZEwYh3l58=
X-Google-Smtp-Source: ABdhPJzqvFM0s+kp5xNHixEgtJFF460rPBl8kW2zHTpy2MZFvt1QqHysjvhiM9A7tayGc5ZQra+kpg==
X-Received: by 2002:a05:6a00:1245:b029:30f:2098:fcf4 with SMTP id u5-20020a056a001245b029030f2098fcf4mr10914653pfi.66.1630915094074;
        Mon, 06 Sep 2021 00:58:14 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id c24sm6895702pfd.145.2021.09.06.00.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:58:13 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next 1/6] mptcp: add noncontiguous flag
Date: Mon,  6 Sep 2021 15:58:02 +0800
Message-Id: <fed5c608544799a51138d6fb56871811e3ad71ab.1630914699.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630914699.git.geliangtang@xiaomi.com>
References: <cover.1630914699.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added a "noncontiguous" flag in the msk to track whether the
data is contiguous on a subflow. When retransmission happens, we could
set this flag, and once all retransmissions are DATA_ACK'd that flag
could be cleared.

When a bad checksum is detected and a single contiguous subflow is in
use, don't send RST + MP_FAIL, send data_ack + MP_FAIL instead.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/protocol.c | 13 ++++++++++---
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 12 ++++++------
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2a525c7ae920..553082eb1206 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1098,8 +1098,10 @@ static void __mptcp_clean_una(struct sock *sk)
 	}
 
 	/* all retransmitted data acked, recovery completed */
-	if (unlikely(msk->recovery) && after64(msk->snd_una, msk->recovery_snd_nxt))
+	if (unlikely(msk->recovery) && after64(msk->snd_una, msk->recovery_snd_nxt)) {
 		msk->recovery = false;
+		WRITE_ONCE(msk->noncontiguous, false);
+	}
 
 out:
 	if (cleaned && tcp_under_memory_pressure(sk))
@@ -2502,8 +2504,10 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 		__mptcp_close_subflow(msk);
 
-	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
+	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags)) {
+		WRITE_ONCE(msk->noncontiguous, true);
 		__mptcp_retrans(sk);
+	}
 
 unlock:
 	release_sock(sk);
@@ -2872,6 +2876,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	WRITE_ONCE(msk->fully_established, false);
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
 		WRITE_ONCE(msk->csum_enabled, true);
+	WRITE_ONCE(msk->noncontiguous, false);
 
 	msk->write_seq = subflow_req->idsn + 1;
 	msk->snd_nxt = msk->write_seq;
@@ -3040,8 +3045,10 @@ static void mptcp_release_cb(struct sock *sk)
 		spin_unlock_bh(&sk->sk_lock.slock);
 		if (flags & BIT(MPTCP_PUSH_PENDING))
 			__mptcp_push_pending(sk, 0);
-		if (flags & BIT(MPTCP_RETRANSMIT))
+		if (flags & BIT(MPTCP_RETRANSMIT)) {
+			WRITE_ONCE(mptcp_sk(sk)->noncontiguous, true);
 			__mptcp_retrans(sk);
+		}
 
 		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 99a23fff7b03..29322e09e7d6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -249,6 +249,7 @@ struct mptcp_sock {
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
+	bool		noncontiguous;
 	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1de7ce883c37..951aafb6021e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1166,15 +1166,15 @@ static bool subflow_check_data_avail(struct sock *ssk)
 fallback:
 	/* RFC 8684 section 3.7. */
 	if (subflow->send_mp_fail) {
-		if (mptcp_has_another_subflow(ssk)) {
+		if (mptcp_has_another_subflow(ssk) || READ_ONCE(msk->noncontiguous)) {
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

