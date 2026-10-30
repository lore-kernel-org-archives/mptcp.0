Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324270;
	b=xWRrUrjghKW2V2b6oMIjLKOIvL5eANmwtIUxrw2DgLjopX+ctIBcIkfQncSLuYqvJL3p
	 nF8bfarClGGKigNKZdBhgvlJHr+VLGTWnfZWbbE4uJFaMqhZZwk/X9WuG7XlVzOgkWH2n
	 rKwq0Qt0fImasmNv3YgT14RdYxsaFNq5lfHi1J1Na0CEwbr8cLJfdDobZiheh61xfU9MM
	 ldOgdH05TXCUDmlTjM8eAnEEZnVRNNccFrYMUxjha5pz0tV61GVjfP5gtKBg+pwmhJa+/
	 30MX8uZm3tNKdXYTgm5iObEvle+o+Ddu5cgVo7jzkHAgCf6RMkcnLyC8pzb/Knvky2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324270;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fiyhPtNWL+tRyZrvVb+wPcRPCFMzxV2vWWZAFpcoLPU=;
	b=xMLlL7vdEOnKP1KHG5wluEGxRd8ozpL7ozRN7J4VJydZBxIy25HNLItNz0yKyPXsUtft
	 TQMLv+r0hxFx/uE5nSzUoGIeYLDZMGH4xPa37bKa2bq34Yy2qyyiPTv6npNCTtEZFpcyl
	 X3jmV/qpJl0XoCDEMB0gH9+XjXcY0Yb++bkEIzTvxYEkNf8Q15WZNdGtU6od/QUs70nme
	 1m4PneAPJQ3WTIbaOnr0cRaf6cZ1YZRaT+bJg/BvL7F5PP1eBpodlYFVux1+T+yKBZnzU
	 vRVEz62YvnIaigJZif1LFWKCqnZgczPdqUn2It5jzXEwNrhRWqmrO9gvmUuaz+EDqnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQ8SFEMJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3EE606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQ8SFEMJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE17D1F00A17;
	Fri, 30 Oct 2026 01:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793324270;
	bh=fiyhPtNWL+tRyZrvVb+wPcRPCFMzxV2vWWZAFpcoLPU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nQ8SFEMJteAxt0vAjIfnTTqc7V2M1Y1htVpBnQBN4JWID/50SKCWXyF8ULyrSEO4W
	 BFNbU7sepsmCtnweWYULmAyQp/ynVb/d5uLJ05RgtlvjXMa1vRyC1wCOFDdGdcStS2
	 sgIJj8koFj0ppkMsSV1vxMG+VIsFf5+bDZ5JLzpaYz5kfytjmQ882ei5f7Zg3oahab
	 0b2mCm7+9mb5+svr4Jvq8JNxQhwH3oWH+UEx3Bns+j2G0JTmb6pY2xOElsPGkUYl2Q
	 RHSpxn69kJAMNi/XIE6g4VZOhORas9T0SE2Qw0DyLKtvcuM/LBp4VFUHQOPPueUcyS
	 TtoPPuJT7tWQw==
Subject: Re: [PATCH mptcp-next v5 4/4] mptcp: sched: add penalise counters and
 tracepoint
From: netdev-bot+sashiko@kernel.org
To: shardul.b@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com, shardulsb08@gmail.com, w453y.me@gmail.com,
 kuba@kernel.org
Date: Fri, 30 Oct 2026 01:37:49 +0000
Message-ID: <179332426952.3132.18255574909668672578@kernel.org>
In-Reply-To:
 <20261028-mptcp_penalise_send_v2-v5-4-32fb379ce117@mpiricsoftware.com>
References:
 <20261028-mptcp_penalise_send_v2-v5-4-32fb379ce117@mpiricsoftware.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit trailer has 'Co-developed-by: Matthieu Baerts (NGI0)
  <matttbe@kernel.org>' followed directly by 'Signed-off-by: Shardul…
- [Low] TP_fast_assign() in the new mptcp_subflow_penalise tracepoint
  reads tcp_snd_cwnd(tcp_sk(ssk)) (include/trace/events/mptcp.h:92).

--

mptcp: sched: add penalise counters and tracepoint

This adds two MPTcpExt SNMP counters, CwndPenalised and PenalCandidate.
They count how often the scheduler's cwnd-halving penalty is triggered
and how often it is actually applied. It also adds a
mptcp_subflow_penalise tracepoint, emitted from mptcp_subflow_get_send()
once the send burst is known.

>     Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>

[Severity: Low]
This isn't a bug, but the Co-developed-by tag for Matthieu Baerts has no
matching Signed-off-by from him. Documentation/process/submitting-patches.rst
says:

  Co-developed-by: denotes authorship, every Co-developed-by: must be
  immediately followed by a Signed-off-by: of the associated co-author.

Could his Signed-off-by be added directly after the Co-developed-by line?
checkpatch.pl also flags this.

> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
> index c47fa2672b84c..de34e107e2021 100644
> --- a/include/trace/events/mptcp.h
> +++ b/include/trace/events/mptcp.h

[ ... ]

> +	TP_fast_assign(
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		__entry->pace = subflow->avg_pacing_rate;
> +		__entry->max_pace = max_pace;
> +		if (ssk && sk_fullsock(ssk))
> +			__entry->cwnd = tcp_snd_cwnd(tcp_sk(ssk));
                                        ^^^^

[Severity: Low]
Should this read be annotated with data_race() or READ_ONCE()?

tcp_snd_cwnd() is a plain load:

include/net/tcp.h:tcp_snd_cwnd() {
	return tp->snd_cwnd;
}

The tracepoint fires from mptcp_subflow_get_send(). That function is
reached from __mptcp_push_pending() before lock_sock() is taken on the
selected subflow. It is also reached from __mptcp_subflow_push_pending(),
which only holds the lock of a different ssk when another subflow gets
scheduled.

So the selected subflow's lock may not be held here. On another CPU,
softirq ACK processing can update snd_cwnd through tcp_snd_cwnd_set() at
the same time. With the tracepoint enabled, KCSAN would report that as a
data race.

The same function already annotates the matching lockless read on the
fastest subflow:

	fast_limited = penal_cand && data_race(tcp_is_cwnd_limited(fastest));

Would data_race(tcp_snd_cwnd(tcp_sk(ssk))) or
READ_ONCE(tcp_sk(ssk)->snd_cwnd) be more consistent here?

> +		else
> +			__entry->cwnd = 0;
> +		__entry->burst = burst;
> +		__entry->penalise = subflow->penalise;
> +	),

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5eef96fa4f3e0..8f3c6ebd49ee9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -1759,6 +1762,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  	wmem = READ_ONCE(ssk->sk_wmem_queued);
>  	/* the conditions on this subflow are re-checked on apply, under its lock */
>  	subflow->penalise = burst && fast_limited && mptcp_snd_wnd_test(msk);
> +	trace_mptcp_subflow_penalise(subflow, max_pace, burst);
>  	if (!burst)
>  		return ssk;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117%40mpiricsoftware.com
