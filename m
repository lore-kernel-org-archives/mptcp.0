Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0871
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 14:32:27 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id p17so16234436plf.12
        for <mptcp@lists.linux.dev>; Fri, 14 May 2021 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qAQ2UsWFkoPWk8owoG7ng0el05DFsOUPOKMldpsNAQc=;
        b=olBxpyJXHKxjgnS7VTLI3q6s0Z5kGPbZln8rsRwA9dL4JGfSXIclzZxSVn8iMsAS11
         FoHSfDvosx7SS+NCCYOQZUo14BBThKeBSfpi5MCRKcMTIJ0iq6eo6DpkB3W29aNINDeu
         M7W9LSKIlEPZSomG+80UHTrldzvu82dmFFwOMxB8A1UinVA0hKa0CP+SawDgISi9ggyy
         p1KYN/cLy9Ply2x4aGe5RLfjAELyBNemPzYK/8g+Kvme1Mpaodvknst4VRvruP3u/pAY
         0Dzq4W+EyAHtwOz3Y6SXpjVITMu545lzgwzbWU0rRUTSDgwnE3NKtXInSi+ZXUqI/tC2
         lEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAQ2UsWFkoPWk8owoG7ng0el05DFsOUPOKMldpsNAQc=;
        b=od3za9dLmvNRi+CQ9hfD05H5ENttiNBDDkXVp18WWz1gK7koun2YouthmoZ7hYgQLd
         c5mBS38Zhj8e+4MXoHo4KjYNJwwn0iSQ4uj0yvT3whCQETP74/xpu8dVuoYd4XkZGbfC
         +5TMn15nnWCuM0Fo/XE9DNSdZ6hnmOm1ycdl1ib3jVW7gxCaDl8Ot8nNW2el6UodwCd1
         6w+njFGn0C+igbhYvJAdbNVhDos8uBxuiFd6kb9ig26aplNxRnxRCRclBnKFO/9cT9ba
         35sEoLP6/ICZzrQXkOxXtyAl8xjkziCBKaQs1VoeXeHjQBRGSZskPr50kGF+LKlOsVKm
         r66A==
X-Gm-Message-State: AOAM5330ZXg8KBeqlEGjSgL2/xdJskMxjmxtdxa/coj40KiQaXTHqX4M
	cBTeay0f8mZjvHajimu5N1vuPC0D2vQ=
X-Google-Smtp-Source: ABdhPJxVpYHXWEsUSeErBogqosZZE0YN6w4fw8LrWteUegiFkmd6IFgpH408DWN5meHRLNRUs/B93A==
X-Received: by 2002:a17:90a:4092:: with SMTP id l18mr11425131pjg.35.1621002747461;
        Fri, 14 May 2021 07:32:27 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id y13sm4225682pff.163.2021.05.14.07.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:32:27 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v6 mptcp-next 2/6] mptcp: add allow_join_id0 in mptcp_out_options
Date: Fri, 14 May 2021 22:32:15 +0800
Message-Id: <2a6a925510a7d79f0c2101d5d353f6b74f0e69bb.1621002341.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <d051657e9c51ccb27b32d443777896c6ae519444.1621002341.git.geliangtang@gmail.com>
References: <cover.1621002341.git.geliangtang@gmail.com> <d051657e9c51ccb27b32d443777896c6ae519444.1621002341.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch defined a new flag MPTCP_CAP_DENY_JOIN_ID0 for the third bit,
labeled "C" of the MP_CAPABLE option.

Add a new flag allow_join_id0 in struct mptcp_out_options. If this flag is
set, send out the MP_CAPABLE option with the flag MPTCP_CAP_DENY_JOIN_ID0.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h  | 3 ++-
 net/mptcp/options.c  | 6 ++++++
 net/mptcp/protocol.h | 6 ++++--
 net/mptcp/subflow.c  | 1 +
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d61bbbf11979..cb580b06152f 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -67,7 +67,8 @@ struct mptcp_out_options {
 	u8 backup;
 	u8 reset_reason:4,
 	   reset_transient:1,
-	   csum_reqd:1;
+	   csum_reqd:1,
+	   allow_join_id0:1;
 	u32 nonce;
 	u64 thmac;
 	u32 token;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b713828819b6..ab9e39d2e645 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -401,6 +401,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 	if (subflow->request_mptcp) {
 		opts->suboptions = OPTION_MPTCP_MPC_SYN;
 		opts->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk));
+		opts->allow_join_id0 = mptcp_allow_join_id0(sock_net(sk));
 		*size = TCPOLEN_MPTCP_MPC_SYN;
 		return true;
 	} else if (subflow->request_join) {
@@ -489,6 +490,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->sndr_key = subflow->local_key;
 		opts->rcvr_key = subflow->remote_key;
 		opts->csum_reqd = READ_ONCE(msk->csum_enabled);
+		opts->allow_join_id0 = mptcp_allow_join_id0(sock_net(sk));
 
 		/* Section 3.1.
 		 * The MP_CAPABLE option is carried on the SYN, SYN/ACK, and ACK
@@ -826,6 +828,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		opts->suboptions = OPTION_MPTCP_MPC_SYNACK;
 		opts->sndr_key = subflow_req->local_key;
 		opts->csum_reqd = subflow_req->csum_reqd;
+		opts->allow_join_id0 = subflow_req->allow_join_id0;
 		*size = TCPOLEN_MPTCP_MPC_SYNACK;
 		pr_debug("subflow_req=%p, local_key=%llu",
 			 subflow_req, subflow_req->local_key);
@@ -1200,6 +1203,9 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		if (opts->csum_reqd)
 			flag |= MPTCP_CAP_CHECKSUM_REQD;
 
+		if (!opts->allow_join_id0)
+			flag |= MPTCP_CAP_DENY_JOIN_ID0;
+
 		*ptr++ = mptcp_option(MPTCPOPT_MP_CAPABLE, len,
 				      MPTCP_SUPPORTED_VERSION,
 				      flag);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3d6bbdf00bfb..fd7ff2d28cb3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -79,8 +79,9 @@
 #define MPTCP_VERSION_MASK	(0x0F)
 #define MPTCP_CAP_CHECKSUM_REQD	BIT(7)
 #define MPTCP_CAP_EXTENSIBILITY	BIT(6)
+#define MPTCP_CAP_DENY_JOIN_ID0	BIT(5)
 #define MPTCP_CAP_HMAC_SHA256	BIT(0)
-#define MPTCP_CAP_FLAG_MASK	(0x3F)
+#define MPTCP_CAP_FLAG_MASK	(0x1F)
 
 /* MPTCP DSS flags */
 #define MPTCP_DSS_DATA_FIN	BIT(4)
@@ -352,7 +353,8 @@ struct mptcp_subflow_request_sock {
 	u16	mp_capable : 1,
 		mp_join : 1,
 		backup : 1,
-		csum_reqd : 1;
+		csum_reqd : 1,
+		allow_join_id0 : 1;
 	u8	local_id;
 	u8	remote_id;
 	u64	local_key;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 554e7ccee02a..41e1b5091e42 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -109,6 +109,7 @@ static void subflow_init_req(struct request_sock *req, const struct sock *sk_lis
 	subflow_req->mp_capable = 0;
 	subflow_req->mp_join = 0;
 	subflow_req->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk_listener));
+	subflow_req->allow_join_id0 = mptcp_allow_join_id0(sock_net(sk_listener));
 	subflow_req->msk = NULL;
 	mptcp_token_init_request(req);
 }
-- 
2.31.1

