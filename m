Content-Type: multipart/mixed; boundary="===============3705571134543229503=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v2 15/19] mptcp: More efficient byte order handling
Date: Tue, 05 Jun 2018 16:40:34 -0700
Message-ID: <20180605234038.28497-16-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180605234038.28497-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 658

--===============3705571134543229503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

crypto_key_sha1() was reordering bytes in words that were discarded, and
the initial data sequence number (IDSN) was returned in a way that
required additional byte swapping. Now only the token is returned with
its bytes swapped, and the IDSN is returned in host order so it is ready
for comparison and addition.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/crypto.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index 0ba35449c4a0..8f575974dfce 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -106,7 +106,6 @@ void crypto_key_sha1(u64 key, u32 *token, u64 *idsn)
 	u32 workspace[SHA_WORKSPACE_WORDS];
 	u32 mptcp_hashed_key[SHA_DIGEST_WORDS];
 	u8 input[64];
-	int i;
 =

 	memset(workspace, 0, sizeof(workspace));
 =

@@ -121,13 +120,10 @@ void crypto_key_sha1(u64 key, u32 *token, u64 *idsn)
 	sha_init(mptcp_hashed_key);
 	sha_transform(mptcp_hashed_key, input, workspace);
 =

-	for (i =3D 0; i < 5; i++)
-		mptcp_hashed_key[i] =3D cpu_to_be32(mptcp_hashed_key[i]);
-
 	if (token)
-		*token =3D mptcp_hashed_key[0];
+		*token =3D htonl(mptcp_hashed_key[0]);
 	if (idsn)
-		*idsn =3D *((u64 *)&mptcp_hashed_key[3]);
+		*idsn =3D ((u64)mptcp_hashed_key[3] << 32) + mptcp_hashed_key[4];
 }
 =

 void crypto_hmac_sha1(const u8 *key_1, const u8 *key_2, u32 *hash_out,
-- =

2.17.1


--===============3705571134543229503==--
