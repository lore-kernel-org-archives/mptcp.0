Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82523E358
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121362; cv=none; b=js5Zo5jnaUq4gdbIMABddX7IZ3w/CTCzClPTG2tOB4FkRgV8TvzqQYwL2XSvvRfzbeOAOsPncC8nzAtCnSrR2nOOCM2T763FGj99TQZaExlihaHopHh1JTLjDdoPR2fBFx1kM7sh8JDCEAUPkyzx28dFzaIhZHpEbPSjE45MuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121362; c=relaxed/simple;
	bh=gorUEuroUFFpjwiCmRhlLkIC9O9BfNNXQd1IlobeDYU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=srEDEOD2rRvcYPZ6pyWrJL+Q7JtqjXe4aQxjPMR6zwORJiwlYJMf7TfsLKPiDBgqn12/bEV56K0u7y31SnqZqq4r7FKjFipYN1M5ktDTw3+9C5gLi3wemYkYV3aCWqOpOKeZ/VFQ5YuEqaubz8sVVTeIM0uYAjaYBQvtZuTf7/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUIsbct3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUIsbct3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6EB1F000FF;
	Fri, 11 Sep 2026 10:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789121361;
	bh=5DZngVEwpsnGJGFVnu1S/MrW3MBcuPxLtEe/ua8hbVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hUIsbct3Qall2YnKPsZDjBDcD3WKPDRzpWP77v4TMVSrpCfaBp9osJ8DOEWkKboMg
	 o0n/Q8mzxDhIvT9coY+XiqMOjfCy7x6XGKr04+p79p7paPGIEauTu/zJwt1oAOImgB
	 grx+Y/1B57azOLkEiCU3lX99O0rRSFred6bRmqAQd92MU8vEatvjXlwC3LE1Gicqtw
	 hmwRlzATAFs6Ijc/Wn7+fcfVFZ3Dx4cZVlkzdWloaoCJWaLAWQPTYmB/D5D8Wwmew3
	 hA5Xmurblkn00JWQSNeFQWruVWB3/JGIh5zaOZxRTAImWolhSFdNrQ4gVSeLYfUkBO
	 aUWOxEUih7cWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v4 4/4] mptcp: sched: add penalise counters
 and tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shardul Bankar" <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260911-mptcp_penalise_send_v2-v4-4-820f2be4a8fe@mpiricsoftware.com>
References: <20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
 <20260911-mptcp_penalise_send_v2-v4-4-820f2be4a8fe@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 10:09:18 +0000
Message-Id: <20260911100920.CE6EB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] TP_fast_assign() evaluates a macro containing a WARN_ON() side e=
ffect, violating tracing guidelines.
- [Medium] Lockless reads of TCP socket state in tracepoint assignment lack=
 data_race() or READ_ONCE() annotations.
--

commit 5ddd66e7676359b892e5316c068af949834ad5ce
Author: Shardul Bankar <shardul.b@mpiricsoftware.com>

mptcp: sched: add penalise counters and tracepoint

This commit adds observability for the cwnd-halving penalty in MPTCP.
It introduces two new SNMP counters, CwndPenalised and PenalCandidate,
along with a tracepoint mptcp_subflow_penalise to track subflow selection
and pacing dynamics.

> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
> index 22882bd034593..f16e04b81322d 100644
> --- a/include/trace/events/mptcp.h
> +++ b/include/trace/events/mptcp.h
[ ... ]
> +	TP_fast_assign(
> +		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> +		__entry->pace =3D subflow->avg_pacing_rate;
> +		__entry->max_pace =3D max_pace;
> +		if (ssk && sk_fullsock(ssk))
> +			__entry->cwnd =3D tcp_snd_cwnd(tcp_sk(ssk));

[Severity: Medium]
Does this inject a WARN_ON() side effect into the tracepoint?

The tracepoint assignment evaluates the tcp_sk() macro, which contains a
WARN_ON(_ptr->sk_protocol !=3D IPPROTO_TCP). This injects a side effect into
TP_fast_assign(), causing the warning condition to be evaluated only when
the tracepoint is enabled. This violates the core tracing guideline that
TP_fast_assign() must not contain side effects to prevent behavior from
diverging based on tracing state.

[Severity: Medium]
Are these lockless reads of the TCP socket state missing annotations?

The tracepoint mptcp_subflow_penalise is invoked from
mptcp_subflow_get_send(), which holds the outer MPTCP socket lock but
not the subflow's TCP socket (ssk) lock. Here, sk_fullsock(ssk) reads
sk->sk_state and tcp_snd_cwnd() reads tp->snd_cwnd.

Both fields can be concurrently modified by the TCP stack (e.g., during
ACK processing) under the ssk lock. Reading them locklessly without
KCSAN suppression (data_race()) or READ_ONCE() constitutes an unmarked
data race.

> +		else
> +			__entry->cwnd =3D 0;
> +		__entry->burst =3D burst;
> +		__entry->penalise =3D subflow->penalise;
> +	),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-mptcp_pena=
lise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com?part=3D4
