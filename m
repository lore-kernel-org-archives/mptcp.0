Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809742;
	b=fHeNJBLY/AzDHZX0KsFS1A8fF36seMs6L5qOLjPBaGyWlJpHaR61pHo/is1cw07Rmev8
	 2Ex5lsKKmqWrf6IDQ4GYQIDHcEGzO7TxP9yPiKsisgJ2RiZ0NViM1GjDpqwkOapUSokYQ
	 FVI3GJ2/J/HkCC5qvSaoD5+C5Y8qnuDGKPnA9cMP61cHRFFZvEuwhSY4gq65LrcT3x4DC
	 FAT4v66vL3RwyC/QhpoVWTN/A7IpYchMezoBmBc6EOSE7Rk7RB/G1GvwKI7ijlmPYl7wu
	 XEzBVRqrww66cfxiAx2PZwdogdzIA45vbOoD0zRsrKHJQGSZmOTQ07oMNIFHAV6g4PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809742;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=35LzLpKUDEZlqqrlLrhvQZ8QSEcEMHRgV64KfB+LNx4=;
	b=ppKdh3ITocoPZGcSvQGkqmbcFUWGWf2W/MIAkMVk51IHWLgBM4BpghVdtF+gpWSTXDc0
	 QuZ2bmjMQumkpSRoyFmvZHlJxMy3TsPVTcGRwuLwhmkEqoHp8TQnUzxnqGNWdkZ86S0ZG
	 gC7FFCYlwFmfBlhJsezcAP3kEuUQvUSBCcisIimS2sbRjSXBeLbzHlc1V74MvMcuhZNbW
	 hZMfO+93b8M0mzbw+O7NLaEXiicj6pD8cHyx5+kj0Qxc6Li36WG4UBcniOATGI3giFWCX
	 bkpVopaW6cea3D7dwQ7gbAM2dWfOMSlf9wo2Y5XqAIykQMDuoDWeJ2NxnlN+XNj7YoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4xGUNum;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC849606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4xGUNum
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F771F0089B;
	Fri, 27 Nov 2026 20:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809742;
	bh=35LzLpKUDEZlqqrlLrhvQZ8QSEcEMHRgV64KfB+LNx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D4xGUNumkRVKM32aZseRf79Cwoo05f1jyIWh2WGbX2ihXn3PJyDS2f8N0dG8A+uqM
	 MXO28+r/62I6VWznwf6S+hVqnfqrZxsJKGjc7VNqtWRvhm+jDIhXvGbPy8vCxMfNI+
	 01lkOlRXOjHJqVks4Pkw+m6aKdlip9JZbdrPci/4SrWqqtSymvUPf8dNO9LfcFHyyB
	 ns1UH7wZiPVlaBk82XFAgbNRzbtXPAPFX8Em6udvYEIkSYTiIqYX/H1dujcyDW4kwD
	 JV2uwWOw2F5+fO8I8lxkPBaBAJtoz/CnPt+AI0bOdhMWbbetE+VL32lA7BM8jB8vmp
	 GGpDjoS/XYlpg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:41 +0100
Subject: [PATCH mptcp-next mptcp-net v4 17/20] mptcp: report errors as TCP
 does when closing
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-mptcp-cmason-fixes-v4-17-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7813; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mKuITHWuiE9I4AlTGbBix4vy81lhRupJH+rTOXT9KQc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H25Lkta6zOaVs4KVIyfceuX01U3SO6yev7905x3j3
 FUqOpNdOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYSM5uRYeXmZYu5zWvP5eSW
 r22YzHkixO2w69ZNTFfn5c562SWjv4/hr2CfTFCb3a7rBS93hHlalAY0/v51UUSSX3rDyXfbxDf
 28gIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the close timeout expires, or when the last subflow is closed in
another state than ESTABLISHED, the MPTCP socket moves to TCP_CLOSE
without error, and recv() then reports ENOTCONN instead of EOF. In
these cases, TCP sets SHUTDOWN_MASK and an error depending on the
state: ETIMEDOUT after a timeout, and ECONNRESET, EPIPE or ECONNREFUSED
after a reset.

Do the same, as tcp_done_with_error() does, also in the late cleanup
done by accept(), when the first subflow has been closed before: with
the error of the last subflow, e.g. ETIMEDOUT after its RTO. After a
reset, or without error, the error depends on the MPTCP-level state,
e.g. EPIPE after a DATA_FIN. When a subflow error closes the socket,
SHUTDOWN_MASK is now set too, as tcp_done() does.

This changes the errors seen by the applications: after the close
timeout, reading or writing now reports ETIMEDOUT once, instead of
ENOTCONN or EPIPE, then EOF and EPIPE, as with TCP after a timeout. The
tests checking these errors in the MPTCP Packetdrill repository have to
be adapted.

With the reproducer from the GitHub issue, where the only subflow dies
by RTO, send() now returns ETIMEDOUT after the subflow timeout and the
close timeout, instead of EPIPE.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/648
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for mptcp-next, as suggested in issue #648 on GitHub
v4: process the ack of our DATA_FIN before picking the error, and
    comment in mptcp_poll() (Clashiko)

Note (Clashiko on v2): the FIN cleared by the disconnect of the first
subflow is now handled by "mptcp: return EOF after a DATA_FIN, as TCP
does", and a reset received before accept() after a fallback by "mptcp:
report errors received before accept()". In FIN_WAIT2, the subflow error
is still reported by __mptcp_error_report(), deferred to the release of
the socket.

Note (Sashiko on v3): while the worker closes the socket, lockless
readers can briefly see it closed before its final error is set.
---
 net/mptcp/protocol.c | 94 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 72 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 64fc04ea997c..d8661fba643a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -518,6 +518,56 @@ static void mptcp_close_wake_up(struct sock *sk)
 		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
 }
 
+/* Mirror the tcp_reset() error propagation */
+static int mptcp_reset_err(const struct sock *sk)
+{
+	int err;
+
+	switch (sk->sk_state) {
+	case TCP_SYN_SENT:
+		err = ECONNREFUSED;
+		break;
+	case TCP_CLOSE_WAIT:
+		err = EPIPE;
+		break;
+	default:
+		err = ECONNRESET;
+	}
+
+	return err;
+}
+
+/* No more data can be exchanged: report it, as tcp_done_with_error() does */
+static void mptcp_close_err(struct sock *sk, int err)
+{
+	WRITE_ONCE(sk->sk_err, err);
+	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
+	smp_wmb();
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
+	mptcp_set_state(sk, TCP_CLOSE);
+	if (sock_flag(sk, SOCK_DEAD))
+		return;
+
+	mptcp_close_wake_up(sk);
+	sk_error_report(sk);
+}
+
+/* As TCP: the error of the last subflow, e.g. ETIMEDOUT, but after a reset
+ * (EBADMSG: by MPTCP) or without error, it depends on the msk state
+ */
+static void mptcp_close_last_err(struct sock *sk, int err)
+{
+	switch (err) {
+	case 0:
+	case ECONNREFUSED:
+	case ECONNRESET:
+	case EPIPE:
+	case EBADMSG:
+		err = mptcp_reset_err(sk);
+	}
+	mptcp_close_err(sk, err);
+}
+
 static void mptcp_shutdown_subflows(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -977,7 +1027,7 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD)) {
 		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
 		smp_wmb();
-		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
+		WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 		mptcp_set_state(sk, ssk_state);
 	}
 	report = true;
@@ -2818,7 +2868,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool dispose_it, need_push = false;
-	int fwd_remaining;
+	int fwd_remaining, ssk_err;
 
 	/* Do not pass RX data to the msk, even if the subflow socket is not
 	 * going to be freed (i.e. even for the first subflow on graceful
@@ -2826,6 +2876,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	 */
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 	subflow->closing = 1;
+	/* in case it is the last subflow: before its disconnect or dispose */
+	ssk_err = READ_ONCE(ssk->sk_err);
 
 	if (flags & MPTCP_CF_PUSH)
 		mptcp_cleanup_ssk_backlog(sk, ssk);
@@ -2914,13 +2966,17 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 			mptcp_set_close_tout(sk, tcp_jiffies32 -
 					     (mptcp_close_timeout(sk) + 1));
 			mptcp_schedule_work(sk);
+		} else if (sk->sk_state == TCP_CLOSE) {
+			mptcp_close_wake_up(sk);
 		} else if (sk->sk_state != TCP_ESTABLISHED ||
 			   msk->in_accept_queue) {
 			mptcp_check_rcv_close(sk);
-			mptcp_set_state(sk, TCP_CLOSE);
-			WRITE_ONCE(sk->sk_shutdown,
-				   sk->sk_shutdown | SEND_SHUTDOWN);
-			mptcp_close_wake_up(sk);
+			/* the ack of our DATA_FIN might not be processed yet */
+			mptcp_check_data_fin_ack(sk);
+			if (sk->sk_state == TCP_CLOSE)
+				mptcp_close_wake_up(sk);
+			else
+				mptcp_close_last_err(sk, ssk_err);
 		} else {
 			mptcp_start_tout_timer(sk);
 		}
@@ -3117,20 +3173,10 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 		unlock_sock_fast(tcp_sk, slow);
 	}
 
-	/* Mirror the tcp_reset() error propagation */
-	switch (sk->sk_state) {
-	case TCP_SYN_SENT:
-		WRITE_ONCE(sk->sk_err, ECONNREFUSED);
-		break;
-	case TCP_CLOSE_WAIT:
-		WRITE_ONCE(sk->sk_err, EPIPE);
-		break;
-	case TCP_CLOSE:
+	if (sk->sk_state == TCP_CLOSE)
 		return;
-	default:
-		WRITE_ONCE(sk->sk_err, ECONNRESET);
-	}
 
+	WRITE_ONCE(sk->sk_err, mptcp_reset_err(sk));
 	mptcp_set_state(sk, TCP_CLOSE);
 	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 	smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
@@ -3450,8 +3496,7 @@ static void mptcp_worker(struct work_struct *work)
 		mptcp_do_fastclose(sk);
 		mptcp_for_each_subflow_safe(msk, subflow, tmp)
 			__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);
-		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
-		mptcp_close_wake_up(sk);
+		mptcp_close_err(sk, ETIMEDOUT);
 	}
 
 	if (sock_flag(sk, SOCK_DEAD) && sk->sk_state == TCP_CLOSE) {
@@ -4804,10 +4849,13 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		 */
 		if (unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
 			if (unlikely(list_is_singular(&msk->conn_list))) {
+				int err = READ_ONCE(msk->first->sk_err);
+
 				mptcp_check_rcv_close(newsk);
 				/* not reported in the accept queue */
 				__mptcp_error_report(newsk);
-				mptcp_set_state(newsk, TCP_CLOSE);
+				if (newsk->sk_state != TCP_CLOSE)
+					mptcp_close_last_err(newsk, err);
 			}
 			mptcp_close_ssk(newsk, msk->first,
 					mptcp_subflow_ctx(msk->first));
@@ -4887,7 +4935,9 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLOUT | EPOLLWRNORM;
 	}
 
-	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
+	/* This barrier is coupled with smp_wmb() in
+	 * __mptcp_subflow_error_report() and mptcp_close_err()
+	 */
 	smp_rmb();
 	if (READ_ONCE(sk->sk_err) ||
 	    !skb_queue_empty_lockless(&sk->sk_error_queue))

-- 
2.55.0

