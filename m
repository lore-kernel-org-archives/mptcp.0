Content-Type: multipart/mixed; boundary="===============7973633173060561566=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 08/11] tcp: Export TCP functions and ops struct
Date: Fri, 13 Dec 2019 21:48:21 +0100
Message-ID: <20191213204824.2464461-9-matthieu.baerts@tessares.net>
In-Reply-To: 20191213204824.2464461-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2989

--===============7973633173060561566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

MPTCP will make use of tcp_send_mss() and tcp_push() when sending
data to specific TCP subflows.

tcp_request_sock_ipv4_ops will be referenced during TCP subflow
creation.

Co-developed-by: Peter Krystad <peter.krystad(a)linux.intel.com>
Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 include/net/tcp.h   | 8 ++++++++
 net/ipv4/tcp.c      | 6 +++---
 net/ipv4/tcp_ipv4.c | 2 +-
 net/ipv6/tcp_ipv6.c | 6 +++---
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index c483c73b8d41..921288afa11b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -330,6 +330,9 @@ int tcp_sendpage_locked(struct sock *sk, struct page *p=
age, int offset,
 			size_t size, int flags);
 ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
 		 size_t size, int flags);
+int tcp_send_mss(struct sock *sk, int *size_goal, int flags);
+void tcp_push(struct sock *sk, int flags, int mss_now, int nonagle,
+	      int size_goal);
 void tcp_release_cb(struct sock *sk);
 void tcp_wfree(struct sk_buff *skb);
 void tcp_write_timer_handler(struct sock *sk);
@@ -2002,6 +2005,11 @@ struct tcp_request_sock_ops {
 			   enum tcp_synack_type synack_type);
 };
 =

+extern const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops;
+#if IS_ENABLED(CONFIG_IPV6)
+extern const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops;
+#endif
+
 #ifdef CONFIG_SYN_COOKIES
 static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops=
 *ops,
 					 const struct sock *sk, struct sk_buff *skb,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 09e2cae92956..932834eb467d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -690,8 +690,8 @@ static bool tcp_should_autocork(struct sock *sk, struct=
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
@@ -925,7 +925,7 @@ static unsigned int tcp_xmit_size_goal(struct sock *sk,=
 u32 mss_now,
 	return max(size_goal, mss_now);
 }
 =

-static int tcp_send_mss(struct sock *sk, int *size_goal, int flags)
+int tcp_send_mss(struct sock *sk, int *size_goal, int flags)
 {
 	int mss_now;
 =

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 26637fce324d..c3b91789de65 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1372,7 +1372,7 @@ struct request_sock_ops tcp_request_sock_ops __read_m=
ostly =3D {
 	.syn_ack_timeout =3D	tcp_syn_ack_timeout,
 };
 =

-static const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops =3D {
+const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops =3D {
 	.mss_clamp	=3D	TCP_MSS_DEFAULT,
 #ifdef CONFIG_TCP_MD5SIG
 	.req_md5_lookup	=3D	tcp_v4_md5_lookup,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index df5fd9109696..30dceac8a608 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -75,7 +75,7 @@ static void	tcp_v6_reqsk_send_ack(const struct sock *sk, =
struct sk_buff *skb,
 static int	tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb);
 =

 static const struct inet_connection_sock_af_ops ipv6_mapped;
-static const struct inet_connection_sock_af_ops ipv6_specific;
+const struct inet_connection_sock_af_ops ipv6_specific;
 #ifdef CONFIG_TCP_MD5SIG
 static const struct tcp_sock_af_ops tcp_sock_ipv6_specific;
 static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
@@ -785,7 +785,7 @@ struct request_sock_ops tcp6_request_sock_ops __read_mo=
stly =3D {
 	.syn_ack_timeout =3D	tcp_syn_ack_timeout,
 };
 =

-static const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops =3D {
+const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops =3D {
 	.mss_clamp	=3D	IPV6_MIN_MTU - sizeof(struct tcphdr) -
 				sizeof(struct ipv6hdr),
 #ifdef CONFIG_TCP_MD5SIG
@@ -1739,7 +1739,7 @@ static struct timewait_sock_ops tcp6_timewait_sock_op=
s =3D {
 	.twsk_destructor =3D tcp_twsk_destructor,
 };
 =

-static const struct inet_connection_sock_af_ops ipv6_specific =3D {
+const struct inet_connection_sock_af_ops ipv6_specific =3D {
 	.queue_xmit	   =3D inet6_csk_xmit,
 	.send_check	   =3D tcp_v6_send_check,
 	.rebuild_header	   =3D inet6_sk_rebuild_header,
-- =

2.24.0

--===============7973633173060561566==--
