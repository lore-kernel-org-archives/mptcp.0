Content-Type: multipart/mixed; boundary="===============7951792549555570365=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 03/10] mptcp: add port support
 for ADD_ADDR suboption writing
Date: Sat, 31 Oct 2020 23:24:34 +0800
Message-ID: <25b16158f8ec8521b79bec9ec20e142ce1623fde.1604156723.git.geliangtang@gmail.com>
In-Reply-To: 5d9becee199f0ffbec60d34451b4779c4c9773c9.1604156723.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6505

--===============7951792549555570365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In rfc8684, the length of ADD_ADDR suboption with IPv4 address and port
is 18 octets, but mptcp_write_options is 32-bit aligned, so we need to
pad it to 20 octets.

This patch added a new field 'port' in mptcp_out_options. When this
field is set with a port number, we need to add up 4 octets for the
ADD_ADDR suboption, and put the port number into the suboption.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/options.c  | 27 ++++++++++++++++++++++++---
 net/mptcp/protocol.h | 10 +++++-----
 3 files changed, 30 insertions(+), 8 deletions(-)

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
index f69d6f3d6605..79dbdf499087 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1074,6 +1074,9 @@ void mptcp_write_options(__be32 *ptr, const struct tc=
p_sock *tp,
 		if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions)
 			len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
 =

+		if (opts->port)
+			len +=3D TCPOLEN_MPTCP_PORT_LEN;
+
 		if (opts->ahmac) {
 			len +=3D sizeof(opts->ahmac);
 			echo =3D 0;
@@ -1091,9 +1094,27 @@ void mptcp_write_options(__be32 *ptr, const struct t=
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
+				put_unaligned_be32(opts->port << 16 |
+						   opts->ahmac >> 48, ptr);
+				ptr +=3D 1;
+				put_unaligned_be64(opts->ahmac << 16 |
+						   TCPOPT_NOP << 8 |
+						   TCPOPT_NOP, ptr);
+				ptr +=3D 2;
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

--===============7951792549555570365==--
