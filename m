Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C455449EA9
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014894; cv=none; b=G+VD38MXppNyClz+LUkG/QoTWd56deNDQihLQ5cLwGduJqsJ8V8np/4B3/vNcLf8l6QH8ua3Sq5a3p1GmNN/zLTHEGnjse8i8TDkMZG+z63QvgSou+MKV17jZNOmlfbJnCAP9IU2B6zfY4q7n1jN7Sx1Q9D47kC2UjFhJ240zwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014894; c=relaxed/simple;
	bh=WmK8KZTr19xuBbBZECD6AVvHrr5CmfBlYQve7lOMDsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XY+xFcZ6YfW7vSmmSmALdKHD0fXHWaWaBmQifMwxXOL91L3C8JPiGirY0QCVgbDVnJGG73LEKdxcvN7xEDRFCYL6/jFOjOO6AoNiAKPv8PLXyMlk280VKztzn/0QK29zMv+uqJppvhfnbpGankIy3WHwKN0GrkJ+B4SOkch/Q4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Z2qEoBFL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Z2qEoBFL"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8487214ad2bso3168957b3a.1
        for <mptcp@lists.linux.dev>; Thu, 06 Aug 2026 04:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786014893; x=1786619693; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=29AyUjE5Vfxw6W9VRHm3bjock3hYe1PRYtirYyF9Kc0=;
        b=Z2qEoBFLNQemBM3ppvh4IZ17/jMl3qhaWOA7hESe5Gf0PiNXCAMDjN3Z+fZMKlEb85
         fdjmqxrMHzPs2HOelT0tot+qquBidc+xbNBOwzwtSfX+EEev01yGtJZW/xOPQuOCJ5b2
         jfgN8oOvMWsJuCdC6C2wE/03GmAamgcD7Za1EiGvl/1bLgV9lwBRK/gVg/OypijSUNoy
         wLMi+dcZssLkjgx1EQ8cw+uNKB53JyeDxzDs6iyF/GnSEqF0j/wwPpWcn+e6/cn4JU/Q
         tYxmUOm0Co7IAm/3/HPXpzMP+yL8pcT6gFS7sUQL7UiXZ/Y0HctHR2x/0VgDtY+BMeUL
         UfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014893; x=1786619693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=29AyUjE5Vfxw6W9VRHm3bjock3hYe1PRYtirYyF9Kc0=;
        b=HzqCpAr6sie7JvROqYU6oMI5gn6CUvtX1Fy4lkwBmUlY2+OyW4Q7la3QIapPyAYbSn
         CM7Fhd8jSdfqqdNHzo/19ilyckXxOowL4+DNNCzSJ6MBE7HFn0l6keH1iAWD6dVElwv3
         JYxAyv9orG3YfV7qzO/UwVSddNTXaAuoTpWY98U4fFrIY8/o4v8DRa6ZSm7O3TK1DYya
         v43epXYSJqdlU32XFLb35gR7hPjlkfv3U5H2ysJfgnjb3AwuJRxoG8QDfvSLCVhQn4es
         wCuw7G47+bu+IK9993FeKRiIdYguRO6Z9KLbaraGpwwRmss06aQXj4yRUjuYH5LUWBVI
         tVsA==
X-Forwarded-Encrypted: i=1; AHgh+RpynI1k0iJi8BoI9KanCO/zvVrKF8YkrdcHpxfeuh1hvPJH8inYTjGqlKf9rkf2DJS0bzBnWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYLi0bgdPpQd1NYZq+tBPV9KH9wz65JDPmne4SyhQwq9R41t8Z
	X4rVl8vKad2IlDdgtjGWkUdR3EPcJBJV2/GazYyLh8CiJfz+IlkGTq8CoNFuKV2InayP
X-Gm-Gg: AR+sD11w4jd8QE21Vw673PeUVyt9cW0GUowrrECR8iITO5W2NJGnEL8ttkvSOmYL6fi
	n7hn3OcIq5Gl1AMaatF6nnojytnyj9O6DGm8oxyEtZO7/yuQrNcETyHjmfFCmzHUNURkS1iVbdg
	wHlMX15b1qKvsZ8Vc1LIqlWaSD+TO9tnKPC+3U1Kh5URgFYHrecNQ0lRqakw5hL14wCI009B/R8
	jvQwmeMbmhAt/bWFeLCjRUS1R3TTdGet3u/JnxrkVfBv+/Sy+0FD8r2sxdO0RWc7QUHvA6Qzd0V
	4RvgXKaD2ttJ0C7B2UBvti5RlYfci+B4dIIvFWJsLXOvXGzQeRxfV94REt+DfAoJD4IejnsAkcl
	lUB1IA5CM6FYwq3bxifLLfeMuG7jeA84knk5cIhs7Amdc80oXhPQUO4zorQYRulxq7M2hn7cncu
	SJKFyCzt1u31eii5ze7Cdi03UhhIKjdVX3CMKlvsW75tfpBz00F6E7B2I=
X-Received: by 2002:aa7:9303:0:b0:845:cf86:9469 with SMTP id d2e1a72fcca58-84f2e004570mr17499947b3a.29.1786014892652;
        Thu, 06 Aug 2026 04:14:52 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b07cdsm1214705b3a.17.2026.08.06.04.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 04:14:52 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	daniel@iogearbox.net,
	kafai@fb.com,
	kylebot@openai.com,
	david.lee@trailofbits.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai,
	sashiko-bot@kernel.org
Subject: [PATCH net v3 1/2] mptcp: hold MP_JOIN msk ref when cloning reqsk
Date: Thu,  6 Aug 2026 19:14:30 +0800
Message-ID: <74e00d4f4fedec635ef06a16b1bf28a281b9e7e5.1785995291.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785995291.git.caoruide123@gmail.com>
References: <cover.1785995291.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruide Cao <caoruide123@gmail.com>

TCP request migration clones pending request sockets with
inet_reqsk_clone(). For MPTCP MP_JOIN requests this byte-copies
subflow_req->msk, but the clone does not take its own reference.

The original and cloned request can consequently drop the same msk
reference from subflow_req_destructor(), leaving one request with a
dangling pointer after the other is released.

Add an MPTCP clone helper on the TCP request migration path and let
cloned subflow requests grab their own msk reference when one is
present.  The clone's normal destructor balances this reference on both
successful migration and failed clone/insert paths.

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@vger.kernel.org
Reported-by: Kyle Zeng <kylebot@openai.com>
Reported-by: David Lee <david.lee@trailofbits.com>
Closes: https://lore.kernel.org/all/20260804095051.715355-1-david.lee@trailofbits.com/
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 include/net/mptcp.h             |  7 +++++++
 net/ipv4/inet_connection_sock.c |  4 ++++
 net/mptcp/subflow.c             | 11 +++++++++++
 3 files changed, 22 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 71b9fc5a5796..0a02ac1ed22d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -223,6 +223,8 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
 					       struct sock *sk_listener,
 					       bool attach_listener);
+void mptcp_subflow_reqsk_clone(struct request_sock *req,
+			       struct request_sock *new_req);
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb);
 
@@ -309,6 +311,11 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 	return NULL;
 }
 
+static inline void mptcp_subflow_reqsk_clone(struct request_sock *req,
+					     struct request_sock *new_req)
+{
+}
+
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6257459bcee2..896f472dcba2 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -21,6 +21,7 @@
 #include <net/xfrm.h>
 #include <net/tcp.h>
 #include <net/tcp_ecn.h>
+#include <net/mptcp.h>
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
 
@@ -961,6 +962,9 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 		rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
 	}
 
+	if (rsk_is_mptcp(req))
+		mptcp_subflow_reqsk_clone(req, nreq);
+
 	return nreq;
 }
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8e386899ceb9..be7260821566 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -47,6 +47,17 @@ static void subflow_req_destructor(struct request_sock *req)
 	mptcp_token_destroy_request(req);
 }
 
+void mptcp_subflow_reqsk_clone(struct request_sock *req,
+			       struct request_sock *new_req)
+{
+	struct mptcp_subflow_request_sock *subflow_req;
+
+	subflow_req = mptcp_subflow_rsk(new_req);
+
+	if (subflow_req->msk)
+		sock_hold((struct sock *)subflow_req->msk);
+}
+
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 				  void *hmac)
 {
-- 
2.43.0
