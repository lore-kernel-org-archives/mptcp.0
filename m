Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD325339A
	for <mptcp@lists.linux.dev>; Tue,  9 Apr 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657433; cv=none; b=aE/hQ8sljyAVvmhEMw/5Sg1PS9EvS4ksZVDVN5TWptyJ2fAol3NVJRf2tZxdLRkLuvPaed8YxnPuL7+lnxc4laMWi7sozRpiIGjYU3TNhxsLP1AZApWNiR23cMvr0L3BGOx29f3FzPgDNZfFu1qm91RsbgMKx4qhADq7QXvyMwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657433; c=relaxed/simple;
	bh=fnNRKmJnrR34kKc3z1CwBEQVAqIXILit5SjBo6YWcyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AERG+l6pY7te4qlLSlHOXL+zomMyyc/mNbrXQrqHUdKA+7zHIyIhKEedZ02TTSA/oTUWwZl9piA2vGLvr9ZYeaZ9ArY1GNNK3EOw45JonaJsqsZTMc8I5nLFfpRwL9O//RsTrAumWwwb5c3dotin9WbwMAD4S7T/2771jqZED7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdNr/3Vp; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdNr/3Vp"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecf3943040so3614938b3a.0
        for <mptcp@lists.linux.dev>; Tue, 09 Apr 2024 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657431; x=1713262231; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8sgb1tDatwNXV1+CdBq8b0fZ/5liYZefyIkuO0GI+8=;
        b=VdNr/3VpNobpP/DJF9eBH31M+iHt/3NJIDItJ/XYknQYFDAnom25Akx7vlbar9nRNm
         lG0APOe4D7Hw9nsrsgmGVu4BHGniC/5FXWxxtMsM/wJhveXzbr2cgjnDRSYqteVFmV46
         ANcWt7xjzgefTV/vqU0C/HZ2rrqquyfp6rdgqbBit4xlQUD8qAshs8EIFSEUDMCfofWk
         iOSAC5Z7otlC/kfmGX9yPCJeHYKsZix2cTv1Iy/mcROrZ/5VmWIJboESe1tPKwZuF8Bq
         lNZMGTv3FABe2KmqEHM9Vx/Hq0GBgCwZX9jlAtG4uKaRtCBr4QWe5ws7OwprQ92e1N/Y
         4jQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657431; x=1713262231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8sgb1tDatwNXV1+CdBq8b0fZ/5liYZefyIkuO0GI+8=;
        b=g03MiBD8zUIZ8+HcNODPKGb1q142vV44lVDXgZDFT66GRGv/SbCjfrRRHmVd7imaS3
         S+j3XYRg7u6ozbYBIMQ7r8ea5s5kf07nh//GiUW1HtAbBmsOyOLS1VXomrTgF4HgZkXP
         ns/tZmpE+ETs6eq3DdUNg4Y3wFvdT6VH8RToXafYuFExt84hoin9d28G6gCvq6AKAu6w
         7ofE/W89tO4XZq70c774tGCs3p+5XJD1GfIxDWRhmxMH/QQiVNHqBpnWhDHnCJAwEq2C
         vdzPT8yUa3y3xZiHOvFxNVhaDrac4UVZxmOaNhae8UvvWYO+HFxEpN5bFY3cP1khZNhn
         7hzw==
X-Gm-Message-State: AOJu0Yx+0ND/1NvC13WTejt72UPYYZiYmGLKYGC7mDdnfBpaRqijsZz8
	WWa9FtNSIpbWSN3Mh1F6N7IeL9Ssb7UCUpHL6MZ7RHV1tk1ihHgj
X-Google-Smtp-Source: AGHT+IF8oO9jcgQhJsIeCO/PBSwIMNI6Dx+dhCnqdC1k6DGvxwvZNsBpwSqfg85Ihj6o+CQnYRIK9g==
X-Received: by 2002:a05:6a00:3c8e:b0:6ea:c4e7:26aa with SMTP id lm14-20020a056a003c8e00b006eac4e726aamr13121693pfb.13.1712657431215;
        Tue, 09 Apr 2024 03:10:31 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.26.66])
        by smtp.gmail.com with ESMTPSA id fn12-20020a056a002fcc00b006e5597994c8sm7959130pfb.5.2024.04.09.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:10:30 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 4/6] tcp: support rstreason for passive reset
Date: Tue,  9 Apr 2024 18:09:32 +0800
Message-Id: <20240409100934.37725-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240409100934.37725-1-kerneljasonxing@gmail.com>
References: <20240409100934.37725-1-kerneljasonxing@gmail.com>
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
index 21fa69445f7a..03c5af9decbf 100644
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
@@ -2278,7 +2278,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v4_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v4_send_reset(nsk, skb, drop_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -2356,7 +2356,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(NULL, skb, drop_reason);
 	}
 
 discard_it:
@@ -2407,7 +2407,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(sk, skb, drop_reason);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7e591521b193..6889ea70c760 100644
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

