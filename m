Content-Type: multipart/mixed; boundary="===============0537755632227552178=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 04/13] mptcp: basic sndbuf autotuning
Date: Wed, 05 Aug 2020 19:57:03 +0200
Message-ID: <bf9d95f3ed58d0ce68c507fe3808f5120e12c62d.1596649926.git.pabeni@redhat.com>
In-Reply-To: cover.1596649926.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5483

--===============0537755632227552178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let the msk sendbuf track the size of the larger subflow's
send window, so that we ensure mptcp_sendmsg() does not
exceed MPTCP-level send window.

The update is performed just before try to send any data.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
RFC -> v1:
 - SOCK_RCVBUF_LOCK -> SOCK_SNDBUF_LOCK
 - track snd_wnd instead of subflows sndbuf
---
 net/mptcp/protocol.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e74a27581c73..9d7b75b4611d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -854,7 +854,8 @@ static void mptcp_nospace(struct mptcp_sock *msk)
 	}
 }
 =

-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
+					   u32 *sndbuf)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk =3D (struct sock *)msk;
@@ -862,6 +863,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp=
_sock *msk)
 =

 	sock_owned_by_me(sk);
 =

+	*sndbuf =3D 0;
 	if (!mptcp_ext_cache_refill(msk))
 		return NULL;
 =

@@ -873,6 +875,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp=
_sock *msk)
 			return NULL;
 		}
 =

+		*sndbuf =3D max(tcp_sk(ssk)->snd_wnd, *sndbuf);
 		if (subflow->backup) {
 			if (!backup)
 				backup =3D ssk;
@@ -899,6 +902,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	struct page_frag *pfrag;
 	size_t copied =3D 0;
 	struct sock *ssk;
+	u32 sndbuf;
 	bool tx_ok;
 	long timeo;
 =

@@ -926,7 +930,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 =

 wait_for_sndbuf:
 	__mptcp_flush_join_list(msk);
-	ssk =3D mptcp_subflow_get_send(msk);
+	ssk =3D mptcp_subflow_get_send(msk, &sndbuf);
 	while (!sk_stream_memory_free(sk) ||
 	       !ssk ||
 	       !mptcp_page_frag_refill(ssk, pfrag)) {
@@ -950,13 +954,18 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
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
+	if (!(sk->sk_userlocks & SOCK_SNDBUF_LOCK) &&
+	    sndbuf > READ_ONCE(sk->sk_sndbuf))
+		WRITE_ONCE(sk->sk_sndbuf, sndbuf);
+
 	pr_debug("conn_list->subflow=3D%p", ssk);
 =

 	lock_sock(ssk);
@@ -1546,7 +1555,7 @@ static int mptcp_init_sock(struct sock *sk)
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

--===============0537755632227552178==--
