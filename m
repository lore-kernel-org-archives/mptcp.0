Content-Type: multipart/mixed; boundary="===============0573959828129564642=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v3 19/19] mptcp: cope with later TCP fallback
Date: Tue, 21 Jan 2020 16:56:33 -0800
Message-ID: <20200122005633.21229-20-cpaasch@apple.com>
In-Reply-To: 20200122005633.21229-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 3483

--===============0573959828129564642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

With MPTCP v1, passive connections can fallback to TCP after the
subflow becomes established:

syn + MP_CAPABLE ->
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
socket with the underlying TCP subflow. Beyond covering
the above scenario, it makes a TCP fallback socket as efficient
as plain TCP ones.

Co-developed-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/protocol.c | 119 ++++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |   1 +
 2 files changed, 103 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1b64dfaa5f63..ee916b3686fe 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -24,6 +24,58 @@
 =

 #define MPTCP_SAME_STATE TCP_MAX_STATES
 =

+static void __mptcp_close(struct sock *sk, long timeout);
+
+static const struct proto_ops * tcp_proto_ops(struct sock *sk)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family =3D=3D AF_INET6)
+		return &inet6_stream_ops;
+#endif
+	return &inet_stream_ops;
+}
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
+	lock_sock(ssk);
+	sock_graft(ssk, sock);
+	if (subflow->conn) {
+		/* We can't release the ULP data on a live socket,
+		 * restore the tcp callback
+		 */
+		mptcp_subflow_tcp_fallback(ssk, subflow);
+		sock_put(subflow->conn);
+		subflow->conn =3D NULL;
+	}
+	release_sock(ssk);
+	sock->ops =3D tcp_proto_ops(ssk);
+
+	/* destroy the left-over msk sock */
+	__mptcp_close(sk, 0);
+	return sock;
+}
+
 /* If msk has an initial subflow socket, and the MP_CAPABLE handshake has =
not
  * completed yet or has failed, return the subflow socket.
  * Otherwise return NULL.
@@ -36,25 +88,37 @@ static struct socket *__mptcp_nmpc_socket(const struct =
mptcp_sock *msk)
 	return msk->subflow;
 }
 =

-/* if msk has a single subflow, and the mp_capable handshake is failed,
- * return it.
+static bool __mptcp_needs_tcp_fallback(const struct mptcp_sock *msk)
+{
+	return msk->first && !sk_is_mptcp(msk->first);
+}
+
+/* if the mp_capable handshake has failed, it fallbacks msk to plain TCP,
+ * releases the socket lock and returns a reference to the now TCP socket.
  * Otherwise returns NULL
  */
-static struct socket *__mptcp_tcp_fallback(const struct mptcp_sock *msk)
+static struct socket *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
-	struct socket *ssock =3D __mptcp_nmpc_socket(msk);
-
 	sock_owned_by_me((const struct sock *)msk);
 =

-	if (!ssock || sk_is_mptcp(ssock->sk))
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
@@ -75,6 +139,7 @@ static struct socket *__mptcp_socket_create(struct mptcp=
_sock *msk, int state)
 	if (err)
 		return ERR_PTR(err);
 =

+	msk->first =3D ssock->sk;
 	msk->subflow =3D ssock;
 	subflow =3D mptcp_subflow_ctx(ssock->sk);
 	list_add(&subflow->node, &msk->conn_list);
@@ -154,6 +219,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 		ret =3D sk_stream_wait_memory(ssk, timeo);
 		if (ret)
 			return ret;
+		if (unlikely(__mptcp_needs_tcp_fallback(msk)))
+			return 0;
 	}
 =

 	/* compute copy limit */
@@ -265,11 +332,11 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
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
@@ -288,6 +355,11 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
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
@@ -368,11 +440,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
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

@@ -477,6 +549,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 		pr_debug("block timeout %ld", timeo);
 		wait_data =3D true;
 		mptcp_wait_data(sk, &timeo);
+		if (unlikely(__mptcp_tcp_fallback(msk)))
+			goto fallback;
 	}
 =

 	if (more_data_avail) {
@@ -529,6 +603,8 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
 =

+	msk->first =3D NULL;
+
 	return 0;
 }
 =

@@ -563,7 +639,8 @@ static void mptcp_subflow_shutdown(struct sock *ssk, in=
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
@@ -571,8 +648,6 @@ static void mptcp_close(struct sock *sk, long timeout)
 	mptcp_token_destroy(msk->token);
 	inet_sk_state_store(sk, TCP_CLOSE);
 =

-	lock_sock(sk);
-
 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

@@ -585,6 +660,12 @@ static void mptcp_close(struct sock *sk, long timeout)
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
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -654,6 +735,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
 		msk->subflow =3D NULL;
+		msk->first =3D newsk;
 =

 		mptcp_token_update_accept(newsk, new_mptcp_sock);
 =

@@ -1007,8 +1089,8 @@ static int mptcp_stream_accept(struct socket *sock, s=
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

@@ -1024,6 +1106,9 @@ static __poll_t mptcp_poll(struct file *file, struct =
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
index 10eaa7c7381b..8a99a2930284 100644
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

2.23.0

--===============0573959828129564642==--
