Content-Type: multipart/mixed; boundary="===============5671532836137487784=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 02/10] mptcp: unify ADD_ADDR and
 ADD_ADDR6 suboptions writing
Date: Sat, 31 Oct 2020 23:24:33 +0800
Message-ID: <5d9becee199f0ffbec60d34451b4779c4c9773c9.1604156723.git.geliangtang@gmail.com>
In-Reply-To: d6a11bb2d1498158ce76822247ffaf34037d04d6.1604156723.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6504

--===============5671532836137487784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The length of ADD_ADDR6 is 12 octets longer than ADD_ADDR. That's the
only difference between them.

This patch dropped the duplicate code between ADD_ADDR and ADD_ADDR6
suboptions writing, and unify them into one.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0fe3f224b00a..f69d6f3d6605 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1066,10 +1066,14 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
 	}
 =

 mp_capable_done:
-	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
+	if ((OPTION_MPTCP_ADD_ADDR | OPTION_MPTCP_ADD_ADDR6) &
+	    opts->suboptions) {
 		u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
 		u8 echo =3D MPTCP_ADDR_ECHO;
 =

+		if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions)
+			len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
+
 		if (opts->ahmac) {
 			len +=3D sizeof(opts->ahmac);
 			echo =3D 0;
@@ -1077,33 +1081,21 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
 =

 		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
 				      len, echo, opts->addr_id);
-		memcpy((u8 *)ptr, (u8 *)&opts->addr.s_addr, 4);
-		ptr +=3D 1;
-		if (opts->ahmac) {
-			put_unaligned_be64(opts->ahmac, ptr);
-			ptr +=3D 2;
+		if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
+			memcpy((u8 *)ptr, (u8 *)&opts->addr.s_addr, 4);
+			ptr +=3D 1;
 		}
-	}
-
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
-		u8 len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
-		u8 echo =3D MPTCP_ADDR_ECHO;
-
-		if (opts->ahmac) {
-			len +=3D sizeof(opts->ahmac);
-			echo =3D 0;
+		else if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
+			memcpy((u8 *)ptr, opts->addr6.s6_addr, 16);
+			ptr +=3D 4;
 		}
-		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
-				      len, echo, opts->addr_id);
-		memcpy((u8 *)ptr, opts->addr6.s6_addr, 16);
-		ptr +=3D 4;
+#endif
 		if (opts->ahmac) {
 			put_unaligned_be64(opts->ahmac, ptr);
 			ptr +=3D 2;
 		}
 	}
-#endif
 =

 	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
 		*ptr++ =3D mptcp_option(MPTCPOPT_RM_ADDR,
-- =

2.26.2

--===============5671532836137487784==--
