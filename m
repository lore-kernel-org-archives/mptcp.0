Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC11B3B47D5;
	Sat, 12 Sep 2026 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789205331; cv=none; b=hlHEV4IgkIzD9IrwZUx/MkQUw++2dQ9zagVHOanjkMSEK51egCP+7Et3AEg0G9JkfZHYPkfg+8JcYxZq928AZxLeckaGGIzFN4EYC2D4hJlt7sUp/wS/NQQdGep0FywfiIN9bRGyqw22mW0giw9J+iI1alLisYET/2DWHo+Bddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789205331; c=relaxed/simple;
	bh=hsHZPbHlPlBEmzivqVQMvSSuiORdsyC0qlaXSPnPHx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ju1ZE/tKxyHHx2NTRbgHuqHQC2d6k03g1yWiwYn2BEpJpNOZAg/kCUFHRuNmR1LEWXywEiDjqp9Qc2CaGmOg/BLKk+JuUOVbc0d0msofRpool4a66EViPZxOqFFf01iwR+XoyCtE4IpVmN9Fmje5PIRS6Ile/icwuLqkXGI9sXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyT/9g+y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyT/9g+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D301F00898;
	Sat, 12 Sep 2026 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789205329;
	bh=KyBDOKb2XC4qNx78w1Q+XyZq+awzI8ioCi5GQLwC7QY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IyT/9g+yjgrdr8VeyId5uFyAr5xD2xHO9YfLFpXKTcQ2KZ7697WPfAP2hwcdZXvfG
	 FaJ3w7BQ7+1gdY/+w3qXNXFk+6d6vxUV+KZIjRb31Kq53DMdgDLRNMwXc2GQNqYV46
	 mQJhCB0vb2uZfSpFPKN6siE3RlnkR0ejdsJoRI+ibT81yuYcl1AkBP+1G9DhWp1wF+
	 HR2X6Vv9EKoe7uv4WTZr5PKJHJauxD/7viMhiK58nRL/8sfMlrt9VdLDbqVhf9rB7/
	 mCspxwhc3MgIoQjo7KTWAh5CInMuh8Nz9u6MuG0HqdbUzaJrwxjDqlWo2DKS0OKF/N
	 vPoagwnYJupKw==
Message-ID: <767ffb21-9465-4ef5-9e12-ac94f04180f8@kernel.org>
Date: Sat, 12 Sep 2026 11:28:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 4/4] mptcp: sched: add penalise counters and
 tracepoint
Content-Language: fr
To: sashiko-reviews@lists.linux.dev,
 Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
References: <20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
 <20260911-mptcp_penalise_send_v2-v4-4-820f2be4a8fe@mpiricsoftware.com>
 <20260911100920.CE6EB1F000FF@smtp.kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260911100920.CE6EB1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 11/09/2026 12:09, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] TP_fast_assign() evaluates a macro containing a WARN_ON() side effect, violating tracing guidelines.
> - [Medium] Lockless reads of TCP socket state in tracepoint assignment lack data_race() or READ_ONCE() annotations.
> --
> 
> commit 5ddd66e7676359b892e5316c068af949834ad5ce
> Author: Shardul Bankar <shardul.b@mpiricsoftware.com>
> 
> mptcp: sched: add penalise counters and tracepoint
> 
> This commit adds observability for the cwnd-halving penalty in MPTCP.
> It introduces two new SNMP counters, CwndPenalised and PenalCandidate,
> along with a tracepoint mptcp_subflow_penalise to track subflow selection
> and pacing dynamics.
> 
>> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
>> index 22882bd034593..f16e04b81322d 100644
>> --- a/include/trace/events/mptcp.h
>> +++ b/include/trace/events/mptcp.h
> [ ... ]
>> +	TP_fast_assign(
>> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>> +
>> +		__entry->pace = subflow->avg_pacing_rate;
>> +		__entry->max_pace = max_pace;
>> +		if (ssk && sk_fullsock(ssk))
>> +			__entry->cwnd = tcp_snd_cwnd(tcp_sk(ssk));
> 
> [Severity: Medium]
> Does this inject a WARN_ON() side effect into the tracepoint?
> 
> The tracepoint assignment evaluates the tcp_sk() macro, which contains a
> WARN_ON(_ptr->sk_protocol != IPPROTO_TCP). This injects a side effect into
> TP_fast_assign(), causing the warning condition to be evaluated only when
> the tracepoint is enabled. This violates the core tracing guideline that
> TP_fast_assign() must not contain side effects to prevent behavior from
> diverging based on tracing state.

This can be ignored: this WARN is only in our tree (debug to catch dev
mistakes) and is harmless here.

> [Severity: Medium]
> Are these lockless reads of the TCP socket state missing annotations?
> 
> The tracepoint mptcp_subflow_penalise is invoked from
> mptcp_subflow_get_send(), which holds the outer MPTCP socket lock but
> not the subflow's TCP socket (ssk) lock. Here, sk_fullsock(ssk) reads
> sk->sk_state and tcp_snd_cwnd() reads tp->snd_cwnd.
> 
> Both fields can be concurrently modified by the TCP stack (e.g., during
> ACK processing) under the ssk lock. Reading them locklessly without
> KCSAN suppression (data_race()) or READ_ONCE() constitutes an unmarked
> data race.

Can be ignored here for the tracing: TCP is doing the same in
include/trace/events/tcp.h.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

