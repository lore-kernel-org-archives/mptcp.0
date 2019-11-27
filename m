Content-Type: multipart/mixed; boundary="===============6109953862171727680=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH MPTCP] init ssn_offset for incoming/outgoing join
 requests
Date: Wed, 27 Nov 2019 13:18:46 +0100
Message-ID: <20191127121846.19741-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2700

--===============6109953862171727680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: mptcp: Add handling of outgoing MP_JOIN requests

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ba46c0b3a6d7..45ceb9a955a8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -139,6 +139,7 @@ static void subflow_init_req(struct request_sock *req,
 		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 	} else if (rx_opt.mptcp.mp_join && listener->request_mptcp) {
+		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 		subflow_req->mp_join =3D 1;
 		subflow_req->backup =3D rx_opt.mptcp.backup;
 		subflow_req->remote_id =3D rx_opt.mptcp.join_id;
@@ -231,6 +232,8 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 				      subflow->remote_nonce,
 				      (u32 *)subflow->hmac);
 =

+		if (skb)
+			subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 		mptcp_finish_join(sk);
 		subflow->conn_finished =3D 1;
 	}
@@ -885,6 +888,7 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 		new_ctx->ssn_offset =3D subflow_req->ssn_offset;
 		new_ctx->idsn =3D subflow_req->idsn;
 	} else if (subflow_req->mp_join) {
+		new_ctx->ssn_offset =3D subflow_req->ssn_offset;
 		new_ctx->mp_join =3D 1;
 		new_ctx->fourth_ack =3D 1;
 		new_ctx->backup =3D subflow_req->backup;
-- =

2.23.0

--===============6109953862171727680==--
