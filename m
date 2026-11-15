Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794739988;
	b=rVTn0oU0eVcjp84vKPQHOD9zd0fHZEGkR7IRsREULFdU1mrtQ7piIV9jat8NRg+MOTUh
	 ruIl8xvP+igTshaLM6cWJR2pifuLW0F23H/4YpIGIrPPWKehdJyzfDdpP2SCs2zcF398L
	 g47ZRzJAFszXA4R/RgWWnZRGHd0uzQebAKMjMGDQB4Tluk/MBuTYykH9E2zzoojYCETNV
	 0bb0ox/ZXf+2j54Qf6CIub6+940x3v+UWRcgDopNBUuyonMQDUzy83jdR8EElgTVWmSiQ
	 Sa9iRN4xayQUhgOXu4DzeNn+ePs1ntRebZ4kglTuc9d633IuQlnmJR9M7QeK3PO4HRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739988;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Zw3Hyp1+mnD/EKpGOduoncVkwjfsFMgnJHvEGPFVbLA=;
	b=K+1oVrGc4mMys07UILprfI6+492FSJ9qp8wX5MHGvErsqIpDox3oO/G4tD1JO8aVKIUU
	 nwC0UGti0Fdgg/4Xk/KK6pd8wdEhE37uapBfTHds6cFHvrsNY3GUe3AIx2MCy8OtSyYqv
	 1KzJIzBaA7TcoPnuknE2trlQT7t+zEeg1mArI+WbhsYHdubAF44u7r8MBtwFfjB5NvrE9
	 nq4VDnWEYOVnLxrASRaayVy++IfDFa1aSxp3kkQgRgipb4DFdorRYj5L7fcXLm111/ff+
	 exKyQ3poj1e+EwLU+SReIGmgiW42VSa3+6w0a8zQoyoyPHy3OTs4Uhe7A3EzEG+tovQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lk2UfcJj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8D606A32C
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lk2UfcJj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFED1F000C5;
	Sun, 15 Nov 2026 10:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794739988;
	bh=Zw3Hyp1+mnD/EKpGOduoncVkwjfsFMgnJHvEGPFVbLA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lk2UfcJjENpDlCe0VKdubKvCNTOtQveOj/SQnRLapNZ2ydNkMgQZDofmNC00YUOlv
	 IlKPCLIAH+CRSqbX2smcTI92AeCa56G0IIJhr7tOBDGFYFmQMsVcBSDEQBvYoxTj5+
	 S5ZCMt2iwTHe1hVTg1sJnThLZDQvPwwLCabiCPuDbSVM5N+Hjk5ONIxk7CUIv/H1TZ
	 DsZ6IX67HFG0oMUEZl3dFmXnsnbzIDMtQWMTs9mUrAuRw6oYyA73KxAVhLRgJWHLG2
	 LkJ/cnX2x+hl04ERn6cAEVZbyZSJHR7WSlILiFlg+hVr5DtOVW7kbtNpM9sTniX9gx
	 vQDsOQ9kz8+lA==
Subject: Re: [PATCH mptcp-net 07/34] mptcp: arm the rtx timer if a push leaves
 data behind
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc:
 mptcp@lists.linux.dev, mason@kernel.org, pabeni@redhat.com, kuba@kernel.org
Date: Sun, 15 Nov 2026 10:53:07 +0000
Message-ID: <179473998797.488855.15888250617793645103@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-7-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-7-9205b77e9a2f@kernel.org>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new arming condition `(copied || mptcp_send_head(sk)) &&
  !mptcp_rtx_timer_pending(sk)` was added to both __mptcp_push_pending()…

--

mptcp: arm the rtx timer if a push leaves data behind

This patch changes __mptcp_push_pending() and
__mptcp_subflow_push_pending() so they also arm the MPTCP rtx timer when
unsent data is left in the write queue, and not only when data was pushed.
Under memory pressure, a send() whose push to a subflow failed can then be
retried without waiting for another event.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e484f7edad49c..dc8cdda31a984 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1850,14 +1850,11 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>  	if (ssk)
>  		mptcp_push_release(ssk, &info);
>  
> -	/* Avoid scheduling the rtx timer if no data has been pushed; the timer
> -	 * will be updated on positive acks by __mptcp_cleanup_una().
> -	 */
> -	if (copied) {
> -		if (!mptcp_rtx_timer_pending(sk))
> -			mptcp_reset_rtx_timer(sk);
> +	/* also retry later if unsent data is left: no ack may trigger it */
> +	if ((copied || mptcp_send_head(sk)) && !mptcp_rtx_timer_pending(sk))
> +		mptcp_reset_rtx_timer(sk);

[Severity: Medium]
Can this arm the rtx timer with a zero timeout when the push copied
nothing?

When a socket goes idle, __mptcp_clean_una() calls mptcp_stop_rtx_timer(),
which clears the interval:

net/mptcp/protocol.c:mptcp_stop_rtx_timer() {
	sk_stop_timer(sk, &sk->mptcp_retransmit_timer);
	mptcp_sk(sk)->timer_ival = 0;
}

Only two places refresh timer_ival afterwards. One is the default
scheduler, through mptcp_subflow_get_send()->__mptcp_set_timeout(). The
other is mptcp_set_timeout() in __subflow_push_pending(), which only runs
after a dfrag has been fully pushed.

A BPF struct_ops scheduler that never calls the mptcp_set_timeout kfunc
refreshes neither of them. The in-tree bpf_first, bkup, red and rr selftest
schedulers work this way. For example, bpf_first_get_send() only sets the
scheduled flag.

With such a scheduler, suppose mptcp_sendmsg_frag() fails after idle
because the skb allocation or the wmem charge failed. Then copied is false
and mptcp_send_head(sk) is non-NULL, so the new code calls:

net/mptcp/protocol.c:mptcp_reset_rtx_timer() {
	...
	tout = msk->timer_ival;
	sk_reset_timer(sk, &sk->mptcp_retransmit_timer, jiffies + tout);
}

with tout == 0.

The timer then fires on the next tick. __mptcp_retrans() finds no rtx head
but a send head, so it reaches:

reset_timer:
	mptcp_check_and_set_pending(sk);

	if (!mptcp_rtx_timer_pending(sk))
		mptcp_reset_rtx_timer(sk);

That re-arms the timer at jiffies + 0 again. The push from
mptcp_release_cb() then fails again, and this repeats for as long as the
memory shortage lasts.

Would this create a timer -> worker -> lock_sock -> allocation retry cycle
on every jiffy, with no backoff, while the system is short of memory?

When the push finally succeeds, the timer is already pending at about
jiffies + 0. Would the data that was just sent then be retransmitted
almost immediately?

__mptcp_subflow_push_pending() gets the same condition. Its first == true
path calls __subflow_push_pending() without going through the scheduler,
so timer_ival is not refreshed there either.

A similar zero-interval arming already exists with these schedulers for
successful pushes after idle. This patch extends it to the failed-push
state.

Could timer_ival be made non-zero before arming when copied is false? Two
options would be calling __mptcp_set_timeout() or falling back to
icsk_rto_min.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f%40kernel.org
