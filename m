Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A821F95A
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124426; cv=none; b=hDpcMVfokOHwhxq6jzJvXesVLZq83VUxdYbN9dNt8BRgUhptNaJEZCGwbG+W+AvtkBZ+3//Dle0WlaE92vKUUeSbmin5qAPcCVvQHJWXo2yxIRU8oCualcwnhaQOAJHDC0SJjQlXqbVqnxU3SX4L5RLCAfzm5r1iXTZ2QnJbY00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124426; c=relaxed/simple;
	bh=0z+SZUtfssSS8PYqgK9/T7Bm1X5L1dbhjGXJTdSE0k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBPxOTlLaClEjwAE/ftoTRJd0hpfrjwq/xvNX1UQmZY6UPFgdkeHIcQgCTn16vxpuYjNtd3rpwxjqyMzJFqFSM0dXgwBG4SZj3EDBME2S6Dz36yO+H3TVkC80K/IMCNdQ+88c157Gm3oHyRh8sAMRKqb3Qbs0cDcX/S5GU9qvXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGo8MzUZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGo8MzUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E619C4CEE1;
	Fri, 17 Jan 2025 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737124425;
	bh=0z+SZUtfssSS8PYqgK9/T7Bm1X5L1dbhjGXJTdSE0k0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TGo8MzUZjuG2KpO7fuGDvwKijILtbylSCwrxDwcY2oYPA4i9N37K007kKPoOJQlFK
	 XjK9J+2mIP9rmw8/7lRWQyziLZztaVLVwsUiyWutLvRgmlgHooz0CVVim8WxMVw5lD
	 xH6RBqZOZAVuM1DIStwS9TfGJF1c4MssoknKeRDyZ8k0Jg57C9/GQELLHYaaiilAFX
	 8uPJxFdqz7pLz+4Qx09UK8Os4M13+SaeIur3eVVLxbml+wfL1LBexjBrHptlh2/KwI
	 6cLcp7jrkncyYKGdi58sQDGhZpBaSr3jOLKnE9+9X5oZRGrRetbkxyLNdasj2PN8P/
	 OREIzyUlhjZzQ==
Message-ID: <34877829-ddd6-4d2d-858e-d057da9c1dba@kernel.org>
Date: Fri, 17 Jan 2025 15:33:42 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 0/3] mptcp: blackhole: sysctl SYN retrans + fix
 conditions
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org>
 <99988d16-43a3-bdd3-c9e7-ccc992570eb2@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <99988d16-43a3-bdd3-c9e7-ccc992570eb2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

H Mat,

On 17/01/2025 01:13, Mat Martineau wrote:
> On Tue, 14 Jan 2025, Matthieu Baerts (NGI0) wrote:
> 
>> Recently, I found a network having weird behaviours with MPTCP packets:
>>
>> - The first connection to a server had a successful 3WHS, then MPTCP
>>  options got stripped off.
>>
>> - The next one had the first SYN (with or without MPTCP) and 5
>>  retransmissions dropped, before being apparently intercepted and
>>  proxied to the end server.
>>
>> - (The next ones were sometimes intercepted, sometimes not, or dropped
>>   at the beginning. I'm trying to find out which kind of "optimiser" is
>>   causing this.)
>>
>> The result of this was a blackhole being "wrongly" detected, and no ways
>> to force connections with quite a few SYN drops to finally use MPTCP at
>> the end.
>>
>> In this series, we have:
>>
>> - A small fix for the doc.
>>
>> - A new sysctl to change the number of SYN retransmitted with MPTCP
>>  options before falling back to TCP. The modification looks simple
>>  enough to still be sent to netdev before the closure I think.
>>
> 
> Hi Matthieu -
> 
> Patches 1 and 2 LGTM:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

I already applied these two patches:

New patches for t/upstream-net and t/upstream:
- 34dc1c307f30: doc: mptcp: sysctl: blackhole_timeout is per-netns
- Results: 1b76b0bd2522..551c1dba2a68 (export-net)
- Results: 2a6dfa001e66..2d16bea74b90 (export)

New patches for t/upstream:
- 5fb87b001602: mptcp: sysctl: add syn_retrans_before_tcp_fallback
- Results: 2d16bea74b90..b7be33140cc3 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/70769bbce0f766c3583cb1caa791722685884f19/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/caa6490e85f954f97ad955a2496c1b1297efee89/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

