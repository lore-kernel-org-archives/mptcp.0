Content-Type: multipart/mixed; boundary="===============1994902554229863428=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v5 5/5] mptcp: v1 ADD_ADDR changes: use
 subflow_generate_hmac()
Date: Mon, 16 Mar 2020 11:39:11 -0700
Message-ID: <20200316183911.4347-6-peter.krystad@linux.intel.com>
In-Reply-To: 20200316183911.4347-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3963

--===============1994902554229863428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use subflow_generate_hmac() to create hmac from nonces.

squash-to: Add handling of outgoing MP_JOIN requests

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/subflow.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0da0e4605f0f..f3ea1d68e39b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -194,9 +194,9 @@ static bool subflow_thmac_valid(struct mptcp_subflow_co=
ntext *subflow)
 	u8 hmac[MPTCPOPT_HMAC_LEN];
 	u64 thmac;
 =

-	mptcp_crypto_hmac_sha(subflow->remote_key, subflow->local_key,
+	subflow_generate_hmac(subflow->remote_key, subflow->local_key,
 			      subflow->remote_nonce, subflow->local_nonce,
-			      (u32 *)hmac);
+			      hmac);
 =

 	thmac =3D get_unaligned_be64(hmac);
 	pr_debug("subflow=3D%p, token=3D%u, thmac=3D%llu, subflow->thmac=3D%llu\n=
",
@@ -235,10 +235,10 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 			goto do_reset;
 		}
 =

-		mptcp_crypto_hmac_sha(subflow->local_key, subflow->remote_key,
+		subflow_generate_hmac(subflow->local_key, subflow->remote_key,
 				      subflow->local_nonce,
 				      subflow->remote_nonce,
-				      (u32 *)subflow->hmac);
+				      subflow->hmac);
 =

 		if (skb)
 			subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
-- =

2.17.2

--===============1994902554229863428==--
