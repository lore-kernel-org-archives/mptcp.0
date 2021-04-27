Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447471
	for <mptcp@lists.linux.dev>; Tue, 27 Apr 2021 10:08:06 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id e9so13620928plj.2
        for <mptcp@lists.linux.dev>; Tue, 27 Apr 2021 03:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QLiV/DBTh0PUhcN1YxEWiaynVlwqnocXzAoDlUOqigs=;
        b=WUwQpLAFfDHJCbnXm7FDQjh0o7UWo/UTgkq2ulb7XAcNzY6BSvm4mQQW+RvP84mcpT
         0gzPaYGBQiG7znWPlO9+kA+Of2PtDWYKHY576dQx3C0GuDy2Q58fl5J1g2qKh1bqCz/c
         C5ftwAbwQAV7Qkkvs1mKN9flAo7Mi4V0HCchXChwtqG7hBwbySkVe5bpLpad07gTTzYe
         OaDAaYXC6ZArLjjIUGK1Ng3Z7CoXnySpZ9QcK7rtqYQAl+og6cErLTgiwmnbXSmI9nYA
         I0dCLDMGWyxT9jomYDktKXmhR+/3Y6n5B1e4JEUfsGkdpRNlC/uz8NWmyeR7zPPSD5aq
         7krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLiV/DBTh0PUhcN1YxEWiaynVlwqnocXzAoDlUOqigs=;
        b=oB0AN/Pl+p6zI5Ngqh2SfcvMif3AB3ZbbNzCKjmoAQTECg+fq+6cUT8sZZQwpFJgQx
         rpWBTqtsFOUHHPDGoIzmA+Hb8GFmmAlDhboeYFiDs4V4PA8Zj+G7ZFnbkImGh5wcxhaO
         Ggd5gHbXjAJ4run61Y5IiQPnoq/fngO48TcK1aJH5wG5rsvPCgGF/sU2TCWZFWr+ApVP
         UlEtey1FzQ4H6xk469VXVsOu5F6YwQA2rfFtwvpoGqEgc3Ahr9NEPtTf88L7yhxsOQao
         Tuvn0PfN1WcpDDKZz0FJ5jx8EsepanOYF0aHc7Tv5Wy1r143EprDjFhCLK26Oz8W7uhz
         Sw8w==
X-Gm-Message-State: AOAM532AqvlD9bYsQAW+2p6Nd+dGTNX8vfbXhsiY0lFELGC0BmUbtqUp
	c5pm6V0PCmDwMzV4kCpRwgpqqtUmuvE=
X-Google-Smtp-Source: ABdhPJz8t8RsWN2JgMkqcaYkI6Dw1xIlPRqdJljoANhqffQqQypsN8jL1wik3KkdlUdACjp2yBJgtw==
X-Received: by 2002:a17:902:8d83:b029:e6:508a:7b8d with SMTP id v3-20020a1709028d83b02900e6508a7b8dmr24282357plo.18.1619518086451;
        Tue, 27 Apr 2021 03:08:06 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id j27sm14386876pgb.54.2021.04.27.03.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:08:06 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 2/5] mptcp: add join_denied in mptcp_out_options
Date: Tue, 27 Apr 2021 18:07:54 +0800
Message-Id: <073e1b2e4f7d03b0302e8eacb235a728774b3104.1619517696.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <b1aefbc214bea1e5cef3dcf3c1c0b5caf502734e.1619517696.git.geliangtang@gmail.com>
References: <cover.1619517696.git.geliangtang@gmail.com> <b1aefbc214bea1e5cef3dcf3c1c0b5caf502734e.1619517696.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch defined a new flag MPTCP_CAP_JOIN_DENIED for the third bit,
labeled "C" of the MP_CAPABLE option.

Add a new flag join_denied in struct mptcp_out_options. If this flag is
set, send out the MP_CAPABLE option with the flag MPTCP_CAP_JOIN_DENIED.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h  |  3 ++-
 net/mptcp/options.c  | 10 ++++++++--
 net/mptcp/protocol.h |  6 ++++--
 net/mptcp/subflow.c  |  1 +
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 83f23774b908..0d83491ab0a2 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -64,7 +64,8 @@ struct mptcp_out_options {
 	u8 join_id;
 	u8 backup;
 	u8 reset_reason:4;
-	u8 reset_transient:1;
+	u8 reset_transient:1,
+	   join_denied:1;
 	u32 nonce;
 	u64 thmac;
 	u32 token;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 99fc21406168..df90f8b46055 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -381,6 +381,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 	subflow->snd_isn = TCP_SKB_CB(skb)->end_seq;
 	if (subflow->request_mptcp) {
 		opts->suboptions = OPTION_MPTCP_MPC_SYN;
+		opts->join_denied = mptcp_is_join_denied(sock_net(sk));
 		*size = TCPOLEN_MPTCP_MPC_SYN;
 		return true;
 	} else if (subflow->request_join) {
@@ -466,6 +467,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->suboptions = OPTION_MPTCP_MPC_ACK;
 		opts->sndr_key = subflow->local_key;
 		opts->rcvr_key = subflow->remote_key;
+		opts->join_denied = mptcp_is_join_denied(sock_net(sk));
 
 		/* Section 3.1.
 		 * The MP_CAPABLE option is carried on the SYN, SYN/ACK, and ACK
@@ -790,6 +792,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 	if (subflow_req->mp_capable) {
 		opts->suboptions = OPTION_MPTCP_MPC_SYNACK;
 		opts->sndr_key = subflow_req->local_key;
+		opts->join_denied = subflow_req->join_denied;
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
 
+		if (opts->join_denied)
+			flag |= MPTCP_CAP_JOIN_DENIED;
+
 		*ptr++ = mptcp_option(MPTCPOPT_MP_CAPABLE, len,
 				      MPTCP_SUPPORTED_VERSION,
-				      MPTCP_CAP_HMAC_SHA256);
+				      flag);
 
 		if (!((OPTION_MPTCP_MPC_SYNACK | OPTION_MPTCP_MPC_ACK) &
 		    opts->suboptions))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a14c1ba85212..ce8bebf13637 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -77,8 +77,9 @@
 #define MPTCP_VERSION_MASK	(0x0F)
 #define MPTCP_CAP_CHECKSUM_REQD	BIT(7)
 #define MPTCP_CAP_EXTENSIBILITY	BIT(6)
+#define MPTCP_CAP_JOIN_DENIED	BIT(5)
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
+		join_denied : 1;
 	u8	local_id;
 	u8	remote_id;
 	u64	local_key;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 15620bafc544..64cacbb75454 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -108,6 +108,7 @@ static void subflow_init_req(struct request_sock *req, const struct sock *sk_lis
 
 	subflow_req->mp_capable = 0;
 	subflow_req->mp_join = 0;
+	subflow_req->join_denied = mptcp_is_join_denied(sock_net(sk_listener));
 	subflow_req->msk = NULL;
 	mptcp_token_init_request(req);
 }
-- 
2.30.2

