Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F103A1D14
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777324216; cv=none; b=XCH4U7yLncIFQUgKcsQuUp/MBLycJqx077mfGPml6twk9gr1La6fmwj1BZrbNwKium2DA1NIjfEP+ydaMZeCR2pK+YCQRbSN7BN/h64sBwRU9TisYJ+N5uHijH87+9Bq1RQfUX24gUYWHn0YbuR3VbsXkkDVeVeeOK++dd6q6XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777324216; c=relaxed/simple;
	bh=vsF4dC8WwHP2FeZmNsBAfNzeKTH7qTbiQ4t1ML0CTyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSOT16RhRa4arkOBEh531fMPcke3XVnIDXm9rW6osaU9IEqcuuQemxuEUZq/PPvZHeyqM4xtJ7vvMYfjGjQamrf9B8z54bHbVcW8TpmcOEwv6s/tfF/drLknPtPvxcHEhZZt/bykF+pOp0/Hk4MFc8sy54hcQjNWsRLuR0pl8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St38sU6z; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St38sU6z"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cfbd17589so8448619f8f.0
        for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 14:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777324213; x=1777929013; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYuFL9GlKOZWYgjoYtnJIyesDSxblNQ52L24vv2eXV8=;
        b=St38sU6zduoLKKgRg+7eD7thmsuPATxwhA4eRurWBmgNil3yOH4R10slk/ajBo9HkJ
         0TDH4iXuYueTGfqvEwKvC2x8KuHyLyb8W5kYj6uJiRrlpr8pjIxLg5d0sZyqPZ6GWTS7
         iUIOCyRvoRX/BQwCuU3Z9iV04XmQ72R4aqKBIDUmtAFOcb5GMpRV4EJ2GoIk4QNmOcvz
         ij5IfxrFZi1LQ+ETan3Owqoz8Xul0dS2abVVK4hXbQu+tebXI30MaUPv//YB9cmNh0/j
         nhGJHcrkPp+cVkkKjoXL/rbQZtqvZwTQBXYSles2Nd38ptAcDTFR/got4iPepXz4HtYO
         yksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777324213; x=1777929013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tYuFL9GlKOZWYgjoYtnJIyesDSxblNQ52L24vv2eXV8=;
        b=KZDBAjHipkVSO5KpVFvdiygHjtaieZfO/n9PVm5Sr6GitQ3k2Q0GP9ijVQZIvc/n/7
         IiM5iI09vn3YHnS6y3QMG5LVwwx+ntKgkv7ZVpr9Lh8VNDWyv+18DnzQSugsIV5Wp1t1
         zRgRNLnVJlJ+rozZcdzgS/BlAZaH/pVxMv/zOlsijpgMmpZ9vdzvnoCFk+hmxBxUwsKi
         sLUZzXt6uEglrv6kTZA+yUnF7ucTXYjUu0W8CCUq87eDYxTUZcVPr2PsLYVM0DzFmfoh
         816EmySv08CMcNrn3eonun8iObWYsvrjyhU8sYBiVILoUsq1jljdRv55eNpBnx+0fTsd
         i6Kg==
X-Gm-Message-State: AOJu0Yw6xULnOHXwo40Ir0OYOEhBlzo3CIvafW7O+uWxx12Wl16n1HDN
	iyaUwLASOe95Oq1Y43BYKfnhOvbyUCqI6TZhV2BEu7Y98khXbMI8d7c6XXJrdCb3
X-Gm-Gg: AeBDieuA5T9HtcGad/h1NuZ4Ztr1DnKxXG5it0nJlf1CMQBPVrkmbGKlEw5SJWyCqmp
	tkVnhQMCo83qG0mP3ZOY2SBwdnVbQcUs/gz3nrg6cGfzLrmrc7nSdZA8ikl/TJJ9OKs4k0CUfdv
	aYXB2TpH5NoaI0iIGc36MMI6z4EU5jgOtu3RS8qPVFR7wIzwss9NWBV84u5HPXefP6TG5FGV+/6
	tetCNyLc88pMlT7iuv+el99FblpKJHRH/Cj5ngrkSmotASi4+82tSeGHrfDdEHd0kfsFXHAIt1J
	iATHwn1CPPso+XYYemBZowgIx8jbtVSTIyUyKFZ802cA+xTNs6u1W9YJmac/QsYg8pgX3ln57x4
	nnYEYpxwKozITnFqhwPnSm+GXVkncaxMOpUN4SwgPR2AhHqjDq45mEQ5WQsuFngiVNC56rcpQ0U
	e2v5R/dGxmpyfdPtvkEd/55uxpy2Q2HUfyof7MyZPxtNsKTReWvrxLmW5Yqaa/E0WIWnPhf2rB1
	TDs1M9FusrskBukK77GLA==
X-Received: by 2002:a5d:5f46:0:b0:43c:ef4f:79e4 with SMTP id ffacd0b85a97d-44649ba18f0mr708283f8f.37.1777324212745;
        Mon, 27 Apr 2026 14:10:12 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d5ee9ecsm1107145f8f.16.2026.04.27.14.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:10:12 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v4 3/4] mptcp: support MSG_ERRQUEUE on the parent socket
Date: Mon, 27 Apr 2026 22:10:05 +0100
Message-ID: <c368d4cea284dd8ee75b14740ae108cb091cb57f.1777324037.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777324037.git.devnexen@gmail.com>
References: <20260421223338.52743-1-devnexen@gmail.com> <cover.1777324037.git.devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Splice pending err skbs from each subflow's error queue onto the
parent msk's error queue at error-report time, so poll() and
recvmsg(MSG_ERRQUEUE) on the parent socket observe ICMP, tx
timestamp, and zerocopy completion notifications through the
standard inet ABI.

If sock_queue_err_skb() on the parent fails (rmem-limited), the
skb is left on the subflow queue and retried on the next error
report, avoiding silent loss.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/protocol.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0db50e3715c3..131fb6ddfcd9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -815,21 +815,39 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+static bool __mptcp_subflow_splice_errqueue(struct sock *sk, struct sock *ssk)
+{
+	struct sk_buff *skb;
+	bool moved = false;
+
+	while ((skb = skb_dequeue(&ssk->sk_error_queue))) {
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
@@ -839,6 +857,11 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
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
@@ -2295,7 +2318,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
 
@@ -4340,7 +4362,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-	if (READ_ONCE(sk->sk_err))
+	if (READ_ONCE(sk->sk_err) ||
+	    !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR;
 
 	return mask;
-- 
2.53.0

