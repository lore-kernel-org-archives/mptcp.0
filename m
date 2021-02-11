Content-Type: multipart/mixed; boundary="===============8556565649551659532=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 2/6] mptcp: fix poll after shutdown
Date: Thu, 11 Feb 2021 15:30:38 -0800
Message-ID: <20210211233042.304878-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210211233042.304878-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7765

--===============8556565649551659532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

The current mptcp_poll() implementation gives unexpected
results after shutdown(SEND_SHUTDOWN) and when the msk
status is TCP_CLOSE.

Set the correct mask.

Fixes: 8edf08649eed ("mptcp: rework poll+nospace handling")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9eecd1383d24..42ca49954bdd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3321,7 +3321,7 @@ static __poll_t mptcp_check_writeable(struct mptcp_so=
ck *msk)
 	struct sock *sk =3D (struct sock *)msk;
 =

 	if (unlikely(sk->sk_shutdown & SEND_SHUTDOWN))
-		return 0;
+		return EPOLLOUT | EPOLLWRNORM;
 =

 	if (sk_stream_is_writeable(sk))
 		return EPOLLOUT | EPOLLWRNORM;
@@ -3354,6 +3354,8 @@ static __poll_t mptcp_poll(struct file *file, struct =
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

2.30.1

--===============8556565649551659532==--
