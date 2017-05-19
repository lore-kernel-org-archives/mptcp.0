Content-Type: multipart/mixed; boundary="===============3587485528976561331=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] Revert tcp_skb_cb to it's original size using
 'struct tcp_skb_cb_ext'
Date: Thu, 18 May 2017 17:08:36 -0700
Message-ID: <alpine.OSX.2.21.1705181557470.23841@asathava-mobl1.amr.corp.intel.com>
In-Reply-To: 80c39b1b-0f02-a180-fbf5-dc20827482be@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 39

--===============3587485528976561331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Rao,

If we take the approach we discussed yesterday (rx side defers MPTCP =

processing until skb reaches the MPTCP layer, tx side pre-populates the =

TCP option), is it necessary to alter the tcp control block as this patch =

does?

I think with one bit in struct tcp_skb_cb, TCP could be told to interpret =

the beginning of the buffer as a TCP option (the kind & length encoded in =

the option would give enough context to finish writing the TCP header).

Mat


On Thu, 18 May 2017, Rao Shoaib wrote:

> The performance issue that I allude to below in only on the Rx side. 'str=
uct =

> tcp_skb_cb_ext' has to be allocated even when the connection is not using =

> MPTCP. If that can be resolved some how, there wont be any issues.
>
> Rao
>
>
> On 05/17/2017 05:50 PM, Rao Shoaib wrote:
>> This patch allocates a structure 'struct tcp_skb_cb_ext' to store values
>> that do not fit in tcp_skb_cb. On the Tx side the structure is allocated
>> as part of the skb carrying the payload. It is freed when the data is =

>> acked.
>> The structure is not passed down below TCP. On the Rxside the structure =
is
>> allocated when the packet is received by TCP, it is freed when the skb
>> is freed.
>> =

>> No changes are required to any of the functions implementing various skb
>> operations.
>> =

>> There might be some performance degradation due to extra allocation.
>> Maintaining a cache of 'struct tcp_skb_cb_ext' might help.
>> =

>> This patch reverses the size of tcp_skb_cb back to 48.
>> =

>> Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
>> ---
>>   include/linux/skbuff.h   |   2 +-
>>   include/net/mptcp.h      |   6 ++-
>>   include/net/tcp.h        | 105 =

>> ++++++++++++++++++++++++++++++++++++-----------
>>   net/ipv4/syncookies.c    |   2 +-
>>   net/ipv4/tcp.c           |  18 ++++++--
>>   net/ipv4/tcp_input.c     |  16 ++++++--
>>   net/ipv4/tcp_ipv4.c      |  22 ++++++----
>>   net/ipv4/tcp_output.c    |  25 +++++++----
>>   net/ipv6/syncookies.c    |   2 +-
>>   net/ipv6/tcp_ipv6.c      |  36 +++++++++++-----
>>   net/mptcp/mptcp_ctrl.c   |   2 +-
>>   net/mptcp/mptcp_input.c  |  37 +++++++++++++++--
>>   net/mptcp/mptcp_ipv4.c   |   6 ++-
>>   net/mptcp/mptcp_ipv6.c   |   3 +-
>>   net/mptcp/mptcp_output.c |  29 +++++++------
>>   15 files changed, 230 insertions(+), 81 deletions(-)
>> =

>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index f66cd5e..ca2e26a 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -540,7 +540,7 @@ struct sk_buff {
>>   	 * want to keep them across layers you have to do a skb_clone()
>>   	 * first. This is owned by whoever has the skb queued ATM.
>>   	 */
>> -	char			cb[56] __aligned(8);
>> +	char			cb[48] __aligned(8);
>>     	unsigned long		_skb_refdst;
>>   	void			(*destructor)(struct sk_buff *skb);
>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>> index 876f1e6..ff0df36 100644
>> --- a/include/net/mptcp.h
>> +++ b/include/net/mptcp.h
>> @@ -1000,12 +1000,14 @@ static inline void mptcp_sub_force_close_all(str=
uct =

>> mptcp_cb *mpcb,
>>     static inline bool mptcp_is_data_seq(const struct sk_buff *skb)
>>   {
>> -	return TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ;
>> +	return ((TCP_SKB_CB(skb)->tcp_skb_ext =3D=3D NULL) ? 0 :
>> +	    TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ);
>>   }
>>     static inline bool mptcp_is_data_fin(const struct sk_buff *skb)
>>   {
>> -	return TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_FIN;
>> +	return ((TCP_SKB_CB(skb)->tcp_skb_ext =3D=3D NULL) ? 0 :
>> +	    TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_FIN);
>>   }
>>     /* Is it a data-fin while in infinite mapping mode?
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 655ecd4..abe3641 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -822,6 +822,30 @@ static inline u32 tcp_skb_timestamp(const struct =

>> sk_buff *skb)
>>   #define TCPHDR_ECE 0x40
>>   #define TCPHDR_CWR 0x80
>>   +struct tcp_skb_cb_ext {
>> +	union {
>> +		struct inet_skb_parm    h4;
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +		struct inet6_skb_parm    h6;
>> +#endif
>> +	} header;
>> +
>> +	union {			/* For MPTCP outgoing frames */
>> +		__u32 path_mask; /* paths that tried to send this skb */
>> +		__u32 dss[6];	/* DSS options */
>> +	};
>> +
>> +	__u8	mptcp_flags;	/* flags for the MPTCP layer    */
>> +	__u8	dss_off;	/* Number of 4-byte words until */
>> +};
>> +
>> +#define	tcp_ipcb_v4	tcp_skb_ext->header.h4
>> +#define	tcp_ipcb_v6	tcp_skb_ext->header.h6
>> +#define	mptcp_flags	tcp_skb_ext->mptcp_flags
>> +#define	path_mask	tcp_skb_ext->path_mask
>> +#define	dss_off		tcp_skb_ext->dss_off
>> +#define	dss		tcp_skb_ext->dss
>> +
>>   /* This is what the send packet queuing engine uses to pass
>>    * TCP per-packet control information to the transmission code.
>>    * We also store the host-order sequence numbers in here too.
>> @@ -829,7 +853,7 @@ static inline u32 tcp_skb_timestamp(const struct =

>> sk_buff *skb)
>>    * If this grows please adjust skbuff.h:skbuff->cb[xxx] size =

>> appropriately.
>>    */
>>   struct tcp_skb_cb {
>> -	__u32		seq;		/* Starting sequence number	*/
>> +	__u32		seq;		/* Starting sequence number     */
>>   	__u32		end_seq;	/* SEQ + FIN + SYN + datalen	*/
>>   	union {
>>   		/* Note : tcp_tw_isn is used in input path only
>> @@ -842,11 +866,6 @@ struct tcp_skb_cb {
>>   		__u32		tcp_gso_segs;
>>   	};
>>   -#ifdef CONFIG_MPTCP
>> -	__u8		mptcp_flags;	/* flags for the MPTCP layer    */
>> -	__u8		dss_off;	/* Number of 4-byte words until
>> -					 * seq-number */
>> -#endif
>>   	__u8		tcp_flags;	/* TCP header flags. (tcp[13])	*/
>>     	__u8		sacked;		/* State flags for SACK/FACK.	*/
>> @@ -861,25 +880,65 @@ struct tcp_skb_cb {
>>     	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
>>   	/* 1 byte hole */
>> +	struct tcp_skb_cb_ext *tcp_skb_ext;
>>   	__u32		ack_seq;	/* Sequence number ACK'd	*/
>> -	union {
>> -		union {
>> -			struct inet_skb_parm	h4;
>> -#if IS_ENABLED(CONFIG_IPV6)
>> -			struct inet6_skb_parm	h6;
>> -#endif
>> -		} header;	/* For incoming frames		*/
>> -#ifdef CONFIG_MPTCP
>> -		union {			/* For MPTCP outgoing frames */
>> -			__u32 path_mask; /* paths that tried to send this skb =

>> */
>> -			__u32 dss[6];	/* DSS options */
>> -		};
>> -#endif
>> -	};
>>   };
>>     #define TCP_SKB_CB(__skb)	((struct tcp_skb_cb *)&((__skb)->cb[0]))
>>   +static inline struct tcp_skb_cb_ext *tcp_skb_cb_ext_alloc(struct sk_b=
uff =

>> *skb)
>> +{
>> +	int extra;
>> +
>> +	if (TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL) {
>> +		return (TCP_SKB_CB(skb)->tcp_skb_ext);
>> +	}
>> +
>> +	extra =3D SKB_DATA_ALIGN(sizeof(struct tcp_skb_cb_ext));
>> +
>> +	TCP_SKB_CB(skb)->tcp_skb_ext =3D kzalloc(extra, GFP_KERNEL);
>> +	if (TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL) {
>> +		skb->truesize +=3D extra;
>> +		return (TCP_SKB_CB(skb)->tcp_skb_ext);
>> +	}
>> +	return (NULL);
>> +}
>> +
>> +static inline void tcp_sk_wmem_free_skb(struct sock *sk, struct sk_buff =

>> *skb)
>> +{
>> +	if (TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL) {
>> +		kfree (TCP_SKB_CB(skb)->tcp_skb_ext);
>> +		TCP_SKB_CB(skb)->tcp_skb_ext =3D NULL;
>> +	}
>> +	sk_wmem_free_skb(sk, skb);
>> +}
>> +
>> +typedef enum {
>> +	SKB_DEFAULT,
>> +	SKB_FCLONE
>> +} tcp_skb_flag_t;
>> +
>> +static inline struct sk_buff *tcp_alloc_skb(unsigned int size,
>> +    gfp_t priority, tcp_skb_flag_t tcp_skb_flag) {
>> +	struct sk_buff *skb;
>> +
>> +	switch (tcp_skb_flag) {
>> +	case (SKB_FCLONE) :
>> +		skb =3D alloc_skb_fclone(size, priority);
>> +		break;
>> +	case (SKB_DEFAULT):
>> +	default:
>> +		skb =3D alloc_skb(size, priority);
>> +		break;
>> +	}
>> +
>> +	if (skb && (tcp_skb_cb_ext_alloc(skb) =3D=3D NULL)) {
>> +		kfree_skb(skb);
>> +		return (NULL);
>> +	}
>> +
>> +	return (skb);
>> +}
>>     #if IS_ENABLED(CONFIG_IPV6)
>>   /* This is the variant of inet6_iif() that must be used by TCP,
>> @@ -887,7 +946,7 @@ struct tcp_skb_cb {
>>    */
>>   static inline int tcp_v6_iif(const struct sk_buff *skb)
>>   {
>> -	return TCP_SKB_CB(skb)->header.h6.iif;
>> +	return TCP_SKB_CB(skb)->tcp_ipcb_v6.iif;
>>   }
>>   #endif
>>   @@ -1533,7 +1592,7 @@ static inline void tcp_write_queue_purge(struct =

>> sock *sk)
>>   	struct sk_buff *skb;
>>     	while ((skb =3D __skb_dequeue(&sk->sk_write_queue)) !=3D NULL)
>> -		sk_wmem_free_skb(sk, skb);
>> +		tcp_sk_wmem_free_skb(sk, skb);
>>   	sk_mem_reclaim(sk);
>>   	tcp_clear_all_retrans_hints(tcp_sk(sk));
>>   }
>> @@ -1869,7 +1928,7 @@ void tcp_init(void);
>>    */
>>   static inline struct ip_options_rcu *tcp_v4_save_options(struct sk_buf=
f =

>> *skb)
>>   {
>> -	const struct ip_options *opt =3D &TCP_SKB_CB(skb)->header.h4.opt;
>> +	const struct ip_options *opt =3D &TCP_SKB_CB(skb)->tcp_ipcb_v4.opt;
>>   	struct ip_options_rcu *dopt =3D NULL;
>>     	if (opt->optlen) {
>> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
>> index 5ce0cff..2da0282 100644
>> --- a/net/ipv4/syncookies.c
>> +++ b/net/ipv4/syncookies.c
>> @@ -310,7 +310,7 @@ EXPORT_SYMBOL(cookie_ecn_ok);
>>     struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>>   {
>> -	struct ip_options *opt =3D &TCP_SKB_CB(skb)->header.h4.opt;
>> +	struct ip_options *opt =3D &TCP_SKB_CB(skb)->tcp_ipcb_v4.opt;
>>   	struct tcp_options_received tcp_opt;
>>   	struct mptcp_options_received mopt;
>>   	struct inet_request_sock *ireq;
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 63c107c..f3cbaf2 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -852,7 +852,12 @@ struct sk_buff *sk_stream_alloc_skb(struct sock *sk=
, =

>> int size, gfp_t gfp)
>>     	skb =3D alloc_skb_fclone(size + sk->sk_prot->max_header, gfp);
>>   	if (skb) {
>> -		if (sk_wmem_schedule(sk, skb->truesize)) {
>> +		/*
>> +		 * allocate tcp_skb_cb_ext
>> +		 */
>> +		(void)tcp_skb_cb_ext_alloc(skb);
>> +		if ((TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL) &&
>> +		    (sk_wmem_schedule(sk, skb->truesize))) {
>>   			skb_reserve(skb, sk->sk_prot->max_header);
>>   			/*
>>   			 * Make sure that we have exactly size bytes
>> @@ -861,11 +866,14 @@ struct sk_buff *sk_stream_alloc_skb(struct sock *s=
k, =

>> int size, gfp_t gfp)
>>   			skb->reserved_tailroom =3D skb->end - skb->tail - size;
>>   			return skb;
>>   		}
>> +		if (TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL)
>> +			kfree (TCP_SKB_CB(skb)->tcp_skb_ext);
>>   		__kfree_skb(skb);
>>   	} else {
>>   		sk->sk_prot->enter_memory_pressure(sk);
>>   		sk_stream_moderate_sndbuf(sk);
>>   	}
>> +
>>   	return NULL;
>>   }
>>   @@ -1344,7 +1352,7 @@ do_fault:
>>   		 * reset, where we can be unlinking the send_head.
>>   		 */
>>   		tcp_check_send_head(sk, skb);
>> -		sk_wmem_free_skb(sk, skb);
>> +		tcp_sk_wmem_free_skb(sk, skb);
>>   	}
>>     do_error:
>> @@ -3160,7 +3168,11 @@ void __init tcp_init(void)
>>   	int max_rshare, max_wshare, cnt;
>>   	unsigned int i;
>>   -	sock_skb_cb_check_size(sizeof(struct tcp_skb_cb));
>> +	/*
>> +	 * copied from the current upstream tree
>> +	 */
>> +	BUILD_BUG_ON(sizeof(struct tcp_skb_cb) >
>> +                     FIELD_SIZEOF(struct sk_buff, cb));
>>     	percpu_counter_init(&tcp_sockets_allocated, 0, GFP_KERNEL);
>>   	percpu_counter_init(&tcp_orphan_count, 0, GFP_KERNEL);
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index 16a7256..cb95a7e 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -1354,7 +1354,7 @@ static bool tcp_shifted_skb(struct sock *sk, struc=
t =

>> sk_buff *skb,
>>   		tcp_advance_highest_sack(sk, skb);
>>     	tcp_unlink_write_queue(skb, sk);
>> -	sk_wmem_free_skb(sk, skb);
>> +	tcp_sk_wmem_free_skb(sk, skb);
>>     	NET_INC_STATS_BH(sock_net(sk), LINUX_MIB_SACKMERGED);
>>   @@ -3144,7 +3144,7 @@ static int tcp_clean_rtx_queue(struct sock *sk, =
int =

>> prior_fackets,
>>   			break;
>>     		tcp_unlink_write_queue(skb, sk);
>> -		sk_wmem_free_skb(sk, skb);
>> +		tcp_sk_wmem_free_skb(sk, skb);
>>   		if (unlikely(skb =3D=3D tp->retransmit_skb_hint))
>>   			tp->retransmit_skb_hint =3D NULL;
>>   		if (unlikely(skb =3D=3D tp->lost_skb_hint))
>> @@ -4639,6 +4639,8 @@ out_of_window:
>>   		tcp_enter_quickack_mode(sk);
>>   		inet_csk_schedule_ack(sk);
>>   drop:
>> +		if (TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL)
>> +			kfree (TCP_SKB_CB(skb)->tcp_skb_ext);
>>   		__kfree_skb(skb);
>>   		return;
>>   	}
>> @@ -4749,11 +4751,14 @@ restart:
>>   		int copy =3D min_t(int, SKB_MAX_ORDER(0, 0), end - start);
>>   		struct sk_buff *nskb;
>>   -		nskb =3D alloc_skb(copy, GFP_ATOMIC);
>> +		nskb =3D tcp_alloc_skb(copy, GFP_ATOMIC, SKB_DEFAULT);
>>   		if (!nskb)
>>   			return;
>>     		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
>> +		memcpy(TCP_SKB_CB(nskb)->tcp_skb_ext,
>> +		    TCP_SKB_CB(skb)->tcp_skb_ext,
>> +		    sizeof(struct tcp_skb_cb_ext));
>>   		TCP_SKB_CB(nskb)->seq =3D TCP_SKB_CB(nskb)->end_seq =3D start;
>>   		__skb_queue_before(list, skb, nskb);
>>   		skb_set_owner_r(nskb, sk);
>> @@ -5251,6 +5256,8 @@ syn_challenge:
>>   discard:
>>   	if (mptcp(tp))
>>   		mptcp_reset_mopt(tp);
>> +	if (TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL)
>> +		kfree (TCP_SKB_CB(skb)->tcp_skb_ext);
>>   	__kfree_skb(skb);
>>   	return false;
>>   }
>> @@ -5473,8 +5480,11 @@ csum_error:
>>   	TCP_INC_STATS_BH(sock_net(sk), TCP_MIB_INERRS);
>>     discard:
>> +	if (TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL)
>> +		kfree (TCP_SKB_CB(skb)->tcp_skb_ext);
>>   	__kfree_skb(skb);
>>   }
>> +
>>   EXPORT_SYMBOL(tcp_rcv_established);
>>     void tcp_finish_connect(struct sock *sk, struct sk_buff *skb)
>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> index 6967a86..c035271 100644
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -694,7 +694,7 @@ void tcp_v4_send_reset(struct sock *sk, struct sk_bu=
ff =

>> *skb)
>>     	arg.tos =3D ip_hdr(skb)->tos;
>>   	ip_send_unicast_reply(*this_cpu_ptr(net->ipv4.tcp_sk),
>> -			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
>> +			      skb, &TCP_SKB_CB(skb)->tcp_ipcb_v4.opt,
>>   			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
>>   			      &arg, arg.iov[0].iov_len);
>>   @@ -798,7 +798,7 @@ static void tcp_v4_send_ack(struct net *net,
>>   		arg.bound_dev_if =3D oif;
>>   	arg.tos =3D tos;
>>   	ip_send_unicast_reply(*this_cpu_ptr(net->ipv4.tcp_sk),
>> -			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
>> +			      skb, &TCP_SKB_CB(skb)->tcp_ipcb_v4.opt,
>>   			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
>>   			      &arg, arg.iov[0].iov_len);
>>   @@ -1599,6 +1599,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
>>   	int ret;
>>   	struct net *net =3D dev_net(skb->dev);
>>   +	TCP_SKB_CB(skb)->tcp_skb_ext =3D NULL;
>> +
>>   	if (skb->pkt_type !=3D PACKET_HOST)
>>   		goto discard_it;
>>   @@ -1612,6 +1614,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>>     	if (th->doff < sizeof(struct tcphdr) / 4)
>>   		goto bad_packet;
>> +
>>   	if (!pskb_may_pull(skb, th->doff * 4))
>>   		goto discard_it;
>>   @@ -1625,10 +1628,14 @@ int tcp_v4_rcv(struct sk_buff *skb)
>>     	th =3D tcp_hdr(skb);
>>   	iph =3D ip_hdr(skb);
>> +
>> +	if (tcp_skb_cb_ext_alloc(skb) =3D=3D NULL)
>> +		goto discard_it;
>> +
>>   	/* This is tricky : We move IPCB at its correct location into =

>> TCP_SKB_CB()
>>   	 * barrier() makes sure compiler wont play fool^Waliasing games.
>>   	 */
>> -	memmove(&TCP_SKB_CB(skb)->header.h4, IPCB(skb),
>> +	memmove(&TCP_SKB_CB(skb)->tcp_ipcb_v4, IPCB(skb),
>>   		sizeof(struct inet_skb_parm));
>>   	barrier();
>>   @@ -1636,10 +1643,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>>   	TCP_SKB_CB(skb)->end_seq =3D (TCP_SKB_CB(skb)->seq + th->syn + th->fi=
n =

>> +
>>   				    skb->len - th->doff * 4);
>>   	TCP_SKB_CB(skb)->ack_seq =3D ntohl(th->ack_seq);
>> -#ifdef CONFIG_MPTCP
>> -	TCP_SKB_CB(skb)->mptcp_flags =3D 0;
>> -	TCP_SKB_CB(skb)->dss_off =3D 0;
>> -#endif
>> +
>>   	TCP_SKB_CB(skb)->tcp_flags =3D tcp_flag_byte(th);
>>   	TCP_SKB_CB(skb)->tcp_tw_isn =3D 0;
>>   	TCP_SKB_CB(skb)->ip_dsfield =3D ipv4_get_dsfield(iph);
>> @@ -1752,6 +1756,10 @@ bad_packet:
>>     discard_it:
>>   	/* Discard frame. */
>> +	if (TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL) {
>> +		kfree(TCP_SKB_CB(skb)->tcp_skb_ext);
>> +		TCP_SKB_CB(skb)->tcp_skb_ext =3D NULL;
>> +	}
>>   	kfree_skb(skb);
>>   	return 0;
>>   diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index a635483..25f8d95 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -540,6 +540,10 @@ static void tcp_options_write(__be32 *ptr, struct =

>> tcp_sock *tp,
>>     	if (unlikely(OPTION_MPTCP & opts->options))
>>   		mptcp_options_write(ptr, tp, opts, skb);
>> +	/*
>> +	 * Now that we have written the options, NULL out the pointer
>> +	 */
>> +	TCP_SKB_CB(skb)->tcp_skb_ext =3D NULL;
>>   }
>>     /* Compute TCP options for SYN packets. This is not the final
>> @@ -2008,7 +2012,7 @@ static int tcp_mtu_probe(struct sock *sk)
>>   			 * Throw it away. */
>>   			TCP_SKB_CB(nskb)->tcp_flags |=3D =

>> TCP_SKB_CB(skb)->tcp_flags;
>>   			tcp_unlink_write_queue(skb, sk);
>> -			sk_wmem_free_skb(sk, skb);
>> +			tcp_sk_wmem_free_skb(sk, skb);
>>   		} else {
>>   			TCP_SKB_CB(nskb)->tcp_flags |=3D =

>> TCP_SKB_CB(skb)->tcp_flags &
>>   						   ~(TCPHDR_FIN|TCPHDR_PSH);
>> @@ -2533,7 +2537,7 @@ static void tcp_collapse_retrans(struct sock *sk, =

>> struct sk_buff *skb)
>>     	tcp_adjust_pcount(sk, next_skb, tcp_skb_pcount(next_skb));
>>   -	sk_wmem_free_skb(sk, next_skb);
>> +	tcp_sk_wmem_free_skb(sk, next_skb);
>>   }
>>     /* Check if coalescing SKBs is legal. */
>> @@ -2905,7 +2909,8 @@ coalesce:
>>   			return;
>>   		}
>>   	} else {
>> -		skb =3D alloc_skb_fclone(MAX_TCP_HEADER, sk->sk_allocation);
>> +		skb =3D tcp_alloc_skb(MAX_TCP_HEADER, sk->sk_allocation,
>> +		    SKB_FCLONE);
>>   		if (unlikely(!skb)) {
>>   			if (tskb)
>>   				goto coalesce;
>> @@ -2931,8 +2936,8 @@ void tcp_send_active_reset(struct sock *sk, gfp_t =

>> priority)
>>   	struct sk_buff *skb;
>>     	/* NOTE: No TCP options attached and we never retransmit this. */
>> -	skb =3D alloc_skb(MAX_TCP_HEADER, priority);
>> -	if (!skb) {
>> +	skb =3D tcp_alloc_skb(MAX_TCP_HEADER, priority, SKB_DEFAULT);
>> +        if (!skb) {
>>   		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTFAILED);
>>   		return;
>>   	}
>> @@ -2972,7 +2977,7 @@ int tcp_send_synack(struct sock *sk)
>>   			tcp_unlink_write_queue(skb, sk);
>>   			__skb_header_release(nskb);
>>   			__tcp_add_write_queue_head(sk, nskb);
>> -			sk_wmem_free_skb(sk, skb);
>> +			tcp_sk_wmem_free_skb(sk, skb);
>>   			sk->sk_wmem_queued +=3D nskb->truesize;
>>   			sk_mem_charge(sk, nskb->truesize);
>>   			skb =3D nskb;
>> @@ -3424,7 +3429,8 @@ void tcp_send_ack(struct sock *sk)
>>   	 * tcp_transmit_skb() will set the ownership to this
>>   	 * sock.
>>   	 */
>> -	buff =3D alloc_skb(MAX_TCP_HEADER, sk_gfp_atomic(sk, GFP_ATOMIC));
>> +	buff =3D tcp_alloc_skb(MAX_TCP_HEADER, sk_gfp_atomic(sk, GFP_ATOMIC),
>> +	    SKB_DEFAULT);
>>   	if (!buff) {
>>   		inet_csk_schedule_ack(sk);
>>   		inet_csk(sk)->icsk_ack.ato =3D TCP_ATO_MIN;
>> @@ -3468,8 +3474,9 @@ int tcp_xmit_probe_skb(struct sock *sk, int urgent)
>>   	struct sk_buff *skb;
>>     	/* We don't queue it, tcp_transmit_skb() sets ownership. */
>> -	skb =3D alloc_skb(MAX_TCP_HEADER, sk_gfp_atomic(sk, GFP_ATOMIC));
>> -	if (!skb)
>> +	skb =3D tcp_alloc_skb(MAX_TCP_HEADER, sk_gfp_atomic(sk, GFP_ATOMIC),
>> +	    SKB_DEFAULT);
>> +        if (!skb)
>>   		return -1;
>>     	/* Reserve space for headers and set control bits. */
>> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
>> index faea999..c349380 100644
>> --- a/net/ipv6/syncookies.c
>> +++ b/net/ipv6/syncookies.c
>> @@ -242,7 +242,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct =

>> sk_buff *skb)
>>   	ireq->ir_num =3D ntohs(th->dest);
>>   	ireq->ir_v6_rmt_addr =3D ipv6_hdr(skb)->saddr;
>>   	ireq->ir_v6_loc_addr =3D ipv6_hdr(skb)->daddr;
>> -	if (ipv6_opt_accepted(sk, skb, &TCP_SKB_CB(skb)->header.h6) ||
>> +	if (ipv6_opt_accepted(sk, skb, &TCP_SKB_CB(skb)->tcp_ipcb_v6) ||
>>   	    np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
>>   	    np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim) {
>>   		atomic_inc(&skb->users);
>> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
>> index eba2436..0218d6a 100644
>> --- a/net/ipv6/tcp_ipv6.c
>> +++ b/net/ipv6/tcp_ipv6.c
>> @@ -699,7 +699,7 @@ static int tcp_v6_init_req(struct request_sock *req, =

>> struct sock *sk,
>>   		ireq->ir_iif =3D tcp_v6_iif(skb);
>>     	if (!TCP_SKB_CB(skb)->tcp_tw_isn &&
>> -	    (ipv6_opt_accepted(sk, skb, &TCP_SKB_CB(skb)->header.h6) ||
>> +	    (ipv6_opt_accepted(sk, skb, &TCP_SKB_CB(skb)->tcp_ipcb_v6) ||
>>   	     np->rxopt.bits.rxinfo ||
>>   	     np->rxopt.bits.rxoinfo || np->rxopt.bits.rxhlim ||
>>   	     np->rxopt.bits.rxohlim || np->repflow)) {
>> @@ -771,8 +771,8 @@ static void tcp_v6_send_response(struct sock *sk, =

>> struct sk_buff *skb, u32 seq,
>>   	if (mptcp)
>>   		tot_len +=3D MPTCP_SUB_LEN_DSS + MPTCP_SUB_LEN_ACK;
>>   #endif
>> -	buff =3D alloc_skb(MAX_HEADER + sizeof(struct ipv6hdr) + tot_len,
>> -			 GFP_ATOMIC);
>> +	buff =3D tcp_alloc_skb(MAX_HEADER + sizeof(struct ipv6hdr) + tot_len,
>> +			 GFP_ATOMIC, SKB_DEFAULT);
>>   	if (!buff)
>>   		return;
>>   @@ -1356,6 +1356,11 @@ reset:
>>   discard:
>>   	if (opt_skb)
>>   		__kfree_skb(opt_skb);
>> +	if (TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL) {
>> +		kfree (TCP_SKB_CB(skb)->tcp_skb_ext);
>> +		TCP_SKB_CB(skb)->tcp_skb_ext =3D NULL;
>> +	}
>> +
>>   	kfree_skb(skb);
>>   	return 0;
>>   csum_err:
>> @@ -1383,7 +1388,7 @@ ipv6_pktoptions:
>>   			np->rcv_flowinfo =3D ip6_flowinfo(ipv6_hdr(opt_skb));
>>   		if (np->repflow)
>>   			np->flow_label =3D ip6_flowlabel(ipv6_hdr(opt_skb));
>> -		if (ipv6_opt_accepted(sk, opt_skb, =

>> &TCP_SKB_CB(opt_skb)->header.h6)) {
>> +		if (ipv6_opt_accepted(sk, opt_skb, =

>> &TCP_SKB_CB(opt_skb)->tcp_ipcb_v6)) {
>>   			skb_set_owner_r(opt_skb, sk);
>>   			opt_skb =3D xchg(&np->pktoptions, opt_skb);
>>   		} else {
>> @@ -1404,7 +1409,7 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, co=
nst =

>> struct ipv6hdr *hdr,
>>   	 * _decode_session6() uses IP6CB().
>>   	 * barrier() makes sure compiler won't play aliasing games.
>>   	 */
>> -	memmove(&TCP_SKB_CB(skb)->header.h6, IP6CB(skb),
>> +	memmove(&TCP_SKB_CB(skb)->tcp_ipcb_v6, IP6CB(skb),
>>   		sizeof(struct inet6_skb_parm));
>>   	barrier();
>>   @@ -1412,10 +1417,7 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, =

>> const struct ipv6hdr *hdr,
>>   	TCP_SKB_CB(skb)->end_seq =3D (TCP_SKB_CB(skb)->seq + th->syn + th->fi=
n =

>> +
>>   				    skb->len - th->doff*4);
>>   	TCP_SKB_CB(skb)->ack_seq =3D ntohl(th->ack_seq);
>> -#ifdef CONFIG_MPTCP
>> -	TCP_SKB_CB(skb)->mptcp_flags =3D 0;
>> -	TCP_SKB_CB(skb)->dss_off =3D 0;
>> -#endif
>> +
>>   	TCP_SKB_CB(skb)->tcp_flags =3D tcp_flag_byte(th);
>>   	TCP_SKB_CB(skb)->tcp_tw_isn =3D 0;
>>   	TCP_SKB_CB(skb)->ip_dsfield =3D ipv6_get_dsfield(hdr);
>> @@ -1427,7 +1429,7 @@ static void tcp_v6_restore_cb(struct sk_buff *skb)
>>   	/* We need to move header back to the beginning if =

>> xfrm6_policy_check()
>>   	 * and tcp_v6_fill_cb() are going to be called again.
>>   	 */
>> -	memmove(IP6CB(skb), &TCP_SKB_CB(skb)->header.h6,
>> +	memmove(IP6CB(skb), &TCP_SKB_CB(skb)->tcp_ipcb_v6,
>>   		sizeof(struct inet6_skb_parm));
>>   }
>>   @@ -1439,6 +1441,8 @@ static int tcp_v6_rcv(struct sk_buff *skb)
>>   	int ret;
>>   	struct net *net =3D dev_net(skb->dev);
>>   +	TCP_SKB_CB(skb)->tcp_skb_ext =3D NULL;
>> +
>>   	if (skb->pkt_type !=3D PACKET_HOST)
>>   		goto discard_it;
>>   @@ -1454,6 +1458,7 @@ static int tcp_v6_rcv(struct sk_buff *skb)
>>     	if (th->doff < sizeof(struct tcphdr)/4)
>>   		goto bad_packet;
>> +
>>   	if (!pskb_may_pull(skb, th->doff*4))
>>   		goto discard_it;
>>   @@ -1467,7 +1472,6 @@ static int tcp_v6_rcv(struct sk_buff *skb)
>>   				inet6_iif(skb));
>>   	if (!sk)
>>   		goto no_tcp_socket;
>> -
>>   process:
>>   	if (sk && sk->sk_state =3D=3D TCP_TIME_WAIT)
>>   		goto do_time_wait;
>> @@ -1483,6 +1487,9 @@ process:
>>   	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb))
>>   		goto discard_and_relse;
>>   +	if (tcp_skb_cb_ext_alloc(skb) =3D=3D NULL)
>> +		goto discard_and_relse;
>> +
>>   	tcp_v6_fill_cb(skb, hdr, th);
>>     #ifdef CONFIG_MPTCP
>> @@ -1536,6 +1543,9 @@ no_tcp_socket:
>>   	if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))
>>   		goto discard_it;
>>   +	if (tcp_skb_cb_ext_alloc(skb) =3D=3D NULL)
>> +		goto discard_it;
>> +
>>   	tcp_v6_fill_cb(skb, hdr, th);
>>     #ifdef CONFIG_MPTCP
>> @@ -1568,6 +1578,10 @@ bad_packet:
>>   	}
>>     discard_it:
>> +	if (TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL) {
>> +		kfree(TCP_SKB_CB(skb)->tcp_skb_ext);
>> +		TCP_SKB_CB(skb)->tcp_skb_ext =3D NULL;
>> +	}
>>   	kfree_skb(skb);
>>   	return 0;
>>   diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
>> index 28f348f..0730c26 100644
>> --- a/net/mptcp/mptcp_ctrl.c
>> +++ b/net/mptcp/mptcp_ctrl.c
>> @@ -1459,7 +1459,7 @@ static int mptcp_sub_send_fin(struct sock *sk)
>>   		TCP_SKB_CB(skb)->end_seq++;
>>   		tp->write_seq++;
>>   	} else {
>> -		skb =3D alloc_skb_fclone(MAX_TCP_HEADER, GFP_ATOMIC);
>> +		skb =3D tcp_alloc_skb(MAX_TCP_HEADER, GFP_ATOMIC, SKB_FCLONE);
>>   		if (!skb)
>>   			return 1;
>>   diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
>> index 51cbb06..60aa548 100644
>> --- a/net/mptcp/mptcp_input.c
>> +++ b/net/mptcp/mptcp_input.c
>> @@ -146,7 +146,7 @@ static void mptcp_clean_rtx_queue(struct sock *meta_=
sk, =

>> u32 prior_snd_una)
>>   				mptcp_sub_close(sk_it, delay);
>>   			}
>>   		}
>> -		sk_wmem_free_skb(meta_sk, skb);
>> +		tcp_sk_wmem_free_skb(meta_sk, skb);
>>   	}
>>   	/* Remove acknowledged data from the reinject queue */
>>   	skb_queue_walk_safe(&mpcb->reinject_queue, skb, tmp) {
>> @@ -494,7 +494,7 @@ static int mptcp_skb_split_tail(struct sk_buff *skb, =

>> struct sock *sk, u32 seq)
>>   		nsize =3D 0;
>>     	/* Get a new skb... force flag on. */
>> -	buff =3D alloc_skb(nsize, GFP_ATOMIC);
>> +	buff =3D tcp_alloc_skb(nsize, GFP_ATOMIC, SKB_DEFAULT);
>>   	if (buff =3D=3D NULL)
>>   		return -ENOMEM;
>>   @@ -542,6 +542,8 @@ static int mptcp_prevalidate_skb(struct sock *sk, =

>> struct sk_buff *skb)
>>   		 */
>>   		tp->copied_seq =3D TCP_SKB_CB(skb)->end_seq;
>>   		__skb_unlink(skb, &sk->sk_receive_queue);
>> +		if (TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL)
>> +			kfree (TCP_SKB_CB(skb)->tcp_skb_ext);
>>   		__kfree_skb(skb);
>>   		return -1;
>>   	}
>> @@ -706,6 +708,8 @@ static int mptcp_detect_mapping(struct sock *sk, str=
uct =

>> sk_buff *skb)
>>   	if (tp->mptcp->send_mp_fail) {
>>   		tp->copied_seq =3D TCP_SKB_CB(skb)->end_seq;
>>   		__skb_unlink(skb, &sk->sk_receive_queue);
>> +		if (TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL)
>> +			kfree (TCP_SKB_CB(skb)->tcp_skb_ext);
>>   		__kfree_skb(skb);
>>   		return -1;
>>   	}
>> @@ -844,6 +848,8 @@ static int mptcp_validate_mapping(struct sock *sk, =

>> struct sk_buff *skb)
>>   			 */
>>   			tp->copied_seq =3D TCP_SKB_CB(skb)->end_seq;
>>   			__skb_unlink(skb, &sk->sk_receive_queue);
>> +			if (TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL)
>> +				kfree (TCP_SKB_CB(skb)->tcp_skb_ext);
>>   			__kfree_skb(skb);
>>   			return -1;
>>   		}
>> @@ -865,6 +871,8 @@ static int mptcp_validate_mapping(struct sock *sk, =

>> struct sk_buff *skb)
>>   			/* Impossible that we could free skb here, because =

>> his
>>   			 * mapping is known to be valid from previous checks
>>   			 */
>> +			if (TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL)
>> +				kfree (TCP_SKB_CB(skb)->tcp_skb_ext);
>>   			__kfree_skb(tmp1);
>>   		}
>>   	}
>> @@ -1026,6 +1034,7 @@ void mptcp_data_ready(struct sock *sk)
>>   	struct sk_buff *skb, *tmp;
>>   	int queued =3D 0;
>>   +
>>   	/* restart before the check, because mptcp_fin might have changed the
>>   	 * state.
>>   	 */
>> @@ -1045,6 +1054,7 @@ restart:
>>   	 */
>>   	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
>>   		int ret;
>> +
>>   		/* Pre-validation - e.g., early fallback */
>>   		ret =3D mptcp_prevalidate_skb(sk, skb);
>>   		if (ret < 0)
>> @@ -1108,6 +1118,11 @@ int mptcp_check_req(struct sk_buff *skb, struct n=
et =

>> *net)
>>   	if (!meta_sk)
>>   		return 0;
>>   +	if (tcp_skb_cb_ext_alloc(skb) =3D=3D NULL) {
>> +		kfree_skb(skb);
>> +		return 1;
>> +	}
>> +
>>   	TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
>>     	bh_lock_sock_nested(meta_sk);
>> @@ -1222,6 +1237,9 @@ int mptcp_lookup_join(struct sk_buff *skb, struct =

>> inet_timewait_sock *tw)
>>   		inet_twsk_put(tw);
>>   	}
>>   +	if (tcp_skb_cb_ext_alloc(skb) =3D=3D NULL)
>> +		return (-1);
>> +
>>   	TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
>>   	/* OK, this is a new syn/join, let's create a new open request and
>>   	 * send syn+ack
>> @@ -1481,7 +1499,9 @@ static void mptcp_data_ack(struct sock *sk, const =

>> struct sk_buff *skb)
>>   	/* If we are in infinite mapping mode, rx_opt.data_ack has been
>>   	 * set by mptcp_clean_rtx_infinite.
>>   	 */
>> -	if (!(tcb->mptcp_flags & MPTCPHDR_ACK) && =

>> !tp->mpcb->infinite_mapping_snd)
>> +	if ((TCP_SKB_CB(skb)->tcp_skb_ext !=3D NULL) &&
>> +	    !(tcb->mptcp_flags & MPTCPHDR_ACK) &&
>> +	    !tp->mpcb->infinite_mapping_snd)
>>   		goto exit;
>>     	data_ack =3D tp->mptcp->rx_opt.data_ack;
>> @@ -1652,6 +1672,14 @@ void mptcp_parse_options(const uint8_t *ptr, int =

>> opsize,
>>   {
>>   	const struct mptcp_option *mp_opt =3D (struct mptcp_option *)ptr;
>>   +	/*
>> +	 * sometimes it may not be necessary to allocate tcp_skb_cb_ext
>> +	 * fix mptcp code to dela with that
>> +	 */
>> +	if (tcp_skb_cb_ext_alloc((struct sk_buff *)skb) =3D=3D NULL) {
>> +		return;
>> +	}
>> +
>>   	/* If the socket is mp-capable we would have a mopt. */
>>   	if (!mopt)
>>   		return;
>> @@ -1754,6 +1782,7 @@ void mptcp_parse_options(const uint8_t *ptr, int =

>> opsize,
>>   			break;
>>   		}
>>   +
>>   		ptr +=3D 4;
>>     		if (mdss->A) {
>> @@ -1908,7 +1937,7 @@ void tcp_parse_mptcp_options(const struct sk_buff =

>> *skb,
>>   			if (opsize > length)
>>   				return;	/* don't parse partial options */
>>   			if (opcode =3D=3D TCPOPT_MPTCP)
>> -				mptcp_parse_options(ptr - 2, opsize, mopt, =

>> skb, NULL);
>> +				mptcp_parse_options(ptr - 2, opsize, mopt, =

>> (struct sk_buff *) skb, NULL);
>>   		}
>>   		ptr +=3D opsize - 2;
>>   		length -=3D opsize;
>> diff --git a/net/mptcp/mptcp_ipv4.c b/net/mptcp/mptcp_ipv4.c
>> index a147b20..b96e5a0 100644
>> --- a/net/mptcp/mptcp_ipv4.c
>> +++ b/net/mptcp/mptcp_ipv4.c
>> @@ -186,7 +186,11 @@ int mptcp_v4_do_rcv(struct sock *meta_sk, struct =

>> sk_buff *skb)
>>   	struct sock *child, *rsk =3D NULL;
>>   	int ret;
>>   -	if (!(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_JOIN)) {
>> +	/*
>> +	 * If tcp_skb_ext =3D=3D NULL this is not a JOIN request
>> +	 */
>> +	if ((TCP_SKB_CB(skb)->tcp_skb_ext =3D=3D NULL) ||
>> +		!(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_JOIN)) {
>>   		struct tcphdr *th =3D tcp_hdr(skb);
>>   		const struct iphdr *iph =3D ip_hdr(skb);
>>   		struct sock *sk;
>> diff --git a/net/mptcp/mptcp_ipv6.c b/net/mptcp/mptcp_ipv6.c
>> index 0de953d..475c6cb 100644
>> --- a/net/mptcp/mptcp_ipv6.c
>> +++ b/net/mptcp/mptcp_ipv6.c
>> @@ -199,7 +199,8 @@ int mptcp_v6_do_rcv(struct sock *meta_sk, struct =

>> sk_buff *skb)
>>   	struct sock *child, *rsk =3D NULL;
>>   	int ret;
>>   -	if (!(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_JOIN)) {
>> +	if ((TCP_SKB_CB(skb)->tcp_skb_ext =3D=3D NULL) ||
>> +	    !(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_JOIN)) {
>>   		struct tcphdr *th =3D tcp_hdr(skb);
>>   		const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
>>   		struct sock *sk;
>> diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
>> index 691ef6f..de9ae81 100644
>> --- a/net/mptcp/mptcp_output.c
>> +++ b/net/mptcp/mptcp_output.c
>> @@ -413,15 +413,8 @@ static int mptcp_write_dss_data_seq(const struct =

>> tcp_sock *tp, struct sk_buff *s
>>   	__be32 *start =3D ptr;
>>     	memcpy(ptr, TCP_SKB_CB(skb)->dss, mptcp_dss_len);
>> -
>>   	/* update the data_ack */
>>   	start[1] =3D htonl(mptcp_meta_tp(tp)->rcv_nxt);
>> -
>> -	/* dss is in a union with inet_skb_parm and
>> -	 * the IP layer expects zeroed IPCB fields.
>> -	 */
>> -	memset(TCP_SKB_CB(skb)->dss, 0 , mptcp_dss_len);
>> -
>>   	return mptcp_dss_len/sizeof(*ptr);
>>   }
>>   @@ -441,6 +434,14 @@ static bool mptcp_skb_entail(struct sock *sk, str=
uct =

>> sk_buff *skb, int reinject)
>>   	if (!subskb)
>>   		return false;
>>   +	TCP_SKB_CB(subskb)->tcp_skb_ext =3D NULL;
>> +	if (tcp_skb_cb_ext_alloc(subskb) =3D=3D NULL) {
>> +		kfree_skb(subskb);
>> +		return false;
>> +	}
>> +
>> +	*(TCP_SKB_CB(subskb)->tcp_skb_ext) =3D *(TCP_SKB_CB(skb)->tcp_skb_ext);
>> +
>>   	/* At the subflow-level we need to call again tcp_init_tso_segs. We
>>   	 * force this, by setting pcount to 0. It has been set to 1 prior to
>>   	 * the call to mptcp_skb_entail.
>> @@ -495,6 +496,7 @@ static bool mptcp_skb_entail(struct sock *sk, struct =

>> sk_buff *skb, int reinject)
>>   		err =3D tcp_transmit_skb(sk, subskb, 1, GFP_ATOMIC);
>>     		/* It has not been queued, we can free it now. */
>> +		kfree (TCP_SKB_CB(subskb)->tcp_skb_ext);
>>   		kfree_skb(subskb);
>>     		if (err)
>> @@ -660,7 +662,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned =

>> int mss_now, int nonagle,
>>   	struct sk_buff *skb;
>>   	int reinject =3D 0;
>>   	unsigned int sublimit;
>> -	__u32 path_mask =3D 0;
>> +	__u32 __path_mask =3D 0;
>>     	while ((skb =3D mpcb->sched_ops->next_segment(meta_sk, &reinject, =

>> &subsk,
>>   						    &sublimit))) {
>> @@ -746,7 +748,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned =

>> int mss_now, int nonagle,
>>   		__tcp_push_pending_frames(subsk, mss_now, TCP_NAGLE_PUSH);
>>   		meta_tp->lsndtime =3D tcp_time_stamp;
>>   -		path_mask |=3D mptcp_pi_to_flag(subtp->mptcp->path_index);
>> +		__path_mask |=3D mptcp_pi_to_flag(subtp->mptcp->path_index);
>>   		skb_mstamp_get(&skb->skb_mstamp);
>>     		if (!reinject) {
>> @@ -770,7 +772,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigned =

>> int mss_now, int nonagle,
>>   	mptcp_for_each_sk(mpcb, subsk) {
>>   		subtp =3D tcp_sk(subsk);
>>   -		if (!(path_mask & =

>> mptcp_pi_to_flag(subtp->mptcp->path_index)))
>> +		if (!(__path_mask & =

>> mptcp_pi_to_flag(subtp->mptcp->path_index)))
>>   			continue;
>>     		/* We have pushed data on this subflow. We ignore the call to
>> @@ -1239,8 +1241,9 @@ void mptcp_send_fin(struct sock *meta_sk)
>>   	} else {
>>   		/* Socket is locked, keep trying until memory is available. =

>> */
>>   		for (;;) {
>> -			skb =3D alloc_skb_fclone(MAX_TCP_HEADER,
>> -					       meta_sk->sk_allocation);
>> +			skb =3D tcp_alloc_skb(MAX_TCP_HEADER,
>> +					       meta_sk->sk_allocation,
>> +					       SKB_FCLONE);
>>   			if (skb)
>>   				break;
>>   			yield();
>> @@ -1331,7 +1334,7 @@ static void mptcp_ack_retransmit_timer(struct sock =

>> *sk)
>>   		goto out;
>>   	}
>>   -	skb =3D alloc_skb(MAX_TCP_HEADER, GFP_ATOMIC);
>> +	skb =3D tcp_alloc_skb(MAX_TCP_HEADER, GFP_ATOMIC, SKB_DEFAULT);
>>   	if (skb =3D=3D NULL) {
>>   		sk_reset_timer(sk, &tp->mptcp->mptcp_ack_timer,
>>   			       jiffies + icsk->icsk_rto);
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel OTC

--===============3587485528976561331==--
