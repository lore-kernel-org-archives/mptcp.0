Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE78BA49
	for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 21:08:35 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id e27so36803033ejc.12
        for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 13:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXlmKccEesmZovUEsGDiZsalt0MAyWophvAm7FOrmFU=;
        b=ux38CguJHFgUP6ttGczlBAG2WwWIrv/6GDkPQwXRIl++mCZDyKjtHCBFoM6ubf03Zx
         6pyE5TOdQIHjKdiibHlFVwzlQmKg042lXvXvTSeWLAlJ+lXt1b1owksUrwfCAVGFuABC
         vdTisL8qza1/NW8wzHnln+I/gA6GNDImGP7iMM7tjBjNo9bBfQEo4UQGWhAzWD6jW0g8
         M4qB7gDGujhq8q+zu7V9l+lXEUZt7gsNdjVfEe8ffO0B4shp0yxj5hQ3Rdl+R9NLHPeR
         5PrBLUDKaEcXS3Myk/r065/1Q/XQMXhp5iqU7x/QD08Ic4sHBWTvyl4yAp79+2G7+slU
         gQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXlmKccEesmZovUEsGDiZsalt0MAyWophvAm7FOrmFU=;
        b=hfsrSxXCOHFTXUnJYCvuIfZbAeqG9tM55enAPl50dkG4eQ2gpZg2buET/cn45TIRCc
         UqDhvdtP38I17gUSoGeGaxE5Y+Cl0znj4VP3fhZWFI8tD295QH9E9aZB3l/y1VOksQxE
         67DMDTWFzl49LdpPRe09lpVaDogklX6LYrjAbXfbzFjnV9u+35iAs/Kz483TWMR/0Axi
         bTz2jwWly+n5RSUBIUyhrLAbqEwgQZP8/EouK3wEK5UfzjQ5dBpxlaiPYnHvD38PrdbO
         Tcv/HBV4maNpIlwprINPsLC+39wIyb8MjznJ7FcuewYbLjtX1QLusWuj4bTGN/wvws/V
         +T4Q==
X-Gm-Message-State: ANoB5pnS859TqIRBJ127KcBeCazlp/SgrVeNGVPACNvdGzwAhLF3kPKI
	mEBKlVfQqHfxkVsUz1MFGyUgvbKsSRdZtxkgulA=
X-Google-Smtp-Source: AA0mqf5zAfanzmMtdGLGrD246PTLOB5pj3nbswPwQALNZJZkJDvWEbVLhbNnQpULzI0xFMR+AZ9Kzw==
X-Received: by 2002:a17:906:3293:b0:7bd:f540:9be7 with SMTP id 19-20020a170906329300b007bdf5409be7mr14920988ejw.434.1669756113378;
        Tue, 29 Nov 2022 13:08:33 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090694ce00b007aed2057eacsm6516487ejy.221.2022.11.29.13.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 13:08:32 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net 2/3] mptcp: dedicated request sock for subflow in v6
Date: Tue, 29 Nov 2022 22:08:03 +0100
Message-Id: <20221129210804.3769157-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129210804.3769157-1-matthieu.baerts@tessares.net>
References: <20221129210804.3769157-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5269; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=SO2iD+cklJishPzqSr5K+q8Er4ry5HsTY583VM8YNAs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjhnSz3+QI4jcr87Pssa3g5vl4JRFl1ZvZ7Ifvdnxe
 GwgcxZGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY4Z0swAKCRD2t4JPQmmgcxRZD/
 9v09+QaIE+rsQB9ycwFKIkTVJWdFLfJJh10RqVlR+LGn2l9Eg2L/zFHOofDGnB0NlPg5i4q7/JC3DU
 wHZ2KTnpTkvu2qd4Ej5si5X2KE8XRptqNUi/aqC7Tqshrx8oYQxRNWi5FTGb1LmEfB22F85V4se6Vr
 eR5OeLzo54D81OPnZOL11h/NsTxQLqWGoNtLGNqh6L/aZeaGBPEM1UppWZEcrp734KbClM9N/g/leC
 HaNFxQxw/uG+DBECi8NrRxnJHhMajmrbMFhifySOsEbqZsRKfpoN+HzI5gLzWssdU9gAhaEKGdUtD2
 +UvWH6SIUu0brSlFSXIzznpcp5R5TINxvKzWUYW46o8uaIda+zFDbdX0QrDyWHkHxiCwcFVa2Yyisk
 P/2/tk6kkwIno1oZH/RNW6EG/HvO3SdRxLl9oexFeUE3ZVKs4TjReyzronGlakvOmkxJXIlj2VwHSV
 73/Pj7eG8a3uxe/plJF5NLvDlGp8QoPhgv8pOuOasEzmJLdHBF8I6RgUGsKPLBkjmWDDEYAMMygnps
 0iUjYIh5BDl/v9+1TnG5ViHzIl2/Has2XViXvfVknN0bJkbyLrYp50Tg9PNQfHiRw4Owcp7n5HeFX8
 NeVZxKIHKZi4wSfBeoE3YuZjWBXwo92p6EQkxz5RBInof6RmAjhemG6cDrMQ==
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
index 97a354aea25f..16498dd9e0a1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -529,7 +529,7 @@ static int subflow_v6_rebuild_header(struct sock *sk)
 }
 #endif
 
-struct request_sock_ops mptcp_subflow_request_sock_ops;
+struct request_sock_ops mptcp_subflow_v4_request_sock_ops;
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
+struct request_sock_ops mptcp_subflow_v6_request_sock_ops;
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

