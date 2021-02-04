Content-Type: multipart/mixed; boundary="===============4415450725236726283=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH] mptcp: better msk receive window updates
Date: Thu, 04 Feb 2021 23:23:36 +0100
Message-ID: <e81e1dd115ed490477390375b0122dae70e8d107.1612477178.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7623

--===============4415450725236726283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move mptcp_cleanup_rbuf() related checks inside the mentioned
helper and extend them to mirror more closely TCP ones. To implement
them we need to track the subflows mss and the ack_seq delta.
Do not relay anymore on tcp_cleanup_rbuf() and send ack explicitly.

Additionally drop the 'rmem_pending' hack, since commit 879526030c8b
("mptcp: protect the rx path with the msk socket spinlock") we
can use instead 'rmem_released'.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
This apparently fixes issues/147 here, @matttbe: looking for 3rd party
double-check ;)
TODO: verify performance impact in stream tests, as the pure ack rate
can potentially increase a lot.
---
 net/mptcp/options.c  |  8 ++--
 net/mptcp/protocol.c | 89 +++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |  5 ++-
 3 files changed, 59 insertions(+), 43 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bb874c5d663a9..17960e8c7615e 100644
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
@@ -541,17 +541,19 @@ static bool mptcp_established_options_dss(struct sock=
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
 	WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
+	WRITE_ONCE(msk->old_ack_seq, ack_seq);
 =

 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
 	if (dss_size =3D=3D 0)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 88a6fb6f7ecc8..f534c783ed00f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -427,51 +427,61 @@ static bool tcp_can_send_ack(const struct sock *ssk)
 	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCP=
F_LISTEN));
 }
 =

-static void mptcp_send_ack(struct mptcp_sock *msk)
-{
-	struct mptcp_subflow_context *subflow;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-
-		lock_sock(ssk);
-		if (tcp_can_send_ack(ssk))
-			tcp_send_ack(ssk);
-		release_sock(ssk);
-	}
-}
-
-static bool mptcp_subflow_cleanup_rbuf(struct sock *ssk)
+static bool mptcp_subflow_send_ack(struct mptcp_subflow_context *subflow)
 {
+	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 	int ret;
 =

 	lock_sock(ssk);
 	ret =3D tcp_can_send_ack(ssk);
 	if (ret)
-		tcp_cleanup_rbuf(ssk, 1);
+		tcp_send_ack(ssk);
 	release_sock(ssk);
 	return ret;
 }
 =

-static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
+static void mptcp_send_ack(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow)
+		if (mptcp_subflow_send_ack(subflow))
+			return;
+}
+
+static void mptcp_cleanup_rbuf(struct mptcp_sock *msk, int copied)
 {
 	struct sock *ack_hint =3D READ_ONCE(msk->ack_hint);
+	u64 old_ack_seq =3D READ_ONCE(msk->old_ack_seq);
+	int old_space =3D READ_ONCE(msk->old_wspace);
 	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+	bool cleanup;
+
+	/* this is a simple superset of what tcp_cleanup_rbuf() implements
+	 * so that we don't have to acquire the ssk socket lock most of the time
+	 * to do actually nothing
+	 */
+	cleanup =3D (__mptcp_space(sk) - old_space >=3D max(0, old_space)) ||
+		  (copied &&
+		   ((msk->ack_seq - old_ack_seq > msk->rcv_mss) ||
+		    (!(atomic_read(&sk->sk_rmem_alloc) - msk->rmem_released) &&
+		     !msk->tx_pending_data)));
+	if (!cleanup)
+		return;
 =

 	/* if the hinted ssk is still active, try to use it */
 	if (likely(ack_hint)) {
 		mptcp_for_each_subflow(msk, subflow) {
 			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

-			if (ack_hint =3D=3D ssk && mptcp_subflow_cleanup_rbuf(ssk))
+			if (ack_hint =3D=3D ssk && mptcp_subflow_send_ack(subflow))
 				return;
 		}
 	}
 =

 	/* otherwise pick the first active subflow */
-	mptcp_for_each_subflow(msk, subflow)
-		if (mptcp_subflow_cleanup_rbuf(mptcp_subflow_tcp_sock(subflow)))
-			return;
+	mptcp_send_ack(msk);
 }
 =

 static bool mptcp_check_data_fin(struct sock *sk)
@@ -1757,6 +1767,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock =
*msk, int copied)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk =3D (struct sock *)msk;
+	u16 rcv_mss =3D 0xffff;
 	u32 time, advmss =3D 1;
 	u64 rtt_us, mstamp;
 =

@@ -1777,17 +1788,24 @@ static void mptcp_rcv_space_adjust(struct mptcp_soc=
k *msk, int copied)
 	rtt_us =3D 0;
 	mptcp_for_each_subflow(msk, subflow) {
 		const struct tcp_sock *tp;
+		const struct sock *ssk;
+		u16 sf_rcv_mss;
 		u64 sf_rtt_us;
 		u32 sf_advmss;
 =

-		tp =3D tcp_sk(mptcp_subflow_tcp_sock(subflow));
+		ssk =3D mptcp_subflow_tcp_sock(subflow);
+		tp =3D tcp_sk(ssk);
 =

 		sf_rtt_us =3D READ_ONCE(tp->rcv_rtt_est.rtt_us);
 		sf_advmss =3D READ_ONCE(tp->advmss);
+		sf_rcv_mss =3D READ_ONCE(inet_csk(ssk)->icsk_ack.rcv_mss);
 =

 		rtt_us =3D max(sf_rtt_us, rtt_us);
 		advmss =3D max(sf_advmss, advmss);
+		rcv_mss =3D min(sf_rcv_mss, rcv_mss);
 	}
+	if (rcv_mss !=3D 0xffff)
+		msk->rcv_mss =3D rcv_mss;
 =

 	msk->rcvq_space.rtt_us =3D rtt_us;
 	if (time < (rtt_us >> 3) || rtt_us =3D=3D 0)
@@ -1866,7 +1884,7 @@ static void __mptcp_splice_receive_queue(struct sock =
*sk)
 	skb_queue_splice_tail_init(&sk->sk_receive_queue, &msk->receive_queue);
 }
 =

-static bool __mptcp_move_skbs(struct mptcp_sock *msk, unsigned int rcv)
+static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
 	unsigned int moved =3D 0;
@@ -1888,11 +1906,7 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk=
, unsigned int rcv)
 		mptcp_data_lock(sk);
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

@@ -1905,6 +1919,7 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk,=
 unsigned int rcv)
 		ret |=3D __mptcp_ofo_queue(msk);
 		__mptcp_splice_receive_queue(sk);
 		mptcp_data_unlock(sk);
+		mptcp_cleanup_rbuf(msk, 0);
 	}
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
@@ -1934,7 +1949,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 	target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 =

 	while (copied < len) {
-		int bytes_read, old_space;
+		int bytes_read;
 =

 		bytes_read =3D __mptcp_recvmsg_mskq(msk, msg, len - copied);
 		if (unlikely(bytes_read < 0)) {
@@ -1945,14 +1960,11 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
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
+		mptcp_cleanup_rbuf(msk, bytes_read);
+
+		if (skb_queue_empty(&msk->receive_queue) && __mptcp_move_skbs(msk))
+			continue;
 =

 		/* only the master socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
@@ -1980,7 +1992,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 				/* race breaker: the shutdown could be after the
 				 * previous receive queue check
 				 */
-				if (__mptcp_move_skbs(msk, len - copied))
+				if (__mptcp_move_skbs(msk))
 					continue;
 				break;
 			}
@@ -2013,7 +2025,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 		/* .. race-breaker: ssk might have gotten new data
 		 * after last __mptcp_move_skbs() returned false.
 		 */
-		if (unlikely(__mptcp_move_skbs(msk, 0)))
+		if (unlikely(__mptcp_move_skbs(msk)))
 			set_bit(MPTCP_DATA_READY, &msk->flags);
 	} else if (unlikely(!test_bit(MPTCP_DATA_READY, &msk->flags))) {
 		/* data to read but mptcp_wait_data() cleared DATA_READY */
@@ -2331,6 +2343,7 @@ static int __mptcp_init_sock(struct sock *sk)
 =

 	msk->ack_hint =3D NULL;
 	msk->first =3D NULL;
+	msk->rcv_mss =3D TCP_MIN_MSS;
 	inet_csk(sk)->icsk_sync_mss =3D mptcp_sync_mss;
 =

 	mptcp_pm_data_init(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 71ca3f039112c..c2bc401698d16 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -234,13 +234,14 @@ struct mptcp_sock {
 	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
+	u64		old_ack_seq;
 	u64		snd_una;
 	u64		wnd_end;
 	unsigned long	timer_ival;
 	u32		token;
-	int		rmem_pending;
 	int		rmem_released;
 	unsigned long	flags;
+	u16		rcv_mss;
 	bool		can_ack;
 	bool		fully_established;
 	bool		rcv_data_fin;
@@ -302,7 +303,7 @@ static inline struct mptcp_sock *mptcp_sk(const struct =
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

--===============4415450725236726283==--
