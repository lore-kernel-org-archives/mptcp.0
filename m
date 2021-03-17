Content-Type: multipart/mixed; boundary="===============1117940363360939880=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 7/9] mptcp: setsockopt: SO_DEBUG and no-op
 options
Date: Wed, 17 Mar 2021 17:38:26 +0100
Message-ID: <20210317163828.27406-8-fw@strlen.de>
In-Reply-To: 20210317163828.27406-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 8197

--===============1117940363360939880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handle SO_DEBUG and set it on all subflows.
Ignore those values not implemented on TCP sockets.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/sockopt.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index e2cc6e11e777..3ba31f4a73e3 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -35,6 +35,32 @@ static int mptcp_get_int_option(struct mptcp_sock *msk, =
sockptr_t optval, unsign
 	return 0;
 }
 =

+static int mptcp_so_debug(struct mptcp_sock *msk, int val)
+{
+	sockptr_t optval =3D KERNEL_SOCKPTR(&val);
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D (struct sock *)msk;
+	int ret;
+
+	ret =3D sock_setsockopt(sk->sk_socket, SOL_SOCKET, SO_DEBUG,
+			      optval, sizeof(val));
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		bool slow =3D lock_sock_fast(ssk);
+
+		sock_valbool_flag(ssk, SOCK_DBG, !!val);
+		unlock_sock_fast(ssk, slow);
+	}
+
+	release_sock(sk);
+	return 0;
+}
+
 static int mptcp_so_mark(struct mptcp_sock *msk, int val)
 {
 	sockptr_t optval =3D KERNEL_SOCKPTR(&val);
@@ -169,6 +195,8 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp=
_sock *msk, int optname,
 		return ret;
 =

 	switch (optname) {
+	case SO_DEBUG:
+		return mptcp_so_debug(msk, val);
 	case SO_MARK:
 		return mptcp_so_mark(msk, val);
 	case SO_KEEPALIVE:
@@ -268,9 +296,21 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_so=
ck *msk, int optname,
 	case SO_RCVBUFFORCE:
 	case SO_MARK:
 	case SO_INCOMING_CPU:
+	case SO_DEBUG:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	case SO_LINGER:
 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
+	case SO_NO_CHECK:
+	case SO_DONTROUTE:
+	case SO_BROADCAST:
+	case SO_BSDCOMPAT:
+	case SO_PASSCRED:
+	case SO_PASSSEC:
+	case SO_RXQ_OVFL:
+	case SO_WIFI_STATUS:
+	case SO_NOFCS:
+	case SO_SELECT_ERR_QUEUE:
+		return 0;
 	}
 =

 	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen=
);
@@ -602,6 +642,7 @@ static void sync_socket_options(struct mptcp_sock *msk,=
 struct sock *ssk)
 		sk_dst_reset(ssk);
 	}
 =

+	sock_valbool_flag(ssk, SOCK_DBG, sock_flag(sk, SOCK_DBG));
 	unlock_sock_fast(ssk, slow);
 }
 =

-- =

2.26.2

--===============1117940363360939880==--
