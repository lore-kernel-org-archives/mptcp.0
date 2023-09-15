Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4221CCA7A
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694787557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYNFaj0xdzI1jSrwYKxqsnAu1Ar15D96QWl5llx2UMs=;
	b=i8aTzqXG4c4CH8Dcg0d0wsU3adicD1kNSv983qaNXB4NiUxq3UUEOgREHAdWbvalzclFJH
	svPB5HTr6vd6Dyrbz3IVh0bjtualb+1/W1WwwO+t8oZSu622Ff/q3OWxijSdjCwhDklpEX
	s9I3Oiz3m32Q9k/d7kNeKmclVX9SCVM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-vedEEeCoOGay3VzyAdd4tQ-1; Fri, 15 Sep 2023 10:19:16 -0400
X-MC-Unique: vedEEeCoOGay3VzyAdd4tQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D59B2185A79C
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 14:19:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6302121B2413
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 14:19:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 3/3] mptcp: refactor sndbuf auto-tuning.
Date: Fri, 15 Sep 2023 16:19:08 +0200
Message-ID: <03a5cef7b0980cfb6f35f5880ff38c6d15c39531.1694787366.git.pabeni@redhat.com>
In-Reply-To: <cover.1694787366.git.pabeni@redhat.com>
References: <cover.1694787366.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP protocol account for the data enqueued on all the subflows
to the main socket send buffer, while the send buffer auto-tuning
algorithm set the main socket send buffer size as the max size among
the subflows.

That causes bad performances when at least one subflow is sndbuf
limited, e.g. due to very high latency, as the MPTCP scheduler can't
even fill such buffer.

Change the send-buffer auto-tuning algorithm to compute the main socket
send buffer size as the sum of all the subflows buffer size.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - avoid ingremental updates, always recompute sum(ssk->sndbuf) to avoid
   drift on memory pressure/decrease
---
 net/mptcp/protocol.c | 19 ++++++++++++++--
 net/mptcp/protocol.h | 54 ++++++++++++++++++++++++++++++++++++++++----
 net/mptcp/subflow.c  |  3 +--
 3 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3a905c122306..7198ded76ae9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -891,6 +891,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_subflow_joined(msk, ssk);
 	mptcp_stop_tout_timer(sk);
+	__mptcp_propagate_sndbuf(sk, ssk);
 	return true;
 }
 
@@ -1077,15 +1078,16 @@ static void mptcp_enter_memory_pressure(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool first = true;
 
-	sk_stream_moderate_sndbuf(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		if (first)
 			tcp_enter_memory_pressure(ssk);
 		sk_stream_moderate_sndbuf(ssk);
+
 		first = false;
 	}
+	__mptcp_sync_sndbuf(sk);
 }
 
 /* ensure we get enough memory for the frag hdr, beyond some minimal amount of
@@ -2436,6 +2438,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		WRITE_ONCE(msk->first, NULL);
 
 out:
+	__mptcp_sync_sndbuf(sk);
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
 
@@ -3214,7 +3217,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	 * uses the correct data
 	 */
 	mptcp_copy_inaddrs(nsk, ssk);
-	mptcp_propagate_sndbuf(nsk, ssk);
+	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
 	bh_unlock_sock(nsk);
@@ -3392,6 +3395,8 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
+		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
+			__mptcp_sync_sndbuf(sk);
 	}
 
 	__mptcp_update_rmem(sk);
@@ -3437,6 +3442,15 @@ void mptcp_subflow_process_delegated(struct sock *ssk)
 		mptcp_data_unlock(sk);
 		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_SEND);
 	}
+	if (test_bit(MPTCP_DELEGATE_SNDBUF, &subflow->delegated_status)) {
+		mptcp_data_lock(sk);
+		if (!sock_owned_by_user(sk))
+			__mptcp_sync_sndbuf(sk);
+		else
+			__set_bit(MPTCP_SYNC_SNDBUF, &mptcp_sk(sk)->cb_flags);
+		mptcp_data_unlock(sk);
+		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_SNDBUF);
+	}
 	if (test_bit(MPTCP_DELEGATE_ACK, &subflow->delegated_status)) {
 		schedule_3rdack_retransmission(ssk);
 		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_ACK);
@@ -3523,6 +3537,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	/* active subflow, already present inside the conn_list */
 	if (!list_empty(&subflow->node)) {
 		mptcp_subflow_joined(msk, ssk);
+		mptcp_propagate_sndbuf(parent, ssk);
 		return true;
 	}
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index aebc0cc24dad..693330daae26 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -123,6 +123,7 @@
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_CONNECTED		6
+#define MPTCP_SYNC_SNDBUF	7
 
 struct mptcp_skb_cb {
 	u64 map_seq;
@@ -446,6 +447,7 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 
 #define MPTCP_DELEGATE_SEND		0
 #define MPTCP_DELEGATE_ACK		1
+#define MPTCP_DELEGATE_SNDBUF		2
 
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
@@ -518,6 +520,9 @@ struct mptcp_subflow_context {
 
 	u32	setsockopt_seq;
 	u32	stale_rcv_tstamp;
+	int     cached_sndbuf;	    /* sndbuf size when last synced with the msk sndbuf,
+				     * protected by the msk socket lock
+				     */
 
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
@@ -780,13 +785,52 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
 }
 
-static inline bool mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
+static inline void __mptcp_sync_sndbuf(struct sock *sk)
 {
-	if ((sk->sk_userlocks & SOCK_SNDBUF_LOCK) || ssk->sk_sndbuf <= READ_ONCE(sk->sk_sndbuf))
-		return false;
+	struct mptcp_subflow_context *subflow;
+	int ssk_sndbuf, new_sndbuf;
+
+	if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
+		return;
+
+	new_sndbuf = sock_net(sk)->ipv4.sysctl_tcp_wmem[0];
+	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
+		ssk_sndbuf =  READ_ONCE(mptcp_subflow_tcp_sock(subflow)->sk_sndbuf);
+
+		subflow->cached_sndbuf = ssk_sndbuf;
+		new_sndbuf += ssk_sndbuf;
+	}
+
+	/* the msk max wmem limit is <nr_subflows> * tcp wmem[2] */
+	WRITE_ONCE(sk->sk_sndbuf, new_sndbuf);
+}
+
+/* The called held both the msk socket and the subflow socket locks,
+ * possibly under BH
+ */
+static inline void __mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+
+	if (READ_ONCE(ssk->sk_sndbuf) - subflow->cached_sndbuf)
+		__mptcp_sync_sndbuf(sk);
+}
+
+/* the caller held only the subflow socket lock, either in process or
+ * BH context. Additionally this can be called under the msk data lock,
+ * so we can't acquire such lock here: let the delegate action acquires
+ * the needed locks in suitable order.
+ */
+static inline void mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+
+	if (likely(READ_ONCE(ssk->sk_sndbuf) == subflow->cached_sndbuf))
+		return;
 
-	WRITE_ONCE(sk->sk_sndbuf, ssk->sk_sndbuf);
-	return true;
+	local_bh_disable();
+	mptcp_subflow_delegate(subflow, MPTCP_DELEGATE_SNDBUF);
+	local_bh_enable();
 }
 
 static inline void mptcp_write_space(struct sock *sk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1c7ff7247bc0..5a901f14e1d7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -421,6 +421,7 @@ static bool subflow_use_different_dport(struct mptcp_sock *msk, const struct soc
 
 void __mptcp_set_connected(struct sock *sk)
 {
+	__mptcp_propagate_sndbuf(sk, mptcp_sk(sk)->first);
 	if (sk->sk_state == TCP_SYN_SENT) {
 		inet_sk_state_store(sk, TCP_ESTABLISHED);
 		sk->sk_state_change(sk);
@@ -472,7 +473,6 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		return;
 
 	msk = mptcp_sk(parent);
-	mptcp_propagate_sndbuf(parent, sk);
 	subflow->rel_write_seq = 1;
 	subflow->conn_finished = 1;
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
@@ -1728,7 +1728,6 @@ static void subflow_state_change(struct sock *sk)
 
 	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
-		mptcp_propagate_sndbuf(parent, sk);
 		mptcp_do_fallback(sk);
 		mptcp_rcv_space_init(msk, sk);
 		pr_fallback(msk);
-- 
2.41.0

