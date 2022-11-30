Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83FBA53
	for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 09:45:04 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id td2so25838697ejc.5
        for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 01:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OPzP72YVvsKNRova7w6dCkXRYl3zdDddxtmB9UpT/M=;
        b=VJilSHZtNi46jyg+58pTWW3bUc7rrWPfF1fozBH3gP0JSIq0byojWY83w365xMP78f
         KX3aM5REl1KsTdtwpNTx5QTWdlq68mTzwxp+2ecMoemmqVIOWIodB3jRZYrlblEamysI
         jSKNu3VXcBvIm+JZCJaqsDwlGwRBLTNIGJOUmLdQWj5Uc0kJW/CrSapIaxXijEjt7V87
         Au0y/dJbjqxoqRDf0Hey9wdls7D7fEHeQN8nYKoR7S79YZ5wQQAZ0AEXHtdKjcVrPlrK
         wIZcxGjIjDOg3i2nyoLnBC1O1j4jt6Xg5X1IiwcM6a6tyHC5+RXZR7bLD0Pq96s03pvX
         4lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OPzP72YVvsKNRova7w6dCkXRYl3zdDddxtmB9UpT/M=;
        b=7VMr7GAMXpb7EOObmxSuWioRsKtiO2r5E2u6IkByu0ILz/AX0ma+knAhottcCl2yFT
         q25H7ru5W/q0JW8ObOVnFk3+TiyP1WB1sRMGmuPu1XgV9iLdy3oCm3n7e9oydi4geauU
         eV5A2dtsebuFozpuEeewliCGf+OJHdXzEJE3VYccghinuSIjXebTuAlRHx4HYVY44RJJ
         yC/FFmuYzhY48r3did2JatsBk3nBMW6/vIZ64+xAdCwXv3e/hnEWqm8ePZgfhwzHc/sR
         mWmFvw3Dsjx7YSL2spdq8z1tP5nGsZSaHCdd2PHKiahuwQwQdZkYu/iVvosV7lJvfTST
         NYdQ==
X-Gm-Message-State: ANoB5pmMhzVJk/fSCnhJv977KRvm/CEKPUlfJYsnLTdj2tGbpxkC7BFG
	3Z8H/UZ92Re0BBz59Ez6fCA6UysOXqo1fBuFj4w=
X-Google-Smtp-Source: AA0mqf7LGimQqqx38j4VKU8zFZ6z7sPRuIbjoxIR51bRfAQQbutATRFRart58SyW7xRoRFREtc+iSQ==
X-Received: by 2002:a17:906:4f0b:b0:78d:aaf9:7b8c with SMTP id t11-20020a1709064f0b00b0078daaf97b8cmr52326545eju.229.1669801502719;
        Wed, 30 Nov 2022 01:45:02 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090653da00b007417041fb2bsm440374ejo.116.2022.11.30.01.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 01:45:02 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v2 2/3] mptcp: dedicated request sock for subflow in v6
Date: Wed, 30 Nov 2022 10:44:47 +0100
Message-Id: <20221130094448.4119946-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221130094448.4119946-1-matthieu.baerts@tessares.net>
References: <20221130094448.4119946-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5338; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=nNvDKHN7jwhttWm6YkrluXFMyhdxMmvAI49u4wU70TU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjhyYQR9t8k39bRwqmo3rxD0G2Nj4AQvoxFwN30f9C
 1GByZSiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY4cmEAAKCRD2t4JPQmmgc2p+EA
 Cp+d4yioDJehkc3muoibloa3i7yess4FDZv1Rge2+uW0GHljO6Jvby9q3cPlawrBLVbj0PmuLb/PHM
 imMsaaMNYX2naXCTi65x4mBqj4V4uKp4JVO5IUjW5+vJ+cA2NpUtcXvmd/EimGdpIgSjoQBgRx2EMH
 TiamdWsa2hwv+B6biXzVHSb4Zdd7hDBCYm8WuxWIlVJGcyoCEBcJzuXdKcq2bDA768WEnLyD7wVJ5X
 SlHkVtbqqsNnYBU4lLYOOYXGBYXmbuwizfQ0pmxPSSR4GYaoJxw5s4cynNFVpMLhfXfQp/QXOlNBDl
 05fjzz3jW7kwz9XAx7nmYs2B4ulKVofgqxAUEhmzCT+C3HTABxMH2aFhYYqQTgsOWxZqQ6ag7UoKWD
 p81yXfA6UGRMUMoQvGLH2lvp7XujFodW/5W/zDTJPja+p7NVnkOOLYQWVX4YI+YMaFU144vsdBa/LM
 1HnBOVXE+sR9TZ2F/nT7YAl5gm4pRfmQcSG8Xf9/o9oVpVSpGXQiykY5QJsHfaVk96AuDh2025W6Eh
 MxwJ/wMzjJGxAdDH6GqefOIv4juAkn9C8UXTDE9CPvbkzogF10Nu1lZQriUsJ3GFLBopeh8qiruYfG
 U9PpixcsCKsO0o21k+9i4mQGq3iNxOJoIrbExsjzd8VehTcbdvFERaVhFA8g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

tcp_request_sock_ops structure is specific to IPv4. It should then not
be used with MPTCP subflows on top of IPv6.

For example, it contains the 'family' field, initialised to AF_INET.
This 'family' field is used by TCP FastOpen code to generate the cookie
but also by TCP Metrics, SELinux and SYN Cookies. Using the wrong family
will not lead to crashes but displaying/using/checking wrong things.

Note that 'send_reset' callback from request_sock_ops structure is used
in some error paths. It is then also important to use the correct one
for IPv4 or IPv6.

The slab name can also be different in IPv4 and IPv6, it will be used
when printing some log messages. The slab pointer will anyway be the
same because the object size is the same for both v4 and v6. A
BUILD_BUG_ON() has also been added to make sure this size is the same.

Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing connections")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/subflow.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3f670f2d5c5c..30524dd7d0ec 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -529,7 +529,7 @@ static int subflow_v6_rebuild_header(struct sock *sk)
 }
 #endif
 
-static struct request_sock_ops mptcp_subflow_request_sock_ops __ro_after_init;
+static struct request_sock_ops mptcp_subflow_v4_request_sock_ops __ro_after_init;
 static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops __ro_after_init;
 
 static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
@@ -542,7 +542,7 @@ static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
 		goto drop;
 
-	return tcp_conn_request(&mptcp_subflow_request_sock_ops,
+	return tcp_conn_request(&mptcp_subflow_v4_request_sock_ops,
 				&subflow_request_sock_ipv4_ops,
 				sk, skb);
 drop:
@@ -551,6 +551,7 @@ static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 }
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static struct request_sock_ops mptcp_subflow_v6_request_sock_ops __ro_after_init;
 static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops __ro_after_init;
 static struct inet_connection_sock_af_ops subflow_v6_specific __ro_after_init;
 static struct inet_connection_sock_af_ops subflow_v6m_specific __ro_after_init;
@@ -573,7 +574,7 @@ static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 		return 0;
 	}
 
-	return tcp_conn_request(&mptcp_subflow_request_sock_ops,
+	return tcp_conn_request(&mptcp_subflow_v6_request_sock_ops,
 				&subflow_request_sock_ipv6_ops, sk, skb);
 
 drop:
@@ -586,7 +587,12 @@ struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *op
 					       struct sock *sk_listener,
 					       bool attach_listener)
 {
-	ops = &mptcp_subflow_request_sock_ops;
+	if (ops->family == AF_INET)
+		ops = &mptcp_subflow_v4_request_sock_ops;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (ops->family == AF_INET6)
+		ops = &mptcp_subflow_v6_request_sock_ops;
+#endif
 
 	return inet_reqsk_alloc(ops, sk_listener, attach_listener);
 }
@@ -1914,7 +1920,6 @@ static struct tcp_ulp_ops subflow_ulp_ops __read_mostly = {
 static int subflow_ops_init(struct request_sock_ops *subflow_ops)
 {
 	subflow_ops->obj_size = sizeof(struct mptcp_subflow_request_sock);
-	subflow_ops->slab_name = "request_sock_subflow";
 
 	subflow_ops->slab = kmem_cache_create(subflow_ops->slab_name,
 					      subflow_ops->obj_size, 0,
@@ -1931,9 +1936,10 @@ static int subflow_ops_init(struct request_sock_ops *subflow_ops)
 
 void __init mptcp_subflow_init(void)
 {
-	mptcp_subflow_request_sock_ops = tcp_request_sock_ops;
-	if (subflow_ops_init(&mptcp_subflow_request_sock_ops) != 0)
-		panic("MPTCP: failed to init subflow request sock ops\n");
+	mptcp_subflow_v4_request_sock_ops = tcp_request_sock_ops;
+	mptcp_subflow_v4_request_sock_ops.slab_name = "request_sock_subflow_v4";
+	if (subflow_ops_init(&mptcp_subflow_v4_request_sock_ops) != 0)
+		panic("MPTCP: failed to init subflow v4 request sock ops\n");
 
 	subflow_request_sock_ipv4_ops = tcp_request_sock_ipv4_ops;
 	subflow_request_sock_ipv4_ops.route_req = subflow_v4_route_req;
@@ -1948,6 +1954,18 @@ void __init mptcp_subflow_init(void)
 	tcp_prot_override.release_cb = tcp_release_cb_override;
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	/* In struct mptcp_subflow_request_sock, we assume the TCP request sock
+	 * structures for v4 and v6 have the same size. It should not changed in
+	 * the future but better to make sure to be warned if it is no longer
+	 * the case.
+	 */
+	BUILD_BUG_ON(sizeof(struct tcp_request_sock) != sizeof(struct tcp6_request_sock));
+
+	mptcp_subflow_v6_request_sock_ops = tcp6_request_sock_ops;
+	mptcp_subflow_v6_request_sock_ops.slab_name = "request_sock_subflow_v6";
+	if (subflow_ops_init(&mptcp_subflow_v6_request_sock_ops) != 0)
+		panic("MPTCP: failed to init subflow v6 request sock ops\n");
+
 	subflow_request_sock_ipv6_ops = tcp_request_sock_ipv6_ops;
 	subflow_request_sock_ipv6_ops.route_req = subflow_v6_route_req;
 
-- 
2.37.2

