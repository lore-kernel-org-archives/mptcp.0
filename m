Content-Type: multipart/mixed; boundary="===============2031540812205416399=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] mptcp: Minor changes to path manager interface
Date: Fri, 06 Sep 2019 18:30:01 -0700
Message-ID: <20190907013002.2759-2-peter.krystad@linux.intel.com>
In-Reply-To: 20190907013002.2759-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1795

--===============2031540812205416399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Needed preparations so interim path manager can be in it's own file

squashto: Add path manager interface

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/pm.c       | 31 +++++++++++++++++++++----------
 net/mptcp/protocol.c |  1 -
 net/mptcp/protocol.h |  9 ++++++++-
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index bc07376a823b..55b497a60230 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -10,7 +10,7 @@
 =

 /* path manager command handlers */
 =

-int pm_announce_addr(u32 token, sa_family_t family, u8 local_id,
+int pm_announce_addr(u32 token, u8 local_id, sa_family_t family,
 		     struct in_addr *addr)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(token_lookup_get(token));
@@ -50,7 +50,8 @@ int pm_remove_addr(u32 token, u8 local_id)
 	return 0;
 }
 =

-int pm_create_subflow(u32 token, u8 remote_id)
+int pm_create_subflow(u32 token, u8 remote_id, sa_family_t family,
+		      struct in_addr *addr)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(token_lookup_get(token));
 	struct sockaddr_in remote;
@@ -69,7 +70,10 @@ int pm_create_subflow(u32 token, u8 remote_id)
 =

 	local.sin_family =3D AF_INET;
 	local.sin_port =3D 0;
-	local.sin_addr.s_addr =3D INADDR_ANY;
+	if (family =3D=3D AF_INET)
+		local.sin_addr.s_addr =3D addr->s_addr;
+	else
+		local.sin_addr.s_addr =3D INADDR_ANY;
 =

 	remote.sin_family =3D msk->pm.remote_family;
 	remote.sin_port =3D htons(msk->dport);
@@ -91,16 +95,21 @@ int pm_remove_subflow(u32 token, u8 remote_id)
 =

 void pm_new_connection(struct mptcp_sock *msk, int server_side)
 {
-	pr_debug("msk=3D%p", msk);
+	struct mptcp_pm_data *pm =3D &msk->pm;
+
+	pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
 =

-	msk->pm.server_side =3D server_side;
+	pm->server_side =3D server_side;
+	pm->token =3D msk->token;
 }
 =

 void pm_fully_established(struct mptcp_sock *msk)
 {
+	struct mptcp_pm_data *pm =3D &msk->pm;
+
 	pr_debug("msk=3D%p", msk);
 =

-	msk->pm.fully_established =3D 1;
+	pm->fully_established =3D 1;
 }
 =

 void pm_connection_closed(struct mptcp_sock *msk)
@@ -120,12 +129,14 @@ void pm_subflow_closed(struct mptcp_sock *msk, u8 id)
 =

 void pm_add_addr(struct mptcp_sock *msk, const struct in_addr *addr, u8 id)
 {
+	struct mptcp_pm_data *pm =3D &msk->pm;
+
 	pr_debug("msk=3D%p, addr=3D%x, remote_id=3D%d", msk, addr->s_addr, id);
 =

-	msk->pm.remote_addr.s_addr =3D addr->s_addr;
-	msk->pm.remote_id =3D id;
-	msk->pm.remote_family =3D AF_INET;
-	msk->pm.remote_valid =3D 1;
+	pm->remote_addr.s_addr =3D addr->s_addr;
+	pm->remote_id =3D id;
+	pm->remote_family =3D AF_INET;
+	pm->remote_valid =3D 1;
 }
 =

 void pm_add_addr6(struct mptcp_sock *msk, const struct in6_addr *addr, u8 =
id)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3c678d52ae1e..06a1cea45efe 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1135,7 +1135,6 @@ void mptcp_proto_init(void)
 =

 	token_init();
 	subflow_init();
-	pm_init();
 =

 	if (proto_register(&mptcp_prot, 1) !=3D 0)
 		panic("Failed to register MPTCP proto.\n");
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 991ad288b892..e0c47d813a26 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -260,7 +260,6 @@ static inline void crypto_key_gen_sha1(u64 *key, u32 *t=
oken, u64 *idsn)
 void crypto_hmac_sha1(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 		      u32 *hash_out);
 =

-void pm_init(void);
 void pm_new_connection(struct mptcp_sock *msk, int server_side);
 void pm_fully_established(struct mptcp_sock *msk);
 void pm_connection_closed(struct mptcp_sock *msk);
@@ -269,6 +268,14 @@ void pm_subflow_closed(struct mptcp_sock *msk, u8 id);
 void pm_add_addr(struct mptcp_sock *msk, const struct in_addr *addr, u8 id=
);
 void pm_add_addr6(struct mptcp_sock *msk, const struct in6_addr *addr, u8 =
id);
 void pm_rm_addr(struct mptcp_sock *msk, u8 id);
+
+int pm_announce_addr(u32 token, u8 local_id, sa_family_t family,
+		     struct in_addr *addr);
+int pm_create_subflow(u32 token, u8 remote_id, sa_family_t family,
+		      struct in_addr *addr);
+int pm_remove_addr(u32 token, u8 local_id);
+int pm_remove_subflow(u32 token, u8 remote_id);
+
 int pm_addr_signal(struct mptcp_sock *msk, u8 *id,
 		   struct sockaddr_storage *saddr);
 int pm_get_local_id(struct request_sock *req, struct sock *sk,
-- =

2.17.2


--===============2031540812205416399==--
