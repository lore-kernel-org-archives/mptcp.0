Content-Type: multipart/mixed; boundary="===============8605122965790388702=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v2 4/8] mptcp: queue data for mptcp level
 retransmission
Date: Thu, 22 Aug 2019 15:47:41 +0200
Message-ID: <40a2dd6778b9e83fbf7c34d40d765dc436f97b97.1566481012.git.pabeni@redhat.com>
In-Reply-To: cover.1566481012.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1670

--===============8605122965790388702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

keep the send page fragment on an MPTCP level retransmission queue.
the queue entries are allocated inside the page frag allocator,
acquiring an additional reference to the page for each list entry.

Also switch to a custom page frag refill function, to ensure that
the current page fragment can always host an MPTCP rtx queue entry.

The MPTCP rtx queue is flushed at disconnect() and close() time

Note that now we need to call __mptcp_init_sock() regarless of mptcp
enable status, as the destructor will try to walk the rtx_queue.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
rfc v1 -> rfc v2:
 - rtx_queue_tail is now static inline (fix link issue)
 - simpler ALIGN() usage (Florian)
 - fix pfrag accounting, adding rtx entry overhead when allocating
   a new one
 - fixed page -> virt conversion
 - always init mptcp data structs
 - move rtx queue flushing into both disconnect() and close()
---
 net/mptcp/protocol.c | 106 +++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h |  20 ++++++++
 2 files changed, 118 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3137bae504e4..21547a21b4f2 100644
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
@@ -101,14 +109,46 @@ static void mptcp_update_subflow_una(struct sock *sk,=
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
+		      int orig_offset)
+{
+	int offset =3D ALIGN(orig_offset, sizeof(long));
+	struct mptcp_data_frag *dfrag;
+
+	dfrag =3D (struct mptcp_data_frag *)(page_to_virt(pfrag->page) + offset);
+	dfrag->data_len =3D 0;
+	dfrag->data_seq =3D msk->write_seq;
+	dfrag->overhead =3D offset - orig_offset + sizeof(struct mptcp_data_frag);
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
+	int mss_now, avail_size, size_goal, offset, ret, frag_truesize =3D 0;
+	bool dfrag_collapsed, collapsed, can_collapse =3D false;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	bool collapsed, can_collapse =3D false;
 	struct mptcp_ext *mpext =3D NULL;
+	struct mptcp_data_frag *dfrag;
 	struct page_frag *pfrag;
 	struct sk_buff *skb;
 	size_t psize;
@@ -117,7 +157,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 	 * from one substream to another, but do per subflow memory accounting
 	 */
 	pfrag =3D sk_page_frag(sk);
-	while (!sk_page_frag_refill(ssk, pfrag)) {
+	while (!mptcp_page_frag_refill(ssk, pfrag)) {
 		ret =3D sk_stream_wait_memory(ssk, timeo);
 		if (ret)
 			return ret;
@@ -147,11 +187,22 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
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
@@ -161,13 +212,24 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 	/* tell the TCP stack to delay the push so that we can safely
 	 * access the skb after the sendpages call
 	 */
-	ret =3D do_tcp_sendpages(ssk, pfrag->page, pfrag->offset, psize,
+	ret =3D do_tcp_sendpages(ssk, pfrag->page, offset, psize,
 			       msg->msg_flags | MSG_SENDPAGE_NOTLAST);
 	if (ret <=3D 0)
 		return ret;
+
+	frag_truesize +=3D ret;
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
@@ -196,7 +258,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 	 */
 =

 out:
-	pfrag->offset +=3D ret;
+	pfrag->offset +=3D frag_truesize;
 	msk->write_seq +=3D ret;
 	subflow_ctx(ssk)->rel_write_seq +=3D ret;
 =

@@ -615,16 +677,33 @@ static int __mptcp_init_sock(struct sock *sk)
 	pr_debug("msk=3D%p", msk);
 =

 	INIT_LIST_HEAD(&msk->conn_list);
+	INIT_LIST_HEAD(&msk->rtx_queue);
 =

 	return 0;
 }
 =

 static int mptcp_init_sock(struct sock *sk)
 {
+	int ret =3D __mptcp_init_sock(sk);
+
+	if (ret)
+		return ret;
+
 	if (!mptcp_is_enabled(sock_net(sk)))
 		return -ENOPROTOOPT;
 =

-	return __mptcp_init_sock(sk);
+	return 0;
+}
+
+static void __mptcp_clear_xmit(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_data_frag *dtmp, *dfrag;
+
+	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
+		list_del(&dfrag->list);
+		put_page(dfrag->page);
+	}
 }
 =

 static void mptcp_close(struct sock *sk, long timeout)
@@ -651,12 +730,22 @@ static void mptcp_close(struct sock *sk, long timeout)
 		pr_debug("conn_list->subflow=3D%p", subflow);
 		sock_release(mptcp_subflow_tcp_socket(subflow));
 	}
+
+	__mptcp_clear_xmit(sk);
 	release_sock(sk);
 =

 	sock_orphan(sk);
 	sock_put(sk);
 }
 =

+static int mptcp_disconnect(struct sock *sk, int flags)
+{
+	lock_sock(sk);
+	__mptcp_clear_xmit(sk);
+	release_sock(sk);
+	return tcp_disconnect(sk, flags);
+}
+
 static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 				 bool kern)
 {
@@ -884,6 +973,7 @@ static struct proto mptcp_prot =3D {
 	.name		=3D "MPTCP",
 	.owner		=3D THIS_MODULE,
 	.init		=3D mptcp_init_sock,
+	.disconnect	=3D mptcp_disconnect,
 	.close		=3D mptcp_close,
 	.accept		=3D mptcp_accept,
 	.setsockopt	=3D mptcp_setsockopt,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9220afe0d362..8b3811b550dd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -108,6 +108,15 @@ struct mptcp_pm_data {
 	u32	token;
 };
 =

+struct mptcp_data_frag {
+	struct list_head list;
+	u64 data_seq;
+	int data_len;
+	int offset;
+	int overhead;
+	struct page *page;
+};
+
 /* MPTCP connection sock */
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
@@ -120,6 +129,7 @@ struct mptcp_sock {
 	u32		token;
 	u16		dport;
 	struct list_head conn_list;
+	struct list_head rtx_queue;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct mptcp_pm_data	pm;
 	u8		addr_signal;
@@ -133,6 +143,16 @@ static inline struct mptcp_sock *mptcp_sk(const struct=
 sock *sk)
 	return (struct mptcp_sock *)sk;
 }
 =

+static inline struct mptcp_data_frag *mptcp_rtx_tail(const struct sock *sk)
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

2.21.0


--===============8605122965790388702==--
