Content-Type: multipart/mixed; boundary="===============0919419193035634427=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/2] mptcp: dispose initial struct socket when its
 subflow is closed
Date: Fri, 12 Feb 2021 00:42:45 +0100
Message-ID: <20210211234245.31961-2-fw@strlen.de>
In-Reply-To: 20210211234245.31961-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7767

--===============0919419193035634427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Christoph Paasch reported following crash:
dst_release underflow
WARNING: CPU: 0 PID: 1319 at net/core/dst.c:175 dst_release+0xc1/0xd0 net/c=
ore/dst.c:175
CPU: 0 PID: 1319 Comm: syz-executor217 Not tainted 5.11.0-rc6af8e85128b4d0d=
24083c5cac646e891227052e0c #70
Call Trace:
 rt_cache_route+0x12e/0x140 net/ipv4/route.c:1503
 rt_set_nexthop.constprop.0+0x1fc/0x590 net/ipv4/route.c:1612
 __mkroute_output net/ipv4/route.c:2484 [inline]
...

The worker leaves msk->subflow alone even when it
happened to close the subflow ssk associated with it.

v2: fix helper function name

Fixes: 866f26f2a9c33b ("mptcp: always graft subflow socket to parent")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/157
Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fdd6b3cb0bf5..19faa43be2f8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2106,6 +2106,14 @@ static struct sock *mptcp_subflow_get_retrans(const =
struct mptcp_sock *msk)
 	return backup;
 }
 =

+static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
+{
+	if (msk->subflow) {
+		iput(SOCK_INODE(msk->subflow));
+		msk->subflow =3D NULL;
+	}
+}
+
 /* subflow sockets can be either outgoing (connect) or incoming
  * (accept).
  *
@@ -2117,6 +2125,8 @@ static struct sock *mptcp_subflow_get_retrans(const s=
truct mptcp_sock *msk)
 static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 			      struct mptcp_subflow_context *subflow)
 {
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
 	list_del(&subflow->node);
 =

 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
@@ -2148,6 +2158,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct=
 sock *ssk,
 =

 	if (ssk =3D=3D msk->last_snd)
 		msk->last_snd =3D NULL;
+
+	if (msk->subflow && ssk =3D=3D msk->subflow->sk)
+		mptcp_dispose_initial_subflow(msk);
 }
 =

 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
@@ -2529,12 +2542,6 @@ static void __mptcp_destroy_sock(struct sock *sk)
 =

 	might_sleep();
 =

-	/* dispose the ancillatory tcp socket, if any */
-	if (msk->subflow) {
-		iput(SOCK_INODE(msk->subflow));
-		msk->subflow =3D NULL;
-	}
-
 	/* be sure to always acquire the join list lock, to sync vs
 	 * mptcp_finish_join().
 	 */
@@ -2559,6 +2566,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
 	sk_refcnt_debug_release(sk);
+	mptcp_dispose_initial_subflow(msk);
 	sock_put(sk);
 }
 =

-- =

2.26.2

--===============0919419193035634427==--
