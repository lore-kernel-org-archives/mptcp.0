Content-Type: multipart/mixed; boundary="===============3982835965715443807=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] mptcp:diag: prefix exposed items
Date: Sat, 05 Oct 2019 10:49:06 +0200
Message-ID: <20191005084906.8960-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2023

--===============3982835965715443807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To conform with the rest.

And only exposed one init function for diag.c

Suggested-by: Davide Caratti <dcaratti(a)redhat.com>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    To be squashed in "mptcp: allow dumping subflow context to userspace"
    v2:
     - MPTCP_SUBFLOW_FLAGS_ -> MPTCP_SUBFLOW_FLAG_ (Davide)
     - only exposed a new function: mptcp_diag_subflow_init (Davide, Paolo)

 include/uapi/linux/mptcp.h | 18 +++++++++---------
 net/mptcp/diag.c           | 28 +++++++++++++++++-----------
 net/mptcp/protocol.h       |  3 +--
 net/mptcp/subflow.c        |  4 ++--
 4 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 2856b89cc36e..3912a9808fa2 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -4,15 +4,15 @@
 =

 #include <linux/types.h>
 =

-#define SUBFLOW_FLAGS_MCAP_REM		BIT(0)
-#define SUBFLOW_FLAGS_MCAP_LOC		BIT(1)
-#define SUBFLOW_FLAGS_JOIN_REM		BIT(2)
-#define SUBFLOW_FLAGS_JOIN_LOC		BIT(3)
-#define SUBFLOW_FLAGS_BKUP_REM		BIT(4)
-#define SUBFLOW_FLAGS_BKUP_LOC		BIT(5)
-#define SUBFLOW_FLAGS_4THACK		BIT(6)
-#define SUBFLOW_FLAGS_CONNECTED		BIT(7)
-#define SUBFLOW_FLAGS_MAPVALID		BIT(8)
+#define MPTCP_SUBFLOW_FLAG_MCAP_REM	BIT(0)
+#define MPTCP_SUBFLOW_FLAG_MCAP_LOC	BIT(1)
+#define MPTCP_SUBFLOW_FLAG_JOIN_REM	BIT(2)
+#define MPTCP_SUBFLOW_FLAG_JOIN_LOC	BIT(3)
+#define MPTCP_SUBFLOW_FLAG_BKUP_REM	BIT(4)
+#define MPTCP_SUBFLOW_FLAG_BKUP_LOC	BIT(5)
+#define MPTCP_SUBFLOW_FLAG_4THACK	BIT(6)
+#define MPTCP_SUBFLOW_FLAG_CONNECTED	BIT(7)
+#define MPTCP_SUBFLOW_FLAG_MAPVALID	BIT(8)
 =

 enum {
 	MPTCP_SUBFLOW_UNSPEC,
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 27acd1ad485c..830a2adfc0fa 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -13,7 +13,7 @@
 #include <uapi/linux/mptcp.h>
 #include "protocol.h"
 =

-int subflow_get_info(const struct sock *sk, struct sk_buff *skb)
+static int subflow_get_info(const struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *sf;
 	struct nlattr *start;
@@ -32,23 +32,23 @@ int subflow_get_info(const struct sock *sk, struct sk_b=
uff *skb)
 	}
 =

 	if (sf->mp_capable)
-		flags |=3D SUBFLOW_FLAGS_MCAP_REM;
+		flags |=3D MPTCP_SUBFLOW_FLAG_MCAP_REM;
 	if (sf->request_mptcp)
-		flags |=3D SUBFLOW_FLAGS_MCAP_LOC;
+		flags |=3D MPTCP_SUBFLOW_FLAG_MCAP_LOC;
 	if (sf->mp_join)
-		flags |=3D SUBFLOW_FLAGS_JOIN_REM;
+		flags |=3D MPTCP_SUBFLOW_FLAG_JOIN_REM;
 	if (sf->request_join)
-		flags |=3D SUBFLOW_FLAGS_JOIN_LOC;
+		flags |=3D MPTCP_SUBFLOW_FLAG_JOIN_LOC;
 	if (sf->backup)
-		flags |=3D SUBFLOW_FLAGS_BKUP_REM;
+		flags |=3D MPTCP_SUBFLOW_FLAG_BKUP_REM;
 	if (sf->request_bkup)
-		flags |=3D SUBFLOW_FLAGS_BKUP_LOC;
+		flags |=3D MPTCP_SUBFLOW_FLAG_BKUP_LOC;
 	if (sf->fourth_ack)
-		flags |=3D SUBFLOW_FLAGS_4THACK;
+		flags |=3D MPTCP_SUBFLOW_FLAG_4THACK;
 	if (sf->conn_finished)
-		flags |=3D SUBFLOW_FLAGS_CONNECTED;
+		flags |=3D MPTCP_SUBFLOW_FLAG_CONNECTED;
 	if (sf->map_valid)
-		flags |=3D SUBFLOW_FLAGS_MAPVALID;
+		flags |=3D MPTCP_SUBFLOW_FLAG_MAPVALID;
 =

 	if (nla_put_u32(skb, MPTCP_SUBFLOW_TOKEN_REM, sf->remote_token) ||
 	    nla_put_u32(skb, MPTCP_SUBFLOW_TOKEN_LOC, sf->token) ||
@@ -75,7 +75,7 @@ int subflow_get_info(const struct sock *sk, struct sk_buf=
f *skb)
 	return err;
 }
 =

-size_t subflow_get_info_size(const struct sock *sk)
+static size_t subflow_get_info_size(const struct sock *sk)
 {
 	size_t size =3D 0;
 =

@@ -93,3 +93,9 @@ size_t subflow_get_info_size(const struct sock *sk)
 		0;
 	return size;
 }
+
+void mptcp_diag_subflow_init(struct tcp_ulp_ops *ops)
+{
+	ops->get_info =3D subflow_get_info;
+	ops->get_info_size =3D subflow_get_info_size;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ecbabf794fd3..3c66f69a734d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -315,7 +315,6 @@ static inline bool before64(__u64 seq1, __u64 seq2)
 =

 #define after64(seq2, seq1)	before64(seq1, seq2)
 =

-size_t subflow_get_info_size(const struct sock *sk);
-int subflow_get_info(const struct sock *sk, struct sk_buff *skb);
+void mptcp_diag_subflow_init(struct tcp_ulp_ops *ops);
 =

 #endif /* __MPTCP_PROTOCOL_H */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ab93dd86e33d..ebe93525b0aa 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -505,8 +505,6 @@ static struct tcp_ulp_ops subflow_ulp_ops __read_mostly=
 =3D {
 	.init		=3D subflow_ulp_init,
 	.release	=3D subflow_ulp_release,
 	.clone		=3D subflow_ulp_clone,
-	.get_info	=3D subflow_get_info,
-	.get_info_size	=3D subflow_get_info_size,
 };
 =

 static int subflow_ops_init(struct request_sock_ops *subflow_ops)
@@ -542,6 +540,8 @@ void mptcp_subflow_init(void)
 	subflow_specific.sk_rx_dst_set =3D subflow_finish_connect;
 	subflow_specific.rebuild_header =3D subflow_rebuild_header;
 =

+	mptcp_diag_subflow_init(&subflow_ulp_ops);
+
 	if (tcp_register_ulp(&subflow_ulp_ops) !=3D 0)
 		panic("MPTCP: failed to register subflows to ULP\n");
 }
-- =

2.20.1

--===============3982835965715443807==--
