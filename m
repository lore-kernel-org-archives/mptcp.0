Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D970A386457
	for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519290; cv=none; b=g8sKnNxAEC6RtD8ivVSKHgh1BFf//bNc3u4vlBggaUNaJYz7Km25o0aPOOjpU5woThhitm3q9ZNblFwaeC0ih47cL1hhzHRw8I5hflpQTzKc8gxxdgH8Ud0gkKsznCBGcFOlHoO3TzcefXuRb4JPBhaQa+GYzjhL/cxdo5YZlKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519290; c=relaxed/simple;
	bh=2EkRqoGXrOUfHB63oRGb5TDy5HRb1y3sBh+IDjMEZ3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/NN2DyjukGXRwMvC7aPPsgI0QnO1+1h3TkWPN0WZ4MAtSzyfMl3EenPCTcAvU31oXqfQ0u3khx4TE2E4gT82aS1cOvuzlAWPjzHzSeORQO50BmwKfeuDMxZeGUr2fQoNOyJ97vYL9c9ONYLB3Zhhy+s/XYFzKslcTcg3ffBEBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPvUubli; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPvUubli"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-46704fbf62dso2144280b6e.1
        for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519287; x=1774124087; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTjO+z47PYHq3eZ5eRulxWts7U/pAeGFmyBg9Cf0dZo=;
        b=GPvUubliQBIWrFJ3pKz83VLqZb0ZVkf87BlvGmqGjTENhRcvtVWP5hj7MXcXshlfOC
         Qfi/Vpsp+/fBEdVDGDlDE2/fHGdHkKfhcdoonp9ac6vWXuNlAkrIevzROPW0ddo3p/AL
         Z5o8sYM27LmrtJeaOtszYVFr+nrB/wpXzjaV5NpAIRG72ZXD8PMDj66oMm2BMsN9AJNd
         Pql1f/QU5q7g4qLEsT/QQe04DUmUwbkaVYg+5YkBFpJXtXbSQKLPpQfs8jGDAwRWcZjT
         n2KTBMYcvKXBGNs4ScxtpKQMSuttKJKAz62BQWTV6tI21FlknjhlYO4G/mnXpgkkRAt7
         POkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519287; x=1774124087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RTjO+z47PYHq3eZ5eRulxWts7U/pAeGFmyBg9Cf0dZo=;
        b=LNcAHVJIwblZQtscf/c978sEbEylhtrW9rhPPT+Fm90fHHzc2dUDoDM2jjy7Ig3RiF
         CU7rlj860lhmIfaM/WIDyCeDQrXSoOV42Siz1/8jnkmM2ZVt/Z66xzCLvF0v1zP8HQ4V
         DIPehOlFybl5MrNh9vOwL5fuvhrDPeVUCnxxoCZ2b7In53RTZlZyIn0YMjtIaA/uSIls
         DtFEahjnEUt55gqNVciOTQF+XHtoqSLuX/ewPuleaYg7LF2eLxohla32FwPqd2hv8BLc
         4hxVqEvxalo2lHMmw8UvAd8LF3rKYi+Qq66vMm/9SuM9qFdqEi1XTeE0r7gYHkW6mO02
         ZOVg==
X-Forwarded-Encrypted: i=1; AJvYcCWDI/vs0H6XOLcBx+QzzxfdCK8Ka4Vhpx32Z6FNR03+hRtwUsJzPTochqlSpvKdkvWEftJ6Yg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywv5aXUNLd5/TqeMLghe/qGdyfN9AyOIWgkoJnZANmoH4+nZX0h
	tFjWBiSKqb7le/tr25cyXS7dV4pHuJIWdnlFS+Ku7nvDAXsKg3uqUWDW
X-Gm-Gg: ATEYQzwkxptuqWrWxdnEG/GOmW+sZRztW/vw2P8dTywl4gVNDH5JIZwh4o1Bxwp3P4n
	uCrAnCqDQunmI7bR53KpYQlSYPH6rImdKqKvt1+BXHl62bhJKHfvkyAAXSlXDo8rh5sDYIiSndw
	qIGHlH064592dJAR5BRYSC0pBJ6XYZ+dXd8asZ5+FtM15NPKV92b/x2lDP8T+eP/vmoLHdXrEGF
	tJTJAvxGYchyfbc0OfrvlC0rfs2ZDRuH8WbnaNNJ2OtlDoHCLQov80yLQP1CVmJbwMmx/QhWPbU
	wbJyAYexcKH7uNMXrIou7WpZxoKW8rhDPvqNLJIiDjdjnIPFApapf2PeO2hbqI0IMPxXrTPNgCo
	mFLS+E9FEv+6oQTprxVLHhU0iYt/F1C532wmncG/1Mg770k+GZTVkCrghVuDyHIdca9/Nk57W1O
	aEuj8HzjFk/ULZpuMjaLgwHxDgerd8mASMTd9nF0anf45JYOie/uDGgwld1UOPC7QpZYW6mPnih
	Faz0XZpRwI7QOejJQVe46HN4QDG9R6CT7K4AHqH3ZO3n5MbD9k=
X-Received: by 2002:a05:6808:23d1:b0:467:15ad:9de5 with SMTP id 5614622812f47-467570a27f2mr4101052b6e.13.1773519287456;
        Sat, 14 Mar 2026 13:14:47 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:47 -0700 (PDT)
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
Subject: [PATCH net-next v2 04/14] tcp: snapshot the maximum advertised receive window
Date: Sat, 14 Mar 2026 14:13:38 -0600
Message-ID: <20260314201348.1786972-5-atwellwea@gmail.com>
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

Track the maximum sender-visible receive-window right edge separately
from the live rwnd, along with the scaling basis that was in force when
that larger window was advertised.

This gives later admission and restore paths enough information to
reason about retracted windows without losing the original sender-
visible bound.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 include/net/tcp.h                             | 21 ++++++++++++++++++-
 net/ipv4/tcp.c                                |  1 +
 net/ipv4/tcp_fastopen.c                       |  2 +-
 net/ipv4/tcp_input.c                          |  4 ++--
 net/ipv4/tcp_minisocks.c                      |  2 +-
 net/ipv4/tcp_output.c                         |  2 +-
 8 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 09ece1c59c2d..d58a3b1eb55d 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -11,6 +11,7 @@ Type                          Name                    fastpath_tx_access  fastpa
 struct inet_connection_sock   inet_conn
 u16                           tcp_header_len          read_mostly         read_mostly         tcp_bound_to_half_wnd,tcp_current_mss(tx);tcp_rcv_established(rx)
 u16                           gso_segs                read_mostly                             tcp_xmit_size_goal
+u8                            rcv_mwnd_scaling_ratio  read_write          read_mostly         tcp_init_max_rcv_wnd_seq,tcp_update_max_rcv_wnd_seq,tcp_repair_set_window,do_tcp_getsockopt
 u8                            rcv_wnd_scaling_ratio   read_write          read_mostly         tcp_set_rcv_wnd,tcp_can_ingest,tcp_repair_set_window,do_tcp_getsockopt
 __be32                        pred_flags              read_write          read_mostly         tcp_select_window(tx);tcp_rcv_established(rx)
 u64                           bytes_received                              read_write          tcp_rcv_nxt_update(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 2ace563d59d6..e5d7a65ac439 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -297,6 +297,7 @@ struct tcp_sock {
 		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
 		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
 		prev_ecnfield:2; /* ECN bits from the previous segment */
+	u8	rcv_mwnd_scaling_ratio; /* 0 if unknown, else tp->rcv_mwnd_seq basis */
 	u8	rcv_wnd_scaling_ratio; /* 0 if unknown, else tp->rcv_wnd basis */
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6fa7cdb0979e..fc22ab6b80d5 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -947,13 +947,21 @@ static inline u32 tcp_max_receive_window(const struct tcp_sock *tp)
 	return (u32) win;
 }
 
+static inline void tcp_init_max_rcv_wnd_seq(struct tcp_sock *tp)
+{
+	tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
+	tp->rcv_mwnd_scaling_ratio = tp->rcv_wnd_scaling_ratio;
+}
+
 /* Check if we need to update the maximum receive window sequence number */
 static inline void tcp_update_max_rcv_wnd_seq(struct tcp_sock *tp)
 {
 	u32 wre = tp->rcv_wup + tp->rcv_wnd;
 
-	if (after(wre, tp->rcv_mwnd_seq))
+	if (after(wre, tp->rcv_mwnd_seq)) {
 		tp->rcv_mwnd_seq = wre;
+		tp->rcv_mwnd_scaling_ratio = tp->rcv_wnd_scaling_ratio;
+	}
 }
 
 /* Choose a new window, without checks for shrinking, and without
@@ -1766,6 +1774,16 @@ static inline bool tcp_space_from_rcv_wnd(const struct tcp_sock *tp, int win,
 					   space);
 }
 
+/* Same as tcp_space_from_rcv_wnd(), but for the remembered maximum
+ * sender-visible receive window.
+ */
+static inline bool tcp_space_from_rcv_mwnd(const struct tcp_sock *tp, int win,
+					   int *space)
+{
+	return tcp_space_from_wnd_snapshot(tp->rcv_mwnd_scaling_ratio, win,
+					   space);
+}
+
 /* Assume a 50% default for skb->len/skb->truesize ratio.
  * This may be adjusted later in tcp_measure_rcv_mss().
  */
@@ -1776,6 +1794,7 @@ static inline void tcp_scaling_ratio_init(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	tp->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
+	tp->rcv_mwnd_scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 	tp->rcv_wnd_scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 }
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0383ee8d3b78..66706dbb90f5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5275,6 +5275,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_mwnd_scaling_ratio);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd_scaling_ratio);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_mwnd_seq);
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 4e389d609f91..56113cf2a165 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -377,7 +377,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 
 	tcp_rsk(req)->rcv_nxt = tp->rcv_nxt;
 	tp->rcv_wup = tp->rcv_nxt;
-	tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
+	tcp_init_max_rcv_wnd_seq(tp);
 	/* tcp_conn_request() is sending the SYNACK,
 	 * and queues the child into listener accept queue.
 	 */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index b8e65e31255e..352f814a4ff6 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6902,7 +6902,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 		WRITE_ONCE(tp->rcv_nxt, TCP_SKB_CB(skb)->seq + 1);
 		tp->rcv_wup = TCP_SKB_CB(skb)->seq + 1;
-		tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
+		tcp_init_max_rcv_wnd_seq(tp);
 
 		/* RFC1323: The window in SYN & SYN/ACK segments is
 		 * never scaled.
@@ -7015,7 +7015,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		WRITE_ONCE(tp->rcv_nxt, TCP_SKB_CB(skb)->seq + 1);
 		WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
 		tp->rcv_wup = TCP_SKB_CB(skb)->seq + 1;
-		tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
+		tcp_init_max_rcv_wnd_seq(tp);
 
 		/* RFC1323: The window in SYN & SYN/ACK segments is
 		 * never scaled.
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 1c02c9cd13fe..85bd9580caf9 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -604,7 +604,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->window_clamp = req->rsk_window_clamp;
 	newtp->rcv_ssthresh = req->rsk_rcv_wnd;
 	tcp_set_rcv_wnd(newtp, req->rsk_rcv_wnd);
-	newtp->rcv_mwnd_seq = newtp->rcv_wup + req->rsk_rcv_wnd;
+	tcp_init_max_rcv_wnd_seq(newtp);
 	newtp->rx_opt.wscale_ok = ireq->wscale_ok;
 	if (newtp->rx_opt.wscale_ok) {
 		newtp->rx_opt.snd_wscale = ireq->snd_wscale;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0b082726d7c4..57a2a6daaad3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4171,7 +4171,7 @@ static void tcp_connect_init(struct sock *sk)
 	else
 		tp->rcv_tstamp = tcp_jiffies32;
 	tp->rcv_wup = tp->rcv_nxt;
-	tp->rcv_mwnd_seq = tp->rcv_nxt + tp->rcv_wnd;
+	tcp_init_max_rcv_wnd_seq(tp);
 	WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
 
 	inet_csk(sk)->icsk_rto = tcp_timeout_init(sk);
-- 
2.43.0

