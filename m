Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C33BC690
	for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215804; cv=none; b=LEgV9o1+HJfkC3wIB6Gx8KGc28Czucf5/G849LBALu448AbsMmg6DWgxAt8vMQ+ROtAUbD1WZEZoDXZselhbnKVAC9x/EDH/6KtXNxijTMuTCOuEBtFNu7fgi2g/9nHh6+X5mvW3q81N/EoksgK8+zrV7wuCfGR0fMtf5a6rXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215804; c=relaxed/simple;
	bh=C939i0d+rKTXWj91cA/6uhlPcNX1BycjNPrjJIyRlB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mKnhfshJtWTSNDVNBdk/rlxd+WOPfwTZ6PcVcSwo6EhP3R8R73UaIWvf9WvK9vZcknxPemB9ELaaWmhKeONDOCfaNBaZUZlhJBdCVoSq6I3w9WMQ5kEMyasiL+rmvgWmVGI0tJQCHzRksWtRl9CsJNmaQMFjiLEKezEkKUyOBHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/KC8XqU; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/KC8XqU"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40946982a78so3527977fac.2
        for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 00:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215799; x=1773820599; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4epqsXquWuAivDGaqjYARTGwK/kOqEMKWTt83y67gTo=;
        b=a/KC8XqUi1z0u26NCUYJ92Xwr/cmJGKRb0DFomki167ppoChuPKUFCt+og5DYtppN7
         6NJtdde4+PNUFK14CAplG4zyW67HqB59IwmzhnYTy61l3zk0OpQ0Xn450h9ats+Xo7AG
         rUoIeCH/4hXa3VMjC2KQj3RUjNEcJETnoz0cQvyOcNGFMewjV/cP8D3l2dbTWB6IDZk9
         fdsWe4+Zf++7wSVKDhMCDG4/5gz70RJQFxKm4qmaDQ4ZVxkgjMJPA2PyiMXsH1/nwk0b
         n4KYp75KIM8Uzs1mvZvbo+3eg/d6+FpsttVKG32+JlsPZHCeAT7AMxK3WE4Aoxv/TEie
         BQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215799; x=1773820599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4epqsXquWuAivDGaqjYARTGwK/kOqEMKWTt83y67gTo=;
        b=ER8+4/aD8Xrb5KLfC2Bdi4lAzbrR2ha9mTBGcKywm6C8rMvkk4q9+lL14nOypLpwvy
         3c0sbkLHwEsuzRRUdNZt46krP812vQAqer6x5nIjrp8cCuolbHjpID+kFOCB8/eHv5TZ
         B7aCCwAYlJVvhbFYzQwLbsxnz3Xf+IVcp9pqtgnCtYhCtAuIYas9MXNZ5Nj52YQjZZvV
         aITDkyJ9b/RD6y8wj1ZtKCo2FSo945Zyq2EUWDTwoMk0Zc4QeMnob4kUFVRGbA+LDtst
         Tpln7d8t5+NWvdKFNBGEApR4JHWRLUyrslCbYxZpzvk+M97VVCvsMTw4zDmJxrLPilLV
         lfzg==
X-Forwarded-Encrypted: i=1; AJvYcCWNvLQKRGPKl0ig8iGnmsDdlhGUGJpQSAJkrJnog4yyDND7kADK+DLQWlC+zdH6aRFgV/ccrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGO1WluYqt5Zbrmu/pbCF1zXVLiCQAsV9FypDlJkdjdVQbFAyn
	/D92Z80SFyibCOaKCKfzFDc1PkgosblcC6+0hHxubn5Y885J77kIFO7I
X-Gm-Gg: ATEYQzzl2y8mZOicMlV9fbbUDx+ugxhJxEOm4PZz1tfXw60xLBhvGvbnqTxkRoQhj/o
	rkC5i5xW5sm3JnWelwV/pxC5pzleSBWNx9RyW1ZLsOc+jnB3tvGCsf/01UMpn0wV1OYCDDINEFT
	jluVMuI+00B6kVU0Ue3g/4qw/yRtJ/5741uQnE9imtEsy3WeURP/+WDfeYKLx18ow/3dFxO85cB
	V5cT3VxzqBSYoysvLzwTYz7STXKgI9j0zLfRGWDLggfh968BCExkCrIjeH1l2z8km3lkb7ahAGL
	mcrdMQI/NNQgJuca7K+7+KsYX42Nnee7Cr1gqG8OjbBkl5W19c1rzkon0i90m0FYzj+B0BAcr1b
	rBhXFyqbfRi5R8aapCtaST2xKCHdh1/wizYZ/vhBx3DCsWGQnHl2kz43+xOwO1DxMqA78u9GRZw
	IsEOflNIxIqH23ukfimk3SKDjeav0FXAUTIPQP9k7DLO0AvtcnxnuiuZ9jd0SXBE3W7w2q/k33B
	lotHbY7W5TsI4zRBa7CgsTJgREBB/T6j2VB5TpoxHgaQfWV
X-Received: by 2002:a05:6870:8e07:b0:3e0:de76:31e5 with SMTP id 586e51a60fabf-4177c8b4e62mr1075613fac.25.1773215798847;
        Wed, 11 Mar 2026 00:56:38 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:38 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: kuniyu@google.com,
	horms@kernel.org,
	geliang@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	atwellwea@gmail.com
Subject: [PATCH net 6/7] tcp: expose rmem and backlog accounting in rcvbuf_grow tracepoints
Date: Wed, 11 Mar 2026 01:55:59 -0600
Message-Id: <20260311075600.948413-7-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311075600.948413-1-atwellwea@gmail.com>
References: <20260311075600.948413-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The receive-window work now depends on keeping sender-visible rwnd and
hard receive-memory accounting aligned.

Expose the current rmem charge and backlog reservation in the TCP and
MPTCP rcvbuf_grow tracepoints so that later drift between advertised
window and local backing is visible during review and debugging.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 include/trace/events/mptcp.h | 11 +++++++----
 include/trace/events/tcp.h   | 12 +++++++-----
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 269d949b2025..167970e8e0a5 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -199,6 +199,8 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 		__field(__u32, inq)
 		__field(__u32, space)
 		__field(__u32, ooo_space)
+		__field(__u32, rmem_alloc)
+		__field(__u32, backlog_len)
 		__field(__u32, rcvbuf)
 		__field(__u32, rcv_wnd)
 		__field(__u8, scaling_ratio)
@@ -228,6 +230,8 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 				     MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq -
 				     msk->ack_seq;
 
+		__entry->rmem_alloc = tcp_rmem_used(sk);
+		__entry->backlog_len = READ_ONCE(msk->backlog_len);
 		__entry->rcvbuf = sk->sk_rcvbuf;
 		__entry->rcv_wnd = atomic64_read(&msk->rcv_wnd_sent) -
 				   msk->ack_seq;
@@ -248,12 +252,11 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 		__entry->skaddr = sk;
 	),
 
-	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u "
-		  "rcvbuf=%u rcv_wnd=%u family=%d sport=%hu dport=%hu saddr=%pI4 "
-		  "daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c skaddr=%p",
+	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u rmem_alloc=%u backlog_len=%u rcvbuf=%u rcv_wnd=%u family=%d sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c skaddr=%p",
 		  __entry->time, __entry->rtt_us, __entry->copied,
 		  __entry->inq, __entry->space, __entry->ooo_space,
-		  __entry->scaling_ratio, __entry->rcvbuf, __entry->rcv_wnd,
+		  __entry->scaling_ratio, __entry->rmem_alloc,
+		  __entry->backlog_len, __entry->rcvbuf, __entry->rcv_wnd,
 		  __entry->family, __entry->sport, __entry->dport,
 		  __entry->saddr, __entry->daddr, __entry->saddr_v6,
 		  __entry->daddr_v6, __entry->skaddr)
diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index f155f95cdb6e..92d0bd6be0ba 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -217,6 +217,8 @@ TRACE_EVENT(tcp_rcvbuf_grow,
 		__field(__u32, inq)
 		__field(__u32, space)
 		__field(__u32, ooo_space)
+		__field(__u32, rmem_alloc)
+		__field(__u32, backlog_len)
 		__field(__u32, rcvbuf)
 		__field(__u32, rcv_ssthresh)
 		__field(__u32, window_clamp)
@@ -247,6 +249,8 @@ TRACE_EVENT(tcp_rcvbuf_grow,
 				     TCP_SKB_CB(tp->ooo_last_skb)->end_seq -
 				     tp->rcv_nxt;
 
+		__entry->rmem_alloc = tcp_rmem_used(sk);
+		__entry->backlog_len = READ_ONCE(sk->sk_backlog.len);
 		__entry->rcvbuf = sk->sk_rcvbuf;
 		__entry->rcv_ssthresh = tp->rcv_ssthresh;
 		__entry->window_clamp = tp->window_clamp;
@@ -269,13 +273,11 @@ TRACE_EVENT(tcp_rcvbuf_grow,
 		__entry->sock_cookie = sock_gen_cookie(sk);
 	),
 
-	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u rcvbuf=%u "
-		  "rcv_ssthresh=%u window_clamp=%u rcv_wnd=%u "
-		  "family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 "
-		  "saddrv6=%pI6c daddrv6=%pI6c skaddr=%p sock_cookie=%llx",
+	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u rmem_alloc=%u backlog_len=%u rcvbuf=%u rcv_ssthresh=%u window_clamp=%u rcv_wnd=%u family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c skaddr=%p sock_cookie=%llx",
 		  __entry->time, __entry->rtt_us, __entry->copied,
 		  __entry->inq, __entry->space, __entry->ooo_space,
-		  __entry->scaling_ratio, __entry->rcvbuf,
+		  __entry->scaling_ratio, __entry->rmem_alloc,
+		  __entry->backlog_len, __entry->rcvbuf,
 		  __entry->rcv_ssthresh, __entry->window_clamp,
 		  __entry->rcv_wnd,
 		  show_family_name(__entry->family),
-- 
2.34.1

