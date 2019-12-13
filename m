Content-Type: multipart/mixed; boundary="===============5304997581070253842=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 1/4] mptcp: add helper to forcefully fallback the
 msk socket to TCP
Date: Fri, 13 Dec 2019 15:33:49 +0100
Message-ID: <8599ff8e65531ddfa8d0cd110e89b2e82bd9368c.1576247361.git.pabeni@redhat.com>
In-Reply-To: cover.1576247361.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2936

--===============5304997581070253842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

will be used in later patch

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c15232461a61..b6d753ed8397 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -24,6 +24,38 @@
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
@@ -561,7 +593,7 @@ static void mptcp_subflow_shutdown(struct sock *ssk, in=
t how)
 	release_sock(ssk);
 }
 =

-static void mptcp_close(struct sock *sk, long timeout)
+static void __mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -569,8 +601,6 @@ static void mptcp_close(struct sock *sk, long timeout)
 	mptcp_token_destroy(msk->token);
 	inet_sk_state_store(sk, TCP_CLOSE);
 =

-	lock_sock(sk);
-
 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

@@ -583,6 +613,12 @@ static void mptcp_close(struct sock *sk, long timeout)
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
-- =

2.21.0

--===============5304997581070253842==--
