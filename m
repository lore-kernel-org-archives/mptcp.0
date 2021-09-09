Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2F3FE1
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 11:51:26 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id rj12-20020a17090b3e8c00b001991428ded8so981625pjb.1
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 04:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+sfPRbbZpSczVpoVWH69WcPjTVaYriomUO/9jZBIOI=;
        b=qkpNjyFLKXzYav5fLP2rxjLRuRHL1BZ0V8R00j19Y4s+GW6+Wel/e5i/mlKxFYU+HH
         3dsRIzRqIL6j4E1IwHvcf6FLU73L7ZCtutXAXR0or9vsXQS4nishpWESSOtyNmZiHZjt
         6p2I0LtxOVlImmHCZpvy/l5KGeO+zLtpry6k1zNhg2YBmKUyyx7tAHjSquea8TPHZCDX
         dvZUAu0uTKObEOnUURzT25FzI0Md1+dkWpd6YA9jkjYkmS0sGMHpiZCgxnJM6ub+4M4S
         He29gVYtm244uY0LvhzslPyLHtn+RgUc9ciPZx09/5y8xPbqDzIR39qrhIwS1HggzrXm
         Pagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+sfPRbbZpSczVpoVWH69WcPjTVaYriomUO/9jZBIOI=;
        b=tB3Rq1+6H0o/BBUbBqPg/P/QU1TGMKXDFZdDOTmNvrhom0/wkd8849VXaitYTVzHHH
         xj12z2yHBxDesjjYTO8KSHK03D/VFnaUUYF3rIV93l9Kh3JWyALOrp05Ew/Kf/hWPkfO
         HMlQg/gGv9TJM52edzv1RE+WYLuHz58ABJKXCd7glhBqqT5AwqmJ32aaC1q3NOBzLJhy
         hTe/a263ZFh2y6ommnJfrqbMkx6u8uF1kuhuMVMoXVSQIlpuHcFLyq/0ZOp8RNU538fp
         1n0tvLIXXjohYDeHagC6QsVzuK5q7iSBSeHaZfKGPC4uS6ebq4LMrbsfgc8QpyfomnSd
         8zPA==
X-Gm-Message-State: AOAM533AFKha0Ix1ysV5GoWSMw9h0uX2wKIAPOMRVfVTWHKU10PZRiaA
	IVMpGaAXMYogcfVgTcyjLrnFQHj3U5Y=
X-Google-Smtp-Source: ABdhPJz4PZthoiQGuSBH+jxQeJa9fdiqTI6YKqEQuwweCd04kjDcaQ9rMoV5X1E9cUalhsq+GT5ePA==
X-Received: by 2002:a17:90b:3e89:: with SMTP id rj9mr3193830pjb.138.1631188285871;
        Thu, 09 Sep 2021 04:51:25 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id n14sm2458225pjm.5.2021.09.09.04.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 04:51:25 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next v2 4/9] mptcp: add start_seq in the msk
Date: Thu,  9 Sep 2021 19:51:06 +0800
Message-Id: <48b3740fe2e7339114c7aa8278e5615cdb6b997b.1631188109.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631188109.git.geliangtang@xiaomi.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added a new member named start_seq to the msk to keep track of
the beginning of the last fully-acked data segment. This would be updated
in __mptcp_move_skb and mptcp_pending_data_fin.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/protocol.c | 4 ++++
 net/mptcp/protocol.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 81ea03b9fff6..c7ecd3e3b537 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -308,6 +308,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
+		WRITE_ONCE(msk->start_seq, msk->ack_seq);
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (tail && mptcp_try_coalesce(sk, tail, skb))
@@ -523,6 +524,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 	 */
 
 	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
+		WRITE_ONCE(msk->start_seq, msk->ack_seq);
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
 		WRITE_ONCE(msk->rcv_data_fin, 0);
 
@@ -2894,6 +2896,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 		WRITE_ONCE(msk->ack_seq, ack_seq);
 		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 	}
+	WRITE_ONCE(msk->start_seq, 0);
 
 #if !IS_ENABLED(CONFIG_KASAN)
 	sock_reset_flag(nsk, SOCK_RCU_FREE);
@@ -3141,6 +3144,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 	WRITE_ONCE(msk->can_ack, 1);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
+	WRITE_ONCE(msk->start_seq, 0);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5644a361b9c7..77af55171ded 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -226,6 +226,7 @@ struct mptcp_sock {
 	u64		remote_key;
 	u64		write_seq;
 	u64		snd_nxt;
+	u64		start_seq;
 	u64		ack_seq;
 	u64		rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
-- 
2.31.1

