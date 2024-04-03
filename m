Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A45B053
	for <mptcp@lists.linux.dev>; Wed,  3 Apr 2024 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129531; cv=none; b=QVm/+hWX/yyjMkQfcICeQiWkr3HHsHKhZSVtS7zV/b3kIWRan3VLf1MCf8luLopUezapIfw+Z5fimNh70CCJF9KEg337APU9vtjwONpxx4JHr9iIL4a7EmQOnWXMGT9uIc1IGeiGERf93Z7MOG0H04DlPplaFU4NxCNNND/rQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129531; c=relaxed/simple;
	bh=nZjGJvKDiRnidQZDsfqPqJwS86EDVeil9dp10M83TYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i5CA66zmMzqtRgprQvOaCn+SU7A8C0g9g0waMK26BHRs0Gam0ea8FJLZpNXlh1fYRDg3uvQC2t4HRaw45ft2vS/Arkza759WLtbQgu8DERSbR2rmenLCTShG141wHw/KP6toBVgdWGkeSgOJmDfrnx7aFpUX+MIJQuZW6EsF3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4MdkLKk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4MdkLKk"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1def3340682so52329335ad.1
        for <mptcp@lists.linux.dev>; Wed, 03 Apr 2024 00:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712129529; x=1712734329; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWKXTqXA1vRilrHfzBrQgWu1Kcy5RdJA5BEIQipNfAk=;
        b=D4MdkLKkU2/iduxNkK84Egl99JoXiR9QBLGAfTcVQMR4o2LzFqndPwlR3KorknQF8Z
         mQfrJrM7dQNJVsZY5LxHDidWqo5LA1zBzV6YyaofOxoLufstS47u7S7/CyDFYEc0aj2A
         tiwB+DwKhyxVE656i8ZxTSaVeNY63GGk0SaA522WWzedfsTmX0vLpHZYnggjo72yUCtx
         ohJdOHrZLOx9MjfPBNEQyQu+l9EuUbUM6GypzAA+MFkIXyxkFeb36Hx1T3UsLGhWC3nG
         6E3/+Cz1wdrpnAc6zrPUiIcXoAbuCjrx6g195/qTLEl3R+hSnXbNm4FxCrDnXx+LVGnf
         tT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712129529; x=1712734329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWKXTqXA1vRilrHfzBrQgWu1Kcy5RdJA5BEIQipNfAk=;
        b=SmVDixfnVDimwfNn3LOX5syJ7cUpzykU9rfRH3417U0Ew48wCMYakb7pKZMH/GRK9V
         qaunK92FZosloKjrsYYoX6K7HLS8qX2GfToloDIRgYkrP9TL+CKEY0Qi35iPU+WHRY4N
         p6RmKowBZThhJCHFi93NHUJfgMD+WpvKByeDdEWM1nZlvcxQNAe3kMULMgZP+fXSrKYU
         00+BFBt044pyk0CLz+/iQuqxgydeazobiidXdHhLsuNC5wPanKvK/7fY5pImyYv6iftx
         qc+6xRB9XRv0QWDSsSjdJm3BqeQ6U+uMx4s7823dKNeq3xRoTJxxoKlupAM4b0qVyAw3
         V+gw==
X-Gm-Message-State: AOJu0YyA8N3WHiqBachlPpPz1osTNt8HZ0xbxMP9AbXZ5nPxpBzBsGIA
	d1tppS4azTsG3nGf6+6ixBds0Qa5CXJxXICk7YRrXi6Ytdz7bo6tjN3osqae
X-Google-Smtp-Source: AGHT+IEvwa5td8d6L8Pc7yaILvDK52o3cnnRubM79JpbjiuY7MP3/vebjOecXXoJF/xYxgnK6dffqA==
X-Received: by 2002:a17:902:ba8b:b0:1e2:44c7:b2af with SMTP id k11-20020a170902ba8b00b001e244c7b2afmr10226572pls.61.1712129528860;
        Wed, 03 Apr 2024 00:32:08 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d48200b001e03b2f7ab1sm12563067plg.92.2024.04.03.00.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:32:08 -0700 (PDT)
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
Subject: [PATCH net-next 2/6] rstreason: prepare for passive reset
Date: Wed,  3 Apr 2024 15:31:40 +0800
Message-Id: <20240403073144.35036-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240403073144.35036-1-kerneljasonxing@gmail.com>
References: <20240403073144.35036-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Adjust the paramenter and support passing reason of reset which
is for now NOT_SPECIFIED. No functional changes.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/request_sock.h |  3 ++-
 net/dccp/ipv4.c            | 10 ++++++----
 net/dccp/ipv6.c            | 10 ++++++----
 net/dccp/minisocks.c       |  3 ++-
 net/ipv4/tcp_ipv4.c        | 12 +++++++-----
 net/ipv4/tcp_minisocks.c   |  3 ++-
 net/ipv6/tcp_ipv6.c        | 15 +++++++++------
 net/mptcp/subflow.c        |  8 +++++---
 8 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 004e651e6067..93f9fee7e52f 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -34,7 +34,8 @@ struct request_sock_ops {
 	void		(*send_ack)(const struct sock *sk, struct sk_buff *skb,
 				    struct request_sock *req);
 	void		(*send_reset)(const struct sock *sk,
-				      struct sk_buff *skb);
+				      struct sk_buff *skb,
+				      int reason);
 	void		(*destructor)(struct request_sock *req);
 	void		(*syn_ack_timeout)(const struct request_sock *req);
 };
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 44b033fe1ef6..628dd783e8f3 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -24,6 +24,7 @@
 #include <net/xfrm.h>
 #include <net/secure_seq.h>
 #include <net/netns/generic.h>
+#include <net/rstreason.h>
 
 #include "ackvec.h"
 #include "ccid.h"
@@ -521,7 +522,8 @@ static int dccp_v4_send_response(const struct sock *sk, struct request_sock *req
 	return err;
 }
 
-static void dccp_v4_ctl_send_reset(const struct sock *sk, struct sk_buff *rxskb)
+static void dccp_v4_ctl_send_reset(const struct sock *sk, struct sk_buff *rxskb,
+				   int reason)
 {
 	int err;
 	const struct iphdr *rxiph;
@@ -706,7 +708,7 @@ int dccp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	dccp_v4_ctl_send_reset(sk, skb);
+	dccp_v4_ctl_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 	kfree_skb(skb);
 	return 0;
 }
@@ -869,7 +871,7 @@ static int dccp_v4_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 		} else if (dccp_child_process(sk, nsk, skb)) {
-			dccp_v4_ctl_send_reset(sk, skb);
+			dccp_v4_ctl_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 			goto discard_and_relse;
 		} else {
 			sock_put(sk);
@@ -909,7 +911,7 @@ static int dccp_v4_rcv(struct sk_buff *skb)
 	if (dh->dccph_type != DCCP_PKT_RESET) {
 		DCCP_SKB_CB(skb)->dccpd_reset_code =
 					DCCP_RESET_CODE_NO_CONNECTION;
-		dccp_v4_ctl_send_reset(sk, skb);
+		dccp_v4_ctl_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 	}
 
 discard_it:
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index ded07e09f813..d64f39e26e87 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -29,6 +29,7 @@
 #include <net/secure_seq.h>
 #include <net/netns/generic.h>
 #include <net/sock.h>
+#include <net/rstreason.h>
 
 #include "dccp.h"
 #include "ipv6.h"
@@ -256,7 +257,8 @@ static void dccp_v6_reqsk_destructor(struct request_sock *req)
 	kfree_skb(inet_rsk(req)->pktopts);
 }
 
-static void dccp_v6_ctl_send_reset(const struct sock *sk, struct sk_buff *rxskb)
+static void dccp_v6_ctl_send_reset(const struct sock *sk, struct sk_buff *rxskb,
+				   int reason)
 {
 	const struct ipv6hdr *rxip6h;
 	struct sk_buff *skb;
@@ -656,7 +658,7 @@ static int dccp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	dccp_v6_ctl_send_reset(sk, skb);
+	dccp_v6_ctl_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 discard:
 	if (opt_skb != NULL)
 		__kfree_skb(opt_skb);
@@ -762,7 +764,7 @@ static int dccp_v6_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 		} else if (dccp_child_process(sk, nsk, skb)) {
-			dccp_v6_ctl_send_reset(sk, skb);
+			dccp_v6_ctl_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 			goto discard_and_relse;
 		} else {
 			sock_put(sk);
@@ -801,7 +803,7 @@ static int dccp_v6_rcv(struct sk_buff *skb)
 	if (dh->dccph_type != DCCP_PKT_RESET) {
 		DCCP_SKB_CB(skb)->dccpd_reset_code =
 					DCCP_RESET_CODE_NO_CONNECTION;
-		dccp_v6_ctl_send_reset(sk, skb);
+		dccp_v6_ctl_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 	}
 
 discard_it:
diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
index 64d805b27add..251a57cf5822 100644
--- a/net/dccp/minisocks.c
+++ b/net/dccp/minisocks.c
@@ -15,6 +15,7 @@
 #include <net/sock.h>
 #include <net/xfrm.h>
 #include <net/inet_timewait_sock.h>
+#include <net/rstreason.h>
 
 #include "ackvec.h"
 #include "ccid.h"
@@ -202,7 +203,7 @@ struct sock *dccp_check_req(struct sock *sk, struct sk_buff *skb,
 	DCCP_SKB_CB(skb)->dccpd_reset_code = DCCP_RESET_CODE_TOO_BUSY;
 drop:
 	if (dccp_hdr(skb)->dccph_type != DCCP_PKT_RESET)
-		req->rsk_ops->send_reset(sk, skb);
+		req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 
 	inet_csk_reqsk_queue_drop(sk, req);
 out:
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0d47b48f8cfd..1c8248abe37a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -70,6 +70,7 @@
 #include <net/xfrm.h>
 #include <net/secure_seq.h>
 #include <net/busy_poll.h>
+#include <net/rstreason.h>
 
 #include <linux/inet.h>
 #include <linux/ipv6.h>
@@ -723,7 +724,8 @@ static bool tcp_v4_ao_sign_reset(const struct sock *sk, struct sk_buff *skb,
  *	Exception: precedence violation. We do not implement it in any case.
  */
 
-static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
+static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
+			      int reason)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct {
@@ -1933,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v4_send_reset(rsk, skb);
+	tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
 discard:
 	kfree_skb_reason(skb, reason);
 	/* Be careful here. If this function gets more complicated and
@@ -2278,7 +2280,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v4_send_reset(nsk, skb);
+				tcp_v4_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -2356,7 +2358,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v4_send_reset(NULL, skb);
+		tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
 	}
 
 discard_it:
@@ -2407,7 +2409,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb);
+		tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index f0761f060a83..d2d42edb8140 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -22,6 +22,7 @@
 #include <net/tcp.h>
 #include <net/xfrm.h>
 #include <net/busy_poll.h>
+#include <net/rstreason.h>
 
 static bool tcp_in_window(u32 seq, u32 end_seq, u32 s_win, u32 e_win)
 {
@@ -879,7 +880,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		 * avoid becoming vulnerable to outside attack aiming at
 		 * resetting legit local connections.
 		 */
-		req->rsk_ops->send_reset(sk, skb);
+		req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 	} else if (fastopen) { /* received a valid RST pkt */
 		reqsk_fastopen_remove(sk, req, true);
 		tcp_reset(sk, skb);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 8e9c59b6c00c..f143b658fb71 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -60,6 +60,7 @@
 #include <net/secure_seq.h>
 #include <net/hotdata.h>
 #include <net/busy_poll.h>
+#include <net/rstreason.h>
 
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -69,7 +70,8 @@
 
 #include <trace/events/tcp.h>
 
-static void	tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb);
+static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
+			      int reason);
 static void	tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 				      struct request_sock *req);
 
@@ -1006,7 +1008,8 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	kfree_skb(buff);
 }
 
-static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
+static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
+			      int reason)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
@@ -1675,7 +1678,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v6_send_reset(sk, skb);
+	tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
@@ -1861,7 +1864,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v6_send_reset(nsk, skb);
+				tcp_v6_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -1937,7 +1940,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v6_send_reset(NULL, skb);
+		tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
 	}
 
 discard_it:
@@ -1992,7 +1995,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v6_send_reset(sk, skb);
+		tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1626dd20c68f..3b1c13136908 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -20,6 +20,8 @@
 #include <net/transp_v6.h>
 #endif
 #include <net/mptcp.h>
+#include <net/rstreason.h>
+
 #include "protocol.h"
 #include "mib.h"
 
@@ -302,7 +304,7 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 
 	dst_release(dst);
 	if (!req->syncookie)
-		tcp_request_sock_ops.send_reset(sk, skb);
+		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 	return NULL;
 }
 
@@ -369,7 +371,7 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 
 	dst_release(dst);
 	if (!req->syncookie)
-		tcp6_request_sock_ops.send_reset(sk, skb);
+		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 	return NULL;
 }
 #endif
@@ -899,7 +901,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	tcp_rsk(req)->drop_req = true;
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-	req->rsk_ops->send_reset(sk, skb);
+	req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 
 	/* The last child reference will be released by the caller */
 	return child;
-- 
2.37.3

