Content-Type: multipart/mixed; boundary="===============7235213832502466650=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 1/3] mptcp: Check connection state before
 attempting send
Date: Thu, 27 Feb 2020 16:29:39 -0800
Message-ID: <20200228002941.99393-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200228002941.99393-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3818

--===============7235213832502466650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

MPTCP should wait for an active connection or skip sending depending on
the connection state, as TCP does. This happens before the possible
passthrough to a regular TCP sendmsg because the subflow's socket type
(MPTCP or TCP fallback) is not known until the connection is complete.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3c19a8efdcea..42a3160fae51 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -278,6 +278,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
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
@@ -286,8 +295,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
 	}
 =

-	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
-
 	ssk =3D mptcp_subflow_get(msk);
 	if (!ssk) {
 		release_sock(sk);
@@ -319,6 +326,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 =

 	ssk_check_wmem(msk, ssk);
 	release_sock(ssk);
+out:
 	release_sock(sk);
 	return ret;
 }
-- =

2.25.1

--===============7235213832502466650==--
