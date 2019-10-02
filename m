Content-Type: multipart/mixed; boundary="===============8248264424682886447=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp:diag: prefix exposed items
Date: Wed, 02 Oct 2019 21:08:59 +0200
Message-ID: <20191002190859.29384-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1999

--===============8248264424682886447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To conform with the rest.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 include/uapi/linux/mptcp.h | 18 +++++++++---------
 net/mptcp/diag.c           | 22 +++++++++++-----------
 net/mptcp/protocol.h       |  4 ++--
 net/mptcp/subflow.c        |  4 ++--
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 2856b89cc36e..04bd134c1807 100644
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
+#define MPTCP_SUBFLOW_FLAGS_MCAP_REM	BIT(0)
+#define MPTCP_SUBFLOW_FLAGS_MCAP_LOC	BIT(1)
+#define MPTCP_SUBFLOW_FLAGS_JOIN_REM	BIT(2)
+#define MPTCP_SUBFLOW_FLAGS_JOIN_LOC	BIT(3)
+#define MPTCP_SUBFLOW_FLAGS_BKUP_REM	BIT(4)
+#define MPTCP_SUBFLOW_FLAGS_BKUP_LOC	BIT(5)
+#define MPTCP_SUBFLOW_FLAGS_4THACK	BIT(6)
+#define MPTCP_SUBFLOW_FLAGS_CONNECTED	BIT(7)
+#define MPTCP_SUBFLOW_FLAGS_MAPVALID	BIT(8)
 =

 enum {
 	MPTCP_SUBFLOW_UNSPEC,
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 27acd1ad485c..0e4607d56fe5 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -13,7 +13,7 @@
 #include <uapi/linux/mptcp.h>
 #include "protocol.h"
 =

-int subflow_get_info(const struct sock *sk, struct sk_buff *skb)
+int mptcp_diag_subflow_get_info(const struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *sf;
 	struct nlattr *start;
@@ -32,23 +32,23 @@ int subflow_get_info(const struct sock *sk, struct sk_b=
uff *skb)
 	}
 =

 	if (sf->mp_capable)
-		flags |=3D SUBFLOW_FLAGS_MCAP_REM;
+		flags |=3D MPTCP_SUBFLOW_FLAGS_MCAP_REM;
 	if (sf->request_mptcp)
-		flags |=3D SUBFLOW_FLAGS_MCAP_LOC;
+		flags |=3D MPTCP_SUBFLOW_FLAGS_MCAP_LOC;
 	if (sf->mp_join)
-		flags |=3D SUBFLOW_FLAGS_JOIN_REM;
+		flags |=3D MPTCP_SUBFLOW_FLAGS_JOIN_REM;
 	if (sf->request_join)
-		flags |=3D SUBFLOW_FLAGS_JOIN_LOC;
+		flags |=3D MPTCP_SUBFLOW_FLAGS_JOIN_LOC;
 	if (sf->backup)
-		flags |=3D SUBFLOW_FLAGS_BKUP_REM;
+		flags |=3D MPTCP_SUBFLOW_FLAGS_BKUP_REM;
 	if (sf->request_bkup)
-		flags |=3D SUBFLOW_FLAGS_BKUP_LOC;
+		flags |=3D MPTCP_SUBFLOW_FLAGS_BKUP_LOC;
 	if (sf->fourth_ack)
-		flags |=3D SUBFLOW_FLAGS_4THACK;
+		flags |=3D MPTCP_SUBFLOW_FLAGS_4THACK;
 	if (sf->conn_finished)
-		flags |=3D SUBFLOW_FLAGS_CONNECTED;
+		flags |=3D MPTCP_SUBFLOW_FLAGS_CONNECTED;
 	if (sf->map_valid)
-		flags |=3D SUBFLOW_FLAGS_MAPVALID;
+		flags |=3D MPTCP_SUBFLOW_FLAGS_MAPVALID;
 =

 	if (nla_put_u32(skb, MPTCP_SUBFLOW_TOKEN_REM, sf->remote_token) ||
 	    nla_put_u32(skb, MPTCP_SUBFLOW_TOKEN_LOC, sf->token) ||
@@ -75,7 +75,7 @@ int subflow_get_info(const struct sock *sk, struct sk_buf=
f *skb)
 	return err;
 }
 =

-size_t subflow_get_info_size(const struct sock *sk)
+size_t mptcp_diag_subflow_get_info_size(const struct sock *sk)
 {
 	size_t size =3D 0;
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 25f62679903e..452e873dc722 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -313,7 +313,7 @@ static inline bool before64(__u64 seq1, __u64 seq2)
 =

 #define after64(seq2, seq1)	before64(seq1, seq2)
 =

-size_t subflow_get_info_size(const struct sock *sk);
-int subflow_get_info(const struct sock *sk, struct sk_buff *skb);
+size_t mptcp_diag_subflow_get_info_size(const struct sock *sk);
+int mptcp_diag_subflow_get_info(const struct sock *sk, struct sk_buff *skb=
);
 =

 #endif /* __MPTCP_PROTOCOL_H */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0f4a2a19d246..99cbb8351584 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -492,8 +492,8 @@ static struct tcp_ulp_ops subflow_ulp_ops __read_mostly=
 =3D {
 	.init		=3D subflow_ulp_init,
 	.release	=3D subflow_ulp_release,
 	.clone		=3D subflow_ulp_clone,
-	.get_info	=3D subflow_get_info,
-	.get_info_size	=3D subflow_get_info_size,
+	.get_info	=3D mptcp_diag_subflow_get_info,
+	.get_info_size	=3D mptcp_diag_subflow_get_info_size,
 };
 =

 static int subflow_ops_init(struct request_sock_ops *subflow_ops)
-- =

2.20.1

--===============8248264424682886447==--
