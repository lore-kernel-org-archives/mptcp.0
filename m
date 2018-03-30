Content-Type: multipart/mixed; boundary="===============3905180747502984346=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 8/9] Restructure TCP code so that it can be shared
 primarily with MPTCP
Date: Fri, 30 Mar 2018 10:59:56 -0700
Message-ID: <2f554aba-fcc9-19ad-699b-8459947c71a9@oracle.com>
In-Reply-To: 20180327101519.GD71178@MacBook-Pro-6.lan
X-Status: 
X-Keywords:                  
X-UID: 486

--===============3905180747502984346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 03/27/2018 03:15 AM, Christoph Paasch wrote:
> On 22/02/18 - 15:50:00, rao.shoaib(a)oracle.com wrote:
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
> You will need to set err to -EPIPE before this if-statement.
>
>> +
>> +	err =3D tcp_sendpages_xmit(sk, page, offset, size, flags);
>> +	if (err >=3D 0)
>> +		return(err);
> Overall, by looking at this patch here, it is not clear to me why these c=
hanges
> are needed.
>
> You would need to explain this in the commit-message as otherwise the rev=
iew
> is very difficult.
These changes are part of restructuring as the title says. MPTCP is very =

intrusive to TCP code. Where possible I have re-factored TCP functions =

into common code and separated out the code where MPTCP and TCP differ. =

The calling function calls the socket type specific function that uses =

the common function.
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
> Same here, it is not clear why this is needed by looking at the patch.
> A reviewer will have a hard time to understand this code-change.
>
> The question would be then whether it is possible to design MPTCP without
> having to adjust nr_segs. I think, it actually is possible to do so. Will
> result in a slightly lower send-buffer, but I deem that acceptable for an
> upstream submission.
These are very low level changes that are specific to MPTCP and was not =

the goal of this effort. However any such possibility will be explored =

later.
>
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
>>   		return;
>>   	}
>>   	skb_dst_drop(skb);
>> @@ -4995,7 +5008,7 @@ static void tcp_new_space(struct sock *sk)
>>   	sk->sk_write_space(sk);
>>   }
>>   =

>> -static void tcp_check_space(struct sock *sk)
>> +void tcp_check_space(struct sock *sk)
>>   {
>>   	if (sock_flag(sk, SOCK_QUEUE_SHRUNK)) {
>>   		sock_reset_flag(sk, SOCK_QUEUE_SHRUNK);
>> @@ -5010,12 +5023,6 @@ static void tcp_check_space(struct sock *sk)
>>   	}
>>   }
>>   =

>> -static inline void tcp_data_snd_check(struct sock *sk)
>> -{
>> -	tcp_push_pending_frames(sk);
>> -	tcp_check_space(sk);
>> -}
>> -
>>   /*
>>    * Check if sending an ack is needed.
>>    */
>> @@ -5504,8 +5511,9 @@ void tcp_finish_connect(struct sock *sk, struct sk=
_buff *skb)
>>   		tp->pred_flags =3D 0;
>>   }
>>   =

>> -bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
>> -			     struct tcp_fastopen_cookie *cookie)
>> +bool tcp_rcv_fastopen_synack_impl(struct sock *sk, struct sk_buff *syna=
ck,
>> +				  struct tcp_fastopen_cookie *cookie,
>> +				  bool rexmit)
>>   {
>>   	struct tcp_sock *tp =3D tcp_sk(sk);
>>   	struct sk_buff *data =3D tp->syn_data ? tcp_rtx_queue_head(sk) : NULL;
>> @@ -5542,7 +5550,7 @@ bool tcp_rcv_fastopen_synack(struct sock *sk, stru=
ct sk_buff *synack,
>>   =

>>   	tcp_fastopen_cache_set(sk, mss, cookie, syn_drop, try_exp);
>>   =

>> -	if (data) { /* Retransmit unacked data in SYN */
>> +	if (data && rexmit) { /* Retransmit unacked data in SYN */
>>   		skb_rbtree_walk_from(data) {
>>   			if (__tcp_retransmit_skb(sk, data, 1))
>>   				break;
>> @@ -5562,6 +5570,12 @@ bool tcp_rcv_fastopen_synack(struct sock *sk, str=
uct sk_buff *synack,
>>   	return false;
>>   }
>>   =

>> +bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
>> +			     struct tcp_fastopen_cookie *cookie)
>> +{
>> +	return tcp_rcv_fastopen_synack_impl(sk, synack, cookie, true);
>> +}
>> +
>>   static void smc_check_reset_syn(struct tcp_sock *tp)
>>   {
>>   #if IS_ENABLED(CONFIG_SMC)
>> @@ -5581,6 +5595,9 @@ int tcp_rcv_synsent_state_process(struct sock *sk,=
 struct sk_buff *skb,
>>   	int saved_clamp =3D tp->rx_opt.mss_clamp;
>>   	bool fastopen_fail;
>>   =

>> +	tp->rx_opt.saw_tstamp =3D 0;
>> +	tcp_mstamp_refresh(tp);
>> +
>>   	tcp_parse_options(sock_net(sk), skb, &tp->rx_opt, 0, &foc);
>>   	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
>>   		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
>> @@ -5682,7 +5699,7 @@ int tcp_rcv_synsent_state_process(struct sock *sk,=
 struct sk_buff *skb,
>>   		tcp_finish_connect(sk, skb);
>>   =

>>   		fastopen_fail =3D (tp->syn_fastopen || tp->syn_data) &&
>> -				tcp_rcv_fastopen_synack(sk, skb, &foc);
>> +				 tp->op_ops->fastopen_synack(sk, skb, &foc);
>>   =

>>   		if (!sock_flag(sk, SOCK_DEAD)) {
>>   			sk->sk_state_change(sk);
>> @@ -5842,9 +5859,7 @@ int tcp_rcv_state_process(struct sock *sk, struct =
sk_buff *skb)
>>   		goto discard;
>>   =

>>   	case TCP_SYN_SENT:
>> -		tp->rx_opt.saw_tstamp =3D 0;
>> -		tcp_mstamp_refresh(tp);
>> -		queued =3D tcp_rcv_synsent_state_process(sk, skb, th);
>> +		queued =3D tp->state_ops->synsent(sk, skb, th);
>>   		if (queued >=3D 0)
>>   			return queued;
>>   =

>> @@ -6052,8 +6067,12 @@ int tcp_rcv_state_process(struct sock *sk, struct=
 sk_buff *skb)
>>   	}
>>   =

>>   	if (!queued) {
>> +		/* options that a layer above might be interested in */
>> +		if (unlikely(tp->op_ops && tp->op_ops->ack_only))
>> +			tp->op_ops->ack_only(sk, skb);
>> +		else
>>   discard:
>> -		tcp_drop(sk, skb);
>> +			tcp_drop(sk, skb);
>>   	}
>>   	return 0;
>>   }
>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> index 482ca15..95d4c1f 100644
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -595,7 +595,7 @@ EXPORT_SYMBOL(tcp_v4_send_check);
>>    *	Exception: precedence violation. We do not implement it in any case.
>>    */
>>   =

>> -static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *sk=
b)
>> +void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
>>   {
>>   	const struct tcphdr *th =3D tcp_hdr(skb);
>>   	struct {
>> @@ -829,8 +829,8 @@ static void tcp_v4_timewait_ack(struct sock *sk, str=
uct sk_buff *skb)
>>   	inet_twsk_put(tw);
>>   }
>>   =

>> -static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff=
 *skb,
>> -				  struct request_sock *req)
>> +void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
>> +			   struct request_sock *req)
>>   {
>>   	/* sk->sk_state =3D=3D TCP_LISTEN -> for regular TCP_SYN_RECV
>>   	 * sk->sk_state =3D=3D TCP_SYN_RECV -> for Fast Open.
>> @@ -892,7 +892,7 @@ static int tcp_v4_send_synack(const struct sock *sk,=
 struct dst_entry *dst,
>>   /*
>>    *	IPv4 request_sock destructor.
>>    */
>> -static void tcp_v4_reqsk_destructor(struct request_sock *req)
>> +void tcp_v4_reqsk_destructor(struct request_sock *req)
>>   {
>>   	kfree(rcu_dereference_protected(inet_rsk(req)->ireq_opt, 1));
>>   }
>> @@ -1431,7 +1431,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
k *sk, struct sk_buff *skb,
>>   }
>>   EXPORT_SYMBOL(tcp_v4_syn_recv_sock);
>>   =

>> -static struct sock *tcp_v4_cookie_check(struct sock *sk, struct sk_buff=
 *skb)
>> +struct sock *tcp_v4_cookie_check(struct sock *sk, struct sk_buff *skb)
>>   {
>>   #ifdef CONFIG_SYN_COOKIES
>>   	const struct tcphdr *th =3D tcp_hdr(skb);
>> @@ -1598,8 +1598,8 @@ static void tcp_v4_restore_cb(struct sk_buff *skb)
>>   		sizeof(struct inet_skb_parm));
>>   }
>>   =

>> -static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
>> -			   const struct tcphdr *th)
>> +void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
>> +		    const struct tcphdr *th)
>>   {
>>   	/* This is tricky : We move IPCB at its correct location into TCP_SKB=
_CB()
>>   	 * barrier() makes sure compiler wont play fool^Waliasing games.
>> @@ -1620,6 +1620,9 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, co=
nst struct iphdr *iph,
>>   			skb->tstamp || skb_hwtstamps(skb)->hwtstamp;
>>   }
>>   =

>> +process_unclaimed tcp_process_unclaimed;
>> +EXPORT_SYMBOL(tcp_process_unclaimed);
>> +
>>   /*
>>    *	From tcp_input.c
>>    */
>> @@ -1750,13 +1753,16 @@ int tcp_v4_rcv(struct sk_buff *skb)
>>   =

>>   	sk_incoming_cpu_update(sk);
>>   =

>> -	bh_lock_sock_nested(sk);
>> -	tcp_segs_in(tcp_sk(sk), skb);
>> -	ret =3D 0;
>> -	if (!sock_owned_by_user(sk)) {
>> -		ret =3D tcp_v4_do_rcv(sk, skb);
>> -	} else if (tcp_add_backlog(sk, skb)) {
>> -		goto discard_and_relse;
>> +	if (likely(!tcp_sk(sk)->op_ops->rx)) {
>> +		bh_lock_sock_nested(sk);
>> +		tcp_segs_in(tcp_sk(sk), skb);
>> +		ret =3D 0;
>> +		if (!sock_owned_by_user(sk))
>> +			ret =3D tcp_v4_do_rcv(sk, skb);
>> +		else if (tcp_add_backlog(sk, skb))
>> +			goto discard_and_relse;
>> +	} else {
>> +		return(tcp_sk(sk)->op_ops->rx(sk, skb, refcounted));
> This looks like a very big "alternative" of the TCP-stack's input
> processing based on the rx-callback. Feedback on netdev was that TCP
> extensions should fit within the TCP-stack. This here, looks like based on
> the callback-pointer we redirect the TCP input-path to an entirely differ=
ent
> stack.
>
> If this is necessary it is important to explain in the commit-message why=
 and
> how much different the stack will look like.
Yes it is necessary because we are trying to clean up TCP code and clean =

it up from all the #ifdef MPTCP statements. It also provides us the =

opportunity to do more MPTCP specific stuff in the future. My =

understanding after talking to upstream folks is that they do not want =

MPTCP all over TCP code. I discussed the alternatives and was told to =

first present an implementation and we will talk. I have very recently =

communicated with Dave and Eric on the list where they have agreed to =

some refactoring. So please stop using we know what upstream wants, =

unless=C2=A0 a thread on the mailing list can be pointed to confirm.

>
>>   	}
>>   	bh_unlock_sock(sk);
>>   =

>> @@ -1778,6 +1784,10 @@ int tcp_v4_rcv(struct sk_buff *skb)
>>   bad_packet:
>>   		__TCP_INC_STATS(net, TCP_MIB_INERRS);
>>   	} else {
>> +		if (unlikely(tcp_process_unclaimed)) {
>> +			if (tcp_process_unclaimed(sk, skb))
>> +				return (0);
>> +		}
> I'm unclear what process_unclaimed is doing. It would be important to
> explain this in the commit-message.
This is the case when where no socket matching socket is found. If MPTCP =

wants to process such packets, it initializes this function pointer to =

receive the packet.
>
>>   		tcp_v4_send_reset(NULL, skb);
>>   	}
>>   =

>> @@ -1820,6 +1830,10 @@ int tcp_v4_rcv(struct sk_buff *skb)
>>   			refcounted =3D false;
>>   			goto process;
>>   		}
>> +		if (unlikely(tcp_process_unclaimed)) {
>> +			if (tcp_process_unclaimed(sk, skb))
>> +				return 0;
>> +		}
>>   	}
>>   		/* to ACK */
>>   		/* fall through */
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index 2fa5c05..72b494a 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -46,7 +46,7 @@
>>   #include <trace/events/tcp.h>
>>   =

>>   /* Account for new data that has been sent to the network. */
>> -static void tcp_event_new_data_sent(struct sock *sk, struct sk_buff *sk=
b)
>> +void tcp_event_new_data_sent(struct sock *sk, struct sk_buff *skb)
>>   {
>>   	struct inet_connection_sock *icsk =3D inet_csk(sk);
>>   	struct tcp_sock *tp =3D tcp_sk(sk);
>> @@ -375,7 +375,7 @@ static void tcp_ecn_send(struct sock *sk, struct sk_=
buff *skb,
>>   /* Constructs common control bits of non-data skb. If SYN/FIN is prese=
nt,
>>    * auto increment end seqno.
>>    */
>> -static void tcp_init_nondata_skb(struct sk_buff *skb, u32 seq, u8 flags)
>> +void tcp_init_nondata_skb(struct sk_buff *skb, u32 seq, u8 flags)
>>   {
>>   	skb->ip_summed =3D CHECKSUM_PARTIAL;
>>   =

>> @@ -390,7 +390,7 @@ static void tcp_init_nondata_skb(struct sk_buff *skb=
, u32 seq, u8 flags)
>>   	TCP_SKB_CB(skb)->end_seq =3D seq;
>>   }
>>   =

>> -static inline bool tcp_urg_mode(const struct tcp_sock *tp)
>> +inline bool tcp_urg_mode(const struct tcp_sock *tp)
>>   {
>>   	return tp->snd_una !=3D tp->snd_up;
>>   }
>> @@ -1031,8 +1031,8 @@ static void tcp_update_skb_after_send(struct tcp_s=
ock *tp, struct sk_buff *skb)
>>    * We are working here with either a clone of the original
>>    * SKB, or a fresh unique copy made by the retransmit engine.
>>    */
>> -static int tcp_transmit_skb(struct sock *sk, struct sk_buff *skb, int c=
lone_it,
>> -			    gfp_t gfp_mask)
>> +int tcp_transmit_skb(struct sock *sk, struct sk_buff *skb, int clone_it,
>> +		     gfp_t gfp_mask)
>>   {
>>   	const struct inet_connection_sock *icsk =3D inet_csk(sk);
>>   	struct inet_sock *inet;
>> @@ -1193,7 +1193,7 @@ static int tcp_transmit_skb(struct sock *sk, struc=
t sk_buff *skb, int clone_it,
>>    * NOTE: probe0 timer is not checked, do not forget tcp_push_pending_f=
rames,
>>    * otherwise socket can stall.
>>    */
>> -static void tcp_queue_skb(struct sock *sk, struct sk_buff *skb)
>> +void tcp_queue_skb(struct sock *sk, struct sk_buff *skb)
>>   {
>>   	struct tcp_sock *tp =3D tcp_sk(sk);
>>   =

>> @@ -1206,7 +1206,7 @@ static void tcp_queue_skb(struct sock *sk, struct =
sk_buff *skb)
>>   }
>>   =

>>   /* Initialize TSO segments for a packet. */
>> -static void tcp_set_skb_tso_segs(struct sk_buff *skb, unsigned int mss_=
now)
>> +void tcp_set_skb_tso_segs(struct sk_buff *skb, unsigned int mss_now)
>>   {
>>   	if (skb->len <=3D mss_now || skb->ip_summed =3D=3D CHECKSUM_NONE) {
>>   		/* Avoid the costly divide in the normal
>> @@ -1223,7 +1223,7 @@ static void tcp_set_skb_tso_segs(struct sk_buff *s=
kb, unsigned int mss_now)
>>   /* Pcount in the middle of the write queue got changed, we need to do =
various
>>    * tweaks to fix counters
>>    */
>> -static void tcp_adjust_pcount(struct sock *sk, const struct sk_buff *sk=
b, int decr)
>> +void tcp_adjust_pcount(struct sock *sk, const struct sk_buff *skb, int =
decr)
>>   {
>>   	struct tcp_sock *tp =3D tcp_sk(sk);
>>   =

>> @@ -1426,6 +1426,11 @@ static int __pskb_trim_head(struct sk_buff *skb, =
int len)
>>   	return len;
>>   }
>>   =

>> +int pskb_trim_head(struct sk_buff *skb, int len)
>> +{
>> +	return

>> (skb, len);
>> +}
> Can you explain, why this change is needed here?
I did not want to make __pskb_trim_head a global. I can rename=C2=A0 the =

original function.

Shoaib
>
>
> Christoph
>
>> +
>>   /* Remove acked data from a packet in the transmit queue. */
>>   int tcp_trim_head(struct sock *sk, struct sk_buff *skb, u32 len)
>>   {
>> @@ -1434,7 +1439,7 @@ int tcp_trim_head(struct sock *sk, struct sk_buff =
*skb, u32 len)
>>   	if (skb_unclone(skb, GFP_ATOMIC))
>>   		return -ENOMEM;
>>   =

>> -	delta_truesize =3D __pskb_trim_head(skb, len);
>> +	delta_truesize =3D pskb_trim_head(skb, len);
>>   =

>>   	TCP_SKB_CB(skb)->seq +=3D len;
>>   	skb->ip_summed =3D CHECKSUM_PARTIAL;
>> @@ -1693,8 +1698,8 @@ static bool tcp_minshall_check(const struct tcp_so=
ck *tp)
>>    * But we can avoid doing the divide again given we already have
>>    *  skb_pcount =3D skb->len / mss_now
>>    */
>> -static void tcp_minshall_update(struct tcp_sock *tp, unsigned int mss_n=
ow,
>> -				const struct sk_buff *skb)
>> +void tcp_minshall_update(struct tcp_sock *tp, unsigned int mss_now,
>> +			 const struct sk_buff *skb)
>>   {
>>   	if (skb->len < tcp_skb_pcount(skb) * mss_now)
>>   		tp->snd_sml =3D TCP_SKB_CB(skb)->end_seq;
>> @@ -1751,11 +1756,11 @@ static u32 tcp_tso_segs(struct sock *sk, unsigne=
d int mss_now)
>>   }
>>   =

>>   /* Returns the portion of skb which can be sent right away */
>> -static unsigned int tcp_mss_split_point(const struct sock *sk,
>> -					const struct sk_buff *skb,
>> -					unsigned int mss_now,
>> -					unsigned int max_segs,
>> -					int nonagle)
>> +unsigned int tcp_mss_split_point(const struct sock *sk,
>> +				 const struct sk_buff *skb,
>> +				 unsigned int mss_now,
>> +				 unsigned int max_segs,
>> +				 int nonagle)
>>   {
>>   	const struct tcp_sock *tp =3D tcp_sk(sk);
>>   	u32 partial, needed, window, max_len;
>> @@ -1785,7 +1790,7 @@ static unsigned int tcp_mss_split_point(const stru=
ct sock *sk,
>>   /* Can at least one segment of SKB be sent right now, according to the
>>    * congestion window rules?  If so, return how many segments are allow=
ed.
>>    */
>> -static inline unsigned int tcp_cwnd_test(const struct tcp_sock *tp,
>> +inline unsigned int tcp_cwnd_test(const struct tcp_sock *tp,
>>   					 const struct sk_buff *skb)
>>   {
>>   	u32 in_flight, cwnd, halfcwnd;
>> @@ -1811,7 +1816,7 @@ static inline unsigned int tcp_cwnd_test(const str=
uct tcp_sock *tp,
>>    * This must be invoked the first time we consider transmitting
>>    * SKB onto the wire.
>>    */
>> -static int tcp_init_tso_segs(struct sk_buff *skb, unsigned int mss_now)
>> +int tcp_init_tso_segs(struct sk_buff *skb, unsigned int mss_now)
>>   {
>>   	int tso_segs =3D tcp_skb_pcount(skb);
>>   =

>> @@ -1826,8 +1831,8 @@ static int tcp_init_tso_segs(struct sk_buff *skb, =
unsigned int mss_now)
>>   /* Return true if the Nagle test allows this packet to be
>>    * sent now.
>>    */
>> -static inline bool tcp_nagle_test(const struct tcp_sock *tp, const stru=
ct sk_buff *skb,
>> -				  unsigned int cur_mss, int nonagle)
>> +inline bool tcp_nagle_test(const struct tcp_sock *tp, const struct sk_b=
uff *skb,
>> +			   unsigned int cur_mss, int nonagle)
>>   {
>>   	/* Nagle rule does not apply to frames, which sit in the middle of the
>>   	 * write_queue (they have no chances to get new data).
>> @@ -1849,9 +1854,9 @@ static inline bool tcp_nagle_test(const struct tcp=
_sock *tp, const struct sk_buf
>>   }
>>   =

>>   /* Does at least the first segment of SKB fit into the send window? */
>> -static bool tcp_snd_wnd_test(const struct tcp_sock *tp,
>> -			     const struct sk_buff *skb,
>> -			     unsigned int cur_mss)
>> +bool tcp_snd_wnd_test(const struct tcp_sock *tp,
>> +		      const struct sk_buff *skb,
>> +		      unsigned int cur_mss)
>>   {
>>   	u32 end_seq =3D TCP_SKB_CB(skb)->end_seq;
>>   =

>> @@ -2148,7 +2153,7 @@ int tcp_mtu_probe(struct sock *sk)
>>   					skb->csum =3D csum_partial(skb->data,
>>   								 skb->len, 0);
>>   			} else {
>> -				__pskb_trim_head(skb, copy);
>> +				pskb_trim_head(skb, copy);
>>   				tcp_set_skb_tso_segs(skb, mss_now);
>>   			}
>>   			TCP_SKB_CB(skb)->seq +=3D copy;
>> @@ -3639,7 +3644,7 @@ EXPORT_SYMBOL_GPL(tcp_send_ack);
>>    * one is with SEG.SEQ=3DSND.UNA to deliver urgent pointer, another is
>>    * out-of-date with SND.UNA-1 to probe window.
>>    */
>> -static int tcp_xmit_probe_skb(struct sock *sk, int urgent, int mib)
>> +int tcp_xmit_probe_skb(struct sock *sk, int urgent, int mib)
>>   {
>>   	struct tcp_sock *tp =3D tcp_sk(sk);
>>   	struct sk_buff *skb;
>> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
>> index beaba7a..dbf284d 100644
>> --- a/net/ipv4/tcp_timer.c
>> +++ b/net/ipv4/tcp_timer.c
>> @@ -29,7 +29,7 @@
>>    *  Returns: Nothing (void)
>>    */
>>   =

>> -static void tcp_write_err(struct sock *sk)
>> +void tcp_write_err(struct sock *sk)
>>   {
>>   	sk->sk_err =3D sk->sk_err_soft ? : ETIMEDOUT;
>>   	sk->sk_error_report(sk);
>> @@ -155,9 +155,8 @@ static void tcp_mtu_probing(struct inet_connection_s=
ock *icsk, struct sock *sk)
>>    * after "boundary" unsuccessful, exponentially backed-off
>>    * retransmissions with an initial RTO of TCP_RTO_MIN.
>>    */
>> -static bool retransmits_timed_out(struct sock *sk,
>> -				  unsigned int boundary,
>> -				  unsigned int timeout)
>> +bool retransmits_timed_out(struct sock *sk, unsigned int boundary,
>> +			   unsigned int timeout)
>>   {
>>   	const unsigned int rto_base =3D TCP_RTO_MIN;
>>   	unsigned int linear_backoff_thresh, start_ts;
>> @@ -187,7 +186,7 @@ static bool retransmits_timed_out(struct sock *sk,
>>   }
>>   =

>>   /* A write timeout has occurred. Process the after effects. */
>> -static int tcp_write_timeout(struct sock *sk)
>> +int tcp_write_timeout(struct sock *sk)
>>   {
>>   	struct inet_connection_sock *icsk =3D inet_csk(sk);
>>   	struct tcp_sock *tp =3D tcp_sk(sk);
>> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
>> index c1e292d..9a242a5 100644
>> --- a/net/ipv6/af_inet6.c
>> +++ b/net/ipv6/af_inet6.c
>> @@ -107,8 +107,8 @@ static __inline__ struct ipv6_pinfo *inet6_sk_generi=
c(struct sock *sk)
>>   	return (struct ipv6_pinfo *)(((u8 *)sk) + offset);
>>   }
>>   =

>> -static int inet6_create(struct net *net, struct socket *sock, int proto=
col,
>> -			int kern)
>> +int inet6_create(struct net *net, struct socket *sock, int protocol,
>> +		 int kern)
>>   {
>>   	struct inet_sock *inet;
>>   	struct ipv6_pinfo *np;
>> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
>> index 293bdc8..c226cf6 100644
>> --- a/net/ipv6/tcp_ipv6.c
>> +++ b/net/ipv6/tcp_ipv6.c
>> @@ -71,12 +71,6 @@
>>   =

>>   #include <trace/events/tcp.h>
>>   =

>> -static void	tcp_v6_send_reset(const struct sock *sk, struct sk_buff *sk=
b);
>> -static void	tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff=
 *skb,
>> -				      struct request_sock *req);
>> -
>> -static int	tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb);
>> -
>>   #ifdef CONFIG_TCP_MD5SIG
>>   static const struct tcp_sock_af_ops tcp_sock_ipv6_specific;
>>   static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
>> @@ -88,7 +82,7 @@ static struct tcp_md5sig_key *tcp_v6_md5_do_lookup(con=
st struct sock *sk,
>>   }
>>   #endif
>>   =

>> -static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *=
skb)
>> +void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
>>   {
>>   	struct dst_entry *dst =3D skb_dst(skb);
>>   =

>> @@ -315,7 +309,7 @@ static int tcp_v6_connect(struct sock *sk, struct so=
ckaddr *uaddr,
>>   	return err;
>>   }
>>   =

>> -static void tcp_v6_mtu_reduced(struct sock *sk)
>> +void tcp_v6_mtu_reduced(struct sock *sk)
>>   {
>>   	struct dst_entry *dst;
>>   =

>> @@ -495,7 +489,7 @@ static int tcp_v6_send_synack(const struct sock *sk,=
 struct dst_entry *dst,
>>   }
>>   =

>>   =

>> -static void tcp_v6_reqsk_destructor(struct request_sock *req)
>> +void tcp_v6_reqsk_destructor(struct request_sock *req)
>>   {
>>   	kfree(inet_rsk(req)->ipv6_opt);
>>   	kfree_skb(inet_rsk(req)->pktopts);
>> @@ -877,7 +871,7 @@ static void tcp_v6_send_response(const struct sock *=
sk, struct sk_buff *skb, u32
>>   	kfree_skb(buff);
>>   }
>>   =

>> -static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *sk=
b)
>> +void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
>>   {
>>   	const struct tcphdr *th =3D tcp_hdr(skb);
>>   	u32 seq =3D 0, ack_seq =3D 0;
>> @@ -975,8 +969,8 @@ static void tcp_v6_timewait_ack(struct sock *sk, str=
uct sk_buff *skb)
>>   	inet_twsk_put(tw);
>>   }
>>   =

>> -static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff=
 *skb,
>> -				  struct request_sock *req)
>> +void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
>> +			   struct request_sock *req)
>>   {
>>   	/* sk->sk_state =3D=3D TCP_LISTEN -> for regular TCP_SYN_RECV
>>   	 * sk->sk_state =3D=3D TCP_SYN_RECV -> for Fast Open.
>> @@ -997,7 +991,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock =
*sk, struct sk_buff *skb,
>>   }
>>   =

>>   =

>> -static struct sock *tcp_v6_cookie_check(struct sock *sk, struct sk_buff=
 *skb)
>> +struct sock *tcp_v6_cookie_check(struct sock *sk, struct sk_buff *skb)
>>   {
>>   #ifdef CONFIG_SYN_COOKIES
>>   	const struct tcphdr *th =3D tcp_hdr(skb);
>> @@ -1008,7 +1002,7 @@ static struct sock *tcp_v6_cookie_check(struct soc=
k *sk, struct sk_buff *skb)
>>   	return sk;
>>   }
>>   =

>> -static int tcp_v6_conn_request(struct sock *sk, struct sk_buff *skb)
>> +int tcp_v6_conn_request(struct sock *sk, struct sk_buff *skb)
>>   {
>>   	if (skb->protocol =3D=3D htons(ETH_P_IP))
>>   		return tcp_v4_conn_request(sk, skb);
>> @@ -1034,11 +1028,11 @@ static void tcp_v6_restore_cb(struct sk_buff *sk=
b)
>>   		sizeof(struct inet6_skb_parm));
>>   }
>>   =

>> -static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct =
sk_buff *skb,
>> -					 struct request_sock *req,
>> -					 struct dst_entry *dst,
>> -					 struct request_sock *req_unhash,
>> -					 bool *own_req)
>> +struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff=
 *skb,
>> +				  struct request_sock *req,
>> +				  struct dst_entry *dst,
>> +				  struct request_sock *req_unhash,
>> +				  bool *own_req)
>>   {
>>   	struct inet_request_sock *ireq;
>>   	struct ipv6_pinfo *newnp;
>> @@ -1250,7 +1244,7 @@ static struct sock *tcp_v6_syn_recv_sock(const str=
uct sock *sk, struct sk_buff *
>>    * This is because we cannot sleep with the original spinlock
>>    * held.
>>    */
>> -static int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
>> +int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
>>   {
>>   	struct ipv6_pinfo *np =3D inet6_sk(sk);
>>   	struct tcp_sock *tp;
>> @@ -1378,8 +1372,8 @@ static int tcp_v6_do_rcv(struct sock *sk, struct s=
k_buff *skb)
>>   	return 0;
>>   }
>>   =

>> -static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *h=
dr,
>> -			   const struct tcphdr *th)
>> +void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
>> +		    const struct tcphdr *th)
>>   {
>>   	/* This is tricky: we move IP6CB at its correct location into
>>   	 * TCP_SKB_CB(). It must be done after xfrm6_policy_check(), because
>> @@ -1522,13 +1516,16 @@ static int tcp_v6_rcv(struct sk_buff *skb)
>>   =

>>   	sk_incoming_cpu_update(sk);
>>   =

>> -	bh_lock_sock_nested(sk);
>> -	tcp_segs_in(tcp_sk(sk), skb);
>> -	ret =3D 0;
>> -	if (!sock_owned_by_user(sk)) {
>> -		ret =3D tcp_v6_do_rcv(sk, skb);
>> -	} else if (tcp_add_backlog(sk, skb)) {
>> -		goto discard_and_relse;
>> +	if (likely(!tcp_sk(sk)->op_ops->rx)) {
>> +		bh_lock_sock_nested(sk);
>> +		tcp_segs_in(tcp_sk(sk), skb);
>> +		ret =3D 0;
>> +		if (!sock_owned_by_user(sk))
>> +			ret =3D tcp_v6_do_rcv(sk, skb);
>> +		else if (tcp_add_backlog(sk, skb))
>> +			goto discard_and_relse;
>> +	} else {
>> +		return(tcp_sk(sk)->op_ops->rx(sk, skb, refcounted));
>>   	}
>>   	bh_unlock_sock(sk);
>>   =

>> @@ -1549,6 +1546,10 @@ static int tcp_v6_rcv(struct sk_buff *skb)
>>   bad_packet:
>>   		__TCP_INC_STATS(net, TCP_MIB_INERRS);
>>   	} else {
>> +		if (unlikely(tcp_process_unclaimed)) {
>> +			if (tcp_process_unclaimed(sk, skb))
>> +				return(0);
>> +		}
>>   		tcp_v6_send_reset(NULL, skb);
>>   	}
>>   =

>> @@ -1594,6 +1595,10 @@ static int tcp_v6_rcv(struct sk_buff *skb)
>>   			refcounted =3D false;
>>   			goto process;
>>   		}
>> +		if (unlikely(tcp_process_unclaimed)) {
>> +			if (tcp_process_unclaimed(sk, skb))
>> +				return 0;
>> +		}
>>   	}
>>   		/* to ACK */
>>   		/* fall through */
>> -- =

>> 2.7.4
>>
>> _______________________________________________
>> mptcp mailing list
>> mptcp(a)lists.01.org
>> https://lists.01.org/mailman/listinfo/mptcp


--===============3905180747502984346==--
