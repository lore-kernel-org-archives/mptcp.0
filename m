Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C922C82
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 01:11:02 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="230039393"
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="scan'208";a="230039393"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 17:11:01 -0800
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="scan'208";a="642361689"
Received: from ticede-or-153.amr.corp.intel.com ([10.212.186.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 17:11:01 -0800
Date: Tue, 9 Nov 2021 17:11:00 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/3] mptcp: add TCP_INQ cmsg support
In-Reply-To: <20211108105711.16200-2-fw@strlen.de>
Message-ID: <add0921a-4ce2-a3d4-d4d-442d4e88365f@linux.intel.com>
References: <20211108105711.16200-1-fw@strlen.de> <20211108105711.16200-2-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 8 Nov 2021, Florian Westphal wrote:

> Support the TCP_INQ setsockopt.
> This is a boolean that tells recvmsg path to include the remaining
> in-sequence bytes into a cmsg data.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/224
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> net/mptcp/protocol.c | 33 +++++++++++++++++++++++++++++++++
> net/mptcp/protocol.h |  1 +
> net/mptcp/sockopt.c  | 37 +++++++++++++++++++++++++++++++++++++
> 3 files changed, 71 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b0bfe20d6bb0..b4263bf821ac 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -46,6 +46,7 @@ struct mptcp_skb_cb {
>
> enum {
> 	MPTCP_CMSG_TS = BIT(0),
> +	MPTCP_CMSG_INQ = BIT(1),
> };
>
> static struct percpu_counter mptcp_sockets_allocated;
> @@ -2006,6 +2007,29 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
> 	return !skb_queue_empty(&msk->receive_queue);
> }
>
> +static unsigned int mptcp_inq_hint(const struct sock *sk)
> +{
> +	const struct mptcp_sock *msk = mptcp_sk(sk);
> +	const struct sk_buff *skb;
> +	u64 acked = msk->ack_seq;
> +	u64 hint_val = 0;
> +
> +	skb = skb_peek(&msk->receive_queue);
> +	if (skb) {
> +		u64 map_seq = MPTCP_SKB_CB(skb)->map_seq + MPTCP_SKB_CB(skb)->offset;

MPTCP_SKB_CB(skb)->offset is an offset within the skb payload, not related 
to the map_seq.

I think MPTCP_SKB_CB(skb)->end_seq has the sequence number you need for 
hint_val?

I did run in to a selftest failure, but could not reproduce:

$ sudo ./mptcp_sockopt.sh
Created /tmp/tmp.Kj9eQSvhn3 (size 1024 KB) containing data sent by client
Created /tmp/tmp.qOpE4X43Jp (size 1024 KB) containing data sent by server
tcp_inq is larger than one mbyte
copyfd_io_poll: poll timed out (events: POLLIN 0, POLLOUT 4)
  client exit code 1, server 2

netns ns1-0-IRJkco socket stat for 12001:
Netid  State     Recv-Q  Send-Q     Local Address:Port      Peer Address:Port   Process 
tcp    ESTAB     0       0               10.0.2.1:12001         10.0.2.2:52141   ino:0 sk:1 fwmark:0x1 <->
 	 ts sack cubic wscale:7,7 rto:201 rtt:0.427/0.261 ato:40 mss:1448 pmtu:1500 rcvmss:1420 advmss:1448 cwnd:10 ssthresh:56 bytes_sent:163620 bytes_acked:163620 bytes_received:65332 segs_out:131 segs_in:68 data_segs_out:117 data_segs_in:50 send 271288056bps lastsnd:30052 lastrcv:30057 lastack:30051 pacing_rate 1821988992bps delivery_rate 1488222216bps delivered:118 busy:3ms rcv_rtt:1 rcv_space:14600 rcv_ssthresh:148470 minrtt:0.122 tcp-ulp-mptcp flags:Jec token:0000(id:0)/5a7e8206(id:3) seq:a590dda83727410f sfseq:e0cd ssnoff:db8b95cc maplen:1e68
tcp    ESTAB     0       0               10.0.1.1:12001         10.0.1.2:48520   ino:0 sk:2 fwmark:0x1 <->
 	 ts sack cubic wscale:7,7 rto:201 rtt:0.279/0.037 ato:40 mss:1448 pmtu:1500 rcvmss:1420 advmss:1448 cwnd:10 ssthresh:20 bytes_sent:426076 bytes_acked:426076 bytes_received:114892 segs_out:368 segs_in:278 data_segs_out:336 data_segs_in:86 send 415197133bps lastsnd:105 lastrcv:30055 lastack:105 pacing_rate 496678872bps delivery_rate 41078008bps delivered:337 busy:9ms rwnd_limited:1ms(11.1%) sndbuf_limited:1ms(11.1%) rcv_rtt:1 rcv_space:14600 rcv_ssthresh:189558 minrtt:0.082 tcp-ulp-mptcp flags:Mec token:0000(id:0)/5a7e8206(id:0) seq:a590dda83728010f sfseq:1a0cd ssnoff:511e5d9a maplen:2000
tcp    ESTAB     0       0               10.0.3.1:12001         10.0.3.2:49725   ino:0 sk:3 fwmark:0x1 <->
 	 ts sack cubic wscale:7,7 rto:201 rtt:1/0.5 mss:1448 pmtu:1500 rcvmss:536 advmss:1448 cwnd:10 segs_out:2 segs_in:3 send 115840000bps lastsnd:30055 lastrcv:30055 lastack:30053 pacing_rate 231680000bps delivered:1 rcv_space:14600 rcv_ssthresh:64076 minrtt:1 tcp-ulp-mptcp flags:Jec token:0000(id:0)/5a7e8206(id:5) seq:a590dda83728210f sfseq:0 ssnoff:1bb4388 maplen:0
mptcp  LAST-ACK  0       0               10.0.1.1:12001         10.0.1.2:48520   timer:(keepalive,59sec,0) ino:0 sk:4 fwmark:0x1 ---
 	 subflows:7 add_addr_signal:8 add_addr_accepted:5 subflows_max:8 add_addr_signal_max:8 add_addr_accepted_max:8 remote_key token:5a7e8206 write_seq:cf6523e6d02cad72 snd_una:cf6523e6d027a6cd rcv_nxt:a590dda837282110

netns ns2-0-IRJkco socket stat for 12001:
Netid  State       Recv-Q  Send-Q   Local Address:Port      Peer Address:Port   Process 
tcp    ESTAB       230756  0             10.0.1.2:48520         10.0.1.1:12001   ino:0 sk:5 fwmark:0x2 <->
 	 ts sack cubic wscale:7,7 rto:201 rtt:0.414/0.368 ato:40 mss:1448 pmtu:1500 rcvmss:1168 advmss:1448 cwnd:27 ssthresh:27 bytes_sent:114892 bytes_acked:114893 bytes_received:426076 segs_out:278 segs_in:369 data_segs_out:86 data_segs_in:336 send 755478261bps lastsnd:30074 lastrcv:123 lastack:123 pacing_rate 906573912bps delivery_rate 8849496bps delivered:87 busy:5ms rcv_rtt:0.888 rcv_space:14480 rcv_ssthresh:163912 minrtt:0.082 tcp-ulp-mptcp flags:Mmec token:0000(id:0)/af0717b9(id:0) seq:cf6523e6d028ec4d sfseq:2e479 ssnoff:3f01671c maplen:1680
tcp    ESTAB       0       0             10.0.3.2:49725         10.0.3.1:12001   ino:0 sk:6 fwmark:0x2 <->
 	 ts sack cubic wscale:7,7 rto:201 rtt:0.48/0.24 mss:1448 pmtu:1500 rcvmss:536 advmss:1448 cwnd:10 bytes_acked:1 segs_out:3 segs_in:3 send 241333333bps lastsnd:30073 lastrcv:30073 lastack:30071 pacing_rate 482666664bps delivered:1 rcv_space:14480 rcv_ssthresh:64088 minrtt:0.48 tcp-ulp-mptcp flags:Jjec token:5a7e8206(id:5)/af0717b9(id:0) seq:0 sfseq:0 ssnoff:a5831809 maplen:0
tcp    ESTAB       52444   0             10.0.2.2:52141         10.0.2.1:12001   ino:0 sk:7 fwmark:0x2 <->
 	 ts sack cubic wscale:7,7 rto:201 rtt:0.167/0.105 ato:40 mss:1448 pmtu:1500 rcvmss:1420 advmss:1448 cwnd:15 bytes_sent:65332 bytes_acked:65333 bytes_received:163620 segs_out:68 segs_in:132 data_segs_out:50 data_segs_in:117 send 1040479042bps lastsnd:30075 lastrcv:30070 lastack:30070 pacing_rate 2079401640bps delivery_rate 868800000bps delivered:51 busy:3ms rcv_rtt:0.184 rcv_space:14480 rcv_ssthresh:152552 minrtt:0.077 tcp-ulp-mptcp flags:Jjec token:5a7e8206(id:3)/af0717b9(id:0) seq:cf6523e6d027e4ed sfseq:13841 ssnoff:21898d30 maplen:7a08
mptcp  FIN-WAIT-2  108184  0             10.0.1.2:48520         10.0.1.1:12001   timer:(keepalive,29sec,0) ino:0 sk:8 fwmark:0x2 ---
 	 subflows:7 add_addr_signal:8 add_addr_accepted:7 subflows_max:8 add_addr_signal_max:8 add_addr_accepted_max:8 remote_key token:af0717b9 write_seq:a590dda837282110 snd_una:a590dda837282110 rcv_nxt:cf6523e6d027a6cd

> +
> +		hint_val = acked - map_seq;
> +
> +		if (hint_val >= INT_MAX)
> +			hint_val = INT_MAX - 1;
> +	}
> +
> +	if (hint_val == 0 && sock_flag(sk, SOCK_DONE))
> +		hint_val = 1;
> +
> +	return (unsigned int)hint_val;
> +}
> +
> static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> 			 int nonblock, int flags, int *addr_len)
> {
> @@ -2030,6 +2054,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> 	len = min_t(size_t, len, INT_MAX);
> 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
>
> +	if (unlikely(msk->recvmsg_inq))
> +		cmsg_flags = MPTCP_CMSG_INQ;
> +
> 	while (copied < len) {
> 		int bytes_read;
>
> @@ -2103,6 +2130,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> 	if (cmsg_flags && copied >= 0) {
> 		if (cmsg_flags & MPTCP_CMSG_TS)
> 			tcp_recv_timestamp(msg, sk, &tss);
> +
> +		if (cmsg_flags & MPTCP_CMSG_INQ) {
> +			unsigned int inq = mptcp_inq_hint(sk);
> +
> +			put_cmsg(msg, SOL_TCP, TCP_CM_INQ, sizeof(inq), &inq);
> +		}
> 	}
>
> 	pr_debug("msk=%p rx queue empty=%d:%d copied=%d",
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 906509c6cde5..e77de7662df0 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -250,6 +250,7 @@ struct mptcp_sock {
> 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
> 	bool		csum_enabled;
> 	bool		allow_infinite_fallback;
> +	u8		recvmsg_inq:1;
> 	spinlock_t	join_list_lock;
> 	struct work_struct work;
> 	struct sk_buff  *ooo_last_skb;
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index b818e91f2e09..7405152691e0 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -557,6 +557,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
> 		case TCP_TIMESTAMP:
> 		case TCP_NOTSENT_LOWAT:
> 		case TCP_TX_DELAY:
> +		case TCP_INQ:
> 			return true;
> 		}
>
> @@ -698,7 +699,21 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
> static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 				    sockptr_t optval, unsigned int optlen)
> {
> +	struct sock *sk = (void *)msk;
> +	int ret, val;
> +
> 	switch (optname) {
> +	case TCP_INQ:
> +		ret = mptcp_get_int_option(msk, optval, optlen, &val);
> +		if (ret)
> +			return ret;
> +		if (val < 0 || val > 1)
> +			return -EINVAL;
> +
> +		lock_sock(sk);
> +		msk->recvmsg_inq = !!val;
> +		release_sock(sk);
> +		return 0;
> 	case TCP_ULP:
> 		return -EOPNOTSUPP;
> 	case TCP_CONGESTION:
> @@ -1032,6 +1047,26 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
> 	return 0;
> }
>
> +static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
> +				int __user *optlen, int val)
> +{
> +	int len;
> +
> +	if (get_user(len, optlen))
> +		return -EFAULT;
> +
> +	len = min_t(unsigned int, len, sizeof(int));
> +	if (len < 0)
> +		return -EINVAL;
> +
> +	if (put_user(len, optlen))
> +		return -EFAULT;
> +	if (copy_to_user(optval, &val, len))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 				    char __user *optval, int __user *optlen)
> {
> @@ -1042,6 +1077,8 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 	case TCP_CC_INFO:
> 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
> 						      optval, optlen);
> +	case TCP_INQ:
> +		return mptcp_put_int_option(msk, optval, optlen, msk->recvmsg_inq);
> 	}
> 	return -EOPNOTSUPP;
> }
> -- 
> 2.32.0
>
>
>

--
Mat Martineau
Intel
