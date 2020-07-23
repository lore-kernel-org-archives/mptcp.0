Content-Type: multipart/mixed; boundary="===============6106785364278803607=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 8/8] subflow: introduce and use
 mptcp_can_accept_new_subflow()
Date: Thu, 23 Jul 2020 13:02:36 +0200
Message-ID: <f917ce96fa7c3ff623378a01ae8fb52d4ac1884f.1595431326.git.pabeni@redhat.com>
In-Reply-To: cover.1595431326.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5239

--===============6106785364278803607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So that we can easily perform some basic PM-related
adimission checks before creating the child socket.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Tested-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ada04df6f99f..e645483d1200 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -53,6 +53,12 @@ static void subflow_generate_hmac(u64 key1, u64 key2, u3=
2 nonce1, u32 nonce2,
 	mptcp_crypto_hmac_sha(key1, key2, msg, 8, hmac);
 }
 =

+static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
+{
+	return mptcp_is_fully_established((void *)msk) &&
+	       READ_ONCE(msk->pm.accept_subflow);
+}
+
 /* validate received token and create truncated hmac and nonce for SYN-ACK=
 */
 static struct mptcp_sock *subflow_token_join_request(struct request_sock *=
req,
 						     const struct sk_buff *skb)
@@ -443,6 +449,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
 		if (!mp_opt.mp_join ||
+		    !mptcp_can_accept_new_subflow(subflow_req->msk) ||
 		    !subflow_hmac_valid(req, &mp_opt)) {
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
 			fallback =3D true;
-- =

2.26.2

--===============6106785364278803607==--
