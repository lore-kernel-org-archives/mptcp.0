Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE42FB1
	for <mptcp@lists.linux.dev>; Mon, 24 May 2021 07:07:30 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id 22so19696105pfv.11
        for <mptcp@lists.linux.dev>; Mon, 24 May 2021 00:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PxiQ/zt4bv5qFhspO2jncT4eNc2X4LIM55ZlOeHgeMw=;
        b=ogp21OwUewmqLf8f8yPWk5EPNevcXZ/Wyc9B6iK2oQP5ABr29uZKjEhQhjuF5+PvsD
         dFNFiNO5BqnHV0DicY8ZT9u13hUiAjVHF7g9aW+4m+E0jgQUqw9vpmQ1m1HAbFPxNCp8
         PUmdz2cHY+0saOfPloaM7hOER4G2kvANMC+a6TnZW91w24VCw8iNT1jQdrMigemNMU4Q
         Y4YF55yzHtgon1Jd+RidzS2G//7OtqrGGpcHFYK5i5Aehb2oQGNcoD9/QcL3mxtZNqVw
         +C4vSaTR66vT057Mg/ZBz7sOUkdcIL1eHaMxlldzkGX6QzKy5Qx++bm+JPZ7z+uZoEx0
         4DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PxiQ/zt4bv5qFhspO2jncT4eNc2X4LIM55ZlOeHgeMw=;
        b=A55gyRID+I/Ad1v5WJacYo91Q4Ynu1/QcMeuUnfIWWnuiFKzD8SwiAb5EJtnwgxtmB
         AyJj2Zkv1IBrsvj4fFgR2DMe5yvhPo1aOKuK7ubpEBIhj1U7Hbos2VLrFNcXAIZX6IXI
         bkqum0SJHdHSkATaNPZ5i8otHCIrsnJIMIPJyF79aSD7LhpQA4v1rslZMwApeCwkqdYN
         xGAyXw269NJUmStUksrJan5Q3Fnr5oyYrsVnNNzLO9UxemtFCnrQS55u7WwMjTOGctQK
         rjA+7KE2uPUMFtikP8w44WyvKXB/mXbGCiUJGNvtGS/ogswREPRAmJSOj4yAfJBhHJ5f
         SZtQ==
X-Gm-Message-State: AOAM533PLLhPUhIWHm0d0ZNIMmZuhiDYEjokVzbIudeZS7dc14453Ao1
	vmWzH0Y5H+YbBEtoUtkwzMWyBC4yzv8fpw==
X-Google-Smtp-Source: ABdhPJy3/xu7Mvz147EckuL/K16aWsw3O9/YecLc+SFIihIPp744Be9K5E1Dx12H07cWIzWEdU/DiA==
X-Received: by 2002:a65:6705:: with SMTP id u5mr12107982pgf.418.1621840049570;
        Mon, 24 May 2021 00:07:29 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id t7sm9217456pju.4.2021.05.24.00.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:07:29 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v7 mptcp-next 2/5] mptcp: add allow_join_id0 in mptcp_out_options
Date: Mon, 24 May 2021 15:07:16 +0800
Message-Id: <372e8fb0d481dfed41cf7e01c60b18c55a852f7e.1621839764.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <7df5c99cf5336e3c1b0225903c75d01bbcde8daf.1621839764.git.geliangtang@gmail.com>
References: <cover.1621839764.git.geliangtang@gmail.com> <7df5c99cf5336e3c1b0225903c75d01bbcde8daf.1621839764.git.geliangtang@gmail.com>
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
index 1aec01686c1a..1e921b5103bf 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -400,6 +400,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 	if (subflow->request_mptcp) {
 		opts->suboptions = OPTION_MPTCP_MPC_SYN;
 		opts->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk));
+		opts->allow_join_id0 = mptcp_allow_join_id0(sock_net(sk));
 		*size = TCPOLEN_MPTCP_MPC_SYN;
 		return true;
 	} else if (subflow->request_join) {
@@ -488,6 +489,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->sndr_key = subflow->local_key;
 		opts->rcvr_key = subflow->remote_key;
 		opts->csum_reqd = READ_ONCE(msk->csum_enabled);
+		opts->allow_join_id0 = mptcp_allow_join_id0(sock_net(sk));
 
 		/* Section 3.1.
 		 * The MP_CAPABLE option is carried on the SYN, SYN/ACK, and ACK
@@ -825,6 +827,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		opts->suboptions = OPTION_MPTCP_MPC_SYNACK;
 		opts->sndr_key = subflow_req->local_key;
 		opts->csum_reqd = subflow_req->csum_reqd;
+		opts->allow_join_id0 = subflow_req->allow_join_id0;
 		*size = TCPOLEN_MPTCP_MPC_SYNACK;
 		pr_debug("subflow_req=%p, local_key=%llu",
 			 subflow_req, subflow_req->local_key);
@@ -1199,6 +1202,9 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		if (opts->csum_reqd)
 			flag |= MPTCP_CAP_CHECKSUM_REQD;
 
+		if (!opts->allow_join_id0)
+			flag |= MPTCP_CAP_DENY_JOIN_ID0;
+
 		*ptr++ = mptcp_option(MPTCPOPT_MP_CAPABLE, len,
 				      MPTCP_SUPPORTED_VERSION,
 				      flag);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c07db980b5da..1201ab04bcdf 100644
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
index 2f13d795c2fc..0f4dc708e9b2 100644
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

