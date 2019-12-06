Content-Type: multipart/mixed; boundary="===============8220490880763681041=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 5/5] mptcp: avoid acquiring the msk lock in
 mptcp_finisch_connect()
Date: Fri, 06 Dec 2019 13:22:47 +0100
Message-ID: <b0076fb69854694ac48b5e10927859aa9e20104f.1575634848.git.pabeni@redhat.com>
In-Reply-To: cover.1575634848.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2816

--===============8220490880763681041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No longer required, just document the unlocked access with WRITE_ONCE()
Since we now always acquire msk -> ssk lock in order, we can also
avoid the msk lock/subflow lookup()/get()/ msk unlock()/ subflow op/ subflo=
w put
dance in most ops - simply keep the msk lock held the whole time.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 181 ++++++++++++++++++-------------------------
 1 file changed, 75 insertions(+), 106 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6ec4aed0338e..c9a729643c0b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -55,10 +55,10 @@ static struct socket *__mptcp_first_socket(const struct=
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
 	struct socket *ssock;
 =

@@ -69,7 +69,6 @@ static struct socket *__mptcp_tcp_fallback_get(const stru=
ct mptcp_sock *msk)
 	if (tcp_sk(ssock->sk)->is_mptcp)
 		return NULL;
 =

-	sock_hold(ssock->sk);
 	return ssock;
 }
 =

@@ -93,28 +92,23 @@ static bool __mptcp_can_create_subflow(const struct mpt=
cp_sock *msk)
 	return state =3D=3D TCP_CLOSE || state =3D=3D TCP_LISTEN;
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

 	subflow =3D mptcp_subflow_ctx(ssock->sk);
 	list_add(&subflow->node, &msk->conn_list);
@@ -122,12 +116,8 @@ static struct socket *mptcp_socket_create_get(struct m=
ptcp_sock *msk, int state)
 	subflow->request_version =3D 1; /* only v1 supported */
 =

 set_state:
-	sock_hold(ssock->sk);
 	if (state !=3D TCP_MAX_STATES)
 		inet_sk_state_store(sk, state);
-
-release:
-	release_sock(sk);
 	return ssock;
 }
 =

@@ -287,12 +277,11 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
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

@@ -394,13 +383,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
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

@@ -645,25 +633,26 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
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
-	ssock =3D mptcp_socket_create_get(msk, TCP_MAX_STATES);
+
+	/* @@ the meaning of setsockopt() when the socket is connected and
+	 * there are multiple subflows is not defined.
+	 */
+	lock_sock(sk);
+	ssock =3D __mptcp_socket_create(msk, TCP_MAX_STATES);
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
@@ -671,27 +660,28 @@ static int mptcp_getsockopt(struct sock *sk, int leve=
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
-	ssock =3D mptcp_socket_create_get(msk, TCP_MAX_STATES);
+	lock_sock(sk);
+
+	/* @@ the meaning of getsockopt() when the socket is connected and
+	 * there are multiple subflows is not defined.
+	 */
+	ssock =3D __mptcp_socket_create(msk, TCP_MAX_STATES);
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
@@ -711,51 +701,27 @@ void mptcp_finish_connect(struct sock *sk,
 			  struct mptcp_subflow_context *subflow)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	u64 ack_seq;
 =

-	if (subflow->mp_capable) {
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
+	pr_debug("msk=3D%p, token=3D%u", msk, subflow->token);
+	mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
+	ack_seq++;
+	subflow->map_seq =3D ack_seq;
+	subflow->map_subflow_seq =3D 1;
+	subflow->rel_write_seq =3D 1;
 =

-		msk->remote_key =3D subflow->remote_key;
-		msk->local_key =3D subflow->local_key;
-		msk->token =3D subflow->token;
-
-		pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
-
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

 static struct proto mptcp_prot =3D {
@@ -783,12 +749,17 @@ static int mptcp_bind(struct socket *sock, struct soc=
kaddr *uaddr, int addr_len)
 	struct socket *ssock;
 	int err;
 =

-	ssock =3D mptcp_socket_create_get(msk, TCP_MAX_STATES);
-	if (IS_ERR(ssock))
-		return PTR_ERR(ssock);
+	lock_sock(sock->sk);
+	ssock =3D __mptcp_socket_create(msk, TCP_MAX_STATES);
+	if (IS_ERR(ssock)) {
+		err =3D PTR_ERR(ssock);
+		goto unlock;
+	}
 =

 	err =3D ssock->ops->bind(ssock, uaddr, addr_len);
-	sock_put(ssock->sk);
+
+unlock:
+	release_sock(sock->sk);
 	return err;
 }
 =

@@ -799,9 +770,12 @@ static int mptcp_stream_connect(struct socket *sock, s=
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
@@ -816,7 +790,9 @@ static int mptcp_stream_connect(struct socket *sock, st=
ruct sockaddr *uaddr,
 	/* should we keep msk socket lock instead? and release it this
 	 * latter state update */
 	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
-	sock_put(ssock->sk);
+
+unlock:
+	release_sock(sock->sk);
 	return err;
 }
 =

@@ -897,16 +873,21 @@ static int mptcp_listen(struct socket *sock, int back=
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
 =

 	/* should we keep msk socket lock instead? and release it this
 	 * latter state update */
 	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
-	sock_put(ssock->sk);
+
+unlock:
+	release_sock(sock->sk);
 	return err;
 }
 =

@@ -952,10 +933,8 @@ static __poll_t mptcp_poll(struct file *file, struct s=
ocket *sock,
 	lock_sock(sk);
 	ssock =3D __mptcp_nmpc_socket(msk);
 	if (ssock) {
-		sock_hold(ssock->sk);
-		release_sock(sk);
 		ret =3D ssock->ops->poll(file, ssock, wait);
-		sock_put(ssock->sk);
+		release_sock(sk);
 		return ret;
 	}
 =

@@ -978,7 +957,6 @@ static int mptcp_shutdown(struct socket *sock, int how)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct mptcp_subflow_context *subflow;
-	struct socket *ssock;
 	int ret =3D 0;
 =

 	pr_debug("sk=3D%p, how=3D%d", msk, how);
@@ -988,15 +966,6 @@ static int mptcp_shutdown(struct socket *sock, int how)
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
 	mptcp_for_each_subflow(msk, subflow) {
 		struct socket *tcp_socket;
 =

-- =

2.21.0

--===============8220490880763681041==--
