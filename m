Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157862FB0
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 09:17:15 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id p39so6776391pfw.8
        for <mptcp@lists.linux.dev>; Tue, 25 May 2021 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PxiQ/zt4bv5qFhspO2jncT4eNc2X4LIM55ZlOeHgeMw=;
        b=MSURivzjX1kRIiAHybAbRf3+n5gKu6DQkez0iKiLhIwXYFqrtUyo1t5bN/VSblWosR
         2hu4TCwMI9YOufyDB9QmDqnelZaQLRe1Na1OondXb2vVT47u51Dkz9Ro1B4mn3TWzVLe
         g4rWsdKj+mjjApoqxEQr9EfrUg5RgH7myozF3fX1pz3f0W9lLC6YUAiGSOVfwpDj4xW3
         8BUCxw4siW+HNJD4xfzbt6aF6rdEjTdz/SB3QwagM+17Tt/0BbSYfdHmJo5tM1MNLnHn
         VndCtg7OXjsj88jOmFv5taB4JFWLtrZgGplMnDUTC6De1n37CRKf4631v9Er6sMGspY5
         vuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PxiQ/zt4bv5qFhspO2jncT4eNc2X4LIM55ZlOeHgeMw=;
        b=m0lkrqR9scZ9dN4oCS3jM/LB1ZNTCyvSSRpGUt9UnQ57aqkq7oqMv0GzQ0KsjQzxrH
         FYKcoHdrLuIdHKlRoGUIb9BTNNwtzCmb6j85yqPLSxtfLueStobjlLuEtCGdmZnWmciP
         jJMFSAaxYZzxeC5Nu3euv2Eut57BHDvMwkLz44cdWVAJQKhmlAK3xOocGXpnG7MpsGNv
         2bbByGdTGxQBpFDl40bf/W+pIIRqosbQRBjyuT8NCRvCzJTOL4HZMppEOAdpSGULMz6B
         EpwDdRUZnbwtBTqQeUSUBhvbXGyUgLUUYmXve8D78nOwnehlJ3tLIimxN3VqqSPbQyw0
         zkLw==
X-Gm-Message-State: AOAM533jDock5vXizedjHUJ3ezz5m2IAKIqlJgTM5twhRLWjZ7ll/dGY
	ZgnO/r59R5FOUtpto4jLlhl1jeK/TwOGZg==
X-Google-Smtp-Source: ABdhPJxJav+hyhmFz58V+GpmQhzAlhpFBvGaqPkk4jFWd4IpQEBBulCrjFqHMeSNlhaS45u3mQZmmg==
X-Received: by 2002:a63:aa48:: with SMTP id x8mr17853904pgo.359.1621934234609;
        Tue, 25 May 2021 02:17:14 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id mj6sm11910372pjb.8.2021.05.25.02.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 02:17:14 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v8 mptcp-next 2/4] mptcp: add allow_join_id0 in mptcp_out_options
Date: Tue, 25 May 2021 17:17:04 +0800
Message-Id: <57e35b700b797c875966ae26252ae07316853837.1621933974.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <b7f8df04d7b08026ee10cf2a784afda85e8cf6df.1621933974.git.geliangtang@gmail.com>
References: <cover.1621933974.git.geliangtang@gmail.com> <b7f8df04d7b08026ee10cf2a784afda85e8cf6df.1621933974.git.geliangtang@gmail.com>
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

