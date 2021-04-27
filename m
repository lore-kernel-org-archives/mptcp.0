Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3671
	for <mptcp@lists.linux.dev>; Tue, 27 Apr 2021 10:08:09 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id p17so2716855pjz.3
        for <mptcp@lists.linux.dev>; Tue, 27 Apr 2021 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JouimiQ1PdMhMmTYsaWbWODVB6zakpCSOAadTBamrkw=;
        b=JFgfdlUlTs2uJmtfkwX+Ggav4vThe1fMSidBHCuFzrVbu7wKFDycPQgtyujWIc57Nr
         WFWN/EWSoS151ofyxuaHySsZETUdwHxDjk0EHvYnxAH4Pq0hnVYel6kM+sH5/+gRbN1m
         P1iBhJlVGyIUDU5QB9nFhgD7o4pXpHPVAypYQvL88Z1+Ai5cMK+EE03mV0Qc11PIzL7T
         UwklsAxkhr0+DjX3pWUuVz657DfWwWsUzZ/+r1ROmEdR5IUL6JXS8heExjV3wslhRK9p
         5EHfMAzvFzez9dTf3oNQpjaSIcfpRhPmCZ/VzGfBJNTiI/NzUUeht6nDFeaD0QQNRsil
         7VTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JouimiQ1PdMhMmTYsaWbWODVB6zakpCSOAadTBamrkw=;
        b=ZmnG/UGqszy76b+hTRAAbrkzkj99zkuDP6H0NBLgJzBi4vOPBrUTVYLKu9gf7Xj4ye
         +KLhvSVTw7Mo3K6LX5i4xIDhPPauwD3VQUfZ0DyqpbMg8U7oUanN8x1sEX0iSkIUX1AN
         Zpuuj5pl/avnoZGO4oUQ5Lod5QVdUAoBdSsls5V8GHfKFQCsIWy4Ggs4A4QZsTRKBV4n
         XJqH0xgQDD1QScX9SyqpyTPOWBJrIwGpk2GAzGlM1bVy1VWm7P3HchUWolfqenEnWIHk
         uQPNwQvSEjXaVlaGP2Wwsz8oKhcmzv/Qm4B3d9U+uebWh/B0Vc9gtP4SnMHI3QfYQrgU
         mXuw==
X-Gm-Message-State: AOAM532ATnYwulFcfiJ1ugSEtYc4Wr0rkMCWoxJMK3KEbjiGp62loSJ8
	oT5JaBgDL/qOiKP7Y80NNxaqHhh73Uo=
X-Google-Smtp-Source: ABdhPJxRBUspm9jI2hvy7wuLy5ZJt/GSldlr1iiz4Efvmn/Mz9fM+/VVckC+JpyGkfl33MT3rBdGlA==
X-Received: by 2002:a17:902:6544:b029:ea:f94e:9d4e with SMTP id d4-20020a1709026544b02900eaf94e9d4emr23667443pln.16.1619518089181;
        Tue, 27 Apr 2021 03:08:09 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id w14sm141690pff.94.2021.04.27.03.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:08:08 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 3/5] mptcp: add sk parameter for mptcp_parse_option
Date: Tue, 27 Apr 2021 18:07:55 +0800
Message-Id: <945e6d874461b595c1a08916d87cb4fed219ac40.1619517696.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <073e1b2e4f7d03b0302e8eacb235a728774b3104.1619517696.git.geliangtang@gmail.com>
References: <cover.1619517696.git.geliangtang@gmail.com> <b1aefbc214bea1e5cef3dcf3c1c0b5caf502734e.1619517696.git.geliangtang@gmail.com> <073e1b2e4f7d03b0302e8eacb235a728774b3104.1619517696.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new parameter name sk in mptcp_parse_option() and
mptcp_get_options().

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 10 ++++++----
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 10 +++++-----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index df90f8b46055..7b354125f33b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -20,7 +20,8 @@ static bool mptcp_cap_flag_sha256(u8 flags)
 	return (flags & MPTCP_CAP_FLAG_MASK) == MPTCP_CAP_HMAC_SHA256;
 }
 
-static void mptcp_parse_option(const struct sk_buff *skb,
+static void mptcp_parse_option(const struct sock *sk,
+			       const struct sk_buff *skb,
 			       const unsigned char *ptr, int opsize,
 			       struct mptcp_options_received *mp_opt)
 {
@@ -324,7 +325,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 	}
 }
 
-void mptcp_get_options(const struct sk_buff *skb,
+void mptcp_get_options(const struct sock *sk,
+		       const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
@@ -363,7 +365,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 			if (opsize > length)
 				return;	/* don't parse partial options */
 			if (opcode == TCPOPT_MPTCP)
-				mptcp_parse_option(skb, ptr, opsize, mp_opt);
+				mptcp_parse_option(sk, skb, ptr, opsize, mp_opt);
 			ptr += opsize - 2;
 			length -= opsize;
 		}
@@ -1011,7 +1013,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return;
 	}
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk, skb, &mp_opt);
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ce8bebf13637..1d828668b15a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -578,7 +578,8 @@ int __init mptcp_proto_v6_init(void);
 struct sock *mptcp_sk_clone(const struct sock *sk,
 			    const struct mptcp_options_received *mp_opt,
 			    struct request_sock *req);
-void mptcp_get_options(const struct sk_buff *skb,
+void mptcp_get_options(const struct sock *sk,
+		       const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt);
 
 void mptcp_finish_connect(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 64cacbb75454..c4fbbefb2c93 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -151,7 +151,7 @@ static int subflow_check_req(struct request_sock *req,
 		return -EINVAL;
 #endif
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk_listener, skb, &mp_opt);
 
 	if (mp_opt.mp_capable) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
@@ -248,7 +248,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 	int err;
 
 	subflow_init_req(req, sk_listener);
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk_listener, skb, &mp_opt);
 
 	if (mp_opt.mp_capable && mp_opt.mp_join)
 		return -EINVAL;
@@ -395,7 +395,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
 	pr_debug("subflow=%p synack seq=%x", subflow, subflow->ssn_offset);
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk, skb, &mp_opt);
 	if (subflow->request_mptcp) {
 		if (!mp_opt.mp_capable) {
 			MPTCP_INC_STATS(sock_net(sk),
@@ -640,7 +640,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			goto create_msk;
 		}
 
-		mptcp_get_options(skb, &mp_opt);
+		mptcp_get_options(sk, skb, &mp_opt);
 		if (!mp_opt.mp_capable) {
 			fallback = true;
 			goto create_child;
@@ -651,7 +651,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		if (!new_msk)
 			fallback = true;
 	} else if (subflow_req->mp_join) {
-		mptcp_get_options(skb, &mp_opt);
+		mptcp_get_options(sk, skb, &mp_opt);
 		if (!mp_opt.mp_join || !subflow_hmac_valid(req, &mp_opt) ||
 		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
-- 
2.30.2

