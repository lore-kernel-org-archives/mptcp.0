Content-Type: multipart/mixed; boundary="===============5495546674632952755=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 06/16] tcp: expose tcp routines and structs for
 MPTCP
Date: Wed, 28 Mar 2018 16:18:30 -0700
Message-ID: <20180328231840.12410-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180328231840.12410-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 450

--===============5495546674632952755==
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
index 500f81375200..572d664b8e8f 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -35,6 +35,9 @@ int inet_bind(struct socket *sock, struct sockaddr *uaddr=
, int addr_len);
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
index 01f4f56f8886..6b4ae84ddf38 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -56,6 +56,8 @@ unsigned int mptcp_synack_options(struct request_sock *re=
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
index 58f33b024411..f1be93536463 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -430,6 +430,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk=
, struct sk_buff *skb,
 int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb);
 int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 int tcp_connect(struct sock *sk);
+int tcp_v4_init_sock(struct sock *sk);
 enum tcp_synack_type {
 	TCP_SYNACK_NORMAL,
 	TCP_SYNACK_FASTOPEN,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index f98e2f0db841..fd6657a01289 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -930,7 +930,7 @@ int inet_ioctl(struct socket *sock, unsigned int cmd, u=
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
index 9639334ebb7c..1c1c1520931d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1287,7 +1287,7 @@ struct request_sock_ops tcp_request_sock_ops __read_m=
ostly =3D {
 	.syn_ack_timeout =3D	tcp_syn_ack_timeout,
 };
 =

-static const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops =3D {
+const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops =3D {
 	.mss_clamp	=3D	TCP_MSS_DEFAULT,
 #ifdef CONFIG_TCP_MD5SIG
 	.req_md5_lookup	=3D	tcp_v4_md5_lookup,
@@ -1876,7 +1876,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv4_spe=
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

2.16.3


--===============5495546674632952755==--
