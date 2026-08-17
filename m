Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD18222597
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980882; cv=none; b=CpvJGp4jTic4ZFz5gwxUIIan4r9foUo+q0OGRBYbXkdCq5zCfv1yzN1ckVcj+XoxPNzq7fWLdEdx6W14KRLUAUrDi7pTsQZS5Ml1WxG/QfIhjU/vyZ7aa2RAT93IsV2fIRKSsl3qBjm2Tie0ZLlVDzQqJooc0xDHFUv+Y5VZgBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980882; c=relaxed/simple;
	bh=ciMs7Ag0c4Q+4w0V4ajwiMZe5HqttUulmQkJC1Fwhyk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lm2sCA/dPt9KF9SUgIZH4tvHDQGcOk53CMVFNmksZVfyWQJn94u68KBSUBk5rM3kB0OEeTyxubw6k79XGee4c5P8tJ8KmAFlmle9Cz7j5HK89atAkIKmmIP4/IiaITB2jZWzA0p3ICxgbiW/JsUPtdRaV+W7wS1qGS8jv2l6GTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLYTaky2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLYTaky2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7001F00A3A;
	Mon, 17 Aug 2026 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786980881;
	bh=KMVJ52FsX3BKBqZ9FXZ3i8C4Gnylkq/1xkM6EkS4m2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oLYTaky2N8z5UCSrLm7JpIaZfjLzKPK4mYlOXeHEGuQJBYWRiljMn0Y/xSjEOl8gc
	 3Q9hR+z/QQ3z+5TpXxMyvdCdQc+u8HrpDKPlcUeKFvcrZpqdUc3DjstHETxbfKgCqQ
	 xzW2HRLUB6VTKtMjrLgO4KCsWMJswq/nltbKeqK8i/3bkZKhf2cR/uXn85/v4lycMX
	 MlDlv0GmYUpDFzEokKatQxBdDKii02KVKLS0YW7nTMyRELrYxB7KCv/zv5GcK/bCsj
	 6UGwcFxNys1Px3S0VJTZHyXZLYczhzAM/riB8f4kJPYZfFie7V7K19iCODYgknoQyg
	 OOpDKui3W/u7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v3 4/4] mptcp: sched: add penalise counters
 and tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shardul Bankar" <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260817-mptcp_penalise_send_v2-v3-4-e6a2ad2f1b82@mpiricsoftware.com>
References: <20260817-mptcp_penalise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com>
 <20260817-mptcp_penalise_send_v2-v3-4-e6a2ad2f1b82@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 15:34:40 +0000
Message-Id: <20260817153441.3F7001F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `mptcp_subflow_penalise` tracepoint logs an inaccurate verdi=
ct because it is emitted before the scheduler finalizes the decision to pen=
alize a subflow.
- [Medium] Unprotected lockless plain reads and writes of TCP and subflow s=
tate violate concurrency rules, which will trigger KCSAN warnings.
--

--- Patch [4]: [PATCH mptcp-next v3 4/4] mptcp: sched: add penalise counter=
s and tracepoint ---
commit 5337879700eb732d117ee91fe901b615a12833e3
Author: Shardul Bankar <shardul.b@mpiricsoftware.com>

mptcp: sched: add penalise counters and tracepoint

Add observability for the cwnd-halving penalty introduced in the previous
patches. It adds MPTcpExt SNMP counters and an mptcp_subflow_penalise
tracepoint.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e4d26c2dce1ee..0cd18705ab404 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1656,6 +1656,7 @@ static void mptcp_penalise_cwnd(struct sock *ssk)
>  		return;
>  	subflow->last_penalise =3D tcp_jiffies32;

[Severity: Medium]
Is this unprotected write safe from load tearing?

Since subflow->last_penalise is concurrently read locklessly in
mptcp_penalise_throttle_ok(), should this be updated using WRITE_ONCE()
to avoid KCSAN warnings?

> +	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_CWNDPENALISED);
>  	if (cwnd >=3D tp->snd_ssthresh)
>  		tp->snd_ssthresh =3D max_t(u32, tp->snd_ssthresh >> 1, 2);
>  }

[ ... ]

> @@ -1739,6 +1740,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_so=
ck *msk)
>  	subflow =3D mptcp_subflow_ctx(ssk);
>  	penal_cand =3D fastest && ssk !=3D fastest &&
>  		     subflow->avg_pacing_rate < max_pace / MPTCP_PENALISE_RATE_RATIO;
> +	if (penal_cand)
> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_PENALCAND);

[Severity: Medium]
Does this block trigger KCSAN data race warnings?

These lockless plain reads of TCP socket fields (tcp_snd_cwnd, icsk_ca_stat=
e,
tcp_is_cwnd_limited) execute under the MPTCP connection lock, while softirqs
may concurrently process incoming ACKs and update the states.

Do these need data_race() or READ_ONCE() annotations to meet kernel
concurrency standards?

>  	subflow->penalise =3D penal_cand &&
>  			    tcp_snd_cwnd(tcp_sk(ssk)) > MPTCP_PENALISE_MIN_CWND &&
>  			    inet_csk(ssk)->icsk_ca_state =3D=3D TCP_CA_Open &&
> @@ -1746,6 +1749,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_so=
ck *msk)
>  			    mptcp_snd_wnd_test(msk) &&
>  			    mptcp_penalise_throttle_ok(subflow);
> =20
> +	/* trace the penalise verdict, decided here after the selection loop */
> +	trace_mptcp_subflow_penalise(subflow, max_pace);
> +

[Severity: Medium]
Will this tracepoint log an inaccurate verdict?

If there is no window room to send (!burst), the code immediately below
sets subflow->penalise =3D false.

Since the tracepoint is emitted before this window limitation check, could
it log penalise=3D1 even when the penalty is later canceled?

>  	burst =3D min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
>  	wmem =3D READ_ONCE(ssk->sk_wmem_queued);
>  	if (!burst) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-mptcp_pena=
lise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com?part=3D4
