Content-Type: multipart/mixed; boundary="===============3996054244608625419=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 7/7] make accept not allocate kernel socket struct
Date: Mon, 25 Nov 2019 03:15:08 +0100
Message-ID: <20191125021508.29153-8-fw@strlen.de>
In-Reply-To: 20191125021508.29153-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2679

--===============3996054244608625419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Once lower-level accept returns, walk the subflow list (there should
be one subflow) and make sk->sk_socket point to the new mptcp socket.

This is needed to make NOSPACE flag work: tcp stack can't signal
availability of new data unless ->sk_socket points to a "struct socket".

If sk_socket is NULL, then from TCP stack p.o.v.  the socket has been
detached from the userspace program already, so nothing to wake up in
first place.

mptcp_close needs to handle both cases: connect()ing sockets have a
'struct socket' allocated, while incoming ones do not.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 66 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 924e63b354ef..bd96d58beccc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -924,10 +924,17 @@ static void mptcp_close(struct sock *sk, long timeout)
 =

 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		struct socket *sock =3D READ_ONCE(ssk->sk_socket);
 =

 		pr_debug("conn_list->subflow=3D%p", subflow);
 		list_del(&subflow->node);
-		sock_release(ssk->sk_socket);
+
+		if (sock && sock !=3D sk->sk_socket) {
+			sock_release(sock);
+		} else {
+			sock_orphan(ssk);
+			tcp_close(ssk, timeout);
+		}
 	}
 =

 	__mptcp_clear_xmit(sk);
@@ -975,23 +982,22 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
-	struct socket *new_sock;
 	struct socket *listener;
 	struct sock *newsk;
 =

 	listener =3D msk->subflow;
 =

 	pr_debug("msk=3D%p, listener=3D%p", msk, mptcp_subflow_ctx(listener->sk));
-	*err =3D kernel_accept(listener, &new_sock, flags);
-	if (*err < 0)
+	newsk =3D inet_csk_accept(listener->sk, flags, err, kern);
+	if (!newsk)
 		return NULL;
 =

-	subflow =3D mptcp_subflow_ctx(new_sock->sk);
+	subflow =3D mptcp_subflow_ctx(newsk);
 	pr_debug("msk=3D%p, new subflow=3D%p, ", msk, subflow);
 =

 	if (subflow->mp_capable) {
-		struct sock *ssk =3D new_sock->sk;
 		struct sock *new_mptcp_sock;
+		struct sock *ssk =3D newsk;
 		u64 ack_seq;
 =

 		lock_sock(sk);
@@ -1002,8 +1008,8 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 			*err =3D -ENOBUFS;
 			local_bh_enable();
 			release_sock(sk);
-			kernel_sock_shutdown(new_sock, SHUT_RDWR);
-			sock_release(new_sock);
+			mptcp_subflow_shutdown(newsk, SHUT_RDWR + 1);
+			tcp_close(newsk, 0);
 			return NULL;
 		}
 =

@@ -1014,7 +1020,7 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
 =

-		mptcp_token_update_accept(new_sock->sk, new_mptcp_sock);
+		mptcp_token_update_accept(newsk, new_mptcp_sock);
 		msk->subflow =3D NULL;
 =

 		mptcp_pm_new_connection(msk, 1);
@@ -1047,10 +1053,7 @@ static struct sock *mptcp_accept(struct sock *sk, in=
t flags, int *err,
 			mptcp_subflow_data_available(ssk);
 		release_sock(ssk);
 	} else {
-		newsk =3D new_sock->sk;
 		tcp_sk(newsk)->is_mptcp =3D 0;
-		new_sock->sk =3D NULL;
-		sock_release(new_sock);
 =

 		MPTCP_INC_STATS(sock_net(sk),
 				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
@@ -1213,15 +1216,27 @@ void mptcp_finish_connect(struct sock *sk, int mp_c=
apable)
 	inet_sk_state_store(sk, TCP_ESTABLISHED);
 }
 =

+static void mptcp_sock_graft(struct sock *sk, struct socket *parent)
+{
+	write_lock_bh(&sk->sk_callback_lock);
+	rcu_assign_pointer(sk->sk_wq, &parent->wq);
+	sk_set_socket(sk, parent);
+	sk->sk_uid =3D SOCK_INODE(parent)->i_uid;
+	write_unlock_bh(&sk->sk_callback_lock);
+}
+
 void mptcp_finish_join(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+	struct sock *parent =3D (void *)msk;
 =

 	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
 =

 	local_bh_disable();
 	bh_lock_sock_nested(subflow->conn);
+	if (!sk->sk_socket)
+		mptcp_sock_graft(sk, parent->sk_socket);
 	list_add_tail(&subflow->node, &msk->conn_list);
 	bh_unlock_sock(subflow->conn);
 	local_bh_enable();
@@ -1393,6 +1408,8 @@ static int mptcp_v4_getname(struct socket *sock, stru=
ct sockaddr *uaddr,
 }
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static struct proto mptcp_v6_prot;
+
 static int mptcp_v6_getname(struct socket *sock, struct sockaddr *uaddr,
 			    int peer)
 {
@@ -1410,6 +1427,16 @@ static int mptcp_v6_getname(struct socket *sock, str=
uct sockaddr *uaddr,
 =

 	return mptcp_getname(sock, uaddr, peer, AF_INET6);
 }
+
+static bool is_mptcp_v6(const struct socket *sock)
+{
+	return sock->sk->sk_prot =3D=3D &mptcp_v6_prot;
+}
+#else
+static bool is_mptcp_v6(const struct socket *sock)
+{
+	return false;
+}
 #endif
 =

 static int mptcp_listen(struct socket *sock, int backlog)
@@ -1443,6 +1470,20 @@ static int mptcp_stream_accept(struct socket *sock, =
struct socket *newsock,
 		return -EINVAL;
 =

 	err =3D ssock->ops->accept(sock, newsock, flags, kern);
+	if (err =3D=3D 0 && (newsock->sk->sk_prot =3D=3D &mptcp_prot ||
+			 is_mptcp_v6(newsock))) {
+		struct mptcp_sock *msk =3D mptcp_sk(newsock->sk);
+		struct mptcp_subflow_context *subflow;
+
+		/* Hack: Need to set ssk->sk_socket of accept()ed flows to mptcp socket.=
 */
+		list_for_each_entry(subflow, &msk->conn_list, node) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+			if (!ssk->sk_socket)
+				mptcp_sock_graft(ssk, newsock);
+		}
+	}
+
 	sock_put(ssock->sk);
 	return err;
 }
@@ -1563,7 +1604,6 @@ void mptcp_proto_init(void)
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 static struct proto_ops mptcp_v6_stream_ops;
-static struct proto mptcp_v6_prot;
 =

 static void mptcp_v6_destroy(struct sock *sk)
 {
-- =

2.23.0

--===============3996054244608625419==--
