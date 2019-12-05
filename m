Content-Type: multipart/mixed; boundary="===============0554303633930243339=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Remove flags field from struct
 mptcp_options_received
Date: Thu, 05 Dec 2019 15:43:44 -0800
Message-ID: <20191205234344.27404-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2805

--===============0554303633930243339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This field is only used temporarily while parsing options,
use a local variable instead.

Also move key fields to final position and fix indents.

Formatted to apply directly to Handle MPTCP TCP options.

squashto: Handle MPTCP TCP options

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h |  7 +++----
 net/mptcp/options.c | 17 ++++++++---------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index da2a281e2c98..7c8a6f877900 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -97,13 +97,12 @@ struct tcp_options_received {
 	u16	mss_clamp;	/* Maximal mss, negotiated at connection setup */
 #if IS_ENABLED(CONFIG_MPTCP)
 	struct mptcp_options_received {
-		u8      mp_capable : 1,
+		u64	sndr_key;
+		u64	rcvr_key;
+		u8	mp_capable : 1,
 			mp_join : 1,
 			dss : 1,
 			version : 4;
-		u8      flags;
-		u64     sndr_key;
-		u64     rcvr_key;
 	} mptcp;
 #endif
 };
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index adf65d3ff27b..a3dc787e7408 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -14,6 +14,7 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 {
 	struct mptcp_options_received *mp_opt =3D &opt_rx->mptcp;
 	u8 subtype =3D *ptr >> 4;
+	u8 flags;
 =

 	switch (subtype) {
 	/* MPTCPOPT_MP_CAPABLE
@@ -31,9 +32,9 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 		if (mp_opt->version !=3D 0)
 			break;
 =

-		mp_opt->flags =3D *ptr++;
-		if (!((mp_opt->flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_SHA1) =
||
-		    (mp_opt->flags & MPTCP_CAP_EXTENSIBILITY))
+		flags =3D *ptr++;
+		if (!((flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_SHA1) ||
+		    (flags & MPTCP_CAP_EXTENSIBILITY))
 			break;
 =

 		/* RFC 6824, Section 3.1:
@@ -49,7 +50,7 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 		 *
 		 * We don't implement DSS checksum - fall back to TCP.
 		 */
-		if (mp_opt->flags & MPTCP_CAP_CHECKSUM_REQD)
+		if (flags & MPTCP_CAP_CHECKSUM_REQD)
 			break;
 =

 		mp_opt->mp_capable =3D 1;
@@ -59,12 +60,10 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_SYNACK) {
 			mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
 			ptr +=3D 8;
-			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu, rcvr=3D%llu",
-				 mp_opt->flags, mp_opt->sndr_key,
-				 mp_opt->rcvr_key);
+			pr_debug("MP_CAPABLE sndr=3D%llu, rcvr=3D%llu",
+				 mp_opt->sndr_key, mp_opt->rcvr_key);
 		} else {
-			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu",
-				 mp_opt->flags, mp_opt->sndr_key);
+			pr_debug("MP_CAPABLE sndr=3D%llu", mp_opt->sndr_key);
 		}
 		break;
 =

-- =

2.17.2

--===============0554303633930243339==--
