Content-Type: multipart/mixed; boundary="===============7029943654990958093=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v3 05/13] mptcp: reduce the arguments of
 mptcp_sendmsg_frag
Date: Mon, 16 Nov 2020 10:48:06 +0100
Message-ID: <7123ec097bc4983e26456cc1a993f6367697b9ca.1605458224.git.pabeni@redhat.com>
In-Reply-To: cover.1605458224.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6743

--===============7029943654990958093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current argument list is pretty long and quite unreadable,
move many of them into a specific struct. Later patches
will add more stuff to such struct.

Additionally drop the 'timeo' argument, now unused.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 53 ++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0e725f18af24..4ed9b1cc3b1e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -914,12 +914,16 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, s=
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
@@ -945,10 +949,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
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
@@ -959,12 +961,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
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
@@ -1187,11 +1189,15 @@ static void ssk_check_wmem(struct mptcp_sock *msk)
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
@@ -1260,8 +1266,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
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
@@ -1284,8 +1289,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
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
@@ -1305,8 +1310,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
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
@@ -1323,8 +1328,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
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
@@ -1763,14 +1768,15 @@ static void mptcp_worker(struct work_struct *work)
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
@@ -1809,8 +1815,7 @@ static void mptcp_worker(struct work_struct *work)
 	orig_offset =3D dfrag->offset;
 	orig_write_seq =3D dfrag->data_seq;
 	while (dfrag->data_len > 0) {
-		int ret =3D mptcp_sendmsg_frag(sk, ssk, &msg, dfrag, &timeo,
-					     &mss_now, &size_goal);
+		ret =3D mptcp_sendmsg_frag(sk, ssk, &msg, dfrag, &info);
 		if (ret < 0)
 			break;
 =

@@ -1823,8 +1828,8 @@ static void mptcp_worker(struct work_struct *work)
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

--===============7029943654990958093==--
