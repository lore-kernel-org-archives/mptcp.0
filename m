Content-Type: multipart/mixed; boundary="===============5574590942396842130=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 5/8] mptcp: Add IPV6 support for incoming connections
Date: Tue, 12 Nov 2019 22:45:15 -0800
Message-ID: <20191113064518.4823-6-peter.krystad@linux.intel.com>
In-Reply-To: 20191113064518.4823-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2497

--===============5574590942396842130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

add mtpcp_accept and listent

squashto: Create SUBFLOW socket for incoming connections

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>

mtpcp: Add IPv6 support for for incoming connections [getname()]

squashto: Create SUBFLOW socket for incoming connections

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>

mtpcp: Add IPv6 support for incoming connections

squashto:  Create SUBFLOW socket for incoming connections

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 35 +++++++++++++++++++++++++++++++----
 net/mptcp/subflow.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6bc064713500..bda16c399e23 100644
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
 =

@@ -764,10 +767,7 @@ static int mptcp_stream_connect(struct socket *sock, s=
truct sockaddr *uaddr,
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
@@ -833,6 +833,30 @@ static int mptcp_v4_getname(struct socket *sock, struc=
t sockaddr *uaddr,
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
@@ -983,6 +1007,9 @@ int mptcpv6_init(void)
 	mptcp_v6_stream_ops.bind =3D mptcp_bind;
 	mptcp_v6_stream_ops.connect =3D mptcp_stream_connect;
 	mptcp_v6_stream_ops.poll =3D mptcp_poll;
+	mptcp_v6_stream_ops.accept =3D mptcp_stream_accept;
+	mptcp_v6_stream_ops.getname =3D mptcp_v6_getname;
+	mptcp_v6_stream_ops.listen =3D mptcp_listen;
 =

 	err =3D inet6_register_protosw(&mptcp_v6_protosw);
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index cf53729929bd..580cee2a5f84 100644
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
 =

@@ -135,6 +138,19 @@ static void subflow_v4_init_req(struct request_sock *r=
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
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *=
skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
@@ -176,7 +192,28 @@ static int subflow_v4_conn_request(struct sock *sk, st=
ruct sk_buff *skb)
 }
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
 static struct inet_connection_sock_af_ops subflow_v6_specific;
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
 #endif
 =

 /* validate hmac received in third ACK */
@@ -749,7 +786,12 @@ void mptcp_subflow_init(void)
 	subflow_specific.rebuild_header =3D subflow_rebuild_header;
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	subflow_request_sock_ipv6_ops =3D tcp_request_sock_ipv6_ops;
+	subflow_request_sock_ipv6_ops.init_req =3D subflow_v6_init_req;
+
 	subflow_v6_specific =3D ipv6_specific;
+	subflow_v6_specific.conn_request =3D subflow_v6_conn_request;
+	subflow_v6_specific.syn_recv_sock =3D subflow_syn_recv_sock;
 	subflow_v6_specific.sk_rx_dst_set =3D subflow_finish_connect;
 #endif
 =

-- =

2.17.2

--===============5574590942396842130==--
