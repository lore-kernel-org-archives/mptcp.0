Content-Type: multipart/mixed; boundary="===============3939422597769428418=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 4/9] mptcp: setsockopt: support SO_LINGER
Date: Wed, 17 Mar 2021 17:38:23 +0100
Message-ID: <20210317163828.27406-5-fw@strlen.de>
In-Reply-To: 20210317163828.27406-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 8194

--===============3939422597769428418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Similar to PRIORITY/KEEPALIVE: needs to be mirrored to all subflows.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/sockopt.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 9a87c50e21a4..a78e51ead3ae 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -136,6 +136,45 @@ static int mptcp_setsockopt_sol_socket_int(struct mptc=
p_sock *msk, int optname,
 	return -ENOPROTOOPT;
 }
 =

+static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sock=
ptr_t optval,
+					      unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+	struct linger ling;
+	sockptr_t kopt;
+	int ret;
+
+	if (optlen < sizeof(ling))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&ling, optval, sizeof(ling)))
+		return -EFAULT;
+
+	kopt =3D KERNEL_SOCKPTR(&ling);
+	ret =3D sock_setsockopt(sk->sk_socket, SOL_SOCKET, SO_LINGER, kopt, sizeo=
f(ling));
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		bool slow =3D lock_sock_fast(ssk);
+
+		if (!ling.l_onoff)
+			sock_reset_flag(ssk, SOCK_LINGER);
+		else {
+			ssk->sk_lingertime =3D sk->sk_lingertime;
+			sock_set_flag(ssk, SOCK_LINGER);
+		}
+
+		unlock_sock_fast(ssk, slow);
+	}
+
+	release_sock(sk);
+	return 0;
+}
+
 static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 				       sockptr_t optval, unsigned int optlen)
 {
@@ -175,6 +214,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_soc=
k *msk, int optname,
 	case SO_RCVBUF:
 	case SO_RCVBUFFORCE:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
+	case SO_LINGER:
+		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
 	}
 =

 	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen=
);
@@ -492,6 +533,13 @@ static void sync_socket_options(struct mptcp_sock *msk=
, struct sock *ssk)
 =

 	WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
 	WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+
+	if (sock_flag(sk, SOCK_LINGER)) {
+		ssk->sk_lingertime =3D sk->sk_lingertime;
+		sock_set_flag(ssk, SOCK_LINGER);
+	} else {
+		sock_reset_flag(ssk, SOCK_LINGER);
+	}
 	unlock_sock_fast(ssk, slow);
 }
 =

-- =

2.26.2

--===============3939422597769428418==--
