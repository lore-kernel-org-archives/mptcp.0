Content-Type: multipart/mixed; boundary="===============1493155754617325051=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 net-next 1/5] mptcp: always graft subflow socket to
 parent
Date: Wed, 20 Jan 2021 15:39:10 +0100
Message-ID: <88587573e1148883abc74c161c59836db808ed9b.1611153172.git.pabeni@redhat.com>
In-Reply-To: cover.1611153172.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7448

--===============1493155754617325051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, incoming subflows link to the parent socket,
while outgoing ones link to a per subflow socket. The latter
is not really needed, except at the initial connect() time and
for the first subflow.

Always graft the outgoing subflow to the parent socket and
free the unneeded ones early.

This allows some code cleanup, reduces the amount of memory
used and will simplify the next patch

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 36 ++++++++++--------------------------
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  3 +++
 3 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f998a077c7dd0..c5c80f9253832 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -114,11 +114,7 @@ static int __mptcp_socket_create(struct mptcp_sock *ms=
k)
 	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssock->sk);
 	subflow->request_mptcp =3D 1;
-
-	/* accept() will wait on first subflow sk_wq, and we always wakes up
-	 * via msk->sk_socket
-	 */
-	RCU_INIT_POINTER(msk->first->sk_wq, &sk->sk_socket->wq);
+	mptcp_sock_graft(msk->first, sk->sk_socket);
 =

 	return 0;
 }
@@ -2116,9 +2112,6 @@ static struct sock *mptcp_subflow_get_retrans(const s=
truct mptcp_sock *msk)
 void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		       struct mptcp_subflow_context *subflow)
 {
-	bool dispose_socket =3D false;
-	struct socket *sock;
-
 	list_del(&subflow->node);
 =

 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
@@ -2126,11 +2119,8 @@ void __mptcp_close_ssk(struct sock *sk, struct sock =
*ssk,
 	/* if we are invoked by the msk cleanup code, the subflow is
 	 * already orphaned
 	 */
-	sock =3D ssk->sk_socket;
-	if (sock) {
-		dispose_socket =3D sock !=3D sk->sk_socket;
+	if (ssk->sk_socket)
 		sock_orphan(ssk);
-	}
 =

 	subflow->disposable =3D 1;
 =

@@ -2148,8 +2138,6 @@ void __mptcp_close_ssk(struct sock *sk, struct sock *=
ssk,
 		__sock_put(ssk);
 	}
 	release_sock(ssk);
-	if (dispose_socket)
-		iput(SOCK_INODE(sock));
 =

 	sock_put(ssk);
 }
@@ -2536,6 +2524,12 @@ static void __mptcp_destroy_sock(struct sock *sk)
 =

 	pr_debug("msk=3D%p", msk);
 =

+	/* dispose the ancillatory tcp socket, if any */
+	if (msk->subflow) {
+		iput(SOCK_INODE(msk->subflow));
+		msk->subflow =3D NULL;
+	}
+
 	/* be sure to always acquire the join list lock, to sync vs
 	 * mptcp_finish_join().
 	 */
@@ -2586,20 +2580,10 @@ static void mptcp_close(struct sock *sk, long timeo=
ut)
 	inet_csk(sk)->icsk_mtup.probe_timestamp =3D tcp_jiffies32;
 	list_for_each_entry(subflow, &mptcp_sk(sk)->conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-		bool slow, dispose_socket;
-		struct socket *sock;
+		bool slow =3D lock_sock_fast(ssk);
 =

-		slow =3D lock_sock_fast(ssk);
-		sock =3D ssk->sk_socket;
-		dispose_socket =3D sock && sock !=3D sk->sk_socket;
 		sock_orphan(ssk);
 		unlock_sock_fast(ssk, slow);
-
-		/* for the outgoing subflows we additionally need to free
-		 * the associated socket
-		 */
-		if (dispose_socket)
-			iput(SOCK_INODE(sock));
 	}
 	sock_orphan(sk);
 =

@@ -3041,7 +3025,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	mptcp_rcv_space_init(msk, ssk);
 }
 =

-static void mptcp_sock_graft(struct sock *sk, struct socket *parent)
+void mptcp_sock_graft(struct sock *sk, struct socket *parent)
 {
 	write_lock_bh(&sk->sk_callback_lock);
 	rcu_assign_pointer(sk->sk_wq, &parent->wq);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d6400ad2d6156..65d200a1072bf 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -473,6 +473,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct soc=
k *ssk, int how);
 void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		       struct mptcp_subflow_context *subflow);
 void mptcp_subflow_reset(struct sock *ssk);
+void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 =

 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info =
*loc,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 278cbe3e539ea..22313710d7696 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1159,6 +1159,9 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
ruct mptcp_addr_info *loc,
 	if (err && err !=3D -EINPROGRESS)
 		goto failed_unlink;
 =

+	/* discard the subflow socket */
+	mptcp_sock_graft(ssk, sk->sk_socket);
+	iput(SOCK_INODE(sf));
 	return err;
 =

 failed_unlink:
-- =

2.26.2

--===============1493155754617325051==--
