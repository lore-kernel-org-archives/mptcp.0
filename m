Content-Type: multipart/mixed; boundary="===============2062210687822199571=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: prefix pm routines with mptcp_
Date: Wed, 02 Oct 2019 22:50:27 +0200
Message-ID: <20191002205027.17633-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2001

--===============2062210687822199571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

"pm" is currently used for Power Manager in the kernel. Better not to
pollute this namespace.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    Here is the patch I applied directly + follow-up. I made sure each comm=
it
    compiles:
      - 49825d3998b9: "squashed" in "mptcp: Add path manager interface"
      - 398e8a1c8bb5: build-fix in "mptcp: Add ADD_ADDR handling"
      - d74222a10684: build-fix in "mptcp: Add handling of incoming MP_JOIN=
 requests"
      - 9f39c3681b37: conflict in t/mptcp-Add-handling-of-outgoing-MP_JOIN-=
requests
      - 0f837758795a: mptcp: fix style typo (extra line added in one commit=
, removed in another one later)
      - 008467ef92e5..eeb324e54935: result

 net/mptcp/options.c  |  7 ++++---
 net/mptcp/pm.c       | 38 ++++++++++++++++++++------------------
 net/mptcp/protocol.c |  6 +++---
 net/mptcp/protocol.h | 28 +++++++++++++++-------------
 4 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 602cf40f72a6..ee53f9d356f9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -405,10 +405,11 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
 =

 	if (msk && mp_opt->add_addr) {
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
-			pm_add_addr(msk, &mp_opt->addr, mp_opt->addr_id);
+			mptcp_pm_add_addr(msk, &mp_opt->addr, mp_opt->addr_id);
 #if IS_ENABLED(CONFIG_IPV6)
 		else if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6)
-			pm_add_addr6(msk, &mp_opt->addr6, mp_opt->addr_id);
+			mptcp_pm_add_addr6(msk, &mp_opt->addr6,
+					   mp_opt->addr_id);
 #endif
 		mp_opt->add_addr =3D 0;
 	}
@@ -439,7 +440,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 	mpext->data_fin =3D mp_opt->data_fin;
 =

 	if (msk)
-		pm_fully_established(msk);
+		mptcp_pm_fully_established(msk);
 =

 }
 =

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 933dd805c9b2..9fa000c3abdc 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -10,59 +10,60 @@
 =

 /* path manager command handlers */
 =

-int pm_announce_addr(u32 token, sa_family_t family, u8 local_id,
-		     struct in_addr *addr)
+int mptcp_pm_announce_addr(u32 token, sa_family_t family, u8 local_id,
+			   struct in_addr *addr)
 {
 	return -ENOTSUPP;
 }
 =

-int pm_remove_addr(u32 token, u8 local_id)
+int mptcp_pm_remove_addr(u32 token, u8 local_id)
 {
 	return -ENOTSUPP;
 }
 =

-int pm_create_subflow(u32 token, u8 remote_id)
+int mptcp_pm_create_subflow(u32 token, u8 remote_id)
 {
 	return -ENOTSUPP;
 }
 =

-int pm_remove_subflow(u32 token, u8 remote_id)
+int mptcp_pm_remove_subflow(u32 token, u8 remote_id)
 {
 	return -ENOTSUPP;
 }
 =

 /* path manager event handlers */
 =

-void pm_new_connection(struct mptcp_sock *msk, int server_side)
+void mptcp_pm_new_connection(struct mptcp_sock *msk, int server_side)
 {
 	pr_debug("msk=3D%p", msk);
 =

 	msk->pm.server_side =3D server_side;
 }
 =

-void pm_fully_established(struct mptcp_sock *msk)
+void mptcp_pm_fully_established(struct mptcp_sock *msk)
 {
 	pr_debug("msk=3D%p", msk);
 =

 	msk->pm.fully_established =3D 1;
 }
 =

-void pm_connection_closed(struct mptcp_sock *msk)
+void mptcp_pm_connection_closed(struct mptcp_sock *msk)
 {
 	pr_debug("msk=3D%p", msk);
 }
 =

-void pm_subflow_established(struct mptcp_sock *msk, u8 id)
+void mptcp_pm_subflow_established(struct mptcp_sock *msk, u8 id)
 {
 	pr_debug("msk=3D%p", msk);
 }
 =

-void pm_subflow_closed(struct mptcp_sock *msk, u8 id)
+void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
 {
 	pr_debug("msk=3D%p", msk);
 }
 =

-void pm_add_addr(struct mptcp_sock *msk, const struct in_addr *addr, u8 id)
+void mptcp_pm_add_addr(struct mptcp_sock *msk, const struct in_addr *addr,
+		       u8 id)
 {
 	pr_debug("msk=3D%p, addr=3D%x, remote_id=3D%d", msk, addr->s_addr, id);
 =

@@ -72,20 +73,21 @@ void pm_add_addr(struct mptcp_sock *msk, const struct i=
n_addr *addr, u8 id)
 	msk->pm.remote_valid =3D 1;
 }
 =

-void pm_add_addr6(struct mptcp_sock *msk, const struct in6_addr *addr, u8 =
id)
+void mptcp_pm_add_addr6(struct mptcp_sock *msk, const struct in6_addr *add=
r,
+			u8 id)
 {
 	pr_debug("msk=3D%p", msk);
 }
 =

-void pm_rm_addr(struct mptcp_sock *msk, u8 id)
+void mptcp_pm_rm_addr(struct mptcp_sock *msk, u8 id)
 {
 	pr_debug("msk=3D%p", msk);
 }
 =

 /* path manager helpers */
 =

-int pm_addr_signal(struct mptcp_sock *msk, u8 *id,
-		   struct sockaddr_storage *saddr)
+int mptcp_pm_addr_signal(struct mptcp_sock *msk, u8 *id,
+			 struct sockaddr_storage *saddr)
 {
 	struct sockaddr_in *addr =3D (struct sockaddr_in *)saddr;
 =

@@ -102,8 +104,8 @@ int pm_addr_signal(struct mptcp_sock *msk, u8 *id,
 	return 0;
 }
 =

-int pm_get_local_id(struct request_sock *req, struct sock *sk,
-		    const struct sk_buff *skb)
+int mptcp_pm_get_local_id(struct request_sock *req, struct sock *sk,
+			  const struct sk_buff *skb)
 {
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -119,6 +121,6 @@ int pm_get_local_id(struct request_sock *req, struct so=
ck *sk,
 	return 0;
 }
 =

-void pm_init(void)
+void mptcp_pm_init(void)
 {
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 754172af8748..b03b88c5a75a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -653,7 +653,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		mptcp_token_update_accept(new_sock->sk, new_mptcp_sock);
 		msk->subflow =3D NULL;
 =

-		pm_new_connection(msk, 1);
+		mptcp_pm_new_connection(msk, 1);
 =

 		mptcp_crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
@@ -786,7 +786,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 		msk->token =3D subflow->token;
 		pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
 =

-		pm_new_connection(msk, 0);
+		mptcp_pm_new_connection(msk, 0);
 =

 		mptcp_crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
@@ -1014,7 +1014,7 @@ void __init mptcp_init(void)
 	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
 =

 	mptcp_subflow_init();
-	pm_init();
+	mptcp_pm_init();
 =

 	if (proto_register(&mptcp_prot, 1) !=3D 0)
 		panic("Failed to register MPTCP proto.\n");
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 32fc273eb60d..b3f2e2382a93 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -199,19 +199,21 @@ static inline void mptcp_crypto_key_gen_sha1(u64 *key=
, u32 *token, u64 *idsn)
 void mptcp_crypto_hmac_sha1(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 			    u32 *hash_out);
 =

-void pm_init(void);
-void pm_new_connection(struct mptcp_sock *msk, int server_side);
-void pm_fully_established(struct mptcp_sock *msk);
-void pm_connection_closed(struct mptcp_sock *msk);
-void pm_subflow_established(struct mptcp_sock *msk, u8 id);
-void pm_subflow_closed(struct mptcp_sock *msk, u8 id);
-void pm_add_addr(struct mptcp_sock *msk, const struct in_addr *addr, u8 id=
);
-void pm_add_addr6(struct mptcp_sock *msk, const struct in6_addr *addr, u8 =
id);
-void pm_rm_addr(struct mptcp_sock *msk, u8 id);
-int pm_addr_signal(struct mptcp_sock *msk, u8 *id,
-		   struct sockaddr_storage *saddr);
-int pm_get_local_id(struct request_sock *req, struct sock *sk,
-		    const struct sk_buff *skb);
+void mptcp_pm_init(void);
+void mptcp_pm_new_connection(struct mptcp_sock *msk, int server_side);
+void mptcp_pm_fully_established(struct mptcp_sock *msk);
+void mptcp_pm_connection_closed(struct mptcp_sock *msk);
+void mptcp_pm_subflow_established(struct mptcp_sock *msk, u8 id);
+void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
+void mptcp_pm_add_addr(struct mptcp_sock *msk, const struct in_addr *addr,
+		       u8 id);
+void mptcp_pm_add_addr6(struct mptcp_sock *msk, const struct in6_addr *add=
r,
+			u8 id);
+void mptcp_pm_rm_addr(struct mptcp_sock *msk, u8 id);
+int mptcp_pm_addr_signal(struct mptcp_sock *msk, u8 *id,
+			 struct sockaddr_storage *saddr);
+int mptcp_pm_get_local_id(struct request_sock *req, struct sock *sk,
+			  const struct sk_buff *skb);
 =

 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
-- =

2.20.1

--===============2062210687822199571==--
