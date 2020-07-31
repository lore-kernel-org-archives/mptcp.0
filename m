Content-Type: multipart/mixed; boundary="===============8848181010246978441=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix bogus sendmsg() return code under
 pressure
Date: Fri, 31 Jul 2020 18:53:49 +0200
Message-ID: <63d451ecf32a5eb3c2d49ccc5468734be1898a61.1596214315.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5406

--===============8848181010246978441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case of memory pressure, mptcp_sendmsg() may call
sk_stream_wait_memory() after succesfully xmitting some
bytes. If the latter fails we currently return to the
user-space the error code, ignoring the succeful xmit.

Address the issue always checking for the xmitted bytes
before mptcp_sendmsg() completes.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
---
needed for upcoming multiple subflow xmit, I hope to sent this
upstream soon

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 650fae3e6e6d..3b9ae98c67bb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -984,7 +984,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 =

 	mptcp_set_timeout(sk, ssk);
 	if (copied) {
-		ret =3D copied;
 		tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle,
 			 size_goal);
 =

@@ -997,7 +996,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	release_sock(ssk);
 out:
 	release_sock(sk);
-	return ret;
+	return copied ? : ret;
 }
 =

 static void mptcp_wait_data(struct sock *sk, long *timeo)
-- =

2.26.2

--===============8848181010246978441==--
