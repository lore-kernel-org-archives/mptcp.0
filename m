Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9133814F6D
	for <mptcp@lists.linux.dev>; Tue, 29 Aug 2023 15:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693323573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPUpjYVTAeFnFZNviqrlaQAS1jqNMg/kMWlAAbUJBJ8=;
	b=d5HdaKWnHhbcwII4rSpzOexD5N6ZKuldr9hGXrdb2W5Q4jBX1S4TYhKrfitUW4s9m27GWz
	QgsqHGOSPAVzh9gukREREjHAk1kvxgJWR4P20DebjW8GvmubEiwMJE/eEIQs618EhFQj93
	1uMkv3yJg9r1V2KPsF4gxMTGKBHfIYk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-Zx1q38D5ONuZ5xWNPbFBSQ-1; Tue, 29 Aug 2023 11:39:31 -0400
X-MC-Unique: Zx1q38D5ONuZ5xWNPbFBSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8579C185A78B
	for <mptcp@lists.linux.dev>; Tue, 29 Aug 2023 15:39:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DEBA740C2063
	for <mptcp@lists.linux.dev>; Tue, 29 Aug 2023 15:39:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 2/2] mptcp: implement connection level timeout.
Date: Tue, 29 Aug 2023 17:39:21 +0200
Message-ID: <07268fba668d7645da445279581ecef9178c1b01.1693322440.git.pabeni@redhat.com>
In-Reply-To: <cover.1693322440.git.pabeni@redhat.com>
References: <cover.1693322440.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/430
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - really set the close timeout as need.
---
 net/mptcp/protocol.c | 85 ++++++++++++++++++++++----------------------
 net/mptcp/protocol.h | 20 +++++++++++
 net/mptcp/subflow.c  |  1 +
 3 files changed, 63 insertions(+), 43 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 33093ed87077..3d86664c8187 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -75,7 +75,6 @@ static bool mptcp_is_tcpsk(struct sock *sk)
 		return true;
 #endif
 	}
-
 	return false;
 }
 
@@ -886,6 +885,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_subflow_joined(msk, ssk);
+	mptcp_stop_tout_timer(sk);
 	return true;
 }
 
@@ -2363,18 +2363,15 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	bool dispose_it, need_push = false;
 
 	/* If the first subflow moved to a close state before accept, e.g. due
-	 * to an incoming reset, mptcp either:
-	 * - if either the subflow or the msk are dead, destroy the context
-	 *   (the subflow socket is deleted by inet_child_forget) and the msk
-	 * - otherwise do nothing at the moment and take action at accept and/or
-	 *   listener shutdown - user-space must be able to accept() the closed
-	 *   socket.
+	 * to an incoming reset or listener shoutdown, the subflow socket is
+	 * already deleted by inet_child_forget() the mptcp socket can't survive
+	 * too.
 	 */
-	if (msk->in_accept_queue && msk->first == ssk) {
-		if (!sock_flag(sk, SOCK_DEAD) && !sock_flag(ssk, SOCK_DEAD))
-			return;
-
+	if (msk->in_accept_queue && msk->first == ssk &&
+	    (sock_flag(sk, SOCK_DEAD) || sock_flag(ssk, SOCK_DEAD))) {
 		/* ensure later check in mptcp_worker() will dispose the msk */
+		inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32 -
+							  TCP_TIMEWAIT_LEN;
 		sock_set_flag(sk, SOCK_DEAD);
 		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 		mptcp_subflow_drop_ctx(ssk);
@@ -2437,6 +2434,22 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
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
@@ -2480,23 +2493,16 @@ static void __mptcp_close_subflow(struct sock *sk)
 
 }
 
-static bool mptcp_should_close(const struct sock *sk)
+static bool mptcp_close_tout_expired(const struct sock *sk)
 {
-	s32 delta = tcp_jiffies32 - inet_csk(sk)->icsk_mtup.probe_timestamp;
-	struct mptcp_subflow_context *subflow;
+	s32 delta;
 
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
+	delta = tcp_jiffies32 - inet_csk(sk)->icsk_mtup.probe_timestamp;
+	return delta >= TCP_TIMEWAIT_LEN;
 }
 
 static void mptcp_check_fastclose(struct mptcp_sock *msk)
@@ -2635,7 +2641,7 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 	struct sock *sk = (struct sock *)msk;
 	unsigned long timeout, close_timeout;
 
-	if (!fail_tout && !sock_flag(sk, SOCK_DEAD))
+	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
 		return;
 
 	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
@@ -2643,7 +2649,7 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 	/* the close timeout takes precedence on the fail one, and here at least one of
 	 * them is active
 	 */
-	timeout = sock_flag(sk, SOCK_DEAD) ? close_timeout : fail_tout;
+	timeout = inet_csk(sk)->icsk_mtup.probe_timestamp ? close_timeout : fail_tout;
 
 	sk_reset_timer(sk, &sk->sk_timer, timeout);
 }
@@ -2662,8 +2668,6 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 	mptcp_subflow_reset(ssk);
 	WRITE_ONCE(mptcp_subflow_ctx(ssk)->fail_tout, 0);
 	unlock_sock_fast(ssk, slow);
-
-	mptcp_reset_tout_timer(msk, 0);
 }
 
 static void mptcp_do_fastclose(struct sock *sk)
@@ -2700,18 +2704,14 @@ static void mptcp_worker(struct work_struct *work)
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
@@ -3010,7 +3010,6 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 cleanup:
 	/* orphan all the subflows */
-	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast_nested(ssk);
@@ -3047,7 +3046,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
 	} else {
-		mptcp_reset_tout_timer(msk, 0);
+		mptcp_start_tout_timer(sk);
 	}
 
 	return do_cancel_work;
@@ -3111,7 +3110,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	inet_sk_state_store(sk, TCP_CLOSE);
 
 	mptcp_stop_rtx_timer(sk);
-	sk_stop_timer(sk, &sk->sk_timer);
+	mptcp_stop_tout_timer(sk);
 
 	if (msk->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4fcce9ad7d04..392c2f247034 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -726,6 +726,26 @@ void mptcp_get_options(const struct sk_buff *skb,
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
+static inline void mptcp_start_tout_timer(struct sock *sk)
+{
+	/* avoid 0 timestamp, at that means no close timeout */
+	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
+	if (!inet_csk(sk)->icsk_mtup.probe_timestamp)
+		inet_csk(sk)->icsk_mtup.probe_timestamp = 1;
+
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

