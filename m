Content-Type: multipart/mixed; boundary="===============5932410651114052540=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1] mptcp: handle ipv4-mapped ipv6 address.
Date: Wed, 15 Jan 2020 16:57:12 +0100
Message-ID: <f5ec1902b97464c76fa765c30492b0dd8e8712b4.1579103007.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3363

--===============5932410651114052540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The TCP code unconditionally overwrite in a few places 'icsk->icsk_af_ops',
which lead to the wrong oops being called for ipv4-mapped ipv6 address.
e.g. Kasan notice a invalid slub access running packetdrill ipv4-mapped
tests.

This patch try to address the issue building ipv4-mapped  mptcp icsk ops
and using it when appropriate:
 - on connect() for ipv4 mapped address (and ev. failure)
 - on syn_recv_sock() - passive socket creation

Additionally subflow_v6_conn_request() should call into subflow_v4_conn_req=
uest()
for ipv4 packets, otherwise we always fallback on passive socket bound to
ipv4 mapped addresses.

Note: this still touches af_ops twice. If we do differently, alike:

	if (sk_is_mptcp(newsk))
		mptcp_handle_ipv6_mapped(sk, true);
	else
		inet_csk(newsk)->icsk_af_ops =3D &ipv6_mapped;

we need either:
- additionally handle the #ifnef CONFIG_MPTCP_IPV6 case in
as mptcp_handle_ipv6_mapped(), as we risk to skip 'icsk_af_ops'
initialization otherwise.
- wrap the above mptcp_handle_ipv6_mapped() call under
a preprocessor's conditional (CONFIG_MPTCP_IPV6).

RFC -> v1:
 - drop unneeded mptcp_chk_mapped()
 - fix subflow_v6_conn_request()
 - add missing hook into tcp_v6_syn_recv_sock()

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/net/mptcp.h |  2 ++
 net/ipv6/tcp_ipv6.c |  6 ++++++
 net/mptcp/subflow.c | 46 +++++++++++++++++++++++++++++++++++++++------
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index e1f248d01113..eabc57c3fde4 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -162,6 +162,8 @@ static inline bool mptcp_skb_can_collapse(const struct =
sk_buff *to,
 =

 #endif /* CONFIG_MPTCP */
 =

+void mptcp_handle_ipv6_mapped(struct sock *sk, bool mapped);
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int mptcpv6_init(void);
 #elif IS_ENABLED(CONFIG_IPV6)
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 60068ffde1d9..459ee57f53d9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -238,6 +238,8 @@ static int tcp_v6_connect(struct sock *sk, struct socka=
ddr *uaddr,
 		sin.sin_addr.s_addr =3D usin->sin6_addr.s6_addr32[3];
 =

 		icsk->icsk_af_ops =3D &ipv6_mapped;
+		if (sk_is_mptcp(sk))
+			mptcp_handle_ipv6_mapped(sk, true);
 		sk->sk_backlog_rcv =3D tcp_v4_do_rcv;
 #ifdef CONFIG_TCP_MD5SIG
 		tp->af_specific =3D &tcp_sock_ipv6_mapped_specific;
@@ -248,6 +250,8 @@ static int tcp_v6_connect(struct sock *sk, struct socka=
ddr *uaddr,
 		if (err) {
 			icsk->icsk_ext_hdr_len =3D exthdrlen;
 			icsk->icsk_af_ops =3D &ipv6_specific;
+			if (sk_is_mptcp(sk))
+				mptcp_handle_ipv6_mapped(sk, true);
 			sk->sk_backlog_rcv =3D tcp_v6_do_rcv;
 #ifdef CONFIG_TCP_MD5SIG
 			tp->af_specific =3D &tcp_sock_ipv6_specific;
@@ -1203,6 +1207,8 @@ static struct sock *tcp_v6_syn_recv_sock(const struct=
 sock *sk, struct sk_buff *
 		newnp->saddr =3D newsk->sk_v6_rcv_saddr;
 =

 		inet_csk(newsk)->icsk_af_ops =3D &ipv6_mapped;
+		if (sk_is_mptcp(newsk))
+			mptcp_handle_ipv6_mapped(sk, true);
 		newsk->sk_backlog_rcv =3D tcp_v4_do_rcv;
 #ifdef CONFIG_TCP_MD5SIG
 		newtp->af_specific =3D &tcp_sock_ipv6_mapped_specific;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 81029562f3da..1eff992a43dc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -141,6 +141,7 @@ static struct inet_connection_sock_af_ops subflow_speci=
fic;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
 static struct inet_connection_sock_af_ops subflow_v6_specific;
+static struct inet_connection_sock_af_ops subflow_v6m_specific;
 =

 static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 {
@@ -149,7 +150,7 @@ static int subflow_v6_conn_request(struct sock *sk, str=
uct sk_buff *skb)
 	pr_debug("subflow=3D%p", subflow);
 =

 	if (skb->protocol =3D=3D htons(ETH_P_IP))
-		return tcp_v4_conn_request(sk, skb);
+		return subflow_v4_conn_request(sk, skb);
 =

 	if (!ipv6_unicast_destination(skb))
 		goto drop;
@@ -163,6 +164,36 @@ static int subflow_v6_conn_request(struct sock *sk, st=
ruct sk_buff *skb)
 }
 #endif
 =

+static struct inet_connection_sock_af_ops *
+subflow_default_af_ops(struct sock *sk)
+{
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (sk->sk_family =3D=3D AF_INET6)
+		return &subflow_v6_specific;
+#endif
+	return &subflow_specific;
+}
+
+void mptcp_handle_ipv6_mapped(struct sock *sk, bool mapped)
+{
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+	struct inet_connection_sock_af_ops *target;
+
+	target =3D mapped ? &subflow_v6m_specific : subflow_default_af_ops(sk);
+
+	pr_debug("subflow=3D%p family=3D%d ops=3D%p target=3D%p mapped=3D%d",
+	         subflow, sk->sk_family, icsk->icsk_af_ops, target, mapped);
+
+	if (likely(icsk->icsk_af_ops =3D=3D target))
+		return;
+
+	subflow->icsk_af_ops =3D icsk->icsk_af_ops;
+	icsk->icsk_af_ops =3D target;
+#endif
+}
+
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 {
 	struct mptcp_subflow_context *subflow;
@@ -240,11 +271,7 @@ static int subflow_ulp_init(struct sock *sk)
 =

 	tp->is_mptcp =3D 1;
 	ctx->icsk_af_ops =3D icsk->icsk_af_ops;
-	icsk->icsk_af_ops =3D &subflow_specific;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (sk->sk_family =3D=3D AF_INET6)
-		icsk->icsk_af_ops =3D &subflow_v6_specific;
-#endif
+	icsk->icsk_af_ops =3D subflow_default_af_ops(sk);
 out:
 	return err;
 }
@@ -341,6 +368,13 @@ void mptcp_subflow_init(void)
 	subflow_v6_specific.conn_request =3D subflow_v6_conn_request;
 	subflow_v6_specific.syn_recv_sock =3D subflow_syn_recv_sock;
 	subflow_v6_specific.sk_rx_dst_set =3D subflow_finish_connect;
+
+	subflow_v6m_specific =3D subflow_v6_specific;
+	subflow_v6m_specific.queue_xmit =3D ipv4_specific.queue_xmit;
+	subflow_v6m_specific.send_check =3D ipv4_specific.send_check;
+	subflow_v6m_specific.net_header_len =3D ipv4_specific.net_header_len;
+	subflow_v6m_specific.mtu_reduced =3D ipv4_specific.mtu_reduced;
+	subflow_v6m_specific.net_frag_header_len =3D 0;
 #endif
 =

 	if (tcp_register_ulp(&subflow_ulp_ops) !=3D 0)
-- =

2.21.0

--===============5932410651114052540==--
