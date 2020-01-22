Content-Type: multipart/mixed; boundary="===============7940655433246315477=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v3 11/19] mptcp: add subflow write space
 signalling and mptcp_poll
Date: Tue, 21 Jan 2020 16:56:25 -0800
Message-ID: <20200122005633.21229-12-cpaasch@apple.com>
In-Reply-To: 20200122005633.21229-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 3485

--===============7940655433246315477==
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
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/protocol.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  3 +++
 3 files changed, 57 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 71250149180b..408efbe34753 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -176,6 +176,23 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
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
+		/* set NOSPACE only after clearing SEND_SPACE flag */
+		set_bit(SOCK_NOSPACE, &sock->flags);
+	}
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -219,6 +236,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	if (copied > 0)
 		ret =3D copied;
 =

+	ssk_check_wmem(msk, ssk);
 	release_sock(ssk);
 	release_sock(sk);
 	return ret;
@@ -315,6 +333,7 @@ static int mptcp_init_sock(struct sock *sk)
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

 	INIT_LIST_HEAD(&msk->conn_list);
+	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
 =

 	return 0;
 }
@@ -576,6 +595,13 @@ static void mptcp_sock_graft(struct sock *sk, struct s=
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
@@ -591,6 +617,7 @@ static struct proto mptcp_prot =3D {
 	.hash		=3D inet_hash,
 	.unhash		=3D inet_unhash,
 	.get_port	=3D mptcp_get_port,
+	.stream_memory_free	=3D mptcp_memory_free,
 	.obj_size	=3D sizeof(struct mptcp_sock),
 	.no_autobind	=3D true,
 };
@@ -767,8 +794,34 @@ static int mptcp_stream_accept(struct socket *sock, st=
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
index c6d8217e24d4..59a83eb64d37 100644
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
index 528351e26371..9fb3eb87a20f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -529,6 +529,9 @@ static void subflow_write_space(struct sock *sk)
 =

 	sk_stream_write_space(sk);
 	if (parent && sk_stream_is_writeable(sk)) {
+		set_bit(MPTCP_SEND_SPACE, &mptcp_sk(parent)->flags);
+		smp_mb__after_atomic();
+		/* set SEND_SPACE before sk_stream_write_space clears NOSPACE */
 		sk_stream_write_space(parent);
 	}
 }
-- =

2.23.0

--===============7940655433246315477==--
