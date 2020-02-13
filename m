Content-Type: multipart/mixed; boundary="===============7376925507075266030=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 4/5] mptcp: update mptcp ack sequence from work queue
Date: Thu, 13 Feb 2020 11:27:41 +0100
Message-ID: <20200213102742.18937-5-fw@strlen.de>
In-Reply-To: 20200213102742.18937-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3647

--===============7376925507075266030==
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

We still wake the userspace task that poll for events -- we do not
depend on the work queue to have run: if the mptcp level receive queue
is empty, skbs are taken from in-sequence subflow sockets.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 162 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |   1 +
 2 files changed, 163 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1ce5105e980a..e9e87e62a184 100644
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
@@ -643,6 +656,45 @@ static void mptcp_wait_data(struct sock *sk, long *tim=
eo)
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
+		break;
+	}
+
+	return copied;
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
@@ -688,6 +740,24 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 		u32 map_remaining;
 		int bytes_read;
 =

+		bytes_read =3D __mptcp_recvmsg_mskq(msk, msg, len - copied);
+		if (unlikely(bytes_read < 0)) {
+			if (!copied)
+				copied =3D bytes_read;
+
+			goto out_err;
+		}
+
+		copied +=3D bytes_read;
+
+		if (!skb_queue_empty(&sk->sk_receive_queue)) {
+			if (copied =3D=3D len) {
+				more_data_avail =3D true;
+				done =3D true;
+			}
+			continue;
+		}
+
 		ssk =3D mptcp_subflow_recv_lookup(msk);
 		pr_debug("msk=3D%p ssk=3D%p", msk, ssk);
 		if (!ssk)
@@ -793,6 +863,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 			set_bit(MPTCP_DATA_READY, &msk->flags);
 	}
 =

+out_err:
 	release_sock(sk);
 	return copied;
 }
@@ -906,6 +977,90 @@ static void mptcp_check_for_eof(struct mptcp_sock *msk)
 	}
 }
 =

+struct mptcp_steal_arg {
+	struct mptcp_sock *msk;
+	struct sock *ssk;
+	bool fin;
+};
+
+static int mptcp_steal_actor(read_descriptor_t *desc, struct sk_buff *skb,
+			     unsigned int offset, size_t len)
+{
+	struct mptcp_steal_arg *arg =3D desc->arg.data;
+	struct sock *sk, *ssk;
+	size_t copy_len =3D min(desc->count, len);
+
+	sk =3D (struct sock *)arg->msk;
+	ssk =3D arg->ssk;
+
+	/* skb_orphan is not good (should keep skb charged to subflow).
+	 * Removing it causes WARN at ssk close time, as tcp_done() call
+	 * path may see ssk->sk_forward_alloc > 0.
+	 */
+	__skb_unlink(skb, &ssk->sk_receive_queue);
+	skb_orphan(skb);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+
+	arg->msk->ack_seq +=3D copy_len;
+	desc->count -=3D copy_len;
+	MPTCP_SKB_CB(skb)->offset =3D offset;
+	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
+		arg->fin =3D true;
+
+	return (int)copy_len;
+}
+
+static void __mptcp_move_skbs(struct mptcp_sock *msk)
+{
+	struct mptcp_steal_arg arg =3D {
+		.msk =3D msk,
+		.fin =3D false,
+	};
+	read_descriptor_t desc =3D {
+		.arg.data =3D &arg,
+	};
+
+	for (;;) {
+		struct mptcp_subflow_context *subflow;
+		bool more_data_avail;
+
+		arg.ssk =3D mptcp_subflow_recv_lookup(msk);
+		if (!arg.ssk)
+			break;
+
+		subflow =3D mptcp_subflow_ctx(arg.ssk);
+
+		lock_sock(arg.ssk);
+
+		do {
+			u32 map_remaining;
+			int bytes_read;
+
+			/* try to read as much data as available */
+			map_remaining =3D subflow->map_data_len -
+					mptcp_subflow_get_map_offset(subflow);
+			desc.count =3D map_remaining;
+
+			bytes_read =3D tcp_read_sock(arg.ssk, &desc, mptcp_steal_actor);
+			if (bytes_read <=3D 0) {
+				release_sock(arg.ssk);
+				return;
+			}
+
+			if (arg.fin) {
+				struct tcp_sock *tp =3D tcp_sk(arg.ssk);
+				u32 seq =3D READ_ONCE(tp->copied_seq);
+
+				WRITE_ONCE(tp->copied_seq, seq + 1);
+			}
+
+			more_data_avail =3D mptcp_subflow_data_available(arg.ssk);
+		} while (more_data_avail);
+
+		release_sock(arg.ssk);
+	}
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	int orig_len, orig_offset, ret, mss_now =3D 0, size_goal =3D 0;
@@ -923,6 +1078,9 @@ static void mptcp_worker(struct work_struct *work)
 	lock_sock(sk);
 	mptcp_clean_una(sk);
 =

+	if (test_and_clear_bit(MPTCP_WORK_DATA_READY, &msk->flags))
+		__mptcp_move_skbs(msk);
+
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
 =

@@ -1087,6 +1245,8 @@ static void mptcp_close(struct sock *sk, long timeout)
 =

 	mptcp_cancel_work(sk);
 =

+	__skb_queue_purge(&sk->sk_receive_queue);
+
 	sk_common_release(sk);
 }
 =

@@ -1757,6 +1917,8 @@ void mptcp_proto_init(void)
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
index 760607e3e65f..e755ed4f273d 100644
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

--===============7376925507075266030==--
