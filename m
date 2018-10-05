Content-Type: multipart/mixed; boundary="===============1959146363112715077=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v3 06/16] tcp: expose tcp routines and structs for
 MPTCP
Date: Fri, 05 Oct 2018 15:59:08 -0700
Message-ID: <20181005225918.9786-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20181005225918.9786-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 771

--===============1959146363112715077==
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
index 3ca969cbd161..1782c0d2ec32 100644
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
index f88213e31fbe..79daad717275 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -55,6 +55,8 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *options);
 =

+extern const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops;
+
 #else
 =

 static inline void mptcp_parse_option(const unsigned char *ptr, int opsize,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 56a3455f7a50..48c59c0d8760 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -436,6 +436,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk=
, struct sk_buff *skb,
 int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb);
 int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 int tcp_connect(struct sock *sk);
+int tcp_v4_init_sock(struct sock *sk);
 enum tcp_synack_type {
 	TCP_SYNACK_NORMAL,
 	TCP_SYNACK_FASTOPEN,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 20fda8fb8ffd..46a9ecd5c8f0 100644
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
index 9e041fa5c545..1b22b2f83719 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1357,7 +1357,7 @@ struct request_sock_ops tcp_request_sock_ops __read_m=
ostly =3D {
 	.syn_ack_timeout =3D	tcp_syn_ack_timeout,
 };
 =

-static const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops =3D {
+const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops =3D {
 	.mss_clamp	=3D	TCP_MSS_DEFAULT,
 #ifdef CONFIG_TCP_MD5SIG
 	.req_md5_lookup	=3D	tcp_v4_md5_lookup,
@@ -1950,7 +1950,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv4_spe=
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

2.19.1


--===============1959146363112715077==--
