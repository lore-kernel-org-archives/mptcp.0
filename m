Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9428689
	for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856930; cv=none; b=D25pxbwEiyw02SZm6jJddQfNQZ++QnS+Hy+Gskn8FmPeh1pf/Hjkjh/NQCKhE/M9FFEmUsKpO261f2ZSIVR6oMbNIA6A6MI65Ke+i+dNzEfZ2squ/raJLBnYrNnCyfUEl1xo3DqnMxE9RKqOCf+cJYVmI/sAltO4LO1fnzGRdXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856930; c=relaxed/simple;
	bh=OtI0qpXQDeqz30Gp/wuADu/hSlBB3PVvmN9MSoBAOsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cJv7ZtJVrsrNjwbYAr1hiiG76WAutECl0R2HGHAtpSqTJmSz6ipydn0KOfdeTqJufXErml3L1HO4F5eEg2m/me0/HfTqd7NBwWmzU4jJzSpl8LYXVMzSRqOHqXOdi2F/CP7ttRhNjF4sERfJY5HSBIVkoeeuubY5eJ+SpFV+koY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJfAu8mT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJfAu8mT"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so46223285ad.1
        for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 00:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713856928; x=1714461728; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HYxE6qPJ+WBlSk1qBaTkX3iWt23hXj5IwR3Pv1tiJQ=;
        b=gJfAu8mTwOVrS1/jbc7r71ot5RQxQkej6Zi/V3UqOCKun4lHxdcFMgJ+OPEO6fJdPh
         70yZlB+nAIJHPtndtT5r3ZquXHL7N4BtcijStQR5nOiSlWLz476AGIxsFNfcIrLMe6/f
         XsMoF8eDkxtpahEPR12iu3MmGin1M12RkM9a9Zvaz9T/chs/Iaq1YWEMjlEk7iTyhw4m
         r2WJyxrro+FjbW84rVFyijdQVIv8AGX5/PN8i3HurL7Insc/Ewc2kvR7AhF2r7iLYS5D
         i+0zEK35mG7k1ZhkyPUPSs6wrCDq568el+D2MTJxMdnABxnL/bQFyq97J6gLEf1NwhPf
         v2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856928; x=1714461728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HYxE6qPJ+WBlSk1qBaTkX3iWt23hXj5IwR3Pv1tiJQ=;
        b=b7Vsz0A/vazAd44s66rHETHRZ0UqjxxqYOJbTUDisMH+cI8bfiIhuXvBzXtDo+ETAQ
         QQhBmAB8mzny1xEfheY2jzt8sYHgYYHZWx42vMyBu9viz4L3VyYmrUshw4mqpyNitDds
         1jAsdm8Ofkh6MGRs7dpcRF6Rq61Z2cptqSq0I1SBFQXfgilPK8bmPJlX0aNN+ATFMcqC
         E1Rpy2dvlnBSH+WvYZESDFPEhUrwUsMD5gUcaJCMa21NJ5NaSyei3q26lx0xHo6Kox9N
         AkL0Wojeps2CliFUUL7mshxhUi/9qGEHK9aIVJaEc5cjikpXZTjsN6Vs26kNsCsuyZYw
         YqdA==
X-Gm-Message-State: AOJu0YwvOclhxmsm+cODkYsLdb9d33QC13bJb/sD5ppGxxsqzEVFyJkB
	nAwc0SOILmv2EPZppFn86hN21ILOzj0Oa36CFBe12mACqBy/X0Jb
X-Google-Smtp-Source: AGHT+IEVW3odWsBwH1bWV+MNF8o8UTAxXCCe8RNadga8mLZQiYMzT0wopshqT5yVbAmB7lCw+R+WCA==
X-Received: by 2002:a17:902:e84f:b0:1e3:e0ca:d8a3 with SMTP id t15-20020a170902e84f00b001e3e0cad8a3mr15113788plg.6.1713856927962;
        Tue, 23 Apr 2024 00:22:07 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902c79300b001e0c956f0dcsm9330114pla.213.2024.04.23.00.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:22:07 -0700 (PDT)
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
	atenart@kernel.org,
	horms@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v8 5/7] mptcp: support rstreason for passive reset
Date: Tue, 23 Apr 2024 15:21:35 +0800
Message-Id: <20240423072137.65168-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240423072137.65168-1-kerneljasonxing@gmail.com>
References: <20240423072137.65168-1-kerneljasonxing@gmail.com>
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
 net/mptcp/protocol.h | 28 ++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 22 +++++++++++++++++-----
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fdfa843e2d88..bbcb8c068aae 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -581,6 +581,34 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
 	WRITE_ONCE(subflow->local_id, -1);
 }
 
+/* Convert reset reasons in MPTCP to enum sk_rst_reason type */
+static inline enum sk_rst_reason
+sk_rst_convert_mptcp_reason(u32 reason)
+{
+	switch (reason) {
+	case MPTCP_RST_EUNSPEC:
+		return SK_RST_REASON_MPTCP_RST_EUNSPEC;
+	case MPTCP_RST_EMPTCP:
+		return SK_RST_REASON_MPTCP_RST_EMPTCP;
+	case MPTCP_RST_ERESOURCE:
+		return SK_RST_REASON_MPTCP_RST_ERESOURCE;
+	case MPTCP_RST_EPROHIBIT:
+		return SK_RST_REASON_MPTCP_RST_EPROHIBIT;
+	case MPTCP_RST_EWQ2BIG:
+		return SK_RST_REASON_MPTCP_RST_EWQ2BIG;
+	case MPTCP_RST_EBADPERF:
+		return SK_RST_REASON_MPTCP_RST_EBADPERF;
+	case MPTCP_RST_EMIDDLEBOX:
+		return SK_RST_REASON_MPTCP_RST_EMIDDLEBOX;
+	default:
+		/**
+		 * It should not happen, or else errors may occur
+		 * in MPTCP layer
+		 */
+		return SK_RST_REASON_ERROR;
+	}
+}
+
 static inline u64
 mptcp_subflow_get_map_offset(const struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ac867d277860..fb7abf2d01ca 100644
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
+		reason = sk_rst_convert_mptcp_reason(mpext->reset_reason);
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
+		reason = sk_rst_convert_mptcp_reason(mpext->reset_reason);
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
+	reason = sk_rst_convert_mptcp_reason(mptcp_get_ext(skb)->reset_reason);
+	req->rsk_ops->send_reset(sk, skb, reason);
 
 	/* The last child reference will be released by the caller */
 	return child;
-- 
2.37.3

