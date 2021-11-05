Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA992C9B
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 10:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636109372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOHyT5bBm+4tFr1sh6fVBEDnmjVe8U0Ia7z9cLMvPWE=;
	b=Vx27QKgAQU8FurvV1XVy3ixLKZ7lRxLLf3kkJ3NGej/+l3bpfi9j3TtC6CoJi+5ejGUyK6
	bwGa5PVAfg0cJavPoWIb4aKTC9UbatHV4qxgp+3yLHKwylAo8CuZClm8K5tgJhhJIIWcW1
	Mb46LBlAvI7/SbEQl+vi16Fwo0GfhR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-E5zn8zNVP92872-ax05AGw-1; Fri, 05 Nov 2021 06:49:31 -0400
X-MC-Unique: E5zn8zNVP92872-ax05AGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 468E51835AC2
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 10:49:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.132])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7EDA85D9D3
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 10:49:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [RFC PATCH 2/3] mptcp: full disconnect implementation
Date: Fri,  5 Nov 2021 11:49:11 +0100
Message-Id: <e5097a1a78868517c84a0bcf20f775c10ab18fed.1636107361.git.pabeni@redhat.com>
In-Reply-To: <cover.1636107361.git.pabeni@redhat.com>
References: <cover.1636107361.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 net/mptcp/pm.c       | 10 +++--
 net/mptcp/protocol.c | 95 ++++++++++++++++++++++++++++++++------------
 net/mptcp/protocol.h | 14 +++++++
 net/mptcp/token.c    |  1 +
 4 files changed, 92 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6ab386ff3294..6b2bfe89d445 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -356,7 +356,7 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 	}
 }
 
-void mptcp_pm_data_init(struct mptcp_sock *msk)
+void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
 	msk->pm.add_addr_signaled = 0;
 	msk->pm.add_addr_accepted = 0;
@@ -371,10 +371,14 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
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
index 1ee3530ac2a3..5fe19adb88a5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2226,22 +2226,33 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
  * parent socket.
  */
 static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
-			      struct mptcp_subflow_context *subflow)
+			      struct mptcp_subflow_context *subflow,
+			      bool check_pending)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	bool need_push;
+	bool need_push, dispose_it;
 
-	list_del(&subflow->node);
+	dispose_it = !msk->subflow || ssk != msk->subflow->sk;
+	if (dispose_it)
+		list_del(&subflow->node);
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
+	need_push = check_pending && __mptcp_retransmit_pending_data(sk);
+	if (!dispose_it) {
+		tcp_disconnect(ssk, 0);
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
@@ -2261,14 +2272,12 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
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
@@ -2279,7 +2288,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 {
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
-	__mptcp_close_ssk(sk, ssk, subflow);
+	__mptcp_close_ssk(sk, ssk, subflow, true);
 }
 
 static unsigned int mptcp_sync_mss(struct sock *sk, u32 pmtu)
@@ -2501,9 +2510,20 @@ static int __mptcp_init_sock(struct sock *sk)
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
 
@@ -2524,12 +2544,7 @@ static int mptcp_init_sock(struct sock *sk)
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
@@ -2687,9 +2702,13 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status = 0;
 
+	/* clears msk->subflow, allowing the following loop to close
+	 * even the initial subflow
+	 */
+	mptcp_dispose_initial_subflow(msk);
 	list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		__mptcp_close_ssk(sk, ssk, subflow);
+		__mptcp_close_ssk(sk, ssk, subflow, false);
 	}
 
 	sk->sk_prot->destroy(sk);
@@ -2700,7 +2719,6 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	xfrm_sk_free_policy(sk);
 
 	sk_refcnt_debug_release(sk);
-	mptcp_dispose_initial_subflow(msk);
 	sock_put(sk);
 }
 
@@ -2736,6 +2754,9 @@ static void mptcp_close(struct sock *sk, long timeout)
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
+	if (mptcp_sk(sk)->token)
+		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
+
 	if (sk->sk_state == TCP_CLOSE) {
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
@@ -2746,9 +2767,6 @@ static void mptcp_close(struct sock *sk, long timeout)
 	if (do_cancel_work)
 		mptcp_cancel_work(sk);
 
-	if (mptcp_sk(sk)->token)
-		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
-
 	sock_put(sk);
 }
 
@@ -2782,13 +2800,40 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	mptcp_do_flush_join_list(msk);
 
+	inet_sk_state_store(sk, TCP_CLOSE);
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		lock_sock(ssk);
-		tcp_disconnect(ssk, flags);
-		release_sock(ssk);
+		__mptcp_close_ssk(sk, ssk, subflow, false);
 	}
+
+	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
+	sk_stop_timer(sk, &sk->sk_timer);
+
+	if (mptcp_sk(sk)->token)
+		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
+
+	mptcp_destroy_common(msk);
+	msk->last_snd = 0;
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
+#if IS_ENABLED(CONFIG_KASAN)
+	sock_set_flag(sk, SOCK_RCU_FREE);
+#else
+	sock_reset_flag(sk, SOCK_RCU_FREE);
+#endif
+
 	return 0;
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f6f4054e19ee..188b9e044672 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -392,6 +392,9 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
+
+	char	reset_start[0];
+
 	unsigned long avg_pacing_rate; /* protected by msk socket lock */
 	u64	local_key;
 	u64	remote_key;
@@ -438,6 +441,9 @@ struct mptcp_subflow_context {
 	u8	stale_count;
 
 	long	delegated_status;
+
+	char	reset_end[0];
+
 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
 
 	u32	setsockopt_seq;
@@ -469,6 +475,13 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
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
@@ -708,6 +721,7 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hmac);
 
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
2.26.3

