Content-Type: multipart/mixed; boundary="===============0779239326513070625=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2] tcp: Register handlers for extra TCP options
Date: Thu, 05 Oct 2017 11:56:48 -0700
Message-ID: <alpine.OSX.2.21.1710050959320.36366@smurali1-mobl.amr.corp.intel.com>
In-Reply-To: 20171005074051.GP4897@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 120

--===============0779239326513070625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Christoph,

On Thu, 5 Oct 2017, Christoph Paasch wrote:

> Hello Mat,
>
> On 04/10/17 - 13:36:16, Mat Martineau wrote:
>> Allow additional TCP options to be handled by registered hook
>> functions.
>>
>> Registered options have a priority that determines the order in which
>> options are prepared and written. Lower priority numbers are handled
>> first.
>>
>> Option parsing will call the provided 'parse' function when a TCP option
>> number is not recognized by the normal option parsing code.
>>
>> The 'prepare' function determines the required space for registered
>> options and store associated data. 'write' adds the option to the TCP
>> header.
>>
>> A static key and RCU synchronization are used to minimize the
>> performance impact of these extensible TCP features.
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>>
>> Changes from v1: One 'prepare' callback (no more special callback for
>> request_sock), and add a few missing callback sites (like ipv6).
>
> great, I like that we now have only one 'prepare' callback.
>
>>
>> drivers/infiniband/hw/cxgb4/cm.c |   2 +-
>>  include/linux/tcp.h              |  22 +++++++
>>  include/net/tcp.h                |  40 +++++++++++-
>>  net/ipv4/syncookies.c            |   2 +-
>>  net/ipv4/tcp.c                   | 133 ++++++++++++++++++++++++++++++++=
+++++++
>>  net/ipv4/tcp_input.c             |  16 +++--
>>  net/ipv4/tcp_ipv4.c              |  80 ++++++++++++++++++-----
>>  net/ipv4/tcp_minisocks.c         |   4 +-
>>  net/ipv4/tcp_output.c            |  43 +++++++------
>>  net/ipv6/syncookies.c            |   2 +-
>>  net/ipv6/tcp_ipv6.c              |  28 ++++++++-
>>  11 files changed, 323 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cx=
gb4/cm.c
>> index daf7a56e5d7e..c3eb31611011 100644
>> --- a/drivers/infiniband/hw/cxgb4/cm.c
>> +++ b/drivers/infiniband/hw/cxgb4/cm.c
>> @@ -3752,7 +3752,7 @@ static void build_cpl_pass_accept_req(struct sk_bu=
ff *skb, int stid , u8 tos)
>>  	 */
>>  	memset(&tmp_opt, 0, sizeof(tmp_opt));
>>  	tcp_clear_options(&tmp_opt);
>> -	tcp_parse_options(&init_net, skb, &tmp_opt, 0, NULL);
>> +	tcp_parse_options(&init_net, skb, &tmp_opt, 0, NULL, NULL);
>>
>>  	req =3D __skb_push(skb, sizeof(*req));
>>  	memset(req, 0, sizeof(*req));
>> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
>> index 4aa40ef02d32..0347e6ce99be 100644
>> --- a/include/linux/tcp.h
>> +++ b/include/linux/tcp.h
>> @@ -112,6 +112,23 @@ static inline void tcp_clear_options(struct tcp_opt=
ions_received *rx_opt)
>>  	rx_opt->wscale_ok =3D rx_opt->snd_wscale =3D 0;
>>  }
>>
>> +#define OPTION_SACK_ADVERTISE	(1 << 0)
>> +#define OPTION_TS		(1 << 1)
>> +#define OPTION_MD5		(1 << 2)
>> +#define OPTION_WSCALE		(1 << 3)
>> +#define OPTION_FAST_OPEN_COOKIE	(1 << 8)
>> +
>> +struct tcp_out_options {
>> +	u16 options;		/* bit field of OPTION_* */
>> +	u16 mss;		/* 0 to disable */
>> +	u8 ws;			/* window scale, 0 to disable */
>> +	u8 num_sack_blocks;	/* number of SACK blocks to include */
>> +	u8 hash_size;		/* bytes in hash_location */
>> +	__u8 *hash_location;	/* temporary pointer, overloaded */
>> +	__u32 tsval, tsecr;	/* need to include OPTION_TS */
>> +	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
>> +};
>> +
>>  /* This is the max number of SACKS that we'll generate and process. It'=
s safe
>>   * to increase this, although since:
>>   *   size =3D TCPOLEN_SACK_BASE_ALIGNED (4) + n * TCPOLEN_SACK_PERBLOCK=
 (8)
>> @@ -389,6 +406,11 @@ static inline struct tcp_sock *tcp_sk(const struct =
sock *sk)
>>  	return (struct tcp_sock *)sk;
>>  }
>>
>> +static inline struct sock *tcp_to_sk(const struct tcp_sock *tp)
>> +{
>> +	return (struct sock *)tp;
>> +}
>
> Nice little function :)
>
>> +
>>  struct tcp_timewait_sock {
>>  	struct inet_timewait_sock tw_sk;
>>  #define tw_rcv_nxt tw_sk.__tw_common.skc_tw_rcv_nxt
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 3bc910a9bfc6..04f3dcecf592 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -433,7 +433,8 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg,=
 size_t len, int nonblock,
>>  		int flags, int *addr_len);
>>  void tcp_parse_options(const struct net *net, const struct sk_buff *skb,
>>  		       struct tcp_options_received *opt_rx,
>> -		       int estab, struct tcp_fastopen_cookie *foc);
>> +		       int estab, struct tcp_fastopen_cookie *foc,
>> +		       struct tcp_sock *tp);
>>  const u8 *tcp_parse_md5sig_option(const struct tcphdr *th);
>>
>>  /*
>> @@ -2109,4 +2110,41 @@ static inline bool tcp_bpf_ca_needs_ecn(struct so=
ck *sk)
>>  {
>>  	return (tcp_call_bpf(sk, BPF_SOCK_OPS_NEEDS_ECN) =3D=3D 1);
>>  }
>> +
>> +extern struct static_key_false tcp_extra_options_enabled;
>> +
>> +struct tcp_extra_option_ops {
>> +	struct list_head	list;
>> +	unsigned char		option_kind;
>> +	unsigned char		priority;
>> +	void (*parse)(int opsize, const unsigned char *opptr,
>> +		      const struct sk_buff *skb,
>> +		      struct tcp_options_received *opt_rx,
>> +		      struct sock *sk);
>> +	/* Return the number of bytes consumed */
>> +	unsigned int (*prepare)(struct sk_buff *skb, u8 flags,
>> +				unsigned int remaining,
>> +				struct tcp_out_options *opts,
>> +				const struct sock *sk);
>> +	void (*write)(__be32 *ptr, struct tcp_out_options *opts,
>> +		      const struct sock *sk);
>> +	struct module		*owner;
>> +};
>> +
>> +void tcp_extra_options_parse(int opcode, int opsize, const unsigned cha=
r *opptr,
>> +			     const struct sk_buff *skb,
>> +			     struct tcp_options_received *opt_rx,
>> +			     struct sock *sk);
>> +
>> +unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
>> +				       unsigned int remaining,
>> +				       struct tcp_out_options *opts,
>> +				       const struct sock *sk);
>> +
>> +void tcp_extra_options_write(__be32 *ptr, struct tcp_out_options *opts,
>> +			     const struct sock *sk);
>> +
>> +int tcp_register_extra_option(struct tcp_extra_option_ops *ops);
>> +void tcp_unregister_extra_option(struct tcp_extra_option_ops *ops);
>> +
>>  #endif	/* _TCP_H */
>> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
>> index b1bb1b3a1082..6c8d750a2243 100644
>> --- a/net/ipv4/syncookies.c
>> +++ b/net/ipv4/syncookies.c
>> @@ -313,7 +313,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct=
 sk_buff *skb)
>>
>>  	/* check for timestamp cookie support */
>>  	memset(&tcp_opt, 0, sizeof(tcp_opt));
>> -	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL);
>> +	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL, tp);
>>
>>  	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
>>  		tsoff =3D secure_tcp_ts_off(sock_net(sk),
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 5091402720ab..8136857b992b 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -270,6 +270,7 @@
>>  #include <linux/time.h>
>>  #include <linux/slab.h>
>>  #include <linux/errqueue.h>
>> +#include <linux/static_key.h>
>>
>>  #include <net/icmp.h>
>>  #include <net/inet_common.h>
>> @@ -306,6 +307,13 @@ EXPORT_SYMBOL(tcp_memory_allocated);
>>  struct percpu_counter tcp_sockets_allocated;
>>  EXPORT_SYMBOL(tcp_sockets_allocated);
>>
>> +/*
>> + * Optional TCP option handlers
>> + */
>> +static DEFINE_SPINLOCK(tcp_option_list_lock);
>> +static LIST_HEAD(tcp_option_list);
>> +DEFINE_STATIC_KEY_FALSE(tcp_extra_options_enabled);
>> +
>>  /*
>>   * TCP splice context
>>   */
>> @@ -3375,6 +3383,130 @@ EXPORT_SYMBOL(tcp_md5_hash_key);
>>
>>  #endif
>>
>> +/* Linear search, few entries are expected. The RCU read lock must
>> + * be held before calling.
>> + */
>> +static struct tcp_extra_option_ops *tcp_extra_options_find_kind(unsigne=
d char kind)
>> +{
>> +	struct tcp_extra_option_ops *entry;
>> +
>> +	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
>> +		if (entry->option_kind =3D=3D kind)
>> +			return entry;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +void tcp_extra_options_parse(int opcode, int opsize, const unsigned cha=
r *opptr,
>> +			     const struct sk_buff *skb,
>> +			     struct tcp_options_received *opt_rx,
>> +			     struct sock *sk)
>> +{
>> +	struct tcp_extra_option_ops *entry;
>> +
>> +	rcu_read_lock();
>> +	entry =3D tcp_extra_options_find_kind(opcode);
>> +	if (entry && entry->parse)
>> +		entry->parse(opsize, opptr, skb, opt_rx, sk);
>> +	rcu_read_unlock();
>> +}
>> +EXPORT_SYMBOL_GPL(tcp_extra_options_parse);
>> +
>> +/* The RCU read lock must be held before calling, and should span both
>> + * the call to this function and tcp_extra_options_write to ensure that
>> + * tcp_option_list does not change between the two calls. To preserve
>> + * expected option alignment, always returns a multiple of 4 bytes.
>> + */
>
> The RCU read lock won't be able to protect the list from being altered. A=
ll
> it will take care of is that the elements on the list won't get free'd wh=
ile
> traversing it and that the next-pointer won't get changed. That way the
> list-traversal is still fine.

Thanks for the description. If we switch to per-socket lists then RCU =

won't be necessary, but I think it's possible to coax RCU in to the =

behavior I want if:

* the list is copied/rebuilt every time an option is registered or =

unregistered

and

* tcp_extra_options_prepare returns a pointer to the version of the list =

for tcp_extra_options_write to use

But then it might as well be an array. The list should be short enough and =

rarely modified, so it wouldn't be a lot of overhead.

> If we move the extra-options to a mode where the list is on a per-TCP soc=
ket
> basis, we can avoid handling this. Because we can limit adding/removing
> TCP-options to happen only when the socket is in TCP_CLOSE. So, once the
> connection started, the list will always remain the same.

I was thinking a global list might still be useful to avoid complicating =

request_sock, but now realize that incoming connections would use the =

extra options list from the listening socket.

>> +unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
>> +				       unsigned int remaining,
>> +				       struct tcp_out_options *opts,
>> +				       const struct sock *sk)
>> +{
>> +	struct tcp_extra_option_ops *entry;
>> +	unsigned int used =3D 0;
>> +
>> +	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
>> +		if (unlikely(!entry->prepare))
>> +			continue;
>> +
>> +		used +=3D entry->prepare(skb, flags, remaining - used, opts, sk);
>> +	}
>> +
>> +	return roundup(used, 4);
>> +}
>> +EXPORT_SYMBOL_GPL(tcp_extra_options_prepare);
>> +
>> +/* The RCU read lock must be held before calling, and should span both
>> + * the call to tcp_extra_options_write and this function to ensure that
>> + * tcp_option_list does not change between the two calls.
>> + */
>> +void tcp_extra_options_write(__be32 *ptr, struct tcp_out_options *opts,
>> +			     const struct sock *sk)
>> +{
>> +	struct tcp_extra_option_ops *entry;
>> +
>> +	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
>> +		if (unlikely(!entry->write))
>> +			continue;
>> +
>> +		entry->write(ptr, opts, sk);
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(tcp_extra_options_write);
>> +
>> +int tcp_register_extra_option(struct tcp_extra_option_ops *ops)
>> +{
>> +	struct tcp_extra_option_ops *entry;
>> +	struct list_head* add_before =3D &tcp_option_list;
>> +	int ret =3D 0;
>> +
>> +	if (!ops->option_kind)
>> +		return -EINVAL;
>> +
>> +	if (!try_module_get(ops->owner))
>> +		return -ENOENT;
>> +
>> +	spin_lock(&tcp_option_list_lock);
>> +
>> +	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
>> +		if (entry->option_kind =3D=3D ops->option_kind) {
>> +			pr_notice("Option kind %u already registered\n",
>> +				  ops->option_kind);
>> +			spin_unlock(&tcp_option_list_lock);
>> +			module_put(ops->owner);
>> +			return -EEXIST;
>> +		}
>> +
>> +		if (entry->priority <=3D ops->priority)
>> +			add_before =3D &entry->list;
>> +	}
>> +
>> +	list_add_tail_rcu(&ops->list, add_before);
>> +	pr_debug("Option kind %u registered\n", ops->option_kind);
>> +
>> +	spin_unlock(&tcp_option_list_lock);
>> +
>> +	static_branch_inc(&tcp_extra_options_enabled);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(tcp_register_extra_option);
>> +
>> +void tcp_unregister_extra_option(struct tcp_extra_option_ops *ops)
>> +{
>> +	spin_lock(&tcp_option_list_lock);
>> +	list_del_rcu(&ops->list);
>> +	spin_unlock(&tcp_option_list_lock);
>> +
>> +	synchronize_net();
>> +
>> +	static_branch_dec(&tcp_extra_options_enabled);
>> +
>> +	module_put(ops->owner);
>> +}
>> +EXPORT_SYMBOL_GPL(tcp_unregister_extra_option);
>> +
>>  void tcp_done(struct sock *sk)
>>  {
>>  	struct request_sock *req =3D tcp_sk(sk)->fastopen_rsk;
>> @@ -3521,6 +3653,7 @@ void __init tcp_init(void)
>>  		INIT_HLIST_HEAD(&tcp_hashinfo.bhash[i].chain);
>>  	}
>>
>> +	INIT_LIST_HEAD(&tcp_option_list);
>>
>>  	cnt =3D tcp_hashinfo.ehash_mask + 1;
>>  	sysctl_tcp_max_orphans =3D cnt / 2;
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index c5d7656beeee..faf3c8d34cec 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -3728,7 +3728,7 @@ static void tcp_parse_fastopen_option(int len, con=
st unsigned char *cookie,
>>  void tcp_parse_options(const struct net *net,
>>  		       const struct sk_buff *skb,
>>  		       struct tcp_options_received *opt_rx, int estab,
>> -		       struct tcp_fastopen_cookie *foc)
>> +		       struct tcp_fastopen_cookie *foc, struct tcp_sock *tp)
>>  {
>>  	const unsigned char *ptr;
>>  	const struct tcphdr *th =3D tcp_hdr(skb);
>> @@ -3830,6 +3830,12 @@ void tcp_parse_options(const struct net *net,
>>  						ptr + 2, th->syn, foc, true);
>>  				break;
>>
>> +			default:
>> +				tcp_extra_options_parse(opcode, opsize, ptr,
>> +							skb, opt_rx,
>> +							tcp_to_sk(tp));
>> +				break;
>> +
>>  			}
>>  			ptr +=3D opsize-2;
>>  			length -=3D opsize;
>> @@ -3876,7 +3882,7 @@ static bool tcp_fast_parse_options(const struct ne=
t *net,
>>  			return true;
>>  	}
>>
>> -	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL);
>> +	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL, tp);
>>  	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
>>  		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
>>
>> @@ -5569,7 +5575,7 @@ static bool tcp_rcv_fastopen_synack(struct sock *s=
k, struct sk_buff *synack,
>>  		/* Get original SYNACK MSS value if user MSS sets mss_clamp */
>>  		tcp_clear_options(&opt);
>>  		opt.user_mss =3D opt.mss_clamp =3D 0;
>> -		tcp_parse_options(sock_net(sk), synack, &opt, 0, NULL);
>> +		tcp_parse_options(sock_net(sk), synack, &opt, 0, NULL, tp);
>>  		mss =3D opt.mss_clamp;
>>  	}
>>
>> @@ -5623,7 +5629,7 @@ static int tcp_rcv_synsent_state_process(struct so=
ck *sk, struct sk_buff *skb,
>>  	int saved_clamp =3D tp->rx_opt.mss_clamp;
>>  	bool fastopen_fail;
>>
>> -	tcp_parse_options(sock_net(sk), skb, &tp->rx_opt, 0, &foc);
>> +	tcp_parse_options(sock_net(sk), skb, &tp->rx_opt, 0, &foc, tp);
>>  	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
>>  		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
>>
>> @@ -6299,7 +6305,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_=
ops,
>>  	tmp_opt.mss_clamp =3D af_ops->mss_clamp;
>>  	tmp_opt.user_mss  =3D tp->rx_opt.user_mss;
>>  	tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0,
>> -			  want_cookie ? NULL : &foc);
>> +			  want_cookie ? NULL : &foc, tp);
>>
>>  	if (want_cookie && !tmp_opt.saw_tstamp)
>>  		tcp_clear_options(&tmp_opt);
>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> index d9416b5162bc..537734e70317 100644
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -598,9 +598,7 @@ static void tcp_v4_send_reset(const struct sock *sk,=
 struct sk_buff *skb)
>>  	const struct tcphdr *th =3D tcp_hdr(skb);
>>  	struct {
>>  		struct tcphdr th;
>> -#ifdef CONFIG_TCP_MD5SIG
>> -		__be32 opt[(TCPOLEN_MD5SIG_ALIGNED >> 2)];
>> -#endif
>> +		__be32 opt[(MAX_TCP_OPTION_SPACE >> 2)];
>>  	} rep;
>>  	struct ip_reply_arg arg;
>>  #ifdef CONFIG_TCP_MD5SIG
>> @@ -611,6 +609,7 @@ static void tcp_v4_send_reset(const struct sock *sk,=
 struct sk_buff *skb)
>>  	struct sock *sk1 =3D NULL;
>>  #endif
>>  	struct net *net;
>> +	int offset =3D 0;
>>
>>  	/* Never send a reset in response to a reset. */
>>  	if (th->rst)
>> @@ -676,17 +675,44 @@ static void tcp_v4_send_reset(const struct sock *s=
k, struct sk_buff *skb)
>>  			goto out;
>>
>>  	}
>> +#endif
>> +
>> +	if (static_branch_unlikely(&tcp_extra_options_enabled)) {
>> +		unsigned int remaining;
>> +		unsigned int used;
>> +		struct tcp_out_options opts;
>> +
>> +		remaining =3D sizeof(rep.opt);
>> +#ifdef CONFIG_TCP_MD5SIG
>> +		if (key)
>> +			remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
>> +#endif
>
> We will break TCP_MD5 here with this patch if we move it inside the static
> branch.
> Only after the patch that makes TCP_MD5 adopt the framework we can move t=
his
> code to here.

The MD5 option is handled outside the static branch (below), this bit of =

conditional code adjusts the space available to the extra options. The =

TCP options are not part of the MD5 digest, so it should be ok to write =

the extra options early.

>> +
>> +		memset(&opts, 0, sizeof(opts));
>> +
>> +		rcu_read_lock();
>> +		used =3D tcp_extra_options_prepare(NULL, TCPHDR_RST, remaining,
>> +						 &opts, sk);
>> +
>> +		tcp_extra_options_write(&rep.opt[0], &opts, sk);
>> +		rcu_read_unlock();
>> +
>> +		arg.iov[0].iov_len +=3D used;
>> +		offset +=3D used / 4;

If any extra options were written, the MD5 option offset is adjusted here.

>> +		rep.th.doff =3D arg.iov[0].iov_len / 4;
>> +	}

(End of static branch)

>> +#ifdef CONFIG_TCP_MD5SIG
>>  	if (key) {
>> -		rep.opt[0] =3D htonl((TCPOPT_NOP << 24) |
>> -				   (TCPOPT_NOP << 16) |
>> -				   (TCPOPT_MD5SIG << 8) |
>> -				   TCPOLEN_MD5SIG);
>> +		rep.opt[offset++] =3D htonl((TCPOPT_NOP << 24) |

The MD5 option will be written at the appropriate offset with or without =

the static branch above. Does that option need to be first? That could be =

accomodated.


Mat


>> +					  (TCPOPT_NOP << 16) |
>> +					  (TCPOPT_MD5SIG << 8) |
>> +					  TCPOLEN_MD5SIG);
>>  		/* Update length and the length the header thinks exists */
>>  		arg.iov[0].iov_len +=3D TCPOLEN_MD5SIG_ALIGNED;
>>  		rep.th.doff =3D arg.iov[0].iov_len / 4;
>>
>> -		tcp_v4_md5_hash_hdr((__u8 *) &rep.opt[1],
>> +		tcp_v4_md5_hash_hdr((__u8 *) &rep.opt[offset],
>>  				     key, ip_hdr(skb)->saddr,
>>  				     ip_hdr(skb)->daddr, &rep.th);
>>  	}
>> @@ -738,14 +764,11 @@ static void tcp_v4_send_ack(const struct sock *sk,
>>  	const struct tcphdr *th =3D tcp_hdr(skb);
>>  	struct {
>>  		struct tcphdr th;
>> -		__be32 opt[(TCPOLEN_TSTAMP_ALIGNED >> 2)
>> -#ifdef CONFIG_TCP_MD5SIG
>> -			   + (TCPOLEN_MD5SIG_ALIGNED >> 2)
>> -#endif
>> -			];
>> +		__be32 opt[(MAX_TCP_OPTION_SPACE >> 2)];
>>  	} rep;
>>  	struct net *net =3D sock_net(sk);
>>  	struct ip_reply_arg arg;
>> +	int offset =3D 0;
>>
>>  	memset(&rep.th, 0, sizeof(struct tcphdr));
>>  	memset(&arg, 0, sizeof(arg));
>> @@ -759,33 +782,56 @@ static void tcp_v4_send_ack(const struct sock *sk,
>>  		rep.opt[1] =3D htonl(tsval);
>>  		rep.opt[2] =3D htonl(tsecr);
>>  		arg.iov[0].iov_len +=3D TCPOLEN_TSTAMP_ALIGNED;
>> +		offset +=3D 3;
>>  	}
>>
>>  	/* Swap the send and the receive. */
>>  	rep.th.dest    =3D th->source;
>>  	rep.th.source  =3D th->dest;
>> -	rep.th.doff    =3D arg.iov[0].iov_len / 4;
>>  	rep.th.seq     =3D htonl(seq);
>>  	rep.th.ack_seq =3D htonl(ack);
>>  	rep.th.ack     =3D 1;
>>  	rep.th.window  =3D htons(win);
>>
>> +	if (static_branch_unlikely(&tcp_extra_options_enabled)) {
>> +		unsigned int remaining;
>> +		unsigned int used;
>> +		struct tcp_out_options opts;
>> +
>> +		remaining =3D sizeof(rep.th) + sizeof(rep.opt) - arg.iov[0].iov_len;
>>  #ifdef CONFIG_TCP_MD5SIG
>> -	if (key) {
>> -		int offset =3D (tsecr) ? 3 : 0;
>> +		if (key)
>> +			remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
>> +#endif
>>
>> +		memset(&opts, 0, sizeof(opts));
>> +		rcu_read_lock();
>> +		used =3D tcp_extra_options_prepare(NULL, TCPHDR_ACK, remaining,
>> +						 &opts, sk);
>> +
>> +		tcp_extra_options_write(&rep.opt[offset], &opts, sk);
>> +		rcu_read_unlock();
>> +
>> +		arg.iov[0].iov_len +=3D used;
>> +		offset +=3D used / 4;
>> +	}
>> +
>> +	rep.th.doff =3D arg.iov[0].iov_len / 4;
>> +
>> +#ifdef CONFIG_TCP_MD5SIG
>> +	if (key) {
>>  		rep.opt[offset++] =3D htonl((TCPOPT_NOP << 24) |
>>  					  (TCPOPT_NOP << 16) |
>>  					  (TCPOPT_MD5SIG << 8) |
>>  					  TCPOLEN_MD5SIG);
>>  		arg.iov[0].iov_len +=3D TCPOLEN_MD5SIG_ALIGNED;
>> -		rep.th.doff =3D arg.iov[0].iov_len/4;
>>
>>  		tcp_v4_md5_hash_hdr((__u8 *) &rep.opt[offset],
>>  				    key, ip_hdr(skb)->saddr,
>>  				    ip_hdr(skb)->daddr, &rep.th);
>>  	}
>>  #endif
>> +
>>  	arg.flags =3D reply_flags;
>>  	arg.csum =3D csum_tcpudp_nofold(ip_hdr(skb)->daddr,
>>  				      ip_hdr(skb)->saddr, /* XXX */
>> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
>> index 188a6f31356d..1c3e91899dac 100644
>> --- a/net/ipv4/tcp_minisocks.c
>> +++ b/net/ipv4/tcp_minisocks.c
>> @@ -98,7 +98,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *=
tw, struct sk_buff *skb,
>>
>>  	tmp_opt.saw_tstamp =3D 0;
>>  	if (th->doff > (sizeof(*th) >> 2) && tcptw->tw_ts_recent_stamp) {
>> -		tcp_parse_options(twsk_net(tw), skb, &tmp_opt, 0, NULL);
>> +		tcp_parse_options(twsk_net(tw), skb, &tmp_opt, 0, NULL, NULL);
>>
>>  		if (tmp_opt.saw_tstamp) {
>>  			if (tmp_opt.rcv_tsecr)
>> @@ -565,7 +565,7 @@ struct sock *tcp_check_req(struct sock *sk, struct s=
k_buff *skb,
>>
>>  	tmp_opt.saw_tstamp =3D 0;
>>  	if (th->doff > (sizeof(struct tcphdr)>>2)) {
>> -		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
>> +		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL, NULL);
>>
>>  		if (tmp_opt.saw_tstamp) {
>>  			tmp_opt.ts_recent =3D req->ts_recent;
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index 0bc9e46a5369..61eba3d0ae17 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -41,6 +41,7 @@
>>  #include <linux/compiler.h>
>>  #include <linux/gfp.h>
>>  #include <linux/module.h>
>> +#include <linux/static_key.h>
>>
>>  /* People can turn this off for buggy TCP's found in printers etc. */
>>  int sysctl_tcp_retrans_collapse __read_mostly =3D 1;
>> @@ -413,23 +414,6 @@ static inline bool tcp_urg_mode(const struct tcp_so=
ck *tp)
>>  	return tp->snd_una !=3D tp->snd_up;
>>  }
>>
>> -#define OPTION_SACK_ADVERTISE	(1 << 0)
>> -#define OPTION_TS		(1 << 1)
>> -#define OPTION_MD5		(1 << 2)
>> -#define OPTION_WSCALE		(1 << 3)
>> -#define OPTION_FAST_OPEN_COOKIE	(1 << 8)
>> -
>> -struct tcp_out_options {
>> -	u16 options;		/* bit field of OPTION_* */
>> -	u16 mss;		/* 0 to disable */
>> -	u8 ws;			/* window scale, 0 to disable */
>> -	u8 num_sack_blocks;	/* number of SACK blocks to include */
>> -	u8 hash_size;		/* bytes in hash_location */
>> -	__u8 *hash_location;	/* temporary pointer, overloaded */
>> -	__u32 tsval, tsecr;	/* need to include OPTION_TS */
>> -	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
>> -};
>> -
>>  /* Write previously computed TCP options to the packet.
>>   *
>>   * Beware: Something in the Internet is very sensitive to the ordering =
of
>> @@ -536,6 +520,9 @@ static void tcp_options_write(__be32 *ptr, struct tc=
p_sock *tp,
>>  		}
>>  		ptr +=3D (len + 3) >> 2;
>>  	}
>> +
>> +	if (static_branch_unlikely(&tcp_extra_options_enabled))
>> +		tcp_extra_options_write(ptr, opts, tcp_to_sk(tp));
>>  }
>>
>>  /* Compute TCP options for SYN packets. This is not the final
>> @@ -603,6 +590,11 @@ static unsigned int tcp_syn_options(struct sock *sk=
, struct sk_buff *skb,
>>  		}
>>  	}
>>
>> +	if (static_branch_unlikely(&tcp_extra_options_enabled))
>> +		remaining -=3D tcp_extra_options_prepare(skb, TCPHDR_SYN,
>> +						       remaining, opts,
>> +						       tcp_to_sk(tp));
>> +
>>  	return MAX_TCP_OPTION_SPACE - remaining;
>>  }
>>
>> @@ -663,6 +655,12 @@ static unsigned int tcp_synack_options(struct reque=
st_sock *req,
>>  		}
>>  	}
>>
>> +	if (static_branch_unlikely(&tcp_extra_options_enabled))
>> +		remaining -=3D tcp_extra_options_prepare(skb,
>> +						       TCPHDR_SYN | TCPHDR_ACK,
>> +						       remaining, opts,
>> +						       req_to_sk(req));
>> +
>>  	return MAX_TCP_OPTION_SPACE - remaining;
>>  }
>>
>> @@ -696,6 +694,11 @@ static unsigned int tcp_established_options(struct =
sock *sk, struct sk_buff *skb
>>  		size +=3D TCPOLEN_TSTAMP_ALIGNED;
>>  	}
>>
>> +	if (static_branch_unlikely(&tcp_extra_options_enabled))
>> +		size +=3D tcp_extra_options_prepare(skb, 0,
>> +						  MAX_TCP_OPTION_SPACE - size,
>> +						  opts, tcp_to_sk(tp));
>> +
>>  	eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
>>  	if (unlikely(eff_sacks)) {
>>  		const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
>> @@ -1016,6 +1019,7 @@ static int tcp_transmit_skb(struct sock *sk, struc=
t sk_buff *skb, int clone_it,
>>  	tcb =3D TCP_SKB_CB(skb);
>>  	memset(&opts, 0, sizeof(opts));
>>
>> +	rcu_read_lock();
>>  	if (unlikely(tcb->tcp_flags & TCPHDR_SYN))
>>  		tcp_options_size =3D tcp_syn_options(sk, skb, &opts, &md5);
>>  	else
>> @@ -1092,6 +1096,7 @@ static int tcp_transmit_skb(struct sock *sk, struc=
t sk_buff *skb, int clone_it,
>>  					       md5, sk, skb);
>>  	}
>>  #endif
>> +	rcu_read_unlock();
>>
>>  	icsk->icsk_af_ops->send_check(sk, skb);
>>
>> @@ -3156,8 +3161,8 @@ struct sk_buff *tcp_make_synack(const struct sock =
*sk, struct dst_entry *dst,
>>  #endif
>>  		skb->skb_mstamp =3D tcp_clock_us();
>>
>> -#ifdef CONFIG_TCP_MD5SIG
>>  	rcu_read_lock();
>> +#ifdef CONFIG_TCP_MD5SIG
>>  	md5 =3D tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req));
>>  #endif
>>  	skb_set_hash(skb, tcp_rsk(req)->txhash, PKT_HASH_TYPE_L4);
>> @@ -3196,8 +3201,8 @@ struct sk_buff *tcp_make_synack(const struct sock =
*sk, struct dst_entry *dst,
>>  	if (md5)
>>  		tcp_rsk(req)->af_specific->calc_md5_hash(opts.hash_location,
>>  					       md5, req_to_sk(req), skb);
>> -	rcu_read_unlock();
>>  #endif
>> +	rcu_read_unlock();
>>
>>  	/* Do not fool tcpdump (if any), clean our debris */
>>  	skb->tstamp =3D 0;
>> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
>> index 4e7817abc0b9..407480366c73 100644
>> --- a/net/ipv6/syncookies.c
>> +++ b/net/ipv6/syncookies.c
>> @@ -162,7 +162,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct=
 sk_buff *skb)
>>
>>  	/* check for timestamp cookie support */
>>  	memset(&tcp_opt, 0, sizeof(tcp_opt));
>> -	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL);
>> +	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL, tp);
>>
>>  	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
>>  		tsoff =3D secure_tcpv6_ts_off(sock_net(sk),
>> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
>> index 64d94afa427f..4a3fba1ef3a2 100644
>> --- a/net/ipv6/tcp_ipv6.c
>> +++ b/net/ipv6/tcp_ipv6.c
>> @@ -784,9 +784,10 @@ static void tcp_v6_send_response(const struct sock =
*sk, struct sk_buff *skb, u32
>>  	struct flowi6 fl6;
>>  	struct net *net =3D sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
>>  	struct sock *ctl_sk =3D net->ipv6.tcp_sk;
>> -	unsigned int tot_len =3D sizeof(struct tcphdr);
>> +	unsigned int tot_len =3D 0;
>>  	struct dst_entry *dst;
>>  	__be32 *topt;
>> +	struct tcp_out_options extraopts;
>>
>>  	if (tsecr)
>>  		tot_len +=3D TCPOLEN_TSTAMP_ALIGNED;
>> @@ -795,10 +796,28 @@ static void tcp_v6_send_response(const struct sock=
 *sk, struct sk_buff *skb, u32
>>  		tot_len +=3D TCPOLEN_MD5SIG_ALIGNED;
>>  #endif
>>
>> +	rcu_read_lock();
>> +	if (static_branch_unlikely(&tcp_extra_options_enabled)) {
>> +		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - tot_len;
>> +		u8 extraflags =3D rst ? TCPHDR_RST : 0;
>> +
>> +		if (!rst || !th->ack)
>> +			extraflags |=3D TCPHDR_ACK;
>> +
>> +		memset(&extraopts, 0, sizeof(extraopts));
>> +
>> +		tot_len +=3D tcp_extra_options_prepare(skb, extraflags, remaining,
>> +						     &extraopts, sk);
>> +	}
>> +
>> +	tot_len +=3D sizeof(struct tcphdr);
>> +
>>  	buff =3D alloc_skb(MAX_HEADER + sizeof(struct ipv6hdr) + tot_len,
>>  			 GFP_ATOMIC);
>> -	if (!buff)
>> +	if (!buff) {
>> +		rcu_read_unlock();
>>  		return;
>> +	}
>>
>>  	skb_reserve(buff, MAX_HEADER + sizeof(struct ipv6hdr) + tot_len);
>>
>> @@ -835,6 +854,11 @@ static void tcp_v6_send_response(const struct sock =
*sk, struct sk_buff *skb, u32
>>  	}
>>  #endif
>>
>> +	if (static_branch_unlikely(&tcp_extra_options_enabled))
>> +		tcp_extra_options_write(topt, &extraopts, sk);
>> +
>> +	rcu_read_unlock();
>> +
>>  	memset(&fl6, 0, sizeof(fl6));
>>  	fl6.daddr =3D ipv6_hdr(skb)->saddr;
>>  	fl6.saddr =3D ipv6_hdr(skb)->daddr;
>> --
>> 2.14.2
>>
>> _______________________________________________
>> mptcp mailing list
>> mptcp(a)lists.01.org
>> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel OTC

--===============0779239326513070625==--
