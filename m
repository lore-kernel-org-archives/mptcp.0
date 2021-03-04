Content-Type: multipart/mixed; boundary="===============2375120265343172456=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 4/9] mptcp: dispose initial struct socket when its
 subflow is closed
Date: Thu, 04 Mar 2021 13:32:11 -0800
Message-ID: <20210304213216.205472-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210304213216.205472-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8031

--===============2375120265343172456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

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

Fixes: 866f26f2a9c33b ("mptcp: always graft subflow socket to parent")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/157
Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Acked-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index aa59101ffe54..a58da04bed71 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2116,6 +2116,14 @@ static struct sock *mptcp_subflow_get_retrans(const =
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
@@ -2160,6 +2168,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct=
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
@@ -2529,12 +2540,6 @@ static void __mptcp_destroy_sock(struct sock *sk)
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
@@ -2559,6 +2564,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
 	sk_refcnt_debug_release(sk);
+	mptcp_dispose_initial_subflow(msk);
 	sock_put(sk);
 }
 =

-- =

2.30.1

--===============2375120265343172456==--
