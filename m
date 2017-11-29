Content-Type: multipart/mixed; boundary="===============4123875120054642382=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 11/25] tcp_extra_options: Make extra-option
 list per-socket
Date: Wed, 29 Nov 2017 09:59:57 -0800
Message-ID: <20171129175957.GQ94116@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1711281740180.17380@ddombrow-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 215

--===============4123875120054642382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 28/11/17 - 17:44:41, Mat Martineau wrote:
> On Mon, 27 Nov 2017, Christoph Paasch wrote:
> =

> > Each TCP-socket, TCP request-socket and TCP time-wait socket has its own
> > list. That way we can send the proper options in each state.
> > =

> > The list is copied across the different socket-types when needed.
> > =

> > Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> > ---
> > include/linux/tcp.h      |   5 ++
> > include/net/tcp.h        |  49 +++++++++--
> > net/ipv4/tcp.c           | 214 ++++++++++++++++++++++++++++++----------=
-------
> > net/ipv4/tcp_input.c     |   5 ++
> > net/ipv4/tcp_ipv4.c      |  14 +++-
> > net/ipv4/tcp_minisocks.c |  10 +++
> > net/ipv6/tcp_ipv6.c      |   9 ++
> > 7 files changed, 219 insertions(+), 87 deletions(-)
> > =

> > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > index a2a1676dfc52..4f653e3bd33f 100644
> > --- a/include/linux/tcp.h
> > +++ b/include/linux/tcp.h
> > @@ -156,6 +156,7 @@ struct tcp_request_sock {
> > 						  * FastOpen it's the seq#
> > 						  * after data-in-SYN.
> > 						  */
> > +	struct list_head		tcp_option_list;
> > };
> > =

> > static inline struct tcp_request_sock *tcp_rsk(const struct request_soc=
k *req)
> > @@ -391,6 +392,8 @@ struct tcp_sock {
> > 	 */
> > 	struct request_sock *fastopen_rsk;
> > 	u32	*saved_syn;
> > +
> > +	struct list_head tcp_option_list;
> > };
> > =

> > enum tsq_enum {
> > @@ -435,6 +438,8 @@ struct tcp_timewait_sock {
> > 	u32			  tw_last_oow_ack_time;
> > =

> > 	long			  tw_ts_recent_stamp;
> > +
> > +	struct list_head	  tcp_option_list;
> > #ifdef CONFIG_TCP_MD5SIG
> > 	struct tcp_md5sig_key	  *tw_md5_key;
> > #endif
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 0981a1b429ca..1f34b1708990 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2066,31 +2066,56 @@ extern struct static_key_false tcp_have_smc;
> > #endif
> > =

> > extern struct static_key_false tcp_extra_options_enabled;
> > +struct tcp_extra_option_store;
> > =

> > struct tcp_extra_option_ops {
> > -	struct list_head	list;
> > 	unsigned char		option_kind;
> > 	unsigned char		priority;
> > 	void (*parse)(int opsize, const unsigned char *opptr,
> > 		      const struct sk_buff *skb,
> > 		      struct tcp_options_received *opt_rx,
> > -		      struct sock *sk);
> > +		      struct sock *sk,
> > +		      struct tcp_extra_option_store *store);
> > 	/* Return the number of bytes consumed */
> > 	unsigned int (*prepare)(struct sk_buff *skb, u8 flags,
> > 				unsigned int remaining,
> > 				struct tcp_out_options *opts,
> > -				const struct sock *sk);
> > +				const struct sock *sk,
> > +				struct tcp_extra_option_store *store);
> > 	void (*write)(__be32 *ptr, struct sk_buff *skb,
> > -		      struct tcp_out_options *opts, struct sock *sk);
> > +		      struct tcp_out_options *opts, struct sock *sk,
> > +		      struct tcp_extra_option_store *store);
> > 	void (*response_write)(__be32 *ptr, struct sk_buff *orig,
> > 			       struct tcphdr *th,
> > 			       struct tcp_out_options *opts,
> > -			       const struct sock *sk);
> > +			       const struct sock *sk,
> > +			       struct tcp_extra_option_store *store);
> > 	int (*add_header_len)(const struct sock *listener,
> > -			      const struct sock *sk);
> > +			      const struct sock *sk,
> > +			      struct tcp_extra_option_store *store);
> > +	struct tcp_extra_option_store *(*copy)(struct sock *listener,
> > +					       struct request_sock *req,
> > +					       struct tcp_options_received *opt,
> > +					       struct tcp_extra_option_store *from);
> > +	struct tcp_extra_option_store *(*move)(struct tcp_extra_option_store =
*from);
> > +	void (*destroy)(struct tcp_extra_option_store *store);
> > 	struct module		*owner;
> > };
> > =

> > +/* Every extra-option in a TCP-socket gets stored in a _store structur=
e which
> > + * has to have tcp_extra_option_store as the first element.
> > + *
> > + * That way, an extra option registers passes this to tcp_register_ext=
ra_option,
> > + * and the surrounding structure can contain per-option state.
> > + */
> > +struct tcp_extra_option_store {
> > +	struct list_head		list;
> > +	const struct tcp_extra_option_ops	*ops;
> > +};
> > +
> > +struct tcp_extra_option_store *tcp_extra_options_find_kind(unsigned ch=
ar kind,
> > +							   const struct sock *sk);
> > +
> > void tcp_extra_options_parse(int opcode, int opsize, const unsigned cha=
r *opptr,
> > 			     const struct sk_buff *skb,
> > 			     struct tcp_options_received *opt_rx,
> > @@ -2113,7 +2138,15 @@ void tcp_extra_options_response_write(__be32 *pt=
r, struct sk_buff *orig,
> > int tcp_extra_options_add_header(const struct sock *listener,
> > 				 const struct sock *sk);
> > =

> > -int tcp_register_extra_option(struct tcp_extra_option_ops *ops);
> > -void tcp_unregister_extra_option(struct tcp_extra_option_ops *ops);
> > +int tcp_register_extra_option(struct tcp_extra_option_store *store,
> > +			      struct sock *sk);
> > +
> > +void tcp_extra_options_copy(struct sock *listener,
> > +			    struct request_sock *req,
> > +			    struct tcp_options_received *opt);
> > +
> > +void tcp_extra_options_move(struct list_head *from, struct list_head *=
to);
> > +
> > +void tcp_extra_options_destroy(struct sock *sk);
> > =

> > #endif	/* _TCP_H */
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 487f28222d3c..01e646873613 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -308,8 +308,6 @@ EXPORT_SYMBOL(tcp_sockets_allocated);
> > /*
> >  * Optional TCP option handlers
> >  */
> > -static DEFINE_SPINLOCK(tcp_option_list_lock);
> > -static LIST_HEAD(tcp_option_list);
> > DEFINE_STATIC_KEY_FALSE(tcp_extra_options_enabled);
> > =

> > /*
> > @@ -423,6 +421,7 @@ void tcp_init_sock(struct sock *sk)
> > 	tcp_init_xmit_timers(sk);
> > 	INIT_LIST_HEAD(&tp->tsq_node);
> > 	INIT_LIST_HEAD(&tp->tsorted_sent_queue);
> > +	INIT_LIST_HEAD(&tp->tcp_option_list);
> > =

> > 	icsk->icsk_rto =3D TCP_TIMEOUT_INIT;
> > 	tp->mdev_us =3D jiffies_to_usecs(TCP_TIMEOUT_INIT);
> > @@ -3479,19 +3478,32 @@ EXPORT_SYMBOL(tcp_md5_hash_key);
> > =

> > #endif
> > =

> > -/* Linear search, few entries are expected. The RCU read lock must
> > - * be held before calling.
> > - */
> > -static struct tcp_extra_option_ops *tcp_extra_options_find_kind(unsign=
ed char kind)
> > +static struct list_head *tcp_extra_options_get_list(const struct sock =
*sk)
> > {
> > -	struct tcp_extra_option_ops *entry;
> > +	if (sk_fullsock(sk))
> > +		return &tcp_sk(sk)->tcp_option_list;
> > +	else if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
> > +		return &tcp_rsk(inet_reqsk(sk))->tcp_option_list;
> > +	else if (sk->sk_state =3D=3D TCP_TIME_WAIT)
> > +		return &tcp_twsk(sk)->tcp_option_list;
> > +
> > +	return NULL;
> > +}
> > +
> > +struct tcp_extra_option_store *tcp_extra_options_find_kind(unsigned ch=
ar kind,
> > +							   const struct sock *sk)
> > +{
> > +	struct tcp_extra_option_store *entry;
> > +	struct list_head *lhead;
> > +
> > +	lhead =3D tcp_extra_options_get_list(sk);
> > =

> > -	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
> > -		if (entry->option_kind =3D=3D kind)
> > -			return entry;
> > +	list_for_each_entry(entry, lhead, list) {
> > +		if (entry->ops->option_kind =3D=3D kind)
> > +			break;
> > 	}
> > =

> > -	return NULL;
> > +	return entry;
> > }
> > =

> > void tcp_extra_options_parse(int opcode, int opsize, const unsigned cha=
r *opptr,
> > @@ -3499,75 +3511,79 @@ void tcp_extra_options_parse(int opcode, int op=
size, const unsigned char *opptr,
> > 			     struct tcp_options_received *opt_rx,
> > 			     struct sock *sk)
> > {
> > -	struct tcp_extra_option_ops *entry;
> > +	struct tcp_extra_option_store *entry;
> > +
> > +	entry =3D tcp_extra_options_find_kind(opcode, sk);
> > =

> > -	rcu_read_lock();
> > -	entry =3D tcp_extra_options_find_kind(opcode);
> > -	if (entry && entry->parse)
> > -		entry->parse(opsize, opptr, skb, opt_rx, sk);
> > -	rcu_read_unlock();
> > +	if (entry && entry->ops->parse)
> > +		entry->ops->parse(opsize, opptr, skb, opt_rx, sk, entry);
> > }
> > EXPORT_SYMBOL_GPL(tcp_extra_options_parse);
> > =

> > -/* The RCU read lock must be held before calling, and should span both
> > - * the call to this function and tcp_extra_options_write to ensure that
> > - * tcp_option_list does not change between the two calls. To preserve
> > - * expected option alignment, always returns a multiple of 4 bytes.
> > - */
> > unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
> > 				       unsigned int remaining,
> > 				       struct tcp_out_options *opts,
> > 				       const struct sock *sk)
> > {
> > -	struct tcp_extra_option_ops *entry;
> > +	struct tcp_extra_option_store *entry;
> > +	struct list_head *lhead;
> > 	unsigned int used =3D 0;
> > =

> > -	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
> > -		if (unlikely(!entry->prepare))
> > +	if (!sk)
> > +		return 0;
> > +
> > +	lhead =3D tcp_extra_options_get_list(sk);
> > +
> > +	list_for_each_entry(entry, lhead, list) {
> > +		if (unlikely(!entry->ops->prepare))
> > 			continue;
> > =

> > -		used +=3D entry->prepare(skb, flags, remaining - used, opts, sk);
> > +		used +=3D entry->ops->prepare(skb, flags, remaining - used, opts,
> > +					    sk, entry);
> > 	}
> > =

> > 	return roundup(used, 4);
> > }
> > EXPORT_SYMBOL_GPL(tcp_extra_options_prepare);
> > =

> > -/* The RCU read lock must be held before calling, and should span both
> > - * the call to tcp_extra_options_write and this function to ensure that
> > - * tcp_option_list does not change between the two calls.
> > - */
> > void tcp_extra_options_write(__be32 *ptr, struct sk_buff *skb,
> > 			     struct tcp_out_options *opts,
> > 			     struct sock *sk)
> > {
> > -	struct tcp_extra_option_ops *entry;
> > +	struct tcp_extra_option_store *entry;
> > +	struct list_head *lhead;
> > +
> > +	if (!sk)
> > +		return;
> > =

> > -	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
> > -		if (unlikely(!entry->write))
> > +	lhead =3D tcp_extra_options_get_list(sk);
> > +
> > +	list_for_each_entry_rcu(entry, lhead, list) {
> =

> An _rcu iterator snuck in here.
> =

> > +		if (unlikely(!entry->ops->write))
> > 			continue;
> > =

> > -		entry->write(ptr, skb, opts, sk);
> > +		entry->ops->write(ptr, skb, opts, sk, entry);
> > 	}
> > }
> > EXPORT_SYMBOL_GPL(tcp_extra_options_write);
> > =

> > -/* The RCU read lock must be held before calling, and should span both
> > - * the call to tcp_extra_options_write and this function to ensure that
> > - * tcp_option_list does not change between the two calls.
> > - */
> > void tcp_extra_options_response_write(__be32 *ptr, struct sk_buff *orig,
> > 				      struct tcphdr *th,
> > 				      struct tcp_out_options *opts,
> > 				      const struct sock *sk)
> > {
> > -	struct tcp_extra_option_ops *entry;
> > +	struct tcp_extra_option_store *entry;
> > =

> > -	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
> > -		if (unlikely(!entry->write))
> > +	if (!sk)
> > +		return;
> > +
> > +	BUG_ON(!sk_fullsock(sk));
> > +
> > +	list_for_each_entry_rcu(entry, &tcp_sk(sk)->tcp_option_list, list) {
> =

> Another _rcu

Thanks, fixed both.


Christoph


--===============4123875120054642382==--
