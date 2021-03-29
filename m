Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DFE71
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:41:16 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id h3so9580575pfr.12
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fjITPoBTLc6F+oRtIGltq6/kZQNrTFQ6E/fN60e54lM=;
        b=M5xuGo398Q3VPuHm27a5v8MiI6iWUFmVemUV3HRhnKbxqGN72WhZVeKaTeOr6O1BVg
         TqanRizua3muj20mILVlXQT1E5YJfMihlV6PGhUMWHoan/ksfOTqLfo7q+VcrorZDo/R
         42MKPSgbu+CwGPyTWH73m+oOaqgJjzmk3665a2eRlDflv3r9rOy8HR4m6Fsa2gSVK298
         etweE+ASEV95XsObA9nN/dnHp5e1YqhYxdsxvgB3WrH1EcMymbfreLenxQf9gXEMrOnS
         Wtjk9FnFRR820Nryi5ulkMaEJuTuCcEQNMUH+GHRqtmxsM7RM0rX7OGGOikbEmGOG8Z/
         5xKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fjITPoBTLc6F+oRtIGltq6/kZQNrTFQ6E/fN60e54lM=;
        b=cD9iiqpRfQ4EbZ9FnfnVhAxJa3VJehv2HgdDE0b7645CUdjq7GqOWe5P2fAZslD1Bq
         mUZJWg9PW+/PM9iOfXcGni0rqJQMrjEMiY+RPyFKXyykWMbXLucSZUmKAjA7HdA/7Ra2
         mOQ3XTt6SUoBtpkLmAmqEM/X+hquj4SoWWnSZChMQWdw21nfdiB3CVH5oFA8pIbeGWtU
         6Ek4UIIc6YFMYyNRHt3ohAjTjEZ0d37OuB/Ad/UzL6tFX1Zkg42vRfaXtPjew+HAIk6K
         AnICIcVWqCWHclfcIHg8MZA76RpGlb6oYtfDHYoMYRk2x/QScugoVc6hVdpf95I6e/gG
         K43g==
X-Gm-Message-State: AOAM532BhKdMSlOdSIkQq70I7ryOmntfO0mgNjPKhEA+Ql1zroUiqfBS
	EG5TDThFEe98gIWq4Cg/nNGrO/rxZggEHw==
X-Google-Smtp-Source: ABdhPJxMEiNlqzkeG37wdhREjR5bvnBSOkhMJx/psiEJ0HEKt9witBVgudKfJ8gfMwLK1uusI5yKXg==
X-Received: by 2002:a62:ce4e:0:b029:225:bcc4:4ee with SMTP id y75-20020a62ce4e0000b0290225bcc404eemr10340251pfg.13.1617014475617;
        Mon, 29 Mar 2021 03:41:15 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id bk8sm14686784pjb.13.2021.03.29.03.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:41:15 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 07/16] mptcp: add sk parameter for mptcp_parse_option
Date: Mon, 29 Mar 2021 18:40:38 +0800
Message-Id: <1c0a240472edcc1afbcb822bd9af3cf03800759e.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <d8a242cfe08b2ab0ccb4752a15c8ea8ef0226ac1.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com> <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com> <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com> <14b6923c9fd052b140d5af261dfd2575d94b3e05.1617014019.git.geliangtang@gmail.com> <08ab4ce9f13e954b45d24c9e7842f7a6a9798d54.1617014019.git.geliangtang@gmail.com> <d8a242cfe08b2ab0ccb4752a15c8ea8ef0226ac1.1617014019.git.geliangtang@gmail.com>
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
index 6acb7469bae9..cb423cba5c3b 100644
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
@@ -322,7 +323,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 	}
 }
 
-void mptcp_get_options(const struct sk_buff *skb,
+void mptcp_get_options(const struct sock *sk,
+		       const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
@@ -362,7 +364,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 			if (opsize > length)
 				return;	/* don't parse partial options */
 			if (opcode == TCPOPT_MPTCP)
-				mptcp_parse_option(skb, ptr, opsize, mp_opt);
+				mptcp_parse_option(sk, skb, ptr, opsize, mp_opt);
 			ptr += opsize - 2;
 			length -= opsize;
 		}
@@ -1016,7 +1018,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return;
 	}
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk, skb, &mp_opt);
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ae7d47352d09..cfdecfb90776 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -570,7 +570,8 @@ int __init mptcp_proto_v6_init(void);
 struct sock *mptcp_sk_clone(const struct sock *sk,
 			    const struct mptcp_options_received *mp_opt,
 			    struct request_sock *req);
-void mptcp_get_options(const struct sk_buff *skb,
+void mptcp_get_options(const struct sock *sk,
+		       const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt);
 
 void mptcp_finish_connect(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index cbdfa5a6f8f6..75664da251a6 100644
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
@@ -642,7 +642,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			goto create_msk;
 		}
 
-		mptcp_get_options(skb, &mp_opt);
+		mptcp_get_options(sk, skb, &mp_opt);
 		if (!mp_opt.mp_capable) {
 			fallback = true;
 			goto create_child;
@@ -653,7 +653,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
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

