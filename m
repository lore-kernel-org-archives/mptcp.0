Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94438553D
	for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519291; cv=none; b=X+gAFDeZqofik2yomoljdUyn7uP8/Kbz7yA9mV+nsWZyXad5zTm7ss0Q3tueK9KlGeMRJT0HfQgyhjr4MLmlaHMN/YLzH2M9yUye/FZqDYJOXXFgAl9F8qwTDlQIS/x2hb/ZvdpMPxnezwg7tvzUGUhcnOi43FuFOfIiu+emX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519291; c=relaxed/simple;
	bh=7izhNqLY7+iqpp+D5zcP+czL6od/LnGYqCsmQoSJSu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Seac3XxSH24DLtwY1pd601Xrzf27+tKKXM/JcA7F2N20m4uZYy+pRpRn7WIxauz96vRpogs8jDYVrSLlXs7tH/iz2qax99jBqUmjBeYM7MW1wO3OMZjBv7hlzjH3VTI+hP1O599/3Vmd3rs85iGuLkW0GDBs9JUF64ITJ1nxy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFoEiCOM; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFoEiCOM"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40974bf7781so3244009fac.0
        for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 13:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519289; x=1774124089; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOOOdlrS2+fu1x+v8Rmi5MAUGmJW2DC+1z1Ah1tHPHA=;
        b=VFoEiCOM2YcyAxVCFKRJ/TI39aDTiHG+a4nVSemZ1nIRBvdZB8V60fxiGVeLWl4bUY
         zJYlFGpzgqUU+vh7obOsiCixWOBkFxWexhwGdIJ1+TGZG+IgJtM6rFgHcdj95+WBYkHp
         J0IEUAcBXBX6nkTFSMC+TBSMyzAvMTttOk+8pIYSB0hkfjsgTYnQMcJQcKZ7yDJQthlm
         +60eJqc7N77oEcqN6m9gEb1Qg9IN98KRxo/2NcOUetNQRTUakpJAoSvthLsBNbv/Ay5c
         j5vLevf+Ia16PwSKYKYKXn3+HAWtZYuGe14iCtS7cXwjMWkCySjwYpzWjcK3hBupX9CY
         qonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519289; x=1774124089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fOOOdlrS2+fu1x+v8Rmi5MAUGmJW2DC+1z1Ah1tHPHA=;
        b=BljsGK7A7GBzNomtA6bDgO+IHYwz7Dh7Pr7OSIPKzRUsW4CFLLrPx+qAI4/V+mg8pe
         /xYAgKIqyNKb3pk6R5Fyj7d8Jw39b6dwCL00oxSOtzXZ+H8WT2P5w8GB+ghdatFbODNW
         f0AHwB5gTt1FYdUTK91h8h6wLKTI0IffsZHmDOBEJqipUXCCP/S+fElr8BoENdbk7iaM
         VWI6PF6HZ7jYY7qPc8vJNVgXGFyzqhHoPjmdsPoAgsk0kPU4vOufvnS2bO5KiwaUOPER
         S/rZGmXCK1sq5xD1Fzqqaq6wb0D6hk/538q/QSsUNL3zFhT7xxO4hme+P5MjxRXGGfg8
         qrmA==
X-Forwarded-Encrypted: i=1; AJvYcCXSKWc47imAf6Nw2Adcsvvd6DnAcHPqUdgn52vWavExY9D8qksmr6rxvU/5uHwwzlvLwo1egA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqqvMdnufrcrZY7GQkmT3Y/OWxQvQ9qcX6DcnffhF954QaAbfg
	KsCu5gbE9a60KDtTxYXkRnyNUXs0PTWdu6zim/QDhJnhwkDsX0ujj8GB
X-Gm-Gg: ATEYQzxTWbwdcgxbLQ48D2E3Nnd2LPCGSRb1rs1J3Zx1DpoYzvUoQS10oSydzRs26Vq
	YFXR8quAP2c4cPz60c2AHpaR+0fCAqjRegcXGO8/8pxlQKbO/fQwVUzBm11eZ1ytMIsx6fctMNX
	9PXezba3+c6x2Us3KWCuUYaIpGHzv8dRTlw3u/84a91gbdWIx2puisGs8R86gusjyvQ/OSVsWfY
	1T1USquu4QfFQKwiC26zOjKLEbY4/rS/b0ruApZjJboPA1MTSQtZ5hruWSdMvRMJDnD7ADJPLIl
	e/AawYm7xu4dcFlZc3W7ajBaLbjDsW8YhTMSL5fEd+5VZcCbGQN8MHmwSjey8kMyJAkQUqqWIEV
	bfPxQZbBAchCXFSmDmtGmNwuK0cWVTu21VotgcrJz4EzobE0tvbb8Z2oT4TeLxVs2kNSsPdiA22
	UIlCnnTVuF8tMMoGNMBrPW63qtK0xGwWB9G4s/IHyeqSeAL5cedbZ6pU6qZd71jq8JEOsjKi5q6
	xVvXpoGFhX6QLDDM+c7NjOPSZEgGTUCgtrNO9mw
X-Received: by 2002:a05:6870:7d86:b0:40a:5870:98bb with SMTP id 586e51a60fabf-4179911cfccmr6459609fac.21.1773519288902;
        Sat, 14 Mar 2026 13:14:48 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:48 -0700 (PDT)
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
Subject: [PATCH net-next v2 05/14] tcp: grow rcvbuf to back scaled-window quantization slack
Date: Sat, 14 Mar 2026 14:13:39 -0600
Message-ID: <20260314201348.1786972-6-atwellwea@gmail.com>
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

Teach TCP to grow sk_rcvbuf when scale rounding would otherwise expose
more sender-visible window than the current hard receive-memory backing
can cover.

The new helper keeps backlog and memory-pressure limits in the same
units as the rest of the receive path, while __tcp_select_window()
backs any rounding slack before advertising it.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 include/net/tcp.h     | 12 ++++++++++++
 net/ipv4/tcp_input.c  | 36 ++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp_output.c | 15 +++++++++++++--
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index fc22ab6b80d5..5b479ad44f89 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -397,6 +397,7 @@ int tcp_ioctl(struct sock *sk, int cmd, int *karg);
 enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
 void tcp_rcvbuf_grow(struct sock *sk, u32 newval);
+bool tcp_try_grow_rcvbuf(struct sock *sk, int needed);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
@@ -1844,6 +1845,17 @@ static inline int tcp_rwnd_avail(const struct sock *sk)
 	return tcp_rmem_avail(sk) - READ_ONCE(sk->sk_backlog.len);
 }
 
+/* Passive children clone the listener's sk_socket until accept() grafts
+ * their own struct socket, so only sockets that point back to themselves
+ * should autotune receive-buffer backing.
+ */
+static inline bool tcp_rcvbuf_grow_allowed(const struct sock *sk)
+{
+	struct socket *sock = READ_ONCE(sk->sk_socket);
+
+	return sock && READ_ONCE(sock->sk) == sk;
+}
+
 /* Note: caller must be prepared to deal with negative returns */
 static inline int tcp_space(const struct sock *sk)
 {
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 352f814a4ff6..32256519a085 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -774,6 +774,38 @@ static void tcp_init_buffer_space(struct sock *sk)
 				    (u32)TCP_INIT_CWND * tp->advmss);
 }
 
+/* Try to grow sk_rcvbuf so the hard receive-memory limit covers @needed
+ * bytes beyond sk_rmem_alloc while preserving sender-visible headroom
+ * already consumed by sk_backlog.len.
+ */
+bool tcp_try_grow_rcvbuf(struct sock *sk, int needed)
+{
+	struct net *net = sock_net(sk);
+	int backlog;
+	int rmem2;
+	int target;
+
+	needed = max(needed, 0);
+	backlog = READ_ONCE(sk->sk_backlog.len);
+	target = tcp_rmem_used(sk) + backlog + needed;
+
+	if (target <= READ_ONCE(sk->sk_rcvbuf))
+		return true;
+
+	rmem2 = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
+	if (READ_ONCE(sk->sk_rcvbuf) >= rmem2 ||
+	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK) ||
+	    tcp_under_memory_pressure(sk) ||
+	    sk_memory_allocated(sk) >= sk_prot_mem_limits(sk, 0))
+		return false;
+
+	WRITE_ONCE(sk->sk_rcvbuf,
+		   min_t(int, rmem2,
+			 max_t(int, READ_ONCE(sk->sk_rcvbuf), target)));
+
+	return target <= READ_ONCE(sk->sk_rcvbuf);
+}
+
 /* 4. Recalculate window clamp after socket hit its memory bounds. */
 static void tcp_clamp_window(struct sock *sk)
 {
@@ -785,14 +817,14 @@ static void tcp_clamp_window(struct sock *sk)
 	icsk->icsk_ack.quick = 0;
 	rmem2 = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
 
-	if (sk->sk_rcvbuf < rmem2 &&
+	if (READ_ONCE(sk->sk_rcvbuf) < rmem2 &&
 	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK) &&
 	    !tcp_under_memory_pressure(sk) &&
 	    sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)) {
 		WRITE_ONCE(sk->sk_rcvbuf,
 			   min(atomic_read(&sk->sk_rmem_alloc), rmem2));
 	}
-	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+	if (atomic_read(&sk->sk_rmem_alloc) > READ_ONCE(sk->sk_rcvbuf))
 		tp->rcv_ssthresh = min(tp->window_clamp, 2U * tp->advmss);
 }
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 57a2a6daaad3..53781cf591d2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3375,13 +3375,24 @@ u32 __tcp_select_window(struct sock *sk)
 	 * scaled window will not line up with the MSS boundary anyway.
 	 */
 	if (tp->rx_opt.rcv_wscale) {
+		int rcv_wscale = 1 << tp->rx_opt.rcv_wscale;
+
 		window = free_space;
 
 		/* Advertise enough space so that it won't get scaled away.
-		 * Import case: prevent zero window announcement if
+		 * Important case: prevent zero-window announcement if
 		 * 1<<rcv_wscale > mss.
 		 */
-		window = ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
+		window = ALIGN(window, rcv_wscale);
+
+		/* Back any scale-quantization slack before we expose it.
+		 * Otherwise tcp_can_ingest() can reject data which is still
+		 * within the sender-visible window.
+		 */
+		if (window > free_space &&
+		    (!tcp_rcvbuf_grow_allowed(sk) ||
+		     !tcp_try_grow_rcvbuf(sk, tcp_space_from_win(sk, window))))
+			window = round_down(free_space, rcv_wscale);
 	} else {
 		window = tp->rcv_wnd;
 		/* Get the largest window that is a nice multiple of mss.
-- 
2.43.0

