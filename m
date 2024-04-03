Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D005F5B202
	for <mptcp@lists.linux.dev>; Wed,  3 Apr 2024 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129539; cv=none; b=P7IKsHZwMTAy+9R41YUopB1peoOhNgwP+WOLBWkn7Krg6ENc9/JcQQ7jnYfQZ16ijKzLQaMz2Zw0Oh25z1uLCGwDqkue0dtmJzWgh0JprFoWk4LKm/8LoijRxO9xnVfgynOj1OKIRhEPOgvV1CIrzHCRLJYETr6JZVKf2/i9jwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129539; c=relaxed/simple;
	bh=n7mrUdrhn4OJF0re698qBkkJaVCY1HgrfL8S+je5f+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oAFMgvgV5MQ/s6a1bfIadlxorg3xm6JjgS3tNhKXzO5m+cKlhyucsRAqEhAnZXra8gAK/MW6G2Qw/ksH0CN5q/oMr1BLdLJLEDSTQ8SbB/MnnX+v9DgdtS9yrEPePg/od16DYEPWfdMD2zVAplkY2Yc0+v4CN7xnAftcKSvSHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQW7YFus; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQW7YFus"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e0b889901bso49054025ad.1
        for <mptcp@lists.linux.dev>; Wed, 03 Apr 2024 00:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712129537; x=1712734337; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9uGKAI5XQUv0MDRE0H+uT31tilfETu4TMRx0dL+C28=;
        b=CQW7YFusY8FiwutkXgHbw8+rXceLbl7d+IErVHuKZcrrvZE6FgxeqB3112pMwgO4Pu
         6XCwhKvPDyM6woeVgGBms82kPhTes+fq83IZNN3lnZw+KHXADGyEKAzHjqyoDfsDFmz3
         DVY8kWmjIv7QZNuwL2or4mXI4IH1J4PJCyvxnKmBtfj4lNZ52OzqQhGRQ6ZXCYosE9gf
         MwxnnRQ+uwiq3hdj8A+TemBIfEn782h0OxNlquitV66E6OetqXSEU7uYSBSzNtl3C4VD
         QCH0vT7jouTXq0CDyCg0jqIgXW30eoa+zKFXgMApJ3OSlRwGBtSQb9UZhY+EgB5XAIMa
         TtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712129537; x=1712734337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9uGKAI5XQUv0MDRE0H+uT31tilfETu4TMRx0dL+C28=;
        b=M9DdO4pv8x54aY1+xT9CHFhhY6sdCzyXE4JJzm6TxPWipZf/L4aBu69V36lWbiRGB7
         a8r/pn7ldMC+C4cCRuw9E20EcJ0W7SU3mF8y2NwVCnbcc1BAmEuUrA2OwzlyH+K7ElgE
         hv7QGYZFHtG9Z/6r2Ddk2Z+6ePnqVewRmc1QhWM+YjjO1oFUmYaxjbFoa1OWp4seboWy
         nUtu8+mJ1IaLRLnCD09X94PUAL4Xu5mHaV6LeLHyLhvPwXY+gvj8dyOCX2hMqjSD1EYc
         xq0x4cRCVNx5YJPk9uq9byhvvfkbHkeLXQWG7fd4UAkYRHVKPycl2SNJiH1rJ+mCs9gh
         ON/w==
X-Gm-Message-State: AOJu0YwFcSM3leTjQpUbmaGXZtKQxwcGubyPShW+4Yqgz1pWv8HM7HqK
	rodnshqNZB302L/f5XS5LoZQ5blMIGT3O2saPzHy+DRDK1o15P7h
X-Google-Smtp-Source: AGHT+IGV37Qy+b3PoF90Ff6nKn8urG405LhGYHGsqq0jy+BkpFP/F1MISYuewYVPqZsAIpgXGmNRxw==
X-Received: by 2002:a17:902:db0e:b0:1e0:fdc6:e4d3 with SMTP id m14-20020a170902db0e00b001e0fdc6e4d3mr14898970plx.49.1712129537282;
        Wed, 03 Apr 2024 00:32:17 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d48200b001e03b2f7ab1sm12563067plg.92.2024.04.03.00.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:32:16 -0700 (PDT)
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
Subject: [PATCH net-next 4/6] tcp: support rstreason for passive reset
Date: Wed,  3 Apr 2024 15:31:42 +0800
Message-Id: <20240403073144.35036-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240403073144.35036-1-kerneljasonxing@gmail.com>
References: <20240403073144.35036-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Reuse the dropreason logic to show the exact reason of tcp reset,
so we don't need to implement those duplicated reset reasons.
This patch replaces all the prior NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_ipv4.c | 8 ++++----
 net/ipv6/tcp_ipv6.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1c8248abe37a..35b0f3bbf596 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1935,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v4_send_reset(rsk, skb, reason);
 discard:
 	kfree_skb_reason(skb, reason);
 	/* Be careful here. If this function gets more complicated and
@@ -2280,7 +2280,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v4_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v4_send_reset(nsk, skb, drop_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -2358,7 +2358,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(NULL, skb, drop_reason);
 	}
 
 discard_it:
@@ -2409,7 +2409,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(sk, skb, drop_reason);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index f143b658fb71..cfcfa2626899 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1678,7 +1678,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v6_send_reset(sk, skb, reason);
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
@@ -1864,7 +1864,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v6_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v6_send_reset(nsk, skb, drop_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -1940,7 +1940,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(NULL, skb, drop_reason);
 	}
 
 discard_it:
@@ -1995,7 +1995,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(sk, skb, drop_reason);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:
-- 
2.37.3

