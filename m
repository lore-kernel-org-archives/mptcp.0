Content-Type: multipart/mixed; boundary="===============5613461875842875661=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v2 PATCH 2/2] mptcp: revert "mptcp: provide subflow
 aware release function"$ ....$
Date: Wed, 03 Mar 2021 19:43:39 +0100
Message-ID: <30e5b4c37fb98deb22b63f1eb6423de321f46222.1614796802.git.pabeni@redhat.com>
In-Reply-To: cover.1614796802.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8003

--===============5613461875842875661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commit reverts ad98dd37051e ("mptcp: provide subflow aware
release function"). The latter introduced a deadlock spotted by
syzkaller and is not needed anymore after the previous commit.

Fixes: ad98dd37051e ("mptcp: provide subflow aware release function")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>$
---
 net/mptcp/protocol.c | 55 ++------------------------------------------
 1 file changed, 2 insertions(+), 53 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6a8c3f46f30a4..911050373ff62 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -11,7 +11,6 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/atomic.h>
-#include <linux/igmp.h>
 #include <net/sock.h>
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
@@ -20,7 +19,6 @@
 #include <net/tcp_states.h>
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 #include <net/transp_v6.h>
-#include <net/addrconf.h>
 #endif
 #include <net/mptcp.h>
 #include <net/xfrm.h>
@@ -3630,34 +3628,10 @@ static __poll_t mptcp_poll(struct file *file, struc=
t socket *sock,
 	return mask;
 }
 =

-static int mptcp_release(struct socket *sock)
-{
-	struct mptcp_subflow_context *subflow;
-	struct sock *sk =3D sock->sk;
-	struct mptcp_sock *msk;
-
-	if (!sk)
-		return 0;
-
-	lock_sock(sk);
-
-	msk =3D mptcp_sk(sk);
-
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-
-		ip_mc_drop_socket(ssk);
-	}
-
-	release_sock(sk);
-
-	return inet_release(sock);
-}
-
 static const struct proto_ops mptcp_stream_ops =3D {
 	.family		   =3D PF_INET,
 	.owner		   =3D THIS_MODULE,
-	.release	   =3D mptcp_release,
+	.release	   =3D inet_release,
 	.bind		   =3D mptcp_bind,
 	.connect	   =3D mptcp_stream_connect,
 	.socketpair	   =3D sock_no_socketpair,
@@ -3755,35 +3729,10 @@ void __init mptcp_proto_init(void)
 }
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-static int mptcp6_release(struct socket *sock)
-{
-	struct mptcp_subflow_context *subflow;
-	struct mptcp_sock *msk;
-	struct sock *sk =3D sock->sk;
-
-	if (!sk)
-		return 0;
-
-	lock_sock(sk);
-
-	msk =3D mptcp_sk(sk);
-
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-
-		ip_mc_drop_socket(ssk);
-		ipv6_sock_mc_close(ssk);
-		ipv6_sock_ac_close(ssk);
-	}
-
-	release_sock(sk);
-	return inet6_release(sock);
-}
-
 static const struct proto_ops mptcp_v6_stream_ops =3D {
 	.family		   =3D PF_INET6,
 	.owner		   =3D THIS_MODULE,
-	.release	   =3D mptcp6_release,
+	.release	   =3D inet6_release,
 	.bind		   =3D mptcp_bind,
 	.connect	   =3D mptcp_stream_connect,
 	.socketpair	   =3D sock_no_socketpair,
-- =

2.26.2

--===============5613461875842875661==--
