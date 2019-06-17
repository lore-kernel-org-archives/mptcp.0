Content-Type: multipart/mixed; boundary="===============7573058894318219115=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/3] squash to: mptcp: Add handling of incoming
 MP_JOIN requests
Date: Mon, 17 Jun 2019 16:11:42 +0200
Message-ID: <20190617141142.6782-4-matthieu.baerts@tessares.net>
In-Reply-To: 20190617141142.6782-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1418

--===============7573058894318219115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)linux.intel.com>

This is extracted from MP_JOIN handling WIP v3 by Peter.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/options.c  | 11 ++++-------
 net/mptcp/protocol.c |  2 +-
 net/mptcp/subflow.c  |  9 ++++++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a73b7ad7388e..58215f19829a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -461,8 +461,7 @@ bool mptcp_synack_options(const struct request_sock *re=
q, unsigned int *size,
 			 subflow_req, subflow_req->local_key,
 			 subflow_req->remote_key);
 		return true;
-	}
-	if (subflow_req->mp_join) {
+	} else if (subflow_req->mp_join) {
 		opts->suboptions =3D OPTION_MPTCP_MPJ_SYNACK;
 		opts->backup =3D subflow_req->backup;
 		opts->join_id =3D subflow_req->local_id;
@@ -560,11 +559,9 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 	}
 =

 	if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
-		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
-			       (TCPOLEN_MPTCP_MPJ_SYNACK << 16) |
-			       (MPTCPOPT_MP_JOIN << 12) |
-			       (opts->backup << 8) |
-			       opts->join_id);
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
+				      TCPOLEN_MPTCP_MPJ_SYNACK,
+				      opts->backup, opts->join_id);
 		put_unaligned_be64(opts->thmac, ptr);
 		ptr +=3D 2;
 		put_unaligned_be32(opts->nonce, ptr);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1ff5a7e5b65d..042811a1e01b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -779,8 +779,8 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 =

 void mptcp_finish_join(struct sock *conn, struct sock *sk)
 {
-	struct mptcp_sock *msk =3D mptcp_sk(conn);
 	struct subflow_context *subflow =3D subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(conn);
 =

 	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e7f4f826da33..a858cc966724 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -54,6 +54,12 @@ static void subflow_v4_init_req(struct request_sock *req,
 	memset(&rx_opt.mptcp, 0, sizeof(rx_opt.mptcp));
 	mptcp_get_options(skb, &rx_opt);
 =

+	subflow_req->mp_capable =3D 0;
+	subflow_req->mp_join =3D 0;
+
+	if (rx_opt.mptcp.mp_capable && rx_opt.mptcp.mp_join)
+		return;
+
 	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
 		subflow_req->mp_capable =3D 1;
 		if (rx_opt.mptcp.version >=3D listener->version)
@@ -80,9 +86,6 @@ static void subflow_v4_init_req(struct request_sock *req,
 			subflow_req->mp_join =3D 0;
 			// @@ need to trigger RST
 		}
-	} else {
-		subflow_req->mp_capable =3D 0;
-		subflow_req->mp_join =3D 0;
 	}
 }
 =

-- =

2.20.1


--===============7573058894318219115==--
