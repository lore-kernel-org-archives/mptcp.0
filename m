Content-Type: multipart/mixed; boundary="===============4908245041576163356=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v3] mptcp: Implement interim path manager
Date: Wed, 28 Aug 2019 12:21:49 -0700
Message-ID: <20190828192149.2738-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1741

--===============4908245041576163356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Two features: 1) When an incoming connection is received
announce a local address and 2) When an outgoing connection
is fully established and a remote address has been received
initiate a secondary subflow.

The second local address must be hard-coded for now.

v3 - only take reference if queue_work succeeds

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/pm.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index bc07376a823b..770938471f66 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -8,6 +8,10 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

+struct workqueue_struct *mptcp_wq;
+static void announce_addr_worker(struct work_struct *work);
+static void create_subflow_worker(struct work_struct *work);
+
 /* path manager command handlers */
 =

 int pm_announce_addr(u32 token, sa_family_t family, u8 local_id,
@@ -91,16 +95,34 @@ int pm_remove_subflow(u32 token, u8 remote_id)
 =

 void pm_new_connection(struct mptcp_sock *msk, int server_side)
 {
-	pr_debug("msk=3D%p", msk);
+	struct mptcp_pm_data *pm =3D &msk->pm;
+
+	pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
 =

-	msk->pm.server_side =3D server_side;
+	pm->server_side =3D server_side;
+	pm->token =3D msk->token;
+
+	/* trigger announce address in interim local path manager */
+	if (pm->server_side) {
+		INIT_WORK(&pm->addr_work, announce_addr_worker);
+		if (queue_work(mptcp_wq, &pm->addr_work))
+			sock_hold((struct sock *)msk);
+	}
 }
 =

 void pm_fully_established(struct mptcp_sock *msk)
 {
+	struct mptcp_pm_data *pm =3D &msk->pm;
+
 	pr_debug("msk=3D%p", msk);
 =

-	msk->pm.fully_established =3D 1;
+	/* trigger create subflow in interim local path manager */
+	if (!pm->server_side && !pm->fully_established && pm->remote_valid) {
+		INIT_WORK(&pm->subflow_work, create_subflow_worker);
+		if (queue_work(mptcp_wq, &pm->subflow_work))
+			sock_hold((struct sock *)msk);
+	}
+	pm->fully_established =3D 1;
 }
 =

 void pm_connection_closed(struct mptcp_sock *msk)
@@ -120,12 +142,21 @@ void pm_subflow_closed(struct mptcp_sock *msk, u8 id)
 =

 void pm_add_addr(struct mptcp_sock *msk, const struct in_addr *addr, u8 id)
 {
+	struct mptcp_pm_data *pm =3D &msk->pm;
+
 	pr_debug("msk=3D%p, addr=3D%x, remote_id=3D%d", msk, addr->s_addr, id);
 =

 	msk->pm.remote_addr.s_addr =3D addr->s_addr;
 	msk->pm.remote_id =3D id;
 	msk->pm.remote_family =3D AF_INET;
-	msk->pm.remote_valid =3D 1;
+
+	/* trigger create subflow in interim local path manager */
+	if (!pm->server_side && !pm->remote_valid && pm->fully_established) {
+		INIT_WORK(&pm->subflow_work, create_subflow_worker);
+		if (queue_work(mptcp_wq, &pm->subflow_work))
+			sock_hold((struct sock *)msk);
+	}
+	pm->remote_valid =3D 1;
 }
 =

 void pm_add_addr6(struct mptcp_sock *msk, const struct in6_addr *addr, u8 =
id)
@@ -177,4 +208,29 @@ int pm_get_local_id(struct request_sock *req, struct s=
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
+	struct mptcp_sock *msk =3D container_of(pm, struct mptcp_sock, pm);
+	struct in_addr addr;
+
+	/* @@ hard-code address to announce here... */
+	pm_announce_addr(pm->token, AF_INET, 1, &addr);
+	sock_put((struct sock *)msk);
+}
+
+static void create_subflow_worker(struct work_struct *work)
+{
+	struct mptcp_pm_data *pm =3D container_of(work, struct mptcp_pm_data,
+						subflow_work);
+	struct mptcp_sock *msk =3D container_of(pm, struct mptcp_sock, pm);
+
+	pm_create_subflow(pm->token, pm->remote_id);
+	sock_put((struct sock *)msk);
 }
-- =

2.17.2


--===============4908245041576163356==--
