Content-Type: multipart/mixed; boundary="===============3902336180005514459=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 04/12] mptcp: basic sndbuf autotuning
Date: Fri, 31 Jul 2020 19:39:19 +0200
Message-ID: <f82128dc0044d0a52ba11940b57f18f3630076f5.1596216310.git.pabeni@redhat.com>
In-Reply-To: cover.1596216310.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5411

--===============3902336180005514459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let the msk sendbuf track the size of the larger subflow's
send buffer.

The update is performed just before try to send any data.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f8e14d43ac55..c2fbd039f730 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -837,7 +837,8 @@ static void mptcp_nospace(struct sock *sk, struct sock =
*ssk)
 		set_bit(SOCK_NOSPACE, &sock->flags);
 }
 =

-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
+					   int *sndbuf)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk =3D (struct sock *)msk;
@@ -845,6 +846,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp=
_sock *msk)
 =

 	sock_owned_by_me(sk);
 =

+	*sndbuf =3D 0;
 	if (!mptcp_ext_cache_refill(msk))
 		return NULL;
 =

@@ -856,6 +858,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp=
_sock *msk)
 			return NULL;
 		}
 =

+		*sndbuf =3D max(ssk->sk_sndbuf, *sndbuf);
 		if (subflow->backup) {
 			if (!backup)
 				backup =3D ssk;
@@ -884,6 +887,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	struct page_frag *pfrag;
 	size_t copied =3D 0;
 	struct sock *ssk;
+	int sndbuf;
 	bool tx_ok;
 	long timeo;
 =

@@ -911,7 +915,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 =

 wait_for_sndbuf:
 	__mptcp_flush_join_list(msk);
-	ssk =3D mptcp_subflow_get_send(msk);
+	ssk =3D mptcp_subflow_get_send(msk, &sndbuf);
 	while (!sk_stream_memory_free(sk) ||
 	       !ssk ||
 	       !mptcp_page_frag_refill(ssk, pfrag)) {
@@ -934,13 +938,18 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =

 		mptcp_clean_una(sk);
 =

-		ssk =3D mptcp_subflow_get_send(msk);
+		ssk =3D mptcp_subflow_get_send(msk, &sndbuf);
 		if (list_empty(&msk->conn_list)) {
 			ret =3D -ENOTCONN;
 			goto out;
 		}
 	}
 =

+	/* do auto tuning */
+	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK) &&
+	    sndbuf > READ_ONCE(sk->sk_sndbuf))
+		WRITE_ONCE(sk->sk_sndbuf, sndbuf);
+
 	pr_debug("conn_list->subflow=3D%p", ssk);
 =

 	lock_sock(ssk);
@@ -1532,7 +1541,7 @@ static int mptcp_init_sock(struct sock *sk)
 =

 	sk_sockets_allocated_inc(sk);
 	sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
-	sk->sk_sndbuf =3D sock_net(sk)->ipv4.sysctl_tcp_wmem[2];
+	sk->sk_sndbuf =3D sock_net(sk)->ipv4.sysctl_tcp_wmem[1];
 =

 	return 0;
 }
-- =

2.26.2

--===============3902336180005514459==--
