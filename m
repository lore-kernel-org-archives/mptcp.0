Content-Type: multipart/mixed; boundary="===============2966095147188026909=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 08/10] mptcp: Add handling of outgoing MP_JOIN
 requests
Date: Thu, 25 Jul 2019 18:58:25 -0700
Message-ID: <20190726015827.10637-9-peter.krystad@linux.intel.com>
In-Reply-To: 20190726015827.10637-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1565

--===============2966095147188026909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Subflow creation may be initiated by the path manager when
the primary connection is fully established and a remote
address has been received via ADD_ADDR.

Create an in-kernel sock and use kernel_connect() to
initiate connection. When a valid SYN-ACK is received the
new sock is added to the tail of the mptcp sock conn_list
where it will not interfere with data flow on the original
connection.

Data flow and connection failover not addressed by this commit.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/mptcp.h  |  2 ++
 net/mptcp/options.c  | 51 ++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.c |  2 ++
 net/mptcp/protocol.h | 10 +++++++
 net/mptcp/subflow.c  | 63 +++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/token.c    | 41 ++++++++++++++++++++++++++++
 6 files changed, 164 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index bb2dd193c0c5..50cd1b31ebdd 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -40,6 +40,8 @@ struct mptcp_out_options {
 	u8 backup;
 	u32 nonce;
 	u64 thmac;
+	u32 token;
+	u8 hmac[20];
 	struct mptcp_ext ext_copy;
 #endif
 };
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 848d761b2ac7..d6f1c832c209 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -300,6 +300,16 @@ bool mptcp_syn_options(struct sock *sk, unsigned int *=
size,
 		opts->sndr_key =3D subflow->local_key;
 		*size =3D TCPOLEN_MPTCP_MPC_SYN;
 		return true;
+	} else if (subflow->request_join) {
+		pr_debug("token=3D%u, nonce=3D%u", subflow->token,
+			 subflow->local_nonce);
+		opts->suboptions =3D OPTION_MPTCP_MPJ_SYN;
+		opts->join_id =3D subflow->remote_id;
+		opts->token =3D subflow->token;
+		opts->nonce =3D subflow->local_nonce;
+		opts->backup =3D subflow->request_bkup;
+		*size =3D TCPOLEN_MPTCP_MPJ_SYN;
+		return true;
 	}
 	return false;
 }
@@ -309,10 +319,17 @@ void mptcp_rcv_synsent(struct sock *sk)
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct subflow_context *subflow =3D subflow_ctx(sk);
 =

-	pr_debug("subflow=3D%p", subflow);
 	if (subflow->request_mptcp && tp->rx_opt.mptcp.mp_capable) {
 		subflow->mp_capable =3D 1;
 		subflow->remote_key =3D tp->rx_opt.mptcp.sndr_key;
+		pr_debug("subflow=3D%p, remote_key=3D%llu", subflow,
+			 subflow->remote_key);
+	} else if (subflow->request_join && tp->rx_opt.mptcp.mp_join) {
+		subflow->mp_join =3D 1;
+		subflow->thmac =3D tp->rx_opt.mptcp.thmac;
+		subflow->remote_nonce =3D tp->rx_opt.mptcp.nonce;
+		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u", subflow,
+			 subflow->thmac, subflow->remote_nonce);
 	}
 }
 =

@@ -322,7 +339,8 @@ static bool mptcp_established_options_mp(struct sock *s=
k, unsigned int *size,
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
 =

-	if (!subflow->fourth_ack && remaining >=3D TCPOLEN_MPTCP_MPC_ACK) {
+	if (subflow->mp_capable && !subflow->fourth_ack &&
+	    remaining >=3D TCPOLEN_MPTCP_MPC_ACK) {
 		opts->suboptions =3D OPTION_MPTCP_MPC_ACK;
 		opts->sndr_key =3D subflow->local_key;
 		opts->rcvr_key =3D subflow->remote_key;
@@ -331,6 +349,14 @@ static bool mptcp_established_options_mp(struct sock *=
sk, unsigned int *size,
 		pr_debug("subflow=3D%p, local_key=3D%llu, remote_key=3D%llu",
 			 subflow, subflow->local_key, subflow->remote_key);
 		return true;
+	} else if (subflow->mp_join && !subflow->fourth_ack &&
+		   remaining >=3D TCPOLEN_MPTCP_MPJ_ACK) {
+		opts->suboptions =3D OPTION_MPTCP_MPJ_ACK;
+		memcpy(opts->hmac, subflow->hmac, MPTCPOPT_HMAC_LEN);
+		*size =3D TCPOLEN_MPTCP_MPJ_ACK;
+		subflow->fourth_ack =3D 1;
+		pr_debug("subflow=3D%p", subflow);
+		return true;
 	}
 	return false;
 }
@@ -443,10 +469,11 @@ bool mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts)
 {
+	struct subflow_context *subflow =3D subflow_ctx(sk);
 	unsigned int opt_size =3D 0;
 	bool ret =3D false;
 =

-	if (!subflow_ctx(sk)->mp_capable)
+	if (!subflow->mp_capable && !subflow->mp_join)
 		return false;
 =

 	opts->suboptions =3D 0;
@@ -543,7 +570,6 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 =

 	if (msk)
 		pm_fully_established(msk);
-
 }
 =

 void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts)
@@ -592,6 +618,16 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 				      0, opts->addr_id);
 	}
 =

+	if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
+				      TCPOLEN_MPTCP_MPJ_SYN,
+				      opts->backup, opts->join_id);
+		put_unaligned_be32(opts->token, ptr);
+		ptr +=3D 1;
+		put_unaligned_be32(opts->nonce, ptr);
+		ptr +=3D 1;
+	}
+
 	if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
 		*ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
 				      TCPOLEN_MPTCP_MPJ_SYNACK,
@@ -602,6 +638,13 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 		ptr +=3D 1;
 	}
 =

+	if (OPTION_MPTCP_MPJ_ACK & opts->suboptions) {
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
+				      TCPOLEN_MPTCP_MPJ_ACK, 0, 0);
+		memcpy(ptr, opts->hmac, MPTCPOPT_HMAC_LEN);
+		ptr +=3D 5;
+	}
+
 	if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
 		struct mptcp_ext *mpext =3D &opts->ext_copy;
 		u8 len =3D TCPOLEN_MPTCP_DSS_BASE;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4d4a9c3d25c4..67a93ab709f1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -797,6 +797,8 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
 		pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
+		msk->dport =3D ntohs(inet_sk(msk->subflow->sk)->inet_dport);
+		pr_debug("dport=3D%d", msk->dport);
 =

 		pm_new_connection(msk, 0);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2891715a82f0..b40e99ebca52 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -49,8 +49,10 @@
 #define TCPOLEN_MPTCP_ADD_ADDR6		20
 #define TCPOLEN_MPTCP_RM_ADDR		4
 =

+/* MPTCP MP_JOIN flags */
 #define MPTCPOPT_BACKUP		BIT(0)
 #define MPTCPOPT_HMAC_LEN	20
+#define MPTCPOPT_THMAC_LEN	8
 =

 /* MPTCP MP_CAPABLE flags */
 #define MPTCP_VERSION_MASK	(0x0F)
@@ -116,6 +118,7 @@ struct mptcp_sock {
 	u64		write_seq;
 	u64		ack_seq;
 	u32		token;
+	u16		dport;
 	struct list_head conn_list;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct mptcp_pm_data	pm;
@@ -168,7 +171,9 @@ struct subflow_context {
 	u32	ssn_offset;
 	u16	map_data_len;
 	u16	request_mptcp : 1,  /* send MP_CAPABLE */
+		request_join : 1,   /* send MP_JOIN */
 		request_cksum : 1,
+		request_bkup : 1,
 		request_version : 4,
 		mp_capable : 1,     /* remote is MPTCP capable */
 		mp_join : 1,        /* remote is JOINing */
@@ -180,6 +185,7 @@ struct subflow_context {
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
+	u8	hmac[MPTCPOPT_HMAC_LEN];
 	u8	local_id;
 	u8	remote_id;
 =

@@ -203,6 +209,8 @@ mptcp_subflow_tcp_socket(const struct subflow_context *=
subflow)
 }
 =

 void subflow_init(void);
+int subflow_connect(struct sock *sk, struct sockaddr_in *local,
+		    struct sockaddr_in *remote, u8 remote_id);
 int subflow_create_socket(struct sock *sk, struct socket **new_sock);
 =

 extern const struct inet_connection_sock_af_ops ipv4_specific;
@@ -216,10 +224,12 @@ void mptcp_finish_join(struct sock *sk);
 void token_init(void);
 void token_new_request(struct request_sock *req, const struct sk_buff *skb=
);
 int token_join_request(struct request_sock *req, const struct sk_buff *skb=
);
+int token_join_response(struct sock *sk);
 int token_join_valid(struct request_sock *req,
 		     struct tcp_options_received *rx_opt);
 void token_destroy_request(u32 token);
 void token_new_connect(struct sock *sk);
+void token_new_subflow(struct sock *sk);
 void token_new_accept(struct sock *sk);
 int token_new_join(struct sock *sk);
 void token_update_accept(struct sock *sk, struct sock *conn);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 678fca99c23a..a871dbb21a1d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -22,6 +22,9 @@ static int subflow_rebuild_header(struct sock *sk)
 	if (subflow->request_mptcp && !subflow->token) {
 		pr_debug("subflow=3D%p", sk);
 		token_new_connect(sk);
+	} else if (subflow->request_join && !subflow->local_nonce) {
+		pr_debug("subflow=3D%p", sk);
+		token_new_subflow(sk);
 	}
 =

 	return inet_sk_rebuild_header(sk);
@@ -95,7 +98,10 @@ static void subflow_finish_connect(struct sock *sk, cons=
t struct sk_buff *skb)
 =

 	inet_sk_rx_dst_set(sk, skb);
 =

-	if (subflow->conn && !subflow->conn_finished) {
+	if (!subflow->conn)
+		return;
+
+	if (subflow->mp_capable && !subflow->conn_finished) {
 		pr_debug("subflow=3D%p, remote_key=3D%llu", subflow_ctx(sk),
 			 subflow->remote_key);
 		mptcp_finish_connect(subflow->conn, subflow->mp_capable);
@@ -105,6 +111,17 @@ static void subflow_finish_connect(struct sock *sk, co=
nst struct sk_buff *skb)
 			pr_debug("synack seq=3D%u", TCP_SKB_CB(skb)->seq);
 			subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 		}
+	} else if (subflow->mp_join && !subflow->conn_finished) {
+		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u",
+			 subflow_ctx(sk), subflow->thmac,
+			 subflow->remote_nonce);
+		if (token_join_response(sk)) {
+			subflow->mp_join =3D 0;
+			// @@ need to trigger RST
+		} else {
+			mptcp_finish_join(sk);
+			subflow->conn_finished =3D 1;
+		}
 	}
 }
 =

@@ -195,6 +212,50 @@ static void subflow_data_ready(struct sock *sk)
 	}
 }
 =

+int subflow_connect(struct sock *sk, struct sockaddr_in *local,
+		    struct sockaddr_in *remote, u8 remote_id)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct subflow_context *subflow;
+	struct socket *sf;
+	u32 token;
+	int err;
+
+	err =3D subflow_create_socket(sk, &sf);
+	if (err)
+		return err;
+
+	err =3D kernel_bind(sf, (struct sockaddr *)local,
+			  sizeof(struct sockaddr_in));
+	if (err) {
+		pr_debug("bind err=3D%d", err);
+		goto failed;
+	}
+
+	subflow =3D subflow_ctx(sf->sk);
+	subflow->remote_key =3D msk->remote_key;
+	subflow->local_key =3D msk->local_key;
+	crypto_key_sha1(msk->remote_key, &token, NULL);
+	pr_debug("msk=3D%p token=3D%u", msk, token);
+	subflow->token =3D token;
+	subflow->remote_id =3D remote_id;
+	subflow->request_join =3D 1;
+	subflow->request_bkup =3D 1;
+
+	err =3D kernel_connect(sf, (struct sockaddr *)remote,
+			     sizeof(struct sockaddr_in), O_NONBLOCK);
+	if (err && err !=3D -EINPROGRESS) {
+		pr_debug("connect err=3D%d", err);
+		goto failed;
+	}
+
+	return 0;
+
+failed:
+	/* @@ cleanup the socket */
+	return err;
+}
+
 int subflow_create_socket(struct sock *sk, struct socket **new_sock)
 {
 	struct subflow_context *subflow;
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index ef03ef19af98..b31d98ba5c0d 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -93,6 +93,28 @@ static void new_req_join(struct request_sock *req, struc=
t sock *sk,
 		 subflow_req->thmac);
 }
 =

+static int new_rsp_join(struct sock *sk)
+{
+	struct subflow_context *subflow =3D subflow_ctx(sk);
+	u8 hmac[MPTCPOPT_HMAC_LEN];
+	u64 thmac;
+
+	crypto_hmac_sha1(subflow->remote_key, subflow->local_key,
+			 subflow->remote_nonce, subflow->local_nonce,
+			 (u32 *)hmac);
+
+	thmac =3D get_unaligned_be64(hmac);
+	pr_debug("thmac=3D%llu", thmac);
+	if (thmac !=3D subflow->thmac)
+		return -1;
+
+	crypto_hmac_sha1(subflow->local_key, subflow->remote_key,
+			 subflow->local_nonce, subflow->remote_nonce,
+			 (u32 *)subflow->hmac);
+
+	return 0;
+}
+
 static int new_join_valid(struct request_sock *req, struct sock *sk,
 			  struct tcp_options_received *rx_opt)
 {
@@ -210,6 +232,15 @@ int token_join_request(struct request_sock *req, const=
 struct sk_buff *skb)
 	return -1;
 }
 =

+/* validate received truncated hmac and create hmac for third ACK */
+int token_join_response(struct sock *sk)
+{
+	struct subflow_context *subflow =3D subflow_ctx(sk);
+
+	pr_debug("subflow=3D%p, token=3D%u", subflow, subflow->token);
+	return new_rsp_join(sk);
+}
+
 /* validate hmac received in third ACK */
 int token_join_valid(struct request_sock *req,
 		     struct tcp_options_received *rx_opt)
@@ -247,6 +278,16 @@ void token_new_connect(struct sock *sk)
 	spin_unlock_bh(&token_tree_lock);
 }
 =

+/* create nonce for secondary subflow */
+void token_new_subflow(struct sock *sk)
+{
+	struct subflow_context *subflow =3D subflow_ctx(sk);
+
+	pr_debug("subflow=3D%p", subflow);
+
+	get_random_bytes(&subflow->local_nonce, sizeof(u32));
+}
+
 void token_new_accept(struct sock *sk)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
-- =

2.17.2


--===============2966095147188026909==--
