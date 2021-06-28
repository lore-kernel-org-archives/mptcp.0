Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF270
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 04:29:20 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id i6so13090726pfq.1
        for <mptcp@lists.linux.dev>; Sun, 27 Jun 2021 21:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jLLxIVMZ7cqonxJTxu59fWqEnGqf2sGD/xaNUrsWHg=;
        b=s6mq/GKz5MGkY6meqL9DPYRPgKAysG657S/A0VBj8Z13KkN17W0Hntz0VgJtMsydnB
         yUWYzWtxZ9SskWdSwH6lqXQxsi+6PvnsXwG9aTOBVOwyQpIQ4JbhHWi7YKIBEyOF0jnj
         mSdDr+zB0FhJRf2urb6KFQrfyjNOLamojgYvrPZTs7aN58Fzs+F0rSDxS08bhg0b+7Re
         ly/dZBRG3q94TX8qoU1uOhPmE+Iuhw5TKcF4Gf9YXLSkjhdLFM5C4InHWCV96WokXjHN
         WOeGy6Y8G+ynEA/Ab7BkQjGJSu4eL6p9CtFjTydHbJWy7XOC13SvTcG6pzMUbbtxLxuG
         rXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jLLxIVMZ7cqonxJTxu59fWqEnGqf2sGD/xaNUrsWHg=;
        b=Q/DyWvuYJP68coHUpeX/G/Jcyz+t85BfU9mvBTo8QBtsubumBXm0mD/4mVblT4J8xK
         A3jyResT8cZZcd+asTcA4unuHlnIvOp0AZ/KTJB8h/QB58qEF44H6e33FAzPTElYHP52
         JU2tSiNORi1Txr1sBP4zZrWxZ6ZqQC7wzkLuGR0sAjtQJzLQBlsB4Wnm2P1KMV7Tf7JW
         4eZ5f0cbYut4mrTG2f4Y7iPqByBxSIB9KI7Ygq7H2QZ44HHt4aVIUteOfhfm3L/Cb6cr
         uThW1czeCzsBwYVHc69NLoJb+LhRrE2j1TwySbrnMeXXoZPM+9esLqVcyArGHAjWJs2c
         VWgQ==
X-Gm-Message-State: AOAM533qQT+CGAvC8LDsyVHVau8M9DoG6Q42xfPIMhYqSvFNkCMRQHus
	pOrlZwAEzrm5DfgkJa+cKsy1erKJKfUNdw==
X-Google-Smtp-Source: ABdhPJxNwN+RlB39tH1T0XNagQhFBnvSvC6ez0S5491/9d6u+YCp5VKR+mWKNp7ZHK8qtnhOf522TQ==
X-Received: by 2002:a63:3704:: with SMTP id e4mr21254993pga.310.1624854560037;
        Sun, 27 Jun 2021 21:29:20 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id g8sm12837391pgo.10.2021.06.27.21.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:29:19 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v3 mptcp-next 3/8] mptcp: send out MP_FAIL when data checksum fail
Date: Mon, 28 Jun 2021 12:28:59 +0800
Message-Id: <30a102a69a09fe644776dbddc93a1a3710c0fd51.1624854005.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <d10ab4b89d053ba9a3debc9c7f6bdab0ca0d95bd.1624854005.git.geliangtang@gmail.com>
References: <cover.1624854005.git.geliangtang@gmail.com> <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com> <d10ab4b89d053ba9a3debc9c7f6bdab0ca0d95bd.1624854005.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a bad checksum is detected, send out the MP_FAIL option.

When multiple subflows are in use, close the affected subflow with a RST
that includes an MP_FAIL option.

When a single subfow is in use, send back an MP_FAIL option on the
subflow-level ACK. And the receiver of this MP_FAIL respond with an
MP_FAIL in the reverse direction.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm.c       | 10 ++++++++++
 net/mptcp/protocol.h | 14 ++++++++++++++
 net/mptcp/subflow.c  | 18 ++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d4c19420194a..c34c9c0b2fa5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -250,8 +250,18 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 
 	pr_debug("map_seq=%llu fail_seq=%llu", subflow->map_seq, fail_seq);
+
+	if (!msk->pm.subflows) {
+		if (!subflow->mp_fail_need_echo) {
+			subflow->send_mp_fail = 1;
+			subflow->fail_seq = fail_seq;
+		} else {
+			subflow->mp_fail_need_echo = 0;
+		}
+	}
 }
 
 /* path manager helpers */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8e050575a2d9..7a49454c77a6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -422,6 +422,7 @@ struct mptcp_subflow_context {
 		backup : 1,
 		send_mp_prio : 1,
 		send_mp_fail : 1,
+		mp_fail_need_echo : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1;	    /* ctx can be free at ulp release time */
@@ -594,6 +595,19 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 	inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
 }
 
+static inline bool mptcp_has_another_subflow_established(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk), *tmp;
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+
+	mptcp_for_each_subflow(msk, tmp) {
+		if (tmp->fully_established && tmp != subflow)
+			return true;
+	}
+
+	return false;
+}
+
 void __init mptcp_proto_init(void);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int __init mptcp_proto_v6_init(void);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0b5d4a3eadcd..46302208c474 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -913,6 +913,8 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
 	if (unlikely(csum_fold(csum))) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
+		subflow->send_mp_fail = 1;
+		subflow->fail_seq = subflow->map_seq;
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
@@ -1160,6 +1162,22 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 fallback:
 	/* RFC 8684 section 3.7. */
+	if (subflow->send_mp_fail) {
+		if (mptcp_has_another_subflow_established(ssk)) {
+			mptcp_subflow_reset(ssk);
+			while ((skb = skb_peek(&ssk->sk_receive_queue)))
+				sk_eat_skb(ssk, skb);
+			WRITE_ONCE(subflow->data_avail, 0);
+			return true;
+		}
+
+		if (!msk->pm.subflows) {
+			subflow->mp_fail_need_echo = 1;
+			WRITE_ONCE(subflow->data_avail, 0);
+			return true;
+		}
+	}
+
 	if (subflow->mp_join || subflow->fully_established) {
 		/* fatal protocol error, close the socket.
 		 * subflow_error_report() will introduce the appropriate barriers
-- 
2.31.1

