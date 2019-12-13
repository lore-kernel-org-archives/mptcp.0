Content-Type: multipart/mixed; boundary="===============1617210440258833727=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 2/4] mptcp: cache the first subflow sock
Date: Fri, 13 Dec 2019 15:33:50 +0100
Message-ID: <61271bff5252d53a660a6e91bafc7c2c9899a319.1576247361.git.pabeni@redhat.com>
In-Reply-To: cover.1576247361.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2937

--===============1617210440258833727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

so that we can easily check for TCP fallback

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 6 +++++-
 net/mptcp/protocol.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b6d753ed8397..1d21b64b2149 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -87,7 +87,7 @@ static struct socket *__mptcp_tcp_fallback(const struct m=
ptcp_sock *msk)
 =

 static bool __mptcp_can_create_subflow(const struct mptcp_sock *msk)
 {
-	return ((struct sock *)msk)->sk_state =3D=3D TCP_CLOSE;
+	return !msk->first;
 }
 =

 static struct socket *__mptcp_socket_create(struct mptcp_sock *msk, int st=
ate)
@@ -108,6 +108,7 @@ static struct socket *__mptcp_socket_create(struct mptc=
p_sock *msk, int state)
 	if (err)
 		return ERR_PTR(err);
 =

+	msk->first =3D ssock->sk;
 	msk->subflow =3D ssock;
 	subflow =3D mptcp_subflow_ctx(ssock->sk);
 	list_add(&subflow->node, &msk->conn_list);
@@ -559,6 +560,8 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
 =

+	msk->first =3D NULL;
+
 	return 0;
 }
 =

@@ -688,6 +691,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
 		msk->subflow =3D NULL;
+		msk->first =3D newsk;
 =

 		mptcp_token_update_accept(newsk, new_mptcp_sock);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0e5ba5ac1443..b4cf88258b6b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -73,6 +73,7 @@ struct mptcp_sock {
 	struct list_head conn_list;
 	struct skb_ext	*cached_ext;	/* for the next sendmsg */
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
+	struct sock	*first;
 };
 =

 #define mptcp_for_each_subflow(__msk, __subflow)			\
-- =

2.21.0

--===============1617210440258833727==--
