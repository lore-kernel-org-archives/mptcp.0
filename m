Content-Type: multipart/mixed; boundary="===============2940388287131137126=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/2] mptcp: increment MIB counters in a few places
Date: Mon, 30 Sep 2019 16:51:58 +0200
Message-ID: <20190930145158.5331-3-fw@strlen.de>
In-Reply-To: 20190930145158.5331-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1966

--===============2940388287131137126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add initial use of the new MIB counters.
We can extend this later on as more features get added.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 13 ++++++++++++-
 net/mptcp/subflow.c  | 21 +++++++++++++++++----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 093c7dac997c..9858c9bdf644 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -491,6 +491,7 @@ static enum mapping_status mptcp_get_mapping(struct soc=
k *ssk)
 =

 	if (mpext->data_len =3D=3D 0) {
 		pr_err("Infinite mapping not handled");
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		ret =3D MAPPING_MISSING;
 		goto del_out;
 	} else if (mpext->subflow_seq =3D=3D 0 &&
@@ -514,8 +515,10 @@ static enum mapping_status mptcp_get_mapping(struct so=
ck *ssk)
 		 */
 		if (subflow->map_seq !=3D map_seq ||
 		    subflow->map_subflow_seq !=3D mpext->subflow_seq ||
-		    subflow->map_data_len !=3D mpext->data_len)
+		    subflow->map_data_len !=3D mpext->data_len) {
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSNOMATCH);
 			pr_warn("Replaced mapping before it was done");
+		}
 	}
 =

 	subflow->map_seq =3D map_seq;
@@ -822,6 +825,7 @@ static void mptcp_retransmit(struct work_struct *work)
 		if (ret < 0)
 			break;
 =

+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
 		copied +=3D ret;
 		dfrag->data_len -=3D ret;
 	}
@@ -1002,7 +1006,10 @@ static struct sock *mptcp_accept(struct sock *sk, in=
t flags, int *err,
 		subflow->conn =3D new_mptcp_sock;
 		list_add(&subflow->node, &msk->conn_list);
 		bh_unlock_sock(new_mptcp_sock);
+
+		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
 		local_bh_enable();
+
 		inet_sk_state_store(newsk, TCP_ESTABLISHED);
 		release_sock(sk);
 	} else {
@@ -1010,6 +1017,8 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 		tcp_sk(newsk)->is_mptcp =3D 0;
 		new_sock->sk =3D NULL;
 		sock_release(new_sock);
+
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	}
 =

 	return newsk;
@@ -1158,6 +1167,8 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
able)
 		msk->subflow =3D NULL;
 		bh_unlock_sock(sk);
 		local_bh_enable();
+	} else {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
 	}
 	inet_sk_state_store(sk, TCP_ESTABLISHED);
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c86ce35580cd..c63ddd899acb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -17,6 +17,13 @@
 #include <net/tcp.h>
 #include <net/mptcp.h>
 #include "protocol.h"
+#include "mib.h"
+
+static inline void SUBFLOW_REQ_INC_STATS(struct request_sock *req,
+					 enum linux_mptcp_mib_field field)
+{
+	MPTCP_INC_STATS(sock_net(req_to_sk(req)), field);
+}
 =

 static int subflow_rebuild_header(struct sock *sk)
 {
@@ -62,8 +69,7 @@ static bool subflow_token_join_request(struct request_soc=
k *req,
 =

 	msk =3D mptcp_token_get_sock(subflow_req->token);
 	if (!msk) {
-		pr_debug("subflow_req=3D%p, token=3D%u - not found\n",
-			 subflow_req, subflow_req->token);
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINNOTOKEN);
 		return false;
 	}
 =

@@ -103,8 +109,14 @@ static void subflow_v4_init_req(struct request_sock *r=
eq,
 	subflow_req->mp_capable =3D 0;
 	subflow_req->mp_join =3D 0;
 =

-	if (rx_opt.mptcp.mp_capable && rx_opt.mptcp.mp_join)
-		return;
+	if (rx_opt.mptcp.mp_capable) {
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
+
+		if (rx_opt.mptcp.mp_join)
+			return;
+	} else if (rx_opt.mptcp.mp_join) {
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
+	}
 =

 	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
 		int err;
@@ -180,6 +192,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 			 subflow_ctx(sk), subflow->thmac,
 			 subflow->remote_nonce);
 		if (!subflow_thmac_valid(subflow)) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINACKMAC);
 			subflow->mp_join =3D 0;
 			// @@ need to trigger RST
 			return;
-- =

2.21.0

--===============2940388287131137126==--
