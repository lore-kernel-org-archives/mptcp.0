Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A95671
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 09:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623835803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6a+kFpERWa6UjhNGfDJeY1jDr0lBmzeOdzXUkMqJPIo=;
	b=EAMPBIT+r2EKaYH1zNdROSOtOM8G4Bz5hk23l3/qr2DJvTNCGibWqrTCKnSYBhnru7HE5f
	ImU6JQ0tfUH9Vu6XNC6RBWo/Ap0y/GKjp5InWqNQ6Cgq8wdjWydZDst969+0+NBiRrA7Ug
	ydvgmM1swxSoVBiCP8sLCcl9CfjPAxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-dlu3Vh6LN5mFRSbxnXJTfg-1; Wed, 16 Jun 2021 05:30:01 -0400
X-MC-Unique: dlu3Vh6LN5mFRSbxnXJTfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA7E91850608
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 09:30:00 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-145.ams2.redhat.com [10.36.114.145])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3BECB19C66
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 09:30:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next] mptcp: refine mptcp_cleanup_rbuf
Date: Wed, 16 Jun 2021 11:29:55 +0200
Message-Id: <93432e2a93c4ae6124fb607346ecfac45d40b2b3.1623835767.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The current cleanup rbuf tries a bit too hard to avoid acquiring
the subflow socket lock. We may end-up delaying the needed ack,
or skip acking a blocked subflow.

Address the above extending the conditions used to trigger the cleanup
to reflect more closely what TCP does and invoking tcp_cleanup_rbuf()
on all the active subflows.

Note that we can't replicate the exact tests implemented in
tcp_cleanup_rbuf(), as MPTCP lacks some of the required info - e.g.
ping-pong mode.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - mptcp_subflow_cleanup_rbuf() returns void
v1 -> v2:
 - access ssk icsk/tp state instead of msk (Mat)
---
 net/mptcp/protocol.c | 56 ++++++++++++++++++--------------------------
 net/mptcp/protocol.h |  1 -
 2 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0a220862f62d..05c8382aafef 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -442,49 +442,46 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
 	}
 }
 
-static bool mptcp_subflow_cleanup_rbuf(struct sock *ssk)
+static void mptcp_subflow_cleanup_rbuf(struct sock *ssk)
 {
 	bool slow;
-	int ret;
 
 	slow = lock_sock_fast(ssk);
-	ret = tcp_can_send_ack(ssk);
-	if (ret)
+	if (tcp_can_send_ack(ssk))
 		tcp_cleanup_rbuf(ssk, 1);
 	unlock_sock_fast(ssk, slow);
-	return ret;
+}
+
+static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
+{
+	const struct inet_connection_sock *icsk = inet_csk(ssk);
+	bool ack_pending = READ_ONCE(icsk->icsk_ack.pending);
+	const struct tcp_sock *tp = tcp_sk(ssk);
+
+	return (ack_pending & ICSK_ACK_SCHED) &&
+		((READ_ONCE(tp->rcv_nxt) - READ_ONCE(tp->rcv_wup) >
+		  READ_ONCE(icsk->icsk_ack.rcv_mss)) ||
+		 (rx_empty && ack_pending &
+			      (ICSK_ACK_PUSHED2 | ICSK_ACK_PUSHED)));
 }
 
 static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
 {
-	struct sock *ack_hint = READ_ONCE(msk->ack_hint);
 	int old_space = READ_ONCE(msk->old_wspace);
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	bool cleanup;
+	int space =  __mptcp_space(sk);
+	bool cleanup, rx_empty;
 
-	/* this is a simple superset of what tcp_cleanup_rbuf() implements
-	 * so that we don't have to acquire the ssk socket lock most of the time
-	 * to do actually nothing
-	 */
-	cleanup = __mptcp_space(sk) - old_space >= max(0, old_space);
-	if (!cleanup)
-		return;
+	cleanup = (space > 0) && (space >= (old_space << 1));
+	rx_empty = !atomic_read(&sk->sk_rmem_alloc);
 
-	/* if the hinted ssk is still active, try to use it */
-	if (likely(ack_hint)) {
-		mptcp_for_each_subflow(msk, subflow) {
-			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-			if (ack_hint == ssk && mptcp_subflow_cleanup_rbuf(ssk))
-				return;
-		}
+		if (cleanup || mptcp_subflow_could_cleanup(ssk, rx_empty))
+			mptcp_subflow_cleanup_rbuf(ssk);
 	}
-
-	/* otherwise pick the first active subflow */
-	mptcp_for_each_subflow(msk, subflow)
-		if (mptcp_subflow_cleanup_rbuf(mptcp_subflow_tcp_sock(subflow)))
-			return;
 }
 
 static bool mptcp_check_data_fin(struct sock *sk)
@@ -629,7 +626,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			break;
 		}
 	} while (more_data_avail);
-	WRITE_ONCE(msk->ack_hint, ssk);
 
 	*bytes += moved;
 	return done;
@@ -1910,7 +1906,6 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 		__mptcp_update_rmem(sk);
 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
 		mptcp_data_unlock(sk);
-		tcp_cleanup_rbuf(ssk, moved);
 
 		if (unlikely(ssk->sk_err))
 			__mptcp_error_report(sk);
@@ -1926,7 +1921,6 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 		ret |= __mptcp_ofo_queue(msk);
 		__mptcp_splice_receive_queue(sk);
 		mptcp_data_unlock(sk);
-		mptcp_cleanup_rbuf(msk);
 	}
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
@@ -2175,9 +2169,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (ssk == msk->last_snd)
 		msk->last_snd = NULL;
 
-	if (ssk == msk->ack_hint)
-		msk->ack_hint = NULL;
-
 	if (ssk == msk->first)
 		msk->first = NULL;
 
@@ -2392,7 +2383,6 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->rmem_released = 0;
 	msk->tx_pending_data = 0;
 
-	msk->ack_hint = NULL;
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 41f2957bf50c..2480db50cbd2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -243,7 +243,6 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	spinlock_t	join_list_lock;
-	struct sock	*ack_hint;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
-- 
2.26.3

