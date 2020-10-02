Content-Type: multipart/mixed; boundary="===============5354986388824330200=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 11/13] mptcp: rework poll+nospace handling
Date: Fri, 02 Oct 2020 11:26:21 +0200
Message-ID: <892b8d02778ef7af57ebec5d0ca26be39241a1c6.1601630384.git.pabeni@redhat.com>
In-Reply-To: cover.1601630384.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6161

--===============5354986388824330200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

MPTCP maintains a status bit, MPTCP_SEND_SPACE, that is set when at
least one subflow and the mptcp socket itself are writeable.

mptcp_poll returns EPOLLOUT if the bit is set.

mptcp_sendmsg makes sure MPTCP_SEND_SPACE gets cleared when last write
has used up all subflows or the mptcp socket wmem.

This reworks nospace handling as follows:

MPTCP_SEND_SPACE is replaced with MPTCP_NOSPACE, i.e. inverted meaning.
This bit is set when the mptcp socket is not writeable.
The mptcp-level ack path schedule will then schedule the mptcp worker
to allow it to free already-acked data (and reduce wmem usage).

This will then wake userspace processes that wait for a POLLOUT event.

sendmsg will set MPTCP_NOSPACE only when it has to wait for more
wmem (blocking I/O case).

poll path will set MPTCP_NOSPACE in case the mptcp socket is
not writeable.

Normal tcp-level notification (SOCK_NOSPACE) is only enabled
in case the subflow socket has no available wmem.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 92 +++++++++++++++++++++++---------------------
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  | 11 +++---
 3 files changed, 54 insertions(+), 51 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fecdb3aba14f..af98a8643091 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -710,7 +710,7 @@ void mptcp_data_acked(struct sock *sk)
 {
 	mptcp_reset_timer(sk);
 =

-	if ((!test_bit(MPTCP_SEND_SPACE, &mptcp_sk(sk)->flags) ||
+	if ((test_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags) ||
 	     mptcp_send_head(sk) ||
 	     (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)))
 		mptcp_schedule_work(sk);
@@ -806,20 +806,6 @@ static void dfrag_clear(struct sock *sk, struct mptcp_=
data_frag *dfrag)
 	put_page(dfrag->page);
 }
 =

-static bool mptcp_is_writeable(struct mptcp_sock *msk)
-{
-	struct mptcp_subflow_context *subflow;
-
-	if (!sk_stream_is_writeable((struct sock *)msk))
-		return false;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		if (sk_stream_is_writeable(subflow->tcp_sock))
-			return true;
-	}
-	return false;
-}
-
 static void mptcp_clean_una(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -872,13 +858,8 @@ static void mptcp_clean_una_wakeup(struct sock *sk)
 	mptcp_clean_una(sk);
 =

 	/* Only wake up writers if a subflow is ready */
-	if (mptcp_is_writeable(msk)) {
-		set_bit(MPTCP_SEND_SPACE, &msk->flags);
-		smp_mb__after_atomic();
-
-		/* set SEND_SPACE before sk_stream_write_space clears
-		 * NOSPACE
-		 */
+	if (sk_stream_is_writeable(sk)) {
+		clear_bit(MPTCP_NOSPACE, &msk->flags);
 		sk_stream_write_space(sk);
 	}
 }
@@ -1019,17 +1000,25 @@ static void mptcp_nospace(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
 =

-	clear_bit(MPTCP_SEND_SPACE, &msk->flags);
+	set_bit(MPTCP_NOSPACE, &msk->flags);
 	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */
 =

 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		bool ssk_writeable =3D sk_stream_is_writeable(ssk);
 		struct socket *sock =3D READ_ONCE(ssk->sk_socket);
 =

+		if (ssk_writeable || !sock)
+			continue;
+
 		/* enables ssk->write_space() callbacks */
-		if (sock)
-			set_bit(SOCK_NOSPACE, &sock->flags);
+		set_bit(SOCK_NOSPACE, &sock->flags);
 	}
+
+	/* mptcp_data_acked() could run just before we set the NOSPACE bit,
+	 * so explicitly check for snd_una value
+	 */
+	mptcp_clean_una((struct sock *)msk);
 }
 =

 static bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
@@ -1133,12 +1122,6 @@ static struct sock *mptcp_subflow_get_send(struct mp=
tcp_sock *msk,
 	return NULL;
 }
 =

-static void ssk_check_wmem(struct mptcp_sock *msk)
-{
-	if (unlikely(!mptcp_is_writeable(msk)))
-		mptcp_nospace(msk);
-}
-
 static void mptcp_push_release(struct sock *sk, struct sock *ssk,
 			       struct mptcp_sendmsg_info *info)
 {
@@ -1310,7 +1293,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =

 wait_for_memory:
 		mptcp_nospace(msk);
-		mptcp_clean_una(sk);
 		if (mptcp_timer_pending(sk))
 			mptcp_reset_timer(sk);
 		ret =3D sk_stream_wait_memory(sk, &timeo);
@@ -1322,7 +1304,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		mptcp_push_pending(sk, msg->msg_flags);
 =

 out:
-	ssk_check_wmem(msk);
 	release_sock(sk);
 	return copied ? : ret;
 }
@@ -1866,7 +1847,6 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
-	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue =3D RB_ROOT;
 	msk->first_pending =3D NULL;
@@ -2557,13 +2537,6 @@ bool mptcp_finish_join(struct sock *ssk)
 	return true;
 }
 =

-static bool mptcp_memory_free(const struct sock *sk, int wake)
-{
-	struct mptcp_sock *msk =3D mptcp_sk(sk);
-
-	return wake ? test_bit(MPTCP_SEND_SPACE, &msk->flags) : true;
-}
-
 static struct proto mptcp_prot =3D {
 	.name		=3D "MPTCP",
 	.owner		=3D THIS_MODULE,
@@ -2584,7 +2557,6 @@ static struct proto mptcp_prot =3D {
 	.sockets_allocated	=3D &mptcp_sockets_allocated,
 	.memory_allocated	=3D &tcp_memory_allocated,
 	.memory_pressure	=3D &tcp_memory_pressure,
-	.stream_memory_free	=3D mptcp_memory_free,
 	.sysctl_wmem_offset	=3D offsetof(struct net, ipv4.sysctl_tcp_wmem),
 	.sysctl_mem	=3D sysctl_tcp_mem,
 	.obj_size	=3D sizeof(struct mptcp_sock),
@@ -2757,6 +2729,39 @@ static __poll_t mptcp_check_readable(struct mptcp_so=
ck *msk)
 	       0;
 }
 =

+static bool __mptcp_check_writeable(struct mptcp_sock *msk)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	bool mptcp_writable;
+
+	mptcp_clean_una(sk);
+	mptcp_writable =3D sk_stream_is_writeable(sk);
+	if (!mptcp_writable)
+		mptcp_nospace(msk);
+
+	return mptcp_writable;
+}
+
+static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	__poll_t ret =3D 0;
+	bool slow;
+
+	if (unlikely(sk->sk_shutdown & SEND_SHUTDOWN))
+		return 0;
+
+	if (sk_stream_is_writeable(sk))
+		return EPOLLOUT | EPOLLWRNORM;
+
+	slow =3D lock_sock_fast(sk);
+	if (__mptcp_check_writeable(msk))
+		ret =3D EPOLLOUT | EPOLLWRNORM;
+
+	unlock_sock_fast(sk, slow);
+	return ret;
+}
+
 static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait)
 {
@@ -2775,8 +2780,7 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 =

 	if (state !=3D TCP_SYN_SENT && state !=3D TCP_SYN_RECV) {
 		mask |=3D mptcp_check_readable(msk);
-		if (test_bit(MPTCP_SEND_SPACE, &msk->flags))
-			mask |=3D EPOLLOUT | EPOLLWRNORM;
+		mask |=3D mptcp_check_writeable(msk);
 	}
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		mask |=3D EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bdcb46d1adae..482e982a706d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -86,7 +86,7 @@
 =

 /* MPTCP socket flags */
 #define MPTCP_DATA_READY	0
-#define MPTCP_SEND_SPACE	1
+#define MPTCP_NOSPACE		1
 #define MPTCP_WORK_RTX		2
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index dff4ae087233..ae5fa5b3d42b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -986,17 +986,16 @@ static void subflow_data_ready(struct sock *sk)
 static void subflow_write_space(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct socket *sock =3D READ_ONCE(sk->sk_socket);
 	struct sock *parent =3D subflow->conn;
 =

 	if (!sk_stream_is_writeable(sk))
 		return;
 =

-	if (sk_stream_is_writeable(parent)) {
-		set_bit(MPTCP_SEND_SPACE, &mptcp_sk(parent)->flags);
-		smp_mb__after_atomic();
-		/* set SEND_SPACE before sk_stream_write_space clears NOSPACE */
-		sk_stream_write_space(parent);
-	}
+	if (sock && sk_stream_is_writeable(parent))
+		clear_bit(SOCK_NOSPACE, &sock->flags);
+
+	sk_stream_write_space(parent);
 }
 =

 static struct inet_connection_sock_af_ops *
-- =

2.26.2

--===============5354986388824330200==--
