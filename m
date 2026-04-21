Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D823D7D9D
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784949; cv=none; b=MrpaSrcY3oRjUJJQYMfzRJHNabYYN5V3T7I7RDM8GHT8QiwC1xHByTFhkktp2bN19zy3102Gxu7qKZzH5Yvm7qnjXbTUkOAbHJA/3lo/4WF+2hqan/t/2JP6K46xjqwun+s/g5N/t5kARSQd3AzeK5QfRVqpAU5rEgOLUPV9wds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784949; c=relaxed/simple;
	bh=Y13M/z1PUkRYdx6T147SQvL+8nHPZtZjHP2OD6TEy6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paPxtE8kkIlQNsS8Tbh9CNXcnV8ZgYfUpdwdo93Aun/B3MmLL8VB0NGJ5+DngL3Ph+Dqp9gCqkjZJ/pSTdMLF19i/sggMvH6b+b+TXdiOgzDu6kMEXcDgeCqLlQo6Mx3uhAv1a6mNKulwBXQM68H1MP5lKs8qvX9vyNB5ph+oBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXLBk6ha; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXLBk6ha"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cfd832155so3199137f8f.1
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776784946; x=1777389746; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vQyN4XtQNgy58qiSyngDxgLbuPWflaYDxCcpF1TE+w=;
        b=qXLBk6ha8tynamLPlBNxy762NSrmRfA4NtOM0imA5HxVxfDdcIz0JYoFDqMDN5Wtgv
         aazEG8hnf3HLua1fBVMF8v3UuVFL4lIf5DOHf7XlprLVffC2QNwF3/uFQA6ozpXF2M60
         IiPq5lpG9NQhCW7MmS3OGxePauWW+xAzI6P9Qw+0naDu67Fkvs1JOHwRARZyAR7r+/i1
         gcNgIsI8J2SnOnXhPkH3tKmpkAlLczduq9tEtRNRRkWtt90MsF4egW/tMyy+J5FHF5Ad
         AIoZcP6+EUxnW8NX5WRlCablrfGhZdeg8z8Fr0rslOc7DM1QdA/YddJZKQesrWx1UMTa
         aIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776784946; x=1777389746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8vQyN4XtQNgy58qiSyngDxgLbuPWflaYDxCcpF1TE+w=;
        b=apCU6WR7rk0wXPUCFB4Nkh7+Yu2t3Emh7BOcUef3BLg9/AeKeqWM1rNQiTMut/8GyF
         GXqnF3kz87ZzgpfPb+XnqsZrDv2a+14dObsarvC9hiY0+51bM38+ukdSBheaFx8LWwn6
         Z1vDVQrbgfmJPZOTlLiCykUnkJUNpZbIpvvA/pQ9X5gE93ohlZX5cY7w30i0V99nVQz9
         b2ka3bdSwJ1+21eqGt6SMc8eBTLqgi6/L0WTHW+SZjJYakfXFLz9ylw0Qw2i2wwWx1VG
         bi6E8Ff2GB8AokFUv4l+l7884Ysx0L+H8v3IuphFlbRnvEC9PUhV1h6JWmBI0mvMZPhe
         AW6w==
X-Forwarded-Encrypted: i=1; AFNElJ9ESVXY5p8eck2t0VV/4HEiqTo22jpWmsugp6wyFyxL4IiWbtGcaeTjL2r529TORUK7gnlEug==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzf63Nnsz+alkLxHxzuKgMMaXUBX065oQBeKjf5eUrGUoDy/EST
	t+aMHY3WPhBQAvfC7cZwdXwoMiSSaRLITeenU/Cfwmqo9WZcDCl4qKPY
X-Gm-Gg: AeBDiesW1MfrtAHW+dpykVTm+jdOmeCXc5KIwa5SR9P3oezcIE7dieNeU/cySK1xP8H
	9VLCzYEQxmBcyTDGyKLPTibh13eVv0Yl5A0AaF2yTLlGqDRMZK2Nx7+gyFvmsxK06WjYzRx8qQ7
	eaYiOXhXsRPLhjPBuWSRlFsQznb+lAlEw1tTp3Dh9wvxY5riyDvo91WZ0D3a8o6vya3EA/JS7sk
	3a7xjQJo9O2C+K8cvH1L3VFQCIq3tfRpNcNEjmsmr5m2yW2NySX2Ey6IhFi++0RRZjrfFohL0Ah
	54lMHEcy6JIQYoJC9ZFSutZiHYSSx8WhQzkL6WLUdDIkjz0NGURN9v4aY6TjVqQOzLJYdPnHV73
	nGUJbpPlD4pTRM3mZWfInI+FeQADdEj3EBP2EEZwbx1SN9avMekaxuuTSR0u6I981SfzqquJZlL
	y6rfXu6mo9FfeC/rOnAw3p+3EISBFSD82S3CrJUHacc3k8/UDdo7K3JrQY0EqKxaeCd6tFhu0Qm
	tYMfYIhmoV/25NmS4wd5Q==
X-Received: by 2002:a05:6000:250e:b0:439:b440:b8a2 with SMTP id ffacd0b85a97d-43fe3dfba35mr27902238f8f.28.1776784945891;
        Tue, 21 Apr 2026 08:22:25 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4411c9f4f03sm8975225f8f.1.2026.04.21.08.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:22:25 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 2/3] mptcp: support MSG_ERRQUEUE on the parent socket
Date: Tue, 21 Apr 2026 16:22:10 +0100
Message-ID: <20260421152216.38127-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421152216.38127-1-devnexen@gmail.com>
References: <20260421152216.38127-1-devnexen@gmail.com>
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
index fbffd3a43fe8..1b2e3bede122 100644
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

