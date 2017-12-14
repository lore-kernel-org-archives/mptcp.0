Content-Type: multipart/mixed; boundary="===============5424308507490860709=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v3 07/15] tcp_smc: Make SMC use TCP extra-option
 framework
Date: Thu, 14 Dec 2017 14:49:02 -0800
Message-ID: <alpine.OSX.2.21.1712141342360.30779@srhallym-mobl.amr.corp.intel.com>
In-Reply-To: 20171211214218.35868-8-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 263

--===============5424308507490860709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 11 Dec 2017, Christoph Paasch wrote:

> Adopt the extra-option framework for SMC.
> It allows us to entirely remove SMC-code out of the TCP-stack.
>
> The static key is gone, as this is now covered by the static key of the
> extra-option framework.
>
> We allocate state (struct tcp_smc_opt) that indicates whether SMC was
> successfully negotiated or not and check this state in the relevant
> functions.
>
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>

Unless you heard otherwise from the smc author, I think it would be good =

to restore her cc: when this is posted to netdev.

Is it possible to test these changes without specific hardware?

A number of SMC patches were merged last week, but didn't cause any merge =

conflicts when I applied this patch set to net-next (as of Tuesday).

I came across https://lwn.net/Articles/723123/ when I was trying to better =

understand the SMC subsystem - interesting that the person who wrote that =

would have preferred using AF_INET/AF_INET6 rather than adding AF_SMC. =

There are some parallels with MPTCP API choices there, confirming the =

approach of using IPPROTO_MPTCP with AF_INET/AF_INET6.

> ---
> include/linux/tcp.h      |   3 +-
> include/net/inet_sock.h  |   3 +-
> include/net/tcp.h        |   4 --
> net/ipv4/tcp.c           |   5 --
> net/ipv4/tcp_input.c     |  36 ----------
> net/ipv4/tcp_minisocks.c |  18 -----
> net/ipv4/tcp_output.c    |  54 ---------------
> net/smc/af_smc.c         | 175 ++++++++++++++++++++++++++++++++++++++++++=
+++--
> 8 files changed, 171 insertions(+), 127 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index b14426228a01..5dc4067100af 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -257,8 +257,7 @@ struct tcp_sock {
> 		syn_fastopen_ch:1, /* Active TFO re-enabling probe */
> 		syn_data_acked:1,/* data in SYN is acked by SYN-ACK */
> 		save_syn:1,	/* Save headers of SYN packet */
> -		is_cwnd_limited:1,/* forward progress limited by snd_cwnd? */
> -		syn_smc:1;	/* SYN includes SMC */
> +		is_cwnd_limited:1;/* forward progress limited by snd_cwnd? */
> 	u32	tlp_high_seq;	/* snd_nxt at the time of TLP retransmit. */
>
> /* RTT measurement */
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index 39efb968b7a4..8e51b4a69088 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -90,8 +90,7 @@ struct inet_request_sock {
> 				wscale_ok  : 1,
> 				ecn_ok	   : 1,
> 				acked	   : 1,
> -				no_srccheck: 1,
> -				smc_ok	   : 1;
> +				no_srccheck: 1;
> 	u32                     ir_mark;
> 	union {
> 		struct ip_options_rcu __rcu	*ireq_opt;
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 86133aa24fca..27e71cb5e4cb 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2063,10 +2063,6 @@ static inline bool tcp_bpf_ca_needs_ecn(struct soc=
k *sk)
> 	return (tcp_call_bpf(sk, BPF_SOCK_OPS_NEEDS_ECN) =3D=3D 1);
> }
>
> -#if IS_ENABLED(CONFIG_SMC)
> -extern struct static_key_false tcp_have_smc;
> -#endif
> -
> extern struct static_key_false tcp_extopt_enabled;
> struct tcp_extopt_store;
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 6676fc3c0059..c5d9484064c9 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -294,11 +294,6 @@ EXPORT_SYMBOL(sysctl_tcp_mem);
> atomic_long_t tcp_memory_allocated;	/* Current allocated memory. */
> EXPORT_SYMBOL(tcp_memory_allocated);
>
> -#if IS_ENABLED(CONFIG_SMC)
> -DEFINE_STATIC_KEY_FALSE(tcp_have_smc);
> -EXPORT_SYMBOL(tcp_have_smc);
> -#endif
> -
> /*
>  * Current number of TCP sockets.
>  */
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index d4d3be8a496c..5f4a2f2e3b87 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3676,24 +3676,6 @@ static void tcp_parse_fastopen_option(int len, con=
st unsigned char *cookie,
> 	foc->exp =3D exp_opt;
> }
>
> -static int smc_parse_options(const struct tcphdr *th,
> -			     struct tcp_options_received *opt_rx,
> -			     const unsigned char *ptr,
> -			     int opsize)
> -{
> -#if IS_ENABLED(CONFIG_SMC)
> -	if (static_branch_unlikely(&tcp_have_smc)) {
> -		if (th->syn && !(opsize & 1) &&
> -		    opsize >=3D TCPOLEN_EXP_SMC_BASE &&
> -		    get_unaligned_be32(ptr) =3D=3D TCPOPT_SMC_MAGIC) {
> -			opt_rx->smc_ok =3D 1;
> -			return 1;
> -		}
> -	}
> -#endif
> -	return 0;
> -}
> -
> /* Look for tcp options. Normally only called on SYN and SYNACK packets.
>  * But, this can also be called on packets in the established flow when
>  * the fast version below fails.
> @@ -3801,9 +3783,6 @@ void tcp_parse_options(const struct net *net,
> 					tcp_parse_fastopen_option(opsize -
> 						TCPOLEN_EXP_FASTOPEN_BASE,
> 						ptr + 2, th->syn, foc, true);
> -				else if (smc_parse_options(th, opt_rx, ptr,
> -							   opsize))
> -					break;
> 				else if (static_branch_unlikely(&tcp_extopt_enabled) &&
> 					 opsize >=3D TCPOLEN_EXP_BASE)
> 					tcp_extopt_parse(get_unaligned_be32(ptr),
> @@ -5580,16 +5559,6 @@ static bool tcp_rcv_fastopen_synack(struct sock *s=
k, struct sk_buff *synack,
> 	return false;
> }
>
> -static void smc_check_reset_syn(struct tcp_sock *tp)
> -{
> -#if IS_ENABLED(CONFIG_SMC)
> -	if (static_branch_unlikely(&tcp_have_smc)) {
> -		if (tp->syn_smc && !tp->rx_opt.smc_ok)
> -			tp->syn_smc =3D 0;
> -	}
> -#endif
> -}
> -
> static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff =
*skb,
> 					 const struct tcphdr *th)
> {
> @@ -5700,8 +5669,6 @@ static int tcp_rcv_synsent_state_process(struct soc=
k *sk, struct sk_buff *skb,
> 		 * is initialized. */
> 		tp->copied_seq =3D tp->rcv_nxt;
>
> -		smc_check_reset_syn(tp);
> -
> 		smp_mb();
>
> 		tcp_finish_connect(sk, skb);
> @@ -6158,9 +6125,6 @@ static void tcp_openreq_init(struct request_sock *r=
eq,
> 	ireq->ir_rmt_port =3D tcp_hdr(skb)->source;
> 	ireq->ir_num =3D ntohs(tcp_hdr(skb)->dest);
> 	ireq->ir_mark =3D inet_request_mark(sk, skb);
> -#if IS_ENABLED(CONFIG_SMC)
> -	ireq->smc_ok =3D rx_opt->smc_ok;
> -#endif
> }
>
> struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index c38d12bc7dde..ce8d1f4548a2 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -434,21 +434,6 @@ void tcp_ca_openreq_child(struct sock *sk, const str=
uct dst_entry *dst)
> }
> EXPORT_SYMBOL_GPL(tcp_ca_openreq_child);
>
> -static void smc_check_reset_syn_req(struct tcp_sock *oldtp,
> -				    struct request_sock *req,
> -				    struct tcp_sock *newtp)
> -{
> -#if IS_ENABLED(CONFIG_SMC)
> -	struct inet_request_sock *ireq;
> -
> -	if (static_branch_unlikely(&tcp_have_smc)) {
> -		ireq =3D inet_rsk(req);
> -		if (oldtp->syn_smc && !ireq->smc_ok)
> -			newtp->syn_smc =3D 0;
> -	}
> -#endif
> -}
> -
> /* This is not only more efficient than what we used to do, it eliminates
>  * a lot of code duplication between IPv4/IPv6 SYN recv processing. -DaveM
>  *
> @@ -466,9 +451,6 @@ struct sock *tcp_create_openreq_child(const struct so=
ck *sk,
> 		struct tcp_request_sock *treq =3D tcp_rsk(req);
> 		struct inet_connection_sock *newicsk =3D inet_csk(newsk);
> 		struct tcp_sock *newtp =3D tcp_sk(newsk);
> -		struct tcp_sock *oldtp =3D tcp_sk(sk);
> -
> -		smc_check_reset_syn_req(oldtp, req, newtp);
>
> 		/* Now setup tcp_sock */
> 		newtp->pred_flags =3D 0;
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index e7ea9596cec7..0dc736849fc0 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -398,21 +398,6 @@ static inline bool tcp_urg_mode(const struct tcp_soc=
k *tp)
> 	return tp->snd_una !=3D tp->snd_up;
> }
>
> -static void smc_options_write(__be32 *ptr, u16 *options)
> -{
> -#if IS_ENABLED(CONFIG_SMC)
> -	if (static_branch_unlikely(&tcp_have_smc)) {
> -		if (unlikely(OPTION_SMC & *options)) {
> -			*ptr++ =3D htonl((TCPOPT_NOP  << 24) |
> -				       (TCPOPT_NOP  << 16) |
> -				       (TCPOPT_EXP <<  8) |
> -				       (TCPOLEN_EXP_SMC_BASE));
> -			*ptr++ =3D htonl(TCPOPT_SMC_MAGIC);
> -		}
> -	}
> -#endif
> -}
> -
> /* Write previously computed TCP options to the packet.
>  *
>  * Beware: Something in the Internet is very sensitive to the ordering of
> @@ -524,45 +509,10 @@ static void tcp_options_write(__be32 *ptr, struct s=
k_buff *skb, struct sock *sk,
> 		ptr +=3D (len + 3) >> 2;
> 	}
>
> -	smc_options_write(ptr, &options);
> -
> 	if (static_branch_unlikely(&tcp_extopt_enabled))
> 		tcp_extopt_write(ptr, skb, opts, sk);
> }
>
> -static void smc_set_option(const struct tcp_sock *tp,
> -			   struct tcp_out_options *opts,
> -			   unsigned int *remaining)
> -{
> -#if IS_ENABLED(CONFIG_SMC)
> -	if (static_branch_unlikely(&tcp_have_smc)) {
> -		if (tp->syn_smc) {
> -			if (*remaining >=3D TCPOLEN_EXP_SMC_BASE_ALIGNED) {
> -				opts->options |=3D OPTION_SMC;
> -				*remaining -=3D TCPOLEN_EXP_SMC_BASE_ALIGNED;
> -			}
> -		}
> -	}
> -#endif
> -}
> -
> -static void smc_set_option_cond(const struct tcp_sock *tp,
> -				const struct inet_request_sock *ireq,
> -				struct tcp_out_options *opts,
> -				unsigned int *remaining)
> -{
> -#if IS_ENABLED(CONFIG_SMC)
> -	if (static_branch_unlikely(&tcp_have_smc)) {
> -		if (tp->syn_smc && ireq->smc_ok) {
> -			if (*remaining >=3D TCPOLEN_EXP_SMC_BASE_ALIGNED) {
> -				opts->options |=3D OPTION_SMC;
> -				*remaining -=3D TCPOLEN_EXP_SMC_BASE_ALIGNED;
> -			}
> -		}
> -	}
> -#endif
> -}
> -
> /* Compute TCP options for SYN packets. This is not the final
>  * network wire format yet.
>  */
> @@ -628,8 +578,6 @@ static unsigned int tcp_syn_options(struct sock *sk, =
struct sk_buff *skb,
> 		}
> 	}
>
> -	smc_set_option(tp, opts, &remaining);
> -
> 	if (static_branch_unlikely(&tcp_extopt_enabled))
> 		remaining -=3D tcp_extopt_prepare(skb, TCPHDR_SYN, remaining,
> 						opts, tcp_to_sk(tp));
> @@ -695,8 +643,6 @@ static unsigned int tcp_synack_options(const struct s=
ock *sk,
> 		}
> 	}
>
> -	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
> -
> 	if (static_branch_unlikely(&tcp_extopt_enabled))
> 		remaining -=3D tcp_extopt_prepare(skb, TCPHDR_SYN | TCPHDR_ACK,
> 						remaining, opts,
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index daf8075f5a4c..3ef9588a4f87 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -44,6 +44,132 @@
> #include "smc_rx.h"
> #include "smc_close.h"
>
> +static unsigned int tcp_smc_opt_prepare(struct sk_buff *skb, u8 flags,
> +					unsigned int remaining,
> +					struct tcp_out_options *opts,
> +					const struct sock *sk,
> +					struct tcp_extopt_store *store);
> +static __be32 *tcp_smc_opt_write(__be32 *ptr, struct sk_buff *skb,
> +				 struct tcp_out_options *opts,
> +				 struct sock *sk,
> +				 struct tcp_extopt_store *store);
> +static void tcp_smc_opt_parse(int opsize, const unsigned char *opptr,
> +			      const struct sk_buff *skb,
> +			      struct tcp_options_received *opt_rx,
> +			      struct sock *sk,
> +			      struct tcp_extopt_store *store);
> +static void tcp_smc_opt_post_process(struct sock *sk,
> +				     struct tcp_options_received *opt,
> +				     struct tcp_extopt_store *store);
> +static struct tcp_extopt_store *tcp_smc_opt_copy(struct sock *listener,
> +						 struct request_sock *req,
> +						 struct tcp_options_received *opt,
> +						 struct tcp_extopt_store *store);
> +static void tcp_smc_opt_destroy(struct tcp_extopt_store *store);
> +
> +struct tcp_smc_opt {
> +	struct tcp_extopt_store	store;
> +	int			smc_ok:1; /* SMC supported on this connection */
> +	struct rcu_head		rcu;
> +};
> +
> +static const struct tcp_extopt_ops tcp_smc_extra_ops =3D {
> +	.option_kind	=3D TCPOPT_SMC_MAGIC,
> +	.parse		=3D tcp_smc_opt_parse,
> +	.post_process	=3D tcp_smc_opt_post_process,
> +	.prepare	=3D tcp_smc_opt_prepare,
> +	.write		=3D tcp_smc_opt_write,
> +	.copy		=3D tcp_smc_opt_copy,
> +	.destroy	=3D tcp_smc_opt_destroy,
> +	.owner		=3D THIS_MODULE,
> +};
> +
> +static unsigned int tcp_smc_opt_prepare(struct sk_buff *skb, u8 flags,
> +					unsigned int remaining,
> +					struct tcp_out_options *opts,
> +					const struct sock *sk,
> +					struct tcp_extopt_store *store)
> +{
> +	if (remaining >=3D TCPOLEN_EXP_SMC_BASE_ALIGNED) {
> +		opts->options |=3D OPTION_SMC;
> +		return TCPOLEN_EXP_SMC_BASE_ALIGNED;
> +	}
> +
> +	return 0;
> +}
> +
> +static __be32 *tcp_smc_opt_write(__be32 *ptr, struct sk_buff *skb,
> +				 struct tcp_out_options *opts,
> +				 struct sock *sk,
> +				 struct tcp_extopt_store *store)
> +{
> +	if (unlikely(OPTION_SMC & opts->options)) {
> +		*ptr++ =3D htonl((TCPOPT_NOP  << 24) |
> +			       (TCPOPT_NOP  << 16) |
> +			       (TCPOPT_EXP <<  8) |
> +			       (TCPOLEN_EXP_SMC_BASE));
> +		*ptr++ =3D htonl(TCPOPT_SMC_MAGIC);
> +	}
> +
> +	return ptr;
> +}
> +
> +static void tcp_smc_opt_parse(int opsize, const unsigned char *opptr,
> +			      const struct sk_buff *skb,
> +			      struct tcp_options_received *opt_rx,
> +			      struct sock *sk,
> +			      struct tcp_extopt_store *store)
> +{
> +	struct tcphdr *th =3D tcp_hdr(skb);
> +
> +	if (th->syn && !(opsize & 1) && opsize >=3D TCPOLEN_EXP_SMC_BASE)
> +		opt_rx->smc_ok =3D 1;
> +}
> +
> +static void tcp_smc_opt_post_process(struct sock *sk,
> +				     struct tcp_options_received *opt,
> +				     struct tcp_extopt_store *store)
> +{
> +	struct tcp_smc_opt *smc_opt =3D (struct tcp_smc_opt *)store;

The container_of() macro would set a type-safe example for other =

tcp_extopt users. If that's the standard, it would get rid of the =

requirement to have the tcp_extopt_store struct at the beginning of the =

container struct.


Mat


> +
> +	if (sk->sk_state !=3D TCP_SYN_SENT)
> +		return;
> +
> +	if (opt->smc_ok)
> +		smc_opt->smc_ok =3D 1;
> +	else
> +		smc_opt->smc_ok =3D 0;
> +}
> +
> +static struct tcp_extopt_store *tcp_smc_opt_copy(struct sock *listener,
> +						 struct request_sock *req,
> +						 struct tcp_options_received *opt,
> +						 struct tcp_extopt_store *store)
> +{
> +	struct tcp_smc_opt *smc_opt;
> +
> +	/* First, check if the peer sent us the smc-opt */
> +	if (!opt->smc_ok)
> +		return NULL;
> +
> +	smc_opt =3D kzalloc(sizeof(*smc_opt), GFP_KERNEL);
> +	if (!smc_opt)
> +		return NULL;
> +
> +	smc_opt->store.ops =3D &tcp_smc_extra_ops;
> +
> +	smc_opt->smc_ok =3D 1;
> +
> +	return (struct tcp_extopt_store *)smc_opt;
> +}
> +
> +static void tcp_smc_opt_destroy(struct tcp_extopt_store *store)
> +{
> +	struct tcp_smc_opt *smc_opt =3D (struct tcp_smc_opt *)store;
> +
> +	kfree_rcu(smc_opt, rcu);
> +}
> +
> static DEFINE_MUTEX(smc_create_lgr_pending);	/* serialize link group
> 						 * creation
> 						 */
> @@ -384,13 +510,16 @@ static int smc_connect_rdma(struct smc_sock *smc)
> 	struct smc_clc_msg_accept_confirm aclc;
> 	int local_contact =3D SMC_FIRST_CONTACT;
> 	struct smc_ib_device *smcibdev;
> +	struct tcp_smc_opt *smc_opt;
> 	struct smc_link *link;
> 	u8 srv_first_contact;
> 	int reason_code =3D 0;
> 	int rc =3D 0;
> 	u8 ibport;
>
> -	if (!tcp_sk(smc->clcsock->sk)->syn_smc) {
> +	smc_opt =3D (struct tcp_smc_opt *)tcp_extopt_find_kind(TCPOPT_SMC_MAGIC,
> +							     smc->clcsock->sk);
> +	if (!smc_opt || !smc_opt->smc_ok) {
> 		/* peer has not signalled SMC-capability */
> 		smc->use_fallback =3D true;
> 		goto out_connected;
> @@ -535,6 +664,7 @@ static int smc_connect_rdma(struct smc_sock *smc)
> static int smc_connect(struct socket *sock, struct sockaddr *addr,
> 		       int alen, int flags)
> {
> +	struct tcp_smc_opt *smc_opt;
> 	struct sock *sk =3D sock->sk;
> 	struct smc_sock *smc;
> 	int rc =3D -EINVAL;
> @@ -548,9 +678,17 @@ static int smc_connect(struct socket *sock, struct s=
ockaddr *addr,
> 		goto out_err;
> 	smc->addr =3D addr;	/* needed for nonblocking connect */
>
> +	smc_opt =3D kzalloc(sizeof(*smc_opt), GFP_KERNEL);
> +	if (!smc_opt) {
> +		rc =3D -ENOMEM;
> +		goto out_err;
> +	}
> +	smc_opt->store.ops =3D &tcp_smc_extra_ops;
> +
> 	lock_sock(sk);
> 	switch (sk->sk_state) {
> 	default:
> +		rc =3D -EINVAL;
> 		goto out;
> 	case SMC_ACTIVE:
> 		rc =3D -EISCONN;
> @@ -560,8 +698,15 @@ static int smc_connect(struct socket *sock, struct s=
ockaddr *addr,
> 		break;
> 	}
>
> +	/* We are the only owner of smc->clcsock->sk, so we can be lockless */
> +	rc =3D tcp_register_extopt(&smc_opt->store, smc->clcsock->sk);
> +	if (rc) {
> +		release_sock(smc->clcsock->sk);
> +		kfree(smc_opt);
> +		goto out_err;
> +	}
> +
> 	smc_copy_sock_settings_to_clc(smc);
> -	tcp_sk(smc->clcsock->sk)->syn_smc =3D 1;
> 	rc =3D kernel_connect(smc->clcsock, addr, alen, flags);
> 	if (rc)
> 		goto out;
> @@ -760,6 +905,7 @@ static void smc_listen_work(struct work_struct *work)
> 	struct smc_clc_msg_proposal *pclc;
> 	struct smc_ib_device *smcibdev;
> 	struct sockaddr_in peeraddr;
> +	struct tcp_smc_opt *smc_opt;
> 	u8 buf[SMC_CLC_MAX_LEN];
> 	struct smc_link *link;
> 	int reason_code =3D 0;
> @@ -769,7 +915,9 @@ static void smc_listen_work(struct work_struct *work)
> 	u8 ibport;
>
> 	/* check if peer is smc capable */
> -	if (!tcp_sk(newclcsock->sk)->syn_smc) {
> +	smc_opt =3D (struct tcp_smc_opt *)tcp_extopt_find_kind(TCPOPT_SMC_MAGIC,
> +							     newclcsock->sk);
> +	if (!smc_opt || !smc_opt->smc_ok) {
> 		new_smc->use_fallback =3D true;
> 		goto out_connected;
> 	}
> @@ -962,10 +1110,18 @@ static void smc_tcp_listen_work(struct work_struct=
 *work)
>
> static int smc_listen(struct socket *sock, int backlog)
> {
> +	struct tcp_smc_opt *smc_opt;
> 	struct sock *sk =3D sock->sk;
> 	struct smc_sock *smc;
> 	int rc;
>
> +	smc_opt =3D kzalloc(sizeof(*smc_opt), GFP_KERNEL);
> +	if (!smc_opt) {
> +		rc =3D -ENOMEM;
> +		goto out_err;
> +	}
> +	smc_opt->store.ops =3D &tcp_smc_extra_ops;
> +
> 	smc =3D smc_sk(sk);
> 	lock_sock(sk);
>
> @@ -978,11 +1134,19 @@ static int smc_listen(struct socket *sock, int bac=
klog)
> 		sk->sk_max_ack_backlog =3D backlog;
> 		goto out;
> 	}
> +
> +	/* We are the only owner of smc->clcsock->sk, so we can be lockless */
> +	rc =3D tcp_register_extopt(&smc_opt->store, smc->clcsock->sk);
> +	if (rc) {
> +		release_sock(smc->clcsock->sk);
> +		kfree(smc_opt);
> +		goto out_err;
> +	}
> +
> 	/* some socket options are handled in core, so we could not apply
> 	 * them to the clc socket -- copy smc socket options to clc socket
> 	 */
> 	smc_copy_sock_settings_to_clc(smc);
> -	tcp_sk(smc->clcsock->sk)->syn_smc =3D 1;
>
> 	rc =3D kernel_listen(smc->clcsock, backlog);
> 	if (rc)
> @@ -995,6 +1159,7 @@ static int smc_listen(struct socket *sock, int backl=
og)
>
> out:
> 	release_sock(sk);
> +out_err:
> 	return rc;
> }
>
> @@ -1425,7 +1590,6 @@ static int __init smc_init(void)
> 		goto out_sock;
> 	}
>
> -	static_branch_enable(&tcp_have_smc);
> 	return 0;
>
> out_sock:
> @@ -1450,7 +1614,6 @@ static void __exit smc_exit(void)
> 		list_del_init(&lgr->list);
> 		smc_lgr_free(lgr); /* free link group */
> 	}
> -	static_branch_disable(&tcp_have_smc);
> 	smc_ib_unregister_client();
> 	sock_unregister(PF_SMC);
> 	proto_unregister(&smc_proto);
> -- =

> 2.15.0
>
>

--
Mat Martineau
Intel OTC

--===============5424308507490860709==--
