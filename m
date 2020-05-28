Content-Type: multipart/mixed; boundary="===============6344393337206287794=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix unblocking connect()
Date: Thu, 28 May 2020 13:20:03 +0200
Message-ID: <a8487a6ea16e12c26367004317165af41b75db56.1590662723.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4521

--===============6344393337206287794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently unblocking connect() on MPTCP sockets fails frequently.
If mptcp_stream_connect() is invoked to complete a previously
attempted unblocking connection, it will still try to create
the first subflow via __mptcp_socket_create(). If the 3whs is
completed and the 'can_ack' flag is already set, the latter
will fail with -EINVAL.

This change addresses the issue checking for pending connect and
delegating the completion to the first subflow. Additionally
do msk addresses and sk_state changes only when needed.

Fixes: 2303f994b3e1 ("mptcp: Associate MPTCP context with TCP socket")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
Note: this addresses:
 https://github.com/multipath-tcp/mptcp_net-next/issues/27
but do not care about connect()/disconnect()/connect() cycles
(which are also currently broken, likely we would need a separate
issue to tracking the latter)
---
 net/mptcp/protocol.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5f036a2c2940..7716c07b46f0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1773,6 +1773,14 @@ static int mptcp_stream_connect(struct socket *sock,=
 struct sockaddr *uaddr,
 	int err;
 =

 	lock_sock(sock->sk);
+	if (sock->state !=3D SS_UNCONNECTED && msk->subflow) {
+		/* pending connection or invalid state, let existing subflow
+		 * cope with that
+		 */
+		ssock =3D msk->subflow;
+		goto do_connect;
+	}
+
 	ssock =3D __mptcp_socket_create(msk, TCP_SYN_SENT);
 	if (IS_ERR(ssock)) {
 		err =3D PTR_ERR(ssock);
@@ -1787,9 +1795,17 @@ static int mptcp_stream_connect(struct socket *sock,=
 struct sockaddr *uaddr,
 		mptcp_subflow_ctx(ssock->sk)->request_mptcp =3D 0;
 #endif
 =

+do_connect:
 	err =3D ssock->ops->connect(ssock, uaddr, addr_len, flags);
-	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
-	mptcp_copy_inaddrs(sock->sk, ssock->sk);
+	sock->state =3D ssock->state;
+
+	/* on successful connect, the msk state will be moved to established by
+	 * subflow_finish_connect()
+	 */
+	if (!err || err =3D=3D EINPROGRESS)
+		mptcp_copy_inaddrs(sock->sk, ssock->sk);
+	else
+		inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
 =

 unlock:
 	release_sock(sock->sk);
-- =

2.21.3

--===============6344393337206287794==--
