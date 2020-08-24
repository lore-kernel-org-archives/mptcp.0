Content-Type: multipart/mixed; boundary="===============1175431729928703811=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v8 mptcp-next 5/8] mptcp: fix subflow's
 remote_id is zero issue
Date: Mon, 24 Aug 2020 19:36:18 +0800
Message-ID: <690fe27e2779bb40aca87905ccc56c0403b9b92a.1598267961.git.geliangtang@gmail.com>
In-Reply-To: cover.1598267961.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5610

--===============1175431729928703811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the missing remote_id set in subflow_ulp_clone. And also
updated the remote_id set in __mptcp_subflow_connect, to make the code more
like local_id set.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/subflow.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 82f6d2d9e39e..0a7b80711096 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1042,6 +1042,7 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
ruct mptcp_addr_info *loc,
 	struct mptcp_subflow_context *subflow;
 	struct sockaddr_storage addr;
 	int local_id =3D loc->id;
+	int remote_id =3D remote->id;
 	struct socket *sf;
 	struct sock *ssk;
 	u32 remote_token;
@@ -1072,7 +1073,6 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
ruct mptcp_addr_info *loc,
 	subflow->remote_key =3D msk->remote_key;
 	subflow->local_key =3D msk->local_key;
 	subflow->token =3D msk->token;
-	subflow->remote_id =3D remote->id;
 	mptcp_info2sockaddr(loc, &addr);
 =

 	addrlen =3D sizeof(struct sockaddr_in);
@@ -1086,10 +1086,11 @@ int __mptcp_subflow_connect(struct sock *sk, const =
struct mptcp_addr_info *loc,
 		goto failed;
 =

 	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
-	pr_debug("msk=3D%p remote_token=3D%u local_id=3D%d", msk, remote_token,
-		 local_id);
+	pr_debug("msk=3D%p remote_token=3D%u local_id=3D%d remote_id=3D%d", msk, =
remote_token,
+		 local_id, remote_id);
 	subflow->remote_token =3D remote_token;
 	subflow->local_id =3D local_id;
+	subflow->remote_id =3D remote_id;
 	subflow->request_join =3D 1;
 	subflow->request_bkup =3D !!(loc->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	mptcp_info2sockaddr(remote, &addr);
@@ -1354,6 +1355,7 @@ static void subflow_ulp_clone(const struct request_so=
ck *req,
 		new_ctx->fully_established =3D 1;
 		new_ctx->backup =3D subflow_req->backup;
 		new_ctx->local_id =3D subflow_req->local_id;
+		new_ctx->remote_id =3D subflow_req->remote_id;
 		new_ctx->token =3D subflow_req->token;
 		new_ctx->thmac =3D subflow_req->thmac;
 	}
-- =

2.17.1

--===============1175431729928703811==--
