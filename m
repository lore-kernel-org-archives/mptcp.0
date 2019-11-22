Content-Type: multipart/mixed; boundary="===============6001057498500445583=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/4] Squash-to: mptcp: Add handling of incoming
 MP_JOIN requests
Date: Fri, 22 Nov 2019 15:26:11 +0100
Message-ID: <11bde36283641c8fb307fc7834f7d5732ee72d84.1574432386.git.pabeni@redhat.com>
In-Reply-To: cover.1574432261.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2663

--===============6001057498500445583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 net/mptcp/subflow.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index eacb17a3e1d6..42d554d6dc06 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -70,9 +70,9 @@ static bool subflow_token_join_request(struct request_soc=
k *req,
 =

 	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
 =

-	mptcp_crypto_hmac_sha1(msk->local_key, msk->remote_key,
-			       subflow_req->local_nonce,
-			       subflow_req->remote_nonce, (u32 *)hmac);
+	mptcp_crypto_hmac_sha(msk->local_key, msk->remote_key,
+			      subflow_req->local_nonce,
+			      subflow_req->remote_nonce, (u32 *)hmac);
 =

 	subflow_req->thmac =3D get_unaligned_be64(hmac);
 =

@@ -238,9 +238,9 @@ static bool subflow_hmac_valid(const struct request_soc=
k *req,
 	if (!msk)
 		return false;
 =

-	mptcp_crypto_hmac_sha1(msk->remote_key, msk->local_key,
-			       subflow_req->remote_nonce,
-			       subflow_req->local_nonce, (u32 *)hmac);
+	mptcp_crypto_hmac_sha(msk->remote_key, msk->local_key,
+			      subflow_req->remote_nonce,
+			      subflow_req->local_nonce, (u32 *)hmac);
 =

 	ret =3D true;
 	if (crypto_memneq(hmac, rx_opt->mptcp.hmac, sizeof(hmac)))
-- =

2.21.0

--===============6001057498500445583==--
