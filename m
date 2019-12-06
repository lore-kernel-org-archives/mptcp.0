Content-Type: multipart/mixed; boundary="===============2251919304344911281=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 3/5] mptcp: cleanup fallback handling
Date: Fri, 06 Dec 2019 13:22:45 +0100
Message-ID: <983c7e217b928ac6bead1016fc71558d604149cb.1575634848.git.pabeni@redhat.com>
In-Reply-To: cover.1575634848.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2813

--===============2251919304344911281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 'fallback' field has many different meanings:
tcp fallback socket, first subflow, listening socket.
Enforcing the correct usage is not easy - currently we have
several problems:

1) this will fail, but it should not:
fd =3D socket(AF_INET{,6}, SOCK_STREAM, MPTCP_PROTO);
setsockopt(fd, SOL_IP{,V6}, //...) =3D -1 EOPNOTSUPP (Operation not support=
ed)

2) this will report success, but it should not:
fd =3D socket(AF_INET{,6}, SOCK_STREAM, MPTCP_PROTO);
connect(fd, //)
bind(fd, //) =3D 0

3) this will report success, but it should not:
fd =3D socket(AF_INET{,6}, SOCK_STREAM, MPTCP_PROTO);
listen(fd, // )
s =3D accept(fd, )
bind(s, ...) =3D 0

This patch:

- explicitly handle the msk socket status in some missing places
- wrap msk->subflow access with helpers describing the expected
  semantic
- use the above to enforce correct syscall behavior
- create on demand the subflow socket for setsockopt(), if possible

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 192 +++++++++++++++++++++++++++----------------
 1 file changed, 123 insertions(+), 69 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 71c8f00a1e37..069aeda69a19 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -22,26 +22,48 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

-static struct socket *__mptcp_fallback_get_ref(const struct mptcp_sock *ms=
k)
+/* if msk has a single subflow socket, and the mp_capable handshake is not
+ * completed yet or has failed - that is, the socket is Not MP Capable,
+ * returns it.
+ * Otherwise returns NULL
+ */
+static struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
 {
 	sock_owned_by_me((const struct sock *)msk);
 =

 	if (!msk->subflow)
 		return NULL;
 =

-	sock_hold(msk->subflow->sk);
 	return msk->subflow;
 }
 =

-static struct socket *mptcp_fallback_get_ref(const struct mptcp_sock *msk)
+/* get a reference to the first subflow socket and returns it */
+static struct socket *__mptcp_first_socket(const struct mptcp_sock *msk)
 {
-	struct socket *ssock;
+	struct socket *ssock =3D __mptcp_nmpc_socket(msk);
+	struct mptcp_subflow_context *subflow;
 =

-	lock_sock((struct sock *)msk);
-	ssock =3D __mptcp_fallback_get_ref(msk);
-	release_sock((struct sock *)msk);
+	if (ssock)
+		return ssock;
+	if (list_empty(&msk->conn_list))
+		return NULL;
 =

-	return ssock;
+	subflow =3D list_first_entry(&msk->conn_list,
+				   struct mptcp_subflow_context, node);
+	return mptcp_subflow_tcp_socket(subflow);
+}
+
+/* if msk has a single subflow, and the mp_capable handshake is failed,
+ * get a reference and return it.
+ * Otherwise returns NULL
+ */
+static struct socket *__mptcp_tcp_fallback_get(const struct mptcp_sock *ms=
k)
+{
+	if (!msk->subflow || tcp_sk(msk->subflow->sk)->is_mptcp)
+		return NULL;
+
+	sock_hold(msk->subflow->sk);
+	return msk->subflow;
 }
 =

 static struct sock *mptcp_subflow_get(const struct mptcp_sock *msk)
@@ -57,6 +79,51 @@ static struct sock *mptcp_subflow_get(const struct mptcp=
_sock *msk)
 	return NULL;
 }
 =

+static bool __mptcp_can_create_subflow(const struct mptcp_sock *msk)
+{
+	int state =3D ((struct sock *)msk)->sk_state;
+
+	return state =3D=3D TCP_CLOSE || state =3D=3D TCP_LISTEN;
+}
+
+static struct socket *mptcp_socket_create_get(struct mptcp_sock *msk, int =
state)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+	struct socket *ssock;
+	int err;
+
+	lock_sock(sk);
+	ssock =3D __mptcp_nmpc_socket(msk);
+	if (ssock)
+		goto set_state;
+
+	if (!__mptcp_can_create_subflow(msk)) {
+		ssock =3D ERR_PTR(-EINVAL);
+		goto release;
+	}
+
+	err =3D mptcp_subflow_create_socket(sk, &ssock);
+	if (err) {
+		ssock =3D ERR_PTR(err);
+		goto release;
+	}
+
+	msk->subflow =3D ssock;
+	subflow =3D mptcp_subflow_ctx(msk->subflow->sk);
+	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
+	subflow->request_version =3D 1; /* only v1 supported */
+
+set_state:
+	sock_hold(ssock->sk);
+	if (state !=3D TCP_MAX_STATES)
+		inet_sk_state_store(sk, state);
+
+release:
+	release_sock(sk);
+	return ssock;
+}
+
 static bool mptcp_ext_cache_refill(struct mptcp_sock *msk)
 {
 	if (!msk->cached_ext)
@@ -213,7 +280,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		return -EOPNOTSUPP;
 =

 	lock_sock(sk);
-	ssock =3D __mptcp_fallback_get_ref(msk);
+	ssock =3D __mptcp_tcp_fallback_get(msk);
 	if (ssock) {
 		release_sock(sk);
 		pr_debug("fallback passthrough");
@@ -320,7 +387,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 	long timeo;
 =

 	lock_sock(sk);
-	ssock =3D __mptcp_fallback_get_ref(msk);
+	ssock =3D __mptcp_tcp_fallback_get(msk);
 	if (ssock) {
 		release_sock(sk);
 		pr_debug("fallback-read subflow=3D%p",
@@ -493,7 +560,11 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 	struct socket *listener;
 	struct sock *newsk;
 =

-	listener =3D msk->subflow;
+	listener =3D __mptcp_first_socket(msk);
+	if (WARN_ON_ONCE(!listener)) {
+		*err =3D -EINVAL;
+		return NULL;
+	}
 =

 	pr_debug("msk=3D%p, listener=3D%p", msk, mptcp_subflow_ctx(listener->sk));
 	*err =3D kernel_accept(listener, &new_sock, flags);
@@ -580,8 +651,8 @@ static int mptcp_setsockopt(struct sock *sk, int level,=
 int optname,
 	optval =3D (char __kernel __force *)uoptval;
 =

 	pr_debug("msk=3D%p", msk);
-	ssock =3D mptcp_fallback_get_ref(msk);
-	if (ssock) {
+	ssock =3D mptcp_socket_create_get(msk, TCP_MAX_STATES);
+	if (!IS_ERR(ssock)) {
 		pr_debug("subflow=3D%p", ssock->sk);
 		ret =3D kernel_setsockopt(ssock, level, optname, optval, optlen);
 		sock_put(ssock->sk);
@@ -608,8 +679,8 @@ static int mptcp_getsockopt(struct sock *sk, int level,=
 int optname,
 	option =3D (int __kernel __force *)uoption;
 =

 	pr_debug("msk=3D%p", msk);
-	ssock =3D mptcp_fallback_get_ref(msk);
-	if (ssock) {
+	ssock =3D mptcp_socket_create_get(msk, TCP_MAX_STATES);
+	if (!IS_ERR(ssock)) {
 		pr_debug("subflow=3D%p", ssock->sk);
 		ret =3D kernel_getsockopt(ssock, level, optname, optval, option);
 		sock_put(ssock->sk);
@@ -625,11 +696,14 @@ static int mptcp_getsockopt(struct sock *sk, int leve=
l, int optname,
 static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct socket *ssock;
 =

-	pr_debug("msk=3D%p, subflow=3D%p", msk,
-		 mptcp_subflow_ctx(msk->subflow->sk));
+	ssock =3D __mptcp_first_socket(msk);
+	pr_debug("msk=3D%p, subflow=3D%p", msk, ssock);
+	if (WARN_ON_ONCE(!ssock))
+		return -EINVAL;
 =

-	return inet_csk_get_port(msk->subflow->sk, snum);
+	return inet_csk_get_port(ssock->sk, snum);
 }
 =

 void mptcp_finish_connect(struct sock *sk,
@@ -704,43 +778,13 @@ static struct proto mptcp_prot =3D {
 	.no_autobind	=3D true,
 };
 =

-static struct socket *mptcp_socket_create_get(struct mptcp_sock *msk)
-{
-	struct mptcp_subflow_context *subflow;
-	struct sock *sk =3D (struct sock *)msk;
-	struct socket *ssock;
-	int err;
-
-	lock_sock(sk);
-	ssock =3D __mptcp_fallback_get_ref(msk);
-	if (ssock)
-		goto release;
-
-	err =3D mptcp_subflow_create_socket(sk, &ssock);
-	if (err) {
-		ssock =3D ERR_PTR(err);
-		goto release;
-	}
-
-	msk->subflow =3D ssock;
-	subflow =3D mptcp_subflow_ctx(msk->subflow->sk);
-	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
-	subflow->request_version =3D 1; /* only v1 supported */
-
-	sock_hold(ssock->sk);
-
-release:
-	release_sock(sk);
-	return ssock;
-}
-
 static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int add=
r_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct socket *ssock;
 	int err;
 =

-	ssock =3D mptcp_socket_create_get(msk);
+	ssock =3D mptcp_socket_create_get(msk, TCP_MAX_STATES);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

@@ -756,7 +800,7 @@ static int mptcp_stream_connect(struct socket *sock, st=
ruct sockaddr *uaddr,
 	struct socket *ssock;
 	int err;
 =

-	ssock =3D mptcp_socket_create_get(msk);
+	ssock =3D mptcp_socket_create_get(msk, TCP_SYN_SENT);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

@@ -769,6 +813,10 @@ static int mptcp_stream_connect(struct socket *sock, s=
truct sockaddr *uaddr,
 #endif
 =

 	err =3D ssock->ops->connect(ssock, uaddr, addr_len, flags);
+
+	/* should we keep msk socket lock instead? and release it this
+	 * latter state update */
+	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
 	sock_put(ssock->sk);
 	return err;
 }
@@ -778,30 +826,20 @@ static int mptcp_getname(struct socket *sock, struct =
sockaddr *uaddr,
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct socket *ssock;
-	struct sock *ssk;
 	int ret;
 =

 	lock_sock(sock->sk);
-	ssock =3D __mptcp_fallback_get_ref(msk);
-	if (ssock) {
-		release_sock(sock->sk);
-		pr_debug("subflow=3D%p", ssock->sk);
-		ret =3D ssock->ops->getname(ssock, uaddr, peer);
-		sock_put(ssock->sk);
-		return ret;
-	}
-
 	/* @@ the meaning of getname() for the remote peer when the socket
 	 * is connected and there are multiple subflows is not defined.
 	 * For now just use the first subflow on the list.
 	 */
-	ssk =3D mptcp_subflow_get(msk);
-	if (!ssk) {
+	ssock =3D __mptcp_first_socket(msk);
+	if (!ssock) {
 		release_sock(sock->sk);
 		return -ENOTCONN;
 	}
 =

-	ret =3D ssk->sk_socket->ops->getname(ssk->sk_socket, uaddr, peer);
+	ret =3D ssock->ops->getname(ssock, uaddr, peer);
 	release_sock(sock->sk);
 	return ret;
 }
@@ -860,11 +898,15 @@ static int mptcp_listen(struct socket *sock, int back=
log)
 =

 	pr_debug("msk=3D%p", msk);
 =

-	ssock =3D mptcp_socket_create_get(msk);
+	ssock =3D mptcp_socket_create_get(msk, TCP_LISTEN);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

 	err =3D ssock->ops->listen(ssock, backlog);
+
+	/* should we keep msk socket lock instead? and release it this
+	 * latter state update */
+	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
 	sock_put(ssock->sk);
 	return err;
 }
@@ -874,17 +916,28 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct socket *ssock;
-	int err;
+	int err =3D -EINVAL;
 =

 	pr_debug("msk=3D%p", msk);
 =

-	ssock =3D mptcp_fallback_get_ref(msk);
+	lock_sock(sock->sk);
+	if (sock->sk->sk_state !=3D TCP_LISTEN)
+		goto unlock_fail;
+
+	ssock =3D __mptcp_first_socket(msk);
 	if (!ssock)
-		return -EINVAL;
+		goto unlock_fail;
+
+	sock_hold(ssock->sk);
+	release_sock(sock->sk);
 =

 	err =3D ssock->ops->accept(sock, newsock, flags, kern);
 	sock_put(ssock->sk);
 	return err;
+
+unlock_fail:
+	release_sock(sock->sk);
+	return -EINVAL;
 }
 =

 static __poll_t mptcp_poll(struct file *file, struct socket *sock,
@@ -898,8 +951,9 @@ static __poll_t mptcp_poll(struct file *file, struct so=
cket *sock,
 =

 	msk =3D mptcp_sk(sk);
 	lock_sock(sk);
-	ssock =3D __mptcp_fallback_get_ref(msk);
+	ssock =3D __mptcp_nmpc_socket(msk);
 	if (ssock) {
+		sock_hold(ssock->sk);
 		release_sock(sk);
 		ret =3D ssock->ops->poll(file, ssock, wait);
 		sock_put(ssock->sk);
@@ -935,7 +989,7 @@ static int mptcp_shutdown(struct socket *sock, int how)
 	if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
 		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
 =

-	ssock =3D __mptcp_fallback_get_ref(msk);
+	ssock =3D __mptcp_tcp_fallback_get(msk);
 	if (ssock) {
 		release_sock(sock->sk);
 		pr_debug("subflow=3D%p", ssock->sk);
-- =

2.21.0

--===============2251919304344911281==--
