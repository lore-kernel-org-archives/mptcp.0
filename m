Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E91BA50
	for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 09:45:05 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id gu23so21739865ejb.10
        for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 01:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDtmQkx0EPenR7HCvKKtLgp6rEirI9Z8ixDkUQBw9gQ=;
        b=tlcUTp0hBxBqGWivTn/HEgFVUDqvvTJSLIjB5336UtIWGmGlL79gnmwqHmmpsxdDog
         Re4kWEaBs5pjkTpwrjjlxKTxpc0qSbiljqaVkenv1R5cD6eh5gFC8jBJSvLOtyVRuHp9
         rXivfoG/WDgFBxqgKMGXidqofonLGUmfylXToWsKmnVi+kWY5yIeRAOKeKiU5iRoJTPR
         UwHfiyusyF+pJebiDYB2B1uN1B4VqLIkl9g6E3RPULBy5Sst3YBQBCtlGkUvXQzs894G
         iz0rF17xClVdgObwFoNQ2i7wuYjZpD4zMQlIICMsZZIj0KPudYtwPYnfQNoPz/8H+8R9
         BBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDtmQkx0EPenR7HCvKKtLgp6rEirI9Z8ixDkUQBw9gQ=;
        b=zhCcnDA1Ef9iFzJUeHwPIFF93Ztzf+JYMq1B01UPBwKNXP02cUQPwPbykrbJusUhQT
         rCpiCzW6ei0OAS0huif1dLqrXRst7L4FiVef5Lbt0/+Dy2Wlj0lJbJVuUD7ctIE7MZTT
         qOdyNowU39hdOVyFoOCnVnxCnw7EckG21ZUUsdVQVI98ieCAK2CdzBm6Wby5jBmdWCE7
         VFbPJKgANIdKqL5rUxsTIgw6leVauuXBNkpmT03y6DySdr5VuXBuFMYRofWagWTr4alY
         sP6esIadbKbPNhrLNPo1cLPx3y4VuX3fqJucNkYHR0LdBE4y6UjPWKkRq72LHEhfgp6I
         N7YA==
X-Gm-Message-State: ANoB5pkIqgNHeAUKPvkDrmn6RvuMwRAjkkFmNPFpZsjxdvpQ92qUPYOW
	lJO4izYNNZyi8fny+VdQGXLyByyvTQwvgpIsL0Q=
X-Google-Smtp-Source: AA0mqf5bcOdGMj4iqVg97yczQUWoMKpYgl2wkuaVwiyVuRPu1p5COpVKqTCI9SXXwS4njvPj8JbJDw==
X-Received: by 2002:a17:907:9852:b0:7a8:a957:5b4e with SMTP id jj18-20020a170907985200b007a8a9575b4emr11121469ejc.305.1669801503842;
        Wed, 30 Nov 2022 01:45:03 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090653da00b007417041fb2bsm440374ejo.116.2022.11.30.01.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 01:45:03 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v2 3/3] mptcp: use proper req destructor for IPv6
Date: Wed, 30 Nov 2022 10:44:48 +0100
Message-Id: <20221130094448.4119946-4-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221130094448.4119946-1-matthieu.baerts@tessares.net>
References: <20221130094448.4119946-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2883; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=nmePdAzT+1vjHcV8VvYMPUr5K9xnzFEYyhw2i69GLiQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjhyYQyekmrcWdr/Ddj0RCAT53neewqOqC7HUFyNh/
 yO63GUCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY4cmEAAKCRD2t4JPQmmgc1iSEA
 Dk+0QBEn0pgbNP4rgG/lDPRScs0MAWPBpkDx5dRzr55jXIfzrT6KqXj2ZKvSjnbUtV1YWeHM6kbzap
 NnYztDehO0PMKRtmuRImPscV3hht4GmyE2J90iPVxFbwYevpPFOWWj6+EuMwJwws6i58mG6sjDvd5L
 /3r+PuJzOBEEq5CjgL4u8AVZgSS5Lorwv6KjkN4ADo9KTza0NtWSaO7j7YEjN0Lsn6vCjLJZLV42gC
 Ly9AcfF/2cuuSaCoTJ/Fh+NXRDJkZDtVQg77PkDEkvL4zdT+JGPCoXjh5UrxWWoegXMGOUZhpbsgCb
 DE7Li7kQIKLLNkqoBLGkfgKNLcgRutDXDNfzMrvR8m2aUKCxbt00+GSwysF+Fwg3nNforOzCipg/Ca
 vy/NTIzB1J3KjS3ZEuZOTbx7qEwoFb6yNUrkyKsfi26Q9zc2QbdCbJjhSkKHYBMTq7o6xqx5S0y0lS
 xckF/Iwe+12viUG1oJGK12eyHXI3TjBjDfvZpEZ0zawTxFm/nz9iQHHha26U/5/v0mckLvm1dMkNzb
 0VVDFPNW+TZM2Dbk5WKGXwYST6EjNwLCG70F0FKouOvxeQX/YpmOOleC6WGAu9SDNDfgFeMEQONSVA
 oNWlgDgt6Aj/DdN50BJemx9c1mOcWm8Cjm0mS1NSpNeMtL1p2f9HzjgVU1JQ==
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
index 30524dd7d0ec..613f515fedf0 100644
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
 static struct request_sock_ops mptcp_subflow_v6_request_sock_ops __ro_after_init;
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

