Content-Type: multipart/mixed; boundary="===============9130730650868277347=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 5/8] mptcp: cleanup subflow_finish_connect()
Date: Thu, 23 Jul 2020 13:02:33 +0200
Message-ID: <d42c2e757008d4b404d82c918d3b6ae56cfa2a0f.1595431326.git.pabeni@redhat.com>
In-Reply-To: cover.1595431326.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5236

--===============9130730650868277347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mentioned function has several unneeded branches,
handle each case - MP_CAPABLE, MP_JOIN, fallback -
under a single conditional and drop quite a bit of
duplicate code.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Tested-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 56 ++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ea81842fc3b2..7f3ef1840df5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -206,44 +206,34 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 	pr_debug("subflow=3D%p synack seq=3D%x", subflow, subflow->ssn_offset);
 =

 	mptcp_get_options(skb, &mp_opt);
-	if (subflow->request_mptcp && mp_opt.mp_capable) {
+	if (subflow->request_mptcp) {
+		if (!mp_opt.mp_capable) {
+			MPTCP_INC_STATS(sock_net(sk),
+					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
+			mptcp_do_fallback(sk);
+			pr_fallback(mptcp_sk(subflow->conn));
+			goto fallback;
+		}
+
 		subflow->mp_capable =3D 1;
 		subflow->can_ack =3D 1;
 		subflow->remote_key =3D mp_opt.sndr_key;
 		pr_debug("subflow=3D%p, remote_key=3D%llu", subflow,
 			 subflow->remote_key);
-	} else if (subflow->request_join && mp_opt.mp_join) {
-		subflow->mp_join =3D 1;
+		mptcp_finish_connect(sk);
+	} else if (subflow->request_join) {
+		u8 hmac[SHA256_DIGEST_SIZE];
+
+		if (!mp_opt.mp_join)
+			goto do_reset;
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
 =

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
-
-		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u",
-			 subflow, subflow->thmac,
-			 subflow->remote_nonce);
 		if (!subflow_thmac_valid(subflow)) {
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINACKMAC);
-			subflow->mp_join =3D 0;
 			goto do_reset;
 		}
 =

@@ -251,18 +241,22 @@ static void subflow_finish_connect(struct sock *sk, c=
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
+	} else if (mptcp_check_fallback(sk)) {
+fallback:
+		mptcp_rcv_space_init(mptcp_sk(parent), sk);
 	}
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

--===============9130730650868277347==--
