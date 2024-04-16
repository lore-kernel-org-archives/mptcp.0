Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1078129A70
	for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267640; cv=none; b=I25zT8nuxK9/E4tSA4Gri6F3krLYUfmmyU4W31ISBTj6baA5EmsQyarqlJFQNExHwb11h5iSjpQ+HLeCf6lbeLko5ttXXt7zLQBRzG/3/hqx5dJAMIcNVFF4jUV3MFTKagPkdWfuVjs+ZUA4CeFy9ADO+LsOaz92UjqIopx6Yso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267640; c=relaxed/simple;
	bh=0VTQYJ78QzBxqF81nvpNqVGCLyn+HEz3ONaeMbi9mG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b3UBJIdPNLbzE5HRxFQfPxTJbQz/8ZS1SA2QqwiB72wuNTD7ET7dyaUaKb84RFXOvyMMjlzxLWokeGVAeuFqgALc/naeFnfm8+3jXYryuhO/9iFnMhWgnYV3Mnf5lQzQH5nV61MG124OSEaW7za5mfWudL4OCFD7H+i6Dk9aIOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngyoiLn2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngyoiLn2"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso3936141b3a.2
        for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713267638; x=1713872438; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk1xbizv/3iUHnTNC2vK0HjYyLpTvBev3i1Kew13jY0=;
        b=ngyoiLn2JzwSHxcEDifXXdRIrJx3PUTAf9eKPYz9l2MACuFeV2udIccKK0+IxQ6GnO
         M2fpRa+k+HBqJr+PTrqqNFQaEzmio/CVu/ZOIkt2wZg9DbQt5edYYK+DoJgmFEzjys7R
         owAsISsvfIrnrQaoDa3KFMfJ3lqNJQ/uDrU/4gQXMdsUfYddI2OdFtvdB0fnZM+MVe2s
         CxUIybkKQbNyTtoRFDT/ouWNOBnxwYWHkkzfWgrXAy+DYvK6PAFGLSeARo8TdIoEi9YT
         F8Nv+ERxeWX3qh3PAGORyWK/uyWQjK3cb6ka3crR+osrEMZZ6o1jI3gvoCbGpUzYRm/7
         9p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267638; x=1713872438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk1xbizv/3iUHnTNC2vK0HjYyLpTvBev3i1Kew13jY0=;
        b=vr8nfIdWlMW3L4vm3gdZ4ManCGuInqgyyQ1YqLoB6/sTpL3yvNqgIi3eKBM+WAvuth
         fTVGtXeDS2/NSRG/IWs+QfVdHF1nfRM/8JXt9rFAqDNitHjxvL6LKacuV7Wn9qWGmeCb
         4Ub/xPRChIIO8RxbZF+E16c2j1cRsADjeXCl4QfmsiN+zS/yBKdDBPX9kRhf+ilYu0Ti
         mpuKTm/ic7ZOk+bi7xflKX7EUxbO/W2ydqWm8nbmL8Ejv5TkwQndWXirPQq3pjFG/SR1
         77p+z2riGKlWnmUMSAbWGHhqUPiUIhqdN+3JPXOcqJ8Er4QCusAFvg5Tpyv90h5M07Vf
         sCzg==
X-Gm-Message-State: AOJu0YzkgczlbCHaNW9aW7gFpMf2KOOqbE1KWSWQBSitkoJOK2Q8KQeh
	ZsIaAWP8HY1eYmf5nJUVcdfm5Byw1+TiRn7ixsHepauzxW1+U+Fe
X-Google-Smtp-Source: AGHT+IFe+4nCe+cABIheFzccWhrHioYgnYZncmu/Al9/d2IKxv2fJ/4SVd7hf79T+RJDu8mJNzEp/g==
X-Received: by 2002:aa7:8888:0:b0:6ea:8b0c:584 with SMTP id z8-20020aa78888000000b006ea8b0c0584mr17359372pfe.9.1713267638254;
        Tue, 16 Apr 2024 04:40:38 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id a21-20020aa78655000000b006e6c16179dbsm8862045pfo.24.2024.04.16.04.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:40:37 -0700 (PDT)
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
Subject: [PATCH net-next v5 5/7] mptcp: support rstreason for passive reset
Date: Tue, 16 Apr 2024 19:40:01 +0800
Message-Id: <20240416114003.62110-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240416114003.62110-1-kerneljasonxing@gmail.com>
References: <20240416114003.62110-1-kerneljasonxing@gmail.com>
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

