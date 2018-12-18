Content-Type: multipart/mixed; boundary="===============0166921345296551213=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 mptcp-net-next 11/12] mptcp: Remove ndiffports path
 manager
Date: Mon, 17 Dec 2018 17:38:07 -0800
Message-ID: <20181218013808.4819-12-cpaasch@apple.com>
In-Reply-To: 20181218013808.4819-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 928

--===============0166921345296551213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/Kconfig            |  12 ----
 net/mptcp/Makefile           |   1 -
 net/mptcp/mptcp_ndiffports.c | 167 ---------------------------------------=
----
 3 files changed, 180 deletions(-)
 delete mode 100644 net/mptcp/mptcp_ndiffports.c

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index 860e9e17f76f..60c07fde5dec 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -23,14 +23,6 @@ config MPTCP_FULLMESH
 	---help---
 	  This path-management module will create a full-mesh among all IP-addres=
ses.
 =

-config MPTCP_NDIFFPORTS
-	tristate "MPTCP ndiff-ports"
-	depends on MPTCP=3Dy
-	---help---
-	  This path-management module will create multiple subflows between the s=
ame
-	  pair of IP-addresses, modifying the source-port. You can set the number
-	  of subflows via the mptcp_ndiffports-sysctl.
-
 choice
 	prompt "Default MPTCP Path-Manager"
 	default DEFAULT
@@ -40,9 +32,6 @@ choice
 	config DEFAULT_FULLMESH
 		bool "Full mesh" if MPTCP_FULLMESH=3Dy
 =

-	config DEFAULT_NDIFFPORTS
-		bool "ndiff-ports" if MPTCP_NDIFFPORTS=3Dy
-
 	config DEFAULT_DUMMY
 		bool "Default"
 =

@@ -54,6 +43,5 @@ config DEFAULT_MPTCP_PM
 	string
 	default "default" if DEFAULT_DUMMY
 	default "fullmesh" if DEFAULT_FULLMESH
-	default "ndiffports" if DEFAULT_NDIFFPORTS
 	default "default"
 =

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 8e28132c6c2a..433fd17b2987 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -9,7 +9,6 @@ mptcp-y :=3D mptcp_ctrl.o mptcp_ipv4.o mptcp_pm.o \
 	   mptcp_output.o mptcp_input.o mptcp_sched.o
 =

 obj-$(CONFIG_MPTCP_FULLMESH) +=3D mptcp_fullmesh.o
-obj-$(CONFIG_MPTCP_NDIFFPORTS) +=3D mptcp_ndiffports.o
 =

 mptcp-$(subst m,y,$(CONFIG_IPV6)) +=3D mptcp_ipv6.o
 =

diff --git a/net/mptcp/mptcp_ndiffports.c b/net/mptcp/mptcp_ndiffports.c
deleted file mode 100644
index 9faef10d8b64..000000000000
--- a/net/mptcp/mptcp_ndiffports.c
+++ /dev/null
@@ -1,167 +0,0 @@
-#include <linux/module.h>
-
-#include <net/mptcp.h>
-#include <net/mptcp_v4.h>
-
-#if IS_ENABLED(CONFIG_IPV6)
-#include <net/mptcp_v6.h>
-#endif
-
-struct ndiffports_priv {
-	/* Worker struct for subflow establishment */
-	struct work_struct subflow_work;
-
-	struct mptcp_cb *mpcb;
-};
-
-static int num_subflows __read_mostly =3D 2;
-module_param(num_subflows, int, 0644);
-MODULE_PARM_DESC(num_subflows, "choose the number of subflows per MPTCP co=
nnection");
-
-/**
- * Create all new subflows, by doing calls to mptcp_initX_subsockets
- *
- * This function uses a goto next_subflow, to allow releasing the lock bet=
ween
- * new subflows and giving other processes a chance to do some work on the
- * socket and potentially finishing the communication.
- **/
-static void create_subflow_worker(struct work_struct *work)
-{
-	const struct ndiffports_priv *pm_priv =3D container_of(work,
-						     struct ndiffports_priv,
-						     subflow_work);
-	struct mptcp_cb *mpcb =3D pm_priv->mpcb;
-	struct sock *meta_sk =3D mpcb->meta_sk;
-	int iter =3D 0;
-
-next_subflow:
-	if (iter) {
-		release_sock(meta_sk);
-		mutex_unlock(&mpcb->mpcb_mutex);
-
-		cond_resched();
-	}
-	mutex_lock(&mpcb->mpcb_mutex);
-	lock_sock_nested(meta_sk, SINGLE_DEPTH_NESTING);
-
-	iter++;
-
-	if (sock_flag(meta_sk, SOCK_DEAD))
-		goto exit;
-
-	if (mpcb->master_sk &&
-	    !tcp_sk(mpcb->master_sk)->mptcp->fully_established)
-		goto exit;
-
-	if (num_subflows > iter && num_subflows > mptcp_subflow_count(mpcb)) {
-		if (meta_sk->sk_family =3D=3D AF_INET ||
-		    mptcp_v6_is_v4_mapped(meta_sk)) {
-			struct mptcp_loc4 loc;
-			struct mptcp_rem4 rem;
-
-			loc.addr.s_addr =3D inet_sk(meta_sk)->inet_saddr;
-			loc.loc4_id =3D 0;
-			if (mpcb->master_sk)
-				loc.if_idx =3D mpcb->master_sk->sk_bound_dev_if;
-			else
-				loc.if_idx =3D 0;
-
-			rem.addr.s_addr =3D inet_sk(meta_sk)->inet_daddr;
-			rem.port =3D inet_sk(meta_sk)->inet_dport;
-			rem.rem4_id =3D 0; /* Default 0 */
-
-			mptcp_init4_subsockets(meta_sk, &loc, &rem);
-		} else {
-#if IS_ENABLED(CONFIG_IPV6)
-			struct mptcp_loc6 loc;
-			struct mptcp_rem6 rem;
-
-			loc.addr =3D inet6_sk(meta_sk)->saddr;
-			loc.loc6_id =3D 0;
-			if (mpcb->master_sk)
-				loc.if_idx =3D mpcb->master_sk->sk_bound_dev_if;
-			else
-				loc.if_idx =3D 0;
-
-			rem.addr =3D meta_sk->sk_v6_daddr;
-			rem.port =3D inet_sk(meta_sk)->inet_dport;
-			rem.rem6_id =3D 0; /* Default 0 */
-
-			mptcp_init6_subsockets(meta_sk, &loc, &rem);
-#endif
-		}
-		goto next_subflow;
-	}
-
-exit:
-	release_sock(meta_sk);
-	mutex_unlock(&mpcb->mpcb_mutex);
-	sock_put(meta_sk);
-}
-
-static void ndiffports_new_session(const struct sock *meta_sk)
-{
-	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
-	struct ndiffports_priv *fmp =3D (struct ndiffports_priv *)&mpcb->mptcp_pm=
[0];
-
-	/* Initialize workqueue-struct */
-	INIT_WORK(&fmp->subflow_work, create_subflow_worker);
-	fmp->mpcb =3D mpcb;
-}
-
-static void ndiffports_create_subflows(struct sock *meta_sk)
-{
-	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
-	struct ndiffports_priv *pm_priv =3D (struct ndiffports_priv *)&mpcb->mptc=
p_pm[0];
-
-	if (mpcb->infinite_mapping_snd || mpcb->infinite_mapping_rcv ||
-	    mpcb->send_infinite_mapping ||
-	    mpcb->server_side || sock_flag(meta_sk, SOCK_DEAD))
-		return;
-
-	if (!work_pending(&pm_priv->subflow_work)) {
-		sock_hold(meta_sk);
-		queue_work(mptcp_wq, &pm_priv->subflow_work);
-	}
-}
-
-static int ndiffports_get_local_id(sa_family_t family, union inet_addr *ad=
dr,
-				   struct net *net)
-{
-	return 0;
-}
-
-static struct mptcp_pm_ops ndiffports __read_mostly =3D {
-	.new_session =3D ndiffports_new_session,
-	.fully_established =3D ndiffports_create_subflows,
-	.get_local_id =3D ndiffports_get_local_id,
-	.name =3D "ndiffports",
-	.owner =3D THIS_MODULE,
-};
-
-/* General initialization of MPTCP_PM */
-static int __init ndiffports_register(void)
-{
-	BUILD_BUG_ON(sizeof(struct ndiffports_priv) > MPTCP_PM_SIZE);
-
-	if (mptcp_register_path_manager(&ndiffports))
-		goto exit;
-
-	return 0;
-
-exit:
-	return -1;
-}
-
-static void ndiffports_unregister(void)
-{
-	mptcp_unregister_path_manager(&ndiffports);
-}
-
-module_init(ndiffports_register);
-module_exit(ndiffports_unregister);
-
-MODULE_AUTHOR("Christoph Paasch");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("NDIFF-PORTS MPTCP");
-MODULE_VERSION("0.88");
-- =

2.16.2


--===============0166921345296551213==--
