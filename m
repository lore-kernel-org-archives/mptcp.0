Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6973314AD26
	for <mptcp@lists.linux.dev>; Thu, 11 Apr 2024 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836635; cv=none; b=CQ/repZYg5lLKqCc2uj73mRFT412QcJb65WGIWSKi/o5QrZ4X5mW7qovPHIGAmRw8vAZS61CrjASc+Oqs/Zw6QDPQWGNxHMUvGr5O36Mg4xRl34jDiUf1aIdPqiQBEwNyArGK8yfnFruNIPvvK81nYIgofzV1MkAgvbCGMjzOVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836635; c=relaxed/simple;
	bh=hWy3YGmkxWsTcp/zGL5RAIH6IGzWY2P3DpM0v8axmXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NTZV6ZSggUz+L2WbgopTVs8i248+claHP59zQk6/VTAnkd7jMyzTZG1AEkV8453hx8GNMsupv6/282XM+C8BoSNdC1WzIBGotZf6Ozl6mhpi/lDZYYuwZbjgqMUuTXrVENjfsIerrguyE7WxgQdvAD9RMEqhcgWbag6iv0ynXu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXbMcvDH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXbMcvDH"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e51398cc4eso12292455ad.2
        for <mptcp@lists.linux.dev>; Thu, 11 Apr 2024 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712836634; x=1713441434; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+ZpBqN9wkpehzV9bwSaxvgN0i8FpFSb8wa56tsf7uE=;
        b=EXbMcvDHYunXNACvG8W0n0S9p//mjia9a+ikifkTlL9XCgIfg1hzQX9s/OYJQANSHz
         RaTBKBO2Noo5/f4GlWtJ5pCuOoAEDdVjL1K8WzAquQ7fJv219mLf2iriTRMaXxnAcJJb
         KjgpQfcLO0ZshXamo7oLN4xu1dxl9WiT4vzBI4LRTePxLSGtV2nKoutRoHcySkaY+Ymz
         dX2xj4HJiJJ3IJV3qaczQR4zo6FK2zEbdE+fYXAqHeNFwEvUBBzyJtjnvwpO+PMfzA/U
         qpvr0eh50/AOmruyut1QhFKARskn9EpBT+PN98oj8zrUu0iyeRQsD6idkXRZb8dvbjDM
         EQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712836634; x=1713441434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+ZpBqN9wkpehzV9bwSaxvgN0i8FpFSb8wa56tsf7uE=;
        b=O3d+s+ICFAMAQwkJUP474bzPRtvQx/9ZZmGiybUOHg2oUu+JOGHlbS8MG1wYPNGoDh
         yVNUpP0htx2YAq0MobH+V8jP8ZSTUVWgJowco5di0HEEOqmElM8emG4y0JypI7CQsqtH
         U5TOobFcuAS6MhKpnuX+thTRyXP0BJQLxGkGewfjv/CDPGtHxFlpLcY9T0ehmozx/t1C
         1RRPxpi7VXIvb1fRBM/B/eB3gOIUD4i7TX0aW1mWJJANyWi4av4REQQtw+48Xrz6YEC5
         qkKxpAf2gBwwcpU1C8mYeisZXF19ct7aLWxa1xbUO7Z6aXJRFZVBPd5sN91vE6giuvDq
         pOPw==
X-Gm-Message-State: AOJu0Yz172Tm+lNP/anWZKQj0Bohpl0Z/nLM7HgmyWwZQNotmQ01gB+b
	sGRXmbgj7F9bpMQJRLXBR4nz0/5eRsg414Xb8HWV+YOUkmYCgbZt
X-Google-Smtp-Source: AGHT+IE0GsoNBivZ1/ktea9PqQlxiMwaMWZZIv74Staw/lpFZm33RXkHsdNOCFeaAdnOkZ2h5KSZlQ==
X-Received: by 2002:a17:903:11cd:b0:1e4:b1c7:9a7a with SMTP id q13-20020a17090311cd00b001e4b1c79a7amr7510161plh.22.1712836633768;
        Thu, 11 Apr 2024 04:57:13 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e5cb00b001e20587b552sm1011840plf.163.2024.04.11.04.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 04:57:13 -0700 (PDT)
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
Subject: [PATCH net-next v4 5/6] mptcp: support rstreason for passive reset
Date: Thu, 11 Apr 2024 19:56:29 +0800
Message-Id: <20240411115630.38420-6-kerneljasonxing@gmail.com>
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

It relys on what reset options in the skb are as rfc8684 says. Reusing
this logic can save us much energy. This patch replaces most of the prior
NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/mptcp/subflow.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ba0a252c113f..25eaad94cb79 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -308,8 +308,12 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
-		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+		enum sk_rst_reason reason = convert_mptcp_reason(mpext->reset_reason);
+
+		tcp_request_sock_ops.send_reset(sk, skb, reason);
+	}
 	return NULL;
 }
 
@@ -375,8 +379,12 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
-		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+		enum sk_rst_reason reason = convert_mptcp_reason(mpext->reset_reason);
+
+		tcp6_request_sock_ops.send_reset(sk, skb, reason);
+	}
 	return NULL;
 }
 #endif
@@ -783,6 +791,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	bool fallback, fallback_is_fatal;
 	struct mptcp_sock *owner;
 	struct sock *child;
+	enum sk_rst_reason reason;
 
 	pr_debug("listener=%p, req=%p, conn=%p", listener, req, listener->conn);
 
@@ -911,7 +920,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	tcp_rsk(req)->drop_req = true;
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-	req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	reason = convert_mptcp_reason(mptcp_get_ext(skb)->reset_reason);
+	req->rsk_ops->send_reset(sk, skb, reason);
 
 	/* The last child reference will be released by the caller */
 	return child;
-- 
2.37.3

