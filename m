Content-Type: multipart/mixed; boundary="===============7855271964554104754=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/2] mptcp: reduce number of pr_debug() calls.
Date: Tue, 11 Jun 2019 10:51:47 -0700
Message-ID: <20190611175148.11832-2-peter.krystad@linux.intel.com>
In-Reply-To: 20190611175148.11832-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1335

--===============7855271964554104754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Handle MPTCP TCP options

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1bee4a267fd8..a6ab6cef4a44 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -13,7 +13,7 @@
 void mptcp_parse_option(const unsigned char *ptr, int opsize,
 			struct tcp_options_received *opt_rx)
 {
-	struct mptcp_options_received *mp_opt;
+	struct mptcp_options_received *mp_opt =3D &opt_rx->mptcp;
 	u8 subtype =3D *ptr >> 4;
 	int expected_opsize;
 =

@@ -29,25 +29,28 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 		    opsize !=3D TCPOLEN_MPTCP_MPC_SYNACK)
 			break;
 =

-		pr_debug("MP_CAPABLE");
-		opt_rx->mptcp.version =3D *ptr++ & MPTCPOPT_VERSION_MASK;
-		if (opt_rx->mptcp.version !=3D 0)
+		mp_opt->version =3D *ptr++ & MPTCPOPT_VERSION_MASK;
+		if (mp_opt->version !=3D 0)
 			break;
 =

-		pr_debug("flags=3D%02x", *ptr);
-		opt_rx->mptcp.flags =3D *ptr++;
-		if (!((opt_rx->mptcp.flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_=
SHA1) ||
-		    (opt_rx->mptcp.flags & MPTCP_CAP_EXTENSIBILITY))
+		mp_opt->flags =3D *ptr++;
+		if (!((mp_opt->flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_SHA1) =
||
+		    (mp_opt->flags & MPTCP_CAP_EXTENSIBILITY))
 			break;
 =

-		opt_rx->mptcp.mp_capable =3D 1;
-		opt_rx->mptcp.sndr_key =3D get_unaligned_be64(ptr);
-		pr_debug("sndr_key=3D%llu", opt_rx->mptcp.sndr_key);
+		mp_opt->mp_capable =3D 1;
+		mp_opt->sndr_key =3D get_unaligned_be64(ptr);
 		ptr +=3D 8;
+
 		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_SYNACK) {
-			opt_rx->mptcp.rcvr_key =3D get_unaligned_be64(ptr);
-			pr_debug("rcvr_key=3D%llu", opt_rx->mptcp.rcvr_key);
+			mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
 			ptr +=3D 8;
+			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu, rcvr=3D%llu",
+				 mp_opt->flags, mp_opt->sndr_key,
+				 mp_opt->rcvr_key);
+		} else {
+			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu",
+				 mp_opt->flags, mp_opt->sndr_key);
 		}
 		break;
 =

@@ -83,7 +86,6 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 	 */
 	case MPTCPOPT_DSS:
 		pr_debug("DSS");
-		mp_opt =3D &opt_rx->mptcp;
 		mp_opt->dss =3D 1;
 		ptr++;
 =

-- =

2.17.2


--===============7855271964554104754==--
