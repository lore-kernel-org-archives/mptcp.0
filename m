Content-Type: multipart/mixed; boundary="===============1004052076044537392=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fix tcp fallback crash
Date: Tue, 31 Mar 2020 13:19:26 +0200
Message-ID: <20200331111926.13919-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 4114

--===============1004052076044537392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Christoph Paasch reports following crash:

general protection fault, probably for non-canonical address 0xfe85e717fe88=
a633: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 2874 Comm: syz-executor072 Not tainted 5.6.0-rc5 #62
RIP: 0010:__pv_queued_spin_lock_slowpath+0x1b3/0x2f0 kernel/locking/qspinlo=
ck.c:471
[..]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:50 [inline]
 do_raw_spin_lock include/linux/spinlock.h:181 [inline]
 spin_lock_bh include/linux/spinlock.h:343 [inline]
 __mptcp_flush_join_list+0x44/0xb0 net/mptcp/protocol.c:278
 mptcp_shutdown+0xb3/0x230 net/mptcp/protocol.c:1882
[..]

Problem is that mptcp_shutdown() socket isn't an mptcp socket,
its a plain tcp_sk.  Thus, trying to access mptcp_sk specific
members accesses garbage.

Root cause is that accept() returns a fallback (tcp) socket,
not an mptcp one.  There is code in getpeername to detect this
and override the sockets stream_ops.  But this will only run when
accept() caller provided a sockaddr struct.  "accept(fd, NULL, 0)"
will therefore result in mptcp stream ops, with sock->sk being a
tcp_sk.  Update the existing fallback handling to detect this as well.

Moreover, mptcp_shutdown did not have fallback handling, and
mptcp_poll did it too late so add that there as well.

Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 50 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a3523bc0739b..72f3176dc924 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -57,10 +57,43 @@ static bool __mptcp_needs_tcp_fallback(const struct mpt=
cp_sock *msk)
 	return msk->first && !sk_is_mptcp(msk->first);
 }
 =

+static struct socket *mptcp_is_tcpsk(struct sock *sk)
+{
+	struct socket *sock =3D sk->sk_socket;
+
+	if (sock->sk !=3D sk)
+		return NULL;
+
+	if (unlikely(sk->sk_prot =3D=3D &tcp_prot)) {
+		/* we are being invoked after mptcp_accept() has
+		 * accepted a non-mp-capable flow: sk is a tcp_sk,
+		 * not an mptcp one.
+		 *
+		 * Hand the socket over to tcp so all further socket ops
+		 * bypass mptcp.
+		 */
+		sock->ops =3D &inet_stream_ops;
+		return sock;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	} else if (unlikely(sk->sk_prot =3D=3D &tcpv6_prot)) {
+		sock->ops =3D &inet6_stream_ops;
+		return sock;
+#endif
+	}
+
+	return NULL;
+}
+
 static struct socket *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
+	struct socket *sock;
+
 	sock_owned_by_me((const struct sock *)msk);
 =

+	sock =3D mptcp_is_tcpsk((struct sock *)msk);
+	if (unlikely(sock))
+		return sock;
+
 	if (likely(!__mptcp_needs_tcp_fallback(msk)))
 		return NULL;
 =

@@ -84,6 +117,10 @@ static struct socket *__mptcp_socket_create(struct mptc=
p_sock *msk, int state)
 	struct socket *ssock;
 	int err;
 =

+	ssock =3D __mptcp_tcp_fallback(msk);
+	if (unlikely(ssock))
+		return ssock;
+
 	ssock =3D __mptcp_nmpc_socket(msk);
 	if (ssock)
 		goto set_state;
@@ -1820,7 +1857,9 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 =

 	msk =3D mptcp_sk(sk);
 	lock_sock(sk);
-	ssock =3D __mptcp_nmpc_socket(msk);
+	ssock =3D __mptcp_tcp_fallback(msk);
+	if (!ssock)
+		ssock =3D __mptcp_nmpc_socket(msk);
 	if (ssock) {
 		mask =3D ssock->ops->poll(file, ssock, wait);
 		release_sock(sk);
@@ -1830,9 +1869,6 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 	release_sock(sk);
 	sock_poll_wait(file, sock, wait);
 	lock_sock(sk);
-	ssock =3D __mptcp_tcp_fallback(msk);
-	if (unlikely(ssock))
-		return ssock->ops->poll(file, ssock, NULL);
 =

 	if (test_bit(MPTCP_DATA_READY, &msk->flags))
 		mask =3D EPOLLIN | EPOLLRDNORM;
@@ -1851,11 +1887,17 @@ static int mptcp_shutdown(struct socket *sock, int =
how)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct mptcp_subflow_context *subflow;
+	struct socket *ssock;
 	int ret =3D 0;
 =

 	pr_debug("sk=3D%p, how=3D%d", msk, how);
 =

 	lock_sock(sock->sk);
+	ssock =3D __mptcp_tcp_fallback(msk);
+	if (ssock) {
+		release_sock(sock->sk);
+		return inet_shutdown(ssock, how);
+	}
 =

 	if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
 		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
-- =

2.24.1

--===============1004052076044537392==--
