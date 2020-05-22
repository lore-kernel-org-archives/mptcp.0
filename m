Content-Type: multipart/mixed; boundary="===============4663068220178664977=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/4] mptcp: add __init annotation on setup functions
Date: Fri, 22 May 2020 12:10:10 +0200
Message-ID: <fae062c473b43900d481322b02c322537e2d7da2.1590142022.git.pabeni@redhat.com>
In-Reply-To: cover.1590142022.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4453

--===============4663068220178664977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the missing annotation in some setup-only
functions.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 5 +++--
 net/mptcp/protocol.h | 9 +++++----
 net/mptcp/subflow.c  | 2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e3a628bea2b8..16ca39ae314a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2028,7 +2028,7 @@ static struct inet_protosw mptcp_protosw =3D {
 	.flags		=3D INET_PROTOSW_ICSK,
 };
 =

-void mptcp_proto_init(void)
+void __init mptcp_proto_init(void)
 {
 	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
 =

@@ -2037,6 +2037,7 @@ void mptcp_proto_init(void)
 =

 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_token_init();
 =

 	if (proto_register(&mptcp_prot, 1) !=3D 0)
 		panic("Failed to register MPTCP proto.\n");
@@ -2089,7 +2090,7 @@ static struct inet_protosw mptcp_v6_protosw =3D {
 	.flags		=3D INET_PROTOSW_ICSK,
 };
 =

-int mptcp_proto_v6_init(void)
+int __init mptcp_proto_v6_init(void)
 {
 	int err;
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f5adca93e8fb..038c0237cca0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -342,7 +342,7 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow=
_context *subflow)
 =

 int mptcp_is_enabled(struct net *net);
 bool mptcp_subflow_data_available(struct sock *sk);
-void mptcp_subflow_init(void);
+void __init mptcp_subflow_init(void);
 =

 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, int ifindex,
@@ -365,9 +365,9 @@ extern const struct inet_connection_sock_af_ops ipv4_sp=
ecific;
 extern const struct inet_connection_sock_af_ops ipv6_specific;
 #endif
 =

-void mptcp_proto_init(void);
+void __init mptcp_proto_init(void);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-int mptcp_proto_v6_init(void);
+int __init mptcp_proto_v6_init(void);
 #endif
 =

 struct sock *mptcp_sk_clone(const struct sock *sk,
@@ -382,6 +382,7 @@ bool mptcp_finish_join(struct sock *sk);
 void mptcp_data_acked(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 =

+void __init mptcp_token_init(void);
 int mptcp_token_new_request(struct request_sock *req);
 void mptcp_token_destroy_request(u32 token);
 int mptcp_token_new_connect(struct sock *sk);
@@ -404,7 +405,7 @@ static inline void mptcp_crypto_key_gen_sha(u64 *key, u=
32 *token, u64 *idsn)
 =

 void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hma=
c);
 =

-void mptcp_pm_init(void);
+void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
 void mptcp_pm_close(struct mptcp_sock *msk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, int server_side);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9ea2dea6f261..6f5b43afd5fd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1239,7 +1239,7 @@ static int subflow_ops_init(struct request_sock_ops *=
subflow_ops)
 	return 0;
 }
 =

-void mptcp_subflow_init(void)
+void __init mptcp_subflow_init(void)
 {
 	subflow_request_sock_ops =3D tcp_request_sock_ops;
 	if (subflow_ops_init(&subflow_request_sock_ops) !=3D 0)
-- =

2.21.3

--===============4663068220178664977==--
