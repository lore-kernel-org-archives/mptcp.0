Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082596F
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:41:02 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id ha17so5801832pjb.2
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vO6mVzuJ9Cu7qtrFTs/FFeLfmd3bj5FJKGN9fueFB/s=;
        b=BJgR/M4B5I2cxu/EtMhVwJFylXuwy57RQS6XNAGNEHJZYg1dTmbfr68PSLldDotk3a
         3CNjTr/6sqrf5G+6UP7n4scosnBfTqJ1jpX6l+GogXOffeStrlDi+HIwFierMMsloWup
         7iXbVj/3kWKglD5jHJai+ffmClWkrQJOcMm5hPjytKmDoy1VpxG0pOdkJoZmnSEiL8hz
         8BrSq0vUXNF1B5vTSQ0sgWAkcasmqiaC+4IC08YXNUlQRF0VDHejALmrqA0Paf4s62h7
         RYQjcVudSG7EQeHE7T1bMq7eCkwSZaP/zmkJ+ms35XIV3GIVNtJB1aYfyMQS58AFhDIq
         ZAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vO6mVzuJ9Cu7qtrFTs/FFeLfmd3bj5FJKGN9fueFB/s=;
        b=cTpf0RBZjWiIZ2Q9rIXyhWyMZvP6Cyon+xJWNfd5OYx6lrDSnCwuV0hniI3QZXNuXj
         GBWfz4pLYtVfJsoZx6IHqy2HiFF9ZJnb7Xq4onU2lJPp0oRsdoySUlX/Q74Qy+TRbyP8
         0kAdHUVyo6aMkamj8tnVggt28gExKEz2d8oOiEspUJah0d3TRY7g4Al4yAV1q3/CuMHT
         aN3XU2eTMHfvWXeiNokKs/MF9h0WN+4XnToLHpE8qhDqXV9t6sm/ZDDBMNt0opRjJbnz
         39nK5oaW+/ZNUEFHmI+Au/pXK1391HebMa/bAGAbcwBiWx6agUOWioiK/3BhKI1wcuSh
         7RAA==
X-Gm-Message-State: AOAM532MhH+NRlwYgqcFhITQ1GvmICMRYtcJel5yXF9gcR+MGcFnknpE
	uRtZd14uCp6Di7fWBmOrZg/ih0OYW4hSdw==
X-Google-Smtp-Source: ABdhPJyTkg3Bk7cKN5adcs0rx4LE/jBAq+iQ0fBMd4IQiZLMiZ1cV9aZWpv2Iw8Xg1AFE2gS+MOjyA==
X-Received: by 2002:a17:90a:e614:: with SMTP id j20mr25508983pjy.184.1617014462310;
        Mon, 29 Mar 2021 03:41:02 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id y29sm16632668pfp.206.2021.03.29.03.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:41:01 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 03/16] mptcp: add csum_reqd in mptcp_out_options
Date: Mon, 29 Mar 2021 18:40:34 +0800
Message-Id: <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com> <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new member csum_reqd in struct mptcp_out_options and
struct mptcp_subflow_request_sock. Initialized it with the helper
function mptcp_is_checksum_enabled().

In mptcp_write_options, if this field is enabled, send out the MP_CAPABLE
suboption with the MPTCP_CAP_CHECKSUM_REQD flag.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h  |  3 ++-
 net/mptcp/options.c  | 10 ++++++++--
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  |  1 +
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 23bbd439e115..8f86c05ddbfd 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -65,7 +65,8 @@ struct mptcp_out_options {
 	u8 join_id;
 	u8 backup;
 	u8 reset_reason:4;
-	u8 reset_transient:1;
+	u8 reset_transient:1,
+	   csum_reqd:1;
 	u32 nonce;
 	u64 thmac;
 	u32 token;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 87bd1bfde964..c57b2a03b756 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -381,6 +381,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 	subflow->snd_isn = TCP_SKB_CB(skb)->end_seq;
 	if (subflow->request_mptcp) {
 		opts->suboptions = OPTION_MPTCP_MPC_SYN;
+		opts->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk));
 		*size = TCPOLEN_MPTCP_MPC_SYN;
 		return true;
 	} else if (subflow->request_join) {
@@ -466,6 +467,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->suboptions = OPTION_MPTCP_MPC_ACK;
 		opts->sndr_key = subflow->local_key;
 		opts->rcvr_key = subflow->remote_key;
+		opts->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk));
 
 		/* Section 3.1.
 		 * The MP_CAPABLE option is carried on the SYN, SYN/ACK, and ACK
@@ -789,6 +791,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 	if (subflow_req->mp_capable) {
 		opts->suboptions = OPTION_MPTCP_MPC_SYNACK;
 		opts->sndr_key = subflow_req->local_key;
+		opts->csum_reqd = subflow_req->csum_reqd;
 		*size = TCPOLEN_MPTCP_MPC_SYNACK;
 		pr_debug("subflow_req=%p, local_key=%llu",
 			 subflow_req, subflow_req->local_key);
@@ -1120,7 +1123,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 {
 	if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
 	     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
-		u8 len;
+		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
 
 		if (OPTION_MPTCP_MPC_SYN & opts->suboptions)
 			len = TCPOLEN_MPTCP_MPC_SYN;
@@ -1131,9 +1134,12 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		else
 			len = TCPOLEN_MPTCP_MPC_ACK;
 
+		if (opts->csum_reqd)
+			flag |= MPTCP_CAP_CHECKSUM_REQD;
+
 		*ptr++ = mptcp_option(MPTCPOPT_MP_CAPABLE, len,
 				      MPTCP_SUPPORTED_VERSION,
-				      MPTCP_CAP_HMAC_SHA256);
+				      flag);
 
 		if (!((OPTION_MPTCP_MPC_SYNACK | OPTION_MPTCP_MPC_ACK) &
 		    opts->suboptions))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b13b95cedb5e..e5cbf5153d8f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -343,7 +343,8 @@ struct mptcp_subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u16	mp_capable : 1,
 		mp_join : 1,
-		backup : 1;
+		backup : 1,
+		csum_reqd : 1;
 	u8	local_id;
 	u8	remote_id;
 	u64	local_key;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d79a99c2bfc4..010e2fec5189 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -108,6 +108,7 @@ static void subflow_init_req(struct request_sock *req, const struct sock *sk_lis
 
 	subflow_req->mp_capable = 0;
 	subflow_req->mp_join = 0;
+	subflow_req->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk_listener));
 	subflow_req->msk = NULL;
 	mptcp_token_init_request(req);
 }
-- 
2.30.2

