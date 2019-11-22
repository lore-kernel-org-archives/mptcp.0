Content-Type: multipart/mixed; boundary="===============7886666014558388598=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/4] Squash-to: "mptcp: Add handling of outgoing
 MP_JOIN requests"
Date: Fri, 22 Nov 2019 15:26:12 +0100
Message-ID: <5759ff6817f90071ee9826041053fc723466d5e0.1574432392.git.pabeni@redhat.com>
In-Reply-To: cover.1574432261.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2662

--===============7886666014558388598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 net/mptcp/subflow.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ccc22e6b1f3f..d8ce3c0be6d2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -172,9 +172,9 @@ static bool subflow_thmac_valid(struct mptcp_subflow_co=
ntext *subflow)
 	u8 hmac[MPTCPOPT_HMAC_LEN];
 	u64 thmac;
 =

-	mptcp_crypto_hmac_sha1(subflow->remote_key, subflow->local_key,
-			       subflow->remote_nonce, subflow->local_nonce,
-			       (u32 *)hmac);
+	mptcp_crypto_hmac_sha(subflow->remote_key, subflow->local_key,
+			      subflow->remote_nonce, subflow->local_nonce,
+			      (u32 *)hmac);
 =

 	thmac =3D get_unaligned_be64(hmac);
 	pr_debug("subflow=3D%p, token=3D%u, thmac=3D%llu, subflow->thmac=3D%llu\n=
",
@@ -214,10 +214,10 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 			return;
 		}
 =

-		mptcp_crypto_hmac_sha1(subflow->local_key, subflow->remote_key,
-				       subflow->local_nonce,
-				       subflow->remote_nonce,
-				       (u32 *)subflow->hmac);
+		mptcp_crypto_hmac_sha(subflow->local_key, subflow->remote_key,
+				      subflow->local_nonce,
+				      subflow->remote_nonce,
+				      (u32 *)subflow->hmac);
 =

 		mptcp_finish_join(sk);
 		subflow->conn_finished =3D 1;
@@ -697,7 +697,7 @@ int mptcp_subflow_connect(struct sock *sk, struct socka=
ddr *local,
 	if (err)
 		goto failed;
 =

-	mptcp_crypto_key_sha1(subflow->remote_key, &remote_token, NULL);
+	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
 	pr_debug("msk=3D%p remote_token=3D%u", msk, remote_token);
 	subflow->remote_token =3D remote_token;
 	subflow->remote_id =3D remote_id;
-- =

2.21.0

--===============7886666014558388598==--
