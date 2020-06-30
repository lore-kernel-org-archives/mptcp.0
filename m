Content-Type: multipart/mixed; boundary="===============4734344637409065208=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: do nonce initialization at subflow
 creation time
Date: Tue, 30 Jun 2020 16:38:26 +0200
Message-ID: <cc811b8707d488492fb8e33ed651aab456de6f72.1593527763.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4869

--===============4734344637409065208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This clean-up the code a bit, reduces the number of
used hooks and indirect call requested, and allow
better error reporting from __mptcp_subflow_connect()

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 54 +++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 548f9e347ff5..664aa9158363 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -29,34 +29,6 @@ static void SUBFLOW_REQ_INC_STATS(struct request_sock *r=
eq,
 	MPTCP_INC_STATS(sock_net(req_to_sk(req)), field);
 }
 =

-static int subflow_rebuild_header(struct sock *sk)
-{
-	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-	int local_id;
-
-	if (subflow->request_join && !subflow->local_nonce) {
-		struct mptcp_sock *msk =3D (struct mptcp_sock *)subflow->conn;
-
-		pr_debug("subflow=3D%p", sk);
-
-		do {
-			get_random_bytes(&subflow->local_nonce, sizeof(u32));
-		} while (!subflow->local_nonce);
-
-		if (subflow->local_id)
-			goto out;
-
-		local_id =3D mptcp_pm_get_local_id(msk, (struct sock_common *)sk);
-		if (local_id < 0)
-			return -EINVAL;
-
-		subflow->local_id =3D local_id;
-	}
-
-out:
-	return subflow->icsk_af_ops->rebuild_header(sk);
-}
-
 static void subflow_req_destructor(struct request_sock *req)
 {
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
@@ -984,7 +956,9 @@ int __mptcp_subflow_connect(struct sock *sk, int ifinde=
x,
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
 	struct sockaddr_storage addr;
+	int local_id =3D loc->id;
 	struct socket *sf;
+	struct sock *ssk;
 	u32 remote_token;
 	int addrlen;
 	int err;
@@ -996,7 +970,20 @@ int __mptcp_subflow_connect(struct sock *sk, int ifind=
ex,
 	if (err)
 		return err;
 =

-	subflow =3D mptcp_subflow_ctx(sf->sk);
+	ssk =3D sf->sk;
+	subflow =3D mptcp_subflow_ctx(ssk);
+	do {
+		get_random_bytes(&subflow->local_nonce, sizeof(u32));
+	} while (!subflow->local_nonce);
+
+	if (!local_id) {
+		err =3D mptcp_pm_get_local_id(msk, (struct sock_common *)ssk);
+		if (err < 0)
+			goto failed;
+
+		local_id =3D err;
+	}
+
 	subflow->remote_key =3D msk->remote_key;
 	subflow->local_key =3D msk->local_key;
 	subflow->token =3D msk->token;
@@ -1007,15 +994,16 @@ int __mptcp_subflow_connect(struct sock *sk, int ifi=
ndex,
 	if (loc->family =3D=3D AF_INET6)
 		addrlen =3D sizeof(struct sockaddr_in6);
 #endif
-	sf->sk->sk_bound_dev_if =3D ifindex;
+	ssk->sk_bound_dev_if =3D ifindex;
 	err =3D kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
 	if (err)
 		goto failed;
 =

 	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
-	pr_debug("msk=3D%p remote_token=3D%u", msk, remote_token);
+	pr_debug("msk=3D%p remote_token=3D%u local_id=3D%d", msk, remote_token,
+		 local_id);
 	subflow->remote_token =3D remote_token;
-	subflow->local_id =3D loc->id;
+	subflow->local_id =3D local_id;
 	subflow->request_join =3D 1;
 	subflow->request_bkup =3D 1;
 	mptcp_info2sockaddr(remote, &addr);
@@ -1288,7 +1276,6 @@ void __init mptcp_subflow_init(void)
 	subflow_specific.conn_request =3D subflow_v4_conn_request;
 	subflow_specific.syn_recv_sock =3D subflow_syn_recv_sock;
 	subflow_specific.sk_rx_dst_set =3D subflow_finish_connect;
-	subflow_specific.rebuild_header =3D subflow_rebuild_header;
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	subflow_request_sock_ipv6_ops =3D tcp_request_sock_ipv6_ops;
@@ -1298,7 +1285,6 @@ void __init mptcp_subflow_init(void)
 	subflow_v6_specific.conn_request =3D subflow_v6_conn_request;
 	subflow_v6_specific.syn_recv_sock =3D subflow_syn_recv_sock;
 	subflow_v6_specific.sk_rx_dst_set =3D subflow_finish_connect;
-	subflow_v6_specific.rebuild_header =3D subflow_rebuild_header;
 =

 	subflow_v6m_specific =3D subflow_v6_specific;
 	subflow_v6m_specific.queue_xmit =3D ipv4_specific.queue_xmit;
-- =

2.26.2

--===============4734344637409065208==--
