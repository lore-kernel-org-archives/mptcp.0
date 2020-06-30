Content-Type: multipart/mixed; boundary="===============3376388420647162517=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 1/5] mptcp: cleanup subflow_finish_connect()
Date: Tue, 30 Jun 2020 13:12:04 +0200
Message-ID: <5fa37db8782dce940699e7b2d0f85733be868a96.1593515429.git.pabeni@redhat.com>
In-Reply-To: cover.1593515429.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4864

--===============3376388420647162517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mentioned function has several unneeded branches,
handle each case - MP_CAPABLE, MP_JOIN, fallback -
under a single conditional and drop quite a bit of
duplicate code.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 46 +++++++++++++++++----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0f0fa1ba57a8..30e907690bc5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -211,38 +211,17 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 		subflow->remote_key =3D mp_opt.sndr_key;
 		pr_debug("subflow=3D%p, remote_key=3D%llu", subflow,
 			 subflow->remote_key);
+		mptcp_finish_connect(sk);
 	} else if (subflow->request_join && mp_opt.mp_join) {
-		subflow->mp_join =3D 1;
+		u8 hmac[SHA256_DIGEST_SIZE];
+
 		subflow->thmac =3D mp_opt.thmac;
 		subflow->remote_nonce =3D mp_opt.nonce;
 		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u", subflow,
 			 subflow->thmac, subflow->remote_nonce);
-	} else {
-		if (subflow->request_mptcp)
-			MPTCP_INC_STATS(sock_net(sk),
-					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
-		mptcp_do_fallback(sk);
-		pr_fallback(mptcp_sk(subflow->conn));
-	}
-
-	if (mptcp_check_fallback(sk)) {
-		mptcp_rcv_space_init(mptcp_sk(parent), sk);
-		return;
-	}
-
-	if (subflow->mp_capable) {
-		pr_debug("subflow=3D%p, remote_key=3D%llu", mptcp_subflow_ctx(sk),
-			 subflow->remote_key);
-		mptcp_finish_connect(sk);
-	} else if (subflow->mp_join) {
-		u8 hmac[SHA256_DIGEST_SIZE];
 =

-		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u",
-			 subflow, subflow->thmac,
-			 subflow->remote_nonce);
 		if (!subflow_thmac_valid(subflow)) {
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINACKMAC);
-			subflow->mp_join =3D 0;
 			goto do_reset;
 		}
 =

@@ -250,18 +229,27 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 				      subflow->local_nonce,
 				      subflow->remote_nonce,
 				      hmac);
-
 		memcpy(subflow->hmac, hmac, MPTCPOPT_HMAC_LEN);
 =

 		if (!mptcp_finish_join(sk))
 			goto do_reset;
 =

+		subflow->mp_join =3D 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
-	} else {
-do_reset:
-		tcp_send_active_reset(sk, GFP_ATOMIC);
-		tcp_done(sk);
+	} else if (subflow->request_mptcp) {
+		MPTCP_INC_STATS(sock_net(sk),
+				MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
+		mptcp_do_fallback(sk);
+		pr_fallback(mptcp_sk(subflow->conn));
 	}
+
+	if (mptcp_check_fallback(sk))
+		mptcp_rcv_space_init(mptcp_sk(parent), sk);
+	return;
+
+do_reset:
+	tcp_send_active_reset(sk, GFP_ATOMIC);
+	tcp_done(sk);
 }
 =

 static struct request_sock_ops subflow_request_sock_ops;
-- =

2.26.2

--===============3376388420647162517==--
