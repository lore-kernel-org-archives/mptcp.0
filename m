Content-Type: multipart/mixed; boundary="===============7834819016887166715=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] Revert tcp_skb_cb to it's original size and
 cleanup main TCP Rx code from MPTCP specific code.
Date: Mon, 26 Jun 2017 15:34:09 -0700
Message-ID: <cd1d922f-3103-7b13-5f2a-0eb5a7c06e5f@oracle.com>
In-Reply-To: 20170626211352.GA7371@caduceus5
X-Status: 
X-Keywords:                  
X-UID: 49

--===============7834819016887166715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I forgot to mention two things

1) Connection setup still has checks for MPTCP, Ideally these should be =

removed but at least we need to run some benchmarks and fix any issues. =

The mainstream folks will not accept any performance degradation in TCP. =

I can look into this next.

2) The code overloads dev field of skb, when it is not being used. IIRC =

there is precedence for this already. I will try to find it.

Rao


On 06/26/2017 02:13 PM, Rao Shoaib wrote:
> This patch returns tcp_skb_cb to it's original size. It also refactors MP=
TCP code so that there are no MPTCP checks in the main Rx pathi, no perform=
ance overheads such as cpu prodiction issues. tcp_v4_rcv() and tcp_v4_do_rc=
v() do not have any MPTCP specific checks any more, niether does tcp_ack().=
 On the Rx path MPTCP options are not parsed till the data is being pushed =
up to the meta socket (mptcp_data_ready). on the Tx side there is one check=
 to add MPTCP specific options but that's it, that should not be that bad a=
s for regular TCP it is a simple check, but it would be good to remove it..
>
> I have tested the changes with ndiffports set to 2, so join works. I have=
 also tested accessing multipath-tcp.org and downloading files from there a=
nd also ran the speed test.
>
> The Bad:
>
> The error cases still have MPTCP checks but that should be OK as they are=
 error cases. I had to use a special marker 0xFEE1DEAD for indicate a speci=
al case. I had to introdue a new socket specfic function. IPv6 has not been=
 changed yet. I am sure I have missed some corner cases and more testing wi=
ll reveal more issues but we just have to fix them.
>
> I would like to hear comments from the list and if this direction seems r=
easonable we can take this as the starting point, port it to latest Linux a=
nd share the design with the mainstream folks.
>
> Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
> ---
>   include/linux/skbuff.h      |   8 ++-
>   include/net/mptcp.h         |  21 +++---
>   include/net/mptcp_v4.h      |   1 +
>   include/net/sock.h          |  12 +++-
>   include/net/tcp.h           |  23 +++----
>   net/ipv4/af_inet.c          |   4 ++
>   net/ipv4/tcp_input.c        |  37 ++--------
>   net/ipv4/tcp_ipv4.c         | 135 +++++++++++++++++++++++--------------
>   net/ipv4/tcp_output.c       |   1 +
>   net/ipv6/af_inet6.c         |   4 ++
>   net/ipv6/tcp_ipv6.c         |   4 --
>   net/mptcp/mptcp_ctrl.c      |  21 ++++++
>   net/mptcp/mptcp_input.c     | 131 ++++++++++++++++++++++++++++--------
>   net/mptcp/mptcp_ipv4.c      |  35 +---------
>   net/mptcp/mptcp_ipv6.c      |   4 +-
>   net/mptcp/mptcp_output.c    | 160 +++++++++++++++++--------------------=
-------
>   net/mptcp/mptcp_redundant.c |   6 +-
>   net/mptcp/mptcp_rr.c        |   4 +-
>   net/mptcp/mptcp_sched.c     |  10 +--
>   19 files changed, 335 insertions(+), 286 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index f66cd5e..348cbc1 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -532,7 +532,13 @@ struct sk_buff {
>   		struct rb_node	rbnode; /* used in netem & tcp stack */
>   	};
>   	struct sock		*sk;
> -	struct net_device	*dev;
> +	union {
> +		struct net_device	*dev;
> +		struct {
> +			__u8 mptcp_flags;
> +			__u8 mptcp_dss_off;
> +		};
> +	};
>   =

>   	/*
>   	 * This is the control buffer. It is free to use for every
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 876f1e6..d087cb4 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -807,7 +807,7 @@ void tcp_parse_mptcp_options(const struct sk_buff *sk=
b,
>   			     struct mptcp_options_received *mopt);
>   void mptcp_parse_options(const uint8_t *ptr, int opsize,
>   			 struct mptcp_options_received *mopt,
> -			 const struct sk_buff *skb,
> +			 struct sk_buff *skb,
>   			 struct tcp_sock *tp);
>   void mptcp_syn_options(const struct sock *sk, struct tcp_out_options *o=
pts,
>   		       unsigned *remaining);
> @@ -998,14 +998,15 @@ static inline void mptcp_sub_force_close_all(struct=
 mptcp_cb *mpcb,
>   	}
>   }
>   =

> +/* currently tp is being used for Rx packets */
>   static inline bool mptcp_is_data_seq(const struct sk_buff *skb)
>   {
> -	return TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ;
> +	return skb->mptcp_flags & MPTCPHDR_SEQ;
>   }
>   =

>   static inline bool mptcp_is_data_fin(const struct sk_buff *skb)
>   {
> -	return TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_FIN;
> +	return skb->mptcp_flags & MPTCPHDR_FIN;
>   }
>   =

>   /* Is it a data-fin while in infinite mapping mode?
> @@ -1034,17 +1035,17 @@ static inline u8 mptcp_get_64_bit(u64 data_seq, s=
truct mptcp_cb *mpcb)
>   /* Sets the data_seq and returns pointer to the in-skb field of the dat=
a_seq.
>    * If the packet has a 64-bit dseq, the pointer points to the last 32 b=
its.
>    */
> -static inline __u32 *mptcp_skb_set_data_seq(const struct sk_buff *skb,
> +static inline __u32 *mptcp_skb_set_data_seq(struct sk_buff *skb,
>   					    u32 *data_seq,
>   					    struct mptcp_cb *mpcb)
>   {
> -	__u32 *ptr =3D (__u32 *)(skb_transport_header(skb) + TCP_SKB_CB(skb)->d=
ss_off);
> +	__u32 *ptr =3D (__u32 *)(skb_transport_header(skb) + skb->mptcp_dss_off=
);
>   =

> -	if (TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ64_SET) {
> +	if (skb->mptcp_flags & MPTCPHDR_SEQ64_SET) {
>   		u64 data_seq64 =3D get_unaligned_be64(ptr);
>   =

>   		if (mpcb)
> -			TCP_SKB_CB(skb)->mptcp_flags |=3D mptcp_get_64_bit(data_seq64, mpcb);
> +			skb->mptcp_flags |=3D mptcp_get_64_bit(data_seq64, mpcb);
>   =

>   		*data_seq =3D (u32)data_seq64;
>   		ptr++;
> @@ -1142,7 +1143,7 @@ static inline void mptcp_reset_mopt(struct tcp_sock=
 *tp)
>   static inline __be32 mptcp_get_highorder_sndbits(const struct sk_buff *=
skb,
>   						 const struct mptcp_cb *mpcb)
>   {
> -	return htonl(mpcb->snd_high_order[(TCP_SKB_CB(skb)->mptcp_flags &
> +	return htonl(mpcb->snd_high_order[(skb->mptcp_flags &
>   			MPTCPHDR_SEQ64_INDEX) ? 1 : 0]);
>   }
>   =

> @@ -1404,8 +1405,8 @@ static inline void mptcp_set_rto(const struct sock =
*sk) {}
>   static inline void mptcp_send_fin(const struct sock *meta_sk) {}
>   static inline void mptcp_parse_options(const uint8_t *ptr, const int op=
size,
>   				       struct mptcp_options_received *mopt,
> -				       const struct sk_buff *skb,
> -				       const struct tcp_sock *tp) {}
> +				       struct sk_buff *skb,
> +				       struct tcp_sock *tp) {}
>   static inline void mptcp_syn_options(const struct sock *sk,
>   				     struct tcp_out_options *opts,
>   				     unsigned *remaining) {}
> diff --git a/include/net/mptcp_v4.h b/include/net/mptcp_v4.h
> index c83dca0..46394a4 100644
> --- a/include/net/mptcp_v4.h
> +++ b/include/net/mptcp_v4.h
> @@ -45,6 +45,7 @@ extern struct tcp_request_sock_ops mptcp_join_request_s=
ock_ipv4_ops;
>   #ifdef CONFIG_MPTCP
>   =

>   int mptcp_v4_do_rcv(struct sock *meta_sk, struct sk_buff *skb);
> +int mptcp_v4_process_join_req(struct sock *meta_sk, struct sk_buff *skb);
>   struct sock *mptcp_v4_search_req(const __be16 rport, const __be32 raddr,
>   				 const __be32 laddr, const struct net *net);
>   int mptcp_init4_subsockets(struct sock *meta_sk, const struct mptcp_loc=
4 *loc,
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 0f12593..0d1bda5 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -296,6 +296,7 @@ struct cg_proto;
>     *	@sk_write_space: callback to indicate there is bf sending space ava=
ilable
>     *	@sk_error_report: callback to indicate errors (e.g. %MSG_ERRQUEUE)
>     *	@sk_backlog_rcv: callback to process the backlog
> +  *	@sk_prequeue: callback to prequeue
>     *	@sk_destruct: called at sock freeing time, i.e. when all refcnt =3D=
=3D 0
>    */
>   struct sock {
> @@ -437,7 +438,9 @@ struct sock {
>   	void			(*sk_write_space)(struct sock *sk);
>   	void			(*sk_error_report)(struct sock *sk);
>   	int			(*sk_backlog_rcv)(struct sock *sk,
> -						  struct sk_buff *skb);
> +						struct sk_buff *skb);
> +	bool			(*sk_prequeue)(struct sock *sk,
> +						struct sk_buff *skb);
>   	void                    (*sk_destruct)(struct sock *sk);
>   };
>   =

> @@ -853,6 +856,11 @@ static inline int sk_backlog_rcv(struct sock *sk, st=
ruct sk_buff *skb)
>   	return sk->sk_backlog_rcv(sk, skb);
>   }
>   =

> +static inline bool sk_prequeue(struct sock *sk, struct sk_buff *skb)
> +{
> +	return (false);
> +}
> +
>   static inline void sk_incoming_cpu_update(struct sock *sk)
>   {
>   	sk->sk_incoming_cpu =3D raw_smp_processor_id();
> @@ -993,6 +1001,8 @@ struct proto {
>   =

>   	int			(*backlog_rcv) (struct sock *sk,
>   						struct sk_buff *skb);
> +	bool			(*prequeue) (struct sock *sk,
> +						struct sk_buff *skb);
>   =

>   	void		(*release_cb)(struct sock *sk);
>   =

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 655ecd4..cbe8ef2 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -47,6 +47,9 @@
>   #include <linux/seq_file.h>
>   #include <linux/memcontrol.h>
>   =

> +typedef int (* process_unclaimed)(struct sock *sk, struct sk_buff *skb);
> +extern process_unclaimed tcp_process_unclaimed;
> +
>   extern struct inet_hashinfo tcp_hashinfo;
>   =

>   extern struct percpu_counter tcp_orphan_count;
> @@ -581,6 +584,7 @@ struct sock *tcp_v4_syn_recv_sock(struct sock *sk, st=
ruct sk_buff *skb,
>   				  struct request_sock *req,
>   				  struct dst_entry *dst);
>   int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb);
> +
>   int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_le=
n);
>   int tcp_connect(struct sock *sk);
>   struct sk_buff *tcp_make_synack(struct sock *sk, struct dst_entry *dst,
> @@ -842,11 +846,6 @@ struct tcp_skb_cb {
>   		__u32		tcp_gso_segs;
>   	};
>   =

> -#ifdef CONFIG_MPTCP
> -	__u8		mptcp_flags;	/* flags for the MPTCP layer    */
> -	__u8		dss_off;	/* Number of 4-byte words until
> -					 * seq-number */
> -#endif
>   	__u8		tcp_flags;	/* TCP header flags. (tcp[13])	*/
>   =

>   	__u8		sacked;		/* State flags for SACK/FACK.	*/
> @@ -859,9 +858,13 @@ struct tcp_skb_cb {
>   #define TCPCB_RETRANS		(TCPCB_SACKED_RETRANS|TCPCB_EVER_RETRANS| \
>   				TCPCB_REPAIRED)
>   =

> -	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
> +	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield */
>   	/* 1 byte hole */
> -	__u32		ack_seq;	/* Sequence number ACK'd	*/
> +	union {
> +		__u32		ack_seq;	/* Sequence number ACK'd */
> +		__u32 		mptcp_data_seq;
> +		__u32		mptcp_path_mask;
> +	};
>   	union {
>   		union {
>   			struct inet_skb_parm	h4;
> @@ -869,12 +872,6 @@ struct tcp_skb_cb {
>   			struct inet6_skb_parm	h6;
>   #endif
>   		} header;	/* For incoming frames		*/
> -#ifdef CONFIG_MPTCP
> -		union {			/* For MPTCP outgoing frames */
> -			__u32 path_mask; /* paths that tried to send this skb */
> -			__u32 dss[6];	/* DSS options */
> -		};
> -#endif
>   	};
>   };
>   =

> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 73480b9..1e7827f 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -356,6 +356,10 @@ lookup_protocol:
>   	sk->sk_destruct	   =3D inet_sock_destruct;
>   	sk->sk_protocol	   =3D protocol;
>   	sk->sk_backlog_rcv =3D sk->sk_prot->backlog_rcv;
> +	sk->sk_prequeue =3D sk->sk_prot->prequeue;
> +	if (sk->sk_prequeue =3D=3D NULL) {
> +		sk->sk_prequeue =3D sk_prequeue;
> +	}
>   =

>   	inet->uc_ttl	=3D -1;
>   	inet->mc_loop	=3D 1;
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 16a7256..cb6bbf9 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3133,8 +3133,6 @@ static int tcp_clean_rtx_queue(struct sock *sk, int=
 prior_fackets,
>   		 */
>   		if (likely(!(scb->tcp_flags & TCPHDR_SYN))) {
>   			flag |=3D FLAG_DATA_ACKED;
> -			if (mptcp(tp) && mptcp_is_data_seq(skb))
> -				flag |=3D MPTCP_FLAG_DATA_ACKED;
>   		} else {
>   			flag |=3D FLAG_SYN_ACKED;
>   			tp->retrans_stamp =3D 0;
> @@ -3582,16 +3580,6 @@ static int tcp_ack(struct sock *sk, struct sk_buff=
 *skb, int flag)
>   				    sack_rtt_us);
>   	acked -=3D tp->packets_out;
>   =

> -	if (mptcp(tp)) {
> -		if (mptcp_fallback_infinite(sk, flag)) {
> -			pr_err("%s resetting flow\n", __func__);
> -			mptcp_send_reset(sk);
> -			goto invalid_ack;
> -		}
> -
> -		mptcp_clean_rtx_infinite(skb, sk);
> -	}
> -
>   	/* Advance cwnd if state allows */
>   	if (tcp_may_raise_cwnd(sk, flag))
>   		tcp_cong_avoid(sk, ack, acked);
> @@ -3824,8 +3812,7 @@ static bool tcp_fast_parse_options(const struct sk_=
buff *skb,
>   		if (tcp_parse_aligned_timestamp(tp, th))
>   			return true;
>   	}
> -	tcp_parse_options(skb, &tp->rx_opt,
> -			  mptcp(tp) ? &tp->mptcp->rx_opt : NULL, 1, NULL, tp);
> +	tcp_parse_options(skb, &tp->rx_opt, NULL, 1, NULL, tp);
>   	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
>   		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
>   =

> @@ -4550,11 +4537,12 @@ static void tcp_data_queue(struct sock *sk, struc=
t sk_buff *skb)
>   	int eaten =3D -1;
>   	bool fragstolen =3D false;
>   =

> -	/* If no data is present, but a data_fin is in the options, we still
> -	 * have to call mptcp_queue_skb later on. */
> -	if (TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq &&
> -	    !(mptcp(tp) && mptcp_is_data_fin(skb)))
> +	/*
> +	 * send every packet to MPTCP
> +	 */
> +	if (!mptcp(tp) && (TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq=
)) {
>   		goto drop;
> +	}
>   =

>   	skb_dst_drop(skb);
>   	__skb_pull(skb, tcp_hdr(skb)->doff * 4);
> @@ -5242,15 +5230,9 @@ syn_challenge:
>   		goto discard;
>   	}
>   =

> -	/* If valid: post process the received MPTCP options. */
> -	if (mptcp(tp) && mptcp_handle_options(sk, th, skb))
> -		goto discard;
> -
>   	return true;
>   =

>   discard:
> -	if (mptcp(tp))
> -		mptcp_reset_mopt(tp);
>   	__kfree_skb(skb);
>   	return false;
>   }
> @@ -5302,10 +5284,6 @@ void tcp_rcv_established(struct sock *sk, struct s=
k_buff *skb,
>   =

>   	tp->rx_opt.saw_tstamp =3D 0;
>   =

> -	/* MPTCP: force slowpath. */
> -	if (mptcp(tp))
> -		goto slow_path;
> -
>   	/*	pred_flags is 0xS?10 << 16 + snd_wnd
>   	 *	if header_prediction is to be made
>   	 *	'S' will always be tp->tcp_header_len >> 2
> @@ -5585,8 +5563,7 @@ static int tcp_rcv_synsent_state_process(struct soc=
k *sk, struct sk_buff *skb,
>   	struct mptcp_options_received mopt;
>   	mptcp_init_mp_opt(&mopt);
>   =

> -	tcp_parse_options(skb, &tp->rx_opt,
> -			  mptcp(tp) ? &tp->mptcp->rx_opt : &mopt, 0, &foc, tp);
> +	tcp_parse_options(skb, &tp->rx_opt, &mopt, 0, &foc, tp);
>   	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
>   		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
>   =

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 6967a86..3329679 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1420,6 +1420,71 @@ struct sock *tcp_v4_hnd_req(struct sock *sk, struc=
t sk_buff *skb)
>   	return sk;
>   }
>   =

> +int mptcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct net *net =3D dev_net(skb->dev);
> +	const struct tcphdr *th =3D tcp_hdr(skb);
> +	int ret;
> +	struct sock *meta_sk;
> +
> +	if (sk =3D=3D NULL) {
> +		if (th->syn && !th->ack) {
> +			int ret =3D mptcp_lookup_join(skb, NULL);
> +
> +			if (ret < 0) {
> +				tcp_v4_send_reset(NULL, skb);
> +				kfree_skb(skb);
> +				return (1);
> +			} else if (ret > 0) {
> +				return (1);
> +			}
> +		}
> +		/* Is there a pending request sock for this segment ? */
> +		if (mptcp_check_req(skb, net)) {
> +			return(1);	=

> +		}
> +		return (0);
> +	}
> +
> +	/* The socket passed in should never be the meta socket */
> +	=

> +	BUG_ON(is_meta_sk(sk));
> +
> +        /* Is there a pending request sock for this segment ? */
> +	if (sk->sk_state =3D=3D TCP_LISTEN && mptcp_check_req(skb, net)) {
> +		return 0;
> +	}
> +
> +	skb->dev =3D NULL;
> +	meta_sk =3D mptcp_meta_sk(sk);
> +
> +	ret =3D 0;
> +	skb->sk =3D sk;
> +	bh_lock_sock_nested(meta_sk);
> +	if (sock_owned_by_user(meta_sk)) {
> +		if (unlikely(sk_add_backlog(meta_sk, skb,
> +		    meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf))) {
> +
> +			NET_INC_STATS_BH(net, LINUX_MIB_TCPBACKLOGDROP);
> +			kfree_skb(skb);
> +		}
> +	} else {
> +
> +		if (is_meta_sk(sk)) {
> +			ret =3D mptcp_v4_process_join_req(sk, skb);
> +			goto done;
> +		}
> +		if (!meta_sk->sk_prequeue(meta_sk, skb)) {
> +			skb->sk =3D NULL;
> +			ret =3D tcp_v4_do_rcv(sk, skb);
> +		}
> +
> +	}
> +done:
> +	bh_unlock_sock(meta_sk);
> +	return (ret);
> +}
> +
>   /* The socket must have it's spinlock held when we get
>    * here.
>    *
> @@ -1432,8 +1497,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *=
skb)
>   {
>   	struct sock *rsk;
>   =

> -	if (is_meta_sk(sk))
> -		return mptcp_v4_do_rcv(sk, skb);
> +	BUG_ON(is_meta_sk(sk));
>   =

>   	if (sk->sk_state =3D=3D TCP_ESTABLISHED) { /* Fast path */
>   		struct dst_entry *dst =3D sk->sk_rx_dst;
> @@ -1587,6 +1651,8 @@ bool tcp_prequeue(struct sock *sk, struct sk_buff *=
skb)
>   }
>   EXPORT_SYMBOL(tcp_prequeue);
>   =

> +process_unclaimed tcp_process_unclaimed =3D NULL;
> +
>   /*
>    *	From tcp_input.c
>    */
> @@ -1595,7 +1661,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>   {
>   	const struct iphdr *iph;
>   	const struct tcphdr *th;
> -	struct sock *sk, *meta_sk =3D NULL;
> +	struct sock *sk =3D NULL;
>   	int ret;
>   	struct net *net =3D dev_net(skb->dev);
>   =

> @@ -1636,10 +1702,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>   	TCP_SKB_CB(skb)->end_seq =3D (TCP_SKB_CB(skb)->seq + th->syn + th->fin=
 +
>   				    skb->len - th->doff * 4);
>   	TCP_SKB_CB(skb)->ack_seq =3D ntohl(th->ack_seq);
> -#ifdef CONFIG_MPTCP
> -	TCP_SKB_CB(skb)->mptcp_flags =3D 0;
> -	TCP_SKB_CB(skb)->dss_off =3D 0;
> -#endif
> +
>   	TCP_SKB_CB(skb)->tcp_flags =3D tcp_flag_byte(th);
>   	TCP_SKB_CB(skb)->tcp_tw_isn =3D 0;
>   	TCP_SKB_CB(skb)->ip_dsfield =3D ipv4_get_dsfield(iph);
> @@ -1662,15 +1725,6 @@ process:
>   	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb))
>   		goto discard_and_relse;
>   =

> -#ifdef CONFIG_MPTCP
> -	/* Is there a pending request sock for this segment ? */
> -	if (sk->sk_state =3D=3D TCP_LISTEN && mptcp_check_req(skb, net)) {
> -		if (sk)
> -			sock_put(sk);
> -		return 0;
> -	}
> -#endif
> -
>   #ifdef CONFIG_TCP_MD5SIG
>   	/*
>   	 * We really want to reject the packet as early as possible
> @@ -1688,30 +1742,21 @@ process:
>   		goto discard_and_relse;
>   =

>   	sk_incoming_cpu_update(sk);
> -	skb->dev =3D NULL;
>   =

> -	if (mptcp(tcp_sk(sk))) {
> -		meta_sk =3D mptcp_meta_sk(sk);
> -
> -		bh_lock_sock_nested(meta_sk);
> -		if (sock_owned_by_user(meta_sk))
> -			skb->sk =3D sk;
> -	} else {
> -		meta_sk =3D sk;
> -		bh_lock_sock_nested(sk);
> -	}
> +	/* Do I have to set skb->dev to null ? */
> +	bh_lock_sock_nested(sk);
>   =

>   	ret =3D 0;
> -	if (!sock_owned_by_user(meta_sk)) {
> -		if (!tcp_prequeue(meta_sk, skb))
> -			ret =3D tcp_v4_do_rcv(sk, skb);
> -	} else if (unlikely(sk_add_backlog(meta_sk, skb,
> -					   meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf))) {
> -		bh_unlock_sock(meta_sk);
> +	if (!sock_owned_by_user(sk)) {
> +		if (!sk->sk_prequeue(sk, skb))
> +			ret =3D sk->sk_backlog_rcv(sk, skb);
> +	} else if (unlikely(sk_add_backlog(sk, skb,
> +		    sk->sk_rcvbuf + sk->sk_sndbuf))) {
> +		bh_unlock_sock(sk);
>   		NET_INC_STATS_BH(net, LINUX_MIB_TCPBACKLOGDROP);
>   		goto discard_and_relse;
>   	}
> -	bh_unlock_sock(meta_sk);
> +	bh_unlock_sock(sk);
>   =

>   	sock_put(sk);
>   =

> @@ -1721,26 +1766,11 @@ no_tcp_socket:
>   	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
>   		goto discard_it;
>   =

> -#ifdef CONFIG_MPTCP
> -	if (!sk && th->syn && !th->ack) {
> -		int ret =3D mptcp_lookup_join(skb, NULL);
> -
> -		if (ret < 0) {
> -			tcp_v4_send_reset(NULL, skb);
> -			goto discard_it;
> -		} else if (ret > 0) {
> -			return 0;
> -		}
> +	if (unlikely (tcp_process_unclaimed !=3D NULL)) {
> +		if ((tcp_process_unclaimed)(NULL, skb))
> +			return (0);
>   	}
>   =

> -	/* Is there a pending request sock for this segment ? */
> -	if (!sk && mptcp_check_req(skb, net)) {
> -		if (sk)
> -			sock_put(sk);
> -		return 0;
> -	}
> -#endif
> -
>   	if (skb->len < (th->doff << 2) || tcp_checksum_complete(skb)) {
>   csum_error:
>   		TCP_INC_STATS_BH(net, TCP_MIB_CSUMERRORS);
> @@ -2506,6 +2536,7 @@ struct proto tcp_prot =3D {
>   	.sendmsg		=3D tcp_sendmsg,
>   	.sendpage		=3D tcp_sendpage,
>   	.backlog_rcv		=3D tcp_v4_do_rcv,
> +	.prequeue		=3D tcp_prequeue,
>   	.release_cb		=3D tcp_release_cb,
>   	.hash			=3D inet_hash,
>   	.unhash			=3D inet_unhash,
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index a635483..41b8be8 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3413,6 +3413,7 @@ void tcp_send_delayed_ack(struct sock *sk)
>   void tcp_send_ack(struct sock *sk)
>   {
>   	struct sk_buff *buff;
> +	struct tcp_sock *tp =3D tcp_sk(sk);
>   =

>   	/* If we have been reset, we may not send again. */
>   	if (sk->sk_state =3D=3D TCP_CLOSE)
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index 8c4dd4a..1554217 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -193,6 +193,10 @@ lookup_protocol:
>   	sk->sk_protocol		=3D protocol;
>   =

>   	sk->sk_backlog_rcv	=3D answer->prot->backlog_rcv;
> +	sk->sk_prequeue		=3D answer->prot->prequeue;
> +	if (sk->sk_prequeue =3D=3D NULL) {
> +		sk->sk_prequeue =3D sk_prequeue;
> +	}
>   =

>   	inet_sk(sk)->pinet6 =3D np =3D inet6_sk_generic(sk);
>   	np->hop_limit	=3D -1;
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index eba2436..d360128 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1412,10 +1412,6 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, co=
nst struct ipv6hdr *hdr,
>   	TCP_SKB_CB(skb)->end_seq =3D (TCP_SKB_CB(skb)->seq + th->syn + th->fin=
 +
>   				    skb->len - th->doff*4);
>   	TCP_SKB_CB(skb)->ack_seq =3D ntohl(th->ack_seq);
> -#ifdef CONFIG_MPTCP
> -	TCP_SKB_CB(skb)->mptcp_flags =3D 0;
> -	TCP_SKB_CB(skb)->dss_off =3D 0;
> -#endif
>   	TCP_SKB_CB(skb)->tcp_flags =3D tcp_flag_byte(th);
>   	TCP_SKB_CB(skb)->tcp_tw_isn =3D 0;
>   	TCP_SKB_CB(skb)->ip_dsfield =3D ipv6_get_dsfield(hdr);
> diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
> index 28f348f..b1e780a 100644
> --- a/net/mptcp/mptcp_ctrl.c
> +++ b/net/mptcp/mptcp_ctrl.c
> @@ -976,6 +976,20 @@ int mptcp_backlog_rcv(struct sock *meta_sk, struct s=
k_buff *skb)
>   	struct sock *sk =3D skb->sk ? skb->sk : meta_sk;
>   	int ret =3D 0;
>   =

> +	 /* socket was owned by the user in mptcp_check_req()
> +	  */
> +	if (sk =3D=3D (struct sock *)0xFEE1DEAD) {
> +		bh_lock_sock_nested(meta_sk);
> +		if (skb->protocol =3D=3D htons(ETH_P_IP))
> +			mptcp_v4_process_join_req(meta_sk, skb);
> +#if IS_ENABLED(CONFIG_IPV6)
> +		else
> +			//mptcp_v6_process_join_req(meta_sk, skb);
> +#endif /* CONFIG_IPV6 */
> +		bh_unlock_sock(meta_sk);
> +		return(0);
> +	}
> +
>   	skb->sk =3D NULL;
>   =

>   	if (unlikely(!atomic_inc_not_zero(&sk->sk_refcnt))) {
> @@ -1297,6 +1311,10 @@ int mptcp_add_sock(struct sock *meta_sk, struct so=
ck *sk, u8 loc_id, u8 rem_id,
>   	sk->sk_write_space =3D mptcp_write_space;
>   	sk->sk_state_change =3D mptcp_set_state;
>   	sk->sk_destruct =3D mptcp_sock_destruct;
> +	 /* MPTCP takes a different path in tcp_v4_rcv
> +	  * thus not impacting main tcp code */
> +	sk->sk_backlog_rcv =3D mptcp_v4_do_rcv;
> +	sk->sk_prequeue =3D sk_prequeue;
>   =

>   	if (sk->sk_family =3D=3D AF_INET)
>   		mptcp_debug("%s: token %#x pi %d, src_addr:%pI4:%d dst_addr:%pI4:%d, =
cnt_subflows now %d\n",
> @@ -2658,6 +2676,9 @@ void __init mptcp_init(void)
>   	if (mptcp_pm_v4_init())
>   		goto mptcp_pm_v4_failed;
>   =

> +	if ((cmpxchg(&tcp_process_unclaimed, NULL, mptcp_v4_do_rcv)) !=3D NULL)
> +		printk("tcp_process_unclaimed not NULL \n");
> +
>   	mptcp_sysctl =3D register_net_sysctl(&init_net, "net/mptcp", mptcp_tab=
le);
>   	if (!mptcp_sysctl)
>   		goto register_sysctl_failed;
> diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
> index 51cbb06..0e09ddf 100644
> --- a/net/mptcp/mptcp_input.c
> +++ b/net/mptcp/mptcp_input.c
> @@ -323,9 +323,8 @@ static int mptcp_verif_dss_csum(struct sock *sk)
>   			 * by 4 bytes, as the high-order 64-bits will be added
>   			 * in the final csum_partial-call.
>   			 */
> -			u32 offset =3D skb_transport_offset(tmp) +
> -				     TCP_SKB_CB(tmp)->dss_off;
> -			if (TCP_SKB_CB(tmp)->mptcp_flags & MPTCPHDR_SEQ64_SET)
> +			u32 offset =3D skb_transport_offset(tmp) + tmp->mptcp_dss_off;
> +			if (tmp->mptcp_flags & MPTCPHDR_SEQ64_SET)
>   				offset +=3D 4;
>   =

>   			csum_tcp =3D skb_checksum(tmp, offset,
> @@ -758,7 +757,7 @@ static int mptcp_detect_mapping(struct sock *sk, stru=
ct sk_buff *skb)
>   	}
>   =

>   	/* Does the DSS had 64-bit seqnum's ? */
> -	if (!(tcb->mptcp_flags & MPTCPHDR_SEQ64_SET)) {
> +	if (!(skb->mptcp_flags & MPTCPHDR_SEQ64_SET)) {
>   		/* Wrapped around? */
>   		if (unlikely(after(data_seq, meta_tp->rcv_nxt) && data_seq < meta_tp-=
>rcv_nxt)) {
>   			tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb, !mpcb->rcv_h=
iseq_index, data_seq);
> @@ -767,9 +766,9 @@ static int mptcp_detect_mapping(struct sock *sk, stru=
ct sk_buff *skb)
>   			tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb, mpcb->rcv_hi=
seq_index, data_seq);
>   		}
>   	} else {
> -		tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb, (tcb->mptcp_fl=
ags & MPTCPHDR_SEQ64_INDEX) ? 1 : 0, data_seq);
> +		tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb, (skb->mptcp_fl=
ags & MPTCPHDR_SEQ64_INDEX) ? 1 : 0, data_seq);
>   =

> -		if (unlikely(tcb->mptcp_flags & MPTCPHDR_SEQ64_OFO)) {
> +		if (unlikely(skb->mptcp_flags & MPTCPHDR_SEQ64_OFO)) {
>   			/* We make sure that the data_seq is invalid.
>   			 * It will be dropped later.
>   			 */
> @@ -1020,6 +1019,67 @@ next:
>   	return data_queued ? -1 : -2;
>   }
>   =

> +static struct sk_buff *
> +mptcp_process_ack(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	int flag =3D 0;
> +
> +	/*
> +	 * TCP takes care of invalid ack's
> +	 * they will never show up here.
> +	 */
> +
> +	 /* Is this skb acknowleding anything data */
> +	=

> +	if (tp->mptcp->snt_isn + 1 !=3D TCP_SKB_CB(skb)->ack_seq) {
> +		flag =3D MPTCP_FLAG_DATA_ACKED;
> +	}
> +
> +	if (mptcp_fallback_infinite(sk, flag)) {
> +		pr_err("%s resetting flow\n", __func__);
> +		mptcp_send_reset(sk);
> +		goto invalid_ack;
> +	}
> +
> +	mptcp_clean_rtx_infinite(skb, sk);
> +
> +	return (skb);
> +invalid_ack:
> +	__skb_unlink(skb, &sk->sk_receive_queue);
> +	__kfree_skb(skb);
> +	return (NULL);
> +
> +}
> +
> +static struct sk_buff *
> +mptcp_process_options_ack(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	const struct tcphdr *th =3D tcp_hdr(skb);
> +
> +	skb->mptcp_flags =3D 0;
> +	skb->mptcp_dss_off =3D 0;
> +
> +	tcp_parse_mptcp_options(skb, &tp->mptcp->rx_opt);
> +	if (mptcp_handle_options(sk, th, skb)) {
> +		mptcp_reset_mopt(tp);
> +		__skb_unlink(skb, &sk->sk_receive_queue);
> +		__kfree_skb(skb);
> +		skb =3D NULL;
> +	}
> +	if ((skb !=3D NULL) && skb->len =3D=3D 0) {
> +		skb =3D mptcp_process_ack(sk, skb);
> +		if (skb !=3D NULL && skb->len =3D=3D 0) {
> +			/* Pure ack */
> +			__skb_unlink(skb, &sk->sk_receive_queue);
> +			__kfree_skb(skb);
> +			skb =3D NULL;
> +		}
> +	}
> +	return (skb);
> +}
> +
>   void mptcp_data_ready(struct sock *sk)
>   {
>   	struct sock *meta_sk =3D mptcp_meta_sk(sk);
> @@ -1045,6 +1105,10 @@ restart:
>   	 */
>   	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
>   		int ret;
> +
> +		skb =3D mptcp_process_options_ack(sk, skb);
> +		if (skb =3D=3D NULL)
> +			continue;
>   		/* Pre-validation - e.g., early fallback */
>   		ret =3D mptcp_prevalidate_skb(sk, skb);
>   		if (ret < 0)
> @@ -1108,13 +1172,11 @@ int mptcp_check_req(struct sk_buff *skb, struct n=
et *net)
>   	if (!meta_sk)
>   		return 0;
>   =

> -	TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
> -
>   	bh_lock_sock_nested(meta_sk);
>   	if (sock_owned_by_user(meta_sk)) {
> -		skb->sk =3D meta_sk;
> +		skb->sk =3D (struct sock *)0xFEE1DEAD;
>   		if (unlikely(sk_add_backlog(meta_sk, skb,
> -					    meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf))) {
> +				meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf))) {
>   			bh_unlock_sock(meta_sk);
>   			NET_INC_STATS_BH(net, LINUX_MIB_TCPBACKLOGDROP);
>   			sock_put(meta_sk); /* Taken by mptcp_search_req */
> @@ -1122,10 +1184,14 @@ int mptcp_check_req(struct sk_buff *skb, struct n=
et *net)
>   			return 1;
>   		}
>   	} else if (skb->protocol =3D=3D htons(ETH_P_IP)) {
> -		tcp_v4_do_rcv(meta_sk, skb);
> +		/*
> +		 * call old mptcp_v4_do_rcv
> +		 */
> +		mptcp_v4_process_join_req(meta_sk, skb);
>   #if IS_ENABLED(CONFIG_IPV6)
>   	} else { /* IPv6 */
> -		tcp_v6_do_rcv(meta_sk, skb);
> +		WARN_ON(1);
> +		//mptcp_v6_handle_join_req(meta_sk, skb);
>   #endif /* CONFIG_IPV6 */
>   	}
>   	bh_unlock_sock(meta_sk);
> @@ -1222,7 +1288,7 @@ int mptcp_lookup_join(struct sk_buff *skb, struct i=
net_timewait_sock *tw)
>   		inet_twsk_put(tw);
>   	}
>   =

> -	TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
> +	skb->mptcp_flags |=3D MPTCPHDR_JOIN;
>   	/* OK, this is a new syn/join, let's create a new open request and
>   	 * send syn+ack
>   	 */
> @@ -1279,7 +1345,7 @@ int mptcp_do_join_short(struct sk_buff *skb,
>   		return -1;
>   	}
>   =

> -	TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
> +	//TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
>   =

>   	/* OK, this is a new syn/join, let's create a new open request and
>   	 * send syn+ack
> @@ -1303,7 +1369,7 @@ int mptcp_do_join_short(struct sk_buff *skb,
>   	}
>   =

>   	if (sock_owned_by_user(meta_sk)) {
> -		skb->sk =3D meta_sk;
> +		skb->sk =3D (struct sock *)0xFEE1DEAD; //skb->sk =3D meta_sk;
>   		if (unlikely(sk_add_backlog(meta_sk, skb,
>   					    meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf)))
>   			NET_INC_STATS_BH(net, LINUX_MIB_TCPBACKLOGDROP);
> @@ -1319,10 +1385,12 @@ int mptcp_do_join_short(struct sk_buff *skb,
>   		 */
>   		skb_get(skb);
>   		if (skb->protocol =3D=3D htons(ETH_P_IP)) {
> -			tcp_v4_do_rcv(meta_sk, skb);
> +			//tcp_v4_do_rcv(meta_sk, skb);
> +			mptcp_v4_process_join_req(meta_sk, skb);
>   #if IS_ENABLED(CONFIG_IPV6)
>   		} else { /* IPv6 */
> -			tcp_v6_do_rcv(meta_sk, skb);
> +			//mptcp_v6_process_join_req(meta_sk, skb);
> +			//tcp_v6_do_rcv(meta_sk, skb);
>   #endif /* CONFIG_IPV6 */
>   		}
>   	}
> @@ -1461,7 +1529,6 @@ static void mptcp_data_ack(struct sock *sk, const s=
truct sk_buff *skb)
>   {
>   	struct sock *meta_sk =3D mptcp_meta_sk(sk);
>   	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk), *tp =3D tcp_sk(sk);
> -	struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
>   	u32 prior_snd_una =3D meta_tp->snd_una;
>   	int prior_packets;
>   	u32 nwin, data_ack, data_seq;
> @@ -1481,7 +1548,7 @@ static void mptcp_data_ack(struct sock *sk, const s=
truct sk_buff *skb)
>   	/* If we are in infinite mapping mode, rx_opt.data_ack has been
>   	 * set by mptcp_clean_rtx_infinite.
>   	 */
> -	if (!(tcb->mptcp_flags & MPTCPHDR_ACK) && !tp->mpcb->infinite_mapping_s=
nd)
> +	if (!(skb->mptcp_flags & MPTCPHDR_ACK) && !tp->mpcb->infinite_mapping_s=
nd)
>   		goto exit;
>   =

>   	data_ack =3D tp->mptcp->rx_opt.data_ack;
> @@ -1647,10 +1714,11 @@ static inline bool is_valid_addropt_opsize(u8 mpt=
cp_ver,
>   =

>   void mptcp_parse_options(const uint8_t *ptr, int opsize,
>   			 struct mptcp_options_received *mopt,
> -			 const struct sk_buff *skb,
> +			 struct sk_buff *skb,
>   			 struct tcp_sock *tp)
>   {
>   	const struct mptcp_option *mp_opt =3D (struct mptcp_option *)ptr;
> +	struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
>   =

>   	/* If the socket is mp-capable we would have a mopt. */
>   	if (!mopt)
> @@ -1757,7 +1825,7 @@ void mptcp_parse_options(const uint8_t *ptr, int op=
size,
>   		ptr +=3D 4;
>   =

>   		if (mdss->A) {
> -			tcb->mptcp_flags |=3D MPTCPHDR_ACK;
> +			skb->mptcp_flags |=3D MPTCPHDR_ACK;
>   =

>   			if (mdss->a) {
>   				mopt->data_ack =3D (u32) get_unaligned_be64(ptr);
> @@ -1768,13 +1836,13 @@ void mptcp_parse_options(const uint8_t *ptr, int =
opsize,
>   			}
>   		}
>   =

> -		tcb->dss_off =3D (ptr - skb_transport_header(skb));
> +		skb->mptcp_dss_off =3D (ptr - skb_transport_header(skb));
>   =

>   		if (mdss->M) {
>   			if (mdss->m) {
>   				u64 data_seq64 =3D get_unaligned_be64(ptr);
>   =

> -				tcb->mptcp_flags |=3D MPTCPHDR_SEQ64_SET;
> +				skb->mptcp_flags |=3D MPTCPHDR_SEQ64_SET;
>   				mopt->data_seq =3D (u32) data_seq64;
>   =

>   				ptr +=3D 12; /* 64-bit dseq + subseq */
> @@ -1784,15 +1852,16 @@ void mptcp_parse_options(const uint8_t *ptr, int =
opsize,
>   			}
>   			mopt->data_len =3D get_unaligned_be16(ptr);
>   =

> -			tcb->mptcp_flags |=3D MPTCPHDR_SEQ;
> +			skb->mptcp_flags |=3D MPTCPHDR_SEQ;
>   =

>   			/* Is a check-sum present? */
> -			if (opsize =3D=3D mptcp_sub_len_dss(mdss, 1))
> -				tcb->mptcp_flags |=3D MPTCPHDR_DSS_CSUM;
> +			if (opsize =3D=3D mptcp_sub_len_dss(mdss, 1)) {
> +				skb->mptcp_flags |=3D MPTCPHDR_DSS_CSUM;
> +			}
>   =

>   			/* DATA_FIN only possible with DSS-mapping */
>   			if (mdss->F)
> -				tcb->mptcp_flags |=3D MPTCPHDR_FIN;
> +				skb->mptcp_flags |=3D MPTCPHDR_FIN;
>   		}
>   =

>   		break;
> @@ -1907,8 +1976,9 @@ void tcp_parse_mptcp_options(const struct sk_buff *=
skb,
>   				return;
>   			if (opsize > length)
>   				return;	/* don't parse partial options */
> -			if (opcode =3D=3D TCPOPT_MPTCP)
> +			if (opcode =3D=3D TCPOPT_MPTCP) {
>   				mptcp_parse_options(ptr - 2, opsize, mopt, skb, NULL);
> +			}
>   		}
>   		ptr +=3D opsize - 2;
>   		length -=3D opsize;
> @@ -2168,6 +2238,8 @@ bool mptcp_handle_options(struct sock *sk, const st=
ruct tcphdr *th,
>   	struct tcp_sock *tp =3D tcp_sk(sk);
>   	struct mptcp_options_received *mopt =3D &tp->mptcp->rx_opt;
>   =

> +	BUG_ON(sk =3D=3D mptcp_meta_sk(sk));
> +
>   	if (tp->mpcb->infinite_mapping_rcv || tp->mpcb->infinite_mapping_snd)
>   		return false;
>   =

> @@ -2185,7 +2257,7 @@ bool mptcp_handle_options(struct sock *sk, const st=
ruct tcphdr *th,
>   	 * receiver MUST close the subflow with a RST as it is considered brok=
en.
>   	 */
>   	if (mptcp_is_data_seq(skb) && tp->mpcb->dss_csum &&
> -	    !(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_DSS_CSUM)) {
> +	    !(skb->mptcp_flags & MPTCPHDR_DSS_CSUM)) {
>   		mptcp_send_reset(sk);
>   		return true;
>   	}
> @@ -2330,6 +2402,7 @@ int mptcp_rcv_synsent_state_process(struct sock *sk=
, struct sock **skptr,
>   		/* Set this flag in order to postpone data sending
>   		 * until the 4th ack arrives.
>   		 */
> +printk("mptcp_rcv_synsent_state_process  pre_established set \n");
>   		tp->mptcp->pre_established =3D 1;
>   		tp->mptcp->rcv_low_prio =3D tp->mptcp->rx_opt.low_prio;
>   =

> diff --git a/net/mptcp/mptcp_ipv4.c b/net/mptcp/mptcp_ipv4.c
> index a147b20..3e60ab5 100644
> --- a/net/mptcp/mptcp_ipv4.c
> +++ b/net/mptcp/mptcp_ipv4.c
> @@ -180,45 +180,12 @@ static int mptcp_v4_join_request(struct sock *meta_=
sk, struct sk_buff *skb)
>   }
>   =

>   /* We only process join requests here. (either the SYN or the final ACK=
) */
> -int mptcp_v4_do_rcv(struct sock *meta_sk, struct sk_buff *skb)
> +int mptcp_v4_process_join_req(struct sock *meta_sk, struct sk_buff *skb)
>   {
>   	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
>   	struct sock *child, *rsk =3D NULL;
>   	int ret;
>   =

> -	if (!(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_JOIN)) {
> -		struct tcphdr *th =3D tcp_hdr(skb);
> -		const struct iphdr *iph =3D ip_hdr(skb);
> -		struct sock *sk;
> -
> -		sk =3D inet_lookup_established(sock_net(meta_sk), &tcp_hashinfo,
> -					     iph->saddr, th->source, iph->daddr,
> -					     th->dest, inet_iif(skb));
> -
> -		if (!sk) {
> -			kfree_skb(skb);
> -			return 0;
> -		}
> -		if (is_meta_sk(sk)) {
> -			WARN("%s Did not find a sub-sk - did found the meta!\n", __func__);
> -			kfree_skb(skb);
> -			sock_put(sk);
> -			return 0;
> -		}
> -
> -		if (sk->sk_state =3D=3D TCP_TIME_WAIT) {
> -			inet_twsk_put(inet_twsk(sk));
> -			kfree_skb(skb);
> -			return 0;
> -		}
> -
> -		ret =3D tcp_v4_do_rcv(sk, skb);
> -		sock_put(sk);
> -
> -		return ret;
> -	}
> -	TCP_SKB_CB(skb)->mptcp_flags =3D 0;
> -
>   	/* Has been removed from the tk-table. Thus, no new subflows.
>   	 *
>   	 * Check for close-state is necessary, because we may have been closed
> diff --git a/net/mptcp/mptcp_ipv6.c b/net/mptcp/mptcp_ipv6.c
> index 0de953d..1959d01 100644
> --- a/net/mptcp/mptcp_ipv6.c
> +++ b/net/mptcp/mptcp_ipv6.c
> @@ -199,7 +199,7 @@ int mptcp_v6_do_rcv(struct sock *meta_sk, struct sk_b=
uff *skb)
>   	struct sock *child, *rsk =3D NULL;
>   	int ret;
>   =

> -	if (!(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_JOIN)) {
> +	if (!(skb->mptcp_flags & MPTCPHDR_JOIN)) {
>   		struct tcphdr *th =3D tcp_hdr(skb);
>   		const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
>   		struct sock *sk;
> @@ -232,7 +232,7 @@ int mptcp_v6_do_rcv(struct sock *meta_sk, struct sk_b=
uff *skb)
>   =

>   		return ret;
>   	}
> -	TCP_SKB_CB(skb)->mptcp_flags =3D 0;
> +	skb->mptcp_flags =3D 0;
>   =

>   	/* Has been removed from the tk-table. Thus, no new subflows.
>   	 *
> diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
> index 691ef6f..e7d340d 100644
> --- a/net/mptcp/mptcp_output.c
> +++ b/net/mptcp/mptcp_output.c
> @@ -59,39 +59,17 @@ EXPORT_SYMBOL(mptcp_sub_len_remove_addr_align);
>    */
>   static bool mptcp_reconstruct_mapping(struct sk_buff *skb)
>   {
> -	const struct mp_dss *mpdss =3D (struct mp_dss *)TCP_SKB_CB(skb)->dss;
> -	u32 *p32;
> -	u16 *p16;
> -
>   	if (!mptcp_is_data_seq(skb))
>   		return false;
>   =

> -	if (!mpdss->M)
> -		return false;
> -
> -	/* Move the pointer to the data-seq */
> -	p32 =3D (u32 *)mpdss;
> -	p32++;
> -	if (mpdss->A) {
> -		p32++;
> -		if (mpdss->a)
> -			p32++;
> -	}
> -
> -	TCP_SKB_CB(skb)->seq =3D ntohl(*p32);
> -
> -	/* Get the data_len to calculate the end_data_seq */
> -	p32++;
> -	p32++;
> -	p16 =3D (u16 *)p32;
> -	TCP_SKB_CB(skb)->end_seq =3D ntohs(*p16) + TCP_SKB_CB(skb)->seq;
> +	TCP_SKB_CB(skb)->seq =3D TCP_SKB_CB(skb)->mptcp_data_seq;
>   =

>   	return true;
>   }
>   =

>   static bool mptcp_is_reinjected(const struct sk_buff *skb)
>   {
> -	return TCP_SKB_CB(skb)->mptcp_flags & MPTCP_REINJECT;
> +	return skb->mptcp_flags & MPTCP_REINJECT;
>   }
>   =

>   static void mptcp_find_and_set_pathmask(const struct sock *meta_sk, str=
uct sk_buff *skb)
> @@ -105,7 +83,7 @@ static void mptcp_find_and_set_pathmask(const struct s=
ock *meta_sk, struct sk_bu
>   			break;
>   =

>   		if (TCP_SKB_CB(skb_it)->seq =3D=3D TCP_SKB_CB(skb)->seq) {
> -			TCP_SKB_CB(skb)->path_mask =3D TCP_SKB_CB(skb_it)->path_mask;
> +			TCP_SKB_CB(skb)->mptcp_path_mask =3D TCP_SKB_CB(skb_it)->mptcp_path_m=
ask;
>   			break;
>   		}
>   	}
> @@ -180,9 +158,9 @@ static void __mptcp_reinject_data(struct sk_buff *ori=
g_skb, struct sock *meta_sk
>   	}
>   =

>   	/* Segment goes back to the MPTCP-layer. So, we need to zero the
> -	 * path_mask/dss.
> +	 * path_mask.
>   	 */
> -	memset(TCP_SKB_CB(skb)->dss, 0 , mptcp_dss_len);
> +	TCP_SKB_CB(skb)->mptcp_path_mask =3D 0;
>   =

>   	/* We need to find out the path-mask from the meta-write-queue
>   	 * to properly select a subflow.
> @@ -272,14 +250,14 @@ void mptcp_reinject_data(struct sock *sk, int clone=
_it)
>   		if (mptcp_is_reinjected(skb_it))
>   			continue;
>   =

> -		tcb->mptcp_flags |=3D MPTCP_REINJECT;
> +		skb_it->mptcp_flags |=3D MPTCP_REINJECT;
>   		__mptcp_reinject_data(skb_it, meta_sk, sk, clone_it);
>   	}
>   =

>   	skb_it =3D tcp_write_queue_tail(meta_sk);
>   	/* If sk has sent the empty data-fin, we have to reinject it too. */
>   	if (skb_it && mptcp_is_data_fin(skb_it) && skb_it->len =3D=3D 0 &&
> -	    TCP_SKB_CB(skb_it)->path_mask & mptcp_pi_to_flag(tp->mptcp->path_in=
dex)) {
> +	    TCP_SKB_CB(skb_it)->mptcp_path_mask & mptcp_pi_to_flag(tp->mptcp->p=
ath_index)) {
>   		__mptcp_reinject_data(skb_it, meta_sk, NULL, 1);
>   	}
>   =

> @@ -319,25 +297,43 @@ combine:
>   	}
>   }
>   =

> -static int mptcp_write_dss_mapping(const struct tcp_sock *tp, const stru=
ct sk_buff *skb,
> -				   __be32 *ptr)
> +/*
> + * RFC6824 states that once a particular subflow mapping has been sent
> + * out it must never be changed. However, packets may be split while
> + * they are in the retransmission queue (due to SACK or ACKs) and that
> + * arguably means that we would change the mapping (e.g. it splits it,
> + * our sends out a subset of the initial mapping).
> + *
> + * Furthermore, the skb checksum is not always preserved across splits
> + * (e.g. mptcp_fragment) which would mean that we need to recompute
> + * the DSS checksum in this case.
> + *
> + * To avoid this we save the initial DSS mapping which allows us to
> + * send the same DSS mapping even for fragmented retransmits.
> + */
> +
> +static int mptcp_write_dss_mapping(const struct tcp_sock *tp,
> +    const struct sk_buff *skb, __be32 *ptr)
>   {
>   	const struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
> -	__be32 *start =3D ptr;
>   	__u16 data_len;
>   =

> -	*ptr++ =3D htonl(tcb->seq); /* data_seq */
> +	*ptr++ =3D htonl(tcb->mptcp_data_seq); /* data_seq */
>   =

>   	/* If it's a non-data DATA_FIN, we set subseq to 0 (draft v7) */
>   	if (mptcp_is_data_fin(skb) && skb->len =3D=3D 0)
>   		*ptr++ =3D 0; /* subseq */
>   	else
> -		*ptr++ =3D htonl(tp->write_seq - tp->mptcp->snt_isn); /* subseq */
> +		*ptr++ =3D htonl(tcb->seq - tp->mptcp->snt_isn); /* subseq */
>   =

> -	if (tcb->mptcp_flags & MPTCPHDR_INF)
> +	if (skb->mptcp_flags & MPTCPHDR_INF)
>   		data_len =3D 0;
> -	else
> +	else {
>   		data_len =3D tcb->end_seq - tcb->seq;
> +		/* mptcp_entail_skb adds one for FIN */
> +		if (tcb->tcp_flags & TCPHDR_FIN)
> +			data_len -=3D 1;
> +	}
>   =

>   	if (tp->mpcb->dss_csum && data_len) {
>   		__be16 *p16 =3D (__be16 *)ptr;
> @@ -356,11 +352,11 @@ static int mptcp_write_dss_mapping(const struct tcp=
_sock *tp, const struct sk_bu
>   			       (TCPOPT_NOP));
>   	}
>   =

> -	return ptr - start;
> +	return mptcp_dss_len/sizeof(*ptr);
>   }
>   =

> -static int mptcp_write_dss_data_ack(const struct tcp_sock *tp, const str=
uct sk_buff *skb,
> -				    __be32 *ptr)
> +static int mptcp_write_dss_data_ack(const struct tcp_sock *tp,
> +    const struct sk_buff *skb, __be32 *ptr)
>   {
>   	struct mp_dss *mdss =3D (struct mp_dss *)ptr;
>   	__be32 *start =3D ptr;
> @@ -377,54 +373,12 @@ static int mptcp_write_dss_data_ack(const struct tc=
p_sock *tp, const struct sk_b
>   	mdss->len =3D mptcp_sub_len_dss(mdss, tp->mpcb->dss_csum);
>   	ptr++;
>   =

> +	/* data_ack */
>   	*ptr++ =3D htonl(mptcp_meta_tp(tp)->rcv_nxt);
>   =

>   	return ptr - start;
>   }
>   =

> -/* RFC6824 states that once a particular subflow mapping has been sent
> - * out it must never be changed. However, packets may be split while
> - * they are in the retransmission queue (due to SACK or ACKs) and that
> - * arguably means that we would change the mapping (e.g. it splits it,
> - * our sends out a subset of the initial mapping).
> - *
> - * Furthermore, the skb checksum is not always preserved across splits
> - * (e.g. mptcp_fragment) which would mean that we need to recompute
> - * the DSS checksum in this case.
> - *
> - * To avoid this we save the initial DSS mapping which allows us to
> - * send the same DSS mapping even for fragmented retransmits.
> - */
> -static void mptcp_save_dss_data_seq(const struct tcp_sock *tp, struct sk=
_buff *skb)
> -{
> -	struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
> -	__be32 *ptr =3D (__be32 *)tcb->dss;
> -
> -	tcb->mptcp_flags |=3D MPTCPHDR_SEQ;
> -
> -	ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
> -	ptr +=3D mptcp_write_dss_mapping(tp, skb, ptr);
> -}
> -
> -/* Write the saved DSS mapping to the header */
> -static int mptcp_write_dss_data_seq(const struct tcp_sock *tp, struct sk=
_buff *skb,
> -				    __be32 *ptr)
> -{
> -	__be32 *start =3D ptr;
> -
> -	memcpy(ptr, TCP_SKB_CB(skb)->dss, mptcp_dss_len);
> -
> -	/* update the data_ack */
> -	start[1] =3D htonl(mptcp_meta_tp(tp)->rcv_nxt);
> -
> -	/* dss is in a union with inet_skb_parm and
> -	 * the IP layer expects zeroed IPCB fields.
> -	 */
> -	memset(TCP_SKB_CB(skb)->dss, 0 , mptcp_dss_len);
> -
> -	return mptcp_dss_len/sizeof(*ptr);
> -}
> -
>   static bool mptcp_skb_entail(struct sock *sk, struct sk_buff *skb, int =
reinject)
>   {
>   	struct tcp_sock *tp =3D tcp_sk(sk);
> @@ -434,7 +388,7 @@ static bool mptcp_skb_entail(struct sock *sk, struct =
sk_buff *skb, int reinject)
>   	struct sk_buff *subskb =3D NULL;
>   =

>   	if (!reinject)
> -		TCP_SKB_CB(skb)->mptcp_flags |=3D (mpcb->snd_hiseq_index ?
> +		skb->mptcp_flags |=3D (mpcb->snd_hiseq_index ?
>   						  MPTCPHDR_SEQ64_INDEX : 0);
>   =

>   	subskb =3D pskb_copy_for_clone(skb, GFP_ATOMIC);
> @@ -447,7 +401,7 @@ static bool mptcp_skb_entail(struct sock *sk, struct =
sk_buff *skb, int reinject)
>   	 */
>   	tcp_skb_pcount_set(subskb, 0);
>   =

> -	TCP_SKB_CB(skb)->path_mask |=3D mptcp_pi_to_flag(tp->mptcp->path_index);
> +	TCP_SKB_CB(skb)->mptcp_path_mask |=3D mptcp_pi_to_flag(tp->mptcp->path_=
index);
>   =

>   	if (!(sk->sk_route_caps & NETIF_F_ALL_CSUM) &&
>   	    skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> @@ -463,13 +417,14 @@ static bool mptcp_skb_entail(struct sock *sk, struc=
t sk_buff *skb, int reinject)
>   		tp->mptcp->fully_established =3D 1;
>   		tp->mpcb->infinite_mapping_snd =3D 1;
>   		tp->mptcp->infinite_cutoff_seq =3D tp->write_seq;
> -		tcb->mptcp_flags |=3D MPTCPHDR_INF;
> +		skb->mptcp_flags |=3D MPTCPHDR_INF;
>   	}
>   =

>   	if (mptcp_is_data_fin(subskb))
>   		mptcp_combine_dfin(subskb, meta_sk, sk);
>   =

> -	mptcp_save_dss_data_seq(tp, subskb);
> +	subskb->mptcp_flags |=3D MPTCPHDR_SEQ;
> +	tcb->mptcp_data_seq =3D tcb->seq;
>   =

>   	tcb->seq =3D tp->write_seq;
>   =

> @@ -536,10 +491,10 @@ static int mptcp_fragment(struct sock *meta_sk, str=
uct sk_buff *skb, u32 len,
>   =

>   	buff =3D skb->next;
>   =

> -	flags =3D TCP_SKB_CB(skb)->mptcp_flags;
> -	TCP_SKB_CB(skb)->mptcp_flags =3D flags & ~(MPTCPHDR_FIN);
> -	TCP_SKB_CB(buff)->mptcp_flags =3D flags;
> -	TCP_SKB_CB(buff)->path_mask =3D TCP_SKB_CB(skb)->path_mask;
> +	flags =3D skb->mptcp_flags;
> +	skb->mptcp_flags =3D flags & ~(MPTCPHDR_FIN);
> +	buff->mptcp_flags =3D flags;
> +	TCP_SKB_CB(buff)->mptcp_path_mask =3D TCP_SKB_CB(skb)->mptcp_path_mask;
>   =

>   	/* If reinject =3D=3D 1, the buff will be added to the reinject
>   	 * queue, which is currently not part of memory accounting. So
> @@ -927,8 +882,9 @@ void mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
>   	 * It does not make sense to check for the options, because when the
>   	 * segment gets sent, another subflow will be chosen.
>   	 */
> -	if (!skb && is_meta_sk(sk))
> +	if (!skb && is_meta_sk(sk)) {
>   		return;
> +	}
>   =

>   	/* In fallback mp_fail-mode, we have to repeat it until the fallback
>   	 * has been done by the sender
> @@ -967,10 +923,11 @@ void mptcp_established_options(struct sock *sk, str=
uct sk_buff *skb,
>   	if (unlikely(mpcb->infinite_mapping_snd) &&
>   	    ((mpcb->send_infinite_mapping && tcb &&
>   	      mptcp_is_data_seq(skb) &&
> -	      !(tcb->mptcp_flags & MPTCPHDR_INF) &&
> +	      !(skb->mptcp_flags & MPTCPHDR_INF) &&
>   	      !before(tcb->seq, tp->mptcp->infinite_cutoff_seq)) ||
> -	     !mpcb->send_infinite_mapping))
> +	     !mpcb->send_infinite_mapping)) {
>   		return;
> +	}
>   =

>   	if (unlikely(tp->mptcp->include_mpc)) {
>   		opts->options |=3D OPTION_MPTCP;
> @@ -995,9 +952,11 @@ void mptcp_established_options(struct sock *sk, stru=
ct sk_buff *skb,
>   	    mpcb->mptcp_ver >=3D MPTCP_VERSION_1 && skb && !mptcp_is_data_seq(=
skb)) {
>   		mpcb->pm_ops->addr_signal(sk, size, opts, skb);
>   =

> -		if (opts->add_addr_v6)
> +		if (opts->add_addr_v6) {
> +
>   			/* Skip subsequent options */
>   			return;
> +		}
>   	}
>   =

>   	if (!tp->mptcp->include_mpc && !tp->mptcp->pre_established) {
> @@ -1197,10 +1156,11 @@ void mptcp_options_write(__be32 *ptr, struct tcp_=
sock *tp,
>   	}
>   =

>   	if (OPTION_DATA_ACK & opts->mptcp_options) {
> -		if (!mptcp_is_data_seq(skb))
> -			ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
> -		else
> -			ptr +=3D mptcp_write_dss_data_seq(tp, skb, ptr);
> +		ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
> +		if (mptcp_is_data_seq(skb)) {
> +			ptr +=3D mptcp_write_dss_mapping(tp, skb, ptr);
> +		}
> +		skb->dev =3D NULL;
>   	}
>   	if (unlikely(OPTION_MP_PRIO & opts->mptcp_options)) {
>   		struct mp_prio *mpprio =3D (struct mp_prio *)ptr;
> @@ -1233,7 +1193,7 @@ void mptcp_send_fin(struct sock *meta_sk)
>   	mss_now =3D mptcp_current_mss(meta_sk);
>   =

>   	if (tcp_send_head(meta_sk) !=3D NULL) {
> -		TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_FIN;
> +		skb->mptcp_flags |=3D MPTCPHDR_FIN;
>   		TCP_SKB_CB(skb)->end_seq++;
>   		meta_tp->write_seq++;
>   	} else {
> @@ -1250,7 +1210,7 @@ void mptcp_send_fin(struct sock *meta_sk)
>   =

>   		tcp_init_nondata_skb(skb, meta_tp->write_seq, TCPHDR_ACK);
>   		TCP_SKB_CB(skb)->end_seq++;
> -		TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_FIN;
> +		skb->mptcp_flags |=3D MPTCPHDR_FIN;
>   		tcp_queue_skb(meta_sk, skb);
>   	}
>   	__tcp_push_pending_frames(meta_sk, mss_now, TCP_NAGLE_OFF);
> diff --git a/net/mptcp/mptcp_redundant.c b/net/mptcp/mptcp_redundant.c
> index 8fa2dba..37a13f4 100644
> --- a/net/mptcp/mptcp_redundant.c
> +++ b/net/mptcp/mptcp_redundant.c
> @@ -72,10 +72,10 @@ static bool redsched_use_subflow(struct sock *meta_sk,
>   	if (!skb || !mptcp_is_available((struct sock *)tp, skb, false))
>   		return false;
>   =

> -	if (TCP_SKB_CB(skb)->path_mask !=3D 0)
> +	if (TCP_SKB_CB(skb)->mptcp_path_mask !=3D 0)
>   		return subflow_is_active(tp);
>   =

> -	if (TCP_SKB_CB(skb)->path_mask =3D=3D 0) {
> +	if (TCP_SKB_CB(skb)->mptcp_path_mask =3D=3D 0) {
>   		if (active_valid_sks =3D=3D -1)
>   			active_valid_sks =3D redsched_get_active_valid_sks(meta_sk);
>   =

> @@ -209,7 +209,7 @@ static struct sk_buff *redundant_next_segment(struct =
sock *meta_sk,
>   			cb_data->next_subflow =3D tp->mptcp->next;
>   			*subsk =3D (struct sock *)tp;
>   =

> -			if (TCP_SKB_CB(skb)->path_mask)
> +			if (TCP_SKB_CB(skb)->mptcp_path_mask)
>   				*reinject =3D -1;
>   			return skb;
>   		}
> diff --git a/net/mptcp/mptcp_rr.c b/net/mptcp/mptcp_rr.c
> index 8910ba9..83837f2 100644
> --- a/net/mptcp/mptcp_rr.c
> +++ b/net/mptcp/mptcp_rr.c
> @@ -93,7 +93,7 @@ static int mptcp_rr_dont_reinject_skb(const struct tcp_=
sock *tp, const struct sk
>   	 */
>   	return skb &&
>   		/* Has the skb already been enqueued into this subsocket? */
> -		mptcp_pi_to_flag(tp->mptcp->path_index) & TCP_SKB_CB(skb)->path_mask;
> +		mptcp_pi_to_flag(tp->mptcp->path_index) & TCP_SKB_CB(skb)->mptcp_path_=
mask;
>   }
>   =

>   /* We just look for any subflow that is available */
> @@ -136,7 +136,7 @@ static struct sock *rr_get_available_subflow(struct s=
ock *meta_sk,
>   		 * chance again by restarting its pathmask.
>   		 */
>   		if (skb)
> -			TCP_SKB_CB(skb)->path_mask =3D 0;
> +			TCP_SKB_CB(skb)->mptcp_path_mask =3D 0;
>   		sk =3D backupsk;
>   	}
>   =

> diff --git a/net/mptcp/mptcp_sched.c b/net/mptcp/mptcp_sched.c
> index 54408ff..5cbbf91 100644
> --- a/net/mptcp/mptcp_sched.c
> +++ b/net/mptcp/mptcp_sched.c
> @@ -118,7 +118,7 @@ static int mptcp_dont_reinject_skb(const struct tcp_s=
ock *tp, const struct sk_bu
>   	 */
>   	return skb &&
>   		/* Has the skb already been enqueued into this subsocket? */
> -		mptcp_pi_to_flag(tp->mptcp->path_index) & TCP_SKB_CB(skb)->path_mask;
> +		mptcp_pi_to_flag(tp->mptcp->path_index) & TCP_SKB_CB(skb)->mptcp_path_=
mask;
>   }
>   =

>   bool subflow_is_backup(const struct tcp_sock *tp)
> @@ -261,7 +261,7 @@ struct sock *get_available_subflow(struct sock *meta_=
sk, struct sk_buff *skb,
>   		 * the skb passed through all the available active and backups
>   		 * sks, so clean the path mask
>   		 */
> -		TCP_SKB_CB(skb)->path_mask =3D 0;
> +		TCP_SKB_CB(skb)->mptcp_path_mask =3D 0;
>   	return sk;
>   }
>   EXPORT_SYMBOL_GPL(get_available_subflow);
> @@ -298,7 +298,7 @@ static struct sk_buff *mptcp_rcv_buf_optimization(str=
uct sock *sk, int penal)
>   	/* Half the cwnd of the slow flow */
>   	mptcp_for_each_tp(tp->mpcb, tp_it) {
>   		if (tp_it !=3D tp &&
> -		    TCP_SKB_CB(skb_head)->path_mask & mptcp_pi_to_flag(tp_it->mptcp->p=
ath_index)) {
> +		    TCP_SKB_CB(skb_head)->mptcp_path_mask & mptcp_pi_to_flag(tp_it->mp=
tcp->path_index)) {
>   			if (tp->srtt_us < tp_it->srtt_us && inet_csk((struct sock *)tp_it)->=
icsk_ca_state =3D=3D TCP_CA_Open) {
>   				u32 prior_cwnd =3D tp_it->snd_cwnd;
>   =

> @@ -317,11 +317,11 @@ static struct sk_buff *mptcp_rcv_buf_optimization(s=
truct sock *sk, int penal)
>   retrans:
>   =

>   	/* Segment not yet injected into this path? Take it!!! */
> -	if (!(TCP_SKB_CB(skb_head)->path_mask & mptcp_pi_to_flag(tp->mptcp->pat=
h_index))) {
> +	if (!(TCP_SKB_CB(skb_head)->mptcp_path_mask & mptcp_pi_to_flag(tp->mptc=
p->path_index))) {
>   		bool do_retrans =3D false;
>   		mptcp_for_each_tp(tp->mpcb, tp_it) {
>   			if (tp_it !=3D tp &&
> -			    TCP_SKB_CB(skb_head)->path_mask & mptcp_pi_to_flag(tp_it->mptcp->=
path_index)) {
> +			    TCP_SKB_CB(skb_head)->mptcp_path_mask & mptcp_pi_to_flag(tp_it->m=
ptcp->path_index)) {
>   				if (tp_it->snd_cwnd <=3D 4) {
>   					do_retrans =3D true;
>   					break;


--===============7834819016887166715==--
