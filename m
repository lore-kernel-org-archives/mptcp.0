Content-Type: multipart/mixed; boundary="===============0071511284627026049=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/4] mptcp: disable on req sk if MD5SIG is enabled
Date: Wed, 13 Nov 2019 09:00:19 +0100
Message-ID: <e4014c9ef5dd1cca06eccffbc2b31ca9c0fa87ee.1573552896.git.pabeni@redhat.com>
In-Reply-To: cover.1573552877.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2502

--===============0071511284627026049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Squash-to: mptcp: Create SUBFLOW socket for incoming connections
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v1 -> v2
 - fix comment typo
---
 net/mptcp/protocol.c | 8 ++++++++
 net/mptcp/subflow.c  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 81b7c21f4d3c..f68da3c41172 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -342,6 +342,14 @@ static int mptcp_stream_connect(struct socket *sock, s=
truct sockaddr *uaddr,
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

+#ifdef CONFIG_TCP_MD5SIG
+	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
+	 * TCP option space.
+	 */
+	if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
+		mptcp_subflow_ctx(ssock->sk)->request_mptcp =3D 0;
+#endif
+
 	err =3D ssock->ops->connect(ssock, uaddr, addr_len, flags);
 	sock_put(ssock->sk);
 	return err;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9b56fe9a83f2..5a832677fd97 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -30,6 +30,14 @@ static void subflow_init_req(struct request_sock *req,
 =

 	subflow_req->mp_capable =3D 0;
 =

+#ifdef CONFIG_TCP_MD5SIG
+	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
+	 * TCP option space.
+	 */
+	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info))
+		return;
+#endif
+
 	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
 		subflow_req->mp_capable =3D 1;
 		if (rx_opt.mptcp.version >=3D listener->request_version)
-- =

2.21.0

--===============0071511284627026049==--
