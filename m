Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793458574;
	b=E3peKj137Gk0ZKDqeax+IhX5JtnGT3bkWu7xgkE0yoeaBuvjnpQbEN/TBMy9zB69/iX7
	 4i1PAwQ+pR91b842RoPhWMAB61TInf6oHKqhFSWWrEVv9cMSAKAy1Tql/5K+DknG5mdF2
	 +IltHc9rcDpBl+Ymx52r0hNGYPU4zvW+LJ8oKcmq67fevHQz6jU7setMezDjHnrBwAsn+
	 9uNPeDzK1g5MqFSUcHjWUgcg6nhWZpo7N2+etG8LzH7HhUtznJISG+0rC7uHE1q7kcAyB
	 6XccESME+apNPec4XiOkqfwi2TmN4aXJqhE7bZZhaLlT4rEcNec120K4hcbCC8gzEWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793458574;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bxN1Geud4VPlc18aM+IS3HRWl44qJIAfg962/6pZCxs=;
	b=neWE/APBGJxRojFZHNZoxnN3A5YBwTszbDVibi7xlZSgH6I42fWkU2ccmGpQYcv7j0u9
	 Vg+ExmMl6lcqY/3oF796/51547nDdph9VJJCZL9bx1fjgQK0WmwqHoWHcYvxUnOaggWXj
	 JYJH5dkXXBzpu+bVSzOOBT4Y3DucInhgYvZ0xwWkTJWj2gHwruxCBOWNBPxHyIhPoXK6+
	 tZpWXWX1/v/aXzkntz7QiXce8R8kw9T3v7n3yKJ1Bz97pxgR73esGLV3gT4z6jvvOnGej
	 wIhbg3pDqUoXjm7JMAisl04JcXV4cJ2E6bW0JdRByplyuFiG7SAF10oVizFpKzr1oeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G0boYHFC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2FF606A31C
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G0boYHFC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B4C1F000C1;
	Sat, 31 Oct 2026 14:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793458574;
	bh=bxN1Geud4VPlc18aM+IS3HRWl44qJIAfg962/6pZCxs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G0boYHFCQjkaq60++t4+snmYi2bD3U74GI0qAkenoJjxM+c7Upd+qVEE8gsI4C3p3
	 Ym0130AcZJ3FkQAm2VuCHOWyD+EXX2gAk9Vr94Jl2a5zh0whwBkjFua6Nd0DlpDkbA
	 YvpEE/pA1GBJjMUvmo6L+aTIYM7qNmGnekDVd6N2r99SUhlGQVKbMLRbhyLoDRCrgx
	 5fbGRtP2hZphXKcYNNRvFhmzkx9aKft4Ird5ay1ZFcIfrTw52Td1CoF+4NRDui77nS
	 vZUJLzAtQ7CCP6NoA3Dc9sE39k7UY3I3nal7dlpnPvxw+ooWmuBwMddEhXF8CCR9vL
	 dyrM1MgosCYCg==
Subject:
 Re: [PATCH mptcp-next v3 4/5] mptcp: track app-limited state in mptcp_sendmsg
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Sat, 31 Oct 2026 14:56:13 +0000
Message-ID: <179345857386.3128.591821758414475761@kernel.org>
In-Reply-To: =?utf-8?q?=3C9fd8f849cbcb94b46bc2f59225dbdde81e8389d2=2E1793324?=
 =?utf-8?q?316=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C9fd8f849cbcb94b46bc2f59225dbdde81e8389d2=2E17933243?=
 =?utf-8?q?16=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/mptcp/protocol.c, mptcp_rate_check_app_limited()
  decides whether MPTCP still has data to send using only…
- [Low] Commit metadata mismatch for "mptcp: track app-limited state in
  mptcp_sendmsg": the author is `Geliang Tang <geliang@kernel.org>`, but…

--

mptcp: track app-limited state in mptcp_sendmsg

This adds mptcp_rate_check_app_limited(). It walks the subflows of an
MPTCP socket and calls tcp_rate_check_app_limited() on each one, unless
the msk still has unpushed or re-injected data. It is called from
mptcp_sendmsg_locked() so that congestion controllers like BBR can ignore
rate samples taken while the connection is application-limited.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the Signed-off-by address doesn't match the author
address (Geliang Tang <geliang@kernel.org>). checkpatch reports
FROM_SIGN_OFF_MISMATCH for this. It doesn't read .mailmap, so the
existing .mailmap entry that maps these two addresses won't stop the
warning.

Patch 1 of the series ("mptcp: update mptcp_check_readable") signs off
with geliang@kernel.org. Could this one use the same address?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 696cdba76bc94..f30e14a2775a2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2038,6 +2038,24 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
>  	}
>  }
>  
> +static void mptcp_rate_check_app_limited(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> +
> +	if (msk->write_seq != msk->snd_nxt || mptcp_send_head(sk))
> +		return;

[Severity: Medium]
Does this check miss data that is waiting for an MPTCP-level
retransmission?

When the MPTCP RTO fires, mptcp_retransmit_timer() only defers the work:

net/mptcp/protocol.c:mptcp_retransmit_timer() {
    ...
	if (!sock_owned_by_user(sk)) {
		/* we need a process context to retransmit */
		if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
			mptcp_schedule_work(sk);
	} else {
		/* delegate our work to tcp_release_cb() */
		__set_bit(MPTCP_RETRANSMIT, &msk->cb_flags);
	}
    ...
}

Neither path changes write_seq, snd_nxt or first_pending.

Later, __mptcp_retrans() reads the data straight from mptcp_rtx_head()
and sends it with __mptcp_push_retrans(). It never sets
msk->first_pending. The only path that sets first_pending = rtx_head is
__mptcp_retransmit_pending_data(), which runs when a subflow is closed
or goes stale.

So suppose mptcp_sendmsg_locked() takes the msk lock after the RTO has
fired but before mptcp_worker() or mptcp_release_cb() has run
__mptcp_retrans(). Then write_seq == snd_nxt and mptcp_send_head() is
NULL. The same holds if __mptcp_retrans() bailed out because
mptcp_sched_get_retrans() found no suitable subflow and the data is
still waiting.

In that window, won't the subflow loop below set tp->app_limited on idle
subflows? That includes the one mptcp_subflow_get_retrans() is about to
pick for the retransmission.

Plain TCP avoids this with the tp->lost_out <= tp->retrans_out condition
in tcp_rate_check_app_limited(). Nothing here does the same for data
lost at the MPTCP level. BBR would then keep the recovery burst samples
out of its max-bw filter in bbr_update_bw(), reset sampling in
bbr_lt_bw_sampling(), and skip them for full-bandwidth detection.

This also seems to contradict the commit message:

    With this in place, subflow rate samples taken while the MPTCP
    connection is genuinely application-limited are flagged as such

Should the early return also cover a pending MPTCP_WORK_RTX or
MPTCP_RETRANSMIT?

> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow;
> +
> +		slow = lock_sock_fast_nested(ssk);
> +		tcp_rate_check_app_limited(ssk);
> +		unlock_sock_fast(ssk, slow);
> +	}
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793324316.git.tanggeliang%40kylinos.cn
