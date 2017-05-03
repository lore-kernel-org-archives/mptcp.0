Content-Type: multipart/mixed; boundary="===============6499063768018394781=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Revert tcp_skb_cb to it's original size
Date: Wed, 03 May 2017 15:02:26 -0700
Message-ID: <20170503220216.GA3736@caduceus5>
X-Status: 
X-Keywords:                  
X-UID: 28

--===============6499063768018394781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is an attempt to address the issue without allocating any space and ov=
erloading existing data structures.

Shoaib.

Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
---
 include/linux/skbuff.h   |   8 ++-
 include/net/mptcp.h      |  17 +++---
 include/net/tcp.h        |  19 +++---
 net/ipv4/tcp_ipv4.c      |   4 +-
 net/ipv4/tcp_output.c    |  13 ++++-
 net/ipv6/tcp_ipv6.c      |   4 +-
 net/mptcp/mptcp_input.c  |  37 ++++++------
 net/mptcp/mptcp_ipv4.c   |   4 +-
 net/mptcp/mptcp_ipv6.c   |   4 +-
 net/mptcp/mptcp_output.c | 146 +++++++++++++++++--------------------------=
----
 10 files changed, 113 insertions(+), 143 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index f66cd5e..e2cdc21 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -532,7 +532,13 @@ struct sk_buff {
 		struct rb_node	rbnode; /* used in netem & tcp stack */
 	};
 	struct sock		*sk;
-	struct net_device	*dev;
+	union {
+		struct net_device	*dev;
+		struct {
+			__u8 mptcp_flags;
+			__u8 dss_offset;
+		};
+	};
 =

 	/*
 	 * This is the control buffer. It is free to use for every
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 876f1e6..d9ff2e7 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -807,8 +807,7 @@ void tcp_parse_mptcp_options(const struct sk_buff *skb,
 			     struct mptcp_options_received *mopt);
 void mptcp_parse_options(const uint8_t *ptr, int opsize,
 			 struct mptcp_options_received *mopt,
-			 const struct sk_buff *skb,
-			 struct tcp_sock *tp);
+			 struct sk_buff *skb, struct tcp_sock *tp);
 void mptcp_syn_options(const struct sock *sk, struct tcp_out_options *opts,
 		       unsigned *remaining);
 void mptcp_synack_options(struct request_sock *req,
@@ -1000,12 +999,12 @@ static inline void mptcp_sub_force_close_all(struct =
mptcp_cb *mpcb,
 =

 static inline bool mptcp_is_data_seq(const struct sk_buff *skb)
 {
-	return TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ;
+	return skb->mptcp_flags & MPTCPHDR_SEQ;
 }
 =

 static inline bool mptcp_is_data_fin(const struct sk_buff *skb)
 {
-	return TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_FIN;
+	return skb->mptcp_flags & MPTCPHDR_FIN;
 }
 =

 /* Is it a data-fin while in infinite mapping mode?
@@ -1034,17 +1033,17 @@ static inline u8 mptcp_get_64_bit(u64 data_seq, str=
uct mptcp_cb *mpcb)
 /* Sets the data_seq and returns pointer to the in-skb field of the data_s=
eq.
  * If the packet has a 64-bit dseq, the pointer points to the last 32 bits.
  */
-static inline __u32 *mptcp_skb_set_data_seq(const struct sk_buff *skb,
+static inline __u32 *mptcp_skb_set_data_seq(struct sk_buff *skb,
 					    u32 *data_seq,
 					    struct mptcp_cb *mpcb)
 {
-	__u32 *ptr =3D (__u32 *)(skb_transport_header(skb) + TCP_SKB_CB(skb)->dss=
_off);
+	__u32 *ptr =3D (__u32 *)(skb_transport_header(skb) + skb->dss_offset);
 =

-	if (TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ64_SET) {
+	if (skb->mptcp_flags & MPTCPHDR_SEQ64_SET) {
 		u64 data_seq64 =3D get_unaligned_be64(ptr);
 =

 		if (mpcb)
-			TCP_SKB_CB(skb)->mptcp_flags |=3D mptcp_get_64_bit(data_seq64, mpcb);
+			skb->mptcp_flags |=3D mptcp_get_64_bit(data_seq64, mpcb);
 =

 		*data_seq =3D (u32)data_seq64;
 		ptr++;
@@ -1142,7 +1141,7 @@ static inline void mptcp_reset_mopt(struct tcp_sock *=
tp)
 static inline __be32 mptcp_get_highorder_sndbits(const struct sk_buff *skb,
 						 const struct mptcp_cb *mpcb)
 {
-	return htonl(mpcb->snd_high_order[(TCP_SKB_CB(skb)->mptcp_flags &
+	return htonl(mpcb->snd_high_order[(skb->mptcp_flags &
 			MPTCPHDR_SEQ64_INDEX) ? 1 : 0]);
 }
 =

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 655ecd4..3258721 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -842,11 +842,6 @@ struct tcp_skb_cb {
 		__u32		tcp_gso_segs;
 	};
 =

-#ifdef CONFIG_MPTCP
-	__u8		mptcp_flags;	/* flags for the MPTCP layer    */
-	__u8		dss_off;	/* Number of 4-byte words until
-					 * seq-number */
-#endif
 	__u8		tcp_flags;	/* TCP header flags. (tcp[13])	*/
 =

 	__u8		sacked;		/* State flags for SACK/FACK.	*/
@@ -861,7 +856,13 @@ struct tcp_skb_cb {
 =

 	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
 	/* 1 byte hole */
-	__u32		ack_seq;	/* Sequence number ACK'd	*/
+	union {
+		__u32		ack_seq;	/* Sequence number ACK'd */
+		union {
+			__u32 mptcp_data_seq;
+			__u32 path_mask;
+		};
+	};
 	union {
 		union {
 			struct inet_skb_parm	h4;
@@ -869,12 +870,6 @@ struct tcp_skb_cb {
 			struct inet6_skb_parm	h6;
 #endif
 		} header;	/* For incoming frames		*/
-#ifdef CONFIG_MPTCP
-		union {			/* For MPTCP outgoing frames */
-			__u32 path_mask; /* paths that tried to send this skb */
-			__u32 dss[6];	/* DSS options */
-		};
-#endif
 	};
 };
 =

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6967a86..4e8a3e3 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1637,8 +1637,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 				    skb->len - th->doff * 4);
 	TCP_SKB_CB(skb)->ack_seq =3D ntohl(th->ack_seq);
 #ifdef CONFIG_MPTCP
-	TCP_SKB_CB(skb)->mptcp_flags =3D 0;
-	TCP_SKB_CB(skb)->dss_off =3D 0;
+	skb->mptcp_flags =3D 0;
+	skb->dss_offset =3D 0;
 #endif
 	TCP_SKB_CB(skb)->tcp_flags =3D tcp_flag_byte(th);
 	TCP_SKB_CB(skb)->tcp_tw_isn =3D 0;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a635483..9d49125 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -999,7 +999,6 @@ int tcp_transmit_skb(struct sock *sk, struct sk_buff *s=
kb, int clone_it,
 	th->source		=3D inet->inet_sport;
 	th->dest		=3D inet->inet_dport;
 	th->seq			=3D htonl(tcb->seq);
-	th->ack_seq		=3D htonl(tp->rcv_nxt);
 	*(((__be16 *)th) + 6)	=3D htons(((tcp_header_size >> 2) << 12) |
 					tcb->tcp_flags);
 =

@@ -1029,6 +1028,12 @@ int tcp_transmit_skb(struct sock *sk, struct sk_buff=
 *skb, int clone_it,
 	if (likely((tcb->tcp_flags & TCPHDR_SYN) =3D=3D 0))
 		tcp_ecn_send(sk, skb, tcp_header_size);
 =

+	/*
+	 * It is important that we initialize ack_seq after options
+	 * have been added as ack_seq is used to pass options value to MPTCP
+	 */
+	th->ack_seq		=3D htonl(tp->rcv_nxt);
+
 #ifdef CONFIG_TCP_MD5SIG
 	/* Calculate the MD5 hash, as we have all we need now */
 	if (md5) {
@@ -1216,6 +1221,12 @@ int tcp_fragment(struct sock *sk, struct sk_buff *sk=
b, u32 len,
 	TCP_SKB_CB(skb)->tcp_flags =3D flags & ~(TCPHDR_FIN | TCPHDR_PSH);
 	TCP_SKB_CB(buff)->tcp_flags =3D flags;
 	TCP_SKB_CB(buff)->sacked =3D TCP_SKB_CB(skb)->sacked;
+	if (mptcp(tp)) {
+		/*
+		 * update the mapping
+		 */
+		TCP_SKB_CB(buff)->mptcp_data_seq +=3D len;
+	}
 =

 	if (!skb_shinfo(skb)->nr_frags && skb->ip_summed !=3D CHECKSUM_PARTIAL) {
 		/* Copy and checksum data tail into the new buffer. */
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index eba2436..e0c6132 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1413,8 +1413,8 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const=
 struct ipv6hdr *hdr,
 				    skb->len - th->doff*4);
 	TCP_SKB_CB(skb)->ack_seq =3D ntohl(th->ack_seq);
 #ifdef CONFIG_MPTCP
-	TCP_SKB_CB(skb)->mptcp_flags =3D 0;
-	TCP_SKB_CB(skb)->dss_off =3D 0;
+	skb->mptcp_flags =3D 0;
+	skb->dss_offset =3D 0;
 #endif
 	TCP_SKB_CB(skb)->tcp_flags =3D tcp_flag_byte(th);
 	TCP_SKB_CB(skb)->tcp_tw_isn =3D 0;
diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
index 51cbb06..3c267ad 100644
--- a/net/mptcp/mptcp_input.c
+++ b/net/mptcp/mptcp_input.c
@@ -324,8 +324,8 @@ static int mptcp_verif_dss_csum(struct sock *sk)
 			 * in the final csum_partial-call.
 			 */
 			u32 offset =3D skb_transport_offset(tmp) +
-				     TCP_SKB_CB(tmp)->dss_off;
-			if (TCP_SKB_CB(tmp)->mptcp_flags & MPTCPHDR_SEQ64_SET)
+				     tmp->dss_offset;
+			if (tmp->mptcp_flags & MPTCPHDR_SEQ64_SET)
 				offset +=3D 4;
 =

 			csum_tcp =3D skb_checksum(tmp, offset,
@@ -758,7 +758,7 @@ static int mptcp_detect_mapping(struct sock *sk, struct=
 sk_buff *skb)
 	}
 =

 	/* Does the DSS had 64-bit seqnum's ? */
-	if (!(tcb->mptcp_flags & MPTCPHDR_SEQ64_SET)) {
+	if (!(skb->mptcp_flags & MPTCPHDR_SEQ64_SET)) {
 		/* Wrapped around? */
 		if (unlikely(after(data_seq, meta_tp->rcv_nxt) && data_seq < meta_tp->rc=
v_nxt)) {
 			tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb, !mpcb->rcv_hise=
q_index, data_seq);
@@ -767,9 +767,9 @@ static int mptcp_detect_mapping(struct sock *sk, struct=
 sk_buff *skb)
 			tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb, mpcb->rcv_hiseq=
_index, data_seq);
 		}
 	} else {
-		tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb, (tcb->mptcp_flag=
s & MPTCPHDR_SEQ64_INDEX) ? 1 : 0, data_seq);
+		tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb, (skb->mptcp_flag=
s & MPTCPHDR_SEQ64_INDEX) ? 1 : 0, data_seq);
 =

-		if (unlikely(tcb->mptcp_flags & MPTCPHDR_SEQ64_OFO)) {
+		if (unlikely(skb->mptcp_flags & MPTCPHDR_SEQ64_OFO)) {
 			/* We make sure that the data_seq is invalid.
 			 * It will be dropped later.
 			 */
@@ -1108,7 +1108,7 @@ int mptcp_check_req(struct sk_buff *skb, struct net *=
net)
 	if (!meta_sk)
 		return 0;
 =

-	TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
+	skb->mptcp_flags |=3D MPTCPHDR_JOIN;
 =

 	bh_lock_sock_nested(meta_sk);
 	if (sock_owned_by_user(meta_sk)) {
@@ -1222,7 +1222,7 @@ int mptcp_lookup_join(struct sk_buff *skb, struct ine=
t_timewait_sock *tw)
 		inet_twsk_put(tw);
 	}
 =

-	TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
+	skb->mptcp_flags |=3D MPTCPHDR_JOIN;
 	/* OK, this is a new syn/join, let's create a new open request and
 	 * send syn+ack
 	 */
@@ -1279,7 +1279,7 @@ int mptcp_do_join_short(struct sk_buff *skb,
 		return -1;
 	}
 =

-	TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
+	skb->mptcp_flags |=3D MPTCPHDR_JOIN;
 =

 	/* OK, this is a new syn/join, let's create a new open request and
 	 * send syn+ack
@@ -1461,7 +1461,7 @@ static void mptcp_data_ack(struct sock *sk, const str=
uct sk_buff *skb)
 {
 	struct sock *meta_sk =3D mptcp_meta_sk(sk);
 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk), *tp =3D tcp_sk(sk);
-	struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
+	//struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
 	u32 prior_snd_una =3D meta_tp->snd_una;
 	int prior_packets;
 	u32 nwin, data_ack, data_seq;
@@ -1481,7 +1481,7 @@ static void mptcp_data_ack(struct sock *sk, const str=
uct sk_buff *skb)
 	/* If we are in infinite mapping mode, rx_opt.data_ack has been
 	 * set by mptcp_clean_rtx_infinite.
 	 */
-	if (!(tcb->mptcp_flags & MPTCPHDR_ACK) && !tp->mpcb->infinite_mapping_snd)
+	if (!(skb->mptcp_flags & MPTCPHDR_ACK) && !tp->mpcb->infinite_mapping_snd)
 		goto exit;
 =

 	data_ack =3D tp->mptcp->rx_opt.data_ack;
@@ -1647,7 +1647,7 @@ static inline bool is_valid_addropt_opsize(u8 mptcp_v=
er,
 =

 void mptcp_parse_options(const uint8_t *ptr, int opsize,
 			 struct mptcp_options_received *mopt,
-			 const struct sk_buff *skb,
+			 struct sk_buff *skb,
 			 struct tcp_sock *tp)
 {
 	const struct mptcp_option *mp_opt =3D (struct mptcp_option *)ptr;
@@ -1757,7 +1757,7 @@ void mptcp_parse_options(const uint8_t *ptr, int opsi=
ze,
 		ptr +=3D 4;
 =

 		if (mdss->A) {
-			tcb->mptcp_flags |=3D MPTCPHDR_ACK;
+			skb->mptcp_flags |=3D MPTCPHDR_ACK;
 =

 			if (mdss->a) {
 				mopt->data_ack =3D (u32) get_unaligned_be64(ptr);
@@ -1768,13 +1768,14 @@ void mptcp_parse_options(const uint8_t *ptr, int op=
size,
 			}
 		}
 =

-		tcb->dss_off =3D (ptr - skb_transport_header(skb));
+		//tcb->dss_off =3D (ptr - skb_transport_header(skb));
+		skb->dss_offset =3D (ptr - skb_transport_header(skb));
 =

 		if (mdss->M) {
 			if (mdss->m) {
 				u64 data_seq64 =3D get_unaligned_be64(ptr);
 =

-				tcb->mptcp_flags |=3D MPTCPHDR_SEQ64_SET;
+				skb->mptcp_flags |=3D MPTCPHDR_SEQ64_SET;
 				mopt->data_seq =3D (u32) data_seq64;
 =

 				ptr +=3D 12; /* 64-bit dseq + subseq */
@@ -1784,15 +1785,15 @@ void mptcp_parse_options(const uint8_t *ptr, int op=
size,
 			}
 			mopt->data_len =3D get_unaligned_be16(ptr);
 =

-			tcb->mptcp_flags |=3D MPTCPHDR_SEQ;
+			skb->mptcp_flags |=3D MPTCPHDR_SEQ;
 =

 			/* Is a check-sum present? */
 			if (opsize =3D=3D mptcp_sub_len_dss(mdss, 1))
-				tcb->mptcp_flags |=3D MPTCPHDR_DSS_CSUM;
+				skb->mptcp_flags |=3D MPTCPHDR_DSS_CSUM;
 =

 			/* DATA_FIN only possible with DSS-mapping */
 			if (mdss->F)
-				tcb->mptcp_flags |=3D MPTCPHDR_FIN;
+				skb->mptcp_flags |=3D MPTCPHDR_FIN;
 		}
 =

 		break;
@@ -2185,7 +2186,7 @@ bool mptcp_handle_options(struct sock *sk, const stru=
ct tcphdr *th,
 	 * receiver MUST close the subflow with a RST as it is considered broken.
 	 */
 	if (mptcp_is_data_seq(skb) && tp->mpcb->dss_csum &&
-	    !(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_DSS_CSUM)) {
+	    !(skb->mptcp_flags & MPTCPHDR_DSS_CSUM)) {
 		mptcp_send_reset(sk);
 		return true;
 	}
diff --git a/net/mptcp/mptcp_ipv4.c b/net/mptcp/mptcp_ipv4.c
index a147b20..1614836 100644
--- a/net/mptcp/mptcp_ipv4.c
+++ b/net/mptcp/mptcp_ipv4.c
@@ -186,7 +186,7 @@ int mptcp_v4_do_rcv(struct sock *meta_sk, struct sk_buf=
f *skb)
 	struct sock *child, *rsk =3D NULL;
 	int ret;
 =

-	if (!(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_JOIN)) {
+	if (!(skb->mptcp_flags & MPTCPHDR_JOIN)) {
 		struct tcphdr *th =3D tcp_hdr(skb);
 		const struct iphdr *iph =3D ip_hdr(skb);
 		struct sock *sk;
@@ -217,7 +217,7 @@ int mptcp_v4_do_rcv(struct sock *meta_sk, struct sk_buf=
f *skb)
 =

 		return ret;
 	}
-	TCP_SKB_CB(skb)->mptcp_flags =3D 0;
+	skb->mptcp_flags =3D 0;
 =

 	/* Has been removed from the tk-table. Thus, no new subflows.
 	 *
diff --git a/net/mptcp/mptcp_ipv6.c b/net/mptcp/mptcp_ipv6.c
index 0de953d..1959d01 100644
--- a/net/mptcp/mptcp_ipv6.c
+++ b/net/mptcp/mptcp_ipv6.c
@@ -199,7 +199,7 @@ int mptcp_v6_do_rcv(struct sock *meta_sk, struct sk_buf=
f *skb)
 	struct sock *child, *rsk =3D NULL;
 	int ret;
 =

-	if (!(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_JOIN)) {
+	if (!(skb->mptcp_flags & MPTCPHDR_JOIN)) {
 		struct tcphdr *th =3D tcp_hdr(skb);
 		const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
 		struct sock *sk;
@@ -232,7 +232,7 @@ int mptcp_v6_do_rcv(struct sock *meta_sk, struct sk_buf=
f *skb)
 =

 		return ret;
 	}
-	TCP_SKB_CB(skb)->mptcp_flags =3D 0;
+	skb->mptcp_flags =3D 0;
 =

 	/* Has been removed from the tk-table. Thus, no new subflows.
 	 *
diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index 691ef6f..e746565 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -59,39 +59,17 @@ EXPORT_SYMBOL(mptcp_sub_len_remove_addr_align);
  */
 static bool mptcp_reconstruct_mapping(struct sk_buff *skb)
 {
-	const struct mp_dss *mpdss =3D (struct mp_dss *)TCP_SKB_CB(skb)->dss;
-	u32 *p32;
-	u16 *p16;
-
 	if (!mptcp_is_data_seq(skb))
 		return false;
 =

-	if (!mpdss->M)
-		return false;
-
-	/* Move the pointer to the data-seq */
-	p32 =3D (u32 *)mpdss;
-	p32++;
-	if (mpdss->A) {
-		p32++;
-		if (mpdss->a)
-			p32++;
-	}
-
-	TCP_SKB_CB(skb)->seq =3D ntohl(*p32);
-
-	/* Get the data_len to calculate the end_data_seq */
-	p32++;
-	p32++;
-	p16 =3D (u16 *)p32;
-	TCP_SKB_CB(skb)->end_seq =3D ntohs(*p16) + TCP_SKB_CB(skb)->seq;
+	TCP_SKB_CB(skb)->seq =3D TCP_SKB_CB(skb)->mptcp_data_seq;
 =

 	return true;
 }
 =

 static bool mptcp_is_reinjected(const struct sk_buff *skb)
 {
-	return TCP_SKB_CB(skb)->mptcp_flags & MPTCP_REINJECT;
+	return skb->mptcp_flags & MPTCP_REINJECT;
 }
 =

 static void mptcp_find_and_set_pathmask(const struct sock *meta_sk, struct=
 sk_buff *skb)
@@ -182,7 +160,7 @@ static void __mptcp_reinject_data(struct sk_buff *orig_=
skb, struct sock *meta_sk
 	/* Segment goes back to the MPTCP-layer. So, we need to zero the
 	 * path_mask/dss.
 	 */
-	memset(TCP_SKB_CB(skb)->dss, 0 , mptcp_dss_len);
+	TCP_SKB_CB(skb)->path_mask =3D 0;
 =

 	/* We need to find out the path-mask from the meta-write-queue
 	 * to properly select a subflow.
@@ -272,7 +250,7 @@ void mptcp_reinject_data(struct sock *sk, int clone_it)
 		if (mptcp_is_reinjected(skb_it))
 			continue;
 =

-		tcb->mptcp_flags |=3D MPTCP_REINJECT;
+		skb_it->mptcp_flags |=3D MPTCP_REINJECT;
 		__mptcp_reinject_data(skb_it, meta_sk, sk, clone_it);
 	}
 =

@@ -319,25 +297,45 @@ combine:
 	}
 }
 =

-static int mptcp_write_dss_mapping(const struct tcp_sock *tp, const struct=
 sk_buff *skb,
-				   __be32 *ptr)
+/* =

+ * RFC6824 states that once a particular subflow mapping has been sent
+ * out it must never be changed. However, packets may be split while
+ * they are in the retransmission queue (due to SACK or ACKs) and that
+ * arguably means that we would change the mapping (e.g. it splits it,
+ * our sends out a subset of the initial mapping).
+ *
+ * Furthermore, the skb checksum is not always preserved across splits
+ * (e.g. mptcp_fragment) which would mean that we need to recompute
+ * the DSS checksum in this case.
+ *
+ * To avoid this we save the initial DSS mapping which allows us to
+ * send the same DSS mapping even for fragmented retransmits.
+ */
+
+static int mptcp_write_dss_mapping(const struct tcp_sock *tp,
+    const struct sk_buff *skb, __be32 *ptr)
 {
 	const struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
-	__be32 *start =3D ptr;
 	__u16 data_len;
 =

-	*ptr++ =3D htonl(tcb->seq); /* data_seq */
+	*ptr++ =3D htonl(tcb->mptcp_data_seq); /* data_seq */
 =

 	/* If it's a non-data DATA_FIN, we set subseq to 0 (draft v7) */
 	if (mptcp_is_data_fin(skb) && skb->len =3D=3D 0)
 		*ptr++ =3D 0; /* subseq */
 	else
-		*ptr++ =3D htonl(tp->write_seq - tp->mptcp->snt_isn); /* subseq */
+		*ptr++ =3D htonl(tcb->seq - tp->mptcp->snt_isn); /* subseq */
 =

-	if (tcb->mptcp_flags & MPTCPHDR_INF)
+	if (skb->mptcp_flags & MPTCPHDR_INF)
 		data_len =3D 0;
-	else
+	else {
 		data_len =3D tcb->end_seq - tcb->seq;
+		/*
+		 * mptcp_entail_skb adds one for FIN
+		 */
+		if (tcb->tcp_flags & TCPHDR_FIN)
+			data_len -=3D 1;
+	}
 =

 	if (tp->mpcb->dss_csum && data_len) {
 		__be16 *p16 =3D (__be16 *)ptr;
@@ -356,11 +354,11 @@ static int mptcp_write_dss_mapping(const struct tcp_s=
ock *tp, const struct sk_bu
 			       (TCPOPT_NOP));
 	}
 =

-	return ptr - start;
+	return mptcp_dss_len/sizeof(*ptr);
 }
 =

-static int mptcp_write_dss_data_ack(const struct tcp_sock *tp, const struc=
t sk_buff *skb,
-				    __be32 *ptr)
+static int mptcp_write_dss_data_ack(const struct tcp_sock *tp,
+    const struct sk_buff *skb, __be32 *ptr)
 {
 	struct mp_dss *mdss =3D (struct mp_dss *)ptr;
 	__be32 *start =3D ptr;
@@ -377,54 +375,12 @@ static int mptcp_write_dss_data_ack(const struct tcp_=
sock *tp, const struct sk_b
 	mdss->len =3D mptcp_sub_len_dss(mdss, tp->mpcb->dss_csum);
 	ptr++;
 =

+	/* data_ack */
 	*ptr++ =3D htonl(mptcp_meta_tp(tp)->rcv_nxt);
 =

 	return ptr - start;
 }
 =

-/* RFC6824 states that once a particular subflow mapping has been sent
- * out it must never be changed. However, packets may be split while
- * they are in the retransmission queue (due to SACK or ACKs) and that
- * arguably means that we would change the mapping (e.g. it splits it,
- * our sends out a subset of the initial mapping).
- *
- * Furthermore, the skb checksum is not always preserved across splits
- * (e.g. mptcp_fragment) which would mean that we need to recompute
- * the DSS checksum in this case.
- *
- * To avoid this we save the initial DSS mapping which allows us to
- * send the same DSS mapping even for fragmented retransmits.
- */
-static void mptcp_save_dss_data_seq(const struct tcp_sock *tp, struct sk_b=
uff *skb)
-{
-	struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
-	__be32 *ptr =3D (__be32 *)tcb->dss;
-
-	tcb->mptcp_flags |=3D MPTCPHDR_SEQ;
-
-	ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
-	ptr +=3D mptcp_write_dss_mapping(tp, skb, ptr);
-}
-
-/* Write the saved DSS mapping to the header */
-static int mptcp_write_dss_data_seq(const struct tcp_sock *tp, struct sk_b=
uff *skb,
-				    __be32 *ptr)
-{
-	__be32 *start =3D ptr;
-
-	memcpy(ptr, TCP_SKB_CB(skb)->dss, mptcp_dss_len);
-
-	/* update the data_ack */
-	start[1] =3D htonl(mptcp_meta_tp(tp)->rcv_nxt);
-
-	/* dss is in a union with inet_skb_parm and
-	 * the IP layer expects zeroed IPCB fields.
-	 */
-	memset(TCP_SKB_CB(skb)->dss, 0 , mptcp_dss_len);
-
-	return mptcp_dss_len/sizeof(*ptr);
-}
-
 static bool mptcp_skb_entail(struct sock *sk, struct sk_buff *skb, int rei=
nject)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
@@ -434,7 +390,7 @@ static bool mptcp_skb_entail(struct sock *sk, struct sk=
_buff *skb, int reinject)
 	struct sk_buff *subskb =3D NULL;
 =

 	if (!reinject)
-		TCP_SKB_CB(skb)->mptcp_flags |=3D (mpcb->snd_hiseq_index ?
+		skb->mptcp_flags |=3D (mpcb->snd_hiseq_index ?
 						  MPTCPHDR_SEQ64_INDEX : 0);
 =

 	subskb =3D pskb_copy_for_clone(skb, GFP_ATOMIC);
@@ -463,14 +419,15 @@ static bool mptcp_skb_entail(struct sock *sk, struct =
sk_buff *skb, int reinject)
 		tp->mptcp->fully_established =3D 1;
 		tp->mpcb->infinite_mapping_snd =3D 1;
 		tp->mptcp->infinite_cutoff_seq =3D tp->write_seq;
-		tcb->mptcp_flags |=3D MPTCPHDR_INF;
+		skb->mptcp_flags |=3D MPTCPHDR_INF;
 	}
 =

 	if (mptcp_is_data_fin(subskb))
 		mptcp_combine_dfin(subskb, meta_sk, sk);
 =

-	mptcp_save_dss_data_seq(tp, subskb);
-
+	skb->mptcp_flags |=3D MPTCPHDR_SEQ;
+	tcb->mptcp_data_seq =3D tcb->seq;
+	=

 	tcb->seq =3D tp->write_seq;
 =

 	/* Take into account seg len */
@@ -536,9 +493,9 @@ static int mptcp_fragment(struct sock *meta_sk, struct =
sk_buff *skb, u32 len,
 =

 	buff =3D skb->next;
 =

-	flags =3D TCP_SKB_CB(skb)->mptcp_flags;
-	TCP_SKB_CB(skb)->mptcp_flags =3D flags & ~(MPTCPHDR_FIN);
-	TCP_SKB_CB(buff)->mptcp_flags =3D flags;
+	flags =3D skb->mptcp_flags;
+	skb->mptcp_flags =3D flags & ~(MPTCPHDR_FIN);
+	buff->mptcp_flags =3D flags;
 	TCP_SKB_CB(buff)->path_mask =3D TCP_SKB_CB(skb)->path_mask;
 =

 	/* If reinject =3D=3D 1, the buff will be added to the reinject
@@ -554,7 +511,8 @@ static int mptcp_fragment(struct sock *meta_sk, struct =
sk_buff *skb, u32 len,
 		tcp_sk(meta_sk)->mpcb->reinject_queue.qlen++;
 		meta_sk->sk_write_queue.qlen--;
 =

-		if (!before(tcp_sk(meta_sk)->snd_nxt, TCP_SKB_CB(buff)->end_seq)) {
+		if (!before(tcp_sk(meta_sk)->snd_nxt,
+		    TCP_SKB_CB(buff)->end_seq)) {
 			undo =3D old_factor - tcp_skb_pcount(skb) -
 				tcp_skb_pcount(buff);
 			if (undo)
@@ -967,7 +925,7 @@ void mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 	if (unlikely(mpcb->infinite_mapping_snd) &&
 	    ((mpcb->send_infinite_mapping && tcb &&
 	      mptcp_is_data_seq(skb) &&
-	      !(tcb->mptcp_flags & MPTCPHDR_INF) &&
+	      !(skb->mptcp_flags & MPTCPHDR_INF) &&
 	      !before(tcb->seq, tp->mptcp->infinite_cutoff_seq)) ||
 	     !mpcb->send_infinite_mapping))
 		return;
@@ -1197,10 +1155,10 @@ void mptcp_options_write(__be32 *ptr, struct tcp_so=
ck *tp,
 	}
 =

 	if (OPTION_DATA_ACK & opts->mptcp_options) {
-		if (!mptcp_is_data_seq(skb))
-			ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
-		else
-			ptr +=3D mptcp_write_dss_data_seq(tp, skb, ptr);
+		ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
+		if (mptcp_is_data_seq(skb))
+			ptr +=3D mptcp_write_dss_mapping(tp, skb, ptr);
+		skb->dev =3D NULL;
 	}
 	if (unlikely(OPTION_MP_PRIO & opts->mptcp_options)) {
 		struct mp_prio *mpprio =3D (struct mp_prio *)ptr;
@@ -1233,7 +1191,7 @@ void mptcp_send_fin(struct sock *meta_sk)
 	mss_now =3D mptcp_current_mss(meta_sk);
 =

 	if (tcp_send_head(meta_sk) !=3D NULL) {
-		TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_FIN;
+		skb->mptcp_flags |=3D MPTCPHDR_FIN;
 		TCP_SKB_CB(skb)->end_seq++;
 		meta_tp->write_seq++;
 	} else {
@@ -1250,7 +1208,7 @@ void mptcp_send_fin(struct sock *meta_sk)
 =

 		tcp_init_nondata_skb(skb, meta_tp->write_seq, TCPHDR_ACK);
 		TCP_SKB_CB(skb)->end_seq++;
-		TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_FIN;
+		skb->mptcp_flags |=3D MPTCPHDR_FIN;
 		tcp_queue_skb(meta_sk, skb);
 	}
 	__tcp_push_pending_frames(meta_sk, mss_now, TCP_NAGLE_OFF);
-- =

2.7.4


--===============6499063768018394781==--
