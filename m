Content-Type: multipart/mixed; boundary="===============3498418072378594845=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC v3 04/10] mptcp: rename and export
 mptcp_subflow_request_sock_ops
Date: Thu, 30 Jul 2020 02:12:35 +0200
Message-ID: <20200730001241.3037-5-fw@strlen.de>
In-Reply-To: 20200730001241.3037-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5376

--===============3498418072378594845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

syncookie code path needs to create an mptcp request sock.

Prepare for this and add mptcp prefix plus needed export of ops struct.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/net/mptcp.h |  1 +
 net/mptcp/subflow.c | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 02158c257bd4..76eb915bf91c 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -58,6 +58,7 @@ struct mptcp_out_options {
 };
 =

 #ifdef CONFIG_MPTCP
+extern struct request_sock_ops mptcp_subflow_request_sock_ops;
 =

 void mptcp_init(void);
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 091e305a81c8..9b11d2b6ff4d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -284,7 +284,8 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 	tcp_done(sk);
 }
 =

-static struct request_sock_ops subflow_request_sock_ops;
+struct request_sock_ops mptcp_subflow_request_sock_ops;
+EXPORT_SYMBOL_GPL(mptcp_subflow_request_sock_ops);
 static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
 =

 static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
@@ -297,7 +298,7 @@ static int subflow_v4_conn_request(struct sock *sk, str=
uct sk_buff *skb)
 	if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
 		goto drop;
 =

-	return tcp_conn_request(&subflow_request_sock_ops,
+	return tcp_conn_request(&mptcp_subflow_request_sock_ops,
 				&subflow_request_sock_ipv4_ops,
 				sk, skb);
 drop:
@@ -322,7 +323,7 @@ static int subflow_v6_conn_request(struct sock *sk, str=
uct sk_buff *skb)
 	if (!ipv6_unicast_destination(skb))
 		goto drop;
 =

-	return tcp_conn_request(&subflow_request_sock_ops,
+	return tcp_conn_request(&mptcp_subflow_request_sock_ops,
 				&subflow_request_sock_ipv6_ops, sk, skb);
 =

 drop:
@@ -1311,8 +1312,8 @@ static int subflow_ops_init(struct request_sock_ops *=
subflow_ops)
 =

 void __init mptcp_subflow_init(void)
 {
-	subflow_request_sock_ops =3D tcp_request_sock_ops;
-	if (subflow_ops_init(&subflow_request_sock_ops) !=3D 0)
+	mptcp_subflow_request_sock_ops =3D tcp_request_sock_ops;
+	if (subflow_ops_init(&mptcp_subflow_request_sock_ops) !=3D 0)
 		panic("MPTCP: failed to init subflow request sock ops\n");
 =

 	subflow_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
-- =

2.26.2

--===============3498418072378594845==--
