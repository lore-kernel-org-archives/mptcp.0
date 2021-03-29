Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B46F
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:41:13 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id v8so4192627plz.10
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8vMl4f//rXKDoqm55l8AC1W1Kpohia120GgcuH6Y/U=;
        b=blz2JWWnr/aUsYAHZLpk3BhlWexJ7BsCt9sWe5ZHBMg7BbVJIzNCwzAnQCYH5JBVvg
         hJJr8kEw3rcCm4Nx17h8ztI6sAAYRyMn9YSJibJ+GsxndKV83vHsERFBBoNoDi1qOn/P
         kSpnW3qHMQRFQ3zdgZdGzvDdd0HZaumQEIV2vWo0zDn/4Pa8bJ42TFbH8aR/3agZ2kgz
         XYLNv3jBA3e7K4ZPQrJOPqdcUzcWbqjG0j7Ib8oqCwkhrGeuHoPbQl+JyxPjY81eJ/YS
         /uA2enmrusd7eVotIQcQ5Xrv8Z+6LSWwxEaT7PmQRwqvvK1ro9x+H9ohyZt/kA8FUd0u
         eITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8vMl4f//rXKDoqm55l8AC1W1Kpohia120GgcuH6Y/U=;
        b=AG9zFsjK0gGS46abh0X9bEN+Z3Q8jCetNzqPDxaSAJT0W/4eLLOYktJlLi5lLnlGzU
         SvmLHtkBgPPYdHxn42qviu5NNvgzILwcdTCIKjCbR27+4YTtqlGsxRkazCYpEPmHNLJL
         OhQevwOjZdINWEshRGKfZ3h1uosKuANqR4AvnpKUWEC5BK5tTNUDbwfWNhFUXwGWGF4K
         GG39JWTMxLzHgyr9RMYAYwvO45Fn8tdTb8pNPJ8SzOwPd0I+ZSub9xIKTFzQTh5RtJ0y
         W6EebhTQyM+JdJvR08DZSnraQfSbItUb8ZNISmAw0hkBBgmNpQ0gJOorEdjGvGn6X+6z
         BJtA==
X-Gm-Message-State: AOAM533wUPEwy/S0CT0wCoJRFUy5rE6zOHknMa0H4fG7ZbZJWGiET2EL
	dMFmrTXfM07yOWywOvj+SqRgIHHiXQgq9Q==
X-Google-Smtp-Source: ABdhPJyrwDaymPChw3XxPtsrDZLRe/QMllCykKEZt93c3Hzs1CjA5k0mqs+jxprf4JvvKPVVKyXcPA==
X-Received: by 2002:a17:90a:c81:: with SMTP id v1mr25322487pja.23.1617014472556;
        Mon, 29 Mar 2021 03:41:12 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id v25sm17143709pfn.51.2021.03.29.03.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:41:12 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 06/16] mptcp: add csum_reqd in mptcp_options_received
Date: Mon, 29 Mar 2021 18:40:37 +0800
Message-Id: <d8a242cfe08b2ab0ccb4752a15c8ea8ef0226ac1.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <08ab4ce9f13e954b45d24c9e7842f7a6a9798d54.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com> <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com> <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com> <14b6923c9fd052b140d5af261dfd2575d94b3e05.1617014019.git.geliangtang@gmail.com> <08ab4ce9f13e954b45d24c9e7842f7a6a9798d54.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new flag csum_reqd in struct mptcp_options_received, if
the flag MPTCP_CAP_CHECKSUM_REQD is set in the receiving MP_CAPABLE
suboption, set this flag.

In mptcp_sk_clone and subflow_finish_connect, if the flag csum_reqd is set,
set the flag msk->csum_enabled to true.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 5 ++---
 net/mptcp/protocol.c | 2 ++
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 2 ++
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0f9abe8ea7cd..6acb7469bae9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -71,11 +71,9 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		 * "If a checksum is not present when its use has been
 		 * negotiated, the receiver MUST close the subflow with a RST as
 		 * it is considered broken."
-		 *
-		 * We don't implement DSS checksum - fall back to TCP.
 		 */
 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
-			break;
+			mp_opt->csum_reqd = 1;
 
 		mp_opt->mp_capable = 1;
 		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
@@ -342,6 +340,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->dss = 0;
 	mp_opt->mp_prio = 0;
 	mp_opt->reset = 0;
+	mp_opt->csum_reqd = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b053f92a8ee1..436969d95e36 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2718,6 +2718,8 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->token = subflow_req->token;
 	msk->subflow = NULL;
 	WRITE_ONCE(msk->fully_established, false);
+	if (mp_opt->csum_reqd)
+		WRITE_ONCE(msk->csum_enabled, true);
 
 	msk->write_seq = subflow_req->idsn + 1;
 	msk->snd_nxt = msk->write_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e5cbf5153d8f..ae7d47352d09 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -132,6 +132,7 @@ struct mptcp_options_received {
 		rm_addr : 1,
 		mp_prio : 1,
 		echo : 1,
+		csum_reqd : 1,
 		backup : 1;
 	u32	token;
 	u32	nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 010e2fec5189..cbdfa5a6f8f6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -405,6 +405,8 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			goto fallback;
 		}
 
+		if (mp_opt.csum_reqd)
+			WRITE_ONCE(mptcp_sk(parent)->csum_enabled, true);
 		subflow->mp_capable = 1;
 		subflow->can_ack = 1;
 		subflow->remote_key = mp_opt.sndr_key;
-- 
2.30.2

