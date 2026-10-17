Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA5F4CF465
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 05:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214618; cv=none; b=fKL+OdOVrsgrfxv+p0bcdr1Y8WJlgOdPLlU+30wTeGGcXDrGC/tA0MH9CS2mL4I1xYC0eQ0b+S+EdygcZHhspuORRGhwu/mOW+W6kVpUodH5KlLEdaQwjGdu9OU8ZtOzhe7byychC2DN3bT4phTLdeTY0gFRrTlgQgQCk6epp/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214618; c=relaxed/simple;
	bh=n6NGx3wEyKChfuVLydLQwdPpVoxK3dr032bGQzcI9cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=exGVlsKFxupyGrCC1NboMuQMlMex5w8DCe8EyahPpLsCi9MDnd9bDpnfjnwQWHpB4RSrzht51ZJUsN0CERf891p7wRt2oM+nuNGReRO7+dThvGALxsGIEgMmrx9T7bEeg2tUkWWnOrICRPxJ7ISR3rXSowXZhbk83woE7a4qqi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqFEj5ki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqFEj5ki"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30EACC2BCF5;
	Sat, 17 Oct 2026 05:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792214618;
	bh=n6NGx3wEyKChfuVLydLQwdPpVoxK3dr032bGQzcI9cE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=sqFEj5kid73jZh/x1NcZRU6o8YCAd6yaxK/j4l/Ts6jNES4CWzzvZDBcI6QAKXiXD
	 kGCOHA30+UQ2DzntIIgmVdtr2GA3fw59dIFKamlhgsqnRL3E7pcfJSvHb67B7+gXUK
	 28BSvFBeYqwXDiXL06pTzg+wxKuTN9Gh1MyDtM+J2FyJyoyXdnp1fCo8xZ6UNi1U+2
	 C+3oeDhfp8+RC3hPYGeHYrAFu2GZCBUC+7RyGH0V+z9pzkDdoxMgx4iToGUPQPBzKR
	 o4ob6CGG56ieFlTl+wTIf+sqQDnVmuGWyOlu464rL3RAgH/5k3sVvcM5wL8RHDJzR5
	 qPxdzYr49KDow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07154CCA462;
	Sat, 17 Oct 2026 05:23:38 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Fri, 16 Oct 2026 22:23:34 -0700
Subject: [PATCH mptcp-net v2] mptcp: annotate lockless access to
 msk->scaling_ratio
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-t-mptcp-scaling-ratio-kcsan-v2-1-241d1f92dcf1@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBREr0L+2m9oY4m68h6GRSkf+Cpt01aiI
 dzdAhdwOZmZNzNDpMAU4VrMEGjiyM5mIQ8FmEHbnpDbrEGWshKlUJhw9Ml4jEa/2PYYdGKHTxO
 1xYvoGtmpKmdbyAQfqOPPRr/DXrOUoN6t+G4eZNJKX8MDx+TCd3syia3y1+gkUGDbiFPVKXUuJ
 d18cMnZ40hQL8vyAxNNiFbjAAAA
X-Change-ID: 20261015-t-mptcp-scaling-ratio-kcsan-91fb2f56026d
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792214616; l=5121;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=yXU9VnKdVKJB0AfOe5oGUZ4r2mM8apoPRCnDoqsgx3A=;
 b=Yu+VMjL2t0BfJUna3fOgGhi1K+VY1Lpttp2HJbDNt3Xt4fArNO8tQb0DtuvjPjrpSyC7Jut/u
 U4gUx5V8/yxBpcycB4kh+MS9OfBGud9LJj1oIeyZkfS8SZu2S45BG2f
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

mptcp_rcv_rtt_update() writes msk->scaling_ratio from BH while holding
the msk data lock (sk->sk_lock.slock). mptcp_cleanup_rbuf() reads the
same byte via mptcp_win_from_space() after mptcp_release_cb() drops
that lock, so it can run concurrently with the RX path.

KCSAN reports:

  BUG: KCSAN: data-race in mptcp_cleanup_rbuf / mptcp_data_ready

  write to 0xffff888014978790 of 1 bytes by interrupt on cpu 1:
   mptcp_rcv_rtt_update net/mptcp/protocol.c:1045 [inline]
   mptcp_data_ready+0x1c1/0x4d0 net/mptcp/protocol.c:1062
   subflow_data_ready+0x271/0x350 net/mptcp/subflow.c:1536
   tcp_data_ready+0x92/0x2c0 net/ipv4/tcp_input.c:5604
   tcp_data_queue+0x1236/0x26c0 net/ipv4/tcp_input.c:5694
   tcp_rcv_established+0x695/0x1fb0 net/ipv4/tcp_input.c:6689
   tcp_v4_do_rcv+0x356/0x6e0 net/ipv4/tcp_ipv4.c:1854
   tcp_v4_rcv+0x1b04/0x26b0 net/ipv4/tcp_ipv4.c:2248

  read to 0xffff888014978790 of 1 bytes by task 2624 on cpu 0:
   mptcp_win_from_space net/mptcp/protocol.h:421 [inline]
   __mptcp_space net/mptcp/protocol.h:431 [inline]
   mptcp_cleanup_rbuf+0x8a/0x380 net/mptcp/protocol.c:680
   mptcp_release_cb+0x375/0x900 net/mptcp/protocol.c:3889
   release_sock+0x100/0x150 net/core/sock.c:3866
   sk_wait_data+0x141/0x2f0 net/core/sock.c:3314
   mptcp_recvmsg+0x6cd/0xd50 net/mptcp/protocol.c:2496

  value changed: 0xd0 -> 0xd5

  Reported by Kernel Concurrency Sanitizer on:
  CPU: 0 UID: 0 PID: 2624 Comm: syz.7.22 Not tainted 7.3.0-rc1-gbaff4b3d06ef #77 PREEMPT(full)

The u8 EWMA is used only to convert sk_rcvbuf occupancy into an
advertised window. A slightly stale ratio is acceptable, so annotate
the lockless accesses with READ_ONCE()/WRITE_ONCE() instead of
widening the data lock. Do the same in mptcp_space_from_win(), which
reads the same field from DRS and SO_RCVLOWAT.

Fixes: d2000361e4dd ("mptcp: better mptcp-level RTT estimator")
Reported-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/634
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
Changes in v2:
- add READ_ONCE in trace_mptcp_rcvbuf_grow, missed before
- Link to v1: https://patch.msgid.link/20261015-t-mptcp-scaling-ratio-kcsan-v1-1-db146f55802e@proton.me
---
 include/trace/events/mptcp.h |  2 +-
 net/mptcp/protocol.c         | 11 ++++++++---
 net/mptcp/protocol.h         |  6 ++++--
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 22882bd03459..c47fa2672b84 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -229,7 +229,7 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 		__entry->rcvbuf = sk->sk_rcvbuf;
 		__entry->rcv_wnd = atomic64_read(&msk->rcv_wnd_sent) -
 				   msk->ack_seq;
-		__entry->scaling_ratio = msk->scaling_ratio;
+		__entry->scaling_ratio = READ_ONCE(msk->scaling_ratio);
 		__entry->sport = ntohs(inet->inet_sport);
 		__entry->dport = ntohs(inet->inet_dport);
 		__entry->family = sk->sk_family;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 05c38564e8fd..ffd22849b719 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -988,6 +988,7 @@ static void mptcp_rcv_rtt_update(struct mptcp_sock *msk,
 {
 	const struct tcp_sock *tp = tcp_sk(subflow->tcp_sock);
 	u32 rtt_us = tp->rcv_rtt_est.rtt_us;
+	u8 scaling_ratio;
 	int id;
 
 	/* Update once per subflow per rcvwnd to avoid touching the msk
@@ -1004,9 +1005,13 @@ static void mptcp_rcv_rtt_update(struct mptcp_sock *msk,
 	if (++msk->rcv_rtt_est.next_sample == MPTCP_RTT_SAMPLES)
 		msk->rcv_rtt_est.next_sample = 0;
 
-	/* EWMA among the incoming subflows */
-	msk->scaling_ratio = ((msk->scaling_ratio << 3) - msk->scaling_ratio +
-			     tp->scaling_ratio) >> 3;
+	/* EWMA among the incoming subflows.
+	 * Pairs with READ_ONCE() in mptcp_win_from_space().
+	 */
+	scaling_ratio = READ_ONCE(msk->scaling_ratio);
+	WRITE_ONCE(msk->scaling_ratio,
+		   ((scaling_ratio << 3) - scaling_ratio +
+		    tp->scaling_ratio) >> 3);
 }
 
 void mptcp_data_ready(struct sock *sk, struct sock *ssk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4ed598febbf0..11e3c6db5e53 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -417,12 +417,14 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 
 static inline int mptcp_win_from_space(const struct sock *sk, int space)
 {
-	return __tcp_win_from_space(mptcp_sk(sk)->scaling_ratio, space);
+	return __tcp_win_from_space(READ_ONCE(mptcp_sk(sk)->scaling_ratio),
+				    space);
 }
 
 static inline int mptcp_space_from_win(const struct sock *sk, int win)
 {
-	return __tcp_space_from_win(mptcp_sk(sk)->scaling_ratio, win);
+	return __tcp_space_from_win(READ_ONCE(mptcp_sk(sk)->scaling_ratio),
+				    win);
 }
 
 static inline int __mptcp_space(const struct sock *sk)

---
base-commit: a22035be824449c4921ec406f6383089016a628c
change-id: 20261015-t-mptcp-scaling-ratio-kcsan-91fb2f56026d

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


