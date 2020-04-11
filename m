Content-Type: multipart/mixed; boundary="===============0561258440615140626=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix double-unlock in mptcp_poll
Date: Sat, 11 Apr 2020 21:05:01 +0200
Message-ID: <20200411190501.13249-1-fw@strlen.de>
In-Reply-To: 000000000000758fcf05a306a8bf@google.com
X-Status: 
X-Keywords:                  
X-UID: 4152

--===============0561258440615140626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_connect/28740 is trying to release lock (sk_lock-AF_INET) at:
[<ffffffff82c15869>] mptcp_poll+0xb9/0x550
but there are no more locks to release!
Call Trace:
 lock_release+0x50f/0x750
 release_sock+0x171/0x1b0
 mptcp_poll+0xb9/0x550
 sock_poll+0x157/0x470
 ? get_net_ns+0xb0/0xb0
 do_sys_poll+0x63c/0xdd0

Problem is that __mptcp_tcp_fallback() releases the mptcp socket lock,
but after recent change it doesn't do this in all of its return paths.

To fix this, remove the unlock from __mptcp_tcp_fallback() and
always do the unlock in the caller.

Also add a small comment as to why we have this
__mptcp_needs_tcp_fallback().

Fixes: 0b4f33def7bbde ("mptcp: fix tcp fallback crash")
Reported-by: syzbot+e56606435b7bfeea8cf5(a)syzkaller.appspotmail.com
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 NB: Reproducer did not trigger for me, so i can't be 100% sure,
 but looking at the 'Fixes' commit the change to
 __mptcp_needs_tcp_fallback was broken.

 net/mptcp/protocol.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 72f3176dc924..559253be6a21 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -97,12 +97,7 @@ static struct socket *__mptcp_tcp_fallback(struct mptcp_=
sock *msk)
 	if (likely(!__mptcp_needs_tcp_fallback(msk)))
 		return NULL;
 =

-	if (msk->subflow) {
-		release_sock((struct sock *)msk);
-		return msk->subflow;
-	}
-
-	return NULL;
+	return msk->subflow;
 }
 =

 static bool __mptcp_can_create_subflow(const struct mptcp_sock *msk)
@@ -734,9 +729,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 			goto out;
 	}
 =

+fallback:
 	ssock =3D __mptcp_tcp_fallback(msk);
 	if (unlikely(ssock)) {
-fallback:
+		release_sock(sk);
 		pr_debug("fallback passthrough");
 		ret =3D sock_sendmsg(ssock, msg);
 		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
@@ -778,8 +774,14 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 		if (ret < 0)
 			break;
 		if (ret =3D=3D 0 && unlikely(__mptcp_needs_tcp_fallback(msk))) {
+			/* Can happen for passive sockets:
+			 * 3WHS negotiated MPTCP, but first packet after is
+			 * plain TCP (e.g. due to middlebox filtering unknown
+			 * options).
+			 *
+			 * Fall back to TCP.
+			 */
 			release_sock(ssk);
-			ssock =3D __mptcp_tcp_fallback(msk);
 			goto fallback;
 		}
 =

@@ -892,6 +894,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 	ssock =3D __mptcp_tcp_fallback(msk);
 	if (unlikely(ssock)) {
 fallback:
+		release_sock(sk);
 		pr_debug("fallback-read subflow=3D%p",
 			 mptcp_subflow_ctx(ssock->sk));
 		copied =3D sock_recvmsg(ssock, msg, flags);
@@ -1476,12 +1479,11 @@ static int mptcp_setsockopt(struct sock *sk, int le=
vel, int optname,
 	 */
 	lock_sock(sk);
 	ssock =3D __mptcp_tcp_fallback(msk);
+	release_sock(sk);
 	if (ssock)
 		return tcp_setsockopt(ssock->sk, level, optname, optval,
 				      optlen);
 =

-	release_sock(sk);
-
 	return -EOPNOTSUPP;
 }
 =

@@ -1501,12 +1503,11 @@ static int mptcp_getsockopt(struct sock *sk, int le=
vel, int optname,
 	 */
 	lock_sock(sk);
 	ssock =3D __mptcp_tcp_fallback(msk);
+	release_sock(sk);
 	if (ssock)
 		return tcp_getsockopt(ssock->sk, level, optname, optval,
 				      option);
 =

-	release_sock(sk);
-
 	return -EOPNOTSUPP;
 }
 =

-- =

2.24.1

--===============0561258440615140626==--
