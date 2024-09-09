Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D943C1758F
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900600; cv=none; b=GyNwyIuMslWHmn5H1tDD3RHmrAtrsHEBLMNaF4w8nE7nluO2DgbJrpAMPHTMCb6UNcUiD1dzSoh60VNt33wmU/8triODYgD95Es6/K4n+a95B00xgCIM1OW2xCWWR03+W2tvIr/oe26eRwUjB3hOmUDsYVaXoryfvLg2dH+yDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900600; c=relaxed/simple;
	bh=K8NXXZ8EDphiablOrAVv62Y4Z7F2Y79eN6OpjwJkoKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aya6RL4t2hjqkVked6xXrNVA6+FimB5rKhV7KZyECnh9t9oaL4etHZhYqsKdm2dwLioXseDxh2yFFX2iKyh5NZIiMxBMqv4UDjttvyplODrqP7j2fhT4aiD/bcJw79syWogqgsCfETPWddANqKezYE7blAMOWXfP/QNJpNT2ce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce0A9wc2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce0A9wc2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD14C4CEC5
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725900600;
	bh=K8NXXZ8EDphiablOrAVv62Y4Z7F2Y79eN6OpjwJkoKE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Ce0A9wc2fD9k9iWs84teof2mZe4YXUiFAWhrxrfAC0f56fBbS9lheHvoU+ZudbDEk
	 KYLhHRDvbYasy7V0qqOgHnWFapatCNTmnLMdJOE4X2vTYW0/egFyVXc1vlKUijTMSi
	 NOLTupI2kIKpQR5dzri8gq79wr+PYSlgqHB0XwFIdcOs6pflpBsC/okmefnx/kZW0v
	 8EjR29ZezkIJC6BjnOLOcVe6QkXMgjg8q9/QgNgAT/Nzd+Jdlgs2Vnqw0lOUbKT1um
	 rajgrgzijaHqgbqnNitkgucBX2OHq7I125ciq6LxcOlj+zKjtcblU/LkhNBlZrrLxS
	 Op8vhDttppxJg==
Message-ID: <86a8a9ee-1dd8-41f6-984f-240bf83ce596@kernel.org>
Date: Mon, 9 Sep 2024 18:49:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 0/3] mptcp: fallback to TCP after 3 MPC drop +
 cache
Content-Language: en-GB
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20240902-mptcp-fallback-x-mpc-v1-0-86d9170ddff7@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240902-mptcp-fallback-x-mpc-v1-0-86d9170ddff7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 02/09/2024 11:09, Matthieu Baerts (NGI0) wrote:
> The SYN + MPTCP_CAPABLE packets could be explicitly dropped by firewall
> somewhere in the network, e.g. with:
> 
>   iptables -t filter -A FORWARD -p tcp --tcp-option 30 -j DROP
> 
> The idea of this series is to fallback to TCP after 3 SYN+MPC drop
> (patch 2). If the connection succeeds after the fallback, it very likely
> means a blackhole has been detected. In this case (patch 3), MPTCP can
> be disabled for a certain period of time, 1h by default. If after this
> period, MPTCP is still blocked, the period is doubled.
> 
> This should help applications which want to use MPTCP by default on the
> client side if available.
> 
> This series has been validated by a new packetdrill test:
> 
>   https://github.com/multipath-tcp/packetdrill/pull/156
> 
> Some questions:
> 
> - Should we let the user changes the number of retransmissions (2)
>   before falling back to TCP? For TFO, the data are never retransmitted
>   in a SYN. Maybe that's different here? A sysctl knob could always be
>   added later on.
> - Should we globally disable all MPTCP connections if any retransmission
>   after the fallback is a success instead of only the first one? I guess
>   we reduce risks of accidents by only looking at the following
>   retransmission after the fallback.
> - Is one hour a good time for the fallback?
> 
> For later:
> 
> - The restriction could be done per oif (sk_dst_get(ssk)->dev), but we
>   would need to store it somehow, or per MPTCP entrypoint. Or let the PM
>   calling mptcp_active_enable() when a new endpoint is added.
> - Other cases could trigger mptcp_active_disable(): e.g. some fallbacks
>   or corruptions in the middle of the connections.

I suggest addressing these questions later. Due to some external
circumstances, it is not possible to have more reviews for the moment. I
think there is no need to block that longer, fixes can always be
addressed later on.

New patches for t/upstream:
- a09026a9e8c4: mptcp: export mptcp_subflow_early_fallback()
- 4216aa51fb10: mptcp: fallback to TCP after SYN+MPC drops
- d0c7c7172eac: mptcp: disable active MPTCP in case of blackhole
- 0fd52c49c60b: conflict in
t/mptcp-annotate-data-races-around-subflow-fully_established
- Results: 29da3bae8ab9..fc8995744495 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/ca4d36d160ee56fa9bd50dc0006ad34d454d8f48/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

