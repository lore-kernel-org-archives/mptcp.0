Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828FEC89
	for <mptcp@lists.linux.dev>; Sat,  5 Mar 2022 01:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646442416; x=1677978416;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2wV5s2/+orVNmvNld/8bn21JauEDabv9IppJ/lpGNec=;
  b=fvGN5IVHVK9mFbro+p4igg/gVcYzBIDZW5Xukeu/oY1pk4yDuhHSxQyt
   l5Bmnve4JYVcPeZ9l0MaraYbgeemLhEnxt6414/4SJBdmoKdB/L29Hgak
   rQgbcuGdIctAn5w+4Qimf9BMKad2zQP3Rbq36mOy5TIdPFlPtbcmdF7Z6
   ZFpWua0zVQjg31E80GhE6in2w55MmIXaHJeA6PMVXYeLZEApwaaPhgECI
   oEggLAogSUzr+0Zd4Wmtg5pccc1GCWUVw+rNMHi+DddjwiqV/X8St0egH
   0XZFD4uXWO9g//oZxfzfhxk4KWR79sypn/FCDhvVVU9lJ+HNbvW4PEXLl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="253828258"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="253828258"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 17:06:56 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="552431470"
Received: from iballa-mobl2.amr.corp.intel.com ([10.251.12.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 17:06:56 -0800
Date: Fri, 4 Mar 2022 17:06:55 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/2] mptcp: reset the subflow when MP_FAIL is
 lost
In-Reply-To: <d4b8877793e878092bd17cfd45018b0feafbace0.1646287286.git.geliang.tang@suse.com>
Message-ID: <4b65313-b2b6-d214-3587-f626991079f@linux.intel.com>
References: <cover.1646287286.git.geliang.tang@suse.com> <d4b8877793e878092bd17cfd45018b0feafbace0.1646287286.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 3 Mar 2022, Geliang Tang wrote:

> This patch reuses icsk_retransmit_timer to trigger a check if we have
> not received a response from the peer after sending MP_FAIL. If the
> peer doesn't respond properly, reset the subflow.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/pm.c       |  1 +
> net/mptcp/protocol.c | 32 +++++++++++++++++++++++++++++++-
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  |  1 +
> 4 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index c9080230b800..441f5c79b601 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -285,6 +285,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
> 			subflow->send_infinite_map = 1;
> 		} else {
> +			sk_stop_timer((struct sock *)msk, &msk->sk.icsk_retransmit_timer);

mptcp_data_lock() needs to be held when manipulating the msk 
retransmit_timer.

> 			subflow->mp_fail_response_expect = 0;
> 		}
> 	}
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3cb975227d12..59d2deec1ae8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -866,6 +866,36 @@ static void mptcp_reset_timer(struct sock *sk)
> 	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
> }
>
> +static void mptcp_mp_fail_timer(struct timer_list *t)
> +{
> +	struct inet_connection_sock *icsk = from_timer(icsk, t,
> +						       icsk_retransmit_timer);
> +	struct sock *sk = &icsk->icsk_inet.sk, *ssk;
> +	struct mptcp_subflow_context *subflow;
> +
> +	if (!sk || inet_sk_state_load(sk) == TCP_CLOSE)
> +		return;
> +
> +	bh_lock_sock(sk);
> +	subflow = mptcp_subflow_ctx(mptcp_sk(sk)->first);

Right now, the code only attempts an MP_FAIL fallback if there have never 
been any other subflows addes, so the msk->first assumption seems to work. 
This is fragile if other code changes to support fallback in other 
scenarios (as allowed by the RFC). Would be better to find the subflow 
with mp_fail_response_expect set and shut that one down.

> +	ssk = mptcp_subflow_tcp_sock(subflow);
> +	pr_debug("MP_FAIL is lost, reset the subflow");
> +	mptcp_subflow_reset(ssk);

Need to handle ssk locking too.

-Mat

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
> +	__mptcp_set_timeout(sk, TCP_RTO_MAX);
> +	mptcp_reset_timer(sk);
> +}
> +
> bool mptcp_schedule_work(struct sock *sk)
> {
> 	if (inet_sk_state_load(sk) != TCP_CLOSE &&
> @@ -1604,7 +1634,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>
> out:
> 	/* ensure the rtx timer is running */
> -	if (!mptcp_timer_pending(sk))
> +	if (!mptcp_timer_pending(sk) && !__mptcp_check_fallback(msk))
> 		mptcp_reset_timer(sk);
> 	if (copied)
> 		__mptcp_check_send_data_fin(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 39aa22595add..313c1a6c616f 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -669,6 +669,7 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk);
> void mptcp_data_ready(struct sock *sk, struct sock *ssk);
> bool mptcp_finish_join(struct sock *sk);
> bool mptcp_schedule_work(struct sock *sk);
> +void mptcp_setup_mp_fail_timer(struct mptcp_sock *msk);
> int mptcp_setsockopt(struct sock *sk, int level, int optname,
> 		     sockptr_t optval, unsigned int optlen);
> int mptcp_getsockopt(struct sock *sk, int level, int optname,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 63a256a94b65..960b161b1cb2 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1219,6 +1219,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
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
