Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1CDBA48
	for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 21:08:34 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id b2so20530635eja.7
        for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 13:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDkQm/Igbqn4yMwljYrb+bCgf8pesfJApfImuUram6c=;
        b=t6bmNlLiQshsVtG9APUJUJAbsl4ch3jnGjEdXaYoddScBbjv6OMtOJZiU/skeopRi2
         Fy1C9qDBd5MgMLVHVmfeUDAxgA66/3pYErko+gZXUpCjMStl26c5c/zmbHi2vSoXODKI
         fJma8gnAur6y3bK8a+tA+ko28KcobEfWEBIXPwPL7fA65QOLsB5kYgyfimm5vwoIKLRY
         WoFLmbd+8fIv6LrkfmdHVcTCGlyiaMHDdkqBCqfUnOIQfFEw52eFOa2+IGbdTaAcvlyq
         +ks117Luh5DaK+BGh0KeyCbNIvdMXqEJ1fbbKyVZitiy2HZ1xwKjps0avxt+MVzuMoIS
         jYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDkQm/Igbqn4yMwljYrb+bCgf8pesfJApfImuUram6c=;
        b=TSaITxaglMhqGX2Pt2K0l1zwnGLdOdAO2B0gP7aUpe6VViQ/dR4vjAFEuMRlsJjU5e
         7kbEuzXqJduh6XUpY1DSI99bESVImMUmPDQstPzpRkTvMIzt6gp/ewLJdIQ0Lg84dyY4
         0qGTZAs2coOMnZOp7rYK8KHVoe1xIOdMczF02Epk8I1myBroknLQxbjbU1jKHxM6OWsI
         cD6GCGPBYqw33QwGGzk/JiOFOEHd8Y6vnoOVYk2oFXfygkEAwpvZUonnX5AFzMjJLp0a
         whED3AbnR+5yYATCHUHXIb3LxCjEh0xnip3XeBasHEQ9NVEps8uMy5tlkLJACtcCjbYM
         xySA==
X-Gm-Message-State: ANoB5plcTYH153GgUoDSZfH1eQi9xwIojycWihiFNAuBCNP3hqvh/sRe
	60An9KYCIJrKAfIZ4coK6/ma5XNs67Ab17e6THA=
X-Google-Smtp-Source: AA0mqf7CL6Uav0lCb4QGKVTTrPdK/+ltIMLZB2DGwwjqV0+pAoB3+bKQHkqKsH6i0lLgAi9ZqAYCRw==
X-Received: by 2002:a17:906:a293:b0:7bf:c6d3:b803 with SMTP id i19-20020a170906a29300b007bfc6d3b803mr10588348ejz.116.1669756112168;
        Tue, 29 Nov 2022 13:08:32 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090694ce00b007aed2057eacsm6516487ejy.221.2022.11.29.13.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 13:08:31 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net 1/3] mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
Date: Tue, 29 Nov 2022 22:08:02 +0100
Message-Id: <20221129210804.3769157-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129210804.3769157-1-matthieu.baerts@tessares.net>
References: <20221129210804.3769157-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3232; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=G5Jigfxrz+PZHTLlMDvp3PvM4NMKe3ZPisN3SNA98z8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjhnSzolzY65p7BkoG95o4BVTF9qbVkCsIt1B3uMGR
 NsFtN3yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY4Z0swAKCRD2t4JPQmmgc+tXD/
 4k5RDWr4Dht66b0HXlYBFq6rCDsLtIyBYy4Ena67VbRYFNlUL4q+0sgqTFrGb8+cSIOIp7H7+IMpYU
 vhddhzRuRwyu9TTPehNq6i059wKhFcSu4jv5cgjNZ5QePs6hu8+/GfaWX+JIIPtJyTF2I3d37HcK5a
 xL2FB0dwYnaXyG2mPI2hiB6edgu7dyNwP5qgz720qrYZisbd1edG+JMCZxYDODqvKSHvifM4knX9tU
 3B9LVuFLE7FK/fQDfM7b8wvgcygP3+16qpAfwjj35ICVhJFsVMk9Icfr4MPlx8yrmlQ9dvO19/CCF3
 ChfIY3j5JQ4IFVPdfYFOFNvQ1CTr+6HQt5XpbHWJv85nh62HqRObVwse1tt7rJysQ0+TYPwzIFOXDl
 fVrCnuoIglRFuGjAfOUAoOWBgK+dr22kW9emphM9KMAgHQ9m/kKI0gOUlxALtvDMiCfesrTLcLW+5n
 mR0GVRBAbBIzSGn4DGuygtgw/erTeMGyMEx5ZA4QvsJ1PjwmREdVRDS+HGcxq1HU9DRN5Q41tKVPXH
 jzjyyy3nDSaQYumqk0taBGnh9435Zc/1iR+hLu1vdpqB+QgrNQIPwZ7j3dTG/F5oVMrefADHtHvKzi
 xe7p9rOFN76CfoYjET0OA6pGBvWYIBF/JJ85T4imjIcNFZ4Xglz2bCnqPgnA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

To ease the maintenance, it is often recommended to avoid having #ifdef
preprocessor conditions.

Here the section related to CONFIG_MPTCP was quite short but the next
commit needs to add more code around. It is then cleaner to move
specific MPTCP code to functions located in net/mptcp directory.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 include/net/mptcp.h   | 12 ++++++++++--
 net/ipv4/syncookies.c |  7 +++----
 net/mptcp/subflow.c   | 10 ++++++++++
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 412479ebf5ad..3c5c68618fcc 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -97,8 +97,6 @@ struct mptcp_out_options {
 };
 
 #ifdef CONFIG_MPTCP
-extern struct request_sock_ops mptcp_subflow_request_sock_ops;
-
 void mptcp_init(void);
 
 static inline bool sk_is_mptcp(const struct sock *sk)
@@ -188,6 +186,9 @@ void mptcp_seq_show(struct seq_file *seq);
 int mptcp_subflow_init_cookie_req(struct request_sock *req,
 				  const struct sock *sk_listener,
 				  struct sk_buff *skb);
+struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
+					       struct sock *sk_listener,
+					       bool attach_listener);
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb);
 
@@ -274,6 +275,13 @@ static inline int mptcp_subflow_init_cookie_req(struct request_sock *req,
 	return 0; /* TCP fallback */
 }
 
+static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
+							     struct sock *sk_listener,
+							     bool attach_listener)
+{
+	return NULL;
+}
+
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 #endif /* CONFIG_MPTCP */
 
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 942d2dfa1115..26fb97d1d4d9 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -288,12 +288,11 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 	struct tcp_request_sock *treq;
 	struct request_sock *req;
 
-#ifdef CONFIG_MPTCP
 	if (sk_is_mptcp(sk))
-		ops = &mptcp_subflow_request_sock_ops;
-#endif
+		req = mptcp_subflow_reqsk_alloc(ops, sk, false);
+	else
+		req = inet_reqsk_alloc(ops, sk, false);
 
-	req = inet_reqsk_alloc(ops, sk, false);
 	if (!req)
 		return NULL;
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2159b5f9988f..97a354aea25f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -582,6 +582,16 @@ static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 }
 #endif
 
+struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
+					       struct sock *sk_listener,
+					       bool attach_listener)
+{
+	ops = &mptcp_subflow_request_sock_ops;
+
+	return inet_reqsk_alloc(ops, sk_listener, attach_listener);
+}
+EXPORT_SYMBOL(mptcp_subflow_reqsk_alloc);
+
 /* validate hmac received in third ACK */
 static bool subflow_hmac_valid(const struct request_sock *req,
 			       const struct mptcp_options_received *mp_opt)
-- 
2.37.2

