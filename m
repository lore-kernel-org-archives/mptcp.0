Content-Type: multipart/mixed; boundary="===============8404157658030287924=="
MIME-Version: 1.0
From: Geert Uytterhoeven <geert at linux-m68k.org>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Fix undefined mptcp_handle_ipv6_mapped for
 modular IPV6
Date: Thu, 30 Jan 2020 10:45:26 +0100
Message-ID: <20200130094526.22483-1-geert@linux-m68k.org>
X-Status: 
X-Keywords:                  
X-UID: 3564

--===============8404157658030287924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If CONFIG_MPTCP=3Dy, CONFIG_MPTCP_IPV6=3Dn, and CONFIG_IPV6=3Dm:

    ERROR: "mptcp_handle_ipv6_mapped" [net/ipv6/ipv6.ko] undefined!

This does not happen if CONFIG_MPTCP_IPV6=3Dy, as CONFIG_MPTCP_IPV6
selects CONFIG_IPV6, and thus forces CONFIG_IPV6 builtin.

As exporting a symbol for an empty function would be a bit wasteful, fix
this by providing a dummy version of mptcp_handle_ipv6_mapped() for the
CONFIG_MPTCP_IPV6=3Dn case.

Rename mptcp_handle_ipv6_mapped() to mptcpv6_handle_mapped(), to make it
clear this is a pure-IPV6 function, just like mptcpv6_init().

Fixes: cec37a6e41aae7bf ("mptcp: Handle MP_CAPABLE options for outgoing con=
nections")
Signed-off-by: Geert Uytterhoeven <geert(a)linux-m68k.org>
---
 include/net/mptcp.h | 9 +++------
 net/ipv6/tcp_ipv6.c | 6 +++---
 net/mptcp/subflow.c | 6 +++---
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 27627e2d1bc2e9a1..c971d25431ea9412 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -174,15 +174,12 @@ static inline bool mptcp_skb_can_collapse(const struc=
t sk_buff *to,
 =

 #endif /* CONFIG_MPTCP */
 =

-void mptcp_handle_ipv6_mapped(struct sock *sk, bool mapped);
-
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int mptcpv6_init(void);
+void mptcpv6_handle_mapped(struct sock *sk, bool mapped);
 #elif IS_ENABLED(CONFIG_IPV6)
-static inline int mptcpv6_init(void)
-{
-	return 0;
-}
+static inline int mptcpv6_init(void) { return 0; }
+static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
 #endif
 =

 #endif /* __NET_MPTCP_H */
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 33a578a3eb3abadb..eaf09e6b78442e09 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -239,7 +239,7 @@ static int tcp_v6_connect(struct sock *sk, struct socka=
ddr *uaddr,
 =

 		icsk->icsk_af_ops =3D &ipv6_mapped;
 		if (sk_is_mptcp(sk))
-			mptcp_handle_ipv6_mapped(sk, true);
+			mptcpv6_handle_mapped(sk, true);
 		sk->sk_backlog_rcv =3D tcp_v4_do_rcv;
 #ifdef CONFIG_TCP_MD5SIG
 		tp->af_specific =3D &tcp_sock_ipv6_mapped_specific;
@@ -251,7 +251,7 @@ static int tcp_v6_connect(struct sock *sk, struct socka=
ddr *uaddr,
 			icsk->icsk_ext_hdr_len =3D exthdrlen;
 			icsk->icsk_af_ops =3D &ipv6_specific;
 			if (sk_is_mptcp(sk))
-				mptcp_handle_ipv6_mapped(sk, false);
+				mptcpv6_handle_mapped(sk, false);
 			sk->sk_backlog_rcv =3D tcp_v6_do_rcv;
 #ifdef CONFIG_TCP_MD5SIG
 			tp->af_specific =3D &tcp_sock_ipv6_specific;
@@ -1208,7 +1208,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct=
 sock *sk, struct sk_buff *
 =

 		inet_csk(newsk)->icsk_af_ops =3D &ipv6_mapped;
 		if (sk_is_mptcp(newsk))
-			mptcp_handle_ipv6_mapped(newsk, true);
+			mptcpv6_handle_mapped(newsk, true);
 		newsk->sk_backlog_rcv =3D tcp_v4_do_rcv;
 #ifdef CONFIG_TCP_MD5SIG
 		newtp->af_specific =3D &tcp_sock_ipv6_mapped_specific;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1662e117894900a8..de04b03fa41e70a6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -582,9 +582,9 @@ subflow_default_af_ops(struct sock *sk)
 	return &subflow_specific;
 }
 =

-void mptcp_handle_ipv6_mapped(struct sock *sk, bool mapped)
-{
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
+void mptcpv6_handle_mapped(struct sock *sk, bool mapped)
+{
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
 	struct inet_connection_sock_af_ops *target;
@@ -599,8 +599,8 @@ void mptcp_handle_ipv6_mapped(struct sock *sk, bool map=
ped)
 =

 	subflow->icsk_af_ops =3D icsk->icsk_af_ops;
 	icsk->icsk_af_ops =3D target;
-#endif
 }
+#endif
 =

 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 {
-- =

2.17.1

--===============8404157658030287924==--
