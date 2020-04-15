Content-Type: multipart/mixed; boundary="===============1707595550607601812=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 3/4] ss: allow dumping MPTCP subflow information
Date: Wed, 15 Apr 2020 14:28:55 +0200
Message-ID: <207f9245d3073d128132389b9d1c529b85133d77.1586953702.git.pabeni@redhat.com>
In-Reply-To: cover.1586953702.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4171

--===============1707595550607601812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Davide Caratti <dcaratti(a)redhat.com>

 [root(a)f31 packetdrill]# ss -tni

 ESTAB    0        0           192.168.82.247:8080           192.0.2.1:35273
          cubic wscale:7,8 [...] tcp-ulp-mptcp flags: Mec token:0000(id:0)/=
5f856c60(id:0) seq:b810457db34209a5 sfseq:1 ssnoff:0 maplen:190

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 misc/ss.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/misc/ss.c b/misc/ss.c
index 3ef151fb..3fac4be8 100644
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

2.21.1

--===============1707595550607601812==--
