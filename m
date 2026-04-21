Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C126B2DA
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810828; cv=none; b=pKpu5taySrp747NkXThD++iVqwFzp5YerzAuxIMGnTewCTIQholN7ugU2kkK96aQivF7sq6eIWSQXuoVhi1M+bS5vreiAbelX8cCJVjHYnke0g9z91wrVFbAF989iF5h6ZI9BV2qlazpiyWXtFXMYwxoN9SeUAwfIOG19NchmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810828; c=relaxed/simple;
	bh=rmMCLSiNjQ0zi5Szgu6JuMRht5SNmzPSWgxY3yu8q74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTC6J8wR192yxPddIstUrHVCAof1wm+BmCQAoHQ8EgP+z/dqo11MuQlV76frqrn73v/xOOQsPYgBiLBCewNZ8m6o+13SQ21AvEOXPZU23e+nTegMITf9/BofilZWrqWrq4IwtBASyssfv2WHhGMaN05Vu6obgLhqe7iht6NkIDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzi7eZqc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzi7eZqc"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488d2079582so55643645e9.2
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 15:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776810825; x=1777415625; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpzd8+9DwlWwfdYBazdVMlZ0wJBEABxjwUprlU8+dHM=;
        b=dzi7eZqcdhaAYnB1LiYRL66cExajQfw5AL+h5rnxaD1XVQxOZ9mCI3Vx5nsw1cE/Sw
         FGdEWUZwiQguSJVxVnRernqzhgFWn5ahdKrFt4O0rH+yWdlE+7rvxAh8mcEMJyvHApbM
         2T0MQ2jDnrDUcW2r9ZIvr0eoHqrIRS0+w1mz268w3eOdF+qktf5dAYkqTqJx20YbRJoy
         vsi3FVyhVpAEev2kxpJ9AgtpKPdweNFCULXk3UCc1IdHLP1p3ATrNwnrfn1Zh3QlSI+m
         7Be918xEyfVkce3Y7GA/iH8tWl8SruoY7QxUQyerJ4l3juj0Y5QF6kwFE6n8w317SwLC
         BWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810825; x=1777415625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wpzd8+9DwlWwfdYBazdVMlZ0wJBEABxjwUprlU8+dHM=;
        b=YSzrsw3GWTawRpWfXZDNFSaZw40E8MhSS/iQ8w9m4XT+C9kUMPVDtR0a+2yHolZ7og
         KNaM6rtJgLxMbDWSz2PzLzZXL4oXGnRHR8P82ifJXGqyWzyAkogso2ZAQB2FdXmmRoDJ
         /FzAvlEhhbMxH1jqQt39IL16BWeao0mUN4OebOsgBQ0m2Tjj05h5/KKC/9DOn0b3BkK4
         cOfjuqvum6CxMrOt4ql9kYVEmF31wWc6uS6sw6lJK3VE5fbkqIxU3FVSixgVcaPvNyrE
         tYgoFkxxpl+l+m2TBfalcesXSXqPUG7e/lmZy4OyXf0XcafI9CHFOUi8kY31kosNIzeW
         VeQQ==
X-Gm-Message-State: AOJu0YzlXSEfu35jGnaNe6pxlwYLJCMmHork4FXIKKFRF/B/ac8bbP47
	6WhS5OCnwVtTE8u0Y/Vo9OKjwMrpNnXMOucJt1Wx6vN8mueRBUp7W5jI7Sd372W8
X-Gm-Gg: AeBDieu86fMCr6GSjIh9nsjHisZ0cgFsPwSSbCQGLanYcpOLaAZNjEpmkhkl3j3kpnk
	YhO6ZUxdXjq17VygJZuBOd0KHQ1Z5s4UQAENp4SonG4flu6zVkXAFcf62nm9YS7j8xYBi1wKX3G
	zQpowD0VQC+Bb6yvZqeTDuFLXzBR5pM6HQ6raCvZXASHPZwDFkb8jPew0SaiHn5a3lPVVyJLxtg
	uuhLn/9czmz1OlSvpTZmml6aqW3p8USSVchbzEfwn0uyGbtzesN3/Un9tCgIXFqRIRl3SAvMMhr
	TELrlB/CrTdLL7LyNF3joR2MnUSO9UHz27ReilKbS4qAOlxjSoeXo5q7c7A8jZtkJLOZ+2+755S
	MmrvCSXAG8ZZ+4S6UGQ84P3wGm34qjF9cXJzvdhINJ/QP94D7+J1bAcgQGEAYKCKVNLIWe+56z5
	Qu3dC4fuaDAz9K3kdp9to/0hQILz8/a58TIQqeqcxBINqqBXKQuziMdZQIYLc0YGnUnpezDJc31
	5qcevW20603A+ujywrThQ==
X-Received: by 2002:a05:600c:444a:b0:487:1520:d107 with SMTP id 5b1f17b1804b1-488fb793580mr262347415e9.31.1776810824537;
        Tue, 21 Apr 2026 15:33:44 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c01cfsm413350505e9.10.2026.04.21.15.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:33:43 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v3 2/3] mptcp: support MSG_ERRQUEUE on the parent socket
Date: Tue, 21 Apr 2026 23:33:37 +0100
Message-ID: <20260421223338.52743-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421223338.52743-1-devnexen@gmail.com>
References: <20260421223338.52743-1-devnexen@gmail.com>
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
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/protocol.c | 123 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6b486fc94c16..87871216bab2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -818,28 +818,29 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 {
 	int ssk_state;
-	int err;
+	int err = 0;
+	bool has_errqueue;
+
+	has_errqueue = !skb_queue_empty_lockless(&ssk->sk_error_queue);
 
-	/* only propagate errors on fallen-back sockets or
-	 * on MPC connect
+	/* Only fallback sockets and the MPC connect path inherit TCP's sk_err
+	 * semantics; consume ssk->sk_err only on those paths so steady-state
+	 * MPTCP doesn't silently drop TCP's one-shot errors.
 	 */
-	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
-		return false;
+	if (sk->sk_state == TCP_SYN_SENT ||
+	    __mptcp_check_fallback(mptcp_sk(sk))) {
+		err = sock_error(ssk);
+		if (err) {
+			ssk_state = inet_sk_state_load(ssk);
+			if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
+				mptcp_set_state(sk, ssk_state);
+			WRITE_ONCE(sk->sk_err, -err);
+		}
+	}
 
-	err = sock_error(ssk);
-	if (!err)
+	if (!err && !has_errqueue)
 		return false;
 
-	/* We need to propagate only transition to CLOSE state.
-	 * Orphaned socket will see such state change via
-	 * subflow_sched_work_if_closed() and that path will properly
-	 * destroy the msk as needed.
-	 */
-	ssk_state = inet_sk_state_load(ssk);
-	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
-		mptcp_set_state(sk, ssk_state);
-	WRITE_ONCE(sk->sk_err, -err);
-
 	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
 	smp_wmb();
 	sk_error_report(sk);
@@ -2286,6 +2287,68 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
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
+	if (READ_ONCE(sk->sk_err) || mptcp_has_error_queue(sk))
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
@@ -2295,9 +2358,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
 	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len);
+		return mptcp_recv_error(sk, msg, len);
 
 	lock_sock(sk);
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
@@ -4296,6 +4358,26 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
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
@@ -4339,7 +4421,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-	if (READ_ONCE(sk->sk_err))
+	if (READ_ONCE(sk->sk_err) || mptcp_has_error_queue(sk) ||
+	    mptcp_subflow_has_error(sk))
 		mask |= EPOLLERR;
 
 	return mask;
-- 
2.53.0

