Content-Type: multipart/mixed; boundary="===============2607658772110117463=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/9] Re-factor and fixes for crypto_hmac_sha1()
Date: Wed, 17 Jul 2019 15:12:51 -0700
Message-ID: <20190717221256.7358-5-peter.krystad@linux.intel.com>
In-Reply-To: 20190717221256.7358-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1515

--===============2607658772110117463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Re-factor to use parameters specific to MPTCP use case similar to
crypto_key_sha1() and get rid of var args. Also fix endianness issues.

squash to: Add key generation and token tree
and: Add handling of incoming MP_JOIN requests

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/crypto.c   | 23 +++++++++--------------
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/token.c    | 19 ++++++++-----------
 3 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index 26a68aa1933a..7ab22b3de2d2 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -118,23 +118,23 @@ void crypto_key_sha1(u64 key, u32 *token, u64 *idsn)
 		*idsn =3D ((u64)mptcp_hashed_key[3] << 32) + mptcp_hashed_key[4];
 }
 =

-void crypto_hmac_sha1(u64 key1, u64 key2, u32 *hash_out,
-		      int arg_num, ...)
+void crypto_hmac_sha1(u64 key1, u64 key2, u32 nonce1, u32 nonce2, u32 *has=
h_out)
 {
 	u32 workspace[SHA_WORKSPACE_WORDS];
 	u8 input[128]; /* 2 512-bit blocks */
 	int i;
 	int index;
-	int length;
-	u8 *msg;
-	va_list list;
 	u8 key_1[8];
 	u8 key_2[8];
+	u8 nonce_1[4];
+	u8 nonce_2[4];
 =

 	memset(workspace, 0, sizeof(workspace));
 =

 	put_unaligned_be64(key1, key_1);
 	put_unaligned_be64(key2, key_2);
+	put_unaligned_be32(nonce1, nonce_1);
+	put_unaligned_be32(nonce2, nonce_2);
 =

 	/* Generate key xored with ipad */
 	memset(input, 0x36, 64);
@@ -143,16 +143,11 @@ void crypto_hmac_sha1(u64 key1, u64 key2, u32 *hash_o=
ut,
 	for (i =3D 0; i < 8; i++)
 		input[i + 8] ^=3D key_2[i];
 =

-	va_start(list, arg_num);
 	index =3D 64;
-	for (i =3D 0; i < arg_num; i++) {
-		length =3D va_arg(list, int);
-		msg =3D va_arg(list, u8 *);
-		WARN_ON(index + length > 125); /* Message is too long */
-		memcpy(&input[index], msg, length);
-		index +=3D length;
-	}
-	va_end(list);
+	memcpy(&input[index], nonce_1, 4);
+	index =3D 68;
+	memcpy(&input[index], nonce_2, 4);
+	index =3D 72;
 =

 	input[index] =3D 0x80; /* Padding: First bit after message =3D 1 */
 	memset(&input[index + 1], 0, (126 - index));
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9d6b10e5479c..ff4f38da9276 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -237,8 +237,8 @@ u32 crypto_v6_get_nonce(const struct in6_addr *saddr,
 			const struct in6_addr *daddr,
 			__be16 sport, __be16 dport);
 void crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
-void crypto_hmac_sha1(u64 key1, u64 key2, u32 *hash_out,
-		      int arg_num, ...);
+void crypto_hmac_sha1(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
+		      u32 *hash_out);
 =

 void pm_init(void);
 void pm_new_connection(struct mptcp_sock *msk, int server_side);
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index c2f4fcb37566..c9160f50f047 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -114,12 +114,11 @@ static void new_req_join(struct request_sock *req, st=
ruct sock *sk,
 	}
 	subflow_req->local_nonce =3D nonce;
 =

-	crypto_hmac_sha1(msk->local_key,
-			 msk->remote_key,
-			 (u32 *)hmac, 2,
-			 4, (u8 *)&subflow_req->local_nonce,
-			 4, (u8 *)&subflow_req->remote_nonce);
-	subflow_req->thmac =3D *(u64 *)hmac;
+	crypto_hmac_sha1(msk->local_key, msk->remote_key,
+			 subflow_req->local_nonce, subflow_req->remote_nonce,
+			 (u32 *)hmac);
+
+	subflow_req->thmac =3D get_unaligned_be64(hmac);
 	pr_debug("local_nonce=3D%u, thmac=3D%llu", subflow_req->local_nonce,
 		 subflow_req->thmac);
 }
@@ -131,11 +130,9 @@ static int new_join_valid(struct request_sock *req, st=
ruct sock *sk,
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	u8 hmac[MPTCPOPT_HMAC_LEN];
 =

-	crypto_hmac_sha1(msk->remote_key,
-			 msk->local_key,
-			 (u32 *)hmac, 2,
-			 4, (u8 *)&subflow_req->remote_nonce,
-			 4, (u8 *)&subflow_req->local_nonce);
+	crypto_hmac_sha1(msk->remote_key, msk->local_key,
+			 subflow_req->remote_nonce, subflow_req->local_nonce,
+			 (u32 *)hmac);
 =

 	return memcmp(hmac, (char *)rx_opt->mptcp.hmac, MPTCPOPT_HMAC_LEN);
 }
-- =

2.17.2


--===============2607658772110117463==--
