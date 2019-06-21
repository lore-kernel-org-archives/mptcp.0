Content-Type: multipart/mixed; boundary="===============2466610972457717929=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 2/3] sock: Make sk_protocol a 16-bit value
Date: Fri, 21 Jun 2019 16:55:33 -0700
Message-ID: <20190621235534.19690-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20190621235534.19690-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1440

--===============2466610972457717929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Match the 16-bit width of skbuff->protocol. Fills an 8-bit hole so
sizeof(struct sock) does not change.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/sock.h          | 4 ++--
 include/trace/events/sock.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index fc6308773d18..2af5b8547b39 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -457,10 +457,10 @@ struct sock {
 				sk_no_check_tx : 1,
 				sk_no_check_rx : 1,
 				sk_userlocks : 4,
-				sk_protocol  : 8,
+				sk_pacing_shift : 8,
 				sk_type      : 16;
+	u16			sk_protocol;
 	u16			sk_gso_max_segs;
-	u8			sk_pacing_shift;
 	unsigned long	        sk_lingertime;
 	struct proto		*sk_prot_creator;
 	rwlock_t		sk_callback_lock;
diff --git a/include/trace/events/sock.h b/include/trace/events/sock.h
index a0c4b8a30966..dc749c651318 100644
--- a/include/trace/events/sock.h
+++ b/include/trace/events/sock.h
@@ -147,7 +147,7 @@ TRACE_EVENT(inet_sock_set_state,
 		__field(__u16, sport)
 		__field(__u16, dport)
 		__field(__u16, family)
-		__field(__u8, protocol)
+		__field(__u16, protocol)
 		__array(__u8, saddr, 4)
 		__array(__u8, daddr, 4)
 		__array(__u8, saddr_v6, 16)
-- =

2.22.0


--===============2466610972457717929==--
