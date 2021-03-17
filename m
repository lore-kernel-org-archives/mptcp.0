Content-Type: multipart/mixed; boundary="===============3211660563003726135=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 2/9] mptcp: setsockopt: handle SO_KEEPALIVE
 and SO_PRIORITY
Date: Wed, 17 Mar 2021 17:38:21 +0100
Message-ID: <20210317163828.27406-3-fw@strlen.de>
In-Reply-To: 20210317163828.27406-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 8192

--===============3211660563003726135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

start with something simple: both take an integer value, both
need to be mirrored to all subflows.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/sockopt.c | 95 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fa71216e11a3..33ca67e99f8f 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -24,6 +24,81 @@ static struct sock *__mptcp_tcp_fallback(struct mptcp_so=
ck *msk)
 	return msk->first;
 }
 =

+static int mptcp_get_int_option(struct mptcp_sock *msk, sockptr_t optval, =
unsigned int optlen, int *val)
+{
+	if (optlen < sizeof(int))
+		return -EINVAL;
+
+	if (copy_from_sockptr(val, optval, sizeof(*val)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static void mptcp_so_keepalive(struct mptcp_sock *msk, int val)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+
+	lock_sock(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		bool slow =3D lock_sock_fast(ssk);
+
+		if (ssk->sk_prot->keepalive)
+			ssk->sk_prot->keepalive(ssk, !!val);
+		sock_valbool_flag(ssk, SOCK_KEEPOPEN, !!val);
+		unlock_sock_fast(ssk, slow);
+	}
+
+	sock_valbool_flag(sk, SOCK_KEEPOPEN, !!val);
+	release_sock(sk);
+}
+
+static int mptcp_so_priority(struct mptcp_sock *msk, int val)
+{
+	sockptr_t optval =3D KERNEL_SOCKPTR(&val);
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+	int ret;
+
+	ret =3D sock_setsockopt(sk->sk_socket, SOL_SOCKET, SO_PRIORITY,
+			      optval, sizeof(val));
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		WRITE_ONCE(ssk->sk_priority, val);
+	}
+	release_sock(sk);
+
+	return 0;
+}
+
+static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int opt=
name,
+					   sockptr_t optval, unsigned int optlen)
+{
+	int val, ret;
+
+	ret =3D mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
+
+	switch (optname) {
+	case SO_KEEPALIVE:
+		mptcp_so_keepalive(msk, val);
+		return 0;
+	case SO_PRIORITY:
+		return mptcp_so_priority(msk, val);
+	}
+
+	return -ENOPROTOOPT;
+}
+
 static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 				       sockptr_t optval, unsigned int optlen)
 {
@@ -50,6 +125,9 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock=
 *msk, int optname,
 		}
 		release_sock(sk);
 		return ret;
+	case SO_KEEPALIVE:
+	case SO_PRIORITY:
+		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	}
 =

 	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen=
);
@@ -350,6 +428,22 @@ int mptcp_getsockopt(struct sock *sk, int level, int o=
ptname,
 	return -EOPNOTSUPP;
 }
 =

+static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	bool slow =3D lock_sock_fast(ssk);
+
+	if (ssk->sk_prot->keepalive) {
+		if (sock_flag(sk, SOCK_KEEPOPEN))
+			ssk->sk_prot->keepalive(ssk, 1);
+		else
+			ssk->sk_prot->keepalive(ssk, 0);
+	}
+
+	ssk->sk_priority =3D sk->sk_priority;
+	unlock_sock_fast(ssk, slow);
+}
+
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -360,6 +454,7 @@ void mptcp_sockopt_sync(struct mptcp_sock *msk, struct =
sock *ssk)
 	if (subflow->setsockopt_seq =3D=3D msk->setsockopt_seq)
 		return;
 =

+	sync_socket_options(msk, ssk);
 	subflow->setsockopt_seq =3D msk->setsockopt_seq;
 }
 =

-- =

2.26.2

--===============3211660563003726135==--
