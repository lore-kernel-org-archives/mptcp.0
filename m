Content-Type: multipart/mixed; boundary="===============0773449000163356900=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net-next] mptcp: free resources when the port
 number is mismatched
Date: Fri, 12 Feb 2021 14:43:35 +0800
Message-ID: <c79259641c0fda0a0df41c25f58ae0a1da1e3839.1613112149.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7770

--===============0773449000163356900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the port number is mismatched with the announced ones, use
'goto dispose_child' to free the resources instead of using 'goto out'.

This patch also moves the port number checking code in
subflow_syn_recv_sock before the setting of ctx->conn, otherwise
subflow_drop_ctx will fail in dispose_child.

Fixes: 5bc56388c74f ("mptcp: add port number check for MP_JOIN")
Reported-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/subflow.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 280da418d60b..a9c8daf72768 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -692,25 +692,25 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 			if (!owner)
 				goto dispose_child;
 =

-			/* move the msk reference ownership to the subflow */
-			subflow_req->msk =3D NULL;
-			ctx->conn =3D (struct sock *)owner;
-			if (!mptcp_finish_join(child))
-				goto dispose_child;
-
-			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
-			tcp_rsk(req)->drop_req =3D true;
-
 			if (subflow_use_different_sport(owner, sk)) {
 				pr_debug("ack inet_sport=3D%d %d",
 					 ntohs(inet_sk(sk)->inet_sport),
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
 				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
-					goto out;
+					goto dispose_child;
 				}
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTACKRX);
 			}
+
+			/* move the msk reference ownership to the subflow */
+			subflow_req->msk =3D NULL;
+			ctx->conn =3D (struct sock *)owner;
+			if (!mptcp_finish_join(child))
+				goto dispose_child;
+
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
+			tcp_rsk(req)->drop_req =3D true;
 		}
 	}
 =

-- =

2.29.2

--===============0773449000163356900==--
