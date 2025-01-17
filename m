Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0931E17E
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 00:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737072798; cv=none; b=pLKcP5gT2xrPSFneHeCUzSDpOABPGF4WhCX3OH3NR9szF+5r3BIKgvvT13Md6Si0T1Szraz6DQMKBppY9R/6n123OlpQYr0xSs/k6qQdc1efr+hhQpjF9RMGp/uYQT0DxFcHo8KYtWtpmqddns5hLybnn8Ecaw2tDx43IZYUiRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737072798; c=relaxed/simple;
	bh=peAUdZ+ypXhlBpQ/cjyLH+HUSnn3PwgODntCVIweqaU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FNPD8pCUZM4wQWuyrX0DPvftB/bOl2kV62AmXpGPOzNuJLcxhzG2t/IV/DgqazCk9NFrRlNB2QHOkdMAZ37S1e8OhdZIEoBq0/c00BfDB6Nv0UvX6FFh0ARsA6FuSbInhA7mcogMnuFL0vYnrXzHj+5cSWkzGwbWA8OWvwl5F0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXgaLb1c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXgaLb1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EF4C4CED6;
	Fri, 17 Jan 2025 00:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737072796;
	bh=peAUdZ+ypXhlBpQ/cjyLH+HUSnn3PwgODntCVIweqaU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bXgaLb1cyZQPQ24kKiyJ/uZ11gGf/BU+NonGA2Y17aR3mk/S0vl7jJrc6ETW3Y2n2
	 m6vF4/NbAdoUH5CjGrl4Q4seMT81tLV1bQiBfu02p7u8WAkGYCSHivEExPbMQx7nxP
	 RbcnAHE1hFQtPUvSgvmnFnOSi1TEecKTuA0R93LqK9SvHuxuE8oPg2ajinJ31ZNgKP
	 /pV5YFkYxjll2V6WKHh7k/Rl9ceVdjO5Cj4oLEApFJMgWTnl8X8+AsxegaaNn29KA2
	 HLfpUYCcj4EOKMrYzUtR3pVoCm9VIiTgwKLcQ15SyJ51YRoS8AW2BPNsZsS27SX+3r
	 lB+zK27nDmWBQ==
Date: Thu, 16 Jan 2025 16:13:15 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/3] mptcp: blackhole: sysctl SYN retrans +
 fix conditions
In-Reply-To: <20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org>
Message-ID: <99988d16-43a3-bdd3-c9e7-ccc992570eb2@kernel.org>
References: <20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 14 Jan 2025, Matthieu Baerts (NGI0) wrote:

> Recently, I found a network having weird behaviours with MPTCP packets:
>
> - The first connection to a server had a successful 3WHS, then MPTCP
>  options got stripped off.
>
> - The next one had the first SYN (with or without MPTCP) and 5
>  retransmissions dropped, before being apparently intercepted and
>  proxied to the end server.
>
> - (The next ones were sometimes intercepted, sometimes not, or dropped
>   at the beginning. I'm trying to find out which kind of "optimiser" is
>   causing this.)
>
> The result of this was a blackhole being "wrongly" detected, and no ways
> to force connections with quite a few SYN drops to finally use MPTCP at
> the end.
>
> In this series, we have:
>
> - A small fix for the doc.
>
> - A new sysctl to change the number of SYN retransmitted with MPTCP
>  options before falling back to TCP. The modification looks simple
>  enough to still be sent to netdev before the closure I think.
>

Hi Matthieu -

Patches 1 and 2 LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> - A fix to only turn on the blackhole protection only when the first SYN
>  retransmitted without MPTCP option is accepted, instead of any after.
>  The blackhole feature was supposed to do that from the beginning, but
>  a check was wrongly placed. I think we should consider this as a fix,
>  even if there are also risks of not detecting a blackhole if the first
>  SYN retransmitted without MPTCP is dropped by accident. But that seems
>  more unlikely for an "MPTCP firewall blackhole", and I guess not all
>  future MPTCP connections will behave exactly like that. It sounds then
>  safer to reduce the possibilities of enabling the blackhole protection
>  by accident, and apply this patch.

I have one comment on patch 3, see my reply there.

- Mat

>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (3):
>      doc: mptcp: sysctl: blackhole_timeout is per-netns
>      mptcp: sysctl: add syn_retrans_before_tcp_fallback
>      mptcp: blackhole only if 1st SYN retrans w/o MPC is accepted
>
> Documentation/networking/mptcp-sysctl.rst | 18 +++++++++++++++++-
> net/mptcp/ctrl.c                          | 25 +++++++++++++++++++------
> 2 files changed, 36 insertions(+), 7 deletions(-)
> ---
> base-commit: 9336324d1aec351496e048ec5b6bbda07944ad16
> change-id: 20250114-mpc-no-blackhole-526a61ea0334
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
