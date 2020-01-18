Content-Type: multipart/mixed; boundary="===============8719436199915430146=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Move subflow ipv6 code earlier in subflow.c
Date: Fri, 17 Jan 2020 16:58:11 -0800
Message-ID: <20200118005811.20655-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3416

--===============8719436199915430146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This prevents some diff noise in "mptcp: Implement MPTCP receive path",
where the code is currently moved.

squashto: "mptcp: Handle MP_CAPABLE options for outgoing connections"

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/subflow.c | 52 ++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1eff992a43dc..c3ce0fe369b7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -106,6 +106,32 @@ static int subflow_v4_conn_request(struct sock *sk, st=
ruct sk_buff *skb)
 	return 0;
 }
 =

+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
+static struct inet_connection_sock_af_ops subflow_v6_specific;
+static struct inet_connection_sock_af_ops subflow_v6m_specific;
+
+static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+
+	pr_debug("subflow=3D%p", subflow);
+
+	if (skb->protocol =3D=3D htons(ETH_P_IP))
+		return subflow_v4_conn_request(sk, skb);
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
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					  struct sk_buff *skb,
 					  struct request_sock *req,
@@ -138,32 +164,6 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 =

 static struct inet_connection_sock_af_ops subflow_specific;
 =

-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
-static struct inet_connection_sock_af_ops subflow_v6_specific;
-static struct inet_connection_sock_af_ops subflow_v6m_specific;
-
-static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
-{
-	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-
-	pr_debug("subflow=3D%p", subflow);
-
-	if (skb->protocol =3D=3D htons(ETH_P_IP))
-		return subflow_v4_conn_request(sk, skb);
-
-	if (!ipv6_unicast_destination(skb))
-		goto drop;
-
-	return tcp_conn_request(&subflow_request_sock_ops,
-				&subflow_request_sock_ipv6_ops, sk, skb);
-
-drop:
-	tcp_listendrop(sk);
-	return 0; /* don't send reset */
-}
-#endif
-
 static struct inet_connection_sock_af_ops *
 subflow_default_af_ops(struct sock *sk)
 {
-- =

2.25.0

--===============8719436199915430146==--
