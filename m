Content-Type: multipart/mixed; boundary="===============8557744504691638793=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/4] mptcp: refactor token container.
Date: Fri, 22 May 2020 12:10:11 +0200
Message-ID: <8a79b154b4619a376faac680c4043d724a68bf43.1590142022.git.pabeni@redhat.com>
In-Reply-To: cover.1590142022.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4454

--===============8557744504691638793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace the radix tree with an hash table allocated
at boot time. The radix tree has some short coming:
a single lock is contented by all the mptcp operation,
the lookup currently use such lock, and traversing
all the items would require lock, too.

With hash table instead we trade a little memory to
address all the above - a per bucket lock is used.

Additionally refactor the token creation to code to:

- limit the number of consecutive attempts to a fixed
maximum. Hitting an hash bucket with long chain is
considered a failed attempt

- accept() no longer can fail to to token management.

- if token creation fails at connect() time, we do
fallback to TCP (before the connection was closed)

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c |  16 +--
 net/mptcp/protocol.h |   5 +-
 net/mptcp/subflow.c  |  10 +-
 net/mptcp/token.c    | 246 ++++++++++++++++++++++++++++++-------------
 4 files changed, 184 insertions(+), 93 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 16ca39ae314a..09152cb80e05 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1424,19 +1424,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->token =3D subflow_req->token;
 	msk->subflow =3D NULL;
 =

-	if (unlikely(mptcp_token_new_accept(subflow_req->token, nsk))) {
-		nsk->sk_state =3D TCP_CLOSE;
-		bh_unlock_sock(nsk);
-
-		/* we can't call into mptcp_close() here - possible BH context
-		 * free the sock directly.
-		 * sk_clone_lock() sets nsk refcnt to two, hence call sk_free()
-		 * too.
-		 */
-		sk_common_release(nsk);
-		sk_free(nsk);
-		return NULL;
-	}
+	mptcp_token_accept(subflow_req, msk);
 =

 	msk->write_seq =3D subflow_req->idsn + 1;
 	atomic64_set(&msk->snd_una, msk->write_seq);
@@ -1654,7 +1642,6 @@ void mptcp_finish_connect(struct sock *ssk)
 	 */
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->local_key, subflow->local_key);
-	WRITE_ONCE(msk->token, subflow->token);
 	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
 	WRITE_ONCE(msk->ack_seq, ack_seq);
 	WRITE_ONCE(msk->can_ack, 1);
@@ -1738,6 +1725,7 @@ static struct proto mptcp_prot =3D {
 	.sysctl_wmem_offset	=3D offsetof(struct net, ipv4.sysctl_tcp_wmem),
 	.sysctl_mem	=3D sysctl_tcp_mem,
 	.obj_size	=3D sizeof(struct mptcp_sock),
+	.slab_flags	=3D SLAB_TYPESAFE_BY_RCU,
 	.no_autobind	=3D true,
 };
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 038c0237cca0..6f18ad2db7a1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -211,6 +211,7 @@ struct mptcp_sock {
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct hlist_nulls_node token_node;
 };
 =

 #define mptcp_for_each_subflow(__msk, __subflow)			\
@@ -255,6 +256,7 @@ struct mptcp_subflow_request_sock {
 	u64	thmac;
 	u32	local_nonce;
 	u32	remote_nonce;
+	struct hlist_nulls_node token_node;
 };
 =

 static inline struct mptcp_subflow_request_sock *
@@ -386,7 +388,8 @@ void __init mptcp_token_init(void);
 int mptcp_token_new_request(struct request_sock *req);
 void mptcp_token_destroy_request(u32 token);
 int mptcp_token_new_connect(struct sock *sk);
-int mptcp_token_new_accept(u32 token, struct sock *conn);
+void mptcp_token_accept(struct mptcp_subflow_request_sock *r,
+			struct mptcp_sock *msk);
 struct mptcp_sock *mptcp_token_get_sock(u32 token);
 void mptcp_token_destroy(u32 token);
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6f5b43afd5fd..88195510acf9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -31,11 +31,14 @@ static void SUBFLOW_REQ_INC_STATS(struct request_sock *=
req,
 static int subflow_rebuild_header(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-	int local_id, err =3D 0;
+	int local_id;
 =

 	if (subflow->request_mptcp && !subflow->token) {
 		pr_debug("subflow=3D%p", sk);
-		err =3D mptcp_token_new_connect(sk);
+		if (mptcp_token_new_connect(sk)) {
+			subflow->mp_capable =3D 0;
+			goto out;
+		}
 	} else if (subflow->request_join && !subflow->local_nonce) {
 		struct mptcp_sock *msk =3D (struct mptcp_sock *)subflow->conn;
 =

@@ -56,9 +59,6 @@ static int subflow_rebuild_header(struct sock *sk)
 	}
 =

 out:
-	if (err)
-		return err;
-
 	return subflow->icsk_af_ops->rebuild_header(sk);
 }
 =

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 33352dd99d4d..d4a4df3c7c42 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -24,7 +24,7 @@
 =

 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/radix-tree.h>
+#include <linux/memblock.h>
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <net/sock.h>
@@ -33,10 +33,53 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

-static RADIX_TREE(token_tree, GFP_ATOMIC);
-static RADIX_TREE(token_req_tree, GFP_ATOMIC);
-static DEFINE_SPINLOCK(token_tree_lock);
-static int token_used __read_mostly;
+#define TOKEN_MAX_RETRIES	4
+#define TOKEN_MAX_CHAIN_LEN	4
+
+struct token_bucket {
+	spinlock_t		lock;
+	int			chain_len;
+	struct hlist_nulls_head	req_chain;
+	struct hlist_nulls_head	msk_chain;
+};
+
+static struct token_bucket *token_hash __read_mostly;
+static unsigned int token_mask __read_mostly;
+
+static struct token_bucket *token_bucket(u32 token)
+{
+	return &token_hash[token & token_mask];
+}
+
+static struct mptcp_subflow_request_sock *
+__token_lookup_req(struct token_bucket *t, u32 token)
+{
+	struct mptcp_subflow_request_sock *req;
+	struct hlist_nulls_node *pos;
+
+	hlist_nulls_for_each_entry_rcu(req, pos, &t->req_chain, token_node)
+		if (req->token =3D=3D token)
+			return req;
+	return NULL;
+}
+
+static struct mptcp_sock *
+__token_lookup_msk(struct token_bucket *t, u32 token)
+{
+	struct hlist_nulls_node *pos;
+	struct mptcp_sock *msk;
+
+	hlist_nulls_for_each_entry_rcu(msk, pos, &t->msk_chain, token_node)
+		if (msk->token =3D=3D token)
+			return msk;
+	return NULL;
+}
+
+bool __token_bucket_busy(struct token_bucket *t, u32 token)
+{
+	return !token || t->chain_len >=3D TOKEN_MAX_CHAIN_LEN ||
+	       __token_lookup_req(t, token) || __token_lookup_msk(t, token);
+}
 =

 /**
  * mptcp_token_new_request - create new key/idsn/token for subflow_request
@@ -52,30 +95,32 @@ static int token_used __read_mostly;
 int mptcp_token_new_request(struct request_sock *req)
 {
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
-	int err;
-
-	while (1) {
-		u32 token;
-
-		mptcp_crypto_key_gen_sha(&subflow_req->local_key,
-					 &subflow_req->token,
-					 &subflow_req->idsn);
-		pr_debug("req=3D%p local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
-			 req, subflow_req->local_key, subflow_req->token,
-			 subflow_req->idsn);
-
-		token =3D subflow_req->token;
-		spin_lock_bh(&token_tree_lock);
-		if (!radix_tree_lookup(&token_req_tree, token) &&
-		    !radix_tree_lookup(&token_tree, token))
-			break;
-		spin_unlock_bh(&token_tree_lock);
+	int retries =3D TOKEN_MAX_RETRIES;
+	struct token_bucket *bucket;
+	u32 token;
+
+again:
+	mptcp_crypto_key_gen_sha(&subflow_req->local_key,
+				 &subflow_req->token,
+				 &subflow_req->idsn);
+	pr_debug("req=3D%p local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
+		 req, subflow_req->local_key, subflow_req->token,
+		 subflow_req->idsn);
+
+	token =3D subflow_req->token;
+	bucket =3D token_bucket(token);
+	spin_lock_bh(&bucket->lock);
+	if (__token_bucket_busy(bucket, token)) {
+		spin_unlock_bh(&bucket->lock);
+		if (!--retries)
+			return -EBUSY;
+		goto again;
 	}
 =

-	err =3D radix_tree_insert(&token_req_tree,
-				subflow_req->token, &token_used);
-	spin_unlock_bh(&token_tree_lock);
-	return err;
+	hlist_nulls_add_tail_rcu(&subflow_req->token_node, &bucket->req_chain);
+	bucket->chain_len++;
+	spin_unlock_bh(&bucket->lock);
+	return 0;
 }
 =

 /**
@@ -97,48 +142,54 @@ int mptcp_token_new_request(struct request_sock *req)
 int mptcp_token_new_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-	struct sock *mptcp_sock =3D subflow->conn;
-	int err;
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+	int retries =3D TOKEN_MAX_RETRIES;
+	struct token_bucket *bucket;
 =

-	while (1) {
-		u32 token;
+	pr_debug("ssk=3D%p, local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
+		 sk, subflow->local_key, subflow->token, subflow->idsn);
 =

-		mptcp_crypto_key_gen_sha(&subflow->local_key, &subflow->token,
-					 &subflow->idsn);
+again:
+	mptcp_crypto_key_gen_sha(&subflow->local_key, &subflow->token,
+				 &subflow->idsn);
 =

-		pr_debug("ssk=3D%p, local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
-			 sk, subflow->local_key, subflow->token, subflow->idsn);
-
-		token =3D subflow->token;
-		spin_lock_bh(&token_tree_lock);
-		if (!radix_tree_lookup(&token_req_tree, token) &&
-		    !radix_tree_lookup(&token_tree, token))
-			break;
-		spin_unlock_bh(&token_tree_lock);
+	bucket =3D token_bucket(subflow->token);
+	spin_lock_bh(&bucket->lock);
+	if (__token_bucket_busy(bucket, subflow->token)) {
+		spin_unlock_bh(&bucket->lock);
+		if (!--retries)
+			return -EBUSY;
+		goto again;
 	}
-	err =3D radix_tree_insert(&token_tree, subflow->token, mptcp_sock);
-	spin_unlock_bh(&token_tree_lock);
 =

-	return err;
+	WRITE_ONCE(msk->token, subflow->token);
+	hlist_nulls_add_tail_rcu(&msk->token_node, &bucket->msk_chain);
+	bucket->chain_len++;
+	spin_unlock_bh(&bucket->lock);
+	return 0;
 }
 =

 /**
- * mptcp_token_new_accept - insert token for later processing
- * @token: the token to insert to the tree
- * @conn: the just cloned socket linked to the new connection
+ * mptcp_token_accept - replace a req sk with full sock in token hash
+ * @req: the request socket to be removed
+ * @msk: the just cloned socket linked to the new connection
  *
  * Called when a SYN packet creates a new logical connection, i.e.
  * is not a join request.
  */
-int mptcp_token_new_accept(u32 token, struct sock *conn)
+void mptcp_token_accept(struct mptcp_subflow_request_sock *req,
+			struct mptcp_sock *msk)
 {
-	int err;
-
-	spin_lock_bh(&token_tree_lock);
-	err =3D radix_tree_insert(&token_tree, token, conn);
-	spin_unlock_bh(&token_tree_lock);
+	struct mptcp_subflow_request_sock *pos;
+	struct token_bucket *bucket;
 =

-	return err;
+	bucket =3D token_bucket(req->token);
+	spin_lock_bh(&bucket->lock);
+	pos =3D __token_lookup_req(bucket, req->token);
+	if (!WARN_ON_ONCE(pos !=3D req))
+		hlist_nulls_del_rcu(&req->token_node);
+	hlist_nulls_add_tail_rcu(&msk->token_node, &bucket->msk_chain);
+	spin_unlock_bh(&bucket->lock);
 }
 =

 /**
@@ -152,20 +203,33 @@ int mptcp_token_new_accept(u32 token, struct sock *co=
nn)
  */
 struct mptcp_sock *mptcp_token_get_sock(u32 token)
 {
-	struct sock *conn;
-
-	spin_lock_bh(&token_tree_lock);
-	conn =3D radix_tree_lookup(&token_tree, token);
-	if (conn) {
-		/* token still reserved? */
-		if (conn =3D=3D (struct sock *)&token_used)
-			conn =3D NULL;
-		else
-			sock_hold(conn);
+	struct hlist_nulls_node *pos;
+	struct token_bucket *bucket;
+	struct mptcp_sock *msk;
+
+	rcu_read_lock();
+	bucket =3D token_bucket(token);
+
+again:
+	hlist_nulls_for_each_entry_rcu(msk, pos, &bucket->msk_chain,
+				       token_node) {
+		if (READ_ONCE(msk->token) !=3D token)
+			continue;
+		if (!refcount_inc_not_zero(&((struct sock *)msk)->sk_refcnt))
+			goto not_found;
+		if (READ_ONCE(msk->token) !=3D token)
+			goto again;
+		goto found;
 	}
-	spin_unlock_bh(&token_tree_lock);
+	if (get_nulls_value(pos) !=3D (token & token_mask))
+		goto again;
 =

-	return mptcp_sk(conn);
+not_found:
+	msk =3D NULL;
+
+found:
+	rcu_read_unlock();
+	return msk;
 }
 =

 /**
@@ -177,9 +241,17 @@ struct mptcp_sock *mptcp_token_get_sock(u32 token)
  */
 void mptcp_token_destroy_request(u32 token)
 {
-	spin_lock_bh(&token_tree_lock);
-	radix_tree_delete(&token_req_tree, token);
-	spin_unlock_bh(&token_tree_lock);
+	struct mptcp_subflow_request_sock *pos;
+	struct token_bucket *bucket;
+
+	bucket =3D token_bucket(token);
+	spin_lock_bh(&bucket->lock);
+	pos =3D __token_lookup_req(bucket, token);
+	if (pos) {
+		hlist_nulls_del_rcu(&pos->token_node);
+		bucket->chain_len--;
+	}
+	spin_unlock_bh(&bucket->lock);
 }
 =

 /**
@@ -190,7 +262,35 @@ void mptcp_token_destroy_request(u32 token)
  */
 void mptcp_token_destroy(u32 token)
 {
-	spin_lock_bh(&token_tree_lock);
-	radix_tree_delete(&token_tree, token);
-	spin_unlock_bh(&token_tree_lock);
+	struct token_bucket *bucket;
+	struct mptcp_sock *pos;
+
+	bucket =3D token_bucket(token);
+	spin_lock_bh(&bucket->lock);
+	pos =3D __token_lookup_msk(bucket, token);
+	if (pos) {
+		hlist_nulls_del_rcu(&pos->token_node);
+		bucket->chain_len--;
+	}
+	spin_unlock_bh(&bucket->lock);
+}
+
+void __init mptcp_token_init(void)
+{
+	int i;
+
+	token_hash =3D alloc_large_system_hash("MPTCP token",
+					     sizeof(struct token_bucket),
+					     0,
+					     20,/* one slot per 1MB of memory */
+					     0,
+					     NULL,
+					     &token_mask,
+					     0,
+					     64 * 1024);
+	for (i =3D 0; i < token_mask + 1; ++i) {
+		INIT_HLIST_NULLS_HEAD(&token_hash[i].req_chain, i);
+		INIT_HLIST_NULLS_HEAD(&token_hash[i].msk_chain, i);
+		spin_lock_init(&token_hash[i].lock);
+	}
 }
-- =

2.21.3

--===============8557744504691638793==--
