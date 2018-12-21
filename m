Content-Type: multipart/mixed; boundary="===============1287340542488881547=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 mptcp-net-next 10/12] mptcp: Remove
 scheduler-selection support
Date: Fri, 21 Dec 2018 08:13:36 -0800
Message-ID: <20181221161338.72325-11-cpaasch@apple.com>
In-Reply-To: 20181221161338.72325-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 961

--===============1287340542488881547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/linux/tcp.h      |   3 -
 include/net/mptcp.h      |  41 ++-------
 include/uapi/linux/tcp.h |   1 -
 net/ipv4/tcp.c           |  46 ----------
 net/mptcp/Kconfig        |  32 -------
 net/mptcp/mptcp_ctrl.c   |  35 +-------
 net/mptcp/mptcp_output.c |   7 +-
 net/mptcp/mptcp_sched.c  | 223 ++++---------------------------------------=
----
 8 files changed, 28 insertions(+), 360 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 01321044047c..02af5c56d2e6 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -476,17 +476,14 @@ struct tcp_sock {
 		close_it:1,	/* Must close socket in mptcp_data_ready? */
 		closing:1,
 		mptcp_ver:4,
-		mptcp_sched_setsockopt:1,
 		mptcp_pm_setsockopt:1,
 		record_master_info:1;
 	struct mptcp_tcp_sock *mptcp;
 #ifdef CONFIG_MPTCP
-#define MPTCP_SCHED_NAME_MAX 16
 #define MPTCP_PM_NAME_MAX 16
 	struct hlist_nulls_node tk_table;
 	u32		mptcp_loc_token;
 	u64		mptcp_loc_key;
-	char		mptcp_sched_name[MPTCP_SCHED_NAME_MAX];
 	char		mptcp_pm_name[MPTCP_PM_NAME_MAX];
 #endif /* CONFIG_MPTCP */
 };
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 136f18ce1d8e..c863f6d48a4c 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -170,8 +170,7 @@ struct mptcp_tcp_sock {
 	u8	loc_id;
 	u8	rem_id;
 =

-#define MPTCP_SCHED_SIZE 4
-	u8	mptcp_sched[MPTCP_SCHED_SIZE] __aligned(8);
+	u32	last_rbuf_opti;
 =

 	int	init_rcv_wnd;
 	u32	infinite_cutoff_seq;
@@ -219,23 +218,6 @@ struct mptcp_pm_ops {
 	struct module	*owner;
 };
 =

-#define MPTCP_SCHED_NAME_MAX 16
-struct mptcp_sched_ops {
-	struct list_head list;
-
-	struct sock *		(*get_subflow)(struct sock *meta_sk,
-					       struct sk_buff *skb,
-					       bool zero_wnd_test);
-	struct sk_buff *	(*next_segment)(struct sock *meta_sk,
-						int *reinject,
-						struct sock **subsk,
-						unsigned int *limit);
-	void			(*init)(struct sock *sk);
-
-	char			name[MPTCP_SCHED_NAME_MAX];
-	struct module		*owner;
-};
-
 struct mptcp_cb {
 	/* list of sockets in this multipath connection */
 	struct hlist_head conn_list;
@@ -261,10 +243,6 @@ struct mptcp_cb {
 		snd_hiseq_index:1, /* Index in snd_high_order of snd_nxt */
 		rcv_hiseq_index:1; /* Index in rcv_high_order of rcv_nxt */
 =

-#define MPTCP_SCHED_DATA_SIZE 8
-	u8 mptcp_sched[MPTCP_SCHED_DATA_SIZE] __aligned(8);
-	struct mptcp_sched_ops *sched_ops;
-
 	u64	infinite_rcv_seq;
 =

 	/***** Start of fields, used for connection closure */
@@ -817,19 +795,18 @@ void mptcp_init_path_manager(struct mptcp_cb *mpcb);
 void mptcp_cleanup_path_manager(struct mptcp_cb *mpcb);
 void mptcp_fallback_default(struct mptcp_cb *mpcb);
 void mptcp_get_default_path_manager(char *name);
-int mptcp_set_scheduler(struct sock *sk, const char *name);
 int mptcp_set_path_manager(struct sock *sk, const char *name);
 int mptcp_set_default_path_manager(const char *name);
 extern struct mptcp_pm_ops mptcp_pm_default;
 =

-/* MPTCP-scheduler registration/initialization functions */
-int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
-void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
-void mptcp_init_scheduler(struct mptcp_cb *mpcb);
-void mptcp_cleanup_scheduler(struct mptcp_cb *mpcb);
-void mptcp_get_default_scheduler(char *name);
-int mptcp_set_default_scheduler(const char *name);
-extern struct mptcp_sched_ops mptcp_sched_default;
+void mptcp_sched_init(struct sock *sk);
+struct sock *mptcp_get_available_subflow(struct sock *meta_sk,
+					 struct sk_buff *skb,
+					 bool zero_wnd_test);
+struct sk_buff *mptcp_next_segment(struct sock *meta_sk,
+				   int *reinject,
+				   struct sock **subsk,
+				   unsigned int *limit);
 =

 /* Initializes function-pointers and MPTCP-flags */
 static inline void mptcp_init_tcp_sock(struct sock *sk)
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 072ce786a0fd..2fcfa2257cc9 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -134,7 +134,6 @@ enum {
 #define TCP_CM_INQ		TCP_INQ
 =

 #define MPTCP_ENABLED		42
-#define MPTCP_SCHEDULER		43
 #define MPTCP_PATH_MANAGER	44
 #define MPTCP_INFO		45
 =

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b2dac73903be..3f570b2c7eea 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2802,33 +2802,6 @@ static int do_tcp_setsockopt(struct sock *sk, int le=
vel,
 		return tcp_fastopen_reset_cipher(net, sk, key, sizeof(key));
 	}
 #ifdef CONFIG_MPTCP
-	case MPTCP_SCHEDULER: {
-		char name[MPTCP_SCHED_NAME_MAX];
-
-		if (optlen < 1)
-			return -EINVAL;
-
-		/* Cannot be used if MPTCP is not used or we already have
-		 * established an MPTCP-connection.
-		 */
-		if (mptcp_init_failed || !sysctl_mptcp_enabled ||
-		    sk->sk_state !=3D TCP_CLOSE)
-			return -EPERM;
-
-		val =3D strncpy_from_user(name, optval,
-					min_t(long, MPTCP_SCHED_NAME_MAX - 1,
-					      optlen));
-
-		if (val < 0)
-			return -EFAULT;
-		name[val] =3D 0;
-
-		lock_sock(sk);
-		err =3D mptcp_set_scheduler(sk, name);
-		release_sock(sk);
-		return err;
-	}
-
 	case MPTCP_PATH_MANAGER: {
 		char name[MPTCP_PM_NAME_MAX];
 =

@@ -3688,25 +3661,6 @@ static int do_tcp_getsockopt(struct sock *sk, int le=
vel,
 	}
 #endif
 #ifdef CONFIG_MPTCP
-	case MPTCP_SCHEDULER:
-		if (get_user(len, optlen))
-			return -EFAULT;
-		len =3D min_t(unsigned int, len, MPTCP_SCHED_NAME_MAX);
-		if (put_user(len, optlen))
-			return -EFAULT;
-
-		if (mptcp(tcp_sk(sk))) {
-			struct mptcp_cb *mpcb =3D tcp_sk(mptcp_meta_sk(sk))->mpcb;
-
-			if (copy_to_user(optval, mpcb->sched_ops->name, len))
-				return -EFAULT;
-		} else {
-			if (copy_to_user(optval, tcp_sk(sk)->mptcp_sched_name,
-					 len))
-				return -EFAULT;
-		}
-		return 0;
-
 	case MPTCP_PATH_MANAGER:
 		if (get_user(len, optlen))
 			return -EFAULT;
diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index 9c490ec8fba8..860e9e17f76f 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -57,35 +57,3 @@ config DEFAULT_MPTCP_PM
 	default "ndiffports" if DEFAULT_NDIFFPORTS
 	default "default"
 =

-menuconfig MPTCP_SCHED_ADVANCED
-	bool "MPTCP: advanced scheduler control"
-	depends on MPTCP=3Dy
-	---help---
-	  Support for selection of different schedulers. You should choose 'Y' he=
re,
-	  if you want to choose a different scheduler than the default one.
-
-if MPTCP_SCHED_ADVANCED
-
-choice
-	prompt "Default MPTCP Scheduler"
-	default DEFAULT
-	help
-	  Select the Scheduler of your choice
-
-	config DEFAULT_SCHEDULER
-		bool "Default"
-		---help---
-		  This is the default scheduler, sending first on the subflow
-		  with the lowest RTT.
-
-endchoice
-endif
-
-config DEFAULT_MPTCP_SCHED
-	string
-	depends on (MPTCP=3Dy)
-	default "default" if DEFAULT_SCHEDULER
-	default "roundrobin" if DEFAULT_ROUNDROBIN
-	default "redundant" if DEFAULT_REDUNDANT
-	default "default"
-
diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index cc07fbf00dbf..0dcccfe75092 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -94,25 +94,6 @@ static int proc_mptcp_path_manager(struct ctl_table *ctl=
, int write,
 	return ret;
 }
 =

-static int proc_mptcp_scheduler(struct ctl_table *ctl, int write,
-				void __user *buffer, size_t *lenp,
-				loff_t *ppos)
-{
-	char val[MPTCP_SCHED_NAME_MAX];
-	struct ctl_table tbl =3D {
-		.data =3D val,
-		.maxlen =3D MPTCP_SCHED_NAME_MAX,
-	};
-	int ret;
-
-	mptcp_get_default_scheduler(val);
-
-	ret =3D proc_dostring(&tbl, write, buffer, lenp, ppos);
-	if (write && ret =3D=3D 0)
-		ret =3D mptcp_set_default_scheduler(val);
-	return ret;
-}
-
 static struct ctl_table mptcp_table[] =3D {
 	{
 		.procname =3D "mptcp_enabled",
@@ -150,12 +131,6 @@ static struct ctl_table mptcp_table[] =3D {
 		.maxlen		=3D MPTCP_PM_NAME_MAX,
 		.proc_handler	=3D proc_mptcp_path_manager,
 	},
-	{
-		.procname	=3D "mptcp_scheduler",
-		.mode		=3D 0644,
-		.maxlen		=3D MPTCP_SCHED_NAME_MAX,
-		.proc_handler	=3D proc_mptcp_scheduler,
-	},
 	{ }
 };
 =

@@ -604,7 +579,6 @@ static void mptcp_mpcb_put(struct mptcp_cb *mpcb)
 {
 	if (refcount_dec_and_test(&mpcb->mpcb_refcnt)) {
 		mptcp_cleanup_path_manager(mpcb);
-		mptcp_cleanup_scheduler(mpcb);
 		kfree(mpcb->master_info);
 		kmem_cache_free(mptcp_cb_cache, mpcb);
 	}
@@ -1276,7 +1250,6 @@ static int mptcp_alloc_mpcb(struct sock *meta_sk, __u=
64 remote_key,
 	refcount_set(&mpcb->mpcb_refcnt, 1);
 =

 	mptcp_init_path_manager(mpcb);
-	mptcp_init_scheduler(mpcb);
 =

 	if (!try_module_get(inet_csk(master_sk)->icsk_ca_ops->owner))
 		tcp_assign_congestion_control(master_sk);
@@ -1344,8 +1317,7 @@ int mptcp_add_sock(struct sock *meta_sk, struct sock =
*sk, u8 loc_id, u8 rem_id,
 =

 	tp->mptcp->loc_id =3D loc_id;
 	tp->mptcp->rem_id =3D rem_id;
-	if (mpcb->sched_ops->init)
-		mpcb->sched_ops->init(sk);
+	mptcp_sched_init(sk);
 =

 	/* The corresponding sock_put is in mptcp_sock_destruct(). It cannot be
 	 * included in mptcp_del_sock(), because the mpcb must remain alive
@@ -2822,17 +2794,12 @@ void __init mptcp_init(void)
 	if (mptcp_register_path_manager(&mptcp_pm_default))
 		goto register_pm_failed;
 =

-	if (mptcp_register_scheduler(&mptcp_sched_default))
-		goto register_sched_failed;
-
 	pr_info("MPTCP: Unstable branch");
 =

 	mptcp_init_failed =3D false;
 =

 	return;
 =

-register_sched_failed:
-	mptcp_unregister_path_manager(&mptcp_pm_default);
 register_pm_failed:
 	unregister_net_sysctl_table(mptcp_sysctl);
 register_sysctl_failed:
diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index 2d84eb2edd97..00a3674ad693 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -306,7 +306,7 @@ int mptcp_write_wakeup(struct sock *meta_sk, int mib)
 	    before(TCP_SKB_CB(skb)->seq, tcp_wnd_end(meta_tp))) {
 		unsigned int mss;
 		unsigned int seg_size =3D tcp_wnd_end(meta_tp) - TCP_SKB_CB(skb)->seq;
-		struct sock *subsk =3D meta_tp->mpcb->sched_ops->get_subflow(meta_sk, sk=
b, true);
+		struct sock *subsk =3D mptcp_get_available_subflow(meta_sk, skb, true);
 		struct tcp_sock *subtp;
 =

 		WARN_ON(TCP_SKB_CB(skb)->sacked);
@@ -395,8 +395,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned in=
t mss_now, int nonagle,
 =

 	tcp_mstamp_refresh(meta_tp);
 =

-	while ((skb =3D mpcb->sched_ops->next_segment(meta_sk, &reinject, &subsk,
-						    &sublimit))) {
+	while ((skb =3D mptcp_next_segment(meta_sk, &reinject, &subsk, &sublimit)=
)) {
 		enum tcp_queue tcp_queue =3D TCP_FRAG_IN_WRITE_QUEUE;
 		unsigned int limit;
 =

@@ -1111,7 +1110,7 @@ int mptcp_retransmit_skb(struct sock *meta_sk, struct=
 sk_buff *skb)
 	/* We need to make sure that the retransmitted segment can be sent on a
 	 * subflow right now. If it is too big, it needs to be fragmented.
 	 */
-	subsk =3D meta_tp->mpcb->sched_ops->get_subflow(meta_sk, skb, false);
+	subsk =3D mptcp_get_available_subflow(meta_sk, skb, false);
 	if (!subsk) {
 		/* We want to increase icsk_retransmits, thus return 0, so that
 		 * mptcp_meta_retransmit_timer enters the desired branch.
diff --git a/net/mptcp/mptcp_sched.c b/net/mptcp/mptcp_sched.c
index 7f19b4b4bea0..1e26518e2b89 100644
--- a/net/mptcp/mptcp_sched.c
+++ b/net/mptcp/mptcp_sched.c
@@ -1,20 +1,6 @@
-/* MPTCP Scheduler module selector. Highly inspired by tcp_cong.c */
-
 #include <linux/module.h>
 #include <net/mptcp.h>
 =

-static DEFINE_SPINLOCK(mptcp_sched_list_lock);
-static LIST_HEAD(mptcp_sched_list);
-
-struct defsched_priv {
-	u32	last_rbuf_opti;
-};
-
-static struct defsched_priv *defsched_get_priv(const struct tcp_sock *tp)
-{
-	return (struct defsched_priv *)&tp->mptcp->mptcp_sched[0];
-}
-
 static bool mptcp_is_def_unavailable(struct sock *sk)
 {
 	const struct tcp_sock *tp =3D tcp_sk(sk);
@@ -192,9 +178,9 @@ static struct sock
  * The flow is selected based on the shortest RTT.
  * If all paths have full cong windows, we simply return NULL.
  */
-static struct sock *get_available_subflow(struct sock *meta_sk,
-					  struct sk_buff *skb,
-					  bool zero_wnd_test)
+struct sock *mptcp_get_available_subflow(struct sock *meta_sk,
+					 struct sk_buff *skb,
+					 bool zero_wnd_test)
 {
 	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
 	struct sock *sk;
@@ -239,11 +225,10 @@ static struct sock *get_available_subflow(struct sock=
 *meta_sk,
 =

 static struct sk_buff *mptcp_rcv_buf_optimization(struct sock *sk, int pen=
al)
 {
-	struct sock *meta_sk;
 	const struct tcp_sock *tp =3D tcp_sk(sk);
 	struct mptcp_tcp_sock *mptcp;
 	struct sk_buff *skb_head;
-	struct defsched_priv *dsp =3D defsched_get_priv(tp);
+	struct sock *meta_sk;
 =

 	meta_sk =3D mptcp_meta_sk(sk);
 	skb_head =3D tcp_rtx_queue_head(meta_sk);
@@ -260,7 +245,7 @@ static struct sk_buff *mptcp_rcv_buf_optimization(struc=
t sock *sk, int penal)
 		goto retrans;
 =

 	/* Only penalize again after an RTT has elapsed */
-	if (tcp_jiffies32 - dsp->last_rbuf_opti < usecs_to_jiffies(tp->srtt_us >>=
 3))
+	if (tcp_jiffies32 - tp->mptcp->last_rbuf_opti < usecs_to_jiffies(tp->srtt=
_us >> 3))
 		goto retrans;
 =

 	/* Half the cwnd of the slow flow */
@@ -278,7 +263,7 @@ static struct sk_buff *mptcp_rcv_buf_optimization(struc=
t sock *sk, int penal)
 				if (prior_cwnd >=3D tp_it->snd_ssthresh)
 					tp_it->snd_ssthresh =3D max(tp_it->snd_ssthresh >> 1U, 2U);
 =

-				dsp->last_rbuf_opti =3D tcp_jiffies32;
+				tp->mptcp->last_rbuf_opti =3D tcp_jiffies32;
 			}
 			break;
 		}
@@ -338,8 +323,8 @@ static struct sk_buff *__mptcp_next_segment(struct sock=
 *meta_sk, int *reinject)
 	if (!skb && meta_sk->sk_socket &&
 	    test_bit(SOCK_NOSPACE, &meta_sk->sk_socket->flags) &&
 	    sk_stream_wspace(meta_sk) < sk_stream_min_wspace(meta_sk)) {
-		struct sock *subsk =3D get_available_subflow(meta_sk, NULL,
-							   false);
+		struct sock *subsk =3D mptcp_get_available_subflow(meta_sk, NULL,
+								 false);
 		if (!subsk)
 			return NULL;
 =

@@ -350,10 +335,10 @@ static struct sk_buff *__mptcp_next_segment(struct so=
ck *meta_sk, int *reinject)
 	return skb;
 }
 =

-static struct sk_buff *mptcp_next_segment(struct sock *meta_sk,
-					  int *reinject,
-					  struct sock **subsk,
-					  unsigned int *limit)
+struct sk_buff *mptcp_next_segment(struct sock *meta_sk,
+				   int *reinject,
+				   struct sock **subsk,
+				   unsigned int *limit)
 {
 	struct sk_buff *skb =3D __mptcp_next_segment(meta_sk, reinject);
 	unsigned int mss_now;
@@ -367,7 +352,7 @@ static struct sk_buff *mptcp_next_segment(struct sock *=
meta_sk,
 	if (!skb)
 		return NULL;
 =

-	*subsk =3D get_available_subflow(meta_sk, skb, false);
+	*subsk =3D mptcp_get_available_subflow(meta_sk, skb, false);
 	if (!*subsk)
 		return NULL;
 =

@@ -415,185 +400,7 @@ static struct sk_buff *mptcp_next_segment(struct sock=
 *meta_sk,
 	return skb;
 }
 =

-static void defsched_init(struct sock *sk)
-{
-	struct defsched_priv *dsp =3D defsched_get_priv(tcp_sk(sk));
-
-	dsp->last_rbuf_opti =3D tcp_jiffies32;
-}
-
-struct mptcp_sched_ops mptcp_sched_default =3D {
-	.get_subflow =3D get_available_subflow,
-	.next_segment =3D mptcp_next_segment,
-	.init =3D defsched_init,
-	.name =3D "default",
-	.owner =3D THIS_MODULE,
-};
-
-static struct mptcp_sched_ops *mptcp_sched_find(const char *name)
-{
-	struct mptcp_sched_ops *e;
-
-	list_for_each_entry_rcu(e, &mptcp_sched_list, list) {
-		if (strcmp(e->name, name) =3D=3D 0)
-			return e;
-	}
-
-	return NULL;
-}
-
-int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
-{
-	int ret =3D 0;
-
-	if (!sched->get_subflow || !sched->next_segment)
-		return -EINVAL;
-
-	spin_lock(&mptcp_sched_list_lock);
-	if (mptcp_sched_find(sched->name)) {
-		pr_notice("%s already registered\n", sched->name);
-		ret =3D -EEXIST;
-	} else {
-		list_add_tail_rcu(&sched->list, &mptcp_sched_list);
-		pr_info("%s registered\n", sched->name);
-	}
-	spin_unlock(&mptcp_sched_list_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mptcp_register_scheduler);
-
-void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
-{
-	spin_lock(&mptcp_sched_list_lock);
-	list_del_rcu(&sched->list);
-	spin_unlock(&mptcp_sched_list_lock);
-
-	/* Wait for outstanding readers to complete before the
-	 * module gets removed entirely.
-	 *
-	 * A try_module_get() should fail by now as our module is
-	 * in "going" state since no refs are held anymore and
-	 * module_exit() handler being called.
-	 */
-	synchronize_rcu();
-}
-EXPORT_SYMBOL_GPL(mptcp_unregister_scheduler);
-
-void mptcp_get_default_scheduler(char *name)
-{
-	struct mptcp_sched_ops *sched;
-
-	BUG_ON(list_empty(&mptcp_sched_list));
-
-	rcu_read_lock();
-	sched =3D list_entry(mptcp_sched_list.next, struct mptcp_sched_ops, list);
-	strncpy(name, sched->name, MPTCP_SCHED_NAME_MAX);
-	rcu_read_unlock();
-}
-
-int mptcp_set_default_scheduler(const char *name)
-{
-	struct mptcp_sched_ops *sched;
-	int ret =3D -ENOENT;
-
-	spin_lock(&mptcp_sched_list_lock);
-	sched =3D mptcp_sched_find(name);
-#ifdef CONFIG_MODULES
-	if (!sched && capable(CAP_NET_ADMIN)) {
-		spin_unlock(&mptcp_sched_list_lock);
-
-		request_module("mptcp_%s", name);
-		spin_lock(&mptcp_sched_list_lock);
-		sched =3D mptcp_sched_find(name);
-	}
-#endif
-
-	if (sched) {
-		list_move(&sched->list, &mptcp_sched_list);
-		ret =3D 0;
-	} else {
-		pr_info("%s is not available\n", name);
-	}
-	spin_unlock(&mptcp_sched_list_lock);
-
-	return ret;
-}
-
-/* Must be called with rcu lock held */
-static struct mptcp_sched_ops *__mptcp_sched_find_autoload(const char *nam=
e)
-{
-	struct mptcp_sched_ops *sched =3D mptcp_sched_find(name);
-#ifdef CONFIG_MODULES
-	if (!sched && capable(CAP_NET_ADMIN)) {
-		rcu_read_unlock();
-		request_module("mptcp_%s", name);
-		rcu_read_lock();
-		sched =3D mptcp_sched_find(name);
-	}
-#endif
-	return sched;
-}
-
-void mptcp_init_scheduler(struct mptcp_cb *mpcb)
-{
-	struct mptcp_sched_ops *sched;
-	struct sock *meta_sk =3D mpcb->meta_sk;
-	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-
-	rcu_read_lock();
-	/* if scheduler was set using socket option */
-	if (meta_tp->mptcp_sched_setsockopt) {
-		sched =3D __mptcp_sched_find_autoload(meta_tp->mptcp_sched_name);
-		if (sched && try_module_get(sched->owner)) {
-			mpcb->sched_ops =3D sched;
-			goto out;
-		}
-	}
-
-	list_for_each_entry_rcu(sched, &mptcp_sched_list, list) {
-		if (try_module_get(sched->owner)) {
-			mpcb->sched_ops =3D sched;
-			break;
-		}
-	}
-out:
-	rcu_read_unlock();
-}
-
-/* Change scheduler for socket */
-int mptcp_set_scheduler(struct sock *sk, const char *name)
-{
-	struct mptcp_sched_ops *sched;
-	int err =3D 0;
-
-	rcu_read_lock();
-	sched =3D __mptcp_sched_find_autoload(name);
-
-	if (!sched) {
-		err =3D -ENOENT;
-	} else if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
-		err =3D -EPERM;
-	} else {
-		strcpy(tcp_sk(sk)->mptcp_sched_name, name);
-		tcp_sk(sk)->mptcp_sched_setsockopt =3D 1;
-	}
-	rcu_read_unlock();
-
-	return err;
-}
-
-/* Manage refcounts on socket close. */
-void mptcp_cleanup_scheduler(struct mptcp_cb *mpcb)
+void mptcp_sched_init(struct sock *sk)
 {
-	module_put(mpcb->sched_ops->owner);
-}
-
-/* Set default value from kernel configuration at bootup */
-static int __init mptcp_scheduler_default(void)
-{
-	BUILD_BUG_ON(sizeof(struct defsched_priv) > MPTCP_SCHED_SIZE);
-
-	return mptcp_set_default_scheduler(CONFIG_DEFAULT_MPTCP_SCHED);
+	tcp_sk(sk)->mptcp->last_rbuf_opti =3D tcp_jiffies32;
 }
-late_initcall(mptcp_scheduler_default);
-- =

2.16.2


--===============1287340542488881547==--
