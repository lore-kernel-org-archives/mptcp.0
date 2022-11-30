Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D25DA50
	for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 09:45:03 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id ml11so15053957ejb.6
        for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 01:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6qIp98IdyNHtYmrmCJesqbBwp2qgAQB0hOzZtk0bcY=;
        b=u/pUw9LL7t3UKyqwANVp9gcH90Jg234ZxAyniwJyq2o3PueukTcoxw2I2X1tVf+ySt
         7f6MJSSq8sfGu+mc1bFIdsakJL5GeEJOGxdWcCjUuP2OFWTDZUD2WKvDUNhXvHDvGH9L
         D6kImIdiqdQzOmFe41BXQv7i6fiqCH9T8lJvlSzoFbQw2QECYfVJ8PoGZe8fiFVou31Y
         ahuwNsfyfgv6gysM3lYcH2KIWQbejUmhuqt0u4RkC5B1fTR2qKgvEtwfFRuWnPO0ALxC
         dGX8vLol9Egfig/ZF2xN67AaaxTue20zhTD+Jr4rY3lV7iw5P2rsp7/cWVl1WTDHO5vT
         lwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6qIp98IdyNHtYmrmCJesqbBwp2qgAQB0hOzZtk0bcY=;
        b=Lfg6jeY48NVzu4b+5QD4LcjiLAs2XJfY+Dogn3NU9dVI73ETQoyplYVJPvDddlqWfx
         M9nUkPx1q8QMcO8R2gW9A30pjam7avYs/Q+mUrxWmDme9RGqOG+oFd+lXko3mMnizEFB
         zjq/6ZIdIRin3KOA2N5YwzQQqiQnGDRriMwaNLJkeGeEjnPq2LVcqHxCK3kVI+IsTcMr
         zT4Iq+v/lwljFNUyYvJJOOPgB5Mbg3VnwtkDMtprOUBIGIImt8RKattGpps4l2TqPzdl
         hgFv/tqrl9VC2fc4TeYmyMSAfxWYqiSOjmycbivow/ax63aFiV92skKZ15hAiwU10W70
         7/Lw==
X-Gm-Message-State: ANoB5plA+6KFAPROBcSWEqGpSTRKLO4QixXHEn1zFhgcOw3mnX7vL4oP
	lT1ILKu77ZDRPXBo5nJmeuixJkETF2f8jEzTrGI=
X-Google-Smtp-Source: AA0mqf6QzmvVEh+J9BQUTCqjrTmyYcA3m4FFx+TYeR4TJqAgXkZLc12qubj4bvHJ7XbXfRqBb2i9eg==
X-Received: by 2002:a17:906:ce49:b0:7bd:2800:9ac6 with SMTP id se9-20020a170906ce4900b007bd28009ac6mr20122161ejb.386.1669801501663;
        Wed, 30 Nov 2022 01:45:01 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090653da00b007417041fb2bsm440374ejo.116.2022.11.30.01.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 01:45:01 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net v2 1/3] mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
Date: Wed, 30 Nov 2022 10:44:46 +0100
Message-Id: <20221130094448.4119946-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221130094448.4119946-1-matthieu.baerts@tessares.net>
References: <20221130094448.4119946-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3839; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=mh1QVBzeNkxTkcbdWyMlbsfTKJPR8xiIHKRtCGjFPj4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjhyYP0BFJPabc/OZrB9y8z6Nu9TSM8oGGkzWxbKl4
 +rqJ362JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY4cmDwAKCRD2t4JPQmmgc15hEA
 CaEy+Djj63EMKnx82bGQ8sB6ui1UClR8GP8Id8qclvDxnhIT1mHI4n3IFx8AWSJwH+vj5tz8A6pkad
 PUgpwR17YHtcE5aKJuknkkOaPSp1DBvoLNQ6Xa7zvjDwNzyc1QTqoImml65v4U0Fewb2c02PrPw5Kq
 l6qAfHt1izwPNbXxieoFo2daW6HkpK/RdAb5t1hE4u5KP7xIOQUoUFWOKWg3xPR6jTlh4saJKDK+S7
 jUSoqY4efabYTjECahuKzH0e7meuqRR+2S+RHjAqPmJvYOHzs5YoLhBzTVW/l/H3K0dZWPk6mOn/JH
 x9ndyh+zhbxMFjQVNsVhqsMdztn8xhmbRgY3HGU6LTr035vU1vjeG1Z4pQO+xj7mT+MY9HzHFoNIL4
 gtzqvk5uvbiVHuiw//jfdHF1a7dyEVhpnUBMoEJl78JlD0oBjEO55sJFLd4knaVuqL7IpRkFB/+z3a
 +Ovta/RFsieGPthh5wke38h2AlLJIkGxQmA5cSb3BWMzP/OM/0gnqo4QzNPH9bJ2oUqy7K2LRkxVa/
 S1fsU+f3i6mNz0BeI7TZ+qlb90vmLBITbbyU3/8ZtbJXLQ31e5Wpvn2kTwFVaNSD42nOfMpC/zBWNk
 wHXe3zVg8q3+nZUYqjDO1FnD4PdL3T4Eb+ZDOQnq/FdgCLiAPElZMWqQ29eA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

To ease the maintenance, it is often recommended to avoid having #ifdef
preprocessor conditions.

Here the section related to CONFIG_MPTCP was quite short but the next
commit needs to add more code around. It is then cleaner to move
specific MPTCP code to functions located in net/mptcp directory.

Now that mptcp_subflow_request_sock_ops structure can be static, it can
also be marked as "read only after init".

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    v2:
     - mark mptcp_subflow_request_sock_ops as static and __ro_after_init

 include/net/mptcp.h   | 12 ++++++++++--
 net/ipv4/syncookies.c |  7 +++----
 net/mptcp/subflow.c   | 12 +++++++++++-
 3 files changed, 24 insertions(+), 7 deletions(-)

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
index 2159b5f9988f..3f670f2d5c5c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -529,7 +529,7 @@ static int subflow_v6_rebuild_header(struct sock *sk)
 }
 #endif
 
-struct request_sock_ops mptcp_subflow_request_sock_ops;
+static struct request_sock_ops mptcp_subflow_request_sock_ops __ro_after_init;
 static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops __ro_after_init;
 
 static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
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

