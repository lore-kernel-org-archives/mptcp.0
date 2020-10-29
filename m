Content-Type: multipart/mixed; boundary="===============4482211821876466674=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 1/8] mptcp: add ADD_ADDR port
 support for writing options
Date: Thu, 29 Oct 2020 14:39:21 +0800
Message-ID: <cf1bf5352d467144523d8b06b5d0cbb95b90407d.1603952836.git.geliangtang@gmail.com>
In-Reply-To: cover.1603952836.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6464

--===============4482211821876466674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added ADD_ADDR port support for writing options.

In rfc8684, the length of ADD_ADDR suboption with IPv4 address and port
is 18 octets:

                       1                   2                   3
   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
  +---------------+---------------+-------+-------+---------------+
  |     Kind      |     Length    |Subtype|(rsv)|E|  Address ID   |
  +---------------+---------------+-------+-------+---------------+
  |           Address (IPv4: 4 octets / IPv6: 16 octets)          |
  +-------------------------------+-------------------------------+
  |   Port (2 octets, optional)   |                               |
  +-------------------------------+                               |
  |                Truncated HMAC (8 octets, if E=3D0)              |
  |                               +-------------------------------+
  |                               |
  +-------------------------------+

But mptcp_write_options is 32-bit aligned, so we need to pad it to 20
octets.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/options.c  | 64 +++++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h | 10 +++----
 3 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index b6cf07143a8a..bb8b7b931490 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -46,6 +46,7 @@ struct mptcp_out_options {
 #endif
 	};
 	u8 addr_id;
+	__be16 port;
 	u64 ahmac;
 	u8 rm_id;
 	u8 join_id;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 248e3930c0cb..7c928286c0da 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1067,39 +1067,83 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
 =

 mp_capable_done:
 	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
+		int add_len, echo_len;
+
+		if (!opts->port) {
+			add_len =3D TCPOLEN_MPTCP_ADD_ADDR;
+			echo_len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
+		} else {
+			add_len =3D TCPOLEN_MPTCP_ADD_ADDR_PORT;
+			echo_len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT;
+		}
+
 		if (opts->ahmac)
 			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
-					      TCPOLEN_MPTCP_ADD_ADDR, 0,
+					      add_len, 0,
 					      opts->addr_id);
 		else
 			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
-					      TCPOLEN_MPTCP_ADD_ADDR_BASE,
+					      echo_len,
 					      MPTCP_ADDR_ECHO,
 					      opts->addr_id);
 		memcpy((u8 *)ptr, (u8 *)&opts->addr.s_addr, 4);
 		ptr +=3D 1;
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
+				put_unaligned_be32(opts->port << 16 | opts->ahmac >> 48, ptr);
+				ptr +=3D 1;
+				put_unaligned_be64(opts->ahmac << 16 | TCPOPT_NOP, ptr);
+				ptr +=3D 2;
+			} else {
+				put_unaligned_be16(opts->port, ptr);
+				ptr +=3D 1;
+			}
 		}
 	}
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
+		int add_len, echo_len;
+
+		if (!opts->port) {
+			add_len =3D TCPOLEN_MPTCP_ADD_ADDR6;
+			echo_len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
+		} else {
+			add_len =3D TCPOLEN_MPTCP_ADD_ADDR6_PORT;
+			echo_len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT;
+		}
 		if (opts->ahmac)
 			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
-					      TCPOLEN_MPTCP_ADD_ADDR6, 0,
+					      add_len, 0,
 					      opts->addr_id);
 		else
 			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
-					      TCPOLEN_MPTCP_ADD_ADDR6_BASE,
+					      echo_len,
 					      MPTCP_ADDR_ECHO,
 					      opts->addr_id);
 		memcpy((u8 *)ptr, opts->addr6.s6_addr, 16);
 		ptr +=3D 4;
-		if (opts->ahmac) {
-			put_unaligned_be64(opts->ahmac, ptr);
-			ptr +=3D 2;
+		if (!opts->port) {
+			if (opts->ahmac) {
+				put_unaligned_be64(opts->ahmac, ptr);
+				ptr +=3D 2;
+			}
+		} else {
+			if (opts->ahmac) {
+				put_unaligned_be32(opts->port << 16 | opts->ahmac >> 48, ptr);
+				ptr +=3D 1;
+				put_unaligned_be64(opts->ahmac << 16 | TCPOPT_NOP, ptr);
+				ptr +=3D 2;
+			} else {
+				put_unaligned_be16(opts->port, ptr);
+				ptr +=3D 1;
+			}
 		}
 	}
 #endif
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

--===============4482211821876466674==--
