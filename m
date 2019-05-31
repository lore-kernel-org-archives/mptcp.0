Content-Type: multipart/mixed; boundary="===============0065950332277389425=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp:init: panic in case of error
Date: Fri, 31 May 2019 17:18:44 +0200
Message-ID: <20190531151844.17972-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1274

--===============0065950332277389425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The idea is to mimic what is done in tcp_init() and not ignore errors
from the init phase. It also simplifies the code as we don't have to
manage exit parts anymore.

Can be squashed in:
- "mptcp: Add MPTCP socket stubs" (mptcp_init())
- "mptcp: Associate MPTCP context with TCP socket" (subflow_init())
- "mptcp: Create SUBFLOW socket for incoming connections" (subflow_ops)

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/protocol.c | 20 ++++----------------
 net/mptcp/protocol.h |  3 +--
 net/mptcp/subflow.c  | 27 +++++----------------------
 3 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4e809719dcfd..b342cd4115da 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -992,10 +992,8 @@ static struct inet_protosw mptcp_protosw =3D {
 	.flags		=3D INET_PROTOSW_ICSK,
 };
 =

-void mptcp_init(void)
+void __init mptcp_init(void)
 {
-	int err;
-
 	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
 	mptcp_stream_ops =3D inet_stream_ops;
 	mptcp_stream_ops.bind =3D mptcp_bind;
@@ -1008,22 +1006,12 @@ void mptcp_init(void)
 =

 	token_init();
 	crypto_init();
+	subflow_init();
 =

-	err =3D subflow_init();
-	if (err)
-		goto subflow_failed;
-
-	err =3D proto_register(&mptcp_prot, 1);
-	if (err)
-		goto proto_failed;
+	if (proto_register(&mptcp_prot, 1) !=3D 0)
+		panic("Failed to register MPTCP proto.\n");
 =

 	inet_register_protosw(&mptcp_protosw);
 =

 	return;
-
-proto_failed:
-	subflow_exit();
-
-subflow_failed:
-	return;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 258325e42fa4..c1a39e31f641 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -105,8 +105,7 @@ static inline struct socket *mptcp_subflow_tcp_socket(c=
onst struct subflow_conte
 	return subflow->tcp_sock;
 }
 =

-int subflow_init(void);
-void subflow_exit(void);
+void subflow_init(void);
 =

 extern const struct inet_connection_sock_af_ops ipv4_specific;
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1b8ec517c687..19f36ba6841f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -286,19 +286,11 @@ static int subflow_ops_init(struct request_sock_ops *=
subflow_ops)
 	return 0;
 }
 =

-static void subflow_ops_exit(void)
+void subflow_init(void)
 {
-	kmem_cache_destroy(subflow_request_sock_ops.slab);
-}
-
-int subflow_init(void)
-{
-	int ret;
-
 	subflow_request_sock_ops =3D tcp_request_sock_ops;
-	ret =3D subflow_ops_init(&subflow_request_sock_ops);
-	if (ret !=3D 0)
-		return ret;
+	if (subflow_ops_init(&subflow_request_sock_ops) !=3D 0)
+		panic("MPTCP: failed to init subflow request sock ops");
 =

 	subflow_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
 	subflow_request_sock_ipv4_ops.init_req =3D subflow_v4_init_req;
@@ -309,15 +301,6 @@ int subflow_init(void)
 	subflow_specific.sk_rx_dst_set =3D subflow_finish_connect;
 	subflow_specific.rebuild_header =3D subflow_rebuild_header;
 =

-	ret =3D tcp_register_ulp(&subflow_ulp_ops);
-	if (ret !=3D 0)
-		subflow_ops_exit();
-
-	return ret;
-}
-
-void subflow_exit(void)
-{
-	tcp_unregister_ulp(&subflow_ulp_ops);
-	subflow_ops_exit();
+	if (tcp_register_ulp(&subflow_ulp_ops) !=3D 0)
+		panic("MPTCP: failed to register subflows to ULP");
 }
-- =

2.20.1


--===============0065950332277389425==--
