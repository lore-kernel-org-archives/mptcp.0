Content-Type: multipart/mixed; boundary="===============3328844443583550228=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: close poll() races
Date: Wed, 10 Jun 2020 18:45:14 +0200
Message-ID: <8b04316909ff8ce4e73f12130d50e42149d3ee8a.1591807318.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4643

--===============3328844443583550228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_poll always return POLLOUT for unblocking
connect(), ensure that the socket is a suitable
state.
The MPTCP_DATA_READY bit is never cleared on accept:
ensure we don't leave mptcp_accept() with an empty
accept queue and such bit set.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
This can be:
- keep as is
- split in 2 patches (listen fix and connect fix)
- squashed into "mptcp: fallback in case of simultaneous connect",
- partially squashed (listen fix) and partially keeped as separate patch

I'll personally vote for option 1 or 3 but I'm open to other
alternatives ;)
---
 net/mptcp/protocol.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0a832c84655a..b6d129489204 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1913,6 +1913,7 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 	if (!ssock)
 		goto unlock_fail;
 =

+	clear_bit(MPTCP_DATA_READY, &msk->flags);
 	sock_hold(ssock->sk);
 	release_sock(sock->sk);
 =

@@ -1933,6 +1934,8 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 		}
 	}
 =

+	if (inet_csk_listen_poll(ssock->sk))
+		set_bit(MPTCP_DATA_READY, &msk->flags);
 	sock_put(ssock->sk);
 	return err;
 =

@@ -1941,21 +1944,34 @@ static int mptcp_stream_accept(struct socket *sock,=
 struct socket *newsock,
 	return -EINVAL;
 }
 =

+
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

2.21.3

--===============3328844443583550228==--
