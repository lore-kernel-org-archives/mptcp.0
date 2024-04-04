Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45215677D
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215303; cv=none; b=BZf0y5SsAjGrbHa28c5grbwmXtVrqSXAn4mrbx/+wZY6GwohTqK5x8Hrfbld0w/O7h0QlQ+g6QAzP9bGBJBjTHaCF3osy93kzn9ooGrtVI9Gx2zhi6MR+YRV9+B3lr6fJfiW1hme5y6rWBit8JvBwvIFwiQODfQE9CiBwbAlpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215303; c=relaxed/simple;
	bh=oZv1Wez/4+bqsLmNS3FVMB20C3FjVPxQSLIEYsk1Hlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CMxMyptOu7x9QcsquV8O5DC2ADyVKW1VcocrHiLAw0X5M30ivpxS/2jg9003yHNOdmZ//qy61fwtO1HtLloNkshgVdVGWK6rv6oH48/BbI1Q1H1nBMRhurm5uGMLERyvZDXjnrAD0Fg8okS2l6ZWQpUzMApWRIMP862stxKpVFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiSnPwC5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiSnPwC5"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e27fadbbe1so5668855ad.1
        for <mptcp@lists.linux.dev>; Thu, 04 Apr 2024 00:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712215301; x=1712820101; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGOhlg//3F0S9mUwjG1Z9GiuJGTOaECWxukxpME741g=;
        b=kiSnPwC5pluMx8nkFyQ4rZa7EztGEp+oxsTfweK9bhaixfFtjgZDSmH47O/UOyAmY0
         CyGpOHCYbIYBlQ5zwVEJTJGS9ONjomfYUHDAo7McVGxNjvSe9N3pPriIfLo+6iCohgLo
         QFT4i7AC+BqpYvaIser8BoKU8OV80ScLEF8C0unLZX+aWA/sQpZO5b7iG2atO6y2jHDz
         SglBisQLMG6IclktbNEkAOEJbF2f74u+sYVxnQNZqvIEQK2xs82Unh4EiMOwiyimGj+5
         XkNbI5KnGavRkygCUKw5Xl9i/i6mJeBUBLfrcIka/qqewc5nTlq0QH2W3By0IkWMdXIb
         cfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215301; x=1712820101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGOhlg//3F0S9mUwjG1Z9GiuJGTOaECWxukxpME741g=;
        b=EK2iYjQZLAXIx9K4yb84CTNnVk8odO0gPpJGXlCrkeQ3wRCrH3iuJFgI7tk0RO4yO6
         6I02ROI1hZ8wR2BTJ7qG6oKxmdzzNiqFfmxXmAaYOzR09i3b9RQP6CfffPTX3YJfCl1g
         ngsrF+WF1511NXunHgYKYsny6fjgtqnhAw/oqgkOgqEC42tMsV6fk/RdEwSB0LA9kla8
         vqlcqv4myqRpKbK162TnuYScDxFxtLPt9QNbcuaGyTQJvIVUE48TjHKF0pU0uAQpAab8
         YbqVvLywbbXOuj51kWOuxLgO+jqSkROaY0FcLvShQA7/oj1X4YpNtF4xkm6zRoYEGj0P
         mDbA==
X-Gm-Message-State: AOJu0YyshKj1KH2sIIAf9thP8qjAP/xf/MSoROn8++VbT7slmXHKo7qX
	YwbU9kwH9LB2CCNpp0OiyXLAdjVp8j4rmOaVmkom8a40qp37trux
X-Google-Smtp-Source: AGHT+IH66YdB2sVgkmH1xvgv4I+C6smt2MXPHmHm4S0q+JrLyLlx88yXDouok+cyXGNV6azCdk+JZw==
X-Received: by 2002:a17:902:f38c:b0:1e2:7462:b97b with SMTP id f12-20020a170902f38c00b001e27462b97bmr1010177ple.67.1712215301155;
        Thu, 04 Apr 2024 00:21:41 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709029a8200b001db5b39635dsm14606399plp.277.2024.04.04.00.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:21:40 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 6/6] rstreason: make it work in trace world
Date: Thu,  4 Apr 2024 15:20:47 +0800
Message-Id: <20240404072047.11490-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240404072047.11490-1-kerneljasonxing@gmail.com>
References: <20240404072047.11490-1-kerneljasonxing@gmail.com>
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
---
 include/trace/events/tcp.h | 37 +++++++++++++++++++++++++++++++++----
 net/ipv4/tcp_ipv4.c        |  2 +-
 net/ipv4/tcp_output.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  2 +-
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 5c04a61a11c2..9bed9e63c9c5 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -11,6 +11,7 @@
 #include <net/ipv6.h>
 #include <net/tcp.h>
 #include <linux/sock_diag.h>
+#include <net/rstreason.h>
 
 /*
  * tcp event with arguments sk and skb
@@ -74,20 +75,38 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
 	TP_ARGS(sk, skb)
 );
 
+#undef FN1
+#define FN1(reason)	TRACE_DEFINE_ENUM(SK_RST_REASON_##reason);
+#undef FN2
+#define FN2(reason)	TRACE_DEFINE_ENUM(SKB_DROP_REASON_##reason);
+DEFINE_RST_REASON(FN1, FN1)
+
+#undef FN1
+#undef FNe1
+#define FN1(reason)	{ SK_RST_REASON_##reason, #reason },
+#define FNe1(reason)	{ SK_RST_REASON_##reason, #reason }
+
+#undef FN2
+#undef FNe2
+#define FN2(reason)	{ SKB_DROP_REASON_##reason, #reason },
+#define FNe2(reason)	{ SKB_DROP_REASON_##reason, #reason }
 /*
  * skb of trace_tcp_send_reset is the skb that caused RST. In case of
  * active reset, skb should be NULL
  */
 TRACE_EVENT(tcp_send_reset,
 
-	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_PROTO(const struct sock *sk,
+		 const struct sk_buff *skb,
+		 const int reason),
 
-	TP_ARGS(sk, skb),
+	TP_ARGS(sk, skb, reason),
 
 	TP_STRUCT__entry(
 		__field(const void *, skbaddr)
 		__field(const void *, skaddr)
 		__field(int, state)
+		__field(int, reason)
 		__array(__u8, saddr, sizeof(struct sockaddr_in6))
 		__array(__u8, daddr, sizeof(struct sockaddr_in6))
 	),
@@ -113,14 +132,24 @@ TRACE_EVENT(tcp_send_reset,
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
+		  __entry->reason < RST_REASON_START ?
+			__print_symbolic(__entry->reason, DEFINE_DROP_REASON(FN2, FNe2)) :
+			__print_symbolic(__entry->reason, DEFINE_RST_REASON(FN1, FNe1)))
 );
 
+#undef FN1
+#undef FNe1
+
+#undef FN2
+#undef FNe2
+
 /*
  * tcp event with arguments sk
  *
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1ae2716f0c34..9c52a4a74842 100644
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
index 18fbbad2028a..d5a7ecfcc1b3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3608,7 +3608,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority, int reason)
 	/* skb of trace_tcp_send_reset() keeps the skb that caused RST,
 	 * skb here is different to the troublesome skb, so use NULL
 	 */
-	trace_tcp_send_reset(sk, NULL);
+	trace_tcp_send_reset(sk, NULL, SK_RST_REASON_NOT_SPECIFIED);
 }
 
 /* Send a crossed SYN-ACK during socket establishment.
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 6889ea70c760..3c995eff6e52 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1131,7 +1131,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 			label = ip6_flowlabel(ipv6h);
 	}
 
-	trace_tcp_send_reset(sk, skb);
+	trace_tcp_send_reset(sk, skb, reason);
 
 	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
 			     ipv6_get_dsfield(ipv6h), label, priority, txhash,
-- 
2.37.3

