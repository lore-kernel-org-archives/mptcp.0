Content-Type: multipart/mixed; boundary="===============5347016697512183513=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 3/3] mptcp: allow collapsing consecutive sendpages
 on the same substream
Date: Fri, 10 May 2019 17:59:21 +0200
Message-ID: <53bb75e5b0f94a4905e9d6f12d6460e1cb102da2.1557497920.git.pabeni@redhat.com>
In-Reply-To: cover.1557497920.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1145

--===============5347016697512183513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the current sendmsg() lands on the same subflow we used last, we
can try to collapse the data.

 v2 -> v3:
 - avoid BUG_ON(!mpext) on pending skb, we can have pure acks there
   with no mptcp ext
 - rebased

 v1 -> v2:
 - reordered the code according to Mat's suggestion
 - rebased on top of previous patch's changes

 RFC -> v1:
 - claried collasping schema
 - update data_len for collapsed skb in mptcp_sendmsg_frag()
 - fix collapsing decision on mptcp-level OoO

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 79 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7ebcceb1d10d..1c9b1e183d12 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -48,12 +48,25 @@ static struct sock *mptcp_subflow_get_ref(const struct =
mptcp_sock *msk)
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
+	int mss_now, avail_size, size_goal, ret;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	bool collapsed, can_collapse =3D false;
 	struct mptcp_ext *mpext =3D NULL;
-	int mss_now, size_goal, ret;
 	struct page_frag *pfrag;
 	struct sk_buff *skb;
 	size_t psize;
@@ -70,8 +83,31 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct so=
ck *ssk,
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
+		 * If we run out of space in the current skb (e.g. the window
+		 * size shrunk from last sent) a new skb will be allocated even
+		 * is collapsing was allowed: collapsing is effectively
+		 * disabled.
+		 */
+		can_collapse =3D mptcp_skb_can_collapse_to(msk, skb, mpext);
+		if (!can_collapse)
+			TCP_SKB_CB(skb)->eor =3D 1;
+		else if (size_goal - skb->len > 0)
+			avail_size =3D size_goal - skb->len;
+		else
+			can_collapse =3D false;
+	}
+	psize =3D min_t(size_t, pfrag->size - pfrag->offset, avail_size);
 =

+	/* Copy to page */
 	pr_debug("left=3D%zu", msg_data_left(msg));
 	psize =3D copy_page_from_iter(pfrag->page, pfrag->offset,
 				    min_t(size_t, msg_data_left(msg), psize),
@@ -80,14 +116,9 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
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
@@ -95,13 +126,16 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 	if (unlikely(ret < psize))
 		iov_iter_revert(&msg->msg_iter, psize - ret);
 =

-	if (skb =3D=3D tcp_write_queue_tail(ssk))
-		pr_err("no new skb %p/%p", sk, ssk);
+	collapsed =3D skb =3D=3D tcp_write_queue_tail(ssk);
+	BUG_ON(collapsed && !can_collapse);
+	if (collapsed) {
+		/* when collapsing mpext always exists */
+		mpext->data_len +=3D ret;
+		goto out;
+	}
 =

 	skb =3D tcp_write_queue_tail(ssk);
-
 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
-
 	if (mpext) {
 		memset(mpext, 0, sizeof(*mpext));
 		mpext->data_seq =3D msk->write_seq;
@@ -114,22 +148,25 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 		pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u checksum=3D%u, =
dsn64=3D%d",
 			 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
 			 mpext->checksum, mpext->dsn64);
-	} /* TODO: else fallback */
+	}
+	/* TODO: else fallback; allocation can fail, but we can't easily retire
+	 * skbs from the write_queue, as we need to roll-back TCP status
+	 */
 =

+out:
 	pfrag->offset +=3D ret;
 	msk->write_seq +=3D ret;
 	subflow_ctx(ssk)->rel_write_seq +=3D ret;
 =

-	tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle, size_goal);
 	return ret;
 }
 =

 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
+	int mss_now =3D 0, size_goal =3D 0, ret =3D 0;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	size_t copied =3D 0;
 	struct sock *ssk;
-	int ret =3D 0;
 	long timeo;
 =

 	pr_debug("msk=3D%p", msk);
@@ -159,14 +196,18 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 	lock_sock(ssk);
 	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	while (msg_data_left(msg)) {
-		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, &timeo);
+		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, &timeo, &mss_now,
+					 &size_goal);
 		if (ret < 0)
 			break;
 =

 		copied +=3D ret;
 	}
-	if (copied > 0)
+	if (copied) {
 		ret =3D copied;
+		tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle,
+			 size_goal);
+	}
 =

 	release_sock(ssk);
 	release_sock(sk);
-- =

2.20.1


--===============5347016697512183513==--
