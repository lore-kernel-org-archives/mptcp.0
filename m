Content-Type: multipart/mixed; boundary="===============4683686875740799478=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 22/25] tcp_md5: Move TCP-MD5 code out of TCP
 itself
Date: Wed, 29 Nov 2017 16:47:25 -0800
Message-ID: <20171130004725.GF94116@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1711291547430.28648@skpadalx-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 229

--===============4683686875740799478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 29/11/17 - 15:49:45, Mat Martineau wrote:
> On Mon, 27 Nov 2017, Christoph Paasch wrote:
> =

> > This is all just copy-pasting the TCP_MD5-code into functions that are
> > placed in net/ipv4/tcp_md5.c.
> > =

> > Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> > ---
> > include/linux/inet_diag.h |    1 +
> > include/linux/tcp_md5.h   |  138 ++++++
> > include/net/tcp.h         |   77 ----
> > net/ipv4/Makefile         |    1 +
> > net/ipv4/tcp.c            |  133 +-----
> > net/ipv4/tcp_diag.c       |   81 +---
> > net/ipv4/tcp_input.c      |   38 --
> > net/ipv4/tcp_ipv4.c       |  521 ++-------------------
> > net/ipv4/tcp_md5.c        | 1104 ++++++++++++++++++++++++++++++++++++++=
+++++++
> > net/ipv4/tcp_minisocks.c  |   26 +-
> > net/ipv4/tcp_output.c     |    4 +-
> > net/ipv6/tcp_ipv6.c       |  325 +------------
> > 12 files changed, 1305 insertions(+), 1144 deletions(-)
> > create mode 100644 include/linux/tcp_md5.h
> > create mode 100644 net/ipv4/tcp_md5.c
> > =

> > diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
> > index 39faaaf843e1..1ef6727e41c9 100644
> > --- a/include/linux/inet_diag.h
> > +++ b/include/linux/inet_diag.h
> > @@ -2,6 +2,7 @@
> > #ifndef _INET_DIAG_H_
> > #define _INET_DIAG_H_ 1
> > =

> > +#include <linux/user_namespace.h>
> > #include <uapi/linux/inet_diag.h>
> > =

> > struct net;
> > diff --git a/include/linux/tcp_md5.h b/include/linux/tcp_md5.h
> > new file mode 100644
> > index 000000000000..27f970f0f464
> > --- /dev/null
> > +++ b/include/linux/tcp_md5.h
> > @@ -0,0 +1,138 @@
> > +#ifndef _LINUX_TCP_MD5_H
> > +#define _LINUX_TCP_MD5_H
> > +
> > +#ifdef CONFIG_TCP_MD5SIG
> > +
> > +#include <linux/types.h>
> > +
> > +#include <net/tcp.h>
> > +
> > +union tcp_md5_addr {
> > +	struct in_addr  a4;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +	struct in6_addr	a6;
> > +#endif
> > +};
> > +
> > +/* - key database */
> > +struct tcp_md5sig_key {
> > +	struct hlist_node	node;
> > +	u8			keylen;
> > +	u8			family; /* AF_INET or AF_INET6 */
> > +	union tcp_md5_addr	addr;
> > +	u8			prefixlen;
> > +	u8			key[TCP_MD5SIG_MAXKEYLEN];
> > +	struct rcu_head		rcu;
> > +};
> > +
> > +/* - sock block */
> > +struct tcp_md5sig_info {
> > +	struct hlist_head	head;
> > +	struct rcu_head		rcu;
> > +};
> > +
> > +union tcp_md5sum_block {
> > +	struct tcp4_pseudohdr ip4;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +	struct tcp6_pseudohdr ip6;
> > +#endif
> > +};
> > +
> > +/* - pool: digest algorithm, hash description and scratch buffer */
> > +struct tcp_md5sig_pool {
> > +	struct ahash_request	*md5_req;
> > +	void			*scratch;
> > +};
> > +
> > +extern const struct tcp_sock_af_ops tcp_sock_ipv4_specific;
> > +extern const struct tcp_sock_af_ops tcp_sock_ipv6_specific;
> > +extern const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
> > +
> > +/* - functions */
> > +int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *k=
ey,
> > +			const struct sock *sk, const struct sk_buff *skb);
> > +
> > +struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
> > +					 const struct sock *addr_sk);
> > +
> > +void tcp_v4_md5_destroy_sock(struct sock *sk);
> > +
> > +int tcp_v4_md5_send_response_prepare(struct sk_buff *skb, u8 flags,
> > +				     unsigned int remaining,
> > +				     struct tcp_out_options *opts,
> > +				     const struct sock *sk);
> > +
> > +void tcp_v4_md5_send_response_write(__be32 *topt, struct sk_buff *skb,
> > +				    struct tcphdr *t1,
> > +				    struct tcp_out_options *opts,
> > +				    const struct sock *sk);
> > +
> > +int tcp_v6_md5_send_response_prepare(struct sk_buff *skb, u8 flags,
> > +				     unsigned int remaining,
> > +				     struct tcp_out_options *opts,
> > +				     const struct sock *sk);
> > +
> > +void tcp_v6_md5_send_response_write(__be32 *topt, struct sk_buff *skb,
> > +				    struct tcphdr *t1,
> > +				    struct tcp_out_options *opts,
> > +				    const struct sock *sk);
> > +
> > +bool tcp_v4_inbound_md5_hash(const struct sock *sk,
> > +			     const struct sk_buff *skb);
> > +
> > +void tcp_v4_md5_syn_recv_sock(const struct sock *listener, struct sock=
 *sk);
> > +
> > +void tcp_v6_md5_syn_recv_sock(const struct sock *listener, struct sock=
 *sk);
> > +
> > +void tcp_md5_time_wait(struct sock *sk, struct inet_timewait_sock *tw);
> > +
> > +struct tcp_md5sig_key *tcp_v6_md5_lookup(const struct sock *sk,
> > +					 const struct sock *addr_sk);
> > +
> > +int tcp_v6_md5_hash_skb(char *md5_hash,
> > +			const struct tcp_md5sig_key *key,
> > +			const struct sock *sk,
> > +			const struct sk_buff *skb);
> > +
> > +bool tcp_v6_inbound_md5_hash(const struct sock *sk,
> > +			     const struct sk_buff *skb);
> > +
> > +static inline void tcp_md5_twsk_destructor(struct sock *sk)
> > +{
> > +	struct tcp_timewait_sock *twsk =3D tcp_twsk(sk);
> > +
> > +	if (twsk->tw_md5_key)
> > +		kfree_rcu(twsk->tw_md5_key, rcu);
> > +}
> > +
> > +static inline void tcp_md5_add_header_len(const struct sock *listener,
> > +					  struct sock *sk)
> > +{
> > +	struct tcp_sock *tp =3D tcp_sk(sk);
> > +
> > +	tp->md5sig_info =3D NULL;	/*XXX*/
> > +	if (tp->af_specific->md5_lookup(listener, sk))
> > +		tp->tcp_header_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> > +}
> > +
> > +int tcp_md5_diag_get_aux(struct sock *sk, bool net_admin, struct sk_bu=
ff *skb);
> > +
> > +int tcp_md5_diag_get_aux_size(struct sock *sk, bool net_admin);
> > +
> > +#else
> > +
> > +static inline bool tcp_v4_inbound_md5_hash(const struct sock *sk,
> > +					   const struct sk_buff *skb)
> > +{
> > +	return false;
> > +}
> > +
> > +static inline bool tcp_v6_inbound_md5_hash(const struct sock *sk,
> > +					   const struct sk_buff *skb)
> > +{
> > +	return false;
> > +}
> > +
> > +#endif
> > +
> > +#endif /* _LINUX_TCP_MD5_H */
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index beedb639e664..058715ab3a45 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -406,7 +406,6 @@ void tcp_parse_options(const struct net *net, const=
 struct sk_buff *skb,
> > 		       struct tcp_options_received *opt_rx,
> > 		       int estab, struct tcp_fastopen_cookie *foc,
> > 		       struct sock *sk);
> > -const u8 *tcp_parse_md5sig_option(const struct tcphdr *th);
> > =

> > /*
> >  *	TCP v4 functions exported for the inet6 API
> > @@ -1416,30 +1415,6 @@ static inline void tcp_clear_all_retrans_hints(s=
truct tcp_sock *tp)
> > 	tp->retransmit_skb_hint =3D NULL;
> > }
> > =

> > -union tcp_md5_addr {
> > -	struct in_addr  a4;
> > -#if IS_ENABLED(CONFIG_IPV6)
> > -	struct in6_addr	a6;
> > -#endif
> > -};
> > -
> > -/* - key database */
> > -struct tcp_md5sig_key {
> > -	struct hlist_node	node;
> > -	u8			keylen;
> > -	u8			family; /* AF_INET or AF_INET6 */
> > -	union tcp_md5_addr	addr;
> > -	u8			prefixlen;
> > -	u8			key[TCP_MD5SIG_MAXKEYLEN];
> > -	struct rcu_head		rcu;
> > -};
> > -
> > -/* - sock block */
> > -struct tcp_md5sig_info {
> > -	struct hlist_head	head;
> > -	struct rcu_head		rcu;
> > -};
> > -
> > /* - pseudo header */
> > struct tcp4_pseudohdr {
> > 	__be32		saddr;
> > @@ -1456,58 +1431,6 @@ struct tcp6_pseudohdr {
> > 	__be32		protocol;	/* including padding */
> > };
> > =

> > -union tcp_md5sum_block {
> > -	struct tcp4_pseudohdr ip4;
> > -#if IS_ENABLED(CONFIG_IPV6)
> > -	struct tcp6_pseudohdr ip6;
> > -#endif
> > -};
> > -
> > -/* - pool: digest algorithm, hash description and scratch buffer */
> > -struct tcp_md5sig_pool {
> > -	struct ahash_request	*md5_req;
> > -	void			*scratch;
> > -};
> > -
> > -/* - functions */
> > -int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *k=
ey,
> > -			const struct sock *sk, const struct sk_buff *skb);
> > -int tcp_md5_do_add(struct sock *sk, const union tcp_md5_addr *addr,
> > -		   int family, u8 prefixlen, const u8 *newkey, u8 newkeylen,
> > -		   gfp_t gfp);
> > -int tcp_md5_do_del(struct sock *sk, const union tcp_md5_addr *addr,
> > -		   int family, u8 prefixlen);
> > -struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
> > -					 const struct sock *addr_sk);
> > -
> > -#ifdef CONFIG_TCP_MD5SIG
> > -struct tcp_md5sig_key *tcp_md5_do_lookup(const struct sock *sk,
> > -					 const union tcp_md5_addr *addr,
> > -					 int family);
> > -#define tcp_twsk_md5_key(twsk)	((twsk)->tw_md5_key)
> > -#else
> > -static inline struct tcp_md5sig_key *tcp_md5_do_lookup(const struct so=
ck *sk,
> > -					 const union tcp_md5_addr *addr,
> > -					 int family)
> > -{
> > -	return NULL;
> > -}
> > -#define tcp_twsk_md5_key(twsk)	NULL
> > -#endif
> > -
> > -bool tcp_alloc_md5sig_pool(void);
> > -
> > -struct tcp_md5sig_pool *tcp_get_md5sig_pool(void);
> > -static inline void tcp_put_md5sig_pool(void)
> > -{
> > -	local_bh_enable();
> > -}
> > -
> > -int tcp_md5_hash_skb_data(struct tcp_md5sig_pool *, const struct sk_bu=
ff *,
> > -			  unsigned int header_len);
> > -int tcp_md5_hash_key(struct tcp_md5sig_pool *hp,
> > -		     const struct tcp_md5sig_key *key);
> > -
> > /* From tcp_fastopen.c */
> > void tcp_fastopen_cache_get(struct sock *sk, u16 *mss,
> > 			    struct tcp_fastopen_cookie *cookie, int *syn_loss,
> > diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
> > index c6c8ad1d4b6d..9262d9a01035 100644
> > --- a/net/ipv4/Makefile
> > +++ b/net/ipv4/Makefile
> > @@ -61,6 +61,7 @@ obj-$(CONFIG_TCP_CONG_LP) +=3D tcp_lp.o
> > obj-$(CONFIG_TCP_CONG_YEAH) +=3D tcp_yeah.o
> > obj-$(CONFIG_TCP_CONG_ILLINOIS) +=3D tcp_illinois.o
> > obj-$(CONFIG_NETLABEL) +=3D cipso_ipv4.o
> > +obj-$(CONFIG_TCP_MD5SIG) +=3D tcp_md5.o
> > =

> > obj-$(CONFIG_XFRM) +=3D xfrm4_policy.o xfrm4_state.o xfrm4_input.o \
> > 		      xfrm4_output.o xfrm4_protocol.o
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 3090fac3c462..ca1ddb2c820c 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -271,6 +271,7 @@
> > #include <linux/slab.h>
> > #include <linux/errqueue.h>
> > #include <linux/static_key.h>
> > +#include <linux/tcp_md5.h>
> > =

> > #include <net/icmp.h>
> > #include <net/inet_common.h>
> > @@ -3342,138 +3343,6 @@ int compat_tcp_getsockopt(struct sock *sk, int =
level, int optname,
> > EXPORT_SYMBOL(compat_tcp_getsockopt);
> > #endif
> > =

> > -#ifdef CONFIG_TCP_MD5SIG
> > -static DEFINE_PER_CPU(struct tcp_md5sig_pool, tcp_md5sig_pool);
> > -static DEFINE_MUTEX(tcp_md5sig_mutex);
> > -static bool tcp_md5sig_pool_populated =3D false;
> > -
> > -static void __tcp_alloc_md5sig_pool(void)
> > -{
> > -	struct crypto_ahash *hash;
> > -	int cpu;
> > -
> > -	hash =3D crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
> > -	if (IS_ERR(hash))
> > -		return;
> > -
> > -	for_each_possible_cpu(cpu) {
> > -		void *scratch =3D per_cpu(tcp_md5sig_pool, cpu).scratch;
> > -		struct ahash_request *req;
> > -
> > -		if (!scratch) {
> > -			scratch =3D kmalloc_node(sizeof(union tcp_md5sum_block) +
> > -					       sizeof(struct tcphdr),
> > -					       GFP_KERNEL,
> > -					       cpu_to_node(cpu));
> > -			if (!scratch)
> > -				return;
> > -			per_cpu(tcp_md5sig_pool, cpu).scratch =3D scratch;
> > -		}
> > -		if (per_cpu(tcp_md5sig_pool, cpu).md5_req)
> > -			continue;
> > -
> > -		req =3D ahash_request_alloc(hash, GFP_KERNEL);
> > -		if (!req)
> > -			return;
> > -
> > -		ahash_request_set_callback(req, 0, NULL, NULL);
> > -
> > -		per_cpu(tcp_md5sig_pool, cpu).md5_req =3D req;
> > -	}
> > -	/* before setting tcp_md5sig_pool_populated, we must commit all writes
> > -	 * to memory. See smp_rmb() in tcp_get_md5sig_pool()
> > -	 */
> > -	smp_wmb();
> > -	tcp_md5sig_pool_populated =3D true;
> > -}
> > -
> > -bool tcp_alloc_md5sig_pool(void)
> > -{
> > -	if (unlikely(!tcp_md5sig_pool_populated)) {
> > -		mutex_lock(&tcp_md5sig_mutex);
> > -
> > -		if (!tcp_md5sig_pool_populated)
> > -			__tcp_alloc_md5sig_pool();
> > -
> > -		mutex_unlock(&tcp_md5sig_mutex);
> > -	}
> > -	return tcp_md5sig_pool_populated;
> > -}
> > -EXPORT_SYMBOL(tcp_alloc_md5sig_pool);
> > -
> > -
> > -/**
> > - *	tcp_get_md5sig_pool - get md5sig_pool for this user
> > - *
> > - *	We use percpu structure, so if we succeed, we exit with preemption
> > - *	and BH disabled, to make sure another thread or softirq handling
> > - *	wont try to get same context.
> > - */
> > -struct tcp_md5sig_pool *tcp_get_md5sig_pool(void)
> > -{
> > -	local_bh_disable();
> > -
> > -	if (tcp_md5sig_pool_populated) {
> > -		/* coupled with smp_wmb() in __tcp_alloc_md5sig_pool() */
> > -		smp_rmb();
> > -		return this_cpu_ptr(&tcp_md5sig_pool);
> > -	}
> > -	local_bh_enable();
> > -	return NULL;
> > -}
> > -EXPORT_SYMBOL(tcp_get_md5sig_pool);
> > -
> > -int tcp_md5_hash_skb_data(struct tcp_md5sig_pool *hp,
> > -			  const struct sk_buff *skb, unsigned int header_len)
> > -{
> > -	struct scatterlist sg;
> > -	const struct tcphdr *tp =3D tcp_hdr(skb);
> > -	struct ahash_request *req =3D hp->md5_req;
> > -	unsigned int i;
> > -	const unsigned int head_data_len =3D skb_headlen(skb) > header_len ?
> > -					   skb_headlen(skb) - header_len : 0;
> > -	const struct skb_shared_info *shi =3D skb_shinfo(skb);
> > -	struct sk_buff *frag_iter;
> > -
> > -	sg_init_table(&sg, 1);
> > -
> > -	sg_set_buf(&sg, ((u8 *) tp) + header_len, head_data_len);
> > -	ahash_request_set_crypt(req, &sg, NULL, head_data_len);
> > -	if (crypto_ahash_update(req))
> > -		return 1;
> > -
> > -	for (i =3D 0; i < shi->nr_frags; ++i) {
> > -		const struct skb_frag_struct *f =3D &shi->frags[i];
> > -		unsigned int offset =3D f->page_offset;
> > -		struct page *page =3D skb_frag_page(f) + (offset >> PAGE_SHIFT);
> > -
> > -		sg_set_page(&sg, page, skb_frag_size(f),
> > -			    offset_in_page(offset));
> > -		ahash_request_set_crypt(req, &sg, NULL, skb_frag_size(f));
> > -		if (crypto_ahash_update(req))
> > -			return 1;
> > -	}
> > -
> > -	skb_walk_frags(skb, frag_iter)
> > -		if (tcp_md5_hash_skb_data(hp, frag_iter, 0))
> > -			return 1;
> > -
> > -	return 0;
> > -}
> > -EXPORT_SYMBOL(tcp_md5_hash_skb_data);
> > -
> > -int tcp_md5_hash_key(struct tcp_md5sig_pool *hp, const struct tcp_md5s=
ig_key *key)
> > -{
> > -	struct scatterlist sg;
> > -
> > -	sg_init_one(&sg, key->key, key->keylen);
> > -	ahash_request_set_crypt(hp->md5_req, &sg, NULL, key->keylen);
> > -	return crypto_ahash_update(hp->md5_req);
> > -}
> > -EXPORT_SYMBOL(tcp_md5_hash_key);
> > -
> > -#endif
> > -
> > static struct list_head *tcp_extra_options_get_list(const struct sock *=
sk)
> > {
> > 	if (sk_fullsock(sk))
> > diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
> > index abbf0edcf6c2..5cfe5dc8f8dd 100644
> > --- a/net/ipv4/tcp_diag.c
> > +++ b/net/ipv4/tcp_diag.c
> > @@ -15,6 +15,7 @@
> > #include <linux/inet_diag.h>
> > =

> > #include <linux/tcp.h>
> > +#include <linux/tcp_md5.h>
> > =

> > #include <net/netlink.h>
> > #include <net/tcp.h>
> > @@ -37,70 +38,14 @@ static void tcp_diag_get_info(struct sock *sk, stru=
ct inet_diag_msg *r,
> > 		tcp_get_info(sk, info);
> > }
> > =

> > -#ifdef CONFIG_TCP_MD5SIG
> > -static void tcp_diag_md5sig_fill(struct tcp_diag_md5sig *info,
> > -				 const struct tcp_md5sig_key *key)
> > -{
> > -	info->tcpm_family =3D key->family;
> > -	info->tcpm_prefixlen =3D key->prefixlen;
> > -	info->tcpm_keylen =3D key->keylen;
> > -	memcpy(info->tcpm_key, key->key, key->keylen);
> > -
> > -	if (key->family =3D=3D AF_INET)
> > -		info->tcpm_addr[0] =3D key->addr.a4.s_addr;
> > -	#if IS_ENABLED(CONFIG_IPV6)
> > -	else if (key->family =3D=3D AF_INET6)
> > -		memcpy(&info->tcpm_addr, &key->addr.a6,
> > -		       sizeof(info->tcpm_addr));
> > -	#endif
> > -}
> > -
> > -static int tcp_diag_put_md5sig(struct sk_buff *skb,
> > -			       const struct tcp_md5sig_info *md5sig)
> > -{
> > -	const struct tcp_md5sig_key *key;
> > -	struct tcp_diag_md5sig *info;
> > -	struct nlattr *attr;
> > -	int md5sig_count =3D 0;
> > -
> > -	hlist_for_each_entry_rcu(key, &md5sig->head, node)
> > -		md5sig_count++;
> > -	if (md5sig_count =3D=3D 0)
> > -		return 0;
> > -
> > -	attr =3D nla_reserve(skb, INET_DIAG_MD5SIG,
> > -			   md5sig_count * sizeof(struct tcp_diag_md5sig));
> > -	if (!attr)
> > -		return -EMSGSIZE;
> > -
> > -	info =3D nla_data(attr);
> > -	memset(info, 0, md5sig_count * sizeof(struct tcp_diag_md5sig));
> > -	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
> > -		tcp_diag_md5sig_fill(info++, key);
> > -		if (--md5sig_count =3D=3D 0)
> > -			break;
> > -	}
> > -
> > -	return 0;
> > -}
> > -#endif
> > -
> > static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
> > 			    struct sk_buff *skb)
> > {
> > #ifdef CONFIG_TCP_MD5SIG
> > -	if (net_admin) {
> > -		struct tcp_md5sig_info *md5sig;
> > -		int err =3D 0;
> > -
> > -		rcu_read_lock();
> > -		md5sig =3D rcu_dereference(tcp_sk(sk)->md5sig_info);
> > -		if (md5sig)
> > -			err =3D tcp_diag_put_md5sig(skb, md5sig);
> > -		rcu_read_unlock();
> > -		if (err < 0)
> > -			return err;
> > -	}
> > +	int err =3D tcp_md5_diag_get_aux(sk, net_admin, skb);
> > +
> > +	if (err < 0)
> > +		return err;
> > #endif
> > =

> > 	return 0;
> > @@ -111,21 +56,7 @@ static size_t tcp_diag_get_aux_size(struct sock *sk=
, bool net_admin)
> > 	size_t size =3D 0;
> > =

> > #ifdef CONFIG_TCP_MD5SIG
> > -	if (net_admin && sk_fullsock(sk)) {
> > -		const struct tcp_md5sig_info *md5sig;
> > -		const struct tcp_md5sig_key *key;
> > -		size_t md5sig_count =3D 0;
> > -
> > -		rcu_read_lock();
> > -		md5sig =3D rcu_dereference(tcp_sk(sk)->md5sig_info);
> > -		if (md5sig) {
> > -			hlist_for_each_entry_rcu(key, &md5sig->head, node)
> > -				md5sig_count++;
> > -		}
> > -		rcu_read_unlock();
> > -		size +=3D nla_total_size(md5sig_count *
> > -				       sizeof(struct tcp_diag_md5sig));
> > -	}
> > +	size +=3D tcp_md5_diag_get_aux_size(sk, net_admin);
> > #endif
> > =

> > 	return size;
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 5dd19c3f37ce..09778d8104b8 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -3848,44 +3848,6 @@ static bool tcp_fast_parse_options(const struct =
net *net,
> > 	return false;
> > }
> > =

> > -#ifdef CONFIG_TCP_MD5SIG
> > -/*
> > - * Parse MD5 Signature option
> > - */
> > -const u8 *tcp_parse_md5sig_option(const struct tcphdr *th)
> > -{
> > -	int length =3D (th->doff << 2) - sizeof(*th);
> > -	const u8 *ptr =3D (const u8 *)(th + 1);
> > -
> > -	/* If the TCP option is too short, we can short cut */
> > -	if (length < TCPOLEN_MD5SIG)
> > -		return NULL;
> > -
> > -	while (length > 0) {
> > -		int opcode =3D *ptr++;
> > -		int opsize;
> > -
> > -		switch (opcode) {
> > -		case TCPOPT_EOL:
> > -			return NULL;
> > -		case TCPOPT_NOP:
> > -			length--;
> > -			continue;
> > -		default:
> > -			opsize =3D *ptr++;
> > -			if (opsize < 2 || opsize > length)
> > -				return NULL;
> > -			if (opcode =3D=3D TCPOPT_MD5SIG)
> > -				return opsize =3D=3D TCPOLEN_MD5SIG ? ptr : NULL;
> > -		}
> > -		ptr +=3D opsize - 2;
> > -		length -=3D opsize;
> > -	}
> > -	return NULL;
> > -}
> > -EXPORT_SYMBOL(tcp_parse_md5sig_option);
> > -#endif
> > -
> > /* Sorry, PAWS as specified is broken wrt. pure-ACKs -DaveM
> >  *
> >  * It is not fatal. If this ACK does _not_ change critical state (seqs,=
 window)
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index f0db7beda04e..d05162654848 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -62,6 +62,7 @@
> > #include <linux/init.h>
> > #include <linux/times.h>
> > #include <linux/slab.h>
> > +#include <linux/tcp_md5.h>
> > =

> > #include <net/net_namespace.h>
> > #include <net/icmp.h>
> > @@ -87,11 +88,6 @@
> > =

> > #include <trace/events/tcp.h>
> > =

> > -#ifdef CONFIG_TCP_MD5SIG
> > -static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig=
_key *key,
> > -			       __be32 daddr, __be32 saddr, const struct tcphdr *th);
> > -#endif
> > -
> > struct inet_hashinfo tcp_hashinfo;
> > EXPORT_SYMBOL(tcp_hashinfo);
> > =

> > @@ -602,14 +598,8 @@ static void tcp_v4_send_reset(const struct sock *s=
k, struct sk_buff *skb)
> > 		struct tcphdr th;
> > 		__be32 opt[(MAX_TCP_OPTION_SPACE >> 2)];
> > 	} rep;
> > +	struct tcp_out_options opts;
> > 	struct ip_reply_arg arg;
> > -#ifdef CONFIG_TCP_MD5SIG
> > -	struct tcp_md5sig_key *key =3D NULL;
> > -	const __u8 *hash_location =3D NULL;
> > -	unsigned char newhash[16];
> > -	int genhash;
> > -	struct sock *sk1 =3D NULL;
> > -#endif
> > 	struct net *net;
> > 	int offset =3D 0;
> > =

> > @@ -623,6 +613,8 @@ static void tcp_v4_send_reset(const struct sock *sk=
, struct sk_buff *skb)
> > 	if (!sk && skb_rtable(skb)->rt_type !=3D RTN_LOCAL)
> > 		return;
> > =

> > +	memset(&opts, 0, sizeof(opts));
> > +
> > 	/* Swap the send and the receive. */
> > 	memset(&rep, 0, sizeof(rep));
> > 	rep.th.dest   =3D th->source;
> > @@ -643,55 +635,32 @@ static void tcp_v4_send_reset(const struct sock *=
sk, struct sk_buff *skb)
> > 	arg.iov[0].iov_len  =3D sizeof(rep.th);
> > =

> > 	net =3D sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
> > -#ifdef CONFIG_TCP_MD5SIG
> > -	rcu_read_lock();
> > -	hash_location =3D tcp_parse_md5sig_option(th);
> > -	if (sk && sk_fullsock(sk)) {
> > -		key =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)
> > -					&ip_hdr(skb)->saddr, AF_INET);
> > -	} else if (hash_location) {
> > -		/*
> > -		 * active side is lost. Try to find listening socket through
> > -		 * source port, and then find md5 key through listening socket.
> > -		 * we are not loose security here:
> > -		 * Incoming packet is checked with md5 hash with finding key,
> > -		 * no RST generated if md5 hash doesn't match.
> > -		 */
> > -		sk1 =3D __inet_lookup_listener(net, &tcp_hashinfo, NULL, 0,
> > -					     ip_hdr(skb)->saddr,
> > -					     th->source, ip_hdr(skb)->daddr,
> > -					     ntohs(th->source), inet_iif(skb),
> > -					     tcp_v4_sdif(skb));
> > -		/* don't send rst if it can't find key */
> > -		if (!sk1)
> > -			goto out;
> > =

> > -		key =3D tcp_md5_do_lookup(sk1, (union tcp_md5_addr *)
> > -					&ip_hdr(skb)->saddr, AF_INET);
> > -		if (!key)
> > -			goto out;
> > +#ifdef CONFIG_TCP_MD5DSIG
> > +{
> > +	int ret;
> > =

> > +	ret =3D tcp_v4_md5_send_response_prepare(skb, 0,
> > +					       MAX_TCP_OPTION_SPACE - arg.iov[0].iov_len
> > +					       &opts, sk);
> > =

> > -		genhash =3D tcp_v4_md5_hash_skb(newhash, key, NULL, skb);
> > -		if (genhash || memcmp(hash_location, newhash, 16) !=3D 0)
> > -			goto out;
> > +	if (ret =3D=3D -1)
> > +		return;
> > =

> > -	}
> > +	arg.iov[0].iov_len +=3D ret;
> > +}
> > #endif
> > =

> > 	if (static_branch_unlikely(&tcp_extra_options_enabled)) {
> > 		unsigned int remaining;
> > -		struct tcp_out_options opts;
> > 		int used;
> > =

> > 		remaining =3D sizeof(rep.opt);
> > #ifdef CONFIG_TCP_MD5SIG
> > -		if (key)
> > +		if (opts.md5)
> > 			remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
> > #endif
> > =

> > -		memset(&opts, 0, sizeof(opts));
> > -
> > 		used =3D tcp_extra_options_response_prepare(skb, TCPHDR_RST,
> > 							  remaining,
> > 							  &opts, sk);
> > @@ -706,19 +675,7 @@ static void tcp_v4_send_reset(const struct sock *s=
k, struct sk_buff *skb)
> > 	}
> > =

> > #ifdef CONFIG_TCP_MD5SIG
> > -	if (key) {
> > -		rep.opt[offset++] =3D htonl((TCPOPT_NOP << 24) |
> > -					  (TCPOPT_NOP << 16) |
> > -					  (TCPOPT_MD5SIG << 8) |
> > -					  TCPOLEN_MD5SIG);
> > -		/* Update length and the length the header thinks exists */
> > -		arg.iov[0].iov_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> > -		rep.th.doff =3D arg.iov[0].iov_len / 4;
> > -
> > -		tcp_v4_md5_hash_hdr((__u8 *)&rep.opt[offset],
> > -				    key, ip_hdr(skb)->saddr,
> > -				    ip_hdr(skb)->daddr, &rep.th);
> > -	}
> > +	tcp_v4_md5_send_response_write(&rep.opt[offset], skb, &rep.th, &opts,=
 sk);
> > #endif
> > 	arg.csum =3D csum_tcpudp_nofold(ip_hdr(skb)->daddr,
> > 				      ip_hdr(skb)->saddr, /* XXX */
> > @@ -749,11 +706,6 @@ static void tcp_v4_send_reset(const struct sock *s=
k, struct sk_buff *skb)
> > 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
> > 	__TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
> > 	local_bh_enable();
> > -
> > -#ifdef CONFIG_TCP_MD5SIG
> > -out:
> > -	rcu_read_unlock();
> > -#endif
> > }
> > =

> > /* The code following below sending ACKs in SYN-RECV and TIME-WAIT stat=
es
> > @@ -770,15 +722,14 @@ static void tcp_v4_send_ack(const struct sock *sk,
> > 		struct tcphdr th;
> > 		__be32 opt[(MAX_TCP_OPTION_SPACE >> 2)];
> > 	} rep;
> > -#ifdef CONFIG_TCP_MD5SIG
> > -	struct tcp_md5sig_key *key;
> > -#endif
> > +	struct tcp_out_options opts;
> > 	struct net *net =3D sock_net(sk);
> > 	struct ip_reply_arg arg;
> > 	int offset =3D 0;
> > =

> > 	memset(&rep.th, 0, sizeof(struct tcphdr));
> > 	memset(&arg, 0, sizeof(arg));
> > +	memset(&opts, 0, sizeof(opts));
> > =

> > 	arg.iov[0].iov_base =3D (unsigned char *)&rep;
> > 	arg.iov[0].iov_len  =3D sizeof(rep.th);
> > @@ -801,27 +752,28 @@ static void tcp_v4_send_ack(const struct sock *sk,
> > 	rep.th.window  =3D htons(win);
> > =

> > #ifdef CONFIG_TCP_MD5SIG
> > -	if (sk->sk_state =3D=3D TCP_TIME_WAIT) {
> > -		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
> > +{
> > +	int ret;
> > =

> > -		key =3D tcp_twsk_md5_key(tcptw);
> > -	} else if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
> > -		key =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&ip_hdr(skb)->da=
ddr,
> > -					AF_INET);
> > -	} else {
> > -		BUG();
> > -	}
> > +	ret =3D tcp_v4_md5_send_response_prepare(skb, 0,
> > +					       MAX_TCP_OPTION_SPACE - arg.iov[0].iov_len,
> > +					       &opts, sk);
> > +
> > +	if (ret =3D=3D -1)
> > +		return;
> > +
> > +	arg.iov[0].iov_len +=3D ret;
> > +}
> > #endif
> > =

> > 	if (static_branch_unlikely(&tcp_extra_options_enabled)) {
> > 		unsigned int remaining;
> > -		struct tcp_out_options opts;
> > 		int used;
> > =

> > 		remaining =3D sizeof(rep.th) + sizeof(rep.opt) - arg.iov[0].iov_len;
> > =

> > #ifdef CONFIG_TCP_MD5SIG
> > -		if (key)
> > +		if (opts.md5)
> > 			remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
> > #endif
> > =

> > @@ -839,17 +791,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
> > 	}
> > =

> > #ifdef CONFIG_TCP_MD5SIG
> > -	if (key) {
> > -		rep.opt[offset++] =3D htonl((TCPOPT_NOP << 24) |
> > -					  (TCPOPT_NOP << 16) |
> > -					  (TCPOPT_MD5SIG << 8) |
> > -					  TCPOLEN_MD5SIG);
> > -		arg.iov[0].iov_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> > -
> > -		tcp_v4_md5_hash_hdr((__u8 *) &rep.opt[offset],
> > -				    key, ip_hdr(skb)->saddr,
> > -				    ip_hdr(skb)->daddr, &rep.th);
> > -	}
> > +	tcp_v4_md5_send_response_write(&rep.opt[offset], skb, &rep.th, &opts,=
 sk);
> > #endif
> > =

> > 	rep.th.doff =3D arg.iov[0].iov_len / 4;
> > @@ -960,374 +902,6 @@ static void tcp_v4_reqsk_destructor(struct reques=
t_sock *req)
> > 	kfree(rcu_dereference_protected(inet_rsk(req)->ireq_opt, 1));
> > }
> > =

> > -#ifdef CONFIG_TCP_MD5SIG
> > -/*
> > - * RFC2385 MD5 checksumming requires a mapping of
> > - * IP address->MD5 Key.
> > - * We need to maintain these in the sk structure.
> > - */
> > -
> > -/* Find the Key structure for an address.  */
> > -struct tcp_md5sig_key *tcp_md5_do_lookup(const struct sock *sk,
> > -					 const union tcp_md5_addr *addr,
> > -					 int family)
> > -{
> > -	const struct tcp_sock *tp =3D tcp_sk(sk);
> > -	struct tcp_md5sig_key *key;
> > -	const struct tcp_md5sig_info *md5sig;
> > -	__be32 mask;
> > -	struct tcp_md5sig_key *best_match =3D NULL;
> > -	bool match;
> > -
> > -	/* caller either holds rcu_read_lock() or socket lock */
> > -	md5sig =3D rcu_dereference_check(tp->md5sig_info,
> > -				       lockdep_sock_is_held(sk));
> > -	if (!md5sig)
> > -		return NULL;
> > -
> > -	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
> > -		if (key->family !=3D family)
> > -			continue;
> > -
> > -		if (family =3D=3D AF_INET) {
> > -			mask =3D inet_make_mask(key->prefixlen);
> > -			match =3D (key->addr.a4.s_addr & mask) =3D=3D
> > -				(addr->a4.s_addr & mask);
> > -#if IS_ENABLED(CONFIG_IPV6)
> > -		} else if (family =3D=3D AF_INET6) {
> > -			match =3D ipv6_prefix_equal(&key->addr.a6, &addr->a6,
> > -						  key->prefixlen);
> > -#endif
> > -		} else {
> > -			match =3D false;
> > -		}
> > -
> > -		if (match && (!best_match ||
> > -			      key->prefixlen > best_match->prefixlen))
> > -			best_match =3D key;
> > -	}
> > -	return best_match;
> > -}
> > -EXPORT_SYMBOL(tcp_md5_do_lookup);
> > -
> > -static struct tcp_md5sig_key *tcp_md5_do_lookup_exact(const struct soc=
k *sk,
> > -						      const union tcp_md5_addr *addr,
> > -						      int family, u8 prefixlen)
> > -{
> > -	const struct tcp_sock *tp =3D tcp_sk(sk);
> > -	struct tcp_md5sig_key *key;
> > -	unsigned int size =3D sizeof(struct in_addr);
> > -	const struct tcp_md5sig_info *md5sig;
> > -
> > -	/* caller either holds rcu_read_lock() or socket lock */
> > -	md5sig =3D rcu_dereference_check(tp->md5sig_info,
> > -				       lockdep_sock_is_held(sk));
> > -	if (!md5sig)
> > -		return NULL;
> > -#if IS_ENABLED(CONFIG_IPV6)
> > -	if (family =3D=3D AF_INET6)
> > -		size =3D sizeof(struct in6_addr);
> > -#endif
> > -	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
> > -		if (key->family !=3D family)
> > -			continue;
> > -		if (!memcmp(&key->addr, addr, size) &&
> > -		    key->prefixlen =3D=3D prefixlen)
> > -			return key;
> > -	}
> > -	return NULL;
> > -}
> > -
> > -struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
> > -					 const struct sock *addr_sk)
> > -{
> > -	const union tcp_md5_addr *addr;
> > -
> > -	addr =3D (const union tcp_md5_addr *)&addr_sk->sk_daddr;
> > -	return tcp_md5_do_lookup(sk, addr, AF_INET);
> > -}
> > -EXPORT_SYMBOL(tcp_v4_md5_lookup);
> > -
> > -/* This can be called on a newly created socket, from other files */
> > -int tcp_md5_do_add(struct sock *sk, const union tcp_md5_addr *addr,
> > -		   int family, u8 prefixlen, const u8 *newkey, u8 newkeylen,
> > -		   gfp_t gfp)
> > -{
> > -	/* Add Key to the list */
> > -	struct tcp_md5sig_key *key;
> > -	struct tcp_sock *tp =3D tcp_sk(sk);
> > -	struct tcp_md5sig_info *md5sig;
> > -
> > -	key =3D tcp_md5_do_lookup_exact(sk, addr, family, prefixlen);
> > -	if (key) {
> > -		/* Pre-existing entry - just update that one. */
> > -		memcpy(key->key, newkey, newkeylen);
> > -		key->keylen =3D newkeylen;
> > -		return 0;
> > -	}
> > -
> > -	md5sig =3D rcu_dereference_protected(tp->md5sig_info,
> > -					   lockdep_sock_is_held(sk));
> > -	if (!md5sig) {
> > -		md5sig =3D kmalloc(sizeof(*md5sig), gfp);
> > -		if (!md5sig)
> > -			return -ENOMEM;
> > -
> > -		sk_nocaps_add(sk, NETIF_F_GSO_MASK);
> > -		INIT_HLIST_HEAD(&md5sig->head);
> > -		rcu_assign_pointer(tp->md5sig_info, md5sig);
> > -	}
> > -
> > -	key =3D sock_kmalloc(sk, sizeof(*key), gfp);
> > -	if (!key)
> > -		return -ENOMEM;
> > -	if (!tcp_alloc_md5sig_pool()) {
> > -		sock_kfree_s(sk, key, sizeof(*key));
> > -		return -ENOMEM;
> > -	}
> > -
> > -	memcpy(key->key, newkey, newkeylen);
> > -	key->keylen =3D newkeylen;
> > -	key->family =3D family;
> > -	key->prefixlen =3D prefixlen;
> > -	memcpy(&key->addr, addr,
> > -	       (family =3D=3D AF_INET6) ? sizeof(struct in6_addr) :
> > -				      sizeof(struct in_addr));
> > -	hlist_add_head_rcu(&key->node, &md5sig->head);
> > -	return 0;
> > -}
> > -EXPORT_SYMBOL(tcp_md5_do_add);
> > -
> > -int tcp_md5_do_del(struct sock *sk, const union tcp_md5_addr *addr, in=
t family,
> > -		   u8 prefixlen)
> > -{
> > -	struct tcp_md5sig_key *key;
> > -
> > -	key =3D tcp_md5_do_lookup_exact(sk, addr, family, prefixlen);
> > -	if (!key)
> > -		return -ENOENT;
> > -	hlist_del_rcu(&key->node);
> > -	atomic_sub(sizeof(*key), &sk->sk_omem_alloc);
> > -	kfree_rcu(key, rcu);
> > -	return 0;
> > -}
> > -EXPORT_SYMBOL(tcp_md5_do_del);
> > -
> > -static void tcp_clear_md5_list(struct sock *sk)
> > -{
> > -	struct tcp_sock *tp =3D tcp_sk(sk);
> > -	struct tcp_md5sig_key *key;
> > -	struct hlist_node *n;
> > -	struct tcp_md5sig_info *md5sig;
> > -
> > -	md5sig =3D rcu_dereference_protected(tp->md5sig_info, 1);
> > -
> > -	hlist_for_each_entry_safe(key, n, &md5sig->head, node) {
> > -		hlist_del_rcu(&key->node);
> > -		atomic_sub(sizeof(*key), &sk->sk_omem_alloc);
> > -		kfree_rcu(key, rcu);
> > -	}
> > -}
> > -
> > -static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
> > -				 char __user *optval, int optlen)
> > -{
> > -	struct tcp_md5sig cmd;
> > -	struct sockaddr_in *sin =3D (struct sockaddr_in *)&cmd.tcpm_addr;
> > -	u8 prefixlen =3D 32;
> > -
> > -	if (optlen < sizeof(cmd))
> > -		return -EINVAL;
> > -
> > -	if (copy_from_user(&cmd, optval, sizeof(cmd)))
> > -		return -EFAULT;
> > -
> > -	if (sin->sin_family !=3D AF_INET)
> > -		return -EINVAL;
> > -
> > -	if (optname =3D=3D TCP_MD5SIG_EXT &&
> > -	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_PREFIX) {
> > -		prefixlen =3D cmd.tcpm_prefixlen;
> > -		if (prefixlen > 32)
> > -			return -EINVAL;
> > -	}
> > -
> > -	if (!cmd.tcpm_keylen)
> > -		return tcp_md5_do_del(sk, (union tcp_md5_addr *)&sin->sin_addr.s_add=
r,
> > -				      AF_INET, prefixlen);
> > -
> > -	if (cmd.tcpm_keylen > TCP_MD5SIG_MAXKEYLEN)
> > -		return -EINVAL;
> > -
> > -	return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin->sin_addr.s_addr,
> > -			      AF_INET, prefixlen, cmd.tcpm_key, cmd.tcpm_keylen,
> > -			      GFP_KERNEL);
> > -}
> > -
> > -static int tcp_v4_md5_hash_headers(struct tcp_md5sig_pool *hp,
> > -				   __be32 daddr, __be32 saddr,
> > -				   const struct tcphdr *th, int nbytes)
> > -{
> > -	struct tcp4_pseudohdr *bp;
> > -	struct scatterlist sg;
> > -	struct tcphdr *_th;
> > -
> > -	bp =3D hp->scratch;
> > -	bp->saddr =3D saddr;
> > -	bp->daddr =3D daddr;
> > -	bp->pad =3D 0;
> > -	bp->protocol =3D IPPROTO_TCP;
> > -	bp->len =3D cpu_to_be16(nbytes);
> > -
> > -	_th =3D (struct tcphdr *)(bp + 1);
> > -	memcpy(_th, th, sizeof(*th));
> > -	_th->check =3D 0;
> > -
> > -	sg_init_one(&sg, bp, sizeof(*bp) + sizeof(*th));
> > -	ahash_request_set_crypt(hp->md5_req, &sg, NULL,
> > -				sizeof(*bp) + sizeof(*th));
> > -	return crypto_ahash_update(hp->md5_req);
> > -}
> > -
> > -static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig=
_key *key,
> > -			       __be32 daddr, __be32 saddr, const struct tcphdr *th)
> > -{
> > -	struct tcp_md5sig_pool *hp;
> > -	struct ahash_request *req;
> > -
> > -	hp =3D tcp_get_md5sig_pool();
> > -	if (!hp)
> > -		goto clear_hash_noput;
> > -	req =3D hp->md5_req;
> > -
> > -	if (crypto_ahash_init(req))
> > -		goto clear_hash;
> > -	if (tcp_v4_md5_hash_headers(hp, daddr, saddr, th, th->doff << 2))
> > -		goto clear_hash;
> > -	if (tcp_md5_hash_key(hp, key))
> > -		goto clear_hash;
> > -	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> > -	if (crypto_ahash_final(req))
> > -		goto clear_hash;
> > -
> > -	tcp_put_md5sig_pool();
> > -	return 0;
> > -
> > -clear_hash:
> > -	tcp_put_md5sig_pool();
> > -clear_hash_noput:
> > -	memset(md5_hash, 0, 16);
> > -	return 1;
> > -}
> > -
> > -int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *k=
ey,
> > -			const struct sock *sk,
> > -			const struct sk_buff *skb)
> > -{
> > -	struct tcp_md5sig_pool *hp;
> > -	struct ahash_request *req;
> > -	const struct tcphdr *th =3D tcp_hdr(skb);
> > -	__be32 saddr, daddr;
> > -
> > -	if (sk) { /* valid for establish/request sockets */
> > -		saddr =3D sk->sk_rcv_saddr;
> > -		daddr =3D sk->sk_daddr;
> > -	} else {
> > -		const struct iphdr *iph =3D ip_hdr(skb);
> > -		saddr =3D iph->saddr;
> > -		daddr =3D iph->daddr;
> > -	}
> > -
> > -	hp =3D tcp_get_md5sig_pool();
> > -	if (!hp)
> > -		goto clear_hash_noput;
> > -	req =3D hp->md5_req;
> > -
> > -	if (crypto_ahash_init(req))
> > -		goto clear_hash;
> > -
> > -	if (tcp_v4_md5_hash_headers(hp, daddr, saddr, th, skb->len))
> > -		goto clear_hash;
> > -	if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
> > -		goto clear_hash;
> > -	if (tcp_md5_hash_key(hp, key))
> > -		goto clear_hash;
> > -	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> > -	if (crypto_ahash_final(req))
> > -		goto clear_hash;
> > -
> > -	tcp_put_md5sig_pool();
> > -	return 0;
> > -
> > -clear_hash:
> > -	tcp_put_md5sig_pool();
> > -clear_hash_noput:
> > -	memset(md5_hash, 0, 16);
> > -	return 1;
> > -}
> > -EXPORT_SYMBOL(tcp_v4_md5_hash_skb);
> > -
> > -#endif
> > -
> > -/* Called with rcu_read_lock() */
> > -static bool tcp_v4_inbound_md5_hash(const struct sock *sk,
> > -				    const struct sk_buff *skb)
> > -{
> > -#ifdef CONFIG_TCP_MD5SIG
> > -	/*
> > -	 * This gets called for each TCP segment that arrives
> > -	 * so we want to be efficient.
> > -	 * We have 3 drop cases:
> > -	 * o No MD5 hash and one expected.
> > -	 * o MD5 hash and we're not expecting one.
> > -	 * o MD5 hash and its wrong.
> > -	 */
> > -	const __u8 *hash_location =3D NULL;
> > -	struct tcp_md5sig_key *hash_expected;
> > -	const struct iphdr *iph =3D ip_hdr(skb);
> > -	const struct tcphdr *th =3D tcp_hdr(skb);
> > -	int genhash;
> > -	unsigned char newhash[16];
> > -
> > -	hash_expected =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&iph->s=
addr,
> > -					  AF_INET);
> > -	hash_location =3D tcp_parse_md5sig_option(th);
> > -
> > -	/* We've parsed the options - do we have a hash? */
> > -	if (!hash_expected && !hash_location)
> > -		return false;
> > -
> > -	if (hash_expected && !hash_location) {
> > -		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
> > -		return true;
> > -	}
> > -
> > -	if (!hash_expected && hash_location) {
> > -		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
> > -		return true;
> > -	}
> > -
> > -	/* Okay, so this is hash_expected and hash_location -
> > -	 * so we need to calculate the checksum.
> > -	 */
> > -	genhash =3D tcp_v4_md5_hash_skb(newhash,
> > -				      hash_expected,
> > -				      NULL, skb);
> > -
> > -	if (genhash || memcmp(hash_location, newhash, 16) !=3D 0) {
> > -		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
> > -		net_info_ratelimited("MD5 Hash failed for (%pI4, %d)->(%pI4, %d)%s\n=
",
> > -				     &iph->saddr, ntohs(th->source),
> > -				     &iph->daddr, ntohs(th->dest),
> > -				     genhash ? " tcp_v4_calc_md5_hash failed"
> > -				     : "");
> > -		return true;
> > -	}
> > -	return false;
> > -#endif
> > -	return false;
> > -}
> > -
> > static void tcp_v4_init_req(struct request_sock *req,
> > 			    const struct sock *sk_listener,
> > 			    struct sk_buff *skb)
> > @@ -1403,9 +977,6 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
k *sk, struct sk_buff *skb,
> > 	struct inet_sock *newinet;
> > 	struct tcp_sock *newtp;
> > 	struct sock *newsk;
> > -#ifdef CONFIG_TCP_MD5SIG
> > -	struct tcp_md5sig_key *key;
> > -#endif
> > 	struct ip_options_rcu *inet_opt;
> > =

> > 	if (sk_acceptq_is_full(sk))
> > @@ -1457,20 +1028,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct s=
ock *sk, struct sk_buff *skb,
> > 		INIT_LIST_HEAD(&tcp_rsk(req)->tcp_option_list);
> > 	}
> > #ifdef CONFIG_TCP_MD5SIG
> > -	/* Copy over the MD5 key from the original socket */
> > -	key =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&newinet->inet_da=
ddr,
> > -				AF_INET);
> > -	if (key) {
> > -		/*
> > -		 * We're using one, so create a matching key
> > -		 * on the newsk structure. If we fail to get
> > -		 * memory, then we end up not copying the key
> > -		 * across. Shucks.
> > -		 */
> > -		tcp_md5_do_add(newsk, (union tcp_md5_addr *)&newinet->inet_daddr,
> > -			       AF_INET, 32, key->key, key->keylen, GFP_ATOMIC);
> > -		sk_nocaps_add(newsk, NETIF_F_GSO_MASK);
> > -	}
> > +	tcp_v4_md5_syn_recv_sock(sk, newsk);
> > #endif
> > =

> > 	if (__inet_inherit_port(sk, newsk) < 0)
> > @@ -1908,14 +1466,6 @@ const struct inet_connection_sock_af_ops ipv4_sp=
ecific =3D {
> > };
> > EXPORT_SYMBOL(ipv4_specific);
> > =

> > -#ifdef CONFIG_TCP_MD5SIG
> > -static const struct tcp_sock_af_ops tcp_sock_ipv4_specific =3D {
> > -	.md5_lookup		=3D tcp_v4_md5_lookup,
> > -	.calc_md5_hash		=3D tcp_v4_md5_hash_skb,
> > -	.md5_parse		=3D tcp_v4_parse_md5_keys,
> > -};
> > -#endif
> > -
> > /* NOTE: A lot of things set to zero explicitly by call to
> >  *       sk_alloc() so need not be done here.
> >  */
> > @@ -1958,12 +1508,7 @@ void tcp_v4_destroy_sock(struct sock *sk)
> > 	if (static_branch_unlikely(&tcp_extra_options_enabled))
> > 		tcp_extra_options_destroy(sk);
> > #ifdef CONFIG_TCP_MD5SIG
> > -	/* Clean up the MD5 key list, if any */
> > -	if (tp->md5sig_info) {
> > -		tcp_clear_md5_list(sk);
> > -		kfree_rcu(tp->md5sig_info, rcu);
> > -		tp->md5sig_info =3D NULL;
> > -	}
> > +	tcp_v4_md5_destroy_sock(sk);
> > #endif
> > =

> > 	/* Clean up a referenced TCP bind bucket. */
> > diff --git a/net/ipv4/tcp_md5.c b/net/ipv4/tcp_md5.c
> > new file mode 100644
> > index 000000000000..a7fbcda0e505
> > --- /dev/null
> > +++ b/net/ipv4/tcp_md5.c
> > @@ -0,0 +1,1104 @@
> > +#include <linux/inet_diag.h>
> > +#include <linux/inetdevice.h>
> > +#include <linux/tcp.h>
> > +#include <linux/tcp_md5.h>
> > +
> > +#include <crypto/hash.h>
> > +
> > +#include <net/inet6_hashtables.h>
> > +
> > +static DEFINE_PER_CPU(struct tcp_md5sig_pool, tcp_md5sig_pool);
> > +static DEFINE_MUTEX(tcp_md5sig_mutex);
> > +static bool tcp_md5sig_pool_populated;
> > +
> > +#define tcp_twsk_md5_key(twsk)	((twsk)->tw_md5_key)
> > +
> > +static void __tcp_alloc_md5sig_pool(void)
> > +{
> > +	struct crypto_ahash *hash;
> > +	int cpu;
> > +
> > +	hash =3D crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
> > +	if (IS_ERR(hash))
> > +		return;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		void *scratch =3D per_cpu(tcp_md5sig_pool, cpu).scratch;
> > +		struct ahash_request *req;
> > +
> > +		if (!scratch) {
> > +			scratch =3D kmalloc_node(sizeof(union tcp_md5sum_block) +
> > +					       sizeof(struct tcphdr),
> > +					       GFP_KERNEL,
> > +					       cpu_to_node(cpu));
> > +			if (!scratch)
> > +				return;
> > +			per_cpu(tcp_md5sig_pool, cpu).scratch =3D scratch;
> > +		}
> > +		if (per_cpu(tcp_md5sig_pool, cpu).md5_req)
> > +			continue;
> > +
> > +		req =3D ahash_request_alloc(hash, GFP_KERNEL);
> > +		if (!req)
> > +			return;
> > +
> > +		ahash_request_set_callback(req, 0, NULL, NULL);
> > +
> > +		per_cpu(tcp_md5sig_pool, cpu).md5_req =3D req;
> > +	}
> > +	/* before setting tcp_md5sig_pool_populated, we must commit all writes
> > +	 * to memory. See smp_rmb() in tcp_get_md5sig_pool()
> > +	 */
> > +	smp_wmb();
> > +	tcp_md5sig_pool_populated =3D true;
> > +}
> > +
> > +static bool tcp_alloc_md5sig_pool(void)
> > +{
> > +	if (unlikely(!tcp_md5sig_pool_populated)) {
> > +		mutex_lock(&tcp_md5sig_mutex);
> > +
> > +		if (!tcp_md5sig_pool_populated)
> > +			__tcp_alloc_md5sig_pool();
> > +
> > +		mutex_unlock(&tcp_md5sig_mutex);
> > +	}
> > +	return tcp_md5sig_pool_populated;
> > +}
> > +
> > +static void tcp_put_md5sig_pool(void)
> > +{
> > +	local_bh_enable();
> > +}
> > +
> > +/**
> > + *	tcp_get_md5sig_pool - get md5sig_pool for this user
> > + *
> > + *	We use percpu structure, so if we succeed, we exit with preemption
> > + *	and BH disabled, to make sure another thread or softirq handling
> > + *	wont try to get same context.
> > + */
> > +static struct tcp_md5sig_pool *tcp_get_md5sig_pool(void)
> > +{
> > +	local_bh_disable();
> > +
> > +	if (tcp_md5sig_pool_populated) {
> > +		/* coupled with smp_wmb() in __tcp_alloc_md5sig_pool() */
> > +		smp_rmb();
> > +		return this_cpu_ptr(&tcp_md5sig_pool);
> > +	}
> > +	local_bh_enable();
> > +	return NULL;
> > +}
> > +
> > +static struct tcp_md5sig_key *tcp_md5_do_lookup_exact(const struct soc=
k *sk,
> > +						      const union tcp_md5_addr *addr,
> > +						      int family, u8 prefixlen)
> > +{
> > +	const struct tcp_sock *tp =3D tcp_sk(sk);
> > +	struct tcp_md5sig_key *key;
> > +	unsigned int size =3D sizeof(struct in_addr);
> > +	const struct tcp_md5sig_info *md5sig;
> > +
> > +	/* caller either holds rcu_read_lock() or socket lock */
> > +	md5sig =3D rcu_dereference_check(tp->md5sig_info,
> > +				       lockdep_sock_is_held(sk));
> > +	if (!md5sig)
> > +		return NULL;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +	if (family =3D=3D AF_INET6)
> > +		size =3D sizeof(struct in6_addr);
> > +#endif
> > +	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
> > +		if (key->family !=3D family)
> > +			continue;
> > +		if (!memcmp(&key->addr, addr, size) &&
> > +		    key->prefixlen =3D=3D prefixlen)
> > +			return key;
> > +	}
> > +	return NULL;
> > +}
> > +
> > +/* This can be called on a newly created socket, from other files */
> > +static int tcp_md5_do_add(struct sock *sk, const union tcp_md5_addr *a=
ddr,
> > +			  int family, u8 prefixlen, const u8 *newkey,
> > +			  u8 newkeylen, gfp_t gfp)
> > +{
> > +	/* Add Key to the list */
> > +	struct tcp_md5sig_key *key;
> > +	struct tcp_sock *tp =3D tcp_sk(sk);
> > +	struct tcp_md5sig_info *md5sig;
> > +
> > +	key =3D tcp_md5_do_lookup_exact(sk, addr, family, prefixlen);
> > +	if (key) {
> > +		/* Pre-existing entry - just update that one. */
> > +		memcpy(key->key, newkey, newkeylen);
> > +		key->keylen =3D newkeylen;
> > +		return 0;
> > +	}
> > +
> > +	md5sig =3D rcu_dereference_protected(tp->md5sig_info,
> > +					   lockdep_sock_is_held(sk));
> > +	if (!md5sig) {
> > +		md5sig =3D kmalloc(sizeof(*md5sig), gfp);
> > +		if (!md5sig)
> > +			return -ENOMEM;
> > +
> > +		sk_nocaps_add(sk, NETIF_F_GSO_MASK);
> > +		INIT_HLIST_HEAD(&md5sig->head);
> > +		rcu_assign_pointer(tp->md5sig_info, md5sig);
> > +	}
> > +
> > +	key =3D sock_kmalloc(sk, sizeof(*key), gfp);
> > +	if (!key)
> > +		return -ENOMEM;
> > +	if (!tcp_alloc_md5sig_pool()) {
> > +		sock_kfree_s(sk, key, sizeof(*key));
> > +		return -ENOMEM;
> > +	}
> > +
> > +	memcpy(key->key, newkey, newkeylen);
> > +	key->keylen =3D newkeylen;
> > +	key->family =3D family;
> > +	key->prefixlen =3D prefixlen;
> > +	memcpy(&key->addr, addr,
> > +	       (family =3D=3D AF_INET6) ? sizeof(struct in6_addr) :
> > +				      sizeof(struct in_addr));
> > +	hlist_add_head_rcu(&key->node, &md5sig->head);
> > +	return 0;
> > +}
> > +
> > +static void tcp_clear_md5_list(struct sock *sk)
> > +{
> > +	struct tcp_sock *tp =3D tcp_sk(sk);
> > +	struct tcp_md5sig_key *key;
> > +	struct hlist_node *n;
> > +	struct tcp_md5sig_info *md5sig;
> > +
> > +	md5sig =3D rcu_dereference_protected(tp->md5sig_info, 1);
> > +
> > +	hlist_for_each_entry_safe(key, n, &md5sig->head, node) {
> > +		hlist_del_rcu(&key->node);
> > +		atomic_sub(sizeof(*key), &sk->sk_omem_alloc);
> > +		kfree_rcu(key, rcu);
> > +	}
> > +}
> > +
> > +static int tcp_md5_do_del(struct sock *sk, const union tcp_md5_addr *a=
ddr,
> > +			  int family, u8 prefixlen)
> > +{
> > +	struct tcp_md5sig_key *key;
> > +
> > +	key =3D tcp_md5_do_lookup_exact(sk, addr, family, prefixlen);
> > +	if (!key)
> > +		return -ENOENT;
> > +	hlist_del_rcu(&key->node);
> > +	atomic_sub(sizeof(*key), &sk->sk_omem_alloc);
> > +	kfree_rcu(key, rcu);
> > +	return 0;
> > +}
> > +
> > +static int tcp_md5_hash_key(struct tcp_md5sig_pool *hp,
> > +			    const struct tcp_md5sig_key *key)
> > +{
> > +	struct scatterlist sg;
> > +
> > +	sg_init_one(&sg, key->key, key->keylen);
> > +	ahash_request_set_crypt(hp->md5_req, &sg, NULL, key->keylen);
> > +	return crypto_ahash_update(hp->md5_req);
> > +}
> > +
> > +static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
> > +				 char __user *optval, int optlen)
> > +{
> > +	struct tcp_md5sig cmd;
> > +	struct sockaddr_in *sin =3D (struct sockaddr_in *)&cmd.tcpm_addr;
> > +	u8 prefixlen =3D 32;
> > +
> > +	if (optlen < sizeof(cmd))
> > +		return -EINVAL;
> > +
> > +	if (copy_from_user(&cmd, optval, sizeof(cmd)))
> > +		return -EFAULT;
> > +
> > +	if (sin->sin_family !=3D AF_INET)
> > +		return -EINVAL;
> > +
> > +	if (optname =3D=3D TCP_MD5SIG_EXT &&
> > +	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_PREFIX) {
> > +		prefixlen =3D cmd.tcpm_prefixlen;
> > +		if (prefixlen > 32)
> > +			return -EINVAL;
> > +	}
> > +
> > +	if (!cmd.tcpm_keylen)
> > +		return tcp_md5_do_del(sk, (union tcp_md5_addr *)&sin->sin_addr.s_add=
r,
> > +				      AF_INET, prefixlen);
> > +
> > +	if (cmd.tcpm_keylen > TCP_MD5SIG_MAXKEYLEN)
> > +		return -EINVAL;
> > +
> > +	return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin->sin_addr.s_addr,
> > +			      AF_INET, prefixlen, cmd.tcpm_key, cmd.tcpm_keylen,
> > +			      GFP_KERNEL);
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
> > +				 char __user *optval, int optlen)
> > +{
> > +	struct tcp_md5sig cmd;
> > +	struct sockaddr_in6 *sin6 =3D (struct sockaddr_in6 *)&cmd.tcpm_addr;
> > +	u8 prefixlen;
> > +
> > +	if (optlen < sizeof(cmd))
> > +		return -EINVAL;
> > +
> > +	if (copy_from_user(&cmd, optval, sizeof(cmd)))
> > +		return -EFAULT;
> > +
> > +	if (sin6->sin6_family !=3D AF_INET6)
> > +		return -EINVAL;
> > +
> > +	if (optname =3D=3D TCP_MD5SIG_EXT &&
> > +	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_PREFIX) {
> > +		prefixlen =3D cmd.tcpm_prefixlen;
> > +		if (prefixlen > 128 || (ipv6_addr_v4mapped(&sin6->sin6_addr) &&
> > +					prefixlen > 32))
> > +			return -EINVAL;
> > +	} else {
> > +		prefixlen =3D ipv6_addr_v4mapped(&sin6->sin6_addr) ? 32 : 128;
> > +	}
> > +
> > +	if (!cmd.tcpm_keylen) {
> > +		if (ipv6_addr_v4mapped(&sin6->sin6_addr))
> > +			return tcp_md5_do_del(sk, (union tcp_md5_addr *)&sin6->sin6_addr.s6=
_addr32[3],
> > +					      AF_INET, prefixlen);
> > +		return tcp_md5_do_del(sk, (union tcp_md5_addr *)&sin6->sin6_addr,
> > +				      AF_INET6, prefixlen);
> > +	}
> > +
> > +	if (cmd.tcpm_keylen > TCP_MD5SIG_MAXKEYLEN)
> > +		return -EINVAL;
> > +
> > +	if (ipv6_addr_v4mapped(&sin6->sin6_addr))
> > +		return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin6->sin6_addr.s6_=
addr32[3],
> > +				      AF_INET, prefixlen, cmd.tcpm_key,
> > +				      cmd.tcpm_keylen, GFP_KERNEL);
> > +
> > +	return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin6->sin6_addr,
> > +			      AF_INET6, prefixlen, cmd.tcpm_key,
> > +			      cmd.tcpm_keylen, GFP_KERNEL);
> > +}
> > +#endif
> > +
> > +static int tcp_v4_md5_hash_headers(struct tcp_md5sig_pool *hp,
> > +				   __be32 daddr, __be32 saddr,
> > +				   const struct tcphdr *th, int nbytes)
> > +{
> > +	struct tcp4_pseudohdr *bp;
> > +	struct scatterlist sg;
> > +	struct tcphdr *_th;
> > +
> > +	bp =3D hp->scratch;
> > +	bp->saddr =3D saddr;
> > +	bp->daddr =3D daddr;
> > +	bp->pad =3D 0;
> > +	bp->protocol =3D IPPROTO_TCP;
> > +	bp->len =3D cpu_to_be16(nbytes);
> > +
> > +	_th =3D (struct tcphdr *)(bp + 1);
> > +	memcpy(_th, th, sizeof(*th));
> > +	_th->check =3D 0;
> > +
> > +	sg_init_one(&sg, bp, sizeof(*bp) + sizeof(*th));
> > +	ahash_request_set_crypt(hp->md5_req, &sg, NULL,
> > +				sizeof(*bp) + sizeof(*th));
> > +	return crypto_ahash_update(hp->md5_req);
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +static int tcp_v6_md5_hash_headers(struct tcp_md5sig_pool *hp,
> > +				   const struct in6_addr *daddr,
> > +				   const struct in6_addr *saddr,
> > +				   const struct tcphdr *th, int nbytes)
> > +{
> > +	struct tcp6_pseudohdr *bp;
> > +	struct scatterlist sg;
> > +	struct tcphdr *_th;
> > +
> > +	bp =3D hp->scratch;
> > +	/* 1. TCP pseudo-header (RFC2460) */
> > +	bp->saddr =3D *saddr;
> > +	bp->daddr =3D *daddr;
> > +	bp->protocol =3D cpu_to_be32(IPPROTO_TCP);
> > +	bp->len =3D cpu_to_be32(nbytes);
> > +
> > +	_th =3D (struct tcphdr *)(bp + 1);
> > +	memcpy(_th, th, sizeof(*th));
> > +	_th->check =3D 0;
> > +
> > +	sg_init_one(&sg, bp, sizeof(*bp) + sizeof(*th));
> > +	ahash_request_set_crypt(hp->md5_req, &sg, NULL,
> > +				sizeof(*bp) + sizeof(*th));
> > +	return crypto_ahash_update(hp->md5_req);
> > +}
> > +#endif
> > +
> > +static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig=
_key *key,
> > +			       __be32 daddr, __be32 saddr,
> > +			       const struct tcphdr *th)
> > +{
> > +	struct tcp_md5sig_pool *hp;
> > +	struct ahash_request *req;
> > +
> > +	hp =3D tcp_get_md5sig_pool();
> > +	if (!hp)
> > +		goto clear_hash_noput;
> > +	req =3D hp->md5_req;
> > +
> > +	if (crypto_ahash_init(req))
> > +		goto clear_hash;
> > +	if (tcp_v4_md5_hash_headers(hp, daddr, saddr, th, th->doff << 2))
> > +		goto clear_hash;
> > +	if (tcp_md5_hash_key(hp, key))
> > +		goto clear_hash;
> > +	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> > +	if (crypto_ahash_final(req))
> > +		goto clear_hash;
> > +
> > +	tcp_put_md5sig_pool();
> > +	return 0;
> > +
> > +clear_hash:
> > +	tcp_put_md5sig_pool();
> > +clear_hash_noput:
> > +	memset(md5_hash, 0, 16);
> > +	return 1;
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +static int tcp_v6_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig=
_key *key,
> > +			       const struct in6_addr *daddr,
> > +			       struct in6_addr *saddr, const struct tcphdr *th)
> > +{
> > +	struct tcp_md5sig_pool *hp;
> > +	struct ahash_request *req;
> > +
> > +	hp =3D tcp_get_md5sig_pool();
> > +	if (!hp)
> > +		goto clear_hash_noput;
> > +	req =3D hp->md5_req;
> > +
> > +	if (crypto_ahash_init(req))
> > +		goto clear_hash;
> > +	if (tcp_v6_md5_hash_headers(hp, daddr, saddr, th, th->doff << 2))
> > +		goto clear_hash;
> > +	if (tcp_md5_hash_key(hp, key))
> > +		goto clear_hash;
> > +	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> > +	if (crypto_ahash_final(req))
> > +		goto clear_hash;
> > +
> > +	tcp_put_md5sig_pool();
> > +	return 0;
> > +
> > +clear_hash:
> > +	tcp_put_md5sig_pool();
> > +clear_hash_noput:
> > +	memset(md5_hash, 0, 16);
> > +	return 1;
> > +}
> > +#endif
> > +
> > +/* RFC2385 MD5 checksumming requires a mapping of
> > + * IP address->MD5 Key.
> > + * We need to maintain these in the sk structure.
> > + */
> > +
> > +/* Find the Key structure for an address.  */
> > +static struct tcp_md5sig_key *tcp_md5_do_lookup(const struct sock *sk,
> > +						const union tcp_md5_addr *addr,
> > +						int family)
> > +{
> > +	const struct tcp_sock *tp =3D tcp_sk(sk);
> > +	struct tcp_md5sig_key *key;
> > +	const struct tcp_md5sig_info *md5sig;
> > +	__be32 mask;
> > +	struct tcp_md5sig_key *best_match =3D NULL;
> > +	bool match;
> > +
> > +	/* caller either holds rcu_read_lock() or socket lock */
> > +	md5sig =3D rcu_dereference_check(tp->md5sig_info,
> > +				       lockdep_sock_is_held(sk));
> > +	if (!md5sig)
> > +		return NULL;
> > +
> > +	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
> > +		if (key->family !=3D family)
> > +			continue;
> > +
> > +		if (family =3D=3D AF_INET) {
> > +			mask =3D inet_make_mask(key->prefixlen);
> > +			match =3D (key->addr.a4.s_addr & mask) =3D=3D
> > +				(addr->a4.s_addr & mask);
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +		} else if (family =3D=3D AF_INET6) {
> > +			match =3D ipv6_prefix_equal(&key->addr.a6, &addr->a6,
> > +						  key->prefixlen);
> > +#endif
> > +		} else {
> > +			match =3D false;
> > +		}
> > +
> > +		if (match && (!best_match ||
> > +			      key->prefixlen > best_match->prefixlen))
> > +			best_match =3D key;
> > +	}
> > +	return best_match;
> > +}
> > +
> > +/* Parse MD5 Signature option */
> > +static const u8 *tcp_parse_md5sig_option(const struct tcphdr *th)
> > +{
> > +	int length =3D (th->doff << 2) - sizeof(*th);
> > +	const u8 *ptr =3D (const u8 *)(th + 1);
> > +
> > +	/* If the TCP option is too short, we can short cut */
> > +	if (length < TCPOLEN_MD5SIG)
> > +		return NULL;
> > +
> > +	while (length > 0) {
> > +		int opcode =3D *ptr++;
> > +		int opsize;
> > +
> > +		switch (opcode) {
> > +		case TCPOPT_EOL:
> > +			return NULL;
> > +		case TCPOPT_NOP:
> > +			length--;
> > +			continue;
> > +		default:
> > +			opsize =3D *ptr++;
> > +			if (opsize < 2 || opsize > length)
> > +				return NULL;
> > +			if (opcode =3D=3D TCPOPT_MD5SIG)
> > +				return opsize =3D=3D TCPOLEN_MD5SIG ? ptr : NULL;
> > +		}
> > +		ptr +=3D opsize - 2;
> > +		length -=3D opsize;
> > +	}
> > +	return NULL;
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +static struct tcp_md5sig_key *tcp_v6_md5_do_lookup(const struct sock *=
sk,
> > +						   const struct in6_addr *addr)
> > +{
> > +	return tcp_md5_do_lookup(sk, (union tcp_md5_addr *)addr, AF_INET6);
> > +}
> > +#endif
> > +
> > +static int tcp_md5_hash_skb_data(struct tcp_md5sig_pool *hp,
> > +				 const struct sk_buff *skb,
> > +				 unsigned int header_len)
> > +{
> > +	struct scatterlist sg;
> > +	const struct tcphdr *tp =3D tcp_hdr(skb);
> > +	struct ahash_request *req =3D hp->md5_req;
> > +	unsigned int i;
> > +	const unsigned int head_data_len =3D skb_headlen(skb) > header_len ?
> > +					   skb_headlen(skb) - header_len : 0;
> > +	const struct skb_shared_info *shi =3D skb_shinfo(skb);
> > +	struct sk_buff *frag_iter;
> > +
> > +	sg_init_table(&sg, 1);
> > +
> > +	sg_set_buf(&sg, ((u8 *)tp) + header_len, head_data_len);
> > +	ahash_request_set_crypt(req, &sg, NULL, head_data_len);
> > +	if (crypto_ahash_update(req))
> > +		return 1;
> > +
> > +	for (i =3D 0; i < shi->nr_frags; ++i) {
> > +		const struct skb_frag_struct *f =3D &shi->frags[i];
> > +		unsigned int offset =3D f->page_offset;
> > +		struct page *page =3D skb_frag_page(f) + (offset >> PAGE_SHIFT);
> > +
> > +		sg_set_page(&sg, page, skb_frag_size(f),
> > +			    offset_in_page(offset));
> > +		ahash_request_set_crypt(req, &sg, NULL, skb_frag_size(f));
> > +		if (crypto_ahash_update(req))
> > +			return 1;
> > +	}
> > +
> > +	skb_walk_frags(skb, frag_iter)
> > +		if (tcp_md5_hash_skb_data(hp, frag_iter, 0))
> > +			return 1;
> > +
> > +	return 0;
> > +}
> > +
> > +int tcp_v4_md5_send_response_prepare(struct sk_buff *skb, u8 flags,
> > +				     unsigned int remaining,
> > +				     struct tcp_out_options *opts,
> > +				     const struct sock *sk)
> > +{
> > +	const struct tcphdr *th =3D tcp_hdr(skb);
> > +	const struct iphdr *iph =3D ip_hdr(skb);
> > +	const __u8 *hash_location =3D NULL;
> > +
> > +	rcu_read_lock();
> > +	hash_location =3D tcp_parse_md5sig_option(th);
> > +	if (sk && sk_fullsock(sk)) {
> > +		opts->md5 =3D tcp_md5_do_lookup(sk,
> > +					      (union tcp_md5_addr *)&iph->daddr,
> > +					      AF_INET);
> > +	} else if (sk && sk->sk_state =3D=3D TCP_TIME_WAIT) {
> > +		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
> > +
> > +		opts->md5 =3D tcp_twsk_md5_key(tcptw);
> > +	} else if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
> > +		opts->md5 =3D tcp_md5_do_lookup(sk,
> > +					      (union tcp_md5_addr *)&iph->daddr,
> > +					      AF_INET);
> > +	} else if (hash_location) {
> > +		unsigned char newhash[16];
> > +		struct sock *sk1;
> > +		int genhash;
> > +
> > +		/* active side is lost. Try to find listening socket through
> > +		 * source port, and then find md5 key through listening socket.
> > +		 * we are not loose security here:
> > +		 * Incoming packet is checked with md5 hash with finding key,
> > +		 * no RST generated if md5 hash doesn't match.
> > +		 */
> > +		sk1 =3D __inet_lookup_listener(dev_net(skb_dst(skb)->dev),
> > +					     &tcp_hashinfo, NULL, 0,
> > +					     iph->saddr,
> > +					     th->source, iph->daddr,
> > +					     ntohs(th->source), inet_iif(skb),
> > +					     tcp_v4_sdif(skb));
> > +		/* don't send rst if it can't find key */
> > +		if (!sk1)
> > +			goto out_err;
> > +
> > +		opts->md5 =3D tcp_md5_do_lookup(sk1, (union tcp_md5_addr *)
> > +					      &iph->saddr, AF_INET);
> > +		if (!opts->md5)
> > +			goto out_err;
> > +
> > +		genhash =3D tcp_v4_md5_hash_skb(newhash, opts->md5, NULL, skb);
> > +		if (genhash || memcmp(hash_location, newhash, 16) !=3D 0)
> > +			goto out_err;
> > +	}
> > +
> > +	if (opts->md5)
> > +		return TCPOLEN_MD5SIG_ALIGNED;
> > +
> > +	rcu_read_unlock();
> > +	return 0;
> > +
> > +out_err:
> > +	rcu_read_unlock();
> > +	return -1;
> > +}
> > +
> > +
> > +void tcp_v4_md5_send_response_write(__be32 *topt, struct sk_buff *skb,
> > +				    struct tcphdr *t1,
> > +				    struct tcp_out_options *opts,
> > +				    const struct sock *sk)
> > +{
> > +
> > +	if (opts->md5) {
> > +		*topt++ =3D htonl((TCPOPT_NOP << 24) |
> > +			        (TCPOPT_NOP << 16) |
> > +			        (TCPOPT_MD5SIG << 8) |
> > +			        TCPOLEN_MD5SIG);
> > +
> > +		tcp_v4_md5_hash_hdr((__u8 *)topt, opts->md5,
> > +				    ip_hdr(skb)->saddr,
> > +				    ip_hdr(skb)->daddr, t1);
> > +	}
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +int tcp_v6_md5_send_response_prepare(struct sk_buff *skb, u8 flags,
> > +				     unsigned int remaining,
> > +				     struct tcp_out_options *opts,
> > +				     const struct sock *sk)
> > +{
> > +	const struct tcphdr *th =3D tcp_hdr(skb);
> > +	struct ipv6hdr *ipv6h =3D ipv6_hdr(skb);
> > +	const __u8 *hash_location =3D NULL;
> > +
> > +	rcu_read_lock();
> > +	hash_location =3D tcp_parse_md5sig_option(th);
> > +	if (sk && sk_fullsock(sk)) {
> > +		opts->md5 =3D tcp_v6_md5_do_lookup(sk, &ipv6h->saddr);
> > +	} else if (sk && sk->sk_state =3D=3D TCP_TIME_WAIT) {
> > +		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
> > +
> > +		opts->md5 =3D tcp_twsk_md5_key(tcptw);
> > +	} else if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
> > +		opts->md5 =3D tcp_v6_md5_do_lookup(sk, &ipv6h->daddr);
> > +	} else if (hash_location) {
> > +		unsigned char newhash[16];
> > +		struct sock *sk1;
> > +		int genhash;
> > +
> > +		/* active side is lost. Try to find listening socket through
> > +		 * source port, and then find md5 key through listening socket.
> > +		 * we are not loose security here:
> > +		 * Incoming packet is checked with md5 hash with finding key,
> > +		 * no RST generated if md5 hash doesn't match.
> > +		 */
> > +		sk1 =3D inet6_lookup_listener(dev_net(skb_dst(skb)->dev),
> > +					    &tcp_hashinfo, NULL, 0,
> > +					    &ipv6h->saddr,
> > +					    th->source, &ipv6h->daddr,
> > +					    ntohs(th->source), tcp_v6_iif(skb),
> > +					    tcp_v6_sdif(skb));
> > +		if (!sk1)
> > +			goto out_err;
> > +
> > +		opts->md5 =3D tcp_v6_md5_do_lookup(sk1, &ipv6h->saddr);
> > +		if (!opts->md5)
> > +			goto out_err;
> > +
> > +		genhash =3D tcp_v6_md5_hash_skb(newhash, opts->md5, NULL, skb);
> > +		if (genhash || memcmp(hash_location, newhash, 16) !=3D 0)
> > +			goto out_err;
> > +	}
> > +
> > +	if (opts->md5)
> > +		return TCPOLEN_MD5SIG_ALIGNED;
> > +
> > +	rcu_read_unlock();
> > +	return 0;
> > +
> > +out_err:
> > +	rcu_read_unlock();
> > +	return -1;
> > +}
> > +EXPORT_SYMBOL_GPL(tcp_v6_md5_send_response_prepare);
> > +
> > +void tcp_v6_md5_send_response_write(__be32 *topt, struct sk_buff *skb,
> > +				    struct tcphdr *t1,
> > +				    struct tcp_out_options *opts,
> > +				    const struct sock *sk)
> > +{
> > +	if (opts->md5) {
> > +		*topt++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
> > +				(TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
> > +		tcp_v6_md5_hash_hdr((__u8 *)topt, opts->md5,
> > +				    &ipv6_hdr(skb)->saddr,
> > +				    &ipv6_hdr(skb)->daddr, t1);
> > +
> > +
> > +		rcu_read_unlock();
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(tcp_v6_md5_send_response_write);
> > +#endif
> > +
> > +struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
> > +					 const struct sock *addr_sk)
> > +{
> > +	const union tcp_md5_addr *addr;
> > +
> > +	addr =3D (const union tcp_md5_addr *)&addr_sk->sk_daddr;
> > +	return tcp_md5_do_lookup(sk, addr, AF_INET);
> > +}
> > +EXPORT_SYMBOL(tcp_v4_md5_lookup);
> > +
> > +int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *k=
ey,
> > +			const struct sock *sk,
> > +			const struct sk_buff *skb)
> > +{
> > +	struct tcp_md5sig_pool *hp;
> > +	struct ahash_request *req;
> > +	const struct tcphdr *th =3D tcp_hdr(skb);
> > +	__be32 saddr, daddr;
> > +
> > +	if (sk) { /* valid for establish/request sockets */
> > +		saddr =3D sk->sk_rcv_saddr;
> > +		daddr =3D sk->sk_daddr;
> > +	} else {
> > +		const struct iphdr *iph =3D ip_hdr(skb);
> > +
> > +		saddr =3D iph->saddr;
> > +		daddr =3D iph->daddr;
> > +	}
> > +
> > +	hp =3D tcp_get_md5sig_pool();
> > +	if (!hp)
> > +		goto clear_hash_noput;
> > +	req =3D hp->md5_req;
> > +
> > +	if (crypto_ahash_init(req))
> > +		goto clear_hash;
> > +
> > +	if (tcp_v4_md5_hash_headers(hp, daddr, saddr, th, skb->len))
> > +		goto clear_hash;
> > +	if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
> > +		goto clear_hash;
> > +	if (tcp_md5_hash_key(hp, key))
> > +		goto clear_hash;
> > +	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> > +	if (crypto_ahash_final(req))
> > +		goto clear_hash;
> > +
> > +	tcp_put_md5sig_pool();
> > +	return 0;
> > +
> > +clear_hash:
> > +	tcp_put_md5sig_pool();
> > +clear_hash_noput:
> > +	memset(md5_hash, 0, 16);
> > +	return 1;
> > +}
> > +EXPORT_SYMBOL(tcp_v4_md5_hash_skb);
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +int tcp_v6_md5_hash_skb(char *md5_hash,
> > +			const struct tcp_md5sig_key *key,
> > +			const struct sock *sk,
> > +			const struct sk_buff *skb)
> > +{
> > +	const struct in6_addr *saddr, *daddr;
> > +	struct tcp_md5sig_pool *hp;
> > +	struct ahash_request *req;
> > +	const struct tcphdr *th =3D tcp_hdr(skb);
> > +
> > +	if (sk) { /* valid for establish/request sockets */
> > +		saddr =3D &sk->sk_v6_rcv_saddr;
> > +		daddr =3D &sk->sk_v6_daddr;
> > +	} else {
> > +		const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
> > +
> > +		saddr =3D &ip6h->saddr;
> > +		daddr =3D &ip6h->daddr;
> > +	}
> > +
> > +	hp =3D tcp_get_md5sig_pool();
> > +	if (!hp)
> > +		goto clear_hash_noput;
> > +	req =3D hp->md5_req;
> > +
> > +	if (crypto_ahash_init(req))
> > +		goto clear_hash;
> > +
> > +	if (tcp_v6_md5_hash_headers(hp, daddr, saddr, th, skb->len))
> > +		goto clear_hash;
> > +	if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
> > +		goto clear_hash;
> > +	if (tcp_md5_hash_key(hp, key))
> > +		goto clear_hash;
> > +	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> > +	if (crypto_ahash_final(req))
> > +		goto clear_hash;
> > +
> > +	tcp_put_md5sig_pool();
> > +	return 0;
> > +
> > +clear_hash:
> > +	tcp_put_md5sig_pool();
> > +clear_hash_noput:
> > +	memset(md5_hash, 0, 16);
> > +	return 1;
> > +}
> > +EXPORT_SYMBOL_GPL(tcp_v6_md5_hash_skb);
> > +#endif
> > +
> > +/* Called with rcu_read_lock() */
> > +bool tcp_v4_inbound_md5_hash(const struct sock *sk,
> > +			     const struct sk_buff *skb)
> > +{
> > +	/* This gets called for each TCP segment that arrives
> > +	 * so we want to be efficient.
> > +	 * We have 3 drop cases:
> > +	 * o No MD5 hash and one expected.
> > +	 * o MD5 hash and we're not expecting one.
> > +	 * o MD5 hash and its wrong.
> > +	 */
> > +	const __u8 *hash_location =3D NULL;
> > +	struct tcp_md5sig_key *hash_expected;
> > +	const struct iphdr *iph =3D ip_hdr(skb);
> > +	const struct tcphdr *th =3D tcp_hdr(skb);
> > +	int genhash;
> > +	unsigned char newhash[16];
> > +
> > +	hash_expected =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&iph->s=
addr,
> > +					  AF_INET);
> > +	hash_location =3D tcp_parse_md5sig_option(th);
> > +
> > +	/* We've parsed the options - do we have a hash? */
> > +	if (!hash_expected && !hash_location)
> > +		return false;
> > +
> > +	if (hash_expected && !hash_location) {
> > +		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
> > +		return true;
> > +	}
> > +
> > +	if (!hash_expected && hash_location) {
> > +		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
> > +		return true;
> > +	}
> > +
> > +	/* Okay, so this is hash_expected and hash_location -
> > +	 * so we need to calculate the checksum.
> > +	 */
> > +	genhash =3D tcp_v4_md5_hash_skb(newhash,
> > +				      hash_expected,
> > +				      NULL, skb);
> > +
> > +	if (genhash || memcmp(hash_location, newhash, 16) !=3D 0) {
> > +		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
> > +		net_info_ratelimited("MD5 Hash failed for (%pI4, %d)->(%pI4, %d)%s\n=
",
> > +				     &iph->saddr, ntohs(th->source),
> > +				     &iph->daddr, ntohs(th->dest),
> > +				     genhash ? " tcp_v4_calc_md5_hash failed"
> > +				     : "");
> > +		return true;
> > +	}
> > +	return false;
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +bool tcp_v6_inbound_md5_hash(const struct sock *sk,
> > +			     const struct sk_buff *skb)
> > +{
> > +	const __u8 *hash_location =3D NULL;
> > +	struct tcp_md5sig_key *hash_expected;
> > +	const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
> > +	const struct tcphdr *th =3D tcp_hdr(skb);
> > +	int genhash;
> > +	u8 newhash[16];
> > +
> > +	hash_expected =3D tcp_v6_md5_do_lookup(sk, &ip6h->saddr);
> > +	hash_location =3D tcp_parse_md5sig_option(th);
> > +
> > +	/* We've parsed the options - do we have a hash? */
> > +	if (!hash_expected && !hash_location)
> > +		return false;
> > +
> > +	if (hash_expected && !hash_location) {
> > +		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
> > +		return true;
> > +	}
> > +
> > +	if (!hash_expected && hash_location) {
> > +		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
> > +		return true;
> > +	}
> > +
> > +	/* check the signature */
> > +	genhash =3D tcp_v6_md5_hash_skb(newhash,
> > +				      hash_expected,
> > +				      NULL, skb);
> > +
> > +	if (genhash || memcmp(hash_location, newhash, 16) !=3D 0) {
> > +		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
> > +		net_info_ratelimited("MD5 Hash %s for [%pI6c]:%u->[%pI6c]:%u\n",
> > +				     genhash ? "failed" : "mismatch",
> > +				     &ip6h->saddr, ntohs(th->source),
> > +				     &ip6h->daddr, ntohs(th->dest));
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +EXPORT_SYMBOL_GPL(tcp_v6_inbound_md5_hash);
> > +#endif
> > +
> > +void tcp_v4_md5_destroy_sock(struct sock *sk)
> > +{
> > +	struct tcp_sock *tp =3D tcp_sk(sk);
> > +
> > +	/* Clean up the MD5 key list, if any */
> > +	if (tp->md5sig_info) {
> > +		tcp_clear_md5_list(sk);
> > +		kfree_rcu(tp->md5sig_info, rcu);
> > +		tp->md5sig_info =3D NULL;
> > +	}
> > +}
> > +
> > +void tcp_v4_md5_syn_recv_sock(const struct sock *listener, struct sock=
 *sk)
> > +{
> > +	struct inet_sock *inet =3D inet_sk(sk);
> > +	struct tcp_md5sig_key *key;
> > +
> > +	/* Copy over the MD5 key from the original socket */
> > +	key =3D tcp_md5_do_lookup(listener, (union tcp_md5_addr *)&inet->inet=
_daddr,
> > +				AF_INET);
> > +	if (key) {
> > +		/* We're using one, so create a matching key
> > +		 * on the sk structure. If we fail to get
> > +		 * memory, then we end up not copying the key
> > +		 * across. Shucks.
> > +		 */
> > +		tcp_md5_do_add(sk, (union tcp_md5_addr *)&inet->inet_daddr,
> > +			       AF_INET, 32, key->key, key->keylen, GFP_ATOMIC);
> > +		sk_nocaps_add(sk, NETIF_F_GSO_MASK);
> > +	}
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +void tcp_v6_md5_syn_recv_sock(const struct sock *listener, struct sock=
 *sk)
> > +{
> > +	struct tcp_md5sig_key *key;
> > +
> > +	/* Copy over the MD5 key from the original socket */
> > +	key =3D tcp_v6_md5_do_lookup(listener, &sk->sk_v6_daddr);
> > +	if (key) {
> > +		/* We're using one, so create a matching key
> > +		 * on the newsk structure. If we fail to get
> > +		 * memory, then we end up not copying the key
> > +		 * across. Shucks.
> > +		 */
> > +		tcp_md5_do_add(sk, (union tcp_md5_addr *)&sk->sk_v6_daddr,
> > +			       AF_INET6, 128, key->key, key->keylen,
> > +			       sk_gfp_mask(sk, GFP_ATOMIC));
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(tcp_v6_md5_syn_recv_sock);
> > +
> > +struct tcp_md5sig_key *tcp_v6_md5_lookup(const struct sock *sk,
> > +					 const struct sock *addr_sk)
> > +{
> > +	return tcp_v6_md5_do_lookup(sk, &addr_sk->sk_v6_daddr);
> > +}
> > +EXPORT_SYMBOL_GPL(tcp_v6_md5_lookup);
> > +#endif
> > +
> > +void tcp_md5_time_wait(struct sock *sk, struct inet_timewait_sock *tw)
> > +{
> > +	struct tcp_timewait_sock *tcptw =3D tcp_twsk((struct sock *)tw);
> > +	struct tcp_sock *tp =3D tcp_sk(sk);
> > +	struct tcp_md5sig_key *key;
> > +
> > +	/* The timewait bucket does not have the key DB from the
> > +	 * sock structure. We just make a quick copy of the
> > +	 * md5 key being used (if indeed we are using one)
> > +	 * so the timewait ack generating code has the key.
> > +	 */
> > +	tcptw->tw_md5_key =3D NULL;
> > +	key =3D tp->af_specific->md5_lookup(sk, sk);
> > +	if (key) {
> > +		tcptw->tw_md5_key =3D kmemdup(key, sizeof(*key), GFP_ATOMIC);
> > +		BUG_ON(tcptw->tw_md5_key && !tcp_alloc_md5sig_pool());
> > +	}
> > +}
> > +
> > +static void tcp_diag_md5sig_fill(struct tcp_diag_md5sig *info,
> > +				 const struct tcp_md5sig_key *key)
> > +{
> > +	info->tcpm_family =3D key->family;
> > +	info->tcpm_prefixlen =3D key->prefixlen;
> > +	info->tcpm_keylen =3D key->keylen;
> > +	memcpy(info->tcpm_key, key->key, key->keylen);
> > +
> > +	if (key->family =3D=3D AF_INET)
> > +		info->tcpm_addr[0] =3D key->addr.a4.s_addr;
> > +	#if IS_ENABLED(CONFIG_IPV6)
> > +	else if (key->family =3D=3D AF_INET6)
> > +		memcpy(&info->tcpm_addr, &key->addr.a6,
> > +		       sizeof(info->tcpm_addr));
> > +	#endif
> > +}
> > +
> > +static int tcp_diag_put_md5sig(struct sk_buff *skb,
> > +			       const struct tcp_md5sig_info *md5sig)
> > +{
> > +	const struct tcp_md5sig_key *key;
> > +	struct tcp_diag_md5sig *info;
> > +	struct nlattr *attr;
> > +	int md5sig_count =3D 0;
> > +
> > +	hlist_for_each_entry_rcu(key, &md5sig->head, node)
> > +		md5sig_count++;
> > +	if (md5sig_count =3D=3D 0)
> > +		return 0;
> > +
> > +	attr =3D nla_reserve(skb, INET_DIAG_MD5SIG,
> > +			   md5sig_count * sizeof(struct tcp_diag_md5sig));
> > +	if (!attr)
> > +		return -EMSGSIZE;
> > +
> > +	info =3D nla_data(attr);
> > +	memset(info, 0, md5sig_count * sizeof(struct tcp_diag_md5sig));
> > +	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
> > +		tcp_diag_md5sig_fill(info++, key);
> > +		if (--md5sig_count =3D=3D 0)
> > +			break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int tcp_md5_diag_get_aux(struct sock *sk, bool net_admin, struct sk_bu=
ff *skb)
> > +{
> > +	if (net_admin) {
> > +		struct tcp_md5sig_info *md5sig;
> > +		int err =3D 0;
> > +
> > +		rcu_read_lock();
> > +		md5sig =3D rcu_dereference(tcp_sk(sk)->md5sig_info);
> > +		if (md5sig)
> > +			err =3D tcp_diag_put_md5sig(skb, md5sig);
> > +		rcu_read_unlock();
> > +		if (err < 0)
> > +			return err;
> > +	}
> > +
> > +	return 0;
> > +}
> =

> Needs EXPORT_SYMBOL_GPL
> =

> > +
> > +int tcp_md5_diag_get_aux_size(struct sock *sk, bool net_admin)
> > +{
> > +	int size =3D 0;
> > +
> > +	if (net_admin && sk_fullsock(sk)) {
> > +		const struct tcp_md5sig_info *md5sig;
> > +		const struct tcp_md5sig_key *key;
> > +		size_t md5sig_count =3D 0;
> > +
> > +		rcu_read_lock();
> > +		md5sig =3D rcu_dereference(tcp_sk(sk)->md5sig_info);
> > +		if (md5sig) {
> > +			hlist_for_each_entry_rcu(key, &md5sig->head, node)
> > +				md5sig_count++;
> > +		}
> > +		rcu_read_unlock();
> > +		size +=3D nla_total_size(md5sig_count *
> > +				       sizeof(struct tcp_diag_md5sig));
> > +	}
> > +
> > +	return size;
> > +}
> =

> Also needs EXPORT_SYMBOL_GPL

Thanks, I'm adding this.


Christoph

> =

> =

> Mat
> =

> > +
> > +const struct tcp_sock_af_ops tcp_sock_ipv4_specific =3D {
> > +	.md5_lookup	=3D tcp_v4_md5_lookup,
> > +	.calc_md5_hash	=3D tcp_v4_md5_hash_skb,
> > +	.md5_parse	=3D tcp_v4_parse_md5_keys,
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +const struct tcp_sock_af_ops tcp_sock_ipv6_specific =3D {
> > +	.md5_lookup	=3D	tcp_v6_md5_lookup,
> > +	.calc_md5_hash	=3D	tcp_v6_md5_hash_skb,
> > +	.md5_parse	=3D	tcp_v6_parse_md5_keys,
> > +};
> > +EXPORT_SYMBOL_GPL(tcp_sock_ipv6_specific);
> > +
> > +const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific =3D {
> > +	.md5_lookup	=3D	tcp_v4_md5_lookup,
> > +	.calc_md5_hash	=3D	tcp_v4_md5_hash_skb,
> > +	.md5_parse	=3D	tcp_v6_parse_md5_keys,
> > +};
> > +EXPORT_SYMBOL_GPL(tcp_sock_ipv6_mapped_specific);
> > +#endif
> > +
> > +
> > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > index 641dca38cc1e..e9e925d51046 100644
> > --- a/net/ipv4/tcp_minisocks.c
> > +++ b/net/ipv4/tcp_minisocks.c
> > @@ -22,6 +22,7 @@
> > #include <linux/module.h>
> > #include <linux/slab.h>
> > #include <linux/sysctl.h>
> > +#include <linux/tcp_md5.h>
> > #include <linux/workqueue.h>
> > #include <linux/static_key.h>
> > #include <net/tcp.h>
> > @@ -296,21 +297,7 @@ void tcp_time_wait(struct sock *sk, int state, int=
 timeo)
> > 			INIT_LIST_HEAD(&tcp_sk(sk)->tcp_option_list);
> > 		}
> > #ifdef CONFIG_TCP_MD5SIG
> > -		/*
> > -		 * The timewait bucket does not have the key DB from the
> > -		 * sock structure. We just make a quick copy of the
> > -		 * md5 key being used (if indeed we are using one)
> > -		 * so the timewait ack generating code has the key.
> > -		 */
> > -		do {
> > -			struct tcp_md5sig_key *key;
> > -			tcptw->tw_md5_key =3D NULL;
> > -			key =3D tp->af_specific->md5_lookup(sk, sk);
> > -			if (key) {
> > -				tcptw->tw_md5_key =3D kmemdup(key, sizeof(*key), GFP_ATOMIC);
> > -				BUG_ON(tcptw->tw_md5_key && !tcp_alloc_md5sig_pool());
> > -			}
> > -		} while (0);
> > +		tcp_md5_time_wait(sk, tw);
> > #endif
> > =

> > 		/* Get the TIME_WAIT timeout firing. */
> > @@ -340,10 +327,7 @@ void tcp_time_wait(struct sock *sk, int state, int=
 timeo)
> > void tcp_twsk_destructor(struct sock *sk)
> > {
> > #ifdef CONFIG_TCP_MD5SIG
> > -	struct tcp_timewait_sock *twsk =3D tcp_twsk(sk);
> > -
> > -	if (twsk->tw_md5_key)
> > -		kfree_rcu(twsk->tw_md5_key, rcu);
> > +	tcp_md5_twsk_destructor(sk);
> > #endif
> > =

> > 	if (static_branch_unlikely(&tcp_extra_options_enabled))
> > @@ -531,9 +515,7 @@ struct sock *tcp_create_openreq_child(const struct =
sock *sk,
> > 		}
> > 		newtp->tsoffset =3D treq->ts_off;
> > #ifdef CONFIG_TCP_MD5SIG
> > -		newtp->md5sig_info =3D NULL;	/*XXX*/
> > -		if (newtp->af_specific->md5_lookup(sk, newsk))
> > -			newtp->tcp_header_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> > +		tcp_md5_add_header_len(sk, newsk);
> > #endif
> > 		if (static_branch_unlikely(&tcp_extra_options_enabled))
> > 			newtp->tcp_header_len +=3D tcp_extra_options_add_header(sk, newsk);
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index a7de79294ee6..1c040c44fbf4 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -42,6 +42,7 @@
> > #include <linux/gfp.h>
> > #include <linux/module.h>
> > #include <linux/static_key.h>
> > +#include <linux/tcp_md5.h>
> > =

> > #include <trace/events/tcp.h>
> > =

> > @@ -3245,8 +3246,7 @@ static void tcp_connect_init(struct sock *sk)
> > 		tp->tcp_header_len +=3D TCPOLEN_TSTAMP_ALIGNED;
> > =

> > #ifdef CONFIG_TCP_MD5SIG
> > -	if (tp->af_specific->md5_lookup(sk, sk))
> > -		tp->tcp_header_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> > +	tcp_md5_add_header_len(sk, sk);
> > #endif
> > =

> > 	if (static_branch_unlikely(&tcp_extra_options_enabled))
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index 2fb688a36731..0d3506309bd4 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -43,6 +43,7 @@
> > #include <linux/ipv6.h>
> > #include <linux/icmpv6.h>
> > #include <linux/random.h>
> > +#include <linux/tcp_md5.h>
> > =

> > #include <net/tcp.h>
> > #include <net/ndisc.h>
> > @@ -79,16 +80,6 @@ static int	tcp_v6_do_rcv(struct sock *sk, struct sk_=
buff *skb);
> > =

> > static const struct inet_connection_sock_af_ops ipv6_mapped;
> > static const struct inet_connection_sock_af_ops ipv6_specific;
> > -#ifdef CONFIG_TCP_MD5SIG
> > -static const struct tcp_sock_af_ops tcp_sock_ipv6_specific;
> > -static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
> > -#else
> > -static struct tcp_md5sig_key *tcp_v6_md5_do_lookup(const struct sock *=
sk,
> > -						   const struct in6_addr *addr)
> > -{
> > -	return NULL;
> > -}
> > -#endif
> > =

> > static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *=
skb)
> > {
> > @@ -507,218 +498,6 @@ static void tcp_v6_reqsk_destructor(struct reques=
t_sock *req)
> > 	kfree_skb(inet_rsk(req)->pktopts);
> > }
> > =

> > -#ifdef CONFIG_TCP_MD5SIG
> > -static struct tcp_md5sig_key *tcp_v6_md5_do_lookup(const struct sock *=
sk,
> > -						   const struct in6_addr *addr)
> > -{
> > -	return tcp_md5_do_lookup(sk, (union tcp_md5_addr *)addr, AF_INET6);
> > -}
> > -
> > -static struct tcp_md5sig_key *tcp_v6_md5_lookup(const struct sock *sk,
> > -						const struct sock *addr_sk)
> > -{
> > -	return tcp_v6_md5_do_lookup(sk, &addr_sk->sk_v6_daddr);
> > -}
> > -
> > -static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
> > -				 char __user *optval, int optlen)
> > -{
> > -	struct tcp_md5sig cmd;
> > -	struct sockaddr_in6 *sin6 =3D (struct sockaddr_in6 *)&cmd.tcpm_addr;
> > -	u8 prefixlen;
> > -
> > -	if (optlen < sizeof(cmd))
> > -		return -EINVAL;
> > -
> > -	if (copy_from_user(&cmd, optval, sizeof(cmd)))
> > -		return -EFAULT;
> > -
> > -	if (sin6->sin6_family !=3D AF_INET6)
> > -		return -EINVAL;
> > -
> > -	if (optname =3D=3D TCP_MD5SIG_EXT &&
> > -	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_PREFIX) {
> > -		prefixlen =3D cmd.tcpm_prefixlen;
> > -		if (prefixlen > 128 || (ipv6_addr_v4mapped(&sin6->sin6_addr) &&
> > -					prefixlen > 32))
> > -			return -EINVAL;
> > -	} else {
> > -		prefixlen =3D ipv6_addr_v4mapped(&sin6->sin6_addr) ? 32 : 128;
> > -	}
> > -
> > -	if (!cmd.tcpm_keylen) {
> > -		if (ipv6_addr_v4mapped(&sin6->sin6_addr))
> > -			return tcp_md5_do_del(sk, (union tcp_md5_addr *)&sin6->sin6_addr.s6=
_addr32[3],
> > -					      AF_INET, prefixlen);
> > -		return tcp_md5_do_del(sk, (union tcp_md5_addr *)&sin6->sin6_addr,
> > -				      AF_INET6, prefixlen);
> > -	}
> > -
> > -	if (cmd.tcpm_keylen > TCP_MD5SIG_MAXKEYLEN)
> > -		return -EINVAL;
> > -
> > -	if (ipv6_addr_v4mapped(&sin6->sin6_addr))
> > -		return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin6->sin6_addr.s6_=
addr32[3],
> > -				      AF_INET, prefixlen, cmd.tcpm_key,
> > -				      cmd.tcpm_keylen, GFP_KERNEL);
> > -
> > -	return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin6->sin6_addr,
> > -			      AF_INET6, prefixlen, cmd.tcpm_key,
> > -			      cmd.tcpm_keylen, GFP_KERNEL);
> > -}
> > -
> > -static int tcp_v6_md5_hash_headers(struct tcp_md5sig_pool *hp,
> > -				   const struct in6_addr *daddr,
> > -				   const struct in6_addr *saddr,
> > -				   const struct tcphdr *th, int nbytes)
> > -{
> > -	struct tcp6_pseudohdr *bp;
> > -	struct scatterlist sg;
> > -	struct tcphdr *_th;
> > -
> > -	bp =3D hp->scratch;
> > -	/* 1. TCP pseudo-header (RFC2460) */
> > -	bp->saddr =3D *saddr;
> > -	bp->daddr =3D *daddr;
> > -	bp->protocol =3D cpu_to_be32(IPPROTO_TCP);
> > -	bp->len =3D cpu_to_be32(nbytes);
> > -
> > -	_th =3D (struct tcphdr *)(bp + 1);
> > -	memcpy(_th, th, sizeof(*th));
> > -	_th->check =3D 0;
> > -
> > -	sg_init_one(&sg, bp, sizeof(*bp) + sizeof(*th));
> > -	ahash_request_set_crypt(hp->md5_req, &sg, NULL,
> > -				sizeof(*bp) + sizeof(*th));
> > -	return crypto_ahash_update(hp->md5_req);
> > -}
> > -
> > -static int tcp_v6_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig=
_key *key,
> > -			       const struct in6_addr *daddr, struct in6_addr *saddr,
> > -			       const struct tcphdr *th)
> > -{
> > -	struct tcp_md5sig_pool *hp;
> > -	struct ahash_request *req;
> > -
> > -	hp =3D tcp_get_md5sig_pool();
> > -	if (!hp)
> > -		goto clear_hash_noput;
> > -	req =3D hp->md5_req;
> > -
> > -	if (crypto_ahash_init(req))
> > -		goto clear_hash;
> > -	if (tcp_v6_md5_hash_headers(hp, daddr, saddr, th, th->doff << 2))
> > -		goto clear_hash;
> > -	if (tcp_md5_hash_key(hp, key))
> > -		goto clear_hash;
> > -	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> > -	if (crypto_ahash_final(req))
> > -		goto clear_hash;
> > -
> > -	tcp_put_md5sig_pool();
> > -	return 0;
> > -
> > -clear_hash:
> > -	tcp_put_md5sig_pool();
> > -clear_hash_noput:
> > -	memset(md5_hash, 0, 16);
> > -	return 1;
> > -}
> > -
> > -static int tcp_v6_md5_hash_skb(char *md5_hash,
> > -			       const struct tcp_md5sig_key *key,
> > -			       const struct sock *sk,
> > -			       const struct sk_buff *skb)
> > -{
> > -	const struct in6_addr *saddr, *daddr;
> > -	struct tcp_md5sig_pool *hp;
> > -	struct ahash_request *req;
> > -	const struct tcphdr *th =3D tcp_hdr(skb);
> > -
> > -	if (sk) { /* valid for establish/request sockets */
> > -		saddr =3D &sk->sk_v6_rcv_saddr;
> > -		daddr =3D &sk->sk_v6_daddr;
> > -	} else {
> > -		const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
> > -		saddr =3D &ip6h->saddr;
> > -		daddr =3D &ip6h->daddr;
> > -	}
> > -
> > -	hp =3D tcp_get_md5sig_pool();
> > -	if (!hp)
> > -		goto clear_hash_noput;
> > -	req =3D hp->md5_req;
> > -
> > -	if (crypto_ahash_init(req))
> > -		goto clear_hash;
> > -
> > -	if (tcp_v6_md5_hash_headers(hp, daddr, saddr, th, skb->len))
> > -		goto clear_hash;
> > -	if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
> > -		goto clear_hash;
> > -	if (tcp_md5_hash_key(hp, key))
> > -		goto clear_hash;
> > -	ahash_request_set_crypt(req, NULL, md5_hash, 0);
> > -	if (crypto_ahash_final(req))
> > -		goto clear_hash;
> > -
> > -	tcp_put_md5sig_pool();
> > -	return 0;
> > -
> > -clear_hash:
> > -	tcp_put_md5sig_pool();
> > -clear_hash_noput:
> > -	memset(md5_hash, 0, 16);
> > -	return 1;
> > -}
> > -
> > -#endif
> > -
> > -static bool tcp_v6_inbound_md5_hash(const struct sock *sk,
> > -				    const struct sk_buff *skb)
> > -{
> > -#ifdef CONFIG_TCP_MD5SIG
> > -	const __u8 *hash_location =3D NULL;
> > -	struct tcp_md5sig_key *hash_expected;
> > -	const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
> > -	const struct tcphdr *th =3D tcp_hdr(skb);
> > -	int genhash;
> > -	u8 newhash[16];
> > -
> > -	hash_expected =3D tcp_v6_md5_do_lookup(sk, &ip6h->saddr);
> > -	hash_location =3D tcp_parse_md5sig_option(th);
> > -
> > -	/* We've parsed the options - do we have a hash? */
> > -	if (!hash_expected && !hash_location)
> > -		return false;
> > -
> > -	if (hash_expected && !hash_location) {
> > -		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
> > -		return true;
> > -	}
> > -
> > -	if (!hash_expected && hash_location) {
> > -		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
> > -		return true;
> > -	}
> > -
> > -	/* check the signature */
> > -	genhash =3D tcp_v6_md5_hash_skb(newhash,
> > -				      hash_expected,
> > -				      NULL, skb);
> > -
> > -	if (genhash || memcmp(hash_location, newhash, 16) !=3D 0) {
> > -		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
> > -		net_info_ratelimited("MD5 Hash %s for [%pI6c]:%u->[%pI6c]:%u\n",
> > -				     genhash ? "failed" : "mismatch",
> > -				     &ip6h->saddr, ntohs(th->source),
> > -				     &ip6h->daddr, ntohs(th->dest));
> > -		return true;
> > -	}
> > -#endif
> > -	return false;
> > -}
> > -
> > static void tcp_v6_init_req(struct request_sock *req,
> > 			    const struct sock *sk_listener,
> > 			    struct sk_buff *skb)
> > @@ -791,60 +570,27 @@ static void tcp_v6_send_response(const struct soc=
k *sk, struct sk_buff *skb, u32
> > 	unsigned int tot_len =3D sizeof(struct tcphdr);
> > 	struct dst_entry *dst;
> > 	__be32 *topt;
> > -#ifdef CONFIG_TCP_MD5SIG
> > -	struct tcp_md5sig_key *key =3D NULL;
> > -	const __u8 *hash_location =3D NULL;
> > -	struct ipv6hdr *ipv6h =3D ipv6_hdr(skb);
> > -#endif
> > 	struct tcp_out_options extraopts;
> > =

> > +	memset(&extraopts, 0, sizeof(extraopts));
> > +
> > 	if (tsecr)
> > 		tot_len +=3D TCPOLEN_TSTAMP_ALIGNED;
> > #ifdef CONFIG_TCP_MD5SIG
> > -	rcu_read_lock();
> > -	hash_location =3D tcp_parse_md5sig_option(th);
> > -	if (sk && sk_fullsock(sk)) {
> > -		key =3D tcp_v6_md5_do_lookup(sk, &ipv6h->saddr);
> > -	} else if (sk && sk->sk_state =3D=3D TCP_TIME_WAIT) {
> > -		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
> > -
> > -		key =3D tcp_twsk_md5_key(tcptw);
> > -	} else if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
> > -		key =3D tcp_v6_md5_do_lookup(sk, &ipv6h->daddr);
> > -	} else if (hash_location) {
> > -		unsigned char newhash[16];
> > -		struct sock *sk1 =3D NULL;
> > -		int genhash;
> > -
> > -		/* active side is lost. Try to find listening socket through
> > -		 * source port, and then find md5 key through listening socket.
> > -		 * we are not loose security here:
> > -		 * Incoming packet is checked with md5 hash with finding key,
> > -		 * no RST generated if md5 hash doesn't match.
> > -		 */
> > -		sk1 =3D inet6_lookup_listener(dev_net(skb_dst(skb)->dev),
> > -					    &tcp_hashinfo, NULL, 0,
> > -					    &ipv6h->saddr,
> > -					    th->source, &ipv6h->daddr,
> > -					    ntohs(th->source), tcp_v6_iif(skb),
> > -					    tcp_v6_sdif(skb));
> > -		if (!sk1)
> > -			goto out;
> > +{
> > +	int ret;
> > =

> > -		key =3D tcp_v6_md5_do_lookup(sk1, &ipv6h->saddr);
> > -		if (!key)
> > -			goto out;
> > +	ret =3D tcp_v6_md5_send_response_prepare(skb, 0,
> > +					       MAX_TCP_OPTION_SPACE - tot_len,
> > +					       &extraopts, sk);
> > =

> > -		genhash =3D tcp_v6_md5_hash_skb(newhash, key, NULL, skb);
> > -		if (genhash || memcmp(hash_location, newhash, 16) !=3D 0)
> > -			goto out;
> > -	}
> > +	if (ret =3D=3D -1)
> > +		goto out;
> > =

> > -	if (key)
> > -		tot_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> > +	tot_len +=3D ret;
> > +}
> > #endif
> > =

> > -
> > 	if (static_branch_unlikely(&tcp_extra_options_enabled)) {
> > 		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - tot_len;
> > 		u8 extraflags =3D rst ? TCPHDR_RST : 0;
> > @@ -853,8 +599,6 @@ static void tcp_v6_send_response(const struct sock =
*sk, struct sk_buff *skb, u32
> > 		if (!rst || !th->ack)
> > 			extraflags |=3D TCPHDR_ACK;
> > =

> > -		memset(&extraopts, 0, sizeof(extraopts));
> > -
> > 		used =3D tcp_extra_options_response_prepare(skb, extraflags,
> > 							  remaining,
> > 							  &extraopts, sk);
> > @@ -895,13 +639,8 @@ static void tcp_v6_send_response(const struct sock=
 *sk, struct sk_buff *skb, u32
> > 	}
> > =

> > #ifdef CONFIG_TCP_MD5SIG
> > -	if (key) {
> > -		*topt++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
> > -				(TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
> > -		tcp_v6_md5_hash_hdr((__u8 *)topt, key,
> > -				    &ipv6_hdr(skb)->saddr,
> > -				    &ipv6_hdr(skb)->daddr, t1);
> > -	}
> > +	if (extraopts.md5)
> > +		tcp_v6_md5_send_response_write(topt, skb, t1, &extraopts, sk);
> > #endif
> > =

> > 	if (static_branch_unlikely(&tcp_extra_options_enabled))
> > @@ -949,10 +688,6 @@ static void tcp_v6_send_response(const struct sock=
 *sk, struct sk_buff *skb, u32
> > =

> > out:
> > 	kfree_skb(buff);
> > -
> > -#if CONFIG_TCP_MD5SIG
> > -	rcu_read_unlock();
> > -#endif
> > }
> > =

> > static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *sk=
b)
> > @@ -1078,9 +813,6 @@ static struct sock *tcp_v6_syn_recv_sock(const str=
uct sock *sk, struct sk_buff *
> > 	struct inet_sock *newinet;
> > 	struct tcp_sock *newtp;
> > 	struct sock *newsk;
> > -#ifdef CONFIG_TCP_MD5SIG
> > -	struct tcp_md5sig_key *key;
> > -#endif
> > 	struct flowi6 fl6;
> > =

> > 	if (skb->protocol =3D=3D htons(ETH_P_IP)) {
> > @@ -1231,18 +963,7 @@ static struct sock *tcp_v6_syn_recv_sock(const st=
ruct sock *sk, struct sk_buff *
> > 	}
> > =

> > #ifdef CONFIG_TCP_MD5SIG
> > -	/* Copy over the MD5 key from the original socket */
> > -	key =3D tcp_v6_md5_do_lookup(sk, &newsk->sk_v6_daddr);
> > -	if (key) {
> > -		/* We're using one, so create a matching key
> > -		 * on the newsk structure. If we fail to get
> > -		 * memory, then we end up not copying the key
> > -		 * across. Shucks.
> > -		 */
> > -		tcp_md5_do_add(newsk, (union tcp_md5_addr *)&newsk->sk_v6_daddr,
> > -			       AF_INET6, 128, key->key, key->keylen,
> > -			       sk_gfp_mask(sk, GFP_ATOMIC));
> > -	}
> > +	tcp_v6_md5_syn_recv_sock(sk, newsk);
> > #endif
> > =

> > 	if (__inet_inherit_port(sk, newsk) < 0) {
> > @@ -1698,14 +1419,6 @@ static const struct inet_connection_sock_af_ops =
ipv6_specific =3D {
> > 	.mtu_reduced	   =3D tcp_v6_mtu_reduced,
> > };
> > =

> > -#ifdef CONFIG_TCP_MD5SIG
> > -static const struct tcp_sock_af_ops tcp_sock_ipv6_specific =3D {
> > -	.md5_lookup	=3D	tcp_v6_md5_lookup,
> > -	.calc_md5_hash	=3D	tcp_v6_md5_hash_skb,
> > -	.md5_parse	=3D	tcp_v6_parse_md5_keys,
> > -};
> > -#endif
> > -
> > /*
> >  *	TCP over IPv4 via INET6 API
> >  */
> > @@ -1728,14 +1441,6 @@ static const struct inet_connection_sock_af_ops =
ipv6_mapped =3D {
> > 	.mtu_reduced	   =3D tcp_v4_mtu_reduced,
> > };
> > =

> > -#ifdef CONFIG_TCP_MD5SIG
> > -static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific =3D {
> > -	.md5_lookup	=3D	tcp_v4_md5_lookup,
> > -	.calc_md5_hash	=3D	tcp_v4_md5_hash_skb,
> > -	.md5_parse	=3D	tcp_v6_parse_md5_keys,
> > -};
> > -#endif
> > -
> > /* NOTE: A lot of things set to zero explicitly by call to
> >  *       sk_alloc() so need not be done here.
> >  */
> > -- =

> > 2.15.0
> > =

> > =

> =

> --
> Mat Martineau
> Intel OTC

--===============4683686875740799478==--
