Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F671
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 04:48:19 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id y32so3855497pga.11
        for <mptcp@lists.linux.dev>; Wed, 05 May 2021 21:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QIAqrWJ2Mm5uhiilKv5y/k+nyX0y7HVT5srGRz12/t8=;
        b=fEp9gFmuZhfg84cRtdrLU34IHTpzFLXoDzQ3dulJxVMlYLR+mYDVfff81NolMsOr0E
         raoO7lGR2280X3qklCd/wbLmfITVSSTNFRB6sPzwjK+lgn2dgwQEvUHzV/0vBgjJD+Ok
         UlWf61TArN1PlWCTZBL6fI2LKXFLfJ19gegGlc1uYtntzwI0QoNL7DzpgyicYlfHJxIU
         qVbhYNIVqV+3eQkEMBjt0o/TXXx4y/gG4ydp8cDcnThDa6MFOLdrwX3bIkWHwt6Gyyvj
         dzmM3IEqCXIWDCpo2RQ46KpbKwPuTcKFLlVUPK+PgBDnRU8qEQQbfTwo0XA6RlvY/6sx
         PMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QIAqrWJ2Mm5uhiilKv5y/k+nyX0y7HVT5srGRz12/t8=;
        b=FBYwCkUqKS43C9p6GEXqSi5E3mUTXgZBk3f1ZO4fN9xcyIvTOyiAmZoJpVwDRRpxnr
         zL2x8AzaGmr9cEpkjsF5gajCUs1guBczIcPPYkcE1Vnd8SVBQsFOY1Dx9tpAluSGmaGE
         gMPmeBLsMK1hYudfek2IMhK8O3FWVOZqlLxDNMsy4IeKtzecJMKmBp8FNDEM1uUchUH/
         I6bDcnunKtT5OV6thtg8pyWceTgz/Z696LIGPqyu74yZADN8KPfFQaDXiY3ouOafJji7
         ExWYHkK6FMUoB6gOoElMWmR4BschXGD6NzFtNdIWR94QmPLh92xDFoJtIKdNMvIeaIAA
         nA9w==
X-Gm-Message-State: AOAM531qcADPBm8WsUo16vuvJL9Xl7w+jAx4hSWCWxZfK8s1lfRXG8xs
	loaun1nhfeuEhY6bEEcpvC/hLNNsyvg=
X-Google-Smtp-Source: ABdhPJz+0WSNkEC3/8tHz81jvy8Euy3OD+EN1HD2SsMen6U8Hs5l5Pn4VkU55k+/Jf2SpqgcLYN9EQ==
X-Received: by 2002:a63:c49:: with SMTP id 9mr2322427pgm.381.1620276498641;
        Wed, 05 May 2021 21:48:18 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id c24sm776609pfi.32.2021.05.05.21.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 21:48:18 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v4 mptcp-next 2/4] mptcp: add allow_join_id0 in mptcp_out_options
Date: Thu,  6 May 2021 12:48:06 +0800
Message-Id: <75cdf44b996264eeacf424f60fecd873ebc47d39.1620275759.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <025c3e92286c1c425b6ce65b4feac7e416947e54.1620275759.git.geliangtang@gmail.com>
References: <cover.1620275759.git.geliangtang@gmail.com> <025c3e92286c1c425b6ce65b4feac7e416947e54.1620275759.git.geliangtang@gmail.com>
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
index 310c3887be91..630c87c62a87 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -403,6 +403,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 	if (subflow->request_mptcp) {
 		opts->suboptions = OPTION_MPTCP_MPC_SYN;
 		opts->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk));
+		opts->allow_join_id0 = mptcp_allow_join_id0(sock_net(sk));
 		*size = TCPOLEN_MPTCP_MPC_SYN;
 		return true;
 	} else if (subflow->request_join) {
@@ -491,6 +492,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->sndr_key = subflow->local_key;
 		opts->rcvr_key = subflow->remote_key;
 		opts->csum_reqd = READ_ONCE(msk->csum_enabled);
+		opts->allow_join_id0 = mptcp_allow_join_id0(sock_net(sk));
 
 		/* Section 3.1.
 		 * The MP_CAPABLE option is carried on the SYN, SYN/ACK, and ACK
@@ -833,6 +835,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		opts->suboptions = OPTION_MPTCP_MPC_SYNACK;
 		opts->sndr_key = subflow_req->local_key;
 		opts->csum_reqd = subflow_req->csum_reqd;
+		opts->allow_join_id0 = subflow_req->allow_join_id0;
 		*size = TCPOLEN_MPTCP_MPC_SYNACK;
 		pr_debug("subflow_req=%p, local_key=%llu",
 			 subflow_req, subflow_req->local_key);
@@ -1207,6 +1210,9 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		if (opts->csum_reqd)
 			flag |= MPTCP_CAP_CHECKSUM_REQD;
 
+		if (!opts->allow_join_id0)
+			flag |= MPTCP_CAP_DENY_JOIN_ID0;
+
 		*ptr++ = mptcp_option(MPTCPOPT_MP_CAPABLE, len,
 				      MPTCP_SUPPORTED_VERSION,
 				      flag);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 17ce5639665a..fd6fe3176e08 100644
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
@@ -351,7 +352,8 @@ struct mptcp_subflow_request_sock {
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
index 7a01723f6080..324aff0b2f16 100644
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

