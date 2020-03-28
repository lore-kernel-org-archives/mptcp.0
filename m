Content-Type: multipart/mixed; boundary="===============7355358668326266152=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC iproute2-next] ss: allow dumping MPTCP subflow
 information
Date: Sat, 28 Mar 2020 18:02:10 +0100
Message-ID: <dd1ce6805f90fe56aaa1f7db383334b4ab96a575.1585414647.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4102

--===============7355358668326266152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 [root(a)f31 packetdrill]# ss -tni

 ESTAB    0        0           192.168.82.247:8080           192.0.2.1:35273
          cubic wscale:7,8 [...] tcp-ulp-mptcp flags: Mec token:0000(id:0)/=
5f856c60(id:0) seq:b810457db34209a5 sfseq:1 ssnoff:0 maplen:190

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 include/uapi/linux/inet_diag.h |  1 +
 include/uapi/linux/mptcp.h     | 89 ++++++++++++++++++++++++++++++++++
 misc/ss.c                      | 62 +++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 include/uapi/linux/mptcp.h

diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_diag.h
index e045d170334b..0c1c781c0a60 100644
--- a/include/uapi/linux/inet_diag.h
+++ b/include/uapi/linux/inet_diag.h
@@ -166,6 +166,7 @@ enum {
 	INET_ULP_INFO_UNSPEC,
 	INET_ULP_INFO_NAME,
 	INET_ULP_INFO_TLS,
+	INET_ULP_INFO_MPTCP,
 	__INET_ULP_INFO_MAX,
 };
 #define INET_ULP_INFO_MAX (__INET_ULP_INFO_MAX - 1)
diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
new file mode 100644
index 000000000000..5f2c77082d9e
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
diff --git a/misc/ss.c b/misc/ss.c
index 3ef151fbf1f1..3fac4be88442 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -53,6 +53,7 @@
 #include <linux/tipc_netlink.h>
 #include <linux/tipc_sockets_diag.h>
 #include <linux/tls.h>
+#include <linux/mptcp.h>
 =

 /* AF_VSOCK/PF_VSOCK is only provided since glibc 2.18 */
 #ifndef PF_VSOCK
@@ -2836,6 +2837,59 @@ static void tcp_tls_conf(const char *name, struct rt=
attr *attr)
 	}
 }
 =

+static void mptcp_subflow_info(struct rtattr *tb[])
+{
+	u_int32_t flags =3D 0;
+
+	if (tb[MPTCP_SUBFLOW_ATTR_FLAGS]) {
+		char caps[32 + 1] =3D { 0 }, *cap =3D &caps[0];
+
+		flags =3D rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_FLAGS]);
+
+		if (flags & MPTCP_SUBFLOW_FLAG_MCAP_REM)
+			*cap++ =3D 'M';
+		if (flags & MPTCP_SUBFLOW_FLAG_MCAP_LOC)
+			*cap++ =3D 'm';
+		if (flags & MPTCP_SUBFLOW_FLAG_JOIN_REM)
+			*cap++ =3D 'J';
+		if (flags & MPTCP_SUBFLOW_FLAG_JOIN_LOC)
+			*cap++ =3D 'j';
+		if (flags & MPTCP_SUBFLOW_FLAG_BKUP_REM)
+			*cap++ =3D 'B';
+		if (flags & MPTCP_SUBFLOW_FLAG_BKUP_LOC)
+			*cap++ =3D 'b';
+		if (flags & MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED)
+			*cap++ =3D 'e';
+		if (flags & MPTCP_SUBFLOW_FLAG_CONNECTED)
+			*cap++ =3D 'c';
+		if (flags & MPTCP_SUBFLOW_FLAG_MAPVALID)
+			*cap++ =3D 'v';
+		if (flags)
+			out(" flags:%s", caps);
+	}
+	if (tb[MPTCP_SUBFLOW_ATTR_TOKEN_REM] &&
+	    tb[MPTCP_SUBFLOW_ATTR_TOKEN_LOC] &&
+	    tb[MPTCP_SUBFLOW_ATTR_ID_REM] &&
+	    tb[MPTCP_SUBFLOW_ATTR_ID_LOC])
+		out(" token:%04x(id:%d)/%04x(id:%d)",
+		    rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_TOKEN_REM]),
+		    rta_getattr_u8(tb[MPTCP_SUBFLOW_ATTR_ID_REM]),
+		    rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_TOKEN_LOC]),
+		    rta_getattr_u8(tb[MPTCP_SUBFLOW_ATTR_ID_LOC]));
+	if (tb[MPTCP_SUBFLOW_ATTR_MAP_SEQ])
+		out(" seq:%llx",
+		    rta_getattr_u64(tb[MPTCP_SUBFLOW_ATTR_MAP_SEQ]));
+	if (tb[MPTCP_SUBFLOW_ATTR_MAP_SFSEQ])
+		out(" sfseq:%x",
+		    rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_MAP_SFSEQ]));
+	if (tb[MPTCP_SUBFLOW_ATTR_SSN_OFFSET])
+		out(" ssnoff:%x",
+		    rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_SSN_OFFSET]));
+	if (tb[MPTCP_SUBFLOW_ATTR_MAP_DATALEN])
+		out(" maplen:%x",
+		    rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_MAP_DATALEN]));
+}
+
 #define TCPI_HAS_OPT(info, opt) !!(info->tcpi_options & (opt))
 =

 static void tcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg=
 *r,
@@ -3012,6 +3066,14 @@ static void tcp_show_info(const struct nlmsghdr *nlh=
, struct inet_diag_msg *r,
 			tcp_tls_conf("rxconf", tlsinfo[TLS_INFO_RXCONF]);
 			tcp_tls_conf("txconf", tlsinfo[TLS_INFO_TXCONF]);
 		}
+		if (ulpinfo[INET_ULP_INFO_MPTCP]) {
+			struct rtattr *sfinfo[MPTCP_SUBFLOW_ATTR_MAX + 1] =3D
+				{ 0 };
+
+			parse_rtattr_nested(sfinfo, MPTCP_SUBFLOW_ATTR_MAX,
+					    ulpinfo[INET_ULP_INFO_MPTCP]);
+			mptcp_subflow_info(sfinfo);
+		}
 	}
 }
 =

-- =

2.25.1

--===============7355358668326266152==--
