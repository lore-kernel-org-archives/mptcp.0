Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF853B775A
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395575; cv=none; b=gY5HUSiEhQZo7TCrj6+hCur9dyCB4USIgDS8S7WRwQr8mCApWfYA/retsz+j2rHGJfR0Lwo/F+chMqul9YOa4BMahsqC54ubxYO8TitGYdbYjhgxSeqqaj/51CVRBv8TIpqWbCqCw7DQ3mN/vjQp91yeuUR1zoyMqdFUjWn+ntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395575; c=relaxed/simple;
	bh=yr4oc3G5MSsrxA8IlYlgHqJ9tgTuIQuzJ2aXr6sgGDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+R+QpY5IU6F65BmXNZYbzn+z2Ih0Btu8YGL8YW+LC1hHWYpldzYWcnvdCN50pjdPQKfS1bxOIT96ZQzifSztpPEzeocnBANF1psIVKHAHZnkdqbZEVNn/UHp6rWHFGnTaKWD8qDYc5QKASr/js7ERobmzgNbfTeS0UH2I4fjKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2LA/TXZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2LA/TXZ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f7027ca11so1153952f8f.3
        for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785395569; x=1786000369; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pkFoVpfDNFpG3p2l5jnz74+X7txAaKO9hQI4sYfh4e4=;
        b=f2LA/TXZjJB4UqAqt+++ml+xTOf4241zi9NIrWy40FxPlJDsNS3ZHrFQT98IEz965x
         S0+kSRj8CxLlBM15Cq3Qb0CVsIbSVt3uQWl/6rBccRtVCoiUM5o2bu7/L6HkSQehuUzt
         T7g1Jsadgw1j1JdDPhLQiVIJQYCTnYfu+AJUxkyQRyF0eOQN7JkL3RzbsQsVXq5i2bEE
         z1BUPnTXmmgDvOSqYhLmeRXW+EmRCVssn3GCPrjkdFvp1JviQtLL3HwVhYEOBSmJAQF/
         RuZ2zWYWxUZk4ws67A/jcYgiY7RJeGcP57fJi12GcGmgkpR/jt8pgOMqH+mGka23AeL6
         RtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785395569; x=1786000369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pkFoVpfDNFpG3p2l5jnz74+X7txAaKO9hQI4sYfh4e4=;
        b=VeKWYyqyp4zEnAvYihaoxG1yYAFfve7jDPqUabnXjS186iAqT2INiyKhGGsSfRZuJT
         ZUr+KdC+yJ44+36Y+KRf5GYwuKE2ZGvKQR6fACPITw/cpPmlT5+yJAYlbQ5wndEu969J
         6f1y/OUNLfglo/H0LDoAW3+EOj1nEwkncfa4dXiRbY25wFAV2TKq7z6der+PUFByJLG4
         14LaugcoxmF3K+mS9xR9J91MaNC1vDTA5bI/9u/5nIQFLbC+wmolzdxlmkn/4EIh2z5U
         iFUGwg6sXR1XN4zjTZQ0sI17sgzokb2Fvh7zAxALn41oM+siTSCZ6s51+NGyzNFmHRId
         /O4Q==
X-Gm-Message-State: AOJu0YzP8HYDMR8kOp8XTQ9RK7+hh0hHKY9iRoZ9erx/NGsKsDBZLzn0
	G5eJ0b2VwBKlGGkPTtzx1Cd/nNc7a3j4pONknhcSKoKiGxudDfc881muxifodQ==
X-Gm-Gg: AR+sD12QAYx4f9xLp31g1btcrk271ZeeYAqo7qxLct+yscasAK6pmCExFU9CPJ5CESj
	YopdaZNLQfcQYrZZwrL40aMCyyZP9Gt86ZRa6LEF0aTr8ZxthctWeBgB8zUGvOB2sj25RuKuEqN
	QTWR0ivtPARBKtczT3YJy12eYRMDZUwGBC4VDZORxaMaVJdMbZ/7BPBgY1kI901aLqeKvLj3xDz
	+qJ1QoY8Fxor79Y0YiWISxVFCigHj6b4Bog1Ful2ZgoGzMgTNwv/x54CIltWo6znUbaYidFLEw9
	phCKGbYD7Jx+DtA15lfVi99ARrevcZHQtAnICIhxecUIWsJfLTWXjgz4lO6fVoE7DltI09obWMZ
	b+BxpwsmGwl0fY8fZbHzA0unWYp+r9X88w3H1yZE5eMzptpcbUOCk6HRMfpxkzOeHXE2XjDs6Go
	IHayYXenvQ5+22sTjeL3LkEWYt/zwfg3wVE7+FlP/IXxKyk40TrPWXZrQVPUqeOXTlw3O3Phnee
	fcOQg2/LAqpvgFoDK8Urxt5vENIIOhPxiDHKuYrsKJLyd8NOp73LksPj/k=
X-Received: by 2002:a05:6000:220b:b0:47f:6fbd:8a23 with SMTP id ffacd0b85a97d-47fc822ea58mr1358225f8f.9.1785395568373;
        Thu, 30 Jul 2026 00:12:48 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d6e5bsm3821717f8f.3.2026.07.30.00.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:12:48 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v12 1/4] mptcp: support MSG_ERRQUEUE on the parent socket
Date: Thu, 30 Jul 2026 08:12:41 +0100
Message-ID: <20260730071244.69473-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730071244.69473-1-devnexen@gmail.com>
References: <20260730071244.69473-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Splice pending err skbs from each subflow's error queue onto the parent
msk's error queue at error-report time, so poll() and recvmsg(MSG_ERRQUEUE)
on the parent socket observe TX timestamps through the standard inet ABI.

The splice filters by SO_EE_ORIGIN: TIMESTAMPING events forward to the
parent because they are tied to user-handed data, not to a specific
path; subflow-level ICMP errors are dropped because the legacy RECVERR
ABI cannot meaningfully convey their per-subflow peer identity to
single-path-aware userspace. Such events will be carried by a future
MPTCP_RECERR channel.

Forwarded events all go through sock_queue_err_skb(), which re-homes
skb->sk onto the parent and charges sk_rmem_alloc, so the parent's error
queue stays bounded by sk_rcvbuf and is dropped under rmem pressure
(sk_rmem_alloc + truesize >= sk_rcvbuf), matching tcp's sk_rcvbuf-gated
tx-timestamp path and ip_icmp_error() / ipv6_icmp_error(). The
MSG_ERRQUEUE branch of mptcp_recvmsg() forwards to inet_recv_error()
directly, and poll() advertises EPOLLERR purely on the parent's sk_err /
sk_error_queue, matching tcp_poll().

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/protocol.c | 54 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 90dc894cb976..ade017f9ce5b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/atomic.h>
+#include <linux/errqueue.h>
 #include <net/aligned_data.h>
 #include <net/rps.h>
 #include <net/sock.h>
@@ -901,21 +902,52 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+static bool mptcp_errqueue_skb_forwardable(const struct sk_buff *skb)
+{
+	/* Subflow-level ICMP errors are dropped: the legacy RECVERR ABI
+	 * cannot convey their per-subflow peer identity.
+	 */
+	return SKB_EXT_ERR(skb)->ee.ee_origin == SO_EE_ORIGIN_TIMESTAMPING;
+}
+
+static bool __mptcp_subflow_splice_errqueue(struct sock *sk, struct sock *ssk)
+{
+	struct sk_buff *skb;
+	bool moved = false;
+
+	while ((skb = skb_dequeue(&ssk->sk_error_queue))) {
+		/* sock_queue_err_skb() re-homes skb->sk onto the parent and
+		 * charges sk_rmem_alloc, bounding the queue by sk_rcvbuf.
+		 */
+		if (!mptcp_errqueue_skb_forwardable(skb) ||
+		    sock_queue_err_skb(sk, skb)) {
+			kfree_skb(skb);
+			continue;
+		}
+		moved = true;
+	}
+
+	return moved;
+}
+
 static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 {
+	bool propagated = false;
 	int ssk_state;
+	bool report;
 	int err;
 
+	report = __mptcp_subflow_splice_errqueue(sk, ssk);
+
 	/* only propagate errors on fallen-back sockets or
 	 * on MPC connect
 	 */
 	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
-		return false;
+		goto out;
 
 	err = sock_error(ssk);
 	if (!err)
-		return false;
-
+		goto out;
 	/* We need to propagate only transition to CLOSE state.
 	 * Orphaned socket will see such state change via
 	 * subflow_sched_work_if_closed() and that path will properly
@@ -925,11 +957,15 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
 		mptcp_set_state(sk, ssk_state);
 	WRITE_ONCE(sk->sk_err, -err);
+	report = propagated = true;
 
-	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
-	smp_wmb();
-	sk_error_report(sk);
-	return true;
+out:
+	if (report) {
+		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
+		smp_wmb();
+		sk_error_report(sk);
+	}
+	return propagated;
 }
 
 void __mptcp_error_report(struct sock *sk)
@@ -2363,7 +2399,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
 
@@ -4493,7 +4528,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-	if (READ_ONCE(sk->sk_err))
+	if (READ_ONCE(sk->sk_err) ||
+	    !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR;
 
 	return mask;
-- 
2.53.0

