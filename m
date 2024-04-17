Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D40312B16A
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343929; cv=none; b=go6/Zy9aXM0jiugYgsHCpaS7B8QdARLpIdCQgj8dAh0u8NawvAXos9FQ7E0MQerT2cLcRogQJCNeV6vbMhMxrn0OLp/OhJdWqEudoYlv51OhkWam81SZR1RVvGm13a8doaLysbyA0Ox0/S0zvcAGG64gPl65JUsuvuDwL4YRpLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343929; c=relaxed/simple;
	bh=Sg52tjwZu02VauEN2wifSM/4N8k/GSX65W7rSwbBSOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MViBzrKgDe/2IhEDCr7hiFnenqtHD0WT8hQ3g7Fccw/4sQ4TRRRTOr8D9xDc3lM6VJFx5Tu/8ybUsFe16RgTCWC0bRIbruuJPY9hlqZNBcs8HAwTvsoOJ0w7vA8ARa5qh7bQP7oznkYmbrI4e4o7TIjLroZZlbBO4WehkwWxYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cjd4PqWo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cjd4PqWo"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3c9300c65so46454955ad.0
        for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 01:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713343928; x=1713948728; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZaHHJogYh/uBF5yMrMV9lgM3yab7Wqg84yx5am8bms=;
        b=Cjd4PqWoPHK+/geeHa3snPEo+HqI1uoVkGlXj+WJ4oTFRHWVqzC6OP4akO08NJK8rS
         0uPr6DlCVK9dQpMN8S+14MXOE02Hura7qY7Ck0gB4Ni1rG62C2tnLNkbEx28QtPhTFnH
         lws9tSLYa3gDrsnstrihZYRL08+3GPLRASaeA6YciQ0J+G2frlw5csU/AGTT+A+oOH2K
         6Fl/rX/cdSXIRVEtDrvmXTFNW4AoNGRL0ODk1SuUO0nER1eBdvCoqCnqgFyMmuxtPxkE
         gDSzsX66WiEMnBpvAfkS6B3ZQv1fbwk7TusNBj5vV+q7SmAy+FWTtKhkq+HV0AEIVL/4
         krAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343928; x=1713948728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZaHHJogYh/uBF5yMrMV9lgM3yab7Wqg84yx5am8bms=;
        b=C8sddGBp/jk2OHE2/nGP9E+CWy2cwOBls59iwSBTHwpQ39dUu0R2Xu0xmLkMyDDDaH
         GTVevJv/9lfChSYrN9Vl96fDttBlqQCb+6bKJ34pvZ10PdB8xelHc26pViLwC8S5KrPo
         oH8vQpvTqz76SQYCWgMJQNhIXKRwwd3PARJcIFtjQ78lMT7xfSuHBJMQcJ5BMXbhG0dV
         QDEnaEPGDcy7VkXDD5kNF3CDq4QTFOvYux0NTICu1a7rrko+Q8YhnHg2oMwG3sX8kigy
         bDPbTlsquXaNYFDCPo4q3baysTZ1V4m0nmmANMEdm7LOzgTZIdSZjpyjukh9WFupZ16r
         YC2w==
X-Gm-Message-State: AOJu0Yz6PyOvhXJEFxEg411U2umy69rkaZR6622eebdCfD1PTkUIb8Qc
	56jqd6yjERI+4/QoR9R6R7NXDRn1lTjA3y2r079o/iz8q4Kt/Muo
X-Google-Smtp-Source: AGHT+IHfbJQQkqEXUGIoWQvJvxqOwXmwLTmClrFzKOUjG7cLUz0s49LjxNYfzdPEy1V1b34gSVrENQ==
X-Received: by 2002:a17:902:f545:b0:1e3:d4a2:387e with SMTP id h5-20020a170902f54500b001e3d4a2387emr15934235plf.1.1713343927736;
        Wed, 17 Apr 2024 01:52:07 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b001e452f47ba1sm11348611pli.173.2024.04.17.01.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:52:07 -0700 (PDT)
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
Date: Wed, 17 Apr 2024 16:51:40 +0800
Message-Id: <20240417085143.69578-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240417085143.69578-1-kerneljasonxing@gmail.com>
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
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

