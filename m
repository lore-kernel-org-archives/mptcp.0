Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147FB6D13
	for <mptcp@lists.linux.dev>; Thu,  8 Apr 2021 18:50:00 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lUZiz-00015S-8f; Thu, 08 Apr 2021 20:49:53 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp 01/10] mptcp: add skeleton to sync msk socket options to subflows
Date: Thu,  8 Apr 2021 20:49:27 +0200
Message-Id: <20210408184936.6245-2-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408184936.6245-1-fw@strlen.de>
References: <20210408184936.6245-1-fw@strlen.de>
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

Cases 2 and 3 are handled right after the join list is spliced to the conn
list.

Not all sockopt values can be just be copied by value, some require
helper calls.  Those can acquire socket lock (which can sleep).

If the join->conn list splicing is done from preemptible context,
synchronization can be done right away, otherwise its deferred to work
queue.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/protocol.c | 43 +++++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h |  7 +++++++
 net/mptcp/sockopt.c  | 19 +++++++++++++++++++
 net/mptcp/subflow.c  |  1 +
 4 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2d895c3c8746..2233baf03c3a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -721,18 +721,44 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
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
 
+	ret = true;
 	spin_lock_bh(&msk->join_list_lock);
 	list_for_each_entry(subflow, &msk->join_list, node)
 		mptcp_propagate_sndbuf((struct sock *)msk, mptcp_subflow_tcp_sock(subflow));
+
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
+	if (!test_and_set_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags))
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
+	mptcp_sockopt_sync_all(msk);
 }
 
 static bool mptcp_timer_pending(struct sock *sk)
@@ -1445,7 +1471,7 @@ static void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			__mptcp_flush_join_list(msk);
+			mptcp_flush_join_list(msk);
 			ssk = mptcp_subflow_get_send(msk);
 
 			/* try to keep the subflow socket lock across
@@ -1871,7 +1897,7 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	unsigned int moved = 0;
 	bool ret, done;
 
-	__mptcp_flush_join_list(msk);
+	mptcp_flush_join_list(msk);
 	do {
 		struct sock *ssk = mptcp_subflow_recv_lookup(msk);
 		bool slowpath;
@@ -2295,7 +2321,7 @@ static void mptcp_worker(struct work_struct *work)
 		goto unlock;
 
 	mptcp_check_data_fin_ack(sk);
-	__mptcp_flush_join_list(msk);
+	mptcp_flush_join_list(msk);
 
 	mptcp_check_fastclose(msk);
 
@@ -2499,7 +2525,7 @@ static void __mptcp_check_send_data_fin(struct sock *sk)
 		}
 	}
 
-	__mptcp_flush_join_list(msk);
+	mptcp_flush_join_list(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2636,7 +2662,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	__mptcp_flush_join_list(msk);
+	mptcp_do_flush_join_list(msk);
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -3204,7 +3231,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
 		 */
-		__mptcp_flush_join_list(msk);
+		mptcp_flush_join_list(msk);
 		mptcp_for_each_subflow(msk, subflow) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d9a489c73029..55fe05a40216 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -108,6 +108,7 @@
 #define MPTCP_CLEAN_UNA		7
 #define MPTCP_ERROR_REPORT	8
 #define MPTCP_RETRANSMIT	9
+#define MPTCP_WORK_SYNC_SETSOCKOPT 10
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -747,6 +748,12 @@ unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
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
index fb98fab252df..4fdc0ad6acf7 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -350,3 +350,22 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 	return -EOPNOTSUPP;
 }
 
+void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
+{
+	msk_owned_by_me(msk);
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
+
+		cond_resched();
+	}
+}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d79a99c2bfc4..fc7107f8d81b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1315,6 +1315,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 
 	mptcp_add_pending_subflow(msk, subflow);
+	mptcp_sockopt_sync(msk, ssk);
 	err = kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
 	if (err && err != -EINPROGRESS)
 		goto failed_unlink;
-- 
2.26.3

