Content-Type: multipart/mixed; boundary="===============8469811544169554601=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 9/9] mptcp: free resources when the port number is
 mismatched
Date: Thu, 04 Mar 2021 13:32:16 -0800
Message-ID: <20210304213216.205472-10-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210304213216.205472-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8034

--===============8469811544169554601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

When the port number is mismatched with the announced ones, use
'goto dispose_child' to free the resources instead of using 'goto out'.

This patch also moves the port number checking code in
subflow_syn_recv_sock before mptcp_finish_join, otherwise subflow_drop_ctx
will fail in dispose_child.

Fixes: 5bc56388c74f ("mptcp: add port number check for MP_JOIN")
Reported-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/subflow.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 41695e26c374..3d47d670e665 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -687,11 +687,6 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk =3D NULL;
 			ctx->conn =3D (struct sock *)owner;
-			if (!mptcp_finish_join(child))
-				goto dispose_child;
-
-			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
-			tcp_rsk(req)->drop_req =3D true;
 =

 			if (subflow_use_different_sport(owner, sk)) {
 				pr_debug("ack inet_sport=3D%d %d",
@@ -699,10 +694,16 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
 				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
-					goto out;
+					goto dispose_child;
 				}
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTACKRX);
 			}
+
+			if (!mptcp_finish_join(child))
+				goto dispose_child;
+
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
+			tcp_rsk(req)->drop_req =3D true;
 		}
 	}
 =

-- =

2.30.1

--===============8469811544169554601==--
