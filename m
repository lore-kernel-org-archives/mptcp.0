Content-Type: multipart/mixed; boundary="===============3246872169333330822=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 1/3] mptcp: re-enable sndbuf autotune
Date: Fri, 08 Jan 2021 12:50:01 +0100
Message-ID: <8ddbfd8593fc67aa873d00b622fcf69008fcf0ed.1610106588.git.pabeni@redhat.com>
In-Reply-To: cover.1610106588.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7285

--===============3246872169333330822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After commit 6e628cd3a8f7 ("mptcp: use mptcp release_cb for
delayed tasks"), MPTCP never sets the flag bit SOCK_NOSPACE
on its subflow. As a side effect, autotune never takes place,
as it happens inside tcp_new_space(), which in turn is called
only when the mentioned bit is set.

Let's sendmsg() set the subflows NOSPACE bit when looking for
more memory. Additionally, cleanup the sndbuf propagation from
subflow into the msk, leveraging the subflow write space callback
and dropping a bunch of duplicate code.

This also makes the SNDBUF_LIMITED chrono relevant again
for MPTCP subflows.

Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 70 ++++++++++++++++++++++++--------------------
 net/mptcp/protocol.h | 20 +++++++++++++
 net/mptcp/subflow.c  | 10 ++++++-
 3 files changed, 67 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5977e9e083be..eb6bb6b78d6f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -734,10 +734,14 @@ void mptcp_data_ready(struct sock *sk, struct sock *s=
sk)
 =

 void __mptcp_flush_join_list(struct mptcp_sock *msk)
 {
+	struct mptcp_subflow_context *subflow;
+
 	if (likely(list_empty(&msk->join_list)))
 		return;
 =

 	spin_lock_bh(&msk->join_list_lock);
+	list_for_each_entry(subflow, &msk->join_list, node)
+		mptcp_propagate_sndbuf((struct sock *)msk, mptcp_subflow_tcp_sock(subflo=
w));
 	list_splice_tail_init(&msk->join_list, &msk->conn_list);
 	spin_unlock_bh(&msk->join_list_lock);
 }
@@ -1037,13 +1041,7 @@ static void __mptcp_clean_una(struct sock *sk)
 			__mptcp_update_wmem(sk);
 			sk_mem_reclaim_partial(sk);
 		}
-
-		if (sk_stream_is_writeable(sk)) {
-			/* pairs with memory barrier in mptcp_poll */
-			smp_mb();
-			if (test_and_clear_bit(MPTCP_NOSPACE, &msk->flags))
-				sk_stream_write_space(sk);
-		}
+		mptcp_write_space(sk);
 	}
 =

 	if (snd_una =3D=3D READ_ONCE(msk->snd_nxt)) {
@@ -1351,6 +1349,26 @@ static int mptcp_sendmsg_frag(struct sock *sk, struc=
t sock *ssk,
 	return ret;
 }
 =

+static void mptcp_start_sndbuf_autotune(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		struct socket *sock;
+
+		/* on all active, unorphaned, subflows matching the current
+		 * msk backup status
+		 */
+		if (!mptcp_subflow_active(subflow) ||
+		    subflow->backup !=3D msk->use_backup ||
+		    !(sock =3D READ_ONCE(ssk->sk_socket)))
+			continue;
+
+		set_bit(SOCK_NOSPACE, &sock->flags);
+	}
+}
+
 #define MPTCP_SEND_BURST_SIZE		((1 << 16) - \
 					 sizeof(struct tcphdr) - \
 					 MAX_TCP_OPTION_SPACE - \
@@ -1362,8 +1380,7 @@ struct subflow_send_info {
 	u64 ratio;
 };
 =

-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
-					   u32 *sndbuf)
+static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[2];
 	struct mptcp_subflow_context *subflow;
@@ -1374,24 +1391,17 @@ static struct sock *mptcp_subflow_get_send(struct m=
ptcp_sock *msk,
 =

 	sock_owned_by_me((struct sock *)msk);
 =

-	*sndbuf =3D 0;
 	if (__mptcp_check_fallback(msk)) {
 		if (!msk->first)
 			return NULL;
-		*sndbuf =3D msk->first->sk_sndbuf;
 		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
 	}
 =

 	/* re-use last subflow, if the burst allow that */
 	if (msk->last_snd && msk->snd_burst > 0 &&
 	    sk_stream_memory_free(msk->last_snd) &&
-	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
-		mptcp_for_each_subflow(msk, subflow) {
-			ssk =3D  mptcp_subflow_tcp_sock(subflow);
-			*sndbuf =3D max(tcp_sk(ssk)->snd_wnd, *sndbuf);
-		}
+	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd)))
 		return msk->last_snd;
-	}
 =

 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i =3D 0; i < 2; ++i) {
@@ -1404,7 +1414,6 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk,
 			continue;
 =

 		nr_active +=3D !subflow->backup;
-		*sndbuf =3D max(tcp_sk(ssk)->snd_wnd, *sndbuf);
 		if (!sk_stream_memory_free(subflow->tcp_sock))
 			continue;
 =

@@ -1425,7 +1434,8 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk,
 		 send_info[1].ssk, send_info[1].ratio);
 =

 	/* pick the best backup if no other subflow is active */
-	if (!nr_active)
+	msk->use_backup =3D !nr_active;
+	if (msk->use_backup)
 		send_info[0].ssk =3D send_info[1].ssk;
 =

 	if (send_info[0].ssk) {
@@ -1434,6 +1444,7 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk,
 				       sk_stream_wspace(msk->last_snd));
 		return msk->last_snd;
 	}
+
 	return NULL;
 }
 =

@@ -1454,7 +1465,6 @@ static void mptcp_push_pending(struct sock *sk, unsig=
ned int flags)
 	};
 	struct mptcp_data_frag *dfrag;
 	int len, copied =3D 0;
-	u32 sndbuf;
 =

 	while ((dfrag =3D mptcp_send_head(sk))) {
 		info.sent =3D dfrag->already_sent;
@@ -1465,12 +1475,7 @@ static void mptcp_push_pending(struct sock *sk, unsi=
gned int flags)
 =

 			prev_ssk =3D ssk;
 			__mptcp_flush_join_list(msk);
-			ssk =3D mptcp_subflow_get_send(msk, &sndbuf);
-
-			/* do auto tuning */
-			if (!(sk->sk_userlocks & SOCK_SNDBUF_LOCK) &&
-			    sndbuf > READ_ONCE(sk->sk_sndbuf))
-				WRITE_ONCE(sk->sk_sndbuf, sndbuf);
+			ssk =3D mptcp_subflow_get_send(msk);
 =

 			/* try to keep the subflow socket lock across
 			 * consecutive xmit on the same socket
@@ -1537,11 +1542,6 @@ static void __mptcp_subflow_push_pending(struct sock=
 *sk, struct sock *ssk)
 		while (len > 0) {
 			int ret =3D 0;
 =

-			/* do auto tuning */
-			if (!(sk->sk_userlocks & SOCK_SNDBUF_LOCK) &&
-			    ssk->sk_sndbuf > READ_ONCE(sk->sk_sndbuf))
-				WRITE_ONCE(sk->sk_sndbuf, ssk->sk_sndbuf);
-
 			if (unlikely(mptcp_must_reclaim_memory(sk, ssk))) {
 				__mptcp_update_wmem(sk);
 				sk_mem_reclaim_partial(sk);
@@ -1680,6 +1680,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		continue;
 =

 wait_for_memory:
+		mptcp_start_sndbuf_autotune(msk);
 		set_bit(MPTCP_NOSPACE, &msk->flags);
 		mptcp_push_pending(sk, msg->msg_flags);
 		ret =3D sk_stream_wait_memory(sk, &timeo);
@@ -1687,8 +1688,11 @@ static int mptcp_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
 			goto out;
 	}
 =

-	if (copied)
+	if (copied) {
+		if (!sk_stream_is_writeable(sk))
+			mptcp_start_sndbuf_autotune(msk);
 		mptcp_push_pending(sk, msg->msg_flags);
+	}
 =

 out:
 	release_sock(sk);
@@ -2359,6 +2363,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->tx_pending_data =3D 0;
 	msk->size_goal_cache =3D TCP_BASE_MSS;
 =

+	msk->use_backup =3D false;
 	msk->ack_hint =3D NULL;
 	msk->first =3D NULL;
 	inet_csk(sk)->icsk_sync_mss =3D mptcp_sync_mss;
@@ -3285,6 +3290,7 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 =

 		mptcp_copy_inaddrs(newsk, msk->first);
 		mptcp_rcv_space_init(msk, msk->first);
+		mptcp_propagate_sndbuf(newsk, msk->first);
 =

 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d6400ad2d615..676f57ebd0f8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -248,6 +248,7 @@ struct mptcp_sock {
 	bool		snd_data_fin_enable;
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
+	bool		use_backup;	/* only backup subflow available */
 	spinlock_t	join_list_lock;
 	struct sock	*ack_hint;
 	struct work_struct work;
@@ -521,6 +522,25 @@ static inline bool mptcp_data_fin_enabled(const struct=
 mptcp_sock *msk)
 	       READ_ONCE(msk->write_seq) =3D=3D READ_ONCE(msk->snd_nxt);
 }
 =

+static inline bool mptcp_propagate_sndbuf(struct sock *sk, struct sock *ss=
k)
+{
+	if ((sk->sk_userlocks & SOCK_SNDBUF_LOCK) || ssk->sk_sndbuf <=3D READ_ONC=
E(sk->sk_sndbuf))
+		return false;
+
+	WRITE_ONCE(sk->sk_sndbuf, ssk->sk_sndbuf);
+	return true;
+}
+
+static inline void mptcp_write_space(struct sock *sk)
+{
+	if (sk_stream_is_writeable(sk)) {
+		/* pairs with memory barrier in mptcp_poll */
+		smp_mb();
+		if (test_and_clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
+			sk_stream_write_space(sk);
+	}
+}
+
 void mptcp_destroy_common(struct mptcp_sock *msk);
 =

 void __init mptcp_token_init(void);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 278cbe3e539e..1352f9a7ede8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -343,6 +343,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 	if (subflow->conn_finished)
 		return;
 =

+	mptcp_propagate_sndbuf(parent, sk);
 	subflow->rel_write_seq =3D 1;
 	subflow->conn_finished =3D 1;
 	subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
@@ -1040,7 +1041,13 @@ static void subflow_data_ready(struct sock *sk)
 =

 static void subflow_write_space(struct sock *ssk)
 {
-	/* we take action in __mptcp_clean_una() */
+	struct socket *sock =3D ssk->sk_socket;
+
+	if (mptcp_propagate_sndbuf(mptcp_subflow_ctx(ssk)->conn, ssk))
+		mptcp_write_space(ssk);
+
+	if (sk_stream_is_writeable(ssk) && sock)
+		clear_bit(SOCK_NOSPACE, &sock->flags);
 }
 =

 static struct inet_connection_sock_af_ops *
@@ -1299,6 +1306,7 @@ static void subflow_state_change(struct sock *sk)
 	__subflow_state_change(sk);
 =

 	if (subflow_simultaneous_connect(sk)) {
+		mptcp_propagate_sndbuf(parent, sk);
 		mptcp_do_fallback(sk);
 		mptcp_rcv_space_init(mptcp_sk(parent), sk);
 		pr_fallback(mptcp_sk(parent));
-- =

2.26.2

--===============3246872169333330822==--
