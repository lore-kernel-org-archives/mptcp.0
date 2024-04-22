Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B868462
	for <mptcp@lists.linux.dev>; Mon, 22 Apr 2024 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713754897; cv=none; b=aU4MPXOTwtj3L54JCl3sYn6OSV/9XkGMlwgd1ruccx0rPCyTRedeogJXFm3aDgVt9Zz3xhGV08UvS29fnwkOCpgzy0SQMHfZ/vCGbjw7RXJ/4z6eze2F4zS5IBcVk3Pg+9NjFNLoa1QnzVSQekGbu5LGLCdV/uEISthCYWKV2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713754897; c=relaxed/simple;
	bh=k0ERIGBUgeH1hzUQytdBB0A2E1f9gLeaMQ8795U1+Qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NAWvdFuZ9P7m0coQKon6Gay/El2Yb63MDsmfxo9tDlaPMx6wB0ymvNqNCQdILf2u4OVM3afXyOt41gi/GsyL/Nwyh4CGaTo8XNpduJzRyJd6oQqeEqZ2KqYfQ+dJbHwmhcHNSFAqf7c65SFSHi9DJ0Zhs0gH8+T7CcL9BRyNn5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca1fUUXt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca1fUUXt"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e40042c13eso28141975ad.2
        for <mptcp@lists.linux.dev>; Sun, 21 Apr 2024 20:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713754895; x=1714359695; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCngxkU1s9o07re7lCIfglS+wHbbPf9d21EG5EVN+Mc=;
        b=ca1fUUXt87Yh3Feih5iv169x/8KrmYUnBsOyrrd26Aw8w4tRnyyVhs9JE+a8XdFJ8F
         Tlw9r7oSHP9FlhsOMKY5xFK4kxUzD0VdAw077x5FWY1ju0C2C0h56QRCjzXMEYeYGsgE
         HOWYTTA+tBQYUIkKmuiDlH3ysR+H+tvAvAu4ZfCK9BqzdvJUf2ap7Qdh/+Qt5to7OmvM
         UiA5CfxD0QRCxzV+OtAjm7HLkvfxCIKae31jVCitvIRxKRhPjRF3CsdAPOHMRsBeZkkc
         ANLUZuOr3sZ5s+DNInjSgLss/U1Ekywe9L6pb4vuUCIal9+eIUYOaMdXUnBrqHaR0Uak
         spbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713754895; x=1714359695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCngxkU1s9o07re7lCIfglS+wHbbPf9d21EG5EVN+Mc=;
        b=iq+W0sjn0AaPprsr9jWB+BIjHpR9Z5oXb6MFfAEfcikWvZRdz7D1HDlU+IAzoK+4+F
         6z+q83whlYncXoSL4wpwBtmycGHOrR4ITul1dLxhbGdzKomX+5fUeOByP3aYum4n3MG6
         efnlYzho1hRafhhqLijlhIpFxiqZGBevcFFaaxv6GjZrjwU49VBosmXoNmwIWrAzrtKQ
         ER8jKMg6/orLTKSGX2wSF425bZ8gP7QexTwqx2vF8q2ijeTHp/iLkmiPsO0REkXANy71
         /PVJTDCUN6gdSB8EYdrL/3QFrIdebbR5KXYi5/UdpYTh7rdKQAZ6ikhQ6+AG49CYpy6/
         bO0g==
X-Gm-Message-State: AOJu0YwoQZ281N5GIVafR/xnCxG8dfN3nXoqQ2woexKGDDO9xJXGdYJq
	j1VpaknKMy5iQ/VcAB/JEmkle5iiDU6b49EvwS9KOL1Shl8UPxEt
X-Google-Smtp-Source: AGHT+IHFrBQ6LpYbYQDtrmuEM6FLFdib/x3xhL+60q54S/e5KhAUcWqxvXJEMLq5A42vH4XJeJ/GXA==
X-Received: by 2002:a17:902:f547:b0:1e7:d482:9e09 with SMTP id h7-20020a170902f54700b001e7d4829e09mr9853379plf.7.1713754895401;
        Sun, 21 Apr 2024 20:01:35 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d60500b001e421f98ebdsm6966009plp.280.2024.04.21.20.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:01:34 -0700 (PDT)
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
Subject: [PATCH net-next v7 4/7] tcp: support rstreason for passive reset
Date: Mon, 22 Apr 2024 11:01:06 +0800
Message-Id: <20240422030109.12891-5-kerneljasonxing@gmail.com>
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

Reuse the dropreason logic to show the exact reason of tcp reset,
so we can finally display the corresponding item in enum sk_reset_reason
instead of reinventing new reset reasons. This patch replaces all
the prior NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_ipv4.c | 9 +++++----
 net/ipv6/tcp_ipv6.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 418d11902fa7..06f8a24801b2 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1936,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v4_send_reset(rsk, skb, convert_dropreason(reason));
 discard:
 	kfree_skb_reason(skb, reason);
 	/* Be careful here. If this function gets more complicated and
@@ -2278,7 +2278,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v4_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v4_send_reset(nsk, skb,
+						  convert_dropreason(drop_reason));
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -2357,7 +2358,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(NULL, skb, convert_dropreason(drop_reason));
 	}
 
 discard_it:
@@ -2409,7 +2410,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(sk, skb, convert_dropreason(drop_reason));
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 017f6293b5f4..d8c74e90698b 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1680,7 +1680,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v6_send_reset(sk, skb, convert_dropreason(reason));
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
@@ -1865,7 +1865,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v6_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v6_send_reset(nsk, skb,
+						  convert_dropreason(drop_reason));
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -1942,7 +1943,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(NULL, skb, convert_dropreason(drop_reason));
 	}
 
 discard_it:
@@ -1998,7 +1999,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(sk, skb, convert_dropreason(drop_reason));
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:
-- 
2.37.3

