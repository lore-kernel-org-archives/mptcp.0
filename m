Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED46277C88
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981155; cv=none; b=PeAUfAjcgO5Q16yJycUJksDwEj+CXOz1gEnvHTujXQpaMNqMbLdKaH9btB6axG8e0VJdWuwLpnz2FdsAeZgtroHz8xbDr2Hk37ptQPjTvcDeSjXOrR6RI5v9LlxdEqgkwWIRHNgKLcHrf01NKokzpXOIhugndqfP4KJG9OZgtCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981155; c=relaxed/simple;
	bh=di19pW5QtwFUZ8FkOlYhaWAPzJFsAGse9OGgFgh7kQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a506bI51aopLkxnMILLTDVGvvk736bdEddu3abf4FILHmTQGWezFFwwT+ZdTyucreLnfmDqOOltaK46qrYXy9SRuEg7k90xQdZXcU6u939FhbatnzjkFOdd8mmoywfJWBXoN1RuW83A8XvQZ6rgH+TSOyCEttXaOOZ9zWJkvBpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6Uihg01; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6Uihg01"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730781F000E9;
	Mon, 17 Aug 2026 15:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786981154;
	bh=wR00wQVZbUMpmNccsR4zC1SaEZ7C2MDGoLX3b4Vz5SE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F6Uihg01D9PxY4aBaz/64/hO4U1uIotWC30wYwOs/B90s2JSA7sQ35Dkc71pGFGPK
	 AIA0jWtsQn1HDfY0CDi1W/sLNUtxaoFzKJlP1HhvgHUOEUUkBWBupq3Z+9ntl49DPS
	 fozS0UmEA7g6DZA0Wolmrl6hE3rhnHEk1Y+jLeJcCyUcnhzUPo/tMHwlTSCB9NnHuB
	 6Ldu8QTDXAfNdHEeHAnB0gp4myrdsZp2xDLd3FPSNWC87YDoEUc+MLpR3QjL8AcQT9
	 Vo7HvTXku9dz6GFphS1QCk5U5YPl01KGjX64VNRzp2f5++w3pJDr6e2YXbdF9YjZwh
	 /lcWKmnHGs3GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v3 2/4] mptcp: sched: penalise a slow subflow
 by halving its cwnd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shardul Bankar" <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260817-mptcp_penalise_send_v2-v3-2-e6a2ad2f1b82@mpiricsoftware.com>
References: <20260817-mptcp_penalise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com>
 <20260817-mptcp_penalise_send_v2-v3-2-e6a2ad2f1b82@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 15:39:13 +0000
Message-Id: <20260817153914.730781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] A 64-bit integer overflow in the EWMA `avg_pacing_rate` calculatio=
n incorrectly cripples highly performant subflows.
- [Medium] Bypassing TCP Congestion Control API corrupts internal state and=
 renders the penalty ineffective.
- [Medium] Unsynchronized lockless reads of TCP subflow internal states and=
 bitfields cause data races.
--

--- Patch [2]: [PATCH mptcp-next v3 2/4] mptcp: sched: penalise a slow subf=
low by halving its cwnd ---
commit 07a5e01113da906e5797c2902f8c9a2e4065ed23
Author: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: mptcp: sched: penalise a slow subflow by halving its cwnd

This commit introduces a mechanism to penalize poorly performing subflows
by halving their congestion window. It flags subflows for penalization in
the scheduler when their pacing rate falls significantly behind the fastest
path, and applies the reduction under the subflow socket lock.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/345

> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> +static void mptcp_penalise_cwnd(struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +	struct tcp_sock *tp =3D tcp_sk(ssk);
> +	u32 cwnd =3D tcp_snd_cwnd(tp);
> +
> +	subflow->penalise =3D false;
> +	/* CA state may have left TCP_CA_Open since get_send flagged this */
> +	if (inet_csk(ssk)->icsk_ca_state !=3D TCP_CA_Open)
> +		return;
> +	subflow->last_penalise =3D tcp_jiffies32;
> +	tcp_snd_cwnd_set(tp, max_t(u32, cwnd >> 1, MPTCP_PENALISE_MIN_CWND));
> +	if (cwnd >=3D tp->snd_ssthresh)
> +		tp->snd_ssthresh =3D max_t(u32, tp->snd_ssthresh >> 1, 2);

[Severity: Medium]
Will bypassing the TCP congestion control API work for modern algorithms?

Algorithms like BBR or CUBIC explicitly ignore external modifications to
snd_cwnd and might immediately overwrite or inflate the window back up on t=
he
next ACK.=20

BBR tracks its own window internally, so the penalty here might be instantly
undone and rendered ineffective.

> +}
[ ... ]
> @@ -1685,12 +1727,24 @@ struct sock *mptcp_subflow_get_send(struct mptcp_=
sock *msk)
>  	if (!ssk || !sk_stream_memory_free(ssk))
>  		return NULL;
> =20
> +	/* Flag a slow subflow for cwnd halving, applied in the push path */
> +	subflow =3D mptcp_subflow_ctx(ssk);
> +	penal_cand =3D fastest && ssk !=3D fastest &&
> +		     subflow->avg_pacing_rate < max_pace / MPTCP_PENALISE_RATE_RATIO;
> +	subflow->penalise =3D penal_cand &&
> +			    tcp_snd_cwnd(tcp_sk(ssk)) > MPTCP_PENALISE_MIN_CWND &&
> +			    inet_csk(ssk)->icsk_ca_state =3D=3D TCP_CA_Open &&
> +			    tcp_is_cwnd_limited(fastest) &&

[Severity: Medium]
Are we safe from data races when reading tcp_is_cwnd_limited(fastest)
locklessly?

The scheduler is running under the MPTCP connection lock, but does not hold
the individual subflow socket locks. tcp_is_cwnd_limited is a bitfield
sharing a byte with other heavily modified TCP flags.

Concurrent updates by the TCP stack to adjacent flags in the bitfield during
ACK processing require Read-Modify-Write operations. This lockless read
might trigger KCSAN splats.

> +			    mptcp_penalise_throttle_ok(subflow);
> +
>  	burst =3D min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
>  	wmem =3D READ_ONCE(ssk->sk_wmem_queued);
> -	if (!burst)
> +	if (!burst) {
> +		/* no window room to send; skip the penalty */
> +		subflow->penalise =3D false;
>  		return ssk;
> +	}
> =20
> -	subflow =3D mptcp_subflow_ctx(ssk);
>  	subflow->avg_pacing_rate =3D div_u64((u64)subflow->avg_pacing_rate * wm=
em +

[Severity: High]
Could this EWMA calculation overflow a 64-bit integer on high-throughput
links?

If a highly performant subflow, like 100Gbps (around 12.5 GB/s), has a large
write queue (wmem around 1.5 GB), the product of (u64)avg_pacing_rate * wmem
might exceed the u64 maximum of ~18.44 * 10^18.

This would wrap around modulo 2^64 and drastically reduce avg_pacing_rate.
The scheduler might then falsely flag this highly performant subflow as
a penalty candidate and repeatedly halve its congestion window.

>  					   (u64)READ_ONCE(ssk->sk_pacing_rate) * burst,
>  					   burst + wmem);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-mptcp_pena=
lise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com?part=3D2
