Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580219F137
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198702; cv=none; b=Y8MM46B2RmrJG7R++xfTkurXU1Ien0LNcI2nmCXEnZVQZU0AsqZ/WoD/tK5Atc5Hujiru0chx9X7unVmuvR9y7ivWaesT9X17Zv2SOOITCBs6XbQCgTyt2JbnmGdve2S9NLvF4YX0/a2XeCuhzCdzVDhhF1O1isjqjksVtZjn8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198702; c=relaxed/simple;
	bh=0WrtTOruFQiP/TAAMzjIk9qYXQUcnzYruvo1ubjtG6A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uL7Ve0Z/LMxPSELK9bd0pLOhuwalZdsy8t2N14BURN3xA5+aO4V/GFc3FvgIb0KhzSFAuzSxkLkGWA2EREavNM0kJ8vFLWhkrYzfCLYzIfn51xqdNEP0il1JUS7ZVTJa+hiIu8zrhxkuKjo/ys5AEdm4IfAASrLVUPqY9XaNNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvbkHFZU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvbkHFZU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DC41F000C5;
	Sat, 17 Oct 2026 00:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792198700;
	bh=cL2kSqImBgZ+JxF3+Xd5rUG8E0SG4TaewIVpmKx+JpE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RvbkHFZUk+f9kENXajlbr8gNyxOT8YN1eTjUHzzYH3jJBU5YOnqJaejJRNFKAuAV8
	 svh35bHy5y/N9D8lWsbKcij3RXmDGc7an/xjosc41bmrAPwxKRgwH2LdUvUxSsB+gO
	 4uQw1RKl9xySsfMZrLB7R8DVBJYBTl4cAnXUw1GLgMUDxcioR8ZiSizV7TBd3tndMi
	 jHMiY12U2Df8rAZ55P3gVBcaOU7to0Xp0SkzaIZwc3zm+q14M9iD7Bzwl+yV+vy186
	 DoMunPraxzGGHOOyNDoqqkD6y+fklOK364RQ9Wx79OasK3UyLJIO8lJ/wjMRODmV99
	 y7+fOUtcyylrg==
Subject:
 Re: [PATCH mptcp-net] mptcp: annotate lockless access to msk->scaling_ratio
From: netdev-bot+sashiko@kernel.org
To: quanyeyang@proton.me
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, kuba@kernel.org
Date: Sat, 17 Oct 2026 00:58:20 +0000
Message-ID: <179219870023.3135.6428859397034144575@kernel.org>
In-Reply-To:
 <20261015-t-mptcp-scaling-ratio-kcsan-v1-1-db146f55802e@proton.me>
References: <20261015-t-mptcp-scaling-ratio-kcsan-v1-1-db146f55802e@proton.me>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch is incomplete: one lockless reader of
  msk->scaling_ratio is still a plain load.

--

mptcp: annotate lockless access to msk->scaling_ratio

This commit annotates the BH write of msk->scaling_ratio in
mptcp_rcv_rtt_update() with WRITE_ONCE(). It also annotates the reads in
mptcp_win_from_space() and mptcp_space_from_win() with READ_ONCE(). The
goal is to fix a KCSAN data-race between mptcp_cleanup_rbuf() and
mptcp_data_ready().

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/634

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 05c38564e8fdf..ffd22849b719b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -1004,9 +1005,13 @@ static void mptcp_rcv_rtt_update(struct mptcp_sock *msk,
>  	if (++msk->rcv_rtt_est.next_sample == MPTCP_RTT_SAMPLES)
>  		msk->rcv_rtt_est.next_sample = 0;
>  
> -	/* EWMA among the incoming subflows */
> -	msk->scaling_ratio = ((msk->scaling_ratio << 3) - msk->scaling_ratio +
> -			     tp->scaling_ratio) >> 3;
> +	/* EWMA among the incoming subflows.
> +	 * Pairs with READ_ONCE() in mptcp_win_from_space().
> +	 */
> +	scaling_ratio = READ_ONCE(msk->scaling_ratio);
> +	WRITE_ONCE(msk->scaling_ratio,
> +		   ((scaling_ratio << 3) - scaling_ratio +
> +		    tp->scaling_ratio) >> 3);

[Severity: Medium]
Is there one more lockless reader of msk->scaling_ratio that still needs
annotating? The mptcp_rcvbuf_grow tracepoint in
include/trace/events/mptcp.h still uses a plain load:

include/trace/events/mptcp.h:TRACE_EVENT(mptcp_rcvbuf_grow) {
    TP_fast_assign(
        ...
        __entry->rtt_us = mptcp_rtt_us_est(msk) >> 3;
        ...
        __entry->scaling_ratio = msk->scaling_ratio;
        ...
}

The tracepoint fires from mptcp_rcv_space_adjust() on the recvmsg and
read_sock paths:

__mptcp_recvmsg_mskq()
  mptcp_rcv_space_adjust()
    trace_mptcp_rcvbuf_grow(sk, time)

That path holds only the msk owner lock (msk_owned_by_me()), not the msk
data spinlock. mptcp_data_ready() takes mptcp_data_lock() and calls
mptcp_rcv_rtt_update() before it checks sock_owned_by_user(). So the
WRITE_ONCE() above can run on another CPU at the same time as the
tracepoint read.

With the mptcp:mptcp_rcvbuf_grow tracepoint enabled, wouldn't KCSAN still
report a race on msk->scaling_ratio here? The same TP_fast_assign already
reads rcv_rtt_est.samples[] locklessly through mptcp_rtt_us_est() with
READ_ONCE().

Should this become the following?

    __entry->scaling_ratio = READ_ONCE(msk->scaling_ratio);

>  }
>  
>  void mptcp_data_ready(struct sock *sk, struct sock *ssk)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-t-mptcp-scaling-ratio-kcsan-v1-1-db146f55802e%40proton.me
