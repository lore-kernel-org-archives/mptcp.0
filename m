Content-Type: multipart/mixed; boundary="===============8712951837016323125=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 5/9] mptcp: setsockopt: add SO_MARK support
Date: Wed, 17 Mar 2021 17:38:24 +0100
Message-ID: <20210317163828.27406-6-fw@strlen.de>
In-Reply-To: 20210317163828.27406-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 8195

--===============8712951837016323125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Value is synced to all subflows.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/sockopt.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a78e51ead3ae..face38d5e149 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -35,6 +35,37 @@ static int mptcp_get_int_option(struct mptcp_sock *msk, =
sockptr_t optval, unsign
 	return 0;
 }
 =

+static int mptcp_so_mark(struct mptcp_sock *msk, int val)
+{
+	sockptr_t optval =3D KERNEL_SOCKPTR(&val);
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+	int ret;
+
+	ret =3D sock_setsockopt(sk->sk_socket, SOL_SOCKET, SO_MARK,
+			      optval, sizeof(val));
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		if (READ_ONCE(ssk->sk_mark) =3D=3D sk->sk_mark)
+			continue;
+
+		slow =3D lock_sock_fast(ssk);
+		ssk->sk_mark =3D sk->sk_mark;
+		sk_dst_reset(ssk);
+		unlock_sock_fast(ssk, slow);
+	}
+
+	release_sock(sk);
+	return 0;
+}
+
 static void mptcp_so_keepalive(struct mptcp_sock *msk, int val)
 {
 	struct mptcp_subflow_context *subflow;
@@ -121,6 +152,8 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp=
_sock *msk, int optname,
 		return ret;
 =

 	switch (optname) {
+	case SO_MARK:
+		return mptcp_so_mark(msk, val);
 	case SO_KEEPALIVE:
 		mptcp_so_keepalive(msk, val);
 		return 0;
@@ -213,6 +246,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_soc=
k *msk, int optname,
 	case SO_SNDBUFFORCE:
 	case SO_RCVBUF:
 	case SO_RCVBUFFORCE:
+	case SO_MARK:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	case SO_LINGER:
 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
@@ -540,6 +574,12 @@ static void sync_socket_options(struct mptcp_sock *msk=
, struct sock *ssk)
 	} else {
 		sock_reset_flag(ssk, SOCK_LINGER);
 	}
+
+	if (sk->sk_mark !=3D ssk->sk_mark) {
+		ssk->sk_mark =3D sk->sk_mark;
+		sk_dst_reset(ssk);
+	}
+
 	unlock_sock_fast(ssk, slow);
 }
 =

-- =

2.26.2

--===============8712951837016323125==--
