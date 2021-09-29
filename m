Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD03FCB
	for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 07:35:20 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id k23so1019189pji.0
        for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 00:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sTKax05uNK5ByDTvZtVlCp5fJJbqmfIsYov3HOE/pIo=;
        b=Yy6mF8tnlTTVgIk34mdeSjlJKhbuJxXjpI2v7Np+hAhTBmbaYVxzzziKhWdEAr/RVJ
         6TW3JW58N/rlrRSBS4tLjRKwPTluPLfdZvKxekHAyigqjR9ptEi60bfJPg+dkkpvjJBI
         74OP3bxF9Ay0r8mdQI+xQa9I+RoyMnGOOB+OHSCFjOzEwlARbvrpxNxSHqzsaj5BqfUf
         OFSD+KxHB2euP74cw6GbaWHfvNmSQ972XyuouybQdg0cKVlRN3chN3G0HIFe6TVFXq/J
         k8Aku44eFXrOwdzeeiPLkBNJv330EGIDhPk8+czdS/Ud/8ILdfvPWld5mt19dTDgpM9b
         SrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sTKax05uNK5ByDTvZtVlCp5fJJbqmfIsYov3HOE/pIo=;
        b=loYA5fU6jmHCCUedL84uYPADY1I6rk7GC6fmd3xsv3xhhZLcGLiKzlmUUHJc1PZJ4M
         JXOhZdGtDaGkqWXZSxcIQd1K1dhwHbSXy7SZnnLuabL0Ji9/8GfHGgRwyKPdWUYpDtyT
         5Sh9u2TChijC1RdmcTZKtQ9r1caz2WzzhXYHOvTEcjbsSIL3HqWLWHusaw/KjoBGVSy0
         p2jZjGhx4ceVf8HRftfyKhqBhLva6onCrQ3wxSSDPK/ZSpKK7emDgxeDIcKkaIT96TvE
         QSRiQypj3sKCRIX1yQ+kQqq405p/PeeAMUPk+QBih83KrUwguAnh7tapINDZ3Bmk0nMj
         usTg==
X-Gm-Message-State: AOAM5334DwvY55h31JuUh3jQsMsunmXDyP/YgzkrlNxERrRD5AQeG7na
	YI416Lrbj2tVGFy5GbsWtUSzenGDd9L5Zw==
X-Google-Smtp-Source: ABdhPJw4AWxZKKRhZ3jQa9+VifEnO4poVITyVraLBPKnalXSS6NFT0ux62dFn8nbOj9ef2HfOal32g==
X-Received: by 2002:a17:90a:ae18:: with SMTP id t24mr4775746pjq.92.1632900920442;
        Wed, 29 Sep 2021 00:35:20 -0700 (PDT)
Received: from MiBook.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id gn11sm937853pjb.36.2021.09.29.00.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 00:35:20 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v6 5/9] mptcp: infinite mapping sending
Date: Wed, 29 Sep 2021 15:35:03 +0800
Message-Id: <2128ccf27ebb66936b4a908dd5704dd7d7c72807.1632900306.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632900306.git.geliangtang@gmail.com>
References: <cover.1632900306.git.geliangtang@gmail.com>
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

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h  |  3 ++-
 net/mptcp/options.c  |  2 +-
 net/mptcp/pm.c       |  5 +++++
 net/mptcp/protocol.c | 19 +++++++++++++++++++
 net/mptcp/protocol.h | 12 ++++++++++++
 5 files changed, 39 insertions(+), 2 deletions(-)

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
index 422f4acfb3e6..f4591421ed22 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -816,7 +816,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	opts->suboptions = 0;
 
-	if (unlikely(__mptcp_check_fallback(msk)))
+	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
 		return false;
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6ab386ff3294..5b99c0c9c17e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -251,7 +251,12 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+
 	pr_debug("fail_seq=%llu", fail_seq);
+
+	if (mptcp_allow_infinite_fallback(sk))
+		subflow->send_infinite_map = 1;
 }
 
 /* path manager helpers */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 334bbce69fcb..5b73493c75c5 100644
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
+	mpext->data_seq = READ_ONCE(msk->last_ack_dss_start);
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
index 7927acf53f06..9da4dd3b2e2d 100644
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
@@ -872,6 +873,17 @@ static inline void mptcp_do_fallback(struct sock *sk)
 
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

