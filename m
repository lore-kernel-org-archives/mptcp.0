Content-Type: multipart/mixed; boundary="===============4660717574094506948=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 9/9] mptcp: sockopt: handle TCP_INFO
Date: Wed, 17 Mar 2021 17:38:28 +0100
Message-ID: <20210317163828.27406-10-fw@strlen.de>
In-Reply-To: 20210317163828.27406-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 8199

--===============4660717574094506948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tries to follow the subflow most recently used from transmit.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/sockopt.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index c1ffc3603b4f..27ea5b1ea57e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -657,6 +657,28 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp=
_sock *msk, int level, int
 	return ret;
 }
 =

+static int mptcp_getsockopt_tcp_info(struct mptcp_sock *msk, char __user *=
optval, int __user *optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+	struct sock *ssk =3D NULL;
+	int ret =3D -EOPNOTSUPP;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		if (ssk =3D=3D msk->last_snd)
+			break;
+	}
+
+	if (ssk)
+		ret =3D tcp_getsockopt(ssk, SOL_TCP, TCP_INFO, optval, optlen);
+
+	release_sock(sk);
+	return ret;
+}
+
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
@@ -665,6 +687,8 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *=
msk, int optname,
 	case TCP_CONGESTION:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
+	case TCP_INFO:
+		return mptcp_getsockopt_tcp_info(msk, optval, optlen);
 	}
 	return -EOPNOTSUPP;
 }
-- =

2.26.2

--===============4660717574094506948==--
