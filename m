Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6357EFBFC
	for <mptcp@lists.linux.dev>; Mon, 22 Apr 2024 03:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713754901; cv=none; b=evGHC8nlSHzalQpFcpQw5N8T8WtVQubD4UATgFoPawr3P5mM/kz1kVBDhS9SmIjt+Cp6k+61m040tpHSVQjntceT2fXhi8FA/IVxHzY+k467hAHUQzCyAHMF7fnZTve5qK3T4cWj4ONrD2x2aIjHff7d1VfdL7n/JLPgGL515HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713754901; c=relaxed/simple;
	bh=WjxyLjN2XXFGhBWrou1hHCduoG9kiV4eYSnQy4H1J6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXmd/LarDlC5I/8zhvZr9E1dqFSQ1ES58J6bt/B9r8ZsEsxYVK+Ybig6Os5jvDpMxLDxTQDpG/OgOgxiSolzADACO6UMid8CQDzur/cAi0tZGecm//3ffX5iueMZKjS1lozNXrq3QYzRa8INNSf3ls28A/HQdLGPnc1Eepud0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnIDpkpm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnIDpkpm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e4f341330fso31558075ad.0
        for <mptcp@lists.linux.dev>; Sun, 21 Apr 2024 20:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713754900; x=1714359700; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYeVVW3LSCqlYGBsnga3ls9vjokc9ozCT9CspXhLgec=;
        b=dnIDpkpmUrNiAJOAqD5tHuSTeEk0DbbsRaxb5TfBCvKEP4U/KKjYl5Sco2imhtc0zo
         FnHxMyeGQwde6Vl16htwW0XX2EMZSi55G3RhyqS7J4HjheKo7VSeZCywnDFbo37uVMXg
         bqiusLROVGCVptOEy9akXrV3vfCvOdfzrsuFreEpIuKp5mF04vlRwMPM8cVCtu41ftMv
         3MohhvJ/Wc8lgfWMuRk157qFEKsj4Gk/J2uDbImVtZfUxjF8e8l25mBdttH1LfmdM1Q6
         vFSbqFeVLV4PzMexpWdUXQxjvsudkKuJEg46wtp4c/oiunMZ9rmINUYUGLp4Fm3+jRXD
         OonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713754900; x=1714359700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYeVVW3LSCqlYGBsnga3ls9vjokc9ozCT9CspXhLgec=;
        b=rQcU7mqCrlhMYQPemoCTlEzQd82Tlw0nwildfvPLjmBEuiOu9M7JPbJXZyq0STzTeD
         kjTVtawE+c8ESydRagDE75uHsprIBe5+PHxV4WZZ44gTVguiu77MIVYzIQ3NIAIlesmq
         zo+XEvF+Fvfq4UytEbj6HHYLI/6nKJt1/9BT1BRV0NbPfU0yQM0QXY3bqKDW6VS9Eq8t
         d/4r03Ys2QVfNcMbM3U3H54xDm40coxDqcnI69dCjPw5ofOQzEmbhnN4+DG5ulo00TQr
         b9Y28H8+CcrDJ28UReSyfBXdEmNab/Ch7X+K90SauzSYtq1tlBg0t4uLV2NGZ0YdvUJJ
         t0RA==
X-Gm-Message-State: AOJu0YwxyV2pzDVFFnIyqLiRqzGNLx57EWk/YOhoYc0AURAgQZKeNiqW
	jRSBHpLcPe0teV797oIb3Pj8OfEBv3E4EXsix+Eh7lHobl7Fr7D4
X-Google-Smtp-Source: AGHT+IGV/c0wsMeQPxLO95FLc5z6vYhPP780ckEi3E8GQHDURTGIlWAooKM5o99muZb1LR2YpdZU+Q==
X-Received: by 2002:a17:903:22ca:b0:1e0:b2d5:5f46 with SMTP id y10-20020a17090322ca00b001e0b2d55f46mr10230874plg.46.1713754899605;
        Sun, 21 Apr 2024 20:01:39 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d60500b001e421f98ebdsm6966009plp.280.2024.04.21.20.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:01:39 -0700 (PDT)
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
Subject: [PATCH net-next v7 5/7] mptcp: support rstreason for passive reset
Date: Mon, 22 Apr 2024 11:01:07 +0800
Message-Id: <20240422030109.12891-6-kerneljasonxing@gmail.com>
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

It relys on what reset options in the skb are as rfc8684 says. Reusing
this logic can save us much energy. This patch replaces most of the prior
NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/mptcp/subflow.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ac867d277860..54e4b2515517 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -309,8 +309,13 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
-		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+		enum sk_rst_reason reason;
+
+		reason = convert_mptcpreason(mpext->reset_reason);
+		tcp_request_sock_ops.send_reset(sk, skb, reason);
+	}
 	return NULL;
 }
 
@@ -377,8 +382,13 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
-		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+		enum sk_rst_reason reason;
+
+		reason = convert_mptcpreason(mpext->reset_reason);
+		tcp6_request_sock_ops.send_reset(sk, skb, reason);
+	}
 	return NULL;
 }
 #endif
@@ -783,6 +793,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	struct mptcp_subflow_request_sock *subflow_req;
 	struct mptcp_options_received mp_opt;
 	bool fallback, fallback_is_fatal;
+	enum sk_rst_reason reason;
 	struct mptcp_sock *owner;
 	struct sock *child;
 
@@ -913,7 +924,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	tcp_rsk(req)->drop_req = true;
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-	req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	reason = convert_mptcpreason(mptcp_get_ext(skb)->reset_reason);
+	req->rsk_ops->send_reset(sk, skb, reason);
 
 	/* The last child reference will be released by the caller */
 	return child;
-- 
2.37.3

