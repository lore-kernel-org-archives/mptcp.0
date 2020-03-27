Content-Type: multipart/mixed; boundary="===============8334450844170377029=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] squashto: mptcp: allow dumping subflow context to
 userspace
Date: Fri, 27 Mar 2020 12:58:17 -0700
Message-ID: <20200327195817.122912-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4097

--===============8334450844170377029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use bit macros appropriate for userspace.

Suggested-by: Davide Caratti <dcaratti(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/uapi/linux/mptcp.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index c564140d20f0..8acc78b7ca7c 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -4,15 +4,15 @@
 =

 #include <linux/types.h>
 =

-#define MPTCP_SUBFLOW_FLAG_MCAP_REM		BIT(0)
-#define MPTCP_SUBFLOW_FLAG_MCAP_LOC		BIT(1)
-#define MPTCP_SUBFLOW_FLAG_JOIN_REM		BIT(2)
-#define MPTCP_SUBFLOW_FLAG_JOIN_LOC		BIT(3)
-#define MPTCP_SUBFLOW_FLAG_BKUP_REM		BIT(4)
-#define MPTCP_SUBFLOW_FLAG_BKUP_LOC		BIT(5)
-#define MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED	BIT(6)
-#define MPTCP_SUBFLOW_FLAG_CONNECTED		BIT(7)
-#define MPTCP_SUBFLOW_FLAG_MAPVALID		BIT(8)
+#define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
+#define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
+#define MPTCP_SUBFLOW_FLAG_JOIN_REM		_BITUL(2)
+#define MPTCP_SUBFLOW_FLAG_JOIN_LOC		_BITUL(3)
+#define MPTCP_SUBFLOW_FLAG_BKUP_REM		_BITUL(4)
+#define MPTCP_SUBFLOW_FLAG_BKUP_LOC		_BITUL(5)
+#define MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED	_BITUL(6)
+#define MPTCP_SUBFLOW_FLAG_CONNECTED		_BITUL(7)
+#define MPTCP_SUBFLOW_FLAG_MAPVALID		_BITUL(8)
 =

 enum {
 	MPTCP_SUBFLOW_ATTR_UNSPEC,
-- =

2.26.0

--===============8334450844170377029==--
