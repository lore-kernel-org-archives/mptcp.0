Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E05339A
	for <mptcp@lists.linux.dev>; Tue,  9 Apr 2024 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657439; cv=none; b=MRizeLf9bjRiFq+lswnOZD831Lk0ngE43PSB3jsDAFjSOz2HA8Tgpi7bn9Xz9AMPTz46PEP+LQ0KrfbxiRqWN82q0cBHT6aIp5gFjYAx9dO26cvVZqT2zPwvsrxgvdVxwisccTHLH4aNhXkp57VbhBUojsl+8dsO63NOiA4m184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657439; c=relaxed/simple;
	bh=vR6kbHqFQ3srkxogKcDP7Nt5k/mLa5xmK4UC1zZj96o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hlIwbT46r+i6eZ2MCuPTJcwR3j8PxGXbeWpfGU0MSX6IoxJEyxFRhUQL//o074N1Vk8Uu7GQWBASVT3TzC6vd67O4jkB4yOc6avijA8YCsms1QhYfz/BgdduinToqwxG2U5q27ogu1e3UAREJQx+jHplGcU96G5Hp1Y+0U1IVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUx22mNG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUx22mNG"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so1460440b3a.0
        for <mptcp@lists.linux.dev>; Tue, 09 Apr 2024 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657437; x=1713262237; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9njs262BXZ+KTO0nKZYKjQcAI0Rd6Xl4cj8uA5zuCE=;
        b=hUx22mNGPz+HIcw5Hofysly9dCJB62MaGFuQFFjU7mDWaR24ibjSPsiL8EIp8WScX7
         dBpjUH8wDRILgar/Llnc5XRSjRwLK+DTgbez1WhUcGXxQEDCGnPSIb+PrOkR6mCfYYpA
         bx7uPtQDREOie8hZ/ljzkEYfdefP0uOfhFVzzqmYBTlAEI5T0tbvKexWvBgcI6cZ4xm3
         HBUxnBkC+zdzGJtoT6jzRbmMAaKQFABNOL3KYfQ4Pq2Gst3PmCh/ltGSUf7SKpNdnMM9
         nreG9Z1klGhY84IsXuPeOuMkvSQLBFu704Kp7+zH0J9/bWYgSwcRnCvWCraSpI/3XbOy
         nxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657437; x=1713262237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9njs262BXZ+KTO0nKZYKjQcAI0Rd6Xl4cj8uA5zuCE=;
        b=NAEEH+SZiAwlXJA0Mq6KA5omJX2lIzzNhckP5ByDZF+85JH4D9OsZfHMHju3b+uxc5
         VP6F8Wx0I6L6Ee+RmcLgVOPLkLTDij8DokLnWM54RNmX0ZMTIT54SIkz8SNxURLDur94
         66gApSUV5uV9g70oPSYH1Ibj9DTwdeJwR+XqEQdwJSbrkyaE9akBOXPjesZRn0kd52Aa
         HRyD0hmT7sUvqyCryU2dyvIxOCLVlUNU8JT8JtUT5D0nmnvNVdva6GIHYd/RGE45HAwg
         4+2P1gSJZjGQAd4ast8BecB9OOYwxg8u3v5SLVvip4k4ho9wSntsNgqkl3OKOJgljDd8
         FZjQ==
X-Gm-Message-State: AOJu0YzXfdMp3YVIZxacDzvjkP1jG7sjMFWyNgpnJMisAaJ1Sjy9hORY
	G6YTLT78mItu88NwI8vfSk61U+FmYpmT8m17K5n2NogbQ+ipC++r
X-Google-Smtp-Source: AGHT+IGbDsK36pQYj/QkFCTE5pr2kBpve2qdJTIHdWw40y+MVtCjE2g6UTnZJRWLuyK348NB8A+fsQ==
X-Received: by 2002:a05:6a00:4fca:b0:6ed:4288:68bc with SMTP id le10-20020a056a004fca00b006ed428868bcmr4068922pfb.19.1712657437479;
        Tue, 09 Apr 2024 03:10:37 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.26.66])
        by smtp.gmail.com with ESMTPSA id fn12-20020a056a002fcc00b006e5597994c8sm7959130pfb.5.2024.04.09.03.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:10:37 -0700 (PDT)
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
Subject: [PATCH net-next v3 5/6] mptcp: support rstreason for passive reset
Date: Tue,  9 Apr 2024 18:09:33 +0800
Message-Id: <20240409100934.37725-6-kerneljasonxing@gmail.com>
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

It relys on what reset options in the skb are as rfc8684 says. Reusing
this logic can save us much energy. This patch replaces most of the prior
NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/mptcp/subflow.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ba0a252c113f..4f2be72d5b02 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -308,8 +308,11 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
-		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+
+		tcp_request_sock_ops.send_reset(sk, skb, mpext->reset_reason);
+	}
 	return NULL;
 }
 
@@ -375,8 +378,11 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
-		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+
+		tcp6_request_sock_ops.send_reset(sk, skb, mpext->reset_reason);
+	}
 	return NULL;
 }
 #endif
@@ -783,6 +789,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	bool fallback, fallback_is_fatal;
 	struct mptcp_sock *owner;
 	struct sock *child;
+	int reason;
 
 	pr_debug("listener=%p, req=%p, conn=%p", listener, req, listener->conn);
 
@@ -911,7 +918,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	tcp_rsk(req)->drop_req = true;
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-	req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	reason = mptcp_get_ext(skb)->reset_reason;
+	req->rsk_ops->send_reset(sk, skb, convert_mptcp_reason(reason));
 
 	/* The last child reference will be released by the caller */
 	return child;
-- 
2.37.3

