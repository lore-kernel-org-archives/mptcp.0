Content-Type: multipart/mixed; boundary="===============1705887902633507833=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 5/7] mptcp: parsing DSS option should use own flags
 field.
Date: Wed, 05 Jun 2019 17:36:30 -0700
Message-ID: <20190606003632.2863-6-peter.krystad@linux.intel.com>
In-Reply-To: 20190606003632.2863-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1300

--===============1705887902633507833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It is possible that both MP_CAPABLE and DSS options are
received in the same header, so they cannot share fields.

squashto: Implement MPTCP reveive path.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h  |  1 +
 include/net/mptcp.h  |  9 ---------
 net/mptcp/options.c  | 12 ++++++------
 net/mptcp/protocol.h |  8 ++++++++
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index db0297daa33c..d68e0f39650b 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -118,6 +118,7 @@ struct tcp_options_received {
 			dss : 1,
 			version : 4;
 		u8      flags;
+		u8	dss_flags;
 		u8	use_map:1,
 			dsn64:1,
 			use_checksum:1,
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 65dd7f052e94..d84489adbd86 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -8,15 +8,6 @@
 #ifndef __NET_MPTCP_H
 #define __NET_MPTCP_H
 =

-/* MPTCP DSS flags */
-
-#define MPTCP_DSS_DATA_FIN	BIT(4)
-#define MPTCP_DSS_DSN64		BIT(3)
-#define MPTCP_DSS_HAS_MAP	BIT(2)
-#define MPTCP_DSS_ACK64		BIT(1)
-#define MPTCP_DSS_HAS_ACK	BIT(0)
-#define MPTCP_DSS_FLAG_MASK	(0x1F)
-
 /* MPTCP sk_buff extension data */
 struct mptcp_ext {
 	u64		data_ack;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b259c4343f36..df4405d268f0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -85,12 +85,12 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 		mp_opt->dss =3D 1;
 		ptr++;
 =

-		mp_opt->flags =3D (*ptr++) & MPTCP_DSS_FLAG_MASK;
-		mp_opt->data_fin =3D (mp_opt->flags & MPTCP_DSS_DATA_FIN) !=3D 0;
-		mp_opt->dsn64 =3D (mp_opt->flags & MPTCP_DSS_DSN64) !=3D 0;
-		mp_opt->use_map =3D (mp_opt->flags & MPTCP_DSS_HAS_MAP) !=3D 0;
-		mp_opt->ack64 =3D (mp_opt->flags & MPTCP_DSS_ACK64) !=3D 0;
-		mp_opt->use_ack =3D (mp_opt->flags & MPTCP_DSS_HAS_ACK);
+		mp_opt->dss_flags =3D (*ptr++) & MPTCP_DSS_FLAG_MASK;
+		mp_opt->data_fin =3D (mp_opt->dss_flags & MPTCP_DSS_DATA_FIN) !=3D 0;
+		mp_opt->dsn64 =3D (mp_opt->dss_flags & MPTCP_DSS_DSN64) !=3D 0;
+		mp_opt->use_map =3D (mp_opt->dss_flags & MPTCP_DSS_HAS_MAP) !=3D 0;
+		mp_opt->ack64 =3D (mp_opt->dss_flags & MPTCP_DSS_ACK64) !=3D 0;
+		mp_opt->use_ack =3D (mp_opt->dss_flags & MPTCP_DSS_HAS_ACK);
 =

 		pr_debug("data_fin=3D%d dsn64=3D%d use_map=3D%d ack64=3D%d use_ack=3D%d",
 			 mp_opt->data_fin, mp_opt->dsn64,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 258325e42fa4..6498e68e1030 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -27,6 +27,14 @@
 #define MPTCP_CAP_EXTENSIBILITY	(1 << 6)
 #define MPTCP_CAP_HMAC_SHA1	(1 << 0)
 =

+/* MPTCP DSS flags */
+#define MPTCP_DSS_DATA_FIN	BIT(4)
+#define MPTCP_DSS_DSN64		BIT(3)
+#define MPTCP_DSS_HAS_MAP	BIT(2)
+#define MPTCP_DSS_ACK64		BIT(1)
+#define MPTCP_DSS_HAS_ACK	BIT(0)
+#define MPTCP_DSS_FLAG_MASK	(0x1F)
+
 /* MPTCP connection sock */
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
-- =

2.17.2


--===============1705887902633507833==--
