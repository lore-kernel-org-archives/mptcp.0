Content-Type: multipart/mixed; boundary="===============4885590931054944855=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] mptcp: Basic single-subflow DATA_FIN
Date: Mon, 18 Nov 2019 16:31:21 -0800
Message-ID: <20191119003121.26945-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2599

--===============4885590931054944855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Send a DATA_FIN along with any subflow TCP FIN flag when the MPTCP
socket is closing or shutting down writes.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

---

Changes from v1:

* Fixed problem with the receive side truncating data. The issue happened
  when a DSS mapping for DATA_FIN was found on a data segment, where the
  data in the packet was already covered by an earlier mapping.

* Only send DATA_FIN when the subflow is sending a FIN and the MPTCP
  socket is no longer in the TCP_ESTABLISHED state. This prevents sending
  DATA_FIN when an individual subflow is removed but the MPTCP-level
  connection is kept alive.

* Changes to warnings and comments suggested in code review.

net/mptcp/options.c  | 40 +++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.c |  4 ++++
 net/mptcp/subflow.c  | 42 ++++++++++++++++++++++++++++--------------
 3 files changed, 69 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9a18a3670cdf..f8dd8b2a4785 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -384,18 +384,48 @@ static bool mptcp_established_options_mp(struct sock =
*sk, unsigned int *size,
 	return false;
 }
 =

+static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
+				 struct mptcp_ext *ext)
+{
+	ext->data_fin =3D 1;
+
+	if (!ext->use_map) {
+		/* RFC6824 requires a DSS mapping with specific values
+		 * if DATA_FIN is set but no data payload is mapped
+		 */
+		ext->use_map =3D 1;
+		ext->dsn64 =3D 1;
+		ext->data_seq =3D mptcp_sk(subflow->conn)->write_seq;
+		ext->subflow_seq =3D 0;
+		ext->data_len =3D 1;
+	} else {
+		/* If there's an existing DSS mapping, DATA_FIN consumes
+		 * 1 additional byte of mapping space.
+		 */
+		ext->data_len++;
+	}
+}
+
 static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff =
*skb,
 					  unsigned int *size,
 					  unsigned int remaining,
 					  struct mptcp_out_options *opts)
 {
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	unsigned int dss_size =3D 0;
 	struct mptcp_ext *mpext;
 	unsigned int ack_size;
+	u8 tcp_fin;
 =

-	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
+	if (skb) {
+		mpext =3D mptcp_get_ext(skb);
+		tcp_fin =3D TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
+	} else {
+		mpext =3D NULL;
+		tcp_fin =3D 0;
+	}
 =

-	if (!skb || (mpext && mpext->use_map)) {
+	if (!skb || (mpext && mpext->use_map) || tcp_fin) {
 		unsigned int map_size;
 =

 		map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
@@ -405,6 +435,10 @@ static bool mptcp_established_options_dss(struct sock =
*sk, struct sk_buff *skb,
 			dss_size =3D map_size;
 			if (mpext)
 				opts->ext_copy =3D *mpext;
+
+			if (skb && tcp_fin &&
+			    subflow->conn->sk_state !=3D TCP_ESTABLISHED)
+				mptcp_write_data_fin(subflow, &opts->ext_copy);
 		} else {
 			opts->ext_copy.use_map =3D 0;
 			WARN_ONCE(1, "MPTCP: Map dropped");
@@ -422,7 +456,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 =

 		dss_size +=3D ack_size;
 =

-		msk =3D mptcp_sk(mptcp_subflow_ctx(sk)->conn);
+		msk =3D mptcp_sk(subflow->conn);
 		if (msk) {
 			opts->ext_copy.data_ack =3D msk->ack_seq;
 		} else {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1a432abfb176..910cf26037b7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1284,6 +1284,10 @@ static int mptcp_shutdown(struct socket *sock, int h=
ow)
 	pr_debug("sk=3D%p, how=3D%d", msk, how);
 =

 	lock_sock(sock->sk);
+
+	if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
+		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
+
 	ssock =3D __mptcp_fallback_get_ref(msk);
 	if (ssock) {
 		release_sock(sock->sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ff38d54392cd..89e6533c97b6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -422,6 +422,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk)
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	struct mptcp_ext *mpext;
 	struct sk_buff *skb;
+	u16 data_len;
 	u64 map_seq;
 =

 	skb =3D skb_peek(&ssk->sk_receive_queue);
@@ -446,26 +447,39 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk)
 =

 		if (!subflow->map_valid)
 			return MAPPING_INVALID;
+
 		goto validate_seq;
 	}
 =

-	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u data_len=3D%u", mpext->data_seq,
-		 mpext->dsn64, mpext->subflow_seq, mpext->data_len);
+	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u data_len=3D%u data_fin=3D%d",
+		 mpext->data_seq, mpext->dsn64, mpext->subflow_seq,
+		 mpext->data_len, mpext->data_fin);
 =

-	if (mpext->data_len =3D=3D 0) {
+	data_len =3D mpext->data_len;
+	if (data_len =3D=3D 0) {
 		pr_err("Infinite mapping not handled");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		return MAPPING_INVALID;
-	} else if (mpext->subflow_seq =3D=3D 0 &&
-		   mpext->data_fin =3D=3D 1) {
-		if (WARN_ON_ONCE(mpext->data_len !=3D 1))
-			return false;
+	}
 =

-		/* do not try hard to handle this any better, till we have
-		 * real data_fin support
-		 */
-		pr_debug("DATA_FIN with no payload");
-		return MAPPING_DATA_FIN;
+	if (mpext->data_fin =3D=3D 1) {
+		if (data_len =3D=3D 1) {
+			pr_debug("DATA_FIN with no payload");
+			if (subflow->map_valid) {
+				/* A DATA_FIN might arrive in a DSS
+				 * option before the previous mapping
+				 * has been fully consumed. Continue
+				 * handling the existing mapping.
+				 */
+				skb_ext_del(skb, SKB_EXT_MPTCP);
+				return MAPPING_OK;
+			} else {
+				return MAPPING_DATA_FIN;
+			}
+		}
+
+		/* Adjust for DATA_FIN using 1 byte of sequence space */
+		data_len--;
 	}
 =

 	if (!mpext->dsn64) {
@@ -480,7 +494,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk)
 		/* Allow replacing only with an identical map */
 		if (subflow->map_seq =3D=3D map_seq &&
 		    subflow->map_subflow_seq =3D=3D mpext->subflow_seq &&
-		    subflow->map_data_len =3D=3D mpext->data_len) {
+		    subflow->map_data_len =3D=3D data_len) {
 			skb_ext_del(skb, SKB_EXT_MPTCP);
 			return MAPPING_OK;
 		}
@@ -499,7 +513,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk)
 =

 	subflow->map_seq =3D map_seq;
 	subflow->map_subflow_seq =3D mpext->subflow_seq;
-	subflow->map_data_len =3D mpext->data_len;
+	subflow->map_data_len =3D data_len;
 	subflow->map_valid =3D 1;
 	pr_debug("new map seq=3D%llu subflow_seq=3D%u data_len=3D%u",
 		 subflow->map_seq, subflow->map_subflow_seq,
-- =

2.24.0

--===============4885590931054944855==--
