Content-Type: multipart/mixed; boundary="===============2029931856834594407=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 01/11] mptcp: move helper to where its used
Date: Tue, 14 Jul 2020 20:25:04 +0200
Message-ID: <20200714182514.25250-2-fw@strlen.de>
In-Reply-To: 20200714182514.25250-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4998

--===============2029931856834594407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only used in token.c.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.h | 11 -----------
 net/mptcp/token.c    | 12 ++++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 08198b61b8a6..cf74305c1d42 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -398,17 +398,6 @@ struct mptcp_sock *mptcp_token_iter_next(const struct =
net *net, long *s_slot,
 void mptcp_token_destroy(struct mptcp_sock *msk);
 =

 void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn);
-static inline void mptcp_crypto_key_gen_sha(u64 *key, u32 *token, u64 *ids=
n)
-{
-	/* we might consider a faster version that computes the key as a
-	 * hash of some information available in the MPTCP socket. Use
-	 * random data at the moment, as it's probably the safest option
-	 * in case multiple sockets are opened in different namespaces at
-	 * the same time.
-	 */
-	get_random_bytes(key, sizeof(u64));
-	mptcp_crypto_key_sha(*key, token, idsn);
-}
 =

 void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hma=
c);
 =

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index c0130e056c9a..97cfc45bcc4f 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -83,6 +83,18 @@ static bool __token_bucket_busy(struct token_bucket *t, =
u32 token)
 	       __token_lookup_req(t, token) || __token_lookup_msk(t, token);
 }
 =

+static void mptcp_crypto_key_gen_sha(u64 *key, u32 *token, u64 *idsn)
+{
+	/* we might consider a faster version that computes the key as a
+	 * hash of some information available in the MPTCP socket. Use
+	 * random data at the moment, as it's probably the safest option
+	 * in case multiple sockets are opened in different namespaces at
+	 * the same time.
+	 */
+	get_random_bytes(key, sizeof(u64));
+	mptcp_crypto_key_sha(*key, token, idsn);
+}
+
 /**
  * mptcp_token_new_request - create new key/idsn/token for subflow_request
  * @req: the request socket
-- =

2.26.2

--===============2029931856834594407==--
