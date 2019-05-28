Content-Type: multipart/mixed; boundary="===============0634697825847050059=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3] mptcp: Make mptcp initialization part of tcp
 initialization
Date: Tue, 28 May 2019 13:37:54 -0700
Message-ID: <20190528203754.25462-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1260

--===============0634697825847050059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove remnant module initialization of MPTCP and make it
part of the inet/tcp initialization sequence.

OK to squash but needs to be split up between
"mptcp: Add MPTCP socket stubs" and
"mptcp: Associate MPTCP context with TCP socket"

v2 - ignore
v3 - fix function declaration

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/mptcp.h  |  6 ++++++
 net/ipv4/tcp.c       |  2 ++
 net/mptcp/protocol.c | 22 +++-------------------
 net/mptcp/subflow.c  | 15 ++++++++++++---
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index ed67b140af33..65dd7f052e94 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -49,6 +49,8 @@ struct mptcp_out_options {
 =

 #ifdef CONFIG_MPTCP
 =

+void mptcp_init(void);
+
 static inline bool sk_is_mptcp(const struct sock *sk)
 {
 	return tcp_sk(sk)->is_mptcp;
@@ -84,6 +86,10 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out_o=
ptions *opts);
 =

 #else
 =

+static inline void mptcp_init(void)
+{
+}
+
 static inline bool sk_is_mptcp(const struct sock *sk)
 {
 	return false;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index cb072dce81a7..ab242851da3f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -275,6 +275,7 @@
 #include <net/icmp.h>
 #include <net/inet_common.h>
 #include <net/tcp.h>
+#include <net/mptcp.h>
 #include <net/xfrm.h>
 #include <net/ip.h>
 #include <net/sock.h>
@@ -3947,4 +3948,5 @@ void __init tcp_init(void)
 	tcp_metrics_init();
 	BUG_ON(tcp_register_congestion_control(&tcp_reno) !=3D 0);
 	tcp_tasklet_init();
+	mptcp_init();
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 06312efc0b90..d1c617852e0f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1009,7 +1009,7 @@ static struct inet_protosw mptcp_protosw =3D {
 	.flags		=3D INET_PROTOSW_ICSK,
 };
 =

-static int __init mptcp_init(void)
+void mptcp_init(void)
 {
 	int err;
 =

@@ -1036,26 +1036,10 @@ static int __init mptcp_init(void)
 =

 	inet_register_protosw(&mptcp_protosw);
 =

-	return 0;
-
+	return;
 proto_failed:
 	subflow_exit();
 =

 subflow_failed:
-	return err;
-}
-
-static void __exit mptcp_exit(void)
-{
-	inet_unregister_protosw(&mptcp_protosw);
-	proto_unregister(&mptcp_prot);
-
-	subflow_exit();
+	return;
 }
-
-module_init(mptcp_init);
-module_exit(mptcp_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_NET_PF_PROTO(PF_INET, IPPROTO_MPTCP);
-MODULE_ALIAS_NET_PF_PROTO(PF_INET6, IPPROTO_MPTCP);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bc8e1a0658ec..e4ae5c5d177d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -294,6 +294,12 @@ static int subflow_ops_init(struct request_sock_ops *s=
ubflow_ops)
 	return 0;
 }
 =

+static void subflow_ops_exit(void)
+{
+	kfree(subflow_request_sock_ops.slab_name);
+	kmem_cache_destroy(subflow_request_sock_ops.slab);
+}
+
 int subflow_init(void)
 {
 	int ret;
@@ -312,12 +318,15 @@ int subflow_init(void)
 	subflow_specific.sk_rx_dst_set =3D subflow_finish_connect;
 	subflow_specific.rebuild_header =3D subflow_rebuild_header;
 =

-	return tcp_register_ulp(&subflow_ulp_ops);
+	ret =3D tcp_register_ulp(&subflow_ulp_ops);
+	if (ret !=3D 0)
+		subflow_ops_exit();
+
+	return ret;
 }
 =

 void subflow_exit(void)
 {
 	tcp_unregister_ulp(&subflow_ulp_ops);
+	subflow_ops_exit();
 }
-
-MODULE_LICENSE("GPL");
-- =

2.17.2


--===============0634697825847050059==--
