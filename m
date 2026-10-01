Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C2495515
	for <mptcp@lists.linux.dev>; Thu,  1 Oct 2026 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889135; cv=none; b=YpSssNewfvWfRnt9LHbilFo6Pc5VNGU8VqTNWSfvH527TD7vz0KYzjkYUXKSXtDytXpx94cAz791pU0mq+4/UQZ0/cvudrueBz0R1WieM6HqElZd4hhTMIYW4PeImC51t5xM72FGl2idMurYRu6SA5GRfzBsyULevNpycWnArrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889135; c=relaxed/simple;
	bh=0cbF+e2HVa52Vdjmrq4HH6UedcVqbAqmXZ6n0uZWg/A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IhkyUA3DGGacgrIohAd/8WqfC4zObOqh85wih/e0YhovE8oQEGGzGCP0bAafGo1eG1nSgMI1Z083C8+2dzjEWHGk6AWJUNQJFvbw9xif/QzheSRgjiafZI4zLKC63NSx85lO1UQ3S64pNOvh9MtffYR3kZunevBwvDkHnq5OGUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0KbJH5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0KbJH5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593871F000FF;
	Thu,  1 Oct 2026 21:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790889133;
	bh=l8ZD59QYJiTacLH/vsyWiLYzSZ9mDPI4DWDm2paBCA4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b0KbJH5KtA0Q8TDSL69aTUQYT2qps4ohpzUYp4563GDjdqp4iwGk6vWFE+hUlcs0B
	 OS8yt/5dAx5mfRQrsQPOyr8BaeY5WWsY0G9Awx9D8OdTPBsEyvIcTuETf5urQamc6N
	 ITmVFeqOYRy6j3LPWqD0dFrau2NuekFaTao8k9bVNeN6/bUreN+O+dAjx4MuGSlitt
	 TGakMAYEBDbqFsXpQHT+ulzaeHinHLsubYfEQmlnCTrid4Wh0qhEkjlvcFSyStkDAM
	 3tQ6rlJff05+FmpISrKkaz2CVGmrL0mpHk85VrpKR05eI/qfN2ZogoRzRBhbqyX5LP
	 akM4U1nU/r+4g==
Subject: Re: [PATCH mptcp-next v14 09/11] mptcp: track app-limited state in
 mptcp_sendmsg
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc:
 mptcp@lists.linux.dev, pabeni@redhat.com, yangang@kylinos.cn, kuba@kernel.org
Date: Thu, 01 Oct 2026 21:12:12 +0000
Message-ID: <179088913294.3135.15874495190303859917@kernel.org>
In-Reply-To: =?utf-8?q?=3Cc1cfbd64bd5447d3f8464d2004865afab609d43c=2E1790734?=
 =?utf-8?q?083=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3Cc1cfbd64bd5447d3f8464d2004865afab609d43c=2E17907340?=
 =?utf-8?q?83=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mptcp_rate_check_app_limited() (net/mptcp/protocol.c:2058)
  runs the plain-TCP test tcp_sock_rate_check_app_limited() on each…
- [Low] Several statements in the commit message do not match the code.
- [Low] The commit author is 'Geliang Tang <geliang@kernel.org>', but the
  only sign-off is 'Signed-off-by: Geliang Tang…

--

mptcp: track app-limited state in mptcp_sendmsg

This commit splits tcp_rate_check_app_limited() into
tcp_sock_rate_check_app_limited(), which takes a struct tcp_sock, and a
thin struct sock wrapper around it. It then adds an MPTCP helper that
runs the check on every subflow under that subflow's socket lock. The
helper is called from mptcp_sendmsg_locked() so that
tcpi_delivery_rate_app_limited gets updated for MPTCP connections.

> Then add mptcp_sock_rate_check_app_limited() that walks every subflow of
> the mptcp_sock and runs tcp_sock_rate_check_app_limited() under each
> subflow's socket lock. Invoke it from mptcp_sendmsg() right after the
> send-side setup, so the delivery-rate app_limited state stays in sync
> with what the application actually has to send across each subflow.
>
> With this in place, TCP_INFO.tcpi_delivery_rate_app_limited is reported
> correctly for MPTCP connections instead of being left at 0.

[Severity: Low]
A few details in this part of the message don't seem to match the code.

The helper added in net/mptcp/protocol.c is named
mptcp_rate_check_app_limited(), not mptcp_sock_rate_check_app_limited().
It is called from mptcp_sendmsg_locked(), not mptcp_sendmsg().

Was the field really "left at 0" before this patch? tcp_init_sock()
starts every socket, subflows included, as app-limited:

net/ipv4/tcp.c:tcp_init_sock() {
    ...
	/* There's a bubble in the pipe until at least the first ACK. */
	tp->app_limited = ~0U;
	tp->rate_app_limited = 1;
    ...
}

BBR's PROBE_RTT handling also sets tp->app_limited.

Also, SOL_TCP / TCP_INFO on an MPTCP socket goes through
mptcp_getsockopt_sol_tcp()->mptcp_getsockopt_first_sf_only(), so it
reports only the first subflow. Per-subflow values are only available
through MPTCP_TCPINFO or MPTCP_FULL_INFO.

Could the message be reworded to match the helper name, the call site,
and what TCP_INFO actually reports?

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author is Geliang Tang <geliang@kernel.org>
and the only sign-off uses tanggeliang@kylinos.cn. checkpatch reports
this as FROM_SIGN_OFF_MISMATCH. Other patches in the series are signed
off as geliang@kernel.org. Should the From: and Signed-off-by: addresses
match here as well?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 319339be80760..1f7aaf3214a06 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2055,6 +2055,21 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
>  	}
>  }
>  
> +static void mptcp_rate_check_app_limited(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow;
> +
> +		slow = lock_sock_fast_nested(ssk);
> +		tcp_sock_rate_check_app_limited(tcp_sk(ssk));
> +		unlock_sock_fast(ssk, slow);
> +	}
> +}

[Severity: Medium]
Can this mark a subflow app-limited while the msk still has queued data
that is blocked by the MPTCP-level receive window?

The first test in tcp_sock_rate_check_app_limited() only looks at the
subflow's own write queue:

	if (/* We have less than one packet to send. */
	    tp->write_seq - tp->snd_nxt < tp->mss_cache &&

In MPTCP, data that the application has queued but that has not been
sent stays at the msk level. It sits on msk->rtx_queue starting at
msk->first_pending, and msk->write_seq is ahead of msk->snd_nxt.

That data only reaches a subflow when
__mptcp_push_pending()->mptcp_sendmsg_frag() hands it over, and the
hand-off is capped by mptcp_wnd_end(msk):

net/mptcp/protocol.c:mptcp_check_allowed_size() {
    ...
	mptcp_snd_wnd = window_end - data_seq;
	avail_size = min(mptcp_snd_wnd, avail_size);
    ...
}

net/mptcp/protocol.c:mptcp_sendmsg_frag() {
    ...
		if (snd_una != msk->snd_nxt || skb->len ||
		    skb != tcp_send_head(ssk)) {
			tcp_remove_empty_skb(ssk);
			return 0;
		}
    ...
}

The scheduler burst in mptcp_subflow_get_send() has the same cap:

	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);

Consider a slow reader during a bulk transfer:

- The peer's MPTCP window fills up.
- The subflow drains, so write_seq == snd_nxt, sk_wmem_alloc is near
  zero, in-flight is below cwnd and lost_out <= retrans_out.
- The next send() goes through
  mptcp_sendmsg_locked()->mptcp_rate_check_app_limited().
- tp->app_limited gets set on the subflow, even though the connection
  is limited by the receive window and not by the application.

Plain TCP keeps rwnd-blocked data in the same write queue, so
write_seq - snd_nxt >= mss_cache and the socket is not marked.

The marker is only cleared once tp->delivered moves past it. Until then,
skbs sent after the window reopens get tx.is_app_limited set in
tcp_rate_skb_sent(), and the rate samples built from them are flagged
app-limited too.

As a result, tcpi_delivery_rate_app_limited would read 1 where TCP would
read 0. BBR also ignores those window-limited bandwidth samples unless
they exceed max_bw.

Would it make sense to skip the per-subflow check when
mptcp_send_head(sk) is non-NULL, or when msk->write_seq differs from
msk->snd_nxt?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790734083.git.tanggeliang%40kylinos.cn
