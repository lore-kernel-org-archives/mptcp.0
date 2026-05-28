Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0882F8E87
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 05:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947708; cv=none; b=HWTyvY+C9lUWIBsnr5GnITouIJ7Ez/e0qpsY3gVchnAxeB992/UWnVLrMeSwr3zLGELv3EgbKvd4q8h5rQhbijq4vzBMfvz+Pm9wOsw9Xxs41/lNKjy7RVVQJ/fbrXPE3c2ECcU8MY4iVomBpps7RKD2YgzB0vUSpftNhGhD5WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947708; c=relaxed/simple;
	bh=NFCuNKYpF8KXxwCucfIl4D1adlRLAnDT6OheGknS9mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8I/HYShoLtF7TMwLdFb3X/lzY96Z2cq30VAMNPO0fbYy2aEih1Rih+O6G5dBmKubF40HXq6aw5Q62VNUhSvZgaW5rzwHB+KFiEJE/N8W3QM64fgijhebvmRtoj39CH4wNg4yd8B+9r2AHt0y+4MslKEiFUOEnpN/9ODH0NfFYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbGB9ADY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbGB9ADY"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d77f6092eso7046110f8f.2
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 22:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779947705; x=1780552505; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYe262hIR9qgeIBQm5PBf+dVUVdbVcK95tRHVHsT30U=;
        b=mbGB9ADYT5KbAm2EcJTAD4iCUYd9ZWqtNosx2YX1TugRedek7CdJZjbj1BiWg9R21j
         ogBIsz/3+Md6W7uf7PJFGQLhkoclY2R+wX+x4SXxv40UKwbehptykOf8fWyENDq/+GUH
         f/1NfNmlSfoUU5lulbBj5Z+wTMLVjhiGZxRneWwuX+tbtuGf2t/da56jLE57ORqXVEBQ
         l2fyOzH/4R1jc6RxyxEOSPBGqojD8aP/MMcU5V9kouj+VtOnJMAO3FXg6/ZwFYXQx+qS
         QoYS16Q/sLTlS4Wyk6Av//gaixz+y9I6KywyiQByc/R3Z0+gfYR3PyPdvTYeUOuCGK0C
         5jEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779947705; x=1780552505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hYe262hIR9qgeIBQm5PBf+dVUVdbVcK95tRHVHsT30U=;
        b=Vj4R3xMEyz4O4NKCYde2400sXcYH6ppFNwvvBB1ia1XGpvB9rPz7Tc9phKdropvvW6
         z77f32w1KUJ38Yo4TM87amxswHeuta+OqA2jHsdq3ru3SHyZ78F9pUHjvAJyHcF6qJNL
         FR6w5M0648HKpFlPB2pbVoiwKvdNZCTVkEYzqSagOnuyYONlT1aOA7y0u168+DR0UQZQ
         DVJA9T7mOzv6PXQUAwHC6Qt/wAnREXCpkeFmEMPvIRQn3ZbQihjL2T9KgjZzY6trPdv6
         FMEQ0W9yqvrK3KQWz3LLqogoCd99LtCTaXGa2l7emgJt405x4dCW0CNgtt4pPFYY/KGD
         njSQ==
X-Gm-Message-State: AOJu0Yz5npu2SSa05+EdEaBCK8eDSNf48okMAkOK3xDbLVVH8Q5l7jce
	fGA6jw2X5CQVKixUTTDXzKWUaFDzuH78lTH35D4LemcHIAbE+VfXCWdFzcJy5R96
X-Gm-Gg: Acq92OE5RbTtV/fECz5et8Z12zu6NToL+/mzxOn1ccXUdY8LoSxjYzeOS2O0E9Ry3tp
	3mYHxkGasLC04QBtGDEubz+8c+gzKs27g6ozOuARyI/D6q8wuwso/6fLV1N0rckOpY9W5L5ovmc
	cjB8i8lA2hidR11gNYjhNair3LFGhOFnMNLNG2Y2mcbfxDjy21Oh78ZN6caU4wjBI/u0VS6OzaT
	iXvgWtRzXLBSsVG3WC1Ahr9klZ6B9gYDkj9YH8Wfeh0Rtncf3pjrc9NYLhxVRrAnGc9kWpjnpos
	ik+aRiFqTwATueBCvEw+rmsrnH1zG/8W7zA0Pq1fBmjSCIyHO2APiPJWcsBCFPta7XSZV1Sz9KI
	HKbehh/ICQGJAon3KAKQGnZg5lMWs70zU5uPhdqKFFGzB/cs0IuqgwPeHK8Sz0Sv9YnFsHMoCLz
	e/KUn2xo6RbfL7BCdIk33B62i8T28OglzXA4BYbw4aGmt55iscQOeIO/rGnbPZQ8R5Ho0/Bg2K6
	YAczKVmR79Zig8b4Rm9Jg==
X-Received: by 2002:a5d:5f54:0:b0:45c:3f0b:be08 with SMTP id ffacd0b85a97d-45eb38a686bmr46195043f8f.23.1779947704902;
        Wed, 27 May 2026 22:55:04 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a2c87sm11002245f8f.17.2026.05.27.22.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:55:04 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v9 3/4] mptcp: support MSG_ERRQUEUE on the parent socket
Date: Thu, 28 May 2026 06:54:57 +0100
Message-ID: <20260528055459.55133-4-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528055459.55133-1-devnexen@gmail.com>
References: <20260528055459.55133-1-devnexen@gmail.com>
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

When sock_queue_err_skb() fails on the parent under rmem pressure
(sk_rmem_alloc + truesize >= sk_rcvbuf), the splice drops the offending
skb, matching the behaviour of ip_icmp_error() / ipv6_icmp_error() on a
full err queue. Userspace expecting MSG_ZEROCOPY completion
notifications must size SO_RCVBUF accordingly. The MSG_ERRQUEUE branch
of mptcp_recvmsg() forwards to inet_recv_error() directly, and poll()
advertises EPOLLERR purely on the parent's sk_err / sk_error_queue,
matching tcp_poll().

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/protocol.c | 55 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1d67728d4233..972b6751d741 100644
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
@@ -829,21 +830,53 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
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
@@ -853,11 +886,15 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
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
@@ -2313,7 +2350,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
 
@@ -4363,7 +4399,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-	if (READ_ONCE(sk->sk_err))
+	if (READ_ONCE(sk->sk_err) ||
+	    !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR;
 
 	return mask;
-- 
2.53.0

