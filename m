Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5021C9E4
	for <mptcp@lists.linux.dev>; Tue,  8 Jul 2025 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986455; cv=none; b=N13D+qhprJgWuFPLdqgmXma8bqYPOLfkjZj0hY9vR252rcLM8ugtfxwujFGdX8o63KHw7kzkS3KSFEkzcalM2vvzDKCNnH6t1PUv8XKL7Hsyh6esNqnxPIYFpY4jfCTs075T9HmqiIfaUvo2CB6rbri9vnSdjlI1Yy99EvZcegw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986455; c=relaxed/simple;
	bh=iVPuqZWvSObJSRq2LLsHYNQ/AIueCfCv+cWNkMrNHT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=gbzApqnGifXtoTWumVncXDbPDTrkCZBaFCLqxUZJ7J7pwKh1MaAYG4xeRj/BuxibVlsgNk/IKmBB86hh2d6/KtNK2IbTLZPqsLRe0Rp8JKdQ+yyMMTv0An7z+NcH7SwRcCbzEesAIV0iu60m7n/SziqvRMpHT7mK5Qd08w+/cc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOkJvD4U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOkJvD4U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBFBC4CEED;
	Tue,  8 Jul 2025 14:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751986455;
	bh=iVPuqZWvSObJSRq2LLsHYNQ/AIueCfCv+cWNkMrNHT4=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=EOkJvD4UJtOGpge17rggk1Mb3wrbcLK9ypcPpBft3C++P89az9LbbsL6DjNJehgM3
	 JM+P0GJHSJxa62gF7MTiXFmskp5aKFguCahNuAB447DmHTfdrR5LB36vKgiIuTeshn
	 99DiwLYQezhpsYEIqLyEdIqHj5+lwL4GX6RHa6hG1++ZOEAlnjvLmwPWAkzE+U6Js2
	 hoT/i2oC5nG5R7By/h46A15quQiP1UcdMCxhebaR4XBs9ebITptrMxjEz0JwvmK3Ro
	 eM/YksgnZmQFnrz0YPNBSSY+H0OHuNK3sYU5q0s7hYo5Jw+Y6S3+5zlrzyLiAdusWi
	 6WfagU4+tE3Zg==
Message-ID: <af295f45-be11-48e2-94c3-fdb99f7153cb@kernel.org>
Date: Tue, 8 Jul 2025 16:54:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 1/5] mptcp: make fallback action and fallback
 decision atomic
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1751699999.git.pabeni@redhat.com>
 <7220b3c204d75d50e480f6045295a825ae80fd38.1751699999.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Cc: mptcp@lists.linux.dev
In-Reply-To: <7220b3c204d75d50e480f6045295a825ae80fd38.1751699999.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 05/07/2025 09:24, Paolo Abeni wrote:
> Syzkaller reported the following splat:

Thank you for working on that!

(...)
> Since we need to track the 'fallback is possible' condition and the
> fallback status separately, there are a few possible races open between
> the check and the actual fallback action.
> 
> Add a spinlock to protect the fallback related information and use
> it close all the possible related races. While at it also remove the
> too-early clearing of allow_infinite_fallback in __mptcp_subflow_connect():
> the field will be correctly cleared by subflow_finish_connect() if/
> when the connection will complete successfully.

Just to be sure, will we correctly handle the case when:
- a SYN + MP_JOIN is sent
- an issue is detected, a fallback is done
- a SYN + ACK + MP_JOIN is received (or later on in the join process).
> If fallback is not possible, as per RFC, reset the current subflow.
> 
> Reported by: Matthieu Baerts <matttbe@kernel.org>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/570
> Reported-by: syzbot+5cf807c20386d699b524@syzkaller.appspotmail.com
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/555
> Fixes: 0530020a7c8f ("mptcp: track and update contiguous data status")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>   - remove unneeded and racing allow_infinite_fallback in
>     __mptcp_subflow_connect()
>   - really close race in subflow_check_data_avail()
> 
> Sharing earlier to feed syzkaller.
> Hopefully a follow-up on mptcp-net-next will cleanup a bit the fallback
> handling, I tried to minimize the delta for backport's sake

I fed my 4 syzkaller instances 1 day and 6 hours ago, and everything
look good so far. But please note that (1) it was not easy for them to
reproduce the issue, and (2) you removed the warning that was triggering
the splat :)
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 56fd7bcb786c..4680d980e605 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -978,8 +978,9 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>  		if (subflow->mp_join)
>  			goto reset;
>  		subflow->mp_capable = 0;
> +		if (mptcp_do_fallback(ssk))

It looks strange: in case of success, we reset?

Not that the selftests don't validate this branch:

 https://ci-results.mptcp.dev/lcov/export/mptcp/options.c.gcov.html#L977

(also, I wonder if we should not have a MIB counter here)

> +			goto reset;
>  		pr_fallback(msk);
> -		mptcp_do_fallback(ssk);
>  		return false;
>  	}
>  
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1de42dc4e8ea..38bb11865b50 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -560,10 +560,9 @@ static bool mptcp_check_data_fin(struct sock *sk)
>  
>  static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
>  {
> -	if (READ_ONCE(msk->allow_infinite_fallback)) {
> +	if (mptcp_do_fallback(ssk)) {
>  		MPTCP_INC_STATS(sock_net(ssk),
>  				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
> -		mptcp_do_fallback(ssk);
>  	} else {
>  		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
>  		mptcp_subflow_reset(ssk);
> @@ -803,6 +802,14 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
>  	if (sk->sk_state != TCP_ESTABLISHED)
>  		return false;
>  
> +	spin_lock_bh(&msk->fallback_lock);
> +	if (__mptcp_check_fallback(msk)) {
> +		spin_unlock_bh(&msk->fallback_lock);
> +		return false;

(I wonder if we should not have a MIB counter here as well)

> +	}
> +	mptcp_subflow_joined(msk, ssk);
> +	spin_unlock_bh(&msk->fallback_lock);
> +
>  	/* attach to msk socket only after we are sure we will deal with it
>  	 * at close time
>  	 */
> @@ -811,7 +818,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
>  
>  	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
>  	mptcp_sockopt_sync_locked(msk, ssk);
> -	mptcp_subflow_joined(msk, ssk);
>  	mptcp_stop_tout_timer(sk);
>  	__mptcp_propagate_sndbuf(sk, ssk);
>  	return true;
> @@ -1136,10 +1142,14 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
>  	mpext->infinite_map = 1;
>  	mpext->data_len = 0;
>  
> +	if (!mptcp_do_fallback(ssk)) {
> +		mptcp_subflow_reset(ssk);

(I wonder if we should not have a MIB counter here as well)

> +		return;
> +	}
> +
>  	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
>  	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
>  	pr_fallback(msk);
> -	mptcp_do_fallback(ssk);
>  }
>  
>  #define MPTCP_MAX_GSO_SIZE (GSO_LEGACY_MAX_SIZE - (MAX_TCP_HEADER + 1))
> @@ -2543,9 +2553,9 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
>  
>  static void __mptcp_retrans(struct sock *sk)
>  {
> +	struct mptcp_sendmsg_info info = { .data_lock_held = true, };

Just to be sure: is this modification here linked to the rest?

>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct mptcp_subflow_context *subflow;
> -	struct mptcp_sendmsg_info info = {};
>  	struct mptcp_data_frag *dfrag;
>  	struct sock *ssk;
>  	int ret, err;
> @@ -2590,6 +2600,18 @@ static void __mptcp_retrans(struct sock *sk)
>  			info.sent = 0;
>  			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
>  								    dfrag->already_sent;
> +
> +			/*
> +			 * make the whole retrans decision, xmit, disallow
> +			 * fallback atomic
> +			 */
> +			spin_lock_bh(&msk->fallback_lock);
> +			if (__mptcp_check_fallback(msk)) {
> +				spin_unlock_bh(&msk->fallback_lock);
> +				release_sock(ssk);
> +				return;
> +			}
> +
>  			while (info.sent < info.limit) {
>  				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
>  				if (ret <= 0)
> @@ -2605,6 +2627,7 @@ static void __mptcp_retrans(struct sock *sk)
>  					 info.size_goal);
>  				WRITE_ONCE(msk->allow_infinite_fallback, false);
>  			}
> +			spin_unlock_bh(&msk->fallback_lock);
>  
>  			release_sock(ssk);
>  		}
> @@ -2738,6 +2761,7 @@ static void __mptcp_init_sock(struct sock *sk)
>  	msk->last_ack_recv = tcp_jiffies32;
>  
>  	mptcp_pm_data_init(msk);
> +	spin_lock_init(&msk->fallback_lock);
>  
>  	/* re-use the csk retrans timer for MPTCP-level retrans */
>  	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
> @@ -3524,7 +3548,13 @@ bool mptcp_finish_join(struct sock *ssk)
>  
>  	/* active subflow, already present inside the conn_list */
>  	if (!list_empty(&subflow->node)) {
> +		spin_lock_bh(&msk->fallback_lock);
> +		if (__mptcp_check_fallback(msk)) {
> +			spin_unlock_bh(&msk->fallback_lock);
> +			return false;
> +		}
>  		mptcp_subflow_joined(msk, ssk);
> +		spin_unlock_bh(&msk->fallback_lock);

Small detail: why not modifying mptcp_subflow_joined() to have the
fallback check there? (+ rename the function name?)
If it returns false, we can abort. (Same above where
mptcp_subflow_joined is used)

>  		mptcp_propagate_sndbuf(parent, ssk);
>  		return true;
>  	}
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index e36ae88b10ad..52c9175c7e49 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -352,6 +352,7 @@ struct mptcp_sock {
>  	u32		subflow_id;
>  	u32		setsockopt_seq;
>  	char		ca_name[TCP_CA_NAME_MAX];
> +	spinlock_t	fallback_lock;	/* protects fallback && allow_infinite_fallback */
>  };
>  
>  #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
> @@ -1214,15 +1215,21 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
>  	return __mptcp_check_fallback(msk);
>  }
>  
> -static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
> +static inline bool __mptcp_do_fallback(struct mptcp_sock *msk)

I wonder if this function should not be renamed, to help with the
backports, but also because we don't do a fallback if we cannot do it:
it is more "try to fallback, but check before if it is possible" :)
Same for mptcp_do_fallback(). WDYT?

>  {
>  	if (__mptcp_check_fallback(msk)) {
>  		pr_debug("TCP fallback already done (msk=%p)\n", msk);
> -		return;
> +		return true;
>  	}
> -	if (WARN_ON_ONCE(!READ_ONCE(msk->allow_infinite_fallback)))
> -		return;
> +	spin_lock_bh(&msk->fallback_lock);
> +	if (!msk->allow_infinite_fallback) {
> +		spin_unlock_bh(&msk->fallback_lock);
> +		return false;
> +	}
> +
>  	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
> +	spin_unlock_bh(&msk->fallback_lock);
> +	return true;
>  }
>  
>  static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
> @@ -1234,14 +1241,15 @@ static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
>  			TCPF_SYN_RECV | TCPF_LISTEN));
>  }
>  
> -static inline void mptcp_do_fallback(struct sock *ssk)
> +static inline bool mptcp_do_fallback(struct sock *ssk)
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>  	struct sock *sk = subflow->conn;
>  	struct mptcp_sock *msk;
>  
>  	msk = mptcp_sk(sk);
> -	__mptcp_do_fallback(msk);
> +	if (!__mptcp_do_fallback(msk))
> +		return false;
>  	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
>  		gfp_t saved_allocation = ssk->sk_allocation;
>  
> @@ -1253,6 +1261,7 @@ static inline void mptcp_do_fallback(struct sock *ssk)
>  		tcp_shutdown(ssk, SEND_SHUTDOWN);
>  		ssk->sk_allocation = saved_allocation;
>  	}
> +	return true;
>  }
>  
>  #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 15613d691bfe..433c0b25dbc1 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -544,9 +544,11 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
>  	mptcp_get_options(skb, &mp_opt);
>  	if (subflow->request_mptcp) {
>  		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) {
> +			if (!mptcp_do_fallback(sk))
> +				goto do_reset;

(I wonder if we should not have a MIB counter here as well)

> +
>  			MPTCP_INC_STATS(sock_net(sk),
>  					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
> -			mptcp_do_fallback(sk);
>  			pr_fallback(msk);
>  			goto fallback;
>  		}
> @@ -1395,7 +1397,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  			return true;
>  		}
>  
> -		if (!READ_ONCE(msk->allow_infinite_fallback)) {
> +		if (!mptcp_do_fallback(ssk)) {
>  			/* fatal protocol error, close the socket.
>  			 * subflow_error_report() will introduce the appropriate barriers
>  			 */
> @@ -1414,7 +1416,6 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  			return false;
>  		}
>  
> -		mptcp_do_fallback(ssk);
>  	}
>  
>  	skb = skb_peek(&ssk->sk_receive_queue);
> @@ -1679,7 +1680,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
>  	/* discard the subflow socket */
>  	mptcp_sock_graft(ssk, sk->sk_socket);
>  	iput(SOCK_INODE(sf));
> -	WRITE_ONCE(msk->allow_infinite_fallback, false);
>  	mptcp_stop_tout_timer(sk);
>  	return 0;
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

