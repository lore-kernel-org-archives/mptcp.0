Content-Type: multipart/mixed; boundary="===============1750375115077842976=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net v2 3/3] mptcp: Use TCP sendmsg/recvmsg for
 fallback subflows
Date: Thu, 13 Feb 2020 12:38:36 -0800
Message-ID: <20200213203836.225812-4-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200213203836.225812-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3656

--===============1750375115077842976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a connection is in TCP fallback, the MPTCP send and recv functions
are bypassed and calls are passed through to the subflow. The MPTCP
socket is unlocked when this passthrough happens because the send or
receive may block. Using sock_sendmsg() and sock_recvmsg() on the
fallback subflows leads to a race condition because they take struct
socket pointers that can be released by another thread. tcp_sendmsg()
and tcp_recvmsg() use struct sock pointers that are reference counted
and will remain valid after the MPTCP socket lock is released.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0169e7dfc2d1..fc5d977549f6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -280,8 +280,13 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 	if (unlikely(ssock)) {
 fallback:
 		pr_debug("fallback passthrough");
+
+		ssk =3D ssock->sk;
+		sock_hold(ssk);
 		release_sock(sk);
-		ret =3D sock_sendmsg(ssock, msg);
+		ret =3D tcp_sendmsg(ssk, msg, msg_data_left(msg));
+		sock_put(ssk);
+
 		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
 	}
 =

@@ -390,8 +395,13 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 fallback:
 		pr_debug("fallback-read subflow=3D%p",
 			 mptcp_subflow_ctx(ssock->sk));
+
+		ssk =3D ssock->sk;
+		sock_hold(ssk);
 		release_sock(sk);
-		copied =3D sock_recvmsg(ssock, msg, flags);
+		copied =3D tcp_recvmsg(ssk, msg, len, nonblock, flags, addr_len);
+		sock_put(ssk);
+
 		return copied;
 	}
 =

-- =

2.25.0

--===============1750375115077842976==--
