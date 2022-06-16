Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FEB7E
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 00:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655341192; x=1686877192;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7xvigHFoX5Zvz7XYilExrXkyAQGUKm6Knlk8yO3kl8A=;
  b=d6GxMMeUQD+WVHXCPAKb++/AJHsuMgbpOIklnOUCNeE/es1iikt6ItZb
   ZxODahRIXjuMF91qiwEE80v0zpx5yQ6PAbst8O0A89pRkW30wAZ8XGmi6
   QlWgVr7ug9kZKomSk7VZ0sR9DOsJ2cnjpT9OoAWhHjblYHIfSUEU3oVp4
   7fzjsH4yHwddm4xENfINI4A+4RMaHeSogA7jHOpQ3rb8400i9ELWhD23m
   Yjx8lXWpXf2X6gxBS6HTKuvgsDgVE3eF4g8wjC78Fyjh5XsfOWuWH+VVg
   ZSmQez/ekuXa1c0G5CMeXtGC6LA3kJM9FNP0WWem61F87TopTgOcTfGqr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="277932201"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="277932201"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 17:59:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="618698558"
Received: from zabbas-mobl.amr.corp.intel.com ([10.212.140.246])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 17:59:51 -0700
Date: Wed, 15 Jun 2022 17:59:51 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2 3/6] Squash-to: "mptcp: invoke MP_FAIL
 response when needed"
In-Reply-To: <1deca06703f8666dc199b76f39cd881733741666.1655324843.git.pabeni@redhat.com>
Message-ID: <58c2377-cc90-7f55-9aa5-1a9d6578fd8a@linux.intel.com>
References: <cover.1655324843.git.pabeni@redhat.com> <1deca06703f8666dc199b76f39cd881733741666.1655324843.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 15 Jun 2022, Paolo Abeni wrote:

> This tries to address a few issues outstanding in the mentioned
> patch:
> - we explicitly need to reset the timeout timer for mp_fail's sake
> - we need to explicitly generate a tcp ack for mp_fail, otherwise
>  there are no guarantees for suck option being sent out
> - the timeout timer needs handling need some caring, as it's still
>  shared between mp_fail and msk socket timeout.
> - we can re-use msk->first for msk->fail_ssk, as only the first/mpc
>  subflow can fail without reset. That additionally avoid the need
>  to clear fail_ssk on the relevant subflow close.
> - fail_tout would need some additional annotation. Just to be on the
>  safe side move its manipulaiton under the ssk socket lock.
>
> Last 2 paragraph of the squash to commit should be replaced with:
>
> """
> It leverages the fact that only the MPC/first subflow can gracefully
> fail to avoid unneeded subflows traversal: the failing subflow can
> be only msk->first.
>
> A new 'fail_tout' field is added to the subflow context to record the
> MP_FAIL response timeout and use such field to reliably share the
> timeout timer between the MP_FAIL event and the MPTCP socket close timeout.
>
> Finally, a new ack is generated to send out MP_FAIL notification as soon
> as we hit the relevant condition, instead of waiting a possibly unbound
> time for the next data packet.
> """
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/pm.c       |  4 +++-
> net/mptcp/protocol.c | 54 ++++++++++++++++++++++++++++++++++++--------
> net/mptcp/protocol.h |  4 ++--
> net/mptcp/subflow.c  | 24 ++++++++++++++++++--
> 4 files changed, 72 insertions(+), 14 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 3c7f07bb124e..45e2a48397b9 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -305,13 +305,15 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> 	if (!READ_ONCE(msk->allow_infinite_fallback))
> 		return;
>
> -	if (!msk->fail_ssk) {
> +	if (!subflow->fail_tout) {
> 		pr_debug("send MP_FAIL response and infinite map");
>
> 		subflow->send_mp_fail = 1;
> 		subflow->send_infinite_map = 1;
> +		tcp_send_ack(sk);
> 	} else {
> 		pr_debug("MP_FAIL response received");
> +		WRITE_ONCE(subflow->fail_tout, 0);
> 	}
> }
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a0f9f3831509..50026b8da625 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -500,7 +500,7 @@ static void mptcp_set_timeout(struct sock *sk)
> 	__mptcp_set_timeout(sk, tout);
> }
>
> -static bool tcp_can_send_ack(const struct sock *ssk)
> +static inline bool tcp_can_send_ack(const struct sock *ssk)
> {
> 	return !((1 << inet_sk_state_load(ssk)) &
> 	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
> @@ -2490,24 +2490,56 @@ static void __mptcp_retrans(struct sock *sk)
> 		mptcp_reset_timer(sk);
> }
>
> +/* schedule the timeout timer for the nearest relevant event: either
> + * close timeout or mp_fail timeout. Both of them could be not
> + * scheduled yet
> + */
> +void mptcp_reset_timeout(struct mptcp_sock *msk, unsigned long fail_tout)
> +{
> +	struct sock *sk = (struct sock *)msk;
> +	unsigned long timeout, close_timeout;
> +
> +	if (!fail_tout && !sock_flag(sk, SOCK_DEAD))
> +		return;
> +
> +	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
> +
> +	/* the following is basically time_min(close_timeout, fail_tout) */
> +	if (!fail_tout)
> +		timeout = close_timeout;
> +	else if (!sock_flag(sk, SOCK_DEAD))
> +		timeout = fail_tout;
> +	else if (time_after(close_timeout, fail_tout))
> +		timeout = fail_tout;
> +	else
> +		timeout = close_timeout;
> +
> +	sk_reset_timer(sk, &sk->sk_timer, timeout);
> +}

Hi Paolo -

The above function seems more complex than needed. If mptcp_close() has 
been called, the fail timeout should be considered canceled and the 
"close" has exclusive use of sk_timer. subflow->fail_tout can be set to 0 
and sk_timer can be set only based on TCP_TIMEWAIT_LEN.

TCP_RTO_MAX for the MP_FAIL timeout was kind of arbitrary - the spec 
doesn't say what exactly to do. We didn't want the connection to be in the 
"unacknowledged" MP_FAIL state forever, but also didn't want to give up 
too fast.

Given that, do you think the complexity is justified to possibly reset the 
subflow earlier in this "unacknowledged MP_FAIL followed by a close" 
scenario?


> +
> static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
> {
> -	struct sock *ssk = msk->fail_ssk;
> +	struct sock *ssk = msk->first;
> 	bool slow;
>
> +	if (!ssk)
> +		return;
> +
> 	pr_debug("MP_FAIL doesn't respond, reset the subflow");
>
> 	slow = lock_sock_fast(ssk);
> 	mptcp_subflow_reset(ssk);
> +	WRITE_ONCE(mptcp_subflow_ctx(ssk)->fail_tout, 0);
> 	unlock_sock_fast(ssk, slow);
>
> -	msk->fail_ssk = NULL;
> +	mptcp_reset_timeout(msk, 0);
> }
>
> static void mptcp_worker(struct work_struct *work)
> {
> 	struct mptcp_sock *msk = container_of(work, struct mptcp_sock, work);
> 	struct sock *sk = &msk->sk.icsk_inet.sk;
> +	unsigned long fail_tout;
> 	int state;
>
> 	lock_sock(sk);
> @@ -2544,7 +2576,8 @@ static void mptcp_worker(struct work_struct *work)
> 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
> 		__mptcp_retrans(sk);
>
> -	if (msk->fail_ssk && time_after(jiffies, msk->fail_tout))
> +	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
> +	if (fail_tout && time_after(jiffies, fail_tout))
> 		mptcp_mp_fail_no_response(msk);
>
> unlock:
> @@ -2572,8 +2605,6 @@ static int __mptcp_init_sock(struct sock *sk)
> 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
> 	WRITE_ONCE(msk->allow_infinite_fallback, true);
> 	msk->recovery = false;
> -	msk->fail_ssk = NULL;
> -	msk->fail_tout = 0;
>
> 	mptcp_pm_data_init(msk);
>
> @@ -2804,7 +2835,9 @@ static void __mptcp_destroy_sock(struct sock *sk)
> static void mptcp_close(struct sock *sk, long timeout)
> {
> 	struct mptcp_subflow_context *subflow;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> 	bool do_cancel_work = false;
> +	unsigned long fail_tout = 0;
>
> 	lock_sock(sk);
> 	sk->sk_shutdown = SHUTDOWN_MASK;
> @@ -2822,10 +2855,13 @@ static void mptcp_close(struct sock *sk, long timeout)
> cleanup:
> 	/* orphan all the subflows */
> 	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
> -	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
> +	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> 		bool slow = lock_sock_fast_nested(ssk);
>
> +		if (ssk == msk->first)
> +			fail_tout = subflow->fail_tout;
> +
> 		sock_orphan(ssk);
> 		unlock_sock_fast(ssk, slow);
> 	}
> @@ -2834,13 +2870,13 @@ static void mptcp_close(struct sock *sk, long timeout)
> 	sock_hold(sk);
> 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
> 	if (mptcp_sk(sk)->token)
> -		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
> +		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
>
> 	if (sk->sk_state == TCP_CLOSE) {
> 		__mptcp_destroy_sock(sk);
> 		do_cancel_work = true;
> 	} else {
> -		sk_reset_timer(sk, &sk->sk_timer, jiffies + TCP_TIMEWAIT_LEN);
> +		mptcp_reset_timeout(msk, fail_tout);
> 	}
> 	release_sock(sk);
> 	if (do_cancel_work)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index bef7dea9f358..077a717799a0 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -306,8 +306,6 @@ struct mptcp_sock {
>
> 	u32 setsockopt_seq;
> 	char		ca_name[TCP_CA_NAME_MAX];
> -	struct sock	*fail_ssk;
> -	unsigned long	fail_tout;
> };
>
> #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
> @@ -484,6 +482,7 @@ struct mptcp_subflow_context {
> 	u8	stale_count;
>
> 	long	delegated_status;
> +	unsigned long	fail_tout;
>
> 	);
>
> @@ -677,6 +676,7 @@ void mptcp_get_options(const struct sk_buff *skb,
>
> void mptcp_finish_connect(struct sock *sk);
> void __mptcp_set_connected(struct sock *sk);
> +void mptcp_reset_timeout(struct mptcp_sock *msk, unsigned long fail_tout);
> static inline bool mptcp_is_fully_established(struct sock *sk)
> {
> 	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 98b12a9c4eb5..040901c1f40c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1158,6 +1158,27 @@ static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
> 		return !subflow->fully_established;
> }
>
> +static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	unsigned long fail_tout;
> +
> +	/* grecefull failure can happen only on the MPC subflow */
> +	if (WARN_ON_ONCE(ssk != READ_ONCE(msk->first)))
> +		return;
> +
> +	/* we don't need extreme accuracy here, use a zero fail_tout as special
> +	 * value meaning no fail timeout at all;
> +	 */
> +	fail_tout = jiffies + TCP_RTO_MAX;
> +	if (!fail_tout)
> +		fail_tout = 1;

Ah, I was wondering how jiffies wrap-around and the '0' special value were 
handled! Good idea.

> +	WRITE_ONCE(subflow->fail_tout, fail_tout);
> +	tcp_send_ack(ssk);
> +
> +	mptcp_reset_timeout(msk, subflow->fail_tout);
> +}
> +
> static bool subflow_check_data_avail(struct sock *ssk)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> @@ -1233,8 +1254,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 				while ((skb = skb_peek(&ssk->sk_receive_queue)))
> 					sk_eat_skb(ssk, skb);
> 			} else {
> -				msk->fail_ssk = ssk;
> -				msk->fail_tout = jiffies + TCP_RTO_MAX;
> +				mptcp_subflow_fail(msk, ssk);
> 			}
> 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
> 			return true;
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
