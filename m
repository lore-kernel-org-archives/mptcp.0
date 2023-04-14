Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587942102
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 14:08:30 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id i3so8327273wrc.4
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 07:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681481308; x=1684073308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmK0FCUfNmeHXQ4DJ8Hz0byh7p8vyN8GhI+Kn6kA5ic=;
        b=qngY7ZD1pySsHI+SAimaDsNO2GfF1aBNavcCotGj6RdfSeKnt4YJQkhECqjrPwvKyI
         ndDoTuaPtt+tyGY/v+PVpKunlsL+oNr2CURiMl7B6Z6LBAUc9hvzU4To8Qu73jiyQ9mA
         9PbM2z8jwDYYaBz1NktgHk5QXskA/YewaLddhgDC7F0WaU4YxA4+DRW/jt+WkPZp+gtj
         3o5ajMHfd3NKcF0+MDEXbbS1ArNBwWtc6KAuG5yt/o9cTjY9Y2xhu/uyT3y7sQHRxzue
         YYc6ucBESWMBcn1q20hDULFGMAUTGovrsLek3Y+QOCZoTjzFuBFijgzIa3ZwWTOsOYs5
         ccVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481308; x=1684073308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmK0FCUfNmeHXQ4DJ8Hz0byh7p8vyN8GhI+Kn6kA5ic=;
        b=chJwILKDvsrDRa5aHObj08LEHOWhSLKoaYBkKo0JipczE7Rk8ME6S7uCX+1x/vQTI7
         Kz5BoO0GGS0yQrLQ9iBcirrzBgniwqsCOiW85nrg0j3Mr18+JHto3UA/Ueynq0CJkQqB
         dlYsN1bM+d9f7eNujRLAnMK2M4tLO1P0Rw2V4KUlQVKWjJkg2Bpy34jKGwhS7QeoC/Qs
         TXqcfd+OPwevQn44lfn8tPSF6yqJAvE+HbM1mCMgn3KvHH7cgmhzWl7Tkt5WfkzMU4a+
         /gQ3WouMVgx2nDHd8B8JbIyXYj17wIeTRYGLWO+5oKYpEegJ0U0Ca/ILkyn7YJ7WihTC
         W8wQ==
X-Gm-Message-State: AAQBX9cTIIVL6Jtn7u9kazWnu8zEp40k3rVxHxRa9ykL96XlOqh2eCXL
	cLy/erfqwWJX3xhX2pYxPSbv1A==
X-Google-Smtp-Source: AKy350YwslMhP1L25HkhxfV9JbUM0Ew6TOTd4/xl01s5XymHCG4YaA2X+NUENIQ9OyoYOxuqT+5V9A==
X-Received: by 2002:a05:6000:182:b0:2c9:b9bf:e20c with SMTP id p2-20020a056000018200b002c9b9bfe20cmr4061444wrx.2.1681481307476;
        Fri, 14 Apr 2023 07:08:27 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d58c5000000b002f47ae62fe0sm3648185wrf.115.2023.04.14.07.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:08:27 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 14 Apr 2023 16:08:00 +0200
Subject: [PATCH net-next 1/5] mptcp: drop unneeded argument
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-upstream-net-next-20230414-mptcp-refactor-first-subflow-init-v1-1-04d177057eb9@tessares.net>
References: <20230414-upstream-net-next-20230414-mptcp-refactor-first-subflow-init-v1-0-04d177057eb9@tessares.net>
In-Reply-To: <20230414-upstream-net-next-20230414-mptcp-refactor-first-subflow-init-v1-0-04d177057eb9@tessares.net>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=MaZ06pjF4key6Fm9pULF8bD6R2n9RR6/Lph50fcV+5c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkOV5Z+BGDys8VB1jwJ/I95s1ZAbmqPntjUxuM3
 BCQfTkfm3aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDleWQAKCRD2t4JPQmmg
 c2PGD/9a2M2J4FmsqD7mq031j8Cw/jOwb1MYLrqouMG34GWmqBSZTRN2432RuVEXzlqWl7lcF3P
 nK4fXBnc+uB2G3aky9mhS5WCebwI4/TEmXJ0p0LJNdtTHxpzK0Jqmi1A6Idls4fKqE555Y/sgrM
 OLxVbunskkX7fKVFj84sKxCWPEzi/vwUt6g842ntgziVq2ZnWdtpamTO9E1fJxqe47Mvm0VqYtk
 fkFvCCaWhWEAemff14JdYiiPggwsomZI9r9ky8piC8QdthtS4mBLidupihPLpvS9kE/aKqAr04q
 d/TlBOp0vYTOUbAj0qGnCcpYleUowgtXgPGidKtt23qU2sEapehdyPFpHw7CkwUGrFc75LMdPr8
 2LIzOgy/bMTPJDE/sK+JlTSSIFIprz85cQp8ImKf79O0Lvc2DSRSsuFMLrnpVLRzW+mfrTzOn72
 lKdVYua8JSYcSU77iWhTMNBgKJ2NZk4rUHkSQRouiyHNjDytlxoTitIskjhH1ZINJ+I8aJtLhj5
 JDxlsyiLqumzsjP2D+56JYU04mE1CTGhca/+xkoSbTYGTn4asVFpKtz7Eh7pTimaM+mJmRFxKTf
 1L0v/7WBNNtvxhXJRrusDMNrdwh5zTHpUDSrXb8xmyQukbzsiJcq5Qr87VXD/LsuCCP2JyHQ6eJ
 Bag0J0MVQK7B4Sw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

After commit 3a236aef280e ("mptcp: refactor passive socket initialization"),
every mptcp_pm_fully_established() call is always invoked with a
GFP_ATOMIC argument. We can then drop it.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/pm.c       | 4 ++--
 net/mptcp/protocol.h | 2 +-
 net/mptcp/subflow.c  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 355f798d575a..cd3b885c8faa 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1001,7 +1001,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		clear_3rdack_retransmission(ssk);
 		mptcp_pm_subflow_established(msk);
 	} else {
-		mptcp_pm_fully_established(msk, ssk, GFP_ATOMIC);
+		mptcp_pm_fully_established(msk, ssk);
 	}
 	return true;
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 70f0ced3ca86..78c924506e83 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -126,7 +126,7 @@ static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
 	return true;
 }
 
-void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk, gfp_t gfp)
+void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool announce = false;
@@ -150,7 +150,7 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk,
 	spin_unlock_bh(&pm->lock);
 
 	if (announce)
-		mptcp_event(MPTCP_EVENT_ESTABLISHED, msk, ssk, gfp);
+		mptcp_event(MPTCP_EVENT_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 }
 
 void mptcp_pm_connection_closed(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e1310bc113be..a9eb0e428a6b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -782,7 +782,7 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
-void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk, gfp_t gfp);
+void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
 void mptcp_pm_connection_closed(struct mptcp_sock *msk);
 void mptcp_pm_subflow_established(struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f46d8f6c40aa..80bbe96c0694 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -850,7 +850,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			 */
 			if (mp_opt.suboptions & OPTION_MPTCP_MPC_ACK) {
 				mptcp_subflow_fully_established(ctx, &mp_opt);
-				mptcp_pm_fully_established(owner, child, GFP_ATOMIC);
+				mptcp_pm_fully_established(owner, child);
 				ctx->pm_notified = 1;
 			}
 		} else if (ctx->mp_join) {

-- 
2.39.2

