Content-Type: multipart/mixed; boundary="===============1491200913014168470=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 03/12] mptcp: trigger msk processing even for OoO
 data
Date: Fri, 31 Jul 2020 19:39:18 +0200
Message-ID: <b62dcbaec7017382d6218e4b8070bc11b4c7c206.1596216310.git.pabeni@redhat.com>
In-Reply-To: cover.1596216310.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5412

--===============1491200913014168470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a pre requiste to allow receiving data from multiple
subflows without re-injection.

Instead of dropping the OoO - "future" data in
subflow_check_data_avail(), call into __mptcp_move_skbs()
and let the msk drop that.

To avoid code duplication factor out the mptcp_subflow_discard_data()
helper.

Note that __mptcp_move_skbs() can now find multiple subflows
with data avail (comprising to-be-discarded data), so must
update the byte counter incrementally.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 33 +++++++++++++++----
 net/mptcp/protocol.h |  6 +++-
 net/mptcp/subflow.c  | 78 ++++++++++++++++++++++++--------------------
 3 files changed, 75 insertions(+), 42 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d51b1d95dfb8..f8e14d43ac55 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -169,7 +169,8 @@ static bool mptcp_subflow_dsn_valid(const struct mptcp_=
sock *msk,
 		return true;
 =

 	subflow->data_avail =3D 0;
-	return mptcp_subflow_data_available(ssk);
+	mptcp_subflow_data_available(ssk);
+	return subflow->data_avail =3D=3D MPTCP_SUBFLOW_DATA_AVAIL;
 }
 =

 static void mptcp_check_data_fin_ack(struct sock *sk)
@@ -316,11 +317,18 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
 	struct tcp_sock *tp;
 	bool done =3D false;
 =

-	if (!mptcp_subflow_dsn_valid(msk, ssk)) {
-		*bytes =3D 0;
+	pr_debug("msk=3D%p ssk=3D%p data avail=3D%d valid=3D%d empty=3D%d",
+		 msk, ssk, subflow->data_avail,
+		 mptcp_subflow_dsn_valid(msk, ssk),
+		 !skb_peek(&ssk->sk_receive_queue));
+	if (subflow->data_avail =3D=3D MPTCP_SUBFLOW_OOO_DATA) {
+		mptcp_subflow_discard_data(ssk, subflow->map_data_len);
 		return false;
 	}
 =

+	if (!mptcp_subflow_dsn_valid(msk, ssk))
+		return false;
+
 	tp =3D tcp_sk(ssk);
 	do {
 		u32 map_remaining, offset;
@@ -379,7 +387,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 		}
 	} while (more_data_avail);
 =

-	*bytes =3D moved;
+	*bytes +=3D moved;
 =

 	/* If the moves have caught up with the DATA_FIN sequence number
 	 * it's time to ack the DATA_FIN and change socket state, but
@@ -418,9 +426,17 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, s=
truct sock *ssk)
 =

 void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	bool wake;
 =

-	set_bit(MPTCP_DATA_READY, &msk->flags);
+	/* move_skbs_to_msk below can legitly clear the data_avail flag,
+	 * but we will need later to properly woke the reader, cache its
+	 * value
+	 */
+	wake =3D subflow->data_avail =3D=3D MPTCP_SUBFLOW_DATA_AVAIL;
+	if (wake)
+		set_bit(MPTCP_DATA_READY, &msk->flags);
 =

 	if (atomic_read(&sk->sk_rmem_alloc) < READ_ONCE(sk->sk_rcvbuf) &&
 	    move_skbs_to_msk(msk, ssk))
@@ -441,7 +457,8 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		move_skbs_to_msk(msk, ssk);
 	}
 wake:
-	sk->sk_data_ready(sk);
+	if (wake)
+		sk->sk_data_ready(sk);
 }
 =

 static void __mptcp_flush_join_list(struct mptcp_sock *msk)
@@ -1264,6 +1281,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 		set_bit(MPTCP_DATA_READY, &msk->flags);
 	}
 out_err:
+	pr_debug("msk=3D%p data_ready=3D%d rx queue empty=3D%d copied=3D%d",
+		 msk, test_bit(MPTCP_DATA_READY, &msk->flags),
+		 skb_queue_empty(&sk->sk_receive_queue), copied);
 	mptcp_rcv_space_adjust(msk, copied);
 =

 	release_sock(sk);
@@ -2295,6 +2315,7 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 	sock_poll_wait(file, sock, wait);
 =

 	state =3D inet_sk_state_load(sk);
+	pr_debug("msk=3D%p state=3D%d flags=3D%lx", msk, state, msk->flags);
 	if (state =3D=3D TCP_LISTEN)
 		return mptcp_check_readable(msk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index beb34b8a5363..e964f3670d75 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -268,6 +268,9 @@ mptcp_subflow_rsk(const struct request_sock *rsk)
 	return (struct mptcp_subflow_request_sock *)rsk;
 }
 =

+#define MPTCP_SUBFLOW_DATA_AVAIL	1
+#define MPTCP_SUBFLOW_OOO_DATA		2
+
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
@@ -292,7 +295,7 @@ struct mptcp_subflow_context {
 		map_valid : 1,
 		mpc_map : 1,
 		backup : 1,
-		data_avail : 1,
+		data_avail : 2,
 		rx_eof : 1,
 		use_64bit_ack : 1, /* Set when we received a 64-bit DSN */
 		can_ack : 1;	    /* only after processing the remote a key */
@@ -347,6 +350,7 @@ int mptcp_is_enabled(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
+int mptcp_subflow_discard_data(struct sock *sk, unsigned limit);
 void __init mptcp_subflow_init(void);
 =

 /* called with sk socket lock held */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 54d89f9379e1..b7394ae1c54d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -746,6 +746,40 @@ static int subflow_read_actor(read_descriptor_t *desc,
 	return copy_len;
 }
 =

+int mptcp_subflow_discard_data(struct sock *ssk, unsigned limit)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	u32 map_remaining;
+	size_t delta;
+
+	map_remaining =3D subflow->map_data_len -
+			mptcp_subflow_get_map_offset(subflow);
+	delta =3D min_t(size_t, limit, map_remaining);
+
+	/* discard mapped data */
+	pr_debug("discarding %zu bytes, current map len=3D%d", delta,
+		 map_remaining);
+	if (delta) {
+		read_descriptor_t desc =3D {
+			.count =3D delta,
+		};
+		int ret;
+
+		ret =3D tcp_read_sock(ssk, &desc, subflow_read_actor);
+		if (ret < 0) {
+			ssk->sk_err =3D -ret;
+			return ret;
+		}
+		if (ret < delta)
+			return 0;
+		if (delta =3D=3D map_remaining) {
+			subflow->data_avail =3D 0;
+			subflow->map_valid =3D 0;
+		}
+	}
+	return 0;
+}
+
 static bool subflow_check_data_avail(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
@@ -762,8 +796,6 @@ static bool subflow_check_data_avail(struct sock *ssk)
 =

 	msk =3D mptcp_sk(subflow->conn);
 	for (;;) {
-		u32 map_remaining;
-		size_t delta;
 		u64 ack_seq;
 		u64 old_ack;
 =

@@ -781,7 +813,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			subflow->map_data_len =3D skb->len;
 			subflow->map_subflow_seq =3D tcp_sk(ssk)->copied_seq -
 						   subflow->ssn_offset;
-			subflow->data_avail =3D 1;
+			subflow->data_avail =3D MPTCP_SUBFLOW_DATA_AVAIL;
 			return true;
 		}
 =

@@ -810,43 +842,19 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		pr_debug("msk ack_seq=3D%llx subflow ack_seq=3D%llx", old_ack,
 			 ack_seq);
 		if (ack_seq =3D=3D old_ack) {
-			subflow->data_avail =3D 1;
+			subflow->data_avail =3D MPTCP_SUBFLOW_DATA_AVAIL;
+			break;
+		} else if (after64(ack_seq, old_ack)) {
+			subflow->data_avail =3D MPTCP_SUBFLOW_OOO_DATA;
 			break;
 		}
 =

 		/* only accept in-sequence mapping. Old values are spurious
-		 * retransmission; we can hit "future" values on active backup
-		 * subflow switch, we relay on retransmissions to get
-		 * in-sequence data.
-		 * Cuncurrent subflows support will require subflow data
-		 * reordering
+		 * retransmission
 		 */
-		map_remaining =3D subflow->map_data_len -
-				mptcp_subflow_get_map_offset(subflow);
-		if (before64(ack_seq, old_ack))
-			delta =3D min_t(size_t, old_ack - ack_seq, map_remaining);
-		else
-			delta =3D min_t(size_t, ack_seq - old_ack, map_remaining);
-
-		/* discard mapped data */
-		pr_debug("discarding %zu bytes, current map len=3D%d", delta,
-			 map_remaining);
-		if (delta) {
-			read_descriptor_t desc =3D {
-				.count =3D delta,
-			};
-			int ret;
-
-			ret =3D tcp_read_sock(ssk, &desc, subflow_read_actor);
-			if (ret < 0) {
-				ssk->sk_err =3D -ret;
-				goto fatal;
-			}
-			if (ret < delta)
-				return false;
-			if (delta =3D=3D map_remaining)
-				subflow->map_valid =3D 0;
-		}
+		if (mptcp_subflow_discard_data(ssk, old_ack - ack_seq))
+			goto fatal;
+		return false;
 	}
 	return true;
 =

-- =

2.26.2

--===============1491200913014168470==--
