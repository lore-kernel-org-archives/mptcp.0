Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8259C302CDF
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943761; cv=none; b=PzF2dJ3/+3OUaWPZ4S07n2b0h1LsLKpk5y8B2PBO1XxqE9PXtkFemjW2+mjhQ5vHJUzyYXldc0AU2rK/kcsQzd+xxg81DFb1rZq1p/jUfJPFcahXhsCoPFW3RdcPnROs72IkKgH0CfRfougpieAIU5z3zlwQx0vD8LJQRFQGV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943761; c=relaxed/simple;
	bh=iPStuyeZ+T0D4v/QAr2fNiio6VYozNEhJMV43DsNVAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A72maRBSFUM9UnMVojicvVHYnJu/izerHTANhxmErWwNz7xuAlrFHC57M6dfalF69OcIzcPm/1wmDQKeiE6QOQZE4/9Wl9O2glw8cUmOr73LnuHGJ8kMjnXckW9aA4rfLA8effUvWXre/VHpYFQStt7rZ0c5oBhfluPZDoSYGz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKtuBXgb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKtuBXgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43C2C4CEF8;
	Wed, 12 Nov 2025 10:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762943761;
	bh=iPStuyeZ+T0D4v/QAr2fNiio6VYozNEhJMV43DsNVAY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=sKtuBXgbKqFGsUEFU3x+AT3MlLMt/8FR+y7ININpnFHSfCIStNw1bvKWcGtRAMZYJ
	 4bth3IKk8T4U08s/+5h0o1P1SrBlzE7TkY1lsqSTtEoUkFJhla3+BBVetnV7rhw1zN
	 DAieJ404dAVey21QroPPYxqDfU0HwKACmxRrJK3nNfKoeYirCwUxPqA4XSANfXihzB
	 Fqya/PMT0GeYr6oq1izTrtapvZVuJ3o/SUVGooH013zC7gQrQjiJJZN2hoiY8FpNZm
	 uarXA+qNCjqX4IK1B1slWnzhctKmBxj46IJHO11fCQzcv47w/Nirz1lvvUDCTXTJue
	 t5vBKz8UxoirQ==
Message-ID: <9b0fcb69-e8b5-44fa-b994-c3f195d17b96@kernel.org>
Date: Wed, 12 Nov 2025 11:35:58 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 0/4] selftests: mptcp: get stats just before
 timing out
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
 <db3ad087c99a9b625dc257e035cc271863cd083e.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <db3ad087c99a9b625dc257e035cc271863cd083e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 12/11/2025 11:02, Geliang Tang wrote:
> Hi Matt,
> 
> On Sat, 2025-11-08 at 15:20 +0100, Matthieu Baerts (NGI0) wrote:
>> A few patches to improve the selftests in case of issues:
>>
>> - Patch 1: a fix to properly kill background tasks.
>>
>> - Patch 2: avoid taking the same packet trace twice.
>>
>> - Patch 3: wait for an event instead of a fix time.
>>
>> - Patch 4: instead of using 'timeout' and print the stats after,
>> another
>>   internal timeout is used: if it fires, it will print stats, then
>> stop
>>   everything. This avoids confusions around stats in case of timeout.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> This set looks good to me.
> 
>     Reviewed-by: Geliang Tang <geliang@kernel.org>

Thank you for the review!

Now in our tree:

New patches for t/upstream:
- 5bdd05d66b06: selftests: mptcp: connect: avoid double packet traces
- 070800d3509c: selftests: mptcp: wait for port instead of sleep
- 7bf5a769dde9: selftests: mptcp: get stats just before timing out
- Results: ee7fdf18febf..6ed800e9ef97 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/03bd0df93bb84cb9894db56697eea33b27d2f1d9/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

