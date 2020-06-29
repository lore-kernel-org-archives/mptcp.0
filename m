Content-Type: multipart/mixed; boundary="===============3684540688695012136=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 4/6] mptcp: create first subflow at msk
 creation time
Date: Mon, 29 Jun 2020 22:26:23 +0200
Message-ID: <ce0a43c723147d86dec5ea47f86fa877bf5371b7.1593461586.git.dcaratti@redhat.com>
In-Reply-To: cover.1593461586.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4849

--===============3684540688695012136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

This cleans the code a bit and makes the behavior more consistent.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/protocol.c | 53 +++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dbeb6fe374f5..ad619bda71cc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -86,32 +86,16 @@ static struct socket *__mptcp_tcp_fallback(struct mptcp=
_sock *msk)
 	return msk->subflow;
 }
 =

-static bool __mptcp_can_create_subflow(const struct mptcp_sock *msk)
-{
-	return !msk->first;
-}
-
-static struct socket *__mptcp_socket_create(struct mptcp_sock *msk, int st=
ate)
+static int __mptcp_socket_create(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk =3D (struct sock *)msk;
 	struct socket *ssock;
 	int err;
 =

-	ssock =3D __mptcp_tcp_fallback(msk);
-	if (unlikely(ssock))
-		return ssock;
-
-	ssock =3D __mptcp_nmpc_socket(msk);
-	if (ssock)
-		goto set_state;
-
-	if (!__mptcp_can_create_subflow(msk))
-		return ERR_PTR(-EINVAL);
-
 	err =3D mptcp_subflow_create_socket(sk, &ssock);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 =

 	msk->first =3D ssock->sk;
 	msk->subflow =3D ssock;
@@ -124,10 +108,7 @@ static struct socket *__mptcp_socket_create(struct mpt=
cp_sock *msk, int state)
 	 */
 	RCU_INIT_POINTER(msk->first->sk_wq, &sk->sk_socket->wq);
 =

-set_state:
-	if (state !=3D MPTCP_SAME_STATE)
-		inet_sk_state_store(sk, state);
-	return ssock;
+	return 0;
 }
 =

 static void __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
@@ -1255,6 +1236,10 @@ static int mptcp_init_sock(struct sock *sk)
 	if (ret)
 		return ret;
 =

+	ret =3D __mptcp_socket_create(mptcp_sk(sk));
+	if (ret)
+		return ret;
+
 	sk_sockets_allocated_inc(sk);
 	sk->sk_sndbuf =3D sock_net(sk)->ipv4.sysctl_tcp_wmem[2];
 =

@@ -1744,9 +1729,9 @@ static int mptcp_bind(struct socket *sock, struct soc=
kaddr *uaddr, int addr_len)
 	int err;
 =

 	lock_sock(sock->sk);
-	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
-	if (IS_ERR(ssock)) {
-		err =3D PTR_ERR(ssock);
+	ssock =3D __mptcp_nmpc_socket(msk);
+	if (!ssock) {
+		err =3D -EINVAL;
 		goto unlock;
 	}
 =

@@ -1776,13 +1761,14 @@ static int mptcp_stream_connect(struct socket *sock=
, struct sockaddr *uaddr,
 		goto do_connect;
 	}
 =

-	mptcp_token_destroy(msk);
-	ssock =3D __mptcp_socket_create(msk, TCP_SYN_SENT);
-	if (IS_ERR(ssock)) {
-		err =3D PTR_ERR(ssock);
+	ssock =3D __mptcp_nmpc_socket(msk);
+	if (!ssock) {
+		err =3D -EINVAL;
 		goto unlock;
 	}
 =

+	mptcp_token_destroy(msk);
+	inet_sk_state_store(sock->sk, TCP_SYN_SENT);
 	subflow =3D mptcp_subflow_ctx(ssock->sk);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -1820,13 +1806,14 @@ static int mptcp_listen(struct socket *sock, int ba=
cklog)
 	pr_debug("msk=3D%p", msk);
 =

 	lock_sock(sock->sk);
-	mptcp_token_destroy(msk);
-	ssock =3D __mptcp_socket_create(msk, TCP_LISTEN);
-	if (IS_ERR(ssock)) {
-		err =3D PTR_ERR(ssock);
+	ssock =3D __mptcp_nmpc_socket(msk);
+	if (!ssock) {
+		err =3D -EINVAL;
 		goto unlock;
 	}
 =

+	mptcp_token_destroy(msk);
+	inet_sk_state_store(sock->sk, TCP_LISTEN);
 	sock_set_flag(sock->sk, SOCK_RCU_FREE);
 =

 	err =3D ssock->ops->listen(ssock, backlog);
-- =

2.26.2

--===============3684540688695012136==--
