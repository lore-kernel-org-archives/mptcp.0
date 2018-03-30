Content-Type: multipart/mixed; boundary="===============6376185925952890071=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 8/9] Restructure TCP code so that it can be shared
 primarily with MPTCP
Date: Fri, 30 Mar 2018 11:28:04 -0700
Message-ID: <ff79d610-9d44-f14a-a83c-8c327d9c103a@oracle.com>
In-Reply-To: 1522432503.16359.85.camel@intel.com
X-Status: 
X-Keywords:                  
X-UID: 491

--===============6376185925952890071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 03/30/2018 10:55 AM, Krystad, Peter wrote:
> On Thu, 2018-02-22 at 15:50 -0800, rao.shoaib(a)oracle.com wrote:
>> From: Rao Shoaib <rao.shoaib(a)oracle.com>
>>
>> Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
>> ---
>>   include/net/inet_common.h |   2 +
>>   include/net/tcp.h         | 106 ++++++++++++++++++++++++++++++++++++++=
++++++++
>>   net/ipv4/af_inet.c        |   3 +-
>>   net/ipv4/tcp.c            |  59 ++++++++++++++------------
>>   net/ipv4/tcp_input.c      |  89 +++++++++++++++++++++++---------------
>>   net/ipv4/tcp_ipv4.c       |  42 ++++++++++++------
>>   net/ipv4/tcp_output.c     |  55 +++++++++++++-----------
>>   net/ipv4/tcp_timer.c      |   9 ++--
>>   net/ipv6/af_inet6.c       |   4 +-
>>   net/ipv6/tcp_ipv6.c       |  63 ++++++++++++++-------------
>>   10 files changed, 293 insertions(+), 139 deletions(-)
>>
>> diff --git a/include/net/inet_common.h b/include/net/inet_common.h
>> index 500f813..7b919c7 100644
>> --- a/include/net/inet_common.h
>> +++ b/include/net/inet_common.h
>> @@ -14,6 +14,8 @@ struct sock;
>>   struct sockaddr;
>>   struct socket;
>>   =

>> +int inet_create(struct net *net, struct socket *sock, int protocol, int=
 kern);
>> +int inet6_create(struct net *net, struct socket *sock, int protocol, in=
t kern);
>>   int inet_release(struct socket *sock);
>>   int inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>>   			int addr_len, int flags);
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index f5d748a..3344b1d 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -314,6 +314,12 @@ static inline bool tcp_too_many_orphans(struct sock=
 *sk, int shift)
>>   	return false;
>>   }
>>   =

>> +static inline void tcp_drop(struct sock *sk, struct sk_buff *skb)
>> +{
>> +	sk_drops_add(sk, skb);
>> +	__kfree_skb(skb);
>> +}
>> +
>>   bool tcp_check_oom(struct sock *sk, int shift);
>>   =

>>   extern struct proto tcp_prot;
>> @@ -2273,6 +2279,106 @@ static inline bool tcp_bpf_ca_needs_ecn(struct s=
ock *sk)
>>   	return (tcp_call_bpf(sk, BPF_SOCK_OPS_NEEDS_ECN, 0, NULL) =3D=3D 1);
>>   }
>>   =

>> +/* MPTCP */
>> +unsigned int tcp_xmit_size_goal(struct sock *sk, u32 mss_now,
>> +				int large_allowed);
>> +ssize_t tcp_sendpages_xmit(struct sock *sk, struct page *page, int offs=
et,
>> +			   size_t size, int flags);
>> +ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
>> +			 size_t size, int flags);
>> +int tcp_close_state(struct sock *sk);
>> +void tcp_enter_quickack_mode(struct sock *sk);
>> +void tcp_sndbuf_expand_impl(struct sock *sk, u32 nr_segs);
>> +bool tcp_check_rtt(struct sock *sk);
>> +u32 tcp_tso_acked(struct sock *sk, struct sk_buff *skb);
>> +void tcp_ack_probe(struct sock *sk);
>> +bool tcp_may_update_window(const struct tcp_sock *tp, const u32 ack,
>> +			   const u32 ack_seq, const u32 nwin);
>> +bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
>> +			     struct tcp_fastopen_cookie *cookie);
>> +bool tcp_rcv_fastopen_synack_impl(struct sock *sk, struct sk_buff *syna=
ck,
>> +				  struct tcp_fastopen_cookie *cookie,
>> +				  bool rexmit);
>> +void tcp_enter_quickack_mode(struct sock *sk);
>> +void tcp_check_space(struct sock *sk);
>> +int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb, in=
t hdrlen,
>> +			       bool *fragstolen);
>> +void tcp_event_new_data_sent(struct sock *sk, struct sk_buff *skb);
>> +void tcp_init_nondata_skb(struct sk_buff *skb, u32 seq, u8 flags);
>> +bool tcp_urg_mode(const struct tcp_sock *tp);
>> +int tcp_transmit_skb(struct sock *sk, struct sk_buff *skb, int clone_it,
>> +		     gfp_t gfp_mask);
>> +void tcp_queue_skb(struct sock *sk, struct sk_buff *skb);
>> +void tcp_set_skb_tso_segs(struct sk_buff *skb, unsigned int mss_now);
>> +void tcp_adjust_pcount(struct sock *sk, const struct sk_buff *skb, int =
decr);
>> +int pskb_trim_head(struct sk_buff *skb, int len);
>> +void tcp_minshall_update(struct tcp_sock *tp, unsigned int mss_now,
>> +			 const struct sk_buff *skb);
>> +unsigned int tcp_mss_split_point(const struct sock *sk,
>> +				 const struct sk_buff *skb,
>> +				 unsigned int mss_now,
>> +				 unsigned int max_segs,
>> +				 int nonagle);
>> +unsigned int tcp_cwnd_test(const struct tcp_sock *tp,
>> +			   const struct sk_buff *skb);
>> +int tcp_init_tso_segs(struct sk_buff *skb, unsigned int mss_now);
>> +bool tcp_nagle_test(const struct tcp_sock *tp, const struct sk_buff *sk=
b,
>> +		    unsigned int cur_mss, int nonagle);
>> +bool tcp_snd_wnd_test(const struct tcp_sock *tp, const struct sk_buff *=
skb,
>> +		      unsigned int cur_mss);
>> +int tcp_xmit_probe_skb(struct sock *sk, int urgent, int mib);
>> +void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb);
>> +void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
>> +			   struct request_sock *req);
>> +void tcp_v4_reqsk_destructor(struct request_sock *req);
>> +struct sock *tcp_v4_cookie_check(struct sock *sk, struct sk_buff *skb);
>> +void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
>> +		    const struct tcphdr *th);
>> +void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
>> +		    const struct tcphdr *th);
>> +void tcp_write_err(struct sock *sk);
>> +bool retransmits_timed_out(struct sock *sk, unsigned int boundary,
>> +			   unsigned int timeout);
>> +int tcp_write_timeout(struct sock *sk);
>> +struct request_sock *tcp_cookie_req_alloc(struct sock *sk,
>> +					  struct sk_buff *skb,
>> +					  struct tcp_options_received *tcp_opts,
>> +					  __u32 cookie, int mss);
>> +void inet_twsk_free(struct inet_timewait_sock *tw);
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb);
>> +void tcp_v6_mtu_reduced(struct sock *sk);
>> +void tcp_v6_reqsk_destructor(struct request_sock *req);
>> +void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb);
>> +void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
>> +			   struct request_sock *req);
>> +struct sock *tcp_v6_cookie_check(struct sock *sk, struct sk_buff *skb);
>> +int tcp_v6_conn_request(struct sock *sk, struct sk_buff *skb);
>> +struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff=
 *skb,
>> +				  struct request_sock *req,
>> +				  struct dst_entry *dst,
>> +				  struct request_sock *req_unhash,
>> +				  bool *own_req);
>> +int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb);
>> +#endif
>> +
>> +static inline void tcp_data_snd_check(struct sock *sk)
>> +{
>> +	tcp_push_pending_frames(sk);
>> +	tcp_check_space(sk);
>> +}
>> +
>> +/* These states need RST on ABORT according to RFC793 */
>> +
>> +static inline bool tcp_need_reset(int state)
>> +{
>> +	return (1 << state) &
>> +		(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT | TCPF_FIN_WAIT1 |
>> +		TCPF_FIN_WAIT2 | TCPF_SYN_RECV);
>> +}
>> +
>> +/* END MPTCP */
>> +
>>   #if IS_ENABLED(CONFIG_SMC)
>>   extern struct static_key_false tcp_have_smc;
>>   #endif
>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>> index e8c7fad..5d8ea09 100644
>> --- a/net/ipv4/af_inet.c
>> +++ b/net/ipv4/af_inet.c
>> @@ -243,8 +243,7 @@ EXPORT_SYMBOL(inet_listen);
>>    *	Create an inet socket.
>>    */
>>   =

>> -static int inet_create(struct net *net, struct socket *sock, int protoc=
ol,
>> -		       int kern)
>> +int inet_create(struct net *net, struct socket *sock, int protocol, int=
 kern)
>>   {
>>   	struct sock *sk;
>>   	struct inet_protosw *answer;
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index ea89a41..20a69eb 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -429,6 +429,7 @@ static const struct tcp_operational_ops __tcp_defaul=
t_op_ops =3D {
>>   	.sndbuf_expand			=3D tcp_sndbuf_expand,
>>   	.shift_skb_data			=3D tcp_shift_skb_data,
>>   	.grow_window			=3D tcp_grow_window,
>> +	.check_rtt			=3D tcp_check_rtt,
>>   	.try_coalesce			=3D tcp_try_coalesce,
>>   	.try_rmem_schedule		=3D tcp_try_rmem_schedule,
>>   	.collapse_one			=3D tcp_collapse_one,
>> @@ -963,8 +964,7 @@ struct sk_buff *sk_stream_alloc_skb(struct sock *sk,=
 int size, gfp_t gfp,
>>   	return NULL;
>>   }
>>   =

>> -static unsigned int tcp_xmit_size_goal(struct sock *sk, u32 mss_now,
>> -				       int large_allowed)
>> +unsigned int tcp_xmit_size_goal(struct sock *sk, u32 mss_now, int large=
_allowed)
>>   {
>>   	struct tcp_sock *tp =3D tcp_sk(sk);
>>   	u32 new_size_goal, size_goal;
>> @@ -998,8 +998,8 @@ int tcp_send_mss(struct sock *sk, int *size_goal, in=
t flags)
>>   	return mss_now;
>>   }
>>   =

>> -ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
>> -			 size_t size, int flags)
>> +ssize_t tcp_sendpages_xmit(struct sock *sk, struct page *page, int offs=
et,
>> +			   size_t size, int flags)
>>   {
>>   	struct tcp_sock *tp =3D tcp_sk(sk);
>>   	int mss_now, size_goal;
>> @@ -1007,25 +1007,12 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct=
 page *page, int offset,
>>   	ssize_t copied;
>>   	long timeo =3D sock_sndtimeo(sk, flags & MSG_DONTWAIT);
>>   =

>> -	/* Wait for a connection to finish. One exception is TCP Fast Open
>> -	 * (passive side) where data is allowed to be sent before a connection
>> -	 * is fully established.
>> -	 */
>> -	if (((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) &&
>> -	    !tcp_passive_fastopen(sk)) {
>> -		err =3D sk_stream_wait_connect(sk, &timeo);
>> -		if (err !=3D 0)
>> -			goto out_err;
>> -	}
>> -
>>   	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
>>   =

>>   	mss_now =3D tp->op_ops->send_mss(sk, &size_goal, flags);
>>   	copied =3D 0;
>>   =

>>   	err =3D -EPIPE;
>> -	if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN))
>> -		goto out_err;
>>   =

>>   	while (size > 0) {
>>   		struct sk_buff *skb =3D tcp_write_queue_tail(sk);
>> @@ -1120,6 +1107,33 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct =
page *page, int offset,
>>   do_error:
>>   	if (copied)
>>   		goto out;
>> +	return err;
>> +}
>> +EXPORT_SYMBOL_GPL(tcp_sendpages_xmit);
>> +
>> +ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
>> +			 size_t size, int flags)
>> +{
>> +	int err;
>> +	long timeo =3D sock_sndtimeo(sk, flags & MSG_DONTWAIT);
>> +
>> +	/* Wait for a connection to finish. One exception is TCP Fast Open
>> +	 * (passive side) where data is allowed to be sent before a connection
>> +	 * is fully established.
>> +	 */
>> +	if (((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) &&
>> +	    !tcp_passive_fastopen(sk)) {
>> +		err =3D sk_stream_wait_connect(sk, &timeo);
>> +		if (err !=3D 0)
>> +			goto out_err;
>> +	}
>> +
>> +	if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN))
>> +		goto out_err;
>> +
>> +	err =3D tcp_sendpages_xmit(sk, page, offset, size, flags);
>> +	if (err >=3D 0)
>> +		return(err);
>>   out_err:
>>   	/* make sure we wake any epoll edge trigger waiter */
>>   	if (unlikely(skb_queue_len(&sk->sk_write_queue) =3D=3D 0 &&
>> @@ -2193,7 +2207,7 @@ static const unsigned char new_state[16] =3D {
>>     [TCP_NEW_SYN_RECV]	=3D TCP_CLOSE,	/* should not happen ! */
>>   };
>>   =

>> -static int tcp_close_state(struct sock *sk)
>> +int tcp_close_state(struct sock *sk)
>>   {
>>   	int next =3D (int)new_state[sk->sk_state];
>>   	int ns =3D next & TCP_STATE_MASK;
>> @@ -2419,15 +2433,6 @@ void tcp_close(struct sock *sk, long timeout)
>>   }
>>   EXPORT_SYMBOL(tcp_close);
>>   =

>> -/* These states need RST on ABORT according to RFC793 */
>> -
>> -static inline bool tcp_need_reset(int state)
>> -{
>> -	return (1 << state) &
>> -	       (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT | TCPF_FIN_WAIT1 |
>> -		TCPF_FIN_WAIT2 | TCPF_SYN_RECV);
>> -}
>> -
>>   static void tcp_rtx_queue_purge(struct sock *sk)
>>   {
>>   	struct rb_node *p =3D rb_first(&sk->tcp_rtx_queue);
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index 8cc48bb..398505e 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -195,7 +195,7 @@ static void tcp_incr_quickack(struct sock *sk)
>>   		icsk->icsk_ack.quick =3D min(quickacks, TCP_MAX_QUICKACKS);
>>   }
>>   =

>> -static void tcp_enter_quickack_mode(struct sock *sk)
>> +void tcp_enter_quickack_mode(struct sock *sk)
>>   {
>>   	struct inet_connection_sock *icsk =3D inet_csk(sk);
>>   	tcp_incr_quickack(sk);
>> @@ -293,12 +293,11 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_=
sock *tp, const struct tcphdr
>>    * 1. Tuning sk->sk_sndbuf, when connection enters established state.
>>    */
>>   =

>> -void tcp_sndbuf_expand(struct sock *sk)
>> +void tcp_sndbuf_expand_impl(struct sock *sk, u32 nr_segs)
>>   {
>>   	const struct tcp_sock *tp =3D tcp_sk(sk);
>>   	const struct tcp_congestion_ops *ca_ops =3D inet_csk(sk)->icsk_ca_ops;
>>   	int sndmem, per_mss;
>> -	u32 nr_segs;
>>   =

>>   	/* Worst case is non GSO/TSO : each frame consumes one skb
>>   	 * and skb->head is kmalloced using power of two area of memory
>> @@ -310,8 +309,10 @@ void tcp_sndbuf_expand(struct sock *sk)
>>   	per_mss =3D roundup_pow_of_two(per_mss) +
>>   		  SKB_DATA_ALIGN(sizeof(struct sk_buff));
>>   =

>> -	nr_segs =3D max_t(u32, TCP_INIT_CWND, tp->snd_cwnd);
>> -	nr_segs =3D max_t(u32, nr_segs, tp->reordering + 1);
>> +	if (nr_segs <=3D 0) {
>> +		nr_segs =3D max_t(u32, TCP_INIT_CWND, tp->snd_cwnd);
>> +		nr_segs =3D max_t(u32, nr_segs, tp->reordering + 1);
>> +	}
>>   =

>>   	/* Fast Recovery (RFC 5681 3.2) :
>>   	 * Cubic needs 1.7 factor, rounded to 2 to include
>> @@ -324,6 +325,11 @@ void tcp_sndbuf_expand(struct sock *sk)
>>   		sk->sk_sndbuf =3D min(sndmem, sock_net(sk)->ipv4.sysctl_tcp_wmem[2]);
>>   }
>>   =

>> +void tcp_sndbuf_expand(struct sock *sk)
>> +{
>> +	tcp_sndbuf_expand_impl(sk, 0);
>> +}
>> +
>>   /* 2. Tuning advertised window (window_clamp, rcv_ssthresh)
>>    *
>>    * All tcp_full_space() is split to two parts: "network" buffer, alloc=
ated
>> @@ -572,6 +578,17 @@ static inline void tcp_rcv_rtt_measure_ts(struct so=
ck *sk,
>>   	}
>>   }
>>   =

>> +bool tcp_check_rtt(struct sock *sk)
>> +{
>> +	struct tcp_sock *tp =3D tcp_sk(sk);
>> +	int time;
>> +
>> +	time =3D tcp_stamp_us_delta(tp->tcp_mstamp, tp->rcvq_space.time);
>> +
>> +	if (time < (tp->rcv_rtt_est.rtt_us >> 3) || tp->rcv_rtt_est.rtt_us =3D=
=3D 0)
>> +		return (true);
>> +	return false;
>> +}
>>   /*
>>    * This function should be called every time data is copied to user sp=
ace.
>>    * It calculates the appropriate TCP receive buffer space.
>> @@ -580,11 +597,9 @@ void tcp_rcv_space_adjust(struct sock *sk)
>>   {
>>   	struct tcp_sock *tp =3D tcp_sk(sk);
>>   	u32 copied;
>> -	int time;
>>   =

>>   	tcp_mstamp_refresh(tp);
>> -	time =3D tcp_stamp_us_delta(tp->tcp_mstamp, tp->rcvq_space.time);
>> -	if (time < (tp->rcv_rtt_est.rtt_us >> 3) || tp->rcv_rtt_est.rtt_us =3D=
=3D 0)
>> +	if (tp->op_ops->check_rtt(sk))
>>   		return;
>>   =

>>   	/* Number of bytes copied to user in last RTT */
>> @@ -2966,7 +2981,7 @@ static void tcp_set_xmit_timer(struct sock *sk)
>>   }
>>   =

>>   /* If we get here, the whole TSO packet has not been acked. */
>> -static u32 tcp_tso_acked(struct sock *sk, struct sk_buff *skb)
>> +u32 tcp_tso_acked(struct sock *sk, struct sk_buff *skb)
>>   {
>>   	struct tcp_sock *tp =3D tcp_sk(sk);
>>   	u32 packets_acked;
>> @@ -3201,7 +3216,7 @@ static int tcp_clean_rtx_queue(struct sock *sk, u3=
2 prior_fack,
>>   	return flag;
>>   }
>>   =

>> -static void tcp_ack_probe(struct sock *sk)
>> +void tcp_ack_probe(struct sock *sk)
>>   {
>>   	struct inet_connection_sock *icsk =3D inet_csk(sk);
>>   	struct sk_buff *head =3D tcp_send_head(sk);
>> @@ -3273,7 +3288,7 @@ static void tcp_cong_control(struct sock *sk, u32 =
ack, u32 acked_sacked,
>>   /* Check that window update is acceptable.
>>    * The function assumes that snd_una<=3Dack<=3Dsnd_next.
>>    */
>> -static inline bool tcp_may_update_window(const struct tcp_sock *tp,
>> +inline bool tcp_may_update_window(const struct tcp_sock *tp,
>>   					const u32 ack, const u32 ack_seq,
>>   					const u32 nwin)
>>   {
>> @@ -4290,12 +4305,6 @@ bool tcp_try_coalesce(struct sock *sk,
>>   	return true;
>>   }
>>   =

>> -static void tcp_drop(struct sock *sk, struct sk_buff *skb)
>> -{
>> -	sk_drops_add(sk, skb);
>> -	__kfree_skb(skb);
>> -}
>> -
>>   /* This one checks to see if we can put data from the
>>    * out_of_order queue into the receive_queue.
>>    */
>> @@ -4505,8 +4514,8 @@ static void tcp_data_queue_ofo(struct sock *sk, st=
ruct sk_buff *skb)
>>   	}
>>   }
>>   =

>> -static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *=
skb, int hdrlen,
>> -		  bool *fragstolen)
>> +int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb, in=
t hdrlen,
>> +			       bool *fragstolen)
>>   {
>>   	int eaten;
>>   	struct sk_buff *tail =3D skb_peek_tail(&sk->sk_receive_queue);
>> @@ -4580,7 +4589,11 @@ static void tcp_data_queue(struct sock *sk, struc=
t sk_buff *skb)
>>   	int eaten;
>>   =

>>   	if (TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq) {
>> -		__kfree_skb(skb);
>> +		/* options that a layer above might be interested in */
>> +		if (unlikely(tp->op_ops->ack_only))
>> +			tp->op_ops->ack_only(sk, skb);
>> +		else
>> +			__kfree_skb(skb);
> If it is a possibility that ack_only() does not call __kfree_skb(skb)
> what is the consequence? I don't have enough context here.
Good point I can look into that.

Shoaib

--===============6376185925952890071==--
