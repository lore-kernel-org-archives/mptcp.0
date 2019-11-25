Content-Type: multipart/mixed; boundary="===============8601488330730783731=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 6/7] add mptcp_subflow_shutdown
Date: Mon, 25 Nov 2019 03:15:07 +0100
Message-ID: <20191125021508.29153-7-fw@strlen.de>
In-Reply-To: 20191125021508.29153-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2678

--===============8601488330730783731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

soon tcp_sk->sk_socket may be pointing at the parent mptcp socket.
Add a private shutdown function and use it instead.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 68ae6796359f..924e63b354ef 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -884,6 +884,29 @@ static void mptcp_cancel_work(struct sock *sk)
 		sock_put(sk);
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
@@ -1477,11 +1500,28 @@ static int mptcp_shutdown(struct socket *sock, int =
how)
 		return ret;
 	}
 =

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
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
 =

-		ret =3D kernel_sock_shutdown(tcp_sk->sk_socket, how);
+		mptcp_subflow_shutdown(tcp_sk, how);
 	}
+
+out_unlock:
 	release_sock(sock->sk);
 =

 	return ret;
-- =

2.23.0

--===============8601488330730783731==--
