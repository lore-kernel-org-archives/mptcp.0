Content-Type: multipart/mixed; boundary="===============8588121104083564629=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 3/4] mptcp: late fallback support
Date: Fri, 13 Dec 2019 15:33:51 +0100
Message-ID: <1ff9c849d5246c75ce15e707e1b3377958a08600.1576247361.git.pabeni@redhat.com>
In-Reply-To: cover.1576247361.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2939

--===============8588121104083564629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

passive connection can fallback tcp, too. Additionally it can happens
after that the subflow become established:

syn+ MP_CAPABLE ->
               <- syn, ack + MP_CAPABLE

ack, seq =3D 3    ->
        // OoO packet is accepted because in-sequence
        // passive socket is created, is in ESTABLISHED
	// status and tentatively as MP_CAPABLE

ack, seq =3D 2     ->
        // no MP_CAPABLE opt, subflow should fallback to TCP

Currently that will lead to disaster, in several nasty ways.

Deal with that "transitioning" the socket to tcp, replacing
socket->sk with the tcp subflow and rearranging all the link,
than calling the relevant operation on the now-tcp socket

Co-developed-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1d21b64b2149..999b1f89b3d6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -69,20 +69,32 @@ static struct socket *__mptcp_nmpc_socket(const struct =
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
+	if (!likely(__mptcp_needs_tcp_fallback(msk)))
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
@@ -301,7 +313,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	if (ssock) {
 		pr_debug("fallback passthrough");
 		ret =3D sock_sendmsg(ssock, msg);
-		release_sock(sk);
 		return ret;
 	}
 =

@@ -404,7 +415,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 		pr_debug("fallback-read subflow=3D%p",
 			 mptcp_subflow_ctx(ssock->sk));
 		copied =3D sock_recvmsg(ssock, msg, flags);
-		release_sock(sk);
 		return copied;
 	}
 =

-- =

2.21.0

--===============8588121104083564629==--
