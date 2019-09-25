Content-Type: multipart/mixed; boundary="===============4424777857881510486=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] mptcp: Remove all traces of checksum support
Date: Wed, 25 Sep 2019 16:44:11 -0700
Message-ID: <20190925234411.2617-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1933

--===============4424777857881510486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since checksum support is not planned remove any references
that look it may be supported.

Also re-factor DSS option size calculation and make
DSS option size check for exactly correct lengths.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c  | 70 +++++++++++++++++---------------------------
 net/mptcp/pm.c       |  1 -
 net/mptcp/protocol.c | 13 ++++----
 net/mptcp/protocol.h |  4 +--
 net/mptcp/subflow.c  |  5 ----
 5 files changed, 33 insertions(+), 60 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 42f8b9beaa41..2ee07f0c01d2 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -130,7 +130,6 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 	 */
 	case MPTCPOPT_DSS:
 		pr_debug("DSS");
-		mp_opt->dss =3D 1;
 		ptr++;
 =

 		mp_opt->dss_flags =3D (*ptr++) & MPTCP_DSS_FLAG_MASK;
@@ -152,10 +151,27 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
 				expected_opsize +=3D TCPOLEN_MPTCP_DSS_ACK64;
 			else
 				expected_opsize +=3D TCPOLEN_MPTCP_DSS_ACK32;
+		}
+
+		if (mp_opt->use_map) {
+			if (mp_opt->dsn64)
+				expected_opsize +=3D TCPOLEN_MPTCP_DSS_MAP64;
+			else
+				expected_opsize +=3D TCPOLEN_MPTCP_DSS_MAP32;
+		}
 =

-			if (opsize < expected_opsize)
-				break;
+		/* RFC 6824, Section 3.3:
+		 * If a checksum is present, but its use had
+		 * not been negotiated in the MP_CAPABLE handshake,
+		 * the checksum field MUST be ignored.
+		 */
+		if (opsize !=3D expected_opsize &&
+		    opsize !=3D expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
+			break;
 =

+		mp_opt->dss =3D 1;
+
+		if (mp_opt->use_ack) {
 			if (mp_opt->ack64) {
 				mp_opt->data_ack =3D get_unaligned_be64(ptr);
 				ptr +=3D 8;
@@ -163,19 +179,10 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
 				mp_opt->data_ack =3D get_unaligned_be32(ptr);
 				ptr +=3D 4;
 			}
-
 			pr_debug("data_ack=3D%llu", mp_opt->data_ack);
 		}
 =

 		if (mp_opt->use_map) {
-			if (mp_opt->dsn64)
-				expected_opsize +=3D TCPOLEN_MPTCP_DSS_MAP64;
-			else
-				expected_opsize +=3D TCPOLEN_MPTCP_DSS_MAP32;
-
-			if (opsize < expected_opsize)
-				break;
-
 			if (mp_opt->dsn64) {
 				mp_opt->data_seq =3D get_unaligned_be64(ptr);
 				ptr +=3D 8;
@@ -190,13 +197,11 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
 			mp_opt->data_len =3D get_unaligned_be16(ptr);
 			ptr +=3D 2;
 =

-			/* Checksum not currently supported */
-			mp_opt->checksum =3D 0;
-
-			pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u ck=3D%u",
+			pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u",
 				 mp_opt->data_seq, mp_opt->subflow_seq,
-				 mp_opt->data_len, mp_opt->checksum);
+				 mp_opt->data_len);
 		}
+
 		break;
 =

 	/* MPTCPOPT_ADD_ADDR
@@ -390,12 +395,8 @@ static bool mptcp_established_options_dss(struct sock =
*sk, struct sk_buff *skb,
 =

 	if (!skb || (mpext && mpext->use_map)) {
 		unsigned int map_size;
-		bool use_csum;
 =

 		map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
-		use_csum =3D subflow_ctx(sk)->use_checksum;
-		if (use_csum)
-			map_size +=3D TCPOLEN_MPTCP_DSS_CHECKSUM;
 =

 		if (map_size <=3D remaining) {
 			remaining -=3D map_size;
@@ -404,10 +405,8 @@ static bool mptcp_established_options_dss(struct sock =
*sk, struct sk_buff *skb,
 				opts->ext_copy.data_seq =3D mpext->data_seq;
 				opts->ext_copy.subflow_seq =3D mpext->subflow_seq;
 				opts->ext_copy.data_len =3D mpext->data_len;
-				opts->ext_copy.checksum =3D mpext->checksum;
 				opts->ext_copy.use_map =3D 1;
 				opts->ext_copy.dsn64 =3D mpext->dsn64;
-				opts->ext_copy.use_checksum =3D use_csum;
 			}
 		} else {
 			opts->ext_copy.use_map =3D 0;
@@ -614,10 +613,8 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 		mpext->data_seq =3D mp_opt->data_seq;
 		mpext->subflow_seq =3D mp_opt->subflow_seq;
 		mpext->data_len =3D mp_opt->data_len;
-		mpext->checksum =3D mp_opt->checksum;
 		mpext->use_map =3D 1;
 		mpext->dsn64 =3D mp_opt->dsn64;
-		mpext->use_checksum =3D mp_opt->use_checksum;
 	}
 =

 	mpext->data_fin =3D mp_opt->data_fin;
@@ -711,12 +708,8 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 		}
 =

 		if (mpext->use_map) {
-			pr_debug("Updating DSS length and flags for map");
 			len +=3D TCPOLEN_MPTCP_DSS_MAP64;
 =

-			if (mpext->use_checksum)
-				len +=3D TCPOLEN_MPTCP_DSS_CHECKSUM;
-
 			/* Use only 64-bit mapping flags for now, add
 			 * support for optional 32-bit mappings later.
 			 */
@@ -725,10 +718,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 				flags |=3D MPTCP_DSS_DATA_FIN;
 		}
 =

-		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
-			       (len  << 16) |
-			       (MPTCPOPT_DSS << 12) |
-			       (flags));
+		*ptr++ =3D mptcp_option(MPTCPOPT_DSS, len, 0, flags);
 =

 		if (mpext->use_ack) {
 			put_unaligned_be64(mpext->data_ack, ptr);
@@ -736,18 +726,12 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_ou=
t_options *opts)
 		}
 =

 		if (mpext->use_map) {
-			__u16 checksum;
-
-			pr_debug("Writing map values");
 			put_unaligned_be64(mpext->data_seq, ptr);
 			ptr +=3D 2;
-			*ptr++ =3D htonl(mpext->subflow_seq);
-
-			if (mpext->use_checksum)
-				checksum =3D (u16 __force)mpext->checksum;
-			else
-				checksum =3D TCPOPT_NOP << 8 | TCPOPT_NOP;
-			*ptr =3D htonl(mpext->data_len << 16 | checksum);
+			put_unaligned_be32(mpext->subflow_seq, ptr);
+			ptr +=3D 1;
+			put_unaligned_be32(mpext->data_len << 16 |
+					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
 		}
 	}
 }
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b02e3c0253f5..2e0b6650be63 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -74,7 +74,6 @@ int pm_create_subflow(u32 token, u8 remote_id, sa_family_=
t family,
 	if (family =3D=3D AF_INET)
 		local.sin_addr.s_addr =3D addr->s_addr;
 	else
-		local.sin_addr.s_addr =3D INADDR_ANY;
 		local.sin_addr.s_addr =3D htonl(INADDR_ANY);
 =

 	remote.sin_family =3D msk->pm.remote_family;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9291ac84e175..d5daf601a067 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -305,13 +305,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 		mpext->data_seq =3D *write_seq;
 		mpext->subflow_seq =3D subflow_ctx(ssk)->rel_write_seq;
 		mpext->data_len =3D ret;
-		mpext->checksum =3D 0xbeef;
 		mpext->use_map =3D 1;
 		mpext->dsn64 =3D 1;
 =

-		pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u checksum=3D%u, =
dsn64=3D%d",
+		pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u dsn64=3D%d",
 			 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
-			 mpext->checksum, mpext->dsn64);
+			 mpext->dsn64);
 	}
 	/* TODO: else fallback; allocation can fail, but we can't easily retire
 	 * skbs from the write_queue, as we need to roll-back TCP status
@@ -482,9 +481,8 @@ static enum mapping_status mptcp_get_mapping(struct soc=
k *ssk)
 		goto del_out;
 	}
 =

-	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u data_len=3D%u ck=3D%u",
-		 mpext->data_seq, mpext->dsn64, mpext->subflow_seq,
-		 mpext->data_len, mpext->checksum);
+	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u data_len=3D%u", mpext->data_seq,
+		 mpext->dsn64, mpext->subflow_seq, mpext->data_len);
 =

 	if (mpext->data_len =3D=3D 0) {
 		pr_err("Infinite mapping not handled");
@@ -1225,8 +1223,7 @@ static struct socket *mptcp_socket_create_get(struct =
mptcp_sock *msk)
 	msk->subflow =3D ssock;
 	subflow =3D subflow_ctx(msk->subflow->sk);
 	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
-	subflow->request_cksum =3D 0; /* checksum not supported */
-	subflow->request_version =3D 0; /* only v0 supported */
+	subflow->request_version =3D 0; /* currently only v0 supported */
 =

 	sock_hold(ssock->sk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f1f5ab3990ab..400fbb0060f3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -173,7 +173,7 @@ struct subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u8	mp_capable : 1,
 		mp_join : 1,
-		checksum : 1,
+		unused : 1,
 		backup : 1,
 		version : 4;
 	u8	local_id;
@@ -208,14 +208,12 @@ struct subflow_context {
 	u16	map_data_len;
 	u16	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_join : 1,   /* send MP_JOIN */
-		request_cksum : 1,
 		request_bkup : 1,
 		request_version : 4,
 		mp_capable : 1,     /* remote is MPTCP capable */
 		mp_join : 1,        /* remote is JOINing */
 		fourth_ack : 1,     /* send initial DSS */
 		conn_finished : 1,
-		use_checksum : 1,
 		map_valid : 1,
 		backup : 1;
 	u32	remote_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 465c1fcc59ac..0c9b9a77f876 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -117,9 +117,6 @@ static void subflow_v4_init_req(struct request_sock *re=
q,
 			subflow_req->version =3D listener->request_version;
 		else
 			subflow_req->version =3D rx_opt.mptcp.version;
-		if ((rx_opt.mptcp.flags & MPTCP_CAP_CHECKSUM_REQD) ||
-		    listener->request_cksum)
-			subflow_req->checksum =3D 1;
 		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
 		pr_debug("syn seq=3D%u", TCP_SKB_CB(skb)->seq);
 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
@@ -434,7 +431,6 @@ static int subflow_ulp_init(struct sock *sk)
 	tp->is_mptcp =3D 1;
 	icsk->icsk_af_ops =3D &subflow_specific;
 	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
-	ctx->use_checksum =3D 0;
 	sk->sk_data_ready =3D subflow_data_ready;
 out:
 	return err;
@@ -472,7 +468,6 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 	new_ctx->conn =3D NULL;
 	new_ctx->conn_finished =3D 1;
 	new_ctx->tcp_sk_data_ready =3D old_ctx->tcp_sk_data_ready;
-	new_ctx->use_checksum =3D old_ctx->use_checksum;
 =

 	if (subflow_req->mp_capable) {
 		new_ctx->mp_capable =3D 1;
-- =

2.17.2


--===============4424777857881510486==--
