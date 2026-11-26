Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795651939;
	b=h52qnE6Gq5W2tqSNcm9TSbwldztRVtf7Cwh2jut2tPd8gMmMkdtvg8BfUVVCEYR051AU
	 RQdQ6Ehg+jxl8faFNsjDsXwI/9+T+TlLFuCRWQbj3EDBpxYLoOAmb9EgJH61qa83Y/IFm
	 xtXuB6Bs+M76xC82SV2BlkiXG3zA4WuvVeoP8ImNxi7sgHSx734pJI097J90CdR4ncC3z
	 GDUUP3+vQxlHECeSM++awC32e/zo+NEzY2AQofE2OXCCUYZULNrDuESYd/jsPmQWlsPPv
	 D3JhWHOe194gyVl5vSFeu/p3YRthf27ZwRS1CaH78E6TPNzxmRd2rOW9gFQlmnOOhtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795651939;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8m7u2E8o1BxsHptW/XAQO5bZWgJgsJyQcHFpELAdf7I=;
	b=ST91XkRhmlahEChm7ob1g+/ic71pmYODN9iRTrdDb3Ge0Gno+ItlILDcV/2dGFywKaUA
	 p1I5Abe+5sjkINZYFyDSFM/lAjP6fdm2Zsaj9Rn+SSFt7aE03SasI/FA/7v/mgRs3NPaZ
	 6ar808FKesTt0PaUB37RfEop85DgPme9mKDYxI4MpJFbBABtcy5hPdctfMOf6I188Ry4k
	 wK/wuJ8L5QZlgAGY/d7fGayO3bH4Qbl6wO8YB++ZSkqTTRU23w/FjokWAfQ94oA9K20I7
	 lp3eGSGWNZrsvgvR/UHjS0uJpNstAWN9u7Xh1Yv7y6avlOJPYUg57PmnSLyAKN+kcEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBBdtqGq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47168606A321
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 00:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBBdtqGq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC201F000C0;
	Thu, 26 Nov 2026 00:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795651938;
	bh=8m7u2E8o1BxsHptW/XAQO5bZWgJgsJyQcHFpELAdf7I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hBBdtqGqRpiJgohhhO8ETkldReZyNsbaHUq72wvFrk0QQjJwjEmKVMMfNonjs+xgP
	 3b9xluYxQBXKehmi0B/weWZ5gTnauP3KDFJBcdharp6SQrn9h7yMuRwykQkEOTB3rt
	 c0JMfNlAi3xIQYpd03f+9xQidcIWzGNGAYV3gFt2k8HiwPBE4f8F2FurRCCQW1a1CP
	 fuyOlPVsSNyJRvuF/xZGo2fHkSYxPB6rSKY9HyJ56mpMY0ibUz1fzp6AX2wREeQCmg
	 Wesj+A/10+E86TeRsZTDKHZB7VorAOUUb3sPeM38/mHPLfOU/+EkaEjGTJ8XhcuOCb
	 QfnpYvERjHYOg==
Subject: Re: [PATCH mptcp-next v8 1/2] mptcp: sched: add subflow avoid flag
 for BPF schedulers
From: netdev-bot+sashiko@kernel.org
To: kalpan.jani@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, shardul.b@mpiricsoftware.com, janak@mpiric.us,
 kalpanjani009@gmail.com, pabeni@redhat.com, kuba@kernel.org
Date: Thu, 26 Nov 2026 00:12:17 +0000
Message-ID: <179565193796.3133.5945806971196572908@kernel.org>
In-Reply-To: <20261124102214.3930527-2-kalpan.jani@mpiricsoftware.com>
References: <20261124102214.3930527-2-kalpan.jani@mpiricsoftware.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] A BPF struct_ops scheduler can store a value other than 0 or
  1 in the bool field subflow->avoid.
- [Medium] The core enforcement of `avoid` can throw away a usable BPF
  selection and send or retransmit nothing.
- [Low] The patch changes the result and scheduled-flag semantics of
  mptcp_sched_get_send() and mptcp_sched_get_retrans() for every…

--

mptcp: sched: add subflow avoid flag for BPF schedulers

This adds an "avoid" bool to mptcp_subflow_context. BPF struct_ops
schedulers set it through a new mptcp_subflow_set_avoid() kfunc, and it
is exported through MPTCP diag. The default send and retransmit
selectors now prefer non-avoided subflows, and mptcp_sched_get_send() /
mptcp_sched_get_retrans() either drop avoided selections or fall back
to the default selector when only avoided subflows are scheduled.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d64e04245963c..44a727236d432 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1639,26 +1639,30 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
>   */
>  struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  {
> -	struct subflow_send_info send_info[SSK_MODE_MAX];
> +	struct subflow_send_info send_info[SSK_MODE_MAX][2];
>  	struct mptcp_subflow_context *subflow;

[ ... ]

>  	mptcp_for_each_subflow(msk, subflow) {
>  		bool backup = subflow->backup || subflow->request_bkup;
> +		bool avoid = READ_ONCE(subflow->avoid);
> +		int mode = backup ? SSK_MODE_BACKUP : SSK_MODE_ACTIVE;

[ ... ]

> @@ -1673,17 +1677,29 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  				continue;
>  		}
>  
> -		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
> -		if (linger_time < send_info[backup].linger_time) {
> -			send_info[backup].ssk = ssk;
> -			send_info[backup].linger_time = linger_time;
> +		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32,
> +				      pace);
> +		if (linger_time < send_info[mode][avoid].linger_time) {
> +			send_info[mode][avoid].ssk = ssk;
> +			send_info[mode][avoid].linger_time = linger_time;

[Severity: Critical]
Can subflow->avoid hold a value other than 0 or 1 here?

Its only writer is the new kfunc:

net/mptcp/sched.c:mptcp_subflow_set_avoid() {
	WRITE_ONCE(subflow->avoid, avoid);
}

The verifier treats the bool argument as a plain scalar.
check_func_args() does no range check for ARG_SCALAR. The x86-64 JIT
passes the full BPF R2 in RSI. The callee assumes a _Bool argument is
already 0 or 1, so it stores the low byte unchanged.

libbpf also treats integer types as compatible for ksym externs. A
struct_ops scheduler could declare the extern with a __u64 parameter and
call mptcp_subflow_set_avoid(subflow, 0xff).

In that case, would send_info[mode][avoid] be indexed with a value up to
255? That would read and write .ssk and .linger_time on the stack, well
past the end of the 2x2 array.

The same applies to mptcp_subflow_get_retrans(). There a struct sock
pointer would be written past the end of the 2-element pick[] and
backup[] arrays:

	if (!pick[avoid])
		pick[avoid] = ssk;

Could the kfunc take a u32 or int parameter and store !!avoid?
Alternatively, the users could index with READ_ONCE(subflow->avoid) ?
1 : 0.

[ ... ]

> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 1e59072d478c9..822904fa939a7 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c

[ ... ]

> @@ -182,34 +237,92 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
>  		return -EINVAL;
>  	}
>  
> -	mptcp_for_each_subflow(msk, subflow) {
> -		if (READ_ONCE(subflow->scheduled))
> -			return 0;
> +	state = mptcp_sched_get_subflow_state(msk);
> +	if (state == MPTCP_SCHED_SUBFLOW_ELIGIBLE)
> +		return 0;
> +
> +	if (state == MPTCP_SCHED_SUBFLOW_AVOIDED_ONLY) {
> +		mptcp_sched_clear_scheduled(msk);
> +		return mptcp_sched_default_get_send(msk);
>  	}
>  
>  	if (msk->sched == &mptcp_sched_default || !msk->sched)
> +		err = mptcp_sched_default_get_send(msk);
> +	else
> +		err = msk->sched->get_send(msk);
> +
> +	state = mptcp_sched_get_subflow_state(msk);
> +	if (state == MPTCP_SCHED_SUBFLOW_ELIGIBLE) {
> +		if (err) {
> +			mptcp_sched_clear_scheduled(msk);
> +			return err;
> +		}
> +		return 0;
> +	}
> +
> +	if (state == MPTCP_SCHED_SUBFLOW_AVOIDED_ONLY) {
> +		if (err) {
> +			mptcp_sched_clear_scheduled(msk);
> +			return err;
> +		}
> +
> +		if (msk->sched == &mptcp_sched_default || !msk->sched)
> +			return 0;
> +
> +		mptcp_sched_clear_scheduled(msk);
>  		return mptcp_sched_default_get_send(msk);

[Severity: Medium]
Can this throw away a usable selection from the BPF scheduler and send
nothing?

The commit message says:

  "Avoided subflows remain usable when no non-avoided alternative is
  available."

Suppose a scheduler returns 0 with only an avoided subflow X scheduled.
This branch clears X and uses the default selector instead.

mptcp_subflow_get_send() now always takes the best non-avoided candidate
Y when there is one. It checks free memory only on that candidate:

	ssk = send_info[SSK_MODE_ACTIVE][0].ssk;
	if (!ssk)
		ssk = send_info[SSK_MODE_ACTIVE][1].ssk;
	...
	if (!ssk || !sk_stream_memory_free(ssk))
		return NULL;

If Y has full wmem and X has room, the result is -EINVAL.
__mptcp_push_pending() then stops without sending, even though X was the
scheduler's explicit choice.

mptcp_sched_get_retrans() has the same override.
mptcp_subflow_get_retrans() skips any subflow that still has TCP-level
data queued:

	if (!tcp_rtx_and_write_queues_empty(ssk)) {
		...
		continue;
	}

It also uses backups only when min_stale_count > 1. So if a BPF
get_retrans() picks an avoided subflow with data in flight, could that
become -EINVAL and leave __mptcp_retrans() with nothing retransmitted?
Before this patch the BPF selection was used.

The early AVOIDED_ONLY branch at function entry acts on leftover
scheduled flags. One example is a flag left on a delegated subflow by
__mptcp_subflow_push_pending(). Another is an avoided fallback picked by
the default selector itself.

Is it intended that this branch replaces those flags with a fresh
default selection before msk->sched->get_send() runs? That path also
updates msk->snd_burst, avg_pacing_rate and timer_ival for a
BPF-scheduled socket. The retrans entry path has the same branch.

The stall seems to recover once wmem frees, a subflow goes stale, or the
rtx timer fires. Still, avoid acts as more than a preference here.

> -	return msk->sched->get_send(msk);
> +	}
> +
> +	return err ?: -EINVAL;
>  }

[Severity: Low]
This changes the return value and scheduled-flag behaviour for every
scheduler, including BPF schedulers that never call
mptcp_subflow_set_avoid(). Should the commit message describe this?

A scheduler that returns 0 with nothing scheduled now gets -EINVAL.
Before, the 0 was passed through.

In __mptcp_subflow_push_pending(), the old behaviour could keep the loop
spinning: keep_pushing stays true and the scheduler is called again on
every iteration:

	if (mptcp_sched_get_send(msk))
		goto out;

So this looks like a fix for an existing hang. Would it fit better as a
separate patch with a Fixes: tag, so it can be considered for stable?

Two more changes apply to all schedulers:

- A scheduler that returns an error after scheduling subflows now has
  all of its flags cleared.
- mptcp_sched_get_subflow_state() now clears scheduled on avoided
  subflows whenever a non-avoided subflow is also scheduled.

mptcp_sched_get_retrans() has the same changes.

The only mention is the changelog line "Handle scheduler success without
a selected subflow correctly". It sits below the --- line, so it won't
reach git history.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124102214.3930527-1-kalpan.jani%40mpiricsoftware.com
