Content-Type: multipart/mixed; boundary="===============6164597960203546261=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v3 09/13] mptcp: move page frag allocation in
 mptcp_sendmsg()
Date: Mon, 16 Nov 2020 10:48:10 +0100
Message-ID: <6a8432957c7969587efe44146f24eccb0b4bf9f8.1605458224.git.pabeni@redhat.com>
In-Reply-To: cover.1605458224.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6747

--===============6164597960203546261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_sendmsg() is refactored so that first it copies
the data provided from user space into the send queue,
and then tries to spool the send queue via sendmsg_frag.

There a subtle change in the mptcp level collapsing on
consecutive data fragment: we now allow that only on unsent
data.

The latter don't need to deal with msghdr data anymore
and can be simplified in a relevant way.

snd_nxt and write_seq are now tracked independently.

Overall this allows some relevant cleanup and will
allow sending pending mptcp data on msk una update in
later patch.

Co-developed-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 406 ++++++++++++++++++++-----------------------
 1 file changed, 189 insertions(+), 217 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index daa51e657db8..9b30c4b39159 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -43,6 +43,7 @@ struct mptcp_skb_cb {
 static struct percpu_counter mptcp_sockets_allocated;
 =

 static void __mptcp_destroy_sock(struct sock *sk);
+static void __mptcp_check_send_data_fin(struct sock *sk);
 =

 /* If msk has an initial subflow socket, and the MP_CAPABLE handshake has =
not
  * completed yet or has failed, return the subflow socket.
@@ -814,6 +815,7 @@ static bool mptcp_frag_can_collapse_to(const struct mpt=
cp_sock *msk,
 				       const struct mptcp_data_frag *df)
 {
 	return df && pfrag->page =3D=3D df->page &&
+		pfrag->size - pfrag->offset > 0 &&
 		df->data_seq + df->data_len =3D=3D msk->write_seq;
 }
 =

@@ -864,6 +866,8 @@ static void mptcp_clean_una(struct sock *sk)
 		if (after64(dfrag->data_seq + dfrag->data_len, snd_una))
 			break;
 =

+		if (WARN_ON_ONCE(dfrag =3D=3D msk->first_pending))
+			break;
 		dfrag_clear(sk, dfrag);
 		cleaned =3D true;
 	}
@@ -872,12 +876,13 @@ static void mptcp_clean_una(struct sock *sk)
 	if (dfrag && after64(snd_una, dfrag->data_seq)) {
 		u64 delta =3D snd_una - dfrag->data_seq;
 =

-		if (WARN_ON_ONCE(delta > dfrag->data_len))
+		if (WARN_ON_ONCE(delta > dfrag->already_sent))
 			goto out;
 =

 		dfrag->data_seq +=3D delta;
 		dfrag->offset +=3D delta;
 		dfrag->data_len -=3D delta;
+		dfrag->already_sent -=3D delta;
 =

 		dfrag_uncharge(sk, delta);
 		cleaned =3D true;
@@ -911,12 +916,23 @@ static void mptcp_clean_una_wakeup(struct sock *sk)
  */
 static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfra=
g)
 {
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	bool first =3D true;
+
 	if (likely(skb_page_frag_refill(32U + sizeof(struct mptcp_data_frag),
 					pfrag, sk->sk_allocation)))
 		return true;
 =

-	sk->sk_prot->enter_memory_pressure(sk);
 	sk_stream_moderate_sndbuf(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		if (first)
+			tcp_enter_memory_pressure(ssk);
+		sk_stream_moderate_sndbuf(ssk);
+		first =3D false;
+	}
 	return false;
 }
 =

@@ -932,6 +948,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, str=
uct page_frag *pfrag,
 	dfrag->data_seq =3D msk->write_seq;
 	dfrag->overhead =3D offset - orig_offset + sizeof(struct mptcp_data_frag);
 	dfrag->offset =3D offset + sizeof(struct mptcp_data_frag);
+	dfrag->already_sent =3D 0;
 	dfrag->page =3D pfrag->page;
 =

 	return dfrag;
@@ -940,121 +957,58 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, =
struct page_frag *pfrag,
 struct mptcp_sendmsg_info {
 	int mss_now;
 	int size_goal;
+	u16 limit;
+	u16 sent;
+	unsigned int flags;
 };
 =

 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
-			      struct msghdr *msg, struct mptcp_data_frag *dfrag,
+			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
 {
-	int avail_size, offset, ret, frag_truesize =3D 0;
-	bool dfrag_collapsed, can_collapse =3D false;
+	u64 data_seq =3D dfrag->data_seq + info->sent;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_ext *mpext =3D NULL;
-	bool retransmission =3D !!dfrag;
 	struct sk_buff *skb, *tail;
-	struct page_frag *pfrag;
-	struct page *page;
-	u64 *write_seq;
-	size_t psize;
-
-	/* use the mptcp page cache so that we can easily move the data
-	 * from one substream to another, but do per subflow memory accounting
-	 * Note: pfrag is used only !retransmission, but the compiler if
-	 * fooled into a warning if we don't init here
-	 */
-	pfrag =3D sk_page_frag(sk);
-	if (!retransmission) {
-		write_seq =3D &msk->write_seq;
-		page =3D pfrag->page;
-	} else {
-		write_seq =3D &dfrag->data_seq;
-		page =3D dfrag->page;
-	}
+	bool can_collapse =3D false;
+	int avail_size;
+	size_t ret;
 =

-	/* compute copy limit */
-	info->mss_now =3D tcp_send_mss(ssk, &info->size_goal, msg->msg_flags);
+	pr_debug("msk=3D%p ssk=3D%p sending dfrag at seq=3D%lld len=3D%d already =
sent=3D%d",
+		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
+
+	/* compute send limit */
+	info->mss_now =3D tcp_send_mss(ssk, &info->size_goal, info->flags);
 	avail_size =3D info->size_goal;
 	skb =3D tcp_write_queue_tail(ssk);
 	if (skb) {
-		mpext =3D skb_ext_find(skb, SKB_EXT_MPTCP);
-
 		/* Limit the write to the size available in the
 		 * current skb, if any, so that we create at most a new skb.
 		 * Explicitly tells TCP internals to avoid collapsing on later
 		 * queue management operation, to avoid breaking the ext <->
 		 * SSN association set here
 		 */
+		mpext =3D skb_ext_find(skb, SKB_EXT_MPTCP);
 		can_collapse =3D (info->size_goal - skb->len > 0) &&
-			      mptcp_skb_can_collapse_to(*write_seq, skb, mpext);
+			 mptcp_skb_can_collapse_to(data_seq, skb, mpext);
 		if (!can_collapse)
 			TCP_SKB_CB(skb)->eor =3D 1;
 		else
 			avail_size =3D info->size_goal - skb->len;
 	}
 =

-	if (!retransmission) {
-		/* reuse tail pfrag, if possible, or carve a new one from the
-		 * page allocator
-		 */
-		dfrag =3D mptcp_rtx_tail(sk);
-		offset =3D pfrag->offset;
-		dfrag_collapsed =3D mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
-		if (!dfrag_collapsed) {
-			dfrag =3D mptcp_carve_data_frag(msk, pfrag, offset);
-			offset =3D dfrag->offset;
-			frag_truesize =3D dfrag->overhead;
-		}
-		psize =3D min_t(size_t, pfrag->size - offset, avail_size);
-
-		/* Copy to page */
-		pr_debug("left=3D%zu", msg_data_left(msg));
-		psize =3D copy_page_from_iter(pfrag->page, offset,
-					    min_t(size_t, msg_data_left(msg),
-						  psize),
-					    &msg->msg_iter);
-		pr_debug("left=3D%zu", msg_data_left(msg));
-		if (!psize)
-			return -EINVAL;
+	if (WARN_ON_ONCE(info->sent > info->limit ||
+			 info->limit > dfrag->data_len))
+		return 0;
 =

-		if (!sk_wmem_schedule(sk, psize + dfrag->overhead)) {
-			iov_iter_revert(&msg->msg_iter, psize);
-			return -ENOMEM;
-		}
-	} else {
-		offset =3D dfrag->offset;
-		psize =3D min_t(size_t, dfrag->data_len, avail_size);
-	}
-
-	tail =3D tcp_build_frag(ssk, psize, msg->msg_flags, page, offset, &psize);
+	ret =3D info->limit - info->sent;
+	tail =3D tcp_build_frag(ssk, avail_size, info->flags, dfrag->page,
+			      dfrag->offset + info->sent, &ret);
 	if (!tail) {
 		tcp_remove_empty_skb(sk, tcp_write_queue_tail(ssk));
 		return -ENOMEM;
 	}
 =

-	ret =3D psize;
-	frag_truesize +=3D ret;
-	if (!retransmission) {
-		if (unlikely(ret < psize))
-			iov_iter_revert(&msg->msg_iter, psize - ret);
-
-		/* send successful, keep track of sent data for mptcp-level
-		 * retransmission
-		 */
-		dfrag->data_len +=3D ret;
-		if (!dfrag_collapsed) {
-			get_page(dfrag->page);
-			list_add_tail(&dfrag->list, &msk->rtx_queue);
-			sk_wmem_queued_add(sk, frag_truesize);
-		} else {
-			sk_wmem_queued_add(sk, ret);
-		}
-
-		/* charge data on mptcp rtx queue to the master socket
-		 * Note: we charge such data both to sk and ssk
-		 */
-		sk->sk_forward_alloc -=3D frag_truesize;
-	}
-
 	/* if the tail skb is still the cached one, collapsing really happened.
 	 */
 	if (skb =3D=3D tail) {
@@ -1067,7 +1021,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 	msk->cached_ext =3D NULL;
 =

 	memset(mpext, 0, sizeof(*mpext));
-	mpext->data_seq =3D *write_seq;
+	mpext->data_seq =3D data_seq;
 	mpext->subflow_seq =3D mptcp_subflow_ctx(ssk)->rel_write_seq;
 	mpext->data_len =3D ret;
 	mpext->use_map =3D 1;
@@ -1078,11 +1032,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struc=
t sock *ssk,
 		 mpext->dsn64);
 =

 out:
-	if (!retransmission)
-		pfrag->offset +=3D frag_truesize;
-	WRITE_ONCE(*write_seq, *write_seq + ret);
 	mptcp_subflow_ctx(ssk)->rel_write_seq +=3D ret;
-
 	return ret;
 }
 =

@@ -1210,19 +1160,86 @@ static void ssk_check_wmem(struct mptcp_sock *msk)
 		mptcp_nospace(msk);
 }
 =

-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static void mptcp_push_release(struct sock *sk, struct sock *ssk,
+			       struct mptcp_sendmsg_info *info)
+{
+	mptcp_set_timeout(sk, ssk);
+	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
+	release_sock(ssk);
+}
+
+static void mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
+	struct sock *prev_ssk =3D NULL, *ssk =3D NULL;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_sendmsg_info info =3D {
-		.mss_now =3D 0,
-		.size_goal =3D 0,
+				.flags =3D flags,
 	};
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
+			prev_ssk =3D ssk;
+			__mptcp_flush_join_list(msk);
+			ssk =3D mptcp_subflow_get_send(msk, &sndbuf);
+
+			/* do auto tuning */
+			if (!(sk->sk_userlocks & SOCK_SNDBUF_LOCK) &&
+			    sndbuf > READ_ONCE(sk->sk_sndbuf))
+				WRITE_ONCE(sk->sk_sndbuf, sndbuf);
+
+			/* try to keep the subflow socket lock across
+			 * consecutive xmit on the same socket
+			 */
+			if (ssk !=3D prev_ssk && prev_ssk)
+				mptcp_push_release(sk, prev_ssk, &info);
+			if (!ssk)
+				goto out;
+
+			if (ssk !=3D prev_ssk || !prev_ssk)
+				lock_sock(ssk);
+
+			ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+			if (ret <=3D 0) {
+				mptcp_push_release(sk, ssk, &info);
+				goto out;
+			}
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
+	/* at this point we held the socket lock for the last subflow we used */
+	if (ssk)
+		mptcp_push_release(sk, ssk, &info);
+
+out:
+	/* start the timer, if it's not pending */
+	if (!mptcp_timer_pending(sk))
+		mptcp_reset_timer(sk);
+	if (copied)
+		__mptcp_check_send_data_fin(sk);
+}
+
+static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct page_frag *pfrag;
 	size_t copied =3D 0;
-	struct sock *ssk;
 	int ret =3D 0;
-	u32 sndbuf;
-	bool tx_ok;
 	long timeo;
 =

 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
@@ -1239,129 +1256,93 @@ static int mptcp_sendmsg(struct sock *sk, struct m=
sghdr *msg, size_t len)
 	}
 =

 	pfrag =3D sk_page_frag(sk);
-restart:
 	mptcp_clean_una(sk);
 =

-	if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN)) {
-		ret =3D -EPIPE;
-		goto out;
-	}
-
-	__mptcp_flush_join_list(msk);
-	ssk =3D mptcp_subflow_get_send(msk, &sndbuf);
-	while (!sk_stream_memory_free(sk) ||
-	       !ssk ||
-	       !mptcp_page_frag_refill(ssk, pfrag)) {
-		if (ssk) {
-			/* make sure retransmit timer is
-			 * running before we wait for memory.
-			 *
-			 * The retransmit timer might be needed
-			 * to make the peer send an up-to-date
-			 * MPTCP Ack.
-			 */
-			mptcp_set_timeout(sk, ssk);
-			if (!mptcp_timer_pending(sk))
-				mptcp_reset_timer(sk);
-		}
-
-		mptcp_nospace(msk);
-		ret =3D sk_stream_wait_memory(sk, &timeo);
-		if (ret)
-			goto out;
-
-		mptcp_clean_una(sk);
+	while (msg_data_left(msg)) {
+		struct mptcp_data_frag *dfrag;
+		int frag_truesize =3D 0;
+		bool dfrag_collapsed;
+		size_t psize, offset;
 =

-		ssk =3D mptcp_subflow_get_send(msk, &sndbuf);
-		if (list_empty(&msk->conn_list)) {
-			ret =3D -ENOTCONN;
+		if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN)) {
+			ret =3D -EPIPE;
 			goto out;
 		}
-	}
 =

-	/* do auto tuning */
-	if (!(sk->sk_userlocks & SOCK_SNDBUF_LOCK) &&
-	    sndbuf > READ_ONCE(sk->sk_sndbuf))
-		WRITE_ONCE(sk->sk_sndbuf, sndbuf);
-
-	pr_debug("conn_list->subflow=3D%p", ssk);
-
-	lock_sock(ssk);
-	tx_ok =3D msg_data_left(msg);
-	while (tx_ok) {
-		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &info);
-		if (ret < 0) {
-			if (ret =3D=3D -EAGAIN && timeo > 0) {
-				mptcp_set_timeout(sk, ssk);
-				release_sock(ssk);
-				goto restart;
+		/* reuse tail pfrag, if possible, or carve a new one from the
+		 * page allocator
+		 */
+		dfrag =3D mptcp_pending_tail(sk);
+		dfrag_collapsed =3D mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
+		if (!dfrag_collapsed) {
+			if (!sk_stream_memory_free(sk)) {
+				mptcp_push_pending(sk, msg->msg_flags);
+				if (!sk_stream_memory_free(sk))
+					goto wait_for_memory;
 			}
-			break;
+			if (!mptcp_page_frag_refill(sk, pfrag))
+				goto wait_for_memory;
+
+			dfrag =3D mptcp_carve_data_frag(msk, pfrag, pfrag->offset);
+			frag_truesize =3D dfrag->overhead;
 		}
 =

-		/* burst can be negative, we will try move to the next subflow
-		 * at selection time, if possible.
+		/* we do not bound vs wspace, to allow a single packet.
+		 * memory accounting will prevent execessive memory usage
+		 * anyway
 		 */
-		msk->snd_burst -=3D ret;
-		copied +=3D ret;
-
-		tx_ok =3D msg_data_left(msg);
-		if (!tx_ok)
-			break;
-
-		if (!sk_stream_memory_free(ssk) ||
-		    !mptcp_page_frag_refill(ssk, pfrag) ||
-		    !mptcp_ext_cache_refill(msk)) {
-			tcp_push(ssk, msg->msg_flags, info.mss_now,
-				 tcp_sk(ssk)->nonagle, info.size_goal);
-			mptcp_set_timeout(sk, ssk);
-			release_sock(ssk);
-			goto restart;
+		offset =3D dfrag->offset + dfrag->data_len;
+		psize =3D pfrag->size - offset;
+		psize =3D min_t(size_t, psize, msg_data_left(msg));
+		if (!sk_wmem_schedule(sk, psize + frag_truesize))
+			goto wait_for_memory;
+
+		if (copy_page_from_iter(dfrag->page, offset, psize,
+					&msg->msg_iter) !=3D psize) {
+			ret =3D -EFAULT;
+			goto out;
 		}
 =

-		/* memory is charged to mptcp level socket as well, i.e.
-		 * if msg is very large, mptcp socket may run out of buffer
-		 * space.  mptcp_clean_una() will release data that has
-		 * been acked at mptcp level in the mean time, so there is
-		 * a good chance we can continue sending data right away.
-		 *
-		 * Normally, when the tcp subflow can accept more data, then
-		 * so can the MPTCP socket.  However, we need to cope with
-		 * peers that might lag behind in their MPTCP-level
-		 * acknowledgements, i.e.  data might have been acked at
-		 * tcp level only.  So, we must also check the MPTCP socket
-		 * limits before we send more data.
+		/* data successfully copied into the write queue */
+		copied +=3D psize;
+		dfrag->data_len +=3D psize;
+		frag_truesize +=3D psize;
+		pfrag->offset +=3D frag_truesize;
+		WRITE_ONCE(msk->write_seq, msk->write_seq + psize);
+
+		/* charge data on mptcp pending queue to the msk socket
+		 * Note: we charge such data both to sk and ssk
 		 */
-		if (unlikely(!sk_stream_memory_free(sk))) {
-			tcp_push(ssk, msg->msg_flags, info.mss_now,
-				 tcp_sk(ssk)->nonagle, info.size_goal);
-			mptcp_clean_una(sk);
-			if (!sk_stream_memory_free(sk)) {
-				/* can't send more for now, need to wait for
-				 * MPTCP-level ACKs from peer.
-				 *
-				 * Wakeup will happen via mptcp_clean_una().
-				 */
-				mptcp_set_timeout(sk, ssk);
-				release_sock(ssk);
-				goto restart;
-			}
+		sk_wmem_queued_add(sk, frag_truesize);
+		sk->sk_forward_alloc -=3D frag_truesize;
+		if (!dfrag_collapsed) {
+			get_page(dfrag->page);
+			list_add_tail(&dfrag->list, &msk->rtx_queue);
+			if (!msk->first_pending)
+				WRITE_ONCE(msk->first_pending, dfrag);
 		}
-	}
+		pr_debug("msk=3D%p dfrag at seq=3D%lld len=3D%d sent=3D%d new=3D%d", msk,
+			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
+			 !dfrag_collapsed);
 =

-	mptcp_set_timeout(sk, ssk);
-	if (copied) {
-		tcp_push(ssk, msg->msg_flags, info.mss_now,
-			 tcp_sk(ssk)->nonagle, info.size_goal);
+		if (!mptcp_ext_cache_refill(msk))
+			goto wait_for_memory;
+		continue;
 =

-		/* start the timer, if it's not pending */
-		if (!mptcp_timer_pending(sk))
+wait_for_memory:
+		mptcp_nospace(msk);
+		mptcp_clean_una(sk);
+		if (mptcp_timer_pending(sk))
 			mptcp_reset_timer(sk);
+		ret =3D sk_stream_wait_memory(sk, &timeo);
+		if (ret)
+			goto out;
 	}
 =

-	release_sock(ssk);
+	if (copied)
+		mptcp_push_pending(sk, msg->msg_flags);
+
 out:
-	msk->snd_nxt =3D msk->write_seq;
 	ssk_check_wmem(msk);
 	release_sock(sk);
 	return copied ? : ret;
@@ -1700,7 +1681,7 @@ static struct sock *mptcp_subflow_get_retrans(const s=
truct mptcp_sock *msk)
 	sock_owned_by_me((const struct sock *)msk);
 =

 	if (__mptcp_check_fallback(msk))
-		return msk->first;
+		return NULL;
 =

 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
@@ -1843,12 +1824,7 @@ static void mptcp_worker(struct work_struct *work)
 	struct sock *ssk, *sk =3D &msk->sk.icsk_inet.sk;
 	struct mptcp_sendmsg_info info =3D {};
 	struct mptcp_data_frag *dfrag;
-	int orig_len, orig_offset;
-	u64 orig_write_seq;
 	size_t copied =3D 0;
-	struct msghdr msg =3D {
-		.msg_flags =3D MSG_DONTWAIT,
-	};
 	int state, ret;
 =

 	lock_sock(sk);
@@ -1901,18 +1877,17 @@ static void mptcp_worker(struct work_struct *work)
 =

 	lock_sock(ssk);
 =

-	orig_len =3D dfrag->data_len;
-	orig_offset =3D dfrag->offset;
-	orig_write_seq =3D dfrag->data_seq;
-	while (dfrag->data_len > 0) {
-		ret =3D mptcp_sendmsg_frag(sk, ssk, &msg, dfrag, &info);
+	/* limit retransmission to the bytes already sent on some subflows */
+	info.sent =3D 0;
+	info.limit =3D dfrag->already_sent;
+	while (info.sent < dfrag->already_sent) {
+		ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 		if (ret < 0)
 			break;
 =

 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
 		copied +=3D ret;
-		dfrag->data_len -=3D ret;
-		dfrag->offset +=3D ret;
+		info.sent +=3D ret;
 =

 		if (!mptcp_ext_cache_refill(msk))
 			break;
@@ -1921,10 +1896,6 @@ static void mptcp_worker(struct work_struct *work)
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
 =

-	dfrag->data_seq =3D orig_write_seq;
-	dfrag->offset =3D orig_offset;
-	dfrag->data_len =3D orig_len;
-
 	mptcp_set_timeout(sk, ssk);
 	release_sock(ssk);
 =

@@ -1996,6 +1967,7 @@ static void __mptcp_clear_xmit(struct sock *sk)
 =

 	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
 =

+	WRITE_ONCE(msk->first_pending, NULL);
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list)
 		dfrag_clear(sk, dfrag);
 }
-- =

2.26.2

--===============6164597960203546261==--
