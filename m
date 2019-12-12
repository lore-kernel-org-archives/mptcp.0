Content-Type: multipart/mixed; boundary="===============7345759917403191253=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] mptcp: Remove version field from
 mptcp_options_received
Date: Wed, 11 Dec 2019 21:08:20 -0800
Message-ID: <20191212050820.29792-3-peter.krystad@linux.intel.com>
In-Reply-To: 20191212050820.29792-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2884

--===============7345759917403191253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This field is not necessary, all version logic is performed
in mptcp_parse_options().

squashto: Handle MPTCP TCP options

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h  | 3 +--
 net/mptcp/options.c  | 7 ++++---
 net/mptcp/protocol.h | 2 ++
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 36f5d8e53e25..e5859d671111 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -84,8 +84,7 @@ struct mptcp_options_received {
 	u64	rcvr_key;
 	u8	mp_capable : 1,
 		mp_join : 1,
-		dss : 1,
-		version : 4;
+		dss : 1;
 };
 #endif
 =

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9e21b72b45b9..cd4c0c8de6e0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -14,6 +14,7 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 {
 	struct mptcp_options_received *mp_opt =3D &opt_rx->mptcp;
 	u8 subtype =3D *ptr >> 4;
+	u8 version;
 	u8 flags;
 =

 	switch (subtype) {
@@ -28,8 +29,8 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 		    opsize !=3D TCPOLEN_MPTCP_MPC_ACK)
 			break;
 =

-		mp_opt->version =3D *ptr++ & MPTCP_VERSION_MASK;
-		if (mp_opt->version !=3D 0)
+		version =3D *ptr++ & MPTCP_VERSION_MASK;
+		if (version !=3D MPTCP_SUPPORTED_VERSION)
 			break;
 =

 		flags =3D *ptr++;
@@ -146,7 +147,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out_=
options *opts)
 =

 		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) | (len << 16) |
 			       (MPTCPOPT_MP_CAPABLE << 12) |
-			       ((MPTCP_VERSION_MASK & 0) << 8) |
+			       (MPTCP_SUPPORTED_VERSION << 8) |
 			       MPTCP_CAP_HMAC_SHA1);
 		put_unaligned_be64(opts->sndr_key, ptr);
 		ptr +=3D 2;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bd420bef44a0..c59cf8b220b0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -7,6 +7,8 @@
 #ifndef __MPTCP_PROTOCOL_H
 #define __MPTCP_PROTOCOL_H
 =

+#define MPTCP_SUPPORTED_VERSION	0
+
 /* MPTCP option bits */
 #define OPTION_MPTCP_MPC_SYN	BIT(0)
 #define OPTION_MPTCP_MPC_SYNACK	BIT(1)
-- =

2.17.2

--===============7345759917403191253==--
