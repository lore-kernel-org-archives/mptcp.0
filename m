Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B975675F
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215284; cv=none; b=jdJ7GoHEQJRfGW91WCNhlDAEOljm+7WUrHHHhF7PoQbwPh7YUKoztYla1pnNyxudtdmDDqTW1nD2jkS11BexnsiDW2eA0+H++MO3j/BElsvgUHIvTUBBPbm8EUGCuf44n6ODJXt3GveunrEWyMHZEmA4V0Wr5nF1X+y1C0jZugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215284; c=relaxed/simple;
	bh=YgH7PNDq2UKgRlZCizRqIh8Ox9j5Glvhxit1f34YJOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pWS6mF7tdSFuOlqqTZfc2JFs5sbYh/dPc0kC+6n8khj3qZGrnEjt6WeA6Fg/tBoW23wPX1ExGX/VpYDdx793Hs2jNMh0Q339zfLiUCLawIfJORNiuwLgZPFD2Utnip7aXYGlypNkAxzHsyNuw+14lfZ6+zHOmc76x1BK+LvZaMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frjQZKNS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frjQZKNS"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2232e30f4so5741645ad.2
        for <mptcp@lists.linux.dev>; Thu, 04 Apr 2024 00:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712215282; x=1712820082; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPoCku/Cj+pJg+VDGr/a/+x9R0CpfMJJYCKZx5paLck=;
        b=frjQZKNSJyQ6i7fj9mM2JiYYjTIG6kEyDrHLNO25DA5Kqrs9lhIjd0+4Q4LibU0LNx
         nLUKA/mzXTHH9RcqC4uHYDNHk3zxOUMjk9BTytj8GnMkIhkfbp5H/ay3pUb7rrPaFZjn
         GnASBMWW4dYUiVFoLhn7rigLCJU1/C0AdyqvcWfmzW6vhoEwN63BovRjO99fJy4I7mFF
         5aGB3MUCFZFbeZRmNRGu1ritM54ZrCJNw6pFygfWd6kFzciSDtbsPKbNMigujxa8ktfr
         tTAqFJ7ACyJbGYBFqo1A5F6d1HBMcNnCtIuUPrRkv3XVRnsdVOhArdhGWQb0o8ZF6p2k
         yZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215282; x=1712820082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPoCku/Cj+pJg+VDGr/a/+x9R0CpfMJJYCKZx5paLck=;
        b=a4uWt1lH/oAn/AMKRUclt8TbkUTTfh/Dm/Y3DIDPnEREc5noesHgP55xKUdXmsczWF
         1PPX/i2/die6hZ6KcocKaI+3jm6Ho75crCCQlTXxS4lKX0xRaHjidKOKRXxgLcm/gP/J
         Taii+M2oyfZlM4C2SHOoBcBd1m5TdtJwIkuuhp+dDv4qO3fU0BmCcYMow/392pzxaUY2
         5HYJND/0VbJh4YTkgmjB2mRtVpdrrUfds1vOBFjfpPgqF/haV3GCxLxP5cnS7mmA7jXs
         Gw36XEOCiLhPpRoIE7+M5+tHNZdSabmxX3ojchyzsyC3q9+I4EuXHUF2qlexTym4e8Ch
         k2IA==
X-Gm-Message-State: AOJu0Yx3J1RoQDlJmCDFRJhxCoegWSZFrGgPKWHRWyZGIa9+TtSgDx7U
	YcicIz9OYbrrEHcp+um26gJo+Uzr9mrc2+RdYRYn+SZP5F5bMx0Z
X-Google-Smtp-Source: AGHT+IH6JbvcvXpnmsgCrgIsfcpqjjyYJH9gAn+c7kSaILqCvMyZhf4X/rygtxqAe0AuAaJzibPDUw==
X-Received: by 2002:a17:902:d2c1:b0:1e0:b87f:beb4 with SMTP id n1-20020a170902d2c100b001e0b87fbeb4mr1449318plc.30.1712215282488;
        Thu, 04 Apr 2024 00:21:22 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709029a8200b001db5b39635dsm14606399plp.277.2024.04.04.00.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:21:21 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 3/6] rstreason: prepare for active reset
Date: Thu,  4 Apr 2024 15:20:44 +0800
Message-Id: <20240404072047.11490-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240404072047.11490-1-kerneljasonxing@gmail.com>
References: <20240404072047.11490-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Like what we did to passive reset:
only passing possible reset reason in each active reset path.

No functional changes.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/tcp.h     |  2 +-
 net/ipv4/tcp.c        | 15 ++++++++++-----
 net/ipv4/tcp_output.c |  2 +-
 net/ipv4/tcp_timer.c  |  9 ++++++---
 net/mptcp/protocol.c  |  4 +++-
 net/mptcp/subflow.c   |  5 +++--
 6 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9ab5b37e9d53..67ab4dbf7805 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -667,7 +667,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 void tcp_send_probe0(struct sock *);
 int tcp_write_wakeup(struct sock *, int mib);
 void tcp_send_fin(struct sock *sk);
-void tcp_send_active_reset(struct sock *sk, gfp_t priority);
+void tcp_send_active_reset(struct sock *sk, gfp_t priority, int reason);
 int tcp_send_synack(struct sock *);
 void tcp_push_one(struct sock *, unsigned int mss_now);
 void __tcp_send_ack(struct sock *sk, u32 rcv_nxt);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e767721b3a58..eacfe0012977 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -275,6 +275,7 @@
 #include <net/xfrm.h>
 #include <net/ip.h>
 #include <net/sock.h>
+#include <net/rstreason.h>
 
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
@@ -2805,7 +2806,8 @@ void __tcp_close(struct sock *sk, long timeout)
 		/* Unread data was tossed, zap the connection. */
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONCLOSE);
 		tcp_set_state(sk, TCP_CLOSE);
-		tcp_send_active_reset(sk, sk->sk_allocation);
+		tcp_send_active_reset(sk, sk->sk_allocation,
+				      SK_RST_REASON_NOT_SPECIFIED);
 	} else if (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime) {
 		/* Check zero linger _after_ checking for unread data. */
 		sk->sk_prot->disconnect(sk, 0);
@@ -2879,7 +2881,8 @@ void __tcp_close(struct sock *sk, long timeout)
 		struct tcp_sock *tp = tcp_sk(sk);
 		if (READ_ONCE(tp->linger2) < 0) {
 			tcp_set_state(sk, TCP_CLOSE);
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 			__NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_TCPABORTONLINGER);
 		} else {
@@ -2897,7 +2900,8 @@ void __tcp_close(struct sock *sk, long timeout)
 	if (sk->sk_state != TCP_CLOSE) {
 		if (tcp_check_oom(sk, 0)) {
 			tcp_set_state(sk, TCP_CLOSE);
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 			__NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_TCPABORTONMEMORY);
 		} else if (!check_net(sock_net(sk))) {
@@ -3001,7 +3005,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 		/* The last check adjusts for discrepancy of Linux wrt. RFC
 		 * states
 		 */
-		tcp_send_active_reset(sk, gfp_any());
+		tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_NOT_SPECIFIED);
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	} else if (old_state == TCP_SYN_SENT)
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
@@ -4557,7 +4561,8 @@ int tcp_abort(struct sock *sk, int err)
 		smp_wmb();
 		sk_error_report(sk);
 		if (tcp_need_reset(sk->sk_state))
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 		tcp_done(sk);
 	}
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e3167ad96567..18fbbad2028a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3583,7 +3583,7 @@ void tcp_send_fin(struct sock *sk)
  * was unread data in the receive queue.  This behavior is recommended
  * by RFC 2525, section 2.17.  -DaveM
  */
-void tcp_send_active_reset(struct sock *sk, gfp_t priority)
+void tcp_send_active_reset(struct sock *sk, gfp_t priority, int reason)
 {
 	struct sk_buff *skb;
 
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 976db57b95d4..83fe7f62f7f1 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/gfp.h>
 #include <net/tcp.h>
+#include <net/rstreason.h>
 
 static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
 {
@@ -127,7 +128,8 @@ static int tcp_out_of_resources(struct sock *sk, bool do_reset)
 		    (!tp->snd_wnd && !tp->packets_out))
 			do_reset = true;
 		if (do_reset)
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 		tcp_done(sk);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONMEMORY);
 		return 1;
@@ -768,7 +770,7 @@ static void tcp_keepalive_timer (struct timer_list *t)
 				goto out;
 			}
 		}
-		tcp_send_active_reset(sk, GFP_ATOMIC);
+		tcp_send_active_reset(sk, GFP_ATOMIC, SK_RST_REASON_NOT_SPECIFIED);
 		goto death;
 	}
 
@@ -795,7 +797,8 @@ static void tcp_keepalive_timer (struct timer_list *t)
 		    icsk->icsk_probes_out > 0) ||
 		    (user_timeout == 0 &&
 		    icsk->icsk_probes_out >= keepalive_probes(tp))) {
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 			tcp_write_err(sk);
 			goto out;
 		}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3a1967bc7bad..836fd054eca4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -21,6 +21,7 @@
 #endif
 #include <net/mptcp.h>
 #include <net/xfrm.h>
+#include <net/rstreason.h>
 #include <asm/ioctls.h>
 #include "protocol.h"
 #include "mib.h"
@@ -2565,7 +2566,8 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 
 		slow = lock_sock_fast(tcp_sk);
 		if (tcp_sk->sk_state != TCP_CLOSE) {
-			tcp_send_active_reset(tcp_sk, GFP_ATOMIC);
+			tcp_send_active_reset(tcp_sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 			tcp_set_state(tcp_sk, TCP_CLOSE);
 		}
 		unlock_sock_fast(tcp_sk, slow);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3b1c13136908..a68d5d0f3e2a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -407,7 +407,7 @@ void mptcp_subflow_reset(struct sock *ssk)
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
-	tcp_send_active_reset(ssk, GFP_ATOMIC);
+	tcp_send_active_reset(ssk, GFP_ATOMIC, SK_RST_REASON_NOT_SPECIFIED);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
 		mptcp_schedule_work(sk);
@@ -1336,7 +1336,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			tcp_set_state(ssk, TCP_CLOSE);
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
-			tcp_send_active_reset(ssk, GFP_ATOMIC);
+			tcp_send_active_reset(ssk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 			WRITE_ONCE(subflow->data_avail, false);
 			return false;
 		}
-- 
2.37.3

