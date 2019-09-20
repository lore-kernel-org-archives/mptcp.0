Content-Type: multipart/mixed; boundary="===============2517507617467499119=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] mptcp: add mib examples
Date: Fri, 20 Sep 2019 17:05:14 +0200
Message-ID: <20190920150514.1878-3-fw@strlen.de>
In-Reply-To: 20190920150514.1878-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1890

--===============2517507617467499119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just for testing, no need to apply this at the moment.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 12 +++++++++++-
 net/mptcp/subflow.c  | 21 +++++++++++++++++----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 66ac7dafe388..31ee19f867f4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -367,8 +367,10 @@ static enum mapping_status mptcp_get_mapping(struct so=
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
@@ -720,7 +722,10 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
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
@@ -728,6 +733,8 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		tcp_sk(newsk)->is_mptcp =3D 0;
 		new_sock->sk =3D NULL;
 		sock_release(new_sock);
+
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	}
 =

 	return newsk;
@@ -852,7 +859,10 @@ void mptcp_finish_connect(struct sock *sk, int mp_capa=
ble)
 		msk->subflow =3D NULL;
 		bh_unlock_sock(sk);
 		local_bh_enable();
+	} else {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
 	}
+
 	inet_sk_state_store(sk, TCP_ESTABLISHED);
 }
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a49cc5ed1b27..1cffde9b95ed 100644
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
@@ -181,6 +193,7 @@ static void subflow_finish_connect(struct sock *sk, con=
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


--===============2517507617467499119==--
