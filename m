Content-Type: multipart/mixed; boundary="===============5794887400496228516=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 3/4] ss: allow dumping MPTCP subflow information
Date: Fri, 17 Apr 2020 18:08:26 +0200
Message-ID: <075c9ea7d3368d21972405166574cb7e4efe34ce.1587139599.git.pabeni@redhat.com>
In-Reply-To: cover.1587139599.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4203

--===============5794887400496228516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Davide Caratti <dcaratti(a)redhat.com>

 [root(a)f31 packetdrill]# ss -tni

 ESTAB    0        0           192.168.82.247:8080           192.0.2.1:35273
          cubic wscale:7,8 [...] tcp-ulp-mptcp flags:Mec token:0000(id:0)/5=
f856c60(id:0) seq:b810457db34209a5 sfseq:1 ssnoff:0 maplen:190

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 man/man8/ss.8 |  5 +++++
 misc/ss.c     | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index 023d771b..c80853f9 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -261,6 +261,11 @@ the pacing rate and max pacing rate
 .TP
 .B rcv_space:<rcv_space>
 a helper variable for TCP internal auto tuning socket receive buffer
+.P
+.TP
+.B tcp-ulp-mptcp flags:[MmBbJjecv] token:<rem_token(rem_id)/loc_token(loc_=
id)> seq:<sn> sfseq:<ssn> ssnoff:<off> maplen:<maplen>
+MPTCP subflow information
+.P
 .RE
 .TP
 .B \-\-tos
diff --git a/misc/ss.c b/misc/ss.c
index 3ef151fb..ee840149 100644
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
+		out(" token:%04x(id:%hhu)/%04x(id:%hhu)",
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

--===============5794887400496228516==--
