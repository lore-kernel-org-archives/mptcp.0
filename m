Content-Type: multipart/mixed; boundary="===============5415090554434883988=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/4] mptcp: cope with later TCP fallback
Date: Fri, 13 Dec 2019 21:51:45 +0100
Message-ID: <20191213205145.2468578-5-matthieu.baerts@tessares.net>
In-Reply-To: 20191213205145.2468578-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3013

--===============5415090554434883988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

With V1 passive connections can fallback TCP after that the
subflow become established:

syn+ MP_CAPABLE ->
               <- syn, ack + MP_CAPABLE

ack, seq =3D 3    ->
        // OoO packet is accepted because in-sequence
        // passive socket is created, is in ESTABLISHED
	// status and tentatively as MP_CAPABLE

ack, seq =3D 2     ->
        // no MP_CAPABLE opt, subflow should fallback to TCP

We can't use the 'subflow' socket fallback, as we don't have
it available for passive connection.

Instead, when the fallback is detected, replace the mptcp
socket with the underlining TCP subflow. Beyond covering
the above scenario, it makes TCP fallback socket as efficient
as plain TCP ones.

Co-developed-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/protocol.c | 99 +++++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |  1 +
 2 files changed, 84 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f645157f2d26..2b20f4d3e179 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -24,6 +24,40 @@
 =

 #define MPTCP_SAME_STATE TCP_MAX_STATES
 =

+static void __mptcp_close(struct sock *sk, long timeout);
+
+/* MP_CAPABLE handshake failed, convert msk to plain tcp, replacing
+ * socket->sk and stream ops and destroying msk
+ * return the msk socket, as we can't access msk anymore after this functi=
on
+ * completes
+ * Called with msk lock held, releases such lock before returning
+ */
+static struct socket *__mptcp_fallback_to_tcp(struct mptcp_sock *msk,
+					      struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct socket *sock;
+	struct sock *sk;
+
+	sk =3D (struct sock *)msk;
+	sock =3D sk->sk_socket;
+	subflow =3D mptcp_subflow_ctx(ssk);
+
+	/* detach the msk socket */
+	list_del_init(&subflow->node);
+	sock_orphan(sk);
+	sock->sk =3D NULL;
+
+	/* socket is now TCP */
+	sock_graft(ssk, sock);
+	sock->ops =3D sk->sk_family =3D=3D AF_INET6 ? &inet6_stream_ops :
+						&inet_stream_ops;
+
+	/* destroy the left-over msk sock */
+	__mptcp_close(sk, 0);
+	return sock;
+}
+
 /* if msk has a single subflow socket, and the mp_capable handshake is not
  * completed yet or has failed - that is, the socket is Not MP Capable,
  * returns it.
@@ -37,25 +71,37 @@ static struct socket *__mptcp_nmpc_socket(const struct =
mptcp_sock *msk)
 	return msk->subflow;
 }
 =

-/* if msk has a single subflow, and the mp_capable handshake is failed,
+static bool __mptcp_needs_tcp_fallback(const struct mptcp_sock *msk)
+{
+	return msk->first && !tcp_sk(msk->first)->is_mptcp;
+}
+
+/* if the mp_capable handshake is failed, return a tcp socket
  * return it.
  * Otherwise returns NULL
  */
-static struct socket *__mptcp_tcp_fallback(const struct mptcp_sock *msk)
+static struct socket *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
-	struct socket *ssock =3D __mptcp_nmpc_socket(msk);
-
 	sock_owned_by_me((const struct sock *)msk);
 =

-	if (!ssock || tcp_sk(ssock->sk)->is_mptcp)
+	if (likely(!__mptcp_needs_tcp_fallback(msk)))
 		return NULL;
 =

-	return ssock;
+	if (msk->subflow) {
+		/* the first subflow is an active connection, discart the
+		 * paired socket
+		 */
+		msk->subflow->sk =3D NULL;
+		sock_release(msk->subflow);
+		msk->subflow =3D NULL;
+	}
+
+	return __mptcp_fallback_to_tcp(msk, msk->first);
 }
 =

 static bool __mptcp_can_create_subflow(const struct mptcp_sock *msk)
 {
-	return ((struct sock *)msk)->sk_state =3D=3D TCP_CLOSE;
+	return !msk->first;
 }
 =

 static struct socket *__mptcp_socket_create(struct mptcp_sock *msk, int st=
ate)
@@ -76,6 +122,7 @@ static struct socket *__mptcp_socket_create(struct mptcp=
_sock *msk, int state)
 	if (err)
 		return ERR_PTR(err);
 =

+	msk->first =3D ssock->sk;
 	msk->subflow =3D ssock;
 	subflow =3D mptcp_subflow_ctx(ssock->sk);
 	list_add(&subflow->node, &msk->conn_list);
@@ -155,6 +202,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 		ret =3D sk_stream_wait_memory(ssk, timeo);
 		if (ret)
 			return ret;
+		if (unlikely(__mptcp_needs_tcp_fallback(msk)))
+			return 0;
 	}
 =

 	/* compute copy limit */
@@ -265,11 +314,11 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =

 	lock_sock(sk);
 	ssock =3D __mptcp_tcp_fallback(msk);
-	if (ssock) {
+	if (unlikely(ssock)) {
+fallback:
 		pr_debug("fallback passthrough");
 		ret =3D sock_sendmsg(ssock, msg);
-		release_sock(sk);
-		return ret;
+		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
 	}
 =

 	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
@@ -288,6 +337,11 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 					 &size_goal);
 		if (ret < 0)
 			break;
+		if (ret =3D=3D 0 && unlikely(__mptcp_needs_tcp_fallback(msk))) {
+			release_sock(ssk);
+			ssock =3D __mptcp_tcp_fallback(msk);
+			goto fallback;
+		}
 =

 		copied +=3D ret;
 	}
@@ -367,11 +421,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 =

 	lock_sock(sk);
 	ssock =3D __mptcp_tcp_fallback(msk);
-	if (ssock) {
+	if (unlikely(ssock)) {
+fallback:
 		pr_debug("fallback-read subflow=3D%p",
 			 mptcp_subflow_ctx(ssock->sk));
 		copied =3D sock_recvmsg(ssock, msg, flags);
-		release_sock(sk);
 		return copied;
 	}
 =

@@ -476,6 +530,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 		pr_debug("block timeout %ld", timeo);
 		wait_data =3D true;
 		mptcp_wait_data(sk, &timeo);
+		if (unlikely(__mptcp_tcp_fallback(msk)))
+			goto fallback;
 	}
 =

 	if (more_data_avail) {
@@ -528,6 +584,8 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
 =

+	msk->first =3D NULL;
+
 	return 0;
 }
 =

@@ -562,7 +620,8 @@ static void mptcp_subflow_shutdown(struct sock *ssk, in=
t how)
 	release_sock(ssk);
 }
 =

-static void mptcp_close(struct sock *sk, long timeout)
+/* Called with msk lock held, releases such lock before returning */
+static void __mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -570,8 +629,6 @@ static void mptcp_close(struct sock *sk, long timeout)
 	mptcp_token_destroy(msk->token);
 	inet_sk_state_store(sk, TCP_CLOSE);
 =

-	lock_sock(sk);
-
 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

@@ -584,6 +641,12 @@ static void mptcp_close(struct sock *sk, long timeout)
 	sk_common_release(sk);
 }
 =

+static void mptcp_close(struct sock *sk, long timeout)
+{
+	lock_sock(sk);
+	__mptcp_close(sk, timeout);
+}
+
 static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 {
 	const struct ipv6_pinfo *ssk6 =3D inet6_sk(ssk);
@@ -653,6 +716,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
 		msk->subflow =3D NULL;
+		msk->first =3D newsk;
 =

 		mptcp_token_update_accept(newsk, new_mptcp_sock);
 =

@@ -1008,8 +1072,8 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait)
 {
-	const struct mptcp_sock *msk;
 	struct sock *sk =3D sock->sk;
+	struct mptcp_sock *msk;
 	struct socket *ssock;
 	__poll_t mask =3D 0;
 =

@@ -1025,6 +1089,9 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 	release_sock(sk);
 	sock_poll_wait(file, sock, wait);
 	lock_sock(sk);
+	ssock =3D __mptcp_tcp_fallback(msk);
+	if (unlikely(ssock))
+		return ssock->ops->poll(file, ssock, NULL);
 =

 	if (test_bit(MPTCP_DATA_READY, &msk->flags))
 		mask =3D EPOLLIN | EPOLLRDNORM;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0e5ba5ac1443..b4cf88258b6b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -73,6 +73,7 @@ struct mptcp_sock {
 	struct list_head conn_list;
 	struct skb_ext	*cached_ext;	/* for the next sendmsg */
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
+	struct sock	*first;
 };
 =

 #define mptcp_for_each_subflow(__msk, __subflow)			\
-- =

2.24.0

--===============5415090554434883988==--
