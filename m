Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B3DDBC
	for <mptcp@lists.linux.dev>; Mon, 22 Apr 2024 03:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713754910; cv=none; b=i3L2fPRl5rhu7MNud3ZrYPkclPc05O6B83uz22H3SCgqXFf7opL/IK4BWDbyJFJbWkypf8y8WRerFnXdqRfjv6A070LK2/jDtiVqn+jUNRwJUjuVzYGLi1CNDzOkdO0du0UW6DE36VE14rc/dCfhRuVB5EuxomdhA0Ei8bJCT04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713754910; c=relaxed/simple;
	bh=CxYn1VGv9BVyoGnuPJvlhKLzgZNZDmrSRnQIudaVJAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dz9xi2BxBBC924KcsVtACe05ZrlEawkvLPNEUpskSjtirHpwAuxIK0em3jC5fBTw3Ph8gQPOAEqg90BoZX+iCnjOxwd7dDhG7sXFDDyq169KpsseBRWsCDN78StiLHt1eFgmSfHezUL8uj8VxI+i/0QTHrLRZEewYjOWSCF1RXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Top9HmMa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Top9HmMa"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e651a9f3ffso20890595ad.1
        for <mptcp@lists.linux.dev>; Sun, 21 Apr 2024 20:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713754908; x=1714359708; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5p8+XBCRL6Hrr61VyGsGU7K/4kprn5SAx6dJ5viCQ54=;
        b=Top9HmMa/zKoSuGotpRU9L3EPlzaHiAbH/kQmJN8JdWpAYo446qBWwTdwBKwYYkikX
         WTS6TYZF9EI/w/zUgBQKU3HulALr/0t/UKqJxg/Yyq83OgDv9zpHnkXGy0tWZWBDvHBo
         hNddObmpmQSVRXvDxLG4FAZo/BpKGAaG4K/g03OxZrX3a1jwdm5o2FIfkgfQpN8LaNsG
         3Qs9RIivBOXTibikswe/nlQpPm2fbpQ6gRFrgUefl0nPUGQZZBxUICCrNn5sMEJH4XO3
         5k+BUCmLUz99yjo73GX+253B1NwzMdZUazQ1IBZlT1Ui65jnSjqvmjqYBaWdLuxSpb4Q
         /bZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713754908; x=1714359708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5p8+XBCRL6Hrr61VyGsGU7K/4kprn5SAx6dJ5viCQ54=;
        b=HA+v+mEef7M2HyL3c2dUTc3go2S5Bc4mfLs8uo/xr3lcg9clRGJaIgLV4HQDVMIdhX
         VYAuk34hlRxoTKCxsU8EnReFvxHqJOegP/vYFxpvnKRyE+AfIClCn+KZHUMkVHszE7hA
         C4trpBOYkb1dS0YYHnaGlBPaPeXd1MYm/KwYt1CNwAPOPVHBb4QXOrkWgaL5O4ulrlqV
         In8I6mfgA9UU3Yky5pGnIhHYi/xbMmHwbWk3SQkJTcegBe5wv9usfbrOEfxuYoIMiF9A
         CqnkuUdOnkcsC2fPyqp7G+Q128E4QBYQYiJb5n7YbSwFK7oCYdLC4H6+/gQafv9C2Hbo
         uFAg==
X-Gm-Message-State: AOJu0YzJYYq5MW7oLID7r/WRHuT2Ueoa8zEIwR+gmtymI6fkzvDhO+dA
	Cn/cxsoCxX5U5f7Kp307ekQTd7beawnLQ4XlyyFiYU0E1Dx/Ygd4
X-Google-Smtp-Source: AGHT+IEmXSE6/YbEiEkDZXkV8Th4sWtQd6TKpikTRSCaVLJJfKnpX6D6nSHGbo4EvC969UyO0qiD4A==
X-Received: by 2002:a17:903:11d1:b0:1e7:f944:b000 with SMTP id q17-20020a17090311d100b001e7f944b000mr9643112plh.24.1713754908124;
        Sun, 21 Apr 2024 20:01:48 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d60500b001e421f98ebdsm6966009plp.280.2024.04.21.20.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:01:47 -0700 (PDT)
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
	atenart@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v7 7/7] rstreason: make it work in trace world
Date: Mon, 22 Apr 2024 11:01:09 +0800
Message-Id: <20240422030109.12891-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240422030109.12891-1-kerneljasonxing@gmail.com>
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

At last, we should let it work by introducing this reset reason in
trace world.

One of the possible expected outputs is:
... tcp_send_reset: skbaddr=xxx skaddr=xxx src=xxx dest=xxx
state=TCP_ESTABLISHED reason=NOT_SPECIFIED

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/tcp.h | 26 ++++++++++++++++++++++----
 net/ipv4/tcp_ipv4.c        |  2 +-
 net/ipv4/tcp_output.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  2 +-
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 5c04a61a11c2..49b5ee091cf6 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -11,6 +11,7 @@
 #include <net/ipv6.h>
 #include <net/tcp.h>
 #include <linux/sock_diag.h>
+#include <net/rstreason.h>
 
 /*
  * tcp event with arguments sk and skb
@@ -74,20 +75,32 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
 	TP_ARGS(sk, skb)
 );
 
+#undef FN
+#define FN(reason)	TRACE_DEFINE_ENUM(SK_RST_REASON_##reason);
+DEFINE_RST_REASON(FN, FN)
+
+#undef FN
+#undef FNe
+#define FN(reason)	{ SK_RST_REASON_##reason, #reason },
+#define FNe(reason)	{ SK_RST_REASON_##reason, #reason }
+
 /*
  * skb of trace_tcp_send_reset is the skb that caused RST. In case of
  * active reset, skb should be NULL
  */
 TRACE_EVENT(tcp_send_reset,
 
-	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_PROTO(const struct sock *sk,
+		 const struct sk_buff *skb,
+		 const enum sk_rst_reason reason),
 
-	TP_ARGS(sk, skb),
+	TP_ARGS(sk, skb, reason),
 
 	TP_STRUCT__entry(
 		__field(const void *, skbaddr)
 		__field(const void *, skaddr)
 		__field(int, state)
+		__field(enum sk_rst_reason, reason)
 		__array(__u8, saddr, sizeof(struct sockaddr_in6))
 		__array(__u8, daddr, sizeof(struct sockaddr_in6))
 	),
@@ -113,14 +126,19 @@ TRACE_EVENT(tcp_send_reset,
 			 */
 			TP_STORE_ADDR_PORTS_SKB(skb, th, entry->daddr, entry->saddr);
 		}
+		__entry->reason = reason;
 	),
 
-	TP_printk("skbaddr=%p skaddr=%p src=%pISpc dest=%pISpc state=%s",
+	TP_printk("skbaddr=%p skaddr=%p src=%pISpc dest=%pISpc state=%s reason=%s",
 		  __entry->skbaddr, __entry->skaddr,
 		  __entry->saddr, __entry->daddr,
-		  __entry->state ? show_tcp_state_name(__entry->state) : "UNKNOWN")
+		  __entry->state ? show_tcp_state_name(__entry->state) : "UNKNOWN",
+		  __print_symbolic(__entry->reason, DEFINE_RST_REASON(FN, FNe)))
 );
 
+#undef FN
+#undef FNe
+
 /*
  * tcp event with arguments sk
  *
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 06f8a24801b2..5db2d55b65af 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -871,7 +871,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	if (sk)
 		arg.bound_dev_if = sk->sk_bound_dev_if;
 
-	trace_tcp_send_reset(sk, skb);
+	trace_tcp_send_reset(sk, skb, reason);
 
 	BUILD_BUG_ON(offsetof(struct sock, sk_bound_dev_if) !=
 		     offsetof(struct inet_timewait_sock, tw_bound_dev_if));
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 276d9d541b01..b08ffb17d5a0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3612,7 +3612,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 	/* skb of trace_tcp_send_reset() keeps the skb that caused RST,
 	 * skb here is different to the troublesome skb, so use NULL
 	 */
-	trace_tcp_send_reset(sk, NULL);
+	trace_tcp_send_reset(sk, NULL, SK_RST_REASON_NOT_SPECIFIED);
 }
 
 /* Send a crossed SYN-ACK during socket establishment.
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d8c74e90698b..966a6a9b0f44 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1133,7 +1133,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 			label = ip6_flowlabel(ipv6h);
 	}
 
-	trace_tcp_send_reset(sk, skb);
+	trace_tcp_send_reset(sk, skb, reason);
 
 	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
 			     ipv6_get_dsfield(ipv6h), label, priority, txhash,
-- 
2.37.3

