Content-Type: multipart/mixed; boundary="===============8625253896631123523=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 11/12] mptcp: allow picking different xmit subflows
Date: Fri, 31 Jul 2020 19:39:26 +0200
Message-ID: <960519a1162d5a416245fa239e57392ab0efa0be.1596216310.git.pabeni@redhat.com>
In-Reply-To: cover.1596216310.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5417

--===============8625253896631123523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Update the scheduler to less trivial heuristic: cache
the last used subflow, and try to send on it a reasonably
long burst of data. When the burst or the subflow send
space is exausted, move to the next one with available
send space.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 112 +++++++++++++++++++++++++++++++++++++------
 net/mptcp/protocol.h |   6 ++-
 2 files changed, 101 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ef5b68c4ff49..89c0400593d1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1012,39 +1012,112 @@ static void mptcp_nospace(struct sock *sk, struct =
sock *ssk)
 		set_bit(SOCK_NOSPACE, &sock->flags);
 }
 =

+static bool mptcp_subflow_active(struct mptcp_subflow_context *subflow,
+				 bool fallback)
+{
+	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+	/* subflow must be open for write */
+	if ((1 << ssk->sk_state) &
+	    (TCPF_CLOSE | TCPF_LAST_ACK | TCPF_CLOSING | TCPF_FIN_WAIT2 |
+	     TCPF_FIN_WAIT1))
+		return false;
+
+	/* we can xmit on MPC and fallen back subflows in
+	 * TCP_SYN_SENT/TCP_SYN_RECV status, but we need fully established
+	 * MP_JOIN subflows.
+	 */
+	return !subflow->request_join ||
+	       (subflow->fully_established && !fallback);
+}
+
+#define MPTCP_SEND_BURST_SIZE		(1 << 15)
+
+static struct list_head *mptcp_next_subflow(struct mptcp_sock *msk,
+					    struct list_head *pos,
+					    bool wrap_around)
+{
+	if (list_is_last(pos, &msk->conn_list) && wrap_around)
+		return msk->conn_list.next;
+	return pos->next;
+}
+
 static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
 					   int *sndbuf)
 {
+	int next_wspace =3D 0, next_bu_wspace =3D 0, last_snd_wspace =3D 0;
+	bool fallback =3D __mptcp_check_fallback(msk);
 	struct mptcp_subflow_context *subflow;
-	struct sock *sk =3D (struct sock *)msk;
-	struct sock *backup =3D NULL;
+	struct sock *next_backup =3D NULL;
+	struct list_head *pos, *start;
+	struct sock *next_ssk =3D NULL;
+	bool wrap_around;
 =

-	sock_owned_by_me(sk);
+	sock_owned_by_me((struct sock *)msk);
 =

 	*sndbuf =3D 0;
 	if (!mptcp_ext_cache_refill(msk))
 		return NULL;
 =

-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+	/* lookup the first writeable subflow and first writable back subflow
+	 * starting from last used, with wrap-around
+	 */
+	if (msk->last_snd) {
+		start =3D &mptcp_subflow_ctx(msk->last_snd)->node;
+		wrap_around =3D true;
+	} else {
+		start =3D &msk->conn_list;
+		wrap_around =3D false;
+	}
+	pr_debug("msk=3D%p start=3D%p pos=3D%p wrap_around=3D%d last=3D%p", msk, =
start,
+		 mptcp_next_subflow(msk, start, wrap_around), wrap_around,
+		 msk->last_snd);
+	for (pos =3D mptcp_next_subflow(msk, start, wrap_around); pos !=3D start;
+	     pos =3D mptcp_next_subflow(msk, pos, wrap_around)) {
+		struct sock *ssk;
+		int wspace;
 =

-		if (!sk_stream_memory_free(sk)) {
-			mptcp_nospace(sk, ssk);
-			return NULL;
-		}
+		subflow =3D list_entry(pos, struct mptcp_subflow_context, node);
+		ssk =3D  mptcp_subflow_tcp_sock(subflow);
+		if (!mptcp_subflow_active(subflow, fallback))
+			continue;
 =

 		*sndbuf =3D max(ssk->sk_sndbuf, *sndbuf);
-		if (subflow->backup) {
-			if (!backup)
-				backup =3D ssk;
-
+		wspace =3D sk_stream_wspace(ssk);
+		if (wspace <=3D 0)
 			continue;
+
+		if (!subflow->backup && !next_ssk) {
+			next_ssk =3D ssk;
+			next_wspace =3D wspace;
 		}
 =

-		return ssk;
+		if (subflow->backup && !next_backup) {
+			next_backup =3D ssk;
+			next_bu_wspace =3D wspace;
+		}
+	}
+	if (!next_ssk) {
+		next_ssk =3D next_backup;
+		next_wspace =3D next_bu_wspace;
 	}
+	if (msk->last_snd) {
+		*sndbuf =3D max(msk->last_snd->sk_sndbuf, *sndbuf);
+		last_snd_wspace =3D sk_stream_wspace(msk->last_snd);
+	}
+	pr_debug("msk=3D%p ssk=3D%p last=3D%p wspace=3D%d last wspace=3D%d burst=
=3D%d", msk,
+		 next_ssk, msk->last_snd, next_wspace, last_snd_wspace,
+		 msk->snd_burst);
 =

-	return backup;
+	/* use the looked-up subflow if the previusly used has exauted the burst
+	 * or is not writable
+	 */
+	if (next_ssk && (last_snd_wspace <=3D 0 || msk->snd_burst <=3D 0)) {
+		msk->last_snd =3D next_ssk;
+		msk->snd_burst =3D min(MPTCP_SEND_BURST_SIZE, next_wspace);
+		last_snd_wspace =3D next_wspace;
+	}
+	return last_snd_wspace > 0 ? msk->last_snd : NULL;
 }
 =

 static void ssk_check_wmem(struct sock *sk, struct sock *ssk)
@@ -1142,6 +1215,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		}
 =

 		copied +=3D ret;
+		msk->snd_burst -=3D ret;
 =

 		tx_ok =3D msg_data_left(msg);
 		if (!tx_ok)
@@ -1358,6 +1432,10 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	unsigned int moved =3D 0;
 	bool done;
 =

+	if (((struct sock *)msk)->sk_state =3D=3D TCP_CLOSE)
+		return false;
+
+	__mptcp_flush_join_list(msk);
 	do {
 		struct sock *ssk =3D mptcp_subflow_recv_lookup(msk);
 =

@@ -1513,6 +1591,7 @@ static void mptcp_retransmit_timer(struct timer_list =
*t)
  */
 static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 {
+	bool fallback =3D __mptcp_check_fallback(msk);
 	struct mptcp_subflow_context *subflow;
 	struct sock *backup =3D NULL;
 =

@@ -1521,6 +1600,9 @@ static struct sock *mptcp_subflow_get_retrans(const s=
truct mptcp_sock *msk)
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

+		if (!mptcp_subflow_active(subflow, fallback))
+			continue;
+
 		/* still data outstanding at TCP level?  Don't retransmit. */
 		if (!tcp_write_queue_empty(ssk))
 			return NULL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5467eb1adebd..0381e63d866d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -196,6 +196,8 @@ struct mptcp_sock {
 	u64		write_seq;
 	u64		ack_seq;
 	u64		rcv_data_fin_seq;
+	struct sock	*last_snd;
+	int		snd_burst;
 	atomic64_t	snd_una;
 	unsigned long	timer_ival;
 	u32		token;
@@ -469,12 +471,12 @@ static inline bool before64(__u64 seq1, __u64 seq2)
 =

 void mptcp_diag_subflow_init(struct tcp_ulp_ops *ops);
 =

-static inline bool __mptcp_check_fallback(struct mptcp_sock *msk)
+static inline bool __mptcp_check_fallback(const struct mptcp_sock *msk)
 {
 	return test_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 =

-static inline bool mptcp_check_fallback(struct sock *sk)
+static inline bool mptcp_check_fallback(const struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
-- =

2.26.2

--===============8625253896631123523==--
