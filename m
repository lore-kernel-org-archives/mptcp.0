Content-Type: multipart/mixed; boundary="===============5661314741443463335=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 2/2] mptcp: support IPV6_V6ONLY setsockopt
Date: Tue, 16 Jun 2020 02:41:49 +0200
Message-ID: <20200616004149.21233-3-fw@strlen.de>
In-Reply-To: 20200616004149.21233-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4687

--===============5661314741443463335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Without this, Opensshd fails to open an ipv6 socket listening
socket:
  error: setsockopt IPV6_V6ONLY: Operation not supported
  error: Bind to port 22 on :: failed: Address already in use.

Opensshd opens an ipv4 and and ipv6 listening socket, but because
IPV6_V6ONLY setsockopt fails, the port number is already in use.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6dc2649bb8e..38d77107137d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1628,6 +1628,31 @@ static void mptcp_destroy(struct sock *sk)
 	sk_sockets_allocated_dec(sk);
 }
 =

+static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int level, int optn=
ame,
+			       char __user *optval, unsigned int optlen)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	int ret =3D -EOPNOTSUPP;
+	struct socket *ssock;
+
+	switch (optname) {
+	case IPV6_V6ONLY:
+		lock_sock(sk);
+		ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
+		release_sock(sk);
+		if (!ssock)
+			return -EINVAL;
+
+		ret =3D tcp_setsockopt(ssock->sk, level, optname, optval, optlen);
+		if (ret =3D=3D 0)
+			sk->sk_ipv6only =3D ssock->sk->sk_ipv6only;
+
+		return ret;
+	}
+
+	return ret;
+}
+
 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
 			    char __user *optval, unsigned int optlen)
 {
@@ -1649,6 +1674,9 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 		return tcp_setsockopt(ssock->sk, level, optname, optval,
 				      optlen);
 =

+	if (level =3D=3D SOL_IPV6)
+		return mptcp_setsockopt_v6(msk, level, optname, optval, optlen);
+
 	return -EOPNOTSUPP;
 }
 =

-- =

2.26.2

--===============5661314741443463335==--
