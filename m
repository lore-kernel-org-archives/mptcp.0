Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF95112A15B
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343935; cv=none; b=VQ3RB0h0tKcXJAfoG42vBimwKP3E92R6JaCO57zrCr7o4QUFwLK4asN4xZT7cmV+qBoQce1oVMZcWAjPIaf15yJAc/WW/OnvQUgld7gNwrFoCtpmnLMzkNP+JOUYzRWW88XgdQJA7L/Jfei9tMy/q7ld1FWqS4o+Sl5KXRteuZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343935; c=relaxed/simple;
	bh=0VTQYJ78QzBxqF81nvpNqVGCLyn+HEz3ONaeMbi9mG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFVTvuMi8Dx9paO9wdw7yIX8GvDY/idhaUeepJ+0r7U4Fuu3PLSn+0yOMxHHElNE9Hr0wldlVxG0Usp6g8Pjn/DuXrU21HRZdB08oKtCG1Z5nnnoICN3dLRNkxtYFmITccFY8H30QgOcg8NvYII072yLCA6oAVRLNRiCIwyFykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWVNrv2e; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWVNrv2e"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e3c9300c65so46455305ad.0
        for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713343932; x=1713948732; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk1xbizv/3iUHnTNC2vK0HjYyLpTvBev3i1Kew13jY0=;
        b=SWVNrv2exIDVPuLaflUGlrv+mEb/xxQ35vz6i8k0FzX4NM093ElkcPcjbFxXSRfROH
         1LNLUzsPrZXYXY8lRhGUAwHU84KELX1Hw6QNnr8cBh+GbpV/2P8RHfUBBJBtBzK0je5w
         pXr8gwhQk5HGO6qH5TasAwQF6S+vWWjPzJzaDDYzbbOLcPZ8bPI34v+jvleUWMi/tGcW
         t6yb7VIlFBXtZdl9cerOYR+vIyyehypg0+0goss3eUIFWOC2YhjiHMBrCc0ihxyeVotB
         MedatsZz/igra8GsQgDAVgH5NybMXKRi91emb1+iZ6N7oLxkznTsBn8oclCefamc4Bs9
         wqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343932; x=1713948732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk1xbizv/3iUHnTNC2vK0HjYyLpTvBev3i1Kew13jY0=;
        b=g5U20Pg/E8IESMxZLsHcwhbuzu2egPWZQn8tv9QVduLjAooDtNyvXuObKHJ1SjJvBX
         SFGVxGRvB8Nt90cF9Mb8FKKFi9oYVjPxbwCUp9Ep3JONYxn4d81dkvJLxhOkKyebb7G7
         Z6ImJuNLi0Fxz9q75a5k5PrsqjbtJWwRskW9LsRrArkSQLP49ORykiHrPuGuEqOdNMc5
         6a1BUNcXV4AzU3zT6iq11KquzX6sRXLLe+J/PIzx00WFxvpJgd4E59DkNdg4yVtbj1mV
         IsoTSaijPq8kLsbBPmBF2DfP3DEYtcaR2b6CYksr6EMPl2CkFIxoVSGlVu8PK1KsUKR4
         MBuA==
X-Gm-Message-State: AOJu0YwhbrCGwd3Rtu+qkepyz/SSUvClaJazFkIUcnlRQIGeRwxj4++z
	/tzhcLr2s+8pDE6b+pb7NOCxPCuYgfDvkWel/FEu6aJKV7TaV7Tf
X-Google-Smtp-Source: AGHT+IGb1GCq6VCXcHLtXm6+/ujsreRYJ8WgJnDnrP/LMg8mwAcBoz7jeK4UHTFovEpjLVVRw0LdNQ==
X-Received: by 2002:a17:902:e84e:b0:1e4:4887:74f0 with SMTP id t14-20020a170902e84e00b001e4488774f0mr16829170plg.36.1713343932188;
        Wed, 17 Apr 2024 01:52:12 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b001e452f47ba1sm11348611pli.173.2024.04.17.01.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:52:11 -0700 (PDT)
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
Date: Wed, 17 Apr 2024 16:51:41 +0800
Message-Id: <20240417085143.69578-6-kerneljasonxing@gmail.com>
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

