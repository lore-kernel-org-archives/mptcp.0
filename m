Content-Type: multipart/mixed; boundary="===============8668192049428182622=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 4/4] mptcp: avoid acquiring the msk lock in
 mptcp_finisch_connect()
Date: Tue, 10 Dec 2019 19:00:59 +0100
Message-ID: <bfaef67f2a4780c23b448ebd4bc77ae0fb3bbdea.1575999260.git.pabeni@redhat.com>
In-Reply-To: cover.1575999260.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2865

--===============8668192049428182622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move the mptcp_copy_inaddrs() into mptcp_finish_connect(), so that
the mks lock is no longer required. Just document the unlocked access
with WRITE_ONCE().

Since we now always acquire msk -> ssk lock in order, we can also
avoid the msk lock/subflow lookup()/get()/ msk unlock()/ subflow op/ subflo=
w put
dance in most ops - simply keep the msk lock held the whole time.

Additionally we can simplify mptcp_getname(), as now the address information
are always available in the msk.

v1  -> v2:
 - moved status change to the end of mptcp_stream_accept() - Florian

RFC -> v1:
 - move mptcp_copy_inaddrs() into finish_connect()

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 234 ++++++++++++++++---------------------------
 1 file changed, 86 insertions(+), 148 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 41c2e18c1321..3eb736aba6df 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -38,10 +38,10 @@ static struct socket *__mptcp_nmpc_socket(const struct =
mptcp_sock *msk)
 }
 =

 /* if msk has a single subflow, and the mp_capable handshake is failed,
- * get a reference and return it.
+ * return it.
  * Otherwise returns NULL
  */
-static struct socket *__mptcp_tcp_fallback_get(const struct mptcp_sock *ms=
k)
+static struct socket *__mptcp_tcp_fallback(const struct mptcp_sock *msk)
 {
 	struct socket *ssock =3D __mptcp_nmpc_socket(msk);
 =

@@ -50,7 +50,6 @@ static struct socket *__mptcp_tcp_fallback_get(const stru=
ct mptcp_sock *msk)
 	if (!ssock || tcp_sk(ssock->sk)->is_mptcp)
 		return NULL;
 =

-	sock_hold(ssock->sk);
 	return ssock;
 }
 =

@@ -72,28 +71,23 @@ static bool __mptcp_can_create_subflow(const struct mpt=
cp_sock *msk)
 	return ((struct sock *)msk)->sk_state =3D=3D TCP_CLOSE;
 }
 =

-static struct socket *mptcp_socket_create_get(struct mptcp_sock *msk, int =
state)
+static struct socket *__mptcp_socket_create(struct mptcp_sock *msk, int st=
ate)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk =3D (struct sock *)msk;
 	struct socket *ssock;
 	int err;
 =

-	lock_sock(sk);
 	ssock =3D __mptcp_nmpc_socket(msk);
 	if (ssock)
 		goto set_state;
 =

-	if (!__mptcp_can_create_subflow(msk)) {
-		ssock =3D ERR_PTR(-EINVAL);
-		goto release;
-	}
+	if (!__mptcp_can_create_subflow(msk))
+		return ERR_PTR(-EINVAL);
 =

 	err =3D mptcp_subflow_create_socket(sk, &ssock);
-	if (err) {
-		ssock =3D ERR_PTR(err);
-		goto release;
-	}
+	if (err)
+		return ERR_PTR(err);
 =

 	msk->subflow =3D ssock;
 	subflow =3D mptcp_subflow_ctx(ssock->sk);
@@ -102,12 +96,8 @@ static struct socket *mptcp_socket_create_get(struct mp=
tcp_sock *msk, int state)
 	subflow->request_version =3D 1; /* only v1 supported */
 =

 set_state:
-	sock_hold(ssock->sk);
 	if (state !=3D MPTCP_SAME_STATE)
 		inet_sk_state_store(sk, state);
-
-release:
-	release_sock(sk);
 	return ssock;
 }
 =

@@ -275,12 +265,11 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		return -EOPNOTSUPP;
 =

 	lock_sock(sk);
-	ssock =3D __mptcp_tcp_fallback_get(msk);
+	ssock =3D __mptcp_tcp_fallback(msk);
 	if (ssock) {
-		release_sock(sk);
 		pr_debug("fallback passthrough");
 		ret =3D sock_sendmsg(ssock, msg);
-		sock_put(ssock->sk);
+		release_sock(sk);
 		return ret;
 	}
 =

@@ -378,13 +367,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 	long timeo;
 =

 	lock_sock(sk);
-	ssock =3D __mptcp_tcp_fallback_get(msk);
+	ssock =3D __mptcp_tcp_fallback(msk);
 	if (ssock) {
-		release_sock(sk);
 		pr_debug("fallback-read subflow=3D%p",
 			 mptcp_subflow_ctx(ssock->sk));
 		copied =3D sock_recvmsg(ssock, msg, flags);
-		sock_put(ssock->sk);
+		release_sock(sk);
 		return copied;
 	}
 =

@@ -681,7 +669,6 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		list_add(&subflow->node, &msk->conn_list);
 		bh_unlock_sock(new_mptcp_sock);
 		local_bh_enable();
-		inet_sk_state_store(newsk, TCP_ESTABLISHED);
 		release_sock(sk);
 =

 		/* the subflow can already receive packet, avoid racing with
@@ -710,25 +697,26 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	char __kernel *optval;
+	int ret =3D -EOPNOTSUPP;
 	struct socket *ssock;
-	int ret;
 =

 	/* will be treated as __user in tcp_setsockopt */
 	optval =3D (char __kernel __force *)uoptval;
 =

 	pr_debug("msk=3D%p", msk);
-	ssock =3D mptcp_socket_create_get(msk, MPTCP_SAME_STATE);
+
+	/* @@ the meaning of setsockopt() when the socket is connected and
+	 * there are multiple subflows is not defined.
+	 */
+	lock_sock(sk);
+	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
 	if (!IS_ERR(ssock)) {
 		pr_debug("subflow=3D%p", ssock->sk);
 		ret =3D kernel_setsockopt(ssock, level, optname, optval, optlen);
-		sock_put(ssock->sk);
-		return ret;
 	}
+	release_sock(sk);
 =

-	/* @@ the meaning of setsockopt() when the socket is connected and
-	 * there are multiple subflows is not defined.
-	 */
-	return -EOPNOTSUPP;
+	return ret;
 }
 =

 static int mptcp_getsockopt(struct sock *sk, int level, int optname,
@@ -736,27 +724,28 @@ static int mptcp_getsockopt(struct sock *sk, int leve=
l, int optname,
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	char __kernel *optval;
+	int ret =3D -EOPNOTSUPP;
 	int __kernel *option;
 	struct socket *ssock;
-	int ret;
 =

 	/* will be treated as __user in tcp_getsockopt */
 	optval =3D (char __kernel __force *)uoptval;
 	option =3D (int __kernel __force *)uoption;
 =

 	pr_debug("msk=3D%p", msk);
-	ssock =3D mptcp_socket_create_get(msk, MPTCP_SAME_STATE);
+
+	/* @@ the meaning of getsockopt() when the socket is connected and
+	 * there are multiple subflows is not defined.
+	 */
+	lock_sock(sk);
+	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
 	if (!IS_ERR(ssock)) {
 		pr_debug("subflow=3D%p", ssock->sk);
 		ret =3D kernel_getsockopt(ssock, level, optname, optval, option);
-		sock_put(ssock->sk);
-		return ret;
 	}
+	release_sock(sk);
 =

-	/* @@ the meaning of getsockopt() when the socket is connected and
-	 * there are multiple subflows is not defined.
-	 */
-	return -EOPNOTSUPP;
+	return ret;
 }
 =

 static int mptcp_get_port(struct sock *sk, unsigned short snum)
@@ -775,57 +764,34 @@ static int mptcp_get_port(struct sock *sk, unsigned s=
hort snum)
 void mptcp_finish_connect(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk;
 	struct sock *sk;
+	u64 ack_seq;
 =

 	subflow =3D mptcp_subflow_ctx(ssk);
-	sk =3D subflow->conn;
-
-	if (subflow->mp_capable) {
-		struct mptcp_sock *msk =3D mptcp_sk(sk);
-		u64 ack_seq;
+	if (!subflow->mp_capable)
+		return;
 =

-		/* sk (new subflow socket) is already locked, but we need
-		 * to lock the parent (mptcp) socket now to add the tcp socket
-		 * to the subflow list.
-		 *
-		 * From lockdep point of view, this creates an ABBA type
-		 * deadlock: Normally (sendmsg, recvmsg, ..), we lock the mptcp
-		 * socket, then acquire a subflow lock.
-		 * Here we do the reverse: "subflow lock, then mptcp lock".
-		 *
-		 * Its alright to do this here, because this subflow is not yet
-		 * on the mptcp sockets subflow list.
-		 *
-		 * IOW, if another CPU has this mptcp socket locked, it cannot
-		 * acquire this particular subflow, because subflow->sk isn't
-		 * on msk->conn_list.
-		 *
-		 * This function can be called either from backlog processing
-		 * (BH will be enabled) or from softirq, so we need to use BH
-		 * locking scheme.
-		 */
-		local_bh_disable();
-		bh_lock_sock_nested(sk);
+	sk =3D subflow->conn;
+	msk =3D mptcp_sk(sk);
 =

-		msk->remote_key =3D subflow->remote_key;
-		msk->local_key =3D subflow->local_key;
-		msk->token =3D subflow->token;
-		mptcp_copy_inaddrs(sk, ssk);
+	pr_debug("msk=3D%p, token=3D%u", sk, subflow->token);
 =

-		pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
+	mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
+	ack_seq++;
+	subflow->map_seq =3D ack_seq;
+	subflow->map_subflow_seq =3D 1;
+	subflow->rel_write_seq =3D 1;
 =

-		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
-		msk->write_seq =3D subflow->idsn + 1;
-		ack_seq++;
-		msk->ack_seq =3D ack_seq;
-		msk->can_ack =3D 1;
-		subflow->map_seq =3D ack_seq;
-		subflow->map_subflow_seq =3D 1;
-		subflow->rel_write_seq =3D 1;
-		bh_unlock_sock(sk);
-		local_bh_enable();
-	}
-	inet_sk_state_store(sk, TCP_ESTABLISHED);
+	/* the socket is not connected yet, no msk/subflow ops can access/race
+	 * accessing the field below
+	 */
+	WRITE_ONCE(msk->remote_key, subflow->remote_key);
+	WRITE_ONCE(msk->local_key, subflow->local_key);
+	WRITE_ONCE(msk->token, subflow->token);
+	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
+	WRITE_ONCE(msk->ack_seq, ack_seq);
+	WRITE_ONCE(msk->can_ack, 1);
 }
 =

 static void mptcp_sock_graft(struct sock *sk, struct socket *parent)
@@ -870,12 +836,19 @@ static int mptcp_bind(struct socket *sock, struct soc=
kaddr *uaddr, int addr_len)
 	struct socket *ssock;
 	int err;
 =

-	ssock =3D mptcp_socket_create_get(msk, MPTCP_SAME_STATE);
-	if (IS_ERR(ssock))
-		return PTR_ERR(ssock);
+	lock_sock(sock->sk);
+	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
+	if (IS_ERR(ssock)) {
+		err =3D PTR_ERR(ssock);
+		goto unlock;
+	}
 =

 	err =3D ssock->ops->bind(ssock, uaddr, addr_len);
-	sock_put(ssock->sk);
+	if (!err)
+		mptcp_copy_inaddrs(sock->sk, ssock->sk);
+
+unlock:
+	release_sock(sock->sk);
 	return err;
 }
 =

@@ -886,9 +859,12 @@ static int mptcp_stream_connect(struct socket *sock, s=
truct sockaddr *uaddr,
 	struct socket *ssock;
 	int err;
 =

-	ssock =3D mptcp_socket_create_get(msk, TCP_SYN_SENT);
-	if (IS_ERR(ssock))
-		return PTR_ERR(ssock);
+	lock_sock(sock->sk);
+	ssock =3D __mptcp_socket_create(msk, TCP_SYN_SENT);
+	if (IS_ERR(ssock)) {
+		err =3D PTR_ERR(ssock);
+		goto unlock;
+	}
 =

 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -900,44 +876,11 @@ static int mptcp_stream_connect(struct socket *sock, =
struct sockaddr *uaddr,
 =

 	err =3D ssock->ops->connect(ssock, uaddr, addr_len, flags);
 	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
-	sock_put(ssock->sk);
-	return err;
-}
-
-static int mptcp_getname(struct socket *sock, struct sockaddr *uaddr,
-			 int peer, int af)
-{
-	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
-	struct socket *ssock;
-	int ret;
+	mptcp_copy_inaddrs(sock->sk, ssock->sk);
 =

-	lock_sock(sock->sk);
-	ssock =3D __mptcp_nmpc_socket(msk);
-	if (ssock)
-		sock_hold(ssock->sk);
+unlock:
 	release_sock(sock->sk);
-	if (ssock) {
-		pr_debug("subflow=3D%p", ssock->sk);
-		ret =3D ssock->ops->getname(ssock, uaddr, peer);
-		sock_put(ssock->sk);
-		return ret;
-	}
-
-	switch (af) {
-	case AF_INET:
-		ret =3D inet_getname(sock, uaddr, peer);
-		break;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	case AF_INET6:
-		ret =3D inet6_getname(sock, uaddr, peer);
-		break;
-#endif
-	default:
-		ret =3D -ENOPROTOOPT;
-		WARN_ON_ONCE(1);
-	}
-
-	return ret;
+	return err;
 }
 =

 static int mptcp_v4_getname(struct socket *sock, struct sockaddr *uaddr,
@@ -952,10 +895,9 @@ static int mptcp_v4_getname(struct socket *sock, struc=
t sockaddr *uaddr,
 		 * bypass mptcp.
 		 */
 		sock->ops =3D &inet_stream_ops;
-		return sock->ops->getname(sock, uaddr, peer);
 	}
 =

-	return mptcp_getname(sock, uaddr, peer, AF_INET);
+	return inet_getname(sock, uaddr, peer);
 }
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -971,10 +913,9 @@ static int mptcp_v6_getname(struct socket *sock, struc=
t sockaddr *uaddr,
 		 * socket ops bypass mptcp.
 		 */
 		sock->ops =3D &inet6_stream_ops;
-		return sock->ops->getname(sock, uaddr, peer);
 	}
 =

-	return mptcp_getname(sock, uaddr, peer, AF_INET6);
+	return inet6_getname(sock, uaddr, peer);
 }
 #endif
 =

@@ -986,13 +927,20 @@ static int mptcp_listen(struct socket *sock, int back=
log)
 =

 	pr_debug("msk=3D%p", msk);
 =

-	ssock =3D mptcp_socket_create_get(msk, TCP_LISTEN);
-	if (IS_ERR(ssock))
-		return PTR_ERR(ssock);
+	lock_sock(sock->sk);
+	ssock =3D __mptcp_socket_create(msk, TCP_LISTEN);
+	if (IS_ERR(ssock)) {
+		err =3D PTR_ERR(ssock);
+		goto unlock;
+	}
 =

 	err =3D ssock->ops->listen(ssock, backlog);
 	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
-	sock_put(ssock->sk);
+	if (!err)
+		mptcp_copy_inaddrs(sock->sk, ssock->sk);
+
+unlock:
+	release_sock(sock->sk);
 	return err;
 }
 =

@@ -1039,6 +987,8 @@ static int mptcp_stream_accept(struct socket *sock, st=
ruct socket *newsock,
 			if (!ssk->sk_socket)
 				mptcp_sock_graft(ssk, newsock);
 		}
+
+		inet_sk_state_store(newsock->sk, TCP_ESTABLISHED);
 	}
 =

 	sock_put(ssock->sk);
@@ -1061,10 +1011,8 @@ static __poll_t mptcp_poll(struct file *file, struct=
 socket *sock,
 	lock_sock(sk);
 	ssock =3D __mptcp_nmpc_socket(msk);
 	if (ssock) {
-		sock_hold(ssock->sk);
-		release_sock(sk);
 		mask =3D ssock->ops->poll(file, ssock, wait);
-		sock_put(ssock->sk);
+		release_sock(sk);
 		return mask;
 	}
 =

@@ -1088,7 +1036,6 @@ static int mptcp_shutdown(struct socket *sock, int ho=
w)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct mptcp_subflow_context *subflow;
-	struct socket *ssock;
 	int ret =3D 0;
 =

 	pr_debug("sk=3D%p, how=3D%d", msk, how);
@@ -1098,15 +1045,6 @@ static int mptcp_shutdown(struct socket *sock, int h=
ow)
 	if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
 		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
 =

-	ssock =3D __mptcp_tcp_fallback_get(msk);
-	if (ssock) {
-		release_sock(sock->sk);
-		pr_debug("subflow=3D%p", ssock->sk);
-		ret =3D kernel_sock_shutdown(ssock, how);
-		sock_put(ssock->sk);
-		return ret;
-	}
-
 	how++;
 =

 	if ((how & ~SHUTDOWN_MASK) || !how) {
-- =

2.21.0

--===============8668192049428182622==--
