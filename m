Content-Type: multipart/mixed; boundary="===============7478071982131222399=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC final 05/14] tcp: Register handlers for extra TCP
 options
Date: Mon, 18 Dec 2017 10:29:34 -0800
Message-ID: <alpine.OSX.2.21.1712181004300.4155@mjmartin-mac01.sea.intel.com>
In-Reply-To: 20171218064245.94150-6-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 291

--===============7478071982131222399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Christoph,

Some comment/commit-message notes below.


On Sun, 17 Dec 2017, Christoph Paasch wrote:

> From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>
> Allow additional TCP options to be handled by registered hook
> functions.
>
> Registered options have a priority that determines the order in which
> options are prepared and written. Lower priority numbers are handled
> first.
>
> Option parsing will call the provided 'parse' function when a TCP option
> number is not recognized by the normal option parsing code.
>
> After parsing, there are two places where we post-process the options.
> First, a 'check' callback that allows to drop the packet based on the
> parsed options (e.g., usefull for TCP MD5SIG). Then, a 'post_process'
> function that gets called after other validity checks (aka, in-window,
> PAWS,...). This post_process function can then update other state for
> this particular extra-option.
>
> In the output-path, the 'prepare' function determines the required space
> for registered options and store associated data. 'write' adds the option
> to the TCP header.
>
> A static key is used to minimize the performance impact.

This line should be deleted now that the static branching was removed.

>
> These additional TCP-options are stored in hlists of the TCP-socket. To
> pass the state and options around during the 3-way handshake and in
> time-wait state, the hlists are also on the tcp_request_sock and
> tcp_timewait_sock.
> The list is copied from the listener to the request-socket (calling into
> the 'copy' callback). Then, moved from the request-socket to the
> TCP-socket and finally to the time-wait socket.
>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
> drivers/infiniband/hw/cxgb4/cm.c |   2 +-
> include/linux/tcp.h              |  28 ++++
> include/net/tcp.h                | 109 ++++++++++++-
> net/ipv4/syncookies.c            |   6 +-
> net/ipv4/tcp.c                   | 327 ++++++++++++++++++++++++++++++++++=
++++-
> net/ipv4/tcp_input.c             |  49 +++++-
> net/ipv4/tcp_ipv4.c              |  97 +++++++++---
> net/ipv4/tcp_minisocks.c         |  32 +++-
> net/ipv4/tcp_output.c            |  40 ++---
> net/ipv6/syncookies.c            |   6 +-
> net/ipv6/tcp_ipv6.c              |  32 ++++
> 11 files changed, 674 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxg=
b4/cm.c
> index 21db3b48a617..a1ea5583f07b 100644
> --- a/drivers/infiniband/hw/cxgb4/cm.c
> +++ b/drivers/infiniband/hw/cxgb4/cm.c
> @@ -3746,7 +3746,7 @@ static void build_cpl_pass_accept_req(struct sk_buf=
f *skb, int stid , u8 tos)
> 	 */
> 	memset(&tmp_opt, 0, sizeof(tmp_opt));
> 	tcp_clear_options(&tmp_opt);
> -	tcp_parse_options(&init_net, skb, &tmp_opt, 0, NULL);
> +	tcp_parse_options(&init_net, skb, &tmp_opt, 0, NULL, NULL);
>
> 	req =3D __skb_push(skb, sizeof(*req));
> 	memset(req, 0, sizeof(*req));
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 4f93f0953c41..4756bd2c4b54 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -115,6 +115,24 @@ static inline void tcp_clear_options(struct tcp_opti=
ons_received *rx_opt)
> #endif
> }
>
> +#define OPTION_SACK_ADVERTISE	(1 << 0)
> +#define OPTION_TS		(1 << 1)
> +#define OPTION_MD5		(1 << 2)
> +#define OPTION_WSCALE		(1 << 3)
> +#define OPTION_FAST_OPEN_COOKIE	(1 << 8)
> +#define OPTION_SMC		(1 << 9)
> +
> +struct tcp_out_options {
> +	u16 options;		/* bit field of OPTION_* */
> +	u16 mss;		/* 0 to disable */
> +	u8 ws;			/* window scale, 0 to disable */
> +	u8 num_sack_blocks;	/* number of SACK blocks to include */
> +	u8 hash_size;		/* bytes in hash_location */
> +	__u8 *hash_location;	/* temporary pointer, overloaded */
> +	__u32 tsval, tsecr;	/* need to include OPTION_TS */
> +	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
> +};
> +
> /* This is the max number of SACKS that we'll generate and process. It's =
safe
>  * to increase this, although since:
>  *   size =3D TCPOLEN_SACK_BASE_ALIGNED (4) + n * TCPOLEN_SACK_PERBLOCK (=
8)
> @@ -137,6 +155,7 @@ struct tcp_request_sock {
> 						  * FastOpen it's the seq#
> 						  * after data-in-SYN.
> 						  */
> +	struct hlist_head		tcp_option_list;
> };
>
> static inline struct tcp_request_sock *tcp_rsk(const struct request_sock =
*req)
> @@ -373,6 +392,8 @@ struct tcp_sock {
> 	 */
> 	struct request_sock *fastopen_rsk;
> 	u32	*saved_syn;
> +
> +	struct hlist_head tcp_option_list;
> };
>
> enum tsq_enum {
> @@ -400,6 +421,11 @@ static inline struct tcp_sock *tcp_sk(const struct s=
ock *sk)
> 	return (struct tcp_sock *)sk;
> }
>
> +static inline struct sock *tcp_to_sk(const struct tcp_sock *tp)
> +{
> +	return (struct sock *)tp;
> +}
> +
> struct tcp_timewait_sock {
> 	struct inet_timewait_sock tw_sk;
> #define tw_rcv_nxt tw_sk.__tw_common.skc_tw_rcv_nxt
> @@ -412,6 +438,8 @@ struct tcp_timewait_sock {
> 	u32			  tw_last_oow_ack_time;
>
> 	long			  tw_ts_recent_stamp;
> +
> +	struct hlist_head	  tcp_option_list;
> #ifdef CONFIG_TCP_MD5SIG
> 	struct tcp_md5sig_key	  *tw_md5_key;
> #endif
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 6939e69d3c37..a1c30b938405 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -202,6 +202,7 @@ void tcp_time_wait(struct sock *sk, int state, int ti=
meo);
> #define TCPOLEN_FASTOPEN_BASE  2
> #define TCPOLEN_EXP_FASTOPEN_BASE  4
> #define TCPOLEN_EXP_SMC_BASE   6
> +#define TCPOLEN_EXP_BASE       6
>
> /* But this is what stacks really send out. */
> #define TCPOLEN_TSTAMP_ALIGNED		12
> @@ -403,7 +404,8 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, =
size_t len, int nonblock,
> 		int flags, int *addr_len);
> void tcp_parse_options(const struct net *net, const struct sk_buff *skb,
> 		       struct tcp_options_received *opt_rx,
> -		       int estab, struct tcp_fastopen_cookie *foc);
> +		       int estab, struct tcp_fastopen_cookie *foc,
> +		       struct sock *sk);
> const u8 *tcp_parse_md5sig_option(const struct tcphdr *th);
>
> /*
> @@ -2063,4 +2065,109 @@ static inline bool tcp_bpf_ca_needs_ecn(struct so=
ck *sk)
> #if IS_ENABLED(CONFIG_SMC)
> extern struct static_key_false tcp_have_smc;
> #endif
> +
> +struct tcp_extopt_store;
> +
> +struct tcp_extopt_ops {
> +	u32			option_kind;
> +	unsigned char		priority;
> +	void (*parse)(int opsize, const unsigned char *opptr,
> +		      const struct sk_buff *skb,
> +		      struct tcp_options_received *opt_rx,
> +		      struct sock *sk,
> +		      struct tcp_extopt_store *store);
> +	bool (*check)(struct sock *sk,
> +		      const struct sk_buff *skb,
> +		      struct tcp_options_received *opt_rx,
> +		      struct tcp_extopt_store *store);
> +	void (*post_process)(struct sock *sk,
> +			     struct tcp_options_received *opt_rx,
> +			     struct tcp_extopt_store *store);
> +	/* Return the number of bytes consumed */
> +	unsigned int (*prepare)(struct sk_buff *skb, u8 flags,
> +				unsigned int remaining,
> +				struct tcp_out_options *opts,
> +				const struct sock *sk,
> +				struct tcp_extopt_store *store);
> +	__be32 *(*write)(__be32 *ptr, struct sk_buff *skb,
> +			 struct tcp_out_options *opts, struct sock *sk,
> +			 struct tcp_extopt_store *store);
> +	int (*response_prepare)(struct sk_buff *orig, u8 flags,
> +				unsigned int remaining,
> +				struct tcp_out_options *opts,
> +				const struct sock *sk,
> +				struct tcp_extopt_store *store);
> +	__be32 *(*response_write)(__be32 *ptr, struct sk_buff *orig,
> +				  struct tcphdr *th,
> +				  struct tcp_out_options *opts,
> +				  const struct sock *sk,
> +				  struct tcp_extopt_store *store);
> +	int (*add_header_len)(const struct sock *orig,
> +			      const struct sock *sk,
> +			      struct tcp_extopt_store *store);
> +	struct tcp_extopt_store *(*copy)(struct sock *listener,
> +					 struct request_sock *req,
> +					 struct tcp_options_received *opt,
> +					 struct tcp_extopt_store *from);
> +	struct tcp_extopt_store *(*move)(struct sock *from, struct sock *to,
> +					 struct tcp_extopt_store *store);
> +	void (*destroy)(struct tcp_extopt_store *store);
> +	struct module		*owner;
> +};
> +
> +/* Every extra-option in a TCP-socket gets stored in a _store structure =
which
> + * has to have tcp_extopt_store as the first element.

Comment can be updated to recommend container_of() instead of positional =

requirement.

> + *
> + * That way, code registering extra options can pass this to
> + * tcp_register_extopt, and the surrounding structure can contain per-op=
tion
> + * state.
> + */
> +struct tcp_extopt_store {
> +	struct hlist_node		list;
> +	const struct tcp_extopt_ops	*ops;
> +};
> +
> +struct hlist_head *tcp_extopt_get_list(const struct sock *sk);
> +
> +struct tcp_extopt_store *tcp_extopt_find_kind(u32 kind, const struct soc=
k *sk);
> +
> +void tcp_extopt_parse(u32 opcode, int opsize, const unsigned char *opptr,
> +		      const struct sk_buff *skb,
> +		      struct tcp_options_received *opt_rx, struct sock *sk);
> +
> +bool tcp_extopt_check(struct sock *sk, const struct sk_buff *skb,
> +		      struct tcp_options_received *opt_rx);
> +
> +void tcp_extopt_post_process(struct sock *sk,
> +			     struct tcp_options_received *opt_rx);
> +
> +unsigned int tcp_extopt_prepare(struct sk_buff *skb, u8 flags,
> +				unsigned int remaining,
> +				struct tcp_out_options *opts,
> +				const struct sock *sk);
> +
> +void tcp_extopt_write(__be32 *ptr, struct sk_buff *skb,
> +		      struct tcp_out_options *opts, struct sock *sk);
> +
> +int tcp_extopt_response_prepare(struct sk_buff *orig, u8 flags,
> +				unsigned int remaining,
> +				struct tcp_out_options *opts,
> +				const struct sock *sk);
> +
> +void tcp_extopt_response_write(__be32 *ptr, struct sk_buff *orig,
> +			       struct tcphdr *th, struct tcp_out_options *opts,
> +			       const struct sock *sk);
> +
> +int tcp_extopt_add_header(const struct sock *orig, const struct sock *sk=
);
> +
> +/* Socket lock must be held when calling this function */
> +int tcp_register_extopt(struct tcp_extopt_store *store, struct sock *sk);
> +
> +void tcp_extopt_copy(struct sock *listener, struct request_sock *req,
> +		     struct tcp_options_received *opt);
> +
> +void tcp_extopt_move(struct sock *from, struct sock *to);
> +
> +void tcp_extopt_destroy(struct sock *sk);
> +
> #endif	/* _TCP_H */
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index fda37f2862c9..8373abf19440 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -313,7 +313,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
>
> 	/* check for timestamp cookie support */
> 	memset(&tcp_opt, 0, sizeof(tcp_opt));
> -	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL);
> +	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL, sk);
>
> 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
> 		tsoff =3D secure_tcp_ts_off(sock_net(sk),
> @@ -325,6 +325,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct=
 sk_buff *skb)
> 	if (!cookie_timestamp_decode(sock_net(sk), &tcp_opt))
> 		goto out;
>
> +	if (unlikely(!hlist_empty(&tp->tcp_option_list)) &&
> +	    tcp_extopt_check(sk, skb, &tcp_opt))
> +		goto out;
> +
> 	ret =3D NULL;
> 	req =3D inet_reqsk_alloc(&tcp_request_sock_ops, sk, false); /* for safet=
y */
> 	if (!req)
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index c470fec9062f..17f38afb4212 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -416,6 +416,7 @@ void tcp_init_sock(struct sock *sk)
> 	tcp_init_xmit_timers(sk);
> 	INIT_LIST_HEAD(&tp->tsq_node);
> 	INIT_LIST_HEAD(&tp->tsorted_sent_queue);
> +	INIT_HLIST_HEAD(&tp->tcp_option_list);
>
> 	icsk->icsk_rto =3D TCP_TIMEOUT_INIT;
> 	tp->mdev_us =3D jiffies_to_usecs(TCP_TIMEOUT_INIT);
> @@ -3473,6 +3474,331 @@ EXPORT_SYMBOL(tcp_md5_hash_key);
>
> #endif
>
> +struct hlist_head *tcp_extopt_get_list(const struct sock *sk)
> +{
> +	if (sk_fullsock(sk))
> +		return &tcp_sk(sk)->tcp_option_list;
> +	else if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
> +		return &tcp_rsk(inet_reqsk(sk))->tcp_option_list;
> +	else if (sk->sk_state =3D=3D TCP_TIME_WAIT)
> +		return &tcp_twsk(sk)->tcp_option_list;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(tcp_extopt_get_list);
> +
> +/* Caller must ensure that rcu is locked */
> +struct tcp_extopt_store *tcp_extopt_find_kind(u32 kind, const struct soc=
k *sk)
> +{
> +	struct tcp_extopt_store *entry;
> +	struct hlist_head *lhead;
> +
> +	lhead =3D tcp_extopt_get_list(sk);
> +
> +	hlist_for_each_entry_rcu(entry, lhead, list) {
> +		if (entry->ops->option_kind =3D=3D kind)
> +			return entry;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(tcp_extopt_find_kind);
> +
> +void tcp_extopt_parse(u32 opcode, int opsize, const unsigned char *opptr,
> +		      const struct sk_buff *skb,
> +		      struct tcp_options_received *opt_rx, struct sock *sk)
> +{
> +	struct tcp_extopt_store *entry;
> +
> +	rcu_read_lock();
> +	entry =3D tcp_extopt_find_kind(opcode, sk);
> +
> +	if (entry && entry->ops->parse)
> +		entry->ops->parse(opsize, opptr, skb, opt_rx, sk, entry);
> +	rcu_read_unlock();
> +}
> +
> +bool tcp_extopt_check(struct sock *sk, const struct sk_buff *skb,
> +		      struct tcp_options_received *opt_rx)
> +{
> +	struct tcp_extopt_store *entry;
> +	struct hlist_head *lhead;
> +	bool drop =3D false;
> +
> +	lhead =3D tcp_extopt_get_list(sk);
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(entry, lhead, list) {
> +		bool ret =3D false;
> +
> +		if (entry->ops->check)
> +			ret =3D entry->ops->check(sk, skb, opt_rx, entry);
> +
> +		if (ret)
> +			drop =3D true;
> +	}
> +	rcu_read_unlock();
> +
> +	return drop;
> +}
> +EXPORT_SYMBOL_GPL(tcp_extopt_check);
> +
> +void tcp_extopt_post_process(struct sock *sk,
> +			     struct tcp_options_received *opt_rx)
> +{
> +	struct tcp_extopt_store *entry;
> +	struct hlist_head *lhead;
> +
> +	lhead =3D tcp_extopt_get_list(sk);
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(entry, lhead, list) {
> +		if (entry->ops->post_process)
> +			entry->ops->post_process(sk, opt_rx, entry);
> +	}
> +	rcu_read_unlock();
> +}
> +
> +unsigned int tcp_extopt_prepare(struct sk_buff *skb, u8 flags,
> +				unsigned int remaining,
> +				struct tcp_out_options *opts,
> +				const struct sock *sk)
> +{
> +	struct tcp_extopt_store *entry;
> +	struct hlist_head *lhead;
> +	unsigned int used =3D 0;
> +
> +	if (!sk)
> +		return 0;
> +
> +	lhead =3D tcp_extopt_get_list(sk);
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(entry, lhead, list) {
> +		if (unlikely(!entry->ops->prepare))
> +			continue;
> +
> +		used +=3D entry->ops->prepare(skb, flags, remaining - used, opts,
> +					    sk, entry);
> +	}
> +	rcu_read_unlock();
> +
> +	return roundup(used, 4);
> +}
> +
> +void tcp_extopt_write(__be32 *ptr, struct sk_buff *skb,
> +		      struct tcp_out_options *opts, struct sock *sk)
> +{
> +	struct tcp_extopt_store *entry;
> +	struct hlist_head *lhead;
> +
> +	if (!sk)
> +		return;
> +
> +	lhead =3D tcp_extopt_get_list(sk);
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(entry, lhead, list) {
> +		if (unlikely(!entry->ops->write))
> +			continue;
> +
> +		ptr =3D entry->ops->write(ptr, skb, opts, sk, entry);
> +	}
> +	rcu_read_unlock();
> +}
> +EXPORT_SYMBOL_GPL(tcp_extopt_write);
> +
> +int tcp_extopt_response_prepare(struct sk_buff *orig, u8 flags,
> +				unsigned int remaining,
> +				struct tcp_out_options *opts,
> +				const struct sock *sk)
> +{
> +	struct tcp_extopt_store *entry;
> +	struct hlist_head *lhead;
> +	unsigned int used =3D 0;
> +
> +	if (!sk)
> +		return 0;
> +
> +	lhead =3D tcp_extopt_get_list(sk);
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(entry, lhead, list) {
> +		int ret;
> +
> +		if (unlikely(!entry->ops->response_prepare))
> +			continue;
> +
> +		ret =3D entry->ops->response_prepare(orig, flags,
> +						   remaining - used, opts,
> +						   sk, entry);
> +
> +		used +=3D ret;
> +	}
> +	rcu_read_unlock();
> +
> +	return roundup(used, 4);
> +}
> +EXPORT_SYMBOL_GPL(tcp_extopt_response_prepare);
> +
> +void tcp_extopt_response_write(__be32 *ptr, struct sk_buff *orig,
> +			       struct tcphdr *th, struct tcp_out_options *opts,
> +			       const struct sock *sk)
> +{
> +	struct tcp_extopt_store *entry;
> +	struct hlist_head *lhead;
> +
> +	if (!sk)
> +		return;
> +
> +	lhead =3D tcp_extopt_get_list(sk);
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(entry, lhead, list) {
> +		if (unlikely(!entry->ops->response_write))
> +			continue;
> +
> +		ptr =3D entry->ops->response_write(ptr, orig, th, opts, sk, entry);
> +	}
> +	rcu_read_unlock();
> +}
> +EXPORT_SYMBOL_GPL(tcp_extopt_response_write);
> +
> +int tcp_extopt_add_header(const struct sock *orig, const struct sock *sk)
> +{
> +	struct tcp_extopt_store *entry;
> +	struct hlist_head *lhead;
> +	int tcp_header_len =3D 0;
> +
> +	lhead =3D tcp_extopt_get_list(sk);
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(entry, lhead, list) {
> +		if (unlikely(!entry->ops->add_header_len))
> +			continue;
> +
> +		tcp_header_len +=3D entry->ops->add_header_len(orig, sk, entry);
> +	}
> +	rcu_read_unlock();
> +
> +	return tcp_header_len;
> +}
> +
> +/* Socket lock must be held when calling this function */
> +int tcp_register_extopt(struct tcp_extopt_store *store, struct sock *sk)
> +{
> +	struct hlist_node *add_before =3D NULL;
> +	struct tcp_extopt_store *entry;
> +	struct hlist_head *lhead;
> +	int ret =3D 0;
> +
> +	lhead =3D tcp_extopt_get_list(sk);
> +
> +	if (!store->ops->option_kind)
> +		return -EINVAL;
> +
> +	if (!try_module_get(store->ops->owner))
> +		return -ENOENT;
> +
> +	hlist_for_each_entry_rcu(entry, lhead, list) {
> +		if (entry->ops->option_kind =3D=3D store->ops->option_kind) {
> +			pr_notice("Option kind %u already registered\n",
> +				  store->ops->option_kind);
> +			module_put(store->ops->owner);
> +			return -EEXIST;
> +		}
> +
> +		if (entry->ops->priority <=3D store->ops->priority)
> +			add_before =3D &entry->list;
> +	}
> +
> +	if (add_before)
> +		hlist_add_behind_rcu(&store->list, add_before);
> +	else
> +		hlist_add_head_rcu(&store->list, lhead);
> +
> +	pr_debug("Option kind %u registered\n", store->ops->option_kind);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(tcp_register_extopt);
> +
> +void tcp_extopt_copy(struct sock *listener, struct request_sock *req,
> +		     struct tcp_options_received *opt)
> +{
> +	struct tcp_extopt_store *entry;
> +	struct hlist_head *from, *to;
> +
> +	from =3D tcp_extopt_get_list(listener);
> +	to =3D tcp_extopt_get_list(req_to_sk(req));
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(entry, from, list) {
> +		struct tcp_extopt_store *new;
> +
> +		if (!try_module_get(entry->ops->owner)) {
> +			pr_err("%s Module get failed while copying\n", __func__);
> +			continue;
> +		}
> +
> +		new =3D entry->ops->copy(listener, req, opt, entry);
> +		if (!new) {
> +			module_put(entry->ops->owner);
> +			continue;
> +		}
> +
> +		hlist_add_tail_rcu(&new->list, to);

Does this require that req is locked? Or is it expected to be under =

construction at this point so it won't be accessed in parallel?

> +	}
> +	rcu_read_unlock();
> +}
> +
> +void tcp_extopt_move(struct sock *from, struct sock *to)

Any locking notes for this function?


Mat

> +{
> +	struct tcp_extopt_store *entry;
> +	struct hlist_head *lfrom, *lto;
> +	struct hlist_node *tmp;
> +
> +	lfrom =3D tcp_extopt_get_list(from);
> +	lto =3D tcp_extopt_get_list(to);
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_safe(entry, tmp, lfrom, list) {
> +		hlist_del_rcu(&entry->list);
> +
> +		if (entry->ops->move) {
> +			entry =3D entry->ops->move(from, to, entry);
> +			if (!entry)
> +				continue;
> +		}
> +
> +		hlist_add_tail_rcu(&entry->list, lto);
> +	}
> +	rcu_read_unlock();
> +}
> +EXPORT_SYMBOL_GPL(tcp_extopt_move);
> +
> +void tcp_extopt_destroy(struct sock *sk)
> +{
> +	struct tcp_extopt_store *entry;
> +	struct hlist_head *lhead;
> +	struct hlist_node *tmp;
> +
> +	lhead =3D tcp_extopt_get_list(sk);
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_safe(entry, tmp, lhead, list) {
> +		struct module *owner =3D entry->ops->owner;
> +
> +		hlist_del_rcu(&entry->list);
> +
> +		entry->ops->destroy(entry);
> +
> +		module_put(owner);
> +	}
> +	rcu_read_unlock();
> +}
> +EXPORT_SYMBOL_GPL(tcp_extopt_destroy);
> +
> void tcp_done(struct sock *sk)
> {
> 	struct request_sock *req =3D tcp_sk(sk)->fastopen_rsk;
> @@ -3622,7 +3948,6 @@ void __init tcp_init(void)
> 		INIT_HLIST_HEAD(&tcp_hashinfo.bhash[i].chain);
> 	}
>
> -
> 	cnt =3D tcp_hashinfo.ehash_mask + 1;
> 	sysctl_tcp_max_orphans =3D cnt / 2;
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 5c35fd568b13..1950ff80fb3f 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3696,7 +3696,7 @@ static int smc_parse_options(const struct tcphdr *t=
h,
> void tcp_parse_options(const struct net *net,
> 		       const struct sk_buff *skb,
> 		       struct tcp_options_received *opt_rx, int estab,
> -		       struct tcp_fastopen_cookie *foc)
> +		       struct tcp_fastopen_cookie *foc, struct sock *sk)
> {
> 	const unsigned char *ptr;
> 	const struct tcphdr *th =3D tcp_hdr(skb);
> @@ -3796,9 +3796,18 @@ void tcp_parse_options(const struct net *net,
> 					tcp_parse_fastopen_option(opsize -
> 						TCPOLEN_EXP_FASTOPEN_BASE,
> 						ptr + 2, th->syn, foc, true);
> -				else
> -					smc_parse_options(th, opt_rx, ptr,
> -							  opsize);
> +				else if (smc_parse_options(th, opt_rx, ptr,
> +							   opsize))
> +					break;
> +				else if (opsize >=3D TCPOLEN_EXP_BASE)
> +					tcp_extopt_parse(get_unaligned_be32(ptr),
> +							 opsize, ptr, skb,
> +							 opt_rx, sk);
> +				break;
> +
> +			default:
> +				tcp_extopt_parse(opcode, opsize, ptr, skb,
> +						 opt_rx, sk);
> 				break;
>
> 			}
> @@ -3849,11 +3858,13 @@ static bool tcp_fast_parse_options(const struct n=
et *net,
> 			goto extra_opt_check;
> 	}
>
> -	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL);
> +	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL, tcp_to_sk(tp));
> 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
> 		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
>
> extra_opt_check:
> +	if (unlikely(!hlist_empty(&tp->tcp_option_list)))
> +		return tcp_extopt_check(tcp_to_sk(tp), skb, &tp->rx_opt);
> 	return false;
> }
>
> @@ -5327,6 +5338,9 @@ void tcp_rcv_established(struct sock *sk, struct sk=
_buff *skb,
>
> 	tp->rx_opt.saw_tstamp =3D 0;
>
> +	if (!hlist_empty(&tp->tcp_option_list))
> +		goto slow_path;
> +
> 	/*	pred_flags is 0xS?10 << 16 + snd_wnd
> 	 *	if header_prediction is to be made
> 	 *	'S' will always be tp->tcp_header_len >> 2
> @@ -5514,7 +5528,7 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk=
, struct sk_buff *synack,
> 		/* Get original SYNACK MSS value if user MSS sets mss_clamp */
> 		tcp_clear_options(&opt);
> 		opt.user_mss =3D opt.mss_clamp =3D 0;
> -		tcp_parse_options(sock_net(sk), synack, &opt, 0, NULL);
> +		tcp_parse_options(sock_net(sk), synack, &opt, 0, NULL, sk);
> 		mss =3D opt.mss_clamp;
> 	}
>
> @@ -5577,10 +5591,14 @@ static int tcp_rcv_synsent_state_process(struct s=
ock *sk, struct sk_buff *skb,
> 	int saved_clamp =3D tp->rx_opt.mss_clamp;
> 	bool fastopen_fail;
>
> -	tcp_parse_options(sock_net(sk), skb, &tp->rx_opt, 0, &foc);
> +	tcp_parse_options(sock_net(sk), skb, &tp->rx_opt, 0, &foc, sk);
> 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
> 		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
>
> +	if (unlikely(!hlist_empty(&tp->tcp_option_list)) &&
> +	    tcp_extopt_check(sk, skb, &tp->rx_opt))
> +		goto discard;
> +
> 	if (th->ack) {
> 		/* rfc793:
> 		 * "If the state is SYN-SENT then
> @@ -5663,6 +5681,9 @@ static int tcp_rcv_synsent_state_process(struct soc=
k *sk, struct sk_buff *skb,
> 			tp->tcp_header_len =3D sizeof(struct tcphdr);
> 		}
>
> +		if (unlikely(!hlist_empty(&tp->tcp_option_list)))
> +			tcp_extopt_post_process(sk, &tp->rx_opt);
> +
> 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
> 		tcp_initialize_rcv_mss(sk);
>
> @@ -5756,6 +5777,9 @@ static int tcp_rcv_synsent_state_process(struct soc=
k *sk, struct sk_buff *skb,
>
> 		tcp_ecn_rcv_syn(tp, th);
>
> +		if (unlikely(!hlist_empty(&tp->tcp_option_list)))
> +			tcp_extopt_post_process(sk, &tp->rx_opt);
> +
> 		tcp_mtup_init(sk);
> 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
> 		tcp_initialize_rcv_mss(sk);
> @@ -6239,12 +6263,17 @@ int tcp_conn_request(struct request_sock_ops *rsk=
_ops,
>
> 	tcp_rsk(req)->af_specific =3D af_ops;
> 	tcp_rsk(req)->ts_off =3D 0;
> +	INIT_HLIST_HEAD(&tcp_rsk(req)->tcp_option_list);
>
> 	tcp_clear_options(&tmp_opt);
> 	tmp_opt.mss_clamp =3D af_ops->mss_clamp;
> 	tmp_opt.user_mss  =3D tp->rx_opt.user_mss;
> 	tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0,
> -			  want_cookie ? NULL : &foc);
> +			  want_cookie ? NULL : &foc, sk);
> +
> +	if (unlikely(!hlist_empty(&tp->tcp_option_list)) &&
> +	    tcp_extopt_check(sk, skb, &tmp_opt))
> +		goto drop_and_free;
>
> 	if (want_cookie && !tmp_opt.saw_tstamp)
> 		tcp_clear_options(&tmp_opt);
> @@ -6305,6 +6334,10 @@ int tcp_conn_request(struct request_sock_ops *rsk_=
ops,
> 		tcp_reqsk_record_syn(sk, req, skb);
> 		fastopen_sk =3D tcp_try_fastopen(sk, skb, req, &foc, dst);
> 	}
> +
> +	if (unlikely(!hlist_empty(&tp->tcp_option_list)))
> +		tcp_extopt_copy(sk, req, &tmp_opt);
> +
> 	if (fastopen_sk) {
> 		af_ops->send_synack(fastopen_sk, dst, &fl, req,
> 				    &foc, TCP_SYNACK_FASTOPEN);
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 94e28350f420..4e8690667b17 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -600,10 +600,9 @@ static void tcp_v4_send_reset(const struct sock *sk,=
 struct sk_buff *skb)
> 	const struct tcphdr *th =3D tcp_hdr(skb);
> 	struct {
> 		struct tcphdr th;
> -#ifdef CONFIG_TCP_MD5SIG
> -		__be32 opt[(TCPOLEN_MD5SIG_ALIGNED >> 2)];
> -#endif
> +		__be32 opt[(MAX_TCP_OPTION_SPACE >> 2)];
> 	} rep;
> +	struct hlist_head *extopt_list =3D NULL;
> 	struct ip_reply_arg arg;
> #ifdef CONFIG_TCP_MD5SIG
> 	struct tcp_md5sig_key *key =3D NULL;
> @@ -613,6 +612,7 @@ static void tcp_v4_send_reset(const struct sock *sk, =
struct sk_buff *skb)
> 	struct sock *sk1 =3D NULL;
> #endif
> 	struct net *net;
> +	int offset =3D 0;
>
> 	/* Never send a reset in response to a reset. */
> 	if (th->rst)
> @@ -624,6 +624,9 @@ static void tcp_v4_send_reset(const struct sock *sk, =
struct sk_buff *skb)
> 	if (!sk && skb_rtable(skb)->rt_type !=3D RTN_LOCAL)
> 		return;
>
> +	if (sk)
> +		extopt_list =3D tcp_extopt_get_list(sk);
> +
> 	/* Swap the send and the receive. */
> 	memset(&rep, 0, sizeof(rep));
> 	rep.th.dest   =3D th->source;
> @@ -678,19 +681,44 @@ static void tcp_v4_send_reset(const struct sock *sk=
, struct sk_buff *skb)
> 			goto out;
>
> 	}
> +#endif
> +
> +	if (unlikely(extopt_list && !hlist_empty(extopt_list))) {
> +		unsigned int remaining;
> +		struct tcp_out_options opts;
> +		int used;
> +
> +		remaining =3D sizeof(rep.opt);
> +#ifdef CONFIG_TCP_MD5SIG
> +		if (key)
> +			remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
> +#endif
> +
> +		memset(&opts, 0, sizeof(opts));
> +
> +		used =3D tcp_extopt_response_prepare(skb, TCPHDR_RST, remaining,
> +						   &opts, sk);
> +
> +		arg.iov[0].iov_len +=3D used;
> +		rep.th.doff =3D arg.iov[0].iov_len / 4;
> +
> +		tcp_extopt_response_write(&rep.opt[0], skb, &rep.th, &opts, sk);
> +		offset +=3D used / 4;
> +	}
>
> +#ifdef CONFIG_TCP_MD5SIG
> 	if (key) {
> -		rep.opt[0] =3D htonl((TCPOPT_NOP << 24) |
> -				   (TCPOPT_NOP << 16) |
> -				   (TCPOPT_MD5SIG << 8) |
> -				   TCPOLEN_MD5SIG);
> +		rep.opt[offset++] =3D htonl((TCPOPT_NOP << 24) |
> +					  (TCPOPT_NOP << 16) |
> +					  (TCPOPT_MD5SIG << 8) |
> +					  TCPOLEN_MD5SIG);
> 		/* Update length and the length the header thinks exists */
> 		arg.iov[0].iov_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> 		rep.th.doff =3D arg.iov[0].iov_len / 4;
>
> -		tcp_v4_md5_hash_hdr((__u8 *) &rep.opt[1],
> -				     key, ip_hdr(skb)->saddr,
> -				     ip_hdr(skb)->daddr, &rep.th);
> +		tcp_v4_md5_hash_hdr((__u8 *)&rep.opt[offset],
> +				    key, ip_hdr(skb)->saddr,
> +				    ip_hdr(skb)->daddr, &rep.th);
> 	}
> #endif
> 	arg.csum =3D csum_tcpudp_nofold(ip_hdr(skb)->daddr,
> @@ -742,14 +770,14 @@ static void tcp_v4_send_ack(const struct sock *sk,
> 	const struct tcphdr *th =3D tcp_hdr(skb);
> 	struct {
> 		struct tcphdr th;
> -		__be32 opt[(TCPOLEN_TSTAMP_ALIGNED >> 2)
> -#ifdef CONFIG_TCP_MD5SIG
> -			   + (TCPOLEN_MD5SIG_ALIGNED >> 2)
> -#endif
> -			];
> +		__be32 opt[(MAX_TCP_OPTION_SPACE >> 2)];
> 	} rep;
> +	struct hlist_head *extopt_list =3D NULL;
> 	struct net *net =3D sock_net(sk);
> 	struct ip_reply_arg arg;
> +	int offset =3D 0;
> +
> +	extopt_list =3D tcp_extopt_get_list(sk);
>
> 	memset(&rep.th, 0, sizeof(struct tcphdr));
> 	memset(&arg, 0, sizeof(arg));
> @@ -763,6 +791,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
> 		rep.opt[1] =3D htonl(tsval);
> 		rep.opt[2] =3D htonl(tsecr);
> 		arg.iov[0].iov_len +=3D TCPOLEN_TSTAMP_ALIGNED;
> +		offset +=3D 3;
> 	}
>
> 	/* Swap the send and the receive. */
> @@ -774,22 +803,45 @@ static void tcp_v4_send_ack(const struct sock *sk,
> 	rep.th.ack     =3D 1;
> 	rep.th.window  =3D htons(win);
>
> +	if (unlikely(extopt_list && !hlist_empty(extopt_list))) {
> +		unsigned int remaining;
> +		struct tcp_out_options opts;
> +		int used;
> +
> +		remaining =3D sizeof(rep.th) + sizeof(rep.opt) - arg.iov[0].iov_len;
> +
> #ifdef CONFIG_TCP_MD5SIG
> -	if (key) {
> -		int offset =3D (tsecr) ? 3 : 0;
> +		if (key)
> +			remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
> +#endif
> +
> +		memset(&opts, 0, sizeof(opts));
> +		used =3D tcp_extopt_response_prepare(skb, TCPHDR_ACK, remaining,
> +						   &opts, sk);
> +
> +		arg.iov[0].iov_len +=3D used;
> +		rep.th.doff =3D arg.iov[0].iov_len / 4;
> +
> +		tcp_extopt_response_write(&rep.opt[offset], skb, &rep.th, &opts, sk);
>
> +		offset +=3D used / 4;
> +	}
> +
> +#ifdef CONFIG_TCP_MD5SIG
> +	if (key) {
> 		rep.opt[offset++] =3D htonl((TCPOPT_NOP << 24) |
> 					  (TCPOPT_NOP << 16) |
> 					  (TCPOPT_MD5SIG << 8) |
> 					  TCPOLEN_MD5SIG);
> 		arg.iov[0].iov_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> -		rep.th.doff =3D arg.iov[0].iov_len/4;
> +		rep.th.doff =3D arg.iov[0].iov_len / 4;
>
> 		tcp_v4_md5_hash_hdr((__u8 *) &rep.opt[offset],
> 				    key, ip_hdr(skb)->saddr,
> 				    ip_hdr(skb)->daddr, &rep.th);
> 	}
> #endif
> +
> 	arg.flags =3D reply_flags;
> 	arg.csum =3D csum_tcpudp_nofold(ip_hdr(skb)->daddr,
> 				      ip_hdr(skb)->saddr, /* XXX */
> @@ -893,6 +945,9 @@ static int tcp_v4_send_synack(const struct sock *sk, =
struct dst_entry *dst,
>  */
> static void tcp_v4_reqsk_destructor(struct request_sock *req)
> {
> +	if (unlikely(!hlist_empty(&tcp_rsk(req)->tcp_option_list)))
> +		tcp_extopt_destroy(req_to_sk(req));
> +
> 	kfree(rcu_dereference_protected(inet_rsk(req)->ireq_opt, 1));
> }
>
> @@ -1387,6 +1442,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
k *sk, struct sk_buff *skb,
>
> 	tcp_initialize_rcv_mss(newsk);
>
> +	if (unlikely(!hlist_empty(&tcp_rsk(req)->tcp_option_list))) {
> +		tcp_extopt_move(req_to_sk(req), newsk);
> +		INIT_HLIST_HEAD(&tcp_rsk(req)->tcp_option_list);
> +	}
> #ifdef CONFIG_TCP_MD5SIG
> 	/* Copy over the MD5 key from the original socket */
> 	key =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&newinet->inet_daddr,
> @@ -1907,6 +1966,8 @@ void tcp_v4_destroy_sock(struct sock *sk)
> 	/* Cleans up our, hopefully empty, out_of_order_queue. */
> 	skb_rbtree_purge(&tp->out_of_order_queue);
>
> +	if (unlikely(!hlist_empty(&tp->tcp_option_list)))
> +		tcp_extopt_destroy(sk);
> #ifdef CONFIG_TCP_MD5SIG
> 	/* Clean up the MD5 key list, if any */
> 	if (tp->md5sig_info) {
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index a8384b0c11f8..676ad7ca13ad 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -95,9 +95,10 @@ tcp_timewait_state_process(struct inet_timewait_sock *=
tw, struct sk_buff *skb,
> 	struct tcp_timewait_sock *tcptw =3D tcp_twsk((struct sock *)tw);
> 	bool paws_reject =3D false;
>
> -	tmp_opt.saw_tstamp =3D 0;
> +	tcp_clear_options(&tmp_opt);
> 	if (th->doff > (sizeof(*th) >> 2) && tcptw->tw_ts_recent_stamp) {
> -		tcp_parse_options(twsk_net(tw), skb, &tmp_opt, 0, NULL);
> +		tcp_parse_options(twsk_net(tw), skb, &tmp_opt, 0, NULL,
> +				  (struct sock *)tw);
>
> 		if (tmp_opt.saw_tstamp) {
> 			if (tmp_opt.rcv_tsecr)
> @@ -108,6 +109,10 @@ tcp_timewait_state_process(struct inet_timewait_sock=
 *tw, struct sk_buff *skb,
> 		}
> 	}
>
> +	if (unlikely(!hlist_empty(&tcptw->tcp_option_list)) &&
> +	    tcp_extopt_check((struct sock *)tw, skb, &tmp_opt))
> +		return TCP_TW_SUCCESS;
> +
> 	if (tw->tw_substate =3D=3D TCP_FIN_WAIT2) {
> 		/* Just repeat all the checks of tcp_rcv_state_process() */
>
> @@ -251,7 +256,7 @@ EXPORT_SYMBOL(tcp_timewait_state_process);
> void tcp_time_wait(struct sock *sk, int state, int timeo)
> {
> 	const struct inet_connection_sock *icsk =3D inet_csk(sk);
> -	const struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> 	struct inet_timewait_sock *tw;
> 	struct inet_timewait_death_row *tcp_death_row =3D &sock_net(sk)->ipv4.tc=
p_death_row;
>
> @@ -271,6 +276,7 @@ void tcp_time_wait(struct sock *sk, int state, int ti=
meo)
> 		tcptw->tw_ts_recent_stamp =3D tp->rx_opt.ts_recent_stamp;
> 		tcptw->tw_ts_offset	=3D tp->tsoffset;
> 		tcptw->tw_last_oow_ack_time =3D 0;
> +		INIT_HLIST_HEAD(&tcptw->tcp_option_list);
>
> #if IS_ENABLED(CONFIG_IPV6)
> 		if (tw->tw_family =3D=3D PF_INET6) {
> @@ -284,6 +290,10 @@ void tcp_time_wait(struct sock *sk, int state, int t=
imeo)
> 		}
> #endif
>
> +		if (unlikely(!hlist_empty(&tp->tcp_option_list))) {
> +			tcp_extopt_move(sk, (struct sock *)tw);
> +			INIT_HLIST_HEAD(&tp->tcp_option_list);
> +		}
> #ifdef CONFIG_TCP_MD5SIG
> 		/*
> 		 * The timewait bucket does not have the key DB from the
> @@ -341,6 +351,9 @@ void tcp_twsk_destructor(struct sock *sk)
> 	if (twsk->tw_md5_key)
> 		kfree_rcu(twsk->tw_md5_key, rcu);
> #endif
> +
> +	if (unlikely(!hlist_empty(&twsk->tcp_option_list)))
> +		tcp_extopt_destroy(sk);
> }
> EXPORT_SYMBOL_GPL(tcp_twsk_destructor);
>
> @@ -470,6 +483,7 @@ struct sock *tcp_create_openreq_child(const struct so=
ck *sk,
>
> 		INIT_LIST_HEAD(&newtp->tsq_node);
> 		INIT_LIST_HEAD(&newtp->tsorted_sent_queue);
> +		INIT_HLIST_HEAD(&newtp->tcp_option_list);
>
> 		tcp_init_wl(newtp, treq->rcv_isn);
>
> @@ -545,6 +559,9 @@ struct sock *tcp_create_openreq_child(const struct so=
ck *sk,
> 		if (newtp->af_specific->md5_lookup(sk, newsk))
> 			newtp->tcp_header_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> #endif
> +		if (unlikely(!hlist_empty(&treq->tcp_option_list)))
> +			newtp->tcp_header_len +=3D tcp_extopt_add_header(req_to_sk(req), news=
k);
> +
> 		if (skb->len >=3D TCP_MSS_DEFAULT + newtp->tcp_header_len)
> 			newicsk->icsk_ack.last_seg_size =3D skb->len - newtp->tcp_header_len;
> 		newtp->rx_opt.mss_clamp =3D req->mss;
> @@ -587,9 +604,10 @@ struct sock *tcp_check_req(struct sock *sk, struct s=
k_buff *skb,
> 	bool paws_reject =3D false;
> 	bool own_req;
>
> -	tmp_opt.saw_tstamp =3D 0;
> +	tcp_clear_options(&tmp_opt);
> 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
> -		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
> +		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL,
> +				  req_to_sk(req));
>
> 		if (tmp_opt.saw_tstamp) {
> 			tmp_opt.ts_recent =3D req->ts_recent;
> @@ -604,6 +622,10 @@ struct sock *tcp_check_req(struct sock *sk, struct s=
k_buff *skb,
> 		}
> 	}
>
> +	if (unlikely(!hlist_empty(&tcp_rsk(req)->tcp_option_list)) &&
> +	    tcp_extopt_check(req_to_sk(req), skb, &tmp_opt))
> +		return NULL;
> +
> 	/* Check for pure retransmitted SYN. */
> 	if (TCP_SKB_CB(skb)->seq =3D=3D tcp_rsk(req)->rcv_isn &&
> 	    flg =3D=3D TCP_FLAG_SYN &&
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index efe599a41e36..6804a9325107 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -398,13 +398,6 @@ static inline bool tcp_urg_mode(const struct tcp_soc=
k *tp)
> 	return tp->snd_una !=3D tp->snd_up;
> }
>
> -#define OPTION_SACK_ADVERTISE	(1 << 0)
> -#define OPTION_TS		(1 << 1)
> -#define OPTION_MD5		(1 << 2)
> -#define OPTION_WSCALE		(1 << 3)
> -#define OPTION_FAST_OPEN_COOKIE	(1 << 8)
> -#define OPTION_SMC		(1 << 9)
> -
> static void smc_options_write(__be32 *ptr, u16 *options)
> {
> #if IS_ENABLED(CONFIG_SMC)
> @@ -420,17 +413,6 @@ static void smc_options_write(__be32 *ptr, u16 *opti=
ons)
> #endif
> }
>
> -struct tcp_out_options {
> -	u16 options;		/* bit field of OPTION_* */
> -	u16 mss;		/* 0 to disable */
> -	u8 ws;			/* window scale, 0 to disable */
> -	u8 num_sack_blocks;	/* number of SACK blocks to include */
> -	u8 hash_size;		/* bytes in hash_location */
> -	__u8 *hash_location;	/* temporary pointer, overloaded */
> -	__u32 tsval, tsecr;	/* need to include OPTION_TS */
> -	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
> -};
> -
> /* Write previously computed TCP options to the packet.
>  *
>  * Beware: Something in the Internet is very sensitive to the ordering of
> @@ -447,12 +429,15 @@ struct tcp_out_options {
> static void tcp_options_write(__be32 *ptr, struct sk_buff *skb, struct so=
ck *sk,
> 			      struct tcp_out_options *opts)
> {
> +	struct hlist_head *extopt_list;
> 	u16 options =3D opts->options;	/* mungable copy */
> 	struct tcp_sock *tp =3D NULL;
>
> 	if (sk_fullsock(sk))
> 		tp =3D tcp_sk(sk);
>
> +	extopt_list =3D tcp_extopt_get_list(sk);
> +
> 	if (unlikely(OPTION_MD5 & options)) {
> 		*ptr++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
> 			       (TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
> @@ -543,6 +528,9 @@ static void tcp_options_write(__be32 *ptr, struct sk_=
buff *skb, struct sock *sk,
> 	}
>
> 	smc_options_write(ptr, &options);
> +
> +	if (unlikely(!hlist_empty(extopt_list)))
> +		tcp_extopt_write(ptr, skb, opts, sk);
> }
>
> static void smc_set_option(const struct tcp_sock *tp,
> @@ -645,6 +633,10 @@ static unsigned int tcp_syn_options(struct sock *sk,=
 struct sk_buff *skb,
>
> 	smc_set_option(tp, opts, &remaining);
>
> +	if (unlikely(!hlist_empty(&tp->tcp_option_list)))
> +		remaining -=3D tcp_extopt_prepare(skb, TCPHDR_SYN, remaining,
> +						opts, tcp_to_sk(tp));
> +
> 	return MAX_TCP_OPTION_SPACE - remaining;
> }
>
> @@ -708,6 +700,11 @@ static unsigned int tcp_synack_options(const struct =
sock *sk,
>
> 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
>
> +	if (unlikely(!hlist_empty(&tcp_rsk(req)->tcp_option_list)))
> +		remaining -=3D tcp_extopt_prepare(skb, TCPHDR_SYN | TCPHDR_ACK,
> +						remaining, opts,
> +						req_to_sk(req));
> +
> 	return MAX_TCP_OPTION_SPACE - remaining;
> }
>
> @@ -741,6 +738,10 @@ static unsigned int tcp_established_options(struct s=
ock *sk, struct sk_buff *skb
> 		size +=3D TCPOLEN_TSTAMP_ALIGNED;
> 	}
>
> +	if (unlikely(!hlist_empty(&tp->tcp_option_list)))
> +		size +=3D tcp_extopt_prepare(skb, 0, MAX_TCP_OPTION_SPACE - size,
> +					   opts, tcp_to_sk(tp));
> +
> 	eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
> 	if (unlikely(eff_sacks)) {
> 		const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> @@ -3303,6 +3304,9 @@ static void tcp_connect_init(struct sock *sk)
> 		tp->tcp_header_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> #endif
>
> +	if (unlikely(!hlist_empty(&tp->tcp_option_list)))
> +		tp->tcp_header_len +=3D tcp_extopt_add_header(sk, sk);
> +
> 	/* If user gave his TCP_MAXSEG, record it to clamp */
> 	if (tp->rx_opt.user_mss)
> 		tp->rx_opt.mss_clamp =3D tp->rx_opt.user_mss;
> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index e7a3a6b6cf56..d0716c7e9390 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -162,7 +162,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct =
sk_buff *skb)
>
> 	/* check for timestamp cookie support */
> 	memset(&tcp_opt, 0, sizeof(tcp_opt));
> -	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL);
> +	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL, sk);
>
> 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
> 		tsoff =3D secure_tcpv6_ts_off(sock_net(sk),
> @@ -174,6 +174,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct=
 sk_buff *skb)
> 	if (!cookie_timestamp_decode(sock_net(sk), &tcp_opt))
> 		goto out;
>
> +	if (unlikely(!hlist_empty(&tp->tcp_option_list)) &&
> +	    tcp_extopt_check(sk, skb, &tcp_opt))
> +		goto out;
> +
> 	ret =3D NULL;
> 	req =3D inet_reqsk_alloc(&tcp6_request_sock_ops, sk, false);
> 	if (!req)
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 7178476b3d2f..54c6b0b87c4a 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -500,6 +500,9 @@ static int tcp_v6_send_synack(const struct sock *sk, =
struct dst_entry *dst,
>
> static void tcp_v6_reqsk_destructor(struct request_sock *req)
> {
> +	if (unlikely(!hlist_empty(&tcp_rsk(req)->tcp_option_list)))
> +		tcp_extopt_destroy(req_to_sk(req));
> +
> 	kfree(inet_rsk(req)->ipv6_opt);
> 	kfree_skb(inet_rsk(req)->pktopts);
> }
> @@ -789,6 +792,8 @@ static void tcp_v6_send_response(const struct sock *s=
k, struct sk_buff *skb, u32
> 	unsigned int tot_len =3D sizeof(struct tcphdr);
> 	struct dst_entry *dst;
> 	__be32 *topt;
> +	struct hlist_head *extopt_list =3D NULL;
> +	struct tcp_out_options extraopts;
>
> 	if (tsecr)
> 		tot_len +=3D TCPOLEN_TSTAMP_ALIGNED;
> @@ -797,6 +802,25 @@ static void tcp_v6_send_response(const struct sock *=
sk, struct sk_buff *skb, u32
> 		tot_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> #endif
>
> +	if (sk)
> +		extopt_list =3D tcp_extopt_get_list(sk);
> +
> +	if (unlikely(extopt_list && !hlist_empty(extopt_list))) {
> +		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - tot_len;
> +		u8 extraflags =3D rst ? TCPHDR_RST : 0;
> +		int used;
> +
> +		if (!rst || !th->ack)
> +			extraflags |=3D TCPHDR_ACK;
> +
> +		memset(&extraopts, 0, sizeof(extraopts));
> +
> +		used =3D tcp_extopt_response_prepare(skb, extraflags, remaining,
> +						   &extraopts, sk);
> +
> +		tot_len +=3D used;
> +	}
> +
> 	buff =3D alloc_skb(MAX_HEADER + sizeof(struct ipv6hdr) + tot_len,
> 			 GFP_ATOMIC);
> 	if (!buff)
> @@ -837,6 +861,9 @@ static void tcp_v6_send_response(const struct sock *s=
k, struct sk_buff *skb, u32
> 	}
> #endif
>
> +	if (unlikely(extopt_list && !hlist_empty(extopt_list)))
> +		tcp_extopt_response_write(topt, skb, t1, &extraopts, sk);
> +
> 	memset(&fl6, 0, sizeof(fl6));
> 	fl6.daddr =3D ipv6_hdr(skb)->saddr;
> 	fl6.saddr =3D ipv6_hdr(skb)->daddr;
> @@ -1196,6 +1223,11 @@ static struct sock *tcp_v6_syn_recv_sock(const str=
uct sock *sk, struct sk_buff *
> 	newinet->inet_daddr =3D newinet->inet_saddr =3D LOOPBACK4_IPV6;
> 	newinet->inet_rcv_saddr =3D LOOPBACK4_IPV6;
>
> +	if (unlikely(!hlist_empty(&tcp_rsk(req)->tcp_option_list))) {
> +		tcp_extopt_move(req_to_sk(req), newsk);
> +		INIT_HLIST_HEAD(&tcp_rsk(req)->tcp_option_list);
> +	}
> +
> #ifdef CONFIG_TCP_MD5SIG
> 	/* Copy over the MD5 key from the original socket */
> 	key =3D tcp_v6_md5_do_lookup(sk, &newsk->sk_v6_daddr);
> -- =

> 2.15.0
>
>

--
Mat Martineau
Intel OTC

--===============7478071982131222399==--
