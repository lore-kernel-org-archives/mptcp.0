Content-Type: multipart/mixed; boundary="===============5151573119807957123=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/3] mptcp: parse and emit MP_CAPABLE option according
 to v1 spec.
Date: Mon, 02 Dec 2019 09:15:03 -0800
Message-ID: <20191202171504.88739-3-cpaasch@apple.com>
In-Reply-To: 20191202171504.88739-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2747

--===============5151573119807957123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This implements MP_CAPABLE options parsing and writing according
the the RFC 6824 bis - MPTCP v1.
Local key is sent on syn/ack, and both keys are sent on 3rd ack.
MP_CAPABLE messages len are updated accordingly.
We need the skbuff to emit correctly the above, so we push the skbuff
struct as an argument all the way from tcp code to the relevant mptcp
callbacks.

When processing incoming MP_CAPABLE + data, build a full blown DSS-like
map info, to simplify later processing.
On child socket creation, we need to record the remote key, if available.

RFC -> v1:
 - rebase on top of "mptcp: Add IPv6 support"
 - explicitly assumes TCP option space is not exhausted

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/linux/tcp.h   |   3 +-
 include/net/mptcp.h   |  11 +--
 net/ipv4/tcp_input.c  |   2 +-
 net/ipv4/tcp_output.c |   2 +-
 net/mptcp/options.c   | 172 ++++++++++++++++++++++++++++++++----------
 net/mptcp/protocol.c  |   2 +-
 net/mptcp/protocol.h  |   6 +-
 net/mptcp/subflow.c   |  14 +++-
 8 files changed, 159 insertions(+), 53 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 4b3ab4226ba8..5760f16823c8 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -114,7 +114,8 @@ struct tcp_options_received {
 			data_fin:1,
 			use_ack:1,
 			ack64:1,
-			__unused:3;
+			mp_capable_map:1,
+			__unused:2;
 	} mptcp;
 #endif
 };
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6349c68e380b..6d82ff9b6a0b 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -23,7 +23,8 @@ struct mptcp_ext {
 			data_fin:1,
 			use_ack:1,
 			ack64:1,
-			__unused:2;
+			mp_capable_map:1,
+			__unused:1;
 };
 =

 struct mptcp_out_options {
@@ -49,10 +50,10 @@ static inline bool rsk_is_mptcp(const struct request_so=
ck *req)
 	return tcp_rsk(req)->is_mptcp;
 }
 =

-void mptcp_parse_option(const unsigned char *ptr, int opsize,
-			struct tcp_options_received *opt_rx);
-bool mptcp_syn_options(struct sock *sk, unsigned int *size,
-		       struct mptcp_out_options *opts);
+void mptcp_parse_option(const struct sk_buff *skb, const unsigned char *pt=
r,
+			int opsize, struct tcp_options_received *opt_rx);
+bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
+		       unsigned int *size, struct mptcp_out_options *opts);
 void mptcp_rcv_synsent(struct sock *sk);
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
 			  struct mptcp_out_options *opts);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d1ab9edfb764..16bd46a097d5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3922,7 +3922,7 @@ void tcp_parse_options(const struct net *net,
 				break;
 #endif
 			case TCPOPT_MPTCP:
-				mptcp_parse_option(ptr, opsize, opt_rx);
+				mptcp_parse_option(skb, ptr, opsize, opt_rx);
 				break;
 =

 			case TCPOPT_FASTOPEN:
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8b2f2a8b9a23..82ebb1a4d669 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -682,7 +682,7 @@ static unsigned int tcp_syn_options(struct sock *sk, st=
ruct sk_buff *skb,
 	if (sk_is_mptcp(sk)) {
 		unsigned int size;
 =

-		if (mptcp_syn_options(sk, &size, &opts->mptcp)) {
+		if (mptcp_syn_options(sk, skb, &size, &opts->mptcp)) {
 			opts->options |=3D OPTION_MPTCP;
 			remaining -=3D size;
 		}
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1cb0bd687b6b..299af8e5456d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -14,8 +14,8 @@ static bool mptcp_cap_flag_sha256(u8 flags)
 	return (flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_SHA256;
 }
 =

-void mptcp_parse_option(const unsigned char *ptr, int opsize,
-			struct tcp_options_received *opt_rx)
+void mptcp_parse_option(const struct sk_buff *skb, const unsigned char *pt=
r,
+			int opsize, struct tcp_options_received *opt_rx)
 {
 	struct mptcp_options_received *mp_opt =3D &opt_rx->mptcp;
 	u8 subtype =3D *ptr >> 4;
@@ -29,12 +29,24 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 	 * 10-17: Receiver key (optional)
 	 */
 	case MPTCPOPT_MP_CAPABLE:
-		if (opsize !=3D TCPOLEN_MPTCP_MPC_SYN &&
-		    opsize !=3D TCPOLEN_MPTCP_MPC_SYNACK)
+		/* strict size checking */
+		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
+			if (skb->len > tcp_hdr(skb)->doff << 2)
+				expected_opsize =3D TCPOLEN_MPTCP_MPC_ACK_DATA;
+			else
+				expected_opsize =3D TCPOLEN_MPTCP_MPC_ACK;
+		} else {
+			if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK)
+				expected_opsize =3D TCPOLEN_MPTCP_MPC_SYNACK;
+			else
+				expected_opsize =3D TCPOLEN_MPTCP_MPC_SYN;
+		}
+		if (opsize !=3D expected_opsize)
 			break;
 =

+		/* only support V1 of the protocol */
 		mp_opt->version =3D *ptr++ & MPTCP_VERSION_MASK;
-		if (mp_opt->version !=3D 0)
+		if (mp_opt->version !=3D 1)
 			break;
 =

 		mp_opt->flags =3D *ptr++;
@@ -59,19 +71,29 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 			break;
 =

 		mp_opt->mp_capable =3D 1;
-		mp_opt->sndr_key =3D get_unaligned_be64(ptr);
-		ptr +=3D 8;
-
-		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_SYNACK) {
+		if (opsize >=3D TCPOLEN_MPTCP_MPC_SYNACK) {
+			mp_opt->sndr_key =3D get_unaligned_be64(ptr);
+			ptr +=3D 8;
+		}
+		if (opsize >=3D TCPOLEN_MPTCP_MPC_ACK) {
 			mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
 			ptr +=3D 8;
-			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu, rcvr=3D%llu",
-				 mp_opt->flags, mp_opt->sndr_key,
-				 mp_opt->rcvr_key);
-		} else {
-			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu",
-				 mp_opt->flags, mp_opt->sndr_key);
 		}
+		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_ACK_DATA) {
+			/* Section 3.1.:
+			 * "the data parameters in a MP_CAPABLE are semantically
+			 * equivalent to those in a DSS option and can be used
+			 * interchangeably."
+			 */
+			mp_opt->dss =3D 1;
+			mp_opt->use_map =3D 1;
+			mp_opt->mp_capable_map =3D 1;
+			mp_opt->data_len =3D get_unaligned_be16(ptr);
+			ptr +=3D 2;
+		}
+		pr_debug("MP_CAPABLE flags=3D%x, optlen=3D%d sndr=3D%llu, rcvr=3D%llu le=
n=3D%d",
+			 mp_opt->flags, opsize, mp_opt->sndr_key,
+			 mp_opt->rcvr_key, mp_opt->data_len);
 		break;
 =

 	/* MPTCPOPT_MP_JOIN
@@ -105,6 +127,11 @@ void mptcp_parse_option(const unsigned char *ptr, int =
opsize,
 		pr_debug("DSS");
 		ptr++;
 =

+		/* we must clear 'mp_capable_map' be able to detect MP_CAPABLE
+		 * map vs DSS map in mptcp_incoming_options(), and reconstruct
+		 * map info accordingly
+		 */
+		mp_opt->mp_capable_map =3D 0;
 		mp_opt->dss_flags =3D (*ptr++) & MPTCP_DSS_FLAG_MASK;
 		mp_opt->data_fin =3D (mp_opt->dss_flags & MPTCP_DSS_DATA_FIN) !=3D 0;
 		mp_opt->dsn64 =3D (mp_opt->dss_flags & MPTCP_DSS_DSN64) !=3D 0;
@@ -238,18 +265,22 @@ void mptcp_get_options(const struct sk_buff *skb,
 			if (opsize > length)
 				return;	/* don't parse partial options */
 			if (opcode =3D=3D TCPOPT_MPTCP)
-				mptcp_parse_option(ptr, opsize, opt_rx);
+				mptcp_parse_option(skb, ptr, opsize, opt_rx);
 			ptr +=3D opsize - 2;
 			length -=3D opsize;
 		}
 	}
 }
 =

-bool mptcp_syn_options(struct sock *sk, unsigned int *size,
-		       struct mptcp_out_options *opts)
+bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
+		       unsigned int *size, struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 =

+	/* we will use snd_isn to detect first pkt [re]transmission
+	 * in mptcp_established_options_mp()
+	 */
+	subflow->snd_isn =3D TCP_SKB_CB(skb)->end_seq;
 	if (subflow->request_mptcp) {
 		pr_debug("local_key=3D%llu", subflow->local_key);
 		opts->suboptions =3D OPTION_MPTCP_MPC_SYN;
@@ -272,20 +303,58 @@ void mptcp_rcv_synsent(struct sock *sk)
 	}
 }
 =

-static bool mptcp_established_options_mp(struct sock *sk, unsigned int *si=
ze,
+static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *=
skb,
+					 unsigned int *size,
 					 unsigned int remaining,
 					 struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-
-	if (!subflow->fourth_ack) {
-		opts->suboptions =3D OPTION_MPTCP_MPC_ACK;
+	struct mptcp_ext *mpext;
+	unsigned int data_len;
+
+	pr_debug("subflow=3D%p fourth_ack=3D%d seq=3D%x:%x remaining=3D%d", subfl=
ow,
+		 subflow->fourth_ack, subflow->snd_isn,
+		 skb ? TCP_SKB_CB(skb)->seq : 0, remaining);
+
+	if (subflow->mp_capable && !subflow->fourth_ack && skb &&
+	    subflow->snd_isn =3D=3D TCP_SKB_CB(skb)->seq) {
+		/* When skb is not available, we better over-estimate the
+		 * emitted options len. A full DSS option is longer than
+		 * TCPOLEN_MPTCP_MPC_ACK_DATA, so let's the caller try to fit
+		 * that.
+		 */
+		mpext =3D mptcp_get_ext(skb);
+		data_len =3D mpext ? mpext->data_len : 0;
 		opts->sndr_key =3D subflow->local_key;
 		opts->rcvr_key =3D subflow->remote_key;
+
+		/* Section 3.1.
+		 * The MP_CAPABLE option is carried on the SYN, SYN/ACK, and ACK
+		 * packets that start the first subflow of an MPTCP connection,
+		 * as well as the first packet that carries data
+		 */
+		if (data_len > 0) {
+			opts->suboptions =3D OPTION_MPTCP_MPC_ACK;
+
+			/* we will check ext_copy.data_len in
+			 * mptcp_write_options() to discriminate between
+			 * TCPOLEN_MPTCP_MPC_ACK_DATA and TCPOLEN_MPTCP_MPC_ACK
+			 */
+			opts->ext_copy.data_len =3D data_len;
+			*size =3D ALIGN(TCPOLEN_MPTCP_MPC_ACK_DATA, 4);
+			pr_debug("subflow=3D%p, local_key=3D%llu, remote_key=3D%llu map_len=3D%=
d",
+				 subflow, subflow->local_key,
+				 subflow->remote_key, opts->ext_copy.data_len);
+			return true;
+		}
+
+		/* plain MP_CAPABLE + ack */
+		opts->suboptions =3D OPTION_MPTCP_MPC_ACK;
+		opts->ext_copy.data_len =3D 0;
 		*size =3D TCPOLEN_MPTCP_MPC_ACK;
-		subflow->fourth_ack =3D 1;
 		pr_debug("subflow=3D%p, local_key=3D%llu, remote_key=3D%llu",
-			 subflow, subflow->local_key, subflow->remote_key);
+			 subflow, subflow->local_key,
+			 subflow->remote_key);
 		return true;
 	}
 	return false;
@@ -348,7 +417,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 	if (!mptcp_subflow_ctx(sk)->mp_capable)
 		return false;
 =

-	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts))
+	if (mptcp_established_options_mp(sk, skb, &opt_size, remaining, opts))
 		ret =3D true;
 	else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
 						 opts))
@@ -374,11 +443,9 @@ bool mptcp_synack_options(const struct request_sock *r=
eq, unsigned int *size,
 	if (subflow_req->mp_capable) {
 		opts->suboptions =3D OPTION_MPTCP_MPC_SYNACK;
 		opts->sndr_key =3D subflow_req->local_key;
-		opts->rcvr_key =3D subflow_req->remote_key;
 		*size =3D TCPOLEN_MPTCP_MPC_SYNACK;
-		pr_debug("subflow_req=3D%p, local_key=3D%llu, remote_key=3D%llu",
-			 subflow_req, subflow_req->local_key,
-			 subflow_req->remote_key);
+		pr_debug("req=3D%p, local_key=3D%llu",
+			 subflow_req, subflow_req->local_key);
 		return true;
 	}
 	return false;
@@ -406,11 +473,23 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
 	memset(mpext, 0, sizeof(*mpext));
 =

 	if (mp_opt->use_map) {
-		mpext->data_seq =3D mp_opt->data_seq;
-		mpext->subflow_seq =3D mp_opt->subflow_seq;
+		if (mp_opt->mp_capable_map) {
+			/* this is an MP_CAPABLE carrying MPTCP data
+			 * we know this map the first chunk of data
+			 */
+			mptcp_crypto_key_sha(subflow->remote_key, NULL,
+					     &mpext->data_seq);
+			mpext->data_seq++;
+			mpext->subflow_seq =3D 1;
+			mpext->dsn64 =3D 1;
+			mpext->mp_capable_map =3D 1;
+		} else {
+			mpext->data_seq =3D mp_opt->data_seq;
+			mpext->subflow_seq =3D mp_opt->subflow_seq;
+			mpext->dsn64 =3D mp_opt->dsn64;
+		}
 		mpext->data_len =3D mp_opt->data_len;
 		mpext->use_map =3D 1;
-		mpext->dsn64 =3D mp_opt->dsn64;
 	}
 =

 	if (mp_opt->use_ack) {
@@ -424,8 +503,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 =

 void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts)
 {
-	if ((OPTION_MPTCP_MPC_SYN |
-	     OPTION_MPTCP_MPC_SYNACK |
+	if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
 	     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
 		u8 len;
 =

@@ -433,22 +511,36 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_ou=
t_options *opts)
 			len =3D TCPOLEN_MPTCP_MPC_SYN;
 		else if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions)
 			len =3D TCPOLEN_MPTCP_MPC_SYNACK;
+		else if (opts->ext_copy.data_len)
+			len =3D TCPOLEN_MPTCP_MPC_ACK_DATA;
 		else
 			len =3D TCPOLEN_MPTCP_MPC_ACK;
 =

 		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) | (len << 16) |
 			       (MPTCPOPT_MP_CAPABLE << 12) |
-			       ((MPTCP_VERSION_MASK & 0) << 8) |
+			       ((MPTCP_VERSION_MASK & 1) << 8) |
 			       MPTCP_CAP_HMAC_SHA256);
+
+		if (!((OPTION_MPTCP_MPC_SYNACK | OPTION_MPTCP_MPC_ACK) &
+		    opts->suboptions))
+			goto mp_capable_done;
+
 		put_unaligned_be64(opts->sndr_key, ptr);
 		ptr +=3D 2;
-		if ((OPTION_MPTCP_MPC_SYNACK |
-		     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
-			put_unaligned_be64(opts->rcvr_key, ptr);
-			ptr +=3D 2;
-		}
+		if (!((OPTION_MPTCP_MPC_ACK) & opts->suboptions))
+			goto mp_capable_done;
+
+		put_unaligned_be64(opts->rcvr_key, ptr);
+		ptr +=3D 2;
+		if (!opts->ext_copy.data_len)
+			goto mp_capable_done;
+
+		put_unaligned_be32(opts->ext_copy.data_len << 16 |
+				   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
+		ptr +=3D 1;
 	}
 =

+mp_capable_done:
 	if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
 		struct mptcp_ext *mpext =3D &opts->ext_copy;
 		u8 len =3D TCPOLEN_MPTCP_DSS_BASE;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6d959559aa1a..4b000f842d6b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -707,7 +707,7 @@ static struct socket *mptcp_socket_create_get(struct mp=
tcp_sock *msk)
 	msk->subflow =3D ssock;
 	subflow =3D mptcp_subflow_ctx(msk->subflow->sk);
 	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
-	subflow->request_version =3D 0; /* currently only v0 supported */
+	subflow->request_version =3D 1; /* only v1 supported */
 =

 	sock_hold(ssock->sk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dcdd3dcd19c6..bdff743cf2b3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -27,9 +27,10 @@
 #define MPTCPOPT_MP_FASTCLOSE	7
 =

 /* MPTCP suboption lengths */
-#define TCPOLEN_MPTCP_MPC_SYN		12
-#define TCPOLEN_MPTCP_MPC_SYNACK	20
+#define TCPOLEN_MPTCP_MPC_SYN		4
+#define TCPOLEN_MPTCP_MPC_SYNACK	12
 #define TCPOLEN_MPTCP_MPC_ACK		20
+#define TCPOLEN_MPTCP_MPC_ACK_DATA	22
 #define TCPOLEN_MPTCP_DSS_BASE		4
 #define TCPOLEN_MPTCP_DSS_ACK32		4
 #define TCPOLEN_MPTCP_DSS_ACK64		8
@@ -103,6 +104,7 @@ struct mptcp_subflow_context {
 	u64	remote_key;
 	u64	idsn;
 	u64	map_seq;
+	u32	snd_isn;
 	u32	token;
 	u32	rel_write_seq;
 	u32	map_subflow_seq;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 37b3ae10c042..96cc80f8d751 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -81,7 +81,6 @@ static void subflow_init_req(struct request_sock *req,
 			subflow_req->version =3D listener->request_version;
 		else
 			subflow_req->version =3D rx_opt.mptcp.version;
-		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 	}
 }
@@ -183,11 +182,22 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 					  bool *own_req)
 {
 	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk);
+	struct mptcp_subflow_request_sock *subflow_req;
+	struct tcp_options_received opt_rx;
 	struct sock *child;
 =

 	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->c=
onn);
 =

-	/* if the sk is MP_CAPABLE, we already received the client key */
+	/* if the sk is MP_CAPABLE, we need to fetch the client key */
+	subflow_req =3D mptcp_subflow_rsk(req);
+	if (subflow_req->mp_capable) {
+		opt_rx.mptcp.mp_capable =3D 0;
+		mptcp_get_options(skb, &opt_rx);
+		if (!opt_rx.mptcp.mp_capable)
+			subflow_req->mp_capable =3D 0;
+		else
+			subflow_req->remote_key =3D opt_rx.mptcp.sndr_key;
+	}
 =

 	child =3D listener->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
 						     req_unhash, own_req);
-- =

2.23.0

--===============5151573119807957123==--
