Content-Type: multipart/mixed; boundary="===============5819240474772837368=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC v3 02/10] mptcp: token: move retry to caller
Date: Thu, 30 Jul 2020 02:12:33 +0200
Message-ID: <20200730001241.3037-3-fw@strlen.de>
In-Reply-To: 20200730001241.3037-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5374

--===============5819240474772837368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Once syncookie support is added, no state will be stored anymore when the
syn/ack is generated in syncookie mode.

When the ACK comes back, the generated key will be taken from the TCP ACK,
the token is re-generated and inserted into the token tree.

This means we can't retry with a new key when the token is already taken
in the syncookie case.

Therefore, move the retry logic to the caller to prepare for syncookie
support in mptcp.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c |  9 ++++++++-
 net/mptcp/token.c   | 12 ++++--------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1c8482bc2ce5..9feb87880d1c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -126,11 +126,18 @@ static void subflow_init_req(struct request_sock *req,
 	}
 =

 	if (mp_opt.mp_capable && listener->request_mptcp) {
-		int err;
+		int err, retries =3D 4;
+
+again:
+		do {
+			get_random_bytes(&subflow_req->local_key, sizeof(subflow_req->local_key=
));
+		} while (subflow_req->local_key =3D=3D 0);
 =

 		err =3D mptcp_token_new_request(req);
 		if (err =3D=3D 0)
 			subflow_req->mp_capable =3D 1;
+		else if (retries-- > 0)
+			goto again;
 =

 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 	} else if (mp_opt.mp_join && listener->request_mptcp) {
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 97cfc45bcc4f..f82410c54653 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -109,14 +109,12 @@ static void mptcp_crypto_key_gen_sha(u64 *key, u32 *t=
oken, u64 *idsn)
 int mptcp_token_new_request(struct request_sock *req)
 {
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
-	int retries =3D TOKEN_MAX_RETRIES;
 	struct token_bucket *bucket;
 	u32 token;
 =

-again:
-	mptcp_crypto_key_gen_sha(&subflow_req->local_key,
-				 &subflow_req->token,
-				 &subflow_req->idsn);
+	mptcp_crypto_key_sha(subflow_req->local_key,
+			     &subflow_req->token,
+			     &subflow_req->idsn);
 	pr_debug("req=3D%p local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
 		 req, subflow_req->local_key, subflow_req->token,
 		 subflow_req->idsn);
@@ -126,9 +124,7 @@ int mptcp_token_new_request(struct request_sock *req)
 	spin_lock_bh(&bucket->lock);
 	if (__token_bucket_busy(bucket, token)) {
 		spin_unlock_bh(&bucket->lock);
-		if (!--retries)
-			return -EBUSY;
-		goto again;
+		return -EBUSY;
 	}
 =

 	hlist_nulls_add_head_rcu(&subflow_req->token_node, &bucket->req_chain);
-- =

2.26.2

--===============5819240474772837368==--
