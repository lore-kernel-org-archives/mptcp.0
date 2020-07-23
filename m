Content-Type: multipart/mixed; boundary="===============0683854327328830368=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 3/8] mptcp: mark as fallback even early ones
Date: Thu, 23 Jul 2020 13:02:31 +0200
Message-ID: <1fa72209d016ee555828b18bc3675784d416d543.1595431326.git.pabeni@redhat.com>
In-Reply-To: cover.1595431326.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5234

--===============0683854327328830368==
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
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Tested-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 254e6ef2b4e0..2936413171be 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1944,6 +1944,13 @@ static int mptcp_bind(struct socket *sock, struct so=
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
@@ -1975,10 +1982,10 @@ static int mptcp_stream_connect(struct socket *sock=
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

--===============0683854327328830368==--
