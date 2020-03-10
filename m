Content-Type: multipart/mixed; boundary="===============3455386792112035413=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 5/5] mptcp: v1 ADD_ADDR changes: use
 subflow_generate_hmac()
Date: Tue, 10 Mar 2020 15:33:32 -0700
Message-ID: <20200310223332.3845-6-peter.krystad@linux.intel.com>
In-Reply-To: 20200310223332.3845-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3910

--===============3455386792112035413==
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
index a857ea8cf6ad..728367db6901 100644
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
@@ -238,10 +238,10 @@ static void subflow_finish_connect(struct sock *sk, c=
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

--===============3455386792112035413==--
