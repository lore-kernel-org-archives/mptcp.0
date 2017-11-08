Content-Type: multipart/mixed; boundary="===============3825746032216356550=="
MIME-Version: 1.0
From: Shoaib Rao <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Revert tcp_skb_cb to its original size
Date: Wed, 08 Nov 2017 13:19:49 -0800
Message-ID: <20171108211949.GA4339@caduceus5>
X-Status: 
X-Keywords:                  
X-UID: 162

--===============3825746032216356550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Christoph,

Following is a patch based on branch mptcp_v0.91.
I have looked into the issue that you pointed out. It is same as the partia=
l ACK issue. If there is no partial ack everything will work and this patch=
 covers all the non partial ack cases.

For the partial ACK case the fix is very simple. We can send the packet out=
 without any mapping and the previous mapping should cover it. We can also =
update the mapping i.e. care a sub mapping.

The Receiver code (detect mapping()) is very implementation based. I will c=
hange it to accept two more mapping, sub mapping that does not violate an e=
xisting mapping and a super mapping.

I will provide that patch later. Also note that the fields used in this pat=
ch are specific to this release.

Shoaib

---
 include/linux/skbuff.h   |  2 +-
 include/net/tcp.h        | 32 +++++++++-------
 net/mptcp/mptcp_output.c | 97 ++++++++++++++++++++++++++++++--------------=
----
 3 files changed, 80 insertions(+), 51 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index f66cd5e..ca2e26a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -540,7 +540,7 @@ struct sk_buff {
 	 * want to keep them across layers you have to do a skb_clone()
 	 * first. This is owned by whoever has the skb queued ATM.
 	 */
-	char			cb[56] __aligned(8);
+	char			cb[48] __aligned(8);
 =

 	unsigned long		_skb_refdst;
 	void			(*destructor)(struct sk_buff *skb);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 655ecd4..b476e86 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -842,14 +842,18 @@ struct tcp_skb_cb {
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

-	__u8		sacked;		/* State flags for SACK/FACK.	*/
+	/* Below union is fine as the skb will use one or the other
+	 * The SKB in the rtx queue will set sacked and does not care
+	 * about dss_off.
+	 * Eventually dss_off will not be needed.
+	 */
+	 =

+	union {
+		__u8		sacked;	/* State flags for SACK/FACK.	*/
+		__u8            dss_off;
+	};
 #define TCPCB_SACKED_ACKED	0x01	/* SKB ACK'd by a SACK block	*/
 #define TCPCB_SACKED_RETRANS	0x02	/* SKB retransmitted		*/
 #define TCPCB_LOST		0x04	/* SKB is lost			*/
@@ -860,8 +864,14 @@ struct tcp_skb_cb {
 				TCPCB_REPAIRED)
 =

 	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
-	/* 1 byte hole */
-	__u32		ack_seq;	/* Sequence number ACK'd	*/
+
+	__u8		mptcp_flags;
+	union {
+		__u32		ack_seq; /* Sequence number ACK'd	*/
+		__u32		mptcp_data_seq;
+		__u32		path_mask;
+		=

+	};
 	union {
 		union {
 			struct inet_skb_parm	h4;
@@ -869,12 +879,6 @@ struct tcp_skb_cb {
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

diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index 691ef6f..5318459 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -57,34 +57,13 @@ EXPORT_SYMBOL(mptcp_sub_len_remove_addr_align);
 /* get the data-seq and end-data-seq and store them again in the
  * tcp_skb_cb
  */
+/* Rao: May need work */
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
@@ -182,7 +161,7 @@ static void __mptcp_reinject_data(struct sk_buff *orig_=
skb, struct sock *meta_sk
 	/* Segment goes back to the MPTCP-layer. So, we need to zero the
 	 * path_mask/dss.
 	 */
-	memset(TCP_SKB_CB(skb)->dss, 0 , mptcp_dss_len);
+	TCP_SKB_CB(skb)->path_mask =3D 0;
 =

 	/* We need to find out the path-mask from the meta-write-queue
 	 * to properly select a subflow.
@@ -319,25 +298,30 @@ combine:
 	}
 }
 =

-static int mptcp_write_dss_mapping(const struct tcp_sock *tp, const struct=
 sk_buff *skb,
-				   __be32 *ptr)
+
+static int mptcp_write_dss_mapping(const struct tcp_sock *tp,
+				   const struct sk_buff *skb, __be32 *ptr)
 {
 	const struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
 	__be32 *start =3D ptr;
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
+	if (tcb->mptcp_flags & MPTCPHDR_INF) {
 		data_len =3D 0;
-	else
+	} else {
 		data_len =3D tcb->end_seq - tcb->seq;
+		/* mptcp_entail_skb adds one for FIN */
+		if (tcb->tcp_flags & TCPHDR_FIN)
+			data_len -=3D 1;
+	}
 =

 	if (tp->mpcb->dss_csum && data_len) {
 		__be16 *p16 =3D (__be16 *)ptr;
@@ -395,6 +379,47 @@ static int mptcp_write_dss_data_ack(const struct tcp_s=
ock *tp, const struct sk_b
  * To avoid this we save the initial DSS mapping which allows us to
  * send the same DSS mapping even for fragmented retransmits.
  */
+#if 0
+static int mptcp_write_dss_mapping(const struct tcp_sock *tp, const struct=
 sk_buff *skb,
+				   __be32 *ptr)
+{
+	const struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
+	__be32 *start =3D ptr;
+	__u16 data_len;
+
+	*ptr++ =3D htonl(tcb->seq); /* data_seq */
+
+	/* If it's a non-data DATA_FIN, we set subseq to 0 (draft v7) */
+	if (mptcp_is_data_fin(skb) && skb->len =3D=3D 0)
+		*ptr++ =3D 0; /* subseq */
+	else
+		*ptr++ =3D htonl(tp->write_seq - tp->mptcp->snt_isn); /* subseq */
+
+	if (tcb->mptcp_flags & MPTCPHDR_INF)
+		data_len =3D 0;
+	else
+		data_len =3D tcb->end_seq - tcb->seq;
+
+	if (tp->mpcb->dss_csum && data_len) {
+		__be16 *p16 =3D (__be16 *)ptr;
+		__be32 hdseq =3D mptcp_get_highorder_sndbits(skb, tp->mpcb);
+		__wsum csum;
+
+		*ptr =3D htonl(((data_len) << 16) |
+			     (TCPOPT_EOL << 8) |
+			     (TCPOPT_EOL));
+		csum =3D csum_partial(ptr - 2, 12, skb->csum);
+		p16++;
+		*p16++ =3D csum_fold(csum_partial(&hdseq, sizeof(hdseq), csum));
+	} else {
+		*ptr++ =3D htonl(((data_len) << 16) |
+			       (TCPOPT_NOP << 8) |
+			       (TCPOPT_NOP));
+	}
+
+	return ptr - start;
+}
+
 static void mptcp_save_dss_data_seq(const struct tcp_sock *tp, struct sk_b=
uff *skb)
 {
 	struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
@@ -424,6 +449,7 @@ static int mptcp_write_dss_data_seq(const struct tcp_so=
ck *tp, struct sk_buff *s
 =

 	return mptcp_dss_len/sizeof(*ptr);
 }
+#endif
 =

 static bool mptcp_skb_entail(struct sock *sk, struct sk_buff *skb, int rei=
nject)
 {
@@ -469,8 +495,8 @@ static bool mptcp_skb_entail(struct sock *sk, struct sk=
_buff *skb, int reinject)
 	if (mptcp_is_data_fin(subskb))
 		mptcp_combine_dfin(subskb, meta_sk, sk);
 =

-	mptcp_save_dss_data_seq(tp, subskb);
-
+	TCP_SKB_CB(subskb)->mptcp_flags |=3D MPTCPHDR_SEQ;
+	tcb->mptcp_data_seq =3D tcb->seq;
 	tcb->seq =3D tp->write_seq;
 =

 	/* Take into account seg len */
@@ -1197,10 +1223,9 @@ void mptcp_options_write(__be32 *ptr, struct tcp_soc=
k *tp,
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
 	}
 	if (unlikely(OPTION_MP_PRIO & opts->mptcp_options)) {
 		struct mp_prio *mpprio =3D (struct mp_prio *)ptr;
-- =

2.7.4


--===============3825746032216356550==--
