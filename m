Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCAF15A3
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 01:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646787765; x=1678323765;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=t106k8ptTxNJZH0BlxCuxwCtGBhMhak1MZpV+7F5ZDc=;
  b=LU+iIInTF3B71cFxi9js+Eyd+VFjO2CzPqyfaLXjT1gKfxjczQvDPMn8
   TdNR2ObYkDRolQqrnGs8v2461ykRzDdEI4TlckY6QDUjyAuMfUUcLfk/n
   ROqXDfhWwQzFkEhcu4decMgarv9Jv6ERS2cbGQWAm1JXGT8l7tLw/3rAV
   jz7RVz0oB3KZJdxWl1Ss/uBN24ZEWDfkjdVJk0odiWkejBCDNrRrCA2OE
   GoXXdSR+ZYoqksziEdgneqPI+UDIsUvn69rIJbrxlsPMg5NrIfkjcBy1v
   G8eTP16f1hBSf06AHYhHk5ri10117i4ARv1ADYN8L41jmLuTpWoHb53Vp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="315572225"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="315572225"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 17:02:45 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="578204873"
Received: from jhou5-mobl.amr.corp.intel.com ([10.209.115.160])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 17:02:45 -0800
Date: Tue, 8 Mar 2022 17:02:44 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 3/3] mptcp: reset the subflow when MP_FAIL
 is lost
In-Reply-To: <43b328bce5479e34e1dbf78b29b8d5d7d8ed2e02.1646657963.git.geliang.tang@suse.com>
Message-ID: <57e7f573-8ddc-a9db-5e17-a6916476385f@linux.intel.com>
References: <cover.1646657963.git.geliang.tang@suse.com> <43b328bce5479e34e1dbf78b29b8d5d7d8ed2e02.1646657963.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 7 Mar 2022, Geliang Tang wrote:

> This patch reuses icsk_retransmit_timer to trigger a check if we have
> not received a response from the peer after sending MP_FAIL. If the
> peer doesn't respond properly, reset the subflow.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/pm.c       |  5 ++++
> net/mptcp/protocol.c | 63 ++++++++++++++++++++++++++++++++++++++++++--
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  |  1 +
> 4 files changed, 68 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 7aae8c2e845b..2630018786c6 100644
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
> @@ -284,6 +285,10 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> 			subflow->send_mp_fail = 1;
> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
> 			subflow->send_infinite_map = 1;
> +		} else {
> +			mptcp_data_lock(s);
> +			sk_stop_timer(s, &msk->sk.icsk_retransmit_timer);
> +			mptcp_data_unlock(s);
> 		}
> 	}
> }
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3cb975227d12..8702f7123143 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -866,6 +866,59 @@ static void mptcp_reset_timer(struct sock *sk)
> 	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
> }
>
> +static struct mptcp_subflow_context *
> +mp_fail_response_expect_subflow(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow, *ret = NULL;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (subflow->mp_fail_response_expect) {
> +			ret = subflow;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void mptcp_mp_fail_timer(struct timer_list *t)
> +{
> +	struct inet_connection_sock *icsk = from_timer(icsk, t,
> +						       icsk_retransmit_timer);
> +	struct sock *sk = &icsk->icsk_inet.sk;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> +
> +	if (!sk || inet_sk_state_load(sk) == TCP_CLOSE)
> +		return;

Is it possible for sk to be NULL here? mptcp_timeout_timer() and 
mptcp_retransmit_timer() don't check for NULL.

Also, early return leaks a refcount on the sk (a sock_put() is always 
needed).

> +
> +	spin_lock_bh(&msk->pm.lock);
> +	subflow = mp_fail_response_expect_subflow(msk);
> +	spin_unlock_bh(&msk->pm.lock);

msk->conn_list is protected by the msk lock, so the pm.lock isn't going to 
protect it here.

I think if you used msk->sk_timer and a msk->flags bit, the existing 
mptcp_timeout_timer() handler could be used and some new code in 
mptcp_worker() could handle resetting the subflow. This would avoid a lot 
of locking here in the timer handler.

The timing for a missing MP_FAIL is not strict, so it doesn't seem 
important to handle it all in a low-level timer callback.


> +	if (subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		pr_debug("MP_FAIL is lost, reset the subflow");
> +		bh_lock_sock(ssk);
> +		mptcp_subflow_reset(ssk);
> +		bh_unlock_sock(ssk);
> +	}
> +	sock_put(sk);
> +}
> +
> +void mptcp_setup_mp_fail_timer(struct mptcp_sock *msk)
> +{
> +	struct sock *sk = (struct sock *)msk;
> +
> +	mptcp_data_lock(sk);
> +	/* re-use the csk retrans timer for MP_FAIL retrans */
> +	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
> +	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_mp_fail_timer, 0);
> +	__mptcp_set_timeout(sk, TCP_RTO_MAX);
> +	mptcp_reset_timer(sk);
> +	mptcp_data_unlock(sk);
> +}
> +
> bool mptcp_schedule_work(struct sock *sk)
> {
> 	if (inet_sk_state_load(sk) != TCP_CLOSE &&
> @@ -1428,6 +1481,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 	struct subflow_send_info send_info[SSK_MODE_MAX];
> 	struct mptcp_subflow_context *subflow;
> 	struct sock *sk = (struct sock *)msk;
> +	u8 mp_fail_response_expect = 0;
> 	u32 pace, burst, wmem;
> 	int i, nr_active = 0;
> 	struct sock *ssk;
> @@ -1442,11 +1496,15 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
> 	}
>
> +	if (mp_fail_response_expect_subflow(msk))
> +		mp_fail_response_expect = 1;

Using sk_timer as I mention above will also make it unnecessary to add 
this check and all the mp_fail_response_expect logic to this function.

- Mat

> +
> 	/* re-use last subflow, if the burst allow that */
> 	if (msk->last_snd && msk->snd_burst > 0 &&
> 	    sk_stream_memory_free(msk->last_snd) &&
> 	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
> -		mptcp_set_timeout(sk);
> +		if (!mp_fail_response_expect)
> +			mptcp_set_timeout(sk);
> 		return msk->last_snd;
> 	}
>
> @@ -1479,7 +1537,8 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 			send_info[subflow->backup].linger_time = linger_time;
> 		}
> 	}
> -	__mptcp_set_timeout(sk, tout);
> +	if (!mp_fail_response_expect)
> +		__mptcp_set_timeout(sk, tout);
>
> 	/* pick the best backup if no other subflow is active */
> 	if (!nr_active)
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
