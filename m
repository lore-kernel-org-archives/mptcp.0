Content-Type: multipart/mixed; boundary="===============8535819053111495909=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v3 3/3] mptcp: Add handling of incoming MP_JOIN requests
Date: Sun, 16 Jun 2019 21:38:14 -0700
Message-ID: <20190617043814.3470-4-peter.krystad@linux.intel.com>
In-Reply-To: 20190617043814.3470-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1411

--===============8535819053111495909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Process the MP_JOIN option in a SYN packet with the same flow
as MP_CAPABLE but when the third ACK is received add the
subflow to the MPTCP socket subflow list instead of adding it to
the TCP socket accept queue.

The subflow is added at the end of the subflow list so it will not
interfere with the existing subflows operation and no data is
expected to be transmitted on it.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h      |   6 ++
 include/net/mptcp.h      |  14 +++++
 net/ipv4/tcp_minisocks.c |   6 ++
 net/mptcp/options.c      |  58 ++++++++++++++++--
 net/mptcp/protocol.c     |  21 +++++++
 net/mptcp/protocol.h     |  28 ++++++++-
 net/mptcp/subflow.c      |  61 ++++++++++++++++---
 net/mptcp/token.c        | 124 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 303 insertions(+), 15 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index b1d2ff2af0c2..68ff73ce8ac2 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -112,8 +112,14 @@ struct tcp_options_received {
 		u8      mp_capable : 1,
 			mp_join : 1,
 			dss : 1,
+			backup : 1,
 			version : 4;
 		u8      flags;
+		u8      join_id;
+		u32     token;
+		u32     nonce;
+		u64     thmac;
+		u8      hmac[20];
 		u8	dss_flags;
 		u8	use_map:1,
 			dsn64:1,
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 9597cb36d2ae..fa6b4bcc71bd 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -28,6 +28,9 @@ struct mptcp_ext {
 #define OPTION_MPTCP_MPC_SYN		BIT(0)
 #define OPTION_MPTCP_MPC_SYNACK		BIT(1)
 #define OPTION_MPTCP_MPC_ACK		BIT(2)
+#define OPTION_MPTCP_MPJ_SYN		BIT(3)
+#define OPTION_MPTCP_MPJ_SYNACK		BIT(4)
+#define OPTION_MPTCP_MPJ_ACK		BIT(5)
 #define OPTION_MPTCP_ADD_ADDR		BIT(6)
 #define OPTION_MPTCP_ADD_ADDR6		BIT(7)
 #define OPTION_MPTCP_RM_ADDR		BIT(8)
@@ -44,6 +47,10 @@ struct mptcp_out_options {
 #endif
 	};
 	u8 addr_id;
+	u8 join_id;
+	u8 backup;
+	u32 nonce;
+	u64 thmac;
 	struct mptcp_ext ext_copy;
 #endif
 };
@@ -83,6 +90,8 @@ static inline bool mptcp_skb_ext_exist(const struct sk_bu=
ff *skb)
 =

 void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts);
 =

+bool mptcp_sk_is_subflow(const struct sock *sk);
+
 #else
 =

 static inline void mptcp_init(void)
@@ -140,5 +149,10 @@ static inline bool mptcp_skb_ext_exist(const struct sk=
_buff *skb)
 	return false;
 }
 =

+static inline book mptcp_sk_is_subflow(const struct sock *sk)
+{
+	return false;
+}
+
 #endif /* CONFIG_MPTCP */
 #endif /* __NET_MPTCP_H */
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 8bcaf2586b68..081b410592b3 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -766,6 +766,12 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_=
buff *skb,
 	if (!child)
 		goto listen_overflow;
 =

+	if (own_req && sk_is_mptcp(child) && mptcp_sk_is_subflow(child)) {
+		inet_csk_reqsk_queue_drop(sk, req);
+		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
+		return child;
+	}
+
 	sock_rps_save_rxhash(child, skb);
 	tcp_synack_rtt_meas(child, req);
 	*req_stolen =3D !own_req;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3abfa02bbb9c..621bd0798af4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -55,24 +55,53 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 		break;
 =

 	/* MPTCPOPT_MP_JOIN
-	 *
 	 * Initial SYN
 	 * 0: 4MSB=3Dsubtype, 000, 1LSB=3DBackup
 	 * 1: Address ID
 	 * 2-5: Receiver token
 	 * 6-9: Sender random number
-	 *
 	 * SYN/ACK response
 	 * 0: 4MSB=3Dsubtype, 000, 1LSB=3DBackup
 	 * 1: Address ID
 	 * 2-9: Sender truncated HMAC
 	 * 10-13: Sender random number
-	 *
 	 * Third ACK
 	 * 0: 4MSB=3Dsubtype, 0000
 	 * 1: 0 (Reserved)
 	 * 2-21: Sender HMAC
 	 */
+	case MPTCPOPT_MP_JOIN:
+		mp_opt->mp_join =3D 1;
+		if (opsize =3D=3D TCPOLEN_MPTCP_MPJ_SYN) {
+			mp_opt->backup =3D *ptr++ & MPTCPOPT_BACKUP;
+			mp_opt->join_id =3D *ptr++;
+			mp_opt->token =3D get_unaligned_be32(ptr);
+			ptr +=3D 4;
+			mp_opt->nonce =3D get_unaligned_be32(ptr);
+			ptr +=3D 4;
+			pr_debug("MP_JOIN bkup=3D%u, id=3D%u, token=3D%u, nonce=3D%u",
+				 mp_opt->backup, mp_opt->join_id,
+				 mp_opt->token, mp_opt->nonce);
+		} else if (opsize =3D=3D TCPOLEN_MPTCP_MPJ_SYNACK) {
+			mp_opt->backup =3D *ptr++ & MPTCPOPT_BACKUP;
+			mp_opt->join_id =3D *ptr++;
+			mp_opt->thmac =3D get_unaligned_be64(ptr);
+			ptr +=3D 8;
+			mp_opt->nonce =3D get_unaligned_be32(ptr);
+			ptr +=3D 4;
+			pr_debug("MP_JOIN bkup=3D%u, id=3D%u, thmac=3D%llu, nonce=3D%u",
+				 mp_opt->backup, mp_opt->join_id,
+				 mp_opt->thmac, mp_opt->nonce);
+		} else if (opsize =3D=3D TCPOLEN_MPTCP_MPJ_ACK) {
+			ptr++;
+			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
+			pr_debug("MP_JOIN hmac");
+		} else {
+			pr_warn("MP_JOIN bad option size");
+			mp_opt->mp_join =3D 0;
+		}
+		break;
+
 =

 	/* MPTCPOPT_DSS
 	 * 0: 4MSB=3Dsubtype, 0000
@@ -429,10 +458,21 @@ bool mptcp_synack_options(const struct request_sock *=
req, unsigned int *size,
 		opts->sndr_key =3D subflow_req->local_key;
 		opts->rcvr_key =3D subflow_req->remote_key;
 		*size =3D TCPOLEN_MPTCP_MPC_SYNACK;
-		pr_debug("subflow_req=3D%p, local_key=3D%llu, remote_key=3D%llu",
+		pr_debug("req=3D%p, local_key=3D%llu, remote_key=3D%llu",
 			 subflow_req, subflow_req->local_key,
 			 subflow_req->remote_key);
 		return true;
+	} else if (subflow_req->mp_join) {
+		opts->suboptions =3D OPTION_MPTCP_MPJ_SYNACK;
+		opts->backup =3D subflow_req->backup;
+		opts->join_id =3D subflow_req->local_id;
+		opts->thmac =3D subflow_req->thmac;
+		opts->nonce =3D subflow_req->local_nonce;
+		pr_debug("req=3D%p, bkup=3D%u, id=3D%u, thmac=3D%llu, nonce=3D%u",
+			 subflow_req, opts->backup, opts->join_id,
+			 opts->thmac, opts->nonce);
+		*size =3D TCPOLEN_MPTCP_MPJ_SYNACK;
+		return true;
 	}
 	return false;
 }
@@ -519,6 +559,16 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 				      0, opts->addr_id);
 	}
 =

+	if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
+				      TCPOLEN_MPTCP_MPJ_SYNACK,
+				      opts->backup, opts->join_id);
+		put_unaligned_be64(opts->thmac, ptr);
+		ptr +=3D 2;
+		put_unaligned_be32(opts->nonce, ptr);
+		ptr +=3D 1;
+	}
+
 	if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
 		struct mptcp_ext *mpext =3D &opts->ext_copy;
 		u8 len =3D TCPOLEN_MPTCP_DSS_BASE;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a1a42ed7810a..f4cc9b769d91 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -777,6 +777,27 @@ void mptcp_finish_connect(struct sock *sk, int mp_capa=
ble)
 	inet_sk_state_store(sk, TCP_ESTABLISHED);
 }
 =

+void mptcp_finish_join(struct sock *conn, struct sock *sk)
+{
+	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(conn);
+
+	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
+
+	local_bh_disable();
+	bh_lock_sock_nested(sk);
+	list_add_tail(&subflow->node, &msk->conn_list);
+	bh_unlock_sock(sk);
+	local_bh_enable();
+}
+
+bool mptcp_sk_is_subflow(const struct sock *sk)
+{
+	struct subflow_context *subflow =3D subflow_ctx(sk);
+
+	return subflow->mp_join =3D=3D 1;
+}
+
 static struct proto mptcp_prot =3D {
 	.name		=3D "MPTCP",
 	.owner		=3D THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b912bf23c480..37eb7b45d2f9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -21,11 +21,16 @@
 #define MPTCPOPT_MP_FAIL	6
 #define MPTCPOPT_MP_FASTCLOSE	7
 =

+#define TCPOLEN_MPTCP_MPJ_SYN		12
+#define TCPOLEN_MPTCP_MPJ_SYNACK	16
+#define TCPOLEN_MPTCP_MPJ_ACK		24
 #define TCPOLEN_MPTCP_ADD_ADDR		8
 #define TCPOLEN_MPTCP_ADD_ADDR6		20
 #define TCPOLEN_MPTCP_RM_ADDR		4
 =

 #define MPTCPOPT_VERSION_MASK	0x0F
+#define MPTCPOPT_BACKUP		(1 << 0)
+#define MPTCPOPT_HMAC_LEN	20
 =

 #define MPTCP_ADDR_FAMILY_MASK	0x0F
 #define MPTCP_ADDR_IPVERSION_4	4
@@ -92,11 +97,16 @@ struct subflow_request_sock {
 		checksum : 1,
 		backup : 1,
 		version : 4;
+	u8	local_id;
+	u8	remote_id;
 	u64	local_key;
 	u64	remote_key;
 	u64	idsn;
 	u32	token;
 	u32	ssn_offset;
+	u64	thmac;
+	u32	local_nonce;
+	u32	remote_nonce;
 };
 =

 static inline
@@ -119,15 +129,23 @@ struct subflow_context {
 	u16	map_data_len;
 	u16	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_cksum : 1,
-		mp_capable : 1,	    /* remote is MPTCP capable */
+		mp_capable : 1,     /* remote is MPTCP capable */
+		mp_join : 1,        /* remote is JOINing */
 		fourth_ack : 1,     /* send initial DSS */
 		version : 4,
 		conn_finished : 1,
 		use_checksum : 1,
-		map_valid : 1;
+		map_valid : 1,
+		backup : 1;
+	u32	remote_nonce;
+	u64	thmac;
+	u32	local_nonce;
+	u8	local_id;
+	u8	remote_id;
 =

 	struct  socket *tcp_sock;  /* underlying tcp_sock */
 	struct  sock *conn;        /* parent mptcp_sock */
+
 	void	(*tcp_sk_data_ready)(struct sock *sk);
 };
 =

@@ -150,13 +168,19 @@ void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx);
 =

 void mptcp_finish_connect(struct sock *sk, int mp_capable);
+void mptcp_finish_join(struct sock *conn, struct sock *sk);
 =

 void token_init(void);
 void token_new_request(struct request_sock *req, const struct sk_buff *skb=
);
+int token_join_request(struct request_sock *req, const struct sk_buff *skb=
);
+int token_join_valid(struct request_sock *req,
+		     struct tcp_options_received *rx_opt);
 void token_destroy_request(u32 token);
 void token_new_connect(struct sock *sk);
 void token_new_accept(struct sock *sk);
+int token_new_join(struct sock *sk);
 void token_update_accept(struct sock *sk, struct sock *conn);
+void token_release(u32 token);
 void token_destroy(u32 token);
 =

 void crypto_init(void);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a31f58990c86..6f92058f1bac 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -55,6 +55,12 @@ static void subflow_v4_init_req(struct request_sock *req,
 	memset(&rx_opt.mptcp, 0, sizeof(rx_opt.mptcp));
 	mptcp_get_options(skb, &rx_opt);
 =

+	subflow_req->mp_capable =3D 0;
+	subflow_req->mp_join =3D 0;
+
+	if (rx_opt.mptcp.mp_capable && rx_opt.mptcp.mp_join)
+		return;
+
 	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
 		subflow_req->mp_capable =3D 1;
 		if (rx_opt.mptcp.version >=3D listener->version)
@@ -69,8 +75,18 @@ static void subflow_v4_init_req(struct request_sock *req,
 		token_new_request(req, skb);
 		pr_debug("syn seq=3D%u", TCP_SKB_CB(skb)->seq);
 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
-	} else {
-		subflow_req->mp_capable =3D 0;
+	} else if (rx_opt.mptcp.mp_join && listener->request_mptcp) {
+		subflow_req->mp_join =3D 1;
+		subflow_req->backup =3D rx_opt.mptcp.backup;
+		subflow_req->remote_id =3D rx_opt.mptcp.join_id;
+		subflow_req->token =3D rx_opt.mptcp.token;
+		subflow_req->remote_nonce =3D rx_opt.mptcp.nonce;
+		pr_debug("token=3D%u, remote_nonce=3D%u", subflow_req->token,
+			 subflow_req->remote_nonce);
+		if (token_join_request(req, skb)) {
+			subflow_req->mp_join =3D 0;
+			// @@ need to trigger RST
+		}
 	}
 }
 =

@@ -135,6 +151,13 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 		    (subflow_req->local_key !=3D opt_rx.mptcp.rcvr_key) ||
 		    (subflow_req->remote_key !=3D opt_rx.mptcp.sndr_key))
 			return NULL;
+	} else if (subflow_req->mp_join) {
+		opt_rx.mptcp.mp_join =3D 0;
+		mptcp_get_options(skb, &opt_rx);
+		if ((!opt_rx.mptcp.mp_join) ||
+		    (token_join_valid(req, &opt_rx))) {
+			return NULL;
+		}
 	}
 =

 	child =3D tcp_v4_syn_recv_sock(sk, skb, req, dst, req_unhash, own_req);
@@ -142,18 +165,28 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 	if (child && *own_req) {
 		struct subflow_context *ctx =3D subflow_ctx(child);
 =

-		if (!ctx) {
-			pr_debug("Closing child socket");
-			inet_sk_set_state(child, TCP_CLOSE);
-			sock_set_flag(child, SOCK_DEAD);
-			inet_csk_destroy_sock(child);
-			child =3D NULL;
-		} else if (ctx->mp_capable) {
+		if (!ctx)
+			goto close_child;
+
+		if (ctx->mp_capable) {
 			token_new_accept(child);
+		} else if (ctx->mp_join) {
+			if (token_new_join(child)) {
+				goto close_child;
+			} else {
+				mptcp_finish_join(ctx->conn, child);
+			}
 		}
 	}
 =

 	return child;
+
+close_child:
+	pr_debug("closing child socket");
+	inet_sk_set_state(child, TCP_CLOSE);
+	sock_set_flag(child, SOCK_DEAD);
+	inet_csk_destroy_sock(child);
+	return NULL;
 }
 =

 static struct inet_connection_sock_af_ops subflow_specific;
@@ -223,6 +256,8 @@ static void subflow_ulp_release(struct sock *sk)
 =

 	pr_debug("subflow=3D%p", ctx);
 =

+	token_release(ctx->token);
+
 	kfree(ctx);
 }
 =

@@ -256,6 +291,14 @@ static void subflow_ulp_clone(const struct request_soc=
k *req,
 		new_ctx->ssn_offset =3D subflow_req->ssn_offset;
 		new_ctx->idsn =3D subflow_req->idsn;
 		pr_debug("token=3D%u", new_ctx->token);
+	} else if (subflow_req->mp_join) {
+		new_ctx->mp_join =3D 1;
+		new_ctx->fourth_ack =3D 1;
+		new_ctx->backup =3D subflow_req->backup;
+		new_ctx->local_id =3D subflow_req->local_id;
+		new_ctx->token =3D subflow_req->token;
+		new_ctx->thmac =3D subflow_req->thmac;
+		pr_debug("token=3D%u", new_ctx->token);
 	}
 }
 =

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 7f1cec957fa8..16f0cad298a8 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -55,6 +55,15 @@ static bool find_token(u32 token)
 	return (used !=3D NULL);
 }
 =

+static struct sock *lookup_token(u32 token)
+{
+	void *conn;
+
+	pr_debug("token=3D%u", token);
+	conn =3D radix_tree_lookup(&token_tree, token);
+	return (struct sock *) conn;
+}
+
 static void new_req_token(struct request_sock *req,
 			  const struct sk_buff *skb)
 {
@@ -82,6 +91,56 @@ static void new_req_token(struct request_sock *req,
 		 subflow_req->token, subflow_req->idsn);
 }
 =

+static void new_req_join(struct request_sock *req, struct sock *sk,
+			 const struct sk_buff *skb)
+{
+	const struct inet_request_sock *ireq =3D inet_rsk(req);
+	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	u8 hmac[MPTCPOPT_HMAC_LEN];
+	u32 nonce;
+
+	if (skb->protocol =3D=3D htons(ETH_P_IP)) {
+		nonce =3D crypto_v4_get_nonce(ip_hdr(skb)->saddr,
+					    ip_hdr(skb)->daddr,
+					    htons(ireq->ir_num),
+					    ireq->ir_rmt_port);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		nonce =3D crypto_v6_get_nonce(&ipv6_hdr(skb)->saddr,
+					    &ipv6_hdr(skb)->daddr,
+					    htons(ireq->ir_num),
+					    ireq->ir_rmt_port);
+#endif
+	}
+	subflow_req->local_nonce =3D nonce;
+
+	crypto_hmac_sha1(msk->local_key,
+			 msk->remote_key,
+			 (u32 *)hmac, 2,
+			 4, (u8 *)&subflow_req->local_nonce,
+			 4, (u8 *)&subflow_req->remote_nonce);
+	subflow_req->thmac =3D *(u64 *)hmac;
+	pr_debug("local_nonce=3D%u, thmac=3D%llu", subflow_req->local_nonce,
+		 subflow_req->thmac);
+}
+
+static int new_join_valid(struct request_sock *req, struct sock *sk,
+			  struct tcp_options_received *rx_opt)
+{
+	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	u8 hmac[MPTCPOPT_HMAC_LEN];
+
+	crypto_hmac_sha1(msk->remote_key,
+			 msk->local_key,
+			 (u32 *)hmac, 2,
+			 4, (u8 *)&subflow_req->remote_nonce,
+			 4, (u8 *)&subflow_req->local_nonce);
+
+	return memcmp(hmac, (char *)rx_opt->mptcp.hmac, MPTCPOPT_HMAC_LEN);
+ }
+
 static void new_token(const struct sock *sk)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
@@ -178,6 +237,42 @@ void token_new_request(struct request_sock *req,
 	spin_unlock_bh(&token_tree_lock);
 }
 =

+/* validate received token and create truncated hmac and nonce for SYN-ACK=
 */
+int token_join_request(struct request_sock *req, const struct sk_buff *skb)
+{
+	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	struct sock *conn;
+
+	pr_debug("subflow_req=3D%p, token=3D%u", subflow_req, subflow_req->token);
+	spin_lock_bh(&token_tree_lock);
+	conn =3D lookup_token(subflow_req->token);
+	spin_unlock_bh(&token_tree_lock);
+	if (conn !=3D NULL) {
+		// @@ get real local address id for this skb->saddr
+		subflow_req->local_id =3D 0;
+		new_req_join(req, conn, skb);
+		return 0;
+	}
+	return -1;
+}
+
+/* validate hmac received in third ACK */
+int token_join_valid(struct request_sock *req,
+		     struct tcp_options_received *rx_opt)
+{
+	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	struct sock *conn;
+
+	pr_debug("subflow_req=3D%p, token=3D%u", subflow_req, subflow_req->token);
+	spin_lock_bh(&token_tree_lock);
+	conn =3D lookup_token(subflow_req->token);
+	spin_unlock_bh(&token_tree_lock);
+	if (conn !=3D NULL) {
+		return new_join_valid(req, conn, rx_opt);
+	}
+	return -1;
+}
+
 /* create new local key, idsn, and token for subflow */
 void token_new_connect(struct sock *sk)
 {
@@ -221,6 +316,23 @@ void token_update_accept(struct sock *sk, struct sock =
*conn)
 	spin_unlock_bh(&token_tree_lock);
 }
 =

+int token_new_join(struct sock *sk)
+{
+	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct sock *conn;
+
+	spin_lock_bh(&token_tree_lock);
+	conn =3D lookup_token(subflow->token);
+	if (conn !=3D NULL) {
+		sock_hold(conn);
+		spin_unlock_bh(&token_tree_lock);
+		subflow->conn =3D conn;
+		return 0;
+	}
+	spin_unlock_bh(&token_tree_lock);
+	return -1;
+}
+
 void token_destroy_request(u32 token)
 {
 	pr_debug("token=3D%u", token);
@@ -230,6 +342,18 @@ void token_destroy_request(u32 token)
 	spin_unlock_bh(&token_tree_lock);
 }
 =

+void token_release(u32 token)
+{
+	struct sock *conn;
+
+	pr_debug("token=3D%u", token);
+	spin_lock_bh(&token_tree_lock);
+	conn =3D lookup_token(token);
+	if (conn !=3D NULL)
+		sock_put(conn);
+	spin_unlock_bh(&token_tree_lock);
+}
+
 void token_destroy(u32 token)
 {
 	struct sock *conn;
-- =

2.17.2


--===============8535819053111495909==--
