Content-Type: multipart/mixed; boundary="===============0965782411971481769=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 2/4] mptcp: disable on req sk if MD5SIG is enabled
Date: Thu, 14 Nov 2019 19:15:50 +0100
Message-ID: <595f646e1de81c99ff3ed6393ff632366539f9db.1573738685.git.pabeni@redhat.com>
In-Reply-To: cover.1573738652.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2546

--===============0965782411971481769==
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
index 4d74cc601d35..b2d6555117de 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -339,6 +339,14 @@ static int mptcp_stream_connect(struct socket *sock, s=
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
index c21a12600ab7..c3aec2c003e5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -33,6 +33,14 @@ static void subflow_init_req(struct request_sock *req,
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

--===============0965782411971481769==--
