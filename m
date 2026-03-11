Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7363B8932
	for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215794; cv=none; b=fp0f4LNS85MYQgjl3ch62POD1iwPPyfn9KYGOx1V0mu2oNVkf286ae5YnUURbBa0nRNkBAkJYhp+Q3YfChZKXJ/cDHtJbyViY9rifYyzRkX6aXW2QucFNwP98PJJufba8I15ZCJ09P8CkabLJAD8Y5baet1AAGfOxorw+MiC4Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215794; c=relaxed/simple;
	bh=FYyuTZ6oj/yHfeGN9pAwnMFoWQKizQRfgw8TBRRgtVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UbFlaycXgPkv+oDf/jA8LcYjIWqZ3KmfTTAAo3jvsExiIzMznRebbWaLzf3auxaHjCWLXveBEbpOfyF02R+deP0SlgvO1QKDUK9u0SYOpJVBVnb44uQ4c46/E5RUyrgfYSjk9NRm7C9hPD2su6P+FOySvGBK/3II85Ya3BMTNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu6QIny2; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu6QIny2"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4042905015cso5412328fac.0
        for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 00:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215789; x=1773820589; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40e3x26UsOAMqAGLAxgvpaUIp6rLm2UmpbVxhD/U51Y=;
        b=Tu6QIny2yroztbeIPqQdwgZzvCRevmylbXjZlswE1mL8lmWHIZF0AQ2LCbM+DcdD/V
         xiofjBG+eVBflVBlB/zYSplchYsQiE2X0wLK7KjKrnCxw74yve5M7l3jqdtj1EfgytzD
         4t526lUVkSxEGhoppSYrKxc6tyecdqJyWT88h2iSmXMzSDbAshdwCukITO/QlhVULkF9
         42ZnQWZHo1/f7IndxyTngILDgkzgxy+qWrIM0kkhrbav5Knfv9D8SGaL51pdv/XjYotT
         59kMmchCPbfTyRPJsZuUVze3AERukj3A3oNzKebyXSV7hiZtshDf8+Y0sRRbADnGo7wk
         fSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215789; x=1773820589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40e3x26UsOAMqAGLAxgvpaUIp6rLm2UmpbVxhD/U51Y=;
        b=lwFVmOcqGZZdnDdmjdxa+qWZgryL0RuiYVClOjhoyeYR7mAwlw3BivT65ygu/45zKX
         aPupu2yl8n2TglTxWN488Dk+osrL+iQh7xMmy4Gn5FxSiuOlpKAzK4Evq+5OxLFElwyh
         xUmL3+YoeRIzpAqyE5voX3SilAdDjP/qmExnznrTFFSc98z8ggAP4bsGrXKlC+0Yg8zp
         JaxexALFKaWAplCFXwJHnU/Ng5i9KGi0955yvY5Qf5hNjugPxpmpzZi3ygm01SdtO4xM
         5u5+RGD2nqP4ro8YtZkFGLN7nQUkxeDgYEre32n1Xc2StwcqMFiaAHaJv16k5mJSgtCW
         tgbA==
X-Forwarded-Encrypted: i=1; AJvYcCXh/jDynxp2RLWH/vhwBNY1X3S3BOe4WPPe6LDSD/8JpKVpNuGHdrQj5Kq+c2UuiFZoX7e2Zw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqI5YqP7R02QeGBFJ81AUAbmVgzxKD3Tj6w9mfc/IzLJ9fsMnL
	ZtRBNFWMD9A7wIsv0MPlwoL7LNyvefrjWvnkNpk01sOxDSCVIshbNnzO
X-Gm-Gg: ATEYQzyW9c+ls38YeKHFnNVBPxIHvJG63WH1eeR+0cMp4JJNlBI7BiMXnM1seGxwQeo
	Hp7flD9a4mieMzCJcvNyrnFqJ+3ONIW3B0N8H8IHh4HxDLv5I2kZ3OYEKLQPfvlkz23f1dvoQg7
	3Y0MfZlBjaQGqVs0ArvNYvoKutur2Vaz5OcfOmnJIL2t5hMnXt8aeuZ5QGTRfMmLd9hZcaBtdEt
	+oWqF2pCIvH2/SYJ+7rNYinstHLZ6/bhY5BZC4t5hj82c5AZppLGMmpdKUl+T6uw8ak8R2zhaVr
	aYxLfhcw6DXl0Dh8VAcbsg1/1fzagrG7vq8z/0Nnmginh+aKzbmUStGPpGtcTQDmzNeLBz47U3b
	hTt0DlyE2fAkctiBdw/VZp4Pm+2JyReDvTD8lKm9DE/Uvi90Z/rR8SJ8P1l+ddzwaOLaI7Ro+Gw
	yUszosNH0/EIORqu8BjRXZJm44dbVeTM6Pkd7NTL/2uMhTlJrDO1QGAOtil8bOANX4VY/eqfZHO
	hsH+wMDMCKxWX4ZKdMyYCiQFk021mkIyMFIcdxcW07CvrI+
X-Received: by 2002:a05:6871:2b04:b0:3ec:565a:13a4 with SMTP id 586e51a60fabf-4177c8be4f7mr1195845fac.34.1773215788774;
        Wed, 11 Mar 2026 00:56:28 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:28 -0700 (PDT)
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
Subject: [PATCH net 1/7] tcp: track advertise-time scaling basis for rcv_wnd
Date: Wed, 11 Mar 2026 01:55:54 -0600
Message-Id: <20260311075600.948413-2-atwellwea@gmail.com>
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

tp->rcv_wnd is an advertised window, but later receive-side accounting
needs to recover the hard memory budget that window represented when it
was exposed.

Prepare for that by storing the scaling basis alongside tp->rcv_wnd and
centralizing the helper API around the paired state. While here, make the
existing receive-memory arithmetic use the shared helper names so later
behavioral changes can build on one explicit accounting model.

This patch is groundwork only. Later patches will refresh the snapshot at
window write sites and consume it in the receive-memory paths.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 include/net/tcp.h                             | 79 +++++++++++++++++--
 net/ipv4/tcp.c                                |  1 +
 4 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 563daea10d6c..1415981b9d8a 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -12,6 +12,7 @@ struct inet_connection_sock   inet_conn
 u16                           tcp_header_len          read_mostly         read_mostly         tcp_bound_to_half_wnd,tcp_current_mss(tx);tcp_rcv_established(rx)
 u16                           gso_segs                read_mostly                             tcp_xmit_size_goal
 __be32                        pred_flags              read_write          read_mostly         tcp_select_window(tx);tcp_rcv_established(rx)
+u8                            rcv_wnd_scaling_ratio   read_write          read_mostly         tcp_set_rcv_wnd,tcp_can_ingest,tcp_clamp_window
 u64                           bytes_received                              read_write          tcp_rcv_nxt_update(rx)
 u32                           segs_in                                     read_write          tcp_v6_rcv(rx)
 u32                           data_segs_in                                read_write          tcp_v6_rcv(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index f72eef31fa23..ec6b70c1174b 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -297,6 +297,7 @@ struct tcp_sock {
 		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
 		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
 		prev_ecnfield:2; /* ECN bits from the previous segment */
+	u8	rcv_wnd_scaling_ratio; /* 0 if unknown, else tp->rcv_wnd basis */
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 978eea2d5df0..187e6d660f62 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1702,6 +1702,26 @@ static inline int tcp_space_from_win(const struct sock *sk, int win)
 	return __tcp_space_from_win(tcp_sk(sk)->scaling_ratio, win);
 }
 
+static inline bool tcp_rcv_wnd_snapshot_valid(const struct tcp_sock *tp)
+{
+	return tp->rcv_wnd_scaling_ratio != 0;
+}
+
+/* Rebuild hard receive-memory units for data already covered by tp->rcv_wnd if
+ * the advertise-time basis is known. Legacy TCP_REPAIR restores can only
+ * recover tp->rcv_wnd itself; callers must fall back when the snapshot is
+ * unknown.
+ */
+static inline bool tcp_space_from_rcv_wnd(const struct tcp_sock *tp, int win,
+					  int *space)
+{
+	if (!tcp_rcv_wnd_snapshot_valid(tp))
+		return false;
+
+	*space = __tcp_space_from_win(tp->rcv_wnd_scaling_ratio, win);
+	return true;
+}
+
 /* Assume a 50% default for skb->len/skb->truesize ratio.
  * This may be adjusted later in tcp_measure_rcv_mss().
  */
@@ -1709,15 +1729,62 @@ static inline int tcp_space_from_win(const struct sock *sk, int win)
 
 static inline void tcp_scaling_ratio_init(struct sock *sk)
 {
-	tcp_sk(sk)->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	tp->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
+	tp->rcv_wnd_scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
+}
+
+/* tp->rcv_wnd is paired with the scaling_ratio that was in force when that
+ * window was last advertised. Legacy TCP_REPAIR restores can only recover the
+ * window value itself and use a zero snapshot until a fresh local window
+ * advertisement refreshes the pair.
+ */
+static inline void tcp_set_rcv_wnd_snapshot(struct tcp_sock *tp, u32 win,
+					    u8 scaling_ratio)
+{
+	tp->rcv_wnd = win;
+	tp->rcv_wnd_scaling_ratio = scaling_ratio;
+}
+
+static inline void tcp_set_rcv_wnd(struct tcp_sock *tp, u32 win)
+{
+	tcp_set_rcv_wnd_snapshot(tp, win, tp->scaling_ratio);
+}
+
+static inline void tcp_set_rcv_wnd_unknown(struct tcp_sock *tp, u32 win)
+{
+	tcp_set_rcv_wnd_snapshot(tp, win, 0);
+}
+
+/* TCP receive-side accounting reuses sk_rcvbuf as both a hard memory limit
+ * and as the source material for the advertised receive window after
+ * scaling_ratio conversion. Keep the byte accounting explicit so admission,
+ * pruning, and rwnd selection all start from the same quantities.
+ */
+static inline int tcp_rmem_used(const struct sock *sk)
+{
+	return atomic_read(&sk->sk_rmem_alloc);
+}
+
+static inline int tcp_rmem_avail(const struct sock *sk)
+{
+	return READ_ONCE(sk->sk_rcvbuf) - tcp_rmem_used(sk);
+}
+
+/* Sender-visible rwnd headroom also reserves bytes already queued on backlog.
+ * Those bytes are not free to advertise again until __release_sock() drains
+ * backlog and clears sk_backlog.len.
+ */
+static inline int tcp_rwnd_avail(const struct sock *sk)
+{
+	return tcp_rmem_avail(sk) - READ_ONCE(sk->sk_backlog.len);
 }
 
 /* Note: caller must be prepared to deal with negative returns */
 static inline int tcp_space(const struct sock *sk)
 {
-	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
-				  READ_ONCE(sk->sk_backlog.len) -
-				  atomic_read(&sk->sk_rmem_alloc));
+	return tcp_win_from_space(sk, tcp_rwnd_avail(sk));
 }
 
 static inline int tcp_full_space(const struct sock *sk)
@@ -1760,7 +1827,7 @@ static inline bool tcp_rmem_pressure(const struct sock *sk)
 	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
 	threshold = rcvbuf - (rcvbuf >> 3);
 
-	return atomic_read(&sk->sk_rmem_alloc) > threshold;
+	return tcp_rmem_used(sk) > threshold;
 }
 
 static inline bool tcp_epollin_ready(const struct sock *sk, int target)
@@ -1910,7 +1977,7 @@ static inline void tcp_fast_path_check(struct sock *sk)
 
 	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
 	    tp->rcv_wnd &&
-	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
+	    tcp_rmem_avail(sk) > 0 &&
 	    !tp->urg_data)
 		tcp_fast_path_on(tp);
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 202a4e57a218..cec9ae1bf875 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5238,6 +5238,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd_scaling_ratio);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
-- 
2.34.1

