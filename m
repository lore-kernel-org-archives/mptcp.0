Content-Type: multipart/mixed; boundary="===============1790163554556373643=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 3/3] mptcp: recvmsg() can drain data from multiple
 subflows
Date: Sun, 13 Oct 2019 18:28:46 +0200
Message-ID: <861c7c76c198b5d1f9bb2e587b072c1e030e961d.1570834035.git.pabeni@redhat.com>
In-Reply-To: cover.1570834035.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2103

--===============1790163554556373643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With the previous patch in place, the msk can detect which subflow
has the current map with a simple walk, let's update the main
loop to always select the 'current' subflow.

Additionally:
- changes the exit conditions to mirror closely tcp_recvmsg() this should
  fix unexpected behavior with timeout and signals.
- brings in MSG_WAITALL && lowlatency support. This is actually required
  to avoid deadlock in the selftests once we switch to the above end of
  main loop conditions

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 174 +++++++++++++++++++++++++++----------------
 1 file changed, 111 insertions(+), 63 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index da2d749d69f4..21743afd935c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -92,6 +92,29 @@ static struct sock *mptcp_subflow_get(const struct mptcp=
_sock *msk)
 	return NULL;
 }
 =

+static struct sock *mptcp_subflow_recv_lookup(const struct mptcp_sock *msk)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	struct mptcp_subflow_context *subflow;
+	int receivers =3D 0;
+
+	sock_owned_by_me(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->data_avail)
+			return mptcp_subflow_tcp_socket(subflow)->sk;
+
+		receivers +=3D !subflow->rx_eof;
+	}
+
+	/* hopefully temporary hack: propagate shutdown status from subflow
+	 * to msk, when all subflows agree on it
+	 */
+	if (!receivers && !(sk->sk_shutdown & RCV_SHUTDOWN))
+		sk->sk_shutdown |=3D RCV_SHUTDOWN;
+	return NULL;
+}
+
 static inline bool mptcp_skb_can_collapse_to(u64 write_seq,
 					     const struct sk_buff *skb,
 					     const struct mptcp_ext *mpext)
@@ -452,6 +475,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 	struct tcp_sock *tp;
 	struct sock *ssk;
 	int copied =3D 0;
+	int target;
 	long timeo;
 =

 	lock_sock(sk);
@@ -465,17 +489,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 		return copied;
 	}
 =

-	ssk =3D mptcp_subflow_get(msk);
-	if (!ssk) {
-		release_sock(sk);
-		return -ENOTCONN;
-	}
-
-	subflow =3D mptcp_subflow_ctx(ssk);
-	tp =3D tcp_sk(ssk);
-
-	lock_sock(ssk);
-
 	arg.msg =3D msg;
 	desc.arg.data =3D &arg;
 	desc.error =3D 0;
@@ -483,75 +496,102 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
 	timeo =3D sock_rcvtimeo(sk, nonblock);
 =

 	len =3D min_t(size_t, len, INT_MAX);
+	target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 =

 	while (copied < len) {
 		u32 map_remaining;
 		int bytes_read;
-		u64 ack_seq;
-		u64 old_ack;
 =

 		smp_mb__before_atomic();
 		clear_bit(MPTCP_DATA_READY, &msk->flags);
 		smp_mb__after_atomic();
 =

-		if (!mptcp_subflow_data_available(ssk))
+		ssk =3D mptcp_subflow_recv_lookup(msk);
+		pr_debug("msk=3D%p ssk=3D%p", msk, ssk);
+		if (!ssk)
 			goto wait_for_data;
 =

-		old_ack =3D msk->ack_seq;
-		ack_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
-		map_remaining =3D subflow->map_data_len -
-				mptcp_subflow_get_map_offset(subflow);
-
-		/* Read mapped data */
-		desc.count =3D min_t(size_t, len - copied, map_remaining);
-		bytes_read =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
-		if (bytes_read < 0)
-			break;
+		subflow =3D mptcp_subflow_ctx(ssk);
+		tp =3D tcp_sk(ssk);
 =

-		/* Refresh current MPTCP sequence number based on subflow seq */
-		ack_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
-		if (before64(old_ack, ack_seq))
-			msk->ack_seq =3D ack_seq;
-
-		copied +=3D bytes_read;
-
-		/* The 'wait_for_data' code path can terminate the receive loop
-		 * in a number of scenarios: check if more data is pending
-		 * before giving up.
-		 */
-		if (mptcp_subflow_data_available(ssk))
-			continue;
+		lock_sock(ssk);
+		while (mptcp_subflow_data_available(ssk)) {
+			/* try to read as much data as available */
+			map_remaining =3D subflow->map_data_len -
+					mptcp_subflow_get_map_offset(subflow);
+			desc.count =3D min_t(size_t, len - copied, map_remaining);
+			pr_debug("reading %ld bytes, copied %d", desc.count,
+				 copied);
+			bytes_read =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
+			if (bytes_read < 0) {
+				if (!copied)
+					copied =3D bytes_read;
+				release_sock(ssk);
+				goto out;
+			}
+
+			pr_debug("msk ack_seq=3D%llx -> %llx", msk->ack_seq,
+				 msk->ack_seq + bytes_read);
+			msk->ack_seq +=3D bytes_read;
+			copied +=3D bytes_read;
+			if (copied >=3D len) {
+				release_sock(ssk);
+				goto out;
+			}
+			if (tp->urg_data && tp->urg_seq =3D=3D tp->copied_seq) {
+				pr_err("Urgent data present, cannot proceed");
+				release_sock(ssk);
+				goto out;
+			}
+		}
+		release_sock(ssk);
+		continue;
 =

 wait_for_data:
-		if (copied)
-			break;
-
-		if (tp->urg_data && tp->urg_seq =3D=3D tp->copied_seq) {
-			pr_err("Urgent data present, cannot proceed");
+		/* only the master socket status is relevant here. The exit
+		 * conditions mirror closely tcp_recvmsg()
+		 */
+		if (copied >=3D target)
 			break;
-		}
 =

-		if (ssk->sk_err || ssk->sk_state =3D=3D TCP_CLOSE ||
-		    (ssk->sk_shutdown & RCV_SHUTDOWN) || !timeo ||
-		    signal_pending(current)) {
-			pr_debug("nonblock or error");
-			break;
+		if (copied) {
+			if (sk->sk_err ||
+			    sk->sk_state =3D=3D TCP_CLOSE ||
+			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
+			    !timeo ||
+			    signal_pending(current))
+				break;
+		} else {
+			if (sk->sk_err) {
+				copied =3D sock_error(sk);
+				break;
+			}
+
+			if (sk->sk_shutdown & RCV_SHUTDOWN)
+				break;
+
+			if (sk->sk_state =3D=3D TCP_CLOSE) {
+				copied =3D -ENOTCONN;
+				break;
+			}
+
+			if (!timeo) {
+				copied =3D -EAGAIN;
+				break;
+			}
+
+			if (signal_pending(current)) {
+				copied =3D sock_intr_errno(timeo);
+				break;
+			}
 		}
 =

-		/* Handle blocking and retry read if needed.
-		 *
-		 * Wait on MPTCP sock, the subflow will notify via data ready.
-		 */
-
-		pr_debug("block");
-		release_sock(ssk);
+		pr_debug("block timeout %ld", timeo);
 		mptcp_wait_data(sk, &timeo);
-		lock_sock(ssk);
 	}
 =

-	release_sock(ssk);
+out:
 	release_sock(sk);
-
 	return copied;
 }
 =

@@ -800,12 +840,7 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 		atomic64_set(&msk->snd_una, msk->write_seq);
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
-		subflow->map_seq =3D ack_seq;
-		subflow->map_subflow_seq =3D 1;
-		subflow->rel_write_seq =3D 1;
-		subflow->tcp_sock =3D new_sock;
 		newsk =3D new_mptcp_sock;
-		subflow->conn =3D new_mptcp_sock;
 		list_add(&subflow->node, &msk->conn_list);
 		bh_unlock_sock(new_mptcp_sock);
 =

@@ -813,6 +848,19 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 		local_bh_enable();
 		inet_sk_state_store(newsk, TCP_ESTABLISHED);
 		release_sock(sk);
+
+		/* the subflow can already receive packet, avoid racing with
+		 * the receive path and process the pending ones
+		 */
+		lock_sock(new_sock->sk);
+		subflow->map_seq =3D ack_seq;
+		subflow->map_subflow_seq =3D 1;
+		subflow->rel_write_seq =3D 1;
+		subflow->tcp_sock =3D new_sock;
+		subflow->conn =3D new_mptcp_sock;
+		if (unlikely(!skb_queue_empty(&new_sock->sk->sk_receive_queue)))
+			mptcp_subflow_data_available(new_sock->sk);
+		release_sock(new_sock->sk);
 	} else {
 		newsk =3D new_sock->sk;
 		tcp_sk(newsk)->is_mptcp =3D 0;
-- =

2.21.0

--===============1790163554556373643==--
