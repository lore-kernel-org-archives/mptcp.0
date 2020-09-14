Content-Type: multipart/mixed; boundary="===============4221579517395980267=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 04/13] mptcp: basic sndbuf autotuning
Date: Mon, 14 Sep 2020 10:01:10 +0200
Message-ID: <3f5500f120bf9a196abf3b7b1b307a1e48f8c715.1599854632.git.pabeni@redhat.com>
In-Reply-To: cover.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5834

--===============4221579517395980267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let the msk sendbuf track the size of the larger subflow's
send window, so that we ensure mptcp_sendmsg() does not
exceed MPTCP-level send window.

The update is performed just before try to send any data.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 95573c6f7762..4f12a8ce0ddd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -856,7 +856,8 @@ static void mptcp_nospace(struct mptcp_sock *msk)
 	}
 }
 =

-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
+					   u32 *sndbuf)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk =3D (struct sock *)msk;
@@ -865,6 +866,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp=
_sock *msk)
 =

 	sock_owned_by_me(sk);
 =

+	*sndbuf =3D 0;
 	if (!mptcp_ext_cache_refill(msk))
 		return NULL;
 =

@@ -877,6 +879,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp=
_sock *msk)
 			return NULL;
 		}
 =

+		*sndbuf =3D max(tcp_sk(ssk)->snd_wnd, *sndbuf);
 		if (subflow->backup) {
 			if (!backup)
 				backup =3D ssk;
@@ -903,6 +906,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	struct page_frag *pfrag;
 	size_t copied =3D 0;
 	struct sock *ssk;
+	u32 sndbuf;
 	bool tx_ok;
 	long timeo;
 =

@@ -929,7 +933,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	}
 =

 	__mptcp_flush_join_list(msk);
-	ssk =3D mptcp_subflow_get_send(msk);
+	ssk =3D mptcp_subflow_get_send(msk, &sndbuf);
 	while (!sk_stream_memory_free(sk) ||
 	       !ssk ||
 	       !mptcp_page_frag_refill(ssk, pfrag)) {
@@ -953,13 +957,18 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
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
@@ -1547,7 +1556,7 @@ static int mptcp_init_sock(struct sock *sk)
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

--===============4221579517395980267==--
