Content-Type: multipart/mixed; boundary="===============7068831252182472760=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 6/6] mptcp: use mptcp backlog.
Date: Tue, 10 Nov 2020 12:25:48 +0100
Message-ID: <daab240341b66f74b998b16c4af4a51171bf1064.1605006569.git.pabeni@redhat.com>
In-Reply-To: cover.1605006569.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6650

--===============7068831252182472760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We have some tasks triggered by the subflow receive path
which require to access the msk socket status, specifically:
mptcp_clean_una() and mptcp_push_pending()

We have almost everything in place to use the msk backlog
and a standard !owned by user schema for that.

Introduce a dummy per msk sk_buff to trigger into the backlog
as needed.

Since the worker is no more used to clean the acked data,
for fallback sockets we need to explicitly call flush them.

As added bonus we can simplify a lot mptcp_poll() and
move the timer update under the data lock

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
rfc v3-> v2:
 - dfrag_release is always invoked under sock spin lock,
   must use mem_release
 - move the mem_reclaim in mptcp_clean_una
 - cleanup poll, leveraging the previous patch
---
 net/mptcp/options.c  |  18 +++--
 net/mptcp/protocol.c | 183 +++++++++++++++++++++++++++----------------
 net/mptcp/protocol.h |   8 ++
 3 files changed, 134 insertions(+), 75 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3986454a0340..48dd6622a04c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -189,7 +189,7 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 				ptr +=3D 4;
 			}
 =

-			pr_debug("data_ack=3D%llu", mp_opt->data_ack);
+			pr_debug("64=3D%d data_ack=3D%llx", mp_opt->ack64, mp_opt->data_ack);
 		}
 =

 		if (mp_opt->use_map) {
@@ -207,7 +207,7 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 			mp_opt->data_len =3D get_unaligned_be16(ptr);
 			ptr +=3D 2;
 =

-			pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u",
+			pr_debug("data_seq=3D%llx subflow_seq=3D%u data_len=3D%u",
 				 mp_opt->data_seq, mp_opt->subflow_seq,
 				 mp_opt->data_len);
 		}
@@ -830,7 +830,7 @@ static u64 expand_ack(u64 old_ack, u64 cur_ack, bool us=
e_64bit)
 }
 =

 static void ack_update_msk(struct mptcp_sock *msk,
-			   const struct sock *ssk,
+			   struct sock *ssk,
 			   struct mptcp_options_received *mp_opt)
 {
 	u64 new_wnd_end, new_snd_una, snd_nxt =3D READ_ONCE(msk->snd_nxt);
@@ -854,8 +854,10 @@ static void ack_update_msk(struct mptcp_sock *msk,
 =

 	if (after64(new_wnd_end, msk->wnd_end)) {
 		msk->wnd_end =3D new_wnd_end;
-		if (mptcp_send_head(sk))
-			mptcp_schedule_work(sk);
+		if (!sock_owned_by_user(sk))
+			__mptcp_subflow_push_pending(sk, ssk);
+		else
+			__mptcp_add_to_backlog(sk, MPTCP_PUSH_PENDING);
 	}
 =

 	if (after64(new_snd_una, old_snd_una)) {
@@ -915,8 +917,12 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb)
 	struct mptcp_options_received mp_opt;
 	struct mptcp_ext *mpext;
 =

-	if (__mptcp_check_fallback(msk))
+	if (__mptcp_check_fallback(msk)) {
+		mptcp_data_lock(subflow->conn);
+		__mptcp_data_acked(subflow->conn);
+		mptcp_data_unlock(subflow->conn);
 		return;
+	}
 =

 	mptcp_get_options(skb, &mp_opt);
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f016b5c11154..0bd791f84ed0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -743,13 +743,16 @@ bool mptcp_schedule_work(struct sock *sk)
 	return false;
 }
 =

+static void __mptcp_clean_una(struct sock *sk);
+
 void __mptcp_data_acked(struct sock *sk)
 {
-	mptcp_reset_timer(sk);
+	if (!sock_owned_by_user(sk))
+		__mptcp_clean_una(sk);
+	else
+		__mptcp_add_to_backlog(sk, MPTCP_CLEAN_UNA);
 =

-	if ((test_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags) ||
-	     mptcp_send_head(sk) ||
-	     (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)))
+	if (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)
 		mptcp_schedule_work(sk);
 }
 =

@@ -875,7 +878,7 @@ static void mptcp_mem_reclaim_partial(struct sock *sk)
 =

 static void dfrag_uncharge(struct sock *sk, int len)
 {
-	mptcp_wmem_uncharge(sk, len);
+	sk_mem_uncharge(sk, len);
 	sk_wmem_queued_add(sk, -len);
 }
 =

@@ -888,7 +891,7 @@ static void dfrag_clear(struct sock *sk, struct mptcp_d=
ata_frag *dfrag)
 	put_page(dfrag->page);
 }
 =

-static void mptcp_clean_una(struct sock *sk)
+static void __mptcp_clean_una(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
@@ -930,20 +933,19 @@ static void mptcp_clean_una(struct sock *sk)
 =

 out:
 	if (cleaned && tcp_under_memory_pressure(sk))
-		mptcp_mem_reclaim_partial(sk);
+		sk_mem_reclaim_partial(sk);
+	if (snd_una =3D=3D READ_ONCE(msk->snd_nxt)) {
+		if (msk->timer_ival)
+			mptcp_stop_timer(sk);
+	} else
+		mptcp_reset_timer(sk);
 }
 =

-static void mptcp_clean_una_wakeup(struct sock *sk)
+static void mptcp_clean_una(struct sock *sk)
 {
-	struct mptcp_sock *msk =3D mptcp_sk(sk);
-
-	mptcp_clean_una(sk);
-
-	/* Only wake up writers if a subflow is ready */
-	if (sk_stream_is_writeable(sk)) {
-		clear_bit(MPTCP_NOSPACE, &msk->flags);
-		sk_stream_write_space(sk);
-	}
+	mptcp_data_lock(sk);
+	__mptcp_clean_una(sk);
+	mptcp_data_unlock(sk);
 }
 =

 static void mptcp_enter_memory_pressure(struct sock *sk)
@@ -1029,13 +1031,13 @@ static bool __mptcp_add_ext(struct sk_buff *skb, gf=
p_t gfp)
 	return true;
 }
 =

-static struct sk_buff *__mptcp_do_alloc_tx_skb(struct sock *sk)
+static struct sk_buff *__mptcp_do_alloc_tx_skb(struct sock *sk, gfp_t gfp)
 {
 	struct sk_buff *skb;
 =

-	skb =3D alloc_skb_fclone(MAX_TCP_HEADER, sk->sk_allocation);
+	skb =3D alloc_skb_fclone(MAX_TCP_HEADER, gfp);
 	if (likely(skb)) {
-		if (likely(__mptcp_add_ext(skb, sk->sk_allocation))) {
+		if (likely(__mptcp_add_ext(skb, gfp))) {
 			skb_reserve(skb, MAX_TCP_HEADER);
 			skb->reserved_tailroom =3D skb->end - skb->tail;
 			return skb;
@@ -1059,7 +1061,7 @@ static bool mptcp_tx_cache_refill(struct sock *sk, in=
t size)
 	space_needed =3D msk->tx_pending_data + size -
 		       msk->skb_tx_cache.qlen * msk->size_goal_cache;
 	while (space_needed > 0) {
-		skb =3D __mptcp_do_alloc_tx_skb(sk);
+		skb =3D __mptcp_do_alloc_tx_skb(sk, sk->sk_allocation);
 		if (!skb)
 			return false;
 =

@@ -1074,7 +1076,7 @@ static bool mptcp_tx_cache_refill(struct sock *sk, in=
t size)
 	return true;
 }
 =

-static bool __mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk)
+static bool __mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, gfp_t =
gfp)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct sk_buff *skb;
@@ -1082,7 +1084,7 @@ static bool __mptcp_alloc_tx_skb(struct sock *sk, str=
uct sock *ssk)
 	if (ssk->sk_tx_skb_cache) {
 		skb =3D ssk->sk_tx_skb_cache;
 		if (unlikely(!skb_ext_find(skb, SKB_EXT_MPTCP) &&
-			     !__mptcp_add_ext(skb, sk->sk_allocation)))
+			     !__mptcp_add_ext(skb, gfp)))
 			return false;
 		return true;
 	}
@@ -1103,7 +1105,7 @@ static bool __mptcp_alloc_tx_skb(struct sock *sk, str=
uct sock *ssk)
 		return false;
 	}
 =

-	skb =3D __mptcp_do_alloc_tx_skb(sk);
+	skb =3D __mptcp_do_alloc_tx_skb(sk, gfp);
 	if (!skb)
 		return false;
 =

@@ -1126,7 +1128,7 @@ static bool mptcp_alloc_tx_skb(struct sock *sk, struc=
t sock *ssk)
 {
 	if (unlikely(mptcp_must_reclaim_memory(sk, ssk)))
 		mptcp_mem_reclaim_partial(sk);
-	return __mptcp_alloc_tx_skb(sk, ssk);
+	return __mptcp_alloc_tx_skb(sk, ssk, sk->sk_allocation);
 }
 =

 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
@@ -1228,17 +1230,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struc=
t sock *ssk,
 	return ret;
 }
 =

-static void mptcp_nospace(struct mptcp_sock *msk)
-{
-	set_bit(MPTCP_NOSPACE, &msk->flags);
-	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */
-
-	/* mptcp_data_acked() could run just before we set the NOSPACE bit,
-	 * so explicitly check for snd_una value
-	 */
-	mptcp_clean_una((struct sock *)msk);
-}
-
 #define MPTCP_SEND_BURST_SIZE		((1 << 16) - \
 					 sizeof(struct tcphdr) - \
 					 MAX_TCP_OPTION_SPACE - \
@@ -1333,7 +1324,7 @@ static void mptcp_push_release(struct sock *sk, struc=
t sock *ssk,
 	release_sock(ssk);
 }
 =

-static void mptcp_push_pending(struct sock *sk, unsigned int flags)
+void mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk =3D NULL, *ssk =3D NULL;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -1402,10 +1393,61 @@ static void mptcp_push_pending(struct sock *sk, uns=
igned int flags)
 =

 out:
 	/* start the timer, if it's not pending */
-	if (!mptcp_timer_pending(sk))
-		mptcp_reset_timer(sk);
-	if (copied)
+	if (copied) {
+		if (!mptcp_timer_pending(sk))
+			mptcp_reset_timer(sk);
 		__mptcp_check_send_data_fin(sk);
+	}
+}
+
+void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_sendmsg_info info;
+	struct mptcp_data_frag *dfrag;
+	int len, copied =3D 0;
+	u32 sndbuf;
+
+	while ((dfrag =3D mptcp_send_head(sk))) {
+		info.sent =3D dfrag->already_sent;
+		info.limit =3D dfrag->data_len;
+		len =3D dfrag->data_len - dfrag->already_sent;
+		while (len > 0) {
+			int ret =3D 0;
+
+			/* do auto tuning */
+			if (!(sk->sk_userlocks & SOCK_SNDBUF_LOCK) &&
+			    sndbuf > READ_ONCE(sk->sk_sndbuf))
+				WRITE_ONCE(sk->sk_sndbuf, sndbuf);
+
+			if (unlikely(mptcp_must_reclaim_memory(sk, ssk)))
+				__mptcp_mem_reclaim_partial(sk);
+			if (!__mptcp_alloc_tx_skb(sk, ssk, GFP_ATOMIC))
+				goto out;
+
+			ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+			if (ret <=3D 0)
+				goto out;
+
+			info.sent +=3D ret;
+			dfrag->already_sent +=3D ret;
+			msk->snd_nxt +=3D ret;
+			msk->snd_burst -=3D ret;
+			copied +=3D ret;
+			len -=3D ret;
+		}
+		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+	}
+
+out:
+	if (copied) {
+		mptcp_set_timeout(sk, ssk);
+		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+			 info.size_goal);
+		if (msk->snd_data_fin_enable &&
+		    msk->snd_nxt + 1 =3D=3D msk->write_seq)
+			mptcp_schedule_work(sk);
+	}
 }
 =

 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
@@ -1430,7 +1472,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 	}
 =

 	pfrag =3D sk_page_frag(sk);
-	mptcp_clean_una(sk);
 =

 	while (msg_data_left(msg)) {
 		struct mptcp_data_frag *dfrag;
@@ -1450,7 +1491,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		dfrag_collapsed =3D mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
 		if (!dfrag_collapsed) {
 			if (!sk_stream_memory_free(sk)) {
-				mptcp_push_pending(sk, msg->msg_flags);
 				if (!sk_stream_memory_free(sk))
 					goto wait_for_memory;
 			}
@@ -1505,9 +1545,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		continue;
 =

 wait_for_memory:
-		mptcp_nospace(msk);
-		if (mptcp_timer_pending(sk))
-			mptcp_reset_timer(sk);
+		mptcp_push_pending(sk, msg->msg_flags);
+		set_bit(MPTCP_NOSPACE, &msk->flags);
 		ret =3D sk_stream_wait_memory(sk, &timeo);
 		if (ret)
 			goto out;
@@ -2067,15 +2106,11 @@ static void mptcp_worker(struct work_struct *work)
 	if (unlikely(state =3D=3D TCP_CLOSE))
 		goto unlock;
 =

-	mptcp_clean_una_wakeup(sk);
 	mptcp_check_data_fin_ack(sk);
 	__mptcp_flush_join_list(msk);
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 		__mptcp_close_subflow(msk);
 =

-	if (mptcp_send_head(sk))
-		mptcp_push_pending(sk, 0);
-
 	if (msk->pm.status)
 		pm_work(msk);
 =

@@ -2160,6 +2195,8 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->size_goal_cache =3D TCP_BASE_MSS;
 =

 	msk->ack_hint =3D NULL;
+	msk->backlog.len =3D 0;
+	msk->backlog.truesize =3D 0;
 	msk->first =3D NULL;
 	inet_csk(sk)->icsk_sync_mss =3D mptcp_sync_mss;
 =

@@ -2712,6 +2749,28 @@ static int mptcp_getsockopt(struct sock *sk, int lev=
el, int optname,
 	return -EOPNOTSUPP;
 }
 =

+void __mptcp_add_to_backlog(struct sock *sk, int event)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (!sk->sk_backlog.tail)
+		__sk_add_backlog(sk, &msk->backlog);
+
+	set_bit(event, &msk->flags);
+}
+
+int mptcp_do_backlog(struct sock *sk, struct sk_buff *skb)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->flags))
+		mptcp_clean_una(sk);
+
+	if (test_and_clear_bit(MPTCP_PUSH_PENDING, &msk->flags))
+		mptcp_push_pending(sk, 0);
+	return 0;
+}
+
 #define MPTCP_DEFERRED_ALL (TCPF_WRITE_TIMER_DEFERRED)
 =

 /* this is very alike tcp_release_cb() but we must handle differently a
@@ -2865,6 +2924,7 @@ static struct proto mptcp_prot =3D {
 	.destroy	=3D mptcp_destroy,
 	.sendmsg	=3D mptcp_sendmsg,
 	.recvmsg	=3D mptcp_recvmsg,
+	.backlog_rcv	=3D mptcp_do_backlog,
 	.release_cb	=3D mptcp_release_cb,
 	.hash		=3D mptcp_hash,
 	.unhash		=3D mptcp_unhash,
@@ -3053,24 +3113,9 @@ static __poll_t mptcp_check_readable(struct mptcp_so=
ck *msk)
 	       0;
 }
 =

-static bool __mptcp_check_writeable(struct mptcp_sock *msk)
-{
-	struct sock *sk =3D (struct sock *)msk;
-	bool mptcp_writable;
-
-	mptcp_clean_una(sk);
-	mptcp_writable =3D sk_stream_is_writeable(sk);
-	if (!mptcp_writable)
-		mptcp_nospace(msk);
-
-	return mptcp_writable;
-}
-
 static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
-	__poll_t ret =3D 0;
-	bool slow;
 =

 	if (unlikely(sk->sk_shutdown & SEND_SHUTDOWN))
 		return 0;
@@ -3078,12 +3123,12 @@ static __poll_t mptcp_check_writeable(struct mptcp_=
sock *msk)
 	if (sk_stream_is_writeable(sk))
 		return EPOLLOUT | EPOLLWRNORM;
 =

-	slow =3D lock_sock_fast(sk);
-	if (__mptcp_check_writeable(msk))
-		ret =3D EPOLLOUT | EPOLLWRNORM;
+	set_bit(MPTCP_NOSPACE, &msk->flags);
+	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */
+	if (sk_stream_is_writeable(sk))
+		return EPOLLOUT | EPOLLWRNORM;
 =

-	unlock_sock_fast(sk, slow);
-	return ret;
+	return 0;
 }
 =

 static __poll_t mptcp_poll(struct file *file, struct socket *sock,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0047295b766f..3a7eb6384801 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -92,6 +92,8 @@
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
 #define MPTCP_WORKER_RUNNING	6
+#define MPTCP_PUSH_PENDING	7
+#define MPTCP_CLEAN_UNA	8
 =

 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -249,6 +251,9 @@ struct mptcp_sock {
 	struct list_head join_list;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
+
+	struct sk_buff backlog;
+
 	struct mptcp_pm_data	pm;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
@@ -440,6 +445,9 @@ unsigned int mptcp_get_add_addr_timeout(struct net *net=
);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
+void mptcp_push_pending(struct sock *sk, unsigned int flags);
+void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk);
+void __mptcp_add_to_backlog(struct sock *sk, int event);
 void __init mptcp_subflow_init(void);
 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
 void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
-- =

2.26.2

--===============7068831252182472760==--
