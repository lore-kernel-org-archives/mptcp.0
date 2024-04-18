Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED184161319
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447203; cv=none; b=Nv9jRAF/n0AsUzwlPuqA698G9K72PKGk0hkI6c8cjOkEces2XTVWe4r2ravSGCiYrMu8mBqCh7CtBTm1wLaJvGVaNFEiiRteez9b1sHNwQhufuapRlXZazRIC2I1ok/Pmro4HSSU7hVezHfPHZjkAI25mL8yYdLB/FL6cl5X4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447203; c=relaxed/simple;
	bh=0VTQYJ78QzBxqF81nvpNqVGCLyn+HEz3ONaeMbi9mG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aCduUi1XPwYiUl8oxK7qOusoFNcSpOAC0tNQKCirnRRIXSucWVfCZTxZad5e1/1y9zktYUb/fF6H32QEr9EFCz9ULOXrOyVV3j56Kz6hDg1+I3d1b8MlbL82hUbDyqYYc7NbbHepP/p0kcUZby7L41WA96SySWipUHwV2PsNW1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhclYZM+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhclYZM+"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so640094a12.3
        for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447201; x=1714052001; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk1xbizv/3iUHnTNC2vK0HjYyLpTvBev3i1Kew13jY0=;
        b=OhclYZM+jk9qApAPy1f5SCUAKm7lxL2N/IRaV+5RkgGsh/byoCLatcE7KMYmuynv+i
         wluOCz+ZPA8RAJOxAIaRR8Bk1N0/v39+qc7fHdBOe4ZXuPvWyXY/hxhy/sU1UOgSZi7I
         te1UfJbzL+Rh+r0vXhcpN8lK0tQR59cCb6r4VYpE/SsRwDKi9xiPR1J9nk7KUxY14P8R
         BMlxlbfJODWKqZ39w/aqLQe3B7cuImhwNRIc+uqU6jj4NtTJ729DYFzdJpD+4CfXZ8GJ
         g8VaIk7uAj3QrzSI1H7JSkYx2Y5tvqaCZocDPs1ZE4kk/Zc2Lk76zaFpKtWFILJt0+Y7
         BP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447201; x=1714052001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk1xbizv/3iUHnTNC2vK0HjYyLpTvBev3i1Kew13jY0=;
        b=Q2bQoLCcBI+zgeI8hFoGJ1dPyNovs5/oDHStsK/iHb1Ls+wkuPVmTWmA01roZYthwQ
         CEHy9BfCtlPLNdOa0omlhDxNlbQRYvWvav3XEQmRpX43mbqmrJCvlqMJTFnV14mmGzaK
         kbZbFlAJs1n8S3Cv4val8pusJx5LkHka0bNNmsXKTbqv5yNmdHK0Dv51DurdCBGXWBH0
         nVV+TnrBs+v7QGFhSkG3vT6RxadT2CJtwCcRVD8jpsC5BZoDOofWHDGNfv3TWPhDqoRU
         s2buxQn7nNE7dNVx9caV4B8HYXvHlWt19oYoObtj6DxgjkDD1BTZ5w5nNkDRtWp9ugLt
         4ejw==
X-Gm-Message-State: AOJu0YzZAZYN+10URYf8gpvd+ZDr6HzRJip2LgSrP96rejbKxdn+cRfW
	lBpF6YR6OJ+1D4XdcbQN+d5qexJLc+4SsHH53iZfxtYIB4+rbE0Z
X-Google-Smtp-Source: AGHT+IGMbYGT+4r7l48YeX26jDG6pDsGMoPErFYy8ztTXEf3VIYQtA2NVt7fUXK18aYuqwfc+8Oj6A==
X-Received: by 2002:a17:90a:f104:b0:2a2:4fa8:faae with SMTP id cc4-20020a17090af10400b002a24fa8faaemr2687259pjb.15.1713447201214;
        Thu, 18 Apr 2024 06:33:21 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id bt19-20020a17090af01300b002a2b06cbe46sm1448819pjb.22.2024.04.18.06.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:33:20 -0700 (PDT)
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
Subject: [PATCH net-next v6 5/7] mptcp: support rstreason for passive reset
Date: Thu, 18 Apr 2024 21:32:46 +0800
Message-Id: <20240418133248.56378-6-kerneljasonxing@gmail.com>
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

It relys on what reset options in the skb are as rfc8684 says. Reusing
this logic can save us much energy. This patch replaces most of the prior
NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/mptcp/subflow.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ac867d277860..bde4a7fdee82 100644
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
+		reason = convert_mptcp_reason(mpext->reset_reason);
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
+		reason = convert_mptcp_reason(mpext->reset_reason);
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
+	reason = convert_mptcp_reason(mptcp_get_ext(skb)->reset_reason);
+	req->rsk_ops->send_reset(sk, skb, reason);
 
 	/* The last child reference will be released by the caller */
 	return child;
-- 
2.37.3

