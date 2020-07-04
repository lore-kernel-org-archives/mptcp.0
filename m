Content-Type: multipart/mixed; boundary="===============0330510809274461053=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 1/3] net: use mptcp setsockopt function for
 SOL_SOCKET on mptcp sockets
Date: Sun, 05 Jul 2020 01:30:15 +0200
Message-ID: <20200704233017.20831-2-fw@strlen.de>
In-Reply-To: 20200704233017.20831-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4915

--===============0330510809274461053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

setsockopt(mptcp_fd, SOL_SOCKET, ...)...  appears to work (returns 0),
but it has no effect -- this is because the MPTCP layer never has a
chance to copy the settings to the subflow socket.

Skip the generic handling for the mptcp case and instead call the
mptcp specific handler instead for SOL_SOCKET too.

Next patch adds more specific handling for SOL_SOCKET to mptcp.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c |  3 +++
 net/socket.c         | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fa137a9c42d1..320f306ea85c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1609,6 +1609,9 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 =

 	pr_debug("msk=3D%p", msk);
 =

+	if (level =3D=3D SOL_SOCKET)
+		return sock_setsockopt(sk->sk_socket, level, optname, optval, optlen);
+
 	/* @@ the meaning of setsockopt() when the socket is connected and
 	 * there are multiple subflows is not yet defined. It is up to the
 	 * MPTCP-level socket to configure the subflows until the subflow
diff --git a/net/socket.c b/net/socket.c
index 976426d03f09..d87812a9ed4b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2080,6 +2080,17 @@ SYSCALL_DEFINE4(recv, int, fd, void __user *, ubuf, =
size_t, size,
 	return __sys_recvfrom(fd, ubuf, size, flags, NULL, NULL);
 }
 =

+static bool sock_use_custom_sol_socket(const struct socket *sock)
+{
+	const struct sock *sk =3D sock->sk;
+
+	/* Use sock->ops->setsockopt() for MPTCP */
+	return IS_ENABLED(CONFIG_MPTCP) &&
+	       sk->sk_protocol =3D=3D IPPROTO_MPTCP &&
+	       sk->sk_type =3D=3D SOCK_STREAM &&
+	       (sk->sk_family =3D=3D AF_INET || sk->sk_family =3D=3D AF_INET6);
+}
+
 /*
  *	Set a socket option. Because we don't know the option lengths we have
  *	to pass the user mode parameter for the protocols to sort out.
@@ -2118,7 +2129,7 @@ static int __sys_setsockopt(int fd, int level, int op=
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

--===============0330510809274461053==--
