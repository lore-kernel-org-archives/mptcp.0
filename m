Content-Type: multipart/mixed; boundary="===============0394858086965547406=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 12/13] mptcp_poll: don't consider subflow socket
 state anymore
Date: Mon, 18 Nov 2019 22:45:37 +0100
Message-ID: <20191118214538.21931-13-fw@strlen.de>
In-Reply-To: 20191118214538.21931-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2597

--===============0394858086965547406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After previous patch, we do not need to call __tcp_poll anymore, we
can use msk->flags instead to see if we have data available on a socket.

SEND_SPACE flag indicates when a subflow has enough space to accept
more data, it gets cleared on mptcp_sendmsg() return in case ssk runs
below the free watermark.

The commit "net: tcp: add __tcp_poll helper" can now be removed.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9f2cbf2b89fb..b36d1b89cb34 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -189,7 +189,10 @@ static void mptcp_clean_una(struct sock *sk)
 =

 	if (cleaned) {
 		sk_mem_reclaim_partial(sk);
-		sk_stream_write_space(sk);
+
+		/* Only wake up writers if a subflow is ready */
+		if (test_bit(MPTCP_SEND_SPACE, &msk->flags))
+			sk_stream_write_space(sk);
 	}
 }
 =

@@ -837,6 +840,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->rtx_queue);
 =

 	INIT_WORK(&msk->rtx_work, mptcp_worker);
+	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
 =

 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
@@ -1401,39 +1405,35 @@ static int mptcp_stream_accept(struct socket *sock,=
 struct socket *newsock,
 static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait)
 {
-	struct mptcp_subflow_context *subflow;
 	const struct mptcp_sock *msk;
 	struct sock *sk =3D sock->sk;
 	struct socket *ssock;
-	__poll_t ret =3D 0;
+	__poll_t mask =3D 0;
 =

 	msk =3D mptcp_sk(sk);
 	lock_sock(sk);
 	ssock =3D __mptcp_fallback_get_ref(msk);
 	if (ssock) {
 		release_sock(sk);
-		ret =3D ssock->ops->poll(file, ssock, wait);
+		mask =3D ssock->ops->poll(file, ssock, wait);
 		sock_put(ssock->sk);
-		return ret;
+		return mask;
 	}
 =

 	release_sock(sk);
 	sock_poll_wait(file, sock, wait);
 	lock_sock(sk);
 =

-	mptcp_for_each_subflow(msk, subflow) {
-		struct socket *tcp_sock;
-
-		tcp_sock =3D mptcp_subflow_tcp_socket(subflow);
-		ret |=3D __tcp_poll(tcp_sock->sk);
-	}
-
-	if (!sk_stream_is_writeable(sk))
-		ret &=3D ~(EPOLLOUT|EPOLLWRNORM);
+	if (test_bit(MPTCP_DATA_READY, &msk->flags))
+		mask =3D EPOLLIN | EPOLLRDNORM;
+	if (sk_stream_is_writeable(sk) && test_bit(MPTCP_SEND_SPACE, &msk->flags))
+		mask |=3D EPOLLOUT | EPOLLWRNORM;
+	if (sk->sk_shutdown & RCV_SHUTDOWN)
+		mask |=3D EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 =

 	release_sock(sk);
 =

-	return ret;
+	return mask;
 }
 =

 static int mptcp_shutdown(struct socket *sock, int how)
-- =

2.23.0

--===============0394858086965547406==--
