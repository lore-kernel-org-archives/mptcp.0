Content-Type: multipart/mixed; boundary="===============2696897038854773379=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 3/6] Squash-to: "mptcp: Add handling of incoming
 MP_JOIN requests"
Date: Tue, 11 Feb 2020 19:12:10 +0100
Message-ID: <46552a9e62de372e1c0b1e31201167cc9ea296bf.1581444137.git.pabeni@redhat.com>
In-Reply-To: cover.1581444137.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3614

--===============2696897038854773379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Update mptcp_pm_get_local_id() callers to new API.

Hook mptcp_pm_subflow_established() when MP_JOIN completes
successfully

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 7 +++++--
 net/mptcp/subflow.c | 5 ++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 43bfeb3fa753..c2e0576065b6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -128,7 +128,6 @@ void mptcp_parse_option(const struct sk_buff *skb, cons=
t unsigned char *ptr,
 		}
 		break;
 =

-
 	case MPTCPOPT_DSS:
 		pr_debug("DSS");
 		ptr++;
@@ -565,8 +564,12 @@ static bool check_fourth_ack(struct mptcp_subflow_cont=
ext *subflow,
 		   TCP_SKB_CB(skb)->seq !=3D subflow->ssn_offset + 1))
 		return true;
 =

-	if (mp_opt->use_ack)
+	if (mp_opt->use_ack) {
 		subflow->fourth_ack =3D 1;
+		if (subflow->mp_join)
+			mptcp_pm_subflow_established(mptcp_sk(subflow->conn),
+						     subflow);
+	}
 =

 	if (subflow->can_ack)
 		return true;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a8dedbd8d458..5710b439e418 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -55,6 +55,7 @@ static bool subflow_token_join_request(struct request_soc=
k *req,
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
 	u8 hmac[MPTCPOPT_HMAC_LEN];
 	struct mptcp_sock *msk;
+	int local_id;
 =

 	msk =3D mptcp_token_get_sock(subflow_req->token);
 	if (!msk) {
@@ -63,10 +64,12 @@ static bool subflow_token_join_request(struct request_s=
ock *req,
 		return false;
 	}
 =

-	if (mptcp_pm_get_local_id(req, (struct sock *)msk, skb)) {
+	local_id =3D mptcp_pm_get_local_id(msk, (struct sock_common *)req);
+	if (local_id < 0) {
 		sock_put((struct sock *)msk);
 		return false;
 	}
+	subflow_req->local_id =3D local_id;
 =

 	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
 =

-- =

2.21.1

--===============2696897038854773379==--
