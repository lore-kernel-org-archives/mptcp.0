Content-Type: multipart/mixed; boundary="===============8316922112609680266=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Remove dss_flags field from struct
 mptcp_options_received
Date: Thu, 05 Dec 2019 15:43:58 -0800
Message-ID: <20191205234358.27455-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2806

--===============8316922112609680266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This field is used only temporarily while parsing options,
use a local variable instead.

Formatted to apply directly to Implement MPTCP receive path.

squashto: Implement MPTCP receive path

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h |  1 -
 net/mptcp/options.c | 12 ++++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 184fc88a140b..a6d6438b27b1 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -107,7 +107,6 @@ struct tcp_options_received {
 			mp_join : 1,
 			dss : 1,
 			version : 4;
-		u8	dss_flags;
 		u8	use_map:1,
 			dsn64:1,
 			data_fin:1,
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c5c770d2e711..e69d56bfabc4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -99,12 +99,12 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 		pr_debug("DSS");
 		ptr++;
 =

-		mp_opt->dss_flags =3D (*ptr++) & MPTCP_DSS_FLAG_MASK;
-		mp_opt->data_fin =3D (mp_opt->dss_flags & MPTCP_DSS_DATA_FIN) !=3D 0;
-		mp_opt->dsn64 =3D (mp_opt->dss_flags & MPTCP_DSS_DSN64) !=3D 0;
-		mp_opt->use_map =3D (mp_opt->dss_flags & MPTCP_DSS_HAS_MAP) !=3D 0;
-		mp_opt->ack64 =3D (mp_opt->dss_flags & MPTCP_DSS_ACK64) !=3D 0;
-		mp_opt->use_ack =3D (mp_opt->dss_flags & MPTCP_DSS_HAS_ACK);
+		flags =3D (*ptr++) & MPTCP_DSS_FLAG_MASK;
+		mp_opt->data_fin =3D (flags & MPTCP_DSS_DATA_FIN) !=3D 0;
+		mp_opt->dsn64 =3D (flags & MPTCP_DSS_DSN64) !=3D 0;
+		mp_opt->use_map =3D (flags & MPTCP_DSS_HAS_MAP) !=3D 0;
+		mp_opt->ack64 =3D (flags & MPTCP_DSS_ACK64) !=3D 0;
+		mp_opt->use_ack =3D (flags & MPTCP_DSS_HAS_ACK);
 =

 		pr_debug("data_fin=3D%d dsn64=3D%d use_map=3D%d ack64=3D%d use_ack=3D%d",
 			 mp_opt->data_fin, mp_opt->dsn64,
-- =

2.17.2

--===============8316922112609680266==--
