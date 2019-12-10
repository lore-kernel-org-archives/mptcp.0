Content-Type: multipart/mixed; boundary="===============8929582838489205882=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/4] mptcp: cleanup fallback handling
Date: Tue, 10 Dec 2019 19:00:57 +0100
Message-ID: <ce07ef989e196a098b4eb81822b350db3a346325.1575999260.git.pabeni@redhat.com>
In-Reply-To: cover.1575999260.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2864

--===============8929582838489205882==
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

v1 -> v2:
 - use MPTCP_SAME_STATE macro (Mat)
 - drop dumb comment (Mat)

RFC -> v1:
 - drop __mptcp_first_socket() helper, always use __mptcp_nmpc_socket()
   instead

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 178 +++++++++++++++++++++++++++----------------
 1 file changed, 111 insertions(+), 67 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f0944a5b562d..65300b555b3b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -22,25 +22,35 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

-static struct socket *__mptcp_fallback_get_ref(const struct mptcp_sock *ms=
k)
-{
-	sock_owned_by_me((const struct sock *)msk);
+#define MPTCP_SAME_STATE TCP_MAX_STATES
 =

+/* if msk has a single subflow socket, and the mp_capable handshake is not
+ * completed yet or has failed - that is, the socket is Not MP Capable,
+ * returns it.
+ * Otherwise returns NULL
+ */
+static struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
+{
 	if (!msk->subflow)
 		return NULL;
 =

-	sock_hold(msk->subflow->sk);
 	return msk->subflow;
 }
 =

-static struct socket *mptcp_fallback_get_ref(const struct mptcp_sock *msk)
+/* if msk has a single subflow, and the mp_capable handshake is failed,
+ * get a reference and return it.
+ * Otherwise returns NULL
+ */
+static struct socket *__mptcp_tcp_fallback_get(const struct mptcp_sock *ms=
k)
 {
-	struct socket *ssock;
+	struct socket *ssock =3D __mptcp_nmpc_socket(msk);
 =

-	lock_sock((struct sock *)msk);
-	ssock =3D __mptcp_fallback_get_ref(msk);
-	release_sock((struct sock *)msk);
+	sock_owned_by_me((const struct sock *)msk);
 =

+	if (!ssock || tcp_sk(ssock->sk)->is_mptcp)
+		return NULL;
+
+	sock_hold(ssock->sk);
 	return ssock;
 }
 =

@@ -57,6 +67,49 @@ static struct sock *mptcp_subflow_get(const struct mptcp=
_sock *msk)
 	return NULL;
 }
 =

+static bool __mptcp_can_create_subflow(const struct mptcp_sock *msk)
+{
+	return ((struct sock *)msk)->sk_state =3D=3D TCP_CLOSE;
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
+	if (state !=3D MPTCP_SAME_STATE)
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
@@ -221,7 +274,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		return -EOPNOTSUPP;
 =

 	lock_sock(sk);
-	ssock =3D __mptcp_fallback_get_ref(msk);
+	ssock =3D __mptcp_tcp_fallback_get(msk);
 	if (ssock) {
 		release_sock(sk);
 		pr_debug("fallback passthrough");
@@ -324,7 +377,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 	long timeo;
 =

 	lock_sock(sk);
-	ssock =3D __mptcp_fallback_get_ref(msk);
+	ssock =3D __mptcp_tcp_fallback_get(msk);
 	if (ssock) {
 		release_sock(sk);
 		pr_debug("fallback-read subflow=3D%p",
@@ -579,7 +632,11 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 	struct socket *listener;
 	struct sock *newsk;
 =

-	listener =3D msk->subflow;
+	listener =3D __mptcp_nmpc_socket(msk);
+	if (WARN_ON_ONCE(!listener)) {
+		*err =3D -EINVAL;
+		return NULL;
+	}
 =

 	pr_debug("msk=3D%p, listener=3D%p", msk, mptcp_subflow_ctx(listener->sk));
 	newsk =3D inet_csk_accept(listener->sk, flags, err, kern);
@@ -665,8 +722,8 @@ static int mptcp_setsockopt(struct sock *sk, int level,=
 int optname,
 	optval =3D (char __kernel __force *)uoptval;
 =

 	pr_debug("msk=3D%p", msk);
-	ssock =3D mptcp_fallback_get_ref(msk);
-	if (ssock) {
+	ssock =3D mptcp_socket_create_get(msk, MPTCP_SAME_STATE);
+	if (!IS_ERR(ssock)) {
 		pr_debug("subflow=3D%p", ssock->sk);
 		ret =3D kernel_setsockopt(ssock, level, optname, optval, optlen);
 		sock_put(ssock->sk);
@@ -693,8 +750,8 @@ static int mptcp_getsockopt(struct sock *sk, int level,=
 int optname,
 	option =3D (int __kernel __force *)uoption;
 =

 	pr_debug("msk=3D%p", msk);
-	ssock =3D mptcp_fallback_get_ref(msk);
-	if (ssock) {
+	ssock =3D mptcp_socket_create_get(msk, MPTCP_SAME_STATE);
+	if (!IS_ERR(ssock)) {
 		pr_debug("subflow=3D%p", ssock->sk);
 		ret =3D kernel_getsockopt(ssock, level, optname, optval, option);
 		sock_put(ssock->sk);
@@ -710,11 +767,14 @@ static int mptcp_getsockopt(struct sock *sk, int leve=
l, int optname,
 static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct socket *ssock;
 =

-	pr_debug("msk=3D%p, subflow=3D%p", msk,
-		 mptcp_subflow_ctx(msk->subflow->sk));
+	ssock =3D __mptcp_nmpc_socket(msk);
+	pr_debug("msk=3D%p, subflow=3D%p", msk, ssock);
+	if (WARN_ON_ONCE(!ssock))
+		return -EINVAL;
 =

-	return inet_csk_get_port(msk->subflow->sk, snum);
+	return inet_csk_get_port(ssock->sk, snum);
 }
 =

 void mptcp_finish_connect(struct sock *ssk)
@@ -811,43 +871,13 @@ static struct proto mptcp_prot =3D {
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
+	ssock =3D mptcp_socket_create_get(msk, MPTCP_SAME_STATE);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

@@ -863,7 +893,7 @@ static int mptcp_stream_connect(struct socket *sock, st=
ruct sockaddr *uaddr,
 	struct socket *ssock;
 	int err;
 =

-	ssock =3D mptcp_socket_create_get(msk);
+	ssock =3D mptcp_socket_create_get(msk, TCP_SYN_SENT);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

@@ -876,6 +906,7 @@ static int mptcp_stream_connect(struct socket *sock, st=
ruct sockaddr *uaddr,
 #endif
 =

 	err =3D ssock->ops->connect(ssock, uaddr, addr_len, flags);
+	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
 	sock_put(ssock->sk);
 	return err;
 }
@@ -887,16 +918,16 @@ static int mptcp_getname(struct socket *sock, struct =
sockaddr *uaddr,
 	struct socket *ssock;
 	int ret;
 =

-	if (msk->subflow) {
-		lock_sock(sock->sk);
-		ssock =3D __mptcp_fallback_get_ref(msk);
-		release_sock(sock->sk);
-		if (ssock) {
-			pr_debug("subflow=3D%p", ssock->sk);
-			ret =3D ssock->ops->getname(ssock, uaddr, peer);
-			sock_put(ssock->sk);
-			return ret;
-		}
+	lock_sock(sock->sk);
+	ssock =3D __mptcp_nmpc_socket(msk);
+	if (ssock)
+		sock_hold(ssock->sk);
+	release_sock(sock->sk);
+	if (ssock) {
+		pr_debug("subflow=3D%p", ssock->sk);
+		ret =3D ssock->ops->getname(ssock, uaddr, peer);
+		sock_put(ssock->sk);
+		return ret;
 	}
 =

 	switch (af) {
@@ -962,11 +993,12 @@ static int mptcp_listen(struct socket *sock, int back=
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
+	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
 	sock_put(ssock->sk);
 	return err;
 }
@@ -985,13 +1017,20 @@ static int mptcp_stream_accept(struct socket *sock, =
struct socket *newsock,
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
+	ssock =3D __mptcp_nmpc_socket(msk);
 	if (!ssock)
-		return -EINVAL;
+		goto unlock_fail;
+
+	sock_hold(ssock->sk);
+	release_sock(sock->sk);
 =

 	err =3D ssock->ops->accept(sock, newsock, flags, kern);
 	if (err =3D=3D 0 && !is_tcp_proto(newsock->sk->sk_prot)) {
@@ -1011,6 +1050,10 @@ static int mptcp_stream_accept(struct socket *sock, =
struct socket *newsock,
 =

 	sock_put(ssock->sk);
 	return err;
+
+unlock_fail:
+	release_sock(sock->sk);
+	return -EINVAL;
 }
 =

 static __poll_t mptcp_poll(struct file *file, struct socket *sock,
@@ -1023,8 +1066,9 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 =

 	msk =3D mptcp_sk(sk);
 	lock_sock(sk);
-	ssock =3D __mptcp_fallback_get_ref(msk);
+	ssock =3D __mptcp_nmpc_socket(msk);
 	if (ssock) {
+		sock_hold(ssock->sk);
 		release_sock(sk);
 		mask =3D ssock->ops->poll(file, ssock, wait);
 		sock_put(ssock->sk);
@@ -1061,7 +1105,7 @@ static int mptcp_shutdown(struct socket *sock, int ho=
w)
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

--===============8929582838489205882==--
