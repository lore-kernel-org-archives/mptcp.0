Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27410802
	for <mptcp@lists.linux.dev>; Wed, 25 May 2022 01:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653440682; x=1684976682;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Z9xqEJ/4X6q1ccXA/6t79xZHt6uJGXyzTg/zWrQU6co=;
  b=LWn0J3BM6rROPpe03Vbu1MjoXbJfbMwD4vPjmI0uhesFrZ7Y2dutYiMf
   Jv48tzhS801IdVFA/sr9FU1y3nAwgcLjhUxE4rqAbkdsfOlkSj9qDkv69
   b4D30H/mgyjmv4GJ67uVvwsdSmsDH7D/t/hezBTfot9EA/VLMeUPW4QZJ
   eHBpZQRj9UrHd9b36WexXmxdmKJf5PvPPfEs1trNpA83K6Xliengu7sfc
   7Lw1nMOKoYfJwAaAQ6cfpPBuTFiz8EKuvPPfC9IJ4PNwQ6k5M9kasZaZv
   7UeSb7ac540eMZoUed1eX31grAt/eVAp8yTROQM5f7ofp1RIVj3JLG5ys
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273797823"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273797823"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 18:04:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="642161564"
Received: from ticela-or-166.amr.corp.intel.com ([10.251.23.3])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 18:04:41 -0700
Date: Tue, 24 May 2022 18:04:40 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Dmytro SHYTYI <dmytro@shytyi.net>
cc: mptcp@lists.linux.dev
Subject: Re: [RFC PATCH mptcp-next v3] mptcp: Fast Open Mechanism
In-Reply-To: <20220522183921.103526-1-dmytro@shytyi.net>
Message-ID: <30709939-9ba2-c9f1-1a0-d63236f53d86@linux.intel.com>
References: <20220522183921.103526-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed


On Sun, 22 May 2022, Dmytro SHYTYI wrote:

> This set of patches will bring "Fast Open" Option support to MPTCP.
> The aim of Fast Open Mechanism is to eliminate one round trip
> time from a TCP conversation by allowing data to be included as
> part of the SYN segment that initiates the connection.
>
> IETF RFC 8684: Appendix B.  TCP Fast Open and MPTCP.
>
> [PATCH v3] includes "client-server" partial support for :
> 1. MPTCP cookie request from client.
> 2. MPTCP cookie offering from server.
> 3. MPTCP SYN+DATA+COOKIE from client.
> 4. subsequent write + read on the opened socket.
>
> This patch is Work In Progress transitional draft. There was a pause
> in code development that was unpaused recently.

Welcome back Dmytro.

> Now this code is based
> on the top of mptcp-next branch. The option below will be modified in
> future inelligently, depending on socket type (TCP||MPTCP):
> *tcp_options ^= OPTION_TS
> You also might notice some of commented pieces of the upstream code -
> that (is probably not good) and was done to observe an
> expected behavior of MPTCP Fast Open mechanism. Any comments how
> to achive the same behavior of MPTCP_FO without commenting the related
> parts of the code are welcome.

One step would be to split those commented out regions in to a separate 
commit, so they're at least separate from the other changes.

Also, if you could trim out any extra whitespace changes (blank lines that 
were added or deleted), that makes it easier to review.

I have some first-pass comments below. I'll have to learn more about 
fastopen before I can comment on the protocol specifics.

>
> Signed-off-by: Dmytro SHYTYI <dmytro@shytyi.net>
> ---
> include/net/mptcp.h     |  2 +-
> net/ipv4/tcp_fastopen.c |  4 +++
> net/ipv4/tcp_input.c    |  7 ++---
> net/ipv4/tcp_output.c   |  3 +--
> net/mptcp/options.c     |  8 ++++--
> net/mptcp/protocol.c    | 59 ++++++++++++++++++++++++++++++++++++++---
> net/mptcp/sockopt.c     | 41 ++++++++++++++++++++++++++++
> net/mptcp/subflow.c     |  9 ++++---
> 8 files changed, 118 insertions(+), 15 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 6456ea26e4c7..692197187af8 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -139,7 +139,7 @@ void mptcp_space(const struct sock *ssk, int *space, int *full_space);
> bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
> 		       unsigned int *size, struct mptcp_out_options *opts);
> bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
> -			  struct mptcp_out_options *opts);
> +			  struct mptcp_out_options *opts, u16 *tcp_options);
> bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> 			       unsigned int *size, unsigned int remaining,
> 			       struct mptcp_out_options *opts);
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index fdbcf2a6d08e..f5f189e4d15a 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -346,8 +346,10 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
> 			      struct tcp_fastopen_cookie *foc,
> 			      const struct dst_entry *dst)
> {
> +	/*
> 	bool syn_data = TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq + 1;
> 	int tcp_fastopen = sock_net(sk)->ipv4.sysctl_tcp_fastopen;
> +	*/
> 	struct tcp_fastopen_cookie valid_foc = { .len = -1 };
> 	struct sock *child;
> 	int ret = 0;
> @@ -355,12 +357,14 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
> 	if (foc->len == 0) /* Client requests a cookie */
> 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPFASTOPENCOOKIEREQD);
>
> +	/*
> 	if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
> 	      (syn_data || foc->len >= 0) &&
> 	      tcp_fastopen_queue_check(sk))) {
> 		foc->len = -1;
> 		return NULL;
> 	}
> +	*/
>
> 	if (tcp_fastopen_no_cookie(sk, dst, TFO_SERVER_COOKIE_NOT_REQD))
> 		goto fastopen;
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 3231af73e430..38119b96171d 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6273,9 +6273,10 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
> 		}
> 		if (fastopen_fail)
> 			return -1;
> -		if (sk->sk_write_pending ||
> -		    icsk->icsk_accept_queue.rskq_defer_accept ||
> -		    inet_csk_in_pingpong_mode(sk)) {
> +
> +		if (!sk_is_mptcp(sk) && (sk->sk_write_pending ||
> +		     icsk->icsk_accept_queue.rskq_defer_accept ||
> +		     inet_csk_in_pingpong_mode(sk))) {
> 			/* Save one ACK. Data will be ready after
> 			 * several ticks, if write_pending is set.
> 			 *
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index b4b2284ed4a2..864517e63bdf 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -747,7 +747,7 @@ static void mptcp_set_option_cond(const struct request_sock *req,
> 	if (rsk_is_mptcp(req)) {
> 		unsigned int size;
>
> -		if (mptcp_synack_options(req, &size, &opts->mptcp)) {
> +		if (mptcp_synack_options(req, &size, &opts->mptcp, &opts->options)) {
> 			if (*remaining >= size) {
> 				opts->options |= OPTION_MPTCP;
> 				*remaining -= size;
> @@ -822,7 +822,6 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
> 			tp->syn_fastopen_exp = fastopen->cookie.exp ? 1 : 0;
> 		}
> 	}
> -
> 	smc_set_option(tp, opts, &remaining);
>
> 	if (sk_is_mptcp(sk)) {
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index be3b918a6d15..ebcb9c04ead9 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -887,16 +887,20 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> }
>
> bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
> -			  struct mptcp_out_options *opts)
> +			  struct mptcp_out_options *opts, u16 *tcp_options)
> {
> 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
> +#define OPTION_TS               BIT(1)
> +
> +
> +        *tcp_options ^= OPTION_TS;

Did you try setting tstamp_ok = 0 in the inet_request_sock, so 
tcp_synack_options() doesn't consume the space for the timestamp option to 
begin with?

>
> 	if (subflow_req->mp_capable) {
> 		opts->suboptions = OPTION_MPTCP_MPC_SYNACK;
> 		opts->sndr_key = subflow_req->local_key;
> 		opts->csum_reqd = subflow_req->csum_reqd;
> 		opts->allow_join_id0 = subflow_req->allow_join_id0;
> -		*size = TCPOLEN_MPTCP_MPC_SYNACK;
> +		*size = TCPOLEN_MPTCP_MPC_SYNACK  - TCPOLEN_TSTAMP_ALIGNED + TCPOLEN_SACKPERM_ALIGNED;

It's important to keep the timestamp and SACK logic in 
tcp_synack_options() so this function won't have to readjust the options 
size based on whatever combination of fastopen/timestamps/sack are 
enabled.

> 		pr_debug("subflow_req=%p, local_key=%llu",
> 			 subflow_req, subflow_req->local_key);
> 		return true;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d6aef4b13b8a..6649088baae5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -54,6 +54,8 @@ static struct percpu_counter mptcp_sockets_allocated ____cacheline_aligned_in_sm
>
> static void __mptcp_destroy_sock(struct sock *sk);
> static void __mptcp_check_send_data_fin(struct sock *sk);
> +static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> +				int addr_len, int flags);
>
> DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
> static struct net_device mptcp_napi_dev;
> @@ -1673,6 +1675,53 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
> 	}
> }
>
> +static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
> +				  size_t len, struct mptcp_sock *msk, size_t copied)
> +{
> +	const struct iphdr *iph;
> +	struct ubuf_info *uarg;
> +	struct sockaddr *uaddr;
> +	struct sk_buff *skb;
> +	struct tcp_sock *tp;
> +	struct socket *ssk;
> +	int ret;
> +
> +	ssk = __mptcp_nmpc_socket(msk);
> +	if (unlikely(!ssk))
> +		goto out_EFAULT;

Need to lock_sock() / release_sock() for both sk and ssk here. Be sure to 
observe the correct locking order (sk acquired first, released last).

> +	skb = tcp_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
> +	if (unlikely(!skb))
> +		goto out_EFAULT;
> +	iph = ip_hdr(skb);
> +	if (unlikely(!iph))
> +		goto out_EFAULT;
> +	uarg = msg_zerocopy_realloc(sk, len, skb_zcopy(skb));
> +	if (unlikely(!uarg))
> +		goto out_EFAULT;
> +	uaddr = msg->msg_name;
> +
> +	tp = tcp_sk(ssk->sk);
> +	if (unlikely(!tp))
> +		goto out_EFAULT;
> +	if (!tp->fastopen_req)
> +		tp->fastopen_req = kzalloc(sizeof(*tp->fastopen_req), ssk->sk->sk_allocation);
> +
> +	if (unlikely(!tp->fastopen_req))
> +		goto out_EFAULT;
> +	tp->fastopen_req->data = msg;
> +	tp->fastopen_req->size = len;
> +	tp->fastopen_req->uarg = uarg;

Similar to how mptcp_sendmsg() has to reimplement tcp_sendmsg() because of 
all the custom handling of the MPTCP retransmit queue and coordinating the 
mappings and data, I don't think the normal TCP fastopen code invoked by 
ssock->ops->connect() in mptcp_stream_connect() is going to work 
out-of-the-box.

I haven't had a chance to look at how the multipath-tcp.org kernel handles 
that yet, it might be good to check that out.

> +
> +	/* requests a cookie */
> +	ret = mptcp_stream_connect(sk->sk_socket, uaddr,
> +				   msg->msg_namelen, msg->msg_flags);
> +
> +	return ret;
> +out_EFAULT:
> +	ret = -EFAULT;
> +	return ret;
> +}
> +
> static void mptcp_set_nospace(struct sock *sk)
> {
> 	/* enable autotune */
> @@ -1690,9 +1739,9 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 	int ret = 0;
> 	long timeo;
>
> -	/* we don't support FASTOPEN yet */
> +	/* we don't fully support FASTOPEN yet */
> 	if (msg->msg_flags & MSG_FASTOPEN)
> -		return -EOPNOTSUPP;
> +		ret = mptcp_sendmsg_fastopen(sk, msg, len, msk, copied);
>
> 	/* silently ignore everything else */
> 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
> @@ -2558,10 +2607,10 @@ static void mptcp_worker(struct work_struct *work)
>
> 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
> 		__mptcp_close_subflow(msk);
> -
> +/*
> 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
> 		__mptcp_retrans(sk);
> -
> +*/
> 	mptcp_mp_fail_no_response(msk);
>
> unlock:
> @@ -2681,6 +2730,8 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
> 	case TCP_SYN_SENT:
> 		tcp_disconnect(ssk, O_NONBLOCK);
> 		break;
> +	case TCP_ESTABLISHED:
> +		break;

This would prevent subflows from being closed by any calls to 
mptcp_subflow_shutdown() - I'm curious what caused you to add this?

> 	default:
> 		if (__mptcp_check_fallback(mptcp_sk(sk))) {
> 			pr_debug("Fallback");
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 423d3826ca1e..e1ae1ef224cf 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -560,6 +560,8 @@ static bool mptcp_supported_sockopt(int level, int optname)
> 		case TCP_TX_DELAY:
> 		case TCP_INQ:
> 			return true;
> +		case TCP_FASTOPEN:
> +			return true;
> 		}
>
> 		/* TCP_MD5SIG, TCP_MD5SIG_EXT are not supported, MD5 is not compatible with MPTCP */
> @@ -768,6 +770,43 @@ static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optv
> 	return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, optlen);
> }
>
> +static int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t optval,
> +					     unsigned int optlen)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	struct net *net = sock_net(sk);
> +	int val;
> +	int ret;
> +
> +	ret = 0;
> +
> +	if (copy_from_sockptr(&val, optval, sizeof(val)))
> +		return -EFAULT;
> +
> +	lock_sock(sk);
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		lock_sock(ssk);
> +
> +		if (val >= 0 && ((1 << sk->sk_state) & (TCPF_CLOSE |
> +		    TCPF_LISTEN))) {
> +			tcp_fastopen_init_key_once(net);
> +			fastopen_queue_tune(sk, val);

Need to use ssk instead of sk in these several lines, right?

> +		} else {
> +			ret = -EINVAL;
> +		}
> +
> +		release_sock(ssk);
> +	}
> +
> +	release_sock(sk);
> +
> +	return ret;
> +}
> +
> static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 				    sockptr_t optval, unsigned int optlen)
> {
> @@ -796,6 +835,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
> 	case TCP_DEFER_ACCEPT:
> 		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
> +	case TCP_FASTOPEN:
> +		return mptcp_setsockopt_sol_tcp_fastopen(msk, optval, optlen);
> 	}
>
> 	return -EOPNOTSUPP;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 8841e8cd9ad8..f732e41e12df 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1002,16 +1002,17 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> 			sk_eat_skb(ssk, skb);
> 			return MAPPING_EMPTY;
> 		}
> -
> +/*
> 		if (!subflow->map_valid)
> 			return MAPPING_INVALID;
> -
> +*/

Yeah, there's some work to do to handle TFO data since the RFC says it is 
not part of the data sequence number space. Fastopen will need to move the 
SYN data directly to the msk->receive_queue, bypassing the normal mapping 
code.


> 		goto validate_seq;
> 	}
>
> 	trace_get_mapping_status(mpext);
>
> 	data_len = mpext->data_len;
> +
> 	if (data_len == 0) {
> 		pr_debug("infinite mapping received");
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> @@ -1075,6 +1076,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> 		/* If this skb data are fully covered by the current mapping,
> 		 * the new map would need caching, which is not supported
> 		 */
> +
> 		if (skb_is_fully_mapped(ssk, skb)) {
> 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSNOMATCH);
> 			return MAPPING_INVALID;
> @@ -1107,11 +1109,12 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> 	/* we revalidate valid mapping on new skb, because we must ensure
> 	 * the current skb is completely covered by the available mapping
> 	 */
> +	/*
> 	if (!validate_mapping(ssk, skb)) {
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSTCPMISMATCH);
> 		return MAPPING_INVALID;
> 	}
> -
> +	*/

If the fastopen data bypasses the normal mptcp receive path, mappings can 
still be validated (as they must be :) ) for regular data.

> 	skb_ext_del(skb, SKB_EXT_MPTCP);
>
> validate_csum:
> -- 
> 2.25.1
>
>
>
>

--
Mat Martineau
Intel
