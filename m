Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C9E3FC5
	for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 09:19:20 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so2237010pjb.5
        for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 02:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TgyOHpmTRrA/igPOpJsKgQpFqmbGpqzqPLSg8lcVocc=;
        b=jT0CjQXTft1GO+MhvFM/QCYPEZtbHHR5YQr6CPsHVNuj6OxeQACAT1vQI2HKJTlIWT
         zopexvyXTB55+Y1fy7CXa68wvq8ReV7Lgm6+YFvBuqW+7MlJeyPY/1xIMdswZmF/Kvhz
         c9YOSuhfKgvCto0dTjwC5DTlI8nd7lrNiNvLqPx3jKvrZxE+7yUyVwy7UvbeHqkCWwHh
         rsmEJHjyEIn2CX7a2nNpVNX+io9z9H6mnGaDy+yVxYBSWvdyBXV+A5tTnhhsROCd51dZ
         pBNY72AsIzxaysjPkh4UOmQIk7IhE8duFpwS/oiklMITzoGjz3yFoLEHNE1pDw8ajU7m
         HLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TgyOHpmTRrA/igPOpJsKgQpFqmbGpqzqPLSg8lcVocc=;
        b=y3oFJO3qeXoYOLXR14UUPramJjb8V01L7HIcJ8sY1wd28aG6ZMdcXJtRxxbjofGLa3
         NlPtKo+d6choIw24K0j0xEw/tCDwK9M6ayrDSjdDWLT2a++lnC5WR690zu35U29c9T0T
         G38hPqI/RH45uO5Ckz4WtixF0k4ICnrztNjc4LQywS19P1qUiIwEokQSneGcvSFmkpIp
         ooVevIFfH5/PR7ilJogR9t81czZgJ35ZYqoSgvKlMK3Sx4uozUsX4k2gFMVZLVSf/cfl
         M8KFHH2M1Kaoe5ytfwXO9wEnA3M/Cvo/hUNyAeAY+Uke1zYzUZVEb74PAZKvt7MMR06+
         MYZA==
X-Gm-Message-State: AOAM531HjfpqrGnpGl2zwV8xNVEFFYj653eOPKx0hd6xN4WR7IODDlgw
	lVHmX8V92BByRnU/1lxypyqV++Eq9nY=
X-Google-Smtp-Source: ABdhPJxRPO0kMbToKYdjArq4ET6cnGkZqmQ+IYrHg48WfS4pHMFDR865OyHvySN8aVWZr9Nkdfo/ZQ==
X-Received: by 2002:a17:90a:4501:: with SMTP id u1mr985035pjg.176.1631611160441;
        Tue, 14 Sep 2021 02:19:20 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id i21sm10851317pgn.93.2021.09.14.02.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:19:20 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v3 3/8] mptcp: infinite mapping sending
Date: Tue, 14 Sep 2021 17:19:02 +0800
Message-Id: <27b8dba6a8057eda732ec4e304087c34f777c7df.1631610729.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631610729.git.geliangtang@gmail.com>
References: <cover.1631610729.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the infinite mapping sending logic.

Added a new flag send_infinite_map in struct mptcp_subflow_context. Set
it true when a single contiguous subflow is in use in
mptcp_pm_mp_fail_received.

In mptcp_sendmsg_frag, if this flag is true, call the new function
mptcp_update_infinite_map to set the infinite mapping.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h  |  3 ++-
 net/mptcp/options.c  |  6 ++++--
 net/mptcp/pm.c       |  6 ++++++
 net/mptcp/protocol.c | 19 +++++++++++++++++++
 net/mptcp/protocol.h | 12 ++++++++++++
 5 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f83fa48408b3..29e930540ea2 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -35,7 +35,8 @@ struct mptcp_ext {
 			frozen:1,
 			reset_transient:1;
 	u8		reset_reason:4,
-			csum_reqd:1;
+			csum_reqd:1,
+			infinite_map:1;
 };
 
 #define MPTCP_RM_IDS_MAX	8
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 422f4acfb3e6..9c175c298ff6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -816,8 +816,10 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	opts->suboptions = 0;
 
-	if (unlikely(__mptcp_check_fallback(msk)))
-		return false;
+	if (unlikely(__mptcp_check_fallback(msk))) {
+		if (!mptcp_check_infinite_map(skb))
+			return false;
+	}
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
 		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6ab386ff3294..4fad1fe8ba10 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -251,7 +251,13 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+
 	pr_debug("fail_seq=%llu", fail_seq);
+
+	if (!mptcp_has_another_subflow(sk) && mptcp_is_data_contiguous(msk))
+		subflow->send_infinite_map = 1;
 }
 
 /* path manager helpers */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e804ca0ac9e1..77183e247e4d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1274,6 +1274,23 @@ static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
 	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
 }
 
+static void mptcp_update_infinite_map(struct mptcp_sock *msk, struct sock *ssk,
+				      struct mptcp_ext *mpext)
+{
+	if (!mpext)
+		return;
+
+	mpext->infinite_map = 1;
+	mpext->data_seq = READ_ONCE(msk->start_seq);
+	mpext->subflow_seq = 0;
+	mpext->data_len = 0;
+	mpext->csum = 0;
+
+	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
+	pr_fallback(msk);
+	__mptcp_do_fallback(msk);
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1406,6 +1423,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 out:
 	if (READ_ONCE(msk->csum_enabled))
 		mptcp_update_data_checksum(skb, copy);
+	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
+		mptcp_update_infinite_map(msk, ssk, mpext);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
 	return copy;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5e07264ba62b..b923fdfbb396 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -433,6 +433,7 @@ struct mptcp_subflow_context {
 		backup : 1,
 		send_mp_prio : 1,
 		send_mp_fail : 1,
+		send_infinite_map : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
@@ -874,6 +875,17 @@ static inline void mptcp_do_fallback(struct sock *sk)
 
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)", __func__, a)
 
+static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
+{
+	struct mptcp_ext *mpext;
+
+	mpext = skb ? mptcp_get_ext(skb) : NULL;
+	if (mpext && mpext->infinite_map)
+		return true;
+
+	return false;
+}
+
 static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
-- 
2.31.1

