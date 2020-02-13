Content-Type: multipart/mixed; boundary="===============6330302398136215378=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net v2 1/3] mptcp: Keep TCP fallback subflow valid
 after lookup
Date: Thu, 13 Feb 2020 12:38:34 -0800
Message-ID: <20200213203836.225812-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200213203836.225812-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3654

--===============6330302398136215378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When __mptcp_tcp_fallback() returns a subflow socket pointer, that
pointer needs to remain valid while normal TCP functions are called
using that pointer. By making the __mptcp_tcp_fallback() caller
responsible for releasing the MPTCP socket lock and making sure the
function does not return a closed subflow, the subflow socket can be
safely used.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 030dee668e0a..a8faf66c38d8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -55,10 +55,8 @@ static struct socket *__mptcp_tcp_fallback(struct mptcp_=
sock *msk)
 	if (likely(!__mptcp_needs_tcp_fallback(msk)))
 		return NULL;
 =

-	if (msk->subflow) {
-		release_sock((struct sock *)msk);
+	if (msk->subflow)
 		return msk->subflow;
-	}
 =

 	return NULL;
 }
@@ -282,6 +280,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	if (unlikely(ssock)) {
 fallback:
 		pr_debug("fallback passthrough");
+		release_sock(sk);
 		ret =3D sock_sendmsg(ssock, msg);
 		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
 	}
@@ -391,6 +390,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 fallback:
 		pr_debug("fallback-read subflow=3D%p",
 			 mptcp_subflow_ctx(ssock->sk));
+		release_sock(sk);
 		copied =3D sock_recvmsg(ssock, msg, flags);
 		return copied;
 	}
@@ -599,6 +599,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 	inet_sk_state_store(sk, TCP_CLOSE);
 =

 	list_splice_init(&msk->conn_list, &conn_list);
+	msk->subflow =3D NULL;
 =

 	release_sock(sk);
 =

@@ -1084,8 +1085,11 @@ static __poll_t mptcp_poll(struct file *file, struct=
 socket *sock,
 	sock_poll_wait(file, sock, wait);
 	lock_sock(sk);
 	ssock =3D __mptcp_tcp_fallback(msk);
-	if (unlikely(ssock))
-		return ssock->ops->poll(file, ssock, NULL);
+	if (unlikely(ssock)) {
+		mask =3D ssock->ops->poll(file, ssock, NULL);
+		release_sock(sk);
+		return mask;
+	}
 =

 	if (test_bit(MPTCP_DATA_READY, &msk->flags))
 		mask =3D EPOLLIN | EPOLLRDNORM;
-- =

2.25.0

--===============6330302398136215378==--
