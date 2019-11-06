Content-Type: multipart/mixed; boundary="===============0902982790036985737=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 4/6] mptcp: Re-factor subflow_v4_conn_request to be
 af-agnostic
Date: Tue, 05 Nov 2019 20:41:31 -0800
Message-ID: <20191106044133.14418-5-peter.krystad@linux.intel.com>
In-Reply-To: 20191106044133.14418-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2414

--===============0902982790036985737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Split subflow_v4_init_req into separate af-specific
and functional parts.

squashto: Create SUBFLOW socket for incoming connections

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/subflow.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6aa02001a06d..586713537124 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -90,19 +90,16 @@ static bool subflow_token_join_request(struct request_s=
ock *req,
 	return true;
 }
 =

-static void subflow_v4_init_req(struct request_sock *req,
-				const struct sock *sk_listener,
-				struct sk_buff *skb)
+static void subflow_init_req(struct request_sock *req,
+			     const struct sock *sk_listener,
+			     struct sk_buff *skb)
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

@@ -146,6 +143,17 @@ static void subflow_v4_init_req(struct request_sock *r=
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
+	subflow_init_req(req, sk_listener, skb);
+}
+
 /* validate received truncated hmac and create hmac for third ACK */
 static bool subflow_thmac_valid(struct mptcp_subflow_context *subflow)
 {
-- =

2.17.2

--===============0902982790036985737==--
