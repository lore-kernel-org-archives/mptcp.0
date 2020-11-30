Content-Type: multipart/mixed; boundary="===============6548623307839197808=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 2/7] mptcp: add port number check
 for MP_JOIN
Date: Mon, 30 Nov 2020 14:17:50 +0800
Message-ID: <86984323249f08d04d6bff717afbdc94f314e291.1606716547.git.geliangtang@gmail.com>
In-Reply-To: 9bfd982aa08d39d84846b7fa655230dc11e91f1c.1606716547.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6973

--===============6548623307839197808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added two new helpers, subflow_use_different_sport and
subflow_use_different_dport, to check whether the subflow's source or
destination port number is different from the msk's port number. When
we received the MP_JOIN's SYN/SYNACK/ACK, we do these port number
checks and print out the different port numbers.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/subflow.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 43cc5e2c3234..89fe7c1744d5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -112,6 +112,11 @@ static int __subflow_init_req(struct request_sock *req=
, const struct sock *sk_li
 	return 0;
 }
 =

+static bool subflow_use_different_sport(struct mptcp_sock *msk, const stru=
ct sock *sk)
+{
+	return inet_sk(sk)->inet_sport !=3D inet_sk((struct sock *)msk)->inet_spo=
rt;
+}
+
 static void subflow_init_req(struct request_sock *req,
 			     const struct sock *sk_listener,
 			     struct sk_buff *skb)
@@ -175,6 +180,12 @@ static void subflow_init_req(struct request_sock *req,
 		subflow_req->remote_nonce =3D mp_opt.nonce;
 		subflow_req->msk =3D subflow_token_join_request(req, skb);
 =

+		if (subflow_use_different_sport(subflow_req->msk, sk_listener)) {
+			pr_debug("syn inet_sport=3D%d %d",
+				 ntohs(inet_sk(sk_listener)->inet_sport),
+				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
+		}
+
 		if (unlikely(req->syncookie) && subflow_req->msk) {
 			if (mptcp_can_accept_new_subflow(subflow_req->msk))
 				subflow_init_req_cookie_join_save(subflow_req, skb);
@@ -289,6 +300,11 @@ void mptcp_subflow_reset(struct sock *ssk)
 	sock_put(sk);
 }
 =

+static bool subflow_use_different_dport(struct mptcp_sock *msk, const stru=
ct sock *sk)
+{
+	return inet_sk(sk)->inet_dport !=3D inet_sk((struct sock *)msk)->inet_dpo=
rt;
+}
+
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *=
skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
@@ -354,6 +370,12 @@ static void subflow_finish_connect(struct sock *sk, co=
nst struct sk_buff *skb)
 =

 		subflow->mp_join =3D 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
+
+		if (subflow_use_different_dport(mptcp_sk(parent), sk)) {
+			pr_debug("synack inet_dport=3D%d %d",
+				 ntohs(inet_sk(sk)->inet_dport),
+				 ntohs(inet_sk(parent)->inet_dport));
+		}
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
 		mptcp_rcv_space_init(mptcp_sk(parent), sk);
@@ -615,6 +637,12 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 =

 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
 			tcp_rsk(req)->drop_req =3D true;
+
+			if (subflow_use_different_sport(owner, sk)) {
+				pr_debug("ack inet_sport=3D%d %d",
+					 ntohs(inet_sk(sk)->inet_sport),
+					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
+			}
 		}
 	}
 =

-- =

2.26.2

--===============6548623307839197808==--
