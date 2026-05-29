Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DAB370D6D
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076736; cv=none; b=WFqQrKUQfQZZsRxB2zrgI4/5Fqf9mUx5fjDi+9O8aDN9mzyhXhmIriuQRX847l4jswOfAiYb99D+ijISNnAfalUSys5qltMw9+DIenVTft5mKAQzPbjw2mVQjj/rnw9CiT6wPr0rdbm3p4xXWGh6PmDfsj/1Q9ToccJMnYHD7ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076736; c=relaxed/simple;
	bh=5zG3tbP3y6kSPc8+Mz0m9bYeQfIImw7t3Rg4zOHV/Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCSyYn7eFGzVrpfKk7ha5IsZPnAlLsJDTbqi7GzkHF3edAR0OmFYeE77DNEdjpJ6EOETi0ZvJb9BbucrmC51b3pYE0ycaXvCZSJRKYurv8fJ5aoSNzfDFhgbTTj/vm2FN0WMaK6HvuH1lc4XxvwNoI5OmmM+kJBAlh6rwIajBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pzEGcMiu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzEGcMiu"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so1339315f8f.1
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780076733; x=1780681533; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVq8ui2ZRmskvyjGPcHjQQSg0JQ5DwT3moq8+SC7Q+A=;
        b=pzEGcMiuTZvkPsw4MGJPZDjpagTU5TgT7qaDq+x6ugwjgozBA2r/CJmuS8sFST5QGN
         Qb2hqa+KSByRMMKl9rBaV2+n+3553Y/vWzfSIDzBn+pBozW/vEaRD7T0+HGM1SCrezDy
         ia51jtoa0r+ewGaeZUjewUCOthvb7VHNA5tcV6nLXYdnUfpcr56GsywbfFpk95l/4Xwc
         WUK/i4m91YbyAO6mnUA2n44xD70dQNQP/oAqQ8CTaMIw6mnfogRcZY+o72zBQhSHL+21
         pa9KPuLo8mHqbS/znqEBX1dJdm1f5ew9UK9pXIP5GluBC9H8NUU8U8LVjEDAmp1uIOU+
         dfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780076733; x=1780681533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sVq8ui2ZRmskvyjGPcHjQQSg0JQ5DwT3moq8+SC7Q+A=;
        b=ETHixwT6DxdMHUVjE8X+DvCzVHAED5CxY84fiXFI1TBCOkrUouIAjbiSxurlLtGcVe
         VHKwhFcRNL60hBPvwVuKNW7PdA+RSqDg8KffQaFAee+iAeO+z8gRwgzRoUSmLkSQ1htk
         Av36Kt1IXWs0uKdVhBjXyg0naa3w+k4pl6PKeVwFt6+AzdK+TN0436LZ1omm2zCrtGrj
         3zVRlLZ1REH+9Pz09Bo/kdX1MAzWNKOGnok/j5HCipDvbNQhwyFMDYi1xNL+k5TpdGSi
         tjp0OOK1/Afjb1huudnqt/pgZPK9PSovN0zbD0OBs7gbmwKDyXEdBOVHtUoQOh8DI8Ts
         xpxQ==
X-Gm-Message-State: AOJu0YxtZY1aKoouL2FKSRkYs2prmUTBrcLEPvJyKXgzapeDgFGoR9NQ
	grtWHmMOqM2NYlNfSP6rzjghuZSGUA+zJLSufxMBei5Q/yAMGPhGkOz/2hMxZw==
X-Gm-Gg: Acq92OESprJ/qZ6mamiU1sRxoq94B+Jv0vPDjCtRK9W9dbkaPQjgXJ4kDH3Gy+mScHa
	Cg+tY0Z4RVctiQ7ht8wk1f9Xm2mHu4f/70hY4SGXZIH468f+sRudbuYcnz4rUf1t6yTRPIlRBVB
	ZhHMJJlDgnqGC5ntZVLs5d5YdTBVZlJ36+4cKe9IH7f6FahOV+FDUyo51roNS0QSsrqpUghv/ad
	avBUtbJ/vyXzPuQqUVbJsCplrSJfVae8oYnYz1kI8CUFyERsuA1siobe/t7aulUIrFVhDU1v3XE
	6zUTWD09ofY9RTZHH4PKpX2niUB4SXnmznmURThyy5K8qziGbQdEWHM3/YA8fcgGMAacfVuGGpb
	Uxa9IDAOXfUk3wcTwzKurlxN0hfwbO6VBLnZ8EglGUqE6rKFTtYODwY3bBEcTeaKFAyEyBtu12Z
	pSBguXx6CulM3AdS0ktHL4ZusWpvY18D+uHNiiz/ITV070K/cYMf2sevjT6R5McYd7V6z0M1AP1
	GUEjvhOo293VNr/8uyZew==
X-Received: by 2002:a05:600c:1d0f:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-490a2a22bb4mr6280055e9.6.1780076732680;
        Fri, 29 May 2026 10:45:32 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c09ab75sm18738075e9.6.2026.05.29.10.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:45:31 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v10 3/4] mptcp: support MSG_ERRQUEUE on the parent socket
Date: Fri, 29 May 2026 18:45:21 +0100
Message-ID: <20260529174524.260199-4-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529174524.260199-1-devnexen@gmail.com>
References: <20260529174524.260199-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Splice pending err skbs from each subflow's error queue onto the parent
msk's error queue at error-report time, so poll() and recvmsg(MSG_ERRQUEUE)
on the parent socket observe TX timestamps and MSG_ZEROCOPY completion
notifications through the standard inet ABI.

The splice filters by SO_EE_ORIGIN: TIMESTAMPING / ZEROCOPY / LOCAL
events forward to the parent because they are tied to user-handed data,
not to a specific path; subflow-level ICMP errors are dropped because
the legacy RECVERR ABI cannot meaningfully convey their per-subflow peer
identity to single-path-aware userspace. Such events will be carried by
a future MPTCP_RECERR channel.

MSG_ZEROCOPY completions carry an unpin/free obligation for userspace, so
they are queued to the parent unconditionally and are never dropped,
mirroring tcp's __msg_zerocopy_callback() which likewise bypasses
sk_rcvbuf. Timestamping and local events instead go through
sock_queue_err_skb() and are dropped under rmem pressure (sk_rmem_alloc +
truesize >= sk_rcvbuf) on a full err queue, matching tcp's sk_rcvbuf-gated
tx-timestamp path and ip_icmp_error() / ipv6_icmp_error(). The
MSG_ERRQUEUE branch of mptcp_recvmsg() forwards to inet_recv_error()
directly, and poll() advertises EPOLLERR purely on the parent's sk_err /
sk_error_queue, matching tcp_poll().

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/protocol.c | 68 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1d67728d4233..64c0e841b9b7 100644
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
@@ -829,21 +830,66 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+static bool mptcp_errqueue_skb_forwardable(const struct sk_buff *skb)
+{
+	u8 origin = SKB_EXT_ERR(skb)->ee.ee_origin;
+
+	return origin == SO_EE_ORIGIN_TIMESTAMPING ||
+		origin == SO_EE_ORIGIN_ZEROCOPY ||
+		origin == SO_EE_ORIGIN_LOCAL;
+}
+
+static bool __mptcp_subflow_splice_errqueue(struct sock *sk, struct sock *ssk)
+{
+	struct sk_buff *skb;
+	bool moved = false;
+
+	while ((skb = skb_dequeue(&ssk->sk_error_queue))) {
+		if (!mptcp_errqueue_skb_forwardable(skb)) {
+			kfree_skb(skb);  /* path-specific (ICMP) — belongs in MPTCP_RECERR */
+			continue;
+		}
+		/* MSG_ZEROCOPY completions carry an unpin/free obligation for
+		 * userspace and must never be dropped. TCP's
+		 * __msg_zerocopy_callback() queues them to sk_error_queue
+		 * regardless of sk_rcvbuf; mirror that here rather than letting
+		 * sock_queue_err_skb() drop them under receive-buffer pressure.
+		 */
+		if (SKB_EXT_ERR(skb)->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY) {
+			skb_orphan(skb);
+			skb->sk = sk;
+			skb_queue_tail(&sk->sk_error_queue, skb);
+			moved = true;
+			continue;
+		}
+		if (sock_queue_err_skb(sk, skb)) {
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
@@ -853,11 +899,15 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
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
@@ -2313,7 +2363,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
 
@@ -4363,7 +4412,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-	if (READ_ONCE(sk->sk_err))
+	if (READ_ONCE(sk->sk_err) ||
+	    !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR;
 
 	return mask;
-- 
2.53.0

