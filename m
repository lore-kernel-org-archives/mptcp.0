Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC58474
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 21:20:54 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id v8so7903020edi.3
        for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 13:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3fZKyWblqg3q0looy+K21Wkk7G9FbBw2pGMu95k2w8=;
        b=W4Bv3uX08BOvui6xGJ6k30Uv0ii7PYgfNfbBiwjG6aV8u7ydd/Ov7A2FRpJMYLjm8o
         iVOKQqteIgIauVHPij2UiqHsZQo3lUOVvH0dZ4aywI1LPN6AU0HSLoQT6lG3Y+o6JLFr
         /M1sxtZHvxd1bBrVub1rIBoEZrc5VQbcLv6EZ9V7aNvuEF3Rm6iHI5IKt1pjVegvV5v+
         ZHXtbOGxMTfSxL63+ZKo21yRC+tzU6b0F4vOMHfp0CUrh+6J/Cqa89YHmpSU9ZzbXsWC
         P5EXzpyp82EPF7IEE8yubqxx8PZs/TOfhCZ9BrV979KZPmWQcNn89BCFQVJ3oRUWHBIH
         zQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3fZKyWblqg3q0looy+K21Wkk7G9FbBw2pGMu95k2w8=;
        b=z3IkB3ya/qASPAzRbbm6xB5DtJubiiYc2ebTFyhuW4qPGL16yop4UbEMEawdhkGaCp
         XOn28JPUvqOpTkD1rVS6tpjE6GEsQMooDBoK2l/bajiBZl2pdD0mmQGSS3PtYMjQjcfo
         +qnfWmWEerI1vf6zzvioJE+TnA/e9WfVuJ0596qM47H3MkXQcJgwigVPA3XTGenIanij
         QNzPua/RDqx4QDUt1iecLZgDfby6JMwgvRWy0o5Yu0tzrxqCcFvhnv0AApiRWzWFgSn2
         UanI0eg1wKhXVqq/4CjgxAtkvOETsGKdtf1jv0PFVTvd2J6vtKlnNHthzREGelmQZ6y2
         7tQw==
X-Gm-Message-State: ANoB5pmHnHAeylW1K76JRmg3EsuKWxjhMiCWNdNp5p5tLhyVHQOknoL1
	njbDaCuAOnmULfNWcmgKl+4Rv73Cbv4Zb8CD
X-Google-Smtp-Source: AA0mqf769y9ipCo/6dXjaTdeYRyEvtOj3UlJSTItjj3R0ixmSR9jsFTM5ICAp2MAG3tNDyEvrBWMpg==
X-Received: by 2002:aa7:ccd3:0:b0:468:f345:aa4a with SMTP id y19-20020aa7ccd3000000b00468f345aa4amr36401014edt.412.1669411252313;
        Fri, 25 Nov 2022 13:20:52 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id i20-20020a50fc14000000b004618f2127d2sm2198480edr.57.2022.11.25.13.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 13:20:51 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] Squash to "mptcp: add subflow_v(4,6)_send_synack()"
Date: Fri, 25 Nov 2022 22:20:28 +0100
Message-Id: <20221125212028.702058-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2869; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=QKQDaVaMGU2BCfEF7shKj/6P6Um+MTn6TuYJT6XdaVc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjgTF0K443ObqLG9qXW7PGhipb7uOtNrlM66Dn5RK0
 ZZW1wtWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY4ExdAAKCRD2t4JPQmmgc524D/
 9xhKzVB9UHKl/CK1nvPtMDlnG/54kL4reCNx3lb5sbui0evbkCZN4i5dgz1RkeJULt/FwBR4BU0fXC
 gIRWWbHNgyC21b9bh1EQTsVWxYEdMcpBhhXFjBaNOpd7sZf9TTwr0RFab3VWmrTAJDOwaJ739WRFQc
 m13H08X020kktCwG87t8MuuYc54B8JhgQZ6M/sSO7giUnzmvo/MGMXC7AMrMgmK8iTSkzEFxx+j5gn
 5K6/0+LLEl+7IoFiFf4jnbvHmKnAkWLxpTVQpbtlJlZUFURuExzjSY39mQXDxnpkT+i9d3QcI52FOC
 PaNcWuM+DEVKbxapBCrzOoVfhW7vvNnL+GfJtRXt84wqYWV+5xao+DNgcas6ktbX7/Xd+6X6aTLw55
 VbEHjZdDUZaUeTnuuWsGJfljTHqvPsb+dJEOJIyXInOpcyHgcFsX0FgchCmJD3OGd3IvivlhmpdKle
 QvzCklTcTzRkE2/RXRsyvPYticJEmSwrCOb0g7sZ/Y8zLQgopBw+thZKeKm4r3otyu8ZZckH3EkkT/
 OuaOHQ58CVlAIiw/eb/f+HAaGufc8VaP6xKdvk5W17wC7TM2WRmuqR/HasYgiOe87tttAvR/qGy0ie
 GVOeM1kq4POfcspvSSuJZ/+SAd+ke25DTCSCTLbX3yo34INbg7Ipm86Yb9fQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

This is a small cleanup, just to avoid duplicating the whole function
for v4 and v6 while the only difference between the two is one call to a
different send_synack() function.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/subflow.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 05099b3760b5..2ff3840fc058 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -307,12 +307,9 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 	return NULL;
 }
 
-static int subflow_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
-				  struct flowi *fl,
-				  struct request_sock *req,
-				  struct tcp_fastopen_cookie *foc,
-				  enum tcp_synack_type synack_type,
-				  struct sk_buff *syn_skb)
+static void subflow_send_synack(const struct sock *sk, struct request_sock *req,
+				struct tcp_fastopen_cookie *foc,
+				enum tcp_synack_type synack_type)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct inet_request_sock *ireq = inet_rsk(req);
@@ -323,8 +320,19 @@ static int subflow_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
 
 	if (synack_type == TCP_SYNACK_FASTOPEN)
 		mptcp_fastopen_subflow_synack_set_params(subflow, req);
+}
+
+static int subflow_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
+				  struct flowi *fl,
+				  struct request_sock *req,
+				  struct tcp_fastopen_cookie *foc,
+				  enum tcp_synack_type synack_type,
+				  struct sk_buff *syn_skb)
+{
+	subflow_send_synack(sk, req, foc, synack_type);
 
-	return tcp_request_sock_ipv4_ops.send_synack(sk, dst, fl, req, foc, synack_type, syn_skb);
+	return tcp_request_sock_ipv4_ops.send_synack(sk, dst, fl, req, foc,
+						     synack_type, syn_skb);
 }
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -335,17 +343,10 @@ static int subflow_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
 				  enum tcp_synack_type synack_type,
 				  struct sk_buff *syn_skb)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
-	struct inet_request_sock *ireq = inet_rsk(req);
-
-	/* clear tstamp_ok, as needed depending on cookie */
-	if (foc && foc->len > -1)
-		ireq->tstamp_ok = 0;
-
-	if (synack_type == TCP_SYNACK_FASTOPEN)
-		mptcp_fastopen_subflow_synack_set_params(subflow, req);
+	subflow_send_synack(sk, req, foc, synack_type);
 
-	return tcp_request_sock_ipv6_ops.send_synack(sk, dst, fl, req, foc, synack_type, syn_skb);
+	return tcp_request_sock_ipv6_ops.send_synack(sk, dst, fl, req, foc,
+						     synack_type, syn_skb);
 }
 
 static struct dst_entry *subflow_v6_route_req(const struct sock *sk,

base-commit: 5d9ac522aceb69b5b524d330b6ecdbaff61decdc
-- 
2.37.2

