Content-Type: multipart/mixed; boundary="===============8652468735243814742=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 2/7] mptcp: avoid blocking in tcp_sendpages
Date: Mon, 11 May 2020 13:55:33 +0200
Message-ID: <20200511115538.6015-3-fw@strlen.de>
In-Reply-To: 20200511115538.6015-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4361

--===============8652468735243814742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The transmit loop continues to xmit new data until an error is returned
or all data was transmitted.

For the blocking i/o case, this means that tcp_sendpages() may block on
the subflow until more space becomes available, i.e. we end up sleeping
with the mptcp socket lock held.

Instead we should check if a different subflow is ready to be used.

This restarts the subflow sk lookup when the tx operation succeeded
and the tcp subflow can't accept more data or if tcp_sendpages
indicates -EAGAIN on a blocking mptcp socket.

In that case we also need to set the NOSPACE bit to make sure we get
notified once memory becomes available.

In case all subflows are busy, the existing logic will wait until a
subflow is ready, releasing the mptcp socket lock while doing so.

The mptcp worker already sets DONTWAIT, so no need to make changes there.

v2:
 * set NOSPACE bit
 * add a comment to clarify that mptcp-sk sndbuf limits need to
   be checked as well.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d14e2aa30a14..13fb04d45083 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -590,7 +590,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 	 * access the skb after the sendpages call
 	 */
 	ret =3D do_tcp_sendpages(ssk, page, offset, psize,
-			       msg->msg_flags | MSG_SENDPAGE_NOTLAST);
+			       msg->msg_flags | MSG_SENDPAGE_NOTLAST | MSG_DONTWAIT);
 	if (ret <=3D 0)
 		return ret;
 =

@@ -718,6 +718,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	struct socket *ssock;
 	size_t copied =3D 0;
 	struct sock *ssk;
+	bool tx_ok;
 	long timeo;
 =

 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
@@ -742,6 +743,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
 	}
 =

+restart:
 	mptcp_clean_una(sk);
 =

 wait_for_sndbuf:
@@ -764,11 +766,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 	pr_debug("conn_list->subflow=3D%p", ssk);
 =

 	lock_sock(ssk);
-	while (msg_data_left(msg)) {
+	tx_ok =3D msg_data_left(msg);
+	while (tx_ok) {
 		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
 					 &size_goal);
-		if (ret < 0)
+		if (ret < 0) {
+			if (ret =3D=3D -EAGAIN && timeo > 0) {
+				release_sock(ssk);
+				goto restart;
+			}
 			break;
+		}
 		if (ret =3D=3D 0 && unlikely(__mptcp_needs_tcp_fallback(msk))) {
 			/* Can happen for passive sockets:
 			 * 3WHS negotiated MPTCP, but first packet after is
@@ -783,11 +791,30 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =

 		copied +=3D ret;
 =

+		tx_ok =3D msg_data_left(msg);
+		if (!tx_ok)
+			break;
+
+		if (!sk_stream_memory_free(ssk)) {
+			set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+			tcp_push(ssk, msg->msg_flags, mss_now,
+				 tcp_sk(ssk)->nonagle, size_goal);
+			release_sock(ssk);
+			goto restart;
+		}
+
 		/* memory is charged to mptcp level socket as well, i.e.
 		 * if msg is very large, mptcp socket may run out of buffer
 		 * space.  mptcp_clean_una() will release data that has
 		 * been acked at mptcp level in the mean time, so there is
 		 * a good chance we can continue sending data right away.
+		 *
+		 * Normally, when the tcp subflow can accept more data, then
+		 * so can the MPTCP socket.  However, we need to cope with
+		 * peers that might lag behind in their MPTCP-level
+		 * acknowledgements, i.e.  data might have been acked at
+		 * tcp level only.  So, we must also check the MPTCP socket
+		 * limits before we send more data.
 		 */
 		if (unlikely(!sk_stream_memory_free(sk))) {
 			tcp_push(ssk, msg->msg_flags, mss_now,
-- =

2.26.2

--===============8652468735243814742==--
