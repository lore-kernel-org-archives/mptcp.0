Content-Type: multipart/mixed; boundary="===============5408104528347020233=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] mptcp: Prefix path management routines with mptcp_
Date: Fri, 27 Sep 2019 16:42:10 -0700
Message-ID: <20190927234210.3000-3-peter.krystad@linux.intel.com>
In-Reply-To: 20190927234210.3000-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1945

--===============5408104528347020233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Do not pollute pm namespace.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c  | 10 ++++++----
 net/mptcp/pm.c       | 38 ++++++++++++++++++++------------------
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h | 42 ++++++++++++++++++++++--------------------
 net/mptcp/subflow.c  |  2 +-
 5 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 42f8b9beaa41..c4111480a3f4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -465,7 +465,7 @@ static bool mptcp_established_options_addr(struct sock =
*sk,
 	if (!msk->pm.fully_established || !msk->addr_signal)
 		return false;
 =

-	if (pm_addr_signal(msk, &id, &saddr))
+	if (mptcp_pm_addr_signal(msk, &id, &saddr))
 		return false;
 =

 	if (saddr.ss_family =3D=3D AF_INET && remaining < TCPOLEN_MPTCP_ADD_ADDR)
@@ -587,10 +587,12 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
 =

 	if (msk && mp_opt->add_addr) {
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
-			pm_add_addr(msk, &mp_opt->addr, mp_opt->addr_id);
+			mptcp_pm_add_addr(msk, &mp_opt->addr,
+					  mp_opt->addr_id);
 #if IS_ENABLED(CONFIG_IPV6)
 		else if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6)
-			pm_add_addr6(msk, &mp_opt->addr6, mp_opt->addr_id);
+			mptcp_pm_add_addr6(msk, &mp_opt->addr6,
+					   mp_opt->addr_id);
 #endif
 		mp_opt->add_addr =3D 0;
 	}
@@ -623,7 +625,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 	mpext->data_fin =3D mp_opt->data_fin;
 =

 	if (msk)
-		pm_fully_established(msk);
+		mptcp_pm_fully_established(msk);
 }
 =

 void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts)
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 20bea1303342..0c0eddc3f18e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -10,8 +10,8 @@
 =

 /* path manager command handlers */
 =

-int pm_announce_addr(u32 token, u8 local_id, sa_family_t family,
-		     struct in_addr *addr)
+int mptcp_pm_announce_addr(u32 token, u8 local_id, sa_family_t family,
+			   struct in_addr *addr)
 {
 	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
 	int err =3D 0;
@@ -36,7 +36,7 @@ int pm_announce_addr(u32 token, u8 local_id, sa_family_t =
family,
 	return err;
 }
 =

-int pm_remove_addr(u32 token, u8 local_id)
+int mptcp_pm_remove_addr(u32 token, u8 local_id)
 {
 	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
 =

@@ -50,8 +50,8 @@ int pm_remove_addr(u32 token, u8 local_id)
 	return 0;
 }
 =

-int pm_create_subflow(u32 token, u8 remote_id, sa_family_t family,
-		      struct in_addr *addr)
+int mptcp_pm_create_subflow(u32 token, u8 remote_id, sa_family_t family,
+			    struct in_addr *addr)
 {
 	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
 	struct sockaddr_in remote;
@@ -86,14 +86,14 @@ int pm_create_subflow(u32 token, u8 remote_id, sa_famil=
y_t family,
 	return err;
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
 	struct mptcp_pm_data *pm =3D &msk->pm;
 =

@@ -103,7 +103,7 @@ void pm_new_connection(struct mptcp_sock *msk, int serv=
er_side)
 	pm->token =3D msk->token;
 }
 =

-void pm_fully_established(struct mptcp_sock *msk)
+void mptcp_pm_fully_established(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
 =

@@ -112,22 +112,23 @@ void pm_fully_established(struct mptcp_sock *msk)
 	pm->fully_established =3D 1;
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
 	struct mptcp_pm_data *pm =3D &msk->pm;
 =

@@ -139,20 +140,21 @@ void pm_add_addr(struct mptcp_sock *msk, const struct=
 in_addr *addr, u8 id)
 	pm->remote_valid =3D 1;
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

@@ -169,8 +171,8 @@ int pm_addr_signal(struct mptcp_sock *msk, u8 *id,
 	return 0;
 }
 =

-int pm_get_local_id(struct request_sock *req, struct sock *sk,
-		    const struct sk_buff *skb)
+int mptcp_pm_get_local_id(struct request_sock *req, struct sock *sk,
+			  const struct sk_buff *skb)
 {
 	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 45dbfe83b08f..4aac1eda09b3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -981,7 +981,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		mptcp_token_update_accept(new_sock->sk, new_mptcp_sock);
 		msk->subflow =3D NULL;
 =

-		pm_new_connection(msk, 1);
+		mptcp_pm_new_connection(msk, 1);
 =

 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
@@ -1138,7 +1138,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
able)
 		pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
 		msk->dport =3D ntohs(inet_sk(msk->subflow->sk)->inet_dport);
 =

-		pm_new_connection(msk, 0);
+		mptcp_pm_new_connection(msk, 0);
 =

 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6518c7f1c232..d42ad07653bd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -288,26 +288,28 @@ static inline void crypto_key_gen_sha1(u64 *key, u32 =
*token, u64 *idsn)
 void crypto_hmac_sha1(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 		      u32 *hash_out);
 =

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
-
-int pm_announce_addr(u32 token, u8 local_id, sa_family_t family,
-		     struct in_addr *addr);
-int pm_create_subflow(u32 token, u8 remote_id, sa_family_t family,
-		      struct in_addr *addr);
-int pm_remove_addr(u32 token, u8 local_id);
-int pm_remove_subflow(u32 token, u8 remote_id);
-
-int pm_addr_signal(struct mptcp_sock *msk, u8 *id,
-		   struct sockaddr_storage *saddr);
-int pm_get_local_id(struct request_sock *req, struct sock *sk,
-		    const struct sk_buff *skb);
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
+
+int mptcp_pm_announce_addr(u32 token, u8 local_id, sa_family_t family,
+			   struct in_addr *addr);
+int mptcp_pm_create_subflow(u32 token, u8 remote_id, sa_family_t family,
+			    struct in_addr *addr);
+int mptcp_pm_remove_addr(u32 token, u8 local_id);
+int mptcp_pm_remove_subflow(u32 token, u8 remote_id);
+
+int mptcp_pm_addr_signal(struct mptcp_sock *msk, u8 *id,
+			 struct sockaddr_storage *saddr);
+int mptcp_pm_get_local_id(struct request_sock *req, struct sock *sk,
+			  const struct sk_buff *skb);
 =

 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 80d297ce11d2..8a542d4d6277 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -67,7 +67,7 @@ static bool subflow_token_join_request(struct request_soc=
k *req,
 		return false;
 	}
 =

-	if (pm_get_local_id(req, (struct sock *)msk, skb)) {
+	if (mptcp_pm_get_local_id(req, (struct sock *)msk, skb)) {
 		sock_put((struct sock *)msk);
 		return false;
 	}
-- =

2.17.2

--===============5408104528347020233==--
