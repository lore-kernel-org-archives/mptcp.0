Content-Type: multipart/mixed; boundary="===============0009521304791111019=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v2 19/19] mptcp: Implement MPTCP receive path
Date: Tue, 05 Jun 2018 16:40:38 -0700
Message-ID: <20180605234038.28497-20-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180605234038.28497-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 662

--===============0009521304791111019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Parses incoming DSS options and populates outgoing MPTCP ACK
fields. Incoming packets are read from the recieve buffer with
tcp_read_sock() to allow access to skb fields and packet headers, and to
only copy the data payload when it's the correct placement in the data
stream.

MPTCP ACK values are now populated from an atomic value stored in the
connection socket rather than carried in the extended control block,
which makes use of the most up-to-date sequence number and allows the
MPTCP ACK to be populated on TCP ACK packets that have no payload.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/linux/tcp.h   |  12 ++
 include/net/mptcp.h   |  37 ++++--
 net/ipv4/tcp_output.c |  81 +++++++-----
 net/mptcp/options.c   |  58 ++++++++-
 net/mptcp/protocol.c  | 291 +++++++++++++++++++++++++++++++++++++-----
 net/mptcp/subflow.c   |  26 +++-
 6 files changed, 422 insertions(+), 83 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 17ecbebf129d..958211b8f26f 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -112,6 +112,18 @@ struct tcp_options_received {
 	u8      flags;
 	u64     sndr_key;
 	u64     rcvr_key;
+	u64	ack;
+	u64	seq;
+	u32	subflow_seq;
+	u16	dll;
+	u16	checksum;
+	u8	use_ack:1,
+		ack64:1,
+		use_map:1,
+		dsn64:1,
+		use_checksum:1,
+		data_fin:1,
+		__unused:2;
 	} mptcp;
 =

 };
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 284a437d4e95..5bd8b797568e 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -38,14 +38,14 @@
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
@@ -55,18 +55,15 @@ static inline struct mptcp_sock *mptcp_sk(const struct =
sock *sk)
 =

 /* MPTCP sk_buff extended control buffer */
 struct mptcp_skb_ext_cb {
-	u64	data_ack;
 	u64	data_seq;
 	u32	subflow_seq;
-	u16	data_level_len;
+	u16	dll;
 	__sum16	checksum;
-	u8	use_ack:1,
-		ack64:1,
-		use_map:1,
+	u8	use_map:1,
 		dsn64:1,
 		use_checksum:1,
 		data_fin:1,
-		__unused:2;
+		__unused:4;
 };
 =

 static inline struct mptcp_skb_ext_cb *mptcp_skb_ecb(struct sk_buff *skb)
@@ -79,16 +76,22 @@ struct subflow_sock {
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
 	struct	sock *conn;     // parent mptcp_sock
+	void    (*tcp_sk_data_ready)(struct sock *sk);
 };
 =

 static inline struct subflow_sock *subflow_sk(const struct sock *sk)
@@ -96,6 +99,11 @@ static inline struct subflow_sock *subflow_sk(const stru=
ct sock *sk)
 	return (struct subflow_sock *)sk;
 }
 =

+static inline struct subflow_sock *subflow_tp(const struct tcp_sock *tp)
+{
+	return (struct subflow_sock *)tp;
+}
+
 struct subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u8	mp_capable : 1,
@@ -107,6 +115,7 @@ struct subflow_request_sock {
 	u32	token;
 	u64	idsn;
 	u64	remote_key;
+	u32	ssn_offset;
 };
 =

 static inline
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 524233f25c35..2632c0a804dc 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -435,7 +435,9 @@ struct tcp_out_options {
 	u64 rcvr_key;
 };
 =

-static void mptcp_options_write(__be32 *ptr, struct sk_buff *skb, struct t=
cp_out_options *opts)
+static void mptcp_options_write(__be32 *ptr, struct sk_buff *skb,
+				struct tcp_sock *tp,
+				struct tcp_out_options *opts)
 {
 	if (!(OPTION_MPTCP & opts->options))
 		return;
@@ -462,34 +464,31 @@ static void mptcp_options_write(__be32 *ptr, struct s=
k_buff *skb, struct tcp_out
 		}
 	}
 =

-	if ((OPTION_MPTCP_DSS_MAP |
-	     OPTION_MPTCP_DSS_ACK) & opts->suboptions) {
-		struct mptcp_skb_ext_cb *ecb =3D mptcp_skb_ecb(skb);
-		bool write_ack =3D (OPTION_MPTCP_DSS_ACK & opts->suboptions) && ecb->use=
_ack;
-		bool write_map =3D (OPTION_MPTCP_DSS_MAP & opts->suboptions) && ecb->use=
_map;
+	if ((OPTION_MPTCP_DSS_MAP | OPTION_MPTCP_DSS_ACK) & opts->suboptions) {
+		bool write_ack =3D !!(OPTION_MPTCP_DSS_ACK & opts->suboptions);
+		bool write_map =3D (OPTION_MPTCP_DSS_MAP & opts->suboptions) &&
+			skb_shinfo(skb)->is_ext && mptcp_skb_ecb(skb)->use_map;
 		u8 flags =3D 0;
 		u8 len =3D 4;
 		u8 *p =3D (u8 *)ptr;
 =

-		BUG_ON(!skb_shinfo(skb)->is_ext);
-		BUG_ON(!write_ack && !write_map);
-
 		if (write_ack) {
 			len +=3D 8;
 			flags =3D 0x03;
 		}
 =

 		if (write_map) {
+			pr_debug("Updating DSS length and flags for map");
 			len +=3D 14;
 =

-			if (ecb->use_checksum)
+			if (mptcp_skb_ecb(skb)->use_checksum)
 				len +=3D 2;
 =

 			/* Use only 64-bit mapping flags for now, add
 			 * support for optional 32-bit mappings later.
 			 */
 			flags |=3D 0x0c;
-			if (ecb->data_fin)
+			if (mptcp_skb_ecb(skb)->data_fin)
 				flags |=3D 0x10;
 		}
 =

@@ -499,18 +498,33 @@ static void mptcp_options_write(__be32 *ptr, struct s=
k_buff *skb, struct tcp_out
 		*p++ =3D flags;
 =

 		if (write_ack) {
-			*(__be64 *)p =3D cpu_to_be64(ecb->data_ack);
+			struct mptcp_sock *msk =3D mptcp_sk(subflow_tp(tp)->conn);
+			u64 ack_seq;
+
+			if (msk) {
+				ack_seq =3D atomic64_read(&msk->ack_seq);
+			} else {
+				crypto_key_sha1(subflow_tp(tp)->remote_key,
+						NULL, &ack_seq);
+				ack_seq++;
+			}
+
+			*(__be64 *)p =3D cpu_to_be64(ack_seq);
+			pr_debug("ack=3D%llu", be64_to_cpu(*(__be64 *)p));
 			p +=3D 8;
 		}
 =

 		if (write_map) {
+			struct mptcp_skb_ext_cb *ecb =3D mptcp_skb_ecb(skb);
+
+			pr_debug("Writing map values");
 			*(__be64 *)p =3D cpu_to_be64(ecb->data_seq);
 			p +=3D 8;
 =

 			*(__be32 *)p =3D htonl(ecb->subflow_seq);
 			p +=3D 4;
 =

-			*(__be16 *)p =3D htons(ecb->data_level_len);
+			*(__be16 *)p =3D htons(ecb->dll);
 			p +=3D 2;
 =

 			if (ecb->use_checksum) {
@@ -648,7 +662,7 @@ static void tcp_options_write(__be32 *ptr, struct sk_bu=
ff *skb,
 =

 	smc_options_write(ptr, &options);
 =

-	mptcp_options_write(ptr, skb, opts);
+	mptcp_options_write(ptr, skb, tp, opts);
 }
 =

 static void smc_set_option(const struct tcp_sock *tp,
@@ -891,17 +905,16 @@ static unsigned int tcp_established_options(struct so=
ck *sk, struct sk_buff *skb
 				}
 				subflow->fourth_ack =3D 1;
 				// @@ also this is where first DSS goes in?
-			} else if (skb && skb_shinfo(skb)->is_ext) {
-				struct mptcp_skb_ext_cb *ecb;
+			} else if (skb) {
 				unsigned int dss_size =3D 0;
+				unsigned int ack_size =3D 8;
 				u16 suboptions =3D 0;
 =

-				ecb =3D mptcp_skb_ecb(skb);
-
-				if (ecb->use_map) {
+				if (skb_shinfo(skb)->is_ext &&
+				    mptcp_skb_ecb(skb)->use_map) {
 					unsigned int map_size =3D 18;
 =

-					if (ecb->use_checksum)
+					if (mptcp_skb_ecb(skb)->use_checksum)
 						map_size +=3D 2;
 =

 					if (map_size <=3D remaining) {
@@ -913,21 +926,17 @@ static unsigned int tcp_established_options(struct so=
ck *sk, struct sk_buff *skb
 					}
 				}
 =

-				if (ecb->use_ack) {
-					unsigned int ack_size =3D 8;
-
-					/* Add kind/length/subtype/flag
-					 * overhead if mapping not populated
-					 */
-					if (dss_size =3D=3D 0)
-						ack_size +=3D 4;
-
-					if (ack_size <=3D remaining) {
-						dss_size +=3D ack_size;
-						suboptions |=3D OPTION_MPTCP_DSS_ACK;
-					} else {
-						WARN(1, "MPTCP: Ack dropped");
-					}
+				/* Add kind/length/subtype/flag
+				 * overhead if mapping not populated
+				 */
+				if (dss_size =3D=3D 0)
+					ack_size +=3D 4;
+
+				if (ack_size <=3D remaining) {
+					dss_size +=3D ack_size;
+					suboptions |=3D OPTION_MPTCP_DSS_ACK;
+				} else {
+					WARN(1, "MPTCP: Ack dropped");
 				}
 =

 				if (dss_size) {
@@ -3802,6 +3811,8 @@ void tcp_send_ack(struct sock *sk)
 	skb_set_tcp_pure_ack(buff);
 =

 	/* Send it off, this clears delayed acks for us. */
+	if (tcp_sk(sk)->is_mptcp)
+		pr_debug("mptcp sk=3D%p", sk);
 	tcp_transmit_skb(sk, buff, 0, (__force gfp_t)0);
 }
 EXPORT_SYMBOL_GPL(tcp_send_ack);
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2ef7ba20b33b..89f59d412549 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -14,6 +14,7 @@
  */
 =

 #include <linux/kernel.h>
+#include <linux/unaligned/be_byteshift.h>
 #include <net/tcp.h>
 #include <net/mptcp.h>
 =

@@ -22,8 +23,8 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 {
 	u8 subtype;
 	u64 *p;
+	int expected_opsize;
 =

-	opsize -=3D 2;
 	subtype =3D *ptr++;
 =

 	/* MPTCPOPT_MP_CAPABLE
@@ -42,7 +43,7 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 		p =3D (u64 *)ptr;
 		pr_debug("sndr_key=3D%llu", *p);
 		opt_rx->mptcp.sndr_key =3D *p++;
-		if (opsize > 10) {
+		if (opsize > TCPOLEN_MPTCP_MPC_SYN) {
 			pr_debug("rcvr_key=3D%llu", *p);
 			opt_rx->mptcp.rcvr_key =3D *p++;
 		}
@@ -80,6 +81,59 @@ void mptcp_parse_option(const unsigned char *ptr, int op=
size,
 	 */
 	case 0x20:
 		pr_debug("DSS");
+		opt_rx->mptcp.dss =3D 1;
+
+		opt_rx->mptcp.flags =3D (*ptr++) & 0x1F;
+		opt_rx->mptcp.data_fin =3D (opt_rx->mptcp.flags & 0x10) !=3D 0;
+		opt_rx->mptcp.dsn64 =3D (opt_rx->mptcp.flags & 0x08) !=3D 0;
+		opt_rx->mptcp.use_map =3D (opt_rx->mptcp.flags & 0x04) !=3D 0;
+		opt_rx->mptcp.ack64 =3D (opt_rx->mptcp.flags & 0x02) !=3D 0;
+		opt_rx->mptcp.use_ack =3D (opt_rx->mptcp.flags & 0x01);
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
+		}
+
 		opt_rx->mptcp.dss =3D 1;
 		break;
 =

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6125d8bbca63..932732622304 100644
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
+        return (__s64)(seq1-seq2) < 0;
+}
+#define after64(seq2, seq1) 	before64(seq1, seq2)
+
 static int mptcp_connect(struct sock *sk, struct sockaddr *saddr, int len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -33,6 +41,8 @@ static int mptcp_connect(struct sock *sk, struct sockaddr=
 *saddr, int len)
 =

 	pr_debug("msk=3D%p, subflow=3D%p", msk, msk->subflow->sk);
 =

+	subflow->conn =3D sk;
+
 	err =3D kernel_connect(msk->subflow, saddr, len, 0);
 	pr_debug("mp_capable=3D%d", subflow->mp_capable);
 	if (!err) {
@@ -144,7 +154,7 @@ static ssize_t do_mptcp_sendpage_dss(struct sock *sk, s=
truct page *page,
 		 * compose a mapping for that much data.
 		 * Alternative 2: one mapping per page?
 		 */
-		if (!sk_wmem_schedule(sk, ecb->data_level_len))
+		if (!sk_wmem_schedule(sk, ecb->dll))
 			goto wait_for_memory;
 =

 		skb =3D mptcp_alloc_skb(sk, size, sk->sk_allocation);
@@ -254,22 +264,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =

 	ecb.data_seq =3D msk->write_seq;
 	ecb.subflow_seq =3D subflow_sk(ssk)->rel_write_seq;
-	ecb.data_level_len =3D msgsize;
+	ecb.dll =3D msgsize;
 	ecb.checksum =3D 0xbeef;
 	ecb.use_map =3D 1;
 	ecb.dsn64 =3D 1;
-	ecb.data_ack =3D msk->ack_seq;
-	ecb.ack64 =3D 1;
-	ecb.use_ack =3D 1;
 =

-	if (ecb.use_ack)
-		pr_debug("data_ack=3D%llu ack64=3D%d", ecb.data_ack,
-			 ecb.ack64);
 	if (ecb.use_map)
 		pr_debug("data_seq=3D%llu subflow_seq=3D%u "
-			 "data_level_len=3D%u checksum=3D%u, dsn64=3D%d",
+			 "dll=3D%u checksum=3D%u, dsn64=3D%d",
 			 ecb.data_seq, ecb.subflow_seq,
-			 ecb.data_level_len, ecb.checksum,
+			 ecb.dll, ecb.checksum,
 			 ecb.dsn64);
 =

 	msk->write_seq +=3D msgsize;
@@ -314,21 +318,229 @@ static int mptcp_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
 	return sent;
 }
 =

+struct mptcp_read_arg {
+	struct mptcp_sock *msk;
+	struct sk_buff *last;
+	struct msghdr *msg;
+	size_t left;
+	int copied;
+	int flags;
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
+static u64 ssn_to_dsn(struct subflow_sock *subsk, u32 ssn)
+{
+	u32 offset =3D ssn - subsk->map_subflow_seq;
+	return subsk->map_seq + offset;
+}
+
+static int mptcp_read_actor(read_descriptor_t *desc, struct sk_buff *skb,
+			    unsigned int offset, size_t len)
+{
+	struct mptcp_read_arg *arg =3D desc->arg.data;
+	struct subflow_sock *subsk =3D subflow_sk(arg->msk->connection_list->sk);
+	struct tcp_options_received opt =3D { 0 };
+	size_t copy_len =3D 0;
+	int consumed =3D 0;
+	u64 ack_seq;
+	u64 old_ack;
+	u32 map_end;
+	u32 ssn;
+	int err;
+
+	pr_debug("skb=3D%p hdr_set=3D%d th=3D%p offset=3D%u len=3D%lu", skb,
+		 skb_transport_header_was_set(skb),
+		 skb_transport_header(skb), offset, len);
+
+	arg->last =3D skb;
+
+	/* Only get options if this skb has not been read from before */
+	if (offset =3D=3D 0)
+		mptcp_get_options(skb, &opt);
+
+	if (opt.mptcp.dss) {
+		if (opt.mptcp.use_ack) {
+			pr_debug("ack=3D%llu is64=3D%d", opt.mptcp.ack,
+				 opt.mptcp.ack64);
+		}
+
+		if (opt.mptcp.use_map) {
+			pr_debug("seq=3D%llu is64=3D%d ssn=3D%u dll=3D%u ck=3D%u",
+				 opt.mptcp.seq, opt.mptcp.dsn64,
+				 opt.mptcp.subflow_seq,
+				 opt.mptcp.dll, opt.mptcp.checksum);
+
+			if (opt.mptcp.dll =3D=3D 0)
+				pr_err("Infinite mapping not handled");
+
+			if (!opt.mptcp.dsn64) {
+				subsk->map_seq =3D expand_seq(subsk->map_seq,
+							    subsk->map_dll,
+							    opt.mptcp.seq);
+				pr_debug("expanded seq=3D%llu", subsk->map_seq);
+			} else {
+				subsk->map_seq =3D opt.mptcp.seq;
+			}
+
+			subsk->map_subflow_seq =3D opt.mptcp.subflow_seq;
+			subsk->map_dll =3D opt.mptcp.dll;
+			pr_debug("map seq=3D%llu subflow_seq=3D%u dll=3D%u",
+				 subsk->map_seq, subsk->map_subflow_seq,
+				 subsk->map_dll);
+		}
+	}
+
+	copy_len =3D len;
+	ssn =3D TCP_SKB_CB(skb)->seq + offset - subsk->ssn_offset;
+	=

+	if (before(ssn, subsk->map_subflow_seq)) {
+		u32 adjust =3D min_t(u32, subsk->map_subflow_seq - ssn, len);
+		ssn +=3D adjust;
+		offset +=3D adjust;
+		consumed +=3D adjust;
+		len -=3D adjust;
+	}
+
+	if (!len)
+		return consumed;
+
+	copy_len =3D min(arg->left, len);
+	map_end =3D subsk->map_subflow_seq + subsk->map_dll;
+	if (after(ssn + copy_len, map_end))
+		copy_len =3D map_end - ssn;
+
+	ack_seq =3D ssn_to_dsn(subsk, ssn + copy_len);
+	old_ack =3D atomic64_read(&arg->msk->ack_seq);
+	if (before64(ack_seq, old_ack) ||
+	    before64(ssn_to_dsn(subsk, ssn), old_ack)) {
+		/* Already received some or all of the mapped data */
+		return consumed + copy_len;
+	}
+
+	err =3D skb_copy_datagram_msg(skb, offset, arg->msg, copy_len);
+
+	if (err < 0) {
+		pr_debug("error path");
+		desc->error =3D err;
+		desc->count =3D 0;
+		return err;
+	}
+
+	consumed +=3D copy_len;
+	arg->copied +=3D copy_len;
+
+	// MSG_PEEK support? Other flags? MSG_TRUNC?
+
+	do {
+		if (!before64(old_ack, ack_seq)) {
+			pr_debug("skipping ack update");
+			break;
+		}
+		pr_debug("old_ack=3D%llu new_ack=3D%llu", old_ack, ack_seq);
+	} while (!atomic64_try_cmpxchg(&arg->msk->ack_seq, &old_ack, ack_seq));
+
+	arg->left -=3D len;
+	if (!arg->left)
+		desc->count =3D 0;
+
+	pr_debug("consumed=3D%u", consumed);
+	return consumed;
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *subflow;
+	read_descriptor_t desc;
+	struct mptcp_read_arg arg;
+	struct tcp_sock *tp;
+	struct sock *ssk;
+	long timeo;
+	int chunk;
 =

-	if (msk->connection_list) {
-		subflow =3D msk->connection_list;
-		pr_debug("conn_list->subflow=3D%p", subflow->sk);
-	} else {
-		subflow =3D msk->subflow;
-		pr_debug("subflow=3D%p", subflow->sk);
+	if (!msk->connection_list) {
+		pr_debug("fallback-read subflow=3D%p", msk->subflow->sk);
+		return sock_recvmsg(msk->subflow, msg, flags);
+	}
+
+	ssk =3D msk->connection_list->sk;
+	tp =3D tcp_sk(ssk);
+	arg.msk =3D msk;
+	arg.msg =3D msg;
+	arg.left =3D len;
+	arg.last =3D NULL;
+	arg.copied =3D 0;
+	arg.flags =3D flags;
+	desc.arg.data =3D &arg;
+	desc.error =3D 0;
+	desc.count =3D 1;
+
+	pr_debug("conn_list->subflow=3D%p", ssk);
+	lock_sock(sk);
+	lock_sock(ssk);
+
+	timeo =3D sock_rcvtimeo(sk, nonblock);
+
+	while (arg.copied < len) {
+		chunk =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
+		pr_debug("chunk=3D%d", chunk);
+
+		/* Let desc.error take precedence over an error returned
+		 * by tcp_read_sock() unless the actor was never called,
+		 * in which case desc.error is still 0.
+		 */
+		if (!desc.error && chunk < 0)
+			desc.error =3D chunk;
+
+		if (desc.error) {
+			/* If data was copied, let the caller know how
+			 * much was copied before the error
+			 */
+			if (!arg.copied)
+				arg.copied =3D desc.error;
+			pr_debug("desc.error=3D%d", desc.error);
+			break;
+		}
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
+		if (arg.copied)
+			break;
+
+		/* Handle blocking and retry read if needed.
+		 *
+		 * Wait on MPTCP sock, the subflow will notify via data ready.
+		 */
+
+		pr_debug("block");
+		release_sock(sk);
+		sk_wait_data(ssk, &timeo, arg.last);
+		lock_sock(sk);
 	}
 =

-	return sock_recvmsg(subflow, msg, flags);
+	release_sock(ssk);
+	release_sock(sk);
+
+	pr_debug("return %d", arg.copied);
+	return arg.copied;
 }
 =

 static int mptcp_init_sock(struct sock *sk)
@@ -346,7 +558,7 @@ static int mptcp_init_sock(struct sock *sk)
 =

 		pr_debug("subflow=3D%p", subflow);
 		msk->subflow =3D sf;
-		subflow->conn =3D sk;
+		subflow->conn =3D NULL;
 		subflow->request_mptcp =3D 1; // @@ if MPTCP enabled
 		subflow->checksum =3D 1; // @@ if checksum enabled
 		subflow->version =3D 0;
@@ -398,17 +610,26 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 	pr_debug("msk=3D%p", msk);
 =

 	if (subflow->mp_capable) {
+		u64 ack_seq;
+
+		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
+		pr_debug("token=3D%u", msk->token);
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
@@ -496,26 +717,36 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
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

 int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 			 int addr_len, int flags)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct subflow_sock *subflow =3D subflow_sk(msk->subflow->sk);
 	int err;
 =

-	pr_debug("msk=3D%p, subflow=3D%p", msk, msk->subflow->sk);
+	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
+
+	subflow->conn =3D sock->sk;
 =

 	err =3D inet_stream_connect(msk->subflow, uaddr, addr_len, flags);
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e0b4aa8fe51d..ac4f1f3e7edb 100644
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
@@ -202,6 +211,17 @@ const struct inet_connection_sock_af_ops subflow_speci=
fic =3D {
 	.mtu_reduced	   =3D tcp_v4_mtu_reduced,
 };
 =

+static void subflow_data_ready(struct sock *sk)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+	struct sock *parent =3D subflow->conn;
+
+	subflow->tcp_sk_data_ready(sk);
+
+	if (parent)
+		parent->sk_data_ready(parent);
+}
+
 static int subflow_init_sock(struct sock *sk)
 {
 	struct subflow_sock *subflow =3D subflow_sk(sk);
@@ -215,6 +235,8 @@ static int subflow_init_sock(struct sock *sk)
 	if (!err) { // @@ AND mptcp is enabled
 		tsk->is_mptcp =3D 1;
 		icsk->icsk_af_ops =3D &subflow_specific;
+		subflow->tcp_sk_data_ready =3D sk->sk_data_ready;
+		sk->sk_data_ready =3D subflow_data_ready;
 	}
 =

 	return err;
-- =

2.17.1


--===============0009521304791111019==--
