Content-Type: multipart/mixed; boundary="===============1111236556922251822=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 2/6] mptcp: update mptcp ack sequence from work
 queue
Date: Thu, 20 Feb 2020 15:34:21 +0100
Message-ID: <20200220143426.28626-3-fw@strlen.de>
In-Reply-To: 20200220143426.28626-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3708

--===============1111236556922251822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds a new worker flag to indicate when the work queue should
drain a subflow socket.

skbs on the subflow socket are then placed on the mptcp socket receive
queue (which was not used so far).
This allows us to announce the correct mptcp ack sequence in the tcp
acks that we send back to the peer, even when the application does not
call recv() on the mptcp socket for some time.

We still wake userspace tasks waiting for POLLIN immediately:
If the mptcp level receive queue is empty (because the work queue is
still pending) it can be filled from in-sequence subflow sockets at
recv time.

Without this, when userspace is not reading data, all the mptcp-level
acks contain the ack_seq from the last time userspace read data rather
than the most recent in-sequence value.  This causes pointless
retransmissions for data that is already queued.

The skb_orphan when moving skbs from subflow to mptcp level is needed,
because the destructor (sock_rfree) relies on skb->sk (ssk!) lock
being taken.

Followup patch will add needed rmem accouting for the moved skbs.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 231 ++++++++++++++++++++++++++++++-------------
 net/mptcp/protocol.h |   1 +
 2 files changed, 164 insertions(+), 68 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 84204129e1d3..85d7f73ca804 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -34,6 +34,12 @@ struct mptcp6_sock {
 =

 static struct percpu_counter mptcp_sockets_allocated;
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
@@ -162,6 +168,13 @@ void mptcp_data_ready(struct sock *sk)
 =

 	set_bit(MPTCP_DATA_READY, &msk->flags);
 	sk->sk_data_ready(sk);
+
+	if (test_and_set_bit(MPTCP_WORK_DATA_READY, &msk->flags))
+		return;
+
+	sock_hold(sk);
+	if (!schedule_work(&msk->rtx_work))
+		sock_put(sk);
 }
 =

 static void mptcp_stop_timer(struct sock *sk)
@@ -641,19 +654,134 @@ static void mptcp_wait_data(struct sock *sk, long *t=
imeo)
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
+static bool __mptcp_move_skbs(struct mptcp_sock *msk)
+{
+	struct sock *sk =3D &msk->sk.icsk_inet.sk;
+	unsigned int moved =3D 0;
+	bool done =3D false;
+
+	do {
+		struct mptcp_subflow_context *subflow;
+		struct sock *ssk;
+		bool more_data_avail;
+		struct tcp_sock *tp;
+
+		ssk =3D mptcp_subflow_recv_lookup(msk);
+		if (!ssk)
+			break;
+
+		subflow =3D mptcp_subflow_ctx(ssk);
+
+		lock_sock(ssk);
+
+		tp =3D tcp_sk(ssk);
+		do {
+			u32 map_remaining, offset;
+			u32 seq =3D tp->copied_seq;
+			struct sk_buff *skb;
+			bool fin;
+
+			/* try to move as much data as available */
+			map_remaining =3D subflow->map_data_len -
+					mptcp_subflow_get_map_offset(subflow);
+
+			skb =3D skb_peek(&ssk->sk_receive_queue);
+			if (!skb)
+				break;
+
+			offset =3D seq - TCP_SKB_CB(skb)->seq;
+			fin =3D TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
+			if (fin) {
+				done =3D true;
+				seq++;
+			}
+
+			if (offset < skb->len) {
+				size_t len =3D skb->len - offset;
+
+				if (tp->urg_data)
+					done =3D true;
+
+				__mptcp_move_skb(msk, ssk, skb, offset, len);
+				seq +=3D len;
+				moved +=3D len;
+
+				if (WARN_ON_ONCE(map_remaining < len))
+					break;
+			} else {
+				WARN_ON_ONCE(!fin);
+				sk_eat_skb(sk, skb);
+				done =3D true;
+			}
+
+			WRITE_ONCE(tp->copied_seq, seq);
+			more_data_avail =3D mptcp_subflow_data_available(ssk);
+		} while (more_data_avail);
+
+		release_sock(ssk);
+	} while (!done);
+
+	return moved > 0;
+}
+
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
@@ -671,66 +799,27 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
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
 	__mptcp_flush_join_list(msk);
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
@@ -771,26 +860,25 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
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
@@ -921,6 +1009,9 @@ static void mptcp_worker(struct work_struct *work)
 	lock_sock(sk);
 	mptcp_clean_una(sk);
 =

+	if (test_and_clear_bit(MPTCP_WORK_DATA_READY, &msk->flags))
+		__mptcp_move_skbs(msk);
+
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
 =

@@ -1085,6 +1176,8 @@ static void mptcp_close(struct sock *sk, long timeout)
 =

 	mptcp_cancel_work(sk);
 =

+	__skb_queue_purge(&sk->sk_receive_queue);
+
 	sk_common_release(sk);
 }
 =

@@ -1755,6 +1848,8 @@ void mptcp_proto_init(void)
 		panic("Failed to register MPTCP proto.\n");
 =

 	inet_register_protosw(&mptcp_protosw);
+
+	BUILD_BUG_ON(sizeof(struct mptcp_skb_cb) > sizeof_field(struct sk_buff, c=
b));
 }
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 95b0ade75771..d676b7b6bbd3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -82,6 +82,7 @@
 #define MPTCP_SEND_SPACE	BIT(1)
 #define MPTCP_WORK_RTX		BIT(2)
 #define MPTCP_WORK_EOF		BIT(3)
+#define MPTCP_WORK_DATA_READY	BIT(4)
 =

 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
 {
-- =

2.24.1

--===============1111236556922251822==--
