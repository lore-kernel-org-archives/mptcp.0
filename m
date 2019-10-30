Content-Type: multipart/mixed; boundary="===============3389209103890597765=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 6/6] mptcp: Add IPv6 support
Date: Wed, 30 Oct 2019 16:38:44 -0700
Message-ID: <20191030233844.4790-7-peter.krystad@linux.intel.com>
In-Reply-To: 20191030233844.4790-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2370

--===============3389209103890597765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mimic hooks and option handling for IPv6 as was done for
IPv4 MPTCP sockets.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/mptcp.h  |   3 ++
 net/ipv6/tcp_ipv6.c  |   7 +++
 net/mptcp/ctrl.c     |  11 +++++
 net/mptcp/protocol.c |  85 ++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |   3 ++
 net/mptcp/subflow.c  | 107 ++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 209 insertions(+), 7 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index eba39a881767..41225c50aebb 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -53,6 +53,9 @@ struct mptcp_out_options {
 #ifdef CONFIG_MPTCP
 =

 void mptcp_init(void);
+#if IS_ENABLED(CONFIG_IPV6)
+int mptcpv6_init(void);
+#endif
 =

 static inline bool sk_is_mptcp(const struct sock *sk)
 {
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
index 6023c9f722ea..a8c5652e0203 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -117,3 +117,14 @@ void __init mptcp_init(void)
 	if (register_pernet_subsys(&mptcp_pernet_ops) < 0)
 		panic("Failed to register MPTCP pernet subsystem.\n");
 }
+
+#if IS_ENABLED(CONFIG_IPV6)
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
index 9659afc9b444..640921705011 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -17,6 +17,7 @@
 #include <net/protocol.h>
 #include <net/tcp.h>
 #include <net/mptcp.h>
+#include <net/transp_v6.h>
 #include "protocol.h"
 #include "mib.h"
 =

@@ -1130,17 +1131,26 @@ static int mptcp_v4_bind(struct socket *sock, struc=
t sockaddr *uaddr,
 	return err;
 }
 =

+#if IS_ENABLED(CONFIG_IPV6)
+static int mptcp_v6_bind(struct socket *sock, struct sockaddr *uaddr,
+			 int addr_len)
+{
+	int err;
+
+	err =3D mptcp_bind(sock, uaddr, addr_len, AF_INET6, &inet6_stream_ops);
+
+	return err;
+}
+#endif
+
 static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uadd=
r,
 				int addr_len, int flags)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct socket *ssock;
-	int err =3D -ENOTSUPP;
-
-	if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
-		return err;
+	int err;
 =

-	ssock =3D mptcp_socket_create_get(msk, AF_INET);
+	ssock =3D mptcp_socket_create_get(msk, uaddr->sa_family);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

@@ -1204,6 +1214,30 @@ static int mptcp_v4_getname(struct socket *sock, str=
uct sockaddr *uaddr,
 	return ret;
 }
 =

+#if IS_ENABLED(CONFIG_IPV6)
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
+	ret =3D mptcp_getname(sock, uaddr, peer, &inet6_stream_ops);
+
+	return ret;
+}
+#endif
+
 static int mptcp_listen(struct socket *sock, int backlog, sa_family_t fami=
ly,
 			const struct proto_ops *ops)
 {
@@ -1231,6 +1265,17 @@ static int mptcp_v4_listen(struct socket *sock, int =
backlog)
 	return ret;
 }
 =

+#if IS_ENABLED(CONFIG_IPV6)
+static int mptcp_v6_listen(struct socket *sock, int backlog)
+{
+	int err;
+
+	err =3D mptcp_listen(sock, backlog, AF_INET6, &inet6_stream_ops);
+
+	return err;
+}
+#endif
+
 static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			       int flags, bool kern)
 {
@@ -1345,3 +1390,33 @@ void mptcp_proto_init(void)
 =

 	inet_register_protosw(&mptcp_protosw);
 }
+
+#if IS_ENABLED(CONFIG_IPV6)
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
+	mptcp_v6_stream_ops.bind =3D mptcp_v6_bind;
+	mptcp_v6_stream_ops.connect =3D mptcp_stream_connect;
+	mptcp_v6_stream_ops.poll =3D mptcp_poll;
+	mptcp_v6_stream_ops.accept =3D mptcp_stream_accept;
+	mptcp_v6_stream_ops.getname =3D mptcp_v6_getname;
+	mptcp_v6_stream_ops.listen =3D mptcp_v6_listen;
+	mptcp_v6_stream_ops.shutdown =3D mptcp_shutdown;
+
+	err =3D inet6_register_protosw(&mptcp_v6_protosw);
+
+	return err;
+}
+#endif
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 71967bac03c0..0951f6ec9954 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -275,6 +275,9 @@ extern const struct inet_connection_sock_af_ops ipv6_sp=
ecific;
 #endif
 =

 void mptcp_proto_init(void);
+#if IS_ENABLED(CONFIG_IPV6)
+int mptcp_proto_v6_init(void);
+#endif
 =

 struct mptcp_read_arg {
 	struct msghdr *msg;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 758b4b36644a..e845d39a9886 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -16,6 +16,7 @@
 #include <net/protocol.h>
 #include <net/tcp.h>
 #include <net/mptcp.h>
+#include <net/ip6_route.h>
 #include "protocol.h"
 #include "mib.h"
 =

@@ -58,6 +59,21 @@ static int subflow_v4_rebuild_header(struct sock *sk)
 	return ipv4_specific.rebuild_header(sk);
 }
 =

+#if IS_ENABLED(CONFIG_IPV6)
+static struct inet_connection_sock_af_ops subflow_v6_specific;
+
+static int subflow_v6_rebuild_header(struct sock *sk)
+{
+	int err;
+
+	err =3D subflow_rebuild_header(sk);
+	if (err)
+		return err;
+
+	return ipv6_specific.rebuild_header(sk);
+}
+#endif
+
 static void subflow_req_destructor(struct request_sock *req)
 {
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
@@ -162,6 +178,21 @@ static void subflow_v4_init_req(struct request_sock *r=
eq,
 	subflow_init_req(req, sk_listener, skb);
 }
 =

+#if IS_ENABLED(CONFIG_IPV6)
+static void subflow_v6_init_req(struct request_sock *req,
+				const struct sock *sk_listener,
+				struct sk_buff *skb)
+{
+	pr_debug("req=3D%p", req);
+
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
@@ -227,6 +258,16 @@ static void subflow_v4_finish_connect(struct sock *sk,
 	subflow_finish_connect(sk, skb);
 }
 =

+#if IS_ENABLED(CONFIG_IPV6)
+static void subflow_v6_finish_connect(struct sock *sk,
+				      const struct sk_buff *skb)
+{
+	ipv6_specific.sk_rx_dst_set(sk, skb);
+
+	subflow_finish_connect(sk, skb);
+}
+#endif
+
 static struct request_sock_ops subflow_request_sock_ops;
 static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
 =

@@ -248,6 +289,30 @@ static int subflow_v4_conn_request(struct sock *sk, st=
ruct sk_buff *skb)
 	return 0;
 }
 =

+#if IS_ENABLED(CONFIG_IPV6)
+static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
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
@@ -348,6 +413,23 @@ static struct sock *subflow_v4_syn_recv_sock(const str=
uct sock *sk,
 	return child;
 }
 =

+#if IS_ENABLED(CONFIG_IPV6)
+static struct sock *subflow_v6_syn_recv_sock(const struct sock *sk,
+					     struct sk_buff *skb,
+					     struct request_sock *req,
+					     struct dst_entry *dst,
+					     struct request_sock *req_unhash,
+					     bool *own_req)
+{
+	struct sock *child;
+
+	child =3D subflow_syn_recv_sock(sk, skb, req, dst, req_unhash, own_req,
+				      &ipv6_specific);
+
+	return child;
+}
+#endif
+
 enum mapping_status {
 	MAPPING_OK,
 	MAPPING_INVALID,
@@ -797,16 +879,26 @@ static int subflow_ulp_init(struct sock *sk)
 		goto out;
 	}
 =

+	if (sk->sk_family =3D=3D AF_INET) {
+		icsk->icsk_af_ops =3D &subflow_v4_specific;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else if (sk->sk_family =3D=3D AF_INET6) {
+		icsk->icsk_af_ops =3D &subflow_v6_specific;
+#endif
+	} else {
+		err =3D -ENOTSUPP;
+		goto out;
+	}
+
 	ctx =3D subflow_create_ctx(sk, sk->sk_socket, GFP_KERNEL);
 	if (!ctx) {
 		err =3D -ENOMEM;
 		goto out;
 	}
 =

-	pr_debug("subflow=3D%p", ctx);
+	pr_debug("subflow=3D%p, family=3D%d", ctx, sk->sk_family);
 =

 	tp->is_mptcp =3D 1;
-	icsk->icsk_af_ops =3D &subflow_v4_specific;
 	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
 	sk->sk_data_ready =3D subflow_data_ready;
 	sk->sk_write_space =3D subflow_write_space;
@@ -904,6 +996,17 @@ void mptcp_subflow_init(void)
 	subflow_v4_specific.sk_rx_dst_set =3D subflow_v4_finish_connect;
 	subflow_v4_specific.rebuild_header =3D subflow_v4_rebuild_header;
 =

+#if IS_ENABLED(CONFIG_IPV6)
+	subflow_request_sock_ipv6_ops =3D tcp_request_sock_ipv6_ops;
+	subflow_request_sock_ipv6_ops.init_req =3D subflow_v6_init_req;
+
+	subflow_v6_specific =3D ipv6_specific;
+	subflow_v6_specific.conn_request =3D subflow_v6_conn_request;
+	subflow_v6_specific.syn_recv_sock =3D subflow_v6_syn_recv_sock;
+	subflow_v6_specific.sk_rx_dst_set =3D subflow_v6_finish_connect;
+	subflow_v6_specific.rebuild_header =3D subflow_v6_rebuild_header;
+#endif
+
 	mptcp_diag_subflow_init(&subflow_ulp_ops);
 =

 	if (tcp_register_ulp(&subflow_ulp_ops) !=3D 0)
-- =

2.17.2

--===============3389209103890597765==--
