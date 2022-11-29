Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB0FBA28
	for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 21:08:36 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id e27so36803141ejc.12
        for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 13:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNL4Tl95wNHbkIQj46VKxVWtH+eLGg64lZJ5BLjgduA=;
        b=a894OARWSyhJVUYsJItQG2vT+kJgyjYifafKCaZdeI0o9DBYr5121nMiwK5vXF/zku
         3T8KPeNQjCO8XixDBvMQsC+GDIHOZ3qNWFN3hiMXteBTUPgjVakZEYKjkqWwFBR7beDr
         gm8CG5ennpYYOU+bxCeSBTkSbfz3GNw8WIDPpyamShpPIBqWNrpHRR6dd7X5OACFsWek
         2O06SzztpSsyI1fBqU2+PSraCFMJ9NMXyGMMM1ZJs7Dx/bDOv2zJpJTAweMPKXbZtdXj
         fRPneE63d29vtS58umlkYWHRFyyF0nb58avW8z+ijKOVO09eD4cXTUCf38/09BQ7TfVJ
         5CDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNL4Tl95wNHbkIQj46VKxVWtH+eLGg64lZJ5BLjgduA=;
        b=qr++sN74ImFe0CJj3z36jTqoCQnC/xKROR1Xis1L4PjfP/vdnxvJEpmNql4kzxp8ju
         VsfnJVkgpGEb3W4ZX4tl3Xjk8w5GLt+s3pZ3wbVTdtUWMCwED+7BxEvAkQ9lcc3tzrdo
         eWlSVRq/9TNTZRN+p/iMR8boPtdgTSTlWtrv/XaDJg+RWvMBfQoZPBMcZCuSmjw4I/V/
         4Uo5uhIBgJPZHEKlOyoR2fu/J3Xygj7mQVwiGzfagucTR/xGPH81oBQZ51Lk8LnEIb+L
         k5mATGI9kJjZEn6vnQ0nFj5kI4dWH2sneahc5dwSyLfJe0L41WnHJfxmstEPGaRJKAKw
         hDww==
X-Gm-Message-State: ANoB5plcGKZC2RkvaTKMrGsG9O7w9ioo0iVqrCYgq17hGRBD1A7hd7ok
	J9jG2YYAJswml2uD9ruwoYTOKkDfe52F1BzBV0M=
X-Google-Smtp-Source: AA0mqf6t/2mwXO/EkWd9jlI+i1PPUJE+ZFJiGzlLylEa/CCalskJn/eCeMRL2AemvjQvDJ26ADB1AQ==
X-Received: by 2002:a17:906:54cf:b0:7ae:43f5:a2a3 with SMTP id c15-20020a17090654cf00b007ae43f5a2a3mr47926014ejp.595.1669756114426;
        Tue, 29 Nov 2022 13:08:34 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090694ce00b007aed2057eacsm6516487ejy.221.2022.11.29.13.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 13:08:33 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net 3/3] mptcp: use proper req destructor for IPv6
Date: Tue, 29 Nov 2022 22:08:04 +0100
Message-Id: <20221129210804.3769157-4-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129210804.3769157-1-matthieu.baerts@tessares.net>
References: <20221129210804.3769157-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2860; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=FXCKpA8i/LwrN7laCoId//D1HNem9y4whs0qcG8fT44=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjhnS0xf0IXnYUrVTfNmS7Pl8eX5k0Y2F2TQ0XTaFa
 qmI9kQOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY4Z0tAAKCRD2t4JPQmmgc2w6EA
 CCKe2FL7S7v1gTPqiSfgZ+1R1JpdaT0veEUKYNbpjf/8ZPpatZR4JXDO61d/SCHXM6VYnqur6K55us
 l1not/9T2IhNa0ol6yd06uKQNogbb3glT5rXv0S/PlO0U5nQgXP+K5pR1ko/q0+lqfR/JhdKqk0IB7
 UylITcunZfqeCxksYCf8BlapbJaYpEFeS4scd8vTPTcpgb9Ddr/JVPR31ws6waZo56ddYVoo6JRllW
 AL82arnkwv7p91KzuxDtljJ+obIhRKQ9Tv0WmoQyk80WHPf92D0VJu3PdzuZM63FnHn1iTKFh3H3PT
 SOfbl/9OWOHoGjWVAD776d9sP7+ql0adGERIE1fshfPIIS4Q7QLmDmg7YwpudjEwp4b97a/NecxZFH
 JVg5mrumOn3R95bz9UUgtKlXDrEWhNbzCjLHzX4TqUP9CSQZfR2A2tNpqjRRc/pSAf/f9U8kTF7p3N
 A/ez7y6TmXjvD8tJKd/JoVbp/hQYGd/JBhKhPyTp6L1mDLw3ciU0wqt8X49Ovugl+leb7ofDSKZYca
 2zACg558OlmdKpQllahlT6rEu5Dk7P8DWd1qeCHLODfjytlUHwqE+9cayggrfY1FhoQk8aAO1N22Mr
 NRtf7hg7Fuy7CLZzHibr740pZTSGgfSWOvVzLZ2RKHnQmnUESRR+o0KsyS3A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Before, only the destructor from TCP request sock in IPv4 was called
even if the subflow was in v4.

It is important to use the right destructor to avoid memory leaks with
some advanced IPv6 features, e.g. when the request socks contain
specific IPv6 options.

Fixes: 79c0949e9a09 ("mptcp: Add key generation and token tree")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/subflow.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 16498dd9e0a1..2e1d70e2272b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -45,7 +45,6 @@ static void subflow_req_destructor(struct request_sock *req)
 		sock_put((struct sock *)subflow_req->msk);
 
 	mptcp_token_destroy_request(req);
-	tcp_request_sock_ops.destructor(req);
 }
 
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
@@ -550,6 +549,12 @@ static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
+static void subflow_v4_req_destructor(struct request_sock *req)
+{
+	subflow_req_destructor(req);
+	tcp_request_sock_ops.destructor(req);
+}
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 struct request_sock_ops mptcp_subflow_v6_request_sock_ops;
 static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops __ro_after_init;
@@ -581,6 +586,12 @@ static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 	tcp_listendrop(sk);
 	return 0; /* don't send reset */
 }
+
+static void subflow_v6_req_destructor(struct request_sock *req)
+{
+	subflow_req_destructor(req);
+	tcp6_request_sock_ops.destructor(req);
+}
 #endif
 
 struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
@@ -1929,8 +1940,6 @@ static int subflow_ops_init(struct request_sock_ops *subflow_ops)
 	if (!subflow_ops->slab)
 		return -ENOMEM;
 
-	subflow_ops->destructor = subflow_req_destructor;
-
 	return 0;
 }
 
@@ -1938,6 +1947,8 @@ void __init mptcp_subflow_init(void)
 {
 	mptcp_subflow_v4_request_sock_ops = tcp_request_sock_ops;
 	mptcp_subflow_v4_request_sock_ops.slab_name = "request_sock_subflow_v4";
+	mptcp_subflow_v4_request_sock_ops.destructor = subflow_v4_req_destructor;
+
 	if (subflow_ops_init(&mptcp_subflow_v4_request_sock_ops) != 0)
 		panic("MPTCP: failed to init subflow v4 request sock ops\n");
 
@@ -1963,6 +1974,8 @@ void __init mptcp_subflow_init(void)
 
 	mptcp_subflow_v6_request_sock_ops = tcp6_request_sock_ops;
 	mptcp_subflow_v6_request_sock_ops.slab_name = "request_sock_subflow_v6";
+	mptcp_subflow_v6_request_sock_ops.destructor = subflow_v6_req_destructor;
+
 	if (subflow_ops_init(&mptcp_subflow_v6_request_sock_ops) != 0)
 		panic("MPTCP: failed to init subflow v6 request sock ops\n");
 
-- 
2.37.2

