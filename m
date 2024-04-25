Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8E1DDEE
	for <mptcp@lists.linux.dev>; Thu, 25 Apr 2024 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014849; cv=none; b=Pbd7s0b2KmEaaiAk52WFyXOI2NvvlFjkZ4iJzcPyIEsDT9+EUuTEXGqzvURSdAMdt+tB88eOCP8+E8TQRMKpsYKmYmbPMwlnPsZipGyvlxVGkZfaWpmqEEZXUK93FYux3NGkpg5RjEsoDN2TrCze6KtXbjkb1Z9uWtPTvW79gxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014849; c=relaxed/simple;
	bh=v7U6oW3gDsie/i0ijCRs85/Eal6SYC2LrAnRuKhJdAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nf18xEWiOK+4g3uW1QIA8lwap6V4y4j7N7tHHgvWEFUZlJs1PIXMQl8grtWGq+Xtdts4HcJiL+wxwu01FAJ7U4i4uMr+t7kaBiw8Dnk9PBLhjbwAQGXULPBfxj6XH7wjsKRQfPnGJjDDl+3YTL3F3aj27GQaSr9gfKHoWSB7YFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pegw/5vO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pegw/5vO"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ee12766586so484536b3a.0
        for <mptcp@lists.linux.dev>; Wed, 24 Apr 2024 20:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714014847; x=1714619647; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6IM3xStLyH2OezX5Q6f1JfXVKMrEKiHR6KKT+cuT2w=;
        b=Pegw/5vO2vpDPfkYap2L7dtGis4qJyXUwXI8G0P8lSCM/vk3XFewLXP2/D3dA/yruD
         SwBtMUVj63+fToQRDZEe/sqnJTwsWM4JbvN82bEl+o62M6ThzsKIovfABeyEWbgR8int
         8vol9jc3A4REi/cM30BC3PiJjYiHR5xQ8sGJlcx66zVoEWKhyIZJo6jlOy7YVh5nf37x
         G2mgPsD5bK9SBI2R7TMa+cWM2ygSLVw5a6iXTi5l3pl6eqeuJ2DW6vJsiagQf+x/GlGJ
         tncK7OqtjsDHY/AzwsgyM7qqWTqG14OWPzB0cL7IFRMOHdISX5AycKG2s1/dATLpkVIk
         eraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714014847; x=1714619647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6IM3xStLyH2OezX5Q6f1JfXVKMrEKiHR6KKT+cuT2w=;
        b=q2mkatIxKt/HZVzCJti8KJ5mkCZsht6cqda/rop+/Jomlb9A9KJMEQH9zx1jNPUUN/
         HfEi4Vxgil7Rf1YNGZ9TBMcNDbTvwnpQHinYL9cX+3cqOGYN7b6rV2lSCMi1p7w252T6
         yls6zydTnnOSlMexrlA2bhMpLMHiNvyEg+aGhqr+fT4BnDONHCxmk9qMkjOlDjPRO0jz
         9liVqbYOE5xmT7NhDl9+pR6yPSqrkKRH0MhMaHXJEDy+U3eFKsKU/xm9L9RpVUXItYRH
         kCo5hf8cFi9cayS2fZO0a6DPSRhjbEU8N0HzcTIpm9WDieK143pABZblatgnZ5fnvS9L
         rL9A==
X-Gm-Message-State: AOJu0YwkKVrCaVrEy35WpMRoald61LT4/HfwYFomc8jfw4DgIoXI5Vfm
	MKRnvQXnKhJYNZN7clpkIiIq416jpSRh7YkgpqTF6ALHqMHVU+5p
X-Google-Smtp-Source: AGHT+IGtwH1fE/Tcubt8Ed5lxBtcDpXwEXMYJQtyqMUjux9Y7TF9h7ABf/9vp6uIKgvCaOflWA4NQg==
X-Received: by 2002:a05:6a00:a86:b0:6ed:2f0d:8d73 with SMTP id b6-20020a056a000a8600b006ed2f0d8d73mr2487746pfl.3.1714014847386;
        Wed, 24 Apr 2024 20:14:07 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id gm8-20020a056a00640800b006e740d23674sm12588884pfb.140.2024.04.24.20.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 20:14:06 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	atenart@kernel.org,
	horms@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v9 4/7] tcp: support rstreason for passive reset
Date: Thu, 25 Apr 2024 11:13:37 +0800
Message-Id: <20240425031340.46946-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240425031340.46946-1-kerneljasonxing@gmail.com>
References: <20240425031340.46946-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Reuse the dropreason logic to show the exact reason of tcp reset,
so we can finally display the corresponding item in enum sk_reset_reason
instead of reinventing new reset reasons. This patch replaces all
the prior NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 15 +++++++++++++++
 net/ipv4/tcp_ipv4.c     | 11 +++++++----
 net/ipv6/tcp_ipv6.c     | 11 +++++++----
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index bc53b5a24505..df3b6ac0c9b3 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -103,4 +103,19 @@ enum sk_rst_reason {
 	 */
 	SK_RST_REASON_MAX,
 };
+
+/* Convert skb drop reasons to enum sk_rst_reason type */
+static inline enum sk_rst_reason
+sk_rst_convert_drop_reason(enum skb_drop_reason reason)
+{
+	switch (reason) {
+	case SKB_DROP_REASON_NOT_SPECIFIED:
+		return SK_RST_REASON_NOT_SPECIFIED;
+	case SKB_DROP_REASON_NO_SOCKET:
+		return SK_RST_REASON_NO_SOCKET;
+	default:
+		/* If we don't have our own corresponding reason */
+		return SK_RST_REASON_NOT_SPECIFIED;
+	}
+}
 #endif
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 418d11902fa7..6bd3a0fb9439 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1936,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v4_send_reset(rsk, skb, sk_rst_convert_drop_reason(reason));
 discard:
 	kfree_skb_reason(skb, reason);
 	/* Be careful here. If this function gets more complicated and
@@ -2278,7 +2278,10 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v4_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				enum sk_rst_reason rst_reason;
+
+				rst_reason = sk_rst_convert_drop_reason(drop_reason);
+				tcp_v4_send_reset(nsk, skb, rst_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -2357,7 +2360,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(NULL, skb, sk_rst_convert_drop_reason(drop_reason));
 	}
 
 discard_it:
@@ -2409,7 +2412,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(sk, skb, sk_rst_convert_drop_reason(drop_reason));
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 017f6293b5f4..317d7a6e6b01 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1680,7 +1680,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v6_send_reset(sk, skb, sk_rst_convert_drop_reason(reason));
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
@@ -1865,7 +1865,10 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v6_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				enum sk_rst_reason rst_reason;
+
+				rst_reason = sk_rst_convert_drop_reason(drop_reason);
+				tcp_v6_send_reset(nsk, skb, rst_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -1942,7 +1945,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(NULL, skb, sk_rst_convert_drop_reason(drop_reason));
 	}
 
 discard_it:
@@ -1998,7 +2001,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(sk, skb, sk_rst_convert_drop_reason(drop_reason));
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:
-- 
2.37.3

