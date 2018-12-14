Content-Type: multipart/mixed; boundary="===============8229671066293335035=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v5 16/17] mptcp: Implement MPTCP receive path
Date: Fri, 14 Dec 2018 14:27:14 -0800
Message-ID: <20181214222715.23766-17-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20181214222715.23766-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 917

--===============8229671066293335035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Parses incoming DSS options and populates outgoing MPTCP ACK
fields. Clone incoming skbs containing MPTCP headers and propagate them
to the MMPTCP socket using the error queue. This avoids the need for TCP
coalesce/collapse bypass for MPTCP, although cloning incoming skbs does
prevent some coalescing.

Keeping DSS map handling separate from data reading makes it easier to
add multiple-subflow receiving, since the receive code can determine
which subflow contains relevant data or data that needs to be purged
without touching the subflow data queues.

MPTCP ACK values are now populated from an atomic value stored in the
connection socket rather than carried in the extended control block,
which makes use of the most up-to-date sequence number and allows the
MPTCP ACK to be populated on TCP ACK packets that have no payload.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/linux/tcp.h   |  12 ++
 include/net/mptcp.h   |  42 ++++-
 net/ipv4/tcp_input.c  |   4 +
 net/ipv4/tcp_output.c | 109 ++++++-------
 net/mptcp/options.c   |  97 +++++++++++-
 net/mptcp/protocol.c  | 350 +++++++++++++++++++++++++++++++++++++++---
 net/mptcp/subflow.c   |  29 +++-
 7 files changed, 558 insertions(+), 85 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index b54ab3b5546a..635c4c9d4d8b 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -112,6 +112,18 @@ struct tcp_options_received {
 		u8      flags;
 		u64     sndr_key;
 		u64     rcvr_key;
+		u64	ack;
+		u64	seq;
+		u32	subflow_seq;
+		u16	dll;
+		__sum16	checksum;
+		u8	use_ack:1,
+			ack64:1,
+			use_map:1,
+			dsn64:1,
+			use_checksum:1,
+			data_fin:1,
+			__unused:2;
 	} mptcp;
 =

 };
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 21c4d3c8ec1f..7be51b696baf 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -36,14 +36,14 @@
 /* MPTCP connection sock */
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
-	struct	inet_connection_sock sk;
-	u64	local_key;
-	u64	remote_key;
-	u64	write_seq;
-	u64	ack_seq;
-	u32	token;
-	struct	socket *connection_list; /* @@ needs to be a list */
-	struct	socket *subflow; /* outgoing connect, listener or !mp_capable */
+	struct inet_connection_sock sk;
+	u64		local_key;
+	u64		remote_key;
+	u64		write_seq;
+	atomic64_t	ack_seq;
+	u32		token;
+	struct socket	*connection_list; /* @@ needs to be a list */
+	struct socket	*subflow; /* outgoing connect, listener or !mp_capable */
 };
 =

 static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
@@ -73,16 +73,23 @@ struct subflow_sock {
 	/* tcp_sock must be the first member */
 	struct	tcp_sock sk;
 	u64	local_key;
+	u64	map_seq;
+	u32	map_subflow_seq;
 	u32	token;
 	u64	idsn;
 	u64	remote_key;
 	u32	rel_write_seq;
+	u32	ssn_offset;
+	u16	map_dll;
 	bool	request_mptcp;	// send MP_CAPABLE
 	bool	checksum;
 	bool	version;
 	bool	mp_capable;	// remote is MPTCP capable
 	bool	fourth_ack;	// send initial DSS
+	bool	conn_finished;
+	bool	map_valid;
 	struct	sock *conn;	// parent mptcp_sock
+	void	(*tcp_sk_data_ready)(struct sock *sk);
 };
 =

 static inline struct subflow_sock *subflow_sk(const struct sock *sk)
@@ -90,6 +97,16 @@ static inline struct subflow_sock *subflow_sk(const stru=
ct sock *sk)
 	return (struct subflow_sock *)sk;
 }
 =

+static inline struct subflow_sock *subflow_tp(const struct tcp_sock *tp)
+{
+	return (struct subflow_sock *)tp;
+}
+
+static inline struct sock *sock_sk(const struct subflow_sock *sk)
+{
+	return (struct sock *)sk;
+}
+
 struct subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u8	mp_capable : 1,
@@ -101,6 +118,7 @@ struct subflow_request_sock {
 	u32	token;
 	u64	idsn;
 	u64	remote_key;
+	u32	ssn_offset;
 };
 =

 static inline
@@ -133,6 +151,9 @@ void mptcp_subflow_exit(void);
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *options);
 =

+void mptcp_attach_dss(struct sock *sk, struct sk_buff *skb,
+		      struct tcp_options_received *opt_rx);
+
 static inline bool mptcp_skb_ext_exist(const struct sk_buff *skb)
 {
 	return skb_ext_exist(skb, SKB_EXT_MPTCP);
@@ -193,6 +214,11 @@ static inline unsigned int mptcp_established_options(s=
truct sock *sk,
 	return 0;
 }
 =

+static inline void mptcp_attach_dss(struct sock *sk, struct sk_buff *skb,
+				    struct tcp_options_received *opt_rx)
+{
+}
+
 static inline bool mptcp_skb_ext_exist(const struct sk_buff *skb)
 {
 	return false;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4124c6b96f2b..7214c482ae98 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5663,6 +5663,10 @@ void tcp_rcv_established(struct sock *sk, struct sk_=
buff *skb)
 	/* Process urgent data. */
 	tcp_urg(sk, skb, th);
 =

+	/* Prepare MPTCP sequence data */
+	if (tcp_sk(sk)->is_mptcp)
+		mptcp_attach_dss(sk, skb, &tp->rx_opt);
+
 	/* step 7: process the segment text */
 	tcp_data_queue(sk, skb);
 =

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 1407bc142c92..ecb187874c5a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -418,8 +418,8 @@ static inline bool tcp_urg_mode(const struct tcp_sock *=
tp)
 #define OPTION_MPTCP_MPC_SYN	(1 << 0)
 #define OPTION_MPTCP_MPC_SYNACK	(1 << 1)
 #define OPTION_MPTCP_MPC_ACK	(1 << 2)
-#define OPTION_MPTCP_MPC_DSS_MAP	(1 << 6)
-#define OPTION_MPTCP_MPC_DSS_ACK	(1 << 7)
+#define OPTION_MPTCP_DSS_MAP	(1 << 6)
+#define OPTION_MPTCP_DSS_ACK	(1 << 7)
 =

 struct tcp_out_options {
 	u16 options;		/* bit field of OPTION_* */
@@ -475,19 +475,12 @@ static void mptcp_options_write(__be32 *ptr, struct s=
k_buff *skb,
 =

 	mcb =3D mptcp_skb_priv_cb(skb);
 =

-	if (((OPTION_MPTCP_MPC_DSS_MAP | OPTION_MPTCP_MPC_DSS_ACK) &
-	     opts->suboptions) && mcb) {
-		bool write_ack =3D
-			(OPTION_MPTCP_MPC_DSS_ACK & opts->suboptions) &&
-			mcb && mcb->use_ack;
-		bool write_map =3D
-			(OPTION_MPTCP_MPC_DSS_MAP & opts->suboptions) &&
-			mcb && mcb->use_map;
+	if ((OPTION_MPTCP_DSS_MAP | OPTION_MPTCP_DSS_ACK) & opts->suboptions) {
+		bool write_ack =3D !!(OPTION_MPTCP_DSS_ACK & opts->suboptions);
+		bool write_map =3D ((OPTION_MPTCP_DSS_MAP & opts->suboptions) &&
+				  mcb && mcb->use_map);
 		u8 flags =3D 0;
 		u8 len =3D 4;
-		u8 *p =3D (u8 *)ptr;
-
-		BUG_ON(!write_ack && !write_map);
 =

 		if (write_ack) {
 			len +=3D 8;
@@ -495,6 +488,7 @@ static void mptcp_options_write(__be32 *ptr, struct sk_=
buff *skb,
 		}
 =

 		if (write_map) {
+			pr_debug("Updating DSS length and flags for map");
 			len +=3D 14;
 =

 			if (mcb->use_checksum)
@@ -508,33 +502,45 @@ static void mptcp_options_write(__be32 *ptr, struct s=
k_buff *skb,
 				flags |=3D 0x10;
 		}
 =

-		*p++ =3D 0x1e; // TCP option: Multipath TCP
-		*p++ =3D len;  // length
-		*p++ =3D 0x20; // subtype=3DDSS
-		*p++ =3D flags;
+		*ptr++ =3D htonl((0x1e << 24) |  // TCP option: Multipath TCP
+			       (len  << 16) |  // length
+			       (0x20 <<  8) |  // subtype=3DDSS
+			       (flags));
 =

 		if (write_ack) {
-			*(__be64 *)p =3D cpu_to_be64(mcb->data_ack);
-			p +=3D 8;
+			struct mptcp_sock *msk =3D mptcp_sk(subflow_tp(tp)->conn);
+			u64 ack_seq;
+			__be64 ack;
+
+			if (msk) {
+				ack_seq =3D atomic64_read(&msk->ack_seq);
+			} else {
+				crypto_key_sha1(subflow_tp(tp)->remote_key,
+						NULL, &ack_seq);
+				ack_seq++;
+			}
+
+			pr_debug("ack=3D%llu", ack_seq);
+			ack =3D cpu_to_be64(ack_seq);
+			memcpy((u8 *) ptr, (u8 *) &ack, 8);
+			ptr +=3D 2;
 		}
 =

 		if (write_map) {
-			*(__be64 *)p =3D cpu_to_be64(mcb->data_seq);
-			p +=3D 8;
-
-			*(__be32 *)p =3D htonl(mcb->subflow_seq);
-			p +=3D 4;
+			u16 checksum;
+			__be64 dss;
 =

-			*(__be16 *)p =3D htons(mcb->dll);
-			p +=3D 2;
+			pr_debug("Writing map values");
+			dss =3D cpu_to_be64(mcb->data_seq);
+			memcpy((u8 *) ptr, &dss, 8);
+			ptr +=3D 2;
+			*ptr++ =3D htonl(mcb->subflow_seq);
 =

-			if (mcb->use_checksum) {
-				*(__be16 *)p =3D htons(mcb->checksum);
-				p +=3D 2;
-			} else {
-				*p++ =3D TCPOPT_NOP;
-				*p++ =3D TCPOPT_NOP;
-			}
+			if (mcb->use_checksum)
+				checksum =3D (__force u16) mcb->checksum;
+			else
+				checksum =3D TCPOPT_NOP << 8 | TCPOPT_NOP;
+			*ptr++ =3D htonl(mcb->dll << 16 | checksum);
 		}
 	}
 #endif
@@ -907,7 +913,8 @@ static unsigned int tcp_established_options(struct sock=
 *sk, struct sk_buff *skb
 		} else if (subflow_sk(sk)->mp_capable && skb) {
 			struct mptcp_skb_cb *cb;
 			unsigned int dss_size =3D 0;
-			u16 options =3D 0;
+			unsigned int ack_size =3D 8;
+			u16 suboptions =3D 0;
 =

 			cb =3D mptcp_skb_priv_cb(skb);
 =

@@ -920,34 +927,29 @@ static unsigned int tcp_established_options(struct so=
ck *sk, struct sk_buff *skb
 				if (map_size <=3D remaining) {
 					remaining -=3D map_size;
 					dss_size =3D map_size;
-					opts->options |=3D OPTION_MPTCP;
-					opts->suboptions =3D OPTION_MPTCP_MPC_DSS_MAP;
+					suboptions =3D OPTION_MPTCP_DSS_MAP;
 				} else {
 					WARN(1, "MPTCP: Map dropped");
 				}
 			}
 =

-			if (cb && cb->use_ack) {
-				unsigned int ack_size =3D 8;
-
-				/* Add kind/length/subtype/flag
-				 * overhead if mapping not populated
-				 */
-				if (dss_size =3D=3D 0)
-					ack_size +=3D 4;
+			/* Add kind/length/subtype/flag
+			 * overhead if mapping not populated
+			 */
+			if (dss_size =3D=3D 0)
+				ack_size +=3D 4;
 =

-				if (ack_size <=3D remaining) {
-					dss_size +=3D ack_size;
-					opts->options |=3D OPTION_MPTCP;
-					opts->suboptions |=3D OPTION_MPTCP_MPC_DSS_ACK;
-				} else {
-					WARN(1, "MPTCP: Ack dropped");
-				}
+			if (ack_size <=3D remaining) {
+				dss_size +=3D ack_size;
+				suboptions |=3D OPTION_MPTCP_DSS_ACK;
+			} else {
+				WARN(1, "MPTCP: Ack dropped");
 			}
 =

 			if (dss_size) {
 				size +=3D ALIGN(dss_size, 4);
-				opts->options |=3D options;
+				opts->options |=3D OPTION_MPTCP;
+				opts->suboptions =3D suboptions;
 			}
 		}
 	}
@@ -3852,6 +3854,9 @@ void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
 	skb_set_tcp_pure_ack(buff);
 =

 	/* Send it off, this clears delayed acks for us. */
+	if (tcp_sk(sk)->is_mptcp)
+		pr_debug("mptcp sk=3D%p", sk);
+
 	__tcp_transmit_skb(sk, buff, 0, (__force gfp_t)0, rcv_nxt);
 }
 EXPORT_SYMBOL_GPL(__tcp_send_ack);
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 266a9f7fed0d..ef40b11e84e6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -21,8 +21,8 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 			struct tcp_options_received *opt_rx)
 {
 	u8 subtype;
+	int expected_opsize;
 =

-	opsize -=3D 2;
 	subtype =3D *ptr++;
 =

 	/* MPTCPOPT_MP_CAPABLE
@@ -81,6 +81,68 @@ void mptcp_parse_option(const unsigned char *ptr, int op=
size,
 	case 0x20:
 		pr_debug("DSS");
 		opt_rx->mptcp.dss =3D 1;
+
+		opt_rx->mptcp.flags =3D (*ptr++) & 0x1F;
+		opt_rx->mptcp.data_fin =3D (opt_rx->mptcp.flags & 0x10) !=3D 0;
+		opt_rx->mptcp.dsn64 =3D (opt_rx->mptcp.flags & 0x08) !=3D 0;
+		opt_rx->mptcp.use_map =3D (opt_rx->mptcp.flags & 0x04) !=3D 0;
+		opt_rx->mptcp.ack64 =3D (opt_rx->mptcp.flags & 0x02) !=3D 0;
+		opt_rx->mptcp.use_ack =3D (opt_rx->mptcp.flags & 0x01);
+
+		pr_debug("data_fin=3D%d dsn64=3D%d use_map=3D%d ack64=3D%d use_ack=3D%d",
+			 opt_rx->mptcp.data_fin, opt_rx->mptcp.dsn64,
+			 opt_rx->mptcp.use_map, opt_rx->mptcp.ack64,
+			 opt_rx->mptcp.use_ack);
+
+		expected_opsize =3D 0;
+
+		if (opt_rx->mptcp.use_ack) {
+			expected_opsize =3D 4;
+			if (opt_rx->mptcp.ack64)
+				expected_opsize +=3D 4;
+
+			if (opsize < expected_opsize)
+				break;
+
+			if (opt_rx->mptcp.ack64) {
+				opt_rx->mptcp.ack =3D get_unaligned_be64(ptr);
+				ptr +=3D 8;
+			} else {
+				opt_rx->mptcp.ack =3D get_unaligned_be32(ptr);
+				ptr +=3D 4;
+			}
+
+			pr_debug("ack=3D%llu", opt_rx->mptcp.ack);
+		}
+
+		if (opt_rx->mptcp.use_map) {
+			expected_opsize +=3D 12;
+			if (opt_rx->mptcp.dsn64)
+				expected_opsize +=3D 4;
+
+			if (opsize < expected_opsize)
+				break;
+
+			if (opt_rx->mptcp.dsn64) {
+				opt_rx->mptcp.seq =3D get_unaligned_be64(ptr);
+				ptr +=3D 8;
+			} else {
+				opt_rx->mptcp.seq =3D get_unaligned_be32(ptr);
+				ptr +=3D 4;
+			}
+
+			opt_rx->mptcp.subflow_seq =3D get_unaligned_be32(ptr);
+			ptr +=3D 4;
+
+			opt_rx->mptcp.dll =3D get_unaligned_be16(ptr);
+			ptr +=3D 2;
+
+			opt_rx->mptcp.checksum =3D get_unaligned_be16(ptr);
+
+			pr_debug("seq=3D%llu subflow_seq=3D%u dll=3D%u ck=3D%u",
+				 opt_rx->mptcp.seq, opt_rx->mptcp.subflow_seq,
+				 opt_rx->mptcp.dll, opt_rx->mptcp.checksum);
+		}
 		break;
 =

 	/* MPTCPOPT_ADD_ADDR
@@ -204,3 +266,36 @@ unsigned int mptcp_synack_options(struct request_sock =
*req, u64 *local_key,
 	}
 	return subflow_req->mp_capable;
 }
+
+void mptcp_attach_dss(struct sock *sk, struct sk_buff *skb,
+		      struct tcp_options_received *opt_rx)
+{
+	struct mptcp_skb_cb *mcb;
+
+	if (!opt_rx->mptcp.dss)
+		return;
+
+	mcb =3D skb_ext_add(skb, SKB_EXT_MPTCP);
+	if (!mcb)
+		return;
+
+	memset(mcb, 0, sizeof(*mcb));
+
+	if (opt_rx->mptcp.use_map) {
+		mcb->data_seq =3D opt_rx->mptcp.seq;
+		mcb->subflow_seq =3D opt_rx->mptcp.subflow_seq;
+		mcb->dll =3D opt_rx->mptcp.dll;
+		mcb->checksum =3D opt_rx->mptcp.checksum;
+		mcb->use_map =3D 1;
+		mcb->dsn64 =3D opt_rx->mptcp.dsn64;
+		mcb->use_checksum =3D opt_rx->mptcp.use_checksum;
+	}
+
+	if (opt_rx->mptcp.use_ack) {
+		mcb->data_ack =3D opt_rx->mptcp.ack;
+		mcb->use_ack =3D 1;
+		mcb->ack64 =3D opt_rx->mptcp.ack64;
+	}
+
+	mcb->data_fin =3D opt_rx->mptcp.data_fin;
+}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 48a3155c99a9..55df5fd5f972 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -16,6 +16,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/sched/signal.h>
+#include <linux/atomic.h>
 #include <net/sock.h>
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
@@ -23,6 +25,12 @@
 #include <net/tcp.h>
 #include <net/mptcp.h>
 =

+static inline bool before64(__u64 seq1, __u64 seq2)
+{
+	return (__s64)(seq1-seq2) < 0;
+}
+#define after64(seq2, seq1)	before64(seq1, seq2)
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -93,19 +101,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 =

 	skb =3D tcp_write_queue_tail(ssk);
 =

-	mcb =3D (struct mptcp_skb_cb *)skb_ext_add(skb, SKB_EXT_MPTCP);
+	mcb =3D skb_ext_add(skb, SKB_EXT_MPTCP);
 =

 	if (mcb) {
 		memset(mcb, 0, sizeof(*mcb));
-		mcb->data_ack =3D msk->ack_seq;
 		mcb->data_seq =3D msk->write_seq;
 		mcb->subflow_seq =3D subflow_sk(ssk)->rel_write_seq;
 		mcb->dll =3D ret;
 		mcb->checksum =3D 0xbeef;
 		mcb->use_map =3D 1;
 		mcb->dsn64 =3D 1;
-		mcb->use_ack =3D 1;
-		mcb->ack64 =3D 1;
 =

 		pr_debug("data_seq=3D%llu subflow_seq=3D%u "
 			 "dll=3D%u checksum=3D%u, dsn64=3D%d",
@@ -125,21 +130,306 @@ static int mptcp_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
 	return ret;
 }
 =

+struct mptcp_read_arg {
+	struct msghdr *msg;
+};
+
+static u64 expand_seq(u64 old_seq, u16 old_dll, u64 seq)
+{
+	if ((u32)seq =3D=3D (u32)old_seq)
+		return old_seq;
+
+	/* Assume map covers data not mapped yet. */
+	return seq | ((old_seq + old_dll + 1) & ~0xFFFFFFFFULL);
+}
+
+static u64 get_mapped_dsn(struct subflow_sock *subflow)
+{
+	u32 map_offset =3D (tcp_sk(sock_sk(subflow))->copied_seq -
+			  subflow->ssn_offset -
+			  subflow->map_subflow_seq);
+
+	return subflow->map_seq + map_offset;
+}
+
+static int mptcp_read_actor(read_descriptor_t *desc, struct sk_buff *skb,
+			    unsigned int offset, size_t len)
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
+static int mptcp_flush_actor(read_descriptor_t *desc, struct sk_buff *skb,
+			     unsigned int offset, size_t len)
+{
+	pr_debug("Flushing one skb with %zu of %zu bytes remaining",
+		 len, len + offset);
+
+	desc->count =3D 0;
+
+	return len;
+}
+
+enum mapping_status {
+	MAPPING_ADDED,
+	MAPPING_MISSING,
+	MAPPING_EMPTY,
+	MAPPING_DATA_FIN
+};
+
+static enum mapping_status mptcp_get_mapping(struct sock *ssk)
+{
+	struct subflow_sock *subflow =3D subflow_sk(ssk);
+	struct mptcp_skb_cb *mcb;
+	struct sk_buff *skb;
+
+	skb =3D skb_peek(&ssk->sk_receive_queue);
+	if (!skb) {
+		pr_debug("Empty queue");
+		return MAPPING_EMPTY;
+	}
+
+	mcb =3D mptcp_skb_priv_cb(skb);
+
+	if (!mcb) {
+		/* This is expected for non-DSS data packets */
+		return MAPPING_MISSING;
+	}
+
+	if (!mcb->use_map)
+		return MAPPING_MISSING;
+
+	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u dll=3D%u ck=3D%u",
+		 mcb->data_seq, mcb->dsn64, mcb->subflow_seq, mcb->dll,
+		 mcb->checksum);
+
+	if (mcb->dll =3D=3D 0) {
+		pr_err("Infinite mapping not handled");
+	} else if (mcb->subflow_seq =3D=3D 0 &&
+		   mcb->data_fin =3D=3D 1) {
+		pr_debug("DATA_FIN with no payload");
+		return MAPPING_DATA_FIN;
+	}
+
+	if (subflow->map_valid)
+		pr_warn("Replaced mapping before it was done");
+
+	if (!mcb->dsn64) {
+		subflow->map_seq =3D expand_seq(subflow->map_seq,
+					      subflow->map_dll,
+					      mcb->data_seq);
+		pr_debug("expanded seq=3D%llu", subflow->map_seq);
+	} else {
+		subflow->map_seq =3D mcb->data_seq;
+	}
+
+	subflow->map_subflow_seq =3D mcb->subflow_seq;
+	subflow->map_dll =3D mcb->dll;
+	subflow->map_valid =3D true;
+	pr_debug("new map seq=3D%llu subflow_seq=3D%u dll=3D%u",
+		 subflow->map_seq, subflow->map_subflow_seq,
+		 subflow->map_dll);
+
+	return MAPPING_ADDED;
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *subflow;
+	struct subflow_sock *subflow;
+	struct mptcp_read_arg arg;
+	read_descriptor_t desc;
+	struct tcp_sock *tp;
+	struct sock *ssk;
+	int copied =3D 0;
+	long timeo;
+
+	if (!msk->connection_list) {
+		pr_debug("fallback-read subflow=3D%p", msk->subflow->sk);
+		return sock_recvmsg(msk->subflow, msg, flags);
+	}
+
+	ssk =3D msk->connection_list->sk;
+	subflow =3D subflow_sk(ssk);
+	tp =3D tcp_sk(ssk);
+
+	desc.arg.data =3D &arg;
+	desc.error =3D 0;
+
+	timeo =3D sock_rcvtimeo(sk, nonblock);
+
+	len =3D min_t(size_t, len, INT_MAX);
+
+	while (copied < len) {
+		enum mapping_status status;
+		size_t discard_len =3D 0;
+		int bytes_read;
+		u64 ack_seq;
+		u64 old_ack;
+		u32 ssn;
+
+		status =3D mptcp_get_mapping(ssk);
+
+		if (status =3D=3D MAPPING_ADDED) {
+			/* Common case, but nothing to do here */
+		} else if (status =3D=3D MAPPING_MISSING) {
+			if (!subflow->map_valid) {
+				pr_debug("Mapping missing, trying next skb");
+
+				arg.msg =3D NULL;
+				desc.count =3D SIZE_MAX;
+
+				bytes_read =3D tcp_read_sock(ssk, &desc,
+							   mptcp_flush_actor);
+
+				if (bytes_read < 0)
+					break;
+				else
+					continue;
+			}
+		} else if (status =3D=3D MAPPING_EMPTY) {
+			goto wait_for_data;
+		} else if (status =3D=3D MAPPING_DATA_FIN) {
+			/* TODO: Handle according to RFC 6824 */
+			if (!copied) {
+				pr_err("Can't read after DATA_FIN");
+				copied =3D -ENOTCONN;
+			}
+
+			break;
+		}
+
+		ssn =3D tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
+		old_ack =3D atomic64_read(&msk->ack_seq);
+
+		if (unlikely(before(ssn, subflow->map_subflow_seq))) {
+			/* Mapping covers data later in the subflow stream,
+			 * discard unmapped data. */
+			pr_debug("Mapping covers data later in stream");
+			discard_len =3D subflow->map_subflow_seq - ssn;
+		} else if (unlikely(!before(ssn, (subflow->map_subflow_seq +
+						  subflow->map_dll)))) {
+			/* Mapping ends earlier in the subflow stream.
+			 * Invalidate the mapping and try again.
+			 */
+			subflow->map_valid =3D false;
+			pr_debug("Invalid mapping ssn=3D%d map_seq=3D%d map_dll=3D%d",
+				 ssn, subflow->map_subflow_seq, subflow->map_dll);
+			continue;
+		} else {
+			ack_seq =3D get_mapped_dsn(subflow);
+
+			if (before64(ack_seq, old_ack)) {
+				/* Mapping covers data already received,
+				 * discard data in the current mapping
+				 * and invalidate the map
+				 */
+				u64 map_end_dsn =3D subflow->map_seq +
+					subflow->map_dll;
+				discard_len =3D min(map_end_dsn - ack_seq,
+						  old_ack - ack_seq);
+				subflow->map_valid =3D false;
+				pr_debug("Duplicate MPTCP data found");
+			}
+		}
+
+		if (discard_len) {
+			/* Discard data for the current mapping.
+			 */
+			pr_debug("Discard %zu bytes", discard_len);
+
+			arg.msg =3D NULL;
+			desc.count =3D discard_len;
+
+			bytes_read =3D tcp_read_sock(ssk, &desc,
+						   mptcp_read_actor);
+
+			if (bytes_read < 0)
+				break;
+			else if (bytes_read =3D=3D discard_len)
+				continue;
+			else
+				goto wait_for_data;
+		}
+
+		/* Read mapped data */
+		desc.count =3D ssn - subflow->map_subflow_seq + subflow->map_dll;
+		arg.msg =3D msg;
+		bytes_read =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
+		if (bytes_read < 0)
+			break;
+
+		/* Refresh current MPTCP sequence number based on subflow seq */
+		ack_seq =3D get_mapped_dsn(subflow);
+
+		if (before64(old_ack, ack_seq)) {
+			atomic64_set(&msk->ack_seq, ack_seq);
+		}
+
+		if (!before(tcp_sk(ssk)->copied_seq - subflow->ssn_offset,
+			    subflow->map_subflow_seq + subflow->map_dll)) {
+			subflow->map_valid =3D false;
+			pr_debug("Done with mapping: seq=3D%u dll=3D%u",
+				 subflow->map_subflow_seq, subflow->map_dll);
+		}
+
+		copied +=3D bytes_read;
+
+wait_for_data:
+		if (copied)
+			break;
+
+		if (tp->urg_data && tp->urg_seq =3D=3D tp->copied_seq) {
+			pr_err("Urgent data present, cannot proceed");
+			break;
+		}
+
+		if (ssk->sk_err || ssk->sk_state =3D=3D TCP_CLOSE ||
+		    (ssk->sk_shutdown & RCV_SHUTDOWN) || !timeo ||
+		    signal_pending(current)) {
+			pr_debug("nonblock or error");
+			break;
+		}
+
+		/* Handle blocking and retry read if needed.
+		 *
+		 * Wait on MPTCP sock, the subflow will notify via data ready.
+		 */
+
+		pr_debug("block");
+		release_sock(ssk);
+		sk_wait_data(sk, &timeo, NULL);
+		lock_sock(ssk);
 =

-	if (msk->connection_list) {
-		subflow =3D msk->connection_list;
-		pr_debug("conn_list->subflow=3D%p", subflow->sk);
-	} else {
-		subflow =3D msk->subflow;
-		pr_debug("subflow=3D%p", subflow->sk);
 	}
 =

-	return sock_recvmsg(subflow, msg, flags);
+	release_sock(ssk);
+	release_sock(sk);
+
+	return copied;
 }
 =

 static int mptcp_init_sock(struct sock *sk)
@@ -195,18 +485,27 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 	subflow->conn =3D mp->sk;
 =

 	if (subflow->mp_capable) {
+		u64 ack_seq;
+
+		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
+		pr_debug("token=3D%u", msk->token);
 		token_update_accept(new_sock->sk, mp->sk);
+		msk->connection_list =3D new_sock;
+
+		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
+		ack_seq++;
+		atomic64_set(&msk->ack_seq, ack_seq);
+		subflow->map_seq =3D ack_seq;
+		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
-		msk->remote_key =3D subflow->remote_key;
-		crypto_key_sha1(msk->remote_key, NULL, &msk->ack_seq);
-		msk->ack_seq++;
-		msk->connection_list =3D new_sock;
+		subflow->conn =3D mp->sk;
 	} else {
 		msk->subflow =3D new_sock;
 	}
+	inet_sk_state_store(sk, TCP_ESTABLISHED);
 =

 	return mp->sk;
 }
@@ -284,17 +583,24 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
able)
 	pr_debug("msk=3D%p", msk);
 =

 	if (mp_capable) {
+		u64 ack_seq;
+
+		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
-		msk->write_seq =3D subflow->idsn + 1;
-		subflow->rel_write_seq =3D 1;
-		msk->remote_key =3D subflow->remote_key;
-		crypto_key_sha1(msk->remote_key, NULL, &msk->ack_seq);
-		msk->ack_seq++;
+		pr_debug("token=3D%u", msk->token);
 		msk->connection_list =3D msk->subflow;
 		msk->subflow =3D NULL;
+
+		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
+		msk->write_seq =3D subflow->idsn + 1;
+		ack_seq++;
+		atomic64_set(&msk->ack_seq, ack_seq);
+		subflow->map_seq =3D ack_seq;
+		subflow->map_subflow_seq =3D 1;
+		subflow->rel_write_seq =3D 1;
 	}
-	sk->sk_state =3D TCP_ESTABLISHED;
+	inet_sk_state_store(sk, TCP_ESTABLISHED);
 }
 =

 static int subflow_create(struct sock *sock)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e0b4aa8fe51d..3c9dca4be26a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -107,6 +107,8 @@ static void subflow_v4_init_req(struct request_sock *re=
q,
 		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
 		pr_debug("remote_key=3D%llu", subflow_req->remote_key);
 		token_new_request(req, skb);
+		pr_debug("syn seq=3D%u", TCP_SKB_CB(skb)->seq);
+		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 	} else {
 		subflow_req->mp_capable =3D 0;
 	}
@@ -120,10 +122,15 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 =

 	pr_debug("subflow=3D%p", subflow);
 =

-	if (subflow->conn) {
+	if (!subflow->conn_finished) {
 		pr_debug("remote_key=3D%llu", subflow->remote_key);
 		mptcp_finish_connect(subflow->conn, subflow->mp_capable);
-		subflow->conn =3D NULL;
+		subflow->conn_finished =3D 1;
+
+		if (skb) {
+			pr_debug("synack seq=3D%u", TCP_SKB_CB(skb)->seq);
+			subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
+		}
 	}
 }
 =

@@ -172,7 +179,9 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			subflow->fourth_ack =3D 1;
 			subflow->remote_key =3D subflow_req->remote_key;
 			subflow->local_key =3D subflow_req->local_key;
+			subflow->ssn_offset =3D subflow_req->ssn_offset;
 			subflow->token =3D subflow_req->token;
+			subflow->idsn =3D subflow_req->idsn;
 			pr_debug("token=3D%u", subflow->token);
 			token_new_accept(child);
 		} else {
@@ -202,6 +211,20 @@ const struct inet_connection_sock_af_ops subflow_speci=
fic =3D {
 	.mtu_reduced	   =3D tcp_v4_mtu_reduced,
 };
 =

+static void subflow_data_ready(struct sock *sk)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+	struct sock *parent =3D subflow->conn;
+
+	pr_debug("sk=3D%p", sk);
+	subflow->tcp_sk_data_ready(sk);
+
+	if (parent) {
+		pr_debug("parent=3D%p", parent);
+		parent->sk_data_ready(parent);
+	}
+}
+
 static int subflow_init_sock(struct sock *sk)
 {
 	struct subflow_sock *subflow =3D subflow_sk(sk);
@@ -215,6 +238,8 @@ static int subflow_init_sock(struct sock *sk)
 	if (!err) { // @@ AND mptcp is enabled
 		tsk->is_mptcp =3D 1;
 		icsk->icsk_af_ops =3D &subflow_specific;
+		subflow->tcp_sk_data_ready =3D sk->sk_data_ready;
+		sk->sk_data_ready =3D subflow_data_ready;
 	}
 =

 	return err;
-- =

2.20.0


--===============8229671066293335035==--
