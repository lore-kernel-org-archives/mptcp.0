Content-Type: multipart/mixed; boundary="===============0493385547338847690=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [mptcp-net 2/2] mptcp: better msk-level shutdown.
Date: Tue, 22 Dec 2020 10:26:51 +0100
Message-ID: <a8b08941cf38265af9ee0f7882d95b821bd20e13.1608628900.git.pabeni@redhat.com>
In-Reply-To: cover.1608628900.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7239

--===============0493385547338847690==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of re-implementing most of inet_shutdown, re-use
such helper, and implement the MPTCP-specific bits at the
'proto' level.

The msk-level disconnect() can now be invoked, lets provide a
suitable implementation.

As a side effect, this fixes bad state management for listener
sockets. The latter could lead to division by 0 oops since
commit ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling").

Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Fixes: ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 62 ++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 45 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7cdee23580bf..37511bf03171 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2644,11 +2644,12 @@ static void mptcp_copy_inaddrs(struct sock *msk, co=
nst struct sock *ssk)
 =

 static int mptcp_disconnect(struct sock *sk, int flags)
 {
-	/* Should never be called.
-	 * inet_stream_connect() calls ->disconnect, but that
-	 * refers to the subflow socket, not the mptcp one.
-	 */
-	WARN_ON_ONCE(1);
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	__mptcp_flush_join_list(msk);
+	mptcp_for_each_subflow(msk, subflow)
+		tcp_disconnect(mptcp_subflow_tcp_sock(subflow), flags);
 	return 0;
 }
 =

@@ -3093,6 +3094,14 @@ bool mptcp_finish_join(struct sock *ssk)
 	return true;
 }
 =

+static void mptcp_shutdown(struct sock *sk, int how)
+{
+	pr_debug("sk=3D%p, how=3D%d", sk, how);
+
+	if ((how & SEND_SHUTDOWN) && mptcp_close_state(sk))
+		__mptcp_wr_shutdown(sk);
+}
+
 static struct proto mptcp_prot =3D {
 	.name		=3D "MPTCP",
 	.owner		=3D THIS_MODULE,
@@ -3102,7 +3111,7 @@ static struct proto mptcp_prot =3D {
 	.accept		=3D mptcp_accept,
 	.setsockopt	=3D mptcp_setsockopt,
 	.getsockopt	=3D mptcp_getsockopt,
-	.shutdown	=3D tcp_shutdown,
+	.shutdown	=3D mptcp_shutdown,
 	.destroy	=3D mptcp_destroy,
 	.sendmsg	=3D mptcp_sendmsg,
 	.recvmsg	=3D mptcp_recvmsg,
@@ -3348,43 +3357,6 @@ static __poll_t mptcp_poll(struct file *file, struct=
 socket *sock,
 	return mask;
 }
 =

-static int mptcp_shutdown(struct socket *sock, int how)
-{
-	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
-	struct sock *sk =3D sock->sk;
-	int ret =3D 0;
-
-	pr_debug("sk=3D%p, how=3D%d", msk, how);
-
-	lock_sock(sk);
-
-	how++;
-	if ((how & ~SHUTDOWN_MASK) || !how) {
-		ret =3D -EINVAL;
-		goto out_unlock;
-	}
-
-	if (sock->state =3D=3D SS_CONNECTING) {
-		if ((1 << sk->sk_state) &
-		    (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_CLOSE))
-			sock->state =3D SS_DISCONNECTING;
-		else
-			sock->state =3D SS_CONNECTED;
-	}
-
-	sk->sk_shutdown |=3D how;
-	if ((how & SEND_SHUTDOWN) && mptcp_close_state(sk))
-		__mptcp_wr_shutdown(sk);
-
-	/* Wake up anyone sleeping in poll. */
-	sk->sk_state_change(sk);
-
-out_unlock:
-	release_sock(sk);
-
-	return ret;
-}
-
 static const struct proto_ops mptcp_stream_ops =3D {
 	.family		   =3D PF_INET,
 	.owner		   =3D THIS_MODULE,
@@ -3398,7 +3370,7 @@ static const struct proto_ops mptcp_stream_ops =3D {
 	.ioctl		   =3D inet_ioctl,
 	.gettstamp	   =3D sock_gettstamp,
 	.listen		   =3D mptcp_listen,
-	.shutdown	   =3D mptcp_shutdown,
+	.shutdown	   =3D inet_shutdown,
 	.setsockopt	   =3D sock_common_setsockopt,
 	.getsockopt	   =3D sock_common_getsockopt,
 	.sendmsg	   =3D inet_sendmsg,
@@ -3454,7 +3426,7 @@ static const struct proto_ops mptcp_v6_stream_ops =3D=
 {
 	.ioctl		   =3D inet6_ioctl,
 	.gettstamp	   =3D sock_gettstamp,
 	.listen		   =3D mptcp_listen,
-	.shutdown	   =3D mptcp_shutdown,
+	.shutdown	   =3D inet_shutdown,
 	.setsockopt	   =3D sock_common_setsockopt,
 	.getsockopt	   =3D sock_common_getsockopt,
 	.sendmsg	   =3D inet6_sendmsg,
-- =

2.26.2

--===============0493385547338847690==--
