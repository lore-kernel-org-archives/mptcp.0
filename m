Content-Type: multipart/mixed; boundary="===============3385776890012969317=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/3] mptcp: sendmsg() do spool all the provided data
Date: Mon, 15 Apr 2019 17:30:48 +0200
Message-ID: <5a13075a3593ca3560a192fbc56bf37dbb6eb674.1555342070.git.pabeni@redhat.com>
In-Reply-To: cover.1555342070.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1069

--===============3385776890012969317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This makes mptcp sendmsg() behaviour more consistent and
improves xmit performances.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 91 ++++++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 38 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1b843c5e2dbc..085d658af772 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -47,52 +47,24 @@ static struct sock *mptcp_subflow_get_ref(const struct =
mptcp_sock *msk)
 	return NULL;
 }
 =

-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
+			      struct msghdr *msg, long *timeo)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	int mss_now, size_goal, poffset, ret;
 	struct mptcp_ext *mpext =3D NULL;
 	struct page_frag *pfrag;
 	struct sk_buff *skb;
-	struct sock *ssk;
 	size_t psize;
-	long timeo;
-
-	pr_debug("msk=3D%p", msk);
-	if (msk->subflow) {
-		pr_debug("fallback passthrough");
-		return sock_sendmsg(msk->subflow, msg);
-	}
-
-	ssk =3D mptcp_subflow_get_ref(msk);
-	if (!ssk)
-		return -ENOTCONN;
-
-	if (!msg_data_left(msg)) {
-		pr_debug("empty send");
-		ret =3D sock_sendmsg(ssk->sk_socket, msg);
-		goto put_out;
-	}
-
-	pr_debug("conn_list->subflow=3D%p", ssk);
-
-	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL)) {
-		ret =3D -ENOTSUPP;
-		goto put_out;
-	}
-
-	lock_sock(sk);
-	lock_sock(ssk);
-	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 =

 	/* use the mptcp page cache so that we can easily move the data
 	 * from one substream to another, but do per subflow memory accounting
 	 */
 	pfrag =3D sk_page_frag(sk);
 	while (!sk_page_frag_refill(ssk, pfrag)) {
-		ret =3D sk_stream_wait_memory(ssk, &timeo);
+		ret =3D sk_stream_wait_memory(ssk, timeo);
 		if (ret)
-			goto release_out;
+			return ret;
 	}
 =

 	/* Copy to page */
@@ -103,10 +75,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 					  pfrag->size - poffset),
 				    &msg->msg_iter);
 	pr_debug("left=3D%zu", msg_data_left(msg));
-	if (!psize) {
-		ret =3D -EINVAL;
-		goto release_out;
-	}
+	if (!psize)
+		return -EINVAL;
 =

 	/* Mark the end of the previous write so the beginning of the
 	 * next write (with its own mptcp skb extension data) is not
@@ -121,7 +91,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr =
*msg, size_t len)
 	ret =3D do_tcp_sendpages(ssk, pfrag->page, poffset, psize,
 			       msg->msg_flags | MSG_SENDPAGE_NOTLAST);
 	if (ret <=3D 0)
-		goto release_out;
+		return ret;
 =

 	if (skb =3D=3D tcp_write_queue_tail(ssk))
 		pr_err("no new skb %p/%p", sk, ssk);
@@ -149,8 +119,53 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 	subflow_ctx(ssk)->rel_write_seq +=3D ret;
 =

 	tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle, size_goal);
+	return ret;
+}
+
+static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	size_t copied =3D 0;
+	struct sock *ssk;
+	int ret =3D 0;
+	long timeo;
+
+	pr_debug("msk=3D%p", msk);
+	if (msk->subflow) {
+		pr_debug("fallback passthrough");
+		return sock_sendmsg(msk->subflow, msg);
+	}
+
+	ssk =3D mptcp_subflow_get_ref(msk);
+	if (!ssk)
+		return -ENOTCONN;
+
+	if (!msg_data_left(msg)) {
+		pr_debug("empty send");
+		ret =3D sock_sendmsg(ssk->sk_socket, msg);
+		goto put_out;
+	}
+
+	pr_debug("conn_list->subflow=3D%p", ssk);
+
+	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL)) {
+		ret =3D -ENOTSUPP;
+		goto put_out;
+	}
+
+	lock_sock(sk);
+	lock_sock(ssk);
+	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
+	while (msg_data_left(msg)) {
+		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, &timeo);
+		if (ret < 0)
+			break;
+
+		copied +=3D ret;
+	}
+	if (copied > 0)
+		ret =3D copied;
 =

-release_out:
 	release_sock(ssk);
 	release_sock(sk);
 =

-- =

2.20.1


--===============3385776890012969317==--
