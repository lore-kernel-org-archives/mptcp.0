Content-Type: multipart/mixed; boundary="===============0449312387545780630=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 1/2] mptcp: do not inherit inet proto ops
Date: Fri, 24 Jan 2020 16:04:02 -0800
Message-ID: <20200125000403.251894-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200125000403.251894-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3507

--===============0449312387545780630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

We need to initialise the struct ourselves, else we expose tcp-specific
callbacks such as tcp_splice_read which will then trigger splat because
the socket is an mptcp one:

BUG: KASAN: slab-out-of-bounds in tcp_mstamp_refresh+0x80/0xa0 net/ipv4/tcp=
_output.c:57
Write of size 8 at addr ffff888116aa21d0 by task syz-executor.0/5478

CPU: 1 PID: 5478 Comm: syz-executor.0 Not tainted 5.5.0-rc6 #3
Call Trace:
 tcp_mstamp_refresh+0x80/0xa0 net/ipv4/tcp_output.c:57
 tcp_rcv_space_adjust+0x72/0x7f0 net/ipv4/tcp_input.c:612
 tcp_read_sock+0x622/0x990 net/ipv4/tcp.c:1674
 tcp_splice_read+0x20b/0xb40 net/ipv4/tcp.c:791
 do_splice+0x1259/0x1560 fs/splice.c:1205

To prevent build error with ipv6, add the recv/sendmsg function
declaration to ipv6.h.  The functions are already accessible "thanks"
to retpoline related work, but they are currently only made visible
by socket.c specific INDIRECT_CALLABLE macros.

Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/ipv6.h   |  3 ++
 net/mptcp/protocol.c | 70 ++++++++++++++++++++++++++++++++------------
 2 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 4e95f6df508c..cec1a54401f2 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1113,6 +1113,9 @@ int inet6_ioctl(struct socket *sock, unsigned int cmd=
, unsigned long arg);
 =

 int inet6_hash_connect(struct inet_timewait_death_row *death_row,
 			      struct sock *sk);
+int inet6_sendmsg(struct socket *sock, struct msghdr *msg, size_t size);
+int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
+		  int flags);
 =

 /*
  * reassembly.c
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ee916b3686fe..41d49126d29a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1163,7 +1163,31 @@ static int mptcp_shutdown(struct socket *sock, int h=
ow)
 	return ret;
 }
 =

-static struct proto_ops mptcp_stream_ops;
+static const struct proto_ops mptcp_stream_ops =3D {
+	.family		   =3D PF_INET,
+	.owner		   =3D THIS_MODULE,
+	.release	   =3D inet_release,
+	.bind		   =3D mptcp_bind,
+	.connect	   =3D mptcp_stream_connect,
+	.socketpair	   =3D sock_no_socketpair,
+	.accept		   =3D mptcp_stream_accept,
+	.getname	   =3D mptcp_v4_getname,
+	.poll		   =3D mptcp_poll,
+	.ioctl		   =3D inet_ioctl,
+	.gettstamp	   =3D sock_gettstamp,
+	.listen		   =3D mptcp_listen,
+	.shutdown	   =3D mptcp_shutdown,
+	.setsockopt	   =3D sock_common_setsockopt,
+	.getsockopt	   =3D sock_common_getsockopt,
+	.sendmsg	   =3D inet_sendmsg,
+	.recvmsg	   =3D inet_recvmsg,
+	.mmap		   =3D sock_no_mmap,
+	.sendpage	   =3D inet_sendpage,
+#ifdef CONFIG_COMPAT
+	.compat_setsockopt =3D compat_sock_common_setsockopt,
+	.compat_getsockopt =3D compat_sock_common_getsockopt,
+#endif
+};
 =

 static struct inet_protosw mptcp_protosw =3D {
 	.type		=3D SOCK_STREAM,
@@ -1176,14 +1200,6 @@ static struct inet_protosw mptcp_protosw =3D {
 void mptcp_proto_init(void)
 {
 	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
-	mptcp_stream_ops =3D inet_stream_ops;
-	mptcp_stream_ops.bind =3D mptcp_bind;
-	mptcp_stream_ops.connect =3D mptcp_stream_connect;
-	mptcp_stream_ops.poll =3D mptcp_poll;
-	mptcp_stream_ops.accept =3D mptcp_stream_accept;
-	mptcp_stream_ops.getname =3D mptcp_v4_getname;
-	mptcp_stream_ops.listen =3D mptcp_listen;
-	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
 =

 	mptcp_subflow_init();
 =

@@ -1194,7 +1210,32 @@ void mptcp_proto_init(void)
 }
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-static struct proto_ops mptcp_v6_stream_ops;
+static const struct proto_ops mptcp_v6_stream_ops =3D {
+	.family		   =3D PF_INET6,
+	.owner		   =3D THIS_MODULE,
+	.release	   =3D inet6_release,
+	.bind		   =3D mptcp_bind,
+	.connect	   =3D mptcp_stream_connect,
+	.socketpair	   =3D sock_no_socketpair,
+	.accept		   =3D mptcp_stream_accept,
+	.getname	   =3D mptcp_v6_getname,
+	.poll		   =3D mptcp_poll,
+	.ioctl		   =3D inet6_ioctl,
+	.gettstamp	   =3D sock_gettstamp,
+	.listen		   =3D mptcp_listen,
+	.shutdown	   =3D mptcp_shutdown,
+	.setsockopt	   =3D sock_common_setsockopt,
+	.getsockopt	   =3D sock_common_getsockopt,
+	.sendmsg	   =3D inet6_sendmsg,
+	.recvmsg	   =3D inet6_recvmsg,
+	.mmap		   =3D sock_no_mmap,
+	.sendpage	   =3D inet_sendpage,
+#ifdef CONFIG_COMPAT
+	.compat_setsockopt =3D compat_sock_common_setsockopt,
+	.compat_getsockopt =3D compat_sock_common_getsockopt,
+#endif
+};
+
 static struct proto mptcp_v6_prot;
 =

 static void mptcp_v6_destroy(struct sock *sk)
@@ -1226,15 +1267,6 @@ int mptcp_proto_v6_init(void)
 	if (err)
 		return err;
 =

-	mptcp_v6_stream_ops =3D inet6_stream_ops;
-	mptcp_v6_stream_ops.bind =3D mptcp_bind;
-	mptcp_v6_stream_ops.connect =3D mptcp_stream_connect;
-	mptcp_v6_stream_ops.poll =3D mptcp_poll;
-	mptcp_v6_stream_ops.accept =3D mptcp_stream_accept;
-	mptcp_v6_stream_ops.getname =3D mptcp_v6_getname;
-	mptcp_v6_stream_ops.listen =3D mptcp_listen;
-	mptcp_v6_stream_ops.shutdown =3D mptcp_shutdown;
-
 	err =3D inet6_register_protosw(&mptcp_v6_protosw);
 	if (err)
 		proto_unregister(&mptcp_v6_prot);
-- =

2.25.0

--===============0449312387545780630==--
