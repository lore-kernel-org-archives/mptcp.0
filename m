Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9DD6E
	for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 11:37:42 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id q11so6405329pld.11
        for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 04:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=thg5ghxi0v208+1k5o93UIYrXfh95s3ovcweJ7NyI2E=;
        b=t08Gr6mHT93qT1MKb4rSp1fvpZzyQfAC4p/GNKh3qi2EKm/xMdoi0iLWdoyShLY4YT
         cOnP0WcyQcHcfYWMDmnWqOMsMrPWNKJwKYPLyryaprDf1RE7oStVo+NTf4H6XysppTa9
         cNnwNJxFdIyYlQ6rbzFaD+bG3RGhv0Vofhh3/NN4OxNSQTiozDazZAUfam220LaGKgyG
         mv1zE10NKc6EKy119R4lCDyQykCza9LKFTFqdTQptZG2eVDg7bMcawAG9ShgLO7DjCNb
         G6Pqcn1L5eAYWVUYd7w+QZpy0fylFhym+KcV6xj7uAOtz6ewe9clOhbC5gs0YPVcyrkj
         kvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thg5ghxi0v208+1k5o93UIYrXfh95s3ovcweJ7NyI2E=;
        b=lnzqyTAPWbXfeBaBxmunSnTsU+XNERB++gKJD66ZvQlVSePr2T38hIuqcyGxrTS4x5
         sUhwzo2aSxjSA/pFR5Kn4kaVClHBwuEKDraXpoHh3L5R3vZEd0BakcLBGubwDambd0bL
         uC5alrA8NxMcxvPLETUnIF7XqplWFJOFWSeVsbDa+3v1s7W5ZaMSFN+W4QgZH7V0S+DX
         a7IQZnYZayhneBdMNySKRxVvQsufLaxB5cjE22yi/KvwSXFQFelamMKKqV5T8Ql3zm7P
         iq1JgLcU6nHRSvprgUHVjH14u1ot1dOfIPm1rU4yh9uu8YFpHb77M5dS5Z6Y5h3vuPAX
         mP3Q==
X-Gm-Message-State: AOAM530A9gUTuK8SI0Ndr9CNLEfIklEMxu2iASfaPX6wVAeQ8Wsh+JjN
	aKkcXHDhWkhYJoVRdFVgcGk=
X-Google-Smtp-Source: ABdhPJzgVg/1yIMds1rQE95nm5NYhrD2lHhUP/T/g7/Ldr/KAQ7SW/6f4Pp3n7D3tlr09ZSkE+9eEA==
X-Received: by 2002:a17:90a:f296:: with SMTP id fs22mr12700421pjb.17.1616413062136;
        Mon, 22 Mar 2021 04:37:42 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id e63sm13326390pfe.208.2021.03.22.04.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:37:41 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.01.org,
	mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 2/6] mptcp: add csum_enabled in mptcp_out_options
Date: Mon, 22 Mar 2021 19:37:26 +0800
Message-Id: <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com>
References: <cover.1616412490.git.geliangtang@gmail.com> <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch add a new member csum_enabled in struct mptcp_out_options.
In mptcp_write_options, if this csum_enabled field is enabled, send out
the MP_CAPABLE suboption with the MPTCP_CAP_CHECKSUM_REQD flag.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h  |  3 ++-
 net/mptcp/options.c  | 10 ++++++++--
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  |  1 +
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 83f23774b908..36fb6907aa6f 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -64,7 +64,8 @@ struct mptcp_out_options {
 	u8 join_id;
 	u8 backup;
 	u8 reset_reason:4;
-	u8 reset_transient:1;
+	u8 reset_transient:1,
+	   csum_enabled:1;
 	u32 nonce;
 	u64 thmac;
 	u32 token;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e3fcd2b0ffd7..f45bebb923dc 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -379,6 +379,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 	subflow->snd_isn = TCP_SKB_CB(skb)->end_seq;
 	if (subflow->request_mptcp) {
 		opts->suboptions = OPTION_MPTCP_MPC_SYN;
+		opts->csum_enabled = mptcp_is_checksum_enabled(sock_net(sk));
 		*size = TCPOLEN_MPTCP_MPC_SYN;
 		return true;
 	} else if (subflow->request_join) {
@@ -464,6 +465,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->suboptions = OPTION_MPTCP_MPC_ACK;
 		opts->sndr_key = subflow->local_key;
 		opts->rcvr_key = subflow->remote_key;
+		opts->csum_enabled = mptcp_is_checksum_enabled(sock_net(sk));
 
 		/* Section 3.1.
 		 * The MP_CAPABLE option is carried on the SYN, SYN/ACK, and ACK
@@ -786,6 +788,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 	if (subflow_req->mp_capable) {
 		opts->suboptions = OPTION_MPTCP_MPC_SYNACK;
 		opts->sndr_key = subflow_req->local_key;
+		opts->csum_enabled = subflow_req->csum_enabled;
 		*size = TCPOLEN_MPTCP_MPC_SYNACK;
 		pr_debug("subflow_req=%p, local_key=%llu",
 			 subflow_req, subflow_req->local_key);
@@ -1116,7 +1119,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 {
 	if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
 	     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
-		u8 len;
+		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
 
 		if (OPTION_MPTCP_MPC_SYN & opts->suboptions)
 			len = TCPOLEN_MPTCP_MPC_SYN;
@@ -1127,9 +1130,12 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		else
 			len = TCPOLEN_MPTCP_MPC_ACK;
 
+		if (opts->csum_enabled)
+			flag |= MPTCP_CAP_CHECKSUM_REQD;
+
 		*ptr++ = mptcp_option(MPTCPOPT_MP_CAPABLE, len,
 				      MPTCP_SUPPORTED_VERSION,
-				      MPTCP_CAP_HMAC_SHA256);
+				      flag);
 
 		if (!((OPTION_MPTCP_MPC_SYNACK | OPTION_MPTCP_MPC_ACK) &
 		    opts->suboptions))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fd36239d8905..14f1e2fd3c08 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -335,7 +335,8 @@ struct mptcp_subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u16	mp_capable : 1,
 		mp_join : 1,
-		backup : 1;
+		backup : 1,
+		csum_enabled : 1;
 	u8	local_id;
 	u8	remote_id;
 	u64	local_key;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5fc3cada11dd..e2e9cc34713d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -106,6 +106,7 @@ static void subflow_init_req(struct request_sock *req, const struct sock *sk_lis
 
 	subflow_req->mp_capable = 0;
 	subflow_req->mp_join = 0;
+	subflow_req->csum_enabled = mptcp_is_checksum_enabled(sock_net(sk_listener));
 	subflow_req->msk = NULL;
 	mptcp_token_init_request(req);
 }
-- 
2.30.2

