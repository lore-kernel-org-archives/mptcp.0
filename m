Content-Type: multipart/mixed; boundary="===============5998102411151415948=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/12] mptcp: rename fourth ack field
Date: Thu, 05 Mar 2020 15:46:38 +0100
Message-ID: <91063550108210c28a3b3aeb5f0e4cb5bc3b73df.1583418572.git.pabeni@redhat.com>
In-Reply-To: cover.1583418571.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3874

--===============5998102411151415948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The name is misleading, it actually track the 'fully established'
status.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  | 18 +++++++++---------
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 45acd877bef3..a45f6f97ef45 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -259,11 +259,11 @@ static bool mptcp_established_options_mp(struct sock =
*sk, struct sk_buff *skb,
 	struct mptcp_ext *mpext;
 	unsigned int data_len;
 =

-	pr_debug("subflow=3D%p fourth_ack=3D%d seq=3D%x:%x remaining=3D%d", subfl=
ow,
-		 subflow->fourth_ack, subflow->snd_isn,
+	pr_debug("subflow=3D%p fully established=3D%d seq=3D%x:%x remaining=3D%d",
+		 subflow, subflow->fully_established, subflow->snd_isn,
 		 skb ? TCP_SKB_CB(skb)->seq : 0, remaining);
 =

-	if (subflow->mp_capable && !subflow->fourth_ack && skb &&
+	if (subflow->mp_capable && !subflow->fully_established && skb &&
 	    subflow->snd_isn =3D=3D TCP_SKB_CB(skb)->seq) {
 		/* When skb is not available, we better over-estimate the
 		 * emitted options len. A full DSS option is longer than
@@ -424,19 +424,19 @@ bool mptcp_synack_options(const struct request_sock *=
req, unsigned int *size,
 	return false;
 }
 =

-static bool check_fourth_ack(struct mptcp_subflow_context *subflow,
-			     struct sk_buff *skb,
-			     struct mptcp_options_received *mp_opt)
+static bool check_fully_established(struct mptcp_subflow_context *subflow,
+				    struct sk_buff *skb,
+				    struct mptcp_options_received *mp_opt)
 {
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
 	 * are relevant
 	 */
-	if (likely(subflow->fourth_ack ||
+	if (likely(subflow->fully_established ||
 		   TCP_SKB_CB(skb)->seq !=3D subflow->ssn_offset + 1))
 		return true;
 =

 	if (mp_opt->use_ack)
-		subflow->fourth_ack =3D 1;
+		subflow->fully_established =3D 1;
 =

 	if (subflow->can_ack)
 		return true;
@@ -462,7 +462,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 	struct mptcp_ext *mpext;
 =

 	mp_opt =3D &opt_rx->mptcp;
-	if (!check_fourth_ack(subflow, skb, mp_opt))
+	if (!check_fully_established(subflow, skb, mp_opt))
 		return;
 =

 	if (!mp_opt->dss)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6c0b2c8ab674..fcba0e8f45f2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -119,7 +119,7 @@ struct mptcp_subflow_context {
 	u32	map_data_len;
 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
 		mp_capable : 1,	    /* remote is MPTCP capable */
-		fourth_ack : 1,	    /* send initial DSS */
+		fully_established : 1,	    /* path validated */
 		conn_finished : 1,
 		map_valid : 1,
 		mpc_map : 1,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0de2a44bdaa0..b5f7a5a90ed1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -794,7 +794,7 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 	new_ctx->tcp_state_change =3D old_ctx->tcp_state_change;
 	new_ctx->tcp_write_space =3D old_ctx->tcp_write_space;
 	new_ctx->mp_capable =3D 1;
-	new_ctx->fourth_ack =3D subflow_req->remote_key_valid;
+	new_ctx->fully_established =3D subflow_req->remote_key_valid;
 	new_ctx->can_ack =3D subflow_req->remote_key_valid;
 	new_ctx->remote_key =3D subflow_req->remote_key;
 	new_ctx->local_key =3D subflow_req->local_key;
-- =

2.21.1

--===============5998102411151415948==--
