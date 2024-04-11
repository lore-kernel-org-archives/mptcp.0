Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372F214AD36
	for <mptcp@lists.linux.dev>; Thu, 11 Apr 2024 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836631; cv=none; b=r+fNb68ObMiNg5/PyT2VUgNMVutIiOrsuS3Zj1XjfAFmCXG5rSgdaFcyeshQCcnBFmrGdZMfQoWiePnKtHn3uZV25TyHpmfJv1MEF52QGa+n6P++jpFlV/8omeIuWsybujSe6fnzVaYc7kBiUQ93ejIXWtsRUYP/Jqv14EKVJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836631; c=relaxed/simple;
	bh=YYAstX7ppQWMuzdq68g4kGdGP/fDG5Hqbg/nseaU7LQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C+nu6Iq17+pGkvPk4Dm5o3np6bT/FjTpjE7/rZv7oiMcl+xNEtxE2J9I9O4CzOMvgJatc/ZM4hw2brsVVt46XX7BOyG96fkujkxuvOy/7KJS6c3mnmZUrRzE7nAsMklCCLIBxU6VKLLwNyGE/TCAX4YrXaagzruWmsx4gE3ZSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCP26k/a; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCP26k/a"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3ca546d40so47173465ad.3
        for <mptcp@lists.linux.dev>; Thu, 11 Apr 2024 04:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712836629; x=1713441429; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzPPT37X9CCukMbb90HnYaZ5ZonWT01Ndh8y/YWgYrg=;
        b=jCP26k/aKNx0PCZovfjwKMVbSpiixxTjggr9IsyLE4uv1TvsjzPmAPwOSv8KJ3zqOb
         NhfodUccFLWOF/uxgKxdOJVVCOEBYYXuXmKcKvVovcfsoy8Pi/kP66vb44PC2lns2EsE
         Yq2izaLY5uYptVCiJIthFID6KYahe6jgu6SfaM+Bx+ef5DXuZpnE7GoOMnXxavs0y7ES
         Kp/ROMVlT9+KLAAQkE1L4cH280gFswuiKMbmBixdCidelhiOm0O5ZotasqP2xfFQj22N
         g0QLjru0NVfuNFUnrR/UJls9J0YJhUJA9/0maA08pJM0StGpEd9x44Gw+2vvXafH8r2J
         VZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712836629; x=1713441429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzPPT37X9CCukMbb90HnYaZ5ZonWT01Ndh8y/YWgYrg=;
        b=Fq3hGF0J2jzw1El0r28cmgZ+LZwarX7EHe3ly/qSN8AzHB33L4GblPf+DZPeiqXMvT
         QRb8dpmol1rRdxyrJB6IakO3sJNjhKazedfcWojyEfw4Tmloo2wxhR8oh6bHIhe2EbaZ
         lASzltLduL+nNwSRXEhGgy/lVbN6bS7wF+RpYN2PSGbcwFXjEWXWPxydqZ0cknbKjc3c
         MHvwC3YFnt0YlNRym1GGPCirwZ+PgbwOlUJPjrPKYnfVKCGgLiNOy9P6JwlzfeAqKDxb
         eD5UWxsIAPp9q4sB6vwjM/n1ePeqElZWp1ZEejB+k0ApGHZoj4vB79UYyG8hhqVqSijH
         /YNA==
X-Gm-Message-State: AOJu0YxWVyZzam5BCfgkQuo+extSND3NKHhzbm/Pptow+fzL/swRs/MO
	rusihjKxweT+hXwSyXEKZL1IIC9xuoG33lroZ/ZVo1qIwt77jAR3/glyfA==
X-Google-Smtp-Source: AGHT+IHka4LqGg39XwLYMiisy6zHtStylD20DZX/IFHR0ajxOiOQ/ecEmfO2dan9iz62T8YrNr1nuw==
X-Received: by 2002:a17:903:1105:b0:1e2:9ddc:f72d with SMTP id n5-20020a170903110500b001e29ddcf72dmr6191779plh.26.1712836629380;
        Thu, 11 Apr 2024 04:57:09 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e5cb00b001e20587b552sm1011840plf.163.2024.04.11.04.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 04:57:08 -0700 (PDT)
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
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 4/6] tcp: support rstreason for passive reset
Date: Thu, 11 Apr 2024 19:56:28 +0800
Message-Id: <20240411115630.38420-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240411115630.38420-1-kerneljasonxing@gmail.com>
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
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
index 441134aebc51..863397c2a47b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1935,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
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
@@ -2356,7 +2356,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(NULL, skb, (u32)drop_reason);
 	}
 
 discard_it:
@@ -2407,7 +2407,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(sk, skb, (u32)drop_reason);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 6cad32430a12..ba9d9ceb7e89 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1678,7 +1678,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v6_send_reset(sk, skb, (u32)reason);
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
@@ -1864,7 +1864,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v6_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v6_send_reset(nsk, skb, (u32)drop_reason);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -1940,7 +1940,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(NULL, skb, (u32)drop_reason);
 	}
 
 discard_it:
@@ -1995,7 +1995,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
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

