Content-Type: multipart/mixed; boundary="===============1908132483716600459=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 11/15] mptcp: add subflow write space
 signalling and mptcp_poll
Date: Fri, 13 Dec 2019 22:04:13 -0800
Message-ID: <20191214060417.2870-12-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191214060417.2870-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3059

--===============1908132483716600459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

Add new SEND_SPACE flag to indicate that a subflow has enough space to
accept more data for transmission.

It gets cleared at the end of mptcp_sendmsg() in case ssk has run
below the free watermark.

It is (re-set) from the wspace callback.

This allows us to use msk->flags to determine the poll mask.

Co-developed-by: Peter Krystad <peter.krystad(a)linux.intel.com>
Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  2 ++
 3 files changed, 55 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1ede654057ba..44e6f0d1070c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -177,6 +177,22 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 	return ret;
 }
 =

+static void ssk_check_wmem(struct mptcp_sock *msk, struct sock *ssk)
+{
+	struct socket *sock;
+
+	if (likely(sk_stream_is_writeable(ssk)))
+		return;
+
+	sock =3D READ_ONCE(ssk->sk_socket);
+
+	if (sock) {
+		clear_bit(MPTCP_SEND_SPACE, &msk->flags);
+		smp_mb__after_atomic();
+		set_bit(SOCK_NOSPACE, &sock->flags);
+	}
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -220,6 +236,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	if (copied > 0)
 		ret =3D copied;
 =

+	ssk_check_wmem(msk, ssk);
 	release_sock(ssk);
 	release_sock(sk);
 	return ret;
@@ -315,6 +332,7 @@ static int mptcp_init_sock(struct sock *sk)
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

 	INIT_LIST_HEAD(&msk->conn_list);
+	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
 =

 	return 0;
 }
@@ -580,6 +598,13 @@ static void mptcp_sock_graft(struct sock *sk, struct s=
ocket *parent)
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 =

+static bool mptcp_memory_free(const struct sock *sk, int wake)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	return wake ? test_bit(MPTCP_SEND_SPACE, &msk->flags) : true;
+}
+
 static struct proto mptcp_prot =3D {
 	.name		=3D "MPTCP",
 	.owner		=3D THIS_MODULE,
@@ -595,6 +620,7 @@ static struct proto mptcp_prot =3D {
 	.hash		=3D inet_hash,
 	.unhash		=3D inet_unhash,
 	.get_port	=3D mptcp_get_port,
+	.stream_memory_free	=3D mptcp_memory_free,
 	.obj_size	=3D sizeof(struct mptcp_sock),
 	.no_autobind	=3D true,
 };
@@ -771,8 +797,34 @@ static int mptcp_stream_accept(struct socket *sock, st=
ruct socket *newsock,
 static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait)
 {
+	const struct mptcp_sock *msk;
+	struct sock *sk =3D sock->sk;
+	struct socket *ssock;
 	__poll_t mask =3D 0;
 =

+	msk =3D mptcp_sk(sk);
+	lock_sock(sk);
+	ssock =3D __mptcp_nmpc_socket(msk);
+	if (ssock) {
+		mask =3D ssock->ops->poll(file, ssock, wait);
+		release_sock(sk);
+		return mask;
+	}
+
+	release_sock(sk);
+	sock_poll_wait(file, sock, wait);
+	lock_sock(sk);
+
+	if (test_bit(MPTCP_DATA_READY, &msk->flags))
+		mask =3D EPOLLIN | EPOLLRDNORM;
+	if (sk_stream_is_writeable(sk) &&
+	    test_bit(MPTCP_SEND_SPACE, &msk->flags))
+		mask |=3D EPOLLOUT | EPOLLWRNORM;
+	if (sk->sk_shutdown & RCV_SHUTDOWN)
+		mask |=3D EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
+
+	release_sock(sk);
+
 	return mask;
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index defa51c0dd44..f02dd5c35ec9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -56,6 +56,7 @@
 =

 /* MPTCP socket flags */
 #define MPTCP_DATA_READY	BIT(0)
+#define MPTCP_SEND_SPACE	BIT(1)
 =

 /* MPTCP connection sock */
 struct mptcp_sock {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index da10b5092d8d..269c7fcb8293 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -527,6 +527,8 @@ static void subflow_write_space(struct sock *sk)
 =

 	sk_stream_write_space(sk);
 	if (parent && sk_stream_is_writeable(sk)) {
+		set_bit(MPTCP_SEND_SPACE, &mptcp_sk(parent)->flags);
+		smp_mb__after_atomic();
 		sk_stream_write_space(parent);
 	}
 }
-- =

2.24.1

--===============1908132483716600459==--
