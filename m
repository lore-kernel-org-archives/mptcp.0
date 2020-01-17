Content-Type: multipart/mixed; boundary="===============6843840190414559359=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Optimize DSS fields in mptcp_options_received
Date: Thu, 16 Jan 2020 23:00:30 -0800
Message-ID: <20200117070030.5825-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3388

--===============6843840190414559359==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use union to minimize space used in structure.
Allow 32-bit DSS to be received at the same time as MP_CAPABLE.

squashto: Implement MPTCP receive path

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6abf8d9f1a42..a9200a86a6d2 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -80,12 +80,18 @@ struct tcp_sack_block {
 =

 #if IS_ENABLED(CONFIG_MPTCP)
 struct mptcp_options_received {
-	u64	sndr_key;
-	u64	rcvr_key;
-	u32	data_ack32;
-	u32	data_seq32;
-	u64	data_ack;
-	u64	data_seq;
+	union {
+		struct {
+			u64	sndr_key;
+			u64	rcvr_key;
+			u32	data_ack32;
+			u32	data_seq32;
+		};
+		struct {
+			u64	data_ack;
+			u64	data_seq;
+		};
+	};
 	u32	subflow_seq;
 	u16	data_len;
 	u8	mp_capable : 1,
-- =

2.17.2

--===============6843840190414559359==--
