Content-Type: multipart/mixed; boundary="===============8045137958632548587=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 2/2] mptcp: fix poll after shutdown
Date: Mon, 01 Feb 2021 19:12:14 +0100
Message-ID: <4c7cb8a5236d7e4bee04812805deeb8603dfdee1.1612201708.git.pabeni@redhat.com>
In-Reply-To: cover.1612201708.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7556

--===============8045137958632548587==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current mptcp_poll() implementation gives unexpected
results after shutdown(SEND_SHUTDOWN) and after receiving
a MP_RESET.

Set the correct mask.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fdd2a30118978..305d25cbc216a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3322,7 +3322,7 @@ static __poll_t mptcp_check_writeable(struct mptcp_so=
ck *msk)
 	struct sock *sk =3D (struct sock *)msk;
 =

 	if (unlikely(sk->sk_shutdown & SEND_SHUTDOWN))
-		return 0;
+		return EPOLLOUT | EPOLLWRNORM;
 =

 	if (sk_stream_is_writeable(sk))
 		return EPOLLOUT | EPOLLWRNORM;
@@ -3355,6 +3355,8 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 		mask |=3D mptcp_check_readable(msk);
 		mask |=3D mptcp_check_writeable(msk);
 	}
+	if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK || state =3D=3D TCP_CLOSE)
+		mask |=3D EPOLLHUP;
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		mask |=3D EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 =

-- =

2.26.2

--===============8045137958632548587==--
