Content-Type: multipart/mixed; boundary="===============1400893242900441022=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 1/7] mptcp: break and restart in case mptcp
 sndbuf is full
Date: Mon, 11 May 2020 13:55:32 +0200
Message-ID: <20200511115538.6015-2-fw@strlen.de>
In-Reply-To: 20200511115538.6015-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4360

--===============1400893242900441022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Its not enough to wait for TCP-level acks (free tcp send space).
We also hold on to any transmitted data for mptcp-level retransmits,
so we can't continue sending more data when there is no more mptcp send
buffer space available.

Therefore add needed check in mptcp_sendmsg, flush tcp data and
wait until mptcp snd space becomes available.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e1f23016ed3f..d14e2aa30a14 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -653,6 +653,15 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 	return ret;
 }
 =

+static void mptcp_nospace(struct mptcp_sock *msk, struct socket *sock)
+{
+	clear_bit(MPTCP_SEND_SPACE, &msk->flags);
+	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */
+
+	/* enables sk->write_space() callbacks */
+	set_bit(SOCK_NOSPACE, &sock->flags);
+}
+
 static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -666,13 +675,8 @@ static struct sock *mptcp_subflow_get_send(struct mptc=
p_sock *msk)
 		if (!sk_stream_memory_free(ssk)) {
 			struct socket *sock =3D ssk->sk_socket;
 =

-			if (sock) {
-				clear_bit(MPTCP_SEND_SPACE, &msk->flags);
-				smp_mb__after_atomic();
-
-				/* enables sk->write_space() callbacks */
-				set_bit(SOCK_NOSPACE, &sock->flags);
-			}
+			if (sock)
+				mptcp_nospace(msk, sock);
 =

 			return NULL;
 		}
@@ -740,6 +744,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 =

 	mptcp_clean_una(sk);
 =

+wait_for_sndbuf:
 	__mptcp_flush_join_list(msk);
 	ssk =3D mptcp_subflow_get_send(msk);
 	while (!sk_stream_memory_free(sk) || !ssk) {
@@ -777,6 +782,24 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 		}
 =

 		copied +=3D ret;
+
+		/* memory is charged to mptcp level socket as well, i.e.
+		 * if msg is very large, mptcp socket may run out of buffer
+		 * space.  mptcp_clean_una() will release data that has
+		 * been acked at mptcp level in the mean time, so there is
+		 * a good chance we can continue sending data right away.
+		 */
+		if (unlikely(!sk_stream_memory_free(sk))) {
+			tcp_push(ssk, msg->msg_flags, mss_now,
+				 tcp_sk(ssk)->nonagle, size_goal);
+			mptcp_clean_una(sk);
+			if (!sk_stream_memory_free(sk)) {
+				/* no luck, can't send more for now */
+				mptcp_nospace(msk, sk->sk_socket);
+				release_sock(ssk);
+				goto wait_for_sndbuf;
+			}
+		}
 	}
 =

 	mptcp_set_timeout(sk, ssk);
-- =

2.26.2

--===============1400893242900441022==--
