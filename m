Content-Type: multipart/mixed; boundary="===============7782345531618734108=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 07/10] Move setting request_ fields of subflow to
 MPTCP layer helper
Date: Thu, 25 Jul 2019 18:58:24 -0700
Message-ID: <20190726015827.10637-8-peter.krystad@linux.intel.com>
In-Reply-To: 20190726015827.10637-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1563

--===============7782345531618734108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For secondary subflows different request_ fields will
be added that will be set differently based on subflow type
(initial vs secondary).

squashto: Associate MPTCP context with TCP socket

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 6 ++++++
 net/mptcp/protocol.h | 2 +-
 net/mptcp/subflow.c  | 7 ++-----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8a841d489b52..4d4a9c3d25c4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -860,6 +860,7 @@ static struct proto mptcp_prot =3D {
 static struct socket *mptcp_socket_create_get(struct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
+	struct subflow_context *subflow;
 	struct socket *ssock;
 	int err;
 =

@@ -875,6 +876,11 @@ static struct socket *mptcp_socket_create_get(struct m=
ptcp_sock *msk)
 	}
 =

 	msk->subflow =3D ssock;
+	subflow =3D subflow_ctx(msk->subflow->sk);
+	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
+	subflow->request_cksum =3D 1; /* @@ if checksum enabled */
+	subflow->request_version =3D 0; /* only v0 supported */
+
 	sock_hold(ssock->sk);
 =

 release:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 591cebcf1bfa..2891715a82f0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -169,10 +169,10 @@ struct subflow_context {
 	u16	map_data_len;
 	u16	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_cksum : 1,
+		request_version : 4,
 		mp_capable : 1,     /* remote is MPTCP capable */
 		mp_join : 1,        /* remote is JOINing */
 		fourth_ack : 1,     /* send initial DSS */
-		version : 4,
 		conn_finished : 1,
 		use_checksum : 1,
 		map_valid : 1,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9d91014c0d1b..678fca99c23a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -62,8 +62,8 @@ static void subflow_v4_init_req(struct request_sock *req,
 =

 	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
 		subflow_req->mp_capable =3D 1;
-		if (rx_opt.mptcp.version >=3D listener->version)
-			subflow_req->version =3D listener->version;
+		if (rx_opt.mptcp.version >=3D listener->request_version)
+			subflow_req->version =3D listener->request_version;
 		else
 			subflow_req->version =3D rx_opt.mptcp.version;
 		if ((rx_opt.mptcp.flags & MPTCP_CAP_CHECKSUM_REQD) ||
@@ -218,9 +218,6 @@ int subflow_create_socket(struct sock *sk, struct socke=
t **new_sock)
 =

 	*new_sock =3D sf;
 	subflow->conn =3D sk;
-	subflow->request_mptcp =3D 1; // @@ if MPTCP enabled
-	subflow->request_cksum =3D 1; // @@ if checksum enabled
-	subflow->version =3D 0;
 =

 	return 0;
 }
-- =

2.17.2


--===============7782345531618734108==--
