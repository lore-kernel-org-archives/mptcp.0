Content-Type: multipart/mixed; boundary="===============7879953027685487323=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PRE-RFC 4/6] mptcp: queue data for mptcp level retransmission
Date: Fri, 16 Aug 2019 18:48:02 +0200
Message-ID: <666fcde927e49fe2e51ebf38e8b6b7d2c3da13d2.1565970525.git.pabeni@redhat.com>
In-Reply-To: cover.1565970525.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1649

--===============7879953027685487323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

keep the send page fragment on an MPTCP level retransmission queue.
the queue entries are allocated inside the page frag allocator,
acquiring an additional reference to the page for each list entry.

Also switch to a custom page frag refill function, to ensure that
the current page fragment can always host an MPTCP rtx queue entry.

The MPTCP rtx queue is flushed at socket destroy() time.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 79 ++++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h | 19 +++++++++++
 2 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b7468f770d25..dcfffb71b545 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -67,6 +67,14 @@ static inline bool mptcp_skb_can_collapse_to(const struc=
t mptcp_sock *msk,
 	return mpext && mpext->data_seq + mpext->data_len =3D=3D msk->write_seq;
 }
 =

+static inline bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
+					      const struct page_frag *pfrag,
+					      const struct mptcp_data_frag *df)
+{
+	return df && pfrag->page =3D=3D df->page &&
+		df->data_seq + df->data_len =3D=3D msk->write_seq;
+}
+
 static u64 mptcp_update_msk_una(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -101,14 +109,45 @@ static void mptcp_update_subflow_una(struct sock *sk,=
 struct sock *ssk)
 		subflow->snd_una =3D snd_una;
 }
 =

+/* ensure we get enough memory for the frag hdr, beyond some minimal amoun=
t of
+ * data
+ */
+bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
+{
+	if (likely(skb_page_frag_refill(32U + sizeof(struct mptcp_data_frag),
+					pfrag, sk->sk_allocation)))
+		return true;
+
+	sk->sk_prot->enter_memory_pressure(sk);
+	sk_stream_moderate_sndbuf(sk);
+	return false;
+}
+
+static inline struct mptcp_data_frag *
+mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfra=
g,
+		      int offset)
+{
+	struct mptcp_data_frag *dfrag;
+
+	offset =3D ALIGN(offset, BITS_PER_LONG / 8);
+	dfrag =3D (struct mptcp_data_frag *)(pfrag->page + offset);
+	dfrag->data_len =3D 0;
+	dfrag->data_seq =3D msk->write_seq;
+	dfrag->offset =3D offset + sizeof(struct mptcp_data_frag);
+	dfrag->page =3D pfrag->page;
+
+	return dfrag;
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct msghdr *msg, long *timeo, int *pmss_now,
 			      int *ps_goal)
 {
-	int mss_now, avail_size, size_goal, ret;
+	bool dfrag_collapsed, collapsed, can_collapse =3D false;
+	int mss_now, avail_size, size_goal, offset, ret;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	bool collapsed, can_collapse =3D false;
 	struct mptcp_ext *mpext =3D NULL;
+	struct mptcp_data_frag *dfrag;
 	struct page_frag *pfrag;
 	struct sk_buff *skb;
 	size_t psize;
@@ -117,7 +156,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 	 * from one substream to another, but do per subflow memory accounting
 	 */
 	pfrag =3D sk_page_frag(sk);
-	while (!sk_page_frag_refill(ssk, pfrag)) {
+	while (!mptcp_page_frag_refill(ssk, pfrag)) {
 		ret =3D sk_stream_wait_memory(ssk, timeo);
 		if (ret)
 			return ret;
@@ -147,11 +186,22 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 		else
 			can_collapse =3D false;
 	}
-	psize =3D min_t(size_t, pfrag->size - pfrag->offset, avail_size);
+
+	/* reuse tail pfrag, if possible, or carve a new one from the page
+	 * allocator
+	 */
+	dfrag =3D mptcp_rtx_tail(sk);
+	offset =3D pfrag->offset;
+	dfrag_collapsed =3D mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
+	if (!dfrag_collapsed) {
+		dfrag =3D mptcp_carve_data_frag(msk, pfrag, offset);
+		offset =3D dfrag->offset;
+	}
+	psize =3D min_t(size_t, pfrag->size - offset, avail_size);
 =

 	/* Copy to page */
 	pr_debug("left=3D%zu", msg_data_left(msg));
-	psize =3D copy_page_from_iter(pfrag->page, pfrag->offset,
+	psize =3D copy_page_from_iter(pfrag->page, offset,
 				    min_t(size_t, msg_data_left(msg), psize),
 				    &msg->msg_iter);
 	pr_debug("left=3D%zu", msg_data_left(msg));
@@ -161,13 +211,22 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 	/* tell the TCP stack to delay the push so that we can safely
 	 * access the skb after the sendpages call
 	 */
-	ret =3D do_tcp_sendpages(ssk, pfrag->page, pfrag->offset, psize,
+	ret =3D do_tcp_sendpages(ssk, pfrag->page, offset, psize,
 			       msg->msg_flags | MSG_SENDPAGE_NOTLAST);
 	if (ret <=3D 0)
 		return ret;
 	if (unlikely(ret < psize))
 		iov_iter_revert(&msg->msg_iter, psize - ret);
 =

+	/* send succesful, keep track of sent data for mptcp-level
+	 * retransmission
+	 */
+	dfrag->data_len +=3D ret;
+	if (!dfrag_collapsed) {
+		get_page(dfrag->page);
+		list_add_tail(&dfrag->list, &msk->rtx_queue);
+	}
+
 	collapsed =3D skb =3D=3D tcp_write_queue_tail(ssk);
 	BUG_ON(collapsed && !can_collapse);
 	if (collapsed) {
@@ -615,6 +674,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	pr_debug("msk=3D%p", msk);
 =

 	INIT_LIST_HEAD(&msk->conn_list);
+	INIT_LIST_HEAD(&msk->rtx_queue);
 =

 	return 0;
 }
@@ -651,6 +711,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 		pr_debug("conn_list->subflow=3D%p", subflow);
 		sock_release(mptcp_subflow_tcp_socket(subflow));
 	}
+
 	release_sock(sk);
 =

 	sock_orphan(sk);
@@ -731,10 +792,16 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_data_frag *dtmp, *dfrag;
 =

 	pr_debug("msk=3D%p, subflow=3D%p", sk, msk->subflow->sk);
 =

 	token_destroy(msk->token);
+
+	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
+		list_del(&dfrag->list);
+		put_page(dfrag->page);
+	}
 }
 =

 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9220afe0d362..889974a4022c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -108,6 +108,14 @@ struct mptcp_pm_data {
 	u32	token;
 };
 =

+struct mptcp_data_frag {
+	struct list_head list;
+	u64 data_seq;
+	int data_len;
+	int offset;
+	struct page *page;
+};
+
 /* MPTCP connection sock */
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
@@ -120,6 +128,7 @@ struct mptcp_sock {
 	u32		token;
 	u16		dport;
 	struct list_head conn_list;
+	struct list_head rtx_queue;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct mptcp_pm_data	pm;
 	u8		addr_signal;
@@ -133,6 +142,16 @@ static inline struct mptcp_sock *mptcp_sk(const struct=
 sock *sk)
 	return (struct mptcp_sock *)sk;
 }
 =

+struct mptcp_data_frag *mptcp_rtx_tail(const struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (list_empty(&msk->rtx_queue))
+		return NULL;
+
+	return list_last_entry(&msk->rtx_queue, struct mptcp_data_frag, list);
+}
+
 struct subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u8	mp_capable : 1,
-- =

2.20.1


--===============7879953027685487323==--
