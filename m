Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21A17AA2
	for <mptcp@lists.linux.dev>; Tue, 20 Jun 2023 16:24:59 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f9b23dc270so23776015e9.0
        for <mptcp@lists.linux.dev>; Tue, 20 Jun 2023 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278298; x=1689870298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8LhkZXq3u26NycQr6cEqr1qtfjnbuarKmiwKf4xMtU=;
        b=cWyjdTqs3sK+thPlhmgkNr9Sd0WrvKg9XdYbu3OWjknzHYL+A96uIxD8LX9G1D59An
         HteKISTUi0icPjK+HTMEnuveZ1z9lDiViC9NW8iF0ew0qOl0pNAj/lh6tOht6buz4ssD
         CpHmSxdgvwlJOObfGIUNCQIFCh8spfUAz41Zvig3AwcjzV/pWG+H7PXFwP8HxrMv3VNf
         vWpYT/zAPaH+CoL7baA44xVvx4B0IPF5OZ2iePnA6ppBdW+i24Vf19Lq3TrKUB0zsu0d
         FDiV/R5AuVMvbcXX2Ou6VIWSWgIQSD+7nmUd8UAxLRrQCxjZ0Zk+eiojLCj8rPyTnVYS
         CdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278298; x=1689870298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8LhkZXq3u26NycQr6cEqr1qtfjnbuarKmiwKf4xMtU=;
        b=NmHuVquYkWl4P1RGGcsa2FrmbZyYuMs9IdfueM1ZK+ktfiE3YjxPpPJTiKdq76Wcn+
         6enah1mMwEt7d3RSIGCnHMj4Vzgo/Nm9wLzMEThsMNyoA5o/xu1f3lfs0diaSfxxNzVn
         Y8zaQkrOIombMx+eEF0Nc23IUvcK5OtNuARAMdLjqgv0cIGLOkQ8bqaxR9quealqVHuf
         1ffAyMohsR2sRVgk2dDeHT9eEfH/8q54iQd4T4vgh8PINvhLGc7B4xisC0MNycLnY1yL
         Efrp0MdsjQX7A+I8czWGEzsNEep4l0zO1SdTuxn9uUqWPKRA+rz4SfJTKBjH4i59VEHy
         xwEg==
X-Gm-Message-State: AC+VfDzWPcvvDTh4Bc3at//dg/RnrUCUrbYw2/iDX0f29exZo2k9H00N
	yG0oU4LAwsYhx0/UCpJbabeydQ==
X-Google-Smtp-Source: ACHHUZ5XgFZeyJRVkTsTsbyc9wiCo1YuIcE90gi/XpAy+/zN3lF3toPTz4LdRl+1DWPSsa0KBFrctg==
X-Received: by 2002:a05:600c:2245:b0:3f8:f4f3:82ec with SMTP id a5-20020a05600c224500b003f8f4f382ecmr11020611wmm.8.1687278298034;
        Tue, 20 Jun 2023 09:24:58 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b003f8fe1933e4sm15753056wms.3.2023.06.20.09.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:24:57 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 20 Jun 2023 18:24:22 +0200
Subject: [PATCH net 5/6] mptcp: drop legacy code around RX EOF
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-5-f36aa5eae8b9@tessares.net>
References: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-0-f36aa5eae8b9@tessares.net>
In-Reply-To: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-0-f36aa5eae8b9@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4049;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=NUftswvvgXNJ7K5F9GELkECEB8VMD4z5k7YKE05yO4Y=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdLU7oSKTlwi+3yscjfycqKb9AgTwioYdcTwq
 sHM4YV425OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHS1AAKCRD2t4JPQmmg
 c0Q/EACUSyGYQmjVMKLnXMWTvXbiizXKX3gzm5uDsKDRUwJx8rLAGgOX+Vx6UXYGm5ul9WEKOx8
 kThgZaQZLwFYeOw11ORTNLRd6qVm3FGAAsCUBABnX/9UwW/EqmE+dW0chPrtIo0JP4Ajwx0ZTO0
 SUMeW7oQhmPyqN4zxmNAGL4Msi8E9E5qTD8hObBV/Ml69gLCAgCq+gy690TVjbjBFfOCokl7NLU
 7SGISI4x9b1z2ZoNRwpI6qXOO5zyRlSbTT0OsCpO6lw7sM1kpwbswm14wNutQT51fdLyjzrI5PI
 1BOzvxxRU3BKNo1QQplLfTmzoER8pKfxwBE3TXjrU/TdcTfZiKZH4aAslwFjOCLdxmjCMKxMlHG
 x8NJxNVbkyacxBloPQ90fTAKGtzA00+IrXlISxaYJTvkOGqKMRLLf6hT4WoSbt4uT2DbJMrg6n3
 dcbhlSVL4RFFrvBofiwsJ5rDU0i7h7mJa5vwXdbUPm9ZW8Xwr52X6IEqAxxB9+50HVeSZVuh69P
 17isgW5rIW+prI0gKDjFxQFvAQn7YM4a0LJAF8r5achpE9F2CbnbtCzGtIoPMKtbds/7Rw96vnR
 ihFzpkkhPr4uuaMliMQ3mQ41i4SVIYQZrl6LHHspZy5kyqMfFci4HZFHPZQ92FpwfGXkl/xzf+S
 1H7BP/dsduq1kuw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Thanks to the previous patch -- "mptcp: consolidate fallback and non
fallback state machine" -- we can finally drop the "temporary hack"
used to detect rx eof.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 49 -------------------------------------------------
 net/mptcp/protocol.h |  5 +----
 2 files changed, 1 insertion(+), 53 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 27d206f7af62..a66ec341485e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -894,49 +894,6 @@ bool mptcp_schedule_work(struct sock *sk)
 	return false;
 }
 
-void mptcp_subflow_eof(struct sock *sk)
-{
-	if (!test_and_set_bit(MPTCP_WORK_EOF, &mptcp_sk(sk)->flags))
-		mptcp_schedule_work(sk);
-}
-
-static void mptcp_check_for_eof(struct mptcp_sock *msk)
-{
-	struct mptcp_subflow_context *subflow;
-	struct sock *sk = (struct sock *)msk;
-	int receivers = 0;
-
-	mptcp_for_each_subflow(msk, subflow)
-		receivers += !subflow->rx_eof;
-	if (receivers)
-		return;
-
-	if (!(sk->sk_shutdown & RCV_SHUTDOWN)) {
-		/* hopefully temporary hack: propagate shutdown status
-		 * to msk, when all subflows agree on it
-		 */
-		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
-
-		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
-		sk->sk_data_ready(sk);
-	}
-
-	switch (sk->sk_state) {
-	case TCP_ESTABLISHED:
-		inet_sk_state_store(sk, TCP_CLOSE_WAIT);
-		break;
-	case TCP_FIN_WAIT1:
-		inet_sk_state_store(sk, TCP_CLOSING);
-		break;
-	case TCP_FIN_WAIT2:
-		inet_sk_state_store(sk, TCP_CLOSE);
-		break;
-	default:
-		return;
-	}
-	mptcp_close_wake_up(sk);
-}
-
 static struct sock *mptcp_subflow_recv_lookup(const struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2161,9 +2118,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 				break;
 			}
 
-			if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
-				mptcp_check_for_eof(msk);
-
 			if (sk->sk_shutdown & RCV_SHUTDOWN) {
 				/* race breaker: the shutdown could be after the
 				 * previous receive queue check
@@ -2681,9 +2635,6 @@ static void mptcp_worker(struct work_struct *work)
 
 	mptcp_pm_nl_work(msk);
 
-	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
-		mptcp_check_for_eof(msk);
-
 	mptcp_check_send_data_fin(sk);
 	mptcp_check_data_fin_ack(sk);
 	mptcp_check_data_fin(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 70c957bc56a8..d3783a7056e1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -113,7 +113,6 @@
 /* MPTCP socket atomic flags */
 #define MPTCP_NOSPACE		1
 #define MPTCP_WORK_RTX		2
-#define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
 
@@ -476,14 +475,13 @@ struct mptcp_subflow_context {
 		send_mp_fail : 1,
 		send_fastclose : 1,
 		send_infinite_map : 1,
-		rx_eof : 1,
 		remote_key_valid : 1,        /* received the peer key from */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		local_id_valid : 1, /* local_id is correctly initialized */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		__unused : 8;
+		__unused : 9;
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u64	thmac;
@@ -720,7 +718,6 @@ static inline u64 mptcp_expand_seq(u64 old_seq, u64 cur_seq, bool use_64bit)
 void __mptcp_check_push(struct sock *sk, struct sock *ssk);
 void __mptcp_data_acked(struct sock *sk);
 void __mptcp_error_report(struct sock *sk);
-void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit);
 static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 {

-- 
2.40.1

