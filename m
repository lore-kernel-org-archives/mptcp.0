Content-Type: multipart/mixed; boundary="===============2824719669782172577=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] mptcp: Move struct mptcp_options_received
Date: Wed, 11 Dec 2019 21:08:19 -0800
Message-ID: <20191212050820.29792-2-peter.krystad@linux.intel.com>
In-Reply-To: 20191212050820.29792-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2883

--===============2824719669782172577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move struct mptcp_options_received out of enclosing tcp
struct.

squashto: Handle MPTCP TCP options

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 7c8a6f877900..36f5d8e53e25 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -78,6 +78,17 @@ struct tcp_sack_block {
 #define TCP_SACK_SEEN     (1 << 0)   /*1 =3D peer is SACK capable, */
 #define TCP_DSACK_SEEN    (1 << 2)   /*1 =3D DSACK was received from peer*/
 =

+#if IS_ENABLED(CONFIG_MPTCP)
+struct mptcp_options_received {
+	u64	sndr_key;
+	u64	rcvr_key;
+	u8	mp_capable : 1,
+		mp_join : 1,
+		dss : 1,
+		version : 4;
+};
+#endif
+
 struct tcp_options_received {
 /*	PAWS/RTTM data	*/
 	int	ts_recent_stamp;/* Time we stored ts_recent (for aging) */
@@ -96,14 +107,7 @@ struct tcp_options_received {
 	u16	user_mss;	/* mss requested by user in ioctl	*/
 	u16	mss_clamp;	/* Maximal mss, negotiated at connection setup */
 #if IS_ENABLED(CONFIG_MPTCP)
-	struct mptcp_options_received {
-		u64	sndr_key;
-		u64	rcvr_key;
-		u8	mp_capable : 1,
-			mp_join : 1,
-			dss : 1,
-			version : 4;
-	} mptcp;
+	struct mptcp_options_received	mptcp;
 #endif
 };
 =

-- =

2.17.2

--===============2824719669782172577==--
