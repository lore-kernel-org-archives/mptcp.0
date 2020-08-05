Content-Type: multipart/mixed; boundary="===============0780005647852331524=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 01/13] mptcp: rethink 'is writable' conditional
Date: Wed, 05 Aug 2020 19:57:00 +0200
Message-ID: <d3995c574535f2be869e5a0c5f5981d4ff346b27.1596649926.git.pabeni@redhat.com>
In-Reply-To: cover.1596649926.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5480

--===============0780005647852331524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, when checking for the 'msk is writable' condition,
we look at the individual subflows write space. That works
well while we sends data via a single subflow, but will not
as soon as we will enable concurrent xmit on multiple subflows.

With this change msk become writable when both the the following
conditions hold:
- the socket has some free write space
- there is at least a subflow with write free space

As results we need to set the NOSPACE bit on all subflows
before blocking, and we can drop the SEND_SPACE bit and related
code.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
RFC -> v1:
 - refactor mptcp_nospace
 - still check ssk write space or we can hit condition where
   msk is writeable but no subflow is
---
 net/mptcp/protocol.c | 69 ++++++++++++++++++++++++++++----------------
 net/mptcp/subflow.c  |  3 +-
 2 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3b9ae98c67bb..fd79b699acde 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -475,7 +475,7 @@ void mptcp_data_acked(struct sock *sk)
 {
 	mptcp_reset_timer(sk);
 =

-	if ((!sk_stream_is_writeable(sk) ||
+	if ((!test_bit(MPTCP_SEND_SPACE, &mptcp_sk(sk)->flags) ||
 	     (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)) &&
 	    schedule_work(&mptcp_sk(sk)->work))
 		sock_hold(sk);
@@ -570,6 +570,20 @@ static void dfrag_clear(struct sock *sk, struct mptcp_=
data_frag *dfrag)
 	put_page(dfrag->page);
 }
 =

+static bool mptcp_is_writeable(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	if (!sk_stream_is_writeable((struct sock *)msk))
+		return false;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (sk_stream_memory_free(mptcp_subflow_tcp_sock(subflow)))
+			return true;
+	}
+	return false;
+}
+
 static void mptcp_clean_una(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -612,8 +626,15 @@ static void mptcp_clean_una(struct sock *sk)
 		sk_mem_reclaim_partial(sk);
 =

 		/* Only wake up writers if a subflow is ready */
-		if (test_bit(MPTCP_SEND_SPACE, &msk->flags))
+		if (mptcp_is_writeable(msk)) {
+			set_bit(MPTCP_SEND_SPACE, &mptcp_sk(sk)->flags);
+			smp_mb__after_atomic();
+
+			/* set SEND_SPACE before sk_stream_write_space clears
+			 * NOSPACE
+			 */
 			sk_stream_write_space(sk);
+		}
 	}
 }
 =

@@ -799,21 +820,30 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 	return ret;
 }
 =

-static void mptcp_nospace(struct mptcp_sock *msk, struct socket *sock)
+static void mptcp_nospace(struct mptcp_sock *msk)
 {
+	struct mptcp_subflow_context *subflow;
+
 	clear_bit(MPTCP_SEND_SPACE, &msk->flags);
 	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */
 =

-	/* enables sk->write_space() callbacks */
-	set_bit(SOCK_NOSPACE, &sock->flags);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		struct socket *sock =3D READ_ONCE(ssk->sk_socket);
+
+		/* enables ssk->write_space() callbacks */
+		if (sock)
+			set_bit(SOCK_NOSPACE, &sock->flags);
+	}
 }
 =

 static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
 	struct sock *backup =3D NULL;
 =

-	sock_owned_by_me((const struct sock *)msk);
+	sock_owned_by_me(sk);
 =

 	if (!mptcp_ext_cache_refill(msk))
 		return NULL;
@@ -821,12 +851,8 @@ static struct sock *mptcp_subflow_get_send(struct mptc=
p_sock *msk)
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

-		if (!sk_stream_memory_free(ssk)) {
-			struct socket *sock =3D ssk->sk_socket;
-
-			if (sock)
-				mptcp_nospace(msk, sock);
-
+		if (!sk_stream_memory_free(sk)) {
+			mptcp_nospace(msk);
 			return NULL;
 		}
 =

@@ -843,16 +869,10 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk)
 	return backup;
 }
 =

-static void ssk_check_wmem(struct mptcp_sock *msk, struct sock *ssk)
+static void ssk_check_wmem(struct mptcp_sock *msk)
 {
-	struct socket *sock;
-
-	if (likely(sk_stream_is_writeable(ssk)))
-		return;
-
-	sock =3D READ_ONCE(ssk->sk_socket);
-	if (sock)
-		mptcp_nospace(msk, sock);
+	if (unlikely(!mptcp_is_writeable(msk)))
+		mptcp_nospace(msk);
 }
 =

 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
@@ -906,6 +926,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 				mptcp_reset_timer(sk);
 		}
 =

+		mptcp_nospace(msk);
 		ret =3D sk_stream_wait_memory(sk, &timeo);
 		if (ret)
 			goto out;
@@ -944,7 +965,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		if (!sk_stream_memory_free(ssk) ||
 		    !mptcp_page_frag_refill(ssk, pfrag) ||
 		    !mptcp_ext_cache_refill(msk)) {
-			set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 			tcp_push(ssk, msg->msg_flags, mss_now,
 				 tcp_sk(ssk)->nonagle, size_goal);
 			mptcp_set_timeout(sk, ssk);
@@ -992,9 +1012,9 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 			mptcp_reset_timer(sk);
 	}
 =

-	ssk_check_wmem(msk, ssk);
 	release_sock(ssk);
 out:
+	ssk_check_wmem(msk);
 	release_sock(sk);
 	return copied ? : ret;
 }
@@ -2294,8 +2314,7 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 =

 	if (state !=3D TCP_SYN_SENT && state !=3D TCP_SYN_RECV) {
 		mask |=3D mptcp_check_readable(msk);
-		if (sk_stream_is_writeable(sk) &&
-		    test_bit(MPTCP_SEND_SPACE, &msk->flags))
+		if (test_bit(MPTCP_SEND_SPACE, &msk->flags))
 			mask |=3D EPOLLOUT | EPOLLWRNORM;
 	}
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c2098d0f8d0b..c2f21471659f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1008,8 +1008,7 @@ static void subflow_write_space(struct sock *sk)
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct sock *parent =3D subflow->conn;
 =

-	sk_stream_write_space(sk);
-	if (sk_stream_is_writeable(sk)) {
+	if (sk_stream_memory_free(sk) && sk_stream_is_writeable(parent)) {
 		set_bit(MPTCP_SEND_SPACE, &mptcp_sk(parent)->flags);
 		smp_mb__after_atomic();
 		/* set SEND_SPACE before sk_stream_write_space clears NOSPACE */
-- =

2.26.2

--===============0780005647852331524==--
