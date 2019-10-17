Content-Type: multipart/mixed; boundary="===============4056683948372393909=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 1/2] mptcp: Export low-level routines for IPv6
Date: Wed, 16 Oct 2019 17:02:05 -0700
Message-ID: <20191017000206.10559-2-peter.krystad@linux.intel.com>
In-Reply-To: 20191017000206.10559-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2196

--===============4056683948372393909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All routines exported already have their IPv4 counterparts exported.
tcp_request_sock_ipv6_ops will be referenced during TCP subflow
creation.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/tcp.h    |  8 ++++++++
 net/ipv6/tcp_ipv6.c  | 22 +++++++++++++---------
 net/mptcp/protocol.h |  3 +++
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7f254765074f..39a31a1f0775 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -464,6 +464,13 @@ void tcp_finish_connect(struct sock *sk, struct sk_buf=
f *skb);
 int tcp_send_rcvq(struct sock *sk, struct msghdr *msg, size_t size);
 void inet_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb);
 =

+struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *s=
kb,
+				  struct request_sock *req,
+				  struct dst_entry *dst,
+				  struct request_sock *req_unhash,
+				  bool *own_req);
+void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb);
+
 /* From syncookies.c */
 struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 				 struct request_sock *req,
@@ -1987,6 +1994,7 @@ struct tcp_request_sock_ops {
 };
 =

 extern const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops;
+extern const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops;
 =

 #ifdef CONFIG_SYN_COOKIES
 static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops=
 *ops,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e3d9f4559c99..1f3a87f4867e 100644
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
@@ -99,7 +99,7 @@ static struct ipv6_pinfo *tcp_inet6_sk(const struct sock =
*sk)
 	return (struct ipv6_pinfo *)(((u8 *)sk) + offset);
 }
 =

-static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
+void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
 {
 	struct dst_entry *dst =3D skb_dst(skb);
 =

@@ -111,6 +111,7 @@ static void inet6_sk_rx_dst_set(struct sock *sk, const =
struct sk_buff *skb)
 		tcp_inet6_sk(sk)->rx_dst_cookie =3D rt6_get_cookie(rt);
 	}
 }
+EXPORT_SYMBOL(inet6_sk_rx_dst_set);
 =

 static u32 tcp_v6_init_seq(const struct sk_buff *skb)
 {
@@ -784,7 +785,7 @@ struct request_sock_ops tcp6_request_sock_ops __read_mo=
stly =3D {
 	.syn_ack_timeout =3D	tcp_syn_ack_timeout,
 };
 =

-static const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops =3D {
+const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops =3D {
 	.mss_clamp	=3D	IPV6_MIN_MTU - sizeof(struct tcphdr) -
 				sizeof(struct ipv6hdr),
 #ifdef CONFIG_TCP_MD5SIG
@@ -800,6 +801,7 @@ static const struct tcp_request_sock_ops tcp_request_so=
ck_ipv6_ops =3D {
 	.init_ts_off	=3D	tcp_v6_init_ts_off,
 	.send_synack	=3D	tcp_v6_send_synack,
 };
+EXPORT_SYMBOL(tcp_request_sock_ipv6_ops);
 =

 static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *sk=
b, u32 seq,
 				 u32 ack, u32 win, u32 tsval, u32 tsecr,
@@ -1110,11 +1112,11 @@ static void tcp_v6_restore_cb(struct sk_buff *skb)
 		sizeof(struct inet6_skb_parm));
 }
 =

-static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_=
buff *skb,
-					 struct request_sock *req,
-					 struct dst_entry *dst,
-					 struct request_sock *req_unhash,
-					 bool *own_req)
+struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *s=
kb,
+				  struct request_sock *req,
+				  struct dst_entry *dst,
+				  struct request_sock *req_unhash,
+				  bool *own_req)
 {
 	struct inet_request_sock *ireq;
 	struct ipv6_pinfo *newnp;
@@ -1314,6 +1316,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct=
 sock *sk, struct sk_buff *
 	tcp_listendrop(sk);
 	return NULL;
 }
+EXPORT_SYMBOL(tcp_v6_syn_recv_sock);
 =

 /* The socket must have it's spinlock held when we get
  * here, unless it is a TCP_LISTEN socket.
@@ -1738,7 +1741,7 @@ static struct timewait_sock_ops tcp6_timewait_sock_op=
s =3D {
 	.twsk_destructor =3D tcp_twsk_destructor,
 };
 =

-static const struct inet_connection_sock_af_ops ipv6_specific =3D {
+const struct inet_connection_sock_af_ops ipv6_specific =3D {
 	.queue_xmit	   =3D inet6_csk_xmit,
 	.send_check	   =3D tcp_v6_send_check,
 	.rebuild_header	   =3D inet6_sk_rebuild_header,
@@ -1757,6 +1760,7 @@ static const struct inet_connection_sock_af_ops ipv6_=
specific =3D {
 #endif
 	.mtu_reduced	   =3D tcp_v6_mtu_reduced,
 };
+EXPORT_SYMBOL(ipv6_specific);
 =

 #ifdef CONFIG_TCP_MD5SIG
 static const struct tcp_sock_af_ops tcp_sock_ipv6_specific =3D {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 791f2c19cfb8..6f09fdfdd523 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -268,6 +268,9 @@ int mptcp_subflow_connect(struct sock *sk, struct socka=
ddr *local,
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
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

--===============4056683948372393909==--
