Content-Type: multipart/mixed; boundary="===============7429246962487220636=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Add explicit check for protocol version
Date: Tue, 21 May 2019 11:15:46 -0700
Message-ID: <20190521181546.2592-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1214

--===============7429246962487220636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently only MPTCP v0 is supported so ignore v1 MP_CAPABLE option.

Also, make sure zeros are shifted to the correct position...

Squash to "Handle MPTCP TCP options".

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c71e40f6f06a..9b9b9c9390c1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -30,8 +30,11 @@ void mptcp_parse_option(const unsigned char *ptr, int op=
size,
 			break;
 =

 		pr_debug("MP_CAPABLE");
-		opt_rx->mptcp.mp_capable =3D 1;
 		opt_rx->mptcp.version =3D *ptr++ & MPTCPOPT_VERSION_MASK;
+		if (opt_rx->mptcp.version !=3D 0)
+			break;
+
+		opt_rx->mptcp.mp_capable =3D 1;
 		pr_debug("flags=3D%02x", *ptr);
 		opt_rx->mptcp.flags =3D *ptr++;
 		opt_rx->mptcp.sndr_key =3D get_unaligned_be64(ptr);
@@ -399,8 +402,8 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out_=
options *opts)
 			len =3D TCPOLEN_MPTCP_MPC_ACK;
 =

 		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) | (len << 16) |
-			       (MPTCPOPT_MP_CAPABLE << 20) |
-			       ((MPTCPOPT_VERSION_MASK & 0) << 16) |
+			       (MPTCPOPT_MP_CAPABLE << 12) |
+			       ((MPTCPOPT_VERSION_MASK & 0) << 8) |
 			       MPTCP_CAP_HMAC_SHA1);
 		put_unaligned_be64(opts->sndr_key, ptr);
 		ptr +=3D 2;
-- =

2.17.2


--===============7429246962487220636==--
