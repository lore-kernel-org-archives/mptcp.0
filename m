Content-Type: multipart/mixed; boundary="===============5039078109098424288=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 1/5] mptcp: consolidate synack processing.
Date: Wed, 29 Apr 2020 12:41:45 +0200
Message-ID: <5261bc9add632deda5890816c41188ee80c6765e.1588156257.git.pabeni@redhat.com>
In-Reply-To: cover.1588156257.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4267

--===============5039078109098424288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently the MPTCP code uses 2 hooks to process syn-ack
packets, mptcp_rcv_synsent() and the sk_rx_dst_set()
callback.

We can drop the first, moving the relevant code into the
latter, reducing the hooking into the TCP code. This is
also needed by the next patch.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/net/mptcp.h  |  1 -
 net/ipv4/tcp_input.c |  3 ---
 net/mptcp/options.c  | 22 ----------------------
 net/mptcp/subflow.c  | 27 ++++++++++++++++++++++++---
 4 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 5288fba56e55..57d5a89d167f 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -74,7 +74,6 @@ void mptcp_parse_option(const struct sk_buff *skb, const =
unsigned char *ptr,
 			int opsize, struct tcp_options_received *opt_rx);
 bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		       unsigned int *size, struct mptcp_out_options *opts);
-void mptcp_rcv_synsent(struct sock *sk);
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
 			  struct mptcp_out_options *opts);
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bf4ced9273e8..81425542da44 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5990,9 +5990,6 @@ static int tcp_rcv_synsent_state_process(struct sock =
*sk, struct sk_buff *skb,
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
 		tcp_initialize_rcv_mss(sk);
 =

-		if (sk_is_mptcp(sk))
-			mptcp_rcv_synsent(sk);
-
 		/* Remember, tcp_poll() does not lock socket!
 		 * Change state from SYN-SENT only after copied_seq
 		 * is initialized. */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4a7c467b99db..8fea686a5562 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -344,28 +344,6 @@ bool mptcp_syn_options(struct sock *sk, const struct s=
k_buff *skb,
 	return false;
 }
 =

-void mptcp_rcv_synsent(struct sock *sk)
-{
-	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-	struct tcp_sock *tp =3D tcp_sk(sk);
-
-	if (subflow->request_mptcp && tp->rx_opt.mptcp.mp_capable) {
-		subflow->mp_capable =3D 1;
-		subflow->can_ack =3D 1;
-		subflow->remote_key =3D tp->rx_opt.mptcp.sndr_key;
-		pr_debug("subflow=3D%p, remote_key=3D%llu", subflow,
-			 subflow->remote_key);
-	} else if (subflow->request_join && tp->rx_opt.mptcp.mp_join) {
-		subflow->mp_join =3D 1;
-		subflow->thmac =3D tp->rx_opt.mptcp.thmac;
-		subflow->remote_nonce =3D tp->rx_opt.mptcp.nonce;
-		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u", subflow,
-			 subflow->thmac, subflow->remote_nonce);
-	} else if (subflow->request_mptcp) {
-		tcp_sk(sk)->is_mptcp =3D 0;
-	}
-}
-
 /* MP_JOIN client subflow must wait for 4th ack before sending any data:
  * TCP can't schedule delack timer before the subflow is fully established.
  * MPTCP uses the delack timer to do 3rd ack retransmissions
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2488e011048c..519b3d7570a3 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -222,6 +222,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct sock *parent =3D subflow->conn;
+	struct tcp_sock *tp =3D tcp_sk(sk);
 =

 	subflow->icsk_af_ops->sk_rx_dst_set(sk, skb);
 =

@@ -230,14 +231,35 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 		parent->sk_state_change(parent);
 	}
 =

-	if (subflow->conn_finished || !tcp_sk(sk)->is_mptcp)
+	/* be sure no special action on any packet other than syn-ack */
+	if (subflow->conn_finished)
+		return;
+
+	subflow->conn_finished =3D 1;
+
+	if (subflow->request_mptcp && tp->rx_opt.mptcp.mp_capable) {
+		subflow->mp_capable =3D 1;
+		subflow->can_ack =3D 1;
+		subflow->remote_key =3D tp->rx_opt.mptcp.sndr_key;
+		pr_debug("subflow=3D%p, remote_key=3D%llu", subflow,
+			 subflow->remote_key);
+	} else if (subflow->request_join && tp->rx_opt.mptcp.mp_join) {
+		subflow->mp_join =3D 1;
+		subflow->thmac =3D tp->rx_opt.mptcp.thmac;
+		subflow->remote_nonce =3D tp->rx_opt.mptcp.nonce;
+		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u", subflow,
+			 subflow->thmac, subflow->remote_nonce);
+	} else if (subflow->request_mptcp) {
+		tcp_sk(sk)->is_mptcp =3D 0;
+	}
+
+	if (!tcp_sk(sk)->is_mptcp)
 		return;
 =

 	if (subflow->mp_capable) {
 		pr_debug("subflow=3D%p, remote_key=3D%llu", mptcp_subflow_ctx(sk),
 			 subflow->remote_key);
 		mptcp_finish_connect(sk);
-		subflow->conn_finished =3D 1;
 =

 		if (skb) {
 			pr_debug("synack seq=3D%u", TCP_SKB_CB(skb)->seq);
@@ -264,7 +286,6 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 		if (!mptcp_finish_join(sk))
 			goto do_reset;
 =

-		subflow->conn_finished =3D 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
 	} else {
 do_reset:
-- =

2.21.1

--===============5039078109098424288==--
