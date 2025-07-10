Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0A2E6D22
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169274; cv=none; b=pUqGm5LXb/a0X+DrAk+Ez0XfXPbIcAB5ZdNVQz6d2kVZirSxEHpnNO+Cs5lmyP8RkVRZQ3Nmu4ZAVb0A7Vxj67fdWoCbE7Kng/u1KweHc2iKge0uHNDNEP76o1pldh8O8F1Ra3mtKmtYEGJPEEU0BZVScdqUiMtbHcJ5WaelQc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169274; c=relaxed/simple;
	bh=mcX8TY/GQ4a3fbsv4mYCgV12yDzgEXA2ihS26RBhTjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dCMQnn6QkRv/NRB3EqMv0FBc5Zwb+xVBhEaPYDC4pJ/n0Fw6AZIhXFMu2S54D+r/CrxKLFsCZRiEMAF6wy7UKY6vd9ESw2MIEMp2sZsc3+7O71TwWmYdmiKQ78c/9gDoJ6frpxT5Y/9DCroWSl69PU2JC0IGZKCIbxW4NS/5yCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CENpikHG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CENpikHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74831C4CEF7;
	Thu, 10 Jul 2025 17:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752169274;
	bh=mcX8TY/GQ4a3fbsv4mYCgV12yDzgEXA2ihS26RBhTjE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=CENpikHGzWQc9NawgugxGmnxeeHUrwAqrZcXDQr54do+3GrqTLkKveslTTFQ1NNno
	 n0TlMQa+0Sn5oXlhkVROPx2tVstb/t8eXunES1kTJJ0rvfz83K8o4jZxJiI0WhWjwI
	 t+uYbJPlOUBOtcCEd66hcuBvH/6qryR0hw3T0XZRujnNHikB7ub8a4Cwt1A7ucKvxX
	 25tD44jBD7kww5sGknWj8fcv/j2WVqrOkQXZkXv+WAjc+aFuoFftI4TjSadgp1nYR5
	 Xa7q2Ha/AtW50VYK7OPktKtXd+lH2BU3/3jl3fAYO91HTzC4A1ohF6Zp0RmKYkaC7g
	 CS9yLTmcZj7Jw==
Message-ID: <2081948e-6236-4eae-ac43-989c776ae10f@kernel.org>
Date: Thu, 10 Jul 2025 19:41:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 mptcp-net 4/5] mptcp: track fallbacks accurately via
 mibs
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1752073685.git.pabeni@redhat.com>
 <b53a37c311ea75427dffb02bf92f09a3d58b36b0.1752073685.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b53a37c311ea75427dffb02bf92f09a3d58b36b0.1752073685.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 09/07/2025 17:12, Paolo Abeni wrote:
> Add the mibs required to cover the few possible fallback causes still
> lacking suck info.
> 
> Move the relevant mib increment into the fallback helper, so that no
> eventual future fallback operation will miss a paired mib increment.
> 
> Additionally track failed fallback via its own mib, such mib is
> incremented only when a fallback mandated by the protocol fails - due
> to racing subflow creation.
> 
> While at the above, rename an existing helper to reduce long lines
> problems all along.

(...)

> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 0c24545f0e8d..ee51d14ba510 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -80,6 +80,11 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
>  	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
>  	SNMP_MIB_ITEM("Blackhole", MPTCP_MIB_BLACKHOLE),
> +	SNMP_MIB_ITEM("DataFallback", MPTCP_MIB_MPCAPABLEDATAFALLBACK),

I see that you modified the enum, but not the exposed name. Is it
intentional?

  MPCapableFallbackData

And placed above with the others MPCapableFallback ones? same in mib.h?

> +	SNMP_MIB_ITEM("MD5sumFallback", MPTCP_MIB_MD5SIGFALLBACK),

Same here? (s/sum/Sig)

  MD5SigFallback

> +	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
> +	SNMP_MIB_ITEM("SimultFallback", MPTCP_MIB_SIMULTCONNFALLBACK),

Same here?

  SimultConnectFallback

> +	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
>  	SNMP_MIB_SENTINEL
>  };
>  
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

