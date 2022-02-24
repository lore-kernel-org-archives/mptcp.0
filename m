Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C27B
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 01:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645667660; x=1677203660;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Yj9iOmeOaEr9IwgA16v9zB/MgkTzNcOdPTD5p3zG0x0=;
  b=e8RGeZy5/zXvj6QSUAp1bO85CAYAPiH1hqZ+9PTD4W/2wWkP8U+rdAjX
   oEtKraq+RXzvc3EQWoS7/u7NgKX9I3CabSSb4aNPV3N9QOh6/VTGH0aVZ
   SLLVWIxyyNP1uQYI4UyYERIUvAWthIfyqxlAcWPVe7gY+Q4ZYnoiHTj5k
   SCSeLS/y0LiOSzInYN47kHNwDA9Z0yPtl1BK17wsSARHvAAEs9x9F4nqv
   8PlQqS2sczU/InGx6bhhJfUG29D3FkgVJjE5VAnm2vNGXMD1VVwjBXVnZ
   F5Od6RY3nnu5Ak1RwjGhjRU1A6A+c9BHv8geVHCq4HGxQ6nk9IwwwUtUo
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="315353825"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="315353825"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:54:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="684116019"
Received: from ortmgvpn37.amr.corp.intel.com ([10.212.237.95])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:54:10 -0800
Date: Wed, 23 Feb 2022 17:54:09 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [RFC mptcp-next v2 5/6] mptcp: add MP_FAIL retrans support
In-Reply-To: <b0f55c56cf296b360582fc54997cbb3f905c106b.1645096378.git.geliang.tang@suse.com>
Message-ID: <9d21497c-204-32f-3b57-e68d998f85d4@linux.intel.com>
References: <cover.1645096378.git.geliang.tang@suse.com> <b0f55c56cf296b360582fc54997cbb3f905c106b.1645096378.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 17 Feb 2022, Geliang Tang wrote:

> Add MP_FAIL retrans support.
>

I'm still trying to figure out if retransmitting MP_FAIL is the action to 
take if the MP_FAIL echo is not received. Could also just send RST, as in 
the other checksum error cases. As Christoph said, this is a "best effort" 
thing and I'm not sure the rare case justifies very much complexity. There 
are other scenarios that arise: for example, the MP_FAIL echo from the 
peer is lost, but the infinite mapping from the peer is delivered. That 
implies that the peer did get the MP_FAIL, but the RFC doesn't have the 
details on what to do.

What do you think about resetting the subflow if the fallback process 
doesn't follow the expected steps?


- Mat

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/pm.c       |  1 +
> net/mptcp/protocol.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
> net/mptcp/protocol.h |  2 ++
> net/mptcp/subflow.c  |  1 +
> 4 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 314e110588d7..ccb29b2d2075 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -285,6 +285,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> 			subflow->send_infinite_map = 1;
> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILECHOTX);
> 		} else {
> +			sk_stop_timer((struct sock *)msk, &msk->sk.icsk_retransmit_timer);
> 			subflow->mp_fail_response_expect = 0;
> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILECHORX);
> 		}
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4599bde215b2..461fd30c6b9d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -50,6 +50,8 @@ enum {
> 	MPTCP_CMSG_INQ = BIT(1),
> };
>
> +#define MP_FAIL_RETRANS_MAX	3
> +
> static struct percpu_counter mptcp_sockets_allocated ____cacheline_aligned_in_smp;
>
> static void __mptcp_destroy_sock(struct sock *sk);
> @@ -860,6 +862,46 @@ static void mptcp_reset_timer(struct sock *sk)
> 	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
> }
>
> +static void mptcp_mp_fail_timer(struct timer_list *t)
> +{
> +	struct inet_connection_sock *icsk = from_timer(icsk, t,
> +						       icsk_retransmit_timer);
> +	struct sock *sk = &icsk->icsk_inet.sk;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> +
> +	if (!msk)
> +		return;
> +	if (inet_sk_state_load(sk) == TCP_CLOSE)
> +		return;
> +
> +	bh_lock_sock(sk);
> +
> +	subflow = mptcp_subflow_ctx(msk->first);
> +	subflow->send_mp_fail = 1;
> +	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
> +	pr_debug("retransmit MP_FAIL %u", subflow->retrans_times++);
> +
> +	if (subflow->retrans_times < MP_FAIL_RETRANS_MAX) {
> +		__mptcp_set_timeout(sk, mptcp_get_mp_fail_timeout(sock_net(sk)));
> +		mptcp_reset_timer(sk);
> +	}
> +
> +	bh_unlock_sock(sk);
> +	sock_put(sk);
> +}
> +
> +void mptcp_setup_mp_fail_timer(struct mptcp_sock *msk)
> +{
> +	struct sock *sk = (struct sock *)msk;
> +
> +	/* re-use the csk retrans timer for MP_FAIL retrans */
> +	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
> +	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_mp_fail_timer, 0);
> +	__mptcp_set_timeout(sk, mptcp_get_mp_fail_timeout(sock_net(sk)));
> +	mptcp_reset_timer(sk);
> +}
> +
> bool mptcp_schedule_work(struct sock *sk)
> {
> 	if (inet_sk_state_load(sk) != TCP_CLOSE &&
> @@ -1598,7 +1640,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>
> out:
> 	/* ensure the rtx timer is running */
> -	if (!mptcp_timer_pending(sk))
> +	if (!mptcp_timer_pending(sk) && !__mptcp_check_fallback(msk))
> 		mptcp_reset_timer(sk);
> 	if (copied)
> 		__mptcp_check_send_data_fin(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index c28842ab0dcc..40954f2389e8 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -467,6 +467,7 @@ struct mptcp_subflow_context {
> 	u8	reset_transient:1;
> 	u8	reset_reason:4;
> 	u8	stale_count;
> +	u8	retrans_times;
>
> 	long	delegated_status;
>
> @@ -669,6 +670,7 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk);
> void mptcp_data_ready(struct sock *sk, struct sock *ssk);
> bool mptcp_finish_join(struct sock *sk);
> bool mptcp_schedule_work(struct sock *sk);
> +void mptcp_setup_mp_fail_timer(struct mptcp_sock *msk);
> int mptcp_setsockopt(struct sock *sk, int level, int optname,
> 		     sockptr_t optval, unsigned int optlen);
> int mptcp_getsockopt(struct sock *sk, int level, int optname,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f06d93fce1bb..a30867f926fd 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1174,6 +1174,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 					sk_eat_skb(ssk, skb);
> 			} else {
> 				subflow->mp_fail_response_expect = 1;
> +				mptcp_setup_mp_fail_timer(msk);
> 			}
> 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
> 			return true;
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
