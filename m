Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6397C161330
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447198; cv=none; b=Y62C2OQL47xr1/Y5ly/ieXINn2BqI6GyThZ99+pIfE9aEvaPKHOR7o8SDB6yfZ4irkhRDyzP45MQPV4IxCazYcEPM25JjJgTNpdQRdueulKt9N4fIBiUT16/r4a916CgsfCsxKTVp3S6EYP2HEOmwTtL8Y/JfhtyW1XlBh/adpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447198; c=relaxed/simple;
	bh=Sg52tjwZu02VauEN2wifSM/4N8k/GSX65W7rSwbBSOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ARSXUiv920u8IeL9B1Wxj0pCHVfzzqIjSEifNvIAMxKSDpQhwFRsRQ+u2xSfRtxvq+oOdM03OgF2J/qLTKNzyIpeCY4tB2Dth9lUD6KujiZ9d3ox8HWWlVC0i/LVSjM8uCmgf0qzkwgyWoKTVMgaSs57be6yxgK+sEBhSB0bvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9SgRaBM; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9SgRaBM"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a3095907ffso681987a91.0
        for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 06:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447197; x=1714051997; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZaHHJogYh/uBF5yMrMV9lgM3yab7Wqg84yx5am8bms=;
        b=K9SgRaBMKvLzSPM+scivBCvzMXYmiXNXW51nRHjg8iPsuimbyNxkbzLqGRmxOHnAIo
         z/tpijAT5CAXirF4B1AwVnM/H7VpKreS2fRujKiBuSlBDSQTvBo+x/CRVRTpRzfadoX9
         YaYwtcCoWPdUguDqVPPOWdCpocHyxVcFZHFzkYcZGjJmsBLu6aUDLaKknglYc79cjbWL
         KepZt7cUyz9A7eKk8WkSgnEakS15CVUAr98OHGoL1HHy1FsGfk7QKY4BYBYGP8Asl46p
         elBGNZtUg54wI03Iu5miNnguaoGIcv4HeV8/3vaoGr3FwrbZJa3t4YMWNeIbGfgFu9Nr
         dhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447197; x=1714051997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZaHHJogYh/uBF5yMrMV9lgM3yab7Wqg84yx5am8bms=;
        b=W9emlYqAQTPFDtIDj90tD4pXSr6ooekcV8UpH0LU35ILYfOCCi/YDOGVVjW6S13r4l
         CkY2pTsbtejbmlvwOPoE06KFHgWJF1mjlSjz20QLvnr73m1BQipgKR5l8t0FhsU02NSw
         fqM6lXpTcDMcjr6c9ZM6DvCitlmrVDWoTO7PYrLyaLU0NuBwmv0W7h8M9GX8YfqXzYfb
         I6W2Fr8B3wQYB3wRVKVMnef7RAQNMMO0T3AeUbfreQgSB2jYyLd8e2UcPQsuIxAk/azl
         y5+pWTQek0f9A2qlIlsK0v88CvJouo3ADFQ/FHSWq5gMlsjXLo73mOvSlJ4t/zJ2a6DD
         NESA==
X-Gm-Message-State: AOJu0YyJ+DqW3hgtQqlD0sstQzUazL6Ie+DonKNqKntxziBihJ/2Wq9H
	ucFQd7PcRuZ/kBf5a+kOQPyvQPIOYtb00hJxRMdE7FjnxucjmP8/
X-Google-Smtp-Source: AGHT+IEuAZnH0smVDKADqkJRuOhN3hMKR9yVhk1bcN0plKrjvE77z3Xj1xbtCdt6bOC3JKiVm+QhWg==
X-Received: by 2002:a17:90b:1889:b0:2a2:4192:dfc1 with SMTP id mn9-20020a17090b188900b002a24192dfc1mr2685882pjb.14.1713447196760;
        Thu, 18 Apr 2024 06:33:16 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id bt19-20020a17090af01300b002a2b06cbe46sm1448819pjb.22.2024.04.18.06.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:33:16 -0700 (PDT)
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
Subject: [PATCH net-next v6 4/7] tcp: support rstreason for passive reset
Date: Thu, 18 Apr 2024 21:32:45 +0800
Message-Id: <20240418133248.56378-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240418133248.56378-1-kerneljasonxing@gmail.com>
References: <20240418133248.56378-1-kerneljasonxing@gmail.com>
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
index 418d11902fa7..d78412cf8566 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1936,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v4_send_reset(rsk, skb, (u32)reason);
 discard:
 	kfree_skb_reason(skb, reason);
 	/* Be careful here. If this function gets more complicated and
@@ -2278,7 +2278,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v4_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v4_send_reset(nsk, skb, (u32)drop_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -2357,7 +2357,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(NULL, skb, (u32)drop_reason);
 	}
 
 discard_it:
@@ -2409,7 +2409,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(sk, skb, (u32)drop_reason);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 017f6293b5f4..c46095fb596c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1680,7 +1680,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v6_send_reset(sk, skb, (u32)reason);
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
@@ -1865,7 +1865,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v6_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v6_send_reset(nsk, skb, (u32)drop_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -1942,7 +1942,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(NULL, skb, (u32)drop_reason);
 	}
 
 discard_it:
@@ -1998,7 +1998,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(sk, skb, (u32)drop_reason);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:
-- 
2.37.3

