Content-Type: multipart/mixed; boundary="===============6749561021598360669=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 5/9] Rename mptcp_attach_dss()
Date: Wed, 17 Jul 2019 15:12:52 -0700
Message-ID: <20190717221256.7358-6-peter.krystad@linux.intel.com>
In-Reply-To: 20190717221256.7358-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1516

--===============6749561021598360669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Other incoming MPTCP options will be handled in this routine.

squashto: Implement MPTCP receive path

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/mptcp.h  | 10 +++++-----
 net/ipv4/tcp_input.c |  4 ++--
 net/mptcp/options.c  |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6cd650838ddf..bb2dd193c0c5 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -68,9 +68,8 @@ bool mptcp_synack_options(const struct request_sock *req,=
 unsigned int *size,
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts);
-
-void mptcp_attach_dss(struct sock *sk, struct sk_buff *skb,
-		      struct tcp_options_received *opt_rx);
+void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
+			    struct tcp_options_received *opt_rx);
 =

 static inline bool mptcp_skb_ext_exist(const struct sk_buff *skb)
 {
@@ -128,8 +127,9 @@ static inline bool mptcp_established_options(struct soc=
k *sk,
 	return false;
 }
 =

-static inline void mptcp_attach_dss(struct sock *sk, struct sk_buff *skb,
-				    struct tcp_options_received *opt_rx)
+static inline void mptcp_incoming_options(struct sock *sk,
+					  struct sk_buff *skb,
+					  struct tcp_options_received *opt_rx)
 {
 }
 =

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index b92985b4762c..ca2fea882281 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5668,9 +5668,9 @@ void tcp_rcv_established(struct sock *sk, struct sk_b=
uff *skb)
 	/* Process urgent data. */
 	tcp_urg(sk, skb, th);
 =

-	/* Prepare MPTCP sequence data */
+	/* Process MPTCP options */
 	if (sk_is_mptcp(sk))
-		mptcp_attach_dss(sk, skb, &tp->rx_opt);
+		mptcp_incoming_options(sk, skb, &tp->rx_opt);
 =

 	/* step 7: process the segment text */
 	tcp_data_queue(sk, skb);
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b5a86f47f097..1a46cfb1f664 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -476,8 +476,8 @@ bool mptcp_synack_options(const struct request_sock *re=
q, unsigned int *size,
 	return false;
 }
 =

-void mptcp_attach_dss(struct sock *sk, struct sk_buff *skb,
-		      struct tcp_options_received *opt_rx)
+void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
+			    struct tcp_options_received *opt_rx)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
-- =

2.17.2


--===============6749561021598360669==--
