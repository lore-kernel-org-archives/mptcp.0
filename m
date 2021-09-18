Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3821872
	for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 07:22:36 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so11612167pjr.1
        for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 00:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQ7V+nHagV4ARUFxgBUHUq7xiW26Oe1iCKGV8p1+45Y=;
        b=aAGygvfgzCtLNpQ/UZra3mJCplqffVwK6cRaHlAhCypHVVhfRyg1BGMpCU6dIy3epg
         M0AUOhXeUh5Oc2NWCFx5jyEG0jPAL4s3GPukTS/rfAgH97p8fd2luhH8gF/m+dEwbE50
         2l64EwKlrZIZQ2aT6fxtEGsDjOAG5yMXgZ/Z9hGWozVvtzBUq8lW/hoP0mb/Y/5yv/6Z
         rmSKuUDlwfYSoWY0PSCfFtNep9uEZ8QUqT4mV/+xxC9xHJlBFU/ZlW9rMsvmPjgF3R+s
         MX09soVUbJIHRkiFUrKtAc/DENApsXZ75l/Jlv4lj49CoVb5ebrRRfiF6WOpnfwaQdAH
         EKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQ7V+nHagV4ARUFxgBUHUq7xiW26Oe1iCKGV8p1+45Y=;
        b=by93FJVx+sK+qnQPj4AigTLEVClOmBDkIwXDzwsaZUeVjrNSKps1WxJbwNdsY3mI7N
         3XcduJdXCRhp7mrINojZYfBNprEOTL2SEaBB0vhhEINMuNrnBWzyWAFK3/da99VyRlt2
         6YJDMbu8XQXUfdluaUXyltaatVmxQ+1yzAUvBJtUP0WojVonRUR8qY5dGKwja36MvEuz
         hWdR+b5zirQB5iuH7oyrd4jqlpOLSLWRKDKf/4hRKR8M+71IC43F/SA81/2NVZxweHTi
         AeWS0mxvZAUO/v+/wlADjH3Y76Xhk22cKKj8QUC6uqaXoCBcJoIeIVMJByoQe6GgtDR7
         1HRg==
X-Gm-Message-State: AOAM53150A+93gO7gY3KAzaK7r8CdC4Mg6Ntth16OJxZsKXYVH+4BubP
	ysDgZ28lUc4E5iD+frXOMIP4TPCujfo=
X-Google-Smtp-Source: ABdhPJyNYuFEABwiVnpKAtUZ2v25ANHz1f9FpCgZiW4HggTykSoQmxzf9Vx1GlAgh/DRfOi9V6oHoQ==
X-Received: by 2002:a17:90a:6708:: with SMTP id n8mr19592281pjj.219.1631949755661;
        Sat, 18 Sep 2021 00:22:35 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 77sm8040214pfu.219.2021.09.18.00.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:22:35 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v4 3/8] mptcp: infinite mapping sending
Date: Sat, 18 Sep 2021 15:22:18 +0800
Message-Id: <00acc9c10fe938ac26eaec0ed5454e32adf4aecd.1631949480.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631949480.git.geliangtang@gmail.com>
References: <cover.1631949480.git.geliangtang@gmail.com>
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
index b056672541df..ffef7e1f061b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1279,6 +1279,23 @@ static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
 	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
 }
 
+static void mptcp_update_infinite_map(struct mptcp_sock *msk, struct sock *ssk,
+				      struct mptcp_ext *mpext)
+{
+	if (!mpext)
+		return;
+
+	mpext->infinite_map = 1;
+	mpext->data_seq = READ_ONCE(msk->last_fully_acked_dss_start_seq);
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
@@ -1411,6 +1428,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 out:
 	if (READ_ONCE(msk->csum_enabled))
 		mptcp_update_data_checksum(skb, copy);
+	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
+		mptcp_update_infinite_map(msk, ssk, mpext);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
 	return copy;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2f8a8589668c..cb26183aec9b 100644
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

