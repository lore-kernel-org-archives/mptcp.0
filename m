Content-Type: multipart/mixed; boundary="===============7142174313933132024=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net 2/2] mptcp: fix subflow's remote_id issues
Date: Mon, 07 Sep 2020 18:29:54 +0800
Message-ID: <7187516ee5a9f17a7bf1e4aa9a849da2dd56a734.1599474422.git.geliangtang@gmail.com>
In-Reply-To: f24ee917e4043d2befe2a0f96cd57aa74d2a4b26.1599474422.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5749

--===============7142174313933132024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch set the init remote_id to zero, otherwise it will be a random
number.

Then it added the missing subflow's remote_id setting code both in
__mptcp_subflow_connect and in subflow_ulp_clone.

Reviewed-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 2 +-
 net/mptcp/subflow.c    | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index dc2c57860d2d..255695221309 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -186,7 +186,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
 	struct mptcp_pm_addr_entry *local;
-	struct mptcp_addr_info remote;
+	struct mptcp_addr_info remote =3D { 0 };
 	struct pm_nl_pernet *pernet;
 =

 	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e8cac2655c82..9ead43f79023 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1063,6 +1063,7 @@ int __mptcp_subflow_connect(struct sock *sk, int ifin=
dex,
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
 	struct sockaddr_storage addr;
+	int remote_id =3D remote->id;
 	int local_id =3D loc->id;
 	struct socket *sf;
 	struct sock *ssk;
@@ -1107,10 +1108,11 @@ int __mptcp_subflow_connect(struct sock *sk, int if=
index,
 		goto failed;
 =

 	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
-	pr_debug("msk=3D%p remote_token=3D%u local_id=3D%d", msk, remote_token,
-		 local_id);
+	pr_debug("msk=3D%p remote_token=3D%u local_id=3D%d remote_id=3D%d", msk,
+		 remote_token, local_id, remote_id);
 	subflow->remote_token =3D remote_token;
 	subflow->local_id =3D local_id;
+	subflow->remote_id =3D remote_id;
 	subflow->request_join =3D 1;
 	subflow->request_bkup =3D 1;
 	mptcp_info2sockaddr(remote, &addr);
@@ -1347,6 +1349,7 @@ static void subflow_ulp_clone(const struct request_so=
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

--===============7142174313933132024==--
