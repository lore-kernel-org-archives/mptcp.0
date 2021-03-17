Content-Type: multipart/mixed; boundary="===============4490001866877770431=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 8/9] mptcp: sockopt: add TCP_CONGESTION
Date: Wed, 17 Mar 2021 17:38:27 +0100
Message-ID: <20210317163828.27406-9-fw@strlen.de>
In-Reply-To: 20210317163828.27406-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 8198

--===============4490001866877770431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make this interact with the initial subflow only, as that is the one
exposed to userspace (connect, bind).

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/sockopt.c | 83 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 3ba31f4a73e3..c1ffc3603b4f 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -556,6 +556,46 @@ static bool mptcp_supported_sockopt(int level, int opt=
name)
 	return false;
 }
 =

+static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int leve=
l, int optname,
+					  sockptr_t optval, unsigned int optlen)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	struct socket *ssock;
+	int ret =3D -EINVAL;
+	struct sock *ssk;
+
+	lock_sock(sk);
+	ssk =3D msk->first;
+	if (ssk)
+		goto do_sockopt;
+
+	ssock =3D __mptcp_nmpc_socket(msk);
+	if (!ssock)
+		goto out;
+
+	ssk =3D ssock->sk;
+do_sockopt:
+	ret =3D tcp_setsockopt(ssk, level, optname, optval, optlen);
+out:
+
+	release_sock(sk);
+	return ret;
+}
+
+static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
+				    sockptr_t optval, unsigned int optlen)
+{
+	switch (optname) {
+	case TCP_ULP:
+		return -EOPNOTSUPP;
+	case TCP_CONGESTION:
+		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
+						      optval, optlen);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 int mptcp_setsockopt(struct sock *sk, int level, int optname,
 		     sockptr_t optval, unsigned int optlen)
 {
@@ -585,6 +625,47 @@ int mptcp_setsockopt(struct sock *sk, int level, int o=
ptname,
 	if (level =3D=3D SOL_IPV6)
 		return mptcp_setsockopt_v6(msk, optname, optval, optlen);
 =

+	if (level =3D=3D SOL_TCP)
+		return mptcp_setsockopt_sol_tcp(msk, optname, optval, optlen);
+
+	return -EOPNOTSUPP;
+}
+
+static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int leve=
l, int optname,
+					  char __user *optval, int __user *optlen)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	struct socket *ssock;
+	int ret =3D -EINVAL;
+	struct sock *ssk;
+
+	lock_sock(sk);
+	ssk =3D msk->first;
+	if (ssk) {
+		ret =3D tcp_getsockopt(ssk, level, optname, optval, optlen);
+		goto out;
+	}
+
+	ssock =3D __mptcp_nmpc_socket(msk);
+	if (!ssock)
+		goto out;
+
+	ret =3D tcp_getsockopt(ssock->sk, level, optname, optval, optlen);
+
+out:
+	release_sock(sk);
+	return ret;
+}
+
+static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
+				    char __user *optval, int __user *optlen)
+{
+	switch (optname) {
+	case TCP_ULP:
+	case TCP_CONGESTION:
+		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
+						      optval, optlen);
+	}
 	return -EOPNOTSUPP;
 }
 =

@@ -608,6 +689,8 @@ int mptcp_getsockopt(struct sock *sk, int level, int op=
tname,
 	if (ssk)
 		return tcp_getsockopt(ssk, level, optname, optval, option);
 =

+	if (level =3D=3D SOL_TCP)
+		return mptcp_getsockopt_sol_tcp(msk, optname, optval, option);
 	return -EOPNOTSUPP;
 }
 =

-- =

2.26.2

--===============4490001866877770431==--
