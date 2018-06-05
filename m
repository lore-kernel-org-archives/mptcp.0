Content-Type: multipart/mixed; boundary="===============3509439577978894909=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v2 06/19] tcp: expose tcp routines and structs for
 MPTCP
Date: Tue, 05 Jun 2018 16:40:25 -0700
Message-ID: <20180605234038.28497-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180605234038.28497-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 649

--===============3509439577978894909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)intel.com>

tcp_v4_init_sock(), inet_compat_ioctl()
tcp_request_sock_ipv4_ops

This function is needed for MPTCP subflow initialization.

Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
---
 include/net/inet_common.h | 3 +++
 include/net/mptcp.h       | 2 ++
 include/net/tcp.h         | 1 +
 net/ipv4/af_inet.c        | 2 +-
 net/ipv4/tcp_ipv4.c       | 4 ++--
 5 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index 384b90c62c0b..8926376dee0a 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -37,6 +37,9 @@ int __inet_bind(struct sock *sk, struct sockaddr *uaddr, =
int addr_len,
 int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 		 int peer);
 int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
+#ifdef CONFIG_COMPAT
+int inet_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long=
 arg);
+#endif
 int inet_ctl_sock_create(struct sock **sk, unsigned short family,
 			 unsigned short type, unsigned char protocol,
 			 struct net *net);
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 736febd2a9d4..d26effbed0e0 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -58,6 +58,8 @@ unsigned int mptcp_synack_options(struct request_sock *re=
q,
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *options);
 =

+extern const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops;
+
 #else
 =

 static inline void mptcp_parse_option(const unsigned char *ptr, int opsize,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index a1d4e744b258..b5051438698f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -434,6 +434,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk=
, struct sk_buff *skb,
 int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb);
 int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 int tcp_connect(struct sock *sk);
+int tcp_v4_init_sock(struct sock *sk);
 enum tcp_synack_type {
 	TCP_SYNACK_NORMAL,
 	TCP_SYNACK_FASTOPEN,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index b403499fdabe..2c2e60b9a75f 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -965,7 +965,7 @@ int inet_ioctl(struct socket *sock, unsigned int cmd, u=
nsigned long arg)
 EXPORT_SYMBOL(inet_ioctl);
 =

 #ifdef CONFIG_COMPAT
-static int inet_compat_ioctl(struct socket *sock, unsigned int cmd, unsign=
ed long arg)
+int inet_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long=
 arg)
 {
 	struct sock *sk =3D sock->sk;
 	int err =3D -ENOIOCTLCMD;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 633963e228bc..56b7bc83b320 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1343,7 +1343,7 @@ struct request_sock_ops tcp_request_sock_ops __read_m=
ostly =3D {
 	.syn_ack_timeout =3D	tcp_syn_ack_timeout,
 };
 =

-static const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops =3D {
+const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops =3D {
 	.mss_clamp	=3D	TCP_MSS_DEFAULT,
 #ifdef CONFIG_TCP_MD5SIG
 	.req_md5_lookup	=3D	tcp_v4_md5_lookup,
@@ -1932,7 +1932,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv4_spe=
cific =3D {
 /* NOTE: A lot of things set to zero explicitly by call to
  *       sk_alloc() so need not be done here.
  */
-static int tcp_v4_init_sock(struct sock *sk)
+int tcp_v4_init_sock(struct sock *sk)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
 =

-- =

2.17.1


--===============3509439577978894909==--
