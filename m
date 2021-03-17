Content-Type: multipart/mixed; boundary="===============3222816092097143968=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 1/9] mptcp: add skeleton to sync msk socket
 options to subflows
Date: Wed, 17 Mar 2021 17:38:20 +0100
Message-ID: <20210317163828.27406-2-fw@strlen.de>
In-Reply-To: 20210317163828.27406-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 8191

--===============3222816092097143968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handle following cases:
1. setsockopt is called with multiple subflows.
   Change might have to be mirrored to all of them.
2. Outgoing subflow is created after one or several setsockopt()
   calls have been made.  Old setsockopt changes should be
   synced to the new socket.
3. Like 2, but for incoming subflow.
   This needs the work queue because socket lock (and in the future
   possibly rtnl mutex) might be needed.

Add sequence numbers to subflow context and mptcp socket so
synchronization functions know which subflow is already updated
and which ones are not.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 31 ++++++++++++++++++++++++++++---
 net/mptcp/protocol.h | 12 ++++++++++++
 net/mptcp/sockopt.c  | 27 +++++++++++++++++++++++++++
 net/mptcp/subflow.c  |  1 +
 4 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9d7e7e13fba8..0b9ef8ddff55 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -730,18 +730,42 @@ void mptcp_data_ready(struct sock *sk, struct sock *s=
sk)
 		sk->sk_data_ready(sk);
 }
 =

-void __mptcp_flush_join_list(struct mptcp_sock *msk)
+static bool mptcp_do_flush_join_list(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
 =

 	if (likely(list_empty(&msk->join_list)))
-		return;
+		return false;
 =

 	spin_lock_bh(&msk->join_list_lock);
 	list_for_each_entry(subflow, &msk->join_list, node)
 		mptcp_propagate_sndbuf((struct sock *)msk, mptcp_subflow_tcp_sock(subflo=
w));
 	list_splice_tail_init(&msk->join_list, &msk->conn_list);
 	spin_unlock_bh(&msk->join_list_lock);
+
+	return true;
+}
+
+static void mptcp_work_flush_join_list(struct mptcp_sock *msk)
+{
+	bool sync_needed =3D test_and_clear_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk-=
>flags);
+
+	if (!mptcp_do_flush_join_list(msk) && !sync_needed)
+		return;
+
+	mptcp_sockopt_sync_all(msk);
+}
+
+void __mptcp_flush_join_list(struct mptcp_sock *msk)
+{
+	if (likely(!mptcp_do_flush_join_list(msk)))
+		return;
+
+	if (msk->setsockopt_seq =3D=3D msk->setsockopt_seq_old)
+		return;
+
+	if (!test_and_set_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags))
+		mptcp_schedule_work((struct sock *)msk);
 }
 =

 static bool mptcp_timer_pending(struct sock *sk)
@@ -2307,7 +2331,7 @@ static void mptcp_worker(struct work_struct *work)
 		goto unlock;
 =

 	mptcp_check_data_fin_ack(sk);
-	__mptcp_flush_join_list(msk);
+	mptcp_work_flush_join_list(msk);
 =

 	mptcp_check_fastclose(msk);
 =

@@ -2569,6 +2593,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	xfrm_sk_free_policy(sk);
 	sk_refcnt_debug_release(sk);
 	mptcp_dispose_initial_subflow(msk);
+
 	sock_put(sk);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a0e301ae56b0..ca938a799f66 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -111,6 +111,7 @@
 #define MPTCP_CLEAN_UNA		7
 #define MPTCP_ERROR_REPORT	8
 #define MPTCP_RETRANSMIT	9
+#define MPTCP_WORK_SYNC_SETSOCKOPT 10
 =

 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -280,6 +281,9 @@ struct mptcp_sock {
 		u64	time;	/* start time of measurement window */
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
+
+	u32 setsockopt_seq;
+	u32 setsockopt_seq_old;
 };
 =

 #define mptcp_lock_sock(___sk, cb) do {					\
@@ -438,6 +442,8 @@ struct mptcp_subflow_context {
 	long	delegated_status;
 	struct	list_head delegated_node;   /* link into delegated_action, protect=
ed by local BH */
 =

+	u32 setsockopt_seq;
+
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
 	const	struct inet_connection_sock_af_ops *icsk_af_ops;
@@ -758,6 +764,12 @@ unsigned int mptcp_pm_get_add_addr_accept_max(struct m=
ptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
 =

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
index fb98fab252df..fa71216e11a3 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -350,3 +350,30 @@ int mptcp_getsockopt(struct sock *sk, int level, int o=
ptname,
 	return -EOPNOTSUPP;
 }
 =

+void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	msk_owned_by_me(msk);
+
+	subflow =3D mptcp_subflow_ctx(ssk);
+	if (subflow->setsockopt_seq =3D=3D msk->setsockopt_seq)
+		return;
+
+	subflow->setsockopt_seq =3D msk->setsockopt_seq;
+}
+
+void mptcp_sockopt_sync_all(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	msk_owned_by_me(msk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		mptcp_sockopt_sync(msk, ssk);
+	}
+
+	msk->setsockopt_seq_old =3D msk->setsockopt_seq;
+}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6af443a18bac..af18f9041673 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1311,6 +1311,7 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
ruct mptcp_addr_info *loc,
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 =

 	mptcp_add_pending_subflow(msk, subflow);
+	mptcp_sockopt_sync(msk, ssk);
 	err =3D kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
 	if (err && err !=3D -EINPROGRESS)
 		goto failed_unlink;
-- =

2.26.2

--===============3222816092097143968==--
