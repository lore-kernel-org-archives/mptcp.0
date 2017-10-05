Content-Type: multipart/mixed; boundary="===============1349299237623254090=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 15/18] tcp: Move TCP-MD5 code out of TCP itself
Date: Thu, 05 Oct 2017 14:15:26 -0700
Message-ID: <alpine.OSX.2.21.1710051335360.36366@smurali1-mobl.amr.corp.intel.com>
In-Reply-To: 20171003162204.17945-16-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 122

--===============1349299237623254090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 3 Oct 2017, Christoph Paasch wrote:

> This is all just copy-pasting the TCP_MD5-code into functions that are
> placed in net/ipv4/tcp_md5.c.
>
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
> include/linux/inet_diag.h |    1 +
> include/linux/tcp_md5.h   |  129 ++++++
> include/net/tcp.h         |   77 ----
> net/ipv4/Makefile         |    1 +
> net/ipv4/tcp.c            |  133 +-----
> net/ipv4/tcp_diag.c       |   81 +---
> net/ipv4/tcp_input.c      |   38 --
> net/ipv4/tcp_ipv4.c       |  498 +--------------------
> net/ipv4/tcp_md5.c        | 1080 ++++++++++++++++++++++++++++++++++++++++=
+++++
> net/ipv4/tcp_minisocks.c  |   27 +-
> net/ipv4/tcp_output.c     |    4 +-
> net/ipv6/tcp_ipv6.c       |  313 +------------
> 12 files changed, 1234 insertions(+), 1148 deletions(-)
> create mode 100644 include/linux/tcp_md5.h
> create mode 100644 net/ipv4/tcp_md5.c
>
> diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
> index ee251c585854..cfd9b2a05301 100644
> --- a/include/linux/inet_diag.h
> +++ b/include/linux/inet_diag.h
> @@ -1,6 +1,7 @@
> #ifndef _INET_DIAG_H_
> #define _INET_DIAG_H_ 1
>
> +#include <linux/user_namespace.h>
> #include <uapi/linux/inet_diag.h>
>
> struct net;
> diff --git a/include/linux/tcp_md5.h b/include/linux/tcp_md5.h
> new file mode 100644
> index 000000000000..73595e9783ed
> --- /dev/null
> +++ b/include/linux/tcp_md5.h
> @@ -0,0 +1,129 @@
> +#ifndef _LINUX_TCP_MD5_H
> +#define _LINUX_TCP_MD5_H
> +
> +#ifdef CONFIG_TCP_MD5SIG
> +
> +#include <linux/types.h>
> +
> +#include <net/tcp.h>
> +
> +union tcp_md5_addr {
> +	struct in_addr  a4;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	struct in6_addr	a6;
> +#endif
> +};
> +
> +/* - key database */
> +struct tcp_md5sig_key {
> +	struct hlist_node	node;
> +	u8			keylen;
> +	u8			family; /* AF_INET or AF_INET6 */
> +	union tcp_md5_addr	addr;
> +	u8			prefixlen;
> +	u8			key[TCP_MD5SIG_MAXKEYLEN];
> +	struct rcu_head		rcu;
> +};
> +
> +/* - sock block */
> +struct tcp_md5sig_info {
> +	struct hlist_head	head;
> +	struct rcu_head		rcu;
> +};
> +
> +union tcp_md5sum_block {
> +	struct tcp4_pseudohdr ip4;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	struct tcp6_pseudohdr ip6;
> +#endif
> +};
> +
> +/* - pool: digest algorithm, hash description and scratch buffer */
> +struct tcp_md5sig_pool {
> +	struct ahash_request	*md5_req;
> +	void			*scratch;
> +};
> +
> +extern const struct tcp_sock_af_ops tcp_sock_ipv4_specific;
> +extern const struct tcp_sock_af_ops tcp_sock_ipv6_specific;
> +extern const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
> +
> +/* - functions */
> +int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
> +			const struct sock *sk, const struct sk_buff *skb);
> +
> +struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
> +					 const struct sock *addr_sk);
> +
> +void tcp_v4_md5_destroy_sock(struct sock *sk);
> +
> +int tcp_v4_md5_send_reset(struct sk_buff *skb, const struct sock *sk,
> +			  struct ip_reply_arg *arg, struct tcphdr *repth,
> +			  __be32 *opt);
> +
> +void tcp_v4_md5_send_ack(struct sk_buff *skb, const struct sock *sk,
> +			 struct ip_reply_arg *arg, struct tcphdr *repth,
> +			 __be32 *opt);
> +
> +int tcp_v6_md5_send_response_write(struct sk_buff *skb, struct tcphdr *t=
1,
> +				   __be32 *topt, const struct sock *sk);
> +
> +bool tcp_v4_inbound_md5_hash(const struct sock *sk,
> +			     const struct sk_buff *skb);
> +
> +void tcp_v4_md5_syn_recv_sock(const struct sock *listener, struct sock *=
sk);
> +
> +void tcp_v6_md5_syn_recv_sock(const struct sock *listener, struct sock *=
sk);
> +
> +void tcp_md5_time_wait(struct sock *sk, struct inet_timewait_sock *tw);
> +
> +struct tcp_md5sig_key *tcp_v6_md5_lookup(const struct sock *sk,
> +					 const struct sock *addr_sk);
> +
> +int tcp_v6_md5_hash_skb(char *md5_hash,
> +			const struct tcp_md5sig_key *key,
> +			const struct sock *sk,
> +			const struct sk_buff *skb);
> +
> +bool tcp_v6_inbound_md5_hash(const struct sock *sk,
> +			     const struct sk_buff *skb);
> +
> +static inline void tcp_md5_twsk_destructor(struct sock *sk)
> +{
> +	struct tcp_timewait_sock *twsk =3D tcp_twsk(sk);
> +
> +	if (twsk->tw_md5_key)
> +		kfree_rcu(twsk->tw_md5_key, rcu);
> +}
> +
> +static inline void tcp_md5_add_header_len(const struct sock *listener,
> +					  struct sock *sk)
> +{
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +
> +	tp->md5sig_info =3D NULL;	/*XXX*/
> +	if (tp->af_specific->md5_lookup(listener, sk))
> +		tp->tcp_header_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> +}
> +
> +int tcp_md5_diag_get_aux(struct sock *sk, bool net_admin, struct sk_buff=
 *skb);
> +
> +int tcp_md5_diag_get_aux_size(struct sock *sk, bool net_admin);
> +
> +#else
> +
> +static inline bool tcp_v4_inbound_md5_hash(const struct sock *sk,
> +					   const struct sk_buff *skb)
> +{
> +	return false;
> +}
> +
> +static inline bool tcp_v6_inbound_md5_hash(const struct sock *sk,
> +					   const struct sk_buff *skb)
> +{
> +	return false;
> +}
> +
> +#endif
> +
> +#endif /* _LINUX_TCP_MD5_H */
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index bc3b8f655a43..384f47c2fe7f 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -435,7 +435,6 @@ void tcp_parse_options(const struct net *net, const s=
truct sk_buff *skb,
> 		       struct tcp_options_received *opt_rx,
> 		       int estab, struct tcp_fastopen_cookie *foc,
> 		       struct tcp_sock *tp);
> -const u8 *tcp_parse_md5sig_option(const struct tcphdr *th);
>
> /*
>  *	TCP v4 functions exported for the inet6 API
> @@ -1443,30 +1442,6 @@ static inline void tcp_clear_all_retrans_hints(str=
uct tcp_sock *tp)
> 	tp->retransmit_skb_hint =3D NULL;
> }
>
> -union tcp_md5_addr {
> -	struct in_addr  a4;
> -#if IS_ENABLED(CONFIG_IPV6)
> -	struct in6_addr	a6;
> -#endif
> -};
> -
> -/* - key database */
> -struct tcp_md5sig_key {
> -	struct hlist_node	node;
> -	u8			keylen;
> -	u8			family; /* AF_INET or AF_INET6 */
> -	union tcp_md5_addr	addr;
> -	u8			prefixlen;
> -	u8			key[TCP_MD5SIG_MAXKEYLEN];
> -	struct rcu_head		rcu;
> -};
> -
> -/* - sock block */
> -struct tcp_md5sig_info {
> -	struct hlist_head	head;
> -	struct rcu_head		rcu;
> -};
> -
> /* - pseudo header */
> struct tcp4_pseudohdr {
> 	__be32		saddr;
> @@ -1483,58 +1458,6 @@ struct tcp6_pseudohdr {
> 	__be32		protocol;	/* including padding */
> };
>
> -union tcp_md5sum_block {
> -	struct tcp4_pseudohdr ip4;
> -#if IS_ENABLED(CONFIG_IPV6)
> -	struct tcp6_pseudohdr ip6;
> -#endif
> -};
> -
> -/* - pool: digest algorithm, hash description and scratch buffer */
> -struct tcp_md5sig_pool {
> -	struct ahash_request	*md5_req;
> -	void			*scratch;
> -};
> -
> -/* - functions */
> -int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
> -			const struct sock *sk, const struct sk_buff *skb);
> -int tcp_md5_do_add(struct sock *sk, const union tcp_md5_addr *addr,
> -		   int family, u8 prefixlen, const u8 *newkey, u8 newkeylen,
> -		   gfp_t gfp);
> -int tcp_md5_do_del(struct sock *sk, const union tcp_md5_addr *addr,
> -		   int family, u8 prefixlen);
> -struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
> -					 const struct sock *addr_sk);
> -
> -#ifdef CONFIG_TCP_MD5SIG
> -struct tcp_md5sig_key *tcp_md5_do_lookup(const struct sock *sk,
> -					 const union tcp_md5_addr *addr,
> -					 int family);
> -#define tcp_twsk_md5_key(twsk)	((twsk)->tw_md5_key)
> -#else
> -static inline struct tcp_md5sig_key *tcp_md5_do_lookup(const struct sock=
 *sk,
> -					 const union tcp_md5_addr *addr,
> -					 int family)
> -{
> -	return NULL;
> -}
> -#define tcp_twsk_md5_key(twsk)	NULL
> -#endif
> -
> -bool tcp_alloc_md5sig_pool(void);
> -
> -struct tcp_md5sig_pool *tcp_get_md5sig_pool(void);
> -static inline void tcp_put_md5sig_pool(void)
> -{
> -	local_bh_enable();
> -}
> -
> -int tcp_md5_hash_skb_data(struct tcp_md5sig_pool *, const struct sk_buff=
 *,
> -			  unsigned int header_len);
> -int tcp_md5_hash_key(struct tcp_md5sig_pool *hp,
> -		     const struct tcp_md5sig_key *key);
> -
> /* From tcp_fastopen.c */
> void tcp_fastopen_cache_get(struct sock *sk, u16 *mss,
> 			    struct tcp_fastopen_cookie *cookie, int *syn_loss,
> diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
> index afcb435adfbe..f10c407c146d 100644
> --- a/net/ipv4/Makefile
> +++ b/net/ipv4/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_TCP_CONG_LP) +=3D tcp_lp.o
> obj-$(CONFIG_TCP_CONG_YEAH) +=3D tcp_yeah.o
> obj-$(CONFIG_TCP_CONG_ILLINOIS) +=3D tcp_illinois.o
> obj-$(CONFIG_NETLABEL) +=3D cipso_ipv4.o
> +obj-$(CONFIG_TCP_MD5SIG) +=3D tcp_md5.o
>
> obj-$(CONFIG_XFRM) +=3D xfrm4_policy.o xfrm4_state.o xfrm4_input.o \
> 		      xfrm4_output.o xfrm4_protocol.o
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e6aea011b65d..22ff47bb602d 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -271,6 +271,7 @@
> #include <linux/slab.h>
> #include <linux/errqueue.h>
> #include <linux/static_key.h>
> +#include <linux/tcp_md5.h>
>
> #include <net/icmp.h>
> #include <net/inet_common.h>
> @@ -3249,138 +3250,6 @@ int compat_tcp_getsockopt(struct sock *sk, int le=
vel, int optname,
> EXPORT_SYMBOL(compat_tcp_getsockopt);
> #endif
>
> -#ifdef CONFIG_TCP_MD5SIG
> -static DEFINE_PER_CPU(struct tcp_md5sig_pool, tcp_md5sig_pool);
> -static DEFINE_MUTEX(tcp_md5sig_mutex);
> -static bool tcp_md5sig_pool_populated =3D false;
> -
> -static void __tcp_alloc_md5sig_pool(void)
> -{
> -	struct crypto_ahash *hash;
> -	int cpu;
> -
> -	hash =3D crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
> -	if (IS_ERR(hash))
> -		return;
> -
> -	for_each_possible_cpu(cpu) {
> -		void *scratch =3D per_cpu(tcp_md5sig_pool, cpu).scratch;
> -		struct ahash_request *req;
> -
> -		if (!scratch) {
> -			scratch =3D kmalloc_node(sizeof(union tcp_md5sum_block) +
> -					       sizeof(struct tcphdr),
> -					       GFP_KERNEL,
> -					       cpu_to_node(cpu));
> -			if (!scratch)
> -				return;
> -			per_cpu(tcp_md5sig_pool, cpu).scratch =3D scratch;
> -		}
> -		if (per_cpu(tcp_md5sig_pool, cpu).md5_req)
> -			continue;
> -
> -		req =3D ahash_request_alloc(hash, GFP_KERNEL);
> -		if (!req)
> -			return;
> -
> -		ahash_request_set_callback(req, 0, NULL, NULL);
> -
> -		per_cpu(tcp_md5sig_pool, cpu).md5_req =3D req;
> -	}
> -	/* before setting tcp_md5sig_pool_populated, we must commit all writes
> -	 * to memory. See smp_rmb() in tcp_get_md5sig_pool()
> -	 */
> -	smp_wmb();
> -	tcp_md5sig_pool_populated =3D true;
> -}
> -
> -bool tcp_alloc_md5sig_pool(void)
> -{
> -	if (unlikely(!tcp_md5sig_pool_populated)) {
> -		mutex_lock(&tcp_md5sig_mutex);
> -
> -		if (!tcp_md5sig_pool_populated)
> -			__tcp_alloc_md5sig_pool();
> -
> -		mutex_unlock(&tcp_md5sig_mutex);
> -	}
> -	return tcp_md5sig_pool_populated;
> -}
> -EXPORT_SYMBOL(tcp_alloc_md5sig_pool);
> -
> -
> -/**
> - *	tcp_get_md5sig_pool - get md5sig_pool for this user
> - *
> - *	We use percpu structure, so if we succeed, we exit with preemption
> - *	and BH disabled, to make sure another thread or softirq handling
> - *	wont try to get same context.
> - */
> -struct tcp_md5sig_pool *tcp_get_md5sig_pool(void)
> -{
> -	local_bh_disable();
> -
> -	if (tcp_md5sig_pool_populated) {
> -		/* coupled with smp_wmb() in __tcp_alloc_md5sig_pool() */
> -		smp_rmb();
> -		return this_cpu_ptr(&tcp_md5sig_pool);
> -	}
> -	local_bh_enable();
> -	return NULL;
> -}
> -EXPORT_SYMBOL(tcp_get_md5sig_pool);
> -
> -int tcp_md5_hash_skb_data(struct tcp_md5sig_pool *hp,
> -			  const struct sk_buff *skb, unsigned int header_len)
> -{
> -	struct scatterlist sg;
> -	const struct tcphdr *tp =3D tcp_hdr(skb);
> -	struct ahash_request *req =3D hp->md5_req;
> -	unsigned int i;
> -	const unsigned int head_data_len =3D skb_headlen(skb) > header_len ?
> -					   skb_headlen(skb) - header_len : 0;
> -	const struct skb_shared_info *shi =3D skb_shinfo(skb);
> -	struct sk_buff *frag_iter;
> -
> -	sg_init_table(&sg, 1);
> -
> -	sg_set_buf(&sg, ((u8 *) tp) + header_len, head_data_len);
> -	ahash_request_set_crypt(req, &sg, NULL, head_data_len);
> -	if (crypto_ahash_update(req))
> -		return 1;
> -
> -	for (i =3D 0; i < shi->nr_frags; ++i) {
> -		const struct skb_frag_struct *f =3D &shi->frags[i];
> -		unsigned int offset =3D f->page_offset;
> -		struct page *page =3D skb_frag_page(f) + (offset >> PAGE_SHIFT);
> -
> -		sg_set_page(&sg, page, skb_frag_size(f),
> -			    offset_in_page(offset));
> -		ahash_request_set_crypt(req, &sg, NULL, skb_frag_size(f));
> -		if (crypto_ahash_update(req))
> -			return 1;
> -	}
> -
> -	skb_walk_frags(skb, frag_iter)
> -		if (tcp_md5_hash_skb_data(hp, frag_iter, 0))
> -			return 1;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(tcp_md5_hash_skb_data);
> -
> -int tcp_md5_hash_key(struct tcp_md5sig_pool *hp, const struct tcp_md5sig=
_key *key)
> -{
> -	struct scatterlist sg;
> -
> -	sg_init_one(&sg, key->key, key->keylen);
> -	ahash_request_set_crypt(hp->md5_req, &sg, NULL, key->keylen);
> -	return crypto_ahash_update(hp->md5_req);
> -}
> -EXPORT_SYMBOL(tcp_md5_hash_key);
> -
> -#endif
> -
> /* Linear search, few entries are expected. The RCU read lock must
>  * be held before calling.
>  */
> diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
> index abbf0edcf6c2..5cfe5dc8f8dd 100644
> --- a/net/ipv4/tcp_diag.c
> +++ b/net/ipv4/tcp_diag.c
> @@ -15,6 +15,7 @@
> #include <linux/inet_diag.h>
>
> #include <linux/tcp.h>
> +#include <linux/tcp_md5.h>
>
> #include <net/netlink.h>
> #include <net/tcp.h>
> @@ -37,70 +38,14 @@ static void tcp_diag_get_info(struct sock *sk, struct=
 inet_diag_msg *r,
> 		tcp_get_info(sk, info);
> }
>
> -#ifdef CONFIG_TCP_MD5SIG
> -static void tcp_diag_md5sig_fill(struct tcp_diag_md5sig *info,
> -				 const struct tcp_md5sig_key *key)
> -{
> -	info->tcpm_family =3D key->family;
> -	info->tcpm_prefixlen =3D key->prefixlen;
> -	info->tcpm_keylen =3D key->keylen;
> -	memcpy(info->tcpm_key, key->key, key->keylen);
> -
> -	if (key->family =3D=3D AF_INET)
> -		info->tcpm_addr[0] =3D key->addr.a4.s_addr;
> -	#if IS_ENABLED(CONFIG_IPV6)
> -	else if (key->family =3D=3D AF_INET6)
> -		memcpy(&info->tcpm_addr, &key->addr.a6,
> -		       sizeof(info->tcpm_addr));
> -	#endif
> -}
> -
> -static int tcp_diag_put_md5sig(struct sk_buff *skb,
> -			       const struct tcp_md5sig_info *md5sig)
> -{
> -	const struct tcp_md5sig_key *key;
> -	struct tcp_diag_md5sig *info;
> -	struct nlattr *attr;
> -	int md5sig_count =3D 0;
> -
> -	hlist_for_each_entry_rcu(key, &md5sig->head, node)
> -		md5sig_count++;
> -	if (md5sig_count =3D=3D 0)
> -		return 0;
> -
> -	attr =3D nla_reserve(skb, INET_DIAG_MD5SIG,
> -			   md5sig_count * sizeof(struct tcp_diag_md5sig));
> -	if (!attr)
> -		return -EMSGSIZE;
> -
> -	info =3D nla_data(attr);
> -	memset(info, 0, md5sig_count * sizeof(struct tcp_diag_md5sig));
> -	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
> -		tcp_diag_md5sig_fill(info++, key);
> -		if (--md5sig_count =3D=3D 0)
> -			break;
> -	}
> -
> -	return 0;
> -}
> -#endif
> -
> static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
> 			    struct sk_buff *skb)
> {
> #ifdef CONFIG_TCP_MD5SIG
> -	if (net_admin) {
> -		struct tcp_md5sig_info *md5sig;
> -		int err =3D 0;
> -
> -		rcu_read_lock();
> -		md5sig =3D rcu_dereference(tcp_sk(sk)->md5sig_info);
> -		if (md5sig)
> -			err =3D tcp_diag_put_md5sig(skb, md5sig);
> -		rcu_read_unlock();
> -		if (err < 0)
> -			return err;
> -	}
> +	int err =3D tcp_md5_diag_get_aux(sk, net_admin, skb);
> +
> +	if (err < 0)
> +		return err;
> #endif
>
> 	return 0;
> @@ -111,21 +56,7 @@ static size_t tcp_diag_get_aux_size(struct sock *sk, =
bool net_admin)
> 	size_t size =3D 0;
>
> #ifdef CONFIG_TCP_MD5SIG
> -	if (net_admin && sk_fullsock(sk)) {
> -		const struct tcp_md5sig_info *md5sig;
> -		const struct tcp_md5sig_key *key;
> -		size_t md5sig_count =3D 0;
> -
> -		rcu_read_lock();
> -		md5sig =3D rcu_dereference(tcp_sk(sk)->md5sig_info);
> -		if (md5sig) {
> -			hlist_for_each_entry_rcu(key, &md5sig->head, node)
> -				md5sig_count++;
> -		}
> -		rcu_read_unlock();
> -		size +=3D nla_total_size(md5sig_count *
> -				       sizeof(struct tcp_diag_md5sig));
> -	}
> +	size +=3D tcp_md5_diag_get_aux_size(sk, net_admin);
> #endif
>
> 	return size;
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index f0d17c36610d..bb4e63fb781f 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3887,44 +3887,6 @@ static bool tcp_fast_parse_options(const struct ne=
t *net,
> 	return true;
> }
>
> -#ifdef CONFIG_TCP_MD5SIG
> -/*
> - * Parse MD5 Signature option
> - */
> -const u8 *tcp_parse_md5sig_option(const struct tcphdr *th)
> -{
> -	int length =3D (th->doff << 2) - sizeof(*th);
> -	const u8 *ptr =3D (const u8 *)(th + 1);
> -
> -	/* If the TCP option is too short, we can short cut */
> -	if (length < TCPOLEN_MD5SIG)
> -		return NULL;
> -
> -	while (length > 0) {
> -		int opcode =3D *ptr++;
> -		int opsize;
> -
> -		switch (opcode) {
> -		case TCPOPT_EOL:
> -			return NULL;
> -		case TCPOPT_NOP:
> -			length--;
> -			continue;
> -		default:
> -			opsize =3D *ptr++;
> -			if (opsize < 2 || opsize > length)
> -				return NULL;
> -			if (opcode =3D=3D TCPOPT_MD5SIG)
> -				return opsize =3D=3D TCPOLEN_MD5SIG ? ptr : NULL;
> -		}
> -		ptr +=3D opsize - 2;
> -		length -=3D opsize;
> -	}
> -	return NULL;
> -}
> -EXPORT_SYMBOL(tcp_parse_md5sig_option);
> -#endif
> -
> /* Sorry, PAWS as specified is broken wrt. pure-ACKs -DaveM
>  *
>  * It is not fatal. If this ACK does _not_ change critical state (seqs, w=
indow)
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index f0e12a1e9ad4..6f54bf22d537 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -62,6 +62,7 @@
> #include <linux/init.h>
> #include <linux/times.h>
> #include <linux/slab.h>
> +#include <linux/tcp_md5.h>
>
> #include <net/net_namespace.h>
> #include <net/icmp.h>
> @@ -85,11 +86,6 @@
> #include <crypto/hash.h>
> #include <linux/scatterlist.h>
>
> -#ifdef CONFIG_TCP_MD5SIG
> -static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_k=
ey *key,
> -			       __be32 daddr, __be32 saddr, const struct tcphdr *th);
> -#endif
> -
> struct inet_hashinfo tcp_hashinfo;
> EXPORT_SYMBOL(tcp_hashinfo);
>
> @@ -603,13 +599,6 @@ static void tcp_v4_send_reset(const struct sock *sk,=
 struct sk_buff *skb)
> #endif
> 	} rep;
> 	struct ip_reply_arg arg;
> -#ifdef CONFIG_TCP_MD5SIG
> -	struct tcp_md5sig_key *key =3D NULL;
> -	const __u8 *hash_location =3D NULL;
> -	unsigned char newhash[16];
> -	int genhash;
> -	struct sock *sk1 =3D NULL;
> -#endif
> 	struct net *net;
>
> 	/* Never send a reset in response to a reset. */
> @@ -643,53 +632,8 @@ static void tcp_v4_send_reset(const struct sock *sk,=
 struct sk_buff *skb)
>
> 	net =3D sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
> #ifdef CONFIG_TCP_MD5SIG
> -	rcu_read_lock();
> -	hash_location =3D tcp_parse_md5sig_option(th);
> -	if (sk && sk_fullsock(sk)) {
> -		key =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)
> -					&ip_hdr(skb)->saddr, AF_INET);
> -	} else if (hash_location) {
> -		/*
> -		 * active side is lost. Try to find listening socket through
> -		 * source port, and then find md5 key through listening socket.
> -		 * we are not loose security here:
> -		 * Incoming packet is checked with md5 hash with finding key,
> -		 * no RST generated if md5 hash doesn't match.
> -		 */
> -		sk1 =3D __inet_lookup_listener(net, &tcp_hashinfo, NULL, 0,
> -					     ip_hdr(skb)->saddr,
> -					     th->source, ip_hdr(skb)->daddr,
> -					     ntohs(th->source), inet_iif(skb),
> -					     tcp_v4_sdif(skb));
> -		/* don't send rst if it can't find key */
> -		if (!sk1)
> -			goto out;
> -
> -		key =3D tcp_md5_do_lookup(sk1, (union tcp_md5_addr *)
> -					&ip_hdr(skb)->saddr, AF_INET);
> -		if (!key)
> -			goto out;
> -
> -
> -		genhash =3D tcp_v4_md5_hash_skb(newhash, key, NULL, skb);
> -		if (genhash || memcmp(hash_location, newhash, 16) !=3D 0)
> -			goto out;
> -
> -	}
> -
> -	if (key) {
> -		rep.opt[0] =3D htonl((TCPOPT_NOP << 24) |
> -				   (TCPOPT_NOP << 16) |
> -				   (TCPOPT_MD5SIG << 8) |
> -				   TCPOLEN_MD5SIG);
> -		/* Update length and the length the header thinks exists */
> -		arg.iov[0].iov_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> -		rep.th.doff =3D arg.iov[0].iov_len / 4;
> -
> -		tcp_v4_md5_hash_hdr((__u8 *) &rep.opt[1],
> -				     key, ip_hdr(skb)->saddr,
> -				     ip_hdr(skb)->daddr, &rep.th);
> -	}
> +	if (tcp_v4_md5_send_reset(skb, sk, &arg, &rep.th, rep.opt))
> +		return;
> #endif
> 	arg.csum =3D csum_tcpudp_nofold(ip_hdr(skb)->daddr,
> 				      ip_hdr(skb)->saddr, /* XXX */
> @@ -718,11 +662,6 @@ static void tcp_v4_send_reset(const struct sock *sk,=
 struct sk_buff *skb)
> 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
> 	__TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
> 	local_bh_enable();
> -
> -#ifdef CONFIG_TCP_MD5SIG
> -out:
> -	rcu_read_unlock();
> -#endif
> }
>
> /* The code following below sending ACKs in SYN-RECV and TIME-WAIT states
> @@ -743,9 +682,6 @@ static void tcp_v4_send_ack(const struct sock *sk,
> #endif
> 			];
> 	} rep;
> -#ifdef CONFIG_TCP_MD5SIG
> -	struct tcp_md5sig_key *key;
> -#endif
> 	struct net *net =3D sock_net(sk);
> 	struct ip_reply_arg arg;
>
> @@ -773,31 +709,8 @@ static void tcp_v4_send_ack(const struct sock *sk,
> 	rep.th.window  =3D htons(win);
>
> #ifdef CONFIG_TCP_MD5SIG
> -	if (sk->sk_state =3D=3D TCP_TIME_WAIT) {
> -		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
> -
> -		key =3D tcp_twsk_md5_key(tcptw);
> -	} else if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
> -		key =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&ip_hdr(skb)->dadd=
r,
> -					AF_INET);
> -	} else {
> -		BUG();
> -	}
> -
> -	if (key) {
> -		int offset =3D (tsecr) ? 3 : 0;
> -
> -		rep.opt[offset++] =3D htonl((TCPOPT_NOP << 24) |
> -					  (TCPOPT_NOP << 16) |
> -					  (TCPOPT_MD5SIG << 8) |
> -					  TCPOLEN_MD5SIG);
> -		arg.iov[0].iov_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> -		rep.th.doff =3D arg.iov[0].iov_len/4;
> -
> -		tcp_v4_md5_hash_hdr((__u8 *) &rep.opt[offset],
> -				    key, ip_hdr(skb)->saddr,
> -				    ip_hdr(skb)->daddr, &rep.th);
> -	}
> +	tcp_v4_md5_send_ack(skb, sk, &arg, &rep.th,
> +			    (tsecr) ? &rep.opt[3] : &rep.opt[0]);
> #endif
> 	arg.flags =3D reply_flags;
> 	arg.csum =3D csum_tcpudp_nofold(ip_hdr(skb)->daddr,
> @@ -902,374 +815,6 @@ static void tcp_v4_reqsk_destructor(struct request_=
sock *req)
> 	kfree(inet_rsk(req)->opt);
> }
>
> -#ifdef CONFIG_TCP_MD5SIG
> -/*
> - * RFC2385 MD5 checksumming requires a mapping of
> - * IP address->MD5 Key.
> - * We need to maintain these in the sk structure.
> - */
> -
> -/* Find the Key structure for an address.  */
> -struct tcp_md5sig_key *tcp_md5_do_lookup(const struct sock *sk,
> -					 const union tcp_md5_addr *addr,
> -					 int family)
> -{
> -	const struct tcp_sock *tp =3D tcp_sk(sk);
> -	struct tcp_md5sig_key *key;
> -	const struct tcp_md5sig_info *md5sig;
> -	__be32 mask;
> -	struct tcp_md5sig_key *best_match =3D NULL;
> -	bool match;
> -
> -	/* caller either holds rcu_read_lock() or socket lock */
> -	md5sig =3D rcu_dereference_check(tp->md5sig_info,
> -				       lockdep_sock_is_held(sk));
> -	if (!md5sig)
> -		return NULL;
> -
> -	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
> -		if (key->family !=3D family)
> -			continue;
> -
> -		if (family =3D=3D AF_INET) {
> -			mask =3D inet_make_mask(key->prefixlen);
> -			match =3D (key->addr.a4.s_addr & mask) =3D=3D
> -				(addr->a4.s_addr & mask);
> -#if IS_ENABLED(CONFIG_IPV6)
> -		} else if (family =3D=3D AF_INET6) {
> -			match =3D ipv6_prefix_equal(&key->addr.a6, &addr->a6,
> -						  key->prefixlen);
> -#endif
> -		} else {
> -			match =3D false;
> -		}
> -
> -		if (match && (!best_match ||
> -			      key->prefixlen > best_match->prefixlen))
> -			best_match =3D key;
> -	}
> -	return best_match;
> -}
> -EXPORT_SYMBOL(tcp_md5_do_lookup);
> -
> -static struct tcp_md5sig_key *tcp_md5_do_lookup_exact(const struct sock =
*sk,
> -						      const union tcp_md5_addr *addr,
> -						      int family, u8 prefixlen)
> -{
> -	const struct tcp_sock *tp =3D tcp_sk(sk);
> -	struct tcp_md5sig_key *key;
> -	unsigned int size =3D sizeof(struct in_addr);
> -	const struct tcp_md5sig_info *md5sig;
> -
> -	/* caller either holds rcu_read_lock() or socket lock */
> -	md5sig =3D rcu_dereference_check(tp->md5sig_info,
> -				       lockdep_sock_is_held(sk));
> -	if (!md5sig)
> -		return NULL;
> -#if IS_ENABLED(CONFIG_IPV6)
> -	if (family =3D=3D AF_INET6)
> -		size =3D sizeof(struct in6_addr);
> -#endif
> -	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
> -		if (key->family !=3D family)
> -			continue;
> -		if (!memcmp(&key->addr, addr, size) &&
> -		    key->prefixlen =3D=3D prefixlen)
> -			return key;
> -	}
> -	return NULL;
> -}
> -
> -struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
> -					 const struct sock *addr_sk)
> -{
> -	const union tcp_md5_addr *addr;
> -
> -	addr =3D (const union tcp_md5_addr *)&addr_sk->sk_daddr;
> -	return tcp_md5_do_lookup(sk, addr, AF_INET);
> -}
> -EXPORT_SYMBOL(tcp_v4_md5_lookup);
> -
> -/* This can be called on a newly created socket, from other files */
> -int tcp_md5_do_add(struct sock *sk, const union tcp_md5_addr *addr,
> -		   int family, u8 prefixlen, const u8 *newkey, u8 newkeylen,
> -		   gfp_t gfp)
> -{
> -	/* Add Key to the list */
> -	struct tcp_md5sig_key *key;
> -	struct tcp_sock *tp =3D tcp_sk(sk);
> -	struct tcp_md5sig_info *md5sig;
> -
> -	key =3D tcp_md5_do_lookup_exact(sk, addr, family, prefixlen);
> -	if (key) {
> -		/* Pre-existing entry - just update that one. */
> -		memcpy(key->key, newkey, newkeylen);
> -		key->keylen =3D newkeylen;
> -		return 0;
> -	}
> -
> -	md5sig =3D rcu_dereference_protected(tp->md5sig_info,
> -					   lockdep_sock_is_held(sk));
> -	if (!md5sig) {
> -		md5sig =3D kmalloc(sizeof(*md5sig), gfp);
> -		if (!md5sig)
> -			return -ENOMEM;
> -
> -		sk_nocaps_add(sk, NETIF_F_GSO_MASK);
> -		INIT_HLIST_HEAD(&md5sig->head);
> -		rcu_assign_pointer(tp->md5sig_info, md5sig);
> -	}
> -
> -	key =3D sock_kmalloc(sk, sizeof(*key), gfp);
> -	if (!key)
> -		return -ENOMEM;
> -	if (!tcp_alloc_md5sig_pool()) {
> -		sock_kfree_s(sk, key, sizeof(*key));
> -		return -ENOMEM;
> -	}
> -
> -	memcpy(key->key, newkey, newkeylen);
> -	key->keylen =3D newkeylen;
> -	key->family =3D family;
> -	key->prefixlen =3D prefixlen;
> -	memcpy(&key->addr, addr,
> -	       (family =3D=3D AF_INET6) ? sizeof(struct in6_addr) :
> -				      sizeof(struct in_addr));
> -	hlist_add_head_rcu(&key->node, &md5sig->head);
> -	return 0;
> -}
> -EXPORT_SYMBOL(tcp_md5_do_add);
> -
> -int tcp_md5_do_del(struct sock *sk, const union tcp_md5_addr *addr, int =
family,
> -		   u8 prefixlen)
> -{
> -	struct tcp_md5sig_key *key;
> -
> -	key =3D tcp_md5_do_lookup_exact(sk, addr, family, prefixlen);
> -	if (!key)
> -		return -ENOENT;
> -	hlist_del_rcu(&key->node);
> -	atomic_sub(sizeof(*key), &sk->sk_omem_alloc);
> -	kfree_rcu(key, rcu);
> -	return 0;
> -}
> -EXPORT_SYMBOL(tcp_md5_do_del);
> -
> -static void tcp_clear_md5_list(struct sock *sk)
> -{
> -	struct tcp_sock *tp =3D tcp_sk(sk);
> -	struct tcp_md5sig_key *key;
> -	struct hlist_node *n;
> -	struct tcp_md5sig_info *md5sig;
> -
> -	md5sig =3D rcu_dereference_protected(tp->md5sig_info, 1);
> -
> -	hlist_for_each_entry_safe(key, n, &md5sig->head, node) {
> -		hlist_del_rcu(&key->node);
> -		atomic_sub(sizeof(*key), &sk->sk_omem_alloc);
> -		kfree_rcu(key, rcu);
> -	}
> -}
> -
> -static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
> -				 char __user *optval, int optlen)
> -{
> -	struct tcp_md5sig cmd;
> -	struct sockaddr_in *sin =3D (struct sockaddr_in *)&cmd.tcpm_addr;
> -	u8 prefixlen =3D 32;
> -
> -	if (optlen < sizeof(cmd))
> -		return -EINVAL;
> -
> -	if (copy_from_user(&cmd, optval, sizeof(cmd)))
> -		return -EFAULT;
> -
> -	if (sin->sin_family !=3D AF_INET)
> -		return -EINVAL;
> -
> -	if (optname =3D=3D TCP_MD5SIG_EXT &&
> -	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_PREFIX) {
> -		prefixlen =3D cmd.tcpm_prefixlen;
> -		if (prefixlen > 32)
> -			return -EINVAL;
> -	}
> -
> -	if (!cmd.tcpm_keylen)
> -		return tcp_md5_do_del(sk, (union tcp_md5_addr *)&sin->sin_addr.s_addr,
> -				      AF_INET, prefixlen);
> -
> -	if (cmd.tcpm_keylen > TCP_MD5SIG_MAXKEYLEN)
> -		return -EINVAL;
> -
> -	return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin->sin_addr.s_addr,
> -			      AF_INET, prefixlen, cmd.tcpm_key, cmd.tcpm_keylen,
> -			      GFP_KERNEL);
> -}
> -
> -static int tcp_v4_md5_hash_headers(struct tcp_md5sig_pool *hp,
> -				   __be32 daddr, __be32 saddr,
> -				   const struct tcphdr *th, int nbytes)
> -{
> -	struct tcp4_pseudohdr *bp;
> -	struct scatterlist sg;
> -	struct tcphdr *_th;
> -
> -	bp =3D hp->scratch;
> -	bp->saddr =3D saddr;
> -	bp->daddr =3D daddr;
> -	bp->pad =3D 0;
> -	bp->protocol =3D IPPROTO_TCP;
> -	bp->len =3D cpu_to_be16(nbytes);
> -
> -	_th =3D (struct tcphdr *)(bp + 1);
> -	memcpy(_th, th, sizeof(*th));
> -	_th->check =3D 0;
> -
> -	sg_init_one(&sg, bp, sizeof(*bp) + sizeof(*th));
> -	ahash_request_set_crypt(hp->md5_req, &sg, NULL,
> -				sizeof(*bp) + sizeof(*th));
> -	return crypto_ahash_update(hp->md5_req);
> -}
> -
> -static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_k=
ey *key,
> -			       __be32 daddr, __be32 saddr, const struct tcphdr *th)
> -{
> -	struct tcp_md5sig_pool *hp;
> -	struct ahash_request *req;
> -
> -	hp =3D tcp_get_md5sig_pool();
> -	if (!hp)
> -		goto clear_hash_noput;
> -	req =3D hp->md5_req;
> -
> -	if (crypto_ahash_init(req))
> -		goto clear_hash;
> -	if (tcp_v4_md5_hash_headers(hp, daddr, saddr, th, th->doff << 2))
> -		goto clear_hash;
> -	if (tcp_md5_hash_key(hp, key))
> -		goto clear_hash;
> -	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> -	if (crypto_ahash_final(req))
> -		goto clear_hash;
> -
> -	tcp_put_md5sig_pool();
> -	return 0;
> -
> -clear_hash:
> -	tcp_put_md5sig_pool();
> -clear_hash_noput:
> -	memset(md5_hash, 0, 16);
> -	return 1;
> -}
> -
> -int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
> -			const struct sock *sk,
> -			const struct sk_buff *skb)
> -{
> -	struct tcp_md5sig_pool *hp;
> -	struct ahash_request *req;
> -	const struct tcphdr *th =3D tcp_hdr(skb);
> -	__be32 saddr, daddr;
> -
> -	if (sk) { /* valid for establish/request sockets */
> -		saddr =3D sk->sk_rcv_saddr;
> -		daddr =3D sk->sk_daddr;
> -	} else {
> -		const struct iphdr *iph =3D ip_hdr(skb);
> -		saddr =3D iph->saddr;
> -		daddr =3D iph->daddr;
> -	}
> -
> -	hp =3D tcp_get_md5sig_pool();
> -	if (!hp)
> -		goto clear_hash_noput;
> -	req =3D hp->md5_req;
> -
> -	if (crypto_ahash_init(req))
> -		goto clear_hash;
> -
> -	if (tcp_v4_md5_hash_headers(hp, daddr, saddr, th, skb->len))
> -		goto clear_hash;
> -	if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
> -		goto clear_hash;
> -	if (tcp_md5_hash_key(hp, key))
> -		goto clear_hash;
> -	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> -	if (crypto_ahash_final(req))
> -		goto clear_hash;
> -
> -	tcp_put_md5sig_pool();
> -	return 0;
> -
> -clear_hash:
> -	tcp_put_md5sig_pool();
> -clear_hash_noput:
> -	memset(md5_hash, 0, 16);
> -	return 1;
> -}
> -EXPORT_SYMBOL(tcp_v4_md5_hash_skb);
> -
> -#endif
> -
> -/* Called with rcu_read_lock() */
> -static bool tcp_v4_inbound_md5_hash(const struct sock *sk,
> -				    const struct sk_buff *skb)
> -{
> -#ifdef CONFIG_TCP_MD5SIG
> -	/*
> -	 * This gets called for each TCP segment that arrives
> -	 * so we want to be efficient.
> -	 * We have 3 drop cases:
> -	 * o No MD5 hash and one expected.
> -	 * o MD5 hash and we're not expecting one.
> -	 * o MD5 hash and its wrong.
> -	 */
> -	const __u8 *hash_location =3D NULL;
> -	struct tcp_md5sig_key *hash_expected;
> -	const struct iphdr *iph =3D ip_hdr(skb);
> -	const struct tcphdr *th =3D tcp_hdr(skb);
> -	int genhash;
> -	unsigned char newhash[16];
> -
> -	hash_expected =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&iph->sad=
dr,
> -					  AF_INET);
> -	hash_location =3D tcp_parse_md5sig_option(th);
> -
> -	/* We've parsed the options - do we have a hash? */
> -	if (!hash_expected && !hash_location)
> -		return false;
> -
> -	if (hash_expected && !hash_location) {
> -		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
> -		return true;
> -	}
> -
> -	if (!hash_expected && hash_location) {
> -		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
> -		return true;
> -	}
> -
> -	/* Okay, so this is hash_expected and hash_location -
> -	 * so we need to calculate the checksum.
> -	 */
> -	genhash =3D tcp_v4_md5_hash_skb(newhash,
> -				      hash_expected,
> -				      NULL, skb);
> -
> -	if (genhash || memcmp(hash_location, newhash, 16) !=3D 0) {
> -		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
> -		net_info_ratelimited("MD5 Hash failed for (%pI4, %d)->(%pI4, %d)%s\n",
> -				     &iph->saddr, ntohs(th->source),
> -				     &iph->daddr, ntohs(th->dest),
> -				     genhash ? " tcp_v4_calc_md5_hash failed"
> -				     : "");
> -		return true;
> -	}
> -	return false;
> -#endif
> -	return false;
> -}
> -
> static void tcp_v4_init_req(struct request_sock *req,
> 			    const struct sock *sk_listener,
> 			    struct sk_buff *skb)
> @@ -1344,9 +889,6 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock =
*sk, struct sk_buff *skb,
> 	struct inet_sock *newinet;
> 	struct tcp_sock *newtp;
> 	struct sock *newsk;
> -#ifdef CONFIG_TCP_MD5SIG
> -	struct tcp_md5sig_key *key;
> -#endif
> 	struct ip_options_rcu *inet_opt;
>
> 	if (sk_acceptq_is_full(sk))
> @@ -1394,20 +936,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock=
 *sk, struct sk_buff *skb,
> 	tcp_initialize_rcv_mss(newsk);
>
> #ifdef CONFIG_TCP_MD5SIG
> -	/* Copy over the MD5 key from the original socket */
> -	key =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&newinet->inet_dadd=
r,
> -				AF_INET);
> -	if (key) {
> -		/*
> -		 * We're using one, so create a matching key
> -		 * on the newsk structure. If we fail to get
> -		 * memory, then we end up not copying the key
> -		 * across. Shucks.
> -		 */
> -		tcp_md5_do_add(newsk, (union tcp_md5_addr *)&newinet->inet_daddr,
> -			       AF_INET, 32, key->key, key->keylen, GFP_ATOMIC);
> -		sk_nocaps_add(newsk, NETIF_F_GSO_MASK);
> -	}
> +	tcp_v4_md5_syn_recv_sock(sk, newsk);
> #endif
>
> 	if (__inet_inherit_port(sk, newsk) < 0)
> @@ -1839,14 +1368,6 @@ const struct inet_connection_sock_af_ops ipv4_spec=
ific =3D {
> };
> EXPORT_SYMBOL(ipv4_specific);
>
> -#ifdef CONFIG_TCP_MD5SIG
> -static const struct tcp_sock_af_ops tcp_sock_ipv4_specific =3D {
> -	.md5_lookup		=3D tcp_v4_md5_lookup,
> -	.calc_md5_hash		=3D tcp_v4_md5_hash_skb,
> -	.md5_parse		=3D tcp_v4_parse_md5_keys,
> -};
> -#endif
> -
> /* NOTE: A lot of things set to zero explicitly by call to
>  *       sk_alloc() so need not be done here.
>  */
> @@ -1885,12 +1406,7 @@ void tcp_v4_destroy_sock(struct sock *sk)
> 	skb_rbtree_purge(&tp->out_of_order_queue);
>
> #ifdef CONFIG_TCP_MD5SIG
> -	/* Clean up the MD5 key list, if any */
> -	if (tp->md5sig_info) {
> -		tcp_clear_md5_list(sk);
> -		kfree_rcu(tp->md5sig_info, rcu);
> -		tp->md5sig_info =3D NULL;
> -	}
> +	tcp_v4_md5_destroy_sock(sk);
> #endif
>
> 	/* Clean up a referenced TCP bind bucket. */
> diff --git a/net/ipv4/tcp_md5.c b/net/ipv4/tcp_md5.c
> new file mode 100644
> index 000000000000..89a9a5457412
> --- /dev/null
> +++ b/net/ipv4/tcp_md5.c
> @@ -0,0 +1,1080 @@
> +#include <linux/inet_diag.h>
> +#include <linux/inetdevice.h>
> +#include <linux/tcp.h>
> +#include <linux/tcp_md5.h>
> +
> +#include <crypto/hash.h>
> +
> +#include <net/inet6_hashtables.h>
> +
> +static DEFINE_PER_CPU(struct tcp_md5sig_pool, tcp_md5sig_pool);
> +static DEFINE_MUTEX(tcp_md5sig_mutex);
> +static bool tcp_md5sig_pool_populated;
> +
> +#define tcp_twsk_md5_key(twsk)	((twsk)->tw_md5_key)
> +
> +static void __tcp_alloc_md5sig_pool(void)
> +{
> +	struct crypto_ahash *hash;
> +	int cpu;
> +
> +	hash =3D crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
> +	if (IS_ERR(hash))
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		void *scratch =3D per_cpu(tcp_md5sig_pool, cpu).scratch;
> +		struct ahash_request *req;
> +
> +		if (!scratch) {
> +			scratch =3D kmalloc_node(sizeof(union tcp_md5sum_block) +
> +					       sizeof(struct tcphdr),
> +					       GFP_KERNEL,
> +					       cpu_to_node(cpu));
> +			if (!scratch)
> +				return;
> +			per_cpu(tcp_md5sig_pool, cpu).scratch =3D scratch;
> +		}
> +		if (per_cpu(tcp_md5sig_pool, cpu).md5_req)
> +			continue;
> +
> +		req =3D ahash_request_alloc(hash, GFP_KERNEL);
> +		if (!req)
> +			return;
> +
> +		ahash_request_set_callback(req, 0, NULL, NULL);
> +
> +		per_cpu(tcp_md5sig_pool, cpu).md5_req =3D req;
> +	}
> +	/* before setting tcp_md5sig_pool_populated, we must commit all writes
> +	 * to memory. See smp_rmb() in tcp_get_md5sig_pool()
> +	 */
> +	smp_wmb();
> +	tcp_md5sig_pool_populated =3D true;
> +}
> +
> +static bool tcp_alloc_md5sig_pool(void)
> +{
> +	if (unlikely(!tcp_md5sig_pool_populated)) {
> +		mutex_lock(&tcp_md5sig_mutex);
> +
> +		if (!tcp_md5sig_pool_populated)
> +			__tcp_alloc_md5sig_pool();
> +
> +		mutex_unlock(&tcp_md5sig_mutex);
> +	}
> +	return tcp_md5sig_pool_populated;
> +}
> +
> +static void tcp_put_md5sig_pool(void)
> +{
> +	local_bh_enable();
> +}
> +
> +/**
> + *	tcp_get_md5sig_pool - get md5sig_pool for this user
> + *
> + *	We use percpu structure, so if we succeed, we exit with preemption
> + *	and BH disabled, to make sure another thread or softirq handling
> + *	wont try to get same context.
> + */
> +static struct tcp_md5sig_pool *tcp_get_md5sig_pool(void)
> +{
> +	local_bh_disable();
> +
> +	if (tcp_md5sig_pool_populated) {
> +		/* coupled with smp_wmb() in __tcp_alloc_md5sig_pool() */
> +		smp_rmb();
> +		return this_cpu_ptr(&tcp_md5sig_pool);
> +	}
> +	local_bh_enable();
> +	return NULL;
> +}
> +
> +static struct tcp_md5sig_key *tcp_md5_do_lookup_exact(const struct sock =
*sk,
> +						      const union tcp_md5_addr *addr,
> +						      int family, u8 prefixlen)
> +{
> +	const struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct tcp_md5sig_key *key;
> +	unsigned int size =3D sizeof(struct in_addr);
> +	const struct tcp_md5sig_info *md5sig;
> +
> +	/* caller either holds rcu_read_lock() or socket lock */
> +	md5sig =3D rcu_dereference_check(tp->md5sig_info,
> +				       lockdep_sock_is_held(sk));
> +	if (!md5sig)
> +		return NULL;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (family =3D=3D AF_INET6)
> +		size =3D sizeof(struct in6_addr);
> +#endif
> +	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
> +		if (key->family !=3D family)
> +			continue;
> +		if (!memcmp(&key->addr, addr, size) &&
> +		    key->prefixlen =3D=3D prefixlen)
> +			return key;
> +	}
> +	return NULL;
> +}
> +
> +/* This can be called on a newly created socket, from other files */
> +static int tcp_md5_do_add(struct sock *sk, const union tcp_md5_addr *add=
r,
> +			  int family, u8 prefixlen, const u8 *newkey,
> +			  u8 newkeylen, gfp_t gfp)
> +{
> +	/* Add Key to the list */
> +	struct tcp_md5sig_key *key;
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct tcp_md5sig_info *md5sig;
> +
> +	key =3D tcp_md5_do_lookup_exact(sk, addr, family, prefixlen);
> +	if (key) {
> +		/* Pre-existing entry - just update that one. */
> +		memcpy(key->key, newkey, newkeylen);
> +		key->keylen =3D newkeylen;
> +		return 0;
> +	}
> +
> +	md5sig =3D rcu_dereference_protected(tp->md5sig_info,
> +					   lockdep_sock_is_held(sk));
> +	if (!md5sig) {
> +		md5sig =3D kmalloc(sizeof(*md5sig), gfp);
> +		if (!md5sig)
> +			return -ENOMEM;
> +
> +		sk_nocaps_add(sk, NETIF_F_GSO_MASK);
> +		INIT_HLIST_HEAD(&md5sig->head);
> +		rcu_assign_pointer(tp->md5sig_info, md5sig);
> +	}
> +
> +	key =3D sock_kmalloc(sk, sizeof(*key), gfp);
> +	if (!key)
> +		return -ENOMEM;
> +	if (!tcp_alloc_md5sig_pool()) {
> +		sock_kfree_s(sk, key, sizeof(*key));
> +		return -ENOMEM;
> +	}
> +
> +	memcpy(key->key, newkey, newkeylen);
> +	key->keylen =3D newkeylen;
> +	key->family =3D family;
> +	key->prefixlen =3D prefixlen;
> +	memcpy(&key->addr, addr,
> +	       (family =3D=3D AF_INET6) ? sizeof(struct in6_addr) :
> +				      sizeof(struct in_addr));
> +	hlist_add_head_rcu(&key->node, &md5sig->head);
> +	return 0;
> +}
> +
> +static void tcp_clear_md5_list(struct sock *sk)
> +{
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct tcp_md5sig_key *key;
> +	struct hlist_node *n;
> +	struct tcp_md5sig_info *md5sig;
> +
> +	md5sig =3D rcu_dereference_protected(tp->md5sig_info, 1);
> +
> +	hlist_for_each_entry_safe(key, n, &md5sig->head, node) {
> +		hlist_del_rcu(&key->node);
> +		atomic_sub(sizeof(*key), &sk->sk_omem_alloc);
> +		kfree_rcu(key, rcu);
> +	}
> +}
> +
> +static int tcp_md5_do_del(struct sock *sk, const union tcp_md5_addr *add=
r,
> +			  int family, u8 prefixlen)
> +{
> +	struct tcp_md5sig_key *key;
> +
> +	key =3D tcp_md5_do_lookup_exact(sk, addr, family, prefixlen);
> +	if (!key)
> +		return -ENOENT;
> +	hlist_del_rcu(&key->node);
> +	atomic_sub(sizeof(*key), &sk->sk_omem_alloc);
> +	kfree_rcu(key, rcu);
> +	return 0;
> +}
> +
> +static int tcp_md5_hash_key(struct tcp_md5sig_pool *hp,
> +			    const struct tcp_md5sig_key *key)
> +{
> +	struct scatterlist sg;
> +
> +	sg_init_one(&sg, key->key, key->keylen);
> +	ahash_request_set_crypt(hp->md5_req, &sg, NULL, key->keylen);
> +	return crypto_ahash_update(hp->md5_req);
> +}
> +
> +static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
> +				 char __user *optval, int optlen)
> +{
> +	struct tcp_md5sig cmd;
> +	struct sockaddr_in *sin =3D (struct sockaddr_in *)&cmd.tcpm_addr;
> +	u8 prefixlen =3D 32;
> +
> +	if (optlen < sizeof(cmd))
> +		return -EINVAL;
> +
> +	if (copy_from_user(&cmd, optval, sizeof(cmd)))
> +		return -EFAULT;
> +
> +	if (sin->sin_family !=3D AF_INET)
> +		return -EINVAL;
> +
> +	if (optname =3D=3D TCP_MD5SIG_EXT &&
> +	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_PREFIX) {
> +		prefixlen =3D cmd.tcpm_prefixlen;
> +		if (prefixlen > 32)
> +			return -EINVAL;
> +	}
> +
> +	if (!cmd.tcpm_keylen)
> +		return tcp_md5_do_del(sk, (union tcp_md5_addr *)&sin->sin_addr.s_addr,
> +				      AF_INET, prefixlen);
> +
> +	if (cmd.tcpm_keylen > TCP_MD5SIG_MAXKEYLEN)
> +		return -EINVAL;
> +
> +	return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin->sin_addr.s_addr,
> +			      AF_INET, prefixlen, cmd.tcpm_key, cmd.tcpm_keylen,
> +			      GFP_KERNEL);
> +}
> +
> +static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
> +				 char __user *optval, int optlen)
> +{
> +	struct tcp_md5sig cmd;
> +	struct sockaddr_in6 *sin6 =3D (struct sockaddr_in6 *)&cmd.tcpm_addr;
> +	u8 prefixlen;
> +
> +	if (optlen < sizeof(cmd))
> +		return -EINVAL;
> +
> +	if (copy_from_user(&cmd, optval, sizeof(cmd)))
> +		return -EFAULT;
> +
> +	if (sin6->sin6_family !=3D AF_INET6)
> +		return -EINVAL;
> +
> +	if (optname =3D=3D TCP_MD5SIG_EXT &&
> +	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_PREFIX) {
> +		prefixlen =3D cmd.tcpm_prefixlen;
> +		if (prefixlen > 128 || (ipv6_addr_v4mapped(&sin6->sin6_addr) &&
> +					prefixlen > 32))
> +			return -EINVAL;
> +	} else {
> +		prefixlen =3D ipv6_addr_v4mapped(&sin6->sin6_addr) ? 32 : 128;
> +	}
> +
> +	if (!cmd.tcpm_keylen) {
> +		if (ipv6_addr_v4mapped(&sin6->sin6_addr))
> +			return tcp_md5_do_del(sk, (union tcp_md5_addr *)&sin6->sin6_addr.s6_a=
ddr32[3],
> +					      AF_INET, prefixlen);
> +		return tcp_md5_do_del(sk, (union tcp_md5_addr *)&sin6->sin6_addr,
> +				      AF_INET6, prefixlen);
> +	}
> +
> +	if (cmd.tcpm_keylen > TCP_MD5SIG_MAXKEYLEN)
> +		return -EINVAL;
> +
> +	if (ipv6_addr_v4mapped(&sin6->sin6_addr))
> +		return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin6->sin6_addr.s6_ad=
dr32[3],
> +				      AF_INET, prefixlen, cmd.tcpm_key,
> +				      cmd.tcpm_keylen, GFP_KERNEL);
> +
> +	return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin6->sin6_addr,
> +			      AF_INET6, prefixlen, cmd.tcpm_key,
> +			      cmd.tcpm_keylen, GFP_KERNEL);
> +}
> +
> +static int tcp_v4_md5_hash_headers(struct tcp_md5sig_pool *hp,
> +				   __be32 daddr, __be32 saddr,
> +				   const struct tcphdr *th, int nbytes)
> +{
> +	struct tcp4_pseudohdr *bp;
> +	struct scatterlist sg;
> +	struct tcphdr *_th;
> +
> +	bp =3D hp->scratch;
> +	bp->saddr =3D saddr;
> +	bp->daddr =3D daddr;
> +	bp->pad =3D 0;
> +	bp->protocol =3D IPPROTO_TCP;
> +	bp->len =3D cpu_to_be16(nbytes);
> +
> +	_th =3D (struct tcphdr *)(bp + 1);
> +	memcpy(_th, th, sizeof(*th));
> +	_th->check =3D 0;
> +
> +	sg_init_one(&sg, bp, sizeof(*bp) + sizeof(*th));
> +	ahash_request_set_crypt(hp->md5_req, &sg, NULL,
> +				sizeof(*bp) + sizeof(*th));
> +	return crypto_ahash_update(hp->md5_req);
> +}
> +
> +static int tcp_v6_md5_hash_headers(struct tcp_md5sig_pool *hp,
> +				   const struct in6_addr *daddr,
> +				   const struct in6_addr *saddr,
> +				   const struct tcphdr *th, int nbytes)
> +{
> +	struct tcp6_pseudohdr *bp;
> +	struct scatterlist sg;
> +	struct tcphdr *_th;
> +
> +	bp =3D hp->scratch;
> +	/* 1. TCP pseudo-header (RFC2460) */
> +	bp->saddr =3D *saddr;
> +	bp->daddr =3D *daddr;
> +	bp->protocol =3D cpu_to_be32(IPPROTO_TCP);
> +	bp->len =3D cpu_to_be32(nbytes);
> +
> +	_th =3D (struct tcphdr *)(bp + 1);
> +	memcpy(_th, th, sizeof(*th));
> +	_th->check =3D 0;
> +
> +	sg_init_one(&sg, bp, sizeof(*bp) + sizeof(*th));
> +	ahash_request_set_crypt(hp->md5_req, &sg, NULL,
> +				sizeof(*bp) + sizeof(*th));
> +	return crypto_ahash_update(hp->md5_req);
> +}
> +
> +static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_k=
ey *key,
> +			       __be32 daddr, __be32 saddr,
> +			       const struct tcphdr *th)
> +{
> +	struct tcp_md5sig_pool *hp;
> +	struct ahash_request *req;
> +
> +	hp =3D tcp_get_md5sig_pool();
> +	if (!hp)
> +		goto clear_hash_noput;
> +	req =3D hp->md5_req;
> +
> +	if (crypto_ahash_init(req))
> +		goto clear_hash;
> +	if (tcp_v4_md5_hash_headers(hp, daddr, saddr, th, th->doff << 2))
> +		goto clear_hash;
> +	if (tcp_md5_hash_key(hp, key))
> +		goto clear_hash;
> +	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> +	if (crypto_ahash_final(req))
> +		goto clear_hash;
> +
> +	tcp_put_md5sig_pool();
> +	return 0;
> +
> +clear_hash:
> +	tcp_put_md5sig_pool();
> +clear_hash_noput:
> +	memset(md5_hash, 0, 16);
> +	return 1;
> +}
> +
> +static int tcp_v6_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_k=
ey *key,
> +			       const struct in6_addr *daddr,
> +			       struct in6_addr *saddr, const struct tcphdr *th)
> +{
> +	struct tcp_md5sig_pool *hp;
> +	struct ahash_request *req;
> +
> +	hp =3D tcp_get_md5sig_pool();
> +	if (!hp)
> +		goto clear_hash_noput;
> +	req =3D hp->md5_req;
> +
> +	if (crypto_ahash_init(req))
> +		goto clear_hash;
> +	if (tcp_v6_md5_hash_headers(hp, daddr, saddr, th, th->doff << 2))
> +		goto clear_hash;
> +	if (tcp_md5_hash_key(hp, key))
> +		goto clear_hash;
> +	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> +	if (crypto_ahash_final(req))
> +		goto clear_hash;
> +
> +	tcp_put_md5sig_pool();
> +	return 0;
> +
> +clear_hash:
> +	tcp_put_md5sig_pool();
> +clear_hash_noput:
> +	memset(md5_hash, 0, 16);
> +	return 1;
> +}
> +
> +/* RFC2385 MD5 checksumming requires a mapping of
> + * IP address->MD5 Key.
> + * We need to maintain these in the sk structure.
> + */
> +
> +/* Find the Key structure for an address.  */
> +static struct tcp_md5sig_key *tcp_md5_do_lookup(const struct sock *sk,
> +						const union tcp_md5_addr *addr,
> +						int family)
> +{
> +	const struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct tcp_md5sig_key *key;
> +	const struct tcp_md5sig_info *md5sig;
> +	__be32 mask;
> +	struct tcp_md5sig_key *best_match =3D NULL;
> +	bool match;
> +
> +	/* caller either holds rcu_read_lock() or socket lock */
> +	md5sig =3D rcu_dereference_check(tp->md5sig_info,
> +				       lockdep_sock_is_held(sk));
> +	if (!md5sig)
> +		return NULL;
> +
> +	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
> +		if (key->family !=3D family)
> +			continue;
> +
> +		if (family =3D=3D AF_INET) {
> +			mask =3D inet_make_mask(key->prefixlen);
> +			match =3D (key->addr.a4.s_addr & mask) =3D=3D
> +				(addr->a4.s_addr & mask);
> +#if IS_ENABLED(CONFIG_IPV6)
> +		} else if (family =3D=3D AF_INET6) {
> +			match =3D ipv6_prefix_equal(&key->addr.a6, &addr->a6,
> +						  key->prefixlen);
> +#endif
> +		} else {
> +			match =3D false;
> +		}
> +
> +		if (match && (!best_match ||
> +			      key->prefixlen > best_match->prefixlen))
> +			best_match =3D key;
> +	}
> +	return best_match;
> +}
> +
> +/* Parse MD5 Signature option */
> +static const u8 *tcp_parse_md5sig_option(const struct tcphdr *th)
> +{
> +	int length =3D (th->doff << 2) - sizeof(*th);
> +	const u8 *ptr =3D (const u8 *)(th + 1);
> +
> +	/* If the TCP option is too short, we can short cut */
> +	if (length < TCPOLEN_MD5SIG)
> +		return NULL;
> +
> +	while (length > 0) {
> +		int opcode =3D *ptr++;
> +		int opsize;
> +
> +		switch (opcode) {
> +		case TCPOPT_EOL:
> +			return NULL;
> +		case TCPOPT_NOP:
> +			length--;
> +			continue;
> +		default:
> +			opsize =3D *ptr++;
> +			if (opsize < 2 || opsize > length)
> +				return NULL;
> +			if (opcode =3D=3D TCPOPT_MD5SIG)
> +				return opsize =3D=3D TCPOLEN_MD5SIG ? ptr : NULL;
> +		}
> +		ptr +=3D opsize - 2;
> +		length -=3D opsize;
> +	}
> +	return NULL;
> +}
> +
> +static struct tcp_md5sig_key *tcp_v6_md5_do_lookup(const struct sock *sk,
> +						   const struct in6_addr *addr)
> +{
> +	return tcp_md5_do_lookup(sk, (union tcp_md5_addr *)addr, AF_INET6);
> +}
> +
> +static int tcp_md5_hash_skb_data(struct tcp_md5sig_pool *hp,
> +				 const struct sk_buff *skb,
> +				 unsigned int header_len)
> +{
> +	struct scatterlist sg;
> +	const struct tcphdr *tp =3D tcp_hdr(skb);
> +	struct ahash_request *req =3D hp->md5_req;
> +	unsigned int i;
> +	const unsigned int head_data_len =3D skb_headlen(skb) > header_len ?
> +					   skb_headlen(skb) - header_len : 0;
> +	const struct skb_shared_info *shi =3D skb_shinfo(skb);
> +	struct sk_buff *frag_iter;
> +
> +	sg_init_table(&sg, 1);
> +
> +	sg_set_buf(&sg, ((u8 *)tp) + header_len, head_data_len);
> +	ahash_request_set_crypt(req, &sg, NULL, head_data_len);
> +	if (crypto_ahash_update(req))
> +		return 1;
> +
> +	for (i =3D 0; i < shi->nr_frags; ++i) {
> +		const struct skb_frag_struct *f =3D &shi->frags[i];
> +		unsigned int offset =3D f->page_offset;
> +		struct page *page =3D skb_frag_page(f) + (offset >> PAGE_SHIFT);
> +
> +		sg_set_page(&sg, page, skb_frag_size(f),
> +			    offset_in_page(offset));
> +		ahash_request_set_crypt(req, &sg, NULL, skb_frag_size(f));
> +		if (crypto_ahash_update(req))
> +			return 1;
> +	}
> +
> +	skb_walk_frags(skb, frag_iter)
> +		if (tcp_md5_hash_skb_data(hp, frag_iter, 0))
> +			return 1;
> +
> +	return 0;
> +}
> +
> +int tcp_v4_md5_send_reset(struct sk_buff *skb, const struct sock *sk,
> +			  struct ip_reply_arg *arg, struct tcphdr *repth,
> +			  __be32 *opt)
> +{
> +	const struct tcphdr *th =3D tcp_hdr(skb);
> +	struct tcp_md5sig_key *key =3D NULL;
> +	const __u8 *hash_location =3D NULL;
> +	unsigned char newhash[16];
> +	struct sock *sk1 =3D NULL;
> +	struct net *net;
> +	int genhash;
> +
> +	net =3D sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
> +
> +	rcu_read_lock();
> +	hash_location =3D tcp_parse_md5sig_option(th);
> +	if (sk && sk_fullsock(sk)) {
> +		key =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)
> +					&ip_hdr(skb)->saddr, AF_INET);
> +	} else if (hash_location) {
> +		/* active side is lost. Try to find listening socket through
> +		 * source port, and then find md5 key through listening socket.
> +		 * we are not loose security here:
> +		 * Incoming packet is checked with md5 hash with finding key,
> +		 * no RST generated if md5 hash doesn't match.
> +		 */
> +		sk1 =3D __inet_lookup_listener(net, &tcp_hashinfo, NULL, 0,
> +					     ip_hdr(skb)->saddr,
> +					     th->source, ip_hdr(skb)->daddr,
> +					     ntohs(th->source), inet_iif(skb),
> +					     tcp_v4_sdif(skb));
> +		/* don't send rst if it can't find key */
> +		if (!sk1)
> +			goto out;
> +
> +		key =3D tcp_md5_do_lookup(sk1, (union tcp_md5_addr *)
> +					&ip_hdr(skb)->saddr, AF_INET);
> +		if (!key)
> +			goto out;
> +
> +		genhash =3D tcp_v4_md5_hash_skb(newhash, key, NULL, skb);
> +		if (genhash || memcmp(hash_location, newhash, 16) !=3D 0)
> +			goto out;
> +	}
> +
> +	if (key) {
> +		opt[0] =3D htonl((TCPOPT_NOP << 24) |
> +				   (TCPOPT_NOP << 16) |
> +				   (TCPOPT_MD5SIG << 8) |
> +				   TCPOLEN_MD5SIG);
> +		/* Update length and the length the header thinks exists */
> +		arg->iov[0].iov_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> +		repth->doff =3D arg->iov[0].iov_len / 4;
> +
> +		tcp_v4_md5_hash_hdr((__u8 *)&opt[1],
> +				    key, ip_hdr(skb)->saddr,
> +				    ip_hdr(skb)->daddr, repth);
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return 0;
> +out:
> +	rcu_read_unlock();
> +	return -1;
> +}
> +
> +void tcp_v4_md5_send_ack(struct sk_buff *skb, const struct sock *sk,
> +			 struct ip_reply_arg *arg, struct tcphdr *repth,
> +			 __be32 *opt)
> +{
> +	struct tcp_md5sig_key *key;
> +
> +	if (sk->sk_state =3D=3D TCP_TIME_WAIT) {
> +		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
> +
> +		key =3D tcp_twsk_md5_key(tcptw);
> +	} else if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
> +		key =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&ip_hdr(skb)->dadd=
r,
> +					AF_INET);
> +	} else {
> +		BUG();
> +	}
> +
> +	if (key) {
> +		opt[0] =3D htonl((TCPOPT_NOP << 24) |
> +			       (TCPOPT_NOP << 16) |
> +			       (TCPOPT_MD5SIG << 8) |
> +			       TCPOLEN_MD5SIG);
> +		arg->iov[0].iov_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> +		repth->doff =3D arg->iov[0].iov_len / 4;
> +
> +		tcp_v4_md5_hash_hdr((__u8 *)&opt[1],
> +				    key, ip_hdr(skb)->saddr,
> +				    ip_hdr(skb)->daddr, repth);
> +	}
> +}
> +
> +int tcp_v6_md5_send_response_write(struct sk_buff *skb, struct tcphdr *t=
1,
> +				   __be32 *topt, const struct sock *sk)
> +{
> +	const struct tcphdr *th =3D tcp_hdr(skb);
> +	struct ipv6hdr *ipv6h =3D ipv6_hdr(skb);
> +	struct tcp_md5sig_key *key =3D NULL;
> +	const __u8 *hash_location =3D NULL;
> +	int ret =3D 0;
> +
> +	rcu_read_lock();
> +	hash_location =3D tcp_parse_md5sig_option(th);
> +	if (sk && sk_fullsock(sk)) {
> +		key =3D tcp_v6_md5_do_lookup(sk, &ipv6h->saddr);
> +	} else if (sk && sk->sk_state =3D=3D TCP_TIME_WAIT) {
> +		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
> +
> +		key =3D tcp_twsk_md5_key(tcptw);
> +	} else if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
> +		key =3D tcp_v6_md5_do_lookup(sk, &ipv6h->daddr);
> +	} else if (hash_location) {
> +		unsigned char newhash[16];
> +		struct sock *sk1 =3D NULL;
> +		int genhash;
> +
> +		/* active side is lost. Try to find listening socket through
> +		 * source port, and then find md5 key through listening socket.
> +		 * we are not loose security here:
> +		 * Incoming packet is checked with md5 hash with finding key,
> +		 * no RST generated if md5 hash doesn't match.
> +		 */
> +		sk1 =3D inet6_lookup_listener(dev_net(skb_dst(skb)->dev),
> +					    &tcp_hashinfo, NULL, 0,
> +					    &ipv6h->saddr,
> +					    th->source, &ipv6h->daddr,
> +					    ntohs(th->source), tcp_v6_iif(skb),
> +					    tcp_v6_sdif(skb));

This code (and other v6 code) gets compiled even when IPv6 is not =

configured - inet6_lookup_listener (for example) is not defined when IPv6 =

is not configured.

IPv6 support can be in a module, which makes things trickier - especially =

if you consider that MD5 can possibly be moved to a module once it is =

fully transitioned to the extra options framework. Maybe there would need =

to be two MD5 modules, tcp_md5 and tcp_md5_ipv6 (the latter depending on =

both tcp_md5 and ipv6). I may be getting ahead of myself with modularizing =

TCP_MD5, it would be simpler to leave the config as-is, splitting off the =

ipv6 parts of TCP_MD5 and including them in the ipv6 module.


Mat


> +		if (!sk1)
> +			goto exit;
> +
> +		key =3D tcp_v6_md5_do_lookup(sk1, &ipv6h->saddr);
> +		if (!key)
> +			goto exit;
> +
> +		genhash =3D tcp_v6_md5_hash_skb(newhash, key, NULL, skb);
> +		if (genhash || memcmp(hash_location, newhash, 16) !=3D 0)
> +			goto exit;
> +	}
> +
> +	if (key) {
> +		*topt++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
> +				(TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
> +		tcp_v6_md5_hash_hdr((__u8 *)topt, key,
> +				    &ipv6_hdr(skb)->saddr,
> +				    &ipv6_hdr(skb)->daddr, t1);
> +
> +		ret =3D TCPOLEN_MD5SIG_ALIGNED;
> +	}
> +
> +exit:
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
> +					 const struct sock *addr_sk)
> +{
> +	const union tcp_md5_addr *addr;
> +
> +	addr =3D (const union tcp_md5_addr *)&addr_sk->sk_daddr;
> +	return tcp_md5_do_lookup(sk, addr, AF_INET);
> +}
> +EXPORT_SYMBOL(tcp_v4_md5_lookup);
> +
> +int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
> +			const struct sock *sk,
> +			const struct sk_buff *skb)
> +{
> +	struct tcp_md5sig_pool *hp;
> +	struct ahash_request *req;
> +	const struct tcphdr *th =3D tcp_hdr(skb);
> +	__be32 saddr, daddr;
> +
> +	if (sk) { /* valid for establish/request sockets */
> +		saddr =3D sk->sk_rcv_saddr;
> +		daddr =3D sk->sk_daddr;
> +	} else {
> +		const struct iphdr *iph =3D ip_hdr(skb);
> +
> +		saddr =3D iph->saddr;
> +		daddr =3D iph->daddr;
> +	}
> +
> +	hp =3D tcp_get_md5sig_pool();
> +	if (!hp)
> +		goto clear_hash_noput;
> +	req =3D hp->md5_req;
> +
> +	if (crypto_ahash_init(req))
> +		goto clear_hash;
> +
> +	if (tcp_v4_md5_hash_headers(hp, daddr, saddr, th, skb->len))
> +		goto clear_hash;
> +	if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
> +		goto clear_hash;
> +	if (tcp_md5_hash_key(hp, key))
> +		goto clear_hash;
> +	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> +	if (crypto_ahash_final(req))
> +		goto clear_hash;
> +
> +	tcp_put_md5sig_pool();
> +	return 0;
> +
> +clear_hash:
> +	tcp_put_md5sig_pool();
> +clear_hash_noput:
> +	memset(md5_hash, 0, 16);
> +	return 1;
> +}
> +EXPORT_SYMBOL(tcp_v4_md5_hash_skb);
> +
> +int tcp_v6_md5_hash_skb(char *md5_hash,
> +			const struct tcp_md5sig_key *key,
> +			const struct sock *sk,
> +			const struct sk_buff *skb)
> +{
> +	const struct in6_addr *saddr, *daddr;
> +	struct tcp_md5sig_pool *hp;
> +	struct ahash_request *req;
> +	const struct tcphdr *th =3D tcp_hdr(skb);
> +
> +	if (sk) { /* valid for establish/request sockets */
> +		saddr =3D &sk->sk_v6_rcv_saddr;
> +		daddr =3D &sk->sk_v6_daddr;
> +	} else {
> +		const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
> +
> +		saddr =3D &ip6h->saddr;
> +		daddr =3D &ip6h->daddr;
> +	}
> +
> +	hp =3D tcp_get_md5sig_pool();
> +	if (!hp)
> +		goto clear_hash_noput;
> +	req =3D hp->md5_req;
> +
> +	if (crypto_ahash_init(req))
> +		goto clear_hash;
> +
> +	if (tcp_v6_md5_hash_headers(hp, daddr, saddr, th, skb->len))
> +		goto clear_hash;
> +	if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
> +		goto clear_hash;
> +	if (tcp_md5_hash_key(hp, key))
> +		goto clear_hash;
> +	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> +	if (crypto_ahash_final(req))
> +		goto clear_hash;
> +
> +	tcp_put_md5sig_pool();
> +	return 0;
> +
> +clear_hash:
> +	tcp_put_md5sig_pool();
> +clear_hash_noput:
> +	memset(md5_hash, 0, 16);
> +	return 1;
> +}
> +
> +/* Called with rcu_read_lock() */
> +bool tcp_v4_inbound_md5_hash(const struct sock *sk,
> +			     const struct sk_buff *skb)
> +{
> +	/* This gets called for each TCP segment that arrives
> +	 * so we want to be efficient.
> +	 * We have 3 drop cases:
> +	 * o No MD5 hash and one expected.
> +	 * o MD5 hash and we're not expecting one.
> +	 * o MD5 hash and its wrong.
> +	 */
> +	const __u8 *hash_location =3D NULL;
> +	struct tcp_md5sig_key *hash_expected;
> +	const struct iphdr *iph =3D ip_hdr(skb);
> +	const struct tcphdr *th =3D tcp_hdr(skb);
> +	int genhash;
> +	unsigned char newhash[16];
> +
> +	hash_expected =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&iph->sad=
dr,
> +					  AF_INET);
> +	hash_location =3D tcp_parse_md5sig_option(th);
> +
> +	/* We've parsed the options - do we have a hash? */
> +	if (!hash_expected && !hash_location)
> +		return false;
> +
> +	if (hash_expected && !hash_location) {
> +		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
> +		return true;
> +	}
> +
> +	if (!hash_expected && hash_location) {
> +		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
> +		return true;
> +	}
> +
> +	/* Okay, so this is hash_expected and hash_location -
> +	 * so we need to calculate the checksum.
> +	 */
> +	genhash =3D tcp_v4_md5_hash_skb(newhash,
> +				      hash_expected,
> +				      NULL, skb);
> +
> +	if (genhash || memcmp(hash_location, newhash, 16) !=3D 0) {
> +		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
> +		net_info_ratelimited("MD5 Hash failed for (%pI4, %d)->(%pI4, %d)%s\n",
> +				     &iph->saddr, ntohs(th->source),
> +				     &iph->daddr, ntohs(th->dest),
> +				     genhash ? " tcp_v4_calc_md5_hash failed"
> +				     : "");
> +		return true;
> +	}
> +	return false;
> +}
> +
> +bool tcp_v6_inbound_md5_hash(const struct sock *sk,
> +			     const struct sk_buff *skb)
> +{
> +	const __u8 *hash_location =3D NULL;
> +	struct tcp_md5sig_key *hash_expected;
> +	const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
> +	const struct tcphdr *th =3D tcp_hdr(skb);
> +	int genhash;
> +	u8 newhash[16];
> +
> +	hash_expected =3D tcp_v6_md5_do_lookup(sk, &ip6h->saddr);
> +	hash_location =3D tcp_parse_md5sig_option(th);
> +
> +	/* We've parsed the options - do we have a hash? */
> +	if (!hash_expected && !hash_location)
> +		return false;
> +
> +	if (hash_expected && !hash_location) {
> +		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
> +		return true;
> +	}
> +
> +	if (!hash_expected && hash_location) {
> +		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
> +		return true;
> +	}
> +
> +	/* check the signature */
> +	genhash =3D tcp_v6_md5_hash_skb(newhash,
> +				      hash_expected,
> +				      NULL, skb);
> +
> +	if (genhash || memcmp(hash_location, newhash, 16) !=3D 0) {
> +		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
> +		net_info_ratelimited("MD5 Hash %s for [%pI6c]:%u->[%pI6c]:%u\n",
> +				     genhash ? "failed" : "mismatch",
> +				     &ip6h->saddr, ntohs(th->source),
> +				     &ip6h->daddr, ntohs(th->dest));
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +void tcp_v4_md5_destroy_sock(struct sock *sk)
> +{
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +
> +	/* Clean up the MD5 key list, if any */
> +	if (tp->md5sig_info) {
> +		tcp_clear_md5_list(sk);
> +		kfree_rcu(tp->md5sig_info, rcu);
> +		tp->md5sig_info =3D NULL;
> +	}
> +}
> +
> +void tcp_v4_md5_syn_recv_sock(const struct sock *listener, struct sock *=
sk)
> +{
> +	struct inet_sock *inet =3D inet_sk(sk);
> +	struct tcp_md5sig_key *key;
> +
> +	/* Copy over the MD5 key from the original socket */
> +	key =3D tcp_md5_do_lookup(listener, (union tcp_md5_addr *)&inet->inet_d=
addr,
> +				AF_INET);
> +	if (key) {
> +		/* We're using one, so create a matching key
> +		 * on the sk structure. If we fail to get
> +		 * memory, then we end up not copying the key
> +		 * across. Shucks.
> +		 */
> +		tcp_md5_do_add(sk, (union tcp_md5_addr *)&inet->inet_daddr,
> +			       AF_INET, 32, key->key, key->keylen, GFP_ATOMIC);
> +		sk_nocaps_add(sk, NETIF_F_GSO_MASK);
> +	}
> +}
> +
> +void tcp_v6_md5_syn_recv_sock(const struct sock *listener, struct sock *=
sk)
> +{
> +	struct tcp_md5sig_key *key;
> +
> +	/* Copy over the MD5 key from the original socket */
> +	key =3D tcp_v6_md5_do_lookup(listener, &sk->sk_v6_daddr);
> +	if (key) {
> +		/* We're using one, so create a matching key
> +		 * on the newsk structure. If we fail to get
> +		 * memory, then we end up not copying the key
> +		 * across. Shucks.
> +		 */
> +		tcp_md5_do_add(sk, (union tcp_md5_addr *)&sk->sk_v6_daddr,
> +			       AF_INET6, 128, key->key, key->keylen,
> +			       sk_gfp_mask(sk, GFP_ATOMIC));
> +	}
> +}
> +
> +struct tcp_md5sig_key *tcp_v6_md5_lookup(const struct sock *sk,
> +					 const struct sock *addr_sk)
> +{
> +	return tcp_v6_md5_do_lookup(sk, &addr_sk->sk_v6_daddr);
> +}
> +
> +void tcp_md5_time_wait(struct sock *sk, struct inet_timewait_sock *tw)
> +{
> +	struct tcp_timewait_sock *tcptw =3D tcp_twsk((struct sock *)tw);
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct tcp_md5sig_key *key;
> +
> +	/* The timewait bucket does not have the key DB from the
> +	 * sock structure. We just make a quick copy of the
> +	 * md5 key being used (if indeed we are using one)
> +	 * so the timewait ack generating code has the key.
> +	 */
> +	tcptw->tw_md5_key =3D NULL;
> +	key =3D tp->af_specific->md5_lookup(sk, sk);
> +	if (key) {
> +		tcptw->tw_md5_key =3D kmemdup(key, sizeof(*key), GFP_ATOMIC);
> +		if (tcptw->tw_md5_key && !tcp_alloc_md5sig_pool())
> +			BUG();
> +	}
> +}
> +
> +static void tcp_diag_md5sig_fill(struct tcp_diag_md5sig *info,
> +				 const struct tcp_md5sig_key *key)
> +{
> +	info->tcpm_family =3D key->family;
> +	info->tcpm_prefixlen =3D key->prefixlen;
> +	info->tcpm_keylen =3D key->keylen;
> +	memcpy(info->tcpm_key, key->key, key->keylen);
> +
> +	if (key->family =3D=3D AF_INET)
> +		info->tcpm_addr[0] =3D key->addr.a4.s_addr;
> +	#if IS_ENABLED(CONFIG_IPV6)
> +	else if (key->family =3D=3D AF_INET6)
> +		memcpy(&info->tcpm_addr, &key->addr.a6,
> +		       sizeof(info->tcpm_addr));
> +	#endif
> +}
> +
> +static int tcp_diag_put_md5sig(struct sk_buff *skb,
> +			       const struct tcp_md5sig_info *md5sig)
> +{
> +	const struct tcp_md5sig_key *key;
> +	struct tcp_diag_md5sig *info;
> +	struct nlattr *attr;
> +	int md5sig_count =3D 0;
> +
> +	hlist_for_each_entry_rcu(key, &md5sig->head, node)
> +		md5sig_count++;
> +	if (md5sig_count =3D=3D 0)
> +		return 0;
> +
> +	attr =3D nla_reserve(skb, INET_DIAG_MD5SIG,
> +			   md5sig_count * sizeof(struct tcp_diag_md5sig));
> +	if (!attr)
> +		return -EMSGSIZE;
> +
> +	info =3D nla_data(attr);
> +	memset(info, 0, md5sig_count * sizeof(struct tcp_diag_md5sig));
> +	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
> +		tcp_diag_md5sig_fill(info++, key);
> +		if (--md5sig_count =3D=3D 0)
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
> +int tcp_md5_diag_get_aux(struct sock *sk, bool net_admin, struct sk_buff=
 *skb)
> +{
> +	if (net_admin) {
> +		struct tcp_md5sig_info *md5sig;
> +		int err =3D 0;
> +
> +		rcu_read_lock();
> +		md5sig =3D rcu_dereference(tcp_sk(sk)->md5sig_info);
> +		if (md5sig)
> +			err =3D tcp_diag_put_md5sig(skb, md5sig);
> +		rcu_read_unlock();
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +int tcp_md5_diag_get_aux_size(struct sock *sk, bool net_admin)
> +{
> +	int size =3D 0;
> +
> +	if (net_admin && sk_fullsock(sk)) {
> +		const struct tcp_md5sig_info *md5sig;
> +		const struct tcp_md5sig_key *key;
> +		size_t md5sig_count =3D 0;
> +
> +		rcu_read_lock();
> +		md5sig =3D rcu_dereference(tcp_sk(sk)->md5sig_info);
> +		if (md5sig) {
> +			hlist_for_each_entry_rcu(key, &md5sig->head, node)
> +				md5sig_count++;
> +		}
> +		rcu_read_unlock();
> +		size +=3D nla_total_size(md5sig_count *
> +				       sizeof(struct tcp_diag_md5sig));
> +	}
> +
> +	return size;
> +}
> +
> +const struct tcp_sock_af_ops tcp_sock_ipv4_specific =3D {
> +	.md5_lookup	=3D tcp_v4_md5_lookup,
> +	.calc_md5_hash	=3D tcp_v4_md5_hash_skb,
> +	.md5_parse	=3D tcp_v4_parse_md5_keys,
> +};
> +
> +const struct tcp_sock_af_ops tcp_sock_ipv6_specific =3D {
> +	.md5_lookup	=3D	tcp_v6_md5_lookup,
> +	.calc_md5_hash	=3D	tcp_v6_md5_hash_skb,
> +	.md5_parse	=3D	tcp_v6_parse_md5_keys,
> +};
> +
> +const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific =3D {
> +	.md5_lookup	=3D	tcp_v4_md5_lookup,
> +	.calc_md5_hash	=3D	tcp_v4_md5_hash_skb,
> +	.md5_parse	=3D	tcp_v6_parse_md5_keys,
> +};
> +
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 2b1683611898..587310fb588d 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -22,6 +22,7 @@
> #include <linux/module.h>
> #include <linux/slab.h>
> #include <linux/sysctl.h>
> +#include <linux/tcp_md5.h>
> #include <linux/workqueue.h>
> #include <net/tcp.h>
> #include <net/inet_common.h>
> @@ -286,22 +287,7 @@ void tcp_time_wait(struct sock *sk, int state, int t=
imeo)
> #endif
>
> #ifdef CONFIG_TCP_MD5SIG
> -		/*
> -		 * The timewait bucket does not have the key DB from the
> -		 * sock structure. We just make a quick copy of the
> -		 * md5 key being used (if indeed we are using one)
> -		 * so the timewait ack generating code has the key.
> -		 */
> -		do {
> -			struct tcp_md5sig_key *key;
> -			tcptw->tw_md5_key =3D NULL;
> -			key =3D tp->af_specific->md5_lookup(sk, sk);
> -			if (key) {
> -				tcptw->tw_md5_key =3D kmemdup(key, sizeof(*key), GFP_ATOMIC);
> -				if (tcptw->tw_md5_key && !tcp_alloc_md5sig_pool())
> -					BUG();
> -			}
> -		} while (0);
> +		tcp_md5_time_wait(sk, tw);
> #endif
>
> 		/* Get the TIME_WAIT timeout firing. */
> @@ -331,10 +317,7 @@ void tcp_time_wait(struct sock *sk, int state, int t=
imeo)
> void tcp_twsk_destructor(struct sock *sk)
> {
> #ifdef CONFIG_TCP_MD5SIG
> -	struct tcp_timewait_sock *twsk =3D tcp_twsk(sk);
> -
> -	if (twsk->tw_md5_key)
> -		kfree_rcu(twsk->tw_md5_key, rcu);
> +	tcp_md5_twsk_destructor(sk);
> #endif
> }
> EXPORT_SYMBOL_GPL(tcp_twsk_destructor);
> @@ -521,9 +504,7 @@ struct sock *tcp_create_openreq_child(const struct so=
ck *sk,
> 		}
> 		newtp->tsoffset =3D treq->ts_off;
> #ifdef CONFIG_TCP_MD5SIG
> -		newtp->md5sig_info =3D NULL;	/*XXX*/
> -		if (newtp->af_specific->md5_lookup(sk, newsk))
> -			newtp->tcp_header_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> +		tcp_md5_add_header_len(sk, newsk);
> #endif
> 		if (static_branch_unlikely(&tcp_extra_options_enabled))
> 			newtp->tcp_header_len +=3D tcp_extra_options_add_header(sk, newsk);
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 67a3779294ad..be32edd76e30 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -42,6 +42,7 @@
> #include <linux/gfp.h>
> #include <linux/module.h>
> #include <linux/static_key.h>
> +#include <linux/tcp_md5.h>
>
> /* People can turn this off for buggy TCP's found in printers etc. */
> int sysctl_tcp_retrans_collapse __read_mostly =3D 1;
> @@ -3249,8 +3250,7 @@ static void tcp_connect_init(struct sock *sk)
> 		tp->tcp_header_len +=3D TCPOLEN_TSTAMP_ALIGNED;
>
> #ifdef CONFIG_TCP_MD5SIG
> -	if (tp->af_specific->md5_lookup(sk, sk))
> -		tp->tcp_header_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> +	tcp_md5_add_header_len(sk, sk);
> #endif
>
> 	if (static_branch_unlikely(&tcp_extra_options_enabled))
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index f1afa3236c4a..3467498f2ae0 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -43,6 +43,7 @@
> #include <linux/ipv6.h>
> #include <linux/icmpv6.h>
> #include <linux/random.h>
> +#include <linux/tcp_md5.h>
>
> #include <net/tcp.h>
> #include <net/ndisc.h>
> @@ -77,16 +78,6 @@ static int	tcp_v6_do_rcv(struct sock *sk, struct sk_bu=
ff *skb);
>
> static const struct inet_connection_sock_af_ops ipv6_mapped;
> static const struct inet_connection_sock_af_ops ipv6_specific;
> -#ifdef CONFIG_TCP_MD5SIG
> -static const struct tcp_sock_af_ops tcp_sock_ipv6_specific;
> -static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
> -#else
> -static struct tcp_md5sig_key *tcp_v6_md5_do_lookup(const struct sock *sk,
> -						   const struct in6_addr *addr)
> -{
> -	return NULL;
> -}
> -#endif
>
> static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *sk=
b)
> {
> @@ -502,218 +493,6 @@ static void tcp_v6_reqsk_destructor(struct request_=
sock *req)
> 	kfree_skb(inet_rsk(req)->pktopts);
> }
>
> -#ifdef CONFIG_TCP_MD5SIG
> -static struct tcp_md5sig_key *tcp_v6_md5_do_lookup(const struct sock *sk,
> -						   const struct in6_addr *addr)
> -{
> -	return tcp_md5_do_lookup(sk, (union tcp_md5_addr *)addr, AF_INET6);
> -}
> -
> -static struct tcp_md5sig_key *tcp_v6_md5_lookup(const struct sock *sk,
> -						const struct sock *addr_sk)
> -{
> -	return tcp_v6_md5_do_lookup(sk, &addr_sk->sk_v6_daddr);
> -}
> -
> -static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
> -				 char __user *optval, int optlen)
> -{
> -	struct tcp_md5sig cmd;
> -	struct sockaddr_in6 *sin6 =3D (struct sockaddr_in6 *)&cmd.tcpm_addr;
> -	u8 prefixlen;
> -
> -	if (optlen < sizeof(cmd))
> -		return -EINVAL;
> -
> -	if (copy_from_user(&cmd, optval, sizeof(cmd)))
> -		return -EFAULT;
> -
> -	if (sin6->sin6_family !=3D AF_INET6)
> -		return -EINVAL;
> -
> -	if (optname =3D=3D TCP_MD5SIG_EXT &&
> -	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_PREFIX) {
> -		prefixlen =3D cmd.tcpm_prefixlen;
> -		if (prefixlen > 128 || (ipv6_addr_v4mapped(&sin6->sin6_addr) &&
> -					prefixlen > 32))
> -			return -EINVAL;
> -	} else {
> -		prefixlen =3D ipv6_addr_v4mapped(&sin6->sin6_addr) ? 32 : 128;
> -	}
> -
> -	if (!cmd.tcpm_keylen) {
> -		if (ipv6_addr_v4mapped(&sin6->sin6_addr))
> -			return tcp_md5_do_del(sk, (union tcp_md5_addr *)&sin6->sin6_addr.s6_a=
ddr32[3],
> -					      AF_INET, prefixlen);
> -		return tcp_md5_do_del(sk, (union tcp_md5_addr *)&sin6->sin6_addr,
> -				      AF_INET6, prefixlen);
> -	}
> -
> -	if (cmd.tcpm_keylen > TCP_MD5SIG_MAXKEYLEN)
> -		return -EINVAL;
> -
> -	if (ipv6_addr_v4mapped(&sin6->sin6_addr))
> -		return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin6->sin6_addr.s6_ad=
dr32[3],
> -				      AF_INET, prefixlen, cmd.tcpm_key,
> -				      cmd.tcpm_keylen, GFP_KERNEL);
> -
> -	return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin6->sin6_addr,
> -			      AF_INET6, prefixlen, cmd.tcpm_key,
> -			      cmd.tcpm_keylen, GFP_KERNEL);
> -}
> -
> -static int tcp_v6_md5_hash_headers(struct tcp_md5sig_pool *hp,
> -				   const struct in6_addr *daddr,
> -				   const struct in6_addr *saddr,
> -				   const struct tcphdr *th, int nbytes)
> -{
> -	struct tcp6_pseudohdr *bp;
> -	struct scatterlist sg;
> -	struct tcphdr *_th;
> -
> -	bp =3D hp->scratch;
> -	/* 1. TCP pseudo-header (RFC2460) */
> -	bp->saddr =3D *saddr;
> -	bp->daddr =3D *daddr;
> -	bp->protocol =3D cpu_to_be32(IPPROTO_TCP);
> -	bp->len =3D cpu_to_be32(nbytes);
> -
> -	_th =3D (struct tcphdr *)(bp + 1);
> -	memcpy(_th, th, sizeof(*th));
> -	_th->check =3D 0;
> -
> -	sg_init_one(&sg, bp, sizeof(*bp) + sizeof(*th));
> -	ahash_request_set_crypt(hp->md5_req, &sg, NULL,
> -				sizeof(*bp) + sizeof(*th));
> -	return crypto_ahash_update(hp->md5_req);
> -}
> -
> -static int tcp_v6_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_k=
ey *key,
> -			       const struct in6_addr *daddr, struct in6_addr *saddr,
> -			       const struct tcphdr *th)
> -{
> -	struct tcp_md5sig_pool *hp;
> -	struct ahash_request *req;
> -
> -	hp =3D tcp_get_md5sig_pool();
> -	if (!hp)
> -		goto clear_hash_noput;
> -	req =3D hp->md5_req;
> -
> -	if (crypto_ahash_init(req))
> -		goto clear_hash;
> -	if (tcp_v6_md5_hash_headers(hp, daddr, saddr, th, th->doff << 2))
> -		goto clear_hash;
> -	if (tcp_md5_hash_key(hp, key))
> -		goto clear_hash;
> -	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> -	if (crypto_ahash_final(req))
> -		goto clear_hash;
> -
> -	tcp_put_md5sig_pool();
> -	return 0;
> -
> -clear_hash:
> -	tcp_put_md5sig_pool();
> -clear_hash_noput:
> -	memset(md5_hash, 0, 16);
> -	return 1;
> -}
> -
> -static int tcp_v6_md5_hash_skb(char *md5_hash,
> -			       const struct tcp_md5sig_key *key,
> -			       const struct sock *sk,
> -			       const struct sk_buff *skb)
> -{
> -	const struct in6_addr *saddr, *daddr;
> -	struct tcp_md5sig_pool *hp;
> -	struct ahash_request *req;
> -	const struct tcphdr *th =3D tcp_hdr(skb);
> -
> -	if (sk) { /* valid for establish/request sockets */
> -		saddr =3D &sk->sk_v6_rcv_saddr;
> -		daddr =3D &sk->sk_v6_daddr;
> -	} else {
> -		const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
> -		saddr =3D &ip6h->saddr;
> -		daddr =3D &ip6h->daddr;
> -	}
> -
> -	hp =3D tcp_get_md5sig_pool();
> -	if (!hp)
> -		goto clear_hash_noput;
> -	req =3D hp->md5_req;
> -
> -	if (crypto_ahash_init(req))
> -		goto clear_hash;
> -
> -	if (tcp_v6_md5_hash_headers(hp, daddr, saddr, th, skb->len))
> -		goto clear_hash;
> -	if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
> -		goto clear_hash;
> -	if (tcp_md5_hash_key(hp, key))
> -		goto clear_hash;
> -	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> -	if (crypto_ahash_final(req))
> -		goto clear_hash;
> -
> -	tcp_put_md5sig_pool();
> -	return 0;
> -
> -clear_hash:
> -	tcp_put_md5sig_pool();
> -clear_hash_noput:
> -	memset(md5_hash, 0, 16);
> -	return 1;
> -}
> -
> -#endif
> -
> -static bool tcp_v6_inbound_md5_hash(const struct sock *sk,
> -				    const struct sk_buff *skb)
> -{
> -#ifdef CONFIG_TCP_MD5SIG
> -	const __u8 *hash_location =3D NULL;
> -	struct tcp_md5sig_key *hash_expected;
> -	const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
> -	const struct tcphdr *th =3D tcp_hdr(skb);
> -	int genhash;
> -	u8 newhash[16];
> -
> -	hash_expected =3D tcp_v6_md5_do_lookup(sk, &ip6h->saddr);
> -	hash_location =3D tcp_parse_md5sig_option(th);
> -
> -	/* We've parsed the options - do we have a hash? */
> -	if (!hash_expected && !hash_location)
> -		return false;
> -
> -	if (hash_expected && !hash_location) {
> -		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
> -		return true;
> -	}
> -
> -	if (!hash_expected && hash_location) {
> -		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
> -		return true;
> -	}
> -
> -	/* check the signature */
> -	genhash =3D tcp_v6_md5_hash_skb(newhash,
> -				      hash_expected,
> -				      NULL, skb);
> -
> -	if (genhash || memcmp(hash_location, newhash, 16) !=3D 0) {
> -		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
> -		net_info_ratelimited("MD5 Hash %s for [%pI6c]:%u->[%pI6c]:%u\n",
> -				     genhash ? "failed" : "mismatch",
> -				     &ip6h->saddr, ntohs(th->source),
> -				     &ip6h->daddr, ntohs(th->dest));
> -		return true;
> -	}
> -#endif
> -	return false;
> -}
> -
> static void tcp_v6_init_req(struct request_sock *req,
> 			    const struct sock *sk_listener,
> 			    struct sk_buff *skb)
> @@ -788,12 +567,6 @@ static void tcp_v6_send_response(const struct sock *=
sk, struct sk_buff *skb, u32
> 	struct dst_entry *dst;
> 	__be32 *topt;
>
> -#ifdef CONFIG_TCP_MD5SIG
> -	struct tcp_md5sig_key *key =3D NULL;
> -	const __u8 *hash_location =3D NULL;
> -	struct ipv6hdr *ipv6h =3D ipv6_hdr(skb);
> -#endif
> -
> 	buff =3D alloc_skb(MAX_HEADER + sizeof(struct ipv6hdr) + tot_len,
> 			 GFP_ATOMIC);
> 	if (!buff)
> @@ -827,57 +600,7 @@ static void tcp_v6_send_response(const struct sock *=
sk, struct sk_buff *skb, u32
> 	}
>
> #ifdef CONFIG_TCP_MD5SIG
> -	rcu_read_lock();
> -	hash_location =3D tcp_parse_md5sig_option(th);
> -	if (sk && sk_fullsock(sk)) {
> -		key =3D tcp_v6_md5_do_lookup(sk, &ipv6h->saddr);
> -	} else if (sk && sk->sk_state =3D=3D TCP_TIME_WAIT) {
> -		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
> -
> -		key =3D tcp_twsk_md5_key(tcptw);
> -	} else if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
> -		key =3D tcp_v6_md5_do_lookup(sk, &ipv6h->daddr);
> -	} else if (hash_location) {
> -		unsigned char newhash[16];
> -		struct sock *sk1 =3D NULL;
> -		int genhash;
> -
> -		/* active side is lost. Try to find listening socket through
> -		 * source port, and then find md5 key through listening socket.
> -		 * we are not loose security here:
> -		 * Incoming packet is checked with md5 hash with finding key,
> -		 * no RST generated if md5 hash doesn't match.
> -		 */
> -		sk1 =3D inet6_lookup_listener(dev_net(skb_dst(skb)->dev),
> -					    &tcp_hashinfo, NULL, 0,
> -					    &ipv6h->saddr,
> -					    th->source, &ipv6h->daddr,
> -					    ntohs(th->source), tcp_v6_iif(skb),
> -					    tcp_v6_sdif(skb));
> -		if (!sk1)
> -			goto go_on;
> -
> -		key =3D tcp_v6_md5_do_lookup(sk1, &ipv6h->saddr);
> -		if (!key)
> -			goto go_on;
> -
> -		genhash =3D tcp_v6_md5_hash_skb(newhash, key, NULL, skb);
> -		if (genhash || memcmp(hash_location, newhash, 16) !=3D 0)
> -			goto go_on;
> -	}
> -
> -go_on:
> -	rcu_read_unlock();
> -
> -	if (key) {
> -		*topt++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
> -				(TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
> -		tcp_v6_md5_hash_hdr((__u8 *)topt, key,
> -				    &ipv6_hdr(skb)->saddr,
> -				    &ipv6_hdr(skb)->daddr, t1);
> -
> -		reduce +=3D TCPOLEN_MD5SIG_ALIGNED;
> -	}
> +	reduce +=3D tcp_v6_md5_send_response_write(skb, t1, topt, sk);
> #endif
>
> 	buff->tail -=3D reduce;
> @@ -1044,9 +767,6 @@ static struct sock *tcp_v6_syn_recv_sock(const struc=
t sock *sk, struct sk_buff *
> 	struct inet_sock *newinet;
> 	struct tcp_sock *newtp;
> 	struct sock *newsk;
> -#ifdef CONFIG_TCP_MD5SIG
> -	struct tcp_md5sig_key *key;
> -#endif
> 	struct flowi6 fl6;
>
> 	if (skb->protocol =3D=3D htons(ETH_P_IP)) {
> @@ -1191,18 +911,7 @@ static struct sock *tcp_v6_syn_recv_sock(const stru=
ct sock *sk, struct sk_buff *
> 	newinet->inet_rcv_saddr =3D LOOPBACK4_IPV6;
>
> #ifdef CONFIG_TCP_MD5SIG
> -	/* Copy over the MD5 key from the original socket */
> -	key =3D tcp_v6_md5_do_lookup(sk, &newsk->sk_v6_daddr);
> -	if (key) {
> -		/* We're using one, so create a matching key
> -		 * on the newsk structure. If we fail to get
> -		 * memory, then we end up not copying the key
> -		 * across. Shucks.
> -		 */
> -		tcp_md5_do_add(newsk, (union tcp_md5_addr *)&newsk->sk_v6_daddr,
> -			       AF_INET6, 128, key->key, key->keylen,
> -			       sk_gfp_mask(sk, GFP_ATOMIC));
> -	}
> +	tcp_v6_md5_syn_recv_sock(sk, newsk);
> #endif
>
> 	if (__inet_inherit_port(sk, newsk) < 0) {
> @@ -1657,14 +1366,6 @@ static const struct inet_connection_sock_af_ops ip=
v6_specific =3D {
> 	.mtu_reduced	   =3D tcp_v6_mtu_reduced,
> };
>
> -#ifdef CONFIG_TCP_MD5SIG
> -static const struct tcp_sock_af_ops tcp_sock_ipv6_specific =3D {
> -	.md5_lookup	=3D	tcp_v6_md5_lookup,
> -	.calc_md5_hash	=3D	tcp_v6_md5_hash_skb,
> -	.md5_parse	=3D	tcp_v6_parse_md5_keys,
> -};
> -#endif
> -
> /*
>  *	TCP over IPv4 via INET6 API
>  */
> @@ -1687,14 +1388,6 @@ static const struct inet_connection_sock_af_ops ip=
v6_mapped =3D {
> 	.mtu_reduced	   =3D tcp_v4_mtu_reduced,
> };
>
> -#ifdef CONFIG_TCP_MD5SIG
> -static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific =3D {
> -	.md5_lookup	=3D	tcp_v4_md5_lookup,
> -	.calc_md5_hash	=3D	tcp_v4_md5_hash_skb,
> -	.md5_parse	=3D	tcp_v6_parse_md5_keys,
> -};
> -#endif
> -
> /* NOTE: A lot of things set to zero explicitly by call to
>  *       sk_alloc() so need not be done here.
>  */
> -- =

> 2.14.1
>
>

--
Mat Martineau
Intel OTC

--===============1349299237623254090==--
