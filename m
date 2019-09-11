Content-Type: multipart/mixed; boundary="===============9034233139754479871=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 6/7] mptcp: rework mptcp_sendmsg_frag to accept
 optional dfrag
Date: Wed, 11 Sep 2019 14:55:40 +0200
Message-ID: <b56f31c084dd7db4723c3724baaca25d3edd8f04.1568206133.git.pabeni@redhat.com>
In-Reply-To: cover.1568206133.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1824

--===============9034233139754479871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will simplify mptcp-level retransmission implementation
in the next patch. If dfrag is provided by the caller, skip
kernel space memory allocation and use data and metadata
provided by the dfrag itself.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 134 +++++++++++++++++++++++++------------------
 1 file changed, 79 insertions(+), 55 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5cf413c86ab3..fe58d95be624 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -93,7 +93,7 @@ static struct sock *mptcp_subflow_get_ref(const struct mp=
tcp_sock *msk)
 	return NULL;
 }
 =

-static inline bool mptcp_skb_can_collapse_to(const struct mptcp_sock *msk,
+static inline bool mptcp_skb_can_collapse_to(u64 write_seq,
 					     const struct sk_buff *skb,
 					     const struct mptcp_ext *mpext)
 {
@@ -101,7 +101,7 @@ static inline bool mptcp_skb_can_collapse_to(const stru=
ct mptcp_sock *msk,
 		return false;
 =

 	/* can collapse only if MPTCP level sequence is in order */
-	return mpext && mpext->data_seq + mpext->data_len =3D=3D msk->write_seq;
+	return mpext && mpext->data_seq + mpext->data_len =3D=3D write_seq;
 }
 =

 static inline bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
@@ -166,31 +166,44 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, s=
truct page_frag *pfrag,
 }
 =

 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
-			      struct msghdr *msg, long *timeo, int *pmss_now,
+			      struct msghdr *msg, struct mptcp_data_frag *dfrag,
+			      long *timeo, int *pmss_now,
 			      int *ps_goal)
 {
 	int mss_now, avail_size, size_goal, offset, ret, frag_truesize =3D 0;
 	bool dfrag_collapsed, collapsed, can_collapse =3D false;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_ext *mpext =3D NULL;
-	struct mptcp_data_frag *dfrag;
+	bool retransmission =3D !!dfrag;
 	struct page_frag *pfrag;
 	struct sk_buff *skb;
+	struct page *page;
+	u64 *write_seq;
 	size_t psize;
+	int *poffset;
 =

 	/* use the mptcp page cache so that we can easily move the data
 	 * from one substream to another, but do per subflow memory accounting
+	 * Note: pfrag is used only !retransmission, but the compiler if
+	 * fooled into a warning if we don't init here
 	 */
 	pfrag =3D sk_page_frag(sk);
-	while (!mptcp_page_frag_refill(ssk, pfrag)) {
-		ret =3D sk_stream_wait_memory(ssk, timeo);
-		if (ret)
-			return ret;
-
-		/* id sk_stream_wait_memory() sleeps snd_una can change
-		 * significantly, refresh the rtx queue
-		 */
-		mptcp_clean_una(sk);
+	if (!retransmission) {
+		while (!mptcp_page_frag_refill(ssk, pfrag)) {
+			ret =3D sk_stream_wait_memory(ssk, timeo);
+			if (ret)
+				return ret;
+
+			/* id sk_stream_wait_memory() sleeps snd_una can change
+			 * significantly, refresh the rtx queue
+			 */
+			mptcp_clean_una(sk);
+		}
+		write_seq =3D &msk->write_seq;
+		page =3D pfrag->page;
+	} else {
+		write_seq =3D &dfrag->data_seq;
+		page =3D dfrag->page;
 	}
 =

 	/* compute copy limit */
@@ -209,7 +222,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 		 * is collapsing was allowed: collapsing is effectively
 		 * disabled.
 		 */
-		can_collapse =3D mptcp_skb_can_collapse_to(msk, skb, mpext);
+		can_collapse =3D mptcp_skb_can_collapse_to(*write_seq, skb,
+							 mpext);
 		if (!can_collapse)
 			TCP_SKB_CB(skb)->eor =3D 1;
 		else if (size_goal - skb->len > 0)
@@ -218,56 +232,66 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 			can_collapse =3D false;
 	}
 =

-	/* reuse tail pfrag, if possible, or carve a new one from the page
-	 * allocator
-	 */
-	dfrag =3D mptcp_rtx_tail(sk);
-	offset =3D pfrag->offset;
-	dfrag_collapsed =3D mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
-	if (!dfrag_collapsed) {
-		dfrag =3D mptcp_carve_data_frag(msk, pfrag, offset);
+	if (!retransmission) {
+		/* reuse tail pfrag, if possible, or carve a new one from the
+		 * page allocator
+		 */
+		dfrag =3D mptcp_rtx_tail(sk);
+		offset =3D pfrag->offset;
+		dfrag_collapsed =3D mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
+		if (!dfrag_collapsed) {
+			dfrag =3D mptcp_carve_data_frag(msk, pfrag, offset);
+			offset =3D dfrag->offset;
+			frag_truesize =3D dfrag->overhead;
+		}
+		poffset =3D &pfrag->offset;
+		psize =3D min_t(size_t, pfrag->size - offset, avail_size);
+
+		/* Copy to page */
+		pr_debug("left=3D%zu", msg_data_left(msg));
+		psize =3D copy_page_from_iter(pfrag->page, offset,
+					    min_t(size_t, msg_data_left(msg),
+						  psize),
+					    &msg->msg_iter);
+		pr_debug("left=3D%zu", msg_data_left(msg));
+		if (!psize)
+			return -EINVAL;
+
+		if (!sk_wmem_schedule(sk, psize + dfrag->overhead))
+			return -ENOMEM;
+	} else {
 		offset =3D dfrag->offset;
-		frag_truesize =3D dfrag->overhead;
+		poffset =3D &dfrag->offset;
+		psize =3D min_t(size_t, dfrag->data_len, avail_size);
 	}
-	psize =3D min_t(size_t, pfrag->size - offset, avail_size);
-
-	/* Copy to page */
-	pr_debug("left=3D%zu", msg_data_left(msg));
-	psize =3D copy_page_from_iter(pfrag->page, offset,
-				    min_t(size_t, msg_data_left(msg), psize),
-				    &msg->msg_iter);
-	pr_debug("left=3D%zu", msg_data_left(msg));
-	if (!psize)
-		return -EINVAL;
-
-	if (!sk_wmem_schedule(sk, psize + dfrag->overhead))
-		return -ENOMEM;
 =

 	/* tell the TCP stack to delay the push so that we can safely
 	 * access the skb after the sendpages call
 	 */
-	ret =3D do_tcp_sendpages(ssk, pfrag->page, offset, psize,
+	ret =3D do_tcp_sendpages(ssk, page, offset, psize,
 			       msg->msg_flags | MSG_SENDPAGE_NOTLAST);
 	if (ret <=3D 0)
 		return ret;
 =

 	frag_truesize +=3D ret;
-	if (unlikely(ret < psize))
-		iov_iter_revert(&msg->msg_iter, psize - ret);
+	if (!retransmission) {
+		if (unlikely(ret < psize))
+			iov_iter_revert(&msg->msg_iter, psize - ret);
 =

-	/* send successful, keep track of sent data for mptcp-level
-	 * retransmission
-	 */
-	dfrag->data_len +=3D ret;
-	if (!dfrag_collapsed) {
-		get_page(dfrag->page);
-		list_add_tail(&dfrag->list, &msk->rtx_queue);
-	}
+		/* send successful, keep track of sent data for mptcp-level
+		 * retransmission
+		 */
+		dfrag->data_len +=3D ret;
+		if (!dfrag_collapsed) {
+			get_page(dfrag->page);
+			list_add_tail(&dfrag->list, &msk->rtx_queue);
+		}
 =

-	/* charge data on mptcp rtx queue to the master socket
-	 * Note: we charge such data both to sk and ssk
-	 */
-	sk->sk_forward_alloc -=3D frag_truesize;
+		/* charge data on mptcp rtx queue to the master socket
+		 * Note: we charge such data both to sk and ssk
+		 */
+		sk->sk_forward_alloc -=3D frag_truesize;
+	}
 =

 	collapsed =3D skb =3D=3D tcp_write_queue_tail(ssk);
 	BUG_ON(collapsed && !can_collapse);
@@ -281,7 +305,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (mpext) {
 		memset(mpext, 0, sizeof(*mpext));
-		mpext->data_seq =3D msk->write_seq;
+		mpext->data_seq =3D *write_seq;
 		mpext->subflow_seq =3D subflow_ctx(ssk)->rel_write_seq;
 		mpext->data_len =3D ret;
 		mpext->checksum =3D 0xbeef;
@@ -297,8 +321,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 	 */
 =

 out:
-	pfrag->offset +=3D frag_truesize;
-	msk->write_seq +=3D ret;
+	*poffset +=3D frag_truesize;
+	*write_seq +=3D ret;
 	subflow_ctx(ssk)->rel_write_seq +=3D ret;
 =

 	return ret;
@@ -347,7 +371,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	mptcp_clean_una(sk);
 	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	while (msg_data_left(msg)) {
-		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, &timeo, &mss_now,
+		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
 					 &size_goal);
 		if (ret < 0)
 			break;
-- =

2.21.0


--===============9034233139754479871==--
