Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BDF1A6825
	for <mptcp@lists.linux.dev>; Sat,  2 May 2026 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777756820; cv=none; b=C6rIHN4ZfqOSaHyKkI+m/OYkmmY1HGRwPXrAldj6j8V5lvl9MLBTroz9w/gx+xItAYROzRjp2ibA472SVjvgDepj5e/ZedLiYqNq0HhYKr8ZhO6JAM6SIajXZyB82ErQn+K+hDCcbuwcpbPoR8eMIuxJ8oPds3ZZ2YNRmejMHMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777756820; c=relaxed/simple;
	bh=VMBMfvrQfme4v1F3IF2CnljZz9JLs9rmam8hQwxkoUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcHhWyZuh0CX109ZNNAGGIXU6/Lndx/LvL23n3wdrWuPWNCnNP/uc0hfpVpz2PtGkpFv1q9C+rTbrD+DG269zvdpPhF+SweSe0ktHPLj4ZqjIC+cXhvpP5eqjb+IONGwGcfenJYoecv7t60eY9JST5XCYPJ4J6p4CD8d/87KC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0WZOicj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0WZOicj"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-441209fb77eso1631825f8f.1
        for <mptcp@lists.linux.dev>; Sat, 02 May 2026 14:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777756817; x=1778361617; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZs56aPqR5NiVcGf7GGB49cZUg0adWLDOUMtOX8cPak=;
        b=W0WZOicjqjkz2g0q1m4IuSNR6lTDarLmYi+m0ftiyf3chH8qBqQdVZUGFRZZZ1J0D5
         KSVY9L6zqD6dfa5xfXbmnbwtANhROQNl3GaMM5xqV3c6TSMLNJQtFNTXHKsHcuSzHSq2
         /GmMliQ5GoIx2qGPO3VZQiE+xSvp4hHMrZcAxGCSQbxHt+E0qFxUrVziDIfc8uE3hbjA
         HLbekTdpMH1UHObPS44KaWCaMB8KxyczvCvPxzJUt2grl797XTJukoPlnM0eNYNESqab
         uwwgS3SvcD0nQW0FP8DgwJEMUuT5hX9gg+OvotOtBotkZU3iLbwSNd8mV595x/0CFsgk
         rZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777756817; x=1778361617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZs56aPqR5NiVcGf7GGB49cZUg0adWLDOUMtOX8cPak=;
        b=FksmAxq34oN5eTVSKLY7IpjZSf7Qa5psR2qMmDwQ7NA6fz/gdAM+1QwWykg3KA/wrO
         wq/korKtMNx/LDwv9q+s11tptEN5Fr0IGEjDOncSyHLGtWcHjgVQ0fyiIAe6A+jhJTJ3
         zMNBq2zfJG47Rm1cV7j8QE+YCW3aDAOZDieMFCL+RnTxN4geh5NeZ/xFaCYi1QVOwJ2z
         obZwqLYExeoZkbh4AaxV9Bt/tN6+/dgDh4FOY+0Gd3gUqTP9D6A4hE4h96xdx2HecTYN
         G4X7cFwkUiRs/Jhe+moiHvBsBcnydWnS+Zy7BzAeOkjwRjfOpBkFb2Hc3Y7p46olWKr4
         XRaQ==
X-Gm-Message-State: AOJu0YxgBV+LVObvsfzCxlpvx6qjO1s+O8DZa+bwt61gUEn3xZ5mjm2j
	16Gu+t7BLFcyd9Y8bEtdp09CgCGb594V1Gh8JzV0pX/UOkp86OL+DinzVurjm6NJ
X-Gm-Gg: AeBDies4/tRxWiBEdLmE6pd36AFR6yWx+jUnH3cvOVsB7CcRwlKofx01nIewZjQGpK+
	5wVIu6rmsU988IjncnW4tN4Q+G8wpaz5x6kP351LO2qJCn+Gn1JeFxJ1yuqfImnI+kEv/H+e8zt
	p1/vQl/POZAvzB8FbvgpEyQECjgwlkx9/7/rijYobZI5nWSnwrIlaHkCI1P/BdVsnNRo6jlwkF4
	/ZeYjuNJ02xKG1wQ4ETTU7hS2Lq+sz3h9jzdWoaM/ILNsJKTMYfpnLGDhlaibrVFh8Jc2i1ABz+
	LPWVzj3Tg9s52wEfLtbWLkbbhZoLpkXU+y+yJ+IaA08Q5qNKikjjJnewCq2RK3fjejsnXFBec0r
	ytVS6K6GltXvZbrkz6uriVYrNGxbBO1Ow6lpWWKuqK/XwVIGBIyVj3brRE+epGM3iSBbYGF3brU
	yEj37tDOYuZ/hyHnHDP81t3qGGxgWQbhwBpLDW2UL4c1MHlkKuDEBsQAoLbSt6t98qvlO6zjIKJ
	2B0PxoKXg9hHsmhwgEcIg==
X-Received: by 2002:a05:6000:1614:b0:446:708e:1e8d with SMTP id ffacd0b85a97d-44951bd849emr13336594f8f.30.1777756817229;
        Sat, 02 May 2026 14:20:17 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981defb3sm19490140f8f.20.2026.05.02.14.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 14:20:16 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v5 3/4] mptcp: support MSG_ERRQUEUE on the parent socket
Date: Sat,  2 May 2026 22:19:59 +0100
Message-ID: <690b4b87e71514a4fc0a0400db62edc63b4bf5eb.1777756707.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777756707.git.devnexen@gmail.com>
References: <cover.1777756707.git.devnexen@gmail.com>
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

mptcp_recv_error() retries the splice on the pull side: if
sock_queue_err_skb() previously failed under rmem pressure, the skb
stays on the subflow queue, and the next recvmsg(MSG_ERRQUEUE) splices
it once the parent's queue has been drained.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/protocol.c | 66 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0db50e3715c3..ed7b086f109a 100644
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
@@ -815,21 +816,52 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
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
+			skb_queue_head(&ssk->sk_error_queue, skb);
+			break;
+		}
+		moved = true;
+	}
+
+	return moved;
+}
+
 static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 {
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
@@ -839,6 +871,11 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
 		mptcp_set_state(sk, ssk_state);
 	WRITE_ONCE(sk->sk_err, -err);
+	report = true;
+
+out:
+	if (!report)
+		return false;
 
 	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
 	smp_wmb();
@@ -2286,6 +2323,23 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 	return 0;
 }
 
+static int mptcp_recv_error(struct sock *sk, struct msghdr *msg, int len)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (!skb_queue_empty(&ssk->sk_error_queue))
+			__mptcp_subflow_splice_errqueue(sk, ssk);
+	}
+	release_sock(sk);
+
+	return inet_recv_error(sk, msg, len);
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int flags)
 {
@@ -2295,9 +2349,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
 	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len);
+		return mptcp_recv_error(sk, msg, len);
 
 	lock_sock(sk);
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
@@ -4340,7 +4393,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-	if (READ_ONCE(sk->sk_err))
+	if (READ_ONCE(sk->sk_err) ||
+	    !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR;
 
 	return mask;
-- 
2.53.0

