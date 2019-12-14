Content-Type: multipart/mixed; boundary="===============7256580001580617446=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 07/15] mptcp: Add shutdown() socket operation
Date: Fri, 13 Dec 2019 22:04:09 -0800
Message-ID: <20191214060417.2870-8-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191214060417.2870-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3053

--===============7256580001580617446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)linux.intel.com>

Call shutdown on all subflows in use on the given socket, or on the
fallback socket.

Co-developed-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 66 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 19b1250bb8cc..6298e1d0008b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -194,6 +194,29 @@ static int mptcp_init_sock(struct sock *sk)
 	return 0;
 }
 =

+static void mptcp_subflow_shutdown(struct sock *ssk, int how)
+{
+	lock_sock(ssk);
+
+	switch (ssk->sk_state) {
+	case TCP_LISTEN:
+		if (!(how & RCV_SHUTDOWN))
+			break;
+		/* fall through */
+	case TCP_SYN_SENT:
+		tcp_disconnect(ssk, O_NONBLOCK);
+		break;
+	default:
+		ssk->sk_shutdown |=3D how;
+		tcp_shutdown(ssk, how);
+		break;
+	}
+
+	/* Wake up anyone sleeping in poll. */
+	ssk->sk_state_change(ssk);
+	release_sock(ssk);
+}
+
 static void mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
@@ -271,6 +294,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 			*err =3D -ENOBUFS;
 			local_bh_enable();
 			release_sock(sk);
+			mptcp_subflow_shutdown(newsk, SHUT_RDWR + 1);
 			tcp_close(newsk, 0);
 			return NULL;
 		}
@@ -544,6 +568,46 @@ static __poll_t mptcp_poll(struct file *file, struct s=
ocket *sock,
 	return mask;
 }
 =

+static int mptcp_shutdown(struct socket *sock, int how)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct mptcp_subflow_context *subflow;
+	int ret =3D 0;
+
+	pr_debug("sk=3D%p, how=3D%d", msk, how);
+
+	lock_sock(sock->sk);
+
+	if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
+		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
+
+	how++;
+
+	if ((how & ~SHUTDOWN_MASK) || !how) {
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	if (sock->state =3D=3D SS_CONNECTING) {
+		if ((1 << sock->sk->sk_state) &
+		    (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_CLOSE))
+			sock->state =3D SS_DISCONNECTING;
+		else
+			sock->state =3D SS_CONNECTED;
+	}
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
+
+		mptcp_subflow_shutdown(tcp_sk, how);
+	}
+
+out_unlock:
+	release_sock(sock->sk);
+
+	return ret;
+}
+
 static struct proto_ops mptcp_stream_ops;
 =

 static struct inet_protosw mptcp_protosw =3D {
@@ -564,6 +628,7 @@ void __init mptcp_init(void)
 	mptcp_stream_ops.accept =3D mptcp_stream_accept;
 	mptcp_stream_ops.getname =3D mptcp_v4_getname;
 	mptcp_stream_ops.listen =3D mptcp_listen;
+	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
 =

 	mptcp_subflow_init();
 =

@@ -613,6 +678,7 @@ int mptcpv6_init(void)
 	mptcp_v6_stream_ops.accept =3D mptcp_stream_accept;
 	mptcp_v6_stream_ops.getname =3D mptcp_v6_getname;
 	mptcp_v6_stream_ops.listen =3D mptcp_listen;
+	mptcp_v6_stream_ops.shutdown =3D mptcp_shutdown;
 =

 	err =3D inet6_register_protosw(&mptcp_v6_protosw);
 	if (err)
-- =

2.24.1

--===============7256580001580617446==--
