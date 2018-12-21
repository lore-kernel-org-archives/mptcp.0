Content-Type: multipart/mixed; boundary="===============0052027621677873607=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 mptcp-net-next 06/12] mptcp: Remove reinjection of
 data across subflows
Date: Fri, 21 Dec 2018 08:13:32 -0800
Message-ID: <20181221161338.72325-7-cpaasch@apple.com>
In-Reply-To: 20181221161338.72325-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 960

--===============0052027621677873607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It's an "optimisation" that we don't need in net-next.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/linux/tcp.h        |   3 -
 include/net/mptcp.h        |   9 --
 net/mptcp/mptcp_ctrl.c     |  10 +-
 net/mptcp/mptcp_fullmesh.c |  12 --
 net/mptcp/mptcp_input.c    |  20 +--
 net/mptcp/mptcp_output.c   | 358 +----------------------------------------=
----
 net/mptcp/mptcp_sched.c    |  32 ++--
 7 files changed, 21 insertions(+), 423 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index cc896f842c31..6dd9c45c52d6 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -470,9 +470,6 @@ struct tcp_sock {
 		request_mptcp:1, /* Did we send out an MP_CAPABLE?
 				  * (this speeds up mptcp_doit() in tcp_recvmsg)
 				  */
-		pf:1, /* Potentially Failed state: when this flag is set, we
-		       * stop using the subflow
-		       */
 		mp_killed:1, /* Killed with a tcp_done in mptcp? */
 		was_meta_sk:1,	/* This was a meta sk (in case of reuse) */
 		is_master_sk:1,
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 9e7dd681fb71..5e3fc3e7adba 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -265,12 +265,6 @@ struct mptcp_cb {
 	u8 mptcp_sched[MPTCP_SCHED_DATA_SIZE] __aligned(8);
 	struct mptcp_sched_ops *sched_ops;
 =

-	struct sk_buff_head reinject_queue;
-	/* First cache-line boundary is here minus 8 bytes. But from the
-	 * reinject-queue only the next and prev pointers are regularly
-	 * accessed. Thus, the whole data-path is on a single cache-line.
-	 */
-
 	u64	infinite_rcv_seq;
 =

 	/***** Start of fields, used for connection closure */
@@ -421,7 +415,6 @@ extern bool mptcp_init_failed;
 #define MPTCPHDR_SEQ64_OFO	0x20 /* Is it not in our circular array? */
 /* MPTCP flags: TX only */
 #define MPTCPHDR_INF		0x08
-#define MPTCP_REINJECT		0x10 /* Did we reinject this segment? */
 =

 struct mptcp_option {
 	__u8	kind;
@@ -719,7 +712,6 @@ int mptcp_add_sock(struct sock *meta_sk, struct sock *s=
k, u8 loc_id, u8 rem_id,
 		   gfp_t flags);
 void mptcp_del_sock(struct sock *sk);
 void mptcp_update_metasocket(const struct sock *meta_sk);
-void mptcp_reinject_data(struct sock *orig_sk, int clone_it);
 void mptcp_update_sndbuf(const struct tcp_sock *tp);
 void mptcp_send_fin(struct sock *meta_sk);
 void mptcp_send_active_reset(struct sock *meta_sk, gfp_t priority);
@@ -1256,7 +1248,6 @@ static inline int is_master_tp(const struct tcp_sock =
*tp)
 }
 static inline void mptcp_del_sock(const struct sock *sk) {}
 static inline void mptcp_update_metasocket(const struct sock *meta_sk) {}
-static inline void mptcp_reinject_data(struct sock *orig_sk, int clone_it)=
 {}
 static inline void mptcp_update_sndbuf(const struct tcp_sock *tp) {}
 static inline void mptcp_clean_rtx_infinite(const struct sk_buff *skb,
 					    const struct sock *sk) {}
diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 16d388fa9454..92c2bf6e6431 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -561,7 +561,7 @@ struct sock *mptcp_select_ack_sock(const struct sock *m=
eta_sk)
 		struct tcp_sock *tp =3D tcp_sk(sk);
 		u32 elapsed;
 =

-		if (!mptcp_sk_can_send_ack(sk) || tp->pf)
+		if (!mptcp_sk_can_send_ack(sk) || inet_csk(sk)->icsk_ca_state =3D=3D TCP=
_CA_Loss)
 			continue;
 =

 		elapsed =3D keepalive_time_elapsed(tp);
@@ -693,8 +693,6 @@ void mptcp_destroy_sock(struct sock *sk)
 		struct mptcp_tcp_sock *mptcp;
 		struct hlist_node *tmp;
 =

-		__skb_queue_purge(&tcp_sk(sk)->mpcb->reinject_queue);
-
 		/* We have to close all remaining subflows. Normally, they
 		 * should all be about to get closed. But, if the kernel is
 		 * forcing a closure (e.g., tcp_write_err), the subflows might
@@ -1230,7 +1228,6 @@ static int mptcp_alloc_mpcb(struct sock *meta_sk, __u=
64 remote_key,
 	meta_tp->was_meta_sk =3D 0;
 =

 	/* Initialize the queues */
-	skb_queue_head_init(&mpcb->reinject_queue);
 	master_tp->out_of_order_queue =3D RB_ROOT;
 	master_sk->tcp_rtx_queue =3D RB_ROOT;
 	INIT_LIST_HEAD(&master_tp->tsq_node);
@@ -1461,9 +1458,6 @@ void mptcp_del_sock(struct sock *sk)
 	tp->mptcp->attached =3D 0;
 	mpcb->path_index_bits &=3D ~(1 << tp->mptcp->path_index);
 =

-	if (!tcp_write_queue_empty(sk) || !tcp_rtx_queue_empty(sk))
-		mptcp_reinject_data(sk, 0);
-
 	if (is_master_tp(tp)) {
 		struct sock *meta_sk =3D mptcp_meta_sk(sk);
 		struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
@@ -1921,8 +1915,6 @@ void mptcp_disconnect(struct sock *sk)
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct hlist_node *tmp;
 =

-	__skb_queue_purge(&tp->mpcb->reinject_queue);
-
 	if (tp->inside_tk_table)
 		mptcp_hash_remove_bh(tp);
 =

diff --git a/net/mptcp/mptcp_fullmesh.c b/net/mptcp/mptcp_fullmesh.c
index 4dad457246b1..2446f75b0b2c 100644
--- a/net/mptcp/mptcp_fullmesh.c
+++ b/net/mptcp/mptcp_fullmesh.c
@@ -923,12 +923,6 @@ static void mptcp_address_worker(struct work_struct *w=
ork)
 					    !ipv6_addr_equal(&inet6_sk(sk)->saddr, &event->addr.in6))
 						continue;
 =

-					/* Reinject, so that pf =3D 1 and so we
-					 * won't select this one as the
-					 * ack-sock.
-					 */
-					mptcp_reinject_data(sk, 0);
-
 					/* We announce the removal of this id */
 					announce_remove_addr(tcp_sk(sk)->mptcp->loc_id, meta_sk);
 =

@@ -1440,12 +1434,6 @@ static void full_mesh_release_sock(struct sock *meta=
_sk)
 		}
 =

 		if (shall_remove) {
-			/* Reinject, so that pf =3D 1 and so we
-			 * won't select this one as the
-			 * ack-sock.
-			 */
-			mptcp_reinject_data(sk, 0);
-
 			announce_remove_addr(tcp_sk(sk)->mptcp->loc_id,
 					     meta_sk);
 =

diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
index 652da0439644..f247e9ef2853 100644
--- a/net/mptcp/mptcp_input.c
+++ b/net/mptcp/mptcp_input.c
@@ -92,7 +92,7 @@ static inline int mptcp_tso_acked_reinject(const struct s=
ock *meta_sk,
 /* Cleans the meta-socket retransmission queue and the reinject-queue. */
 static void mptcp_clean_rtx_queue(struct sock *meta_sk, u32 prior_snd_una)
 {
-	struct sk_buff *skb, *tmp, *next;
+	struct sk_buff *skb, *next;
 	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
 	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
 	bool acked =3D false;
@@ -149,20 +149,6 @@ static void mptcp_clean_rtx_queue(struct sock *meta_sk=
, u32 prior_snd_una)
 		}
 		sk_wmem_free_skb(meta_sk, skb);
 	}
-	/* Remove acknowledged data from the reinject queue */
-	skb_queue_walk_safe(&mpcb->reinject_queue, skb, tmp) {
-		if (before(meta_tp->snd_una, TCP_SKB_CB(skb)->end_seq)) {
-			if (tcp_skb_pcount(skb) =3D=3D 1 ||
-			    !after(meta_tp->snd_una, TCP_SKB_CB(skb)->seq))
-				break;
-
-			mptcp_tso_acked_reinject(meta_sk, skb);
-			break;
-		}
-
-		__skb_unlink(skb, &mpcb->reinject_queue);
-		__kfree_skb(skb);
-	}
 =

 	if (likely(between(meta_tp->snd_up, prior_snd_una, meta_tp->snd_una)))
 		meta_tp->snd_up =3D meta_tp->snd_una;
@@ -1242,9 +1228,6 @@ static void mptcp_data_ack(struct sock *sk, const str=
uct sk_buff *skb)
 	u32 nwin, data_ack, data_seq;
 	u16 data_len =3D 0;
 =

-	/* A valid packet came in - subflow is operational again */
-	tp->pf =3D 0;
-
 	/* Even if there is no data-ack, we stop retransmitting.
 	 * Except if this is a SYN/ACK. Then it is just a retransmission
 	 */
@@ -1400,7 +1383,6 @@ static void mptcp_send_reset_rem_id(const struct mptc=
p_cb *mpcb, u8 rem_id)
 		struct sock *sk_it =3D mptcp_to_sock(mptcp);
 =

 		if (tcp_sk(sk_it)->mptcp->rem_id =3D=3D rem_id) {
-			mptcp_reinject_data(sk_it, 0);
 			mptcp_send_reset(sk_it);
 		}
 	}
diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index af695fafaab2..26cf41f75922 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -54,309 +54,6 @@ int mptcp_sub_len_remove_addr_align(u16 bitfield)
 }
 EXPORT_SYMBOL(mptcp_sub_len_remove_addr_align);
 =

-/* get the data-seq and end-data-seq and store them again in the
- * tcp_skb_cb
- */
-static bool mptcp_reconstruct_mapping(struct sk_buff *skb)
-{
-	const struct mp_dss *mpdss =3D (struct mp_dss *)TCP_SKB_CB(skb)->dss;
-	u32 *p32;
-	u16 *p16;
-
-	if (!mptcp_is_data_seq(skb))
-		return false;
-
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
-
-	return true;
-}
-
-static bool mptcp_is_reinjected(const struct sk_buff *skb)
-{
-	return TCP_SKB_CB(skb)->mptcp_flags & MPTCP_REINJECT;
-}
-
-static void mptcp_find_and_set_pathmask(struct sock *meta_sk, struct sk_bu=
ff *skb)
-{
-	struct rb_node **p =3D &meta_sk->tcp_rtx_queue.rb_node;
-	struct rb_node *parent;
-	struct sk_buff *skb_it;
-
-	while (*p) {
-		parent =3D *p;
-		skb_it =3D rb_to_skb(parent);
-		if (before(TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb_it)->seq)) {
-			p =3D &parent->rb_left;
-			continue;
-		}
-		if (after(TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb_it)->seq)) {
-			p =3D &parent->rb_right;
-			continue;
-		}
-
-		TCP_SKB_CB(skb)->path_mask =3D TCP_SKB_CB(skb_it)->path_mask;
-		break;
-	}
-}
-
-/* Reinject data from one TCP subflow to the meta_sk. If sk =3D=3D NULL, w=
e are
- * coming from the meta-retransmit-timer
- */
-static void __mptcp_reinject_data(struct sk_buff *orig_skb, struct sock *m=
eta_sk,
-				  struct sock *sk, int clone_it,
-				  enum tcp_queue tcp_queue)
-{
-	struct sk_buff *skb, *skb1;
-	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
-	u32 seq, end_seq;
-
-	if (clone_it) {
-		/* pskb_copy is necessary here, because the TCP/IP-headers
-		 * will be changed when it's going to be reinjected on another
-		 * subflow.
-		 */
-		tcp_skb_tsorted_save(orig_skb) {
-			skb =3D pskb_copy_for_clone(orig_skb, GFP_ATOMIC);
-		} tcp_skb_tsorted_restore(orig_skb);
-	} else {
-		if (tcp_queue =3D=3D TCP_FRAG_IN_WRITE_QUEUE)
-			__skb_unlink(orig_skb, &sk->sk_write_queue);
-		else
-			rb_erase(&orig_skb->rbnode, &sk->tcp_rtx_queue);
-		sock_set_flag(sk, SOCK_QUEUE_SHRUNK);
-		sk->sk_wmem_queued -=3D orig_skb->truesize;
-		sk_mem_uncharge(sk, orig_skb->truesize);
-		skb =3D orig_skb;
-	}
-	if (unlikely(!skb))
-		return;
-
-	if (sk && !mptcp_reconstruct_mapping(skb)) {
-		__kfree_skb(skb);
-		return;
-	}
-
-	skb->sk =3D meta_sk;
-
-	/* Make sure that this list is clean */
-	tcp_skb_tsorted_anchor_cleanup(skb);
-
-	/* Reset subflow-specific TCP control-data */
-	TCP_SKB_CB(skb)->sacked =3D 0;
-	TCP_SKB_CB(skb)->tcp_flags &=3D (TCPHDR_ACK | TCPHDR_PSH);
-
-	/* If it reached already the destination, we don't have to reinject it */
-	if (!after(TCP_SKB_CB(skb)->end_seq, meta_tp->snd_una)) {
-		__kfree_skb(skb);
-		return;
-	}
-
-	/* Only reinject segments that are fully covered by the mapping */
-	if (skb->len + (mptcp_is_data_fin(skb) ? 1 : 0) !=3D
-	    TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)->seq) {
-		struct rb_node *parent, **p =3D &meta_sk->tcp_rtx_queue.rb_node;
-		u32 end_seq =3D TCP_SKB_CB(skb)->end_seq;
-		u32 seq =3D TCP_SKB_CB(skb)->seq;
-
-		__kfree_skb(skb);
-
-		/* Ok, now we have to look for the full mapping in the meta
-		 * send-queue :S
-		 */
-
-		/* First, find the first skb that covers us */
-		while (*p) {
-			parent =3D *p;
-			skb =3D rb_to_skb(parent);
-
-			/* Not yet at the mapping? */
-			if (!after(end_seq, TCP_SKB_CB(skb)->seq)) {
-				p =3D &parent->rb_left;
-				continue;
-			}
-
-			if (!before(seq, TCP_SKB_CB(skb)->end_seq)) {
-				p =3D &parent->rb_right;
-				continue;
-			}
-
-			break;
-		}
-
-		if (*p) {
-			/* We found it, now let's reinject everything */
-			skb =3D rb_to_skb(*p);
-
-			skb_rbtree_walk_from(skb) {
-				if (after(TCP_SKB_CB(skb)->end_seq, end_seq))
-					return;
-				__mptcp_reinject_data(skb, meta_sk, NULL, 1,
-						      TCP_FRAG_IN_RTX_QUEUE);
-			}
-		}
-		return;
-	}
-
-	/* Segment goes back to the MPTCP-layer. So, we need to zero the
-	 * path_mask/dss.
-	 */
-	memset(TCP_SKB_CB(skb)->dss, 0 , mptcp_dss_len);
-
-	/* We need to find out the path-mask from the meta-write-queue
-	 * to properly select a subflow.
-	 */
-	mptcp_find_and_set_pathmask(meta_sk, skb);
-
-	/* If it's empty, just add */
-	if (skb_queue_empty(&mpcb->reinject_queue)) {
-		skb_queue_head(&mpcb->reinject_queue, skb);
-		return;
-	}
-
-	/* Find place to insert skb - or even we can 'drop' it, as the
-	 * data is already covered by other skb's in the reinject-queue.
-	 *
-	 * This is inspired by code from tcp_data_queue.
-	 */
-
-	skb1 =3D skb_peek_tail(&mpcb->reinject_queue);
-	seq =3D TCP_SKB_CB(skb)->seq;
-	while (1) {
-		if (!after(TCP_SKB_CB(skb1)->seq, seq))
-			break;
-		if (skb_queue_is_first(&mpcb->reinject_queue, skb1)) {
-			skb1 =3D NULL;
-			break;
-		}
-		skb1 =3D skb_queue_prev(&mpcb->reinject_queue, skb1);
-	}
-
-	/* Do skb overlap to previous one? */
-	end_seq =3D TCP_SKB_CB(skb)->end_seq;
-	if (skb1 && before(seq, TCP_SKB_CB(skb1)->end_seq)) {
-		if (!after(end_seq, TCP_SKB_CB(skb1)->end_seq)) {
-			/* All the bits are present. Don't reinject */
-			__kfree_skb(skb);
-			return;
-		}
-		if (seq =3D=3D TCP_SKB_CB(skb1)->seq) {
-			if (skb_queue_is_first(&mpcb->reinject_queue, skb1))
-				skb1 =3D NULL;
-			else
-				skb1 =3D skb_queue_prev(&mpcb->reinject_queue, skb1);
-		}
-	}
-	if (!skb1)
-		__skb_queue_head(&mpcb->reinject_queue, skb);
-	else
-		__skb_queue_after(&mpcb->reinject_queue, skb1, skb);
-
-	/* And clean segments covered by new one as whole. */
-	while (!skb_queue_is_last(&mpcb->reinject_queue, skb)) {
-		skb1 =3D skb_queue_next(&mpcb->reinject_queue, skb);
-
-		if (!after(end_seq, TCP_SKB_CB(skb1)->seq))
-			break;
-
-		if (before(end_seq, TCP_SKB_CB(skb1)->end_seq))
-			break;
-
-		__skb_unlink(skb1, &mpcb->reinject_queue);
-		__kfree_skb(skb1);
-	}
-	return;
-}
-
-/* Inserts data into the reinject queue */
-void mptcp_reinject_data(struct sock *sk, int clone_it)
-{
-	struct sock *meta_sk =3D mptcp_meta_sk(sk);
-	struct sk_buff *skb_it, *tmp;
-	enum tcp_queue tcp_queue;
-
-	/* It has already been closed - there is really no point in reinjecting */
-	if (meta_sk->sk_state =3D=3D TCP_CLOSE)
-		return;
-
-	skb_queue_walk_safe(&sk->sk_write_queue, skb_it, tmp) {
-		struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb_it);
-		/* Subflow syn's and fin's are not reinjected.
-		 *
-		 * As well as empty subflow-fins with a data-fin.
-		 * They are reinjected below (without the subflow-fin-flag)
-		 */
-		if (tcb->tcp_flags & TCPHDR_SYN ||
-		    (tcb->tcp_flags & TCPHDR_FIN && !mptcp_is_data_fin(skb_it)) ||
-		    (tcb->tcp_flags & TCPHDR_FIN && mptcp_is_data_fin(skb_it) && !skb_it=
->len))
-			continue;
-
-		if (mptcp_is_reinjected(skb_it))
-			continue;
-
-		tcb->mptcp_flags |=3D MPTCP_REINJECT;
-		__mptcp_reinject_data(skb_it, meta_sk, sk, clone_it,
-				      TCP_FRAG_IN_WRITE_QUEUE);
-	}
-
-	skb_rbtree_walk_safe(skb_it, &sk->tcp_rtx_queue, tmp) {
-		struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb_it);
-		/* Subflow syn's and fin's are not reinjected.
-		 *
-		 * As well as empty subflow-fins with a data-fin.
-		 * They are reinjected below (without the subflow-fin-flag)
-		 */
-		if (tcb->tcp_flags & TCPHDR_SYN ||
-		    (tcb->tcp_flags & TCPHDR_FIN && !mptcp_is_data_fin(skb_it)) ||
-		    (tcb->tcp_flags & TCPHDR_FIN && mptcp_is_data_fin(skb_it) && !skb_it=
->len))
-			continue;
-
-		if (mptcp_is_reinjected(skb_it))
-			continue;
-
-		tcb->mptcp_flags |=3D MPTCP_REINJECT;
-		__mptcp_reinject_data(skb_it, meta_sk, sk, clone_it,
-				      TCP_FRAG_IN_RTX_QUEUE);
-	}
-
-	skb_it =3D tcp_write_queue_tail(meta_sk);
-	tcp_queue =3D TCP_FRAG_IN_WRITE_QUEUE;
-
-	if (!skb_it) {
-		skb_it =3D skb_rb_last(&meta_sk->tcp_rtx_queue);
-		tcp_queue =3D TCP_FRAG_IN_RTX_QUEUE;
-	}
-
-	/* If sk has sent the empty data-fin, we have to reinject it too. */
-	if (skb_it && mptcp_is_data_fin(skb_it) && skb_it->len =3D=3D 0 &&
-	    TCP_SKB_CB(skb_it)->path_mask & mptcp_pi_to_flag(tcp_sk(sk)->mptcp->p=
ath_index)) {
-		__mptcp_reinject_data(skb_it, meta_sk, NULL, 1, tcp_queue);
-	}
-
-	tcp_sk(sk)->pf =3D 1;
-
-	mptcp_push_pending_frames(meta_sk);
-}
-EXPORT_SYMBOL(mptcp_reinject_data);
-
 static void mptcp_combine_dfin(const struct sk_buff *skb,
 			       const struct sock *meta_sk,
 			       struct sock *subsk)
@@ -560,8 +257,7 @@ static bool mptcp_skb_entail(struct sock *sk, struct sk=
_buff *skb, int reinject)
  * - The reinject-queue (reinject =3D=3D -1)
  */
 static int mptcp_fragment(struct sock *meta_sk, enum tcp_queue tcp_queue,
-			  struct sk_buff *skb, u32 len,
-			  gfp_t gfp, int reinject)
+			  struct sk_buff *skb, u32 len, gfp_t gfp)
 {
 	int ret, diff, old_factor;
 	struct sk_buff *buff;
@@ -592,34 +288,6 @@ static int mptcp_fragment(struct sock *meta_sk, enum t=
cp_queue tcp_queue,
 	TCP_SKB_CB(buff)->mptcp_flags =3D flags;
 	TCP_SKB_CB(buff)->path_mask =3D TCP_SKB_CB(skb)->path_mask;
 =

-	/* If reinject =3D=3D 1, the buff will be added to the reinject
-	 * queue, which is currently not part of memory accounting. So
-	 * undo the changes done by tcp_fragment and update the
-	 * reinject queue. Also, undo changes to the packet counters.
-	 */
-	if (reinject =3D=3D 1) {
-		int undo =3D buff->truesize - diff;
-		meta_sk->sk_wmem_queued -=3D undo;
-		sk_mem_uncharge(meta_sk, undo);
-
-		tcp_sk(meta_sk)->mpcb->reinject_queue.qlen++;
-		if (tcp_queue =3D=3D TCP_FRAG_IN_WRITE_QUEUE)
-			meta_sk->sk_write_queue.qlen--;
-
-		if (!before(tcp_sk(meta_sk)->snd_nxt, TCP_SKB_CB(buff)->end_seq)) {
-			undo =3D old_factor - tcp_skb_pcount(skb) -
-				tcp_skb_pcount(buff);
-			if (undo)
-				tcp_adjust_pcount(meta_sk, skb, -undo);
-		}
-
-		/* tcp_fragment's call to sk_stream_alloc_skb initializes the
-		 * tcp_tsorted_anchor. We need to revert this as it clashes
-		 * with the refdst pointer.
-		 */
-		tcp_skb_tsorted_anchor_cleanup(buff);
-	}
-
 	return 0;
 }
 =

@@ -663,7 +331,7 @@ int mptcp_write_wakeup(struct sock *meta_sk, int mib)
 			seg_size =3D min(seg_size, mss);
 			TCP_SKB_CB(skb)->tcp_flags |=3D TCPHDR_PSH;
 			if (mptcp_fragment(meta_sk, TCP_FRAG_IN_WRITE_QUEUE,
-					   skb, seg_size, GFP_ATOMIC, 0))
+					   skb, seg_size, GFP_ATOMIC))
 				return -1;
 		} else if (!tcp_skb_pcount(skb)) {
 			/* see mptcp_write_xmit on why we use UINT_MAX */
@@ -738,14 +406,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned i=
nt mss_now, int nonagle,
 		subtp =3D tcp_sk(subsk);
 		mss_now =3D tcp_current_mss(subsk);
 =

-		if (reinject =3D=3D 1) {
-			if (!after(TCP_SKB_CB(skb)->end_seq, meta_tp->snd_una)) {
-				/* Segment already reached the peer, take the next one */
-				__skb_unlink(skb, &mpcb->reinject_queue);
-				__kfree_skb(skb);
-				continue;
-			}
-		} else if (reinject =3D=3D -1) {
+		if (reinject =3D=3D -1) {
 			tcp_queue =3D TCP_FRAG_IN_RTX_QUEUE;
 		}
 =

@@ -810,7 +471,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned in=
t mss_now, int nonagle,
 =

 		if (skb->len > limit &&
 		    unlikely(mptcp_fragment(meta_sk, tcp_queue,
-					    skb, limit, gfp, reinject)))
+					    skb, limit, gfp)))
 			break;
 =

 		if (!mptcp_skb_entail(subsk, skb, reinject))
@@ -833,11 +494,6 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned i=
nt mss_now, int nonagle,
 =

 		tcp_minshall_update(meta_tp, mss_now, skb);
 =

-		if (reinject > 0) {
-			__skb_unlink(skb, &mpcb->reinject_queue);
-			kfree_skb(skb);
-		}
-
 		if (push_one)
 			break;
 	}
@@ -1488,7 +1144,7 @@ int mptcp_retransmit_skb(struct sock *meta_sk, struct=
 sk_buff *skb)
 =

 	if (skb->len > limit &&
 	    unlikely(mptcp_fragment(meta_sk, TCP_FRAG_IN_RTX_QUEUE, skb,
-				    limit, GFP_ATOMIC, 0)))
+				    limit, GFP_ATOMIC)))
 		goto failed;
 =

 	if (!mptcp_skb_entail(subsk, skb, -1))
@@ -1640,10 +1296,8 @@ void mptcp_sub_retransmit_timer(struct sock *sk)
 =

 	tcp_retransmit_timer(sk);
 =

-	if (!tp->fastopen_rsk) {
-		mptcp_reinject_data(sk, 1);
+	if (!tp->fastopen_rsk)
 		mptcp_set_rto(sk);
-	}
 }
 =

 /* Modify values to an mptcp-level for the initial window of new subflows =
*/
diff --git a/net/mptcp/mptcp_sched.c b/net/mptcp/mptcp_sched.c
index 7d4804f8ba91..7f19b4b4bea0 100644
--- a/net/mptcp/mptcp_sched.c
+++ b/net/mptcp/mptcp_sched.c
@@ -29,7 +29,7 @@ static bool mptcp_is_def_unavailable(struct sock *sk)
 	if (tp->mptcp->pre_established)
 		return true;
 =

-	if (tp->pf)
+	if (inet_csk(sk)->icsk_ca_state =3D=3D TCP_CA_Loss)
 		return true;
 =

 	return false;
@@ -333,25 +333,19 @@ static struct sk_buff *__mptcp_next_segment(struct so=
ck *meta_sk, int *reinject)
 	if (mpcb->infinite_mapping_snd || mpcb->send_infinite_mapping)
 		return tcp_send_head(meta_sk);
 =

-	skb =3D skb_peek(&mpcb->reinject_queue);
+	skb =3D tcp_send_head(meta_sk);
 =

-	if (skb) {
-		*reinject =3D 1;
-	} else {
-		skb =3D tcp_send_head(meta_sk);
-
-		if (!skb && meta_sk->sk_socket &&
-		    test_bit(SOCK_NOSPACE, &meta_sk->sk_socket->flags) &&
-		    sk_stream_wspace(meta_sk) < sk_stream_min_wspace(meta_sk)) {
-			struct sock *subsk =3D get_available_subflow(meta_sk, NULL,
-								   false);
-			if (!subsk)
-				return NULL;
-
-			skb =3D mptcp_rcv_buf_optimization(subsk, 0);
-			if (skb)
-				*reinject =3D -1;
-		}
+	if (!skb && meta_sk->sk_socket &&
+	    test_bit(SOCK_NOSPACE, &meta_sk->sk_socket->flags) &&
+	    sk_stream_wspace(meta_sk) < sk_stream_min_wspace(meta_sk)) {
+		struct sock *subsk =3D get_available_subflow(meta_sk, NULL,
+							   false);
+		if (!subsk)
+			return NULL;
+
+		skb =3D mptcp_rcv_buf_optimization(subsk, 0);
+		if (skb)
+			*reinject =3D -1;
 	}
 	return skb;
 }
-- =

2.16.2


--===============0052027621677873607==--
