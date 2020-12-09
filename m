Content-Type: multipart/mixed; boundary="===============6603753940509517557=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 02/11] mptcp: unify ADD_ADDR and ADD_ADDR6
 suboptions writing
Date: Wed, 09 Dec 2020 15:51:19 -0800
Message-ID: <20201209235128.175473-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201209235128.175473-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7108

--===============6603753940509517557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

The length of ADD_ADDR6 is 12 octets longer than ADD_ADDR. That's the
only difference between them.

This patch dropped the duplicate code between ADD_ADDR and ADD_ADDR6
suboptions writing, and unify them into one.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a061b2106cfe..639d47e6e2d0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1075,10 +1075,19 @@ void mptcp_write_options(__be32 *ptr, const struct =
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
@@ -1086,33 +1095,21 @@ void mptcp_write_options(__be32 *ptr, const struct =
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

2.29.2

--===============6603753940509517557==--
