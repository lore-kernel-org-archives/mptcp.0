Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADAA284693
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776798826; cv=none; b=R/e02dJXHpdNFITHYJwFC9JSjXdNakqCJOxRoiOrQo+I2eGuYr8M5SCFjiBYtcPNVypK6uS+keABOKvAAyHdMH5JYhWDqHC1h26D1IuUcSXX+pUeAfBsbdlnu3qfagiy2CUUVQdBvIBx8tswTzqHN8IXXXJ2v472F4arqu/g1Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776798826; c=relaxed/simple;
	bh=4xyJeZXUQ2uBeQdp9f1NS8Fh0zmFyUANa9YQeTh+GVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDYnXz6xEkULUQAIx/LfWw/dGiTepMCeuALydmaJ//lIkj9fJcYldRA4mVNwIwRpQDR8RV0MSfqbkAif9+EiNNUI0XzyUKFjutp42lXP+Rf0VgfloVYPD9S1At8HSwHiO/+GEPRB4PuTsXXpDgVDEd3Wbl+uvKj0La5jBLd8wAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcBqPQtf; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcBqPQtf"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43fe8bda8e9so2406017f8f.1
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 12:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776798823; x=1777403623; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qFZTDU7vLzWx/IvTmuyXfCSxmgGLGdxMBwdf5JEknI=;
        b=HcBqPQtfXfJ8PvB7jYFHxtT1thSeJFM/e93SJuXM9EmbwwgeQVL1aw9aJzBP6u9iW3
         cfAypEWA+IxFLImHYrlajhvDPeusxwlmRmEEtWAMWHJQm/JowZKlvWrLU8mIzjst+svh
         +rdtECSUz5r0t84PulaezGTQDPThkVzu3C1nFARgU+TZeo3n7M3MQgRc4FrsiQMlZ1H0
         REw/pVJZBN5CU1Y4haIpSSQrD6znMw9e0aqHnjHLj1Gno9QpM0yI8Oy0fGfRIkBL5sX4
         bZPrOw4Y7JMQdZjEu8RFuE78cVKrjy49zpU6VWOaii5gUoa1yWozE1T6RxHoh8pHFF7g
         /3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776798823; x=1777403623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3qFZTDU7vLzWx/IvTmuyXfCSxmgGLGdxMBwdf5JEknI=;
        b=mDay9jNQxDbzhJRiBo1bK+Z/h1uFPgXCGgLRCjtJzErIAlBXJ7++9oyoedMmDQuTx7
         YJ7G6DWqem1MDinMb1FLw+SwIIdLHImmRXlkPafZQOVWcGXL+xlpC9DQy+3e0eozIss6
         SUGqpiJ0OBRu+fnnM40toTD4qGPfxtISngKoZcFQ0d6vwI+mRocHM2sz/iO2b084fqOx
         rUJD2LQiFymu5xkf6rthXta5wNXXx1uf1H4omx8bMts4D/jLgGmW7yoQUBFZRaU9b4TZ
         h+VQr27UmuUWWttNOpsFnJ5BFnQo7SzSgUCXhPIjgJ4xydUC7QAJX8Y/YZaPGMcj8vCe
         V1MQ==
X-Gm-Message-State: AOJu0Yx8buw6GLIPKnOdYX+sLBLztPjhrnDD4B0ncpGkbwEhQw1vdEEu
	AQIT79BBFQJ4M5rZSesqOPkuhAHWG/WRpaCHAZ5pRGXCY2ScrfYNzZ1hZI4syL4Jb3c=
X-Gm-Gg: AeBDiet9WUImJXOHge+5Y6G7bpCBXlIrhgPYQqkTqqU3KMGzUJ4ycrkb87RpQ0WBDVC
	nDP5+hswYthdOCyUfm6kz0qv/049sgP8/lYs24RBSxSovBCSHCNFGMs/zbqHbZxXI3ODfrLIXLl
	PNF2zFKJIK24dC/AAALL0WqrER0SlT2mMOcENuiIk4UQRm2ZXAaeIjsA0WSIjOTeJFeETWfPuim
	+ABv87hw2opVM5wCLwe6Tw7YLAQdfUnZiwNkN8dlhDIIB8bh7DMXdgbn3S5tRLq236id7djK8M7
	R2T6AlnpC53IZtKJC2ocT9OAP1P2PoCrog0vRqJnbhgKIDj+jcj7mSGsFJAJUfFMnHSrYxMJUpO
	SDy2b1HoH3s2DGscCkIQvEOc5uezPRVpGSUv/sY1hlE4h+MEmAijJKPTBj8GkDwqw+pOHJSmmv2
	Ta+MhuVLQFbs7FUE+F9aF4c6JSFTb9I5EHbMzx7/VC3A+C1CuWgRQuzWyat1LGBRvdr9wi3qNYs
	vmBdKV2NhwML4Yr169iXEKJVm0zp9s6
X-Received: by 2002:a05:6000:2909:b0:43f:e22d:e624 with SMTP id ffacd0b85a97d-43fe3db3cb2mr28198324f8f.1.1776798822599;
        Tue, 21 Apr 2026 12:13:42 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d112sm43859447f8f.29.2026.04.21.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 12:13:42 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v2 2/3] mptcp: support MSG_ERRQUEUE on the parent socket
Date: Tue, 21 Apr 2026 20:13:36 +0100
Message-ID: <20260421191337.58341-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421191337.58341-1-devnexen@gmail.com>
References: <20260421191337.58341-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle MSG_ERRQUEUE on the MPTCP socket by selecting a subflow with
pending errqueue data, moving one error skb to the parent socket, and
consuming it through the parent socket ABI.

This surfaces subflow errqueue activity through poll(), keeps the
userspace ABI tied to the socket being used, and restores the skb to
the subflow errqueue if requeueing to the parent fails under rmem
pressure.

Signed-off-by: David Carlier <devnexen@gmail.com>
Assisted-by: Codex:gpt-5
---
 net/mptcp/protocol.c | 121 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6b486fc94c16..558aa57073a7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -819,26 +819,29 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 {
 	int ssk_state;
 	int err;
+	bool has_errqueue;
 
-	/* only propagate errors on fallen-back sockets or
-	 * on MPC connect
-	 */
-	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
-		return false;
-
+	has_errqueue = !skb_queue_empty_lockless(&ssk->sk_error_queue);
 	err = sock_error(ssk);
-	if (!err)
+	if (!err && !has_errqueue)
 		return false;
 
-	/* We need to propagate only transition to CLOSE state.
-	 * Orphaned socket will see such state change via
-	 * subflow_sched_work_if_closed() and that path will properly
-	 * destroy the msk as needed.
+	/* Errqueue notifications should wake poll()/recvmsg(MSG_ERRQUEUE) on
+	 * the MPTCP socket, but only fallback sockets and the MPC connect path
+	 * inherit TCP's sk_err semantics.
 	 */
-	ssk_state = inet_sk_state_load(ssk);
-	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
-		mptcp_set_state(sk, ssk_state);
-	WRITE_ONCE(sk->sk_err, -err);
+	if (err &&
+	    (sk->sk_state == TCP_SYN_SENT || __mptcp_check_fallback(mptcp_sk(sk)))) {
+		/* We need to propagate only transition to CLOSE state.
+		 * Orphaned socket will see such state change via
+		 * subflow_sched_work_if_closed() and that path will properly
+		 * destroy the msk as needed.
+		 */
+		ssk_state = inet_sk_state_load(ssk);
+		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
+			mptcp_set_state(sk, ssk_state);
+		WRITE_ONCE(sk->sk_err, -err);
+	}
 
 	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
 	smp_wmb();
@@ -2286,6 +2289,68 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 	return 0;
 }
 
+static struct sock *mptcp_pick_errqueue_subflow(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk = NULL;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
+		struct sock *subflow_sk = mptcp_subflow_tcp_sock(subflow);
+
+		if (skb_queue_empty_lockless(&subflow_sk->sk_error_queue))
+			continue;
+
+		if (!refcount_inc_not_zero(&subflow_sk->sk_refcnt))
+			continue;
+
+		ssk = subflow_sk;
+		break;
+	}
+	release_sock(sk);
+
+	return ssk;
+}
+
+static bool mptcp_has_error_queue(const struct sock *sk)
+{
+	return !skb_queue_empty_lockless(&sk->sk_error_queue);
+}
+
+static int mptcp_recv_error(struct sock *sk, struct msghdr *msg, int len)
+{
+	struct sk_buff *skb;
+	struct sock *ssk;
+	int ret, ret2;
+
+	if (mptcp_has_error_queue(sk))
+		return inet_recv_error(sk, msg, len);
+
+	ssk = mptcp_pick_errqueue_subflow(sk);
+	if (!ssk)
+		return -EAGAIN;
+
+	skb = sock_dequeue_err_skb(ssk);
+	if (!skb)
+		goto put_ssk;
+
+	ret = sock_queue_err_skb(sk, skb);
+	if (ret) {
+		ret2 = sock_queue_err_skb(ssk, skb);
+		sock_put(ssk);
+		if (ret2)
+			kfree_skb(skb);
+		return ret;
+	}
+
+	sock_put(ssk);
+	return inet_recv_error(sk, msg, len);
+
+put_ssk:
+	sock_put(ssk);
+	return -EAGAIN;
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int flags)
 {
@@ -2295,9 +2360,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
 	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len);
+		return mptcp_recv_error(sk, msg, len);
 
 	lock_sock(sk);
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
@@ -4296,6 +4360,26 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 	return 0;
 }
 
+static bool mptcp_subflow_has_error(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	bool has_error = false;
+
+	mptcp_data_lock(sk);
+	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (READ_ONCE(ssk->sk_err) ||
+		    !skb_queue_empty_lockless(&ssk->sk_error_queue)) {
+			has_error = true;
+			break;
+		}
+	}
+	mptcp_data_unlock(sk);
+
+	return has_error;
+}
+
 static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait)
 {
@@ -4339,7 +4423,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-	if (READ_ONCE(sk->sk_err))
+	if (READ_ONCE(sk->sk_err) || mptcp_has_error_queue(sk) ||
+	    mptcp_subflow_has_error(sk))
 		mask |= EPOLLERR;
 
 	return mask;
-- 
2.53.0

