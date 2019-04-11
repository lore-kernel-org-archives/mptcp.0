Content-Type: multipart/mixed; boundary="===============3824683345807155231=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 2/2] mptcp: reorder mptcp rx options
Date: Thu, 11 Apr 2019 13:43:25 +0200
Message-ID: <20190411114325.29375-3-fw@strlen.de>
In-Reply-To: 20190411114325.29375-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1064

--===============3824683345807155231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Saves 8 bytes by closing a hole.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/linux/tcp.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 2f4178f3d127..db0297daa33c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -106,11 +106,6 @@ struct tcp_options_received {
 	u16	mss_clamp;	/* Maximal mss, negotiated at connection setup */
 #if IS_ENABLED(CONFIG_MPTCP)
 	struct mptcp_options_received {
-		u8      mp_capable : 1,
-			mp_join : 1,
-			dss : 1,
-			version : 4;
-		u8      flags;
 		u64     sndr_key;
 		u64     rcvr_key;
 		u64	data_ack;
@@ -118,6 +113,11 @@ struct tcp_options_received {
 		u32	subflow_seq;
 		u16	data_len;
 		__sum16	checksum;
+		u8      mp_capable : 1,
+			mp_join : 1,
+			dss : 1,
+			version : 4;
+		u8      flags;
 		u8	use_map:1,
 			dsn64:1,
 			use_checksum:1,
-- =

2.21.0


--===============3824683345807155231==--
