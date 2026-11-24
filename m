Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557717;
	b=wvZWKhwZ06xcRQgKaYNO9XIR7Mi9k41RO2oimHxt56CF8t5+yfgi4ypVVlg3TShN5d1p
	 /BUv8JDtMlTbiPFrl9NTCmQQanSOI0Tmk0ZXcoSdGAvJs4nkI0PB2qaHUGQd+FM+YD7Np
	 JGvVqDDGWRGqesDRvvrcmWCvvV3GkIjh+s5NZiA1PVcLEiPmUdnNMJQmWqdrgXA/2z5vT
	 UJm/zAeNYnLf0WmQ9rYbhkzzPS4oWJMkTFsng47AHKp7QbF0pfHPSQmb3GKN7CLfFAL0j
	 9ur6Xc11TIRA8HcnhXWsQR8dO8V2rguSuBlAqIfAxVRqxb+UkRHnpCnhQ3QqHo0cJkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557717;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Jd7F08cGCiDp86kacKQcbWhyKdloas4iKA/eNsBn/SM=;
	b=YSChRHelHeV27Fn7oBTkj6Kf1rbcBYckMtWxhZNrOd+pJpuIihqSzXrM1DCkpFsmN9d0
	 ryyrqc2rwmYzIA2nNCpXtWBXuIwSFNdqKBI1AQ4vbDVxi/B6UqrUC8k/+sDVrRXQJmdr+
	 FEbI4D0HUDdFPBnNyrYalTZ0sXyDOSWjWMrHGt/wae2X+8G39F9UHXZFughBk2ugsg0Y3
	 6JVb/DxStrWvcoTkMx5osY01SzQne4lgxhwckXzWOYnOQ/kGG3GIvWUK3cvNb7E3+KLZC
	 bFeW68NSzzWRtZjj2cEh/gTJkvBKCxBPIBfX7h5PBSA7TbUywFAqatq4vuf8Rxnfhqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzUgU36f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75687606A321
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzUgU36f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BD31F000C4;
	Tue, 24 Nov 2026 22:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557717;
	bh=Jd7F08cGCiDp86kacKQcbWhyKdloas4iKA/eNsBn/SM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bzUgU36fnjkKYROeVmJRz7D+XyAd+Yw8UUFXc+L9syFzo+kqiDY99GzXDhWk41JRI
	 4x+KhuKZTBdeMu9WqvhUB8F5/Wc+i6RlbK6KS4OI5lk9rSZJ/kC8Q5Lk34qdzIZ1n5
	 5mInNAEq3E5RY0140aL75i7j43dhCPaCiLJI6TxPSRd4TjgkcCe7JiPEyAkEFGvto+
	 ckxDPbrC7vfvU1LpoXedKpD+gYAYaN4Q2JHah0g76+vvmRl3g5Um5jS0FjDe0vFO7p
	 F4FRi+0LkbWbO8le1Ye3UALgjrBF2dhVQk0K+xyYtTm3QY7DMJ61ML/fiocaFVv3X5
	 l8Bim8hvj3MDw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 23:00:05 +0100
Subject: [PATCH mptcp-next mptcp-net v3 48/50] mptcp: report errors as TCP
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-48-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7050; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ph5iSx0BeWYtMqvh4sPPWNlYm0a/1Ti2C3EtEq+SQ7I=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOEXFJbsz9D8+id0v0rC2XO/+5dPzrM4onL6rtjOh4
 cspTUvpjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlMrGFkeC3BHGwzW+/Wdw13
 AfGHAizup91OTymu15eZaGLe4s/rz/C/YL2omeHn2+8l7i5qlFxteHRC81FPvebS4L/2F0MX3OL
 iAgA=
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

Note (Clashiko on v2): the FIN cleared by the disconnect of the first
subflow is now handled by "mptcp: return EOF after a DATA_FIN, as TCP
does", and a reset received before accept() after a fallback by "mptcp:
report errors received before accept()". In FIN_WAIT2, the subflow error
is still reported by __mptcp_error_report(), deferred to the release of
the socket.
---
 net/mptcp/protocol.c | 88 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 016b16b3cc92..0a7600aea181 100644
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
@@ -983,7 +1033,7 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD)) {
 		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
 		smp_wmb();
-		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
+		WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 		mptcp_set_state(sk, ssk_state);
 	}
 	report = true;
@@ -2809,7 +2859,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool dispose_it, need_push = false;
-	int fwd_remaining;
+	int fwd_remaining, ssk_err;
 
 	/* Do not pass RX data to the msk, even if the subflow socket is not
 	 * going to be freed (i.e. even for the first subflow on graceful
@@ -2817,6 +2867,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	 */
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 	subflow->closing = 1;
+	/* in case it is the last subflow: before its disconnect or dispose */
+	ssk_err = READ_ONCE(ssk->sk_err);
 
 	if (flags & MPTCP_CF_PUSH)
 		mptcp_cleanup_ssk_backlog(sk, ssk);
@@ -2905,13 +2957,15 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
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
+			if (sk->sk_state == TCP_CLOSE)
+				mptcp_close_wake_up(sk);
+			else
+				mptcp_close_last_err(sk, ssk_err);
 		} else {
 			mptcp_start_tout_timer(sk);
 		}
@@ -3108,20 +3162,10 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -3441,8 +3485,7 @@ static void mptcp_worker(struct work_struct *work)
 		mptcp_do_fastclose(sk);
 		mptcp_for_each_subflow_safe(msk, subflow, tmp)
 			__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);
-		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
-		mptcp_close_wake_up(sk);
+		mptcp_close_err(sk, ETIMEDOUT);
 	}
 
 	if (sock_flag(sk, SOCK_DEAD) && sk->sk_state == TCP_CLOSE) {
@@ -4795,10 +4838,13 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
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

-- 
2.55.0

