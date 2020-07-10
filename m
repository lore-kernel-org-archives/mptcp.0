Content-Type: multipart/mixed; boundary="===============3015405619996693496=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 3/9] mptcp: mark as fallback even early ones
Date: Fri, 10 Jul 2020 19:22:12 +0200
Message-ID: <22af4673749f14e61117091bb40214e3e50febcb.1594401165.git.pabeni@redhat.com>
In-Reply-To: cover.1594401165.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4980

--===============3015405619996693496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the unlikely event of a failure at connect time,
we currently clear the request_mptcp flag - so that
the MPC handshake is not started at all, but the msk
is not explicitly marked as fallback.

This would lead to later insertion of wrong DSS options
in the xmitted packets, in violation of RFC specs and
possibly fooling the peer.

Fixes: e1ff9e82e2ea ("net: mptcp: improve fallback to TCP")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2986637fc39e..15358d676020 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1949,6 +1949,13 @@ static int mptcp_bind(struct socket *sock, struct so=
ckaddr *uaddr, int addr_len)
 	return err;
 }
 =

+static void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
+					 struct mptcp_subflow_context *subflow)
+{
+	subflow->request_mptcp =3D 0;
+	__mptcp_do_fallback(msk);
+}
+
 static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uadd=
r,
 				int addr_len, int flags)
 {
@@ -1980,10 +1987,10 @@ static int mptcp_stream_connect(struct socket *sock=
, struct sockaddr *uaddr,
 	 * TCP option space.
 	 */
 	if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
-		subflow->request_mptcp =3D 0;
+		mptcp_subflow_early_fallback(msk, subflow);
 #endif
 	if (subflow->request_mptcp && mptcp_token_new_connect(ssock->sk))
-		subflow->request_mptcp =3D 0;
+		mptcp_subflow_early_fallback(msk, subflow);
 =

 do_connect:
 	err =3D ssock->ops->connect(ssock, uaddr, addr_len, flags);
-- =

2.26.2

--===============3015405619996693496==--
