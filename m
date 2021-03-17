Content-Type: multipart/mixed; boundary="===============4425436181944275739=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 6/9] mptcp: setsockopt: add SO_INCOMING_CPU
Date: Wed, 17 Mar 2021 17:38:25 +0100
Message-ID: <20210317163828.27406-7-fw@strlen.de>
In-Reply-To: 20210317163828.27406-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 8196

--===============4425436181944275739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replicate to all subflows.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/sockopt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index face38d5e149..e2cc6e11e777 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -110,6 +110,23 @@ static int mptcp_so_priority(struct mptcp_sock *msk, i=
nt val)
 	return 0;
 }
 =

+static void mptcp_so_incoming_cpu(struct mptcp_sock *msk, int val)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+
+	WRITE_ONCE(sk->sk_incoming_cpu, val);
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		WRITE_ONCE(ssk->sk_incoming_cpu, val);
+	}
+
+	release_sock(sk);
+}
+
 static int mptcp_so_sndrcvbuf(struct mptcp_sock *msk, int optname, int val)
 {
 	sockptr_t optval =3D KERNEL_SOCKPTR(&val);
@@ -164,6 +181,9 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp=
_sock *msk, int optname,
 	case SO_RCVBUF:
 	case SO_RCVBUFFORCE:
 		return mptcp_so_sndrcvbuf(msk, optname, val);
+	case SO_INCOMING_CPU:
+		mptcp_so_incoming_cpu(msk, val);
+		return 0;
 	}
 =

 	return -ENOPROTOOPT;
@@ -247,6 +267,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_soc=
k *msk, int optname,
 	case SO_RCVBUF:
 	case SO_RCVBUFFORCE:
 	case SO_MARK:
+	case SO_INCOMING_CPU:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	case SO_LINGER:
 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
@@ -564,6 +585,7 @@ static void sync_socket_options(struct mptcp_sock *msk,=
 struct sock *ssk)
 =

 	ssk->sk_priority =3D sk->sk_priority;
 	ssk->sk_bound_dev_if =3D sk->sk_bound_dev_if;
+	ssk->sk_incoming_cpu =3D sk->sk_incoming_cpu;
 =

 	WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
 	WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
-- =

2.26.2

--===============4425436181944275739==--
