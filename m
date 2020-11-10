Content-Type: multipart/mixed; boundary="===============5161916306839872538=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 5/6] mptcp: simplify mptcp_nospace
Date: Tue, 10 Nov 2020 12:25:47 +0100
Message-ID: <b392a121089613fe464242707816232d9161790a.1605006569.git.pabeni@redhat.com>
In-Reply-To: cover.1605006569.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6649

--===============5161916306839872538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently mptcp_space has to traverse the whole conn_list
setting the relevant bit on each subflow, because the client
ones will have a different sk_socket.

We can actually leave the NOSPACE always set on all client
subflow and make nospace simpler.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 15 +--------------
 net/mptcp/subflow.c  | 31 ++++++++++++++++++++++---------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ccf0ceaf5a1c..f016b5c11154 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1230,23 +1230,9 @@ static int mptcp_sendmsg_frag(struct sock *sk, struc=
t sock *ssk,
 =

 static void mptcp_nospace(struct mptcp_sock *msk)
 {
-	struct mptcp_subflow_context *subflow;
-
 	set_bit(MPTCP_NOSPACE, &msk->flags);
 	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */
 =

-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-		bool ssk_writeable =3D sk_stream_is_writeable(ssk);
-		struct socket *sock =3D READ_ONCE(ssk->sk_socket);
-
-		if (ssk_writeable || !sock)
-			continue;
-
-		/* enables ssk->write_space() callbacks */
-		set_bit(SOCK_NOSPACE, &sock->flags);
-	}
-
 	/* mptcp_data_acked() could run just before we set the NOSPACE bit,
 	 * so explicitly check for snd_una value
 	 */
@@ -3036,6 +3022,7 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 		slowpath =3D lock_sock_fast(newsk);
 		mptcp_copy_inaddrs(newsk, msk->first);
 		mptcp_rcv_space_init(msk, msk->first);
+		set_bit(SOCK_NOSPACE, &newsock->flags);
 =

 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 02d757e0ddb7..77cddbeaee1a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -996,19 +996,28 @@ static void subflow_data_ready(struct sock *sk)
 		mptcp_data_ready(parent, sk);
 }
 =

-static void subflow_write_space(struct sock *sk)
+static void subflow_write_space(struct sock *ssk)
 {
-	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-	struct socket *sock =3D READ_ONCE(sk->sk_socket);
-	struct sock *parent =3D subflow->conn;
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	struct sock *sk =3D subflow->conn;
+	struct socket_wq *wq;
 =

-	if (!sk_stream_is_writeable(sk))
+	if (!sk_stream_is_writeable(ssk) || !sk_stream_is_writeable(sk) ||
+	    !sk->sk_socket || !test_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
 		return;
 =

-	if (sock && sk_stream_is_writeable(parent))
-		clear_bit(SOCK_NOSPACE, &sock->flags);
-
-	sk_stream_write_space(parent);
+	/* The following is quite alike sk_stream_write_space, but avoids
+	 * clearing the sk SOCK_NOSPACE bit
+	 */
+	clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
+	rcu_read_lock();
+	wq =3D rcu_dereference(sk->sk_wq);
+	if (skwq_has_sleeper(wq))
+		wake_up_interruptible_poll(&wq->wait, EPOLLOUT |
+		                        EPOLLWRNORM | EPOLLWRBAND);
+	if (wq && wq->fasync_list && !(sk->sk_shutdown & SEND_SHUTDOWN))
+		sock_wake_async(wq, SOCK_WAKE_SPACE, POLL_OUT);
+	rcu_read_unlock();
 }
 =

 static struct inet_connection_sock_af_ops *
@@ -1208,6 +1217,10 @@ int mptcp_subflow_create_socket(struct sock *sk, str=
uct socket **new_sock)
 	SOCK_INODE(sf)->i_uid =3D SOCK_INODE(sk->sk_socket)->i_uid;
 	SOCK_INODE(sf)->i_gid =3D SOCK_INODE(sk->sk_socket)->i_gid;
 =

+	/* subflows will always call into sk_write_space, and subflow_write_space=
()
+	 * will be responsible of doing the actual wake-up
+	 */
+	set_bit(SOCK_NOSPACE, &sf->flags);
 	subflow =3D mptcp_subflow_ctx(sf->sk);
 	pr_debug("subflow=3D%p", subflow);
 =

-- =

2.26.2

--===============5161916306839872538==--
