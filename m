Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6D55F
	for <mptcp@lists.linux.dev>; Wed, 31 Mar 2021 07:23:44 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id ay2so7441125plb.3
        for <mptcp@lists.linux.dev>; Wed, 31 Mar 2021 00:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L6Ibo/3rRgyxWF9uJAxrX161gbesvx35cAaRQ3TagRI=;
        b=S+CemrDcnRsKP4T3URSjK9flt6DWm3ctIzpFj7S83mzFI7lK4Wk1RpZSQf/Mg8c4Vy
         NMdRW7+lBvu8ldVrkTbhMudDAHtEJ86uWqoTzJGFHQwPFZUgBtldYWL3o3EUglTnRejT
         aQjyf56ndfUATmtQ5FLiLl0nQOPlfoIiLd10uA/WKotadtYcoMCTYTs7rYEqvqJVFrPj
         Vi/D22D79+TNWqNjkNx3qpWeX2QIyztzGZrVSOzc8YkzUmaay5qggnFXSoQRiIIjZnWZ
         up9HdOJ89OgBMz6DR8ZGK3dCTwi5nbHnE2st3XOIJvT50C0GXcg2siurAEhG8PJrmwsx
         y15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6Ibo/3rRgyxWF9uJAxrX161gbesvx35cAaRQ3TagRI=;
        b=AEsXRZjwicrLRVAxRfVy11J7nVGxRNQ9Vz711CxpiWytB/fmRpr1nccsUKXQMT9OVG
         n8OANmgMywtlPTnMLpGyxQxNLqysRI0Cyg3/Lfd7vLnadDU9A+AvmxL+SvSqskdBvQeu
         RwgN5VEY8dA2j9n+2Xaa3fCau+cH/mOa8mNYLYS8luuim3KxtbrQk8kqNedoypsnerhS
         hzkQYmaRWUOB+9ZcGjxx3r5avjqIq/J7/x+rJXt+0oTSk1JFilCiAeT5gRJ7tQNkpSII
         7Npfq0c2sAf23fROTCdcFdUdRFwKqkk/y63drdwtBl5ETlXaKhY0S72Nx0pb5DmcS3xB
         Likw==
X-Gm-Message-State: AOAM5329Hc7ALcR2j7OIM5T5sPhf+lBL0doEBDtfwB3tIBVXCn2AAYQ9
	2uVAbAt9Vq5GZlCGlwBWA/QA51qL6vY=
X-Google-Smtp-Source: ABdhPJzmUbg82l7cJ2BTsql0PfnCeM6xrPqtbYjdZ3ek9qmJtBsprLU4qDUxDAXwCz3iK8XS6ZxUVQ==
X-Received: by 2002:a17:90b:3615:: with SMTP id ml21mr2163862pjb.72.1617175423957;
        Wed, 31 Mar 2021 00:23:43 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x22sm1170607pfa.24.2021.03.31.00.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 00:23:43 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v4 mptcp-next 1/5] mptcp: export mptcp_subflow_active
Date: Wed, 31 Mar 2021 15:23:32 +0800
Message-Id: <69be5c2c98752dfe6cfe572ef5f13ff701618bd0.1617175133.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617175133.git.geliangtang@gmail.com>
References: <cover.1617175133.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moved the static function mptcp_subflow_active to protocol.h
as an inline one.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c | 12 ------------
 net/mptcp/protocol.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9d7e7e13fba8..a625c4e63152 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -399,18 +399,6 @@ static void mptcp_set_timeout(const struct sock *sk, const struct sock *ssk)
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
 
-static bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
-{
-	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-
-	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
-	if (subflow->request_join && !subflow->fully_established)
-		return false;
-
-	/* only send if our side has not closed yet */
-	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
-}
-
 static bool tcp_can_send_ack(const struct sock *ssk)
 {
 	return !((1 << inet_sk_state_load(ssk)) &
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 14f0114be17a..d9a489c73029 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -539,6 +539,18 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
 
+static inline bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
+	if (subflow->request_join && !subflow->fully_established)
+		return false;
+
+	/* only send if our side has not closed yet */
+	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
+}
+
 static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 					      struct mptcp_subflow_context *ctx)
 {
-- 
2.30.2

