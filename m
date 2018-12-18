Content-Type: multipart/mixed; boundary="===============1680808130594094292=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 mptcp-net-next 01/12] mptcp: Remove support for
 DSS-checksums
Date: Tue, 18 Dec 2018 11:43:40 -0800
Message-ID: <20181218194351.14716-2-cpaasch@apple.com>
In-Reply-To: 20181218194351.14716-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 937

--===============1680808130594094292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To reduce the code-size and complexity, we remove support for
DSS-checksums. If we receive a MP_CAPABLE with a DSS-checksum we simply
fallback to regular TCP.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/linux/tcp.h      |   3 +-
 include/net/mptcp.h      |  31 ++------
 net/mptcp/mptcp_ctrl.c   |  16 -----
 net/mptcp/mptcp_input.c  | 184 ++-----------------------------------------=
----
 net/mptcp/mptcp_output.c |  69 ++----------------
 5 files changed, 17 insertions(+), 286 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 29f8ab30c7ed..f38bf1e18e58 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -94,8 +94,7 @@ struct tcp_out_options {
 	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
 #ifdef CONFIG_MPTCP
 	u16	mptcp_options;	/* bit field of MPTCP related OPTION_* */
-	u8	dss_csum:1,	/* dss-checksum required? */
-		add_addr_v4:1,
+	u8	add_addr_v4:1,
 		add_addr_v6:1,
 		mptcp_ver:4;
 =

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index b8b750034a91..a512e9386296 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -102,8 +102,7 @@ struct mptcp_request_sock {
 =

 	u8				loc_id;
 	u8				rem_id; /* Address-id in the MP_JOIN */
-	u8				dss_csum:1,
-					is_sub:1, /* Is this a new subflow? */
+	u8				is_sub:1, /* Is this a new subflow? */
 					low_prio:1, /* Interface set to low-prio? */
 					rcv_low_prio:1,
 					mptcp_ver:4;
@@ -111,7 +110,6 @@ struct mptcp_request_sock {
 =

 struct mptcp_options_received {
 	u16	saw_mpc:1,
-		dss_csum:1,
 		drop_me:1,
 =

 		is_mp_join:1,
@@ -168,7 +166,6 @@ struct mptcp_tcp_sock {
 		fully_established:1,
 		second_packet:1,
 		attached:1,
-		send_mp_fail:1,
 		include_mpc:1,
 		mapping_present:1,
 		map_data_fin:1,
@@ -269,7 +266,6 @@ struct mptcp_cb {
 		in_time_wait:1,
 		list_rcvd:1, /* XXX TO REMOVE */
 		addr_signal:1, /* Path-manager wants us to call addr_signal */
-		dss_csum:1,
 		server_side:1,
 		infinite_mapping_rcv:1,
 		infinite_mapping_snd:1,
@@ -288,7 +284,6 @@ struct mptcp_cb {
 	 * accessed. Thus, the whole data-path is on a single cache-line.
 	 */
 =

-	u64	csum_cutoff_seq;
 	u64	infinite_rcv_seq;
 =

 	/***** Start of fields, used for connection closure */
@@ -364,11 +359,9 @@ struct mptcp_cb {
  * To get the total length, just add the different options together.
  */
 #define MPTCP_SUB_LEN_SEQ	10
-#define MPTCP_SUB_LEN_SEQ_CSUM	12
 #define MPTCP_SUB_LEN_SEQ_ALIGN	12
 =

 #define MPTCP_SUB_LEN_SEQ_64		14
-#define MPTCP_SUB_LEN_SEQ_CSUM_64	16
 #define MPTCP_SUB_LEN_SEQ_64_ALIGN	16
 =

 #define MPTCP_SUB_LEN_ACK	4
@@ -434,10 +427,9 @@ extern bool mptcp_init_failed;
 #define OPTION_DATA_ACK		(1 << 4)
 #define OPTION_ADD_ADDR		(1 << 5)
 #define OPTION_MP_JOIN		(1 << 6)
-#define OPTION_MP_FAIL		(1 << 7)
-#define OPTION_MP_FCLOSE	(1 << 8)
-#define OPTION_REMOVE_ADDR	(1 << 9)
-#define OPTION_MP_PRIO		(1 << 10)
+#define OPTION_MP_FCLOSE	(1 << 7)
+#define OPTION_REMOVE_ADDR	(1 << 8)
+#define OPTION_MP_PRIO		(1 << 9)
 =

 /* MPTCP flags: both TX and RX */
 #define MPTCPHDR_SEQ		0x01 /* DSS.M option is present */
@@ -447,7 +439,6 @@ extern bool mptcp_init_failed;
 #define MPTCPHDR_ACK		0x08
 #define MPTCPHDR_SEQ64_SET	0x10 /* Did we received a 64-bit seq number?  */
 #define MPTCPHDR_SEQ64_OFO	0x20 /* Is it not in our circular array? */
-#define MPTCPHDR_DSS_CSUM	0x40
 /* MPTCP flags: TX only */
 #define MPTCPHDR_INF		0x08
 #define MPTCP_REINJECT		0x10 /* Did we reinject this segment? */
@@ -640,16 +631,15 @@ struct mp_prio {
 	__u8	addr_id;
 } __attribute__((__packed__));
 =

-static inline int mptcp_sub_len_dss(const struct mp_dss *m, const int csum)
+static inline int mptcp_sub_len_dss(const struct mp_dss *m)
 {
-	return 4 + m->A * (4 + m->a * 4) + m->M * (10 + m->m * 4 + csum * 2);
+	return 4 + m->A * (4 + m->a * 4) + m->M * (10 + m->m * 4);
 }
 =

 #define MPTCP_SYSCTL	1
 =

 extern int sysctl_mptcp_enabled;
 extern int sysctl_mptcp_version;
-extern int sysctl_mptcp_checksum;
 extern int sysctl_mptcp_debug;
 extern int sysctl_mptcp_syn_retries;
 =

@@ -693,10 +683,8 @@ enum
 	MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,/* Server-side fallback during 3-way h=
andshake */
 	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3-way h=
andshake */
 	MPTCP_MIB_MPCAPABLERETRANSFALLBACK,/* Client-side stopped sending MP_CAPA=
BLE after too many SYN-retransmissions */
-	MPTCP_MIB_CSUMENABLED,		/* Created MPTCP-connection with DSS-checksum ena=
bled */
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_MPFAILRX,		/* Received an MP_FAIL */
-	MPTCP_MIB_CSUMFAIL,		/* Received segment with invalid checksum */
 	MPTCP_MIB_FASTCLOSERX,		/* Recevied a FAST_CLOSE */
 	MPTCP_MIB_FASTCLOSETX,		/* Sent a FAST_CLOSE */
 	MPTCP_MIB_FBACKSUB,		/* Fallback upon ack without data-ack on new subflow=
 */
@@ -921,9 +909,6 @@ static inline bool mptcp_can_sendpage(struct sock *sk)
 {
 	struct mptcp_tcp_sock *mptcp;
 =

-	if (tcp_sk(sk)->mpcb->dss_csum)
-		return false;
-
 	mptcp_for_each_sub(tcp_sk(sk)->mpcb, mptcp) {
 		struct sock *sk_it =3D mptcp_to_sock(mptcp);
 =

@@ -1058,7 +1043,6 @@ static inline int is_master_tp(const struct tcp_sock =
*tp)
 static inline void mptcp_init_mp_opt(struct mptcp_options_received *mopt)
 {
 	mopt->saw_mpc =3D 0;
-	mopt->dss_csum =3D 0;
 	mopt->drop_me =3D 0;
 =

 	mopt->is_mp_join =3D 0;
@@ -1153,9 +1137,6 @@ static inline bool mptcp_can_sg(const struct sock *me=
ta_sk)
 {
 	struct mptcp_tcp_sock *mptcp;
 =

-	if (tcp_sk(meta_sk)->mpcb->dss_csum)
-		return false;
-
 	mptcp_for_each_sub(tcp_sk(meta_sk)->mpcb, mptcp) {
 		struct sock *sk =3D mptcp_to_sock(mptcp);
 =

diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 916438e31b59..1a04decc9578 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -30,7 +30,6 @@
 #include <net/inet_common.h>
 #include <net/inet6_hashtables.h>
 #include <net/ipv6.h>
-#include <net/ip6_checksum.h>
 #include <net/mptcp.h>
 #include <net/mptcp_v4.h>
 #if IS_ENABLED(CONFIG_IPV6)
@@ -67,7 +66,6 @@ int sysctl_mptcp_enabled __read_mostly =3D 1;
 int sysctl_mptcp_version __read_mostly =3D 0;
 static int min_mptcp_version;
 static int max_mptcp_version =3D 1;
-int sysctl_mptcp_checksum __read_mostly =3D 1;
 int sysctl_mptcp_debug __read_mostly;
 EXPORT_SYMBOL(sysctl_mptcp_debug);
 int sysctl_mptcp_syn_retries __read_mostly =3D 3;
@@ -132,13 +130,6 @@ static struct ctl_table mptcp_table[] =3D {
 		.extra1 =3D &min_mptcp_version,
 		.extra2 =3D &max_mptcp_version,
 	},
-	{
-		.procname =3D "mptcp_checksum",
-		.data =3D &sysctl_mptcp_checksum,
-		.maxlen =3D sizeof(int),
-		.mode =3D 0644,
-		.proc_handler =3D &proc_dointvec
-	},
 	{
 		.procname =3D "mptcp_debug",
 		.data =3D &sysctl_mptcp_debug,
@@ -2078,7 +2069,6 @@ static int __mptcp_check_req_master(struct sock *chil=
d,
 	child_tp->mptcp->snt_isn =3D tcp_rsk(req)->snt_isn;
 	child_tp->mptcp->rcv_isn =3D tcp_rsk(req)->rcv_isn;
 =

-	mpcb->dss_csum =3D mtreq->dss_csum;
 	mpcb->server_side =3D 1;
 =

 	/* Needs to be done here additionally, because when accepting a
@@ -2457,13 +2447,10 @@ void mptcp_reqsk_init(struct request_sock *req, con=
st struct sock *sk,
 		      const struct sk_buff *skb, bool want_cookie)
 {
 	struct mptcp_options_received mopt;
-	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
 =

 	mptcp_init_mp_opt(&mopt);
 	tcp_parse_mptcp_options(skb, &mopt);
 =

-	mtreq->dss_csum =3D mopt.dss_csum;
-
 	if (want_cookie) {
 		if (!mptcp_reqsk_new_cookie(req, sk, &mopt, skb))
 			/* No key available - back to regular TCP */
@@ -2500,7 +2487,6 @@ void mptcp_cookies_reqsk_init(struct request_sock *re=
q,
 	inet_rsk(req)->saw_mpc =3D 1;
 	mtreq->is_sub =3D 0;
 	inet_rsk(req)->mptcp_rqsk =3D 1;
-	mtreq->dss_csum =3D mopt->dss_csum;
 =

 out:
 	spin_unlock(&mptcp_tk_hashlock);
@@ -2771,10 +2757,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPCapableFallbackACK", MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
 	SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEFALLBAC=
K),
 	SNMP_MIB_ITEM("MPCapableRetransFallback", MPTCP_MIB_MPCAPABLERETRANSFALLB=
ACK),
-	SNMP_MIB_ITEM("MPTCPCsumEnabled", MPTCP_MIB_CSUMENABLED),
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPFailRX", MPTCP_MIB_MPFAILRX),
-	SNMP_MIB_ITEM("MPCsumFail", MPTCP_MIB_CSUMFAIL),
 	SNMP_MIB_ITEM("MPFastcloseRX", MPTCP_MIB_FASTCLOSERX),
 	SNMP_MIB_ITEM("MPFastcloseTX", MPTCP_MIB_FASTCLOSETX),
 	SNMP_MIB_ITEM("MPFallbackAckSub", MPTCP_MIB_FBACKSUB),
diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
index d2a605cbdd04..9a4d1609b3b9 100644
--- a/net/mptcp/mptcp_input.c
+++ b/net/mptcp/mptcp_input.c
@@ -269,133 +269,6 @@ static int mptcp_rcv_state_process(struct sock *meta_=
sk, struct sock *sk,
 	return 0;
 }
 =

-/**
- * @return:
- *  i) 1: Everything's fine.
- *  ii) -1: A reset has been sent on the subflow - csum-failure
- *  iii) 0: csum-failure but no reset sent, because it's the last subflow.
- *	 Last packet should not be destroyed by the caller because it has
- *	 been done here.
- */
-static int mptcp_verif_dss_csum(struct sock *sk)
-{
-	struct tcp_sock *tp =3D tcp_sk(sk);
-	struct sk_buff *tmp, *tmp1, *last =3D NULL;
-	__wsum csum_tcp =3D 0; /* cumulative checksum of pld + mptcp-header */
-	int ans =3D 1, overflowed =3D 0, offset =3D 0, dss_csum_added =3D 0;
-	int iter =3D 0;
-
-	skb_queue_walk_safe(&sk->sk_receive_queue, tmp, tmp1) {
-		unsigned int csum_len;
-
-		if (before(tp->mptcp->map_subseq + tp->mptcp->map_data_len, TCP_SKB_CB(t=
mp)->end_seq))
-			/* Mapping ends in the middle of the packet -
-			 * csum only these bytes
-			 */
-			csum_len =3D tp->mptcp->map_subseq + tp->mptcp->map_data_len - TCP_SKB_=
CB(tmp)->seq;
-		else
-			csum_len =3D tmp->len;
-
-		offset =3D 0;
-		if (overflowed) {
-			char first_word[4];
-			first_word[0] =3D 0;
-			first_word[1] =3D 0;
-			first_word[2] =3D 0;
-			first_word[3] =3D *(tmp->data);
-			csum_tcp =3D csum_partial(first_word, 4, csum_tcp);
-			offset =3D 1;
-			csum_len--;
-			overflowed =3D 0;
-		}
-
-		csum_tcp =3D skb_checksum(tmp, offset, csum_len, csum_tcp);
-
-		/* Was it on an odd-length? Then we have to merge the next byte
-		 * correctly (see above)
-		 */
-		if (csum_len !=3D (csum_len & (~1)))
-			overflowed =3D 1;
-
-		if (mptcp_is_data_seq(tmp) && !dss_csum_added) {
-			__be32 data_seq =3D htonl((u32)(tp->mptcp->map_data_seq >> 32));
-
-			/* If a 64-bit dss is present, we increase the offset
-			 * by 4 bytes, as the high-order 64-bits will be added
-			 * in the final csum_partial-call.
-			 */
-			u32 offset =3D skb_transport_offset(tmp) +
-				     TCP_SKB_CB(tmp)->dss_off;
-			if (TCP_SKB_CB(tmp)->mptcp_flags & MPTCPHDR_SEQ64_SET)
-				offset +=3D 4;
-
-			csum_tcp =3D skb_checksum(tmp, offset,
-						MPTCP_SUB_LEN_SEQ_CSUM,
-						csum_tcp);
-
-			csum_tcp =3D csum_partial(&data_seq,
-						sizeof(data_seq), csum_tcp);
-
-			dss_csum_added =3D 1; /* Just do it once */
-		}
-		last =3D tmp;
-		iter++;
-
-		if (!skb_queue_is_last(&sk->sk_receive_queue, tmp) &&
-		    !before(TCP_SKB_CB(tmp1)->seq,
-			    tp->mptcp->map_subseq + tp->mptcp->map_data_len))
-			break;
-	}
-
-	/* Now, checksum must be 0 */
-	if (unlikely(csum_fold(csum_tcp))) {
-		struct mptcp_tcp_sock *mptcp;
-		struct sock *sk_it =3D NULL;
-
-		pr_err("%s csum is wrong: %#x tcp-seq %u dss_csum_added %d overflowed %d=
 iterations %d\n",
-		       __func__, csum_fold(csum_tcp), TCP_SKB_CB(last)->seq,
-		       dss_csum_added, overflowed, iter);
-
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CSUMFAIL);
-		tp->mptcp->send_mp_fail =3D 1;
-
-		/* map_data_seq is the data-seq number of the
-		 * mapping we are currently checking
-		 */
-		tp->mpcb->csum_cutoff_seq =3D tp->mptcp->map_data_seq;
-
-		/* Search for another subflow that is fully established */
-		mptcp_for_each_sub(tp->mpcb, mptcp) {
-			sk_it =3D mptcp_to_sock(mptcp);
-
-			if (sk_it !=3D sk &&
-			    tcp_sk(sk_it)->mptcp->fully_established)
-				break;
-
-			sk_it =3D NULL;
-		}
-
-		if (sk_it) {
-			mptcp_send_reset(sk);
-			ans =3D -1;
-		} else {
-			tp->mpcb->send_infinite_mapping =3D 1;
-
-			/* Need to purge the rcv-queue as it's no more valid */
-			while ((tmp =3D __skb_dequeue(&sk->sk_receive_queue)) !=3D NULL) {
-				tp->copied_seq =3D TCP_SKB_CB(tmp)->end_seq;
-				kfree_skb(tmp);
-			}
-
-			mptcp_sub_force_close_all(tp->mpcb, sk);
-
-			ans =3D 0;
-		}
-	}
-
-	return ans;
-}
-
 static inline void mptcp_prepare_skb(struct sk_buff *skb,
 				     const struct sock *sk)
 {
@@ -710,10 +583,6 @@ static int mptcp_detect_mapping(struct sock *sk, struc=
t sk_buff *skb)
 		mpcb->infinite_mapping_rcv =3D 1;
 		mpcb->send_infinite_mapping =3D 1;
 		tp->mptcp->fully_established =3D 1;
-		/* We need to repeat mp_fail's until the sender felt
-		 * back to infinite-mapping - here we stop repeating it.
-		 */
-		tp->mptcp->send_mp_fail =3D 0;
 =

 		/* We have to fixup data_len - it must be the same as skb->len */
 		data_len =3D skb->len + (mptcp_is_data_fin(skb) ? 1 : 0);
@@ -735,17 +604,6 @@ static int mptcp_detect_mapping(struct sock *sk, struc=
t sk_buff *skb)
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_INFINITEMAPRX);
 	}
 =

-	/* We are sending mp-fail's and thus are in fallback mode.
-	 * Ignore packets which do not announce the fallback and still
-	 * want to provide a mapping.
-	 */
-	if (tp->mptcp->send_mp_fail) {
-		tp->copied_seq =3D TCP_SKB_CB(skb)->end_seq;
-		__skb_unlink(skb, &sk->sk_receive_queue);
-		__kfree_skb(skb);
-		return -1;
-	}
-
 	/* FIN increased the mapping-length by 1 */
 	if (mptcp_is_data_fin(skb))
 		data_len--;
@@ -957,16 +815,6 @@ static int mptcp_queue_skb(struct sock *sk)
 		mpcb->dfin_combined =3D !!(sk->sk_shutdown & RCV_SHUTDOWN);
 	}
 =

-	/* Verify the checksum */
-	if (mpcb->dss_csum && !mpcb->infinite_mapping_rcv) {
-		int ret =3D mptcp_verif_dss_csum(sk);
-
-		if (ret <=3D 0) {
-			mptcp_reset_mapping(tp, old_copied_seq);
-			return 1;
-		}
-	}
-
 	if (before64(rcv_nxt64, tp->mptcp->map_data_seq)) {
 		/* Seg's have to go to the meta-ofo-queue */
 		skb_queue_walk_safe(&sk->sk_receive_queue, tmp1, tmp) {
@@ -1605,6 +1453,10 @@ void mptcp_parse_options(const uint8_t *ptr, int ops=
ize,
 			break;
 		}
 =

+		/* We do not support DSS-checksums */
+		if (mpcapable->a)
+			break;
+
 		/* MPTCP-RFC 6824:
 		 * "If receiving a message with the 'B' flag set to 1, and this
 		 * is not understood, then this SYN MUST be silently ignored;
@@ -1622,7 +1474,6 @@ void mptcp_parse_options(const uint8_t *ptr, int opsi=
ze,
 			break;
 =

 		mopt->saw_mpc =3D 1;
-		mopt->dss_csum =3D sysctl_mptcp_checksum || mpcapable->a;
 =

 		if (opsize >=3D MPTCP_SUB_LEN_CAPABLE_SYN)
 			mopt->mptcp_sender_key =3D mpcapable->sender_key;
@@ -1677,15 +1528,7 @@ void mptcp_parse_options(const uint8_t *ptr, int ops=
ize,
 		const struct mp_dss *mdss =3D (struct mp_dss *)ptr;
 		struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
 =

-		/* We check opsize for the csum and non-csum case. We do this,
-		 * because the draft says that the csum SHOULD be ignored if
-		 * it has not been negotiated in the MP_CAPABLE but still is
-		 * present in the data.
-		 *
-		 * It will get ignored later in mptcp_queue_skb.
-		 */
-		if (opsize !=3D mptcp_sub_len_dss(mdss, 0) &&
-		    opsize !=3D mptcp_sub_len_dss(mdss, 1)) {
+		if (opsize !=3D mptcp_sub_len_dss(mdss)) {
 			mptcp_debug("%s: mp_dss: bad option size %d\n",
 				    __func__, opsize);
 			break;
@@ -1723,10 +1566,6 @@ void mptcp_parse_options(const uint8_t *ptr, int ops=
ize,
 =

 			tcb->mptcp_flags |=3D MPTCPHDR_SEQ;
 =

-			/* Is a check-sum present? */
-			if (opsize =3D=3D mptcp_sub_len_dss(mdss, 1))
-				tcb->mptcp_flags |=3D MPTCPHDR_DSS_CSUM;
-
 			/* DATA_FIN only possible with DSS-mapping */
 			if (mdss->F)
 				tcb->mptcp_flags |=3D MPTCPHDR_FIN;
@@ -2101,16 +1940,6 @@ bool mptcp_handle_options(struct sock *sk, const str=
uct tcphdr *th,
 	if (unlikely(mopt->mp_fail))
 		mptcp_mp_fail_rcvd(sk, th);
 =

-	/* RFC 6824, Section 3.3:
-	 * If a checksum is not present when its use has been negotiated, the
-	 * receiver MUST close the subflow with a RST as it is considered broken.
-	 */
-	if (mptcp_is_data_seq(skb) && tp->mpcb->dss_csum &&
-	    !(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_DSS_CSUM)) {
-		mptcp_send_reset(sk);
-		return true;
-	}
-
 	/* We have to acknowledge retransmissions of the third
 	 * ack.
 	 */
@@ -2290,9 +2119,6 @@ int mptcp_rcv_synsent_state_process(struct sock *sk, =
struct sock **skptr,
 		 * is not part of any mapping.
 		 */
 		tp->mptcp->snt_isn =3D tp->snd_una - 1;
-		tp->mpcb->dss_csum =3D mopt->dss_csum;
-		if (tp->mpcb->dss_csum)
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CSUMENABLED);
 =

 		tp->mptcp->include_mpc =3D 1;
 =

diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index 1de93c405c78..f9bce20259e9 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -407,22 +407,7 @@ static int mptcp_write_dss_mapping(const struct tcp_so=
ck *tp, const struct sk_bu
 	else
 		data_len =3D tcb->end_seq - tcb->seq;
 =

-	if (tp->mpcb->dss_csum && data_len) {
-		__be16 *p16 =3D (__be16 *)ptr;
-		__be32 hdseq =3D mptcp_get_highorder_sndbits(skb, tp->mpcb);
-		__wsum csum;
-
-		*ptr =3D htonl(((data_len) << 16) |
-			     (TCPOPT_EOL << 8) |
-			     (TCPOPT_EOL));
-		csum =3D csum_partial(ptr - 2, 12, skb->csum);
-		p16++;
-		*p16++ =3D csum_fold(csum_partial(&hdseq, sizeof(hdseq), csum));
-	} else {
-		*ptr++ =3D htonl(((data_len) << 16) |
-			       (TCPOPT_NOP << 8) |
-			       (TCPOPT_NOP));
-	}
+	*ptr++ =3D htonl(((data_len) << 16) | (TCPOPT_NOP << 8) | (TCPOPT_NOP));
 =

 	return ptr - start;
 }
@@ -442,7 +427,7 @@ static int mptcp_write_dss_data_ack(const struct tcp_so=
ck *tp, const struct sk_b
 	mdss->M =3D mptcp_is_data_seq(skb) ? 1 : 0;
 	mdss->a =3D 0;
 	mdss->A =3D 1;
-	mdss->len =3D mptcp_sub_len_dss(mdss, tp->mpcb->dss_csum);
+	mdss->len =3D mptcp_sub_len_dss(mdss);
 	ptr++;
 =

 	*ptr++ =3D htonl(mptcp_meta_tp(tp)->rcv_nxt);
@@ -456,10 +441,6 @@ static int mptcp_write_dss_data_ack(const struct tcp_s=
ock *tp, const struct sk_b
  * arguably means that we would change the mapping (e.g. it splits it,
  * our sends out a subset of the initial mapping).
  *
- * Furthermore, the skb checksum is not always preserved across splits
- * (e.g. mptcp_fragment) which would mean that we need to recompute
- * the DSS checksum in this case.
- *
  * To avoid this we save the initial DSS mapping which allows us to
  * send the same DSS mapping even for fragmented retransmits.
  */
@@ -519,10 +500,6 @@ static bool mptcp_skb_entail(struct sock *sk, struct s=
k_buff *skb, int reinject)
 =

 	TCP_SKB_CB(skb)->path_mask |=3D mptcp_pi_to_flag(tp->mptcp->path_index);
 =

-	/* Compute checksum */
-	if (tp->mpcb->dss_csum)
-		subskb->csum =3D skb->csum =3D skb_checksum(skb, 0, skb->len, 0);
-
 	tcb =3D TCP_SKB_CB(subskb);
 =

 	if (tp->mpcb->send_infinite_mapping &&
@@ -977,7 +954,6 @@ void mptcp_syn_options(const struct sock *sk, struct tc=
p_out_options *opts,
 		opts->mptcp_ver =3D tcp_sk(sk)->mptcp_ver;
 		*remaining -=3D MPTCP_SUB_LEN_CAPABLE_SYN_ALIGN;
 		opts->mp_capable.sender_key =3D tp->mptcp_loc_key;
-		opts->dss_csum =3D !!sysctl_mptcp_checksum;
 	} else {
 		const struct mptcp_cb *mpcb =3D tp->mpcb;
 =

@@ -1002,7 +978,6 @@ void mptcp_synack_options(struct request_sock *req,
 		opts->mptcp_options |=3D OPTION_MP_CAPABLE | OPTION_TYPE_SYNACK;
 		opts->mptcp_ver =3D mtreq->mptcp_ver;
 		opts->mp_capable.sender_key =3D mtreq->mptcp_loc_key;
-		opts->dss_csum =3D !!sysctl_mptcp_checksum || mtreq->dss_csum;
 		*remaining -=3D MPTCP_SUB_LEN_CAPABLE_SYN_ALIGN;
 	} else {
 		opts->mptcp_options |=3D OPTION_MP_JOIN | OPTION_TYPE_SYNACK;
@@ -1070,7 +1045,6 @@ void mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
 		opts->mptcp_ver =3D mpcb->mptcp_ver;
 		opts->mp_capable.sender_key =3D mpcb->mptcp_loc_key;
 		opts->mp_capable.receiver_key =3D mpcb->mptcp_rem_key;
-		opts->dss_csum =3D mpcb->dss_csum;
 =

 		if (skb)
 			tp->mptcp->include_mpc =3D 0;
@@ -1100,9 +1074,6 @@ void mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
 		if (skb && !mptcp_is_data_seq(skb)) {
 			*size +=3D MPTCP_SUB_LEN_ACK_ALIGN;
 		} else {
-			/* Doesn't matter, if csum included or not. It will be
-			 * either 10 or 12, and thus aligned =3D 12
-			 */
 			*size +=3D MPTCP_SUB_LEN_ACK_ALIGN +
 				 MPTCP_SUB_LEN_SEQ_ALIGN;
 		}
@@ -1110,16 +1081,6 @@ void mptcp_established_options(struct sock *sk, stru=
ct sk_buff *skb,
 		*size +=3D MPTCP_SUB_LEN_DSS_ALIGN;
 	}
 =

-	/* In fallback mp_fail-mode, we have to repeat it until the fallback
-	 * has been done by the sender
-	 */
-	if (unlikely(tp->mptcp->send_mp_fail) && skb &&
-	    MAX_TCP_OPTION_SPACE - *size >=3D MPTCP_SUB_LEN_FAIL) {
-		opts->options |=3D OPTION_MPTCP;
-		opts->mptcp_options |=3D OPTION_MP_FAIL;
-		*size +=3D MPTCP_SUB_LEN_FAIL;
-	}
-
 	if (unlikely(mpcb->addr_signal) && mpcb->pm_ops->addr_signal &&
 	    mpcb->mptcp_ver < MPTCP_VERSION_1)
 		mpcb->pm_ops->addr_signal(sk, size, opts, skb);
@@ -1172,7 +1133,7 @@ void mptcp_options_write(__be32 *ptr, struct tcp_sock=
 *tp,
 		}
 =

 		mpc->sub =3D MPTCP_SUB_CAPABLE;
-		mpc->a =3D opts->dss_csum;
+		mpc->a =3D 0;
 		mpc->b =3D 0;
 		mpc->rsv =3D 0;
 		mpc->h =3D 1;
@@ -1272,18 +1233,6 @@ void mptcp_options_write(__be32 *ptr, struct tcp_soc=
k *tp,
 =

 		MPTCP_INC_STATS(sock_net((struct sock *)tp), MPTCP_MIB_REMADDRTX);
 	}
-	if (unlikely(OPTION_MP_FAIL & opts->mptcp_options)) {
-		struct mp_fail *mpfail =3D (struct mp_fail *)ptr;
-
-		mpfail->kind =3D TCPOPT_MPTCP;
-		mpfail->len =3D MPTCP_SUB_LEN_FAIL;
-		mpfail->sub =3D MPTCP_SUB_FAIL;
-		mpfail->rsv1 =3D 0;
-		mpfail->rsv2 =3D 0;
-		mpfail->data_seq =3D htonll(tp->mpcb->csum_cutoff_seq);
-
-		ptr +=3D MPTCP_SUB_LEN_FAIL_ALIGN >> 2;
-	}
 	if (unlikely(OPTION_MP_FCLOSE & opts->mptcp_options)) {
 		struct mp_fclose *mpfclose =3D (struct mp_fclose *)ptr;
 =

@@ -1848,15 +1797,7 @@ int mptcp_select_size(const struct sock *meta_sk, bo=
ol first_skb, bool zc)
 		if (zc)
 			return 0;
 =

-		if (!tcp_sk(meta_sk)->mpcb->dss_csum) {
-			mss =3D linear_payload_sz(first_skb);
-		} else {
-			int pgbreak =3D SKB_MAX_HEAD(MAX_TCP_HEADER);
-
-			if (mss >=3D pgbreak &&
-			    mss <=3D pgbreak + (MAX_SKB_FRAGS - 1) * PAGE_SIZE)
-				mss =3D pgbreak;
-		}
+		mss =3D linear_payload_sz(first_skb);
 	}
 =

 	return !mss ? tcp_sk(meta_sk)->mss_cache : mss;
@@ -1893,7 +1834,7 @@ unsigned int mptcp_xmit_size_goal(const struct sock *=
meta_sk, u32 mss_now,
 {
 	u32 xmit_size_goal =3D 0;
 =

-	if (large_allowed && !tcp_sk(meta_sk)->mpcb->dss_csum) {
+	if (large_allowed) {
 		struct mptcp_tcp_sock *mptcp;
 =

 		mptcp_for_each_sub(tcp_sk(meta_sk)->mpcb, mptcp) {
-- =

2.16.2


--===============1680808130594094292==--
