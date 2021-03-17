Content-Type: multipart/mixed; boundary="===============0101141064150073962=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 3/9] mptcp: setsockopt: handle receive/send
 buffer and device bind
Date: Wed, 17 Mar 2021 17:38:22 +0100
Message-ID: <20210317163828.27406-4-fw@strlen.de>
In-Reply-To: 20210317163828.27406-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 8193

--===============0101141064150073962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Similar to previous patch: needs to be mirrored to all subflows.

Device bind is simpler: it is only done on the initial (listener) sk.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/sockopt.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 33ca67e99f8f..9a87c50e21a4 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -79,6 +79,38 @@ static int mptcp_so_priority(struct mptcp_sock *msk, int=
 val)
 	return 0;
 }
 =

+static int mptcp_so_sndrcvbuf(struct mptcp_sock *msk, int optname, int val)
+{
+	sockptr_t optval =3D KERNEL_SOCKPTR(&val);
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+	int ret;
+
+	ret =3D sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname,
+			      optval, sizeof(val));
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		bool slow =3D lock_sock_fast(ssk);
+		unsigned int ulock;
+
+		ulock =3D sk->sk_userlocks;
+		ulock &=3D SOCK_SNDBUF_LOCK | SOCK_RCVBUF_LOCK;
+
+		ssk->sk_priority =3D val;
+		ssk->sk_userlocks |=3D ulock;
+		WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
+		WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+		unlock_sock_fast(ssk, slow);
+	}
+
+	release_sock(sk);
+	return 0;
+}
+
 static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int opt=
name,
 					   sockptr_t optval, unsigned int optlen)
 {
@@ -94,6 +126,11 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp=
_sock *msk, int optname,
 		return 0;
 	case SO_PRIORITY:
 		return mptcp_so_priority(msk, val);
+	case SO_SNDBUF:
+	case SO_SNDBUFFORCE:
+	case SO_RCVBUF:
+	case SO_RCVBUFFORCE:
+		return mptcp_so_sndrcvbuf(msk, optname, val);
 	}
 =

 	return -ENOPROTOOPT;
@@ -109,6 +146,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_soc=
k *msk, int optname,
 	switch (optname) {
 	case SO_REUSEPORT:
 	case SO_REUSEADDR:
+	case SO_BINDTODEVICE:
+	case SO_BINDTOIFINDEX:
 		lock_sock(sk);
 		ssock =3D __mptcp_nmpc_socket(msk);
 		if (!ssock) {
@@ -122,11 +161,19 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_s=
ock *msk, int optname,
 				sk->sk_reuseport =3D ssock->sk->sk_reuseport;
 			else if (optname =3D=3D SO_REUSEADDR)
 				sk->sk_reuse =3D ssock->sk->sk_reuse;
+			else if (optname =3D=3D SO_BINDTODEVICE)
+				sk->sk_bound_dev_if =3D ssock->sk->sk_bound_dev_if;
+			else if (optname =3D=3D SO_BINDTOIFINDEX)
+				sk->sk_bound_dev_if =3D ssock->sk->sk_bound_dev_if;
 		}
 		release_sock(sk);
 		return ret;
 	case SO_KEEPALIVE:
 	case SO_PRIORITY:
+	case SO_SNDBUF:
+	case SO_SNDBUFFORCE:
+	case SO_RCVBUF:
+	case SO_RCVBUFFORCE:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	}
 =

@@ -441,6 +488,10 @@ static void sync_socket_options(struct mptcp_sock *msk=
, struct sock *ssk)
 	}
 =

 	ssk->sk_priority =3D sk->sk_priority;
+	ssk->sk_bound_dev_if =3D sk->sk_bound_dev_if;
+
+	WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
+	WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
 	unlock_sock_fast(ssk, slow);
 }
 =

-- =

2.26.2

--===============0101141064150073962==--
