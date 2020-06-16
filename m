Content-Type: multipart/mixed; boundary="===============3627341381853638541=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v2 3/3] mptcp: support IPV6_V6ONLY
 setsockopt
Date: Tue, 16 Jun 2020 14:25:31 +0200
Message-ID: <20200616122531.2443-4-fw@strlen.de>
In-Reply-To: 20200616122531.2443-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4698

--===============3627341381853638541==
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
 net/mptcp/protocol.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b2338680497a..9e7fc44f405d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1659,6 +1659,33 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_=
sock *msk, int optname,
 	return ret;
 }
 =

+static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
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
+		if (IS_ERR(ssock)) {
+			release_sock(sk);
+			return PTR_ERR(ssock);
+		}
+
+		ret =3D tcp_setsockopt(ssock->sk, SOL_IPV6, optname, optval, optlen);
+		if (ret =3D=3D 0)
+			sk->sk_ipv6only =3D ssock->sk->sk_ipv6only;
+
+		release_sock(sk);
+		break;
+	}
+
+	return ret;
+}
+
 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
 			    char __user *optval, unsigned int optlen)
 {
@@ -1684,6 +1711,9 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 		return tcp_setsockopt(ssock->sk, level, optname, optval,
 				      optlen);
 =

+	if (level =3D=3D SOL_IPV6)
+		return mptcp_setsockopt_v6(msk, optname, optval, optlen);
+
 	return -EOPNOTSUPP;
 }
 =

-- =

2.26.2

--===============3627341381853638541==--
