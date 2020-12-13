Content-Type: multipart/mixed; boundary="===============1047823727550005970=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v8 mptcp-next 2/8] mptcp: add port number check
 for MP_JOIN
Date: Sun, 13 Dec 2020 09:52:04 +0800
Message-ID: <6fe8a4f118716ea43fedad741cc129292027fdbe.1607823272.git.geliangtang@gmail.com>
In-Reply-To: 81bbbc826edf123d47abfa74dbaf9e0674689cf2.1607823272.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7155

--===============1047823727550005970==
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
index c64a1c41a29b..398554590bf1 100644
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
 /* Init mptcp request socket.
  *
  * Returns an error code if a JOIN has failed and a TCP reset
@@ -184,6 +189,12 @@ static int subflow_init_req(struct request_sock *req,
 		if (!subflow_req->msk)
 			return -EPERM;
 =

+		if (subflow_use_different_sport(subflow_req->msk, sk_listener)) {
+			pr_debug("syn inet_sport=3D%d %d",
+				 ntohs(inet_sk(sk_listener)->inet_sport),
+				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
+		}
+
 		if (unlikely(req->syncookie)) {
 			if (mptcp_can_accept_new_subflow(subflow_req->msk))
 				subflow_init_req_cookie_join_save(subflow_req, skb);
@@ -326,6 +337,11 @@ void mptcp_subflow_reset(struct sock *ssk)
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
@@ -391,6 +407,12 @@ static void subflow_finish_connect(struct sock *sk, co=
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
@@ -653,6 +675,12 @@ static struct sock *subflow_syn_recv_sock(const struct=
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

2.29.2

--===============1047823727550005970==--
