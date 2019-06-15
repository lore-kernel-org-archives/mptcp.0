Content-Type: multipart/mixed; boundary="===============8811299922073349115=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 6/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:49 +0200
Message-ID: <20190615105259.15151-7-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1391

--===============8811299922073349115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - networking block comments don't use an empty /* line, use /*
   Comment... (2)
 - Alignment should match open parenthesis (2)
 - Comparison to NULL could be written "X" (6)
 - Unnecessary parentheses around 'X' (2)

What has not been fixed:

 - added, moved or deleted file(s), does MAINTAINERS need updating?
   > TBD later

Fixes: 06e0adad6f4e (mptcp: Add key generation and token tree)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/crypto.c   |  3 +--
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/token.c    | 15 +++++++--------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index 2dc453d1d5ab..26a68aa1933a 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Multipath TCP cryptographic functions
+/* Multipath TCP cryptographic functions
  * Copyright (c) 2017 - 2019, Intel Corporation.
  *
  * Note: This code is based on mptcp_ctrl.c, mptcp_ipv4.c, and
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4da5a0f08c01..fe3408258468 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -111,7 +111,7 @@ void crypto_init(void);
 u32 crypto_v4_get_nonce(__be32 saddr, __be32 daddr,
 			__be16 sport, __be16 dport);
 u64 crypto_v4_get_key(__be32 saddr, __be32 daddr,
-			__be16 sport, __be16 dport);
+		      __be16 sport, __be16 dport);
 u64 crypto_v6_get_key(const struct in6_addr *saddr,
 		      const struct in6_addr *daddr,
 		      __be16 sport, __be16 dport);
@@ -120,6 +120,6 @@ u32 crypto_v6_get_nonce(const struct in6_addr *saddr,
 			__be16 sport, __be16 dport);
 void crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
 void crypto_hmac_sha1(u64 key1, u64 key2, u32 *hash_out,
-		     int arg_num, ...);
+		      int arg_num, ...);
 =

 #endif /* __MPTCP_PROTOCOL_H */
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index fbd8e6373fe5..8c15b8134f70 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Multipath TCP token management
+/* Multipath TCP token management
  * Copyright (c) 2017 - 2019, Intel Corporation.
  *
  * Note: This code is based on mptcp_ctrl.c from multipath-tcp.org,
@@ -43,7 +42,7 @@ static bool find_req_token(u32 token)
 =

 	pr_debug("token=3D%u", token);
 	used =3D radix_tree_lookup(&token_req_tree, token);
-	return (used !=3D NULL);
+	return used;
 }
 =

 static bool find_token(u32 token)
@@ -52,7 +51,7 @@ static bool find_token(u32 token)
 =

 	pr_debug("token=3D%u", token);
 	used =3D radix_tree_lookup(&token_tree, token);
-	return (used !=3D NULL);
+	return used;
 }
 =

 static void new_req_token(struct request_sock *req,
@@ -116,7 +115,7 @@ static int insert_token(u32 token, void *conn)
 {
 	void *used =3D &token_used;
 =

-	if (conn !=3D NULL)
+	if (conn)
 		used =3D conn;
 =

 	pr_debug("token=3D%u, conn=3D%p", token, used);
@@ -129,7 +128,7 @@ static void update_token(u32 token, void *conn)
 =

 	pr_debug("token=3D%u, conn=3D%p", token, conn);
 	slot =3D radix_tree_lookup_slot(&token_tree, token);
-	if (slot !=3D NULL) {
+	if (slot) {
 		if (*slot !=3D &token_used)
 			pr_err("slot ALREADY updated!");
 		*slot =3D conn;
@@ -153,7 +152,7 @@ static struct sock *destroy_token(u32 token)
 =

 	pr_debug("token=3D%u", token);
 	conn =3D radix_tree_delete(&token_tree, token);
-	if ((conn !=3D NULL) && (conn !=3D &token_used))
+	if (conn && conn !=3D &token_used)
 		return (struct sock *)conn;
 	return NULL;
 }
@@ -236,7 +235,7 @@ void token_destroy(u32 token)
 	pr_debug("token=3D%u", token);
 	spin_lock_bh(&token_tree_lock);
 	conn =3D destroy_token(token);
-	if (conn !=3D NULL)
+	if (conn)
 		sock_put(conn);
 	spin_unlock_bh(&token_tree_lock);
 }
-- =

2.20.1


--===============8811299922073349115==--
