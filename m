Content-Type: multipart/mixed; boundary="===============7877291274646868023=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 2/3] mptcp: add REUSEADDR/REUSEPORT support
Date: Sun, 05 Jul 2020 01:30:16 +0200
Message-ID: <20200704233017.20831-3-fw@strlen.de>
In-Reply-To: 20200704233017.20831-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4916

--===============7877291274646868023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will e.g. make 'sshd restart' work when MPTCP is used, as we will
now set this option on the listener socket instead of only the mptcp
socket (where it has no effect).

We still need to copy the setting to the master socket so that a
subsequent getsockopt() returns the expected value.

Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 320f306ea85c..612f6d49f1bb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1601,6 +1601,37 @@ static void mptcp_destroy(struct sock *sk)
 	sk_sockets_allocated_dec(sk);
 }
 =

+static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
+				       char __user *optval, unsigned int optlen)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	struct socket *ssock;
+	int ret;
+
+	switch (optname) {
+	case SO_REUSEPORT:
+	case SO_REUSEADDR:
+		lock_sock(sk);
+		ssock =3D __mptcp_nmpc_socket(msk);
+		if (!ssock) {
+			release_sock(sk);
+			return -EINVAL;
+		}
+
+		ret =3D sock_setsockopt(ssock, SOL_SOCKET, optname, optval, optlen);
+		if (ret =3D=3D 0) {
+			if (optname =3D=3D SO_REUSEPORT)
+				sk->sk_reuseport =3D ssock->sk->sk_reuseport;
+			else if (optname =3D=3D SO_REUSEADDR)
+				sk->sk_reuse =3D ssock->sk->sk_reuse;
+		}
+		release_sock(sk);
+		return ret;
+	}
+
+	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen=
);
+}
+
 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
 			    char __user *optval, unsigned int optlen)
 {
@@ -1610,7 +1641,7 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 	pr_debug("msk=3D%p", msk);
 =

 	if (level =3D=3D SOL_SOCKET)
-		return sock_setsockopt(sk->sk_socket, level, optname, optval, optlen);
+		return mptcp_setsockopt_sol_socket(msk, optname, optval, optlen);
 =

 	/* @@ the meaning of setsockopt() when the socket is connected and
 	 * there are multiple subflows is not yet defined. It is up to the
-- =

2.26.2

--===============7877291274646868023==--
