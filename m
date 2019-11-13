Content-Type: multipart/mixed; boundary="===============6975027704086979804=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/8] mptcp: Add IPV6 support for outgoing connections
Date: Tue, 12 Nov 2019 22:45:13 -0800
Message-ID: <20191113064518.4823-4-peter.krystad@linux.intel.com>
In-Reply-To: 20191113064518.4823-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2494

--===============6975027704086979804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Handle MP_CAPABLE options for outgoing connections

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.h |  3 +++
 net/mptcp/subflow.c  | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0c5586f14e6a..2566858ea272 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -227,6 +227,9 @@ void mptcp_subflow_init(void);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
 =

 extern const struct inet_connection_sock_af_ops ipv4_specific;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+extern const struct inet_connection_sock_af_ops ipv6_specific;
+#endif
 =

 void mptcp_proto_init(void);
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 12daebe16f5d..cf53729929bd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -175,6 +175,10 @@ static int subflow_v4_conn_request(struct sock *sk, st=
ruct sk_buff *skb)
 	return 0;
 }
 =

+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static struct inet_connection_sock_af_ops subflow_v6_specific;
+#endif
+
 /* validate hmac received in third ACK */
 static bool subflow_hmac_valid(const struct request_sock *req,
 			       const struct tcp_options_received *rx_opt)
@@ -575,7 +579,8 @@ int mptcp_subflow_create_socket(struct sock *sk, struct=
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

@@ -637,11 +642,15 @@ static int subflow_ulp_init(struct sock *sk)
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
@@ -739,6 +748,11 @@ void mptcp_subflow_init(void)
 	subflow_specific.sk_rx_dst_set =3D subflow_finish_connect;
 	subflow_specific.rebuild_header =3D subflow_rebuild_header;
 =

+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	subflow_v6_specific =3D ipv6_specific;
+	subflow_v6_specific.sk_rx_dst_set =3D subflow_finish_connect;
+#endif
+
 	if (tcp_register_ulp(&subflow_ulp_ops) !=3D 0)
 		panic("MPTCP: failed to register subflows to ULP\n");
 }
-- =

2.17.2

--===============6975027704086979804==--
