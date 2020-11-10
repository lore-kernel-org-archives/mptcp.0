Content-Type: multipart/mixed; boundary="===============5977155590708152952=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 03/13] mptcp: add port support
 for ADD_ADDR suboption writing
Date: Tue, 10 Nov 2020 13:14:51 +0800
Message-ID: <35189188e680590f632dc40519b8bc176d46dda8.1604984546.git.geliangtang@gmail.com>
In-Reply-To: 4dea6c56d1ae1caf10bcc85a25467f65b9941db0.1604984546.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6630

--===============5977155590708152952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In rfc8684, the length of ADD_ADDR suboption with IPv4 address and port
is 18 octets, but mptcp_write_options is 32-bit aligned, so we need to
pad it to 20 octets. All the other port related option lengths need to
be added up 2 octets similarly.

This patch added a new field 'port' in mptcp_out_options. When this
field is set with a port number, we need to add up 4 octets for the
ADD_ADDR suboption, and put the port number into the suboption.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/options.c  | 30 +++++++++++++++++++++++++++---
 net/mptcp/protocol.h | 10 +++++-----
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index b6cf07143a8a..5694370be3d4 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -46,6 +46,7 @@ struct mptcp_out_options {
 #endif
 	};
 	u8 addr_id;
+	u16 port;
 	u64 ahmac;
 	u8 rm_id;
 	u8 join_id;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 42b39148288f..ecdd2224ad3f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1079,6 +1079,9 @@ void mptcp_write_options(__be32 *ptr, const struct tc=
p_sock *tp,
 			len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
 #endif
 =

+		if (opts->port)
+			len +=3D TCPOLEN_MPTCP_PORT_LEN;
+
 		if (opts->ahmac) {
 			len +=3D sizeof(opts->ahmac);
 			echo =3D 0;
@@ -1096,9 +1099,30 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 			ptr +=3D 4;
 		}
 #endif
-		if (opts->ahmac) {
-			put_unaligned_be64(opts->ahmac, ptr);
-			ptr +=3D 2;
+
+		if (!opts->port) {
+			if (opts->ahmac) {
+				put_unaligned_be64(opts->ahmac, ptr);
+				ptr +=3D 2;
+			}
+		} else {
+			if (opts->ahmac) {
+				u8 *bptr =3D (u8 *)ptr;
+
+				put_unaligned_be16(opts->port, bptr);
+				bptr +=3D 2;
+				put_unaligned_be64(opts->ahmac, bptr);
+				bptr +=3D 8;
+				put_unaligned_be16(TCPOPT_NOP << 8 |
+						   TCPOPT_NOP, bptr);
+
+				ptr +=3D 3;
+			} else {
+				put_unaligned_be32(opts->port << 16 |
+						   TCPOPT_NOP << 8 |
+						   TCPOPT_NOP, ptr);
+				ptr +=3D 1;
+			}
 		}
 	}
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d29c6a4749eb..f303c46bcc29 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -49,14 +49,14 @@
 #define TCPOLEN_MPTCP_DSS_MAP64		14
 #define TCPOLEN_MPTCP_DSS_CHECKSUM	2
 #define TCPOLEN_MPTCP_ADD_ADDR		16
-#define TCPOLEN_MPTCP_ADD_ADDR_PORT	18
+#define TCPOLEN_MPTCP_ADD_ADDR_PORT	20
 #define TCPOLEN_MPTCP_ADD_ADDR_BASE	8
-#define TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT	10
+#define TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT	12
 #define TCPOLEN_MPTCP_ADD_ADDR6		28
-#define TCPOLEN_MPTCP_ADD_ADDR6_PORT	30
+#define TCPOLEN_MPTCP_ADD_ADDR6_PORT	32
 #define TCPOLEN_MPTCP_ADD_ADDR6_BASE	20
-#define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	22
-#define TCPOLEN_MPTCP_PORT_LEN		2
+#define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	24
+#define TCPOLEN_MPTCP_PORT_LEN		4
 #define TCPOLEN_MPTCP_RM_ADDR_BASE	4
 =

 /* MPTCP MP_JOIN flags */
-- =

2.26.2

--===============5977155590708152952==--
