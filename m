Content-Type: multipart/mixed; boundary="===============2242019727998819505=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 12/12] mptcp: Make path-management no more a
 module nor selectable through socketops
Date: Thu, 06 Dec 2018 14:38:19 -0800
Message-ID: <20181206223819.GP41383@MacBook-Pro-19.local>
In-Reply-To: 20181206010023.18819-13-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 890

--===============2242019727998819505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/12/18 - 17:00:23, Christoph Paasch wrote:
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
>  include/linux/tcp.h        |   3 -
>  include/net/mptcp.h        |  94 ++++++++------
>  include/net/netns/mptcp.h  |   8 +-
>  net/ipv4/tcp.c             |  47 -------
>  net/ipv4/tcp_input.c       |   4 +-
>  net/ipv4/tcp_output.c      |   3 +-
>  net/mptcp/Kconfig          |  37 ------
>  net/mptcp/Makefile         |   4 +-
>  net/mptcp/mptcp_ctrl.c     |  49 +-------
>  net/mptcp/mptcp_fullmesh.c | 305 ++++-----------------------------------=
------
>  net/mptcp/mptcp_input.c    |  27 ++--
>  net/mptcp/mptcp_ipv4.c     |   2 +-
>  net/mptcp/mptcp_ipv6.c     |   2 +-
>  net/mptcp/mptcp_output.c   |   8 +-
>  net/mptcp/mptcp_pm.c       | 226 ---------------------------------
>  15 files changed, 109 insertions(+), 710 deletions(-)
>  delete mode 100644 net/mptcp/mptcp_pm.c
> =

> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 02af5c56d2e6..84ec344fe184 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -476,15 +476,12 @@ struct tcp_sock {
>  		close_it:1,	/* Must close socket in mptcp_data_ready? */
>  		closing:1,
>  		mptcp_ver:4,
> -		mptcp_pm_setsockopt:1,
>  		record_master_info:1;
>  	struct mptcp_tcp_sock *mptcp;
>  #ifdef CONFIG_MPTCP
> -#define MPTCP_PM_NAME_MAX 16
>  	struct hlist_nulls_node tk_table;
>  	u32		mptcp_loc_token;
>  	u64		mptcp_loc_key;
> -	char		mptcp_pm_name[MPTCP_PM_NAME_MAX];
>  #endif /* CONFIG_MPTCP */
>  };
>  =

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 90a9e220702a..7ea8539384e5 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -195,27 +195,50 @@ struct mptcp_tw {
>  	   in_list:1;
>  };
>  =

> -#define MPTCP_PM_NAME_MAX 16
> -struct mptcp_pm_ops {
> -	struct list_head list;
> +struct fullmesh_rem4 {
> +	u8		rem4_id;
> +	u8		bitfield;
> +	u8		retry_bitfield;
> +	__be16		port;
> +	struct in_addr	addr;
> +};
>  =

> -	/* Signal the creation of a new MPTCP-session. */
> -	void (*new_session)(const struct sock *meta_sk);
> -	void (*release_sock)(struct sock *meta_sk);
> -	void (*fully_established)(struct sock *meta_sk);
> -	void (*new_remote_address)(struct sock *meta_sk);
> -	void (*subflow_error)(struct sock *meta_sk, struct sock *sk);
> -	int  (*get_local_id)(sa_family_t family, union inet_addr *addr,
> -			     struct net *net);
> -	void (*addr_signal)(struct sock *sk, unsigned *size,
> -			    struct tcp_out_options *opts, struct sk_buff *skb);
> -	void (*add_raddr)(struct mptcp_cb *mpcb, const union inet_addr *addr,
> -			  sa_family_t family, __be16 port, u8 id);
> -	void (*rem_raddr)(struct mptcp_cb *mpcb, u8 rem_id);
> -	void (*delete_subflow)(struct sock *sk);
> -
> -	char		name[MPTCP_PM_NAME_MAX];
> -	struct module	*owner;
> +struct fullmesh_rem6 {
> +	u8		rem6_id;
> +	u8		bitfield;
> +	u8		retry_bitfield;
> +	__be16		port;
> +	struct in6_addr	addr;
> +};
> +
> +/* Max number of local or remote addresses we can store.
> + * When changing, see the bitfield below in fullmesh_rem4/6.
> + */
> +#define MPTCP_MAX_ADDR	8
> +
> +struct fullmesh_priv {
> +	/* Worker struct for subflow establishment */
> +	struct work_struct subflow_work;
> +	/* Delayed worker, when the routing-tables are not yet ready. */
> +	struct delayed_work subflow_retry_work;
> +
> +	/* Remote addresses */
> +	struct fullmesh_rem4 remaddr4[MPTCP_MAX_ADDR];
> +	struct fullmesh_rem6 remaddr6[MPTCP_MAX_ADDR];
> +
> +	struct mptcp_cb *mpcb;
> +
> +	u16 remove_addrs; /* Addresses to remove */
> +	u8 announced_addrs_v4; /* IPv4 Addresses we did announce */
> +	u8 announced_addrs_v6; /* IPv6 Addresses we did announce */
> +
> +	u8	add_addr; /* Are we sending an add_addr? */
> +
> +	u8 rem4_bits;
> +	u8 rem6_bits;
> +
> +	/* Have we established the additional subflows for primary pair? */
> +	u8 first_pair:1;
>  };
>  =

>  struct mptcp_cb {
> @@ -273,9 +296,7 @@ struct mptcp_cb {
>  	__u32	mptcp_loc_token;
>  	__u32	mptcp_rem_token;
>  =

> -#define MPTCP_PM_SIZE 608
> -	u8 mptcp_pm[MPTCP_PM_SIZE] __aligned(8);
> -	struct mptcp_pm_ops *pm_ops;
> +	struct fullmesh_priv fmp;
>  =

>  	unsigned long path_index_bits;
>  =

> @@ -690,7 +711,6 @@ void mptcp_cleanup_rbuf(struct sock *meta_sk, int cop=
ied);
>  int mptcp_add_sock(struct sock *meta_sk, struct sock *sk, u8 loc_id, u8 =
rem_id,
>  		   gfp_t flags);
>  void mptcp_del_sock(struct sock *sk);
> -void mptcp_update_metasocket(const struct sock *meta_sk);
>  void mptcp_update_sndbuf(const struct tcp_sock *tp);
>  void mptcp_send_fin(struct sock *meta_sk);
>  void mptcp_send_active_reset(struct sock *meta_sk, gfp_t priority);
> @@ -793,16 +813,19 @@ int mptcp_finish_handshake(struct sock *child, stru=
ct sk_buff *skb);
>  int mptcp_get_info(const struct sock *meta_sk, char __user *optval, int =
optlen);
>  void mptcp_clear_sk(struct sock *sk, int size);
>  =

> -/* MPTCP-path-manager registration/initialization functions */
> -int mptcp_register_path_manager(struct mptcp_pm_ops *pm);
> -void mptcp_unregister_path_manager(struct mptcp_pm_ops *pm);
> -void mptcp_init_path_manager(struct mptcp_cb *mpcb);
> -void mptcp_cleanup_path_manager(struct mptcp_cb *mpcb);
> -void mptcp_fallback_default(struct mptcp_cb *mpcb);
> -void mptcp_get_default_path_manager(char *name);
> -int mptcp_set_path_manager(struct sock *sk, const char *name);
> -int mptcp_set_default_path_manager(const char *name);
> -extern struct mptcp_pm_ops mptcp_pm_default;
> +int __init full_mesh_register(void);
> +void full_mesh_new_session(const struct sock *meta_sk);
> +void full_mesh_release_sock(struct sock *meta_sk);
> +void full_mesh_create_subflows(struct sock *meta_sk);
> +int full_mesh_get_local_id(sa_family_t family, union inet_addr *addr,
> +			   struct net *net);
> +void full_mesh_addr_signal(struct sock *sk, unsigned *size,
> +			   struct tcp_out_options *opts,
> +			   struct sk_buff *skb);
> +void full_mesh_add_raddr(struct mptcp_cb *mpcb,
> +			 const union inet_addr *addr,
> +			 sa_family_t family, __be16 port, u8 id);
> +void full_mesh_rem_raddr(struct mptcp_cb *mpcb, u8 rem_id);
>  =

>  void mptcp_sched_init(struct sock *sk);
>  struct sock *mptcp_get_available_subflow(struct sock *meta_sk,
> @@ -1223,7 +1246,6 @@ static inline int is_master_tp(const struct tcp_soc=
k *tp)
>  	return 0;
>  }
>  static inline void mptcp_del_sock(const struct sock *sk) {}
> -static inline void mptcp_update_metasocket(const struct sock *meta_sk) {}
>  static inline void mptcp_update_sndbuf(const struct tcp_sock *tp) {}
>  static inline void mptcp_clean_rtx_infinite(const struct sk_buff *skb,
>  					    const struct sock *sk) {}
> @@ -1336,6 +1358,8 @@ static inline bool mptcp_can_new_subflow(const stru=
ct sock *meta_sk)
>  {
>  	return false;
>  }
> +static inline void full_mesh_new_session(const struct sock *meta_sk) {}
> +static inline void full_mesh_release_sock(struct sock *meta_sk) {}
>  =

>  #endif /* CONFIG_MPTCP */
>  =

> diff --git a/include/net/netns/mptcp.h b/include/net/netns/mptcp.h
> index 6680f3bbcfc8..c9dd96de4db5 100644
> --- a/include/net/netns/mptcp.h
> +++ b/include/net/netns/mptcp.h
> @@ -32,12 +32,8 @@
>  =

>  #include <linux/compiler.h>
>  =

> -enum {
> -	MPTCP_PM_FULLMESH =3D 0,
> -	MPTCP_PM_MAX
> -};
> -
>  struct mptcp_mib;
> +struct mptcp_fm_ns;
>  =

>  struct netns_mptcp {
>  	DEFINE_SNMP_STAT(struct mptcp_mib, mptcp_statistics);
> @@ -46,7 +42,7 @@ struct netns_mptcp {
>  	struct proc_dir_entry *proc_net_mptcp;
>  #endif
>  =

> -	void *path_managers[MPTCP_PM_MAX];
> +	struct mptcp_fm_ns *fm_ns;
>  };
>  =

>  #endif /* __NETNS_MPTCP_H__ */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 3f570b2c7eea..76555f8b26fe 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2801,34 +2801,6 @@ static int do_tcp_setsockopt(struct sock *sk, int =
level,
>  =

>  		return tcp_fastopen_reset_cipher(net, sk, key, sizeof(key));
>  	}
> -#ifdef CONFIG_MPTCP
> -	case MPTCP_PATH_MANAGER: {
> -		char name[MPTCP_PM_NAME_MAX];
> -
> -		if (optlen < 1)
> -			return -EINVAL;
> -
> -		/* Cannot be used if MPTCP is not used or we already have
> -		 * established an MPTCP-connection.
> -		 */
> -		if (mptcp_init_failed || !sysctl_mptcp_enabled ||
> -		    sk->sk_state !=3D TCP_CLOSE)
> -			return -EPERM;
> -
> -		val =3D strncpy_from_user(name, optval,
> -					min_t(long, MPTCP_PM_NAME_MAX - 1,
> -					      optlen));
> -
> -		if (val < 0)
> -			return -EFAULT;
> -		name[val] =3D 0;
> -
> -		lock_sock(sk);
> -		err =3D mptcp_set_path_manager(sk, name);
> -		release_sock(sk);
> -		return err;
> -	}
> -#endif
>  	default:
>  		/* fallthru */
>  		break;
> @@ -3661,25 +3633,6 @@ static int do_tcp_getsockopt(struct sock *sk, int =
level,
>  	}
>  #endif
>  #ifdef CONFIG_MPTCP
> -	case MPTCP_PATH_MANAGER:
> -		if (get_user(len, optlen))
> -			return -EFAULT;
> -		len =3D min_t(unsigned int, len, MPTCP_PM_NAME_MAX);
> -		if (put_user(len, optlen))
> -			return -EFAULT;
> -
> -		if (mptcp(tcp_sk(sk))) {
> -			struct mptcp_cb *mpcb =3D tcp_sk(mptcp_meta_sk(sk))->mpcb;
> -
> -			if (copy_to_user(optval, mpcb->pm_ops->name, len))
> -				return -EFAULT;
> -		} else {
> -			if (copy_to_user(optval, tcp_sk(sk)->mptcp_pm_name,
> -					 len))
> -				return -EFAULT;
> -		}
> -		return 0;
> -
>  	case MPTCP_ENABLED:
>  		if (sk->sk_state !=3D TCP_SYN_SENT)
>  			val =3D mptcp(tp) ? 1 : 0;
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 49ac1b821ac1..5cf9161db844 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6177,7 +6177,7 @@ int tcp_rcv_state_process(struct sock *sk, struct s=
k_buff *skb)
>  			 * addresses, which can only be done after the third ack
>  			 * of the 3-way handshake.
>  			 */
> -			mptcp_update_metasocket(tp->meta_sk);
> +			full_mesh_new_session(tp->meta_sk);
>  		}
>  		if (queued >=3D 0)
>  			return queued;
> @@ -6280,7 +6280,7 @@ int tcp_rcv_state_process(struct sock *sk, struct s=
k_buff *skb)
>  		 */
>  		if (mptcp(tp)) {
>  			if (is_master_tp(tp))
> -				mptcp_update_metasocket(mptcp_meta_sk(sk));
> +				full_mesh_new_session(mptcp_meta_sk(sk));
>  			else
>  				tcp_send_ack(sk);
>  		}
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index a1cb6a3c0dda..e41db7407a90 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -921,8 +921,7 @@ void tcp_release_cb(struct sock *sk)
>  		__sock_put(sk);
>  	}
>  	if (flags & TCPF_PATH_MANAGER_DEFERRED) {
> -		if (tcp_sk(sk)->mpcb->pm_ops->release_sock)
> -			tcp_sk(sk)->mpcb->pm_ops->release_sock(sk);
> +		full_mesh_release_sock(sk);
>  		__sock_put(sk);
>  	}
>  	if (flags & TCPF_SUB_DEFERRED)
> diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
> index 60c07fde5dec..c3b835e40d8b 100644
> --- a/net/mptcp/Kconfig
> +++ b/net/mptcp/Kconfig
> @@ -8,40 +8,3 @@ config MPTCP
>            This replaces the normal TCP stack with a Multipath TCP stack,
>            able to use several paths at once.
>  =

> -menuconfig MPTCP_PM_ADVANCED
> -	bool "MPTCP: advanced path-manager control"
> -	depends on MPTCP=3Dy
> -	---help---
> -	  Support for selection of different path-managers. You should choose '=
Y' here,
> -	  because otherwise you will not actively create new MPTCP-subflows.
> -
> -if MPTCP_PM_ADVANCED
> -
> -config MPTCP_FULLMESH
> -	tristate "MPTCP Full-Mesh Path-Manager"
> -	depends on MPTCP=3Dy
> -	---help---
> -	  This path-management module will create a full-mesh among all IP-addr=
esses.
> -
> -choice
> -	prompt "Default MPTCP Path-Manager"
> -	default DEFAULT
> -	help
> -	  Select the Path-Manager of your choice
> -
> -	config DEFAULT_FULLMESH
> -		bool "Full mesh" if MPTCP_FULLMESH=3Dy
> -
> -	config DEFAULT_DUMMY
> -		bool "Default"
> -
> -endchoice
> -
> -endif
> -
> -config DEFAULT_MPTCP_PM
> -	string
> -	default "default" if DEFAULT_DUMMY
> -	default "fullmesh" if DEFAULT_FULLMESH
> -	default "default"
> -
> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index 433fd17b2987..87901e6b3843 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -5,10 +5,8 @@
>  =

>  obj-$(CONFIG_MPTCP) +=3D mptcp.o
>  =

> -mptcp-y :=3D mptcp_ctrl.o mptcp_ipv4.o mptcp_pm.o \
> +mptcp-y :=3D mptcp_ctrl.o mptcp_ipv4.o mptcp_fullmesh.o \
>  	   mptcp_output.o mptcp_input.o mptcp_sched.o
>  =

> -obj-$(CONFIG_MPTCP_FULLMESH) +=3D mptcp_fullmesh.o
> -
>  mptcp-$(subst m,y,$(CONFIG_IPV6)) +=3D mptcp_ipv6.o
>  =

> diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
> index 83639951c5a5..f170de1c72d4 100644
> --- a/net/mptcp/mptcp_ctrl.c
> +++ b/net/mptcp/mptcp_ctrl.c
> @@ -76,25 +76,6 @@ bool mptcp_init_failed __read_mostly;
>  struct static_key mptcp_static_key =3D STATIC_KEY_INIT_FALSE;
>  EXPORT_SYMBOL(mptcp_static_key);
>  =

> -static int proc_mptcp_path_manager(struct ctl_table *ctl, int write,
> -				   void __user *buffer, size_t *lenp,
> -				   loff_t *ppos)
> -{
> -	char val[MPTCP_PM_NAME_MAX];
> -	struct ctl_table tbl =3D {
> -		.data =3D val,
> -		.maxlen =3D MPTCP_PM_NAME_MAX,
> -	};
> -	int ret;
> -
> -	mptcp_get_default_path_manager(val);
> -
> -	ret =3D proc_dostring(&tbl, write, buffer, lenp, ppos);
> -	if (write && ret =3D=3D 0)
> -		ret =3D mptcp_set_default_path_manager(val);
> -	return ret;
> -}
> -
>  static struct ctl_table mptcp_table[] =3D {
>  	{
>  		.procname =3D "mptcp_enabled",
> @@ -126,12 +107,6 @@ static struct ctl_table mptcp_table[] =3D {
>  		.mode =3D 0644,
>  		.proc_handler =3D &proc_dointvec
>  	},
> -	{
> -		.procname	=3D "mptcp_path_manager",
> -		.mode		=3D 0644,
> -		.maxlen		=3D MPTCP_PM_NAME_MAX,
> -		.proc_handler	=3D proc_mptcp_path_manager,
> -	},
>  	{ }
>  };
>  =

> @@ -604,9 +579,6 @@ static void mptcp_sock_def_error_report(struct sock *=
sk)
>  			tcp_done(meta_sk);
>  	}
>  =

> -	if (mpcb->pm_ops->subflow_error)
> -		mpcb->pm_ops->subflow_error(meta_sk, sk);
> -
>  	sk->sk_err =3D 0;
>  	return;
>  }
> @@ -614,7 +586,6 @@ static void mptcp_sock_def_error_report(struct sock *=
sk)
>  static void mptcp_mpcb_put(struct mptcp_cb *mpcb)
>  {
>  	if (refcount_dec_and_test(&mpcb->mpcb_refcnt)) {
> -		mptcp_cleanup_path_manager(mpcb);
>  		kfree(mpcb->master_info);
>  		kmem_cache_free(mptcp_cb_cache, mpcb);
>  	}
> @@ -1285,8 +1256,6 @@ static int mptcp_alloc_mpcb(struct sock *meta_sk, _=
_u64 remote_key,
>  	/* The meta is directly linked - set refcnt to 1 */
>  	refcount_set(&mpcb->mpcb_refcnt, 1);
>  =

> -	mptcp_init_path_manager(mpcb);
> -
>  	if (!try_module_get(inet_csk(master_sk)->icsk_ca_ops->owner))
>  		tcp_assign_congestion_control(master_sk);
>  =

> @@ -1417,9 +1386,6 @@ void mptcp_del_sock(struct sock *sk)
>  =

>  	mpcb =3D tp->mpcb;
>  =

> -	if (mpcb->pm_ops->delete_subflow)
> -		mpcb->pm_ops->delete_subflow(sk);
> -
>  	mptcp_debug("%s: Removing subsock tok %#x pi:%d state %d is_meta? %d\n",
>  		    __func__, mpcb->mptcp_loc_token, tp->mptcp->path_index,
>  		    sk->sk_state, is_meta_sk(sk));
> @@ -1452,15 +1418,6 @@ void mptcp_del_sock(struct sock *sk)
>  	rcu_assign_pointer(inet_sk(sk)->inet_opt, NULL);
>  }
>  =

> -/* Updates the MPTCP-session based on path-manager information (e.g., ad=
dresses,
> - * low-prio flows,...).
> - */
> -void mptcp_update_metasocket(const struct sock *meta_sk)
> -{
> -	if (tcp_sk(meta_sk)->mpcb->pm_ops->new_session)
> -		tcp_sk(meta_sk)->mpcb->pm_ops->new_session(meta_sk);
> -}
> -
>  /* Clean up the receive buffer for full frames taken by the user,
>   * then send an ACK if necessary.  COPIED is the number of bytes
>   * tcp_recvmsg has given to the user so far, it speeds up the
> @@ -2879,8 +2836,8 @@ void __init mptcp_init(void)
>  	if (!mptcp_sysctl)
>  		goto register_sysctl_failed;
>  =

> -	if (mptcp_register_path_manager(&mptcp_pm_default))
> -		goto register_pm_failed;
> +	if (full_mesh_register())
> +		goto register_full_mesh_failed;
>  =

>  	pr_info("MPTCP: Unstable branch");
>  =

> @@ -2888,7 +2845,7 @@ void __init mptcp_init(void)
>  =

>  	return;
>  =

> -register_pm_failed:
> +register_full_mesh_failed:
>  	unregister_net_sysctl_table(mptcp_sysctl);
>  register_sysctl_failed:
>  	mptcp_pm_v4_undo();
> diff --git a/net/mptcp/mptcp_fullmesh.c b/net/mptcp/mptcp_fullmesh.c
> index 3fff298cee86..5990897605b3 100644
> --- a/net/mptcp/mptcp_fullmesh.c
> +++ b/net/mptcp/mptcp_fullmesh.c
> @@ -16,27 +16,6 @@ enum {
>  =

>  #define MPTCP_SUBFLOW_RETRY_DELAY	1000
>  =

> -/* Max number of local or remote addresses we can store.
> - * When changing, see the bitfield below in fullmesh_rem4/6.
> - */
> -#define MPTCP_MAX_ADDR	8
> -
> -struct fullmesh_rem4 {
> -	u8		rem4_id;
> -	u8		bitfield;
> -	u8		retry_bitfield;
> -	__be16		port;
> -	struct in_addr	addr;
> -};
> -
> -struct fullmesh_rem6 {
> -	u8		rem6_id;
> -	u8		bitfield;
> -	u8		retry_bitfield;
> -	__be16		port;
> -	struct in6_addr	addr;
> -};
> -
>  struct mptcp_loc_addr {
>  	struct mptcp_loc4 locaddr4[MPTCP_MAX_ADDR];
>  	u8 loc4_bits;
> @@ -56,31 +35,6 @@ struct mptcp_addr_event {
>  	union inet_addr addr;
>  };
>  =

> -struct fullmesh_priv {
> -	/* Worker struct for subflow establishment */
> -	struct work_struct subflow_work;
> -	/* Delayed worker, when the routing-tables are not yet ready. */
> -	struct delayed_work subflow_retry_work;
> -
> -	/* Remote addresses */
> -	struct fullmesh_rem4 remaddr4[MPTCP_MAX_ADDR];
> -	struct fullmesh_rem6 remaddr6[MPTCP_MAX_ADDR];
> -
> -	struct mptcp_cb *mpcb;
> -
> -	u16 remove_addrs; /* Addresses to remove */
> -	u8 announced_addrs_v4; /* IPv4 Addresses we did announce */
> -	u8 announced_addrs_v6; /* IPv6 Addresses we did announce */
> -
> -	u8	add_addr; /* Are we sending an add_addr? */
> -
> -	u8 rem4_bits;
> -	u8 rem6_bits;
> -
> -	/* Have we established the additional subflows for primary pair? */
> -	u8 first_pair:1;
> -};
> -
>  struct mptcp_fm_ns {
>  	struct mptcp_loc_addr __rcu *local;
>  	spinlock_t local_lock; /* Protecting the above pointer */
> @@ -90,26 +44,14 @@ struct mptcp_fm_ns {
>  	struct net *net;
>  };
>  =

> -static int num_subflows __read_mostly =3D 1;
> -module_param(num_subflows, int, 0644);
> -MODULE_PARM_DESC(num_subflows, "choose the number of subflows per pair o=
f IP addresses of MPTCP connection");
> -
> -static int create_on_err __read_mostly;
> -module_param(create_on_err, int, 0644);
> -MODULE_PARM_DESC(create_on_err, "recreate the subflow upon a timeout");
> -
> -static struct mptcp_pm_ops full_mesh __read_mostly;
> -
> -static void full_mesh_create_subflows(struct sock *meta_sk);
> -
> -static struct mptcp_fm_ns *fm_get_ns(const struct net *net)
> +static struct mptcp_fm_ns *fm_get_ns(struct net *net)
>  {
> -	return (struct mptcp_fm_ns *)net->mptcp.path_managers[MPTCP_PM_FULLMESH=
];
> +	return net->mptcp.fm_ns;
>  }
>  =

> -static struct fullmesh_priv *fullmesh_get_priv(const struct mptcp_cb *mp=
cb)
> +static struct fullmesh_priv *fullmesh_get_priv(struct mptcp_cb *mpcb)
>  {
> -	return (struct fullmesh_priv *)&mpcb->mptcp_pm[0];
> +	return &mpcb->fmp;
>  }
>  =

>  /* Find the first free index in the bitfield */
> @@ -265,7 +207,7 @@ static void mptcp_v4_rem_raddress(struct mptcp_cb *mp=
cb, u8 id)
>  	}
>  }
>  =

> -static void mptcp_v6_rem_raddress(const struct mptcp_cb *mpcb, u8 id)
> +static void mptcp_v6_rem_raddress(struct mptcp_cb *mpcb, u8 id)
>  {
>  	int i;
>  	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
> @@ -281,7 +223,7 @@ static void mptcp_v6_rem_raddress(const struct mptcp_=
cb *mpcb, u8 id)
>  }
>  =

>  /* Sets the bitfield of the remote-address field */
> -static void mptcp_v4_set_init_addr_bit(const struct mptcp_cb *mpcb,
> +static void mptcp_v4_set_init_addr_bit(struct mptcp_cb *mpcb,
>  				       const struct in_addr *addr, u8 index)
>  {
>  	int i;
> @@ -320,28 +262,6 @@ static void mptcp_set_init_addr_bit(struct mptcp_cb =
*mpcb,
>  		mptcp_v6_set_init_addr_bit(mpcb, &addr->in6, id);
>  }
>  =

> -static void mptcp_v4_subflows(struct sock *meta_sk,
> -			      const struct mptcp_loc4 *loc,
> -			      struct mptcp_rem4 *rem)
> -{
> -	int i;
> -
> -	for (i =3D 1; i < num_subflows; i++)
> -		mptcp_init4_subsockets(meta_sk, loc, rem);
> -}
> -
> -#if IS_ENABLED(CONFIG_IPV6)
> -static void mptcp_v6_subflows(struct sock *meta_sk,
> -			      const struct mptcp_loc6 *loc,
> -			      struct mptcp_rem6 *rem)
> -{
> -	int i;
> -
> -	for (i =3D 1; i < num_subflows; i++)
> -		mptcp_init6_subsockets(meta_sk, loc, rem);
> -}
> -#endif
> -
>  static void retry_subflow_worker(struct work_struct *work)
>  {
>  	struct delayed_work *delayed_work =3D container_of(work,
> @@ -397,9 +317,6 @@ static void retry_subflow_worker(struct work_struct *=
work)
>  			rem4.rem4_id =3D rem->rem4_id;
>  =

>  			mptcp_init4_subsockets(meta_sk, &mptcp_local->locaddr4[i], &rem4);
> -			mptcp_v4_subflows(meta_sk,
> -					  &mptcp_local->locaddr4[i],
> -					  &rem4);
>  			goto next_subflow;
>  		}
>  	}
> @@ -421,9 +338,6 @@ static void retry_subflow_worker(struct work_struct *=
work)
>  			rem6.rem6_id =3D rem->rem6_id;
>  =

>  			mptcp_init6_subsockets(meta_sk, &mptcp_local->locaddr6[i], &rem6);
> -			mptcp_v6_subflows(meta_sk,
> -					  &mptcp_local->locaddr6[i],
> -					  &rem6);
>  			goto next_subflow;
>  		}
>  	}
> @@ -482,23 +396,6 @@ static void create_subflow_worker(struct work_struct=
 *work)
>  	    !tcp_sk(mpcb->master_sk)->mptcp->fully_established)
>  		goto exit;
>  =

> -	/* Create the additional subflows for the first pair */
> -	if (fmp->first_pair =3D=3D 0 && mpcb->master_sk) {
> -		struct mptcp_loc4 loc;
> -		struct mptcp_rem4 rem;
> -
> -		loc.addr.s_addr =3D inet_sk(meta_sk)->inet_saddr;
> -		loc.loc4_id =3D 0;
> -		loc.if_idx =3D mpcb->master_sk->sk_bound_dev_if;
> -
> -		rem.addr.s_addr =3D inet_sk(meta_sk)->inet_daddr;
> -		rem.port =3D inet_sk(meta_sk)->inet_dport;
> -		rem.rem4_id =3D 0; /* Default 0 */
> -
> -		mptcp_v4_subflows(meta_sk, &loc, &rem);
> -
> -		fmp->first_pair =3D 1;
> -	}
>  	iter++;
>  =

>  	mptcp_for_each_bit_set(fmp->rem4_bits, i) {
> @@ -523,31 +420,11 @@ static void create_subflow_worker(struct work_struc=
t *work)
>  			if (mptcp_init4_subsockets(meta_sk, &mptcp_local->locaddr4[i],
>  						   &rem4) =3D=3D -ENETUNREACH)
>  				retry =3D rem->retry_bitfield |=3D (1 << i);
> -			else
> -				mptcp_v4_subflows(meta_sk,
> -						  &mptcp_local->locaddr4[i],
> -						  &rem4);
>  			goto next_subflow;
>  		}
>  	}
>  =

>  #if IS_ENABLED(CONFIG_IPV6)
> -	if (fmp->first_pair =3D=3D 0 && mpcb->master_sk) {
> -			struct mptcp_loc6 loc;
> -			struct mptcp_rem6 rem;
> -
> -			loc.addr =3D inet6_sk(meta_sk)->saddr;
> -			loc.loc6_id =3D 0;
> -			loc.if_idx =3D mpcb->master_sk->sk_bound_dev_if;
> -
> -			rem.addr =3D meta_sk->sk_v6_daddr;
> -			rem.port =3D inet_sk(meta_sk)->inet_dport;
> -			rem.rem6_id =3D 0; /* Default 0 */
> -
> -			mptcp_v6_subflows(meta_sk, &loc, &rem);
> -
> -			fmp->first_pair =3D 1;
> -	}
>  	mptcp_for_each_bit_set(fmp->rem6_bits, i) {
>  		struct fullmesh_rem6 *rem;
>  		u8 remaining_bits;
> @@ -570,10 +447,6 @@ static void create_subflow_worker(struct work_struct=
 *work)
>  			if (mptcp_init6_subsockets(meta_sk, &mptcp_local->locaddr6[i],
>  						   &rem6) =3D=3D -ENETUNREACH)
>  				retry =3D rem->retry_bitfield |=3D (1 << i);
> -			else
> -				mptcp_v6_subflows(meta_sk,
> -						  &mptcp_local->locaddr6[i],
> -						  &rem6);
>  			goto next_subflow;
>  		}
>  	}
> @@ -863,10 +736,6 @@ static void mptcp_address_worker(struct work_struct =
*work)
>  			    mpcb->send_infinite_mapping)
>  				goto next;
>  =

> -			/* May be that the pm has changed in-between */
> -			if (mpcb->pm_ops !=3D &full_mesh)
> -				goto next;
> -
>  			if (sock_owned_by_user(meta_sk)) {
>  				if (!test_and_set_bit(MPTCP_PATH_MANAGER_DEFERRED,
>  						      &meta_sk->sk_tsq_flags))
> @@ -954,7 +823,7 @@ static void mptcp_address_worker(struct work_struct *=
work)
>  	goto next_event;
>  }
>  =

> -static struct mptcp_addr_event *lookup_similar_event(const struct net *n=
et,
> +static struct mptcp_addr_event *lookup_similar_event(struct net *net,
>  						     const struct mptcp_addr_event *event)
>  {
>  	struct mptcp_addr_event *eventq;
> @@ -1168,9 +1037,9 @@ static struct notifier_block mptcp_pm_netdev_notifi=
er =3D {
>  		.notifier_call =3D netdev_event,
>  };
>  =

> -static void full_mesh_add_raddr(struct mptcp_cb *mpcb,
> -				const union inet_addr *addr,
> -				sa_family_t family, __be16 port, u8 id)
> +void full_mesh_add_raddr(struct mptcp_cb *mpcb,
> +			 const union inet_addr *addr,
> +			 sa_family_t family, __be16 port, u8 id)
>  {
>  	if (family =3D=3D AF_INET)
>  		mptcp_addv4_raddr(mpcb, &addr->in, port, id);
> @@ -1178,7 +1047,7 @@ static void full_mesh_add_raddr(struct mptcp_cb *mp=
cb,
>  		mptcp_addv6_raddr(mpcb, &addr->in6, port, id);
>  }
>  =

> -static void full_mesh_new_session(const struct sock *meta_sk)
> +void full_mesh_new_session(const struct sock *meta_sk)
>  {
>  	struct mptcp_loc_addr *mptcp_local;
>  	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
> @@ -1215,7 +1084,7 @@ static void full_mesh_new_session(const struct sock=
 *meta_sk)
>  	else
>  		index =3D mptcp_find_address(mptcp_local, family, &saddr, if_idx);
>  	if (index < 0)
> -		goto fallback;
> +		goto exit;
>  =

>  	full_mesh_add_raddr(mpcb, &daddr, family, 0, 0);
>  	mptcp_set_init_addr_bit(mpcb, &daddr, family, index);
> @@ -1276,15 +1145,14 @@ static void full_mesh_new_session(const struct so=
ck *meta_sk)
>  =

>  	return;
>  =

> -fallback:
> +exit:
>  	rcu_read_unlock_bh();
> -	mptcp_fallback_default(mpcb);
>  	return;
>  }
>  =

> -static void full_mesh_create_subflows(struct sock *meta_sk)
> +void full_mesh_create_subflows(struct sock *meta_sk)
>  {
> -	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
> +	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
>  	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
>  =

>  	if (mpcb->infinite_mapping_snd || mpcb->infinite_mapping_rcv ||
> @@ -1302,28 +1170,10 @@ static void full_mesh_create_subflows(struct sock=
 *meta_sk)
>  	}
>  }
>  =

> -static void full_mesh_subflow_error(struct sock *meta_sk, struct sock *s=
k)
> -{
> -	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
> -
> -	if (!create_on_err)
> -		return;
> -
> -	if (mpcb->infinite_mapping_snd || mpcb->infinite_mapping_rcv ||
> -	    mpcb->send_infinite_mapping ||
> -	    mpcb->server_side || sock_flag(meta_sk, SOCK_DEAD))
> -		return;
> -
> -	if (sk->sk_err !=3D ETIMEDOUT)
> -		return;
> -
> -	full_mesh_create_subflows(meta_sk);
> -}
> -
>  /* Called upon release_sock, if the socket was owned by the user during
>   * a path-management event.
>   */
> -static void full_mesh_release_sock(struct sock *meta_sk)
> +void full_mesh_release_sock(struct sock *meta_sk)
>  {
>  	struct mptcp_loc_addr *mptcp_local;
>  	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
> @@ -1445,8 +1295,8 @@ static void full_mesh_release_sock(struct sock *met=
a_sk)
>  	rcu_read_unlock_bh();
>  }
>  =

> -static int full_mesh_get_local_id(sa_family_t family, union inet_addr *a=
ddr,
> -				  struct net *net)
> +int full_mesh_get_local_id(sa_family_t family, union inet_addr *addr,
> +			   struct net *net)
>  {
>  	struct mptcp_loc_addr *mptcp_local;
>  	const struct mptcp_fm_ns *fm_ns =3D fm_get_ns(net);
> @@ -1472,9 +1322,9 @@ static int full_mesh_get_local_id(sa_family_t famil=
y, union inet_addr *addr,
>  	return id;
>  }
>  =

> -static void full_mesh_addr_signal(struct sock *sk, unsigned *size,
> -				  struct tcp_out_options *opts,
> -				  struct sk_buff *skb)
> +void full_mesh_addr_signal(struct sock *sk, unsigned *size,
> +			   struct tcp_out_options *opts,
> +			   struct sk_buff *skb)
>  {
>  	const struct tcp_sock *tp =3D tcp_sk(sk);
>  	struct mptcp_cb *mpcb =3D tp->mpcb;
> @@ -1602,77 +1452,16 @@ static void full_mesh_addr_signal(struct sock *sk=
, unsigned *size,
>  	mpcb->addr_signal =3D !!(fmp->add_addr || fmp->remove_addrs);
>  }
>  =

> -static void full_mesh_rem_raddr(struct mptcp_cb *mpcb, u8 rem_id)
> +void full_mesh_rem_raddr(struct mptcp_cb *mpcb, u8 rem_id)
>  {
>  	mptcp_v4_rem_raddress(mpcb, rem_id);
>  	mptcp_v6_rem_raddress(mpcb, rem_id);
>  }
>  =

> -static void full_mesh_delete_subflow(struct sock *sk)
> -{
> -	struct fullmesh_priv *fmp =3D fullmesh_get_priv(tcp_sk(sk)->mpcb);
> -	struct mptcp_fm_ns *fm_ns =3D fm_get_ns(sock_net(sk));
> -	struct mptcp_loc_addr *mptcp_local;
> -	int index, i;
> -
> -	if (!create_on_err)
> -		return;
> -
> -	rcu_read_lock_bh();
> -	mptcp_local =3D rcu_dereference_bh(fm_ns->local);
> -
> -	if (sk->sk_family =3D=3D AF_INET || mptcp_v6_is_v4_mapped(sk)) {
> -		union inet_addr saddr;
> -
> -		saddr.ip =3D inet_sk(sk)->inet_saddr;
> -		index =3D mptcp_find_address(mptcp_local, AF_INET, &saddr,
> -					   sk->sk_bound_dev_if);
> -		if (index < 0)
> -			goto out;
> -
> -		mptcp_for_each_bit_set(fmp->rem4_bits, i) {
> -			struct fullmesh_rem4 *rem4 =3D &fmp->remaddr4[i];
> -
> -			if (rem4->addr.s_addr !=3D sk->sk_daddr)
> -				continue;
> -
> -			if (rem4->port && rem4->port !=3D inet_sk(sk)->inet_dport)
> -				continue;
> -
> -			rem4->bitfield &=3D ~(1 << index);
> -		}
> -#if IS_ENABLED(CONFIG_IPV6)
> -	} else {
> -		union inet_addr saddr;
> -
> -		saddr.in6 =3D inet6_sk(sk)->saddr;
> -		index =3D mptcp_find_address(mptcp_local, AF_INET6, &saddr,
> -					   sk->sk_bound_dev_if);
> -		if (index < 0)
> -			goto out;
> -
> -		mptcp_for_each_bit_set(fmp->rem6_bits, i) {
> -			struct fullmesh_rem6 *rem6 =3D &fmp->remaddr6[i];
> -
> -			if (!ipv6_addr_equal(&rem6->addr, &sk->sk_v6_daddr))
> -				continue;
> -
> -			if (rem6->port && rem6->port !=3D inet_sk(sk)->inet_dport)
> -				continue;
> -
> -			rem6->bitfield &=3D ~(1 << index);
> -		}
> -#endif
> -	}
> -
> -out:
> -	rcu_read_unlock_bh();
> -}
> -
>  /* Output /proc/net/mptcp_fullmesh */
>  static int mptcp_fm_seq_show(struct seq_file *seq, void *v)
>  {
> -	const struct net *net =3D seq->private;
> +	struct net *net =3D seq->private;
>  	struct mptcp_loc_addr *mptcp_local;
>  	const struct mptcp_fm_ns *fm_ns =3D fm_get_ns(net);
>  	int i;
> @@ -1733,7 +1522,7 @@ static int mptcp_fm_init_net(struct net *net)
>  	INIT_LIST_HEAD(&fm_ns->events);
>  	spin_lock_init(&fm_ns->local_lock);
>  	fm_ns->net =3D net;
> -	net->mptcp.path_managers[MPTCP_PM_FULLMESH] =3D fm_ns;
> +	net->mptcp.fm_ns =3D fm_ns;
>  =

>  	return 0;
>  err_seq_fops:
> @@ -1776,28 +1565,11 @@ static struct pernet_operations full_mesh_net_ops=
 =3D {
>  	.exit =3D mptcp_fm_exit_net,
>  };
>  =

> -static struct mptcp_pm_ops full_mesh __read_mostly =3D {
> -	.new_session =3D full_mesh_new_session,
> -	.release_sock =3D full_mesh_release_sock,
> -	.fully_established =3D full_mesh_create_subflows,
> -	.new_remote_address =3D full_mesh_create_subflows,
> -	.subflow_error =3D full_mesh_subflow_error,
> -	.get_local_id =3D full_mesh_get_local_id,
> -	.addr_signal =3D full_mesh_addr_signal,
> -	.add_raddr =3D full_mesh_add_raddr,
> -	.rem_raddr =3D full_mesh_rem_raddr,
> -	.delete_subflow =3D full_mesh_delete_subflow,
> -	.name =3D "fullmesh",
> -	.owner =3D THIS_MODULE,
> -};
> -
>  /* General initialization of MPTCP_PM */
> -static int __init full_mesh_register(void)
> +int __init full_mesh_register(void)
>  {
>  	int ret;
>  =

> -	BUILD_BUG_ON(sizeof(struct fullmesh_priv) > MPTCP_PM_SIZE);
> -
>  	ret =3D register_pernet_subsys(&full_mesh_net_ops);
>  	if (ret)
>  		goto out;
> @@ -1814,21 +1586,14 @@ static int __init full_mesh_register(void)
>  	if (ret)
>  		goto err_reg_inet6addr;
>  #endif
> -
> -	ret =3D mptcp_register_path_manager(&full_mesh);
> -	if (ret)
> -		goto err_reg_pm;
> -
>  out:
>  	return ret;
>  =

>  =

> -err_reg_pm:
>  #if IS_ENABLED(CONFIG_IPV6)
> -	unregister_inet6addr_notifier(&inet6_addr_notifier);
>  err_reg_inet6addr:
> -#endif
>  	unregister_netdevice_notifier(&mptcp_pm_netdev_notifier);
> +#endif
>  err_reg_netdev:
>  	unregister_inetaddr_notifier(&mptcp_pm_inetaddr_notifier);
>  err_reg_inetaddr:
> @@ -1836,21 +1601,3 @@ static int __init full_mesh_register(void)
>  	goto out;
>  }
>  =

> -static void full_mesh_unregister(void)
> -{
> -#if IS_ENABLED(CONFIG_IPV6)
> -	unregister_inet6addr_notifier(&inet6_addr_notifier);
> -#endif
> -	unregister_netdevice_notifier(&mptcp_pm_netdev_notifier);
> -	unregister_inetaddr_notifier(&mptcp_pm_inetaddr_notifier);
> -	unregister_pernet_subsys(&full_mesh_net_ops);
> -	mptcp_unregister_path_manager(&full_mesh);
> -}
> -
> -module_init(full_mesh_register);
> -module_exit(full_mesh_unregister);
> -
> -MODULE_AUTHOR("Christoph Paasch");
> -MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("Full-Mesh MPTCP");
> -MODULE_VERSION("0.88");
> diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
> index 88c7a64ef26c..88df2467e1b2 100644
> --- a/net/mptcp/mptcp_input.c
> +++ b/net/mptcp/mptcp_input.c
> @@ -44,15 +44,6 @@ static inline bool before64(const u64 seq1, const u64 =
seq2)
>  /* is seq1 > seq2 ? */
>  #define after64(seq1, seq2)	before64(seq2, seq1)
>  =

> -static inline void mptcp_become_fully_estab(struct sock *sk)
> -{
> -	tcp_sk(sk)->mptcp->fully_established =3D 1;
> -
> -	if (is_master_tp(tcp_sk(sk)) &&
> -	    tcp_sk(sk)->mpcb->pm_ops->fully_established)
> -		tcp_sk(sk)->mpcb->pm_ops->fully_established(mptcp_meta_sk(sk));
> -}
> -
>  /* Similar to tcp_tso_acked without any memory accounting */
>  static inline int mptcp_tso_acked_reinject(const struct sock *meta_sk,
>  					   struct sk_buff *skb)
> @@ -428,6 +419,7 @@ static int mptcp_prevalidate_skb(struct sock *sk, str=
uct sk_buff *skb)
>  		/* We do a seamless fallback and should not send a inf.mapping. */
>  		mpcb->send_infinite_mapping =3D 0;
>  		tp->mptcp->fully_established =3D 1;
> +		full_mesh_create_subflows(tp->meta_sk);

There is a bug here! I am going to send a v2.


Christoph

>  	}
>  =

>  	/* Receiver-side becomes fully established when a whole rcv-window has
> @@ -436,8 +428,10 @@ static int mptcp_prevalidate_skb(struct sock *sk, st=
ruct sk_buff *skb)
>  	 */
>  	if (!tp->mptcp->fully_established) {
>  		tp->mptcp->init_rcv_wnd -=3D skb->len;
> -		if (tp->mptcp->init_rcv_wnd < 0)
> -			mptcp_become_fully_estab(sk);
> +		if (tp->mptcp->init_rcv_wnd < 0) {
> +			tp->mptcp->fully_established =3D 1;
> +			full_mesh_create_subflows(tp->meta_sk);
> +		}
>  	}
>  =

>  	return 0;
> @@ -1247,7 +1241,7 @@ static void mptcp_data_ack(struct sock *sk, const s=
truct sk_buff *skb)
>  		/* As soon as a subflow-data-ack (not acking syn, thus snt_isn + 1)
>  		 * includes a data-ack, we are fully established
>  		 */
> -		mptcp_become_fully_estab(sk);
> +		tp->mptcp->fully_established =3D 1;
>  =

>  	/* After we did the subflow-only processing (stopping timer and marking
>  	 * subflow as established), check if we can proceed with MPTCP-level
> @@ -1757,8 +1751,7 @@ static void mptcp_handle_add_addr(const unsigned ch=
ar *ptr, struct sock *sk)
>  		return;
>  	}
>  =

> -	if (mpcb->pm_ops->add_raddr)
> -		mpcb->pm_ops->add_raddr(mpcb, &addr, family, port, mpadd->addr_id);
> +	full_mesh_add_raddr(mpcb, &addr, family, port, mpadd->addr_id);
>  =

>  	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDRRX);
>  }
> @@ -1773,8 +1766,7 @@ static void mptcp_handle_rem_addr(const unsigned ch=
ar *ptr, struct sock *sk)
>  	for (i =3D 0; i <=3D mprem->len - MPTCP_SUB_LEN_REMOVE_ADDR; i++) {
>  		rem_id =3D (&mprem->addrs_id)[i];
>  =

> -		if (mpcb->pm_ops->rem_raddr)
> -			mpcb->pm_ops->rem_raddr(mpcb, rem_id);
> +		full_mesh_rem_raddr(mpcb, rem_id);
>  		mptcp_send_reset_rem_id(mpcb, rem_id);
>  =

>  		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_REMADDRSUB);
> @@ -1877,8 +1869,7 @@ static inline void mptcp_path_array_check(struct so=
ck *meta_sk)
>  =

>  	if (unlikely(mpcb->list_rcvd)) {
>  		mpcb->list_rcvd =3D 0;
> -		if (mpcb->pm_ops->new_remote_address)
> -			mpcb->pm_ops->new_remote_address(meta_sk);
> +		full_mesh_create_subflows(meta_sk);
>  	}
>  }
>  =

> diff --git a/net/mptcp/mptcp_ipv4.c b/net/mptcp/mptcp_ipv4.c
> index 94bc1416af77..8153b1d7e4bf 100644
> --- a/net/mptcp/mptcp_ipv4.c
> +++ b/net/mptcp/mptcp_ipv4.c
> @@ -105,7 +105,7 @@ static int mptcp_v4_join_init_req(struct request_sock=
 *req, const struct sock *m
>  						    tcp_hdr(skb)->source,
>  						    tcp_hdr(skb)->dest);
>  	addr.ip =3D inet_rsk(req)->ir_loc_addr;
> -	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET, &addr, sock_net(meta_sk)=
);
> +	loc_id =3D full_mesh_get_local_id(AF_INET, &addr, sock_net(meta_sk));
>  	if (loc_id =3D=3D -1)
>  		return -1;
>  	mtreq->loc_id =3D loc_id;
> diff --git a/net/mptcp/mptcp_ipv6.c b/net/mptcp/mptcp_ipv6.c
> index 297dd872fbfb..19ce256a7679 100644
> --- a/net/mptcp/mptcp_ipv6.c
> +++ b/net/mptcp/mptcp_ipv6.c
> @@ -134,7 +134,7 @@ static int mptcp_v6_join_init_req(struct request_sock=
 *req, const struct sock *m
>  						    tcp_hdr(skb)->source,
>  						    tcp_hdr(skb)->dest);
>  	addr.in6 =3D inet_rsk(req)->ir_v6_loc_addr;
> -	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET6, &addr, sock_net(meta_sk=
));
> +	loc_id =3D full_mesh_get_local_id(AF_INET6, &addr, sock_net(meta_sk));
>  	if (loc_id =3D=3D -1)
>  		return -1;
>  	mtreq->loc_id =3D loc_id;
> diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
> index 00a3674ad693..b3978a7e9254 100644
> --- a/net/mptcp/mptcp_output.c
> +++ b/net/mptcp/mptcp_output.c
> @@ -709,9 +709,9 @@ void mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
>  		*size +=3D MPTCP_SUB_LEN_JOIN_ACK_ALIGN;
>  	}
>  =

> -	if (unlikely(mpcb->addr_signal) && mpcb->pm_ops->addr_signal &&
> +	if (unlikely(mpcb->addr_signal) &&
>  	    mpcb->mptcp_ver >=3D MPTCP_VERSION_1 && skb && !mptcp_is_data_seq(s=
kb)) {
> -		mpcb->pm_ops->addr_signal(sk, size, opts, skb);
> +		full_mesh_addr_signal(sk, size, opts, skb);
>  =

>  		if (opts->add_addr_v6)
>  			/* Skip subsequent options */
> @@ -734,9 +734,9 @@ void mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
>  		*size +=3D MPTCP_SUB_LEN_DSS_ALIGN;
>  	}
>  =

> -	if (unlikely(mpcb->addr_signal) && mpcb->pm_ops->addr_signal &&
> +	if (unlikely(mpcb->addr_signal) &&
>  	    mpcb->mptcp_ver < MPTCP_VERSION_1)
> -		mpcb->pm_ops->addr_signal(sk, size, opts, skb);
> +		full_mesh_addr_signal(sk, size, opts, skb);
>  =

>  	return;
>  }
> diff --git a/net/mptcp/mptcp_pm.c b/net/mptcp/mptcp_pm.c
> deleted file mode 100644
> index fbdf8eb58d17..000000000000
> --- a/net/mptcp/mptcp_pm.c
> +++ /dev/null
> @@ -1,226 +0,0 @@
> -/*
> - *     MPTCP implementation - MPTCP-subflow-management
> - *
> - *     Initial Design & Implementation:
> - *     S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
> - *
> - *     Current Maintainer & Author:
> - *     Christoph Paasch <christoph.paasch(a)uclouvain.be>
> - *
> - *     Additional authors:
> - *     Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
> - *     Gregory Detal <gregory.detal(a)uclouvain.be>
> - *     Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
> - *     Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
> - *     Lavkesh Lahngir <lavkesh51(a)gmail.com>
> - *     Andreas Ripke <ripke(a)neclab.eu>
> - *     Vlad Dogaru <vlad.dogaru(a)intel.com>
> - *     Octavian Purdila <octavian.purdila(a)intel.com>
> - *     John Ronan <jronan(a)tssg.org>
> - *     Catalin Nicutar <catalin.nicutar(a)gmail.com>
> - *     Brandon Heller <brandonh(a)stanford.edu>
> - *
> - *
> - *     This program is free software; you can redistribute it and/or
> - *      modify it under the terms of the GNU General Public License
> - *      as published by the Free Software Foundation; either version
> - *      2 of the License, or (at your option) any later version.
> - */
> -
> -
> -#include <linux/module.h>
> -#include <net/mptcp.h>
> -
> -static DEFINE_SPINLOCK(mptcp_pm_list_lock);
> -static LIST_HEAD(mptcp_pm_list);
> -
> -static int mptcp_default_id(sa_family_t family, union inet_addr *addr,
> -			    struct net *net)
> -{
> -	return 0;
> -}
> -
> -struct mptcp_pm_ops mptcp_pm_default =3D {
> -	.get_local_id =3D mptcp_default_id, /* We do not care */
> -	.name =3D "default",
> -	.owner =3D THIS_MODULE,
> -};
> -
> -static struct mptcp_pm_ops *mptcp_pm_find(const char *name)
> -{
> -	struct mptcp_pm_ops *e;
> -
> -	list_for_each_entry_rcu(e, &mptcp_pm_list, list) {
> -		if (strcmp(e->name, name) =3D=3D 0)
> -			return e;
> -	}
> -
> -	return NULL;
> -}
> -
> -int mptcp_register_path_manager(struct mptcp_pm_ops *pm)
> -{
> -	int ret =3D 0;
> -
> -	if (!pm->get_local_id)
> -		return -EINVAL;
> -
> -	spin_lock(&mptcp_pm_list_lock);
> -	if (mptcp_pm_find(pm->name)) {
> -		pr_notice("%s already registered\n", pm->name);
> -		ret =3D -EEXIST;
> -	} else {
> -		list_add_tail_rcu(&pm->list, &mptcp_pm_list);
> -		pr_info("%s registered\n", pm->name);
> -	}
> -	spin_unlock(&mptcp_pm_list_lock);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(mptcp_register_path_manager);
> -
> -void mptcp_unregister_path_manager(struct mptcp_pm_ops *pm)
> -{
> -	spin_lock(&mptcp_pm_list_lock);
> -	list_del_rcu(&pm->list);
> -	spin_unlock(&mptcp_pm_list_lock);
> -
> -	/* Wait for outstanding readers to complete before the
> -	 * module gets removed entirely.
> -	 *
> -	 * A try_module_get() should fail by now as our module is
> -	 * in "going" state since no refs are held anymore and
> -	 * module_exit() handler being called.
> -	 */
> -	synchronize_rcu();
> -}
> -EXPORT_SYMBOL_GPL(mptcp_unregister_path_manager);
> -
> -void mptcp_get_default_path_manager(char *name)
> -{
> -	struct mptcp_pm_ops *pm;
> -
> -	BUG_ON(list_empty(&mptcp_pm_list));
> -
> -	rcu_read_lock();
> -	pm =3D list_entry(mptcp_pm_list.next, struct mptcp_pm_ops, list);
> -	strncpy(name, pm->name, MPTCP_PM_NAME_MAX);
> -	rcu_read_unlock();
> -}
> -
> -int mptcp_set_default_path_manager(const char *name)
> -{
> -	struct mptcp_pm_ops *pm;
> -	int ret =3D -ENOENT;
> -
> -	spin_lock(&mptcp_pm_list_lock);
> -	pm =3D mptcp_pm_find(name);
> -#ifdef CONFIG_MODULES
> -	if (!pm && capable(CAP_NET_ADMIN)) {
> -		spin_unlock(&mptcp_pm_list_lock);
> -
> -		request_module("mptcp_%s", name);
> -		spin_lock(&mptcp_pm_list_lock);
> -		pm =3D mptcp_pm_find(name);
> -	}
> -#endif
> -
> -	if (pm) {
> -		list_move(&pm->list, &mptcp_pm_list);
> -		ret =3D 0;
> -	} else {
> -		pr_info("%s is not available\n", name);
> -	}
> -	spin_unlock(&mptcp_pm_list_lock);
> -
> -	return ret;
> -}
> -
> -static struct mptcp_pm_ops *__mptcp_pm_find_autoload(const char *name)
> -{
> -	struct mptcp_pm_ops *pm =3D mptcp_pm_find(name);
> -#ifdef CONFIG_MODULES
> -	if (!pm && capable(CAP_NET_ADMIN)) {
> -		rcu_read_unlock();
> -		request_module("mptcp_%s", name);
> -		rcu_read_lock();
> -		pm =3D mptcp_pm_find(name);
> -	}
> -#endif
> -	return pm;
> -}
> -
> -void mptcp_init_path_manager(struct mptcp_cb *mpcb)
> -{
> -	struct mptcp_pm_ops *pm;
> -	struct sock *meta_sk =3D mpcb->meta_sk;
> -	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
> -
> -	rcu_read_lock();
> -	/* if path manager was set using socket option */
> -	if (meta_tp->mptcp_pm_setsockopt) {
> -		pm =3D __mptcp_pm_find_autoload(meta_tp->mptcp_pm_name);
> -		if (pm && try_module_get(pm->owner)) {
> -			mpcb->pm_ops =3D pm;
> -			goto out;
> -		}
> -	}
> -
> -	list_for_each_entry_rcu(pm, &mptcp_pm_list, list) {
> -		if (try_module_get(pm->owner)) {
> -			mpcb->pm_ops =3D pm;
> -			break;
> -		}
> -	}
> -out:
> -	rcu_read_unlock();
> -}
> -
> -/* Change path manager for socket */
> -int mptcp_set_path_manager(struct sock *sk, const char *name)
> -{
> -	struct mptcp_pm_ops *pm;
> -	int err =3D 0;
> -
> -	rcu_read_lock();
> -	pm =3D __mptcp_pm_find_autoload(name);
> -
> -	if (!pm) {
> -		err =3D -ENOENT;
> -	} else if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
> -		err =3D -EPERM;
> -	} else {
> -		strcpy(tcp_sk(sk)->mptcp_pm_name, name);
> -		tcp_sk(sk)->mptcp_pm_setsockopt =3D 1;
> -	}
> -	rcu_read_unlock();
> -
> -	return err;
> -}
> -
> -/* Manage refcounts on socket close. */
> -void mptcp_cleanup_path_manager(struct mptcp_cb *mpcb)
> -{
> -	module_put(mpcb->pm_ops->owner);
> -}
> -
> -/* Fallback to the default path-manager. */
> -void mptcp_fallback_default(struct mptcp_cb *mpcb)
> -{
> -	struct mptcp_pm_ops *pm;
> -
> -	mptcp_cleanup_path_manager(mpcb);
> -	pm =3D mptcp_pm_find("default");
> -
> -	/* Cannot fail - it's the default module */
> -	try_module_get(pm->owner);
> -	mpcb->pm_ops =3D pm;
> -}
> -EXPORT_SYMBOL_GPL(mptcp_fallback_default);
> -
> -/* Set default value from kernel configuration at bootup */
> -static int __init mptcp_path_manager_default(void)
> -{
> -	return mptcp_set_default_path_manager(CONFIG_DEFAULT_MPTCP_PM);
> -}
> -late_initcall(mptcp_path_manager_default);
> -- =

> 2.16.2
> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

--===============2242019727998819505==--
