Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1289E12A16B
	for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267632; cv=none; b=MSwJG9FbfxREXiAF2fc8TPpK00rJPweReqT3mHujJWSJ89l0bnx8Q/z5yhuf0t88fgcba6tCo5Zm6lE4WU/+W3nNS6eiBF+WCooI4KuRHIdCnL28Tr7svxR4sQRyrzJ5Qdi4Q18Op6KTR089S5++dxOJYx1tmBSXSVj8GyO3YUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267632; c=relaxed/simple;
	bh=UQ8OKu/6XO1gzteA1wAsmRbCyz+zioVQYep7p/MIbLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FGbXtXXmZnQiOwE8f1tRVcdT6fPFeuwB1FTH0ZWipCs4u4o+6qfqKtQVodvyotIH2SP4CzgFrmYMPS4RQ/MFMXi4NqtApsSfegZV3B2YJXEroB4axalAbQ9Mlrz+nXB2JL9Vunui+H4RbNdYyLaDp0tji/9GN5Oln+xsFiLNFDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdgDD73K; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdgDD73K"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2351c03438cso221873fac.2
        for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 04:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713267630; x=1713872430; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLE5sB7nZh8FDwAJ64hDtj2qNR1n4lihjWtB4CW/Oiw=;
        b=VdgDD73Kcmmv9DWTAEXKrAJOQ+67Owu+Pb257hsWNjcxR4IRp76dosRmAWCp6zkmkb
         LSUQZdf6G3cymZlcugfbpq8S3A4p06mLjEreOlZNyR6lRNWviY66QBrynA6WLiPFdZGY
         d6R5DJeeYa2ClLlFhtNeLuz4QScFDxtt+bs7dOnneXQhUoWSR9wCiLdcXCOMf7Fv02OE
         g99eC27dU89bA8g/gmQl6VUCBemJydMCh9yzBltnfeM+EvRgpCjsexXahluuMi9vkeon
         IowscKZxnYzMiwHnYJ08nUb0uz8eBT/QSb5+h79e3jBFcpiRUJbL0YTmH8GzMJRyNOW6
         OT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267630; x=1713872430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLE5sB7nZh8FDwAJ64hDtj2qNR1n4lihjWtB4CW/Oiw=;
        b=PSIhqs+q5atRIwN8e/9h5cSd295kk5BJ3iqkpFmo8y51gwGJvSritXZVZhJVvtrG/s
         zSYkA3TZIxT1I1hZTXM73qDwB5dcEY2yheUT4p3oitep0quCsUt+U1tg/j+8tUYve/iT
         I02O5HPoJKHQNVckq2nnETsJCc1be5AAtjhTPLKpLbgxS1BF2+QfbefjWIGJEUCQz9BP
         wquLuH/ZjW7sBkw2Xu2P2xQ2HPN1QJKSPJItQDl8sEROti9OTFJ8M9YK1vOaVksmI7IN
         nTLSCclbOZIq5AgOG31dYu7Nf1PSfxLAUYp/2RlLfqrus5ZOgPd0bx7aXivcCRuDyaiW
         WoeA==
X-Gm-Message-State: AOJu0YyCs+g8DXniwrAFlJX5l/jFsCl/XHgHk6jeRQG7BcEvX0iCZNEq
	9Ncm4yTq/4sboyJc00TRaBiYwZgQuugJ8Y4QER3GQ/QWdF6o72Ec
X-Google-Smtp-Source: AGHT+IF8f1hedEYzgKnIzJLEf05JE1ZfB11qpMzmZ2ALmR5m2KQBEvmCEmaxO1n+It4VNfT0L1LpqA==
X-Received: by 2002:a05:6870:ac26:b0:22e:e46f:57e3 with SMTP id kw38-20020a056870ac2600b0022ee46f57e3mr13439076oab.35.1713267630129;
        Tue, 16 Apr 2024 04:40:30 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id a21-20020aa78655000000b006e6c16179dbsm8862045pfo.24.2024.04.16.04.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:40:29 -0700 (PDT)
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
Subject: [PATCH net-next v5 3/7] rstreason: prepare for active reset
Date: Tue, 16 Apr 2024 19:39:59 +0800
Message-Id: <20240416114003.62110-4-kerneljasonxing@gmail.com>
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

Like what we did to passive reset:
only passing possible reset reason in each active reset path.

No functional changes.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/tcp.h     |  3 ++-
 net/ipv4/tcp.c        | 15 ++++++++++-----
 net/ipv4/tcp_output.c |  3 ++-
 net/ipv4/tcp_timer.c  |  9 ++++++---
 net/mptcp/protocol.c  |  4 +++-
 net/mptcp/subflow.c   |  5 +++--
 6 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index b935e1ae4caf..adeacc9aa28a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -670,7 +670,8 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 void tcp_send_probe0(struct sock *);
 int tcp_write_wakeup(struct sock *, int mib);
 void tcp_send_fin(struct sock *sk);
-void tcp_send_active_reset(struct sock *sk, gfp_t priority);
+void tcp_send_active_reset(struct sock *sk, gfp_t priority,
+			   enum sk_rst_reason reason);
 int tcp_send_synack(struct sock *);
 void tcp_push_one(struct sock *, unsigned int mss_now);
 void __tcp_send_ack(struct sock *sk, u32 rcv_nxt);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f23b97777ea5..4ec0f4feee00 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -275,6 +275,7 @@
 #include <net/xfrm.h>
 #include <net/ip.h>
 #include <net/sock.h>
+#include <net/rstreason.h>
 
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
@@ -2811,7 +2812,8 @@ void __tcp_close(struct sock *sk, long timeout)
 		/* Unread data was tossed, zap the connection. */
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONCLOSE);
 		tcp_set_state(sk, TCP_CLOSE);
-		tcp_send_active_reset(sk, sk->sk_allocation);
+		tcp_send_active_reset(sk, sk->sk_allocation,
+				      SK_RST_REASON_NOT_SPECIFIED);
 	} else if (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime) {
 		/* Check zero linger _after_ checking for unread data. */
 		sk->sk_prot->disconnect(sk, 0);
@@ -2885,7 +2887,8 @@ void __tcp_close(struct sock *sk, long timeout)
 		struct tcp_sock *tp = tcp_sk(sk);
 		if (READ_ONCE(tp->linger2) < 0) {
 			tcp_set_state(sk, TCP_CLOSE);
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 			__NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_TCPABORTONLINGER);
 		} else {
@@ -2903,7 +2906,8 @@ void __tcp_close(struct sock *sk, long timeout)
 	if (sk->sk_state != TCP_CLOSE) {
 		if (tcp_check_oom(sk, 0)) {
 			tcp_set_state(sk, TCP_CLOSE);
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 			__NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_TCPABORTONMEMORY);
 		} else if (!check_net(sock_net(sk))) {
@@ -3007,7 +3011,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 		/* The last check adjusts for discrepancy of Linux wrt. RFC
 		 * states
 		 */
-		tcp_send_active_reset(sk, gfp_any());
+		tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_NOT_SPECIFIED);
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	} else if (old_state == TCP_SYN_SENT)
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
@@ -4564,7 +4568,8 @@ int tcp_abort(struct sock *sk, int err)
 		smp_wmb();
 		sk_error_report(sk);
 		if (tcp_need_reset(sk->sk_state))
-			tcp_send_active_reset(sk, GFP_ATOMIC);
+			tcp_send_active_reset(sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 		tcp_done(sk);
 	}
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 61119d42b0fd..276d9d541b01 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3586,7 +3586,8 @@ void tcp_send_fin(struct sock *sk)
  * was unread data in the receive queue.  This behavior is recommended
  * by RFC 2525, section 2.17.  -DaveM
  */
-void tcp_send_active_reset(struct sock *sk, gfp_t priority)
+void tcp_send_active_reset(struct sock *sk, gfp_t priority,
+			   enum sk_rst_reason reason)
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
index f8bc34f0d973..065967086492 100644
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
@@ -2569,7 +2570,8 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 
 		slow = lock_sock_fast(tcp_sk);
 		if (tcp_sk->sk_state != TCP_CLOSE) {
-			tcp_send_active_reset(tcp_sk, GFP_ATOMIC);
+			tcp_send_active_reset(tcp_sk, GFP_ATOMIC,
+					      SK_RST_REASON_NOT_SPECIFIED);
 			tcp_set_state(tcp_sk, TCP_CLOSE);
 		}
 		unlock_sock_fast(tcp_sk, slow);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 32fe2ef36d56..ac867d277860 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -414,7 +414,7 @@ void mptcp_subflow_reset(struct sock *ssk)
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
-	tcp_send_active_reset(ssk, GFP_ATOMIC);
+	tcp_send_active_reset(ssk, GFP_ATOMIC, SK_RST_REASON_NOT_SPECIFIED);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
 		mptcp_schedule_work(sk);
@@ -1350,7 +1350,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
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

