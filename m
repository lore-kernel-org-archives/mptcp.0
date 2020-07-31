Content-Type: multipart/mixed; boundary="===============4130466128514924703=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 01/12] mptcp: msk is writable according to msk
 write space
Date: Fri, 31 Jul 2020 19:39:16 +0200
Message-ID: <aa6bae778983c8f5d02a15e443482fc24ea2a56a.1596216310.git.pabeni@redhat.com>
In-Reply-To: cover.1596216310.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5408

--===============4130466128514924703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, when checking for the 'msk is writable' condition,
we look at the individual subflows write space. That works
well while we sends data via a single subflow, but will not
as soon as we will enable concurrent xmit on multiple subflows.

Let's use the msk write space instead.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 42 ++++++++++++++++++++++++------------------
 net/mptcp/subflow.c  |  3 +--
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3b9ae98c67bb..d51b1d95dfb8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -612,8 +612,15 @@ static void mptcp_clean_una(struct sock *sk)
 		sk_mem_reclaim_partial(sk);
 =

 		/* Only wake up writers if a subflow is ready */
-		if (test_bit(MPTCP_SEND_SPACE, &msk->flags))
+		if (sk_stream_is_writeable(sk)) {
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

@@ -799,21 +806,27 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 	return ret;
 }
 =

-static void mptcp_nospace(struct mptcp_sock *msk, struct socket *sock)
+static void mptcp_nospace(struct sock *sk, struct sock *ssk)
 {
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct socket *sock;
+
 	clear_bit(MPTCP_SEND_SPACE, &msk->flags);
 	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */
 =

 	/* enables sk->write_space() callbacks */
-	set_bit(SOCK_NOSPACE, &sock->flags);
+	sock =3D READ_ONCE(ssk->sk_socket);
+	if (sock)
+		set_bit(SOCK_NOSPACE, &sock->flags);
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
@@ -821,12 +834,8 @@ static struct sock *mptcp_subflow_get_send(struct mptc=
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
+			mptcp_nospace(sk, ssk);
 			return NULL;
 		}
 =

@@ -843,16 +852,12 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk)
 	return backup;
 }
 =

-static void ssk_check_wmem(struct mptcp_sock *msk, struct sock *ssk)
+static void ssk_check_wmem(struct sock *sk, struct sock *ssk)
 {
-	struct socket *sock;
-
-	if (likely(sk_stream_is_writeable(ssk)))
+	if (likely(sk_stream_is_writeable(sk)))
 		return;
 =

-	sock =3D READ_ONCE(ssk->sk_socket);
-	if (sock)
-		mptcp_nospace(msk, sock);
+	mptcp_nospace(sk, ssk);
 }
 =

 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
@@ -976,6 +981,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 				 * Wakeup will happen via mptcp_clean_una().
 				 */
 				mptcp_set_timeout(sk, ssk);
+				mptcp_nospace(sk, ssk);
 				release_sock(ssk);
 				goto wait_for_sndbuf;
 			}
@@ -992,7 +998,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 			mptcp_reset_timer(sk);
 	}
 =

-	ssk_check_wmem(msk, ssk);
+	ssk_check_wmem(sk, ssk);
 	release_sock(ssk);
 out:
 	release_sock(sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7e838bc6e364..bd2201d62ae6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -926,8 +926,7 @@ static void subflow_write_space(struct sock *sk)
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct sock *parent =3D subflow->conn;
 =

-	sk_stream_write_space(sk);
-	if (sk_stream_is_writeable(sk)) {
+	if (sk_stream_is_writeable(parent)) {
 		set_bit(MPTCP_SEND_SPACE, &mptcp_sk(parent)->flags);
 		smp_mb__after_atomic();
 		/* set SEND_SPACE before sk_stream_write_space clears NOSPACE */
-- =

2.26.2

--===============4130466128514924703==--
