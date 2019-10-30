Content-Type: multipart/mixed; boundary="===============5922575947714486350=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 5/6] mptcp: Export low-level routines for IPv6
Date: Wed, 30 Oct 2019 16:38:43 -0700
Message-ID: <20191030233844.4790-6-peter.krystad@linux.intel.com>
In-Reply-To: 20191030233844.4790-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2369

--===============5922575947714486350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ipv6_specific and tcp_request_sock_ipv6_ops will be referenced
during TCP subflow creation.

squashto: tcp: Export TCP functions and ops

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/tcp.h    | 3 +++
 net/ipv6/tcp_ipv6.c  | 9 +++++----
 net/mptcp/protocol.h | 3 +++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f1a0bdb7d1b1..74840bb2a4f3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1990,6 +1990,9 @@ struct tcp_request_sock_ops {
 };
 =

 extern const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops;
+#if IS_ENABLED(CONFIG_IPV6)
+extern const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops;
+#endif
 =

 #ifdef CONFIG_SYN_COOKIES
 static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops=
 *ops,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 4804b6dc5e65..50f6f21bbdb1 100644
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
@@ -1111,7 +1111,8 @@ static void tcp_v6_restore_cb(struct sk_buff *skb)
 		sizeof(struct inet6_skb_parm));
 }
 =

-static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_=
buff *skb,
+static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk,
+					 struct sk_buff *skb,
 					 struct request_sock *req,
 					 struct dst_entry *dst,
 					 struct request_sock *req_unhash,
@@ -1739,7 +1740,7 @@ static struct timewait_sock_ops tcp6_timewait_sock_op=
s =3D {
 	.twsk_destructor =3D tcp_twsk_destructor,
 };
 =

-static const struct inet_connection_sock_af_ops ipv6_specific =3D {
+const struct inet_connection_sock_af_ops ipv6_specific =3D {
 	.queue_xmit	   =3D inet6_csk_xmit,
 	.send_check	   =3D tcp_v6_send_check,
 	.rebuild_header	   =3D inet6_sk_rebuild_header,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2635d68e58a0..71967bac03c0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -270,6 +270,9 @@ int mptcp_subflow_create_socket(struct sock *sk, sa_fam=
ily_t family,
 				struct socket **new_sock);
 =

 extern const struct inet_connection_sock_af_ops ipv4_specific;
+#if IS_ENABLED(CONFIG_IPV6)
+extern const struct inet_connection_sock_af_ops ipv6_specific;
+#endif
 =

 void mptcp_proto_init(void);
 =

-- =

2.17.2

--===============5922575947714486350==--
