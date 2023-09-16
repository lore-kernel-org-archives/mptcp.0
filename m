Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135C12B8B
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 10:53:58 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50307759b65so291524e87.0
        for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 03:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694861636; x=1695466436; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvXzRr88SnSDxxsAv4ZSTVo/5hnYCAUN9lBO/XCA5NQ=;
        b=3+3+yIcgh9A0o9wbNO6vX64Y5LADdobvnIKsA6ysk+RZ2ngOwKSzKX0ryJovxDQ5qu
         opapqpTlTCfvi0iYUU7PlpX7hKmoE9WeBnyQWkwV3PHu2nKAQZVz4ftAssBu8VJZ0UYY
         nUxKCCORuRxdMrHRwxARt9IvK9536lawq41OXX5VKlYm8nwlkzafXGXSczbzs0uBB2ti
         fgsenbJ55C07yAlskUHr1MfVC5qYpOsjZp2knt0FCc6B7NHubOvy5/xROOiSS6g7oBLx
         1LbmBm5WDyJ0ubMlY4/5gbRU6Bv03NWueNSxY4hagguj5aqxM34lOM4fGixtJYqCpr3f
         ZcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694861636; x=1695466436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvXzRr88SnSDxxsAv4ZSTVo/5hnYCAUN9lBO/XCA5NQ=;
        b=NH4bdsY6HqASaBsCRh4woZqyhD4iiI03Xg3zFByeEAqj/87bYgkBwxASusFXDyoPIl
         qkgLbLLogy+cjJddmt2V+EcpeIa81wgdO3/zoq0DTPpgSEb+Nia+b5WmwxX/p6jIoPP5
         AwphnPv1hV3J56NKrCDDYCi4cvAhbrhpWlPGoNGx8ToNWY7cwYF8j1g8GucSJwyI8aOe
         gH4OImBvs47S8uPIYs1fbvYLquTa8eJWUoXmlWHK1zy1TBDUBZOYHYjb4kSm/RJBiq5p
         CCuV/mqTBiIV9b0Uhts04DErMy1V7nD+Cq3TME1wb6pOW011fBZdpfxK/OBvRD1CVjDf
         bPbw==
X-Gm-Message-State: AOJu0YxEJig+wZGQz2lnIALv3ggm1mRReRlzssxUe370OFWAO0zd7rzQ
	2JAbt4jDZxkp21UqWVIoQLxqPg==
X-Google-Smtp-Source: AGHT+IHtX5K9ta5qbhSPuwwilwWoJTuhSxV4JuGUo8+ZCkJwFKR7S7akQYR8J9f36ryoXsEa9vW34Q==
X-Received: by 2002:a19:6715:0:b0:502:e2be:54b5 with SMTP id b21-20020a196715000000b00502e2be54b5mr3268108lfc.17.1694861636296;
        Sat, 16 Sep 2023 03:53:56 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003feae747ff2sm9900743wmk.35.2023.09.16.03.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 03:53:55 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Sat, 16 Sep 2023 12:52:46 +0200
Subject: [PATCH net 2/5] mptcp: move __mptcp_error_report in protocol.c
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-2-05d1a8b851a8@tessares.net>
References: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-0-05d1a8b851a8@tessares.net>
In-Reply-To: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-0-05d1a8b851a8@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3409;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=UCzONQs8IbPl41AgIyasVUSFyocd6ByoszHVHBiWnr4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlBYlAE4rFvQULAtV4XxAqAqenuymInl5nYoNWA
 +2Zl3C/OP2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZQWJQAAKCRD2t4JPQmmg
 cwpoEADUHOOGVVygnOP/3dSVU8OHtSYLaNemMIDJhsqCUCurZS9AorYWIdENIP0Y5LKJX3y4hbF
 QagnCCUz49DbXHtDlc1KqwHFI0Sy64GUurBXyqnv6LuPsPGISXBDEq1ykawed40/t6OrSEZau/I
 5t5i032ECrUeiooVypidj7HWkukdn8XaSDYSLTV8LUNtoXgzk/NjBSC5ft7EM8FQXaVVr1jFJ1D
 nI7VIN/fsIodx45oPKBBrQV4m6gSWQ6Z4i7AUNkjgtPPvhYQbM+7lZsa44pAm+MGB2UxAN2r7nY
 3VR1KzI+DQwzDcbXzfHVfFvps+UrHgfQT3OQLHCEXRMOBqHiXaeZg3pLFIltNcYjrkNYdZoO+ME
 dhTuQF2nWh5t4FFmKnkc7mMT521SPtFiaZ7mxUimM2T5cOl1FoOsq70wpyAqLoZ7QByGwMu0vi/
 DIn8LNX4X+ZTYKoNfNAtWc7lHJ6YuQWkiu6ddwO4vkvk9NkurKA9cPE0s+WGIEiLMEHCIRwisbg
 czehBHr3Uy/DGoatW8/umqh+q+BGv6zEsxnlGOGA579UQh2Y3XM5OrQIsaYefV7L4feOgaqlPmC
 zUmv91Mr7naOXvfv+wvCobZmTKwFEVpHlPH1GcAeZxYDrS2gN/fkCdF5yib5cp+sG2ta9t3JX3w
 hHL4mOoUD7/Lvsg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

This will simplify the next patch ("mptcp: process pending subflow error
on close").

No functional change intended.

Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 36 ++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 36 ------------------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a7fc16f5175d..915860027b1a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -770,6 +770,42 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+void __mptcp_error_report(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int err = sock_error(ssk);
+		int ssk_state;
+
+		if (!err)
+			continue;
+
+		/* only propagate errors on fallen-back sockets or
+		 * on MPC connect
+		 */
+		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
+			continue;
+
+		/* We need to propagate only transition to CLOSE state.
+		 * Orphaned socket will see such state change via
+		 * subflow_sched_work_if_closed() and that path will properly
+		 * destroy the msk as needed.
+		 */
+		ssk_state = inet_sk_state_load(ssk);
+		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
+			inet_sk_state_store(sk, ssk_state);
+		WRITE_ONCE(sk->sk_err, -err);
+
+		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
+		smp_wmb();
+		sk_error_report(sk);
+		break;
+	}
+}
+
 /* In most cases we will be able to lock the mptcp socket.  If its already
  * owned, we need to defer to the work queue to avoid ABBA deadlock.
  */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9bf3c7bc1762..2f40c23fdb0d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1362,42 +1362,6 @@ void mptcp_space(const struct sock *ssk, int *space, int *full_space)
 	*full_space = mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf));
 }
 
-void __mptcp_error_report(struct sock *sk)
-{
-	struct mptcp_subflow_context *subflow;
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		int err = sock_error(ssk);
-		int ssk_state;
-
-		if (!err)
-			continue;
-
-		/* only propagate errors on fallen-back sockets or
-		 * on MPC connect
-		 */
-		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
-			continue;
-
-		/* We need to propagate only transition to CLOSE state.
-		 * Orphaned socket will see such state change via
-		 * subflow_sched_work_if_closed() and that path will properly
-		 * destroy the msk as needed.
-		 */
-		ssk_state = inet_sk_state_load(ssk);
-		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
-			inet_sk_state_store(sk, ssk_state);
-		WRITE_ONCE(sk->sk_err, -err);
-
-		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
-		break;
-	}
-}
-
 static void subflow_error_report(struct sock *ssk)
 {
 	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;

-- 
2.40.1

