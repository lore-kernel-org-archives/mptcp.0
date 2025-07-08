Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B85221D87
	for <mptcp@lists.linux.dev>; Tue,  8 Jul 2025 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990175; cv=none; b=HmAfVbN8qeyAF05UID2scI20Fi4qs58H5gup95oGtZb7bg8RG+bVlhqQFRNssd7FYERAEA1b0bMyoWkrFbqqpyknE86OzL+AFiX4HSQZRE7oq1bPyb5hefCEaxOl3EMn6fV2QgTt9yx8lKLHSdHiRl81wLUjMY+yG3UAOO0dk3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990175; c=relaxed/simple;
	bh=53B85yz4ahW6r1JG0ZP7lobr4uDpGw9zld+u44cyfWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gOOgBSb0SugtO7qP78VrP4womkhx5Dlb9jKXZgfkIi1IIqS1avue/xWXjVu4oke65JCac/riC4QWNOX1lnuwVfRiFcFtfYp28njhQdL8zkyn5S9u9rGhBEUXMyZELJdlES+xO2e/+iRVYQssAKm5uYoT563wNqd/MSU77yxbTXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byumOFfj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byumOFfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3134BC4CEEF;
	Tue,  8 Jul 2025 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990174;
	bh=53B85yz4ahW6r1JG0ZP7lobr4uDpGw9zld+u44cyfWY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=byumOFfj0wSPHtDZ1+0mU5pGmgVb7c61e2v0cP2jDu6ODsZzjbBw9b1q9Nm9FMqYX
	 u54j5mTtJDVY1fe6kbgLvL7Q3/Dff0OZlwXCcphisPYbSc+Um4YL6dQI/kX5re5CGb
	 J650ut6KYGVtinLDDdkIwZVAXq3nbbJacrFYPLC5LbuWBUsssLxksmY0vMF7JXMXZW
	 cPVdAyMTlvu9KUx6BZ6vwEm4xmajUT6Fm71nT6uaWDB3m/qX9gXWKwiVMb3j0Xj8+X
	 cnbQHl8hIzjU1tQdNQDB3W2AB/DrSBRrOuYVpqoXWA/l0gJjR4mGaWkQ1dwaZmY5gG
	 ViAMArdMqYrXg==
Message-ID: <a6b76e9d-b84f-428b-b0bc-bc9d9aa782f7@kernel.org>
Date: Tue, 8 Jul 2025 17:56:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 4/5] mptcp: track fallbacks accurately via
 mibs
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1751699999.git.pabeni@redhat.com>
 <5a78b3e0fc95d2f6356ff4754ec3bdf1dcf6b2cc.1751700000.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <5a78b3e0fc95d2f6356ff4754ec3bdf1dcf6b2cc.1751700000.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 05/07/2025 09:24, Paolo Abeni wrote:
> Add the mibs required to cover the few possible fallback causes still
> lacking suck info.
> 
> Move the relevant mib increment into the fallback helper, so that no
> eventual future fallback operation will miss a paired mib increment.
> 
> Additionally track failed fallback via its own mib.

Good idea!

> While at the above, rename an existing helper to reduce long lines
> problems all along.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> still a couple of long lines I could not trim

That's OK. My understanding is that we should try to have lines under 80
chars, but when this condition makes the code harder to read, it is fine
to go over.

> ---
>  net/mptcp/ctrl.c     |  4 ++--
>  net/mptcp/mib.c      |  5 +++++
>  net/mptcp/mib.h      |  7 +++++++
>  net/mptcp/options.c  |  2 +-
>  net/mptcp/protocol.c | 44 ++++++++++++++++++++++++++++++--------------
>  net/mptcp/protocol.h | 31 ++++++++-----------------------
>  net/mptcp/subflow.c  | 10 ++++------
>  7 files changed, 57 insertions(+), 46 deletions(-)
> 
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index d9290c5bb6c7..fed40dae5583 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -533,9 +533,9 @@ void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
>  	to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
>  
>  	if (timeouts == to_max || (timeouts < to_max && expired)) {
> -		MPTCP_INC_STATS(net, MPTCP_MIB_MPCAPABLEACTIVEDROP);
>  		subflow->mpc_drop = 1;
> -		mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
> +		mptcp_early_fallback(mptcp_sk(subflow->conn), subflow,
> +				     MPTCP_MIB_MPCAPABLEACTIVEDROP);
>  	}
>  }
>  
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 0c24545f0e8d..064f5eaf0595 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -80,6 +80,11 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
>  	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
>  	SNMP_MIB_ITEM("Blackhole", MPTCP_MIB_BLACKHOLE),
> +	SNMP_MIB_ITEM("DataFallback", MPTCP_MIB_DATA_FALLBACK),

Should it not be prefixed MPCapableFallback like others above?

Maybe: MPCapableFallbackData / MPTCP_MIB_MPCAPABLEDATAFALLBACK?

> +	SNMP_MIB_ITEM("MD5sumFallback", MPTCP_MIB_MD5SUM_FALLBACK),

For the name: is it limited to MD5Sum? Or any TCP AO?

> +	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSS_FALLBACK),
> +	SNMP_MIB_ITEM("SimultFallback", MPTCP_MIB_SIMULT_FALLBACK),
> +	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACK_FAILED),

Do you think it would be worth it to check in the selftests
(mptcp_join.sh?) if any of these counters are incremented when they
should not be?

>  	SNMP_MIB_SENTINEL
>  };
>  
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 250c6b77977e..99c8788694c3 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -81,6 +81,13 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
>  	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
>  	MPTCP_MIB_BLACKHOLE,		/* A blackhole has been detected */
> +	MPTCP_MIB_DATA_FALLBACK,	/* Missing DSS/MPC+data on first
> +					 * established packet
> +					 */
> +	MPTCP_MIB_MD5SUM_FALLBACK,	/* Conflicting TCP option enabled */
> +	MPTCP_MIB_DSS_FALLBACK,		/* Bad or missing DSS */
> +	MPTCP_MIB_SIMULT_FALLBACK,	/* Simultaneous connect */

Maybe clearer with CONNECT or CONN in the name?

Maybe: SimultConnectFallback / MPTCP_MIB_SIMULT_CONN_FALLBACK?

> +	MPTCP_MIB_FALLBACK_FAILED,	/* Can't fallback due to msk status */
>  	__MPTCP_MIB_MAX
>  };
>  
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 4680d980e605..c9e1f3ec3772 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -978,7 +978,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>  		if (subflow->mp_join)
>  			goto reset;
>  		subflow->mp_capable = 0;
> -		if (mptcp_do_fallback(ssk))
> +		if (mptcp_do_fallback(ssk, MPTCP_MIB_DATA_FALLBACK))
>  			goto reset;
>  		pr_fallback(msk);
>  		return false;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0dc55a17f274..5f99f02c827c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -67,6 +67,27 @@ static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
>  	return &inet_stream_ops;
>  }
>  
> +bool __mptcp_do_fallback(struct mptcp_sock *msk, int fb_mib)
> +{
> +	struct net *net = sock_net((struct sock *)msk);
> +
> +	if (__mptcp_check_fallback(msk))
> +		return true;
> +
> +	spin_lock_bh(&msk->fallback_lock);
> +	if (!msk->allow_infinite_fallback) {
> +		__MPTCP_INC_STATS(net, MPTCP_MIB_SIMULT_FALLBACK);

Is the name OK? To me, a counter with this name should be incremented
when __mptcp_check_fallback() returns true just above, no?

Here, we now try to do a fallback, but we cannot, a reset is probably
needed instead, but that's not because we try to do the same fallback in
parallel, no?

I guess you wanted to use MPTCP_MIB_FALLBACK_FAILED, no?

Anyway, even with 'fallback failed', because in the first patch, the
helper is now also used to check if a fallback can happen. It means that
here we can be in a "normal" situation where we just want to fallback if
we can. If not, that's not an error.

In other words, I don't think we can have a generic MIB here. If we do,
this counter will be incremented in parallel to one linked to a subflow
reset, e.g. MPTCP_MIB_DSSCORRUPTIONRESET. I wonder if (1) this helper
should not be renamed to avoid such confusion -- see patch 1 -- and if
(2) another argument should not be passed to increment another counter
linked to a subflow reset or an abort (MPTCP_MIB_FALLBACK_FAILED can be
passed if that's not normal). Or maybe clearer to add one new helper to
do a fallback or a reset + increment the right MIB counter depending on
the situation? (And another helper to do a fallback if possible, and if
not, only increment MPTCP_MIB_FALLBACK_FAILED?)

(also, detail: why not doing that after the spin_unlock?)

> +		spin_unlock_bh(&msk->fallback_lock);
> +		return false;
> +	}
> +
> +	msk->allow_subflows = false;
> +	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
> +	__MPTCP_INC_STATS(net, fb_mib);

(same here, why not doing that after the spin_unlock?)

> +	spin_unlock_bh(&msk->fallback_lock);
> +	return true;
> +}
> +
>  static int __mptcp_socket_create(struct mptcp_sock *msk)
>  {
>  	struct mptcp_subflow_context *subflow;
> @@ -560,10 +581,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
>  
>  static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
>  {
> -	if (mptcp_do_fallback(ssk)) {
> -		MPTCP_INC_STATS(sock_net(ssk),
> -				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
> -	} else {
> +	if (!mptcp_do_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
>  		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
>  		mptcp_subflow_reset(ssk);
>  	}
> @@ -1142,12 +1160,11 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
>  	mpext->infinite_map = 1;
>  	mpext->data_len = 0;
>  
> -	if (!mptcp_do_fallback(ssk)) {
> +	if (!mptcp_do_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
>  		mptcp_subflow_reset(ssk);
>  		return;
>  	}
>  
> -	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
>  	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
>  	pr_fallback(msk);
>  }
> @@ -3717,16 +3734,15 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
>  	 * TCP option space.
>  	 */
>  	if (rcu_access_pointer(tcp_sk(ssk)->md5sig_info))
> -		mptcp_subflow_early_fallback(msk, subflow);
> +		mptcp_early_fallback(msk, subflow, MPTCP_MIB_MD5SUM_FALLBACK);
>  #endif
>  	if (subflow->request_mptcp) {
> -		if (mptcp_active_should_disable(sk)) {
> -			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVEDISABLED);
> -			mptcp_subflow_early_fallback(msk, subflow);
> -		} else if (mptcp_token_new_connect(ssk) < 0) {
> -			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
> -			mptcp_subflow_early_fallback(msk, subflow);
> -		}
> +		if (mptcp_active_should_disable(sk))
> +			mptcp_early_fallback(msk, subflow,
> +					    MPTCP_MIB_MPCAPABLEACTIVEDISABLED);
> +		else if (mptcp_token_new_connect(ssk) < 0)
> +			mptcp_early_fallback(msk, subflow,
> +					     MPTCP_MIB_TOKENFALLBACKINIT);
>  	}
>  
>  	WRITE_ONCE(msk->write_seq, subflow->idsn);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 34c0863f1eae..ceb2f2ba2cc7 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1220,24 +1220,6 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
>  	return __mptcp_check_fallback(msk);
>  }
>  
> -static inline bool __mptcp_do_fallback(struct mptcp_sock *msk)
> -{
> -	if (__mptcp_check_fallback(msk)) {
> -		pr_debug("TCP fallback already done (msk=%p)\n", msk);
> -		return true;
> -	}
> -	spin_lock_bh(&msk->fallback_lock);
> -	if (!msk->allow_infinite_fallback) {
> -		spin_unlock_bh(&msk->fallback_lock);
> -		return false;
> -	}
> -
> -	msk->allow_subflows = false;
> -	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
> -	spin_unlock_bh(&msk->fallback_lock);
> -	return true;
> -}
> -
>  static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
>  {
>  	struct sock *ssk = READ_ONCE(msk->first);
> @@ -1247,14 +1229,16 @@ static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
>  			TCPF_SYN_RECV | TCPF_LISTEN));
>  }
>  
> -static inline bool mptcp_do_fallback(struct sock *ssk)
> +bool __mptcp_do_fallback(struct mptcp_sock *msk, int fb_mib);
> +
> +static inline bool mptcp_do_fallback(struct sock *ssk, int fb_mib)
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>  	struct sock *sk = subflow->conn;
>  	struct mptcp_sock *msk;
>  
>  	msk = mptcp_sk(sk);
> -	if (!__mptcp_do_fallback(msk))
> +	if (!__mptcp_do_fallback(msk, fb_mib))
>  		return false;
>  	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
>  		gfp_t saved_allocation = ssk->sk_allocation;
> @@ -1272,12 +1256,13 @@ static inline bool mptcp_do_fallback(struct sock *ssk)
>  
>  #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
>  
> -static inline void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
> -						struct mptcp_subflow_context *subflow)
> +static inline void mptcp_early_fallback(struct mptcp_sock *msk,
> +					struct mptcp_subflow_context *subflow,
> +					int fb_mib)
>  {
>  	pr_fallback(msk);
>  	subflow->request_mptcp = 0;
> -	__mptcp_do_fallback(msk);
> +	__mptcp_do_fallback(msk, fb_mib);
>  }
>  
>  static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 11c5b042c2e1..e140d032eb3e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -544,11 +544,10 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
>  	mptcp_get_options(skb, &mp_opt);
>  	if (subflow->request_mptcp) {
>  		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) {
> -			if (!mptcp_do_fallback(sk))
> +			if (!mptcp_do_fallback(sk,
> +					    MPTCP_MIB_MPCAPABLEACTIVEFALLBACK))
>  				goto do_reset;
>  
> -			MPTCP_INC_STATS(sock_net(sk),
> -					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
>  			pr_fallback(msk);
>  			goto fallback;
>  		}
> @@ -1406,7 +1405,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  			return true;
>  		}
>  
> -		if (!mptcp_do_fallback(ssk)) {
> +		if (!mptcp_do_fallback(ssk, MPTCP_MIB_DSS_FALLBACK)) {
>  			/* fatal protocol error, close the socket.
>  			 * subflow_error_report() will introduce the appropriate barriers
>  			 */
> @@ -1424,7 +1423,6 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  			WRITE_ONCE(subflow->data_avail, false);
>  			return false;
>  		}
> -

Maybe better to remove this line in patch 1/5?

>  	}
>  
>  	skb = skb_peek(&ssk->sk_receive_queue);
> @@ -1860,7 +1858,7 @@ static void subflow_state_change(struct sock *sk)
>  
>  	msk = mptcp_sk(parent);
>  	if (subflow_simultaneous_connect(sk)) {
> -		mptcp_do_fallback(sk);
> +		mptcp_do_fallback(sk, MPTCP_MIB_SIMULT_FALLBACK);
>  		pr_fallback(msk);
>  		subflow->conn_finished = 1;
>  		mptcp_propagate_state(parent, sk, subflow, NULL);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

