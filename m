Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2D513FD9F
	for <mptcp@lists.linux.dev>; Thu, 11 Apr 2024 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836623; cv=none; b=Cov6cedlekUYaWHRzJIz3y8NXKFNLvAAL7q+bHKZrRBhhoIGyKIcSwPnNrIK9w42B2kYBdquwUjPYKy3iqW9jHQo3iyeUD7D7TJtAoC/L+SIjYywz2cZcn/gwxWUzhU5vkFnAGcilsv5ypOxxfbxYibjbb1Y/K4U4I+fHJqYGWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836623; c=relaxed/simple;
	bh=PH0t0uQxPHpHTnOZNvi9SxZmiLnATkh0wsu80tL1a5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U8WilfWSDcFhWNFZX1juvqfdnCiTYMD6T7DStQSTfFNgqpKfHQhuAm1PhatcrlZ+qxEi/qZxkaa8S2kKHKBtgEJ+jo7eHwLD/gvzC+FE3eJtvHH1+1gnRywc3fbWiqapjj5wAWmpCJwhzsOZMrq0ZpcnTWQ6Zd87kvaXBsZsUjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1w7eyHG; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1w7eyHG"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so5592192a12.1
        for <mptcp@lists.linux.dev>; Thu, 11 Apr 2024 04:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712836621; x=1713441421; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZLRkIDF/aQki4JRqdF4sjfFGCD9QXnJCAeTRcuS4w0=;
        b=g1w7eyHG+z1VugiWMQPmjpRfBRaeElPrxKhh03DBMb5I/wbQ/WtG0HuQWd6TeCQRt5
         mPsC0elHJRr8v5obLLvyCYVrXSpYDwuA9ZXCuUM7bR/bfA8GChIrXoAUIdx3VRN1sjVs
         cqXXz/dbnrqwJp53eGuR6vOb5DcQnJTi2+kTgDwqgi9LZJxY5vqugUpkFhFLez32L+mQ
         WCb/8Ou+1W9Q3+OBqdUjK9OmuIFo9eOsUwk0o1T2Psbu6VQ1gaNpLPDyNB3EqyvbWNgJ
         yWCICjIFiQScByvMole3Y2OwSIxNs4tZJdeRJRIuKSTKwaT3i9j3muATu8K5kqCvtfUA
         j7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712836621; x=1713441421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZLRkIDF/aQki4JRqdF4sjfFGCD9QXnJCAeTRcuS4w0=;
        b=UaxLxt4EIk1vYwj3nMZ6Dm06winNiSv4i/JsBYz3EDchKU7XAPWDGU1mRj2tWeqWjy
         fbbpvc/9nxKE9kFeX955lnmruO/OhWgc6MuGf0z0toXLGx7a142yBuhbbl+CIc6+y2Q9
         hCcXgZWazNrYp3vARGoa59pynBRBcTlq4wGDlsxn5M5W9ARuU7Cv3eHQ1UgHJexcSBCF
         /J5dB4ptB18fGu5kmXiUaKyXhqImzpu0JDzNHYb+1vGYdi9MLt7LuF4WIlZLNSxuhtFG
         EadEhS9U6e76SQTpS1rdAO53XT4IHxp7L16EVann77c5tBvU0RuatnoVxU6dEAWKxxfN
         LFDg==
X-Gm-Message-State: AOJu0YwvooSjogyg2Z6pPZcia7Cf4zHfwj0smzySmdHMfDT0k1Clxrak
	Vl9JL/nKQ/giyfG0ZhD8Mqhu5FdP1Bj7iP9PNGt6MDsjR84EML22
X-Google-Smtp-Source: AGHT+IFVfRizPmPMWnS9jU6CV3veUN8cJrkadY6/j21/YXZP+QB1AF29K/OvnOzGhL2RcH7zvz9Wkw==
X-Received: by 2002:a05:6a20:1582:b0:1a8:3607:6939 with SMTP id h2-20020a056a20158200b001a836076939mr6467692pzj.57.1712836620657;
        Thu, 11 Apr 2024 04:57:00 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e5cb00b001e20587b552sm1011840plf.163.2024.04.11.04.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 04:57:00 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/6] rstreason: prepare for passive reset
Date: Thu, 11 Apr 2024 19:56:26 +0800
Message-Id: <20240411115630.38420-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240411115630.38420-1-kerneljasonxing@gmail.com>
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Adjust the parameter and support passing reason of reset which
is for now NOT_SPECIFIED. No functional changes.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/request_sock.h |  4 +++-
 net/dccp/ipv4.c            | 10 ++++++----
 net/dccp/ipv6.c            | 10 ++++++----
 net/dccp/minisocks.c       |  3 ++-
 net/ipv4/tcp_ipv4.c        | 12 +++++++-----
 net/ipv4/tcp_minisocks.c   |  3 ++-
 net/ipv6/tcp_ipv6.c        | 15 +++++++++------
 net/mptcp/subflow.c        |  8 +++++---
 8 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 004e651e6067..bdc737832da6 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -18,6 +18,7 @@
 #include <linux/refcount.h>
 
 #include <net/sock.h>
+#include <net/rstreason.h>
 
 struct request_sock;
 struct sk_buff;
@@ -34,7 +35,8 @@ struct request_sock_ops {
 	void		(*send_ack)(const struct sock *sk, struct sk_buff *skb,
 				    struct request_sock *req);
 	void		(*send_reset)(const struct sock *sk,
-				      struct sk_buff *skb);
+				      struct sk_buff *skb,
+				      enum sk_rst_reason reason);
 	void		(*destructor)(struct request_sock *req);
 	void		(*syn_ack_timeout)(const struct request_sock *req);
 };
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 9fc9cea4c251..ff41bd6f99c3 100644
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
+				   enum sk_rst_reason reason)
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
index c8ca703dc331..85f4b8fdbe5e 100644
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
+				   enum sk_rst_reason reason)
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
index 52963c3bb8ca..441134aebc51 100644
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
+			      enum sk_rst_reason reason)
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
@@ -2276,7 +2278,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v4_send_reset(nsk, skb);
+				tcp_v4_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -2354,7 +2356,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v4_send_reset(NULL, skb);
+		tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
 	}
 
 discard_it:
@@ -2405,7 +2407,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb);
+		tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 5b21a07ddf9a..2d7d81428c07 100644
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
index cffebaec66f1..6cad32430a12 100644
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
+			      enum sk_rst_reason reason);
 static void	tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 				      struct request_sock *req);
 
@@ -1006,7 +1008,8 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	kfree_skb(buff);
 }
 
-static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
+static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
+			      enum sk_rst_reason reason)
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
index 162b218d9858..744c87b6d5a4 100644
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
 
@@ -307,7 +309,7 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 
 	dst_release(dst);
 	if (!req->syncookie)
-		tcp_request_sock_ops.send_reset(sk, skb);
+		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 	return NULL;
 }
 
@@ -374,7 +376,7 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 
 	dst_release(dst);
 	if (!req->syncookie)
-		tcp6_request_sock_ops.send_reset(sk, skb);
+		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 	return NULL;
 }
 #endif
@@ -909,7 +911,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	tcp_rsk(req)->drop_req = true;
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-	req->rsk_ops->send_reset(sk, skb);
+	req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
 
 	/* The last child reference will be released by the caller */
 	return child;
-- 
2.37.3

