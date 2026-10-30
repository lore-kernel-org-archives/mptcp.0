Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324268;
	b=U4XtK7n2Y2N3XvqKvv81JKZMT4BdKtdU6/4ziS2dwsy59VVSyJbJrSyJoaxSxb6loLVD
	 jTkvy5cMcyduZPi5JMzwHliKsYEVD/EjrxcsyZBDJE4bpTjHnTholtZupc/At4eCBMfBs
	 j2LwPoICQqZHD73pbr8TQy3BSQjZxbW7jjOWjulJEsejgjj7wGoMBS+pM7+R4GDwxjxxg
	 q/e9ASKVHDwC7AOaWZhtMx7y0AMNcvKGZq2trB4cf2ByFMRkWRtugoNjVJ8H3MupkJ6wC
	 466kE1pS9jZzUfecvXzZRJTaz7C+g9Jshp9WHVyWGfzGrRYFjP5LGZemeToaPlwvC2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324268;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=A1CDe/Vl1eF9+bi4pnuJBCoiuzCOxMXyWkqkbUzGmso=;
	b=PCOVbwVNZ+0k9PyMB4Xi9be83DwoaaiCEVfN8xL+uABHeFwMpq5kJhKau446/lH4FIP1
	 P57/xuL9mD7pjBoqCgnn1czwWhSTujglaxGhDKlDXW5W1oPy/wnS/EfAvb/j1cQFAY4R0
	 zBu74hu6IFRRYc/k89T9f95UVvodTi1DAFa7xLfZr6qmn20zmrnTVD3igrT+z7yZ7wMtP
	 9BtBXNi27Je4eOr80GiFsrfMcuSAAqs4RaZ1mfQZCIHr+g4AzBZ/9t57llsZVhHLd9EnH
	 b6J555cEpgT+mMSxEFFMgwjwHyXbvFkIqFCMWmhGgOmXy3wEFZBKGpcW8YaJxZVB0Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uh9pjX3G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656FE606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uh9pjX3G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF851F00919;
	Fri, 30 Oct 2026 01:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793324268;
	bh=A1CDe/Vl1eF9+bi4pnuJBCoiuzCOxMXyWkqkbUzGmso=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Uh9pjX3GLiq2XWNQW8kLu/s2RJlu+k5fbhwsAJsR5p839XsYEz/+G7jQwRFAObegh
	 aU+nUHKtSOMkInjeVVKsTIS0kX1GTCaRhpBiJV/vDSPnyb4GRTEm0Q8bxNLsuxoRV7
	 NTaU/a8/cjcDIlBoqd/mId/dIvWfzEE8yKV1NpoiuO/0lww0Tnx+v+Y79mwwrH0OSo
	 N9NMYf27D18Gjd//atdiryp8zIayPkoSCrOB325YsF0gMUDtB6xepKLRGmqy+OCiYI
	 /o54MJvFpKhIg5C4ff+6qfTZ2a1o4hYpnlD8VAfttvNfO7QjJcOYth8HfV0EDLEZ/u
	 9+wqFM9Rt4kMw==
Subject: Re: [PATCH mptcp-next v5 2/4] mptcp: sched: penalise a slow subflow
 by halving its cwnd
From: netdev-bot+sashiko@kernel.org
To: shardul.b@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com, shardulsb08@gmail.com, w453y.me@gmail.com,
 kuba@kernel.org
Date: Fri, 30 Oct 2026 01:37:47 +0000
Message-ID: <179332426731.3132.5154849254860151673@kernel.org>
In-Reply-To:
 <20261028-mptcp_penalise_send_v2-v5-2-32fb379ce117@mpiricsoftware.com>
References:
 <20261028-mptcp_penalise_send_v2-v5-2-32fb379ce117@mpiricsoftware.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The penalty feeds itself and drives a slow subflow's cwnd down
  to a near-floor value.
- [Low] The commit message has a 'Co-developed-by: Matthieu Baerts (NGI0)
  <matttbe@kernel.org>' trailer, but no Signed-off-by from Matthieu…
- [Low] mptcp_penalise_throttle_ok() (net/mptcp/protocol.c:1637-1643)
  enforces 'not penalised in the last RTT' by comparing jiffy…

--

mptcp: sched: penalise a slow subflow by halving its cwnd

With this commit, the default MPTCP packet scheduler flags the subflow it
picks when that subflow's avg_pacing_rate is below half that of the
fastest non-backup subflow, and that fastest subflow is cwnd-limited.
The flagged subflow then gets its cwnd (and possibly its ssthresh) halved
in __subflow_push_pending(), under its own socket lock. This happens at
most once per RTT, and cwnd never goes below MPTCP_PENALISE_MIN_CWND.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/345
Link: https://github.com/multipath-tcp/mptcp/blob/825b62d597b5/net/mptcp/mptcp_sched.c#L300-L330

> Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>

[Severity: Low]
This isn't a bug, but shouldn't the Co-developed-by tag be followed by a
Signed-off-by from Matthieu Baerts?

Documentation/process/submitting-patches.rst says every Co-developed-by:
must be immediately followed by a Signed-off-by: from the same co-author.
checkpatch.pl warns about this.

The later commits "mptcp: sched: do not penalise when
receive-window-limited" and "mptcp: sched: add penalise counters and
tracepoint" have the same trailer layout.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 886f00ee2a4d4..395f9582ece89 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1624,6 +1624,45 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)

[ ... ]

> +/* Rate-limit the penalty to at most once per subflow RTT, so the congestion
> + * control can grow the window back between reductions.
> + */
> +static bool mptcp_penalise_throttle_ok(struct mptcp_subflow_context *subflow)
> +{
> +	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +	u32 rtt = usecs_to_jiffies(READ_ONCE(tcp_sk(ssk)->srtt_us) >> 3);
> +
> +	return tcp_jiffies32 - subflow->last_penalise >= max_t(u32, rtt, 1);

[Severity: Low]
Is the once-per-RTT limit actually enforced when srtt is shorter than one
jiffy?

In that case rtt is 0 and the threshold becomes 1. A difference of one
jiffy only means a tick boundary was crossed. A penalty late in jiffy N,
followed by another pick of the same subflow early in jiffy N+1, would
pass this check microseconds later with no ACK in between. That would
quarter cwnd within a single RTT.

This can happen on sub-millisecond paths at HZ=1000, below 4ms at HZ=250,
or below 10ms at HZ=100. __mptcp_push_pending() calls the scheduler on
every loop iteration, so picking the same subflow twice in a row is
normal. For larger RTTs, the real gap can still be up to one jiffy
shorter than srtt.

Would a microsecond clock, such as tp->tcp_mstamp compared with
srtt_us >> 3, match the documented limit better?

> +}
> +
> +/* Halve cwnd, and ssthresh when cwnd is at or above it, under the subflow
> + * socket lock: the scheduler only marks a candidate, the conditions on this
> + * subflow are evaluated here, on current state.
> + */
> +static void mptcp_penalise_cwnd(struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	struct tcp_sock *tp = tcp_sk(ssk);
> +	u32 cwnd = tcp_snd_cwnd(tp);
> +
> +	subflow->penalise = false;
> +	if (cwnd <= MPTCP_PENALISE_MIN_CWND ||
> +	    inet_csk(ssk)->icsk_ca_state != TCP_CA_Open ||
> +	    !mptcp_penalise_throttle_ok(subflow))
> +		return;
> +	subflow->last_penalise = tcp_jiffies32;
> +	tcp_snd_cwnd_set(tp, max_t(u32, cwnd >> 1, MPTCP_PENALISE_MIN_CWND));
> +	if (cwnd >= tp->snd_ssthresh)
> +		tp->snd_ssthresh = max_t(u32, tp->snd_ssthresh >> 1, 2);

[Severity: High]
Can the congestion control really grow the window back between
reductions, as the comment above mptcp_penalise_throttle_ok() says?

Once ssthresh has also been halved, the subflow is in congestion
avoidance. There, Reno grows by about one segment per RTT in
tcp_cong_avoid_ai(). CUBIC limits growth to about cwnd/2 per RTT:

net/ipv4/tcp_cubic.c:bictcp_update() {
    ...
	ca->cnt = max(ca->cnt, 2U);
    ...
}

Halving every RTT outpaces both. It looks like cwnd would ratchet down
towards MPTCP_PENALISE_MIN_CWND (3 -> 2, regrow to 3, halve again). In
slow start, doubling per RTT against halving per RTT gives roughly zero
net growth.

The trigger also seems to feed itself. avg_pacing_rate is built from
sk_pacing_rate, which tcp_update_pacing_rate() computes from:

	rate *= max(tcp_snd_cwnd(tp), tp->packets_out);

divided by srtt. Each halving lowers the subflow's rate, so this check in
mptcp_subflow_get_send() passes by a wider margin each time:

	penal_cand = fastest && ssk != fastest &&
		     subflow->avg_pacing_rate < max_pace / MPTCP_PENALISE_RATE_RATIO;

Nothing here tells a slow path apart from a subflow that just has a small
cwnd.

For example, take a newly joined MP_JOIN subflow B on a path as good as
A. B starts with cwnd 10 and sk_wmem_queued == 0, so linger_time is 0
and the scheduler picks it. If A has a cwnd of around 100 and is
cwnd-limited, B becomes a candidate.

B is in TCP_CA_Open, its cwnd of 10 is above 2, and last_penalise == 0
passes the throttle. So B's cwnd is halved before B has sent any data:

mptcp_subflow_get_send()
    subflow->penalise = burst && fast_limited;
__subflow_push_pending()
    mptcp_penalise_cwnd()
        tcp_snd_cwnd_set()    /* cwnd 10 -> 5 */

This would repeat every srtt, so B could not ramp up while A stays
saturated. Would this keep slower or newly added subflows at a tiny cwnd
and defeat bandwidth aggregation for bulk transfers with the default
scheduler?

The later patches in this series don't seem to change this behaviour.

> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117%40mpiricsoftware.com
