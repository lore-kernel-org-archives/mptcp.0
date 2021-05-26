Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855422FB4
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:08:39 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id z12so3359110ejw.0
        for <mptcp@lists.linux.dev>; Wed, 26 May 2021 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k273NB9wIyfKYG+Tl83ECdrDlxzxxBmfRV9onhRlQp0=;
        b=V9rkKZTOjHjf3NWaTo90znu4sw+OKVSserO7ezizGKFRNwEH8vx/waG9/u2JtAkfnC
         9BNbmHUadlwXwFqiliD1T1nMU2jOoF5NIxRrcSp3HRwEnc4HgOrRkUhhDoA16oV39O5T
         0crghWmKdQsWWma4o/wLosLY0wiWVM/iuxSmglDm3TccfNzUV1n1EzedHIlgttmWog3Y
         q+yORi2M/cBm26aw0LCkZm1ahfB0yymuF6vdsLShw8gD2ET+yOrtbFy85xVD06AUb6VG
         TnVDu5KP/uD5beqUqQ4Eti/n747eLbRBp/oVGM2Od4YukU3BG5q8SCvOa+8Hq0csHKej
         +P3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k273NB9wIyfKYG+Tl83ECdrDlxzxxBmfRV9onhRlQp0=;
        b=I25cbRJBR0+h2Wm17nKnn7+TJD36k2VWdYOcRFVUgrRBEykRSe26ACxYT/ASIa64JG
         uEJpv7cQAW2dk19TnOzPwvhBNGfatV7FxcDV2APuxIG3zMA+ajOgKYYbFJLeOn5adWIc
         xpsJ4K2W3pUEqnZK17kxIKbJGkYz4DDHpXfzL8wz/Jf/Qjg5px+l0Ld/8BzDcpxiaFY/
         TU0myQRC/jAgAySzubhBbAMKfyvhglGUOTL7+mNouqIVFoGL37IoSftc0UbJz3Em4Xgv
         24Y5yNv1Mv+lsF+6WmZeTF0rkItoQpOSGvLXbANVk+NzX5ZDfCqTmTzPw+L3Zb81Y5gS
         ghQA==
X-Gm-Message-State: AOAM530vv8nWc7oh7UmSkyOpG/rVTnJxZzwGH8b6uugdhww5Fy9vskJk
	G5seMXb89iYEyfGXjG0DkVXoxlFp3faiuTKF
X-Google-Smtp-Source: ABdhPJyogBRbNKWEKrHE9qoMCIdO1oZZG/4GLnEocBR6faoCjCQQ7Hxq7nPFTQPro7x73Ee9Y/sBIA==
X-Received: by 2002:a17:906:76c6:: with SMTP id q6mr22048328ejn.387.1622045317986;
        Wed, 26 May 2021 09:08:37 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id j7sm931655ejk.51.2021.05.26.09.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:08:37 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [RESEND] [MPTCP] [PATCH MPTCP 1/5] tcp: make two mptcp helpers available to tcp stack
Date: Wed, 26 May 2021 18:08:09 +0200
Message-ID: <20201105170126.5627-2-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
References: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20210526160809.rTj9ASQ134zS4-WNEx5nzBlazpJOKqv2wxIt7V8L19w@z>

From: Florian Westphal <fw@strlen.de>

needed by followup patches to add mptcp reset (and fastclose)
options to tcp reset packets.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/mptcp.h  | 10 ++++++++++
 include/net/tcp.h    |  5 +++++
 net/mptcp/protocol.h | 11 -----------
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index b6cf07143a8a..3d57607982fa 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -78,6 +78,11 @@ static inline bool rsk_drop_req(const struct request_sock *req)
 	return tcp_rsk(req)->is_mptcp && tcp_rsk(req)->drop_req;
 }
 
+static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
+{
+	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
+}
+
 void mptcp_space(const struct sock *ssk, int *space, int *full_space);
 bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		       unsigned int *size, struct mptcp_out_options *opts);
@@ -169,6 +174,11 @@ static inline bool rsk_drop_req(const struct request_sock *req)
 	return false;
 }
 
+static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
+{
+	return NULL;
+}
+
 static inline void mptcp_parse_option(const struct sk_buff *skb,
 				      const unsigned char *ptr, int opsize,
 				      struct tcp_options_received *opt_rx)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index f3d42cb626fc..8115164e0df6 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2377,4 +2377,9 @@ static inline u64 tcp_transmit_time(const struct sock *sk)
 	return 0;
 }
 
+static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
+{
+	return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
+		     ((nib & 0xF) << 8) | field);
+}
 #endif	/* _TCP_H */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d29c6a4749eb..66bd4d096753 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -139,12 +139,6 @@ struct mptcp_options_received {
 	u16	port;
 };
 
-static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
-{
-	return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
-		     ((nib & 0xF) << 8) | field);
-}
-
 struct mptcp_addr_info {
 	sa_family_t		family;
 	__be16			port;
@@ -568,11 +562,6 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 
-static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
-{
-	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
-}
-
 void mptcp_diag_subflow_init(struct tcp_ulp_ops *ops);
 
 static inline bool __mptcp_check_fallback(const struct mptcp_sock *msk)
