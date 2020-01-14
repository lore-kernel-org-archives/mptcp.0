Content-Type: multipart/mixed; boundary="===============7171871226997515902=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Handle subflow join failures
Date: Tue, 14 Jan 2020 14:57:05 +0100
Message-ID: <20200114135705.4019-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3352

--===============7171871226997515902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: mptcp: Add handling of outgoing MP_JOIN requests

When the join request fails we should send a reset and also
close the socket, we can't do anything useful with such a
connection.

Signed-off-by: Florian Westphal <fw(a)strlen.de>

---
 net/mptcp/subflow.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f69a75f6bd6e..03f4604e2cb7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -187,10 +187,13 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 =

 	subflow->icsk_af_ops->sk_rx_dst_set(sk, skb);
 =

-	if (!subflow->conn)
+	if (subflow->conn_finished || !tcp_sk(sk)->is_mptcp)
 		return;
 =

-	if (subflow->mp_capable && !subflow->conn_finished) {
+	if (!subflow->conn)
+		goto do_reset;
+
+	if (subflow->mp_capable) {
 		pr_debug("subflow=3D%p, remote_key=3D%llu", mptcp_subflow_ctx(sk),
 			 subflow->remote_key);
 		mptcp_finish_connect(sk);
@@ -200,14 +203,13 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 			pr_debug("synack seq=3D%u", TCP_SKB_CB(skb)->seq);
 			subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 		}
-	} else if (subflow->mp_join && !subflow->conn_finished) {
+	} else if (subflow->mp_join) {
 		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u",
 			 subflow, subflow->thmac,
 			 subflow->remote_nonce);
 		if (!subflow_thmac_valid(subflow)) {
 			subflow->mp_join =3D 0;
-			// @@ need to trigger RST
-			return;
+			goto do_reset;
 		}
 =

 		mptcp_crypto_hmac_sha(subflow->local_key, subflow->remote_key,
@@ -218,8 +220,14 @@ static void subflow_finish_connect(struct sock *sk, co=
nst struct sk_buff *skb)
 		if (skb)
 			subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 =

-		if (mptcp_finish_join(sk))
-			subflow->conn_finished =3D 1;
+		if (!mptcp_finish_join(sk))
+			goto do_reset;
+
+		subflow->conn_finished =3D 1;
+	} else {
+do_reset:
+		tcp_send_active_reset(sk, GFP_ATOMIC);
+		tcp_done(sk);
 	}
 }
 =

-- =

2.24.1

--===============7171871226997515902==--
