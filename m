Content-Type: multipart/mixed; boundary="===============2495325863610259340=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 7/9] Move setting request_ fields of subflow to MPTCP
 layer
Date: Wed, 17 Jul 2019 15:12:54 -0700
Message-ID: <20190717221256.7358-8-peter.krystad@linux.intel.com>
In-Reply-To: 20190717221256.7358-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1518

--===============2495325863610259340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For secondary subflows a different set of request_ fields will
be added that will be set differently based on subflow type
(initial vs secondary).

squashto: Associate MPTCP context with TCP socket

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 13 +++++++++++++
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  7 ++-----
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1664a69c8e30..fe73379a81df 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -840,6 +840,7 @@ static int mptcp_stream_connect(struct socket *sock, st=
ruct sockaddr *uaddr,
 				int addr_len, int flags)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct subflow_context *subflow;
 	int err =3D -ENOTSUPP;
 =

 	pr_debug("msk=3D%p", msk);
@@ -853,6 +854,11 @@ static int mptcp_stream_connect(struct socket *sock, s=
truct sockaddr *uaddr,
 			return err;
 	}
 =

+	subflow =3D subflow_ctx(msk->subflow->sk);
+	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
+	subflow->request_cksum =3D 1; /* @@ if checksum enabled */
+	subflow->request_version =3D 0; /* only v0 supported */
+
 	return inet_stream_connect(msk->subflow, uaddr, addr_len, flags);
 }
 =

@@ -902,6 +908,7 @@ static int mptcp_getname(struct socket *sock, struct so=
ckaddr *uaddr,
 static int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct subflow_context *subflow;
 	int err;
 =

 	pr_debug("msk=3D%p", msk);
@@ -911,6 +918,12 @@ static int mptcp_listen(struct socket *sock, int backl=
og)
 		if (err)
 			return err;
 	}
+
+	subflow =3D subflow_ctx(msk->subflow->sk);
+	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
+	subflow->request_cksum =3D 1; /* @@ if checksum enabled */
+	subflow->request_version =3D 0; /* only v0 supported */
+
 	return inet_listen(msk->subflow, backlog);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ff4f38da9276..1ce9130dee66 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -168,10 +168,10 @@ struct subflow_context {
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
index 32652f7d1497..b9a40cdb1d4d 100644
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
@@ -224,9 +224,6 @@ int subflow_create_socket(struct sock *sk, struct socke=
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


--===============2495325863610259340==--
