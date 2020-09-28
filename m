Content-Type: multipart/mixed; boundary="===============3925909400203717830=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 3/9] mptcp: reduce the arguments of
 mptcp_sendmsg_frag
Date: Mon, 28 Sep 2020 17:04:55 +0200
Message-ID: <5e4cd4e0488ecec6b9fd6ca19bb16b2a210882d8.1601304622.git.pabeni@redhat.com>
In-Reply-To: cover.1601304622.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6078

--===============3925909400203717830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current argument list is pretty long and quite unreadable,
move many of them into a specific struct. Later patches
will add more stuff to such struct.

Additionally drop the 'timeo' argument, now unused.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v8 -> v9:
 - cleanup mptcp_sendmsg_info init in mptcp_worker
---
 net/mptcp/protocol.c | 53 ++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index efa8589a1c7d..eb8c6d7a4b16 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -892,12 +892,16 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, s=
truct page_frag *pfrag,
 	return dfrag;
 }
 =

+struct mptcp_sendmsg_info {
+	int mss_now;
+	int size_goal;
+};
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct msghdr *msg, struct mptcp_data_frag *dfrag,
-			      long *timeo, int *pmss_now,
-			      int *ps_goal)
+			      struct mptcp_sendmsg_info *info)
 {
-	int mss_now, avail_size, size_goal, offset, ret, frag_truesize =3D 0;
+	int avail_size, offset, ret, frag_truesize =3D 0;
 	bool dfrag_collapsed, can_collapse =3D false;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_ext *mpext =3D NULL;
@@ -923,10 +927,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 	}
 =

 	/* compute copy limit */
-	mss_now =3D tcp_send_mss(ssk, &size_goal, msg->msg_flags);
-	*pmss_now =3D mss_now;
-	*ps_goal =3D size_goal;
-	avail_size =3D size_goal;
+	info->mss_now =3D tcp_send_mss(ssk, &info->size_goal, msg->msg_flags);
+	avail_size =3D info->size_goal;
 	skb =3D tcp_write_queue_tail(ssk);
 	if (skb) {
 		mpext =3D skb_ext_find(skb, SKB_EXT_MPTCP);
@@ -937,12 +939,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 		 * queue management operation, to avoid breaking the ext <->
 		 * SSN association set here
 		 */
-		can_collapse =3D (size_goal - skb->len > 0) &&
+		can_collapse =3D (info->size_goal - skb->len > 0) &&
 			      mptcp_skb_can_collapse_to(*write_seq, skb, mpext);
 		if (!can_collapse)
 			TCP_SKB_CB(skb)->eor =3D 1;
 		else
-			avail_size =3D size_goal - skb->len;
+			avail_size =3D info->size_goal - skb->len;
 	}
 =

 	if (!retransmission) {
@@ -1174,11 +1176,15 @@ static void ssk_check_wmem(struct mptcp_sock *msk)
 =

 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
-	int mss_now =3D 0, size_goal =3D 0, ret =3D 0;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_sendmsg_info info =3D {
+		.mss_now =3D 0,
+		.size_goal =3D 0,
+	};
 	struct page_frag *pfrag;
 	size_t copied =3D 0;
 	struct sock *ssk;
+	int ret =3D 0;
 	u32 sndbuf;
 	bool tx_ok;
 	long timeo;
@@ -1247,8 +1253,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 	lock_sock(ssk);
 	tx_ok =3D msg_data_left(msg);
 	while (tx_ok) {
-		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
-					 &size_goal);
+		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &info);
 		if (ret < 0) {
 			if (ret =3D=3D -EAGAIN && timeo > 0) {
 				mptcp_set_timeout(sk, ssk);
@@ -1271,8 +1276,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		if (!sk_stream_memory_free(ssk) ||
 		    !mptcp_page_frag_refill(ssk, pfrag) ||
 		    !mptcp_ext_cache_refill(msk)) {
-			tcp_push(ssk, msg->msg_flags, mss_now,
-				 tcp_sk(ssk)->nonagle, size_goal);
+			tcp_push(ssk, msg->msg_flags, info.mss_now,
+				 tcp_sk(ssk)->nonagle, info.size_goal);
 			mptcp_set_timeout(sk, ssk);
 			release_sock(ssk);
 			goto restart;
@@ -1292,8 +1297,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		 * limits before we send more data.
 		 */
 		if (unlikely(!sk_stream_memory_free(sk))) {
-			tcp_push(ssk, msg->msg_flags, mss_now,
-				 tcp_sk(ssk)->nonagle, size_goal);
+			tcp_push(ssk, msg->msg_flags, info.mss_now,
+				 tcp_sk(ssk)->nonagle, info.size_goal);
 			mptcp_clean_una(sk);
 			if (!sk_stream_memory_free(sk)) {
 				/* can't send more for now, need to wait for
@@ -1310,8 +1315,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =

 	mptcp_set_timeout(sk, ssk);
 	if (copied) {
-		tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle,
-			 size_goal);
+		tcp_push(ssk, msg->msg_flags, info.mss_now,
+			 tcp_sk(ssk)->nonagle, info.size_goal);
 =

 		/* start the timer, if it's not pending */
 		if (!mptcp_timer_pending(sk))
@@ -1736,14 +1741,15 @@ static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
 	struct sock *ssk, *sk =3D &msk->sk.icsk_inet.sk;
-	int orig_len, orig_offset, mss_now =3D 0, size_goal =3D 0;
+	struct mptcp_sendmsg_info info =3D {};
 	struct mptcp_data_frag *dfrag;
+	int orig_len, orig_offset;
 	u64 orig_write_seq;
 	size_t copied =3D 0;
 	struct msghdr msg =3D {
 		.msg_flags =3D MSG_DONTWAIT,
 	};
-	long timeo =3D 0;
+	int ret;
 =

 	lock_sock(sk);
 	mptcp_clean_una_wakeup(sk);
@@ -1779,8 +1785,7 @@ static void mptcp_worker(struct work_struct *work)
 	orig_offset =3D dfrag->offset;
 	orig_write_seq =3D dfrag->data_seq;
 	while (dfrag->data_len > 0) {
-		int ret =3D mptcp_sendmsg_frag(sk, ssk, &msg, dfrag, &timeo,
-					     &mss_now, &size_goal);
+		ret =3D mptcp_sendmsg_frag(sk, ssk, &msg, dfrag, &info);
 		if (ret < 0)
 			break;
 =

@@ -1793,8 +1798,8 @@ static void mptcp_worker(struct work_struct *work)
 			break;
 	}
 	if (copied)
-		tcp_push(ssk, msg.msg_flags, mss_now, tcp_sk(ssk)->nonagle,
-			 size_goal);
+		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+			 info.size_goal);
 =

 	dfrag->data_seq =3D orig_write_seq;
 	dfrag->offset =3D orig_offset;
-- =

2.26.2

--===============3925909400203717830==--
