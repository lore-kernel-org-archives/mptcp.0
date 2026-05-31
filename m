Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E038F651
	for <mptcp@lists.linux.dev>; Sun, 31 May 2026 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780239607; cv=none; b=e8LKBbkfLd5klpd1Urz0t3kRJvlAO+Xgargy0b/x4XjOTFknQMx4xD8I0fhaqlomR6L/k7ftEF5apxyr6x5zfBBAs8FlKRCTYhtWp5wZ4AlZcxy2vD4EUC2tgH5tbkhWElX3kzFovNouJFbZmrcIVHae84PdVWuC8mvzCmUrJxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780239607; c=relaxed/simple;
	bh=wFdKLtZamkQHV6GIN0O3mMCrNWO46pV7+i+eGCV6yLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cq7BhHtkUS6sri3qo5pA6xeKRSveqWCo6fI0r8KhUMpgHloBzqaHiL7hB6+yv7FMrj6BXCjLME8QvfNowgfNSkfoEbBUw/p8tmsc7k4W7xRoTTUMfMBfbr8yEB2gJecsTChYwW8g5RvnWAbfdgvRIR9BAal0OEcSHixST6bI980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcoaAOFP; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcoaAOFP"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef29c5561so1089699f8f.0
        for <mptcp@lists.linux.dev>; Sun, 31 May 2026 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780239602; x=1780844402; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJnjeINp9vZ1pv2Fi0ORekBEc6b4xUxFfCkGr6FTptA=;
        b=KcoaAOFPAEgOOLITUkAUuBdJHGrvgGoAqcr5O8Zu5vLI3fNmFIiO3b+xKiMAbIObpr
         1JKt4WbSPPcc21IMIT4ILTNztz5gM1FJL+LsSsh3vf8Sa24ccId46TFZwCEhTLWpWblp
         CkdogdaEPi/fTy3ByQ37V6raIC87/S5z3jwHZ0wsKUbKtmYir479bB8VQF11CCjb0Lnh
         gZWOCIBkdllXaSss32qi/6eHtlXx+BMIJXEHiLwi0+D0Q8HxwpF6h3ibABucw/5wFEdG
         m945ogG1ewA8QMp6MjPeg0c0YpYQJBYyKmIRCt/mWcXdcl27VWvJkXDilucdiu1OuIVJ
         DsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780239602; x=1780844402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qJnjeINp9vZ1pv2Fi0ORekBEc6b4xUxFfCkGr6FTptA=;
        b=I4bq3ByTo1+BgbJeN7t+IBUGGOhjMqTbiR9p7yj6F7xWAIHuvBayOKR5Nlzna+H4s4
         GnrcTdpesm+GpLJVFkO7yFDkUz39Tmijyetj+hQnUWeWP2S9duc2HDnY5ICkD1kh1sTe
         bU1PzgSeoxBsAWicdhurfvdFZOzgiHrVWu9C7xnphFX6/cx533Av9PVr6aDdJlHK2b3X
         hF1YVJQraRY+JDRyv+raejJRGpdI00auYF6AcBe1iW9VIT80/5FA/kevuibQ+ZBtbRS/
         Jr18dyiwpUvRX1euGg7NPCOVcd/UZUI1j4ocYw9KGrYsp2eWE/UEwGBZFllRA461jPNV
         nlPw==
X-Gm-Message-State: AOJu0YwHav2gJEnlG7m0sfRcuM++iXaOsTPz0wVqJEAHJT8hudaaJFQf
	CwzzFAI2f7bJi7mUnsGJ32hjxSMeBB42seu11EdnN10yrBeKSRcpwoI3mLkaZg==
X-Gm-Gg: Acq92OH60N11EAkYj9hJySbXh5LCs7T2TANuL5pfBAq0p3tV6xYXU1Cgr1A/y6I9OgM
	1jPpg/SSYrWQSqEm3EPSI2zyPoHFMKNdsm88gArSGLFhbZqaVpdWWatf/Uci+sTX/a+bz1NARav
	OWjXBw63Rse3H5n9WhNzLJcTPlFtlBcYv7LuHQGS1GtemteJ8Kv8XWHP7OxYA3joVdtMYAnt0gN
	cXoZObZtYartToqC/qO+kt6wYFtifW4b8kNUQMJ2EiIidsPt04GzugTxerryAgKpCClJucsAOZ4
	PLShhSmLRI2awc/+zWvjuq1heKjycnDpD4lkRJXREJUW3DUBJaJQpdzGaYFttKOTYC5uH+tQ+q2
	NqMulmjXnv4FCdpAHiDmCJLgRi6lsxJR+q9ibc0S+QkAlTB8vndOVDzR350Znh/9B+F8LFUiBzR
	8n2jy2F1dt7/hUN7MDuv+IonvU3CSYrxuhHbXTPMo+aVF3cOVjAaNQwe8iSdS/0W4OluNWIxgDj
	//MMZkxK+T5hbFJx0oqIw==
X-Received: by 2002:a05:6000:2892:b0:45e:f68d:e791 with SMTP id ffacd0b85a97d-45ef6a946a9mr13999005f8f.0.1780239602168;
        Sun, 31 May 2026 08:00:02 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3587072sm19133545f8f.34.2026.05.31.08.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:00:01 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v11 3/4] mptcp: support MSG_ERRQUEUE on the parent socket
Date: Sun, 31 May 2026 15:59:52 +0100
Message-ID: <20260531145955.322337-4-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531145955.322337-1-devnexen@gmail.com>
References: <20260531145955.322337-1-devnexen@gmail.com>
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

Forwarded events all go through sock_queue_err_skb(), which re-homes
skb->sk onto the parent and charges sk_rmem_alloc, so the parent's error
queue stays bounded by sk_rcvbuf and is dropped under rmem pressure
(sk_rmem_alloc + truesize >= sk_rcvbuf), matching tcp's sk_rcvbuf-gated
tx-timestamp path and ip_icmp_error() / ipv6_icmp_error(). MPTCP itself
never originates MSG_ZEROCOPY or OPT_ID tx-timestamp completions -- its
data path copies into msk-owned pages and bypasses tcp_sendmsg_locked()
-- so no subflow-relative ee_data sequence is ever forwarded to the
parent. The MSG_ERRQUEUE branch of mptcp_recvmsg() forwards to
inet_recv_error() directly, and poll() advertises EPOLLERR purely on the
parent's sk_err / sk_error_queue, matching tcp_poll().

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/protocol.c | 63 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f1d74d4b28cf..42a355311c81 100644
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
@@ -894,21 +895,61 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
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
+		/* sock_queue_err_skb() re-homes skb->sk onto the parent and
+		 * charges its sk_rmem_alloc, so the error queue stays bounded by
+		 * sk_rcvbuf; drop on overflow, matching tcp's tx-timestamp path.
+		 * MPTCP never originates MSG_ZEROCOPY or OPT_ID tx-timestamp
+		 * completions (the data path copies and bypasses
+		 * tcp_sendmsg_locked()), so no subflow-relative ee_data sequence
+		 * is ever forwarded.
+		 */
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
@@ -918,11 +959,15 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
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
@@ -2363,7 +2408,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
 
@@ -4413,7 +4457,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-	if (READ_ONCE(sk->sk_err))
+	if (READ_ONCE(sk->sk_err) ||
+	    !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR;
 
 	return mask;
-- 
2.53.0

