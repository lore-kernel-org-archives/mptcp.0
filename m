Content-Type: multipart/mixed; boundary="===============8137644561045150620=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/6] mptcp: update mptcp ack sequence from work
 queue
Date: Mon, 17 Feb 2020 16:00:57 +0100
Message-ID: <20200217150101.13603-3-fw@strlen.de>
In-Reply-To: 20200217150101.13603-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3671

--===============8137644561045150620==
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

We still wake userspace tasks waiting for POLLIN -- we do not
depend on the work queue to have run. If the mptcp level receive queue
is empty, it can be filled from in-sequence subflow sockets at recv time.

v2: remove inner recv loop in mptcp_recvmsg.
    don't use tcp_read_sock, just move skbs directly.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 213 ++++++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.h |   1 +
 2 files changed, 159 insertions(+), 55 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 84204129e1d3..28fc28b7e9cf 100644
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
@@ -641,18 +654,136 @@ static void mptcp_wait_data(struct sock *sk, long *t=
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
+	bool more_data_avail =3D true;
 	bool wait_data =3D false;
 	struct socket *ssock;
-	struct tcp_sock *tp;
-	bool done =3D false;
 	struct sock *ssk;
 	int copied =3D 0;
 	int target;
@@ -671,66 +802,30 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
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
+	while (more_data_avail) {
 		int bytes_read;
 =

-		ssk =3D mptcp_subflow_recv_lookup(msk);
-		pr_debug("msk=3D%p ssk=3D%p", msk, ssk);
-		if (!ssk)
-			goto wait_for_data;
-
-		subflow =3D mptcp_subflow_ctx(ssk);
-		tp =3D tcp_sk(ssk);
+		bytes_read =3D __mptcp_recvmsg_mskq(msk, msg, len - copied);
+		if (unlikely(bytes_read < 0)) {
+			if (!copied)
+				copied =3D bytes_read;
+			goto out_err;
+		}
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
+		copied +=3D bytes_read;
 =

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
+		if (skb_queue_empty(&sk->sk_receive_queue)) {
+			if (!__mptcp_move_skbs(msk))
+				more_data_avail =3D false;
 =

-wait_for_data:
-		more_data_avail =3D false;
+			continue;
+		}
 =

 		/* only the master socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
@@ -791,6 +886,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 			set_bit(MPTCP_DATA_READY, &msk->flags);
 	}
 =

+out_err:
 	release_sock(sk);
 	return copied;
 }
@@ -921,6 +1017,9 @@ static void mptcp_worker(struct work_struct *work)
 	lock_sock(sk);
 	mptcp_clean_una(sk);
 =

+	if (test_and_clear_bit(MPTCP_WORK_DATA_READY, &msk->flags))
+		__mptcp_move_skbs(msk);
+
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
 =

@@ -1085,6 +1184,8 @@ static void mptcp_close(struct sock *sk, long timeout)
 =

 	mptcp_cancel_work(sk);
 =

+	__skb_queue_purge(&sk->sk_receive_queue);
+
 	sk_common_release(sk);
 }
 =

@@ -1755,6 +1856,8 @@ void mptcp_proto_init(void)
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

--===============8137644561045150620==--
