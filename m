Content-Type: multipart/mixed; boundary="===============5603008724937839049=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] tcp: Let do_tcp_sendpages accept a pre-allocated
 initial skb
Date: Fri, 20 Oct 2017 16:02:32 -0700
Message-ID: <20171020230232.14721-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20171020230232.14721-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 131

--===============5603008724937839049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows the caller to optionally provide an skb with special
characteristics (like a shared control buffer) to use for the first
packet.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/tcp.h  |  2 +-
 net/ipv4/tcp.c     | 12 +++++++++---
 net/tls/tls_main.c |  3 ++-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5a95e5886b55..f0b54ff368bc 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -355,7 +355,7 @@ int tcp_sendpage(struct sock *sk, struct page *page, in=
t offset, size_t size,
 int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
 			size_t size, int flags);
 ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
-		 size_t size, int flags);
+			 size_t size, int flags, struct sk_buff *first_skb);
 void tcp_release_cb(struct sock *sk);
 void tcp_wfree(struct sk_buff *skb);
 void tcp_write_timer_handler(struct sock *sk);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3b34850d361f..df0d5128dfa1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -931,7 +931,7 @@ static int tcp_send_mss(struct sock *sk, int *size_goal=
, int flags)
 }
 =

 ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
-			 size_t size, int flags)
+			 size_t size, int flags, struct sk_buff *first_skb)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	int mss_now, size_goal;
@@ -964,7 +964,13 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page =
*page, int offset,
 		int copy, i;
 		bool can_coalesce;
 =

-		if (!skb || (copy =3D size_goal - skb->len) <=3D 0 ||
+		if (first_skb) {
+			skb =3D first_skb;
+			first_skb =3D NULL;
+
+			skb_entail(sk, skb);
+			copy =3D size_goal;
+		} else if (!skb || (copy =3D size_goal - skb->len) <=3D 0 ||
 		    !tcp_skb_can_collapse_to(skb)) {
 new_segment:
 			if (!sk_stream_memory_free(sk))
@@ -1072,7 +1078,7 @@ int tcp_sendpage_locked(struct sock *sk, struct page =
*page, int offset,
 =

 	tcp_rate_check_app_limited(sk);  /* is sending application-limited? */
 =

-	return do_tcp_sendpages(sk, page, offset, size, flags);
+	return do_tcp_sendpages(sk, page, offset, size, flags, NULL);
 }
 EXPORT_SYMBOL_GPL(tcp_sendpage_locked);
 =

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 60aff60e30ad..7f9aad13e8ce 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -95,7 +95,8 @@ int tls_push_sg(struct sock *sk,
 		tcp_rate_check_app_limited(sk);
 		p =3D sg_page(sg);
 retry:
-		ret =3D do_tcp_sendpages(sk, p, offset, size, sendpage_flags);
+		ret =3D do_tcp_sendpages(sk, p, offset, size, sendpage_flags,
+				       NULL);
 =

 		if (ret !=3D size) {
 			if (ret > 0) {
-- =

2.14.2


--===============5603008724937839049==--
