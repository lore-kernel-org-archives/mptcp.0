Content-Type: multipart/mixed; boundary="===============6940117194692905328=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 11/13] mptcp: allow picking different xmit subflows
Date: Wed, 05 Aug 2020 19:57:10 +0200
Message-ID: <bb3b5399e7403986863abaa8e1e2eaad0083cde0.1596649926.git.pabeni@redhat.com>
In-Reply-To: cover.1596649926.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5490

--===============6940117194692905328==
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
RFC -> v1:
 - simplify mptcp_subflow_active() - Florian
 - use sk_stream_memory_free() to check for free space

Note: still keep the sk_state =3D=3D TCP_CLOSE chk in __mptcp_move_skbs():
the alternative would be clearing data_avail at close time.
That should happen after closing the subflow, but for outgoing
connection, the subflow socket could be already free -
we call sock_release().
---
 net/mptcp/protocol.c | 115 +++++++++++++++++++++++++++++++++++++------
 net/mptcp/protocol.h |   6 ++-
 2 files changed, 104 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 39dbd8d5a34c..932e54d6fc90 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1029,39 +1029,109 @@ static void mptcp_nospace(struct mptcp_sock *msk)
 	}
 }
 =

+static bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
+{
+	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
+	if (subflow->request_join && !subflow->fully_established)
+		return false;
+
+	/* only send if our side has not closed yet */
+	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
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
 					   u32 *sndbuf)
 {
 	struct mptcp_subflow_context *subflow;
-	struct sock *sk =3D (struct sock *)msk;
-	struct sock *backup =3D NULL;
+	struct sock *next_backup =3D NULL;
+	struct list_head *pos, *start;
+	struct sock *next_ssk =3D NULL;
+	bool wrap_around;
+	bool free;
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
+	if (__mptcp_check_fallback(msk)) {
+		*sndbuf =3D msk->first ? msk->first->sk_sndbuf: 0;
+		return msk->first;
+	}
 =

-		if (!sk_stream_memory_free(sk)) {
-			mptcp_nospace(msk);
-			return NULL;
-		}
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
+
+		subflow =3D list_entry(pos, struct mptcp_subflow_context, node);
+		ssk =3D  mptcp_subflow_tcp_sock(subflow);
+		if (!mptcp_subflow_active(subflow))
+			continue;
 =

 		*sndbuf =3D max(tcp_sk(ssk)->snd_wnd, *sndbuf);
-		if (subflow->backup) {
-			if (!backup)
-				backup =3D ssk;
+		if (next_backup || next_ssk)
+			continue;
 =

+		free =3D sk_stream_memory_free(ssk);
+		if (!free)
 			continue;
-		}
 =

-		return ssk;
+		if (!subflow->backup && !next_ssk)
+			next_ssk =3D ssk;
+
+		if (subflow->backup && !next_backup)
+			next_backup =3D ssk;
 	}
+	if (!next_ssk)
+		next_ssk =3D next_backup;
 =

-	return backup;
+	if (msk->last_snd) {
+		*sndbuf =3D max(tcp_sk(msk->last_snd)->snd_wnd, *sndbuf);
+		free =3D sk_stream_memory_free(msk->last_snd);
+	} else {
+		free =3D false;
+	}
+	pr_debug("msk=3D%p ssk=3D%p:%d last=3D%p last free=3D%d burst=3D%d", msk,
+		 next_ssk, next_ssk ? sk_stream_wspace(next_ssk) : 0,
+		 msk->last_snd, free, msk->snd_burst);
+
+	/* use the looked-up subflow if the previusly one has exauted the burst
+	 * or is not writable
+	 */
+	if (next_ssk && (!free || msk->snd_burst <=3D 0)) {
+		msk->last_snd =3D next_ssk;
+		msk->snd_burst =3D min(MPTCP_SEND_BURST_SIZE,
+				     sk_stream_wspace(next_ssk));
+		free =3D true;
+	}
+	return free ? msk->last_snd : NULL;
 }
 =

 static void ssk_check_wmem(struct mptcp_sock *msk)
@@ -1157,6 +1227,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
 			break;
 		}
 =

+		/* burst can be negative, we will try move to the next subflow
+		 * at selection time, if possible.
+		 */
+		msk->snd_burst -=3D ret;
 		copied +=3D ret;
 =

 		tx_ok =3D msg_data_left(msg);
@@ -1372,6 +1446,11 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	unsigned int moved =3D 0;
 	bool done;
 =

+	/* avoid looping forever below on racing close */
+	if (((struct sock *)msk)->sk_state =3D=3D TCP_CLOSE)
+		return false;
+
+	__mptcp_flush_join_list(msk);
 	do {
 		struct sock *ssk =3D mptcp_subflow_recv_lookup(msk);
 =

@@ -1536,9 +1615,15 @@ static struct sock *mptcp_subflow_get_retrans(const =
struct mptcp_sock *msk)
 =

 	sock_owned_by_me((const struct sock *)msk);
 =

+	if (__mptcp_check_fallback(msk))
+		return msk->first;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

+		if (!mptcp_subflow_active(subflow))
+			continue;
+
 		/* still data outstanding at TCP level?  Don't retransmit. */
 		if (!tcp_write_queue_empty(ssk))
 			return NULL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cfa5e1b9521b..493bd2c13bc6 100644
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
@@ -473,12 +475,12 @@ static inline bool before64(__u64 seq1, __u64 seq2)
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

--===============6940117194692905328==--
