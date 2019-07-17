Content-Type: multipart/mixed; boundary="===============3153004116957777947=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 9/9] mptcp: Implement interim path manager
Date: Wed, 17 Jul 2019 15:12:56 -0700
Message-ID: <20190717221256.7358-10-peter.krystad@linux.intel.com>
In-Reply-To: 20190717221256.7358-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1520

--===============3153004116957777947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Two features: 1) When a new connection occurs announce
a local address and 2) When an outgoing connection is fully
established (and a remote address was received) initiate a
secondary subflow.

The second local address must be hard-coded for now.

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/pm.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0d53a0f23d2d..69df6332b4d0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -8,21 +8,84 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

+struct workqueue_struct *mptcp_wq;
+static void announce_addr_worker(struct work_struct *work);
+static void create_subflow_worker(struct work_struct *work);
+
 /* path manager command handlers */
 =

 int pm_announce_addr(u32 token, sa_family_t family, u8 id, struct in_addr =
*addr)
 {
-	return -ENOTSUPP;
+	struct mptcp_sock *msk =3D mptcp_sk(token_lookup(token));
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
+	pr_debug("msk=3D%p, id=3D%d, addr=3D%x", msk, id, addr->s_addr);
+	msk->pm.local_valid =3D 1;
+	msk->pm.local_id =3D id;
+	msk->pm.local_family =3D family;
+	msk->pm.local_addr.s_addr =3D addr->s_addr;
+	msk->addr_signal =3D 1;
+
+announce_put:
+	sock_put((struct sock *)msk);
+	return err;
 }
 =

 int pm_remove_addr(u32 token, u8 id)
 {
-	return -ENOTSUPP;
+	struct mptcp_sock *msk =3D mptcp_sk(token_lookup(token));
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

 int pm_create_subflow(u32 token, u8 local_id, u8 remote_id)
 {
-	return -ENOTSUPP;
+	struct mptcp_sock *msk =3D mptcp_sk(token_lookup(token));
+	struct sockaddr_in remote;
+	struct sockaddr_in local;
+	int err;
+
+	if (!msk)
+		return -EINVAL;
+
+	pr_debug("msk=3D%p", msk);
+	if (!msk->pm.local_valid || local_id !=3D msk->pm.local_id) {
+		err =3D -EBADR;
+		goto create_put;
+	}
+	local.sin_family =3D AF_INET;
+	local.sin_port =3D 0;
+	local.sin_addr.s_addr =3D INADDR_ANY;
+
+	if (!msk->pm.remote_valid || remote_id !=3D msk->pm.remote_id) {
+		err =3D -EBADR;
+		goto create_put;
+	}
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

 int pm_remove_subflow(u32 token, u8 local_id, u8 remote_id)
@@ -37,12 +100,22 @@ void pm_new_connection(struct mptcp_sock *msk, int ser=
ver_side)
 	pr_debug("msk=3D%p", msk);
 =

 	msk->pm.server_side =3D server_side;
+
+	/* trigger announce address in interim local path manager */
+	INIT_WORK(&msk->pm.addr_work, announce_addr_worker);
+	msk->pm.token =3D msk->token;
+	queue_work(mptcp_wq, &msk->pm.addr_work);
 }
 =

 void pm_fully_established(struct mptcp_sock *msk)
 {
 	pr_debug("msk=3D%p", msk);
 =

+	/* trigger create subflow in interim local local path manager */
+	if (!msk->pm.server_side && !msk->pm.fully_established) {
+		INIT_WORK(&msk->pm.subflow_work, create_subflow_worker);
+		queue_work(mptcp_wq, &msk->pm.subflow_work);
+	}
 	msk->pm.fully_established =3D 1;
 }
 =

@@ -126,4 +199,25 @@ int pm_get_local_id(struct request_sock *req, struct s=
ock *sk,
 =

 void pm_init(void)
 {
+	mptcp_wq =3D alloc_workqueue("mptcp_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 8);
+	if (!mptcp_wq)
+		panic("Failed to allocate workqueue");
+}
+
+static void announce_addr_worker(struct work_struct *work)
+{
+	struct mptcp_pm_data *pm =3D container_of(work, struct mptcp_pm_data,
+						addr_work);
+	struct in_addr addr;
+
+	/* @@ hard-code address to announce here... */
+	pm_announce_addr(pm->token, AF_INET, 1, &addr);
+}
+
+static void create_subflow_worker(struct work_struct *work)
+{
+	struct mptcp_pm_data *pm =3D container_of(work, struct mptcp_pm_data,
+						subflow_work);
+
+	pm_create_subflow(pm->token, pm->local_id, pm->remote_id);
 }
-- =

2.17.2


--===============3153004116957777947==--
