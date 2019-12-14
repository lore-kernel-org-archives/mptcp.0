Content-Type: multipart/mixed; boundary="===============1690786835001920779=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 10/15] mptcp: Implement MPTCP receive path
Date: Fri, 13 Dec 2019 22:04:12 -0800
Message-ID: <20191214060417.2870-11-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191214060417.2870-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3056

--===============1690786835001920779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Parses incoming DSS options and populates outgoing MPTCP ACK
fields. MPTCP fields are parsed from the TCP option header and placed in
an skb extension, allowing the upper MPTCP layer to access MPTCP
options after the skb has gone through the TCP stack.

The subflow implements it's own data_ready() ops, which ensures that
the pending data is in sequence - according to MPTCP seq number -
dropping out-of-seq skbs.  The DATA_READY bit flag is set if this
is the case.  This allows the MPTCP socket layer to determine if more
data is available without having to consult the individual subflows.

It additionally validates the current mapping and propagate EoF events
to the connection socket.

Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Co-developed-by: Peter Krystad <peter.krystad(a)linux.intel.com>
Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
Co-developed-by: Davide Caratti <dcaratti(a)redhat.com>
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Co-developed-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/linux/tcp.h  |  10 ++
 include/net/mptcp.h  |   8 +
 net/ipv4/tcp_input.c |   8 +-
 net/mptcp/options.c  | 111 ++++++++++++
 net/mptcp/protocol.c |  38 ++++
 net/mptcp/protocol.h |  51 +++++-
 net/mptcp/subflow.c  | 405 +++++++++++++++++++++++++++++++++++++++++--
 7 files changed, 614 insertions(+), 17 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index e9ee06d887fa..0d00dad4b85d 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -82,9 +82,19 @@ struct tcp_sack_block {
 struct mptcp_options_received {
 	u64	sndr_key;
 	u64	rcvr_key;
+	u64	data_ack;
+	u64	data_seq;
+	u32	subflow_seq;
+	u16	data_len;
 	u8	mp_capable : 1,
 		mp_join : 1,
 		dss : 1;
+	u8	use_map:1,
+		dsn64:1,
+		data_fin:1,
+		use_ack:1,
+		ack64:1,
+		__unused:3;
 };
 #endif
 =

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6615920d3703..6349c68e380b 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -59,6 +59,8 @@ bool mptcp_synack_options(const struct request_sock *req,=
 unsigned int *size,
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts);
+void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
+			    struct tcp_options_received *opt_rx);
 =

 void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts);
 =

@@ -114,6 +116,12 @@ static inline bool mptcp_established_options(struct so=
ck *sk,
 	return false;
 }
 =

+static inline void mptcp_incoming_options(struct sock *sk,
+					  struct sk_buff *skb,
+					  struct tcp_options_received *opt_rx)
+{
+}
+
 static inline bool mptcp_skb_ext_exist(const struct sk_buff *skb)
 {
 	return false;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 11c22ff1d7cb..d1ab9edfb764 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4766,6 +4766,9 @@ static void tcp_data_queue(struct sock *sk, struct sk=
_buff *skb)
 	bool fragstolen;
 	int eaten;
 =

+	if (sk_is_mptcp(sk))
+		mptcp_incoming_options(sk, skb, &tp->rx_opt);
+
 	if (TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq) {
 		__kfree_skb(skb);
 		return;
@@ -6343,8 +6346,11 @@ int tcp_rcv_state_process(struct sock *sk, struct sk=
_buff *skb)
 	case TCP_CLOSE_WAIT:
 	case TCP_CLOSING:
 	case TCP_LAST_ACK:
-		if (!before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt))
+		if (!before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt)) {
+			if (sk_is_mptcp(sk))
+				mptcp_incoming_options(sk, skb, &tp->rx_opt);
 			break;
+		}
 		/* fall through */
 	case TCP_FIN_WAIT1:
 	case TCP_FIN_WAIT2:
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c9b5f37db63b..669e6ac1d070 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -14,6 +14,7 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 {
 	struct mptcp_options_received *mp_opt =3D &opt_rx->mptcp;
 	u8 subtype =3D *ptr >> 4;
+	int expected_opsize;
 	u8 version;
 	u8 flags;
 =

@@ -97,7 +98,79 @@ void mptcp_parse_option(const unsigned char *ptr, int op=
size,
 	 */
 	case MPTCPOPT_DSS:
 		pr_debug("DSS");
+		ptr++;
+
+		flags =3D (*ptr++) & MPTCP_DSS_FLAG_MASK;
+		mp_opt->data_fin =3D (flags & MPTCP_DSS_DATA_FIN) !=3D 0;
+		mp_opt->dsn64 =3D (flags & MPTCP_DSS_DSN64) !=3D 0;
+		mp_opt->use_map =3D (flags & MPTCP_DSS_HAS_MAP) !=3D 0;
+		mp_opt->ack64 =3D (flags & MPTCP_DSS_ACK64) !=3D 0;
+		mp_opt->use_ack =3D (flags & MPTCP_DSS_HAS_ACK);
+
+		pr_debug("data_fin=3D%d dsn64=3D%d use_map=3D%d ack64=3D%d use_ack=3D%d",
+			 mp_opt->data_fin, mp_opt->dsn64,
+			 mp_opt->use_map, mp_opt->ack64,
+			 mp_opt->use_ack);
+
+		expected_opsize =3D TCPOLEN_MPTCP_DSS_BASE;
+
+		if (mp_opt->use_ack) {
+			if (mp_opt->ack64)
+				expected_opsize +=3D TCPOLEN_MPTCP_DSS_ACK64;
+			else
+				expected_opsize +=3D TCPOLEN_MPTCP_DSS_ACK32;
+		}
+
+		if (mp_opt->use_map) {
+			if (mp_opt->dsn64)
+				expected_opsize +=3D TCPOLEN_MPTCP_DSS_MAP64;
+			else
+				expected_opsize +=3D TCPOLEN_MPTCP_DSS_MAP32;
+		}
+
+		/* RFC 6824, Section 3.3:
+		 * If a checksum is present, but its use had
+		 * not been negotiated in the MP_CAPABLE handshake,
+		 * the checksum field MUST be ignored.
+		 */
+		if (opsize !=3D expected_opsize &&
+		    opsize !=3D expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
+			break;
+
 		mp_opt->dss =3D 1;
+
+		if (mp_opt->use_ack) {
+			if (mp_opt->ack64) {
+				mp_opt->data_ack =3D get_unaligned_be64(ptr);
+				ptr +=3D 8;
+			} else {
+				mp_opt->data_ack =3D get_unaligned_be32(ptr);
+				ptr +=3D 4;
+			}
+
+			pr_debug("data_ack=3D%llu", mp_opt->data_ack);
+		}
+
+		if (mp_opt->use_map) {
+			if (mp_opt->dsn64) {
+				mp_opt->data_seq =3D get_unaligned_be64(ptr);
+				ptr +=3D 8;
+			} else {
+				mp_opt->data_seq =3D get_unaligned_be32(ptr);
+				ptr +=3D 4;
+			}
+
+			mp_opt->subflow_seq =3D get_unaligned_be32(ptr);
+			ptr +=3D 4;
+
+			mp_opt->data_len =3D get_unaligned_be16(ptr);
+			ptr +=3D 2;
+
+			pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u",
+				 mp_opt->data_seq, mp_opt->subflow_seq,
+				 mp_opt->data_len);
+		}
+
 		break;
 =

 	/* MPTCPOPT_ADD_ADDR
@@ -340,6 +413,44 @@ bool mptcp_synack_options(const struct request_sock *r=
eq, unsigned int *size,
 	return false;
 }
 =

+void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
+			    struct tcp_options_received *opt_rx)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct mptcp_options_received *mp_opt;
+	struct mptcp_ext *mpext;
+
+	if (!subflow->mp_capable)
+		return;
+
+	mp_opt =3D &opt_rx->mptcp;
+
+	if (!mp_opt->dss)
+		return;
+
+	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
+	if (!mpext)
+		return;
+
+	memset(mpext, 0, sizeof(*mpext));
+
+	if (mp_opt->use_map) {
+		mpext->data_seq =3D mp_opt->data_seq;
+		mpext->subflow_seq =3D mp_opt->subflow_seq;
+		mpext->data_len =3D mp_opt->data_len;
+		mpext->use_map =3D 1;
+		mpext->dsn64 =3D mp_opt->dsn64;
+	}
+
+	if (mp_opt->use_ack) {
+		mpext->data_ack =3D mp_opt->data_ack;
+		mpext->use_ack =3D 1;
+		mpext->ack64 =3D mp_opt->ack64;
+	}
+
+	mpext->data_fin =3D mp_opt->data_fin;
+}
+
 void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts)
 {
 	if ((OPTION_MPTCP_MPC_SYN |
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ea79091921c0..1ede654057ba 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -225,6 +225,35 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 	return ret;
 }
 =

+int mptcp_read_actor(read_descriptor_t *desc, struct sk_buff *skb,
+		     unsigned int offset, size_t len)
+{
+	struct mptcp_read_arg *arg =3D desc->arg.data;
+	size_t copy_len;
+
+	copy_len =3D min(desc->count, len);
+
+	if (likely(arg->msg)) {
+		int err;
+
+		err =3D skb_copy_datagram_msg(skb, offset, arg->msg, copy_len);
+		if (err) {
+			pr_debug("error path");
+			desc->error =3D err;
+			return err;
+		}
+	} else {
+		pr_debug("Flushing skb payload");
+	}
+
+	// MSG_PEEK support? Other flags? MSG_TRUNC?
+
+	desc->count -=3D copy_len;
+
+	pr_debug("consumed %zu bytes, %zu left", copy_len, desc->count);
+	return copy_len;
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
@@ -412,7 +441,10 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 		msk->write_seq =3D subflow->idsn + 1;
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
+		subflow->map_seq =3D ack_seq;
+		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
+		subflow->tcp_sock =3D ssk;
 		newsk =3D new_mptcp_sock;
 		mptcp_copy_inaddrs(newsk, ssk);
 		list_add(&subflow->node, &msk->conn_list);
@@ -519,8 +551,14 @@ void mptcp_finish_connect(struct sock *ssk)
 	sk =3D subflow->conn;
 	msk =3D mptcp_sk(sk);
 =

+	pr_debug("msk=3D%p, token=3D%u", sk, subflow->token);
+
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
 	ack_seq++;
+	subflow->map_seq =3D ack_seq;
+	subflow->map_subflow_seq =3D 1;
+	subflow->rel_write_seq =3D 1;
+
 	subflow->rel_write_seq =3D 1;
 =

 	/* the socket is not connected yet, no msk/subflow ops can access/race
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5daae10271c3..defa51c0dd44 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -33,7 +33,9 @@
 #define TCPOLEN_MPTCP_MPC_SYNACK	12
 #define TCPOLEN_MPTCP_MPC_ACK		20
 #define TCPOLEN_MPTCP_DSS_BASE		4
+#define TCPOLEN_MPTCP_DSS_ACK32		4
 #define TCPOLEN_MPTCP_DSS_ACK64		8
+#define TCPOLEN_MPTCP_DSS_MAP32		10
 #define TCPOLEN_MPTCP_DSS_MAP64		14
 #define TCPOLEN_MPTCP_DSS_CHECKSUM	2
 =

@@ -50,6 +52,10 @@
 #define MPTCP_DSS_HAS_MAP	BIT(2)
 #define MPTCP_DSS_ACK64		BIT(1)
 #define MPTCP_DSS_HAS_ACK	BIT(0)
+#define MPTCP_DSS_FLAG_MASK	(0x1F)
+
+/* MPTCP socket flags */
+#define MPTCP_DATA_READY	BIT(0)
 =

 /* MPTCP connection sock */
 struct mptcp_sock {
@@ -60,6 +66,7 @@ struct mptcp_sock {
 	u64		write_seq;
 	u64		ack_seq;
 	u32		token;
+	unsigned long	flags;
 	struct list_head conn_list;
 	struct skb_ext	*cached_ext;	/* for the next sendmsg */
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
@@ -82,6 +89,7 @@ struct mptcp_subflow_request_sock {
 	u64	remote_key;
 	u64	idsn;
 	u32	token;
+	u32	ssn_offset;
 };
 =

 static inline struct mptcp_subflow_request_sock *
@@ -96,15 +104,24 @@ struct mptcp_subflow_context {
 	u64	local_key;
 	u64	remote_key;
 	u64	idsn;
+	u64	map_seq;
 	u32	token;
 	u32	rel_write_seq;
+	u32	map_subflow_seq;
+	u32	ssn_offset;
+	u32	map_data_len;
 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
 		mp_capable : 1,	    /* remote is MPTCP capable */
 		fourth_ack : 1,	    /* send initial DSS */
-		conn_finished : 1;
+		conn_finished : 1,
+		map_valid : 1,
+		data_avail : 1,
+		rx_eof : 1;
+
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
 	const	struct inet_connection_sock_af_ops *icsk_af_ops;
+	void	(*tcp_sk_data_ready)(struct sock *sk);
 	struct	rcu_head rcu;
 };
 =

@@ -123,6 +140,22 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_cont=
ext *subflow)
 	return subflow->tcp_sock;
 }
 =

+static inline u64
+mptcp_subflow_get_map_offset(const struct mptcp_subflow_context *subflow)
+{
+	return tcp_sk(mptcp_subflow_tcp_sock(subflow))->copied_seq -
+		      subflow->ssn_offset -
+		      subflow->map_subflow_seq;
+}
+
+static inline u64
+mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow_context *subflow)
+{
+	return subflow->map_seq + mptcp_subflow_get_map_offset(subflow);
+}
+
+int mptcp_is_enabled(struct net *net);
+bool mptcp_subflow_data_available(struct sock *sk);
 void mptcp_subflow_init(void);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
 =

@@ -131,6 +164,15 @@ extern const struct inet_connection_sock_af_ops ipv4_s=
pecific;
 extern const struct inet_connection_sock_af_ops ipv6_specific;
 #endif
 =

+void mptcp_proto_init(void);
+
+struct mptcp_read_arg {
+	struct msghdr *msg;
+};
+
+int mptcp_read_actor(read_descriptor_t *desc, struct sk_buff *skb,
+		     unsigned int offset, size_t len);
+
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx);
 =

@@ -164,4 +206,11 @@ static inline struct mptcp_ext *mptcp_get_ext(struct s=
k_buff *skb)
 	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
 }
 =

+static inline bool before64(__u64 seq1, __u64 seq2)
+{
+	return (__s64)(seq1 - seq2) < 0;
+}
+
+#define after64(seq2, seq1)	before64(seq1, seq2)
+
 #endif /* __MPTCP_PROTOCOL_H */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 35134342fab0..da10b5092d8d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -78,6 +78,7 @@ static void subflow_init_req(struct request_sock *req,
 			subflow_req->mp_capable =3D 1;
 =

 		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
+		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 	}
 }
 =

@@ -116,6 +117,11 @@ static void subflow_finish_connect(struct sock *sk, co=
nst struct sk_buff *skb)
 			 subflow->remote_key);
 		mptcp_finish_connect(sk);
 		subflow->conn_finished =3D 1;
+
+		if (skb) {
+			pr_debug("synack seq=3D%u", TCP_SKB_CB(skb)->seq);
+			subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
+		}
 	}
 }
 =

@@ -140,6 +146,31 @@ static int subflow_v4_conn_request(struct sock *sk, st=
ruct sk_buff *skb)
 	return 0;
 }
 =

+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
+static struct inet_connection_sock_af_ops subflow_v6_specific;
+
+static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+
+	pr_debug("subflow=3D%p", subflow);
+
+	if (skb->protocol =3D=3D htons(ETH_P_IP))
+		return tcp_v4_conn_request(sk, skb);
+
+	if (!ipv6_unicast_destination(skb))
+		goto drop;
+
+	return tcp_conn_request(&subflow_request_sock_ops,
+				&subflow_request_sock_ipv6_ops, sk, skb);
+
+drop:
+	tcp_listendrop(sk);
+	return 0; /* don't send reset */
+}
+#endif
+
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					  struct sk_buff *skb,
 					  struct request_sock *req,
@@ -181,30 +212,324 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
 =

 static struct inet_connection_sock_af_ops subflow_specific;
 =

-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
-static struct inet_connection_sock_af_ops subflow_v6_specific;
+enum mapping_status {
+	MAPPING_OK,
+	MAPPING_INVALID,
+	MAPPING_EMPTY,
+	MAPPING_DATA_FIN
+};
 =

-static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
+static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
+{
+	if ((u32)seq =3D=3D (u32)old_seq)
+		return old_seq;
+
+	/* Assume map covers data not mapped yet. */
+	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63, 32));
+}
+
+static void warn_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
+{
+	WARN_ONCE(1, "Bad mapping: ssn=3D%d map_seq=3D%d map_data_len=3D%d",
+		  ssn, subflow->map_subflow_seq, subflow->map_data_len);
+}
+
+static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	unsigned int skb_consumed;
+
+	skb_consumed =3D tcp_sk(ssk)->copied_seq - TCP_SKB_CB(skb)->seq;
+	if (WARN_ON_ONCE(skb_consumed >=3D skb->len))
+		return true;
+
+	return skb->len - skb_consumed <=3D subflow->map_data_len -
+					  mptcp_subflow_get_map_offset(subflow);
+}
+
+static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	u32 ssn =3D tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
+
+	if (unlikely(before(ssn, subflow->map_subflow_seq))) {
+		/* Mapping covers data later in the subflow stream,
+		 * currently unsupported.
+		 */
+		warn_bad_map(subflow, ssn);
+		return false;
+	}
+	if (unlikely(!before(ssn, subflow->map_subflow_seq +
+				  subflow->map_data_len))) {
+		/* Mapping does covers past subflow data, invalid */
+		warn_bad_map(subflow, ssn + skb->len);
+		return false;
+	}
+	return true;
+}
+
+static enum mapping_status get_mapping_status(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	struct mptcp_ext *mpext;
+	struct sk_buff *skb;
+	u16 data_len;
+	u64 map_seq;
+
+	skb =3D skb_peek(&ssk->sk_receive_queue);
+	if (!skb)
+		return MAPPING_EMPTY;
+
+	mpext =3D mptcp_get_ext(skb);
+	if (!mpext || !mpext->use_map) {
+		if (!subflow->map_valid && !skb->len) {
+			/* the TCP stack deliver 0 len FIN pkt to the receive
+			 * queue, that is the only 0len pkts ever expected here,
+			 * and we can admit no mapping only for 0 len pkts
+			 */
+			if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN))
+				WARN_ONCE(1, "0len seq %d:%d flags %x",
+					  TCP_SKB_CB(skb)->seq,
+					  TCP_SKB_CB(skb)->end_seq,
+					  TCP_SKB_CB(skb)->tcp_flags);
+			sk_eat_skb(ssk, skb);
+			return MAPPING_EMPTY;
+		}
+
+		if (!subflow->map_valid)
+			return MAPPING_INVALID;
+
+		goto validate_seq;
+	}
+
+	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u data_len=3D%u data_fin=3D%d",
+		 mpext->data_seq, mpext->dsn64, mpext->subflow_seq,
+		 mpext->data_len, mpext->data_fin);
+
+	data_len =3D mpext->data_len;
+	if (data_len =3D=3D 0) {
+		pr_err("Infinite mapping not handled");
+		return MAPPING_INVALID;
+	}
+
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
+	}
+
+	if (!mpext->dsn64) {
+		map_seq =3D expand_seq(subflow->map_seq, subflow->map_data_len,
+				     mpext->data_seq);
+		pr_debug("expanded seq=3D%llu", subflow->map_seq);
+	} else {
+		map_seq =3D mpext->data_seq;
+	}
+
+	if (subflow->map_valid) {
+		/* Allow replacing only with an identical map */
+		if (subflow->map_seq =3D=3D map_seq &&
+		    subflow->map_subflow_seq =3D=3D mpext->subflow_seq &&
+		    subflow->map_data_len =3D=3D data_len) {
+			skb_ext_del(skb, SKB_EXT_MPTCP);
+			return MAPPING_OK;
+		}
+
+		/* If this skb data are fully covered by the current mapping,
+		 * the new map would need caching, which is not supported
+		 */
+		if (skb_is_fully_mapped(ssk, skb))
+			return MAPPING_INVALID;
+
+		/* will validate the next map after consuming the current one */
+		return MAPPING_OK;
+	}
+
+	subflow->map_seq =3D map_seq;
+	subflow->map_subflow_seq =3D mpext->subflow_seq;
+	subflow->map_data_len =3D data_len;
+	subflow->map_valid =3D 1;
+	pr_debug("new map seq=3D%llu subflow_seq=3D%u data_len=3D%u",
+		 subflow->map_seq, subflow->map_subflow_seq,
+		 subflow->map_data_len);
+
+validate_seq:
+	/* we revalidate valid mapping on new skb, because we must ensure
+	 * the current skb is completely covered by the available mapping
+	 */
+	if (!validate_mapping(ssk, skb))
+		return MAPPING_INVALID;
+
+	skb_ext_del(skb, SKB_EXT_MPTCP);
+	return MAPPING_OK;
+}
+
+static bool subflow_check_data_avail(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	enum mapping_status status;
+	struct mptcp_sock *msk;
+	struct sk_buff *skb;
+
+	pr_debug("msk=3D%p ssk=3D%p data_avail=3D%d skb=3D%p", subflow->conn, ssk,
+		 subflow->data_avail, skb_peek(&ssk->sk_receive_queue));
+	if (subflow->data_avail)
+		return true;
+
+	if (!subflow->conn)
+		return false;
+
+	msk =3D mptcp_sk(subflow->conn);
+	for (;;) {
+		u32 map_remaining;
+		size_t delta;
+		u64 ack_seq;
+		u64 old_ack;
+
+		status =3D get_mapping_status(ssk);
+		pr_debug("msk=3D%p ssk=3D%p status=3D%d", msk, ssk, status);
+		if (status =3D=3D MAPPING_INVALID) {
+			ssk->sk_err =3D EBADMSG;
+			goto fatal;
+		}
+
+		if (status !=3D MAPPING_OK)
+			return false;
+
+		skb =3D skb_peek(&ssk->sk_receive_queue);
+		if (WARN_ON_ONCE(!skb))
+			return false;
+
+		old_ack =3D READ_ONCE(msk->ack_seq);
+		ack_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
+		pr_debug("msk ack_seq=3D%llx subflow ack_seq=3D%llx", old_ack,
+			 ack_seq);
+		if (ack_seq =3D=3D old_ack)
+			break;
+
+		/* only accept in-sequence mapping. Old values are spurious
+		 * retransmission; we can hit "future" values on active backup
+		 * subflow switch, we relay on retransmissions to get
+		 * in-sequence data.
+		 * Cuncurrent subflows support will require subflow data
+		 * reordering
+		 */
+		map_remaining =3D subflow->map_data_len -
+				mptcp_subflow_get_map_offset(subflow);
+		if (before64(ack_seq, old_ack))
+			delta =3D min_t(size_t, old_ack - ack_seq, map_remaining);
+		else
+			delta =3D min_t(size_t, ack_seq - old_ack, map_remaining);
+
+		/* discard mapped data */
+		pr_debug("discarding %zu bytes, current map len=3D%d", delta,
+			 map_remaining);
+		if (delta) {
+			struct mptcp_read_arg arg =3D {
+				.msg =3D NULL,
+			};
+			read_descriptor_t desc =3D {
+				.count =3D delta,
+				.arg.data =3D &arg,
+			};
+			int ret;
+
+			ret =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
+			if (ret < 0) {
+				ssk->sk_err =3D -ret;
+				goto fatal;
+			}
+			if (ret < delta)
+				return false;
+			if (delta =3D=3D map_remaining)
+				subflow->map_valid =3D 0;
+		}
+	}
+	return true;
+
+fatal:
+	/* fatal protocol error, close the socket */
+	/* This barrier is coupled with smp_rmb() in tcp_poll() */
+	smp_wmb();
+	ssk->sk_error_report(ssk);
+	tcp_set_state(ssk, TCP_CLOSE);
+	tcp_send_active_reset(ssk, GFP_ATOMIC);
+	return false;
+}
+
+bool mptcp_subflow_data_available(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct sk_buff *skb;
 =

-	pr_debug("subflow=3D%p", subflow);
+	/* check if current mapping is still valid */
+	if (subflow->map_valid &&
+	    mptcp_subflow_get_map_offset(subflow) >=3D subflow->map_data_len) {
+		subflow->map_valid =3D 0;
+		subflow->data_avail =3D 0;
 =

-	if (skb->protocol =3D=3D htons(ETH_P_IP))
-		return tcp_v4_conn_request(sk, skb);
+		pr_debug("Done with mapping: seq=3D%u data_len=3D%u",
+			 subflow->map_subflow_seq,
+			 subflow->map_data_len);
+	}
 =

-	if (!ipv6_unicast_destination(skb))
-		goto drop;
+	if (!subflow_check_data_avail(sk)) {
+		subflow->data_avail =3D 0;
+		return false;
+	}
 =

-	return tcp_conn_request(&subflow_request_sock_ops,
-				&subflow_request_sock_ipv6_ops, sk, skb);
+	skb =3D skb_peek(&sk->sk_receive_queue);
+	subflow->data_avail =3D skb &&
+		       before(tcp_sk(sk)->copied_seq, TCP_SKB_CB(skb)->end_seq);
+	return subflow->data_avail;
+}
 =

-drop:
-	tcp_listendrop(sk);
-	return 0; /* don't send reset */
+static void subflow_data_ready(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct sock *parent =3D subflow->conn;
+
+	if (!parent || !subflow->mp_capable) {
+		subflow->tcp_sk_data_ready(sk);
+
+		if (parent)
+			parent->sk_data_ready(parent);
+		return;
+	}
+
+	if (mptcp_subflow_data_available(sk)) {
+		smp_mb__before_atomic();
+		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
+		smp_mb__after_atomic();
+
+		parent->sk_data_ready(parent);
+	}
+}
+
+static void subflow_write_space(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct sock *parent =3D subflow->conn;
+
+	sk_stream_write_space(sk);
+	if (parent && sk_stream_is_writeable(sk)) {
+		sk_stream_write_space(parent);
+	}
 }
-#endif
 =

 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 {
@@ -254,6 +579,49 @@ static struct mptcp_subflow_context *subflow_create_ct=
x(struct sock *sk,
 	return ctx;
 }
 =

+static void __subflow_state_change(struct sock *sk)
+{
+	struct socket_wq *wq;
+
+	rcu_read_lock();
+	wq =3D rcu_dereference(sk->sk_wq);
+	if (skwq_has_sleeper(wq))
+		wake_up_interruptible_all(&wq->wait);
+	rcu_read_unlock();
+}
+
+static bool subflow_is_done(const struct sock *sk)
+{
+	return sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state =3D=3D TCP_CLOSE;
+}
+
+static void subflow_state_change(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct sock *parent =3D READ_ONCE(subflow->conn);
+
+	__subflow_state_change(sk);
+
+	/* as recvmsg() does not acquire the subflow socket for ssk selection
+	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
+	 * the data available machinery here.
+	 */
+	if (parent && subflow->mp_capable && mptcp_subflow_data_available(sk)) {
+		smp_mb__before_atomic();
+		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
+		smp_mb__after_atomic();
+
+		parent->sk_data_ready(parent);
+	}
+
+	if (parent && !(parent->sk_shutdown & RCV_SHUTDOWN) &&
+	    !subflow->rx_eof && subflow_is_done(sk)) {
+		subflow->rx_eof =3D 1;
+		parent->sk_shutdown |=3D RCV_SHUTDOWN;
+		__subflow_state_change(parent);
+	}
+}
+
 static int subflow_ulp_init(struct sock *sk)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
@@ -284,6 +652,10 @@ static int subflow_ulp_init(struct sock *sk)
 	if (sk->sk_family =3D=3D AF_INET6)
 		icsk->icsk_af_ops =3D &subflow_v6_specific;
 #endif
+	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
+	sk->sk_data_ready =3D subflow_data_ready;
+	sk->sk_write_space =3D subflow_write_space;
+	sk->sk_state_change =3D subflow_state_change;
 out:
 	return err;
 }
@@ -317,6 +689,7 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 	new_ctx->conn =3D NULL;
 	new_ctx->conn_finished =3D 1;
 	new_ctx->icsk_af_ops =3D old_ctx->icsk_af_ops;
+	new_ctx->tcp_sk_data_ready =3D old_ctx->tcp_sk_data_ready;
 =

 	if (subflow_req->mp_capable) {
 		new_ctx->mp_capable =3D 1;
@@ -324,6 +697,8 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 		new_ctx->remote_key =3D subflow_req->remote_key;
 		new_ctx->local_key =3D subflow_req->local_key;
 		new_ctx->token =3D subflow_req->token;
+		new_ctx->ssn_offset =3D subflow_req->ssn_offset;
+		new_ctx->idsn =3D subflow_req->idsn;
 	} else {
 		tcp_sk(newsk)->is_mptcp =3D 0;
 	}
-- =

2.24.1

--===============1690786835001920779==--
