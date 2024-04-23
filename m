Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D647A5D
	for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856925; cv=none; b=j1Sioi/tYEk4nUg89JBKhACBr18ut5a+OOii4i808Y94Q7SWDyztk4wxL+vwMIMB2+1uq0VAo4lFFdbmqxx7Bfrw5OFFBShKauyXrTy6+h/NPPqQXOidwupeVo3CvYbwQURzsbRxIFI2oNA/4bf0gy6CzL9KmHjGVpFsAWcQIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856925; c=relaxed/simple;
	bh=v7U6oW3gDsie/i0ijCRs85/Eal6SYC2LrAnRuKhJdAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g0GFjKWouB3JTl2r3PVBbk4CCYGz7Y2GlajEPOLYu0IU/fLWKj8XB6e4uVqxfgDhij18m+/KVW9m9fG9uTfMFY/ojECiyt8fzhtQOY5h//swnD2mF+sXCEXzl4a5uI0Kgq9rjk01AiNf2U2cN0Ytd96V3sl+q+0bdcKwlE8y3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jh1AAD1F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh1AAD1F"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so50567285ad.1
        for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 00:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713856923; x=1714461723; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6IM3xStLyH2OezX5Q6f1JfXVKMrEKiHR6KKT+cuT2w=;
        b=Jh1AAD1Fwrd+OP+ctqNl6kp8cVpJJC4Os1OjaocdIWbN4Ka60pI1k60ugV3vmEgc9D
         sW7i9U6miUzksadmLeEYN2na8AjaJ+aj5jdStJ+HqB8WWybRL59nI/1u08HVQqIdeVq8
         O6c5d+UnKpWEAYTJJ3mjBA9V/iZm/Vw0OScigndiDGODw0Vu9Ks6A2wgG6ijFxX/PHk5
         1uiUymukaOEFVx4QgVqlAL2iZ1QZgXaZa+v8wtesP7w/Q1Ig9YdH7pHfba9N6Daw0x7X
         xHiwc6jqeJu87+nVTmyyzR1iQQNvuUYP7JDwTim4mGpgpPE4F11/9oo22+uBP16atd8T
         xfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856923; x=1714461723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6IM3xStLyH2OezX5Q6f1JfXVKMrEKiHR6KKT+cuT2w=;
        b=hS2ftEhiNS4r6BPJt96RCGVCpYDO2kdtkW/uTCTdGB/seJDvWK6hzXF7Ia1y39x4o6
         l3A4a2EhzMGFHfBDZa94tWm+TOURhMzGS9rMwuY1usVEcykU/gG3UVyKpzZOcOzqNRqN
         Y4P3J/acqAeL1MPf+UQcPGYDUoh0Kj5fDDEG+820DxQk0N1br9EcCq1PxeFLd1wyZAZ7
         v79r9c4wVi6BxRdFVbmHwQrsW4cpSGqNcq7My/5daNRO2mVHJRQ+AWfy9tJuzY7b0V20
         xRwgCw3i+lThez+PWsCvQ3Ki1ZUvhbBwKDzVubchxxqrrNZeQY5ps/FM2bxEd08IK1+j
         yjyw==
X-Gm-Message-State: AOJu0YymeBYmf/gnRDI+DIHCUTYod8IARPW8zYD6FS3AXf4xr6beLAum
	jE36fdo76z3qs2h++DAfu2OLkmnibpFhP0nvzzVZGcdFL1TXxRj7
X-Google-Smtp-Source: AGHT+IHoNxkdFLrxPGCKW/STKVaUNQvSi1kKswyzGQR0MI/GSOTUPLcJoxVbDzYnNQIyEloeXjVMRA==
X-Received: by 2002:a17:902:da84:b0:1e3:e1ff:2e79 with SMTP id j4-20020a170902da8400b001e3e1ff2e79mr16792847plx.45.1713856923506;
        Tue, 23 Apr 2024 00:22:03 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902c79300b001e0c956f0dcsm9330114pla.213.2024.04.23.00.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:22:02 -0700 (PDT)
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
Subject: [PATCH net-next v8 4/7] tcp: support rstreason for passive reset
Date: Tue, 23 Apr 2024 15:21:34 +0800
Message-Id: <20240423072137.65168-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240423072137.65168-1-kerneljasonxing@gmail.com>
References: <20240423072137.65168-1-kerneljasonxing@gmail.com>
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

