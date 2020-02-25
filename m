Content-Type: multipart/mixed; boundary="===============0708660928664997987=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 3/8] mptcp: update mptcp ack sequence from
 work queue
Date: Tue, 25 Feb 2020 13:05:21 +0100
Message-ID: <20200225120526.2866-4-fw@strlen.de>
In-Reply-To: 20200225120526.2866-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3773

--===============0708660928664997987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If userspace is not reading data, all the mptcp-level acks contain the
ack_seq from the last time userspace read data rather than the most
recent in-sequence value.

This causes pointless retransmissions for data that is already queued.

The reason for this is that all the mptcp protocol level processing
happens at mptcp_recv time.

This adds work queue to move skbs from the subflow sockets receive
queue on the mptcp socket receive queue (which was not used so far).

This allows us to announce the correct mptcp ack sequence in a timely
fashion, even when the application does not call recv() on the mptcp socket
for some time.

We still wake userspace tasks waiting for POLLIN immediately:
If the mptcp level receive queue is empty (because the work queue is
still pending) it can be filled from in-sequence subflow sockets at
recv time without a need to wait for the worker.

The skb_orphan when moving skbs from subflow to mptcp level is needed,
because the destructor (sock_rfree) relies on skb->sk (ssk!) lock
being taken.

A followup patch will add needed rmem accouting for the moved skbs.

Other problem: In case application behaves as expected, and calls
recv() as soon as mptcp socket becomes readable, the work queue will
only waste cpu cycles.  This will also be addressed in followup patches.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 233 ++++++++++++++++++++++++++++++-------------
 1 file changed, 164 insertions(+), 69 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cbf184a71ed7..d68c20a28efe 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -31,6 +31,12 @@ struct mptcp6_sock {
 };
 #endif
 =

+struct mptcp_skb_cb {
+	u32 offset;
+};
+
+#define MPTCP_SKB_CB(__skb)	((struct mptcp_skb_cb *)&((__skb)->cb[0]))
+
 /* If msk has an initial subflow socket, and the MP_CAPABLE handshake has =
not
  * completed yet or has failed, return the subflow socket.
  * Otherwise return NULL.
@@ -111,12 +117,88 @@ static struct sock *mptcp_subflow_get(const struct mp=
tcp_sock *msk)
 	return NULL;
 }
 =

+static void __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
+			     struct sk_buff *skb,
+			     unsigned int offset, size_t copy_len)
+{
+	struct sock *sk =3D (struct sock *)msk;
+
+	__skb_unlink(skb, &ssk->sk_receive_queue);
+	skb_orphan(skb);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+
+	msk->ack_seq +=3D copy_len;
+	MPTCP_SKB_CB(skb)->offset =3D offset;
+}
+
+static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
+					   struct sock *ssk,
+					   unsigned int *bytes)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	unsigned int moved =3D 0;
+	bool more_data_avail;
+	struct tcp_sock *tp;
+	bool done =3D false;
+
+	tp =3D tcp_sk(ssk);
+	do {
+		u32 map_remaining, offset;
+		u32 seq =3D tp->copied_seq;
+		struct sk_buff *skb;
+		bool fin;
+
+		/* try to move as much data as available */
+		map_remaining =3D subflow->map_data_len -
+				mptcp_subflow_get_map_offset(subflow);
+
+		skb =3D skb_peek(&ssk->sk_receive_queue);
+		if (!skb)
+			break;
+
+		offset =3D seq - TCP_SKB_CB(skb)->seq;
+		fin =3D TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
+		if (fin) {
+			done =3D true;
+			seq++;
+		}
+
+		if (offset < skb->len) {
+			size_t len =3D skb->len - offset;
+
+			if (tp->urg_data)
+				done =3D true;
+
+			__mptcp_move_skb(msk, ssk, skb, offset, len);
+			seq +=3D len;
+			moved +=3D len;
+
+			if (WARN_ON_ONCE(map_remaining < len))
+				break;
+		} else {
+			WARN_ON_ONCE(!fin);
+			sk_eat_skb(ssk, skb);
+			done =3D true;
+		}
+
+		WRITE_ONCE(tp->copied_seq, seq);
+		more_data_avail =3D mptcp_subflow_data_available(ssk);
+	} while (more_data_avail);
+
+	*bytes =3D moved;
+
+	return done;
+}
+
 void mptcp_data_ready(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

 	set_bit(MPTCP_DATA_READY, &msk->flags);
 	sk->sk_data_ready(sk);
+
+	if (schedule_work(&msk->work))
+		sock_hold((struct sock *)msk);
 }
 =

 static bool mptcp_ext_cache_refill(struct mptcp_sock *msk)
@@ -373,19 +455,68 @@ static void mptcp_wait_data(struct sock *sk, long *ti=
meo)
 	remove_wait_queue(sk_sleep(sk), &wait);
 }
 =

+static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
+				struct msghdr *msg,
+				size_t len)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	struct sk_buff *skb;
+	int copied =3D 0;
+
+	while ((skb =3D skb_peek(&sk->sk_receive_queue)) !=3D NULL) {
+		u32 offset =3D MPTCP_SKB_CB(skb)->offset;
+		u32 data_len =3D skb->len - offset;
+		u32 count =3D min_t(size_t, len - copied, data_len);
+		int err;
+
+		err =3D skb_copy_datagram_msg(skb, offset, msg, count);
+		if (unlikely(err < 0)) {
+			if (!copied)
+				return err;
+			break;
+		}
+
+		copied +=3D count;
+
+		if (count < data_len) {
+			MPTCP_SKB_CB(skb)->offset +=3D count;
+			break;
+		}
+
+		__skb_unlink(skb, &sk->sk_receive_queue);
+		__kfree_skb(skb);
+
+		if (copied >=3D len)
+			break;
+	}
+
+	return copied;
+}
+
+static bool __mptcp_move_skbs(struct mptcp_sock *msk)
+{
+	unsigned int moved =3D 0;
+	bool done;
+
+	do {
+		struct sock *ssk =3D mptcp_subflow_recv_lookup(msk);
+
+		if (!ssk)
+			break;
+
+		lock_sock(ssk);
+		done =3D __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
+		release_sock(ssk);
+	} while (!done);
+
+	return moved > 0;
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct mptcp_subflow_context *subflow;
-	bool more_data_avail =3D false;
-	struct mptcp_read_arg arg;
-	read_descriptor_t desc;
-	bool wait_data =3D false;
 	struct socket *ssock;
-	struct tcp_sock *tp;
-	bool done =3D false;
-	struct sock *ssk;
 	int copied =3D 0;
 	int target;
 	long timeo;
@@ -403,65 +534,26 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 		return copied;
 	}
 =

-	arg.msg =3D msg;
-	desc.arg.data =3D &arg;
-	desc.error =3D 0;
-
 	timeo =3D sock_rcvtimeo(sk, nonblock);
 =

 	len =3D min_t(size_t, len, INT_MAX);
 	target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 =

-	while (!done) {
-		u32 map_remaining;
+	while (len > (size_t)copied) {
 		int bytes_read;
 =

-		ssk =3D mptcp_subflow_recv_lookup(msk);
-		pr_debug("msk=3D%p ssk=3D%p", msk, ssk);
-		if (!ssk)
-			goto wait_for_data;
+		bytes_read =3D __mptcp_recvmsg_mskq(msk, msg, len - copied);
+		if (unlikely(bytes_read < 0)) {
+			if (!copied)
+				copied =3D bytes_read;
+			goto out_err;
+		}
 =

-		subflow =3D mptcp_subflow_ctx(ssk);
-		tp =3D tcp_sk(ssk);
+		copied +=3D bytes_read;
 =

-		lock_sock(ssk);
-		do {
-			/* try to read as much data as available */
-			map_remaining =3D subflow->map_data_len -
-					mptcp_subflow_get_map_offset(subflow);
-			desc.count =3D min_t(size_t, len - copied, map_remaining);
-			pr_debug("reading %zu bytes, copied %d", desc.count,
-				 copied);
-			bytes_read =3D tcp_read_sock(ssk, &desc,
-						   mptcp_read_actor);
-			if (bytes_read < 0) {
-				if (!copied)
-					copied =3D bytes_read;
-				done =3D true;
-				goto next;
-			}
-
-			pr_debug("msk ack_seq=3D%llx -> %llx", msk->ack_seq,
-				 msk->ack_seq + bytes_read);
-			msk->ack_seq +=3D bytes_read;
-			copied +=3D bytes_read;
-			if (copied >=3D len) {
-				done =3D true;
-				goto next;
-			}
-			if (tp->urg_data && tp->urg_seq =3D=3D tp->copied_seq) {
-				pr_err("Urgent data present, cannot proceed");
-				done =3D true;
-				goto next;
-			}
-next:
-			more_data_avail =3D mptcp_subflow_data_available(ssk);
-		} while (more_data_avail && !done);
-		release_sock(ssk);
-		continue;
-
-wait_for_data:
-		more_data_avail =3D false;
+		if (skb_queue_empty(&sk->sk_receive_queue) &&
+		    __mptcp_move_skbs(msk))
+			continue;
 =

 		/* only the master socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
@@ -502,26 +594,25 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 		}
 =

 		pr_debug("block timeout %ld", timeo);
-		wait_data =3D true;
 		mptcp_wait_data(sk, &timeo);
 		if (unlikely(__mptcp_tcp_fallback(msk)))
 			goto fallback;
 	}
 =

-	if (more_data_avail) {
-		if (!test_bit(MPTCP_DATA_READY, &msk->flags))
-			set_bit(MPTCP_DATA_READY, &msk->flags);
-	} else if (!wait_data) {
+	if (skb_queue_empty(&sk->sk_receive_queue)) {
+		/* entire backlog drained, clear DATA_READY. */
 		clear_bit(MPTCP_DATA_READY, &msk->flags);
 =

-		/* .. race-breaker: ssk might get new data after last
-		 * data_available() returns false.
+		/* .. race-breaker: ssk might have gotten new data
+		 * after last __mptcp_move_skbs() returned false.
 		 */
-		ssk =3D mptcp_subflow_recv_lookup(msk);
-		if (unlikely(ssk))
+		if (unlikely(__mptcp_move_skbs(msk)))
 			set_bit(MPTCP_DATA_READY, &msk->flags);
+	} else if (unlikely(!test_bit(MPTCP_DATA_READY, &msk->flags))) {
+		/* data to read but mptcp_wait_data() cleared DATA_READY */
+		set_bit(MPTCP_DATA_READY, &msk->flags);
 	}
-
+out_err:
 	release_sock(sk);
 	return copied;
 }
@@ -557,7 +648,7 @@ static void mptcp_worker(struct work_struct *work)
 	struct sock *sk =3D &msk->sk.icsk_inet.sk;
 =

 	lock_sock(sk);
-
+	__mptcp_move_skbs(msk);
 	release_sock(sk);
 	sock_put(sk);
 }
@@ -638,6 +729,8 @@ static void mptcp_close(struct sock *sk, long timeout)
 =

 	mptcp_cancel_work(sk);
 =

+	__skb_queue_purge(&sk->sk_receive_queue);
+
 	sk_common_release(sk);
 }
 =

@@ -1204,6 +1297,8 @@ void mptcp_proto_init(void)
 		panic("Failed to register MPTCP proto.\n");
 =

 	inet_register_protosw(&mptcp_protosw);
+
+	BUILD_BUG_ON(sizeof(struct mptcp_skb_cb) > sizeof_field(struct sk_buff, c=
b));
 }
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-- =

2.24.1

--===============0708660928664997987==--
