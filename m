Content-Type: multipart/mixed; boundary="===============1712833318375042201=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/6] mptcp: Reference af_ops routines through struct
 ipv4_specific
Date: Wed, 30 Oct 2019 16:38:39 -0700
Message-ID: <20191030233844.4790-2-peter.krystad@linux.intel.com>
In-Reply-To: 20191030233844.4790-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2365

--===============1712833318375042201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make this look similar to how it will have to be done for IPv6,
as the IPv6 routines are declared static and thus not visible.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/subflow.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7bae7c35ea6b..e6bb68e1c292 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -25,6 +25,8 @@ static inline void SUBFLOW_REQ_INC_STATS(struct request_s=
ock *req,
 	MPTCP_INC_STATS(sock_net(req_to_sk(req)), field);
 }
 =

+static struct inet_connection_sock_af_ops subflow_specific;
+
 static int subflow_rebuild_header(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
@@ -45,7 +47,7 @@ static int subflow_rebuild_header(struct sock *sk)
 	if (err)
 		return err;
 =

-	return inet_sk_rebuild_header(sk);
+	return ipv4_specific.rebuild_header(sk);
 }
 =

 static void subflow_req_destructor(struct request_sock *req)
@@ -169,7 +171,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 =

-	inet_sk_rx_dst_set(sk, skb);
+	ipv4_specific.sk_rx_dst_set(sk, skb);
 =

 	if (!subflow->conn)
 		return;
@@ -276,7 +278,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			return NULL;
 	}
 =

-	child =3D tcp_v4_syn_recv_sock(sk, skb, req, dst, req_unhash, own_req);
+	child =3D ipv4_specific.syn_recv_sock(sk, skb, req, dst, req_unhash,
+					    own_req);
 =

 	if (child && *own_req) {
 		struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(child);
@@ -309,8 +312,6 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 	return NULL;
 }
 =

-static struct inet_connection_sock_af_ops subflow_specific;
-
 enum mapping_status {
 	MAPPING_OK,
 	MAPPING_INVALID,
-- =

2.17.2

--===============1712833318375042201==--
