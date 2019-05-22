Content-Type: multipart/mixed; boundary="===============8157456383917450983=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 3/3] mptcp: Add handling of incoming MP_JOIN requests
Date: Wed, 22 May 2019 14:38:25 -0700
Message-ID: <20190522213825.4057-4-peter.krystad@linux.intel.com>
In-Reply-To: 20190522213825.4057-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1226

--===============8157456383917450983==
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
 include/net/mptcp.h      |  13 ++++
 include/net/tcp.h        |   3 +
 net/ipv4/tcp_minisocks.c |   6 ++
 net/ipv4/tcp_output.c    |   8 +--
 net/mptcp/options.c      |  85 ++++++++++++++++++++++++---
 net/mptcp/protocol.c     |  19 ++++++
 net/mptcp/protocol.h     |  25 +++++++-
 net/mptcp/subflow.c      |  42 +++++++++++++
 net/mptcp/token.c        | 124 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 316 insertions(+), 15 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index db0297daa33c..2c7060daf32f 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -116,6 +116,7 @@ struct tcp_options_received {
 		u8      mp_capable : 1,
 			mp_join : 1,
 			dss : 1,
+			backup : 1,
 			version : 4;
 		u8      flags;
 		u8	use_map:1,
@@ -125,6 +126,11 @@ struct tcp_options_received {
 			use_ack:1,
 			ack64:1,
 			__unused:2;
+		u8      address_id;
+		u32     token;
+		u32     nonce;
+		u64     thmac;
+		u8      hmac[20];
 	} mptcp;
 #endif
 };
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 5bcd0f386d9d..421bdf4cb0b4 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -37,6 +37,9 @@ struct mptcp_ext {
 #define OPTION_MPTCP_MPC_SYN		BIT(0)
 #define OPTION_MPTCP_MPC_SYNACK		BIT(1)
 #define OPTION_MPTCP_MPC_ACK		BIT(2)
+#define OPTION_MPTCP_MPJ_SYN		BIT(3)
+#define OPTION_MPTCP_MPJ_SYNACK		BIT(4)
+#define OPTION_MPTCP_MPJ_ACK		BIT(5)
 #define OPTION_MPTCP_ADD_ADDR		BIT(6)
 #define OPTION_MPTCP_ADD_ADDR6		BIT(7)
 #define OPTION_MPTCP_RM_ADDR		BIT(8)
@@ -49,6 +52,9 @@ struct mptcp_out_options {
 	struct in_addr addr;
 	struct in6_addr addr6;
 	u8 address_id;
+	u8 backup;
+	u32 nonce;
+	u64 thmac;
 	struct mptcp_ext ext_copy;
 #endif
 };
@@ -92,6 +98,8 @@ static inline bool mptcp_skb_ext_exist(const struct sk_bu=
ff *skb)
 =

 void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts);
 =

+bool mptcp_sk_is_subflow(const struct sock *sk);
+
 #else
 =

 static inline bool sk_is_mptcp(const struct sock *sk)
@@ -163,5 +171,10 @@ static inline bool mptcp_skb_ext_exist(const struct sk=
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
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6219b568c0f9..431c463d9d42 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -219,6 +219,9 @@ void tcp_time_wait(struct sock *sk, int state, int time=
o);
 #define TCPOLEN_MPTCP_MPC_SYN		12
 #define TCPOLEN_MPTCP_MPC_SYNACK	20
 #define TCPOLEN_MPTCP_MPC_ACK		20
+#define TCPOLEN_MPTCP_MPJ_SYN		12
+#define TCPOLEN_MPTCP_MPJ_SYNACK	16
+#define TCPOLEN_MPTCP_MPJ_ACK		24
 #define TCPOLEN_MPTCP_DSS_BASE		4
 #define TCPOLEN_MPTCP_DSS_ACK32		4
 #define TCPOLEN_MPTCP_DSS_ACK64		8
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9c2a0d36fb20..baf8b975fce6 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -764,6 +764,12 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_=
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
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a455af8a7b34..c02ec6bea9ee 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -804,15 +804,15 @@ static unsigned int tcp_established_options(struct so=
ck *sk, struct sk_buff *skb
 			remaining -=3D opt_size;
 		}
 =

-		if (mptcp_established_options_dss(sk, skb, &opt_size,
-						  remaining, &opts->mptcp)) {
+		if (mptcp_established_options_addr(sk, skb, &opt_size,
+						   remaining, &opts->mptcp)) {
 			opts->options |=3D OPTION_MPTCP;
 			size +=3D opt_size;
 			remaining -=3D opt_size;
 		}
 =

-		if (mptcp_established_options_addr(sk, skb, &opt_size,
-						   remaining, &opts->mptcp)) {
+		if (mptcp_established_options_dss(sk, skb, &opt_size,
+						  remaining, &opts->mptcp)) {
 			opts->options |=3D OPTION_MPTCP;
 			size +=3D opt_size;
 			remaining -=3D opt_size;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6437434a7bd7..dc4ba418c963 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -45,24 +45,55 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
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
+		pr_debug("MP_JOIN");
+		opt_rx->mptcp.mp_join =3D 1;
+		if (opsize =3D=3D TCPOLEN_MPTCP_MPJ_SYN) {
+			opt_rx->mptcp.backup =3D *ptr++ & MPTCPOPT_BACKUP;
+			pr_debug("backup=3D%u", opt_rx->mptcp.backup);
+			opt_rx->mptcp.address_id =3D *ptr++;
+			pr_debug("address_id=3D%u", opt_rx->mptcp.address_id);
+			opt_rx->mptcp.token =3D get_unaligned_be32(ptr);
+			pr_debug("token=3D%u", opt_rx->mptcp.token);
+			ptr +=3D 4;
+			opt_rx->mptcp.nonce =3D get_unaligned_be32(ptr);
+			pr_debug("nonce=3D%u", opt_rx->mptcp.nonce);
+			ptr +=3D 4;
+		} else if (opsize =3D=3D TCPOLEN_MPTCP_MPJ_SYNACK) {
+			opt_rx->mptcp.backup =3D *ptr++ & MPTCPOPT_BACKUP;
+			pr_debug("backup=3D%u", opt_rx->mptcp.backup);
+			opt_rx->mptcp.address_id =3D *ptr++;
+			pr_debug("address_id=3D%u", opt_rx->mptcp.address_id);
+			opt_rx->mptcp.thmac =3D get_unaligned_be64(ptr);
+			pr_debug("thmac=3D%llu", opt_rx->mptcp.thmac);
+			ptr +=3D 8;
+			opt_rx->mptcp.nonce =3D get_unaligned_be32(ptr);
+			pr_debug("nonce=3D%u", opt_rx->mptcp.nonce);
+			ptr +=3D 4;
+		} else if (opsize =3D=3D TCPOLEN_MPTCP_MPJ_ACK) {
+			ptr++;
+			memcpy(opt_rx->mptcp.hmac, ptr, MPTCPOPT_HMAC_LEN);
+		} else {
+			pr_warn("MP_JOIN bad option size");
+			opt_rx->mptcp.mp_join =3D 0;
+		}
+		break;
+
 =

 	/* MPTCPOPT_DSS
 	 * 0: 4MSB=3Dsubtype, 0000
@@ -152,6 +183,9 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 	 * 4 or 16 bytes of address (depending on ip version)
 	 * 0 or 2 bytes of port (depending on length)
 	 */
+	case MPTCPOPT_ADD_ADDR:
+		pr_debug("ADD_ADDR");
+		break;
 =

 	/* MPTCPOPT_RM_ADDR
 	 * 0: 4MSB=3Dsubtype, 0000
@@ -246,9 +280,11 @@ bool mptcp_established_options(struct sock *sk, struct=
 sk_buff *skb,
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
 =

+	if (!subflow->mp_capable)
+		return false;
+
 	pr_debug("subflow=3D%p", subflow);
-	if (subflow->mp_capable && !subflow->fourth_ack &&
-	    remaining >=3D TCPOLEN_MPTCP_MPC_ACK) {
+	if (!subflow->fourth_ack && remaining >=3D TCPOLEN_MPTCP_MPC_ACK) {
 		opts->suboptions =3D OPTION_MPTCP_MPC_ACK;
 		opts->sndr_key =3D subflow->local_key;
 		opts->rcvr_key =3D subflow->remote_key;
@@ -268,10 +304,12 @@ bool mptcp_established_options_addr(struct sock *sk, =
struct sk_buff *skb,
 	struct subflow_context *subflow =3D subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 =

+	if (!subflow->mp_capable)
+		return false;
+
 	pr_debug("subflow=3D%p", subflow);
 	pr_debug("fourth_ack=3D%d", subflow->fourth_ack);
-	if (subflow->mp_capable && subflow->fourth_ack && msk &&
-	    msk->addr_signal) {
+	if (subflow->fourth_ack && msk && msk->addr_signal) {
 		return pm_addr_signal(msk, size, remaining, opts, skb);
 	}
 	return false;
@@ -363,6 +401,19 @@ bool mptcp_synack_options(const struct request_sock *r=
eq, unsigned int *size,
 		pr_debug("remote_key=3D%llu", subflow_req->remote_key);
 		return true;
 	}
+	if (subflow_req->mp_join) {
+		opts->suboptions |=3D OPTION_MPTCP_MPJ_SYNACK;
+		opts->backup =3D subflow_req->backup;
+		opts->address_id =3D subflow_req->local_id;
+		opts->thmac =3D subflow_req->thmac;
+		opts->nonce =3D subflow_req->local_nonce;
+		pr_debug("backup=3D%u", opts->backup);
+		pr_debug("address_id=3D%u", opts->address_id);
+		pr_debug("thmac=3D%llu", opts->thmac);
+		pr_debug("nonce=3D%u", opts->nonce);
+		*size =3D TCPOLEN_MPTCP_MPJ_SYNACK;
+		return true;
+	}
 	return false;
 }
 =

@@ -417,8 +468,8 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out_=
options *opts)
 			len =3D TCPOLEN_MPTCP_MPC_ACK;
 =

 		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) | (len << 16) |
-			       (MPTCPOPT_MP_CAPABLE << 20) |
-			       ((MPTCPOPT_VERSION_MASK & 0) << 16) |
+			       (MPTCPOPT_MP_CAPABLE << 12) |
+			       ((MPTCPOPT_VERSION_MASK & 0) << 8) |
 			       MPTCP_CAP_HMAC_SHA1);
 		put_unaligned_be64(opts->sndr_key, ptr);
 		ptr +=3D 2;
@@ -455,6 +506,22 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 			       (opts->address_id));
 	}
 =

+	if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
+		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
+			       (TCPOLEN_MPTCP_MPJ_SYNACK << 16) |
+			       (MPTCPOPT_MP_JOIN << 12) |
+			       (opts->backup << 8) |
+			       opts->address_id);
+		pr_debug("opts->backup=3D%u", opts->backup);
+		pr_debug("opts->address_id=3D%u", opts->address_id);
+		put_unaligned_be64(opts->thmac, ptr);
+		ptr +=3D 2;
+		pr_debug("opts->thmac=3D%llu", opts->thmac);
+		put_unaligned_be32(opts->nonce, ptr);
+		ptr +=3D 1;
+		pr_debug("opts->nonce=3D%u", opts->nonce);
+	}
+
 	if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
 		struct mptcp_ext *mpext =3D &opts->ext_copy;
 		u8 len =3D TCPOLEN_MPTCP_DSS_BASE;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0d9796a040da..36981d8fcb51 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -772,6 +772,25 @@ void mptcp_finish_connect(struct sock *sk, int mp_capa=
ble)
 	inet_sk_state_store(sk, TCP_ESTABLISHED);
 }
 =

+void mptcp_finish_join(struct sock *conn, struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(conn);
+	struct subflow_context *subflow =3D subflow_ctx(sk);
+
+	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
+
+	spin_lock_bh(&msk->conn_list_lock);
+	list_add_tail_rcu(&subflow->node, &msk->conn_list);
+	spin_unlock_bh(&msk->conn_list_lock);
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
index 32d9faf4a311..4c8bf7e60e3e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -21,6 +21,8 @@
 #define MPTCPOPT_MP_FASTCLOSE	7
 =

 #define MPTCPOPT_VERSION_MASK	0x0F
+#define MPTCPOPT_BACKUP		(1 << 0)
+#define MPTCPOPT_HMAC_LEN	20
 =

 #define MPTCP_IPVERSION_4	4
 #define MPTCP_IPVERSION_6	6
@@ -69,11 +71,16 @@ struct subflow_request_sock {
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
@@ -96,15 +103,23 @@ struct subflow_context {
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

@@ -128,13 +143,19 @@ void mptcp_get_options(const struct sk_buff *skb,
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
index bc8e1a0658ec..1a768dd7a557 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -69,8 +69,21 @@ static void subflow_v4_init_req(struct request_sock *req,
 		token_new_request(req, skb);
 		pr_debug("syn seq=3D%u", TCP_SKB_CB(skb)->seq);
 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
+	} else if (rx_opt.mptcp.mp_join && listener->request_mptcp) {
+		subflow_req->mp_join =3D 1;
+		subflow_req->backup =3D rx_opt.mptcp.backup;
+		subflow_req->remote_id =3D rx_opt.mptcp.address_id;
+		subflow_req->token =3D rx_opt.mptcp.token;
+		pr_debug("token=3D%u", subflow_req->token);
+		subflow_req->remote_nonce =3D rx_opt.mptcp.nonce;
+		pr_debug("remote_nonce=3D%u", subflow_req->remote_nonce);
+		if (token_join_request(req, skb)) {
+			subflow_req->mp_join =3D 0;
+			// @@ need to trigger RST
+		}
 	} else {
 		subflow_req->mp_capable =3D 0;
+		subflow_req->mp_join =3D 0;
 	}
 }
 =

@@ -136,6 +149,13 @@ static struct sock *subflow_syn_recv_sock(const struct=
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
@@ -151,6 +171,18 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 			child =3D NULL;
 		} else if (ctx->mp_capable) {
 			token_new_accept(child);
+		} else if (ctx->mp_join) {
+			if (token_new_join(child)) {
+				inet_sk_set_state(child, TCP_CLOSE);
+				sock_set_flag(child, SOCK_DEAD);
+				inet_csk_destroy_sock(child);
+				child =3D NULL;
+			} else {
+				mptcp_finish_join(ctx->conn, child);
+			}
+		} else {
+			ctx->mp_capable =3D 0;
+			ctx->mp_join =3D 0;
 		}
 	}
 =

@@ -224,6 +256,8 @@ static void subflow_ulp_release(struct sock *sk)
 =

 	pr_debug("subflow=3D%p", ctx);
 =

+	token_release(ctx->token);
+
 	kfree(ctx);
 }
 =

@@ -257,6 +291,14 @@ static void subflow_ulp_clone(const struct request_soc=
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
index 7f1cec957fa8..d4957deabcfd 100644
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
+	pr_debug("local_nonce=3D%u", subflow_req->local_nonce);
+
+	crypto_hmac_sha1(msk->local_key,
+			 msk->remote_key,
+			 (u32 *)hmac, 2,
+			 4, (u8 *)&subflow_req->local_nonce,
+			 4, (u8 *)&subflow_req->remote_nonce);
+	subflow_req->thmac =3D *(u64 *)hmac;
+	pr_debug("thmac=3D%llu", subflow_req->thmac);
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


--===============8157456383917450983==--
