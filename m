Content-Type: multipart/mixed; boundary="===============6977530700934404590=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v2 1/3] net: use mptcp setsockopt function
 for SOL_SOCKET on mptcp sockets
Date: Tue, 16 Jun 2020 14:25:29 +0200
Message-ID: <20200616122531.2443-2-fw@strlen.de>
In-Reply-To: 20200616122531.2443-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4696

--===============6977530700934404590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

setsockopt(mptcp_fd, SOL_SOCKET, ...)...  appears to work (returns 0),
but it has no effect -- this is because the MPTCP layer never has a
chance to copy the settings to the subflow socket.

Skip the generic handling for the mptcp case and return -EOPNOTSUPP.
Next patch adds handling for SOL_SOCKET to mptcp.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c |  3 +++
 net/socket.c         | 12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index faa804f63c81..f9429c6f5b96 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1636,6 +1636,9 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 =

 	pr_debug("msk=3D%p", msk);
 =

+	if (level =3D=3D SOL_SOCKET)
+		return -EOPNOTSUPP;
+
 	/* @@ the meaning of setsockopt() when the socket is connected and
 	 * there are multiple subflows is not yet defined. It is up to the
 	 * MPTCP-level socket to configure the subflows until the subflow
diff --git a/net/socket.c b/net/socket.c
index d5b555845b37..98b70fcaff19 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2091,6 +2091,16 @@ SYSCALL_DEFINE4(recv, int, fd, void __user *, ubuf, =
size_t, size,
 	return __sys_recvfrom(fd, ubuf, size, flags, NULL, NULL);
 }
 =

+static bool sock_use_custom_sol_socket(const struct socket *sock)
+{
+	const struct sock *sk =3D sock->sk;
+
+	/* Use sock->ops->setsockopt() for MPTCP */
+	return sk->sk_protocol =3D=3D IPPROTO_MPTCP &&
+	       sk->sk_type =3D=3D SOCK_STREAM &&
+	       (sk->sk_family =3D=3D AF_INET || sk->sk_family =3D=3D AF_INET6);
+}
+
 /*
  *	Set a socket option. Because we don't know the option lengths we have
  *	to pass the user mode parameter for the protocols to sort out.
@@ -2129,7 +2139,7 @@ static int __sys_setsockopt(int fd, int level, int op=
tname,
 			optval =3D (char __user __force *)kernel_optval;
 		}
 =

-		if (level =3D=3D SOL_SOCKET)
+		if (level =3D=3D SOL_SOCKET && !sock_use_custom_sol_socket(sock))
 			err =3D
 			    sock_setsockopt(sock, level, optname, optval,
 					    optlen);
-- =

2.26.2

--===============6977530700934404590==--
