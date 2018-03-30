Content-Type: multipart/mixed; boundary="===============3284607459522131334=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 5/9] Switch code to use function pointers
Date: Fri, 30 Mar 2018 11:36:15 -0700
Message-ID: <8641e1e0-e60f-b3c8-b9c5-33e91d84de15@oracle.com>
In-Reply-To: 1522432512.16359.87.camel@intel.com
X-Status: 
X-Keywords:                  
X-UID: 493

--===============3284607459522131334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 03/30/2018 10:55 AM, Krystad, Peter wrote:
> See inline ...
>
> On Thu, 2018-02-22 at 15:49 -0800, rao.shoaib(a)oracle.com wrote:
>> From: Rao Shoaib <rao.shoaib(a)oracle.com>
>>
>> Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
>> ---
>>   crypto/md5.c            |  3 ---
>>   include/crypto/md5.h    |  2 ++
>>   include/net/tcp.h       |  6 ++++++
>>   include/net/transp_v6.h |  3 ---
>>   net/ipv4/tcp.c          | 38 +++++++++++++++++++++++++-------------
>>   net/ipv4/tcp_input.c    | 27 +++++++++++++++------------
>>   net/ipv4/tcp_ipv4.c     |  4 ----
>>   net/ipv4/tcp_output.c   | 24 +++++++++++++-----------
>>   net/ipv4/tcp_timer.c    |  2 +-
>>   net/ipv6/tcp_ipv6.c     | 10 ++--------
>>   10 files changed, 64 insertions(+), 55 deletions(-)
>>
>> diff --git a/crypto/md5.c b/crypto/md5.c
>> index f7ae1a4..96d4460 100644
>> --- a/crypto/md5.c
>> +++ b/crypto/md5.c
>> @@ -23,9 +23,6 @@
>>   #include <linux/types.h>
>>   #include <asm/byteorder.h>
>>   =

>> -#define MD5_DIGEST_WORDS 4
>> -#define MD5_MESSAGE_BYTES 64
>> -
>>   const u8 md5_zero_message_hash[MD5_DIGEST_SIZE] =3D {
>>   	0xd4, 0x1d, 0x8c, 0xd9, 0x8f, 0x00, 0xb2, 0x04,
>>   	0xe9, 0x80, 0x09, 0x98, 0xec, 0xf8, 0x42, 0x7e,
>> diff --git a/include/crypto/md5.h b/include/crypto/md5.h
>> index cf9e9de..c1ffab5 100644
>> --- a/include/crypto/md5.h
>> +++ b/include/crypto/md5.h
>> @@ -8,6 +8,8 @@
>>   #define MD5_HMAC_BLOCK_SIZE	64
>>   #define MD5_BLOCK_WORDS		16
>>   #define MD5_HASH_WORDS		4
>> +#define	MD5_DIGEST_WORDS	4
>> +#define	MD5_MESSAGE_BYTES	64
>>   =

>>   #define MD5_H0	0x67452301UL
>>   #define MD5_H1	0xefcdab89UL
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index f952d97..bd6b082 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -355,6 +355,12 @@ void tcp_twsk_destructor(struct sock *sk);
>>   ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
>>   			struct pipe_inode_info *pipe, size_t len,
>>   			unsigned int flags);
>> +/* address family specific functions */
>> +extern const struct inet_connection_sock_af_ops ipv4_specific;
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +extern const struct inet_connection_sock_af_ops ipv6_specific;
>> +extern const struct inet_connection_sock_af_ops ipv6_mapped;
>> +#endif
>>   =

>>   static inline void tcp_dec_quickack_mode(struct sock *sk,
>>   					 const unsigned int pkts)
>> diff --git a/include/net/transp_v6.h b/include/net/transp_v6.h
>> index c4f5caa..1caf7c6 100644
>> --- a/include/net/transp_v6.h
>> +++ b/include/net/transp_v6.h
>> @@ -50,9 +50,6 @@ void ip6_dgram_sock_seq_show(struct seq_file *seq, str=
uct sock *sp,
>>   =

>>   #define LOOPBACK4_IPV6 cpu_to_be32(0x7f000006)
>>   =

>> -/* address family specific functions */
>> -extern const struct inet_connection_sock_af_ops ipv4_specific;
>> -
>>   void inet6_destroy_sock(struct sock *sk);
>>   =

>>   #define IPV6_SEQ_DGRAM_HEADER					       \
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index a6ff25c..ab82e7c 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -508,12 +508,24 @@ void tcp_init_sock(struct sock *sk)
>>   	sk->sk_sndbuf =3D sock_net(sk)->ipv4.sysctl_tcp_wmem[1];
>>   	sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
>>   =

>> +	tp->op_ops =3D READ_ONCE(tcp_default_op_ops);
>> +	tp->state_ops =3D READ_ONCE(tcp_default_state_ops);
>> +
>> +	if (sk->sk_family =3D=3D AF_INET)
>> +		icsk->icsk_af_ops =3D &ipv4_specific;
>> +	else
>> +		icsk->icsk_af_ops =3D &ipv6_specific;
>> +
>> +	if (unlikely(tp->op_ops->sock_init))
>> +		tp->op_ops->sock_init(sk);
>> +
> Looking at the MPTCP patch tcp_default_op_ops.sock_init() is
> initialized to mptcp_init_tcp_sock(), so it is called regardless of the
> actual TCP vs. MPTCP nature of this tcp_sock. It seems
> mptcp_init_tcp_sock() could be called directly instead of through
> pointer and the sock_init element is not necessary.
In the current implementation you have to enable MPTCP system wide. The =

next step would be to make the change where MPTCP is used only when the =

use explicitly asks for it. There are other changes that need to be =

made, for example I remember seeing a comment that using extra memory is =

fine as long as it's only for MPTCP sockets. That is not acceptable to =

me and I plan to see if it is possible to allocate extra memory for =

MPTCP only when needed.

As you point out, this patch is not about having a most efficient MPTCP =

implementation, but an attempt to interface more cleanly with TCP and =

ask the folks upstream if this makes sense or not.

Shoaib

>
> Peter.
>
>>   	sk_sockets_allocated_inc(sk);
>>   }
>>   EXPORT_SYMBOL(tcp_init_sock);
>>   =

>>   void tcp_init_transfer(struct sock *sk, int bpf_op)
>>   {
>> +	const struct tcp_sock *tp =3D tcp_sk(sk);
>>   	struct inet_connection_sock *icsk =3D inet_csk(sk);
>>   =

>>   	tcp_mtup_init(sk);
>> @@ -521,7 +533,7 @@ void tcp_init_transfer(struct sock *sk, int bpf_op)
>>   	tcp_init_metrics(sk);
>>   	tcp_call_bpf(sk, bpf_op, 0, NULL);
>>   	tcp_init_congestion_control(sk);
>> -	tcp_init_buffer_space(sk);
>> +	tp->op_ops->init_buffer_space(sk);
>>   }
>>   =

>>   static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
>> @@ -1004,7 +1016,7 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct p=
age *page, int offset,
>>   =

>>   	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
>>   =

>> -	mss_now =3D tcp_send_mss(sk, &size_goal, flags);
>> +	mss_now =3D tp->op_ops->send_mss(sk, &size_goal, flags);
>>   	copied =3D 0;
>>   =

>>   	err =3D -EPIPE;
>> @@ -1090,7 +1102,7 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct p=
age *page, int offset,
>>   		if (err !=3D 0)
>>   			goto do_error;
>>   =

>> -		mss_now =3D tcp_send_mss(sk, &size_goal, flags);
>> +		mss_now =3D tp->op_ops->send_mss(sk, &size_goal, flags);
>>   	}
>>   =

>>   out:
>> @@ -1134,7 +1146,8 @@ int tcp_sendpage(struct sock *sk, struct page *pag=
e, int offset,
>>   	int ret;
>>   =

>>   	lock_sock(sk);
>> -	ret =3D tcp_sendpage_locked(sk, page, offset, size, flags);
>> +	ret =3D tcp_sk(sk)->op_ops->sendpage_locked(sk, page, offset,
>> +						  size, flags);
>>   	release_sock(sk);
>>   =

>>   	return ret;
>> @@ -1282,8 +1295,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msg=
hdr *msg, size_t size)
>>   	 * (passive side) where data is allowed to be sent before a connection
>>   	 * is fully established.
>>   	 */
>> -	if (((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) &&
>> -	    !tcp_passive_fastopen(sk)) {
>> +	if (!tp->op_ops->can_send(sk)) {
>>   		err =3D sk_stream_wait_connect(sk, &timeo);
>>   		if (err !=3D 0)
>>   			goto do_error;
>> @@ -1318,7 +1330,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msg=
hdr *msg, size_t size)
>>   	copied =3D 0;
>>   =

>>   restart:
>> -	mss_now =3D tcp_send_mss(sk, &size_goal, flags);
>> +	mss_now =3D tp->op_ops->send_mss(sk, &size_goal, flags);
>>   =

>>   	err =3D -EPIPE;
>>   	if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN))
>> @@ -1353,7 +1365,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msg=
hdr *msg, size_t size)
>>   				goto restart;
>>   			}
>>   			first_skb =3D tcp_rtx_and_write_queues_empty(sk);
>> -			linear =3D select_size(sk, sg, first_skb, zc);
>> +			linear =3D tp->op_ops->select_size(sk, sg, first_skb, zc);
>>   			skb =3D sk_stream_alloc_skb(sk, linear, sk->sk_allocation,
>>   						  first_skb);
>>   			if (!skb)
>> @@ -1473,7 +1485,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msg=
hdr *msg, size_t size)
>>   		if (err !=3D 0)
>>   			goto do_error;
>>   =

>> -		mss_now =3D tcp_send_mss(sk, &size_goal, flags);
>> +		mss_now =3D tp->op_ops->send_mss(sk, &size_goal, flags);
>>   	}
>>   =

>>   out:
>> @@ -1762,7 +1774,7 @@ int tcp_read_sock(struct sock *sk, read_descriptor=
_t *desc,
>>   	/* Clean up data we have read: This will do ACK frames. */
>>   	if (copied > 0) {
>>   		tcp_recv_skb(sk, seq, &offset);
>> -		tcp_cleanup_rbuf(sk, copied);
>> +		tp->op_ops->cleanup_rbuf(sk, copied);
>>   	}
>>   	return copied;
>>   }
>> @@ -1982,7 +1994,7 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *ms=
g, size_t len, int nonblock,
>>   			}
>>   		}
>>   =

>> -		tcp_cleanup_rbuf(sk, copied);
>> +		tp->op_ops->cleanup_rbuf(sk, copied);
>>   =

>>   		if (copied >=3D target) {
>>   			/* Do not sleep, just process backlog. */
>> @@ -2075,7 +2087,7 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *ms=
g, size_t len, int nonblock,
>>   		tcp_recv_timestamp(msg, sk, &tss);
>>   =

>>   	/* Clean up data we have read: This will do ACK frames. */
>> -	tcp_cleanup_rbuf(sk, copied);
>> +	tp->op_ops->cleanup_rbuf(sk, copied);
>>   =

>>   	release_sock(sk);
>>   	return copied;
>> @@ -2876,7 +2888,7 @@ static int do_tcp_setsockopt(struct sock *sk, int =
level,
>>   			    (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT) &&
>>   			    inet_csk_ack_scheduled(sk)) {
>>   				icsk->icsk_ack.pending |=3D ICSK_ACK_PUSHED;
>> -				tcp_cleanup_rbuf(sk, 1);
>> +				tp->op_ops->cleanup_rbuf(sk, 1);
>>   				if (!(val & 1))
>>   					icsk->icsk_ack.pingpong =3D 1;
>>   			}
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index 5d6eb58..8cc48bb 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -425,7 +425,7 @@ void tcp_init_buffer_space(struct sock *sk)
>>   	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK))
>>   		tcp_fixup_rcvbuf(sk);
>>   	if (!(sk->sk_userlocks & SOCK_SNDBUF_LOCK))
>> -		tcp_sndbuf_expand(sk);
>> +		tp->op_ops->sndbuf_expand(sk);
>>   =

>>   	tp->rcvq_space.space =3D tp->rcv_wnd;
>>   	tcp_mstamp_refresh(tp);
>> @@ -690,7 +690,7 @@ static void tcp_event_data_recv(struct sock *sk, str=
uct sk_buff *skb)
>>   	tcp_ecn_check_ce(tp, skb);
>>   =

>>   	if (skb->len >=3D 128)
>> -		tcp_grow_window(sk, skb);
>> +		tp->op_ops->grow_window(sk, skb);
>>   }
>>   =

>>   /* Called to compute a smoothed rtt estimate. The data fed to this
>> @@ -1504,7 +1504,7 @@ static struct sk_buff *tcp_sacktag_walk(struct sk_=
buff *skb, struct sock *sk,
>>   		 * so not even _safe variant of the loop is enough.
>>   		 */
>>   		if (in_sack <=3D 0) {
>> -			tmp =3D tcp_shift_skb_data(sk, skb, state,
>> +			tmp =3D tp->op_ops->shift_skb_data(sk, skb, state,
>>   						 start_seq, end_seq, dup_sack);
>>   			if (tmp) {
>>   				if (tmp !=3D skb) {
>> @@ -2974,7 +2974,7 @@ static u32 tcp_tso_acked(struct sock *sk, struct s=
k_buff *skb)
>>   	BUG_ON(!after(TCP_SKB_CB(skb)->end_seq, tp->snd_una));
>>   =

>>   	packets_acked =3D tcp_skb_pcount(skb);
>> -	if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq))
>> +	if (tp->op_ops->trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq))
>>   		return 0;
>>   	packets_acked -=3D tcp_skb_pcount(skb);
>>   =

>> @@ -4362,7 +4362,7 @@ int tcp_try_rmem_schedule(struct sock *sk, struct =
sk_buff *skb,
>>   			return -1;
>>   =

>>   		while (!sk_rmem_schedule(sk, skb, size)) {
>> -			if (!tcp_prune_ofo_queue(sk))
>> +			if (!tcp_sk(sk)->op_ops->prune_ofo_queue(sk))
>>   				return -1;
>>   		}
>>   	}
>> @@ -4741,7 +4741,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head =
*list, struct rb_root *root,
>>   =

>>   		/* No new bits? It is possible on ofo queue. */
>>   		if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
>> -			skb =3D tcp_collapse_one(sk, skb, list, root);
>> +			skb =3D tcp_sk(sk)->op_ops->collapse_one(sk, skb,
>> +							       list, root);
>>   			if (!skb)
>>   				break;
>>   			goto restart;
>> @@ -4805,7 +4806,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head =
*list, struct rb_root *root,
>>   				start +=3D size;
>>   			}
>>   			if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
>> -				skb =3D tcp_collapse_one(sk, skb, list, root);
>> +				skb =3D
>> +				tcp_sk(sk)->op_ops->collapse_one(sk, skb, list,
>> +								 root);
>>   				if (!skb ||
>>   				    skb =3D=3D tail ||
>>   				    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
>> @@ -4933,7 +4936,7 @@ static int tcp_prune_queue(struct sock *sk)
>>   	/* Collapsing did not help, destructive actions follow.
>>   	 * This must not ever occur. */
>>   =

>> -	tcp_prune_ofo_queue(sk);
>> +	tp->op_ops->prune_ofo_queue(sk);
>>   =

>>   	if (atomic_read(&sk->sk_rmem_alloc) <=3D sk->sk_rcvbuf)
>>   		return 0;
>> @@ -4985,7 +4988,7 @@ static void tcp_new_space(struct sock *sk)
>>   	struct tcp_sock *tp =3D tcp_sk(sk);
>>   =

>>   	if (tcp_should_expand_sndbuf(sk)) {
>> -		tcp_sndbuf_expand(sk);
>> +		tp->op_ops->sndbuf_expand(sk);
>>   		tp->snd_cwnd_stamp =3D tcp_jiffies32;
>>   	}
>>   =

>> @@ -5454,7 +5457,7 @@ void tcp_rcv_established(struct sock *sk, struct s=
k_buff *skb,
>>   	tcp_rcv_rtt_measure_ts(sk, skb);
>>   =

>>   	/* Process urgent data. */
>> -	tcp_urg(sk, skb, th);
>> +	tp->op_ops->urg(sk, skb, th);
>>   =

>>   	/* step 7: process the segment text */
>>   	tcp_data_queue(sk, skb);
>> @@ -5846,7 +5849,7 @@ int tcp_rcv_state_process(struct sock *sk, struct =
sk_buff *skb)
>>   			return queued;
>>   =

>>   		/* Do step6 onward by hand. */
>> -		tcp_urg(sk, skb, th);
>> +		tp->op_ops->urg(sk, skb, th);
>>   		__kfree_skb(skb);
>>   		tcp_data_snd_check(sk);
>>   		return 0;
>> @@ -6011,7 +6014,7 @@ int tcp_rcv_state_process(struct sock *sk, struct =
sk_buff *skb)
>>   	}
>>   =

>>   	/* step 6: check the URG bit */
>> -	tcp_urg(sk, skb, th);
>> +	tp->op_ops->urg(sk, skb, th);
>>   =

>>   	/* step 7: process the segment text */
>>   	switch (sk->sk_state) {
>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> index f3e52bc..482ca15 100644
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -1885,12 +1885,8 @@ static const struct tcp_sock_af_ops tcp_sock_ipv4=
_specific =3D {
>>    */
>>   static int tcp_v4_init_sock(struct sock *sk)
>>   {
>> -	struct inet_connection_sock *icsk =3D inet_csk(sk);
>> -
>>   	tcp_init_sock(sk);
>>   =

>> -	icsk->icsk_af_ops =3D &ipv4_specific;
>> -
>>   #ifdef CONFIG_TCP_MD5SIG
>>   	tcp_sk(sk)->af_specific =3D &tcp_sock_ipv4_specific;
>>   #endif
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index 9f5be16..f296f1f7 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -771,8 +771,8 @@ static void tcp_tsq_handler(struct sock *sk)
>>   			tcp_xmit_retransmit_queue(sk);
>>   		}
>>   =

>> -		tcp_write_xmit(sk, tcp_current_mss(sk), tp->nonagle,
>> -			       0, GFP_ATOMIC);
>> +		tcp_sk(sk)->op_ops->write_xmit(sk, tcp_current_mss(sk),
>> +					       tp->nonagle, 0, GFP_ATOMIC);
>>   	}
>>   }
>>   /*
>> @@ -2282,8 +2282,8 @@ bool tcp_write_xmit(struct sock *sk, unsigned int =
mss_now, int nonagle,
>>   =

>>   	tcp_mstamp_refresh(tp);
>>   	if (!push_one) {
>> -		/* Do MTU probing. */
>> -		result =3D tcp_mtu_probe(sk);
>> +		/* Do MTU probing ? */
>> +		result =3D tp->op_ops->mtu_probe(sk);
>>   		if (!result) {
>>   			return false;
>>   		} else if (result > 0) {
>> @@ -2524,8 +2524,8 @@ void __tcp_push_pending_frames(struct sock *sk, un=
signed int cur_mss,
>>   	if (unlikely(sk->sk_state =3D=3D TCP_CLOSE))
>>   		return;
>>   =

>> -	if (tcp_write_xmit(sk, cur_mss, nonagle, 0,
>> -			   sk_gfp_mask(sk, GFP_ATOMIC)))
>> +	if (tcp_sk(sk)->op_ops->write_xmit(sk, cur_mss, nonagle, 0,
>> +					   sk_gfp_mask(sk, GFP_ATOMIC)))
>>   		tcp_check_probe_timer(sk);
>>   }
>>   =

>> @@ -2538,7 +2538,8 @@ void tcp_push_one(struct sock *sk, unsigned int ms=
s_now)
>>   =

>>   	BUG_ON(!skb || skb->len < mss_now);
>>   =

>> -	tcp_write_xmit(sk, mss_now, TCP_NAGLE_PUSH, 1, sk->sk_allocation);
>> +	tcp_sk(sk)->op_ops->write_xmit(sk, mss_now, TCP_NAGLE_PUSH, 1,
>> +				       sk->sk_allocation);
>>   }
>>   =

>>   /* This function returns the amount that we can raise the
>> @@ -2822,7 +2823,8 @@ int __tcp_retransmit_skb(struct sock *sk, struct s=
k_buff *skb, int segs)
>>   	if (before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
>>   		if (before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))
>>   			BUG();
>> -		if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq))
>> +		if (tp->op_ops->trim_head(sk, skb,
>> +					  tp->snd_una - TCP_SKB_CB(skb)->seq))
>>   			return -ENOMEM;
>>   	}
>>   =

>> @@ -2855,7 +2857,7 @@ int __tcp_retransmit_skb(struct sock *sk, struct s=
k_buff *skb, int segs)
>>   		if (diff)
>>   			tcp_adjust_pcount(sk, skb, diff);
>>   		if (skb->len < cur_mss)
>> -			tcp_retrans_try_collapse(sk, skb, cur_mss);
>> +			tp->op_ops->retrans_try_collapse(sk, skb, cur_mss);
>>   	}
>>   =

>>   	/* RFC3168, section 6.1.1.1. ECN fallback */
>> @@ -3464,7 +3466,7 @@ int tcp_connect(struct sock *sk)
>>   	if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk))
>>   		return -EHOSTUNREACH; /* Routing failure or similar. */
>>   =

>> -	tcp_connect_init(sk);
>> +	tp->op_ops->connect_init(sk);
>>   =

>>   	if (unlikely(tp->repair)) {
>>   		tcp_finish_connect(sk, NULL);
>> @@ -3704,7 +3706,7 @@ void tcp_send_probe0(struct sock *sk)
>>   	unsigned long probe_max;
>>   	int err;
>>   =

>> -	err =3D tcp_write_wakeup(sk, LINUX_MIB_TCPWINPROBE);
>> +	err =3D tp->op_ops->write_wakeup(sk, LINUX_MIB_TCPWINPROBE);
>>   =

>>   	if (tp->packets_out || tcp_write_queue_empty(sk)) {
>>   		/* Cancel probe timer, if it is not required. */
>> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
>> index 71fc60f..beaba7a 100644
>> --- a/net/ipv4/tcp_timer.c
>> +++ b/net/ipv4/tcp_timer.c
>> @@ -569,7 +569,7 @@ void tcp_write_timer_handler(struct sock *sk)
>>   		break;
>>   	case ICSK_TIME_RETRANS:
>>   		icsk->icsk_pending =3D 0;
>> -		tcp_retransmit_timer(sk);
>> +		tcp_sk(sk)->op_ops->retransmit_timer(sk);
>>   		break;
>>   	case ICSK_TIME_PROBE0:
>>   		icsk->icsk_pending =3D 0;
>> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
>> index 883df0a..293bdc8 100644
>> --- a/net/ipv6/tcp_ipv6.c
>> +++ b/net/ipv6/tcp_ipv6.c
>> @@ -77,8 +77,6 @@ static void	tcp_v6_reqsk_send_ack(const struct sock *s=
k, struct sk_buff *skb,
>>   =

>>   static int	tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb);
>>   =

>> -static const struct inet_connection_sock_af_ops ipv6_mapped;
>> -static const struct inet_connection_sock_af_ops ipv6_specific;
>>   #ifdef CONFIG_TCP_MD5SIG
>>   static const struct tcp_sock_af_ops tcp_sock_ipv6_specific;
>>   static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
>> @@ -1656,7 +1654,7 @@ static struct timewait_sock_ops tcp6_timewait_sock=
_ops =3D {
>>   	.twsk_destructor =3D tcp_twsk_destructor,
>>   };
>>   =

>> -static const struct inet_connection_sock_af_ops ipv6_specific =3D {
>> +const struct inet_connection_sock_af_ops ipv6_specific =3D {
>>   	.queue_xmit	   =3D inet6_csk_xmit,
>>   	.send_check	   =3D tcp_v6_send_check,
>>   	.rebuild_header	   =3D inet6_sk_rebuild_header,
>> @@ -1687,7 +1685,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_=
specific =3D {
>>   /*
>>    *	TCP over IPv4 via INET6 API
>>    */
>> -static const struct inet_connection_sock_af_ops ipv6_mapped =3D {
>> +const struct inet_connection_sock_af_ops ipv6_mapped =3D {
>>   	.queue_xmit	   =3D ip_queue_xmit,
>>   	.send_check	   =3D tcp_v4_send_check,
>>   	.rebuild_header	   =3D inet_sk_rebuild_header,
>> @@ -1719,12 +1717,8 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6=
_mapped_specific =3D {
>>    */
>>   static int tcp_v6_init_sock(struct sock *sk)
>>   {
>> -	struct inet_connection_sock *icsk =3D inet_csk(sk);
>> -
>>   	tcp_init_sock(sk);
>>   =

>> -	icsk->icsk_af_ops =3D &ipv6_specific;
>> -
>>   #ifdef CONFIG_TCP_MD5SIG
>>   	tcp_sk(sk)->af_specific =3D &tcp_sock_ipv6_specific;
>>   #endif
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============3284607459522131334==--
