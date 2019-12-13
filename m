Content-Type: multipart/mixed; boundary="===============8200734845767359799=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 4/4] mptcp: deal with fallback in additional
 places.
Date: Fri, 13 Dec 2019 15:33:52 +0100
Message-ID: <2a28826e6748b33e04b28a733c537dd4d2a55dea.1576247361.git.pabeni@redhat.com>
In-Reply-To: cover.1576247361.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2940

--===============8200734845767359799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Everytime the msk socket ops block, a passive connection
can complete with failure the MP_CAPABLE handshake, requiring
transitioning to TCP.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com
---
 net/mptcp/protocol.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 999b1f89b3d6..04cbfca8966c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -200,6 +200,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 		ret =3D sk_stream_wait_memory(ssk, timeo);
 		if (ret)
 			return ret;
+		if (unlikely(__mptcp_needs_tcp_fallback(msk)))
+			return 0;
 	}
 =

 	/* compute copy limit */
@@ -311,9 +313,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 	lock_sock(sk);
 	ssock =3D __mptcp_tcp_fallback(msk);
 	if (ssock) {
+fallback:
 		pr_debug("fallback passthrough");
 		ret =3D sock_sendmsg(ssock, msg);
-		return ret;
+		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
 	}
 =

 	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
@@ -332,6 +335,11 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
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
@@ -412,6 +420,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 	lock_sock(sk);
 	ssock =3D __mptcp_tcp_fallback(msk);
 	if (ssock) {
+fallback:
 		pr_debug("fallback-read subflow=3D%p",
 			 mptcp_subflow_ctx(ssock->sk));
 		copied =3D sock_recvmsg(ssock, msg, flags);
@@ -518,6 +527,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 		pr_debug("block timeout %ld", timeo);
 		wait_data =3D true;
 		mptcp_wait_data(sk, &timeo);
+		if (unlikely(__mptcp_tcp_fallback(msk)))
+			goto fallback;
 	}
 =

 	if (more_data_avail) {
@@ -1057,8 +1068,8 @@ static int mptcp_stream_accept(struct socket *sock, s=
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

@@ -1074,6 +1085,9 @@ static __poll_t mptcp_poll(struct file *file, struct =
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
-- =

2.21.0

--===============8200734845767359799==--
