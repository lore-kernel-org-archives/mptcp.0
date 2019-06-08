Content-Type: multipart/mixed; boundary="===============1763276564134120533=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] mptcp: reduce number of pr_debug() calls.
Date: Fri, 07 Jun 2019 17:40:39 -0700
Message-ID: <20190608004040.3426-2-peter.krystad@linux.intel.com>
In-Reply-To: 20190608004040.3426-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1318

--===============1763276564134120533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Handle MPTCP TCP options

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1bee4a267fd8..cad1702323a3 100644
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

@@ -29,25 +29,29 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
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
+		mp_opt->flags =3D *ptr++;
+		if (!((opt_rx->mptcp.flags & MPTCP_CAP_FLAG_MASK) =3D=3D
+		    MPTCP_CAP_HMAC_SHA1) ||
 		    (opt_rx->mptcp.flags & MPTCP_CAP_EXTENSIBILITY))
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

@@ -83,7 +87,6 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 	 */
 	case MPTCPOPT_DSS:
 		pr_debug("DSS");
-		mp_opt =3D &opt_rx->mptcp;
 		mp_opt->dss =3D 1;
 		ptr++;
 =

@@ -399,10 +402,8 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 =

 		if (OPTION_MPTCP_MPC_SYN & opts->suboptions)
 			len =3D TCPOLEN_MPTCP_MPC_SYN;
-		else if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions)
-			len =3D TCPOLEN_MPTCP_MPC_SYNACK;
 		else
-			len =3D TCPOLEN_MPTCP_MPC_ACK;
+			len =3D TCPOLEN_MPTCP_MPC_SYNACK;
 =

 		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) | (len << 16) |
 			       (MPTCPOPT_MP_CAPABLE << 12) |
-- =

2.17.2


--===============1763276564134120533==--
