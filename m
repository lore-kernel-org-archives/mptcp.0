Content-Type: multipart/mixed; boundary="===============4609910358849406104=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 10/12] mptcp: Make subflow-list an RCU-list
Date: Tue, 10 Apr 2018 17:45:10 +0200
Message-ID: <91dde274-2d13-0f11-f046-52c94cba805d@tessares.net>
In-Reply-To: 20180326073215.83607-11-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 533

--===============4609910358849406104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 26/03/2018 09:32, Christoph Paasch wrote:
> mptcp_add_sock() will now be called without holding the meta-level lock.
> However, mptcp_add_sock() wants to add the subflow to the meta-level
> list, thus we need to protect this by a lock. We use the mpcb_list_lock
> for that.
> =

> Now that we are locking during add/del, and want to allow lockless
> traversal of the list, this implies that we need to make it an RCU-list.
> =

> So, this patch transitions to the RCU hlist. The list-traversal macros
> (hlist_for_each_entry_rcu) require me to now pass the mptcp_tcp_sock to
> mptcp_for_each_*. So, I had to change all the places in the code where
> we call one of the list-traversal macros to adapt to this.

Thank you for this big refactoring!
I quickly reviewed these changes, I hope no 'struct mptcp_tcp_sock' have =

been overridden but it looks fine, we always add a new variable 'mptcp' :-)

I only have comments in mptcp_redundant.c

> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
>   include/net/mptcp.h          |  69 ++++++++++----------
>   net/ipv4/af_inet.c           |   9 +--
>   net/ipv4/ip_sockglue.c       |   7 +-
>   net/ipv4/tcp.c               |  31 +++++----
>   net/mptcp/mctcp_desync.c     |  18 ++++--
>   net/mptcp/mptcp_balia.c      |   8 ++-
>   net/mptcp/mptcp_binder.c     |  10 ++-
>   net/mptcp/mptcp_coupled.c    |  11 ++--
>   net/mptcp/mptcp_ctrl.c       |  89 +++++++++++++++----------
>   net/mptcp/mptcp_fullmesh.c   |  28 +++++---
>   net/mptcp/mptcp_input.c      |  44 ++++++++-----
>   net/mptcp/mptcp_ndiffports.c |   4 +-
>   net/mptcp/mptcp_olia.c       |  20 ++++--
>   net/mptcp/mptcp_output.c     |  38 +++++++----
>   net/mptcp/mptcp_redundant.c  | 151 ++++++++++++++++++++++++++++++++++--=
-------
>   net/mptcp/mptcp_rr.c         |  22 +++++--
>   net/mptcp/mptcp_sched.c      |  21 ++++--
>   net/mptcp/mptcp_wvegas.c     |   5 +-
>   18 files changed, 394 insertions(+), 191 deletions(-)
> =

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index d455bdd101ec..59e3da6c4031 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -156,7 +156,7 @@ struct mptcp_options_received {
>   };
>   =

>   struct mptcp_tcp_sock {
> -	struct tcp_sock	*next;		/* Next subflow socket */
> +	struct hlist_node node;
>   	struct hlist_node cb_list;
>   	struct mptcp_options_received rx_opt;
>   =

> @@ -257,7 +257,7 @@ struct mptcp_sched_ops {
>   =

>   struct mptcp_cb {
>   	/* list of sockets in this multipath connection */
> -	struct tcp_sock *connection_list;
> +	struct hlist_head conn_list;
>   	/* list of sockets that need a call to release_cb */
>   	struct hlist_head callback_list;
>   =

> @@ -312,7 +312,7 @@ struct mptcp_cb {
>   	/***** Start of fields, used for subflow establishment */
>   	struct sock *meta_sk;
>   =

> -	/* Master socket, also part of the connection_list, this
> +	/* Master socket, also part of the conn_list, this
>   	 * socket is the one that the application sees.
>   	 */
>   	struct sock *master_sk;
> @@ -664,21 +664,17 @@ extern struct workqueue_struct *mptcp_wq;
>   			pr_err(fmt, ##args);					\
>   	} while (0)
>   =

> -/* Iterates over all subflows */
> -#define mptcp_for_each_tp(mpcb, tp)					\
> -	for ((tp) =3D (mpcb)->connection_list; (tp); (tp) =3D (tp)->mptcp->next)
> +static inline struct sock *mptcp_to_sock(const struct mptcp_tcp_sock *mp=
tcp)
> +{
> +	return (struct sock *)mptcp->tp;
> +}
>   =

> -#define mptcp_for_each_sk(mpcb, sk)					\
> -	for ((sk) =3D (struct sock *)(mpcb)->connection_list;		\
> -	     sk;							\
> -	     sk =3D (struct sock *)tcp_sk(sk)->mptcp->next)
> +#define mptcp_for_each_sub(__mpcb, __mptcp)					\
> +	hlist_for_each_entry_rcu(__mptcp, &((__mpcb)->conn_list), node)
>   =

> -#define mptcp_for_each_sk_safe(__mpcb, __sk, __temp)			\
> -	for (__sk =3D (struct sock *)(__mpcb)->connection_list,		\
> -	     __temp =3D __sk ? (struct sock *)tcp_sk(__sk)->mptcp->next : NULL;=
 \
> -	     __sk;							\
> -	     __sk =3D __temp,						\
> -	     __temp =3D __sk ? (struct sock *)tcp_sk(__sk)->mptcp->next : NULL)
> +/* Must be called with the appropriate lock held */
> +#define mptcp_for_each_sub_safe(__mpcb, __mptcp, __tmp)				\
> +	hlist_for_each_entry_safe(__mptcp, __tmp, &((__mpcb)->conn_list), node)
>   =

>   /* Iterates over all bit set to 1 in a bitset */
>   #define mptcp_for_each_bit_set(b, i)					\
> @@ -932,12 +928,14 @@ struct request_sock *rev_mptcp_rsk(const struct mpt=
cp_request_sock *req)
>   =

>   static inline bool mptcp_can_sendpage(struct sock *sk)
>   {
> -	struct sock *sk_it;
> +	struct mptcp_tcp_sock *mptcp;
>   =

>   	if (tcp_sk(sk)->mpcb->dss_csum)
>   		return false;
>   =

> -	mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk_it) {
> +	mptcp_for_each_sub(tcp_sk(sk)->mpcb, mptcp) {
> +		struct sock *sk_it =3D mptcp_to_sock(mptcp);
> +
>   		if (!(sk_it->sk_route_caps & NETIF_F_SG) ||
>   		    !sk_check_csum_caps(sk_it))
>   			return false;
> @@ -972,9 +970,12 @@ static inline void mptcp_send_reset(struct sock *sk)
>   static inline void mptcp_sub_force_close_all(struct mptcp_cb *mpcb,
>   					     struct sock *except)
>   {
> -	struct sock *sk_it, *tmp;
> +	struct mptcp_tcp_sock *mptcp;
> +	struct hlist_node *tmp;
> +
> +	mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
> +		struct sock *sk_it =3D mptcp_to_sock(mptcp);
>   =

> -	mptcp_for_each_sk_safe(mpcb, sk_it, tmp) {
>   		if (sk_it !=3D except)
>   			mptcp_send_reset(sk_it);
>   	}
> @@ -1161,12 +1162,14 @@ static inline int mptcp_sk_can_send_ack(const str=
uct sock *sk)
>   /* Only support GSO if all subflows supports it */
>   static inline bool mptcp_sk_can_gso(const struct sock *meta_sk)
>   {
> -	struct sock *sk;
> +	struct mptcp_tcp_sock *mptcp;
>   =

>   	if (tcp_sk(meta_sk)->mpcb->dss_csum)
>   		return false;
>   =

> -	mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
> +	mptcp_for_each_sub(tcp_sk(meta_sk)->mpcb, mptcp) {
> +		struct sock *sk =3D mptcp_to_sock(mptcp);
> +
>   		if (!mptcp_sk_can_send(sk))
>   			continue;
>   		if (!sk_can_gso(sk))
> @@ -1177,12 +1180,14 @@ static inline bool mptcp_sk_can_gso(const struct =
sock *meta_sk)
>   =

>   static inline bool mptcp_can_sg(const struct sock *meta_sk)
>   {
> -	struct sock *sk;
> +	struct mptcp_tcp_sock *mptcp;
>   =

>   	if (tcp_sk(meta_sk)->mpcb->dss_csum)
>   		return false;
>   =

> -	mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
> +	mptcp_for_each_sub(tcp_sk(meta_sk)->mpcb, mptcp) {
> +		struct sock *sk =3D mptcp_to_sock(mptcp);
> +
>   		if (!mptcp_sk_can_send(sk))
>   			continue;
>   		if (!(sk->sk_route_caps & NETIF_F_SG))
> @@ -1193,9 +1198,9 @@ static inline bool mptcp_can_sg(const struct sock *=
meta_sk)
>   =

>   static inline void mptcp_set_rto(struct sock *sk)
>   {
> -	struct tcp_sock *tp =3D tcp_sk(sk);
> -	struct sock *sk_it;
>   	struct inet_connection_sock *micsk =3D inet_csk(mptcp_meta_sk(sk));
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct mptcp_tcp_sock *mptcp;
>   	__u32 max_rto =3D 0;
>   =

>   	/* We are in recovery-phase on the MPTCP-level. Do not update the
> @@ -1204,7 +1209,9 @@ static inline void mptcp_set_rto(struct sock *sk)
>   	if (micsk->icsk_retransmits)
>   		return;
>   =

> -	mptcp_for_each_sk(tp->mpcb, sk_it) {
> +	mptcp_for_each_sub(tp->mpcb, mptcp) {
> +		struct sock *sk_it =3D mptcp_to_sock(mptcp);
> +
>   		if ((mptcp_sk_can_send(sk_it) || sk->sk_state =3D=3D TCP_SYN_RECV) &&
>   		    inet_csk(sk_it)->icsk_rto > max_rto)
>   			max_rto =3D inet_csk(sk_it)->icsk_rto;
> @@ -1303,12 +1310,8 @@ bool mptcp_prune_ofo_queue(struct sock *sk);
>   	do {				\
>   	} while (0)
>   =

> -/* Without MPTCP, we just do one iteration
> - * over the only socket available. This assumes that
> - * the sk/tp arg is the socket in that case.
> - */
> -#define mptcp_for_each_sk(mpcb, sk)
> -#define mptcp_for_each_sk_safe(__mpcb, __sk, __temp)
> +#define mptcp_for_each_sub(__mpcb, __mptcp)					\
> +	if (0)
>   =

>   #define MPTCP_INC_STATS(net, field)	\
>   	do {				\
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 426fa704e218..87a98edc18d4 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -709,13 +709,14 @@ int inet_accept(struct socket *sock, struct socket =
*newsock, int flags,
>   	sock_rps_record_flow(sk2);
>   =

>   	if (sk2->sk_protocol =3D=3D IPPROTO_TCP && mptcp(tcp_sk(sk2))) {
> -		struct sock *sk_it =3D sk2;
> +		struct mptcp_tcp_sock *mptcp;
>   =

> -		mptcp_for_each_sk(tcp_sk(sk2)->mpcb, sk_it)
> -			sock_rps_record_flow(sk_it);
> +		mptcp_for_each_sub(tcp_sk(sk2)->mpcb, mptcp) {
> +			sock_rps_record_flow(mptcp_to_sock(mptcp));
> +		}
>   =

>   		if (tcp_sk(sk2)->mpcb->master_sk) {
> -			sk_it =3D tcp_sk(sk2)->mpcb->master_sk;
> +			struct sock *sk_it =3D tcp_sk(sk2)->mpcb->master_sk;
>   =

>   			write_lock_bh(&sk_it->sk_callback_lock);
>   			sk_it->sk_wq =3D newsock->wq;
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 1fe79c7bcc9e..2b7a8c416c91 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -756,8 +756,11 @@ static int do_ip_setsockopt(struct sock *sk, int lev=
el,
>   			sk_dst_reset(sk);
>   			/* Update TOS on mptcp subflow */
>   			if (is_meta_sk(sk)) {
> -				struct sock *sk_it;
> -				mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk_it) {
> +				struct mptcp_tcp_sock *mptcp;
> +
> +				mptcp_for_each_sub(tcp_sk(sk)->mpcb, mptcp) {
> +					struct sock *sk_it =3D mptcp_to_sock(mptcp);
> +
>   					if (inet_sk(sk_it)->tos !=3D inet_sk(sk)->tos) {
>   						inet_sk(sk_it)->tos =3D inet_sk(sk)->tos;
>   						sk_it->sk_priority =3D sk->sk_priority;
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 93e15eeba870..fd53722bf59e 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -804,9 +804,11 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t =
*ppos,
>   =

>   #ifdef CONFIG_MPTCP
>   	if (mptcp(tcp_sk(sk))) {
> -		struct sock *sk_it;
> -		mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk_it)
> -			sock_rps_record_flow(sk_it);
> +		struct mptcp_tcp_sock *mptcp;
> +
> +		mptcp_for_each_sub(tcp_sk(sk)->mpcb, mptcp) {
> +			sock_rps_record_flow(mptcp_to_sock(mptcp));
> +		}
>   	}
>   #endif
>   	/*
> @@ -984,7 +986,7 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page=
 *page, int offset,
>   	}
>   =

>   	if (mptcp(tp)) {
> -		struct sock *sk_it =3D sk;
> +		struct mptcp_tcp_sock *mptcp;
>   =

>   		/* We must check this with socket-lock hold because we iterate
>   		 * over the subflows.
> @@ -999,8 +1001,9 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct pag=
e *page, int offset,
>   			return ret;
>   		}
>   =

> -		mptcp_for_each_sk(tp->mpcb, sk_it)
> -			sock_rps_record_flow(sk_it);
> +		mptcp_for_each_sub(tp->mpcb, mptcp) {
> +			sock_rps_record_flow(mptcp_to_sock(mptcp));
> +		}
>   	}
>   =

>   	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
> @@ -1293,9 +1296,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct msg=
hdr *msg, size_t size)
>   	}
>   =

>   	if (mptcp(tp)) {
> -		struct sock *sk_it =3D sk;
> -		mptcp_for_each_sk(tp->mpcb, sk_it)
> -			sock_rps_record_flow(sk_it);
> +		struct mptcp_tcp_sock *mptcp;
> +
> +		mptcp_for_each_sub(tp->mpcb, mptcp) {
> +			sock_rps_record_flow(mptcp_to_sock(mptcp));
> +		}
>   	}
>   =

>   	if (unlikely(tp->repair)) {
> @@ -1883,9 +1888,11 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *ms=
g, size_t len, int nonblock,
>   =

>   #ifdef CONFIG_MPTCP
>   	if (mptcp(tp)) {
> -		struct sock *sk_it;
> -		mptcp_for_each_sk(tp->mpcb, sk_it)
> -			sock_rps_record_flow(sk_it);
> +		struct mptcp_tcp_sock *mptcp;
> +
> +		mptcp_for_each_sub(tp->mpcb, mptcp) {
> +			sock_rps_record_flow(mptcp_to_sock(mptcp));
> +		}
>   	}
>   #endif
>   =

> diff --git a/net/mptcp/mctcp_desync.c b/net/mptcp/mctcp_desync.c
> index cfc26fcc3161..f6bf9251d59b 100644
> --- a/net/mptcp/mctcp_desync.c
> +++ b/net/mptcp/mctcp_desync.c
> @@ -67,7 +67,6 @@ static void mctcp_desync_cong_avoid(struct sock *sk, u3=
2 ack, u32 acked)
>   	} else {
>   		const struct mctcp_desync *ca =3D inet_csk_ca(mptcp_meta_sk(sk));
>   		const u8 subfid =3D tp->mptcp->path_index;
> -		const struct sock *sub_sk;
>   =

>   		/* current aggregated cwnd */
>   		u32 agg_cwnd =3D 0;
> @@ -90,11 +89,14 @@ static void mctcp_desync_cong_avoid(struct sock *sk, =
u32 ack, u32 acked)
>   				tp->snd_ssthresh =3D tp->snd_cwnd =3D INI_MIN_CWND;
>   			}
>   			return;
> -		}
> -		  /* In dangerous area, increase slowly and linearly. */
> -		  else {
> +		} else {
> +			/* In dangerous area, increase slowly and linearly. */
> +			const struct mptcp_tcp_sock *mptcp;
> +
>   			/* get total cwnd and the subflow that has min cwnd */
> -			mptcp_for_each_sk(tp->mpcb, sub_sk) {
> +			mptcp_for_each_sub(tp->mpcb, mptcp) {
> +				const struct sock *sub_sk =3D mptcp_to_sock(mptcp);
> +
>   				if (mctcp_cc_sk_can_send(sub_sk)) {
>   					const struct tcp_sock *sub_tp =3D
>   								tcp_sk(sub_sk);
> @@ -126,12 +128,14 @@ static u32 mctcp_desync_ssthresh(struct sock *sk)
>   	} else {
>   		struct mctcp_desync *ca =3D inet_csk_ca(mptcp_meta_sk(sk));
>   		const u8 subfid =3D tp->mptcp->path_index;
> -		const struct sock *sub_sk;
> +		const struct mptcp_tcp_sock *mptcp;
>   		u32 max_cwnd =3D 0;
>   		u8 max_cwnd_subfid =3D 0;
>   =

>   		/* Find the subflow that has the max cwnd. */
> -		mptcp_for_each_sk(tp->mpcb, sub_sk) {
> +		mptcp_for_each_sub(tp->mpcb, mptcp) {
> +			const struct sock *sub_sk =3D mptcp_to_sock(mptcp);
> +
>   			if (mctcp_cc_sk_can_send(sub_sk)) {
>   				const struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
>   				if (max_cwnd < sub_tp->snd_cwnd) {
> diff --git a/net/mptcp/mptcp_balia.c b/net/mptcp/mptcp_balia.c
> index ac5c5e550539..e8a22fa66a50 100644
> --- a/net/mptcp/mptcp_balia.c
> +++ b/net/mptcp/mptcp_balia.c
> @@ -78,7 +78,7 @@ static void mptcp_balia_recalc_ai(const struct sock *sk)
>   {
>   	const struct tcp_sock *tp =3D tcp_sk(sk);
>   	const struct mptcp_cb *mpcb =3D tp->mpcb;
> -	const struct sock *sub_sk;
> +	struct mptcp_tcp_sock *mptcp;
>   	u64 max_rate =3D 0, rate =3D 0, sum_rate =3D 0;
>   	u64 alpha, ai =3D tp->snd_cwnd, md =3D (tp->snd_cwnd >> 1);
>   	int num_scale_down =3D 0;
> @@ -87,7 +87,8 @@ static void mptcp_balia_recalc_ai(const struct sock *sk)
>   		return;
>   =

>   	/* Find max_rate first */
> -	mptcp_for_each_sk(mpcb, sub_sk) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		const struct sock *sub_sk =3D mptcp_to_sock(mptcp);
>   		struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
>   		u64 tmp;
>   =

> @@ -119,7 +120,8 @@ static void mptcp_balia_recalc_ai(const struct sock *=
sk)
>   =

>   	if (num_scale_down) {
>   		sum_rate =3D 0;
> -		mptcp_for_each_sk(mpcb, sub_sk) {
> +		mptcp_for_each_sub(mpcb, mptcp) {
> +			const struct sock *sub_sk =3D mptcp_to_sock(mptcp);
>   			struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
>   			u64 tmp;
>   =

> diff --git a/net/mptcp/mptcp_binder.c b/net/mptcp/mptcp_binder.c
> index d6ef9c5b6ce5..eaf8ba674d17 100644
> --- a/net/mptcp/mptcp_binder.c
> +++ b/net/mptcp/mptcp_binder.c
> @@ -46,6 +46,8 @@ static int mptcp_get_avail_list_ipv4(struct sock *sk)
>   	unsigned char *opt_ptr, *opt_end_ptr, opt[MAX_IPOPTLEN];
>   =

>   	for (i =3D 0; i < MPTCP_GW_MAX_LISTS; ++i) {
> +		struct mptcp_tcp_sock *mptcp;
> +
>   		if (mptcp_gws->len[i] =3D=3D 0)
>   			goto error;
>   =

> @@ -53,7 +55,9 @@ static int mptcp_get_avail_list_ipv4(struct sock *sk)
>   		list_taken =3D 0;
>   =

>   		/* Loop through all sub-sockets in this connection */
> -		mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk) {
> +		mptcp_for_each_sub(tcp_sk(sk)->mpcb, mptcp) {
> +			sk =3D mptcp_to_sock(mptcp);
> +
>   			mptcp_debug("mptcp_get_avail_list_ipv4: Next sock\n");
>   =

>   			/* Reset length and options buffer, then retrieve
> @@ -289,10 +293,10 @@ static int mptcp_parse_gateway_ipv4(char *gateways)
>   =

>   static int mptcp_binder_subflow_count(const struct mptcp_cb *mpcb)
>   {
> -	struct sock *sk;
> +	struct mptcp_tcp_sock *mptcp;
>   	int i =3D 0;
>   =

> -	mptcp_for_each_sk(mpcb, sk) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
>   		i++;
>   	}
>   =

> diff --git a/net/mptcp/mptcp_coupled.c b/net/mptcp/mptcp_coupled.c
> index a6569f5e20ab..e1040a23e59f 100644
> --- a/net/mptcp/mptcp_coupled.c
> +++ b/net/mptcp/mptcp_coupled.c
> @@ -80,7 +80,7 @@ static inline void mptcp_set_forced(const struct sock *=
meta_sk, bool force)
>   static void mptcp_ccc_recalc_alpha(const struct sock *sk)
>   {
>   	const struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
> -	const struct sock *sub_sk;
> +	const struct mptcp_tcp_sock *mptcp;
>   	int best_cwnd =3D 0, best_rtt =3D 0, can_send =3D 0;
>   	u64 max_numerator =3D 0, sum_denominator =3D 0, alpha =3D 1;
>   =

> @@ -90,7 +90,8 @@ static void mptcp_ccc_recalc_alpha(const struct sock *s=
k)
>   	/* Do regular alpha-calculation for multiple subflows */
>   =

>   	/* Find the max numerator of the alpha-calculation */
> -	mptcp_for_each_sk(mpcb, sub_sk) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		const struct sock *sub_sk =3D mptcp_to_sock(mptcp);
>   		struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
>   		u64 tmp;
>   =

> @@ -118,7 +119,8 @@ static void mptcp_ccc_recalc_alpha(const struct sock =
*sk)
>   		goto exit;
>   =

>   	/* Calculate the denominator */
> -	mptcp_for_each_sk(mpcb, sub_sk) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		const struct sock *sub_sk =3D mptcp_to_sock(mptcp);
>   		struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
>   =

>   		if (!mptcp_ccc_sk_can_send(sub_sk))
> @@ -132,7 +134,8 @@ static void mptcp_ccc_recalc_alpha(const struct sock =
*sk)
>   	sum_denominator *=3D sum_denominator;
>   	if (unlikely(!sum_denominator)) {
>   		pr_err("%s: sum_denominator =3D=3D 0\n", __func__);
> -		mptcp_for_each_sk(mpcb, sub_sk) {
> +		mptcp_for_each_sub(mpcb, mptcp) {
> +			const struct sock *sub_sk =3D mptcp_to_sock(mptcp);
>   			struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
>   			pr_err("%s: pi:%d, state:%d\n, rtt:%u, cwnd: %u",
>   			       __func__, sub_tp->mptcp->path_index,
> diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
> index 9237a73ec174..fe824649bcc3 100644
> --- a/net/mptcp/mptcp_ctrl.c
> +++ b/net/mptcp/mptcp_ctrl.c
> @@ -553,10 +553,12 @@ void mptcp_hash_remove_bh(struct tcp_sock *meta_tp)
>   struct sock *mptcp_select_ack_sock(const struct sock *meta_sk)
>   {
>   	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
> -	struct sock *sk, *rttsk =3D NULL, *lastsk =3D NULL;
> +	struct sock *rttsk =3D NULL, *lastsk =3D NULL;
>   	u32 min_time =3D 0, last_active =3D 0;
> +	struct mptcp_tcp_sock *mptcp;
>   =

> -	mptcp_for_each_sk(meta_tp->mpcb, sk) {
> +	mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>   		struct tcp_sock *tp =3D tcp_sk(sk);
>   		u32 elapsed;
>   =

> @@ -689,7 +691,8 @@ void mptcp_sock_destruct(struct sock *sk)
>   void mptcp_destroy_sock(struct sock *sk)
>   {
>   	if (is_meta_sk(sk)) {
> -		struct sock *sk_it, *tmpsk;
> +		struct mptcp_tcp_sock *mptcp;
> +		struct hlist_node *tmp;
>   =

>   		__skb_queue_purge(&tcp_sk(sk)->mpcb->reinject_queue);
>   =

> @@ -699,7 +702,9 @@ void mptcp_destroy_sock(struct sock *sk)
>   		 * not have been closed properly (as we are waiting for the
>   		 * DATA_ACK of the DATA_FIN).
>   		 */
> -		mptcp_for_each_sk_safe(tcp_sk(sk)->mpcb, sk_it, tmpsk) {
> +		mptcp_for_each_sub_safe(tcp_sk(sk)->mpcb, mptcp, tmp) {
> +			struct sock *sk_it =3D mptcp_to_sock(mptcp);
> +
>   			/* Already did call tcp_close - waiting for graceful
>   			 * closure, or if we are retransmitting fast-close on
>   			 * the subflow. The reset (or timeout) will kill the
> @@ -1281,6 +1286,7 @@ static int mptcp_alloc_mpcb(struct sock *meta_sk, _=
_u64 remote_key,
>   	INIT_LIST_HEAD(&mpcb->tw_list);
>   =

>   	INIT_HLIST_HEAD(&mpcb->callback_list);
> +	INIT_HLIST_HEAD(&mpcb->conn_list);
>   	spin_lock_init(&mpcb->mpcb_list_lock);
>   =

>   	mptcp_mpcb_inherit_sockopts(meta_sk, master_sk);
> @@ -1370,8 +1376,12 @@ int mptcp_add_sock(struct sock *meta_sk, struct so=
ck *sk, u8 loc_id, u8 rem_id,
>   	sock_hold(meta_sk);
>   	refcount_inc(&mpcb->mpcb_refcnt);
>   =

> -	tp->mptcp->next =3D mpcb->connection_list;
> -	mpcb->connection_list =3D tp;
> +	local_bh_disable();
> +	spin_lock(&mpcb->mpcb_list_lock);
> +	hlist_add_head_rcu(&tp->mptcp->node, &mpcb->conn_list);
> +	spin_unlock(&mpcb->mpcb_list_lock);
> +	local_bh_enable();
> +
>   	tp->mptcp->attached =3D 1;
>   =

>   	atomic_add(atomic_read(&((struct sock *)tp)->sk_rmem_alloc),
> @@ -1415,14 +1425,13 @@ int mptcp_add_sock(struct sock *meta_sk, struct s=
ock *sk, u8 loc_id, u8 rem_id,
>   =

>   void mptcp_del_sock(struct sock *sk)
>   {
> -	struct tcp_sock *tp =3D tcp_sk(sk), *tp_prev;
> +	struct tcp_sock *tp =3D tcp_sk(sk);
>   	struct mptcp_cb *mpcb;
>   =

>   	if (!tp->mptcp || !tp->mptcp->attached)
>   		return;
>   =

>   	mpcb =3D tp->mpcb;
> -	tp_prev =3D mpcb->connection_list;
>   =

>   	if (mpcb->sched_ops->release)
>   		mpcb->sched_ops->release(sk);
> @@ -1434,17 +1443,10 @@ void mptcp_del_sock(struct sock *sk)
>   		    __func__, mpcb->mptcp_loc_token, tp->mptcp->path_index,
>   		    sk->sk_state, is_meta_sk(sk));
>   =

> -	if (tp_prev =3D=3D tp) {
> -		mpcb->connection_list =3D tp->mptcp->next;
> -	} else {
> -		for (; tp_prev && tp_prev->mptcp->next; tp_prev =3D tp_prev->mptcp->ne=
xt) {
> -			if (tp_prev->mptcp->next =3D=3D tp) {
> -				tp_prev->mptcp->next =3D tp->mptcp->next;
> -				break;
> -			}
> -		}
> -	}
> -	tp->mptcp->next =3D NULL;
> +	spin_lock(&mpcb->mpcb_list_lock);
> +	hlist_del_init_rcu(&tp->mptcp->node);
> +	spin_unlock(&mpcb->mpcb_list_lock);
> +
>   	tp->mptcp->attached =3D 0;
>   	mpcb->path_index_bits &=3D ~(1 << tp->mptcp->path_index);
>   =

> @@ -1491,8 +1493,8 @@ void mptcp_update_metasocket(const struct sock *met=
a_sk)
>   void mptcp_cleanup_rbuf(struct sock *meta_sk, int copied)
>   {
>   	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
> -	struct sock *sk;
>   	bool recheck_rcv_window =3D false;
> +	struct mptcp_tcp_sock *mptcp;
>   	__u32 rcv_window_now =3D 0;
>   =

>   	if (copied > 0 && !(meta_sk->sk_shutdown & RCV_SHUTDOWN)) {
> @@ -1503,7 +1505,8 @@ void mptcp_cleanup_rbuf(struct sock *meta_sk, int c=
opied)
>   			recheck_rcv_window =3D true;
>   	}
>   =

> -	mptcp_for_each_sk(meta_tp->mpcb, sk) {
> +	mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>   		struct tcp_sock *tp =3D tcp_sk(sk);
>   		const struct inet_connection_sock *icsk =3D inet_csk(sk);
>   =

> @@ -1690,10 +1693,13 @@ EXPORT_SYMBOL(mptcp_sub_force_close);
>    */
>   void mptcp_update_sndbuf(const struct tcp_sock *tp)
>   {
> -	struct sock *meta_sk =3D tp->meta_sk, *sk;
> +	struct sock *meta_sk =3D tp->meta_sk;
>   	int new_sndbuf =3D 0, old_sndbuf =3D meta_sk->sk_sndbuf;
> +	struct mptcp_tcp_sock *mptcp;
> +
> +	mptcp_for_each_sub(tp->mpcb, mptcp) {
> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>   =

> -	mptcp_for_each_sk(tp->mpcb, sk) {
>   		if (!mptcp_sk_can_send(sk))
>   			continue;
>   =

> @@ -1722,8 +1728,8 @@ void mptcp_update_sndbuf(const struct tcp_sock *tp)
>   void mptcp_close(struct sock *meta_sk, long timeout)
>   {
>   	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
> -	struct sock *sk_it, *tmpsk;
>   	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
> +	struct mptcp_tcp_sock *mptcp;
>   	struct sk_buff *skb;
>   	int data_was_unread =3D 0;
>   	int state;
> @@ -1756,7 +1762,12 @@ void mptcp_close(struct sock *meta_sk, long timeou=
t)
>   =

>   	/* If socket has been already reset (e.g. in tcp_reset()) - kill it. */
>   	if (meta_sk->sk_state =3D=3D TCP_CLOSE) {
> -		mptcp_for_each_sk_safe(mpcb, sk_it, tmpsk) {
> +		struct mptcp_tcp_sock *mptcp;
> +		struct hlist_node *tmp;
> +
> +		mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
> +			struct sock *sk_it =3D mptcp_to_sock(mptcp);
> +
>   			if (tcp_sk(sk_it)->send_mp_fclose)
>   				continue;
>   			mptcp_sub_close(sk_it, 0);
> @@ -1777,10 +1788,14 @@ void mptcp_close(struct sock *meta_sk, long timeo=
ut)
>   	} else if (tcp_close_state(meta_sk)) {
>   		mptcp_send_fin(meta_sk);
>   	} else if (meta_tp->snd_una =3D=3D meta_tp->write_seq) {
> +		struct mptcp_tcp_sock *mptcp;
> +		struct hlist_node *tmp;
> +
>   		/* The DATA_FIN has been sent and acknowledged
>   		 * (e.g., by sk_shutdown). Close all the other subflows
>   		 */
> -		mptcp_for_each_sk_safe(mpcb, sk_it, tmpsk) {
> +		mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
> +			struct sock *sk_it =3D mptcp_to_sock(mptcp);
>   			unsigned long delay =3D 0;
>   			/* If we are the passive closer, don't trigger
>   			 * subflow-fin until the subflow has been finned
> @@ -1804,7 +1819,9 @@ void mptcp_close(struct sock *meta_sk, long timeout)
>   	/* socket will be freed after mptcp_close - we have to prevent
>   	 * access from the subflows.
>   	 */
> -	mptcp_for_each_sk(mpcb, sk_it) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		struct sock *sk_it =3D mptcp_to_sock(mptcp);
> +
>   		/* Similar to sock_orphan, but we don't set it DEAD, because
>   		 * the callbacks are still set and must be called.
>   		 */
> @@ -1889,8 +1906,9 @@ void mptcp_close(struct sock *meta_sk, long timeout)
>   =

>   void mptcp_disconnect(struct sock *sk)
>   {
> -	struct sock *subsk, *tmpsk;
> +	struct mptcp_tcp_sock *mptcp;
>   	struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct hlist_node *tmp;
>   =

>   	__skb_queue_purge(&tp->mpcb->reinject_queue);
>   =

> @@ -1898,7 +1916,9 @@ void mptcp_disconnect(struct sock *sk)
>   		mptcp_hash_remove_bh(tp);
>   =

>   	local_bh_disable();
> -	mptcp_for_each_sk_safe(tp->mpcb, subsk, tmpsk) {
> +	mptcp_for_each_sub_safe(tp->mpcb, mptcp, tmp) {
> +		struct sock *subsk =3D mptcp_to_sock(mptcp);
> +
>   		/* The socket will get removed from the subsocket-list
>   		 * and made non-mptcp by setting mpc to 0.
>   		 *
> @@ -2582,7 +2602,6 @@ static void mptcp_get_sub_info(struct sock *sk, str=
uct mptcp_sub_info *info)
>   int mptcp_get_info(const struct sock *meta_sk, char __user *optval, int=
 optlen)
>   {
>   	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
> -	struct sock *sk;
>   =

>   	struct mptcp_meta_info meta_info;
>   	struct mptcp_info m_info;
> @@ -2628,16 +2647,17 @@ int mptcp_get_info(const struct sock *meta_sk, ch=
ar __user *optval, int optlen)
>   =

>   	if (m_info.subflows) {
>   		unsigned int len, sub_len =3D 0;
> +		struct mptcp_tcp_sock *mptcp;
>   		char __user *ptr;
>   =

>   		ptr =3D (char __user *)m_info.subflows;
>   		len =3D m_info.sub_len;
>   =

> -		mptcp_for_each_sk(meta_tp->mpcb, sk) {
> +		mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
>   			struct tcp_info t_info;
>   			unsigned int tmp_len;
>   =

> -			tcp_get_info(sk, &t_info);
> +			tcp_get_info(mptcp_to_sock(mptcp), &t_info);
>   =

>   			tmp_len =3D min_t(unsigned int, len, info_len);
>   			len -=3D tmp_len;
> @@ -2657,6 +2677,7 @@ int mptcp_get_info(const struct sock *meta_sk, char=
 __user *optval, int optlen)
>   =

>   	if (m_info.subflow_info) {
>   		unsigned int len, sub_info_len, total_sub_info_len =3D 0;
> +		struct mptcp_tcp_sock *mptcp;
>   		char __user *ptr;
>   =

>   		ptr =3D (char __user *)m_info.subflow_info;
> @@ -2666,11 +2687,11 @@ int mptcp_get_info(const struct sock *meta_sk, ch=
ar __user *optval, int optlen)
>   				     sizeof(struct mptcp_sub_info));
>   		m_info.sub_info_len =3D sub_info_len;
>   =

> -		mptcp_for_each_sk(meta_tp->mpcb, sk) {
> +		mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
>   			struct mptcp_sub_info m_sub_info;
>   			unsigned int tmp_len;
>   =

> -			mptcp_get_sub_info(sk, &m_sub_info);
> +			mptcp_get_sub_info(mptcp_to_sock(mptcp), &m_sub_info);
>   =

>   			tmp_len =3D min_t(unsigned int, len, sub_info_len);
>   			len -=3D tmp_len;
> diff --git a/net/mptcp/mptcp_fullmesh.c b/net/mptcp/mptcp_fullmesh.c
> index d29102a1dffb..53c1ba7319f5 100644
> --- a/net/mptcp/mptcp_fullmesh.c
> +++ b/net/mptcp/mptcp_fullmesh.c
> @@ -903,8 +903,9 @@ static void mptcp_address_worker(struct work_struct *=
work)
>   			}
>   =

>   			if (event->code =3D=3D MPTCP_EVENT_DEL) {
> -				struct sock *sk, *tmpsk;
> +				struct mptcp_tcp_sock *mptcp;
>   				struct mptcp_loc_addr *mptcp_local;
> +				struct hlist_node *tmp;
>   				bool found =3D false;
>   =

>   				mptcp_local =3D rcu_dereference_bh(fm_ns->local);
> @@ -914,7 +915,9 @@ static void mptcp_address_worker(struct work_struct *=
work)
>   					update_addr_bitfields(meta_sk, mptcp_local);
>   =

>   				/* Look for the socket and remove him */
> -				mptcp_for_each_sk_safe(mpcb, sk, tmpsk) {
> +				mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
> +					struct sock *sk =3D mptcp_to_sock(mptcp);
> +
>   					if ((event->family =3D=3D AF_INET6 &&
>   					     (sk->sk_family =3D=3D AF_INET ||
>   					      mptcp_v6_is_v4_mapped(sk))) ||
> @@ -964,9 +967,10 @@ static void mptcp_address_worker(struct work_struct =
*work)
>   			}
>   =

>   			if (event->code =3D=3D MPTCP_EVENT_MOD) {
> -				struct sock *sk;
> +				struct mptcp_tcp_sock *mptcp;
>   =

> -				mptcp_for_each_sk(mpcb, sk) {
> +				mptcp_for_each_sub(mpcb, mptcp) {
> +					struct sock *sk =3D mptcp_to_sock(mptcp);
>   					struct tcp_sock *tp =3D tcp_sk(sk);
>   					if (event->family =3D=3D AF_INET &&
>   					    (sk->sk_family =3D=3D AF_INET ||
> @@ -1455,8 +1459,9 @@ static void full_mesh_release_sock(struct sock *met=
a_sk)
>   	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
>   	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
>   	const struct mptcp_fm_ns *fm_ns =3D fm_get_ns(sock_net(meta_sk));
> -	struct sock *sk, *tmpsk;
>   	bool meta_v4 =3D meta_sk->sk_family =3D=3D AF_INET;
> +	struct mptcp_tcp_sock *mptcp;
> +	struct hlist_node *tmp;
>   	int i;
>   =

>   	rcu_read_lock_bh();
> @@ -1470,7 +1475,8 @@ static void full_mesh_release_sock(struct sock *met=
a_sk)
>   		struct in_addr ifa =3D mptcp_local->locaddr4[i].addr;
>   		bool found =3D false;
>   =

> -		mptcp_for_each_sk(mpcb, sk) {
> +		mptcp_for_each_sub(mpcb, mptcp) {
> +			struct sock *sk =3D mptcp_to_sock(mptcp);
>   			struct tcp_sock *tp =3D tcp_sk(sk);
>   =

>   			if (sk->sk_family =3D=3D AF_INET6 &&
> @@ -1491,6 +1497,8 @@ static void full_mesh_release_sock(struct sock *met=
a_sk)
>   		}
>   =

>   		if (!found) {
> +			struct sock *sk;
> +
>   			fmp->add_addr++;
>   			mpcb->addr_signal =3D 1;
>   =

> @@ -1511,7 +1519,8 @@ static void full_mesh_release_sock(struct sock *met=
a_sk)
>   		struct in6_addr ifa =3D mptcp_local->locaddr6[i].addr;
>   		bool found =3D false;
>   =

> -		mptcp_for_each_sk(mpcb, sk) {
> +		mptcp_for_each_sub(mpcb, mptcp) {
> +			struct sock *sk =3D mptcp_to_sock(mptcp);
>   			struct tcp_sock *tp =3D tcp_sk(sk);
>   =

>   			if (sk->sk_family =3D=3D AF_INET ||
> @@ -1532,6 +1541,8 @@ static void full_mesh_release_sock(struct sock *met=
a_sk)
>   		}
>   =

>   		if (!found) {
> +			struct sock *sk;
> +
>   			fmp->add_addr++;
>   			mpcb->addr_signal =3D 1;
>   =

> @@ -1546,7 +1557,8 @@ static void full_mesh_release_sock(struct sock *met=
a_sk)
>   #endif
>   =

>   	/* Now, detect address-removals */
> -	mptcp_for_each_sk_safe(mpcb, sk, tmpsk) {
> +	mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>   		bool shall_remove =3D true;
>   =

>   		if (sk->sk_family =3D=3D AF_INET || mptcp_v6_is_v4_mapped(sk)) {
> diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
> index 211605347f70..64b0265bfd06 100644
> --- a/net/mptcp/mptcp_input.c
> +++ b/net/mptcp/mptcp_input.c
> @@ -126,12 +126,14 @@ static void mptcp_clean_rtx_queue(struct sock *meta=
_sk, u32 prior_snd_una)
>   		tcp_rtx_queue_unlink(skb, meta_sk);
>   =

>   		if (mptcp_is_data_fin(skb)) {
> -			struct sock *sk_it, *sk_tmp;
> +			struct mptcp_tcp_sock *mptcp;
> +			struct hlist_node *tmp;
>   =

>   			/* DATA_FIN has been acknowledged - now we can close
>   			 * the subflows
>   			 */
> -			mptcp_for_each_sk_safe(mpcb, sk_it, sk_tmp) {
> +			mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
> +				struct sock *sk_it =3D mptcp_to_sock(mptcp);
>   				unsigned long delay =3D 0;
>   =

>   				/* If we are the passive closer, don't trigger
> @@ -347,6 +349,7 @@ static int mptcp_verif_dss_csum(struct sock *sk)
>   =

>   	/* Now, checksum must be 0 */
>   	if (unlikely(csum_fold(csum_tcp))) {
> +		struct mptcp_tcp_sock *mptcp;
>   		struct sock *sk_it =3D NULL;
>   =

>   		pr_err("%s csum is wrong: %#x tcp-seq %u dss_csum_added %d overflowed=
 %d iterations %d\n",
> @@ -362,7 +365,9 @@ static int mptcp_verif_dss_csum(struct sock *sk)
>   		tp->mpcb->csum_cutoff_seq =3D tp->mptcp->map_data_seq;
>   =

>   		/* Search for another subflow that is fully established */
> -		mptcp_for_each_sk(tp->mpcb, sk_it) {
> +		mptcp_for_each_sub(tp->mpcb, mptcp) {
> +			sk_it =3D mptcp_to_sock(mptcp);
> +
>   			if (sk_it !=3D sk &&
>   			    tcp_sk(sk_it)->mptcp->fully_established)
>   				break;
> @@ -1308,12 +1313,15 @@ int mptcp_do_join_short(struct sk_buff *skb,
>    */
>   void mptcp_fin(struct sock *meta_sk)
>   {
> -	struct sock *sk =3D NULL, *sk_it;
> +	struct sock *sk =3D NULL;
>   	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
>   	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
> +	struct mptcp_tcp_sock *mptcp;
>   	unsigned char state;
>   =

> -	mptcp_for_each_sk(mpcb, sk_it) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		struct sock *sk_it =3D mptcp_to_sock(mptcp);
> +
>   		if (tcp_sk(sk_it)->mptcp->path_index =3D=3D mpcb->dfin_path_index) {
>   			sk =3D sk_it;
>   			break;
> @@ -1585,9 +1593,12 @@ void mptcp_clean_rtx_infinite(const struct sk_buff=
 *skb, struct sock *sk)
>   =

>   static void mptcp_send_reset_rem_id(const struct mptcp_cb *mpcb, u8 rem=
_id)
>   {
> -	struct sock *sk_it, *tmpsk;
> +	struct mptcp_tcp_sock *mptcp;
> +	struct hlist_node *tmp;
> +
> +	mptcp_for_each_sub_safe(mpcb, mptcp, tmp) {
> +		struct sock *sk_it =3D mptcp_to_sock(mptcp);
>   =

> -	mptcp_for_each_sk_safe(mpcb, sk_it, tmpsk) {
>   		if (tcp_sk(sk_it)->mptcp->rem_id =3D=3D rem_id) {
>   			mptcp_reinject_data(sk_it, 0);
>   			mptcp_send_reset(sk_it);
> @@ -1892,13 +1903,15 @@ void tcp_parse_mptcp_options(const struct sk_buff=
 *skb,
>   bool mptcp_check_rtt(const struct tcp_sock *tp, int time)
>   {
>   	struct mptcp_cb *mpcb =3D tp->mpcb;
> -	struct sock *sk;
> +	struct mptcp_tcp_sock *mptcp;
>   	u32 rtt_max =3D 0;
>   =

>   	/* In MPTCP, we take the max delay across all flows,
>   	 * in order to take into account meta-reordering buffers.
>   	 */
> -	mptcp_for_each_sk(mpcb, sk) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		struct sock *sk =3D mptcp_to_sock(mptcp);
> +
>   		if (!mptcp_sk_can_recv(sk))
>   			continue;
>   =

> @@ -2173,9 +2186,9 @@ bool mptcp_handle_options(struct sock *sk, const st=
ruct tcphdr *th,
>   		if (mopt->saw_low_prio =3D=3D 1) {
>   			tp->mptcp->rcv_low_prio =3D mopt->low_prio;
>   		} else {
> -			struct sock *sk_it;
> -			mptcp_for_each_sk(tp->mpcb, sk_it) {
> -				struct mptcp_tcp_sock *mptcp =3D tcp_sk(sk_it)->mptcp;
> +			struct mptcp_tcp_sock *mptcp;
> +
> +			mptcp_for_each_sub(tp->mpcb, mptcp) {
>   				if (mptcp->rem_id =3D=3D mopt->prio_addr_id)
>   					mptcp->rcv_low_prio =3D mopt->low_prio;
>   			}
> @@ -2359,7 +2372,7 @@ bool mptcp_should_expand_sndbuf(const struct sock *=
sk)
>   {
>   	const struct sock *meta_sk =3D mptcp_meta_sk(sk);
>   	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
> -	const struct sock *sk_it;
> +	const struct mptcp_tcp_sock *mptcp;
>   =

>   	/* We circumvent this check in tcp_check_space, because we want to
>   	 * always call sk_write_space. So, we reproduce the check here.
> @@ -2385,8 +2398,9 @@ bool mptcp_should_expand_sndbuf(const struct sock *=
sk)
>   	/* For MPTCP we look for a subsocket that could send data.
>   	 * If we found one, then we update the send-buffer.
>   	 */
> -	mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
> -		struct tcp_sock *tp_it =3D tcp_sk(sk_it);
> +	mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
> +		const struct sock *sk_it =3D mptcp_to_sock(mptcp);
> +		const struct tcp_sock *tp_it =3D tcp_sk(sk_it);
>   =

>   		if (!mptcp_sk_can_send(sk_it))
>   			continue;
> diff --git a/net/mptcp/mptcp_ndiffports.c b/net/mptcp/mptcp_ndiffports.c
> index fe73ade7ba24..4219e9489655 100644
> --- a/net/mptcp/mptcp_ndiffports.c
> +++ b/net/mptcp/mptcp_ndiffports.c
> @@ -20,10 +20,10 @@ MODULE_PARM_DESC(num_subflows, "choose the number of =
subflows per MPTCP connecti
>   =

>   static int mptcp_ndiffports_subflow_count(const struct mptcp_cb *mpcb)
>   {
> -	struct sock *sk;
> +	struct mptcp_tcp_sock *mptcp;
>   	int i =3D 0;
>   =

> -	mptcp_for_each_sk(mpcb, sk) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
>   		i++;
>   	}
>   =

> diff --git a/net/mptcp/mptcp_olia.c b/net/mptcp/mptcp_olia.c
> index 9f61e1eff65a..c44eb9208581 100644
> --- a/net/mptcp/mptcp_olia.c
> +++ b/net/mptcp/mptcp_olia.c
> @@ -61,10 +61,11 @@ static u32 mptcp_get_crt_cwnd(struct sock *sk)
>   /* return the dominator of the first term of  the increasing term */
>   static u64 mptcp_get_rate(const struct mptcp_cb *mpcb , u32 path_rtt)
>   {
> -	struct sock *sk;
> +	struct mptcp_tcp_sock *mptcp;
>   	u64 rate =3D 1; /* We have to avoid a zero-rate because it is used as =
a divisor */
>   =

> -	mptcp_for_each_sk(mpcb, sk) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>   		struct tcp_sock *tp =3D tcp_sk(sk);
>   		u64 scaled_num;
>   		u32 tmp_cwnd;
> @@ -83,10 +84,11 @@ static u64 mptcp_get_rate(const struct mptcp_cb *mpcb=
 , u32 path_rtt)
>   /* find the maximum cwnd, used to find set M */
>   static u32 mptcp_get_max_cwnd(const struct mptcp_cb *mpcb)
>   {
> -	struct sock *sk;
> +	struct mptcp_tcp_sock *mptcp;
>   	u32 best_cwnd =3D 0;
>   =

> -	mptcp_for_each_sk(mpcb, sk) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>   		u32 tmp_cwnd;
>   =

>   		if (!mptcp_olia_sk_can_send(sk))
> @@ -101,6 +103,7 @@ static u32 mptcp_get_max_cwnd(const struct mptcp_cb *=
mpcb)
>   =

>   static void mptcp_get_epsilon(const struct mptcp_cb *mpcb)
>   {
> +	struct mptcp_tcp_sock *mptcp;
>   	struct mptcp_olia *ca;
>   	struct tcp_sock *tp;
>   	struct sock *sk;
> @@ -113,7 +116,8 @@ static void mptcp_get_epsilon(const struct mptcp_cb *=
mpcb)
>   	max_cwnd =3D mptcp_get_max_cwnd(mpcb);
>   =

>   	/* find the best path */
> -	mptcp_for_each_sk(mpcb, sk) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		sk =3D mptcp_to_sock(mptcp);
>   		tp =3D tcp_sk(sk);
>   		ca =3D inet_csk_ca(sk);
>   =

> @@ -135,7 +139,8 @@ static void mptcp_get_epsilon(const struct mptcp_cb *=
mpcb)
>   =

>   	/* TODO - integrate this here in mptcp_get_max_cwnd and in the previou=
s loop */
>   	/* find the size of M and B_not_M */
> -	mptcp_for_each_sk(mpcb, sk) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		sk =3D mptcp_to_sock(mptcp);
>   		tp =3D tcp_sk(sk);
>   		ca =3D inet_csk_ca(sk);
>   =

> @@ -156,7 +161,8 @@ static void mptcp_get_epsilon(const struct mptcp_cb *=
mpcb)
>   	}
>   =

>   	/* check if the path is in M or B_not_M and set the value of epsilon a=
ccordingly */
> -	mptcp_for_each_sk(mpcb, sk) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		sk =3D mptcp_to_sock(mptcp);
>   		tp =3D tcp_sk(sk);
>   		ca =3D inet_csk_ca(sk);
>   =

> diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
> index cc1a4f7d39e9..29a7ab309751 100644
> --- a/net/mptcp/mptcp_output.c
> +++ b/net/mptcp/mptcp_output.c
> @@ -647,7 +647,6 @@ int mptcp_write_wakeup(struct sock *meta_sk, int mib)
>   {
>   	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
>   	struct sk_buff *skb;
> -	struct sock *sk_it;
>   	int ans =3D 0;
>   =

>   	if (meta_sk->sk_state =3D=3D TCP_CLOSE)
> @@ -704,17 +703,22 @@ int mptcp_write_wakeup(struct sock *meta_sk, int mi=
b)
>   =

>   		return 0;
>   	} else {
> +		struct mptcp_tcp_sock *mptcp;
> +

detail: that's strange to see the declaration of the variable just =

before the flag :)
But that's correct.

>   window_probe:
>   		if (between(meta_tp->snd_up, meta_tp->snd_una + 1,
>   			    meta_tp->snd_una + 0xFFFF)) {
> -			mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
> +			mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
> +				struct sock *sk_it =3D mptcp_to_sock(mptcp);
> +
>   				if (mptcp_sk_can_send_ack(sk_it))
>   					tcp_xmit_probe_skb(sk_it, 1, mib);
>   			}
>   		}
>   =

>   		/* At least one of the tcp_xmit_probe_skb's has to succeed */
> -		mptcp_for_each_sk(meta_tp->mpcb, sk_it) {
> +		mptcp_for_each_sub(meta_tp->mpcb, mptcp) {
> +			struct sock *sk_it =3D mptcp_to_sock(mptcp);
>   			int ret;
>   =

>   			if (!mptcp_sk_can_send_ack(sk_it))
> @@ -732,6 +736,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned =
int mss_now, int nonagle,
>   		     int push_one, gfp_t gfp)
>   {
>   	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk), *subtp;
> +	struct mptcp_tcp_sock *mptcp;
>   	struct sock *subsk =3D NULL;
>   	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
>   	struct sk_buff *skb;
> @@ -856,7 +861,8 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned =
int mss_now, int nonagle,
>   			break;
>   	}
>   =

> -	mptcp_for_each_sk(mpcb, subsk) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		subsk =3D mptcp_to_sock(mptcp);
>   		subtp =3D tcp_sk(subsk);
>   =

>   		if (!(path_mask & mptcp_pi_to_flag(subtp->mptcp->path_index)))
> @@ -1353,7 +1359,7 @@ void mptcp_send_active_reset(struct sock *meta_sk, =
gfp_t priority)
>   	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
>   	struct sock *sk;
>   =

> -	if (!mpcb->connection_list)
> +	if (hlist_empty(&mpcb->conn_list))
>   		return;
>   =

>   	WARN_ON(meta_tp->send_mp_fclose);
> @@ -1728,10 +1734,11 @@ void mptcp_select_initial_window(const struct soc=
k *sk, int __space, __u32 mss,
>   static inline u64 mptcp_calc_rate(const struct sock *meta_sk, unsigned =
int mss,
>   				  unsigned int (*mss_cb)(struct sock *sk))
>   {
> -	struct sock *sk;
> +	struct mptcp_tcp_sock *mptcp;
>   	u64 rate =3D 0;
>   =

> -	mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
> +	mptcp_for_each_sub(tcp_sk(meta_sk)->mpcb, mptcp) {
> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>   		struct tcp_sock *tp =3D tcp_sk(sk);
>   		int this_mss;
>   		u64 this_rate;
> @@ -1783,11 +1790,12 @@ static inline u64 mptcp_calc_rate(const struct so=
ck *meta_sk, unsigned int mss,
>   static unsigned int __mptcp_current_mss(const struct sock *meta_sk,
>   					unsigned int (*mss_cb)(struct sock *sk))
>   {
> +	struct mptcp_tcp_sock *mptcp;
>   	unsigned int mss =3D 0;
>   	u64 rate =3D 0;
> -	struct sock *sk;
>   =

> -	mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
> +	mptcp_for_each_sub(tcp_sk(meta_sk)->mpcb, mptcp) {
> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>   		int this_mss;
>   		u64 this_rate;
>   =

> @@ -1852,14 +1860,16 @@ int mptcp_select_size(const struct sock *meta_sk,=
 bool sg, bool first_skb, bool
>   =

>   int mptcp_check_snd_buf(const struct tcp_sock *tp)
>   {
> -	const struct sock *sk;
> +	const struct mptcp_tcp_sock *mptcp;
>   	u32 rtt_max =3D tp->srtt_us;
>   	u64 bw_est;
>   =

>   	if (!tp->srtt_us)
>   		return tp->reordering + 1;
>   =

> -	mptcp_for_each_sk(tp->mpcb, sk) {
> +	mptcp_for_each_sub(tp->mpcb, mptcp) {
> +		const struct sock *sk =3D mptcp_to_sock(mptcp);
> +
>   		if (!mptcp_sk_can_send(sk))
>   			continue;
>   =

> @@ -1877,11 +1887,13 @@ int mptcp_check_snd_buf(const struct tcp_sock *tp)
>   unsigned int mptcp_xmit_size_goal(const struct sock *meta_sk, u32 mss_n=
ow,
>   				  int large_allowed)
>   {
> -	struct sock *sk;
>   	u32 xmit_size_goal =3D 0;
>   =

>   	if (large_allowed && mptcp_sk_can_gso(meta_sk)) {
> -		mptcp_for_each_sk(tcp_sk(meta_sk)->mpcb, sk) {
> +		struct mptcp_tcp_sock *mptcp;
> +
> +		mptcp_for_each_sub(tcp_sk(meta_sk)->mpcb, mptcp) {
> +			struct sock *sk =3D mptcp_to_sock(mptcp);
>   			int this_size_goal;
>   =

>   			if (!mptcp_sk_can_send(sk))
> diff --git a/net/mptcp/mptcp_redundant.c b/net/mptcp/mptcp_redundant.c
> index 001a3f8a974d..6c68a8a071c1 100644
> --- a/net/mptcp/mptcp_redundant.c
> +++ b/net/mptcp/mptcp_redundant.c
> @@ -52,10 +52,12 @@ static bool redsched_get_active_valid_sks(struct sock=
 *meta_sk)
>   {
>   	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
>   	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
> -	struct sock *sk;
> +	struct mptcp_tcp_sock *mptcp;
>   	int active_valid_sks =3D 0;
>   =

> -	mptcp_for_each_sk(mpcb, sk) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		struct sock *sk =3D mptcp_to_sock(mptcp);
> +
>   		if (subflow_is_active((struct tcp_sock *)sk) &&
>   		    !mptcp_is_def_unavailable(sk))
>   			active_valid_sks++;
> @@ -88,6 +90,10 @@ static bool redsched_use_subflow(struct sock *meta_sk,
>   	return false;
>   }
>   =

> +#define mptcp_entry_next_rcu(__mptcp)						\
> +	hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(			\
> +		&(__mptcp)->node)), struct mptcp_tcp_sock, node)
> +
>   static struct sock *redundant_get_subflow(struct sock *meta_sk,
>   					  struct sk_buff *skb,
>   					  bool zero_wnd_test)
> @@ -95,14 +101,16 @@ static struct sock *redundant_get_subflow(struct soc=
k *meta_sk,
>   	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
>   	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
>   	struct redsched_cb_data *cb_data =3D redsched_get_cb_data(meta_tp);
> -	struct tcp_sock *first_tp =3D cb_data->next_subflow;
> -	struct sock *sk;
> -	struct tcp_sock *tp;
> +	struct tcp_sock *first_tp =3D cb_data->next_subflow, *tp;
> +	struct mptcp_tcp_sock *mptcp;
> +	int found =3D 0;
>   =

>   	/* Answer data_fin on same subflow */
>   	if (meta_sk->sk_shutdown & RCV_SHUTDOWN &&
>   	    skb && mptcp_is_data_fin(skb)) {
> -		mptcp_for_each_sk(mpcb, sk) {
> +		mptcp_for_each_sub(mpcb, mptcp) {
> +			struct sock *sk =3D mptcp_to_sock(mptcp);
> +
>   			if (tcp_sk(sk)->mptcp->path_index =3D=3D
>   				mpcb->dfin_path_index &&
>   			    mptcp_is_available(sk, skb, zero_wnd_test))
> @@ -110,26 +118,58 @@ static struct sock *redundant_get_subflow(struct so=
ck *meta_sk,
>   		}
>   	}
>   =

> -	if (!first_tp)
> -		first_tp =3D mpcb->connection_list;
> +	if (!first_tp && !hlist_empty(&mpcb->conn_list)) {
> +		first_tp =3D hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(&mpc=
b->conn_list)),
> +					    struct mptcp_tcp_sock, node)->tp;
> +	}
>   	tp =3D first_tp;
>   =

> -	/* still NULL (no subflow in connection_list?) */
> +	/* still NULL (no subflow in conn_list?) */
>   	if (!first_tp)
>   		return NULL;
>   =

>   	/* Search for any subflow to send it */
> -	do {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		/* We go up to the subflow 'tp', then we pick the next one. */
> +		if (!found)
> +			continue;

I guess I missed something in the patch but found will always be false =

here, we will never do the rest, no?

> +		if (tp =3D=3D mptcp->tp) {
> +			found =3D 1;
> +			continue; > +		}
> +		tp =3D mptcp->tp;
> +
>   		if (mptcp_is_available((struct sock *)tp, skb,
>   				       zero_wnd_test)) {
> -			cb_data->next_subflow =3D tp->mptcp->next;
> +			struct mptcp_tcp_sock *mptcp;
> +
> +			mptcp =3D mptcp_entry_next_rcu(tp->mptcp);
> +			if (mptcp)
> +				cb_data->next_subflow =3D mptcp->tp;
> +			else
> +				cb_data->next_subflow =3D NULL;
>   			return (struct sock *)tp;
>   		}

Should we not break here?

> +	}
> +
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		tp =3D mptcp->tp;
> +
> +		if (tp =3D=3D first_tp)
> +			break;
> +
> +		if (mptcp_is_available((struct sock *)tp, skb,
> +				       zero_wnd_test)) {
> +			struct mptcp_tcp_sock *mptcp;
>   =

> -		tp =3D tp->mptcp->next;
> -		if (!tp)
> -			tp =3D mpcb->connection_list;
> -	} while (tp !=3D first_tp);
> +			mptcp =3D mptcp_entry_next_rcu(tp->mptcp);
> +			if (mptcp)
> +				cb_data->next_subflow =3D mptcp->tp;
> +			else
> +				cb_data->next_subflow =3D NULL;
> +			return (struct sock *)tp;
> +		}
> +	}

I am not sure I understand why you need two mptcp_for_each_sub here. May =

you add a comment? :)

>   =

>   	/* No space */
>   	return NULL;
> @@ -190,10 +230,11 @@ static struct sk_buff *redundant_next_segment(struc=
t sock *meta_sk,
>   	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
>   	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
>   	struct redsched_cb_data *cb_data =3D redsched_get_cb_data(meta_tp);
> -	struct tcp_sock *first_tp =3D cb_data->next_subflow;
> -	struct tcp_sock *tp;
> -	struct sk_buff *skb;
> +	struct tcp_sock *first_tp =3D cb_data->next_subflow, *tp;
> +	struct mptcp_tcp_sock *mptcp;
>   	int active_valid_sks =3D -1;
> +	struct sk_buff *skb;
> +	int found =3D 0;
>   =

>   	/* As we set it, we have to reset it as well. */
>   	*limit =3D 0;
> @@ -215,10 +256,12 @@ static struct sk_buff *redundant_next_segment(struc=
t sock *meta_sk,
>   =

>   	/* Then try indistinctly redundant and normal skbs */
>   =

> -	if (!first_tp)
> -		first_tp =3D mpcb->connection_list;
> +	if (!first_tp && !hlist_empty(&mpcb->conn_list)) {
> +		first_tp =3D hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(&mpc=
b->conn_list)),
> +					    struct mptcp_tcp_sock, node)->tp;
> +	}
>   =

> -	/* still NULL (no subflow in connection_list?) */
> +	/* still NULL (no subflow in conn_list?) */
>   	if (!first_tp)
>   		return NULL;
>   =

> @@ -226,9 +269,17 @@ static struct sk_buff *redundant_next_segment(struct=
 sock *meta_sk,
>   =

>   	*reinject =3D 0;
>   	active_valid_sks =3D redsched_get_active_valid_sks(meta_sk);
> -	do {
> +	mptcp_for_each_sub(mpcb, mptcp) {
>   		struct redsched_sock_data *sk_data;
>   =

> +		if (!found)
> +			continue;

Same here, I guess I missed a goto somewhere but found will always be 0 =

here.

> +		if (tp =3D=3D mptcp->tp) {
> +			found =3D 1;
> +			continue;
> +		}
> +
>   		/* Correct the skb pointers of the current subflow */
>   		sk_data =3D redsched_get_sock_data(tp);
>   		redsched_correct_skb_pointers(meta_sk, sk_data);
> @@ -237,20 +288,55 @@ static struct sk_buff *redundant_next_segment(struc=
t sock *meta_sk,
>   						    sk_data->skb, meta_sk);
>   		if (skb && redsched_use_subflow(meta_sk, active_valid_sks, tp,
>   						skb)) {
> +			struct mptcp_tcp_sock *mptcp;
> +
>   			sk_data->skb =3D skb;
>   			sk_data->skb_end_seq =3D TCP_SKB_CB(skb)->end_seq;
> -			cb_data->next_subflow =3D tp->mptcp->next;
> +			mptcp =3D mptcp_entry_next_rcu(tp->mptcp);
> +			if (mptcp)
> +				cb_data->next_subflow =3D mptcp->tp;
> +			else
> +				cb_data->next_subflow =3D NULL;
>   			*subsk =3D (struct sock *)tp;
>   =

>   			if (TCP_SKB_CB(skb)->path_mask)
>   				*reinject =3D -1;
>   			return skb;
>   		}
> +	}
>   =

> -		tp =3D tp->mptcp->next;
> -		if (!tp)
> -			tp =3D mpcb->connection_list;
> -	} while (tp !=3D first_tp);
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		struct redsched_sock_data *sk_data;
> +
> +		tp =3D mptcp->tp;
> +
> +		if (tp =3D=3D first_tp)
> +			break;
> +
> +		/* Correct the skb pointers of the current subflow */
> +		sk_data =3D redsched_get_sock_data(tp);
> +		redsched_correct_skb_pointers(meta_sk, sk_data);
> +
> +		skb =3D redundant_next_skb_from_queue(&meta_sk->sk_write_queue,
> +						    sk_data->skb, meta_sk);
> +		if (skb && redsched_use_subflow(meta_sk, active_valid_sks, tp,
> +						skb)) {
> +			struct mptcp_tcp_sock *mptcp;
> +
> +			sk_data->skb =3D skb;
> +			sk_data->skb_end_seq =3D TCP_SKB_CB(skb)->end_seq;
> +			mptcp =3D mptcp_entry_next_rcu(tp->mptcp);
> +			if (mptcp)
> +				cb_data->next_subflow =3D mptcp->tp;
> +			else
> +				cb_data->next_subflow =3D NULL;
> +			*subsk =3D (struct sock *)tp;
> +
> +			if (TCP_SKB_CB(skb)->path_mask)
> +				*reinject =3D -1;
> +			return skb;
> +		}
> +	}

Could you also add a comment explaining the two for_each's? :)

>   =

>   	/* Nothing to send */
>   	return NULL;
> @@ -264,8 +350,15 @@ static void redundant_release(struct sock *sk)
>   	/* Check if the next subflow would be the released one. If yes correct
>   	 * the pointer
>   	 */
> -	if (cb_data->next_subflow =3D=3D tp)
> -		cb_data->next_subflow =3D tp->mptcp->next;
> +	if (cb_data->next_subflow =3D=3D tp) {
> +		struct mptcp_tcp_sock *mptcp;
> +
> +		mptcp =3D mptcp_entry_next_rcu(tp->mptcp);
> +		if (mptcp)
> +			cb_data->next_subflow =3D mptcp->tp;
> +		else
> +			cb_data->next_subflow =3D NULL;
> +	}

Should we not create a function for this block?

Best regards,
Matt

>   }
>   =

>   static struct mptcp_sched_ops mptcp_sched_redundant =3D {
> diff --git a/net/mptcp/mptcp_rr.c b/net/mptcp/mptcp_rr.c
> index 8910ba9e6052..d97706034646 100644
> --- a/net/mptcp/mptcp_rr.c
> +++ b/net/mptcp/mptcp_rr.c
> @@ -102,12 +102,14 @@ static struct sock *rr_get_available_subflow(struct=
 sock *meta_sk,
>   					     bool zero_wnd_test)
>   {
>   	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
> -	struct sock *sk, *bestsk =3D NULL, *backupsk =3D NULL;
> +	struct sock *sk =3D NULL, *bestsk =3D NULL, *backupsk =3D NULL;
> +	struct mptcp_tcp_sock *mptcp;
>   =

>   	/* Answer data_fin on same subflow!!! */
>   	if (meta_sk->sk_shutdown & RCV_SHUTDOWN &&
>   	    skb && mptcp_is_data_fin(skb)) {
> -		mptcp_for_each_sk(mpcb, sk) {
> +		mptcp_for_each_sub(mpcb, mptcp) {
> +			sk =3D mptcp_to_sock(mptcp);
>   			if (tcp_sk(sk)->mptcp->path_index =3D=3D mpcb->dfin_path_index &&
>   			    mptcp_rr_is_available(sk, skb, zero_wnd_test, true))
>   				return sk;
> @@ -115,8 +117,11 @@ static struct sock *rr_get_available_subflow(struct =
sock *meta_sk,
>   	}
>   =

>   	/* First, find the best subflow */
> -	mptcp_for_each_sk(mpcb, sk) {
> -		struct tcp_sock *tp =3D tcp_sk(sk);
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		struct tcp_sock *tp;
> +
> +		sk =3D mptcp_to_sock(mptcp);
> +		tp =3D tcp_sk(sk);
>   =

>   		if (!mptcp_rr_is_available(sk, skb, zero_wnd_test, true))
>   			continue;
> @@ -177,7 +182,8 @@ static struct sk_buff *mptcp_rr_next_segment(struct s=
ock *meta_sk,
>   					     unsigned int *limit)
>   {
>   	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
> -	struct sock *sk_it, *choose_sk =3D NULL;
> +	struct sock *choose_sk =3D NULL;
> +	struct mptcp_tcp_sock *mptcp;
>   	struct sk_buff *skb =3D __mptcp_rr_next_segment(meta_sk, reinject);
>   	unsigned char split =3D num_segments;
>   	unsigned char iter =3D 0, full_subs =3D 0;
> @@ -199,7 +205,8 @@ static struct sk_buff *mptcp_rr_next_segment(struct s=
ock *meta_sk,
>   retry:
>   =

>   	/* First, we look for a subflow who is currently being used */
> -	mptcp_for_each_sk(mpcb, sk_it) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		struct sock *sk_it =3D mptcp_to_sock(mptcp);
>   		struct tcp_sock *tp_it =3D tcp_sk(sk_it);
>   		struct rrsched_priv *rsp =3D rrsched_get_priv(tp_it);
>   =

> @@ -233,7 +240,8 @@ static struct sk_buff *mptcp_rr_next_segment(struct s=
ock *meta_sk,
>   		/* So, we restart this round by setting quota to 0 and retry
>   		 * to find a subflow.
>   		 */
> -		mptcp_for_each_sk(mpcb, sk_it) {
> +		mptcp_for_each_sub(mpcb, mptcp) {
> +			struct sock *sk_it =3D mptcp_to_sock(mptcp);
>   			struct tcp_sock *tp_it =3D tcp_sk(sk_it);
>   			struct rrsched_priv *rsp =3D rrsched_get_priv(tp_it);
>   =

> diff --git a/net/mptcp/mptcp_sched.c b/net/mptcp/mptcp_sched.c
> index c831515fd7f0..09246e286da8 100644
> --- a/net/mptcp/mptcp_sched.c
> +++ b/net/mptcp/mptcp_sched.c
> @@ -139,9 +139,10 @@ static struct sock
>   	u32 min_srtt =3D 0xffffffff;
>   	bool found_unused =3D false;
>   	bool found_unused_una =3D false;
> -	struct sock *sk;
> +	struct mptcp_tcp_sock *mptcp;
>   =

> -	mptcp_for_each_sk(mpcb, sk) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		struct sock *sk =3D mptcp_to_sock(mptcp);
>   		struct tcp_sock *tp =3D tcp_sk(sk);
>   		bool unused =3D false;
>   =

> @@ -222,7 +223,11 @@ struct sock *get_available_subflow(struct sock *meta=
_sk, struct sk_buff *skb,
>   	/* Answer data_fin on same subflow!!! */
>   	if (meta_sk->sk_shutdown & RCV_SHUTDOWN &&
>   	    skb && mptcp_is_data_fin(skb)) {
> -		mptcp_for_each_sk(mpcb, sk) {
> +		struct mptcp_tcp_sock *mptcp;
> +
> +		mptcp_for_each_sub(mpcb, mptcp) {
> +			sk =3D mptcp_to_sock(mptcp);
> +
>   			if (tcp_sk(sk)->mptcp->path_index =3D=3D mpcb->dfin_path_index &&
>   			    mptcp_is_available(sk, skb, zero_wnd_test))
>   				return sk;
> @@ -256,7 +261,7 @@ static struct sk_buff *mptcp_rcv_buf_optimization(str=
uct sock *sk, int penal)
>   {
>   	struct sock *meta_sk;
>   	const struct tcp_sock *tp =3D tcp_sk(sk);
> -	struct tcp_sock *tp_it;
> +	struct mptcp_tcp_sock *mptcp;
>   	struct sk_buff *skb_head;
>   	struct defsched_priv *dsp =3D defsched_get_priv(tp);
>   =

> @@ -279,7 +284,9 @@ static struct sk_buff *mptcp_rcv_buf_optimization(str=
uct sock *sk, int penal)
>   		goto retrans;
>   =

>   	/* Half the cwnd of the slow flow */
> -	mptcp_for_each_tp(tp->mpcb, tp_it) {
> +	mptcp_for_each_sub(tp->mpcb, mptcp) {
> +		struct tcp_sock *tp_it =3D mptcp->tp;
> +
>   		if (tp_it !=3D tp &&
>   		    TCP_SKB_CB(skb_head)->path_mask & mptcp_pi_to_flag(tp_it->mptcp->=
path_index)) {
>   			if (tp->srtt_us < tp_it->srtt_us && inet_csk((struct sock *)tp_it)->=
icsk_ca_state =3D=3D TCP_CA_Open) {
> @@ -302,7 +309,9 @@ static struct sk_buff *mptcp_rcv_buf_optimization(str=
uct sock *sk, int penal)
>   	/* Segment not yet injected into this path? Take it!!! */
>   	if (!(TCP_SKB_CB(skb_head)->path_mask & mptcp_pi_to_flag(tp->mptcp->pa=
th_index))) {
>   		bool do_retrans =3D false;
> -		mptcp_for_each_tp(tp->mpcb, tp_it) {
> +		mptcp_for_each_sub(tp->mpcb, mptcp) {
> +			struct tcp_sock *tp_it =3D mptcp->tp;
> +
>   			if (tp_it !=3D tp &&
>   			    TCP_SKB_CB(skb_head)->path_mask & mptcp_pi_to_flag(tp_it->mptcp-=
>path_index)) {
>   				if (tp_it->snd_cwnd <=3D 4) {
> diff --git a/net/mptcp/mptcp_wvegas.c b/net/mptcp/mptcp_wvegas.c
> index 4373b8d1ee8d..787ddaab98a2 100644
> --- a/net/mptcp/mptcp_wvegas.c
> +++ b/net/mptcp/mptcp_wvegas.c
> @@ -143,14 +143,15 @@ static inline u32 mptcp_wvegas_ssthresh(const struc=
t tcp_sock *tp)
>   static u64 mptcp_wvegas_weight(const struct mptcp_cb *mpcb, const struc=
t sock *sk)
>   {
>   	u64 total_rate =3D 0;
> -	struct sock *sub_sk;
>   	const struct wvegas *wvegas =3D inet_csk_ca(sk);
> +	struct mptcp_tcp_sock *mptcp;
>   =

>   	if (!mpcb)
>   		return wvegas->weight;
>   =

>   =

> -	mptcp_for_each_sk(mpcb, sub_sk) {
> +	mptcp_for_each_sub(mpcb, mptcp) {
> +		struct sock *sub_sk =3D mptcp_to_sock(mptcp);
>   		struct wvegas *sub_wvegas =3D inet_csk_ca(sub_sk);
>   =

>   		/* sampled_rtt is initialized by 0 */
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

-- =



DISCLAIMER.
This email and any files transmitted with it are confidential =

and intended solely for the use of the individual or entity to whom they =

are addressed. If you have received this email in error please notify the =

system manager. This message contains confidential information and is =

intended only for the individual named. If you are not the named addressee =

you should not disseminate, distribute or copy this e-mail. Please notify =

the sender immediately by e-mail if you have received this e-mail by =

mistake and delete this e-mail from your system. If you are not the =

intended recipient you are notified that disclosing, copying, distributing =

or taking any action in reliance on the contents of this information is =

strictly prohibited.

--===============4609910358849406104==--
