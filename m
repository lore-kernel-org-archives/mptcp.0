Content-Type: multipart/mixed; boundary="===============2349549132897170453=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 02/13] mptcp: unify ADD_ADDR and
 ADD_ADDR6 suboptions writing
Date: Tue, 10 Nov 2020 13:14:50 +0800
Message-ID: <4dea6c56d1ae1caf10bcc85a25467f65b9941db0.1604984546.git.geliangtang@gmail.com>
In-Reply-To: c6347b427019ce0b0601f7341262c7f1839f8455.1604984546.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6629

--===============2349549132897170453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The length of ADD_ADDR6 is 12 octets longer than ADD_ADDR. That's the
only difference between them.

This patch dropped the duplicate code between ADD_ADDR and ADD_ADDR6
suboptions writing, and unify them into one.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0fe3f224b00a..42b39148288f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1066,10 +1066,19 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
 	}
 =

 mp_capable_done:
-	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
+	if ((OPTION_MPTCP_ADD_ADDR
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	     | OPTION_MPTCP_ADD_ADDR6
+#endif
+	    ) & opts->suboptions) {
 		u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
 		u8 echo =3D MPTCP_ADDR_ECHO;
 =

+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions)
+			len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
+#endif
+
 		if (opts->ahmac) {
 			len +=3D sizeof(opts->ahmac);
 			echo =3D 0;
@@ -1077,33 +1086,21 @@ void mptcp_write_options(__be32 *ptr, const struct =
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

--===============2349549132897170453==--
