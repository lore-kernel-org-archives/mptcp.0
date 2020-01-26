Content-Type: multipart/mixed; boundary="===============5897686672050445106=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: protocol: fix panic on user pointer
 access
Date: Sun, 26 Jan 2020 17:19:00 +0100
Message-ID: <20200126161900.21223-1-fw@strlen.de>
In-Reply-To: 20200124180545.GJ60524@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 3514

--===============5897686672050445106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Its not possible to call the kernel_(s|g)etsockopt functions here,
the address points to user memory:

General protection fault in user access. Non-canonical address?
WARNING: CPU: 1 PID: 5352 at arch/x86/mm/extable.c:77 ex_handler_uaccess+0x=
ba/0xe0 arch/x86/mm/extable.c:77
Kernel panic - not syncing: panic_on_warn set ...
[..]
Call Trace:
 fixup_exception+0x9d/0xcd arch/x86/mm/extable.c:178
 general_protection+0x2d/0x40 arch/x86/entry/entry_64.S:1202
 do_ip_getsockopt+0x1f6/0x1860 net/ipv4/ip_sockglue.c:1323
 ip_getsockopt+0x87/0x1c0 net/ipv4/ip_sockglue.c:1561
 tcp_getsockopt net/ipv4/tcp.c:3691 [inline]
 tcp_getsockopt+0x8c/0xd0 net/ipv4/tcp.c:3685
 kernel_getsockopt+0x121/0x1f0 net/socket.c:3736
 mptcp_getsockopt+0x69/0x90 net/mptcp/protocol.c:830
 __sys_getsockopt+0x13a/0x220 net/socket.c:2175

Fixes: 717e79c867ca5 ("mptcp: Add setsockopt()/getsockopt() socket operatio=
ns")
Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 39fdca79ce90..a4459f0adb0b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -778,17 +778,23 @@ static void mptcp_destroy(struct sock *sk)
 {
 }
 =

+static int fallback_setsockopt(struct socket *sock, int level, int optname,
+			       char __user *optval, unsigned int optlen)
+{
+	if (level =3D=3D SOL_SOCKET)
+		return sock_setsockopt(sock, level, optname, optval, optlen);
+
+	return sock->ops->setsockopt(sock, level, optname, optval,
+				     optlen);
+}
+
 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
-			    char __user *uoptval, unsigned int optlen)
+			    char __user *optval, unsigned int optlen)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	char __kernel *optval;
 	int ret =3D -EOPNOTSUPP;
 	struct socket *ssock;
 =

-	/* will be treated as __user in tcp_setsockopt */
-	optval =3D (char __kernel __force *)uoptval;
-
 	pr_debug("msk=3D%p", msk);
 =

 	/* @@ the meaning of setsockopt() when the socket is connected and
@@ -798,13 +804,23 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
 	if (!IS_ERR(ssock)) {
 		pr_debug("subflow=3D%p", ssock->sk);
-		ret =3D kernel_setsockopt(ssock, level, optname, optval, optlen);
+		ret =3D fallback_setsockopt(ssock, level, optname, optval, optlen);
 	}
 	release_sock(sk);
 =

 	return ret;
 }
 =

+static int fallback_getsockopt(struct socket *sock, int level, int optname,
+			       char __user *optval, int __user *optlen)
+{
+	if (level =3D=3D SOL_SOCKET)
+		return sock_getsockopt(sock, level, optname, optval, optlen);
+
+	return sock->ops->getsockopt(sock, level, optname, optval,
+				     optlen);
+}
+
 static int mptcp_getsockopt(struct sock *sk, int level, int optname,
 			    char __user *uoptval, int __user *uoption)
 {
@@ -827,7 +843,7 @@ static int mptcp_getsockopt(struct sock *sk, int level,=
 int optname,
 	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
 	if (!IS_ERR(ssock)) {
 		pr_debug("subflow=3D%p", ssock->sk);
-		ret =3D kernel_getsockopt(ssock, level, optname, optval, option);
+		ret =3D fallback_getsockopt(ssock, level, optname, optval, option);
 	}
 	release_sock(sk);
 =

-- =

2.24.1

--===============5897686672050445106==--
