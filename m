Content-Type: multipart/mixed; boundary="===============5164006594235572718=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp] mptcp: provide subflow aware release function
Date: Mon, 15 Feb 2021 16:36:23 +0100
Message-ID: <20210215153623.7406-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 7808

--===============5164006594235572718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp re-used inet(6)_release, so the subflow sockets are ignored.
Need to invoke ip(v6)_mc_drop_socket function to ensure mcast join
resources get free'd.

Fixes: 717e79c867ca5 ("mptcp: Add setsockopt()/getsockopt() socket operatio=
ns")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/110
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 55 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 19faa43be2f8..d811f60a867b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/atomic.h>
+#include <linux/igmp.h>
 #include <net/sock.h>
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
@@ -19,6 +20,7 @@
 #include <net/tcp_states.h>
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 #include <net/transp_v6.h>
+#include <net/addrconf.h>
 #endif
 #include <net/mptcp.h>
 #include <net/xfrm.h>
@@ -3388,10 +3390,34 @@ static __poll_t mptcp_poll(struct file *file, struc=
t socket *sock,
 	return mask;
 }
 =

+static int mptcp_release(struct socket *sock)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D sock->sk;
+	struct mptcp_sock *msk;
+
+	if (!sk)
+		return 0;
+
+	lock_sock(sk);
+
+	msk =3D mptcp_sk(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		ip_mc_drop_socket(ssk);
+	}
+
+	release_sock(sk);
+
+	return inet_release(sock);
+}
+
 static const struct proto_ops mptcp_stream_ops =3D {
 	.family		   =3D PF_INET,
 	.owner		   =3D THIS_MODULE,
-	.release	   =3D inet_release,
+	.release	   =3D mptcp_release,
 	.bind		   =3D mptcp_bind,
 	.connect	   =3D mptcp_stream_connect,
 	.socketpair	   =3D sock_no_socketpair,
@@ -3489,10 +3515,35 @@ void __init mptcp_proto_init(void)
 }
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static int mptcp6_release(struct socket *sock)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk;
+	struct sock *sk =3D sock->sk;
+
+	if (!sk)
+		return 0;
+
+	lock_sock(sk);
+
+	msk =3D mptcp_sk(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		ip_mc_drop_socket(ssk);
+		ipv6_sock_mc_close(ssk);
+		ipv6_sock_ac_close(ssk);
+	}
+
+	release_sock(sk);
+	return inet6_release(sock);
+}
+
 static const struct proto_ops mptcp_v6_stream_ops =3D {
 	.family		   =3D PF_INET6,
 	.owner		   =3D THIS_MODULE,
-	.release	   =3D inet6_release,
+	.release	   =3D mptcp6_release,
 	.bind		   =3D mptcp_bind,
 	.connect	   =3D mptcp_stream_connect,
 	.socketpair	   =3D sock_no_socketpair,
-- =

2.26.2

--===============5164006594235572718==--
