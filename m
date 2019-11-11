Content-Type: multipart/mixed; boundary="===============3611639726760451933=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/4] mptcp: disable on req sk if MD5SIG is enabled
Date: Mon, 11 Nov 2019 17:53:51 +0100
Message-ID: <4efc3c8a58dc8e50c533b262860a63010b8babbd.1573488743.git.pabeni@redhat.com>
In-Reply-To: cover.1573488686.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2467

--===============3611639726760451933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Likley we want to update the "mptcp: Create SUBFLOW socket for incoming con=
nections"
commit message with something alike:

Explicitly disable MPTCP if MD5SIG is enable, to prevent TCP option space
exaustion.

Squash-to: mptcp: Create SUBFLOW socket for incoming connections
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 8 ++++++++
 net/mptcp/subflow.c  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 81b7c21f4d3c..bb297e9dd6c5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -342,6 +342,14 @@ static int mptcp_stream_connect(struct socket *sock, s=
truct sockaddr *uaddr,
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

+#ifdef CONFIG_TCP_MD5SIG
+	/* no MPTCP is MD5SIG is enabled on this socket or we may run out of
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
index 9b56fe9a83f2..4ab751163965 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -30,6 +30,14 @@ static void subflow_init_req(struct request_sock *req,
 =

 	subflow_req->mp_capable =3D 0;
 =

+#ifdef CONFIG_TCP_MD5SIG
+	/* no MPTCP is MD5SIG is enabled on this socket or we may run out of
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

--===============3611639726760451933==--
