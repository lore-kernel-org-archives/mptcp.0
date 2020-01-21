Content-Type: multipart/mixed; boundary="===============8761699662963539083=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] Squash-to: "mptcp: cope with later TCP fallback"
Date: Tue, 21 Jan 2020 21:49:09 +0100
Message-ID: <4da2ded92f9b41cd1bf77a1fe235e694e0d2cdf9.1579639542.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3456

--===============8761699662963539083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kbuildbot reported a build breakage with IPV6 disabled.

v1 -> v2:
 - fixed preprocessor conditional (Mat)
 - fixed SoB (Mat)

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6da609791c7a..69b229607ab8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -26,6 +26,15 @@
 =

 static void __mptcp_close(struct sock *sk, long timeout);
 =

+static const struct proto_ops * tcp_proto_ops(struct sock *sk)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family =3D=3D AF_INET6)
+		return &inet6_stream_ops;
+#endif
+	return &inet_stream_ops;
+}
+
 /* MP_CAPABLE handshake failed, convert msk to plain tcp, replacing
  * socket->sk and stream ops and destroying msk
  * return the msk socket, as we can't access msk anymore after this functi=
on
@@ -60,8 +69,7 @@ static struct socket *__mptcp_fallback_to_tcp(struct mptc=
p_sock *msk,
 		subflow->conn =3D NULL;
 	}
 	release_sock(ssk);
-	sock->ops =3D sk->sk_family =3D=3D AF_INET6 ? &inet6_stream_ops :
-						&inet_stream_ops;
+	sock->ops =3D tcp_proto_ops(ssk);
 =

 	/* destroy the left-over msk sock */
 	__mptcp_close(sk, 0);
-- =

2.21.0

--===============8761699662963539083==--
