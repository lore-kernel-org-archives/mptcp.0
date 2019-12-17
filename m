Content-Type: multipart/mixed; boundary="===============8872470064194402252=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 02/11] sock: Make sk_protocol a 16-bit
 value
Date: Mon, 16 Dec 2019 16:24:46 -0800
Message-ID: <20191217002455.24849-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191217002455.24849-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3096

--===============8872470064194402252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Match the 16-bit width of skbuff->protocol. Fills an 8-bit hole so
sizeof(struct sock) does not change.

Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---

Changes for v2:

Moved sk_pacing_shift back to a regular struct member, adjacent to the
bitfield. gcc then packs the bitfield and the u8 in a single 32-bit word.


 include/net/sock.h          | 4 ++--
 include/trace/events/sock.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 81dc811aad2e..0930f46c600c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -456,10 +456,10 @@ struct sock {
 				sk_no_check_tx : 1,
 				sk_no_check_rx : 1,
 				sk_userlocks : 4,
-				sk_protocol  : 8,
 				sk_type      : 16;
-	u16			sk_gso_max_segs;
 	u8			sk_pacing_shift;
+	u16			sk_protocol;
+	u16			sk_gso_max_segs;
 	unsigned long	        sk_lingertime;
 	struct proto		*sk_prot_creator;
 	rwlock_t		sk_callback_lock;
diff --git a/include/trace/events/sock.h b/include/trace/events/sock.h
index 51fe9f6719eb..3ff12b90048d 100644
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

2.24.1

--===============8872470064194402252==--
