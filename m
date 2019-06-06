Content-Type: multipart/mixed; boundary="===============2585379145649096630=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 6/7] mptcp: Check flags in MP_CAPABLE option
Date: Wed, 05 Jun 2019 17:36:31 -0700
Message-ID: <20190606003632.2863-7-peter.krystad@linux.intel.com>
In-Reply-To: 20190606003632.2863-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1302

--===============2585379145649096630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Handle MPTCP TCP options

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c  | 6 +++++-
 net/mptcp/protocol.h | 7 ++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index df4405d268f0..98d582207cb0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -29,8 +29,12 @@ void mptcp_parse_option(const unsigned char *ptr, int op=
size,
 		if (mp_opt->version !=3D 0)
 			break;
 =

-		mp_opt->mp_capable =3D 1;
 		mp_opt->flags =3D *ptr++;
+		if (!((mp_opt->flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_SHA1) =
||
+		    (mp_opt->flags & MPTCP_CAP_EXTENSIBILITY))
+			break;
+
+		mp_opt->mp_capable =3D 1;
 		mp_opt->sndr_key =3D get_unaligned_be64(ptr);
 		ptr +=3D 8;
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6498e68e1030..2c2f2ca4312b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -23,9 +23,10 @@
 #define MPTCPOPT_VERSION_MASK	0x0F
 =

 /* MPTCP handshake flags */
-#define MPTCP_CAP_CHECKSUM_REQD	(1 << 7)
-#define MPTCP_CAP_EXTENSIBILITY	(1 << 6)
-#define MPTCP_CAP_HMAC_SHA1	(1 << 0)
+#define MPTCP_CAP_CHECKSUM_REQD	BIT(7)
+#define MPTCP_CAP_EXTENSIBILITY	BIT(6)
+#define MPTCP_CAP_HMAC_SHA1	BIT(0)
+#define MPTCP_CAP_FLAG_MASK	(0x3F)
 =

 /* MPTCP DSS flags */
 #define MPTCP_DSS_DATA_FIN	BIT(4)
-- =

2.17.2


--===============2585379145649096630==--
