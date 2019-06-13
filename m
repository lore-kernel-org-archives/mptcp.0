Content-Type: multipart/mixed; boundary="===============3055925240109596661=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/4] mptcp: make flag field naming consistent
Date: Thu, 13 Jun 2019 15:24:54 -0700
Message-ID: <20190613222454.10728-5-peter.krystad@linux.intel.com>
In-Reply-To: 20190613222454.10728-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1370

--===============3055925240109596661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Handle MPTCP TCP options

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c  | 4 ++--
 net/mptcp/protocol.h | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d285a33cd480..984de1edd946 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -29,7 +29,7 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 		    opsize !=3D TCPOLEN_MPTCP_MPC_SYNACK)
 			break;
 =

-		mp_opt->version =3D *ptr++ & MPTCPOPT_VERSION_MASK;
+		mp_opt->version =3D *ptr++ & MPTCP_VERSION_MASK;
 		if (mp_opt->version !=3D 0)
 			break;
 =

@@ -430,7 +430,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out_=
options *opts)
 =

 		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) | (len << 16) |
 			       (MPTCPOPT_MP_CAPABLE << 12) |
-			       ((MPTCPOPT_VERSION_MASK & 0) << 8) |
+			       ((MPTCP_VERSION_MASK & 0) << 8) |
 			       MPTCP_CAP_HMAC_SHA1);
 		put_unaligned_be64(opts->sndr_key, ptr);
 		ptr +=3D 2;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2393d2194d28..3200dc63577b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -31,9 +31,8 @@
 #define TCPOLEN_MPTCP_DSS_MAP64		14
 #define TCPOLEN_MPTCP_DSS_CHECKSUM	2
 =

-#define MPTCPOPT_VERSION_MASK	0x0F
-
-/* MPTCP handshake flags */
+/* MPTCP MP_CAPABLE flags */
+#define MPTCP_VERSION_MASK	(0x0F)
 #define MPTCP_CAP_CHECKSUM_REQD	BIT(7)
 #define MPTCP_CAP_EXTENSIBILITY	BIT(6)
 #define MPTCP_CAP_HMAC_SHA1	BIT(0)
-- =

2.17.2


--===============3055925240109596661==--
