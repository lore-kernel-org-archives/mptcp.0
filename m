Content-Type: multipart/mixed; boundary="===============6501537627059433987=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net 3/5] mptcp: better msk receive window updates
Date: Fri, 05 Feb 2021 17:55:12 +0100
Message-ID: <ed9a2c374017420a4315c7b23121ed08becf866e.1612543972.git.pabeni@redhat.com>
In-Reply-To: cover.1612543972.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7653

--===============6501537627059433987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move mptcp_cleanup_rbuf() related checks inside the mentioned
helper and extend them to mirror more closely TCP ones.

Additionally drop the 'rmem_pending' hack, since commit 879526030c8b
("mptcp: protect the rx path with the msk socket spinlock") we
can use instead 'rmem_released'.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  |  7 ++++---
 net/mptcp/protocol.c | 38 ++++++++++++++++++++++----------------
 net/mptcp/protocol.h |  3 +--
 3 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bb874c5d663a9..331967d709de5 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -508,8 +508,8 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+	u64 snd_data_fin_enable, ack_seq;
 	unsigned int dss_size =3D 0;
-	u64 snd_data_fin_enable;
 	struct mptcp_ext *mpext;
 	unsigned int ack_size;
 	bool ret =3D false;
@@ -541,13 +541,14 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
 		return ret;
 	}
 =

+	ack_seq =3D READ_ONCE(msk->ack_seq);
 	if (READ_ONCE(msk->use_64bit_ack)) {
 		ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
-		opts->ext_copy.data_ack =3D READ_ONCE(msk->ack_seq);
+		opts->ext_copy.data_ack =3D ack_seq;
 		opts->ext_copy.ack64 =3D 1;
 	} else {
 		ack_size =3D TCPOLEN_MPTCP_DSS_ACK32;
-		opts->ext_copy.data_ack32 =3D (uint32_t)READ_ONCE(msk->ack_seq);
+		opts->ext_copy.data_ack32 =3D (uint32_t)ack_seq;
 		opts->ext_copy.ack64 =3D 0;
 	}
 	opts->ext_copy.use_ack =3D 1;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 60378e6a24540..5e75e89931915 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -456,7 +456,18 @@ static bool mptcp_subflow_cleanup_rbuf(struct sock *ss=
k)
 static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
 {
 	struct sock *ack_hint =3D READ_ONCE(msk->ack_hint);
+	int old_space =3D READ_ONCE(msk->old_wspace);
 	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+	bool cleanup;
+
+	/* this is a simple superset of what tcp_cleanup_rbuf() implements
+	 * so that we don't have to acquire the ssk socket lock most of the time
+	 * to do actually nothing
+	 */
+	cleanup =3D __mptcp_space(sk) - old_space >=3D max(0, old_space);
+	if (!cleanup)
+		return;
 =

 	/* if the hinted ssk is still active, try to use it */
 	if (likely(ack_hint)) {
@@ -1866,7 +1877,7 @@ static void __mptcp_splice_receive_queue(struct sock =
*sk)
 	skb_queue_splice_tail_init(&sk->sk_receive_queue, &msk->receive_queue);
 }
 =

-static bool __mptcp_move_skbs(struct mptcp_sock *msk, unsigned int rcv)
+static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
 	unsigned int moved =3D 0;
@@ -1886,13 +1897,10 @@ static bool __mptcp_move_skbs(struct mptcp_sock *ms=
k, unsigned int rcv)
 =

 		slowpath =3D lock_sock_fast(ssk);
 		mptcp_data_lock(sk);
+		__mptcp_update_rmem(sk);
 		done =3D __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
 		mptcp_data_unlock(sk);
-		if (moved && rcv) {
-			WRITE_ONCE(msk->rmem_pending, min(rcv, moved));
-			tcp_cleanup_rbuf(ssk, 1);
-			WRITE_ONCE(msk->rmem_pending, 0);
-		}
+		tcp_cleanup_rbuf(ssk, moved);
 		unlock_sock_fast(ssk, slowpath);
 	} while (!done);
 =

@@ -1905,6 +1913,7 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk,=
 unsigned int rcv)
 		ret |=3D __mptcp_ofo_queue(msk);
 		__mptcp_splice_receive_queue(sk);
 		mptcp_data_unlock(sk);
+		mptcp_cleanup_rbuf(msk);
 	}
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
@@ -1934,7 +1943,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 	target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 =

 	while (copied < len) {
-		int bytes_read, old_space;
+		int bytes_read;
 =

 		bytes_read =3D __mptcp_recvmsg_mskq(msk, msg, len - copied);
 		if (unlikely(bytes_read < 0)) {
@@ -1945,14 +1954,11 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
 =

 		copied +=3D bytes_read;
 =

-		if (skb_queue_empty(&msk->receive_queue) &&
-		    __mptcp_move_skbs(msk, len - copied))
-			continue;
-
 		/* be sure to advertise window change */
-		old_space =3D READ_ONCE(msk->old_wspace);
-		if ((tcp_space(sk) - old_space) >=3D old_space)
-			mptcp_cleanup_rbuf(msk);
+		mptcp_cleanup_rbuf(msk);
+
+		if (skb_queue_empty(&msk->receive_queue) && __mptcp_move_skbs(msk))
+			continue;
 =

 		/* only the master socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
@@ -1980,7 +1986,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 				/* race breaker: the shutdown could be after the
 				 * previous receive queue check
 				 */
-				if (__mptcp_move_skbs(msk, len - copied))
+				if (__mptcp_move_skbs(msk))
 					continue;
 				break;
 			}
@@ -2013,7 +2019,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 		/* .. race-breaker: ssk might have gotten new data
 		 * after last __mptcp_move_skbs() returned false.
 		 */
-		if (unlikely(__mptcp_move_skbs(msk, 0)))
+		if (unlikely(__mptcp_move_skbs(msk)))
 			set_bit(MPTCP_DATA_READY, &msk->flags);
 	} else if (unlikely(!test_bit(MPTCP_DATA_READY, &msk->flags))) {
 		/* data to read but mptcp_wait_data() cleared DATA_READY */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d04d2a96fd4bf..5282a7d9f1443 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -238,7 +238,6 @@ struct mptcp_sock {
 	u64		wnd_end;
 	unsigned long	timer_ival;
 	u32		token;
-	int		rmem_pending;
 	int		rmem_released;
 	unsigned long	flags;
 	bool		can_ack;
@@ -302,7 +301,7 @@ static inline struct mptcp_sock *mptcp_sk(const struct =
sock *sk)
 =

 static inline int __mptcp_space(const struct sock *sk)
 {
-	return tcp_space(sk) + READ_ONCE(mptcp_sk(sk)->rmem_pending);
+	return tcp_space(sk) + READ_ONCE(mptcp_sk(sk)->rmem_released);
 }
 =

 static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *s=
k)
-- =

2.26.2

--===============6501537627059433987==--
