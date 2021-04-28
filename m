Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632452F80
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 07:01:16 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id p12so44060375pgj.10
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 00:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sr2AcqGaUFesMNLlvYAQvlGrgYRXAc1mxAeJubli6+Y=;
        b=RLxeLD1pQNWLpNr2rfVeEJCbEH4VQLXgXK3s+WmtcI2WUsvpuCp1sAh+TS37PFkFfi
         N7M26Tc1pkuj3E7wocVzDCSHIRNc7aEOvyM8yt0uHTj0VePJecKWipDKAC0plYeFiNoc
         HdDuUb6Y9mTp4XBLejilMkzkxp1rC1ilVy94C3QYgsH2u/e4yKN2eFQCutOwuQ34tcXV
         J7dgow8gRcXsndNDbw8uWf1qLPOPs6Iymw+k+tQC+VXAryQSzUwl07D2qC1nMgBE9k49
         RFaByQm+To3peW0vlzfPkswa7u3oAvXfuuCx/mImSqNXMtyVSAMorP7Ap1AMAY9VTzQ0
         R0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sr2AcqGaUFesMNLlvYAQvlGrgYRXAc1mxAeJubli6+Y=;
        b=ahuoNTsfhtQWbq3W2oo4K82s6DHIJCJptDi4mz6wyzC8TWowpfXrZprdRwuWPpz9fO
         BrIR6ohKDGhv8IIltkTA3rVk8Z2vsC1yIs+bSGaQ1Sesb5pgpdrwyAbuCEnztxgJJUQA
         xQeId4qMPiDo1uMJ6ZUvbzS8I5dhYFgjN7ielQeNxYHljpTdgETsKdJlhl7IV03LvGWX
         MZqBKRWWL5UvHdP3ih6vPdraewXV5LC3UisTfcmdVdvS5zQAj6FPkKc49jVWmGOPa6s4
         c4SUrQyp0iMU2UzPT7wjjpqrdbbnz0IBbCJO9KLqalF6cEYF/q1tHy+3jceO4tn/Pcx+
         2pZQ==
X-Gm-Message-State: AOAM532raaXgRRyrxkjey7C3SggVleE6miNjpSjideabjbw0siAwb6la
	sg01Wl1Gr8tHYI5Aeqj+fuWqi1DXcqI=
X-Google-Smtp-Source: ABdhPJxZl5pDL3Fr93IjS4/yNX6MWteHpHSRfbRDn+0dT2SbjrbJGRZk4GMzMJgSeN37Tw/i6+7CPg==
X-Received: by 2002:a62:4d86:0:b029:252:c889:2dd8 with SMTP id a128-20020a624d860000b0290252c8892dd8mr27306428pfb.41.1619593275815;
        Wed, 28 Apr 2021 00:01:15 -0700 (PDT)
Received: from localhost ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id p12sm4045890pjo.4.2021.04.28.00.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 00:01:15 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 2/4] mptcp: add allow_join_id0 in mptcp_out_options
Date: Wed, 28 Apr 2021 15:01:04 +0800
Message-Id: <65d1e4e729dfbeb5d0e51760affe2745e211cb50.1619592361.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <51758a7f629764dc91186acbf09665992e5b8e69.1619592361.git.geliangtang@gmail.com>
References: <cover.1619592361.git.geliangtang@gmail.com> <51758a7f629764dc91186acbf09665992e5b8e69.1619592361.git.geliangtang@gmail.com>
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
 include/net/mptcp.h  |  3 ++-
 net/mptcp/options.c  | 10 ++++++++--
 net/mptcp/protocol.h |  6 ++++--
 net/mptcp/subflow.c  |  1 +
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 83f23774b908..d259796326ea 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -64,7 +64,8 @@ struct mptcp_out_options {
 	u8 join_id;
 	u8 backup;
 	u8 reset_reason:4;
-	u8 reset_transient:1;
+	u8 reset_transient:1,
+	   allow_join_id0:1;
 	u32 nonce;
 	u64 thmac;
 	u32 token;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 99fc21406168..58ea22bf3d3d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -381,6 +381,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 	subflow->snd_isn = TCP_SKB_CB(skb)->end_seq;
 	if (subflow->request_mptcp) {
 		opts->suboptions = OPTION_MPTCP_MPC_SYN;
+		opts->allow_join_id0 = mptcp_is_allow_join_id0(sock_net(sk));
 		*size = TCPOLEN_MPTCP_MPC_SYN;
 		return true;
 	} else if (subflow->request_join) {
@@ -466,6 +467,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->suboptions = OPTION_MPTCP_MPC_ACK;
 		opts->sndr_key = subflow->local_key;
 		opts->rcvr_key = subflow->remote_key;
+		opts->allow_join_id0 = mptcp_is_allow_join_id0(sock_net(sk));
 
 		/* Section 3.1.
 		 * The MP_CAPABLE option is carried on the SYN, SYN/ACK, and ACK
@@ -790,6 +792,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 	if (subflow_req->mp_capable) {
 		opts->suboptions = OPTION_MPTCP_MPC_SYNACK;
 		opts->sndr_key = subflow_req->local_key;
+		opts->allow_join_id0 = subflow_req->allow_join_id0;
 		*size = TCPOLEN_MPTCP_MPC_SYNACK;
 		pr_debug("subflow_req=%p, local_key=%llu",
 			 subflow_req, subflow_req->local_key);
@@ -1124,7 +1127,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 {
 	if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
 	     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
-		u8 len;
+		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
 
 		if (OPTION_MPTCP_MPC_SYN & opts->suboptions)
 			len = TCPOLEN_MPTCP_MPC_SYN;
@@ -1135,9 +1138,12 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		else
 			len = TCPOLEN_MPTCP_MPC_ACK;
 
+		if (!opts->allow_join_id0)
+			flag |= MPTCP_CAP_DENY_JOIN_ID0;
+
 		*ptr++ = mptcp_option(MPTCPOPT_MP_CAPABLE, len,
 				      MPTCP_SUPPORTED_VERSION,
-				      MPTCP_CAP_HMAC_SHA256);
+				      flag);
 
 		if (!((OPTION_MPTCP_MPC_SYNACK | OPTION_MPTCP_MPC_ACK) &
 		    opts->suboptions))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bb901435c2d4..fcbaf47ce3bc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -77,8 +77,9 @@
 #define MPTCP_VERSION_MASK	(0x0F)
 #define MPTCP_CAP_CHECKSUM_REQD	BIT(7)
 #define MPTCP_CAP_EXTENSIBILITY	BIT(6)
+#define MPTCP_CAP_DENY_JOIN_ID0	BIT(5)
 #define MPTCP_CAP_HMAC_SHA256	BIT(0)
-#define MPTCP_CAP_FLAG_MASK	(0x3F)
+#define MPTCP_CAP_FLAG_MASK	(0x1F)
 
 /* MPTCP DSS flags */
 #define MPTCP_DSS_DATA_FIN	BIT(4)
@@ -338,7 +339,8 @@ struct mptcp_subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u16	mp_capable : 1,
 		mp_join : 1,
-		backup : 1;
+		backup : 1,
+		allow_join_id0 : 1;
 	u8	local_id;
 	u8	remote_id;
 	u64	local_key;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 15620bafc544..fb5b6eb5bec9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -108,6 +108,7 @@ static void subflow_init_req(struct request_sock *req, const struct sock *sk_lis
 
 	subflow_req->mp_capable = 0;
 	subflow_req->mp_join = 0;
+	subflow_req->allow_join_id0 = mptcp_is_allow_join_id0(sock_net(sk_listener));
 	subflow_req->msk = NULL;
 	mptcp_token_init_request(req);
 }
-- 
2.30.2

