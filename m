Content-Type: multipart/mixed; boundary="===============2711520463084090157=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 1/5] mptcp: add and use wrappers to manipulate
 mptcp opt flags
Date: Fri, 24 Apr 2020 19:14:08 +0200
Message-ID: <d888f827af12e9d49d1c243a8da786b685f57f7c.1587738345.git.pabeni@redhat.com>
In-Reply-To: cover.1587738345.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4239

--===============2711520463084090157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While at it, also replace a warning reachable via external
input to warn_on_once and use the mptcp incoming option
init helper instead of open-coded and more costly alternatives.
Other than that, no functional change intented.
This will make next patches more readable.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/linux/tcp.h  | 17 ++++++++-----
 net/mptcp/options.c  | 36 +++++++++++++-------------
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h | 60 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 23 ++++++++---------
 5 files changed, 101 insertions(+), 37 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 421c99c12291..f24b25e50b30 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -141,13 +141,8 @@ struct tcp_options_received {
 #endif
 };
 =

-static inline void tcp_clear_options(struct tcp_options_received *rx_opt)
+static inline void mptcp_init_options(struct tcp_options_received *rx_opt)
 {
-	rx_opt->tstamp_ok =3D rx_opt->sack_ok =3D 0;
-	rx_opt->wscale_ok =3D rx_opt->snd_wscale =3D 0;
-#if IS_ENABLED(CONFIG_SMC)
-	rx_opt->smc_ok =3D 0;
-#endif
 #if IS_ENABLED(CONFIG_MPTCP)
 	rx_opt->mptcp.mp_capable =3D 0;
 	rx_opt->mptcp.mp_join =3D 0;
@@ -157,6 +152,16 @@ static inline void tcp_clear_options(struct tcp_option=
s_received *rx_opt)
 #endif
 }
 =

+static inline void tcp_clear_options(struct tcp_options_received *rx_opt)
+{
+	rx_opt->tstamp_ok =3D rx_opt->sack_ok =3D 0;
+	rx_opt->wscale_ok =3D rx_opt->snd_wscale =3D 0;
+#if IS_ENABLED(CONFIG_SMC)
+	rx_opt->smc_ok =3D 0;
+#endif
+	mptcp_init_options(rx_opt);
+}
+
 /* This is the max number of SACKS that we'll generate and process. It's s=
afe
  * to increase this, although since:
  *   size =3D TCPOLEN_SACK_BASE_ALIGNED (4) + n * TCPOLEN_SACK_PERBLOCK (8)
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4a7c467b99db..e8a7c141836e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -72,7 +72,7 @@ void mptcp_parse_option(const struct sk_buff *skb, const =
unsigned char *ptr,
 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
 			break;
 =

-		mp_opt->mp_capable =3D 1;
+		mptcp_option_set_mp_capable(opt_rx);
 		if (opsize >=3D TCPOLEN_MPTCP_MPC_SYNACK) {
 			mp_opt->sndr_key =3D get_unaligned_be64(ptr);
 			ptr +=3D 8;
@@ -87,7 +87,7 @@ void mptcp_parse_option(const struct sk_buff *skb, const =
unsigned char *ptr,
 			 * equivalent to those in a DSS option and can be used
 			 * interchangeably."
 			 */
-			mp_opt->dss =3D 1;
+			mptcp_option_set_dss(opt_rx);
 			mp_opt->use_map =3D 1;
 			mp_opt->mpc_map =3D 1;
 			mp_opt->data_len =3D get_unaligned_be16(ptr);
@@ -99,7 +99,6 @@ void mptcp_parse_option(const struct sk_buff *skb, const =
unsigned char *ptr,
 		break;
 =

 	case MPTCPOPT_MP_JOIN:
-		mp_opt->mp_join =3D 1;
 		if (opsize =3D=3D TCPOLEN_MPTCP_MPJ_SYN) {
 			mp_opt->backup =3D *ptr++ & MPTCPOPT_BACKUP;
 			mp_opt->join_id =3D *ptr++;
@@ -125,9 +124,10 @@ void mptcp_parse_option(const struct sk_buff *skb, con=
st unsigned char *ptr,
 			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
 			pr_debug("MP_JOIN hmac");
 		} else {
-			pr_warn("MP_JOIN bad option size");
-			mp_opt->mp_join =3D 0;
+			pr_warn_once("MP_JOIN bad option size");
+			break;
 		}
+		mptcp_option_set_mp_join(opt_rx);
 		break;
 =

 	case MPTCPOPT_DSS:
@@ -176,7 +176,7 @@ void mptcp_parse_option(const struct sk_buff *skb, cons=
t unsigned char *ptr,
 		    opsize !=3D expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
 			break;
 =

-		mp_opt->dss =3D 1;
+		mptcp_option_set_dss(opt_rx);
 =

 		if (mp_opt->use_ack) {
 			if (mp_opt->ack64) {
@@ -238,7 +238,7 @@ void mptcp_parse_option(const struct sk_buff *skb, cons=
t unsigned char *ptr,
 				break;
 		}
 =

-		mp_opt->add_addr =3D 1;
+		mptcp_option_set_add_addr(opt_rx);
 		mp_opt->port =3D 0;
 		mp_opt->addr_id =3D *ptr++;
 		pr_debug("ADD_ADDR: id=3D%d", mp_opt->addr_id);
@@ -272,7 +272,7 @@ void mptcp_parse_option(const struct sk_buff *skb, cons=
t unsigned char *ptr,
 		if (opsize !=3D TCPOLEN_MPTCP_RM_ADDR_BASE)
 			break;
 =

-		mp_opt->rm_addr =3D 1;
+		mptcp_option_set_rm_addr(opt_rx);
 		mp_opt->rm_id =3D *ptr++;
 		pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
 		break;
@@ -349,13 +349,13 @@ void mptcp_rcv_synsent(struct sock *sk)
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct tcp_sock *tp =3D tcp_sk(sk);
 =

-	if (subflow->request_mptcp && tp->rx_opt.mptcp.mp_capable) {
+	if (subflow->request_mptcp && mptcp_option_mp_capable(&tp->rx_opt)) {
 		subflow->mp_capable =3D 1;
 		subflow->can_ack =3D 1;
 		subflow->remote_key =3D tp->rx_opt.mptcp.sndr_key;
 		pr_debug("subflow=3D%p, remote_key=3D%llu", subflow,
 			 subflow->remote_key);
-	} else if (subflow->request_join && tp->rx_opt.mptcp.mp_join) {
+	} else if (subflow->request_join && mptcp_option_mp_join(&tp->rx_opt)) {
 		subflow->mp_join =3D 1;
 		subflow->thmac =3D tp->rx_opt.mptcp.thmac;
 		subflow->remote_nonce =3D tp->rx_opt.mptcp.nonce;
@@ -685,7 +685,7 @@ bool mptcp_synack_options(const struct request_sock *re=
q, unsigned int *size,
 static bool check_fully_established(struct mptcp_sock *msk, struct sock *s=
k,
 				    struct mptcp_subflow_context *subflow,
 				    struct sk_buff *skb,
-				    struct mptcp_options_received *mp_opt)
+				    struct tcp_options_received *rx_opt)
 {
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
 	 * will make the subflow fully established
@@ -697,7 +697,7 @@ static bool check_fully_established(struct mptcp_sock *=
msk, struct sock *sk,
 		 */
 		if (TCP_SKB_CB(skb)->seq =3D=3D subflow->ssn_offset + 1 &&
 		    TCP_SKB_CB(skb)->end_seq =3D=3D TCP_SKB_CB(skb)->seq &&
-		    subflow->mp_join && mp_opt->mp_join &&
+		    subflow->mp_join && mptcp_option_mp_join(rx_opt) &&
 		    READ_ONCE(msk->pm.server_side))
 			tcp_send_ack(sk);
 		goto fully_established;
@@ -709,7 +709,7 @@ static bool check_fully_established(struct mptcp_sock *=
msk, struct sock *sk,
 	if (TCP_SKB_CB(skb)->seq !=3D subflow->ssn_offset + 1)
 		return subflow->mp_capable;
 =

-	if (mp_opt->use_ack) {
+	if (rx_opt->mptcp.use_ack) {
 		/* subflows are fully established as soon as we get any
 		 * additional ack.
 		 */
@@ -722,14 +722,14 @@ static bool check_fully_established(struct mptcp_sock=
 *msk, struct sock *sk,
 	/* If the first established packet does not contain MP_CAPABLE + data
 	 * then fallback to TCP
 	 */
-	if (!mp_opt->mp_capable) {
+	if (!mptcp_option_mp_capable(rx_opt)) {
 		subflow->mp_capable =3D 0;
 		tcp_sk(sk)->is_mptcp =3D 0;
 		return false;
 	}
 =

 	subflow->fully_established =3D 1;
-	subflow->remote_key =3D mp_opt->sndr_key;
+	subflow->remote_key =3D rx_opt->mptcp.sndr_key;
 	subflow->can_ack =3D 1;
 =

 fully_established:
@@ -823,10 +823,10 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
 	struct mptcp_ext *mpext;
 =

 	mp_opt =3D &opt_rx->mptcp;
-	if (!check_fully_established(msk, sk, subflow, skb, mp_opt))
+	if (!check_fully_established(msk, sk, subflow, skb, opt_rx))
 		return;
 =

-	if (mp_opt->add_addr && add_addr_hmac_valid(msk, mp_opt)) {
+	if (mptcp_option_add_addr(opt_rx) && add_addr_hmac_valid(msk, mp_opt)) {
 		struct mptcp_addr_info addr;
 =

 		addr.port =3D htons(mp_opt->port);
@@ -846,7 +846,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 		mp_opt->add_addr =3D 0;
 	}
 =

-	if (!mp_opt->dss)
+	if (!mptcp_option_dss(opt_rx))
 		return;
 =

 	/* we can't wait for recvmsg() to update the ack_seq, otherwise
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7104504dc8b7..c08fe7ae58ce 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1381,7 +1381,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 =

 	msk->write_seq =3D subflow_req->idsn + 1;
 	atomic64_set(&msk->snd_una, msk->write_seq);
-	if (opt_rx->mptcp.mp_capable) {
+	if (mptcp_option_mp_capable(opt_rx)) {
 		msk->can_ack =3D true;
 		msk->remote_key =3D opt_rx->mptcp.sndr_key;
 		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a2b3048037d0..451315c0dfe3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -97,6 +97,66 @@ static inline __be32 mptcp_option(u8 subopt, u8 len, u8 =
nib, u8 field)
 		     ((nib & 0xF) << 8) | field);
 }
 =

+static inline void
+mptcp_option_set_mp_capable(struct tcp_options_received *opt_rx)
+{
+	opt_rx->mptcp.mp_capable =3D 1;
+}
+
+static inline void
+mptcp_option_set_mp_join(struct tcp_options_received *opt_rx)
+{
+	opt_rx->mptcp.mp_join =3D1;
+}
+
+static inline void
+mptcp_option_set_dss(struct tcp_options_received *opt_rx)
+{
+	opt_rx->mptcp.dss =3D 1;
+}
+
+static inline void
+mptcp_option_set_add_addr(struct tcp_options_received *opt_rx)
+{
+	opt_rx->mptcp.add_addr =3D 1;
+}
+
+static inline void
+mptcp_option_set_rm_addr(struct tcp_options_received *opt_rx)
+{
+	opt_rx->mptcp.rm_addr =3D 1;
+}
+
+static inline bool
+mptcp_option_mp_capable(const struct tcp_options_received *opt_rx)
+{
+	return opt_rx->mptcp.mp_capable;
+}
+
+static inline bool
+mptcp_option_mp_join(const struct tcp_options_received *opt_rx)
+{
+	return opt_rx->mptcp.mp_join;
+}
+
+static inline bool
+mptcp_option_dss(const struct tcp_options_received *opt_rx)
+{
+	return opt_rx->mptcp.dss;
+}
+
+static inline bool
+mptcp_option_add_addr(const struct tcp_options_received *opt_rx)
+{
+	return opt_rx->mptcp.add_addr;
+}
+
+static inline bool
+mptcp_option_rm_add(const struct tcp_options_received *opt_rx)
+{
+	return opt_rx->mptcp.rm_addr;
+}
+
 #define MPTCP_PM_MAX_ADDR	4
 =

 struct mptcp_addr_info {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2488e011048c..dda6688bb2e4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -128,7 +128,7 @@ static void subflow_init_req(struct request_sock *req,
 =

 	pr_debug("subflow_req=3D%p, listener=3D%p", subflow_req, listener);
 =

-	memset(&rx_opt.mptcp, 0, sizeof(rx_opt.mptcp));
+	mptcp_init_options(&rx_opt);
 	mptcp_get_options(skb, &rx_opt);
 =

 	subflow_req->mp_capable =3D 0;
@@ -142,16 +142,16 @@ static void subflow_init_req(struct request_sock *req,
 		return;
 #endif
 =

-	if (rx_opt.mptcp.mp_capable) {
+	if (mptcp_option_mp_capable(&rx_opt)) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
 =

-		if (rx_opt.mptcp.mp_join)
+		if (mptcp_option_mp_join(&rx_opt))
 			return;
-	} else if (rx_opt.mptcp.mp_join) {
+	} else if (mptcp_option_mp_join(&rx_opt)) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
 	}
 =

-	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
+	if (mptcp_option_mp_capable(&rx_opt) && listener->request_mptcp) {
 		int err;
 =

 		err =3D mptcp_token_new_request(req);
@@ -159,7 +159,7 @@ static void subflow_init_req(struct request_sock *req,
 			subflow_req->mp_capable =3D 1;
 =

 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
-	} else if (rx_opt.mptcp.mp_join && listener->request_mptcp) {
+	} else if (mptcp_option_mp_join(&rx_opt) && listener->request_mptcp) {
 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 		subflow_req->mp_join =3D 1;
 		subflow_req->backup =3D rx_opt.mptcp.backup;
@@ -403,7 +403,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 =

 	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->c=
onn);
 =

-	opt_rx.mptcp.mp_capable =3D 0;
+	mptcp_init_options(&opt_rx);
 	if (tcp_rsk(req)->is_mptcp =3D=3D 0)
 		goto create_child;
 =

@@ -419,7 +419,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 		}
 =

 		mptcp_get_options(skb, &opt_rx);
-		if (!opt_rx.mptcp.mp_capable) {
+		if (!mptcp_option_mp_capable(&opt_rx)) {
 			fallback =3D true;
 			goto create_child;
 		}
@@ -430,9 +430,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			fallback =3D true;
 	} else if (subflow_req->mp_join) {
 		fallback_is_fatal =3D true;
-		opt_rx.mptcp.mp_join =3D 0;
 		mptcp_get_options(skb, &opt_rx);
-		if (!opt_rx.mptcp.mp_join ||
+		if (!mptcp_option_mp_join(&opt_rx) ||
 		    !subflow_hmac_valid(req, &opt_rx)) {
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
 			return NULL;
@@ -474,8 +473,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			 * mpc option
 			 */
 			ctx->remote_key =3D opt_rx.mptcp.sndr_key;
-			ctx->fully_established =3D opt_rx.mptcp.mp_capable;
-			ctx->can_ack =3D opt_rx.mptcp.mp_capable;
+			ctx->can_ack =3D mptcp_option_mp_capable(&opt_rx);
+			ctx->fully_established =3D ctx->can_ack;
 		} else if (ctx->mp_join) {
 			struct mptcp_sock *owner;
 =

-- =

2.21.1

--===============2711520463084090157==--
