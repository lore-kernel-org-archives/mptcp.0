Content-Type: multipart/mixed; boundary="===============1451141528810202265=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 14/16] tcp: Export low-level TCP functions
Date: Wed, 28 Mar 2018 16:18:38 -0700
Message-ID: <20180328231840.12410-15-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180328231840.12410-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 456

--===============1451141528810202265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/tcp.h |  4 ++++
 net/ipv4/tcp.c    | 12 ++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f1be93536463..21955e4f4b39 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -330,6 +330,10 @@ int tcp_sendpage_locked(struct sock *sk, struct page *=
page, int offset,
 			size_t size, int flags);
 ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
 		 size_t size, int flags);
+int tcp_send_mss(struct sock *sk, int *size_goal, int flags);
+void tcp_skb_entail(struct sock *sk, struct sk_buff *skb);
+void tcp_push(struct sock *sk, int flags, int mss_now, int nonagle,
+	      int size_goal);
 void tcp_release_cb(struct sock *sk);
 void tcp_wfree(struct sk_buff *skb);
 void tcp_write_timer_handler(struct sock *sk);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0c31be306572..80093e91c25e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -649,7 +649,7 @@ static inline bool forced_push(const struct tcp_sock *t=
p)
 	return after(tp->write_seq, tp->pushed_seq + (tp->max_window >> 1));
 }
 =

-static void skb_entail(struct sock *sk, struct sk_buff *skb)
+void tcp_skb_entail(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
@@ -693,8 +693,8 @@ static bool tcp_should_autocork(struct sock *sk, struct=
 sk_buff *skb,
 	       refcount_read(&sk->sk_wmem_alloc) > skb->truesize;
 }
 =

-static void tcp_push(struct sock *sk, int flags, int mss_now,
-		     int nonagle, int size_goal)
+void tcp_push(struct sock *sk, int flags, int mss_now,
+	      int nonagle, int size_goal)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct sk_buff *skb;
@@ -917,7 +917,7 @@ static unsigned int tcp_xmit_size_goal(struct sock *sk,=
 u32 mss_now,
 	return max(size_goal, mss_now);
 }
 =

-static int tcp_send_mss(struct sock *sk, int *size_goal, int flags)
+int tcp_send_mss(struct sock *sk, int *size_goal, int flags)
 {
 	int mss_now;
 =

@@ -972,7 +972,7 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page *=
page, int offset,
 			if (!skb)
 				goto wait_for_memory;
 =

-			skb_entail(sk, skb);
+			tcp_skb_entail(sk, skb);
 			copy =3D size_goal;
 		}
 =

@@ -1286,7 +1286,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr=
 *msg, size_t size)
 			process_backlog =3D true;
 			skb->ip_summed =3D CHECKSUM_PARTIAL;
 =

-			skb_entail(sk, skb);
+			tcp_skb_entail(sk, skb);
 			copy =3D size_goal;
 =

 			/* All packets are restored as if they have
-- =

2.16.3


--===============1451141528810202265==--
