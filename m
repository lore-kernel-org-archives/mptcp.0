Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E22CA0
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 17:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1638551327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c47uqCxycs0rXXbZjDfWyCcc+fG54OdBnrEshFSxHXU=;
	b=bvo+k9fTKMLrOsl3DN0fA24pIO1YKuUQIYIC5+jJQrFw/N6he5iW9lFbUQu1bSB/EHFVOJ
	pr0jfZhVIA8b5RFBURuFH40LCECt4wdHk7o+eSPEU16MIimbbR3rgadomict6UjuNexdgd
	63a24vDS2fB+nkkL31ctLJAZrtnfSVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-535-uWwYc-QIMfWiUlaSzvpGTw-1; Fri, 03 Dec 2021 12:08:44 -0500
X-MC-Unique: uWwYc-QIMfWiUlaSzvpGTw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A533285B660
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 17:08:43 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.192.107])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE3EA60C13
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 17:08:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [RFC PATCH] mptcp: cleanup MPJ subflow list handling
Date: Fri,  3 Dec 2021 18:08:38 +0100
Message-Id: <beb4f4d12b8e7afd58ad22252ee0ca060473334e.1638550827.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

We can simplify the join list handling leveraging the
mptcp_release_cb(): if we can acquire the msk socket
lock ad mptcp_finish_join time, move the new subflow
directly into the conn_list, othewise place it on join_list and
let the release_cb process such list.

Since pending MPJ connection are now always processed
in a timely way, we can avoid flushing the join list
every time we have to process all the current subflows.

Additionally we can now use the mptcp data lock to protect
the join_list, removing the additional spin lock.

Finally, the MPJ handshake is now always finalized under the
msk socket lock, we can drop the additional synchronization
between mptcp_finish_join() and mptcp_close().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
side note:
Most bits in msk->flags are always accessed under the mptcp data lock
- specifically: all the bits manipulated by mptcp_release_cb().
Currently we use atomic bit operations for them, because the are a
bunch of other bits which are accessed even outside the mptcp data
lock.

If we move the latter outside msk->flags in a new bitfield, say
msk->atomic_flags, we could remove a lot of atomic operations. I don't
see any measurable cost for them in performance tests, but using atomic
operation where not strictly needed in fast-path is not so nice, and
binary operator would simplify a bit the inner loop of
mptcp_release_cb(). WDYT?
---
 net/mptcp/pm_netlink.c |   3 --
 net/mptcp/protocol.c   | 113 ++++++++++++++++++-----------------------
 net/mptcp/protocol.h   |  15 +-----
 net/mptcp/sockopt.c    |  24 +++------
 net/mptcp/subflow.c    |   5 +-
 5 files changed, 60 insertions(+), 100 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 48963ae4c610..3162e8d25d05 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -165,7 +165,6 @@ select_local_address(const struct pm_nl_pernet *pernet,
 	msk_owned_by_me(msk);
 
 	rcu_read_lock();
-	__mptcp_flush_join_list(msk);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
@@ -544,7 +543,6 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
 	rcu_read_lock();
-	__mptcp_flush_join_list(msk);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
 			continue;
@@ -633,7 +631,6 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 	    !mptcp_pm_should_rm_signal(msk))
 		return;
 
-	__mptcp_flush_join_list(msk);
 	subflow = list_first_entry_or_null(&msk->conn_list, typeof(*subflow), node);
 	if (subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index accd109fd86d..66ecb0aa0bed 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -808,47 +808,31 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	mptcp_data_unlock(sk);
 }
 
-static bool mptcp_do_flush_join_list(struct mptcp_sock *msk)
+static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 {
-	struct mptcp_subflow_context *subflow;
-	bool ret = false;
-
-	if (likely(list_empty(&msk->join_list)))
+	if (((struct sock *)msk)->sk_state != TCP_ESTABLISHED)
 		return false;
 
-	spin_lock_bh(&msk->join_list_lock);
-	list_for_each_entry(subflow, &msk->join_list, node) {
-		u32 sseq = READ_ONCE(subflow->setsockopt_seq);
-
-		mptcp_propagate_sndbuf((struct sock *)msk, mptcp_subflow_tcp_sock(subflow));
-		if (READ_ONCE(msk->setsockopt_seq) != sseq)
-			ret = true;
-	}
-	list_splice_tail_init(&msk->join_list, &msk->conn_list);
-	spin_unlock_bh(&msk->join_list_lock);
-
-	return ret;
-}
-
-void __mptcp_flush_join_list(struct mptcp_sock *msk)
-{
-	if (likely(!mptcp_do_flush_join_list(msk)))
-		return;
-
-	if (!test_and_set_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags))
-		mptcp_schedule_work((struct sock *)msk);
+	mptcp_propagate_sndbuf((struct sock *)msk, ssk);
+	mptcp_sockopt_sync_locked(msk, ssk);
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
+	return true;
 }
 
-static void mptcp_flush_join_list(struct mptcp_sock *msk)
+static void __mptcp_flush_join_list(struct sock *sk, struct list_head *join_list)
 {
-	bool sync_needed = test_and_clear_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags);
-
-	might_sleep();
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 
-	if (!mptcp_do_flush_join_list(msk) && !sync_needed)
-		return;
+	list_for_each_entry(subflow, join_list, node) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow = lock_sock_fast(ssk);
 
-	mptcp_sockopt_sync_all(msk);
+		list_add_tail(&subflow->node, &msk->conn_list);
+		if (!__mptcp_finish_join(msk, ssk))
+			mptcp_subflow_reset(ssk);
+		unlock_sock_fast(ssk, slow);
+	}
 }
 
 static bool mptcp_timer_pending(struct sock *sk)
@@ -1568,7 +1552,6 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			__mptcp_flush_join_list(msk);
 			ssk = mptcp_subflow_get_send(msk);
 
 			/* First check. If the ssk has changed since
@@ -1973,7 +1956,6 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	unsigned int moved = 0;
 	bool ret, done;
 
-	mptcp_flush_join_list(msk);
 	do {
 		struct sock *ssk = mptcp_subflow_recv_lookup(msk);
 		bool slowpath;
@@ -2510,7 +2492,6 @@ static void mptcp_worker(struct work_struct *work)
 		goto unlock;
 
 	mptcp_check_data_fin_ack(sk);
-	mptcp_flush_join_list(msk);
 
 	mptcp_check_fastclose(msk);
 
@@ -2549,8 +2530,6 @@ static int __mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	spin_lock_init(&msk->join_list_lock);
-
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
@@ -2729,7 +2708,6 @@ static void __mptcp_check_send_data_fin(struct sock *sk)
 		}
 	}
 
-	mptcp_flush_join_list(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2762,12 +2740,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 
 	might_sleep();
 
-	/* be sure to always acquire the join list lock, to sync vs
-	 * mptcp_finish_join().
-	 */
-	spin_lock_bh(&msk->join_list_lock);
-	list_splice_tail_init(&msk->join_list, &msk->conn_list);
-	spin_unlock_bh(&msk->join_list_lock);
+	/* join list will be eventually flushed (with rst) at sock lock release time*/
 	list_splice_init(&msk->conn_list, &conn_list);
 
 	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
@@ -2870,8 +2843,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	mptcp_do_flush_join_list(msk);
-
 	inet_sk_state_store(sk, TCP_CLOSE);
 
 	mptcp_for_each_subflow(msk, subflow) {
@@ -3096,12 +3067,18 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 static void mptcp_release_cb(struct sock *sk)
 {
 	for (;;) {
+		struct list_head join_list;
 		unsigned long flags = 0;
 
 		if (test_and_clear_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags))
 			flags |= BIT(MPTCP_PUSH_PENDING);
 		if (test_and_clear_bit(MPTCP_RETRANSMIT, &mptcp_sk(sk)->flags))
 			flags |= BIT(MPTCP_RETRANSMIT);
+		if (test_and_clear_bit(MPTCP_FLUSH_JOIN_LIST, &mptcp_sk(sk)->flags)) {
+			INIT_LIST_HEAD(&join_list);
+			list_splice_init(&mptcp_sk(sk)->join_list, &join_list);
+			flags |= BIT(MPTCP_FLUSH_JOIN_LIST);
+		}
 		if (!flags)
 			break;
 
@@ -3114,6 +3091,8 @@ static void mptcp_release_cb(struct sock *sk)
 		 */
 
 		spin_unlock_bh(&sk->sk_lock.slock);
+		if (flags & BIT(MPTCP_FLUSH_JOIN_LIST))
+			__mptcp_flush_join_list(sk, &join_list);
 		if (flags & BIT(MPTCP_PUSH_PENDING))
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))
@@ -3259,7 +3238,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct sock *parent = (void *)msk;
 	struct socket *parent_sock;
-	bool ret;
+	bool ret = true;
 
 	pr_debug("msk=%p, subflow=%p", msk, subflow);
 
@@ -3272,24 +3251,32 @@ bool mptcp_finish_join(struct sock *ssk)
 	if (!msk->pm.server_side)
 		goto out;
 
-	if (!mptcp_pm_allow_new_subflow(msk)) {
-		subflow->reset_reason = MPTCP_RST_EPROHIBIT;
-		return false;
-	}
+	if (!mptcp_pm_allow_new_subflow(msk))
+		goto prebited;
 
-	/* active connections are already on conn_list, and we can't acquire
-	 * msk lock here.
-	 * use the join list lock as synchronization point and double-check
-	 * msk status to avoid racing with __mptcp_destroy_sock()
+	if (WARN_ON_ONCE(!list_empty(&subflow->node)))
+		goto prebited;
+
+	/* active connections are already on conn_list.
+	 * If we can't acquire msk socket lock here, let the release callback
+	 * handle it
 	 */
-	spin_lock_bh(&msk->join_list_lock);
-	ret = inet_sk_state_load(parent) == TCP_ESTABLISHED;
-	if (ret && !WARN_ON_ONCE(!list_empty(&subflow->node))) {
-		list_add_tail(&subflow->node, &msk->join_list);
+	mptcp_data_lock(parent);
+	if (!sock_owned_by_user(parent)) {
+		ret = __mptcp_finish_join(msk, ssk);
+		if (ret) {
+			sock_hold(ssk);
+			list_add_tail(&subflow->node, &msk->conn_list);
+		}
+	} else {
 		sock_hold(ssk);
+		list_add_tail(&subflow->node, &msk->join_list);
+		set_bit(MPTCP_FLUSH_JOIN_LIST, &msk->flags);
 	}
-	spin_unlock_bh(&msk->join_list_lock);
+	mptcp_data_unlock(parent);
+
 	if (!ret) {
+prebited:
 		subflow->reset_reason = MPTCP_RST_EPROHIBIT;
 		return false;
 	}
@@ -3300,8 +3287,9 @@ bool mptcp_finish_join(struct sock *ssk)
 	parent_sock = READ_ONCE(parent->sk_socket);
 	if (parent_sock && !ssk->sk_socket)
 		mptcp_sock_graft(ssk, parent_sock);
+
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
+
 out:
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 	return true;
@@ -3566,7 +3554,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
 		 */
-		mptcp_flush_join_list(msk);
 		mptcp_for_each_subflow(msk, subflow) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3e7e541a013f..4a140aec68b3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -120,7 +120,7 @@
 #define MPTCP_CLEAN_UNA		7
 #define MPTCP_ERROR_REPORT	8
 #define MPTCP_RETRANSMIT	9
-#define MPTCP_WORK_SYNC_SETSOCKOPT 10
+#define MPTCP_FLUSH_JOIN_LIST	10
 #define MPTCP_CONNECTED		11
 
 static inline bool before64(__u64 seq1, __u64 seq2)
@@ -255,7 +255,6 @@ struct mptcp_sock {
 	u8		recvmsg_inq:1,
 			cork:1,
 			nodelay:1;
-	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
@@ -505,15 +504,6 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow_context *subflow)
 	return subflow->map_seq + mptcp_subflow_get_map_offset(subflow);
 }
 
-static inline void mptcp_add_pending_subflow(struct mptcp_sock *msk,
-					     struct mptcp_subflow_context *subflow)
-{
-	sock_hold(mptcp_subflow_tcp_sock(subflow));
-	spin_lock_bh(&msk->join_list_lock);
-	list_add_tail(&subflow->node, &msk->join_list);
-	spin_unlock_bh(&msk->join_list_lock);
-}
-
 void mptcp_subflow_process_delegated(struct sock *ssk);
 
 static inline void mptcp_subflow_delegate(struct mptcp_subflow_context *subflow, int action)
@@ -678,7 +668,6 @@ void __mptcp_data_acked(struct sock *sk);
 void __mptcp_error_report(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit);
-void __mptcp_flush_join_list(struct mptcp_sock *msk);
 static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->snd_data_fin_enable) &&
@@ -838,7 +827,7 @@ unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
-void mptcp_sockopt_sync_all(struct mptcp_sock *msk);
+void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
 
 static inline struct mptcp_ext *mptcp_get_ext(const struct sk_buff *skb)
 {
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 3c3db22fd36a..962cfe3c463e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1286,27 +1286,15 @@ void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
 	}
 }
 
-void mptcp_sockopt_sync_all(struct mptcp_sock *msk)
+void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
 {
-	struct mptcp_subflow_context *subflow;
-	struct sock *sk = (struct sock *)msk;
-	u32 seq;
-
-	seq = sockopt_seq_reset(sk);
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		u32 sseq = READ_ONCE(subflow->setsockopt_seq);
+	msk_owned_by_me(msk);
 
-		if (sseq != msk->setsockopt_seq) {
-			__mptcp_sockopt_sync(msk, ssk);
-			WRITE_ONCE(subflow->setsockopt_seq, seq);
-		} else if (sseq != seq) {
-			WRITE_ONCE(subflow->setsockopt_seq, seq);
-		}
+	if (READ_ONCE(subflow->setsockopt_seq) != msk->setsockopt_seq) {
+		sync_socket_options(msk, ssk);
 
-		cond_resched();
+		subflow->setsockopt_seq = msk->setsockopt_seq;
 	}
-
-	msk->setsockopt_seq = seq;
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 76556743e952..536a322a6fd0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1448,7 +1448,8 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	subflow->start_stamp = tcp_jiffies32;
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 
-	mptcp_add_pending_subflow(msk, subflow);
+	sock_hold(ssk);
+	list_add_tail(&subflow->node, &msk->conn_list);
 	err = kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
 	if (err && err != -EINPROGRESS)
 		goto failed_unlink;
@@ -1460,9 +1461,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	return err;
 
 failed_unlink:
-	spin_lock_bh(&msk->join_list_lock);
 	list_del(&subflow->node);
-	spin_unlock_bh(&msk->join_list_lock);
 	mptcp_pm_subflow_check_next(msk, ssk, subflow);
 	sock_put(mptcp_subflow_tcp_sock(subflow));
 
-- 
2.33.1

