Content-Type: multipart/mixed; boundary="===============2340250262926260685=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/3] mptcp:options: merge two holes in one
Date: Wed, 02 Oct 2019 18:40:32 +0200
Message-ID: <20191002164032.11111-4-matthieu.baerts@tessares.net>
In-Reply-To: 20191002164032.11111-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1986

--===============2340250262926260685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of having two u8 not fully used, we switch to one u16 with only
one "__unused" variable.

I guess we will want to optimise this code in
'struct tcp_options_received' to use even more unions and reduce the
structure size, e.g. we cannot receive an MP_CAPABLE option and an
MP_JOIN one, etc.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 include/linux/tcp.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 58902cea4a26..b6fce4c93f3a 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -115,15 +115,15 @@ struct tcp_options_received {
 		u64     thmac;
 		u8      hmac[20];
 		u8	dss_flags;
-		u8	use_map:1,
-			dsn64:1,
-			data_fin:1,
-			use_ack:1,
-			ack64:1,
-			__unused:3;
-		u8	add_addr : 1,
+		u16	use_map : 1,
+			dsn64 : 1,
+			data_fin : 1,
+			use_ack : 1,
+			ack64 : 1,
+			add_addr : 1,
 			rm_addr : 1,
 			family : 4;
+			__unused : 5;
 		u8	addr_id;
 		union {
 			struct	in_addr	addr;
-- =

2.20.1

--===============2340250262926260685==--
