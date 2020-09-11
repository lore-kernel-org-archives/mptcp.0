Content-Type: multipart/mixed; boundary="===============5096936260600970432=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 11/13] mptcp: allow picking different xmit
 subflows
Date: Fri, 11 Sep 2020 15:52:06 +0200
Message-ID: <3b8e364293d3cbb0348f20ca14301200aa43bc24.1599832097.git.pabeni@redhat.com>
In-Reply-To: cover.1599832097.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5815

--===============5096936260600970432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Update the scheduler to less trivial heuristic: cache
the last used subflow, and try to send on it a reasonably
long burst of data.

When the burst or the subflow send space is exhausted, pick
the subflow with the lower ratio between write space and
send buffer - that is, the subflow with the greater relative
amount of free space.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 109 ++++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |   6 ++-
 2 files changed, 97 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ec9c38d3acc7..148c4e685ecd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1031,41 +1031,103 @@ static void mptcp_nospace(struct mptcp_sock *msk)
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
+#define MPTCP_SEND_BURST_SIZE		((1 << 16) - \
+					 sizeof(struct tcphdr) - \
+					 MAX_TCP_OPTION_SPACE - \
+					 sizeof(struct ipv6hdr) - \
+					 sizeof(struct frag_hdr))
+
+struct subflow_send_info {
+	struct sock *ssk;
+	uint64_t ratio;
+};
+
 static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
 					   u32 *sndbuf)
 {
+	struct subflow_send_info send_info[2];
 	struct mptcp_subflow_context *subflow;
-	struct sock *sk =3D (struct sock *)msk;
-	struct sock *backup =3D NULL;
-	bool free;
+	int i, nr_active =3D 0;
+	int64_t ratio, pace;
+	struct sock *ssk;
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
-
-		free =3D sk_stream_is_writeable(subflow->tcp_sock);
-		if (!free) {
-			mptcp_nospace(msk);
+	if (__mptcp_check_fallback(msk)) {
+		if (!msk->first)
 			return NULL;
+		*sndbuf =3D msk->first->sk_sndbuf;
+		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
+	}
+
+	/* re-use last subflow, if the burst allow that */
+	if (msk->last_snd && msk->snd_burst > 0 &&
+	    sk_stream_memory_free(msk->last_snd) &&
+	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
+		mptcp_for_each_subflow(msk, subflow) {
+			ssk =3D  mptcp_subflow_tcp_sock(subflow);
+			*sndbuf =3D max(tcp_sk(ssk)->snd_wnd, *sndbuf);
 		}
+		return msk->last_snd;
+	}
+
+	/* pick the subflow with the lower wmem/wspace ratio */
+	for (i =3D 0; i < 2; ++i) {
+		send_info[i].ssk =3D NULL;
+		send_info[i].ratio =3D -1;
+	}
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk =3D  mptcp_subflow_tcp_sock(subflow);
+		if (!mptcp_subflow_active(subflow))
+			continue;
 =

+		nr_active +=3D !subflow->backup;
 		*sndbuf =3D max(tcp_sk(ssk)->snd_wnd, *sndbuf);
-		if (subflow->backup) {
-			if (!backup)
-				backup =3D ssk;
+		if (!sk_stream_memory_free(subflow->tcp_sock))
+			continue;
 =

+		pace =3D READ_ONCE(ssk->sk_pacing_rate);
+		if (!pace)
 			continue;
-		}
 =

-		return ssk;
+		ratio =3D (int64_t)READ_ONCE(ssk->sk_wmem_queued) << 32 / pace;
+		if (ratio < send_info[subflow->backup].ratio) {
+			send_info[subflow->backup].ssk =3D ssk;
+			send_info[subflow->backup].ratio =3D ratio;
+		}
 	}
 =

-	return backup;
+	pr_debug("msk=3D%p nr_active=3D%d ssk=3D%p:%lld backup=3D%p:%lld",
+		 msk, nr_active, send_info[0].ssk, send_info[0].ratio,
+		 send_info[1].ssk, send_info[1].ratio);
+
+	/* pick the best backup if no other subflow is active */
+	if (!nr_active)
+		send_info[0].ssk =3D send_info[1].ssk;
+
+	if (send_info[0].ssk) {
+		msk->last_snd =3D send_info[0].ssk;
+		msk->snd_burst =3D min_t(int, MPTCP_SEND_BURST_SIZE,
+				       sk_stream_wspace(msk->last_snd));
+		return msk->last_snd;
+	}
+	return NULL;
 }
 =

 static void ssk_check_wmem(struct mptcp_sock *msk)
@@ -1160,6 +1222,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msg=
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
@@ -1375,6 +1441,11 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
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

@@ -1539,9 +1610,15 @@ static struct sock *mptcp_subflow_get_retrans(const =
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

--===============5096936260600970432==--
