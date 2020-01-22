Content-Type: multipart/mixed; boundary="===============4576500247250676727=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v3 12/19] mptcp: recvmsg() can drain data
 from multiple subflows
Date: Tue, 21 Jan 2020 16:56:26 -0800
Message-ID: <20200122005633.21229-13-cpaasch@apple.com>
In-Reply-To: 20200122005633.21229-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 3480

--===============4576500247250676727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

With the previous patch in place, the msk can detect which subflow
has the current map with a simple walk, let's update the main
loop to always select the 'current' subflow. The exit conditions now
closely mirror tcp_recvmsg() to get expected timeout and signal
behavior.

Co-developed-by: Peter Krystad <peter.krystad(a)linux.intel.com>
Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
Co-developed-by: Davide Caratti <dcaratti(a)redhat.com>
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Co-developed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Co-developed-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/protocol.c | 178 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 168 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 408efbe34753..ad9c73cc20e1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -9,6 +9,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/sched/signal.h>
+#include <linux/atomic.h>
 #include <net/sock.h>
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
@@ -105,6 +107,21 @@ static bool mptcp_ext_cache_refill(struct mptcp_sock *=
msk)
 	return !!msk->cached_ext;
 }
 =

+static struct sock *mptcp_subflow_recv_lookup(const struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+
+	sock_owned_by_me(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->data_avail)
+			return mptcp_subflow_tcp_sock(subflow);
+	}
+
+	return NULL;
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct msghdr *msg, long *timeo)
 {
@@ -269,13 +286,37 @@ int mptcp_read_actor(read_descriptor_t *desc, struct =
sk_buff *skb,
 	return copy_len;
 }
 =

+static void mptcp_wait_data(struct sock *sk, long *timeo)
+{
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	add_wait_queue(sk_sleep(sk), &wait);
+	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
+
+	sk_wait_event(sk, timeo,
+		      test_and_clear_bit(MPTCP_DATA_READY, &msk->flags), &wait);
+
+	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
+	remove_wait_queue(sk_sleep(sk), &wait);
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	bool more_data_avail =3D false;
+	struct mptcp_read_arg arg;
+	read_descriptor_t desc;
+	bool wait_data =3D false;
 	struct socket *ssock;
+	struct tcp_sock *tp;
+	bool done =3D false;
 	struct sock *ssk;
 	int copied =3D 0;
+	int target;
+	long timeo;
 =

 	if (msg->msg_flags & ~(MSG_WAITALL | MSG_DONTWAIT))
 		return -EOPNOTSUPP;
@@ -290,16 +331,124 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
 		return copied;
 	}
 =

-	ssk =3D mptcp_subflow_get(msk);
-	if (!ssk) {
-		release_sock(sk);
-		return -ENOTCONN;
+	arg.msg =3D msg;
+	desc.arg.data =3D &arg;
+	desc.error =3D 0;
+
+	timeo =3D sock_rcvtimeo(sk, nonblock);
+
+	len =3D min_t(size_t, len, INT_MAX);
+	target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
+
+	while (!done) {
+		u32 map_remaining;
+		int bytes_read;
+
+		ssk =3D mptcp_subflow_recv_lookup(msk);
+		pr_debug("msk=3D%p ssk=3D%p", msk, ssk);
+		if (!ssk)
+			goto wait_for_data;
+
+		subflow =3D mptcp_subflow_ctx(ssk);
+		tp =3D tcp_sk(ssk);
+
+		lock_sock(ssk);
+		do {
+			/* try to read as much data as available */
+			map_remaining =3D subflow->map_data_len -
+					mptcp_subflow_get_map_offset(subflow);
+			desc.count =3D min_t(size_t, len - copied, map_remaining);
+			pr_debug("reading %zu bytes, copied %d", desc.count,
+				 copied);
+			bytes_read =3D tcp_read_sock(ssk, &desc,
+						   mptcp_read_actor);
+			if (bytes_read < 0) {
+				if (!copied)
+					copied =3D bytes_read;
+				done =3D true;
+				goto next;
+			}
+
+			pr_debug("msk ack_seq=3D%llx -> %llx", msk->ack_seq,
+				 msk->ack_seq + bytes_read);
+			msk->ack_seq +=3D bytes_read;
+			copied +=3D bytes_read;
+			if (copied >=3D len) {
+				done =3D true;
+				goto next;
+			}
+			if (tp->urg_data && tp->urg_seq =3D=3D tp->copied_seq) {
+				pr_err("Urgent data present, cannot proceed");
+				done =3D true;
+				goto next;
+			}
+next:
+			more_data_avail =3D mptcp_subflow_data_available(ssk);
+		} while (more_data_avail && !done);
+		release_sock(ssk);
+		continue;
+
+wait_for_data:
+		more_data_avail =3D false;
+
+		/* only the master socket status is relevant here. The exit
+		 * conditions mirror closely tcp_recvmsg()
+		 */
+		if (copied >=3D target)
+			break;
+
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
+		}
+
+		pr_debug("block timeout %ld", timeo);
+		wait_data =3D true;
+		mptcp_wait_data(sk, &timeo);
 	}
 =

-	copied =3D sock_recvmsg(ssk->sk_socket, msg, flags);
+	if (more_data_avail) {
+		if (!test_bit(MPTCP_DATA_READY, &msk->flags))
+			set_bit(MPTCP_DATA_READY, &msk->flags);
+	} else if (!wait_data) {
+		clear_bit(MPTCP_DATA_READY, &msk->flags);
 =

-	release_sock(sk);
+		/* .. race-breaker: ssk might get new data after last
+		 * data_available() returns false.
+		 */
+		ssk =3D mptcp_subflow_recv_lookup(msk);
+		if (unlikely(ssk))
+			set_bit(MPTCP_DATA_READY, &msk->flags);
+	}
 =

+	release_sock(sk);
 	return copied;
 }
 =

@@ -460,10 +609,6 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 		msk->write_seq =3D subflow->idsn + 1;
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
-		subflow->map_seq =3D ack_seq;
-		subflow->map_subflow_seq =3D 1;
-		subflow->rel_write_seq =3D 1;
-		subflow->tcp_sock =3D ssk;
 		newsk =3D new_mptcp_sock;
 		mptcp_copy_inaddrs(newsk, ssk);
 		list_add(&subflow->node, &msk->conn_list);
@@ -475,6 +620,19 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 		bh_unlock_sock(new_mptcp_sock);
 		local_bh_enable();
 		release_sock(sk);
+
+		/* the subflow can already receive packet, avoid racing with
+		 * the receive path and process the pending ones
+		 */
+		lock_sock(ssk);
+		subflow->map_seq =3D ack_seq;
+		subflow->map_subflow_seq =3D 1;
+		subflow->rel_write_seq =3D 1;
+		subflow->tcp_sock =3D ssk;
+		subflow->conn =3D new_mptcp_sock;
+		if (unlikely(!skb_queue_empty(&ssk->sk_receive_queue)))
+			mptcp_subflow_data_available(ssk);
+		release_sock(ssk);
 	}
 =

 	return newsk;
-- =

2.23.0

--===============4576500247250676727==--
