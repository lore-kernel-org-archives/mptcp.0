Content-Type: multipart/mixed; boundary="===============3247775198252329827=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/7] mptcp: reduce number of pr_debug() calls.
Date: Wed, 05 Jun 2019 17:36:28 -0700
Message-ID: <20190606003632.2863-4-peter.krystad@linux.intel.com>
In-Reply-To: 20190606003632.2863-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1296

--===============3247775198252329827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squash to: Create SUBFLOW socket for incoming connections

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c  | 6 +++---
 net/mptcp/protocol.c | 5 +----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7475c1d5c15f..b259c4343f36 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -339,14 +339,14 @@ bool mptcp_synack_options(const struct request_sock *=
req, unsigned int *size,
 {
 	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
 =

-	pr_debug("subflow_req=3D%p", subflow_req);
 	if (subflow_req->mp_capable) {
 		opts->suboptions =3D OPTION_MPTCP_MPC_SYNACK;
 		opts->sndr_key =3D subflow_req->local_key;
 		opts->rcvr_key =3D subflow_req->remote_key;
 		*size =3D TCPOLEN_MPTCP_MPC_SYNACK;
-		pr_debug("local_key=3D%llu", subflow_req->local_key);
-		pr_debug("remote_key=3D%llu", subflow_req->remote_key);
+		pr_debug("subflow_req=3D%p, local_key=3D%llu, remote_key=3D%llu",
+			 subflow_req, subflow_req->local_key,
+			 subflow_req->remote_key);
 		return true;
 	}
 	return false;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 902b6c994f00..78ce42b1617a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -596,9 +596,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		return NULL;
 =

 	subflow =3D subflow_ctx(new_sock->sk);
-	pr_debug("new subflow=3D%p", subflow);
-
-	pr_debug("new msk=3D%p", msk);
+	pr_debug("msk=3D%p, new subflow=3D%p, ", msk, subflow);
 =

 	if (subflow->mp_capable) {
 		struct sock *new_mptcp_sock;
@@ -623,7 +621,6 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
-		pr_debug("token=3D%u", msk->token);
 		token_update_accept(new_sock->sk, new_mptcp_sock);
 		msk->subflow =3D NULL;
 =

-- =

2.17.2


--===============3247775198252329827==--
