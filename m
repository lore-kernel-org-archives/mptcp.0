Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80E62D3ED2
	for <mptcp@lists.linux.dev>; Thu, 21 Aug 2025 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770271; cv=none; b=q86HlIa8Hn3f7sEXbO3CWeEjfxX3A3aMm1VwWbjg2b/nhF2vDclUmPsFVCl/nfYyGX4W8/xqTAUiNV3ACU+2q8Veb3Xp3rQ9H7298AHs2ccx/B3bbOyLw90UqVEnF/zan1isf2g8vu2Wf00T0VkkiMjWFHo/YkgcVYMvR5FLB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770271; c=relaxed/simple;
	bh=JGvPQWDxV0f+zL68JzPelNwSjopdivm61S0WQQLjjiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYZs2njxSJ07Hybe2xoIy59E6i+tKvRPUorKluQDyDU7pwvQWXWsK3AzwNIFvboiu2mJdkR9dDM6JuuYyAo3wgPJO3ylpWYM4eRUB3RZY0372IzpuEN7Ox8TS0HP8vLS3XKLQnaqYUL42kGgqGYC+XCNghTomqHNrMq2mdzmUBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQNFYt1k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQNFYt1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98631C4CEEB;
	Thu, 21 Aug 2025 09:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755770271;
	bh=JGvPQWDxV0f+zL68JzPelNwSjopdivm61S0WQQLjjiY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OQNFYt1kGR4tvhb35gyEF71HRErQlMJ8iiC4pxG1Wz/8edxjUGeOFjc6YJZdxDI4O
	 N7qc0MPJ1+LjlJdq00/vRiCt1ax0jDS/jXh+YIC4/iEYtHK5bAxLfMs0IVhVEF//Vo
	 oeiiME1ZHBogDLsaE3i23+nmWeYyBV/cq/W5S5XSkO0VH203XegKXLWfYKUHiXhYfP
	 tzZZSenTrA+p70Dl3Cw9jneRym2mAdiMmTnq52Ov0u7kG3pe5sshHCRtc2VE0cPICB
	 TV+BGMW13/wU7KeiPs4glmrnfP36KjsLugRqIx2UoEjQY8lDxW5jyx8662EIFU6g0g
	 zxAg9Chfj+o/g==
Message-ID: <81664b69-0110-4ac5-926d-295fef8ca072@kernel.org>
Date: Thu, 21 Aug 2025 11:57:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 00/10] selftests: cover more MPTCP socket
 options
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1755680616.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1755680616.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for looking at that!

On 21/08/2025 10:54, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v2:
>  - IP_FREEBIND/IPV6_FREEBIND are set in do_getsockopt_transparent, fix
>    it.
>  - Use "for" loops in mptcp_sockopt.sh.
>  - Move "add IP_TOS socket option test" out of this set.
>  - some cleanups.
> 
> This series significantly expands MPTCP socket option test coverage
> by adding validation for 10 more socket options:
> 
> 1. SO_REUSEADDR/SO_REUSEPORT - Test socket reuse capabilities
> 2. SO_BINDTODEVICE/SO_BINDTOIFINDEX - Validate interface binding
> 3. IP_TOS - Verify Type of Service handling
> 4. IP_FREEBIND - Test free address binding
> 5. IP_TRANSPARENT - Validate transparent proxying
> 6. IP_BIND_ADDRESS_NO_PORT - Test deferred port binding
> 7. IP_LOCAL_PORT_RANGE - Check local port range restriction
> 8. IPV6_V6ONLY - Verify IPv6-only sockets
> 
> Each commit systematically adds:
> - Setsockopt/getsockopt operations in mptcp_sockopt.c
> - Dedicated test cases in mptcp_sockopt.sh
> - IPv4 and IPv6 coverage
> - Error handling and edge case validation
> 
> The new tests verify that MPTCP correctly propagates socket options to
> subflows and maintains consistent behavior across address families.

I don't know if the last sentence is correct: if I'm not mistaken, it
looks like the new code "only" set and get some socket options, no?

If yes, that's not enough to me to verify a socket option is doing the
expected job. I think it might even be better not to include such code
giving a false sentiment of "it's fully tested" (+ more code to
maintain). All these options are supposed to affect the behaviour
somehow: a test should then mainly validate that, and check this
behaviour is similar to TCP.

In other words, such tests should be similar to what you did with
TCP_MAXSEG in Packetdrill:

  https://github.com/multipath-tcp/packetdrill/pull/161

I think that when validating a new socket options, the following should
be checked:

 - Comparison with TCP: the behaviour should be as closed as possible
 - set/get before and after the connection
 - behaviour on the client and server side
 - important: checking the new expected behaviour

Checking all this should probably be easier with Packetdrill, especially
to validate a behavioural change. But it might not be always possible,
or best suited, like with IP_BIND_ADDRESS_NO_PORT and
IP_LOCAL_PORT_RANGE which are "properly" tested in:

  tools/testing/selftests/net/mptcp/ip_local_port_range.c

What do you think?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

