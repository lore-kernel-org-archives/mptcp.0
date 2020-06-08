Content-Type: multipart/mixed; boundary="===============3960836171551711593=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/3] Squash-to: "mptcp: refactor token container."
Date: Mon, 08 Jun 2020 23:51:30 +0200
Message-ID: <3937b1a365f3f679c4f09887ba372d310af52f48.1591652866.git.pabeni@redhat.com>
In-Reply-To: cover.1591652866.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4618

--===============3960836171551711593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move token creation into stream_connect(). This clean
the code a bit reducing the test in critical path and
plug a race: at shutdown time, subflow_rebuild_header()
can be called after the msk token is removed, leaving
a refecen to the to-be destroyed socket into the
token container with later UaF.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c |  6 +++++-
 net/mptcp/subflow.c  | 10 ++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 99c019879833..be09fd525f8f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1800,6 +1800,7 @@ static int mptcp_stream_connect(struct socket *sock, =
struct sockaddr *uaddr,
 				int addr_len, int flags)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct mptcp_subflow_context *subflow;
 	struct socket *ssock;
 	int err;
 =

@@ -1819,13 +1820,16 @@ static int mptcp_stream_connect(struct socket *sock=
, struct sockaddr *uaddr,
 		goto unlock;
 	}
 =

+	subflow =3D mptcp_subflow_ctx(ssock->sk);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
 	 * TCP option space.
 	 */
 	if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
-		mptcp_subflow_ctx(ssock->sk)->request_mptcp =3D 0;
+		subflow->request_mptcp =3D 0;
 #endif
+	if (subflow->request_mptcp && mptcp_token_new_connect(ssock->sk))
+		subflow->request_mptcp =3D 0;
 =

 do_connect:
 	err =3D ssock->ops->connect(ssock, uaddr, addr_len, flags);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fcb9ca9a9dce..2d30fafa1aed 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -34,13 +34,7 @@ static int subflow_rebuild_header(struct sock *sk)
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	int local_id;
 =

-	if (subflow->request_mptcp && sk_unhashed(subflow->conn)) {
-		pr_debug("subflow=3D%p", sk);
-		if (mptcp_token_new_connect(sk)) {
-			subflow->mp_capable =3D 0;
-			goto out;
-		}
-	} else if (subflow->request_join && !subflow->local_nonce) {
+	if (subflow->request_join && !subflow->local_nonce) {
 		struct mptcp_sock *msk =3D (struct mptcp_sock *)subflow->conn;
 =

 		pr_debug("subflow=3D%p", sk);
@@ -251,7 +245,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 		subflow->remote_nonce =3D mp_opt.nonce;
 		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u", subflow,
 			 subflow->thmac, subflow->remote_nonce);
-	} else if (subflow->request_mptcp) {
+	} else {
 		tp->is_mptcp =3D 0;
 	}
 =

-- =

2.21.3

--===============3960836171551711593==--
