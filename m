Content-Type: multipart/mixed; boundary="===============4177550154356978941=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/3] mptcp: removed unused fields in structure: tcp.h
Date: Wed, 02 Oct 2019 18:40:31 +0200
Message-ID: <20191002164032.11111-3-matthieu.baerts@tessares.net>
In-Reply-To: 20191002164032.11111-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1985

--===============4177550154356978941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

checksum feature is no longer (partly) supported, we can remove them as
well.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    To be squashed in "mptcp: Implement MPTCP receive path"

 include/linux/tcp.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 3b69ab99e666..58902cea4a26 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -103,7 +103,6 @@ struct tcp_options_received {
 		u64	data_seq;
 		u32	subflow_seq;
 		u16	data_len;
-		__sum16	checksum;
 		u8      mp_capable : 1,
 			mp_join : 1,
 			dss : 1,
@@ -118,11 +117,10 @@ struct tcp_options_received {
 		u8	dss_flags;
 		u8	use_map:1,
 			dsn64:1,
-			use_checksum:1,
 			data_fin:1,
 			use_ack:1,
 			ack64:1,
-			__unused:2;
+			__unused:3;
 		u8	add_addr : 1,
 			rm_addr : 1,
 			family : 4;
-- =

2.20.1

--===============4177550154356978941==--
