Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8E62B
	for <mptcp@lists.linux.dev>; Wed,  6 Sep 2023 08:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693989275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNk/g3m/HQVOv3wTsVKcaZ2QO3UBdBN1wqoxwURixEY=;
	b=QkfyNhuORqyo7AUbkV4K40TqtMYKr5CuATNfi8b8nk6x6/yVaOD4364FLVTWsGAZguY8rc
	wAkh1vy4O7IrL14MHegNaNqT6Ag/2W9Bafo01IIs6ZbQBEnS07dpf2dCeI8Gnt/vP4gM5f
	CkPH5N6j5MQxa9yqVJVaGRGuNB7nf7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-138-fvPhiO-bMMCcUDggmT6Ktw-1; Wed, 06 Sep 2023 04:33:53 -0400
X-MC-Unique: fvPhiO-bMMCcUDggmT6Ktw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B95D8164E1
	for <mptcp@lists.linux.dev>; Wed,  6 Sep 2023 08:33:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.172])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EFA8D1121314
	for <mptcp@lists.linux.dev>; Wed,  6 Sep 2023 08:33:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v5 2/2] mptcp: fix dangling connection hang-up
Date: Wed,  6 Sep 2023 10:30:28 +0200
Message-ID: <c6eb12bdaa092d1f98ae15adb99729c8192d8939.1693988314.git.pabeni@redhat.com>
In-Reply-To: <cover.1693988314.git.pabeni@redhat.com>
References: <cover.1693988314.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

According to RFC 8684 section 3.3:

  A connection is not closed unless [...] or an implementation-specific
  connection-level send timeout.

Currently the MPTCP protocol does not implement such timeout, and
connection timing-out at the TCP-level never move to close state.

Introduces a catch-up condition at subflow close time to move the
MPTCP socket to close, too.

That additionally allow removing similar existing inside the worker.

Finally, allow some additional timeout for plain ESTABLISHED mptcp
sockets, as the protocol allows creating new subflows even at that
point and making the connection functional again.

The issues is actually present since the beginning, but it basically
impossible to solve without a long chain of functional pre-requisites
topped by the blamed commit below.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/430
Fixes: bbd49d114d57 ("mptcp: consolidate transition to TCP_CLOSE in mptcp_do_fastclose()")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - let the tout always expire for dead socks (Mat)
 - fix comment type (Mat)
 - targeting net, added fixes tag

v3 -> v4:
 - fix off-by-one in timer update/check (sigh, trival math is too
   hard:/)

v2 -> v3:
 - fix integer overflow in mptcp_close_tout_expired()
v1 -> v2:
 - really set the close timeout as need.
---
 net/mptcp/protocol.c | 86 ++++++++++++++++++++++----------------------
 net/mptcp/protocol.h | 24 +++++++++++++
 net/mptcp/subflow.c  |  1 +
 3 files changed, 67 insertions(+), 44 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b9497712eb8f..3facdc006adc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -892,6 +892,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_subflow_joined(msk, ssk);
+	mptcp_stop_tout_timer(sk);
 	return true;
 }
 
@@ -2369,18 +2370,14 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	bool dispose_it, need_push = false;
 
 	/* If the first subflow moved to a close state before accept, e.g. due
-	 * to an incoming reset, mptcp either:
-	 * - if either the subflow or the msk are dead, destroy the context
-	 *   (the subflow socket is deleted by inet_child_forget) and the msk
-	 * - otherwise do nothing at the moment and take action at accept and/or
-	 *   listener shutdown - user-space must be able to accept() the closed
-	 *   socket.
+	 * to an incoming reset or listener shutdown, the subflow socket is
+	 * already deleted by inet_child_forget() and the mptcp socket can't
+	 * survive too.
 	 */
-	if (msk->in_accept_queue && msk->first == ssk) {
-		if (!sock_flag(sk, SOCK_DEAD) && !sock_flag(ssk, SOCK_DEAD))
-			return;
-
+	if (msk->in_accept_queue && msk->first == ssk &&
+	    (sock_flag(sk, SOCK_DEAD) || sock_flag(ssk, SOCK_DEAD))) {
 		/* ensure later check in mptcp_worker() will dispose the msk */
+		mptcp_set_close_tout(sk, tcp_jiffies32 - (TCP_TIMEWAIT_LEN + 1));
 		sock_set_flag(sk, SOCK_DEAD);
 		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 		mptcp_subflow_drop_ctx(ssk);
@@ -2443,6 +2440,22 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 out:
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
+
+	/* Catch every 'all subflows closed' scenario, including peers silently
+	 * closing them, e.g. due to timeout.
+	 * For established sockets, allow an additional timeout before closing,
+	 * as the protocol can still create more subflows.
+	 */
+	if (list_is_singular(&msk->conn_list) && msk->first &&
+	    inet_sk_state_load(msk->first) == TCP_CLOSE) {
+		if (sk->sk_state != TCP_ESTABLISHED ||
+		    msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
+			inet_sk_state_store(sk, TCP_CLOSE);
+			mptcp_close_wake_up(sk);
+		} else {
+			mptcp_start_tout_timer(sk);
+		}
+	}
 }
 
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
@@ -2486,23 +2499,14 @@ static void __mptcp_close_subflow(struct sock *sk)
 
 }
 
-static bool mptcp_should_close(const struct sock *sk)
+static bool mptcp_close_tout_expired(const struct sock *sk)
 {
-	s32 delta = tcp_jiffies32 - inet_csk(sk)->icsk_mtup.probe_timestamp;
-	struct mptcp_subflow_context *subflow;
-
-	if (delta >= TCP_TIMEWAIT_LEN || mptcp_sk(sk)->in_accept_queue)
-		return true;
+	if (!inet_csk(sk)->icsk_mtup.probe_timestamp ||
+	    sk->sk_state == TCP_CLOSE)
+		return false;
 
-	/* if all subflows are in closed status don't bother with additional
-	 * timeout
-	 */
-	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
-		if (inet_sk_state_load(mptcp_subflow_tcp_sock(subflow)) !=
-		    TCP_CLOSE)
-			return false;
-	}
-	return true;
+	return time_after32(tcp_jiffies32,
+		  inet_csk(sk)->icsk_mtup.probe_timestamp + TCP_TIMEWAIT_LEN);
 }
 
 static void mptcp_check_fastclose(struct mptcp_sock *msk)
@@ -2641,15 +2645,16 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 	struct sock *sk = (struct sock *)msk;
 	unsigned long timeout, close_timeout;
 
-	if (!fail_tout && !sock_flag(sk, SOCK_DEAD))
+	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
 		return;
 
-	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
+	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
+			TCP_TIMEWAIT_LEN;
 
 	/* the close timeout takes precedence on the fail one, and here at least one of
 	 * them is active
 	 */
-	timeout = sock_flag(sk, SOCK_DEAD) ? close_timeout : fail_tout;
+	timeout = inet_csk(sk)->icsk_mtup.probe_timestamp ? close_timeout : fail_tout;
 
 	sk_reset_timer(sk, &sk->sk_timer, timeout);
 }
@@ -2668,8 +2673,6 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 	mptcp_subflow_reset(ssk);
 	WRITE_ONCE(mptcp_subflow_ctx(ssk)->fail_tout, 0);
 	unlock_sock_fast(ssk, slow);
-
-	mptcp_reset_tout_timer(msk, 0);
 }
 
 static void mptcp_do_fastclose(struct sock *sk)
@@ -2706,18 +2709,14 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 		__mptcp_close_subflow(sk);
 
-	/* There is no point in keeping around an orphaned sk timedout or
-	 * closed, but we need the msk around to reply to incoming DATA_FIN,
-	 * even if it is orphaned and in FIN_WAIT2 state
-	 */
-	if (sock_flag(sk, SOCK_DEAD)) {
-		if (mptcp_should_close(sk))
-			mptcp_do_fastclose(sk);
+	if (mptcp_close_tout_expired(sk)) {
+		mptcp_do_fastclose(sk);
+		mptcp_close_wake_up(sk);
+	}
 
-		if (sk->sk_state == TCP_CLOSE) {
-			__mptcp_destroy_sock(sk);
-			goto unlock;
-		}
+	if (sock_flag(sk, SOCK_DEAD) && sk->sk_state == TCP_CLOSE) {
+		__mptcp_destroy_sock(sk);
+		goto unlock;
 	}
 
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
@@ -3016,7 +3015,6 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 cleanup:
 	/* orphan all the subflows */
-	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast_nested(ssk);
@@ -3053,7 +3051,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
 	} else {
-		mptcp_reset_tout_timer(msk, 0);
+		mptcp_start_tout_timer(sk);
 	}
 
 	return do_cancel_work;
@@ -3117,7 +3115,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	inet_sk_state_store(sk, TCP_CLOSE);
 
 	mptcp_stop_rtx_timer(sk);
-	sk_stop_timer(sk, &sk->sk_timer);
+	mptcp_stop_tout_timer(sk);
 
 	if (msk->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4fcce9ad7d04..74889f072d2d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -726,6 +726,30 @@ void mptcp_get_options(const struct sk_buff *skb,
 void mptcp_finish_connect(struct sock *sk);
 void __mptcp_set_connected(struct sock *sk);
 void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout);
+
+static inline void mptcp_stop_tout_timer(struct sock *sk)
+{
+	if (!inet_csk(sk)->icsk_mtup.probe_timestamp)
+		return;
+
+	sk_stop_timer(sk, &sk->sk_timer);
+	inet_csk(sk)->icsk_mtup.probe_timestamp = 0;
+}
+
+static inline void mptcp_set_close_tout(struct sock *sk, unsigned long tout)
+{
+	/* avoid 0 timestamp, at that means no close timeout */
+	inet_csk(sk)->icsk_mtup.probe_timestamp = tout;
+	if (!inet_csk(sk)->icsk_mtup.probe_timestamp)
+		inet_csk(sk)->icsk_mtup.probe_timestamp = 1;
+}
+
+static inline void mptcp_start_tout_timer(struct sock *sk)
+{
+	mptcp_set_close_tout(sk, tcp_jiffies32);
+	mptcp_reset_tout_timer(mptcp_sk(sk), 0);
+}
+
 static inline bool mptcp_is_fully_established(struct sock *sk)
 {
 	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 433f290984c8..918c1a235790 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1552,6 +1552,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	mptcp_sock_graft(ssk, sk->sk_socket);
 	iput(SOCK_INODE(sf));
 	WRITE_ONCE(msk->allow_infinite_fallback, false);
+	mptcp_stop_tout_timer(sk);
 	return 0;
 
 failed_unlink:
-- 
2.41.0

