Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689316F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 13:23:58 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lP3Me-0003kj-4H; Wed, 24 Mar 2021 14:16:00 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: <mptcp@lists.01.org>,
	Florian Westphal <fw@strlen.de>
Subject: [RFC PATCH mptcp-next v2 1/8] mptcp: add skeleton to sync msk socket options to subflows
Date: Wed, 24 Mar 2021 14:15:39 +0100
Message-Id: <20210324131546.13730-2-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210324131546.13730-1-fw@strlen.de>
References: <20210324131546.13730-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle following cases:
1. setsockopt is called with multiple subflows.
   Change might have to be mirrored to all of them.
   This is done directly in process context/setsockopt call.
2. Outgoing subflow is created after one or several setsockopt()
   calls have been made.  Old setsockopt changes should be
   synced to the new socket.
3. Incoming subflow, after setsockopt call(s).

Cases 2 and 3 are handled right after the join list is spliced to the
conn list.

Because splicing is sometimes done from non-preemptible context, the
sync action can be deferred to the work queue.

Add sequence numbers to subflow context and mptcp socket so
synchronization functions know which subflow is already updated
and which are not.

seqno is re-set to 1 in mptcp_sockopt_sync_all(), at this point
the list of subflows is up to date.

A setsockopt sequence count of 0 means that no setsockopt call
was made so no synchronization is needed.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/protocol.c | 50 ++++++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h | 11 ++++++++++
 net/mptcp/sockopt.c  | 30 ++++++++++++++++++++++++++
 net/mptcp/subflow.c  |  1 +
 4 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9d7e7e13fba8..15beb99f559d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -730,18 +730,49 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		sk->sk_data_ready(sk);
 }
 
-void __mptcp_flush_join_list(struct mptcp_sock *msk)
+static bool mptcp_do_flush_join_list(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
+	bool ret;
 
 	if (likely(list_empty(&msk->join_list)))
-		return;
+		return false;
 
 	spin_lock_bh(&msk->join_list_lock);
-	list_for_each_entry(subflow, &msk->join_list, node)
+	list_for_each_entry(subflow, &msk->join_list, node) {
+		u32 sseq = READ_ONCE(subflow->setsockopt_seq);
+
 		mptcp_propagate_sndbuf((struct sock *)msk, mptcp_subflow_tcp_sock(subflow));
+		if (READ_ONCE(msk->setsockopt_seq) != sseq)
+			ret = true;
+	}
 	list_splice_tail_init(&msk->join_list, &msk->conn_list);
 	spin_unlock_bh(&msk->join_list_lock);
+
+	return ret;
+}
+
+void __mptcp_flush_join_list(struct mptcp_sock *msk)
+{
+	if (likely(!mptcp_do_flush_join_list(msk)))
+		return;
+
+	if (msk->setsockopt_seq &&
+	    !test_and_set_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags))
+		mptcp_schedule_work((struct sock *)msk);
+}
+
+static void mptcp_flush_join_list(struct mptcp_sock *msk)
+{
+	bool sync_needed = test_and_clear_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags);
+
+	might_sleep();
+
+	if (!mptcp_do_flush_join_list(msk) && !sync_needed)
+		return;
+
+	if (msk->setsockopt_seq)
+		mptcp_sockopt_sync_all(msk);
 }
 
 static bool mptcp_timer_pending(struct sock *sk)
@@ -1457,7 +1488,7 @@ static void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			__mptcp_flush_join_list(msk);
+			mptcp_flush_join_list(msk);
 			ssk = mptcp_subflow_get_send(msk);
 
 			/* try to keep the subflow socket lock across
@@ -1883,7 +1914,7 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	unsigned int moved = 0;
 	bool ret, done;
 
-	__mptcp_flush_join_list(msk);
+	mptcp_flush_join_list(msk);
 	do {
 		struct sock *ssk = mptcp_subflow_recv_lookup(msk);
 		bool slowpath;
@@ -2307,7 +2338,7 @@ static void mptcp_worker(struct work_struct *work)
 		goto unlock;
 
 	mptcp_check_data_fin_ack(sk);
-	__mptcp_flush_join_list(msk);
+	mptcp_flush_join_list(msk);
 
 	mptcp_check_fastclose(msk);
 
@@ -2511,7 +2542,7 @@ static void __mptcp_check_send_data_fin(struct sock *sk)
 		}
 	}
 
-	__mptcp_flush_join_list(msk);
+	mptcp_flush_join_list(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2648,7 +2679,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	__mptcp_flush_join_list(msk);
+	mptcp_do_flush_join_list(msk);
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -3216,7 +3248,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
 		 */
-		__mptcp_flush_join_list(msk);
+		mptcp_flush_join_list(msk);
 		mptcp_for_each_subflow(msk, subflow) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 14f0114be17a..df269c26f145 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -108,6 +108,7 @@
 #define MPTCP_CLEAN_UNA		7
 #define MPTCP_ERROR_REPORT	8
 #define MPTCP_RETRANSMIT	9
+#define MPTCP_WORK_SYNC_SETSOCKOPT 10
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -255,6 +256,8 @@ struct mptcp_sock {
 		u64	time;	/* start time of measurement window */
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
+
+	u32 setsockopt_seq;
 };
 
 #define mptcp_lock_sock(___sk, cb) do {					\
@@ -413,6 +416,8 @@ struct mptcp_subflow_context {
 	long	delegated_status;
 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
 
+	u32 setsockopt_seq;
+
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
 	const	struct inet_connection_sock_af_ops *icsk_af_ops;
@@ -735,6 +740,12 @@ unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
 
+int mptcp_setsockopt(struct sock *sk, int level, int optname,
+		     sockptr_t optval, unsigned int optlen);
+
+void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
+void mptcp_sockopt_sync_all(struct mptcp_sock *msk);
+
 static inline struct mptcp_ext *mptcp_get_ext(const struct sk_buff *skb)
 {
 	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fb98fab252df..7f0cb012e3a2 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -350,3 +350,33 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 	return -EOPNOTSUPP;
 }
 
+void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	msk_owned_by_me(msk);
+
+	subflow = mptcp_subflow_ctx(ssk);
+	if (subflow->setsockopt_seq == msk->setsockopt_seq)
+		return;
+
+	subflow->setsockopt_seq = msk->setsockopt_seq;
+}
+
+void mptcp_sockopt_sync_all(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	msk_owned_by_me(msk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		mptcp_sockopt_sync(msk, ssk);
+		subflow->setsockopt_seq = 1;
+
+		cond_resched();
+	}
+
+	msk->setsockopt_seq = 1;
+}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5fc3cada11dd..1dea59f3ff70 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1312,6 +1312,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 
 	mptcp_add_pending_subflow(msk, subflow);
+	mptcp_sockopt_sync(msk, ssk);
 	err = kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
 	if (err && err != -EINPROGRESS)
 		goto failed_unlink;
-- 
2.26.3

