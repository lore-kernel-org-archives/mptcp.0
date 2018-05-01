Content-Type: multipart/mixed; boundary="===============0563083529575725141=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 8/9] mptcp: Remove Binder Path-Manager
Date: Tue, 01 May 2018 13:35:37 -0700
Message-ID: <20180501203538.95477-9-cpaasch@apple.com>
In-Reply-To: 20180501203538.95477-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 593

--===============0563083529575725141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/Kconfig        |  14 +-
 net/mptcp/Makefile       |   1 -
 net/mptcp/mptcp_binder.c | 486 -------------------------------------------=
----
 3 files changed, 1 insertion(+), 500 deletions(-)
 delete mode 100644 net/mptcp/mptcp_binder.c

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index 0333de3e6349..9c490ec8fba8 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -31,14 +31,6 @@ config MPTCP_NDIFFPORTS
 	  pair of IP-addresses, modifying the source-port. You can set the number
 	  of subflows via the mptcp_ndiffports-sysctl.
 =

-config MPTCP_BINDER
-	tristate "MPTCP Binder"
-	depends on (MPTCP=3Dy)
-	---help---
-	  This path-management module works like ndiffports, and adds the sysctl
-	  option to set the gateway (and/or path to) per each additional subflow
-	  via Loose Source Routing (IPv4 only).
-
 choice
 	prompt "Default MPTCP Path-Manager"
 	default DEFAULT
@@ -51,9 +43,6 @@ choice
 	config DEFAULT_NDIFFPORTS
 		bool "ndiff-ports" if MPTCP_NDIFFPORTS=3Dy
 =

-	config DEFAULT_BINDER
-		bool "binder" if MPTCP_BINDER=3Dy
-
 	config DEFAULT_DUMMY
 		bool "Default"
 =

@@ -64,9 +53,8 @@ endif
 config DEFAULT_MPTCP_PM
 	string
 	default "default" if DEFAULT_DUMMY
-	default "fullmesh" if DEFAULT_FULLMESH =

+	default "fullmesh" if DEFAULT_FULLMESH
 	default "ndiffports" if DEFAULT_NDIFFPORTS
-	default "binder" if DEFAULT_BINDER
 	default "default"
 =

 menuconfig MPTCP_SCHED_ADVANCED
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index d722b8266014..8e28132c6c2a 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -10,7 +10,6 @@ mptcp-y :=3D mptcp_ctrl.o mptcp_ipv4.o mptcp_pm.o \
 =

 obj-$(CONFIG_MPTCP_FULLMESH) +=3D mptcp_fullmesh.o
 obj-$(CONFIG_MPTCP_NDIFFPORTS) +=3D mptcp_ndiffports.o
-obj-$(CONFIG_MPTCP_BINDER) +=3D mptcp_binder.o
 =

 mptcp-$(subst m,y,$(CONFIG_IPV6)) +=3D mptcp_ipv6.o
 =

diff --git a/net/mptcp/mptcp_binder.c b/net/mptcp/mptcp_binder.c
deleted file mode 100644
index 58a342dc1620..000000000000
--- a/net/mptcp/mptcp_binder.c
+++ /dev/null
@@ -1,486 +0,0 @@
-#include <linux/module.h>
-
-#include <net/mptcp.h>
-#include <net/mptcp_v4.h>
-
-#include <linux/route.h>
-#include <linux/inet.h>
-#include <linux/mroute.h>
-#include <linux/spinlock_types.h>
-#include <net/inet_ecn.h>
-#include <net/route.h>
-#include <net/xfrm.h>
-#include <net/compat.h>
-#include <linux/slab.h>
-
-#define MPTCP_GW_MAX_LISTS	10
-#define MPTCP_GW_LIST_MAX_LEN	6
-#define MPTCP_GW_SYSCTL_MAX_LEN	(15 * MPTCP_GW_LIST_MAX_LEN *	\
-							MPTCP_GW_MAX_LISTS)
-
-struct mptcp_gw_list {
-	struct in_addr list[MPTCP_GW_MAX_LISTS][MPTCP_GW_LIST_MAX_LEN];
-	u8 len[MPTCP_GW_MAX_LISTS];
-};
-
-struct binder_priv {
-	/* Worker struct for subflow establishment */
-	struct work_struct subflow_work;
-
-	struct mptcp_cb *mpcb;
-
-	/* Prevent multiple sub-sockets concurrently iterating over sockets */
-	spinlock_t *flow_lock;
-};
-
-static struct mptcp_gw_list *mptcp_gws;
-static rwlock_t mptcp_gws_lock;
-
-static int mptcp_binder_ndiffports __read_mostly =3D 1;
-
-static char sysctl_mptcp_binder_gateways[MPTCP_GW_SYSCTL_MAX_LEN] __read_m=
ostly;
-
-static int mptcp_get_avail_list_ipv4(struct sock *sk)
-{
-	int i, j, list_taken, opt_ret, opt_len;
-	unsigned char *opt_ptr, *opt_end_ptr, opt[MAX_IPOPTLEN];
-
-	for (i =3D 0; i < MPTCP_GW_MAX_LISTS; ++i) {
-		if (mptcp_gws->len[i] =3D=3D 0)
-			goto error;
-
-		mptcp_debug("mptcp_get_avail_list_ipv4: List %i\n", i);
-		list_taken =3D 0;
-
-		/* Loop through all sub-sockets in this connection */
-		mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk) {
-			mptcp_debug("mptcp_get_avail_list_ipv4: Next sock\n");
-
-			/* Reset length and options buffer, then retrieve
-			 * from socket
-			 */
-			opt_len =3D MAX_IPOPTLEN;
-			memset(opt, 0, MAX_IPOPTLEN);
-			opt_ret =3D ip_getsockopt(sk, IPPROTO_IP,
-				IP_OPTIONS, (char __user *)opt, (int __user *)&opt_len);
-			if (opt_ret < 0) {
-				mptcp_debug("%s: MPTCP subsocket getsockopt() IP_OPTIONS failed, error=
 %d\n",
-					    __func__, opt_ret);
-				goto error;
-			}
-
-			/* If socket has no options, it has no stake in this list */
-			if (opt_len <=3D 0)
-				continue;
-
-			/* Iterate options buffer */
-			for (opt_ptr =3D &opt[0]; opt_ptr < &opt[opt_len]; opt_ptr++) {
-				if (*opt_ptr =3D=3D IPOPT_LSRR) {
-					mptcp_debug("mptcp_get_avail_list_ipv4: LSRR options found\n");
-					goto sock_lsrr;
-				}
-			}
-			continue;
-
-sock_lsrr:
-			/* Pointer to the 2nd to last address */
-			opt_end_ptr =3D opt_ptr+(*(opt_ptr+1))-4;
-
-			/* Addresses start 3 bytes after type offset */
-			opt_ptr +=3D 3;
-			j =3D 0;
-
-			/* Different length lists cannot be the same */
-			if ((opt_end_ptr-opt_ptr)/4 !=3D mptcp_gws->len[i])
-				continue;
-
-			/* Iterate if we are still inside options list
-			 * and sysctl list
-			 */
-			while (opt_ptr < opt_end_ptr && j < mptcp_gws->len[i]) {
-				/* If there is a different address, this list must
-				 * not be set on this socket
-				 */
-				if (memcmp(&mptcp_gws->list[i][j], opt_ptr, 4))
-					break;
-
-				/* Jump 4 bytes to next address */
-				opt_ptr +=3D 4;
-				j++;
-			}
-
-			/* Reached the end without a differing address, lists
-			 * are therefore identical.
-			 */
-			if (j =3D=3D mptcp_gws->len[i]) {
-				mptcp_debug("mptcp_get_avail_list_ipv4: List already used\n");
-				list_taken =3D 1;
-				break;
-			}
-		}
-
-		/* Free list found if not taken by a socket */
-		if (!list_taken) {
-			mptcp_debug("mptcp_get_avail_list_ipv4: List free\n");
-			break;
-		}
-	}
-
-	if (i >=3D MPTCP_GW_MAX_LISTS)
-		goto error;
-
-	return i;
-error:
-	return -1;
-}
-
-/* The list of addresses is parsed each time a new connection is opened,
- *  to make sure it's up to date. In case of error, all the lists are
- *  marked as unavailable and the subflow's fingerprint is set to 0.
- */
-static void mptcp_v4_add_lsrr(struct sock *sk, struct in_addr addr)
-{
-	int i, j, ret;
-	unsigned char opt[MAX_IPOPTLEN] =3D {0};
-	struct tcp_sock *tp =3D tcp_sk(sk);
-	struct binder_priv *fmp =3D (struct binder_priv *)&tp->mpcb->mptcp_pm[0];
-
-	/* Read lock: multiple sockets can read LSRR addresses at the same
-	 * time, but writes are done in mutual exclusion.
-	 * Spin lock: must search for free list for one socket at a time, or
-	 * multiple sockets could take the same list.
-	 */
-	read_lock(&mptcp_gws_lock);
-	spin_lock(fmp->flow_lock);
-
-	i =3D mptcp_get_avail_list_ipv4(sk);
-
-	/* Execution enters here only if a free path is found.
-	 */
-	if (i >=3D 0) {
-		opt[0] =3D IPOPT_NOP;
-		opt[1] =3D IPOPT_LSRR;
-		opt[2] =3D sizeof(mptcp_gws->list[i][0].s_addr) *
-				(mptcp_gws->len[i] + 1) + 3;
-		opt[3] =3D IPOPT_MINOFF;
-		for (j =3D 0; j < mptcp_gws->len[i]; ++j)
-			memcpy(opt + 4 +
-				(j * sizeof(mptcp_gws->list[i][0].s_addr)),
-				&mptcp_gws->list[i][j].s_addr,
-				sizeof(mptcp_gws->list[i][0].s_addr));
-		/* Final destination must be part of IP_OPTIONS parameter. */
-		memcpy(opt + 4 + (j * sizeof(addr.s_addr)), &addr.s_addr,
-		       sizeof(addr.s_addr));
-
-		/* setsockopt must be inside the lock, otherwise another
-		 * subflow could fail to see that we have taken a list.
-		 */
-		ret =3D ip_setsockopt(sk, IPPROTO_IP, IP_OPTIONS, (char __user *)opt,
-				    4 + sizeof(mptcp_gws->list[i][0].s_addr) * (mptcp_gws->len[i] + 1)=
);
-
-		if (ret < 0) {
-			mptcp_debug("%s: MPTCP subsock setsockopt() IP_OPTIONS failed, error %d=
\n",
-				    __func__, ret);
-		}
-	}
-
-	spin_unlock(fmp->flow_lock);
-	read_unlock(&mptcp_gws_lock);
-
-	return;
-}
-
-/* Parses gateways string for a list of paths to different
- * gateways, and stores them for use with the Loose Source Routing (LSRR)
- * socket option. Each list must have "," separated addresses, and the lis=
ts
- * themselves must be separated by "-". Returns -1 in case one or more of =
the
- * addresses is not a valid ipv4/6 address.
- */
-static int mptcp_parse_gateway_ipv4(char *gateways)
-{
-	int i, j, k, ret;
-	char *tmp_string =3D NULL;
-	struct in_addr tmp_addr;
-
-	tmp_string =3D kzalloc(16, GFP_KERNEL);
-	if (tmp_string =3D=3D NULL)
-		return -ENOMEM;
-
-	write_lock(&mptcp_gws_lock);
-
-	memset(mptcp_gws, 0, sizeof(struct mptcp_gw_list));
-
-	/* A TMP string is used since inet_pton needs a null terminated string
-	 * but we do not want to modify the sysctl for obvious reasons.
-	 * i will iterate over the SYSCTL string, j will iterate over the
-	 * temporary string where each IP is copied into, k will iterate over
-	 * the IPs in each list.
-	 */
-	for (i =3D j =3D k =3D 0;
-			i < MPTCP_GW_SYSCTL_MAX_LEN && k < MPTCP_GW_MAX_LISTS;
-			++i) {
-		if (gateways[i] =3D=3D '-' || gateways[i] =3D=3D ',' || gateways[i] =3D=
=3D '\0') {
-			/* If the temp IP is empty and the current list is
-			 *  empty, we are done.
-			 */
-			if (j =3D=3D 0 && mptcp_gws->len[k] =3D=3D 0)
-				break;
-
-			/* Terminate the temp IP string, then if it is
-			 * non-empty parse the IP and copy it.
-			 */
-			tmp_string[j] =3D '\0';
-			if (j > 0) {
-				mptcp_debug("mptcp_parse_gateway_list tmp: %s i: %d\n", tmp_string, i);
-
-				ret =3D in4_pton(tmp_string, strlen(tmp_string),
-						(u8 *)&tmp_addr.s_addr, '\0',
-						NULL);
-
-				if (ret) {
-					mptcp_debug("mptcp_parse_gateway_list ret: %d s_addr: %pI4\n",
-						    ret,
-						    &tmp_addr.s_addr);
-					memcpy(&mptcp_gws->list[k][mptcp_gws->len[k]].s_addr,
-					       &tmp_addr.s_addr,
-					       sizeof(tmp_addr.s_addr));
-					mptcp_gws->len[k]++;
-					j =3D 0;
-					tmp_string[j] =3D '\0';
-					/* Since we can't impose a limit to
-					 * what the user can input, make sure
-					 * there are not too many IPs in the
-					 * SYSCTL string.
-					 */
-					if (mptcp_gws->len[k] > MPTCP_GW_LIST_MAX_LEN) {
-						mptcp_debug("mptcp_parse_gateway_list too many members in list %i: m=
ax %i\n",
-							    k,
-							    MPTCP_GW_LIST_MAX_LEN);
-						goto error;
-					}
-				} else {
-					goto error;
-				}
-			}
-
-			if (gateways[i] =3D=3D '-' || gateways[i] =3D=3D '\0')
-				++k;
-		} else {
-			tmp_string[j] =3D gateways[i];
-			++j;
-		}
-	}
-
-	/* Number of flows is number of gateway lists plus master flow */
-	mptcp_binder_ndiffports =3D k+1;
-
-	write_unlock(&mptcp_gws_lock);
-	kfree(tmp_string);
-
-	return 0;
-
-error:
-	memset(mptcp_gws, 0, sizeof(struct mptcp_gw_list));
-	memset(gateways, 0, sizeof(char) * MPTCP_GW_SYSCTL_MAX_LEN);
-	write_unlock(&mptcp_gws_lock);
-	kfree(tmp_string);
-	return -1;
-}
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
-	const struct binder_priv *pm_priv =3D container_of(work,
-						     struct binder_priv,
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
-	if (mptcp_binder_ndiffports > iter &&
-	    mptcp_binder_ndiffports > mpcb->cnt_subflows) {
-		struct mptcp_loc4 loc;
-		struct mptcp_rem4 rem;
-
-		loc.addr.s_addr =3D inet_sk(meta_sk)->inet_saddr;
-		loc.loc4_id =3D 0;
-		loc.low_prio =3D 0;
-
-		rem.addr.s_addr =3D inet_sk(meta_sk)->inet_daddr;
-		rem.port =3D inet_sk(meta_sk)->inet_dport;
-		rem.rem4_id =3D 0; /* Default 0 */
-
-		mptcp_init4_subsockets(meta_sk, &loc, &rem);
-
-		goto next_subflow;
-	}
-
-exit:
-	release_sock(meta_sk);
-	mutex_unlock(&mpcb->mpcb_mutex);
-	sock_put(meta_sk);
-}
-
-static void binder_new_session(const struct sock *meta_sk)
-{
-	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
-	struct binder_priv *fmp =3D (struct binder_priv *)&mpcb->mptcp_pm[0];
-	static DEFINE_SPINLOCK(flow_lock);
-
-#if IS_ENABLED(CONFIG_IPV6)
-	if (meta_sk->sk_family =3D=3D AF_INET6 &&
-	    !mptcp_v6_is_v4_mapped(meta_sk)) {
-			mptcp_fallback_default(mpcb);
-			return;
-	}
-#endif
-
-	/* Initialize workqueue-struct */
-	INIT_WORK(&fmp->subflow_work, create_subflow_worker);
-	fmp->mpcb =3D mpcb;
-
-	fmp->flow_lock =3D &flow_lock;
-}
-
-static void binder_create_subflows(struct sock *meta_sk)
-{
-	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
-	struct binder_priv *pm_priv =3D (struct binder_priv *)&mpcb->mptcp_pm[0];
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
-static int binder_get_local_id(sa_family_t family, union inet_addr *addr,
-				  struct net *net, bool *low_prio)
-{
-	return 0;
-}
-
-/* Callback functions, executed when syctl mptcp.mptcp_gateways is updated.
- * Inspired from proc_tcp_congestion_control().
- */
-static int proc_mptcp_gateways(struct ctl_table *ctl, int write,
-			       void __user *buffer, size_t *lenp,
-			       loff_t *ppos)
-{
-	int ret;
-	struct ctl_table tbl =3D {
-		.maxlen =3D MPTCP_GW_SYSCTL_MAX_LEN,
-	};
-
-	if (write) {
-		tbl.data =3D kzalloc(MPTCP_GW_SYSCTL_MAX_LEN, GFP_KERNEL);
-		if (tbl.data =3D=3D NULL)
-			return -ENOMEM;
-		ret =3D proc_dostring(&tbl, write, buffer, lenp, ppos);
-		if (ret =3D=3D 0) {
-			ret =3D mptcp_parse_gateway_ipv4(tbl.data);
-			memcpy(ctl->data, tbl.data, MPTCP_GW_SYSCTL_MAX_LEN);
-		}
-		kfree(tbl.data);
-	} else {
-		ret =3D proc_dostring(ctl, write, buffer, lenp, ppos);
-	}
-
-
-	return ret;
-}
-
-static struct mptcp_pm_ops binder __read_mostly =3D {
-	.new_session =3D binder_new_session,
-	.fully_established =3D binder_create_subflows,
-	.get_local_id =3D binder_get_local_id,
-	.init_subsocket_v4 =3D mptcp_v4_add_lsrr,
-	.name =3D "binder",
-	.owner =3D THIS_MODULE,
-};
-
-static struct ctl_table binder_table[] =3D {
-	{
-		.procname =3D "mptcp_binder_gateways",
-		.data =3D &sysctl_mptcp_binder_gateways,
-		.maxlen =3D sizeof(char) * MPTCP_GW_SYSCTL_MAX_LEN,
-		.mode =3D 0644,
-		.proc_handler =3D &proc_mptcp_gateways
-	},
-	{ }
-};
-
-static struct ctl_table_header *mptcp_sysctl_binder;
-
-/* General initialization of MPTCP_PM */
-static int __init binder_register(void)
-{
-	mptcp_gws =3D kzalloc(sizeof(*mptcp_gws), GFP_KERNEL);
-	if (!mptcp_gws)
-		return -ENOMEM;
-
-	rwlock_init(&mptcp_gws_lock);
-
-	BUILD_BUG_ON(sizeof(struct binder_priv) > MPTCP_PM_SIZE);
-
-	mptcp_sysctl_binder =3D register_net_sysctl(&init_net, "net/mptcp",
-			binder_table);
-	if (!mptcp_sysctl_binder)
-		goto sysctl_fail;
-
-	if (mptcp_register_path_manager(&binder))
-		goto pm_failed;
-
-	return 0;
-
-pm_failed:
-	unregister_net_sysctl_table(mptcp_sysctl_binder);
-sysctl_fail:
-	kfree(mptcp_gws);
-
-	return -1;
-}
-
-static void binder_unregister(void)
-{
-	mptcp_unregister_path_manager(&binder);
-	unregister_net_sysctl_table(mptcp_sysctl_binder);
-	kfree(mptcp_gws);
-}
-
-module_init(binder_register);
-module_exit(binder_unregister);
-
-MODULE_AUTHOR("Luca Boccassi, Duncan Eastoe, Christoph Paasch (ndiffports)=
");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("BINDER MPTCP");
-MODULE_VERSION("0.1");
-- =

2.16.2


--===============0563083529575725141==--
