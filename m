Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583D72
	for <mptcp@lists.linux.dev>; Sat,  8 May 2021 10:34:07 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id c21so9206529pgg.3
        for <mptcp@lists.linux.dev>; Sat, 08 May 2021 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KIy2FAOYHcSKinOcTsKwN6UfKHCgj0JUPC1P/6Qd3mo=;
        b=g4/hre6+OmdkTmEg1tdi6y2MeO/ku6PLR6qv4uz72B/2W4GCY2kufaGxZ+noGoPcMx
         VuaSFGpTCufaACDXpZ4spFgZSPs34ML23Hrd9aHIVsrNLOrsn/e88koHXya14oMieolb
         Kxfdj3KHaOum0hwPTmWmq+z9D67LYLT5CDxl9znYyi/eES7BBkCavs7TR7y1jEjaeW9D
         SIjKE7pWUdfqeNMJ2Nx/I/6X88MadbAvb7zW+clYsIhHunWKvK+dYJK5Grjiwe1sDKOu
         WIbkxrhvOigDq42IXNoJ/H9+NQcJaEGkCRoWN5fedERZNXSRSDuigUY5w4vXVAiMh/Yn
         tGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KIy2FAOYHcSKinOcTsKwN6UfKHCgj0JUPC1P/6Qd3mo=;
        b=SRvRhvwQGgAu5qwchBF+mTjCDz++CrUvdGIhIFtg3L0fk2Xtt7nIO833hzOn0hhziF
         M6H6477TB9QIk5S4DfsAImpjGOSi/wdmSvdu300zxC32FO1BMu91wLyxJ8x/yFQUgc8U
         ocLfFhx0HijXIJ4dkAIsg0bNrAfB4hMFnaoSMGxZoN000yGh+2l9Jq33QNQwtAW68cqV
         JmIihjBtFHc2b2R3CBcFYrUvjM0dRMYPCThCJEabF1hfgrWwuQjgs2BHII+wG5DLnY8H
         aBWQ4F4c2kWltPfzGt7Q6aJ2uoiQY5Vs5Bun+vtcxplCyRRum2zm/Ln+e4xc6GH/XYX8
         3ejQ==
X-Gm-Message-State: AOAM530NY8atqe9WUp9pvJx9WWR4t3diRTDRIy2Qjs/goJ1AlMmNw8no
	5vY8YhSux87Tyw0MabXR+5B6BD67HAU=
X-Google-Smtp-Source: ABdhPJwyxMfJv7UIkgwwucRckAYmbGDlEJfpukdlb8b8E+FRj2Ym25LHvfoSPjV5AsTFHywr1sE2rA==
X-Received: by 2002:a63:3242:: with SMTP id y63mr14451947pgy.87.1620470046690;
        Sat, 08 May 2021 03:34:06 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id a190sm6877956pfb.185.2021.05.08.03.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 03:34:06 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v5 mptcp-next 2/5] mptcp: add allow_join_id0 in mptcp_out_options
Date: Sat,  8 May 2021 18:33:25 +0800
Message-Id: <04612972cea357bc84aa01e145ac689a8397f466.1620469774.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <0edd6a3ad45c1f67a350356298ed4333fc42dac3.1620469774.git.geliangtang@gmail.com>
References: <cover.1620469774.git.geliangtang@gmail.com> <0edd6a3ad45c1f67a350356298ed4333fc42dac3.1620469774.git.geliangtang@gmail.com>
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
index 3428c163299b..441ec25e117d 100644
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
index c8968038174f..249a66ad54dc 100644
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

