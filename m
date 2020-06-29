Content-Type: multipart/mixed; boundary="===============1799454912794415576=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 6/6] mptcp: close poll() races
Date: Mon, 29 Jun 2020 22:26:25 +0200
Message-ID: <0c0e9026c97b90d92047b3771dc248e5d873ac6a.1593461586.git.dcaratti@redhat.com>
In-Reply-To: cover.1593461586.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4852

--===============1799454912794415576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

mptcp_poll always return POLLOUT for unblocking
connect(), ensure that the socket is a suitable
state.
The MPTCP_DATA_READY bit is never cleared on accept:
ensure we don't leave mptcp_accept() with an empty
accept queue and such bit set.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/protocol.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f2b2bd37e371..28ec26d97f96 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1841,6 +1841,7 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 	if (!ssock)
 		goto unlock_fail;
 =

+	clear_bit(MPTCP_DATA_READY, &msk->flags);
 	sock_hold(ssock->sk);
 	release_sock(sock->sk);
 =

@@ -1861,6 +1862,8 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 		}
 	}
 =

+	if (inet_csk_listen_poll(ssock->sk))
+		set_bit(MPTCP_DATA_READY, &msk->flags);
 	sock_put(ssock->sk);
 	return err;
 =

@@ -1869,21 +1872,33 @@ static int mptcp_stream_accept(struct socket *sock,=
 struct socket *newsock,
 	return -EINVAL;
 }
 =

+static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
+{
+	return test_bit(MPTCP_DATA_READY, &msk->flags) ? EPOLLIN | EPOLLRDNORM :
+	       0;
+}
+
 static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait)
 {
 	struct sock *sk =3D sock->sk;
 	struct mptcp_sock *msk;
 	__poll_t mask =3D 0;
+	int state;
 =

 	msk =3D mptcp_sk(sk);
 	sock_poll_wait(file, sock, wait);
 =

-	if (test_bit(MPTCP_DATA_READY, &msk->flags))
-		mask =3D EPOLLIN | EPOLLRDNORM;
-	if (sk_stream_is_writeable(sk) &&
-	    test_bit(MPTCP_SEND_SPACE, &msk->flags))
-		mask |=3D EPOLLOUT | EPOLLWRNORM;
+	state =3D inet_sk_state_load(sk);
+	if (state =3D=3D TCP_LISTEN)
+		return mptcp_check_readable(msk);
+
+	if (state !=3D TCP_SYN_SENT && state !=3D TCP_SYN_RECV) {
+		mask |=3D mptcp_check_readable(msk);
+		if (sk_stream_is_writeable(sk) &&
+		    test_bit(MPTCP_SEND_SPACE, &msk->flags))
+			mask |=3D EPOLLOUT | EPOLLWRNORM;
+	}
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		mask |=3D EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 =

-- =

2.26.2

--===============1799454912794415576==--
