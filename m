Content-Type: multipart/mixed; boundary="===============8430104510978944293=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 2/2] mptcp: Add IPv6 support
Date: Wed, 16 Oct 2019 17:02:06 -0700
Message-ID: <20191017000206.10559-3-peter.krystad@linux.intel.com>
In-Reply-To: 20191017000206.10559-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2197

--===============8430104510978944293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mimic hooks and option handling for IPv6 as was done for
IPv4 MPTCP sockets.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/mptcp.h  |   3 +
 net/ipv6/tcp_ipv6.c  |   7 ++
 net/mptcp/ctrl.c     |  11 +++
 net/mptcp/protocol.c | 152 ++++++++++++++++++++++++++---
 net/mptcp/protocol.h |   6 +-
 net/mptcp/subflow.c  | 225 +++++++++++++++++++++++++++++++++++++------
 6 files changed, 364 insertions(+), 40 deletions(-)

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
index 1f3a87f4867e..9ed884818c29 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2110,9 +2110,16 @@ int __init tcpv6_init(void)
 	ret =3D register_pernet_subsys(&tcpv6_net_ops);
 	if (ret)
 		goto out_tcpv6_protosw;
+
+	ret =3D mptcpv6_init();
+	if (ret)
+		goto out_mptcpv6_init;
+
 out:
 	return ret;
 =

+out_mptcpv6_init:
+	unregister_pernet_subsys(&tcpv6_net_ops);
 out_tcpv6_protosw:
 	inet6_unregister_protosw(&tcpv6_protosw);
 out_tcpv6_protocol:
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 33de3ced2ba7..a8ce6e05c41f 100644
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
index 4fdcbb0f4285..bc38527209c9 100644
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

@@ -1070,7 +1071,8 @@ static struct proto mptcp_prot =3D {
 	.no_autobind	=3D 1,
 };
 =

-static struct socket *mptcp_socket_create_get(struct mptcp_sock *msk)
+static struct socket *mptcp_socket_create_get(struct mptcp_sock *msk,
+					      sa_family_t family)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk =3D (struct sock *)msk;
@@ -1082,7 +1084,7 @@ static struct socket *mptcp_socket_create_get(struct =
mptcp_sock *msk)
 	if (ssock)
 		goto release;
 =

-	err =3D mptcp_subflow_create_socket(sk, &ssock);
+	err =3D mptcp_subflow_create_socket(sk, family, &ssock);
 	if (err) {
 		ssock =3D ERR_PTR(err);
 		goto release;
@@ -1104,12 +1106,9 @@ static int mptcp_bind(struct socket *sock, struct so=
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

-	ssock =3D mptcp_socket_create_get(msk);
+	ssock =3D mptcp_socket_create_get(msk, AF_INET);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

@@ -1118,17 +1117,49 @@ static int mptcp_bind(struct socket *sock, struct s=
ockaddr *uaddr, int addr_len)
 	return err;
 }
 =

+#if IS_ENABLED(CONFIG_IPV6)
+static int mptcp_v6_bind(struct socket *sock, struct sockaddr *uaddr,
+			 int addr_len)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct socket *ssock;
+	int err;
+
+	ssock =3D mptcp_socket_create_get(msk, AF_INET6);
+	if (IS_ERR(ssock))
+		return PTR_ERR(ssock);
+
+	err =3D inet6_bind(ssock, uaddr, addr_len);
+	sock_put(ssock->sk);
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
+	int err;
+
+	ssock =3D mptcp_socket_create_get(msk, uaddr->sa_family);
+	if (IS_ERR(ssock))
+		return PTR_ERR(ssock);
 =

-	if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
-		return err;
+	err =3D inet_stream_connect(ssock, uaddr, addr_len, flags);
+	sock_put(ssock->sk);
+	return err;
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static int mptcp_v6_stream_connect(struct socket *sock, struct sockaddr *u=
addr,
+				   int addr_len, int flags)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct socket *ssock;
+	int err;
 =

-	ssock =3D mptcp_socket_create_get(msk);
+	ssock =3D mptcp_socket_create_get(msk, AF_INET6);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

@@ -1136,6 +1167,7 @@ static int mptcp_stream_connect(struct socket *sock, =
struct sockaddr *uaddr,
 	sock_put(ssock->sk);
 	return err;
 }
+#endif
 =

 static int mptcp_getname(struct socket *sock, struct sockaddr *uaddr,
 			 int peer)
@@ -1182,6 +1214,53 @@ static int mptcp_getname(struct socket *sock, struct=
 sockaddr *uaddr,
 	return ret;
 }
 =

+#if IS_ENABLED(CONFIG_IPV6)
+static int mptcp_v6_getname(struct socket *sock, struct sockaddr *uaddr,
+			    int peer)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct socket *ssock;
+	struct sock *ssk;
+	int ret;
+
+	if (sock->sk->sk_prot =3D=3D &tcpv6_prot) {
+		/* we are being invoked from __sys_accept4, after
+		 * mptcp_accept() has just accepted a non-mp-capable
+		 * flow: sk is a tcp_sk, not an mptcp one.
+		 *
+		 * Hand the socket over to tcp so all further socket ops
+		 * bypass mptcp.
+		 */
+		sock->ops =3D &inet_stream_ops;
+		return inet6_getname(sock, uaddr, peer);
+	}
+
+	lock_sock(sock->sk);
+	ssock =3D __mptcp_fallback_get_ref(msk);
+	if (ssock) {
+		release_sock(sock->sk);
+		pr_debug("subflow=3D%p", ssock->sk);
+		ret =3D inet6_getname(ssock, uaddr, peer);
+		sock_put(ssock->sk);
+		return ret;
+	}
+
+	/* @@ the meaning of getname() for the remote peer when the socket
+	 * is connected and there are multiple subflows is not defined.
+	 * For now just use the first subflow on the list.
+	 */
+	ssk =3D mptcp_subflow_get(msk);
+	if (!ssk) {
+		release_sock(sock->sk);
+		return -ENOTCONN;
+	}
+
+	ret =3D inet6_getname(ssk->sk_socket, uaddr, peer);
+	release_sock(sock->sk);
+	return ret;
+}
+#endif
+
 static int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
@@ -1190,7 +1269,25 @@ static int mptcp_listen(struct socket *sock, int bac=
klog)
 =

 	pr_debug("msk=3D%p", msk);
 =

-	ssock =3D mptcp_socket_create_get(msk);
+	ssock =3D mptcp_socket_create_get(msk, AF_INET);
+	if (IS_ERR(ssock))
+		return PTR_ERR(ssock);
+
+	err =3D inet_listen(ssock, backlog);
+	sock_put(ssock->sk);
+	return err;
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static int mptcp_v6_listen(struct socket *sock, int backlog)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct socket *ssock;
+	int err;
+
+	pr_debug("msk=3D%p", msk);
+
+	ssock =3D mptcp_socket_create_get(msk, AF_INET6);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

@@ -1198,6 +1295,7 @@ static int mptcp_listen(struct socket *sock, int back=
log)
 	sock_put(ssock->sk);
 	return err;
 }
+#endif
 =

 static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			       int flags, bool kern)
@@ -1311,3 +1409,33 @@ void mptcp_proto_init(void)
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
+	mptcp_v6_stream_ops.connect =3D mptcp_v6_stream_connect;
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
index 6f09fdfdd523..f0211beac92b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -265,7 +265,8 @@ bool mptcp_subflow_data_available(struct sock *sk);
 void mptcp_subflow_init(void);
 int mptcp_subflow_connect(struct sock *sk, struct sockaddr *local,
 			  struct sockaddr *remote, u8 remote_id);
-int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
+int mptcp_subflow_create_socket(struct sock *sk, sa_family_t family,
+				struct socket **new_sock);
 =

 extern const struct inet_connection_sock_af_ops ipv4_specific;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -273,6 +274,9 @@ extern const struct inet_connection_sock_af_ops ipv6_sp=
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
index 01a15cc2c711..1e2b8829c326 100644
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

@@ -42,12 +43,33 @@ static int subflow_rebuild_header(struct sock *sk)
 		} while (!subflow->local_nonce);
 	}
 =

+	return err;
+}
+
+static int subflow_v4_rebuild_header(struct sock *sk)
+{
+	int err;
+
+	err =3D subflow_rebuild_header(sk);
 	if (err)
 		return err;
 =

 	return inet_sk_rebuild_header(sk);
 }
 =

+#if IS_ENABLED(CONFIG_IPV6)
+static int subflow_v6_rebuild_header(struct sock *sk)
+{
+	int err;
+
+	err =3D subflow_rebuild_header(sk);
+	if (err)
+		return err;
+
+	return inet6_sk_rebuild_header(sk);
+}
+#endif
+
 static void subflow_req_destructor(struct request_sock *req)
 {
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
@@ -90,19 +112,16 @@ static bool subflow_token_join_request(struct request_=
sock *req,
 	return true;
 }
 =

-static void subflow_v4_init_req(struct request_sock *req,
-				const struct sock *sk_listener,
-				struct sk_buff *skb)
+static void __subflow_init_req(struct request_sock *req,
+			       const struct sock *sk_listener,
+			       struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk_listener);
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
 	struct tcp_options_received rx_opt;
 =

-	tcp_rsk(req)->is_mptcp =3D 1;
 	pr_debug("subflow_req=3D%p, listener=3D%p", subflow_req, listener);
 =

-	tcp_request_sock_ipv4_ops.init_req(req, sk_listener, skb);
-
 	memset(&rx_opt.mptcp, 0, sizeof(rx_opt.mptcp));
 	mptcp_get_options(skb, &rx_opt);
 =

@@ -146,6 +165,32 @@ static void subflow_v4_init_req(struct request_sock *r=
eq,
 	}
 }
 =

+static void subflow_v4_init_req(struct request_sock *req,
+				const struct sock *sk_listener,
+				struct sk_buff *skb)
+{
+	tcp_rsk(req)->is_mptcp =3D 1;
+
+	tcp_request_sock_ipv4_ops.init_req(req, sk_listener, skb);
+
+	__subflow_init_req(req, sk_listener, skb);
+}
+
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
+	__subflow_init_req(req, sk_listener, skb);
+}
+#endif
+
 /* validate received truncated hmac and create hmac for third ACK */
 static bool subflow_thmac_valid(struct mptcp_subflow_context *subflow)
 {
@@ -165,12 +210,10 @@ static bool subflow_thmac_valid(struct mptcp_subflow_=
context *subflow)
 	return thmac =3D=3D subflow->thmac;
 }
 =

-static void subflow_finish_connect(struct sock *sk, const struct sk_buff *=
skb)
+static void __subflow_finish_connect(struct sock *sk, const struct sk_buff=
 *skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 =

-	inet_sk_rx_dst_set(sk, skb);
-
 	if (!subflow->conn)
 		return;
 =

@@ -205,10 +248,31 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 	}
 }
 =

+static void subflow_v4_finish_connect(struct sock *sk,
+				      const struct sk_buff *skb)
+{
+	inet_sk_rx_dst_set(sk, skb);
+
+	__subflow_finish_connect(sk, skb);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static void subflow_v6_finish_connect(struct sock *sk,
+				      const struct sk_buff *skb)
+{
+	inet6_sk_rx_dst_set(sk, skb);
+
+	__subflow_finish_connect(sk, skb);
+}
+#endif
+
 static struct request_sock_ops subflow_request_sock_ops;
 static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
+#if IS_ENABLED(CONFIG_IPV6)
+static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
+#endif
 =

-static int subflow_conn_request(struct sock *sk, struct sk_buff *skb)
+static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 =

@@ -226,6 +290,26 @@ static int subflow_conn_request(struct sock *sk, struc=
t sk_buff *skb)
 	return 0;
 }
 =

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
+
 /* validate hmac received in third ACK */
 static bool subflow_hmac_valid(const struct request_sock *req,
 			       const struct tcp_options_received *rx_opt)
@@ -252,12 +336,12 @@ static bool subflow_hmac_valid(const struct request_s=
ock *req,
 	return ret;
 }
 =

-static struct sock *subflow_syn_recv_sock(const struct sock *sk,
-					  struct sk_buff *skb,
-					  struct request_sock *req,
-					  struct dst_entry *dst,
-					  struct request_sock *req_unhash,
-					  bool *own_req)
+static struct sock *subflow_v4_syn_recv_sock(const struct sock *sk,
+					     struct sk_buff *skb,
+					     struct request_sock *req,
+					     struct dst_entry *dst,
+					     struct request_sock *req_unhash,
+					     bool *own_req)
 {
 	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk);
 	struct mptcp_subflow_request_sock *subflow_req;
@@ -309,7 +393,70 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 	return NULL;
 }
 =

-static struct inet_connection_sock_af_ops subflow_specific;
+#if IS_ENABLED(CONFIG_IPV6)
+static struct sock *subflow_v6_syn_recv_sock(const struct sock *sk,
+					     struct sk_buff *skb,
+					     struct request_sock *req,
+					     struct dst_entry *dst,
+					     struct request_sock *req_unhash,
+					     bool *own_req)
+{
+	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk);
+	struct mptcp_subflow_request_sock *subflow_req;
+	struct tcp_options_received opt_rx;
+	struct sock *child;
+
+	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->c=
onn);
+
+	/* if the sk is MP_CAPABLE, we already received the client key */
+	subflow_req =3D mptcp_subflow_rsk(req);
+	if (!subflow_req->mp_capable && subflow_req->mp_join) {
+		opt_rx.mptcp.mp_join =3D 0;
+		mptcp_get_options(skb, &opt_rx);
+		if (!opt_rx.mptcp.mp_join ||
+		    !subflow_hmac_valid(req, &opt_rx))
+			return NULL;
+	}
+
+	child =3D tcp_v6_syn_recv_sock(sk, skb, req, dst, req_unhash, own_req);
+
+	if (child && *own_req) {
+		struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(child);
+
+		if (!ctx)
+			goto close_child;
+
+		if (ctx->mp_capable) {
+			if (mptcp_token_new_accept(ctx->token))
+				goto close_child;
+		} else if (ctx->mp_join) {
+			struct mptcp_sock *owner;
+
+			owner =3D mptcp_token_get_sock(ctx->token);
+			if (!owner)
+				goto close_child;
+
+			ctx->conn =3D (struct sock *)owner;
+			mptcp_finish_join(child);
+		}
+	}
+
+	return child;
+
+close_child:
+	pr_debug("closing child socket");
+	inet_sk_set_state(child, TCP_CLOSE);
+	sock_set_flag(child, SOCK_DEAD);
+	inet_csk_destroy_sock(child);
+	return NULL;
+}
+#endif
+
+static struct inet_connection_sock_af_ops subflow_v4_specific;
+
+#if IS_ENABLED(CONFIG_IPV6)
+static struct inet_connection_sock_af_ops subflow_v6_specific;
+#endif
 =

 enum mapping_status {
 	MAPPING_OK,
@@ -624,7 +771,7 @@ int mptcp_subflow_connect(struct sock *sk, struct socka=
ddr *local,
 	int err;
 =

 	lock_sock(sk);
-	err =3D mptcp_subflow_create_socket(sk, &sf);
+	err =3D mptcp_subflow_create_socket(sk, local->sa_family, &sf);
 	if (err) {
 		release_sock(sk);
 		return err;
@@ -667,14 +814,17 @@ int mptcp_subflow_connect(struct sock *sk, struct soc=
kaddr *local,
 	return err;
 }
 =

-int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
+int mptcp_subflow_create_socket(struct sock *sk, sa_family_t family,
+				struct socket **new_sock)
 {
 	struct mptcp_subflow_context *subflow;
 	struct net *net =3D sock_net(sk);
 	struct socket *sf;
 	int err;
 =

-	err =3D sock_create_kern(net, PF_INET, SOCK_STREAM, IPPROTO_TCP, &sf);
+	pr_debug("msk=3D%p, family=3D%d", sk, family);
+
+	err =3D sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
 	if (err)
 		return err;
 =

@@ -730,16 +880,26 @@ static int subflow_ulp_init(struct sock *sk)
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
-	icsk->icsk_af_ops =3D &subflow_specific;
 	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
 	sk->sk_data_ready =3D subflow_data_ready;
 out:
@@ -829,11 +989,22 @@ void mptcp_subflow_init(void)
 	subflow_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
 	subflow_request_sock_ipv4_ops.init_req =3D subflow_v4_init_req;
 =

-	subflow_specific =3D ipv4_specific;
-	subflow_specific.conn_request =3D subflow_conn_request;
-	subflow_specific.syn_recv_sock =3D subflow_syn_recv_sock;
-	subflow_specific.sk_rx_dst_set =3D subflow_finish_connect;
-	subflow_specific.rebuild_header =3D subflow_rebuild_header;
+	subflow_v4_specific =3D ipv4_specific;
+	subflow_v4_specific.conn_request =3D subflow_v4_conn_request;
+	subflow_v4_specific.syn_recv_sock =3D subflow_v4_syn_recv_sock;
+	subflow_v4_specific.sk_rx_dst_set =3D subflow_v4_finish_connect;
+	subflow_v4_specific.rebuild_header =3D subflow_v4_rebuild_header;
+
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
 =

 	mptcp_diag_subflow_init(&subflow_ulp_ops);
 =

-- =

2.17.2

--===============8430104510978944293==--
