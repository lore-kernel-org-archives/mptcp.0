Content-Type: multipart/mixed; boundary="===============7233255798394707450=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 10/10] mptcp: Implement path manager interface
 commands
Date: Wed, 07 Aug 2019 15:44:34 -0700
Message-ID: <20190807224434.2829-11-peter.krystad@linux.intel.com>
In-Reply-To: 20190807224434.2829-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1593

--===============7233255798394707450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the addr_signal flag to indicate to the subflow layer
that a local address may be announced, and call subflow_connect()
to initiate a secondary subflow.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/pm.c       | 62 +++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  1 +
 net/mptcp/token.c    | 13 ++++++++++
 3 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e81475a337b7..c98b92512adf 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -13,17 +13,73 @@
 int pm_announce_addr(u32 token, sa_family_t family, u8 local_id,
 		     struct in_addr *addr)
 {
-	return -ENOTSUPP;
+	struct mptcp_sock *msk =3D mptcp_sk(token_lookup_get(token));
+	int err =3D 0;
+
+	if (!msk)
+		return -EINVAL;
+
+	if (msk->pm.local_valid) {
+		err =3D -EBADR;
+		goto announce_put;
+	}
+
+	pr_debug("msk=3D%p, local_id=3D%d, addr=3D%x", msk, local_id, addr->s_add=
r);
+	msk->pm.local_valid =3D 1;
+	msk->pm.local_id =3D local_id;
+	msk->pm.local_family =3D family;
+	msk->pm.local_addr.s_addr =3D addr->s_addr;
+	msk->addr_signal =3D 1;
+
+announce_put:
+	sock_put((struct sock *)msk);
+	return err;
 }
 =

 int pm_remove_addr(u32 token, u8 local_id)
 {
-	return -ENOTSUPP;
+	struct mptcp_sock *msk =3D mptcp_sk(token_lookup_get(token));
+
+	if (!msk)
+		return -EINVAL;
+
+	pr_debug("msk=3D%p", msk);
+	msk->pm.local_valid =3D 0;
+
+	sock_put((struct sock *)msk);
+	return 0;
 }
 =

 int pm_create_subflow(u32 token, u8 remote_id)
 {
-	return -ENOTSUPP;
+	struct mptcp_sock *msk =3D mptcp_sk(token_lookup_get(token));
+	struct sockaddr_in remote;
+	struct sockaddr_in local;
+	int err;
+
+	if (!msk)
+		return -EINVAL;
+
+	pr_debug("msk=3D%p", msk);
+
+	if (!msk->pm.remote_valid || remote_id !=3D msk->pm.remote_id) {
+		err =3D -EBADR;
+		goto create_put;
+	}
+
+	local.sin_family =3D AF_INET;
+	local.sin_port =3D 0;
+	local.sin_addr.s_addr =3D INADDR_ANY;
+
+	remote.sin_family =3D msk->pm.remote_family;
+	remote.sin_port =3D htons(msk->dport);
+	remote.sin_addr.s_addr =3D htonl(msk->pm.remote_addr.s_addr);
+
+	err =3D subflow_connect((struct sock *)msk, &local, &remote, remote_id);
+
+create_put:
+	sock_put((struct sock *)msk);
+	return err;
 }
 =

 int pm_remove_subflow(u32 token, u8 remote_id)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 243d896d9e42..bc1fbd3827a6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -233,6 +233,7 @@ void token_new_subflow(struct sock *sk);
 void token_new_accept(struct sock *sk);
 int token_new_join(struct sock *sk);
 void token_update_accept(struct sock *sk, struct sock *conn);
+struct sock *token_lookup_get(u32 token);
 void token_release(u32 token);
 void token_destroy(u32 token);
 =

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 80acb6c6657f..b54f617d4c26 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -348,6 +348,19 @@ int token_new_join(struct sock *sk)
 	return -1;
 }
 =

+struct sock *token_lookup_get(u32 token)
+{
+	struct sock *conn;
+
+	spin_lock_bh(&token_tree_lock);
+	conn =3D lookup_token(token);
+	if (conn)
+		sock_hold(conn);
+
+	spin_unlock_bh(&token_tree_lock);
+	return conn;
+}
+
 void token_destroy_request(u32 token)
 {
 	pr_debug("token=3D%u", token);
-- =

2.17.2


--===============7233255798394707450==--
