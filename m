Content-Type: multipart/mixed; boundary="===============4227827536222301083=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 4/5] subflow: introduce and use
 mptcp_can_accept_new_subflow()
Date: Tue, 30 Jun 2020 13:12:07 +0200
Message-ID: <cae22fc12d266777c7d710197efd28b5afd17d5a.1593515429.git.pabeni@redhat.com>
In-Reply-To: cover.1593515429.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4868

--===============4227827536222301083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So that we can easily perform some basic PM-related
adimission checks before creating the child socket.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
Note: I initially used mptcp_can_accept_new_subflow() in
subflow_token_join_request(), too. The goal was add a follow-up
patch sending reset at rsk creation time in case of !can_accept
but I dismissed such patch because it feel "insecure"/potentially
dos prone send this early reset: an attacker could force an mptcp
server to send reset packets towards arbitrary IP/ports.

Additionally, after a quick look at mptcp.org, I could not find
trace of such early reset - looks like resets for bad MP_JOINs
are send only at syn_recv_sock() time.
---
 net/mptcp/subflow.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f3517d4f70f6..3077e07375b5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -53,6 +53,12 @@ static void subflow_generate_hmac(u64 key1, u64 key2, u3=
2 nonce1, u32 nonce2,
 	mptcp_crypto_hmac_sha(key1, key2, msg, 8, hmac);
 }
 =

+static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
+{
+	return inet_sk_state_load((struct sock *)msk) =3D=3D TCP_ESTABLISHED &&
+	       READ_ONCE(msk->pm.accept_subflow);
+}
+
 /* validate received token and create truncated hmac and nonce for SYN-ACK=
 */
 static struct mptcp_sock *subflow_token_join_request(struct request_sock *=
req,
 						     const struct sk_buff *skb)
@@ -425,6 +431,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
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

--===============4227827536222301083==--
