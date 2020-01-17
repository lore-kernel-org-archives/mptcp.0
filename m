Content-Type: multipart/mixed; boundary="===============4722580719759170737=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Optimize MP_JOIN fields in
 mptcp_options_received
Date: Thu, 16 Jan 2020 23:01:37 -0800
Message-ID: <20200117070137.5987-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3391

--===============4722580719759170737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use union to minimize space used in structure.

squashto: Add handling of incoming MP_JOIN requests

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index ff0db270f3d4..069c7dad49eb 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -105,6 +105,15 @@ struct mptcp_options_received {
 			u8	addr6_id;
 		};
 #endif
+		union {
+			struct {
+				u32	token;
+				u32	nonce;
+				u64	thmac;
+				u8	join_id;
+			};
+			u8	hmac[20];
+		};
 	};
 	u32	subflow_seq;
 	u16	data_len;
@@ -115,11 +124,6 @@ struct mptcp_options_received {
 		add_addr6 : 1,
 		rm_addr : 1,
 		backup : 1;
-	u8	join_id;
-	u32	token;
-	u32	nonce;
-	u64	thmac;
-	u8	hmac[20];
 	u8	use_map:1,
 		dsn64:1,
 		data_fin:1,
-- =

2.17.2

--===============4722580719759170737==--
