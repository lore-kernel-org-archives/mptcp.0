Content-Type: multipart/mixed; boundary="===============5055389136352225038=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 6/6] mptcp: Add IPv6 support
Date: Tue, 05 Nov 2019 20:41:33 -0800
Message-ID: <20191106044133.14418-7-peter.krystad@linux.intel.com>
In-Reply-To: 20191106044133.14418-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2417

--===============5055389136352225038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add hooks for IPv6 as needed and initialize MPTCP
IPv6 support.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/mptcp.h  | 10 +++++++
 net/ipv6/tcp_ipv6.c  |  7 +++++
 net/mptcp/ctrl.c     | 11 ++++++++
 net/mptcp/protocol.c | 67 ++++++++++++++++++++++++++++++++++++++------
 net/mptcp/protocol.h |  3 ++
 net/mptcp/subflow.c  | 61 ++++++++++++++++++++++++++++++++++++++--
 6 files changed, 149 insertions(+), 10 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 1196a5588ce1..d19bc31a6250 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -152,4 +152,14 @@ static inline bool mptcp_sk_is_subflow(const struct so=
ck *sk)
 =

 static inline void mptcp_seq_show(struct seq_file *seq) { }
 #endif /* CONFIG_MPTCP */
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+int mptcpv6_init(void);
+#elif IS_ENABLED(CONFIG_IPV6)
+static inline int mptcpv6_init(void)
+{
+	return 0;
+}
+#endif
+
 #endif /* __NET_MPTCP_H */
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 50f6f21bbdb1..10d1c033d458 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2109,9 +2109,16 @@ int __init tcpv6_init(void)
 	ret =3D register_pernet_subsys(&tcpv6_net_ops);
 	if (ret)
 		goto out_tcpv6_protosw;
+
+	ret =3D mptcpv6_init();
+	if (ret)
+		goto out_tcpv6_pernet_subsys;
+
 out:
 	return ret;
 =

+out_tcpv6_pernet_subsys:
+	unregister_pernet_subsys(&tcpv6_net_ops);
 out_tcpv6_protosw:
 	inet6_unregister_protosw(&tcpv6_protosw);
 out_tcpv6_protocol:
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 6023c9f722ea..8e39585d37f3 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -117,3 +117,14 @@ void __init mptcp_init(void)
 	if (register_pernet_subsys(&mptcp_pernet_ops) < 0)
 		panic("Failed to register MPTCP pernet subsystem.\n");
 }
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+int __init mptcpv6_init(void)
+{
+	int err;
+
+	err =3D mptcp_proto_v6_init();
+
+	return err;
+}
+#endif
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 323b3e65dba2..0bb9af3bef02 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -16,6 +16,9 @@
 #include <net/inet_hashtables.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+#include <net/transp_v6.h>
+#endif
 #include <net/mptcp.h>
 #include "protocol.h"
 #include "mib.h"
@@ -1106,10 +1109,7 @@ static int mptcp_bind(struct socket *sock, struct so=
ckaddr *uaddr, int addr_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct socket *ssock;
-	int err =3D -ENOTSUPP;
-
-	if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
-		return err;
+	int err;
 =

 	ssock =3D mptcp_socket_create_get(msk);
 	if (IS_ERR(ssock))
@@ -1125,10 +1125,7 @@ static int mptcp_stream_connect(struct socket *sock,=
 struct sockaddr *uaddr,
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct socket *ssock;
-	int err =3D -ENOTSUPP;
-
-	if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
-		return err;
+	int err;
 =

 	ssock =3D mptcp_socket_create_get(msk);
 	if (IS_ERR(ssock))
@@ -1194,6 +1191,30 @@ static int mptcp_v4_getname(struct socket *sock, str=
uct sockaddr *uaddr,
 	return ret;
 }
 =

+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static int mptcp_v6_getname(struct socket *sock, struct sockaddr *uaddr,
+			    int peer)
+{
+	int ret;
+
+	if (sock->sk->sk_prot =3D=3D &tcpv6_prot) {
+		/* we are being invoked from __sys_accept4 after
+		 * mptcp_accept() has accepted a non-mp-capable
+		 * subflow: sk is a tcp_sk, not mptcp.
+		 *
+		 * Hand the socket over to tcp so all further
+		 * socket ops bypass mptcp.
+		 */
+		sock->ops =3D &inet6_stream_ops;
+		return sock->ops->getname(sock, uaddr, peer);
+	}
+
+	ret =3D mptcp_getname(sock, uaddr, peer);
+
+	return ret;
+}
+#endif
+
 static int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
@@ -1325,3 +1346,33 @@ void mptcp_proto_init(void)
 =

 	inet_register_protosw(&mptcp_protosw);
 }
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static struct proto_ops mptcp_v6_stream_ops;
+
+static struct inet_protosw mptcp_v6_protosw =3D {
+	.type		=3D SOCK_STREAM,
+	.protocol	=3D IPPROTO_MPTCP,
+	.prot		=3D &mptcp_prot,
+	.ops		=3D &mptcp_v6_stream_ops,
+	.flags		=3D INET_PROTOSW_ICSK,
+};
+
+int mptcp_proto_v6_init(void)
+{
+	int err;
+
+	mptcp_v6_stream_ops =3D inet6_stream_ops;
+	mptcp_v6_stream_ops.bind =3D mptcp_bind;
+	mptcp_v6_stream_ops.connect =3D mptcp_stream_connect;
+	mptcp_v6_stream_ops.poll =3D mptcp_poll;
+	mptcp_v6_stream_ops.accept =3D mptcp_stream_accept;
+	mptcp_v6_stream_ops.getname =3D mptcp_v6_getname;
+	mptcp_v6_stream_ops.listen =3D mptcp_listen;
+	mptcp_v6_stream_ops.shutdown =3D mptcp_shutdown;
+
+	err =3D inet6_register_protosw(&mptcp_v6_protosw);
+
+	return err;
+}
+#endif
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c6102ca3c79e..90942e0c3112 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -274,6 +274,9 @@ extern const struct inet_connection_sock_af_ops ipv6_sp=
ecific;
 #endif
 =

 void mptcp_proto_init(void);
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+int mptcp_proto_v6_init(void);
+#endif
 =

 struct mptcp_read_arg {
 	struct msghdr *msg;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 586713537124..b945460456b4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -15,6 +15,9 @@
 #include <net/inet_hashtables.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+#include <net/ip6_route.h>
+#endif
 #include <net/mptcp.h>
 #include "protocol.h"
 #include "mib.h"
@@ -154,6 +157,19 @@ static void subflow_v4_init_req(struct request_sock *r=
eq,
 	subflow_init_req(req, sk_listener, skb);
 }
 =

+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static void subflow_v6_init_req(struct request_sock *req,
+				const struct sock *sk_listener,
+				struct sk_buff *skb)
+{
+	tcp_rsk(req)->is_mptcp =3D 1;
+
+	tcp_request_sock_ipv6_ops.init_req(req, sk_listener, skb);
+
+	subflow_init_req(req, sk_listener, skb);
+}
+#endif
+
 /* validate received truncated hmac and create hmac for third ACK */
 static bool subflow_thmac_valid(struct mptcp_subflow_context *subflow)
 {
@@ -234,6 +250,31 @@ static int subflow_v4_conn_request(struct sock *sk, st=
ruct sk_buff *skb)
 	return 0;
 }
 =

+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
+static struct inet_connection_sock_af_ops subflow_v6_specific;
+
+static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+
+	pr_debug("subflow=3D%p", subflow);
+
+	if (skb->protocol =3D=3D htons(ETH_P_IP))
+		return tcp_v4_conn_request(sk, skb);
+
+	if (!ipv6_unicast_destination(skb))
+		goto drop;
+
+	return tcp_conn_request(&subflow_request_sock_ops,
+				&subflow_request_sock_ipv6_ops, sk, skb);
+
+drop:
+	tcp_listendrop(sk);
+	return 0; /* don't send reset */
+}
+#endif
+
 /* validate hmac received in third ACK */
 static bool subflow_hmac_valid(const struct request_sock *req,
 			       const struct tcp_options_received *rx_opt)
@@ -690,7 +731,8 @@ int mptcp_subflow_create_socket(struct sock *sk, struct=
 socket **new_sock)
 	struct socket *sf;
 	int err;
 =

-	err =3D sock_create_kern(net, PF_INET, SOCK_STREAM, IPPROTO_TCP, &sf);
+	err =3D sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
+			       &sf);
 	if (err)
 		return err;
 =

@@ -774,11 +816,15 @@ static int subflow_ulp_init(struct sock *sk)
 		goto out;
 	}
 =

-	pr_debug("subflow=3D%p", ctx);
+	pr_debug("subflow=3D%p, family=3D%d", ctx, sk->sk_family);
 =

 	tp->is_mptcp =3D 1;
 	ctx->icsk_af_ops =3D icsk->icsk_af_ops;
 	icsk->icsk_af_ops =3D &subflow_specific;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (sk->sk_family =3D=3D AF_INET6)
+		icsk->icsk_af_ops =3D &subflow_v6_specific;
+#endif
 	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
 	sk->sk_data_ready =3D subflow_data_ready;
 	sk->sk_write_space =3D subflow_write_space;
@@ -877,6 +923,17 @@ void mptcp_subflow_init(void)
 	subflow_specific.sk_rx_dst_set =3D subflow_finish_connect;
 	subflow_specific.rebuild_header =3D subflow_rebuild_header;
 =

+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	subflow_request_sock_ipv6_ops =3D tcp_request_sock_ipv6_ops;
+	subflow_request_sock_ipv6_ops.init_req =3D subflow_v6_init_req;
+
+	subflow_v6_specific =3D ipv6_specific;
+	subflow_v6_specific.conn_request =3D subflow_v6_conn_request;
+	subflow_v6_specific.syn_recv_sock =3D subflow_syn_recv_sock;
+	subflow_v6_specific.sk_rx_dst_set =3D subflow_finish_connect;
+	subflow_v6_specific.rebuild_header =3D subflow_rebuild_header;
+#endif
+
 	mptcp_diag_subflow_init(&subflow_ulp_ops);
 =

 	if (tcp_register_ulp(&subflow_ulp_ops) !=3D 0)
-- =

2.17.2

--===============5055389136352225038==--
