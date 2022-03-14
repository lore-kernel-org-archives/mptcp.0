Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C7C7469
	for <mptcp@lists.linux.dev>; Mon, 14 Mar 2022 23:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647300496; x=1678836496;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NIHwmlU9HvNFn6x8EMKqwWYT4ZHyfbmrQQSXP2vwLmA=;
  b=dyykn/kK73f2/WbINYuJ46jvUj5u90T/uun1/BEqryvFThjCfKdFsN78
   XG8ozfwq9hpgBljbU64Z6VeQeze+Kt7/WZioiAekfR05NmAT5AxBzNeCe
   0UGqejFtdBSUxx2csRYxkC0pU1osn2GG6EXSfV3Uqc/ZX75EoRG6SWyXE
   1DZMkft0RoEGkG8lcFi3HjTzopAUaNaDkQ31EpxSdIqMc9LMGj51UtZHZ
   HuepV5UIj4MdKa5P298SqskM+V1+uSAYqI0gHHbkKnUk08VplC1iJk6CP
   KVrwIjoUvjq13Hg14/hWTSmAPUsdLKJY1IaM5DumCWzhl+KxNOwp2yHjp
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236114320"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="236114320"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 16:28:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="819338516"
Received: from rpmchugh-mobl.amr.corp.intel.com ([10.255.231.9])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 16:28:15 -0700
Date: Mon, 14 Mar 2022 16:28:14 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 2/4] mptcp: reset subflow when MP_FAIL
 doesn't respond
In-Reply-To: <3ad7b8308cfb43d625b75d059db95ecdebca4caf.1646898548.git.geliang.tang@suse.com>
Message-ID: <6d81053-849b-cdea-9230-80eb8b5d47b9@linux.intel.com>
References: <cover.1646898548.git.geliang.tang@suse.com> <3ad7b8308cfb43d625b75d059db95ecdebca4caf.1646898548.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 10 Mar 2022, Geliang Tang wrote:

> This patch added a new msk->flags bit MPTCP_FAIL_NO_RESPONSE, then reused
> sk_timer to trigger a check if we have not received a response from the
> peer after sending MP_FAIL. If the peer doesn't respond properly, reset
> the subflow.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/pm.c       |  7 +++++++
> net/mptcp/protocol.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  |  9 +++++++++
> 4 files changed, 61 insertions(+)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index f5f4561f332a..e3a541ffebbd 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -276,6 +276,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +	struct sock *s = (struct sock *)msk;
>
> 	pr_debug("fail_seq=%llu", fail_seq);
>
> @@ -288,6 +289,12 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> 		subflow->send_mp_fail = 1;
> 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
> 		subflow->send_infinite_map = 1;
> +	} else if (s && inet_sk_state_load(s) != TCP_CLOSE) {
> +		pr_debug("MP_FAIL response received");
> +
> +		mptcp_data_lock(s);

I think the TCP_CLOSE state should be checked again after acquiring the 
lock to be sure the state hasn't changed - another thread could have 
acquired the lock and changed the socket state.

> +		sk_stop_timer(s, &s->sk_timer);
> +		mptcp_data_unlock(s);
> 	}
> }
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3cb975227d12..d1a62e2a1d29 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2166,9 +2166,33 @@ static void mptcp_retransmit_timer(struct timer_list *t)
> 	sock_put(sk);
> }
>
> +static struct mptcp_subflow_context *
> +mp_fail_response_expect_subflow(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow, *ret = NULL;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (READ_ONCE(subflow->mp_fail_response_expect)) {
> +			ret = subflow;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> static void mptcp_timeout_timer(struct timer_list *t)
> {
> 	struct sock *sk = from_timer(sk, t, sk_timer);
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> +
> +	subflow = mp_fail_response_expect_subflow(msk);

The msk needs to be locked before iterating over the subflows.

> +	if (subflow) {
> +		bh_lock_sock(sk);
> +		__set_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags);
> +		bh_unlock_sock(sk);
> +	}
>
> 	mptcp_schedule_work(sk);
> 	sock_put(sk);
> @@ -2494,6 +2518,23 @@ static void __mptcp_retrans(struct sock *sk)
> 		mptcp_reset_timer(sk);
> }
>
> +static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *ssk;
> +	bool slow;
> +
> +	subflow = mp_fail_response_expect_subflow(msk);
> +	if (subflow) {
> +		pr_debug("MP_FAIL doesn't respond, reset the subflow");
> +
> +		ssk = mptcp_subflow_tcp_sock(subflow);
> +		slow = lock_sock_fast(ssk);
> +		mptcp_subflow_reset(ssk);
> +		unlock_sock_fast(ssk, slow);
> +	}
> +}
> +
> static void mptcp_worker(struct work_struct *work)
> {
> 	struct mptcp_sock *msk = container_of(work, struct mptcp_sock, work);
> @@ -2534,6 +2575,9 @@ static void mptcp_worker(struct work_struct *work)
> 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
> 		__mptcp_retrans(sk);
>
> +	if (test_and_clear_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags))
> +		mptcp_mp_fail_no_response(msk);
> +
> unlock:
> 	release_sock(sk);
> 	sock_put(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 83f0205f0d95..bf58d3c886f5 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -116,6 +116,7 @@
> #define MPTCP_WORK_EOF		3
> #define MPTCP_FALLBACK_DONE	4
> #define MPTCP_WORK_CLOSE_SUBFLOW 5
> +#define MPTCP_FAIL_NO_RESPONSE	6
>
> /* MPTCP socket release cb flags */
> #define MPTCP_PUSH_PENDING	1
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index ca2352ad20d4..d38b8089988e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -968,6 +968,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> 	bool csum_reqd = READ_ONCE(msk->csum_enabled);
> +	struct sock *sk = (struct sock *)msk;
> 	struct mptcp_ext *mpext;
> 	struct sk_buff *skb;
> 	u16 data_len;
> @@ -1009,6 +1010,11 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> 		pr_debug("infinite mapping received");
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> 		subflow->map_data_len = 0;
> +		if (sk && inet_sk_state_load(sk) != TCP_CLOSE) {
> +			mptcp_data_lock(sk);

Similar to above, best to re-check for TCP_CLOSE.

> +			sk_stop_timer(sk, &sk->sk_timer);
> +			mptcp_data_unlock(sk);
> +		}
> 		return MAPPING_INVALID;
> 	}
>
> @@ -1219,6 +1225,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 					sk_eat_skb(ssk, skb);
> 			} else {
> 				WRITE_ONCE(subflow->mp_fail_response_expect, true);
> +				sk_reset_timer((struct sock *)msk,
> +					       &((struct sock *)msk)->sk_timer,
> +					       jiffies + TCP_RTO_MAX);

Need to use mptcp_data_lock() here too. Can you also double-check other 
uses of sk_timer to make sure it's protected by the lock everywhere? The 
existing calls for using the timer at msk close might not all do this 
locking.

> 			}
> 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
> 			return true;
> -- 
> 2.34.1



--
Mat Martineau
Intel
