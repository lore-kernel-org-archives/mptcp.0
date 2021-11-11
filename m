Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31C92C81
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636647716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0oMTytNnpjGVPn6sIMjvirU1X39jV9Pq17avPHWWMk=;
	b=ITYlwl0siyDQ+Sa6IZOu7DcsZpfza55sMdxubt8IGqCAInGzmj1quHH5aYQVmEOMERveX0
	EErJWWy2L1XAgU2yxutnNTLjNaQU6F1tD+NkTD3AdyiL13qa7F1Y0o76E1XqgvaKnIRY4W
	ZwbZOdWq2DYt2azNwdEWnWVq0YSEa3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-nhoIj3CvPP63GhjvBzpRfw-1; Thu, 11 Nov 2021 11:21:54 -0500
X-MC-Unique: nhoIj3CvPP63GhjvBzpRfw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FF6719057A2
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:54 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE5A55D6B1
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 4/7] mptcp: full disconnect implementation
Date: Thu, 11 Nov 2021 17:21:39 +0100
Message-Id: <32bb6535c35ac10c222e3d8693bb86040d4909dc.1636647623.git.pabeni@redhat.com>
In-Reply-To: <cover.1636647623.git.pabeni@redhat.com>
References: <cover.1636647623.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The current mptcp_disconnect() implementation lacks several
steps, we additionally need to reset the msk socket state
and flush the subflow list.

Factor out the needed helper to avoid code duplication.

Additionally ensure that the initial subflow is disposed
only after mptcp_close(), just reset it at disconnect time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - fix compile warning (CI)
 - reset first subflow socket state on disconnect
 - use fast-close on disconnect
---
 net/mptcp/pm.c       |  10 +++--
 net/mptcp/protocol.c | 101 ++++++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.h |  14 ++++++
 net/mptcp/token.c    |   1 +
 4 files changed, 98 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 86b38a830b4c..761995a34124 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -362,7 +362,7 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 	}
 }
 
-void mptcp_pm_data_init(struct mptcp_sock *msk)
+void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
 	msk->pm.add_addr_signaled = 0;
 	msk->pm.add_addr_accepted = 0;
@@ -377,10 +377,14 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	WRITE_ONCE(msk->pm.remote_deny_join_id0, false);
 	msk->pm.status = 0;
 
+	mptcp_pm_nl_data_init(msk);
+}
+
+void mptcp_pm_data_init(struct mptcp_sock *msk)
+{
 	spin_lock_init(&msk->pm.lock);
 	INIT_LIST_HEAD(&msk->pm.anno_list);
-
-	mptcp_pm_nl_data_init(msk);
+	mptcp_pm_data_reset(msk);
 }
 
 void __init mptcp_pm_init(void)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3fef1b4e7780..84a3df43a38d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2271,6 +2271,10 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	return true;
 }
 
+/* flags for __mptcp_close_ssk() */
+#define MPTCP_CF_PUSH		BIT(1)
+#define MPTCP_CF_FASTCLOSE	BIT(2)
+
 /* subflow sockets can be either outgoing (connect) or incoming
  * (accept).
  *
@@ -2280,22 +2284,37 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
  * parent socket.
  */
 static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
-			      struct mptcp_subflow_context *subflow)
+			      struct mptcp_subflow_context *subflow,
+			      unsigned int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	bool need_push;
+	bool need_push, dispose_it;
 
-	list_del(&subflow->node);
+	dispose_it = !msk->subflow || ssk != msk->subflow->sk;
+	if (dispose_it)
+		list_del(&subflow->node);
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
+	if (flags & MPTCP_CF_FASTCLOSE)
+		subflow->send_fastclose = 1;
+
+	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
+	if (!dispose_it) {
+		tcp_disconnect(ssk, 0);
+		msk->subflow->state = SS_UNCONNECTED;
+		mptcp_subflow_ctx_reset(subflow);
+		release_sock(ssk);
+
+		goto out;
+	}
+
 	/* if we are invoked by the msk cleanup code, the subflow is
 	 * already orphaned
 	 */
 	if (ssk->sk_socket)
 		sock_orphan(ssk);
 
-	need_push = __mptcp_retransmit_pending_data(sk);
 	subflow->disposable = 1;
 
 	/* if ssk hit tcp_done(), tcp_cleanup_ulp() cleared the related ops
@@ -2315,14 +2334,12 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	sock_put(ssk);
 
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
-
 	if (ssk == msk->first)
 		msk->first = NULL;
 
-	if (msk->subflow && ssk == msk->subflow->sk)
-		mptcp_dispose_initial_subflow(msk);
+out:
+	if (ssk == msk->last_snd)
+		msk->last_snd = NULL;
 
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
@@ -2333,7 +2350,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 {
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
-	__mptcp_close_ssk(sk, ssk, subflow);
+	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
 }
 
 static unsigned int mptcp_sync_mss(struct sock *sk, u32 pmtu)
@@ -2557,9 +2574,20 @@ static int __mptcp_init_sock(struct sock *sk)
 	return 0;
 }
 
-static int mptcp_init_sock(struct sock *sk)
+static void mptcp_ca_reset(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	tcp_assign_congestion_control(sk);
+	strcpy(mptcp_sk(sk)->ca_name, icsk->icsk_ca_ops->name);
+
+	/* no need to keep a reference to the ops, the name will suffice */
+	tcp_cleanup_congestion_control(sk);
+	icsk->icsk_ca_ops = NULL;
+}
+
+static int mptcp_init_sock(struct sock *sk)
+{
 	struct net *net = sock_net(sk);
 	int ret;
 
@@ -2580,12 +2608,7 @@ static int mptcp_init_sock(struct sock *sk)
 	/* fetch the ca name; do it outside __mptcp_init_sock(), so that clone will
 	 * propagate the correct value
 	 */
-	tcp_assign_congestion_control(sk);
-	strcpy(mptcp_sk(sk)->ca_name, icsk->icsk_ca_ops->name);
-
-	/* no need to keep a reference to the ops, the name will suffice */
-	tcp_cleanup_congestion_control(sk);
-	icsk->icsk_ca_ops = NULL;
+	mptcp_ca_reset(sk);
 
 	sk_sockets_allocated_inc(sk);
 	sk->sk_rcvbuf = sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
@@ -2744,9 +2767,13 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status = 0;
 
+	/* clears msk->subflow, allowing the following loop to close
+	 * even the initial subflow
+	 */
+	mptcp_dispose_initial_subflow(msk);
 	list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		__mptcp_close_ssk(sk, ssk, subflow);
+		__mptcp_close_ssk(sk, ssk, subflow, 0);
 	}
 
 	sk->sk_prot->destroy(sk);
@@ -2757,7 +2784,6 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	xfrm_sk_free_policy(sk);
 
 	sk_refcnt_debug_release(sk);
-	mptcp_dispose_initial_subflow(msk);
 	sock_put(sk);
 }
 
@@ -2793,6 +2819,9 @@ static void mptcp_close(struct sock *sk, long timeout)
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
+	if (mptcp_sk(sk)->token)
+		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
+
 	if (sk->sk_state == TCP_CLOSE) {
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
@@ -2803,9 +2832,6 @@ static void mptcp_close(struct sock *sk, long timeout)
 	if (do_cancel_work)
 		mptcp_cancel_work(sk);
 
-	if (mptcp_sk(sk)->token)
-		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
-
 	sock_put(sk);
 }
 
@@ -2839,13 +2865,36 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	mptcp_do_flush_join_list(msk);
 
+	inet_sk_state_store(sk, TCP_CLOSE);
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		lock_sock(ssk);
-		tcp_disconnect(ssk, flags);
-		release_sock(ssk);
+		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_FASTCLOSE);
 	}
+
+	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
+	sk_stop_timer(sk, &sk->sk_timer);
+
+	if (mptcp_sk(sk)->token)
+		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
+
+	mptcp_destroy_common(msk);
+	msk->last_snd = NULL;
+	msk->flags = 0;
+	msk->recovery = false;
+	msk->can_ack = false;
+	msk->fully_established = false;
+	msk->rcv_data_fin = false;
+	msk->snd_data_fin_enable = false;
+	msk->rcv_fastclose = false;
+	msk->use_64bit_ack = false;
+	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
+	mptcp_pm_data_reset(msk);
+	mptcp_ca_reset(sk);
+
+	sk->sk_shutdown = 0;
+	sk_error_report(sk);
 	return 0;
 }
 
@@ -2985,9 +3034,11 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 	__mptcp_clear_xmit(sk);
 
 	/* move to sk_receive_queue, sk_stream_kill_queues will purge it */
+	mptcp_data_lock(sk);
 	skb_queue_splice_tail_init(&msk->receive_queue, &sk->sk_receive_queue);
 	__skb_queue_purge(&sk->sk_receive_queue);
 	skb_rbtree_purge(&msk->out_of_order_queue);
+	mptcp_data_unlock(sk);
 
 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
 	 * inet_sock_destruct() will dispose it
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cee323de1a1c..f8ed68c5ef9d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -394,6 +394,9 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
+
+	char	reset_start[0];
+
 	unsigned long avg_pacing_rate; /* protected by msk socket lock */
 	u64	local_key;
 	u64	remote_key;
@@ -442,6 +445,9 @@ struct mptcp_subflow_context {
 	u8	stale_count;
 
 	long	delegated_status;
+
+	char	reset_end[0];
+
 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
 
 	u32	setsockopt_seq;
@@ -473,6 +479,13 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 	return subflow->tcp_sock;
 }
 
+static inline void
+mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
+{
+	memset(subflow->reset_start, 0, subflow->reset_end - subflow->reset_start);
+	subflow->request_mptcp = 1;
+}
+
 static inline u64
 mptcp_subflow_get_map_offset(const struct mptcp_subflow_context *subflow)
 {
@@ -712,6 +725,7 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hmac);
 
 void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
+void mptcp_pm_data_reset(struct mptcp_sock *msk);
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index e581b341c5be..f52ee7b26aed 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -384,6 +384,7 @@ void mptcp_token_destroy(struct mptcp_sock *msk)
 		bucket->chain_len--;
 	}
 	spin_unlock_bh(&bucket->lock);
+	WRITE_ONCE(msk->token, 0);
 }
 
 void __init mptcp_token_init(void)
-- 
2.33.1

