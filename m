Content-Type: multipart/mixed; boundary="===============8317263216925942146=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 1/3] mptcp: Check connection state before
 attempting send
Date: Tue, 04 Feb 2020 18:06:46 -0800
Message-ID: <20200205020648.72997-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200205020648.72997-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3588

--===============8317263216925942146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

MPTCP should wait for an active connection or skip sending depending on
the connection state, as TCP does. This happens before the possible
passthrough to a regular TCP sendmsg because the subflow's socket type
(MPTCP or TCP fallback) is not known until the connection is complete.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ae5494a8f60e..e856bde01ebf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -572,6 +572,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 		return -EOPNOTSUPP;
 =

 	lock_sock(sk);
+
+	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
+
+	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
+		ret =3D sk_stream_wait_connect(sk, &timeo);
+		if (ret)
+			goto out;
+	}
+
 	ssock =3D __mptcp_tcp_fallback(msk);
 	if (unlikely(ssock)) {
 fallback:
@@ -580,8 +589,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
 	}
 =

-	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
-
 	mptcp_clean_una(sk);
 =

 	__mptcp_flush_join_list(msk);
-- =

2.25.0

--===============8317263216925942146==--
