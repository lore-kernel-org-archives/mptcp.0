Content-Type: multipart/mixed; boundary="===============3294411353879065823=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 7/7] mptcp: use mptcp backlog.
Date: Wed, 18 Nov 2020 23:30:16 +0100
Message-ID: <fd0bfb708ae11768dda5546c905fd9fb99af0601.1605737933.git.pabeni@redhat.com>
In-Reply-To: cover.1605737932.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6803

--===============3294411353879065823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We have some tasks triggered by the subflow receive path
which require to access the msk socket status, specifically:
mptcp_clean_una() and mptcp_push_pending()

We have almost everything in place to defer to the msk
release_cb such tasks when the msk sock is owned.

Since the worker is no more used to clean the acked data,
for fallback sockets we need to explicitly flush them.

As added bonus we can simplify a lot mptcp_poll() and
move the timer update under the data lock.

The worker is now used only to process and send DATA_FIN
packets and do the mptcp-level retransmissions.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
v3 -> v4:
 - use release_cb for push_pending, too
 - note: this will conflict with the pending net-next,
   but the conflict resolution should be easy.

v2 -> v3:
 - move clean una to release_cb(), so that we don't need
   an additional spin lock contention

v1 -> v2
 - add tx_pending_data accounting in __mptcp_subflow_push_pending()
 - in mptcp_data_acked schedule explicitly schedule the worker if
   ack is pending - checking sk status is both too liberal and not
   enough.
 - add missing call to __mptcp_check_send_data_fin() in mptcp_worker()
   this is needed to cope with __mptcp_subflow_push_pending() deferring
   send ack to the worker
 - renamed backlog to bl_entry
 - sk_mem_reclaim_partial() -> __mptcp_mem_reclaim_partial() in
   mptcp_clean_una(). We are both under the data_lock and the socket
   lock so we can call the more effective mptcp variant
 - do not try to push pending frames on wnd update if no pending data
   (use the new __mptcp_wnd_updated helper for that)
 - move write queue cleanup in destroy_common() so that it takes place
   after that subflows stops touching msk->sk_forward_alloc.
   and we don't need to acquire the msk socket lock spin lock to reclaim
   the xmit memory
 - explicitly init info->flags in __mptcp_subflow_push_pending(), or
   horrible corruption will happen later
 - explicitly flush pending data for fallback socket on ack reception.
   This likely fixes an older issue, which was hidden by the worker,
   spooling the pending data, just slower.
---
 net/mptcp/options.c  |  18 +++-
 net/mptcp/protocol.c | 215 ++++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h |   3 +
 3 files changed, 146 insertions(+), 90 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3986454a0340..6b7b4b67f18c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
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
@@ -854,8 +854,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 =

 	if (after64(new_wnd_end, msk->wnd_end)) {
 		msk->wnd_end =3D new_wnd_end;
-		if (mptcp_send_head(sk))
-			mptcp_schedule_work(sk);
+		__mptcp_wnd_updated(sk, ssk);
 	}
 =

 	if (after64(new_snd_una, old_snd_una)) {
@@ -915,8 +914,19 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb)
 	struct mptcp_options_received mp_opt;
 	struct mptcp_ext *mpext;
 =

-	if (__mptcp_check_fallback(msk))
+	if (__mptcp_check_fallback(msk)) {
+		/* Keep it simple and unconditionally trigger send data cleanup and
+		 * pending queue spooling. We will need to acquire the data lock
+		 * for more accurate checks, and once the lock is acquired, such
+		 * helpers are cheap.
+		 */
+		mptcp_data_lock(subflow->conn);
+		if (mptcp_send_head(subflow->conn))
+			__mptcp_wnd_updated(subflow->conn, sk);
+		__mptcp_data_acked(subflow->conn);
+		mptcp_data_unlock(subflow->conn);
 		return;
+	}
 =

 	mptcp_get_options(skb, &mp_opt);
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dacc59d004ad..5b0467dc1954 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -360,17 +360,22 @@ static void mptcp_close_wake_up(struct sock *sk)
 		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
 }
 =

-static void mptcp_check_data_fin_ack(struct sock *sk)
+static bool mptcp_pending_data_fin_ack(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	if (__mptcp_check_fallback(msk))
-		return;
+	return !__mptcp_check_fallback(msk) &&
+	       ((1 << sk->sk_state) &
+		(TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK)) &&
+	       msk->write_seq =3D=3D READ_ONCE(msk->snd_una);
+}
+
+static void mptcp_check_data_fin_ack(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

 	/* Look for an acknowledged DATA_FIN */
-	if (((1 << sk->sk_state) &
-	     (TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK)) &&
-	    msk->write_seq =3D=3D READ_ONCE(msk->snd_una)) {
+	if (mptcp_pending_data_fin_ack(sk)) {
 		mptcp_stop_timer(sk);
 =

 		WRITE_ONCE(msk->snd_data_fin_enable, 0);
@@ -750,16 +755,6 @@ bool mptcp_schedule_work(struct sock *sk)
 	return false;
 }
 =

-void __mptcp_data_acked(struct sock *sk)
-{
-	mptcp_reset_timer(sk);
-
-	if ((test_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags) ||
-	     mptcp_send_head(sk) ||
-	     (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)))
-		mptcp_schedule_work(sk);
-}
-
 void mptcp_subflow_eof(struct sock *sk)
 {
 	if (!test_and_set_bit(MPTCP_WORK_EOF, &mptcp_sk(sk)->flags))
@@ -972,7 +967,7 @@ static void dfrag_clear(struct sock *sk, struct mptcp_d=
ata_frag *dfrag)
 	put_page(dfrag->page);
 }
 =

-static void mptcp_clean_una(struct sock *sk)
+static void __mptcp_clean_una(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
@@ -985,8 +980,6 @@ static void mptcp_clean_una(struct sock *sk)
 	if (__mptcp_check_fallback(msk))
 		msk->snd_una =3D READ_ONCE(msk->snd_nxt);
 =

-
-	mptcp_data_lock(sk);
 	snd_una =3D msk->snd_una;
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
 		if (after64(dfrag->data_seq + dfrag->data_len, snd_una))
@@ -1017,19 +1010,11 @@ static void mptcp_clean_una(struct sock *sk)
 out:
 	if (cleaned && tcp_under_memory_pressure(sk))
 		sk_mem_reclaim_partial(sk);
-	mptcp_data_unlock(sk);
-}
-
-static void mptcp_clean_una_wakeup(struct sock *sk)
-{
-	struct mptcp_sock *msk =3D mptcp_sk(sk);
-
-	mptcp_clean_una(sk);
-
-	/* Only wake up writers if a subflow is ready */
-	if (sk_stream_is_writeable(sk)) {
-		clear_bit(MPTCP_NOSPACE, &msk->flags);
-		sk_stream_write_space(sk);
+	if (snd_una =3D=3D READ_ONCE(msk->snd_nxt)) {
+		if (msk->timer_ival)
+			mptcp_stop_timer(sk);
+	} else {
+		mptcp_reset_timer(sk);
 	}
 }
 =

@@ -1116,13 +1101,13 @@ static bool __mptcp_add_ext(struct sk_buff *skb, gf=
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
@@ -1154,7 +1139,7 @@ static bool mptcp_tx_cache_refill(struct sock *sk, in=
t size,
 	}
 =

 	while (space_needed > 0) {
-		skb =3D __mptcp_do_alloc_tx_skb(sk);
+		skb =3D __mptcp_do_alloc_tx_skb(sk, sk->sk_allocation);
 		if (unlikely(!skb)) {
 			/* under memory pressure, try to pass the caller a
 			 * single skb to allow forward progress
@@ -1173,7 +1158,7 @@ static bool mptcp_tx_cache_refill(struct sock *sk, in=
t size,
 	return true;
 }
 =

-static bool __mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk)
+static bool __mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, gfp_t =
gfp)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct sk_buff *skb;
@@ -1181,7 +1166,7 @@ static bool __mptcp_alloc_tx_skb(struct sock *sk, str=
uct sock *ssk)
 	if (ssk->sk_tx_skb_cache) {
 		skb =3D ssk->sk_tx_skb_cache;
 		if (unlikely(!skb_ext_find(skb, SKB_EXT_MPTCP) &&
-			     !__mptcp_add_ext(skb, sk->sk_allocation)))
+			     !__mptcp_add_ext(skb, gfp)))
 			return false;
 		return true;
 	}
@@ -1202,7 +1187,7 @@ static bool __mptcp_alloc_tx_skb(struct sock *sk, str=
uct sock *ssk)
 		return false;
 	}
 =

-	skb =3D __mptcp_do_alloc_tx_skb(sk);
+	skb =3D __mptcp_do_alloc_tx_skb(sk, gfp);
 	if (!skb)
 		return false;
 =

@@ -1225,7 +1210,7 @@ static bool mptcp_alloc_tx_skb(struct sock *sk, struc=
t sock *ssk)
 {
 	if (unlikely(mptcp_must_reclaim_memory(sk, ssk)))
 		mptcp_mem_reclaim_partial(sk);
-	return __mptcp_alloc_tx_skb(sk, ssk);
+	return __mptcp_alloc_tx_skb(sk, ssk, sk->sk_allocation);
 }
 =

 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
@@ -1326,17 +1311,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struc=
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
@@ -1501,10 +1475,67 @@ static void mptcp_push_pending(struct sock *sk, uns=
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
+static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_sendmsg_info info;
+	struct mptcp_data_frag *dfrag;
+	int len, copied =3D 0;
+	u32 sndbuf;
+
+	info.flags =3D 0;
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
+				sk_mem_reclaim_partial(sk);
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
+			msk->tx_pending_data -=3D ret;
+			copied +=3D ret;
+			len -=3D ret;
+		}
+		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+	}
+
+out:
+	/* __mptcp_alloc_tx_skb could have released some wmem and we are
+	 * not going to flush it via release_sock()
+	 */
+	__mptcp_update_wmem(sk);
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
@@ -1529,7 +1560,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 	}
 =

 	pfrag =3D sk_page_frag(sk);
-	mptcp_clean_una(sk);
 =

 	while (msg_data_left(msg)) {
 		int total_ts, frag_truesize =3D 0;
@@ -1550,7 +1580,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		dfrag_collapsed =3D mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
 		if (!dfrag_collapsed) {
 			if (!sk_stream_memory_free(sk)) {
-				mptcp_push_pending(sk, msg->msg_flags);
 				if (!sk_stream_memory_free(sk))
 					goto wait_for_memory;
 			}
@@ -1610,9 +1639,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
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
@@ -2164,21 +2192,18 @@ static void mptcp_worker(struct work_struct *work)
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

 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
 =

+	__mptcp_check_send_data_fin(sk);
 	mptcp_check_data_fin(sk);
 =

 	/* if the msk data is completely acked, or the socket timedout,
@@ -2304,8 +2329,6 @@ static void __mptcp_clear_xmit(struct sock *sk)
 	struct mptcp_data_frag *dtmp, *dfrag;
 	struct sk_buff *skb;
 =

-	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
-
 	WRITE_ONCE(msk->first_pending, NULL);
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list)
 		dfrag_clear(sk, dfrag);
@@ -2447,7 +2470,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	spin_unlock_bh(&msk->join_list_lock);
 	list_splice_init(&msk->conn_list, &conn_list);
 =

-	__mptcp_clear_xmit(sk);
+	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status =3D 0;
 =

@@ -2681,6 +2704,8 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
 =

+	__mptcp_clear_xmit(sk);
+
 	skb_queue_splice_tail_init(&sk->sk_receive_queue, &msk->receive_queue);
 	skb_rbtree_purge(&msk->out_of_order_queue);
 	mptcp_token_destroy(msk);
@@ -2805,6 +2830,28 @@ static int mptcp_getsockopt(struct sock *sk, int lev=
el, int optname,
 	return -EOPNOTSUPP;
 }
 =

+void __mptcp_data_acked(struct sock *sk)
+{
+	if (!sock_owned_by_user(sk))
+		__mptcp_clean_una(sk);
+	else
+		set_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->flags);
+
+	if (mptcp_pending_data_fin_ack(sk))
+		mptcp_schedule_work(sk);
+}
+
+void __mptcp_wnd_updated(struct sock *sk, struct sock *ssk)
+{
+	if (!mptcp_send_head(sk))
+		return;
+
+	if (!sock_owned_by_user(sk))
+		__mptcp_subflow_push_pending(sk, ssk);
+	else
+		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
+}
+
 #define MPTCP_DEFERRED_ALL (TCPF_WRITE_TIMER_DEFERRED)
 =

 /* processes deferred events and flush wmem */
@@ -2812,6 +2859,17 @@ static void mptcp_release_cb(struct sock *sk)
 {
 	unsigned long flags, nflags;
 =

+	/* push_pending may touch wmem_reserved, do it before the later
+	 * cleanup
+	 */
+	if (test_and_clear_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->flags))
+		__mptcp_clean_una(sk);
+	if (test_and_clear_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags)) {
+		spin_unlock_bh(&sk->sk_lock.slock);
+		mptcp_push_pending(sk, 0);
+		spin_lock_bh(&sk->sk_lock.slock);
+	}
+
 	/* clear any wmem reservation and errors */
 	__mptcp_update_wmem(sk);
 	__mptcp_update_rmem(sk);
@@ -3148,24 +3206,9 @@ static __poll_t mptcp_check_readable(struct mptcp_so=
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
@@ -3173,12 +3216,12 @@ static __poll_t mptcp_check_writeable(struct mptcp_=
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
index 76a6a82d2585..9dc5ff163e1e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -91,6 +91,8 @@
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
+#define MPTCP_PUSH_PENDING	6
+#define MPTCP_CLEAN_UNA		7
 =

 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -497,6 +499,7 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const=
 struct sock *ssk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
 bool mptcp_schedule_work(struct sock *sk);
+void __mptcp_wnd_updated(struct sock *sk, struct sock *ssk);
 void __mptcp_data_acked(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, b=
ool use_64bit);
-- =

2.26.2

--===============3294411353879065823==--
