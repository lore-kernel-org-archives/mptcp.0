Content-Type: multipart/mixed; boundary="===============2695749280321809262=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 13/15] mptcp: allow collapsing consecutive
 sendpages on the same substream
Date: Wed, 18 Dec 2019 11:55:08 -0800
Message-ID: <20191218195510.7782-14-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191218195510.7782-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3157

--===============2695749280321809262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

If the current sendmsg() lands on the same subflow we used last, we
can try to collapse the data.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 75 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8545e326546b..79d45081e66e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -123,14 +123,27 @@ static struct sock *mptcp_subflow_recv_lookup(const s=
truct mptcp_sock *msk)
 	return NULL;
 }
 =

+static inline bool mptcp_skb_can_collapse_to(const struct mptcp_sock *msk,
+					     const struct sk_buff *skb,
+					     const struct mptcp_ext *mpext)
+{
+	if (!tcp_skb_can_collapse_to(skb))
+		return false;
+
+	/* can collapse only if MPTCP level sequence is in order */
+	return mpext && mpext->data_seq + mpext->data_len =3D=3D msk->write_seq;
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
-			      struct msghdr *msg, long *timeo)
+			      struct msghdr *msg, long *timeo, int *pmss_now,
+			      int *ps_goal)
 {
-	int mss_now =3D 0, size_goal =3D 0, ret =3D 0;
+	int mss_now, avail_size, size_goal, ret;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_ext *mpext =3D NULL;
+	struct sk_buff *skb, *tail;
+	bool can_collapse =3D false;
 	struct page_frag *pfrag;
-	struct sk_buff *skb;
 	size_t psize;
 =

 	/* use the mptcp page cache so that we can easily move the data
@@ -146,8 +159,29 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 =

 	/* compute copy limit */
 	mss_now =3D tcp_send_mss(ssk, &size_goal, msg->msg_flags);
-	psize =3D min_t(int, pfrag->size - pfrag->offset, size_goal);
+	*pmss_now =3D mss_now;
+	*ps_goal =3D size_goal;
+	avail_size =3D size_goal;
+	skb =3D tcp_write_queue_tail(ssk);
+	if (skb) {
+		mpext =3D skb_ext_find(skb, SKB_EXT_MPTCP);
+
+		/* Limit the write to the size available in the
+		 * current skb, if any, so that we create at most a new skb.
+		 * Explicitly tells TCP internals to avoid collapsing on later
+		 * queue management operation, to avoid breaking the ext <->
+		 * SSN association set here
+		 */
+		can_collapse =3D (size_goal - skb->len > 0) &&
+			      mptcp_skb_can_collapse_to(msk, skb, mpext);
+		if (!can_collapse)
+			TCP_SKB_CB(skb)->eor =3D 1;
+		else
+			avail_size =3D size_goal - skb->len;
+	}
+	psize =3D min_t(size_t, pfrag->size - pfrag->offset, avail_size);
 =

+	/* Copy to page */
 	pr_debug("left=3D%zu", msg_data_left(msg));
 	psize =3D copy_page_from_iter(pfrag->page, pfrag->offset,
 				    min_t(size_t, msg_data_left(msg), psize),
@@ -156,14 +190,9 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 	if (!psize)
 		return -EINVAL;
 =

-	/* Mark the end of the previous write so the beginning of the
-	 * next write (with its own mptcp skb extension data) is not
-	 * collapsed.
+	/* tell the TCP stack to delay the push so that we can safely
+	 * access the skb after the sendpages call
 	 */
-	skb =3D tcp_write_queue_tail(ssk);
-	if (skb)
-		TCP_SKB_CB(skb)->eor =3D 1;
-
 	ret =3D do_tcp_sendpages(ssk, pfrag->page, pfrag->offset, psize,
 			       msg->msg_flags | MSG_SENDPAGE_NOTLAST);
 	if (ret <=3D 0)
@@ -171,6 +200,18 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 	if (unlikely(ret < psize))
 		iov_iter_revert(&msg->msg_iter, psize - ret);
 =

+	/* if the tail skb extension is still the cached one, collapsing
+	 * really happened. Note: we can't check for 'same skb' as the sk_buff
+	 * hdr on tail can be transmitted, freed and re-allocated by the
+	 * do_tcp_sendpages() call
+	 */
+	tail =3D tcp_write_queue_tail(ssk);
+	if (mpext && tail && mpext =3D=3D skb_ext_find(tail, SKB_EXT_MPTCP)) {
+		WARN_ON_ONCE(!can_collapse);
+		mpext->data_len +=3D ret;
+		goto out;
+	}
+
 	skb =3D tcp_write_queue_tail(ssk);
 	mpext =3D __skb_ext_set(skb, SKB_EXT_MPTCP, msk->cached_ext);
 	msk->cached_ext =3D NULL;
@@ -186,11 +227,11 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 		 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
 		 mpext->dsn64);
 =

+out:
 	pfrag->offset +=3D ret;
 	msk->write_seq +=3D ret;
 	mptcp_subflow_ctx(ssk)->rel_write_seq +=3D ret;
 =

-	tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle, size_goal);
 	return ret;
 }
 =

@@ -212,11 +253,11 @@ static void ssk_check_wmem(struct mptcp_sock *msk, st=
ruct sock *ssk)
 =

 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
+	int mss_now =3D 0, size_goal =3D 0, ret =3D 0;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct socket *ssock;
 	size_t copied =3D 0;
 	struct sock *ssk;
-	int ret =3D 0;
 	long timeo;
 =

 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
@@ -243,15 +284,19 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =

 	lock_sock(ssk);
 	while (msg_data_left(msg)) {
-		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, &timeo);
+		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, &timeo, &mss_now,
+					 &size_goal);
 		if (ret < 0)
 			break;
 =

 		copied +=3D ret;
 	}
 =

-	if (copied > 0)
+	if (copied) {
 		ret =3D copied;
+		tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle,
+			 size_goal);
+	}
 =

 	ssk_check_wmem(msk, ssk);
 	release_sock(ssk);
-- =

2.24.1

--===============2695749280321809262==--
