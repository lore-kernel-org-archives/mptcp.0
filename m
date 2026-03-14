Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433433859C2
	for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519287; cv=none; b=o+Ss9iTnkAVbrBJgi8AvR2s4/UMTDO22UltmymfkgKOSAxnD8L95mgjGdDzNlsBaU18aP2yP8l5nevDRB2mJdZ+78x4saMNGoCiHXd2psQt2zScCYAEbfjs4AB76mz9FIVpT+ZIbu5Cdm3I5hRWdPBMDLFds02XhIX08acPtAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519287; c=relaxed/simple;
	bh=kQAayNyz3gm5FbyPOD3uaOhq7RsoX4Ii2Fi5JpOs7C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjVrJr/vQS9vkuFZxsFeQLSQ3TGgK/erF1oCdSQUdDeZNU6XFrCx52MYFzSBwdRGrNBek5k5RZPR9ASMH5MMuOGroG7+nqDSUvy2RhfKA6fR/HhvtE19fuBpo6kXTr1ipj0u1diK8JyDBI6Zn5IBWOKN/KxEURVO2VY6z1udPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng5ML4uQ; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng5ML4uQ"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-67bb5e4cf5aso2044152eaf.2
        for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519284; x=1774124084; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meSreHlytwJ2+CYWUu8fQhMJhkO7SpENNzkrogjDyzo=;
        b=ng5ML4uQ/dsyACPRl61ehwT7OvaYoMAvTAGbsoXy5N/MTwEF6dTl2IEk4/XMFtMqNe
         cTodLbP4wRo/nOVpfdsZz4Ts9nJxQiv3tlFNAZuIVBnb/WjSbJjkzMB2AyquNwaEpNP3
         6rxWtimf+TVkYUV/EMbLnFT6PUzkHsaIYyjVZ50iLEXqWgPpUFwHStlt/Dbq6Y/aTKKZ
         5Sm7QYL+ON3d7/Klv60YJAxorxdSSmj/PjpF65q2q7usWKZiL9CV0/ie0NdMmtwRMCpV
         3mOY/V9d4d6FjGUTRhlJFKA7VVUGejlaaka71gUar4/Q5A3ooUPzFgP2srWyUqKUZYd0
         yFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519284; x=1774124084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=meSreHlytwJ2+CYWUu8fQhMJhkO7SpENNzkrogjDyzo=;
        b=raRr66hNaos2E/2oy8Ag4Pidrxu1L9iS+/9zuN7Xzi8KsMelmBNDA7tI0WVwIq8dOP
         uyAXnYPGSoOmmVJyoJ9zi8tkM89HJANyCyEnmMfDfHxzMXhbLiD5DrDLev2zUBW1v8ij
         lcig3IuMB1ipqtteQZ+Vv5/finxUgR5PWDAlmjK/2g1/wV4cnSVdKD64cvItW9L1wjhO
         uOIxhHCMbw/wXyt5cQnXY0an49EdBYOtshCzTn1gW9f4q4QenoqAS3/+Lkj1p3W+eJu9
         eYUmmSDaQ/sbVBNayI44wJBSM6jH1nGeKl2bw2ZHMRK4a15CSCAsCj3bo00uX8QnyPgS
         2sHg==
X-Forwarded-Encrypted: i=1; AJvYcCWMBDy1lJMzmh6UBFNcmDk4ph2H7L/j6+W8fB5Y4U5LSOjFPiDXbdeF/FuYcQYwQic/iQNucw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyohaYtHEVwQ+ODqL9zvQIn5k4FOJ0JBMadBmCGaAAxNhxB0E5P
	bFzUMD/gnC9hiu+eKmN+j4C2VFKXR+xojL9gn4LnEbw2yLzxPUAvod+c
X-Gm-Gg: ATEYQzwAQ18pcmvkg9apGZ81BQrYDyuo4WaqIh8uJ9oxVzFpM1EXrq+tpryJFjmPg9R
	EV8oxlBUbZ7BkpoNkS8OpkVrLYplrL2Hng6MR3gbPxMTVskD1lSGB2hA7sne49E6eMpsbvoZVpX
	qGYSDLoUDUI2/r+D+XP3pzHIENgkLnB/b2C3HyADQAfJPvVGBgylHk7g1dyfUFeSKeEfVRrUi6B
	tKCBgJl0il9uutRwn/PEkzXpvh9yFNpRp/dgs6m4IdJFxywBAE9H/QgAPMd9gZOxrlXfvPNzaox
	ef780NMlEwCzE7Zsriyl2bEMTd0nMhIURAzRZK9zq7MFDiG2xYNpospPfwyrAQjqF3Lh5vLRzoq
	rLLC/sq+1Z9iVWnTO43dvAw8TjgwjnpMoclMvVdJii9RzhAmVzJnfr//0o6ATD58Yj+259LDaHg
	GwZRewQc8FuR2FnxHsbbh8qXKj5ctJ6Ug64K1PubKr1MgimRm0f6+BtZjS9L0Vt6Q1jZqLyoBkF
	MQgj+/Ektj7xBpjW//bdrn/+YKFY9wqSjyaKJ8M
X-Received: by 2002:a05:6820:2909:b0:662:fbd6:1849 with SMTP id 006d021491bc7-67bda98cb6dmr4777838eaf.4.1773519284132;
        Sat, 14 Mar 2026 13:14:44 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:43 -0700 (PDT)
From: atwellwea@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com
Subject: [PATCH net-next v2 02/14] tcp: snapshot advertise-time scaling for rcv_wnd
Date: Sat, 14 Mar 2026 14:13:36 -0600
Message-ID: <20260314201348.1786972-3-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
References: <20260314201348.1786972-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wesley Atwell <atwellwea@gmail.com>

Track the scaling basis that was in force when tp->rcv_wnd was last
advertised, and provide helpers to refresh or interpret that snapshot.

Later patches use this live-window basis to preserve sender-visible rwnd
accounting when receive-side memory costs drift after advertisement.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 include/net/tcp.h                             | 52 ++++++++++++++++++-
 net/ipv4/tcp.c                                |  1 +
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index fecf61166a54..09ece1c59c2d 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -11,6 +11,7 @@ Type                          Name                    fastpath_tx_access  fastpa
 struct inet_connection_sock   inet_conn
 u16                           tcp_header_len          read_mostly         read_mostly         tcp_bound_to_half_wnd,tcp_current_mss(tx);tcp_rcv_established(rx)
 u16                           gso_segs                read_mostly                             tcp_xmit_size_goal
+u8                            rcv_wnd_scaling_ratio   read_write          read_mostly         tcp_set_rcv_wnd,tcp_can_ingest,tcp_repair_set_window,do_tcp_getsockopt
 __be32                        pred_flags              read_write          read_mostly         tcp_select_window(tx);tcp_rcv_established(rx)
 u64                           bytes_received                              read_write          tcp_rcv_nxt_update(rx)
 u32                           segs_in                                     read_write          tcp_v6_rcv(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6982f10e826b..2ace563d59d6 100644
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
index 3a0060599afe..6fa7cdb0979e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1741,6 +1741,31 @@ static inline int tcp_space_from_win(const struct sock *sk, int win)
 	return __tcp_space_from_win(tcp_sk(sk)->scaling_ratio, win);
 }
 
+static inline bool tcp_wnd_snapshot_valid(u8 scaling_ratio)
+{
+	return scaling_ratio != 0;
+}
+
+static inline bool tcp_space_from_wnd_snapshot(u8 scaling_ratio, int win,
+					       int *space)
+{
+	if (!tcp_wnd_snapshot_valid(scaling_ratio))
+		return false;
+
+	*space = __tcp_space_from_win(scaling_ratio, win);
+	return true;
+}
+
+/* Rebuild hard receive-memory units for data already covered by tp->rcv_wnd if
+ * the advertise-time basis is known.
+ */
+static inline bool tcp_space_from_rcv_wnd(const struct tcp_sock *tp, int win,
+					  int *space)
+{
+	return tcp_space_from_wnd_snapshot(tp->rcv_wnd_scaling_ratio, win,
+					   space);
+}
+
 /* Assume a 50% default for skb->len/skb->truesize ratio.
  * This may be adjusted later in tcp_measure_rcv_mss().
  */
@@ -1748,7 +1773,32 @@ static inline int tcp_space_from_win(const struct sock *sk, int win)
 
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
+ * window was last advertised. Callers can leave a zero snapshot when the
+ * advertise-time basis is unknown and refresh the pair on the next local
+ * window update.
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
 }
 
 /* TCP receive-side accounting reuses sk_rcvbuf as both a hard memory limit
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 516087c622ad..0383ee8d3b78 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5275,6 +5275,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd_scaling_ratio);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_mwnd_seq);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_tstamp);
-- 
2.43.0

