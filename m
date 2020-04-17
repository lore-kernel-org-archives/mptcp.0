Content-Type: multipart/mixed; boundary="===============6655200462341038282=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 1/4] uapi: update linux/mptcp.h
Date: Fri, 17 Apr 2020 18:08:24 +0200
Message-ID: <211c1fcffddd7b820ea2777f9b114d748853c8fc.1587139599.git.pabeni@redhat.com>
In-Reply-To: cover.1587139599.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4199

--===============6655200462341038282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/uapi/linux/mptcp.h | 89 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 include/uapi/linux/mptcp.h

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
new file mode 100644
index 00000000..5f2c7708
--- /dev/null
+++ b/include/uapi/linux/mptcp.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_MPTCP_H
+#define _UAPI_MPTCP_H
+
+#include <linux/const.h>
+#include <linux/types.h>
+
+#define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
+#define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
+#define MPTCP_SUBFLOW_FLAG_JOIN_REM		_BITUL(2)
+#define MPTCP_SUBFLOW_FLAG_JOIN_LOC		_BITUL(3)
+#define MPTCP_SUBFLOW_FLAG_BKUP_REM		_BITUL(4)
+#define MPTCP_SUBFLOW_FLAG_BKUP_LOC		_BITUL(5)
+#define MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED	_BITUL(6)
+#define MPTCP_SUBFLOW_FLAG_CONNECTED		_BITUL(7)
+#define MPTCP_SUBFLOW_FLAG_MAPVALID		_BITUL(8)
+
+enum {
+	MPTCP_SUBFLOW_ATTR_UNSPEC,
+	MPTCP_SUBFLOW_ATTR_TOKEN_REM,
+	MPTCP_SUBFLOW_ATTR_TOKEN_LOC,
+	MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
+	MPTCP_SUBFLOW_ATTR_MAP_SEQ,
+	MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
+	MPTCP_SUBFLOW_ATTR_SSN_OFFSET,
+	MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
+	MPTCP_SUBFLOW_ATTR_FLAGS,
+	MPTCP_SUBFLOW_ATTR_ID_REM,
+	MPTCP_SUBFLOW_ATTR_ID_LOC,
+	MPTCP_SUBFLOW_ATTR_PAD,
+	__MPTCP_SUBFLOW_ATTR_MAX
+};
+
+#define MPTCP_SUBFLOW_ATTR_MAX (__MPTCP_SUBFLOW_ATTR_MAX - 1)
+
+/* netlink interface */
+#define MPTCP_PM_NAME		"mptcp_pm"
+#define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
+#define MPTCP_PM_VER		0x1
+
+/*
+ * ATTR types defined for MPTCP
+ */
+enum {
+	MPTCP_PM_ATTR_UNSPEC,
+
+	MPTCP_PM_ATTR_ADDR,				/* nested address */
+	MPTCP_PM_ATTR_RCV_ADD_ADDRS,			/* u32 */
+	MPTCP_PM_ATTR_SUBFLOWS,				/* u32 */
+
+	__MPTCP_PM_ATTR_MAX
+};
+
+#define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
+
+enum {
+	MPTCP_PM_ADDR_ATTR_UNSPEC,
+
+	MPTCP_PM_ADDR_ATTR_FAMILY,			/* u16 */
+	MPTCP_PM_ADDR_ATTR_ID,				/* u8 */
+	MPTCP_PM_ADDR_ATTR_ADDR4,			/* struct in_addr */
+	MPTCP_PM_ADDR_ATTR_ADDR6,			/* struct in6_addr */
+	MPTCP_PM_ADDR_ATTR_PORT,			/* u16 */
+	MPTCP_PM_ADDR_ATTR_FLAGS,			/* u32 */
+	MPTCP_PM_ADDR_ATTR_IF_IDX,			/* s32 */
+
+	__MPTCP_PM_ADDR_ATTR_MAX
+};
+
+#define MPTCP_PM_ADDR_ATTR_MAX (__MPTCP_PM_ADDR_ATTR_MAX - 1)
+
+#define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
+#define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
+#define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
+
+enum {
+	MPTCP_PM_CMD_UNSPEC,
+
+	MPTCP_PM_CMD_ADD_ADDR,
+	MPTCP_PM_CMD_DEL_ADDR,
+	MPTCP_PM_CMD_GET_ADDR,
+	MPTCP_PM_CMD_FLUSH_ADDRS,
+	MPTCP_PM_CMD_SET_LIMITS,
+	MPTCP_PM_CMD_GET_LIMITS,
+
+	__MPTCP_PM_CMD_AFTER_LAST
+};
+
+#endif /* _UAPI_MPTCP_H */
-- =

2.21.1

--===============6655200462341038282==--
