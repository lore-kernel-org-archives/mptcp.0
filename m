Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE365810C
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215290; cv=none; b=FHL0UGwoqRpC/hn1uIBSz3iF/GP3DEDzw/LbLOAtJKGql3waxjqFL4CLlcrt2Q19V5smmwlcgkqDoLv3OKtnzjLx9elw4WyGXbAhc1ySeJ+qHbaO0Np4WJKpRKfqPadOZheJnqdDWTVu4saqza7MwTsMpkjV2hpj0pKsEVEQoto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215290; c=relaxed/simple;
	bh=XwQdJ1YaaAMtdXN9npqhQhlx7+lFvpeEOH+8E1BGeKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jF4e6b/xwxRfoXCdX6cEb/ooSvulY3A22ofwg2azfXOVDcJRDlTCM1woap7i08tF7KfUkd35EYUA8Lr3salTk1/jEXBguTX8HP+WunfAcILxwBdT3f6Kowo/mvn7Apk6/XhuUFcnOccSFuFc6CpGUtHnFP0x78efS1uh7Lw5W2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BemOKF8R; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BemOKF8R"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso264765b3a.2
        for <mptcp@lists.linux.dev>; Thu, 04 Apr 2024 00:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712215288; x=1712820088; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bItfs35jBJwYsVcRlz2Ak3QufL1GUraVsJFxf8+lDvM=;
        b=BemOKF8Ri1iSV5SXqpAYvjkY70BdhoQBuILvRJtA6iXjqt+AI6kqU5nqogCD6Nuc8W
         8ffijvwXRIiy6wmReqFh7hgmPlfa1Md04YhHgx0fwWzjCQl1JgYTqCf3ClqC+Z8MhPUt
         qW7iP5JPUG9g2sm1yhEy84gW0aFFlL9Pq3xERsT+Dux9L5VJ4QocemCIQc6x7loH6RyT
         fHJBx52yYFEtHWDmUde0XW/h6S7epeOMd9DFZRGCI911BJTn7utzSXQ/n2bJV+e97Fpt
         3mGBU55KHRQDez92iaX55NyG6MmpoI2GcBWHbnUbBIAnIwtcDoFdnCHLK69wB2jW42x9
         yIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215288; x=1712820088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bItfs35jBJwYsVcRlz2Ak3QufL1GUraVsJFxf8+lDvM=;
        b=rKnTqe/C7ZYb2j14gU7z1ouJZFjLzpzOBQIdFrthCBlDKOvhcBVzltRzFb7HHkZ+Xr
         z26kStvdQCFp8NrwMlWnVpvPSy7jkBVS3ctJgU2zx8kehLunifuRKA3V/FKq3oE2gCGw
         oW92lP5Wqd8yL1j6BKnleNPQZgcCSwrmk7kjpiIDKeWX4jtC9UJzQRZt18NyKjTe8NH3
         cBfuJMJ1gyl7w1KIxqNdGlhCzUJGFMUSk9DEjNkVS72DBGYj1szOlirY6ArJWyY51V72
         XLT9n2SmRTq1O67MIKkBpwdl43gkP/dbAgJ0ZCcDzclPrSmH5xo5xmItPQbNRtpFRXzR
         Tr/g==
X-Gm-Message-State: AOJu0YxALy6N3gj7ggdCMAJNMAgByQU4B+cbkEJbAIo7Z3ffmoYWQApM
	c+n5CCfKKDY0pqujB/F5gXYmGLQIKFs9fmq8CylYn6sbDl2u+8cK
X-Google-Smtp-Source: AGHT+IE21WwNiERpBlyk4bHmJSIsioNkuIjxFf5RmkSh4ep+Z1Hr7F/8youhW3d0v7pmPe+U1uTOIw==
X-Received: by 2002:a05:6a20:c70e:b0:1a3:6474:3953 with SMTP id hi14-20020a056a20c70e00b001a364743953mr1961611pzb.35.1712215288667;
        Thu, 04 Apr 2024 00:21:28 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709029a8200b001db5b39635dsm14606399plp.277.2024.04.04.00.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:21:28 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/6] tcp: support rstreason for passive reset
Date: Thu,  4 Apr 2024 15:20:45 +0800
Message-Id: <20240404072047.11490-5-kerneljasonxing@gmail.com>
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

Reuse the dropreason logic to show the exact reason of tcp reset,
so we don't need to implement those duplicated reset reasons.
This patch replaces all the prior NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_ipv4.c | 8 ++++----
 net/ipv6/tcp_ipv6.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d8d98db8f58e..1ae2716f0c34 100644
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

