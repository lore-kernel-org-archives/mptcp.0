Content-Type: multipart/mixed; boundary="===============5345367957692028890=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 6/0006] Squash-to: "mptcp: allow dumping subflow
 context to userspace"
Date: Wed, 04 Mar 2020 16:02:05 +0100
Message-ID: <bd09b746907c90b322b5ae7bc296e99d366d0739.1583334095.git.pabeni@redhat.com>
In-Reply-To: cover.1583334095.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3854

--===============5345367957692028890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

fix after field name change.

Additionally rename the exposed uAPI flags to be more consistent

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/uapi/linux/mptcp.h | 18 +++++++++---------
 net/mptcp/diag.c           |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index d087048fb4a2..c564140d20f0 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -4,15 +4,15 @@
 =

 #include <linux/types.h>
 =

-#define MPTCP_SUBFLOW_FLAG_MCAP_REM	BIT(0)
-#define MPTCP_SUBFLOW_FLAG_MCAP_LOC	BIT(1)
-#define MPTCP_SUBFLOW_FLAG_JOIN_REM	BIT(2)
-#define MPTCP_SUBFLOW_FLAG_JOIN_LOC	BIT(3)
-#define MPTCP_SUBFLOW_FLAG_BKUP_REM	BIT(4)
-#define MPTCP_SUBFLOW_FLAG_BKUP_LOC	BIT(5)
-#define MPTCP_SUBFLOW_FLAG_4THACK	BIT(6)
-#define MPTCP_SUBFLOW_FLAG_CONNECTED	BIT(7)
-#define MPTCP_SUBFLOW_FLAG_MAPVALID	BIT(8)
+#define MPTCP_SUBFLOW_FLAG_MCAP_REM		BIT(0)
+#define MPTCP_SUBFLOW_FLAG_MCAP_LOC		BIT(1)
+#define MPTCP_SUBFLOW_FLAG_JOIN_REM		BIT(2)
+#define MPTCP_SUBFLOW_FLAG_JOIN_LOC		BIT(3)
+#define MPTCP_SUBFLOW_FLAG_BKUP_REM		BIT(4)
+#define MPTCP_SUBFLOW_FLAG_BKUP_LOC		BIT(5)
+#define MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED	BIT(6)
+#define MPTCP_SUBFLOW_FLAG_CONNECTED		BIT(7)
+#define MPTCP_SUBFLOW_FLAG_MAPVALID		BIT(8)
 =

 enum {
 	MPTCP_SUBFLOW_ATTR_UNSPEC,
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 4b6d9f7e418f..a536586742f2 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -43,8 +43,8 @@ static int subflow_get_info(const struct sock *sk, struct=
 sk_buff *skb)
 		flags |=3D MPTCP_SUBFLOW_FLAG_BKUP_REM;
 	if (sf->request_bkup)
 		flags |=3D MPTCP_SUBFLOW_FLAG_BKUP_LOC;
-	if (sf->fourth_ack)
-		flags |=3D MPTCP_SUBFLOW_FLAG_4THACK;
+	if (sf->fully_established)
+		flags |=3D MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED;
 	if (sf->conn_finished)
 		flags |=3D MPTCP_SUBFLOW_FLAG_CONNECTED;
 	if (sf->map_valid)
-- =

2.21.1

--===============5345367957692028890==--
