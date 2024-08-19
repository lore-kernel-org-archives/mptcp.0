Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12931EEA5
	for <mptcp@lists.linux.dev>; Mon, 19 Aug 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085870; cv=none; b=KJTeVsMAsyMt17LWDkPbRv7metNqzlyWYIIdL8R98ZCV0iOm/ns8JtOhq9avKceUfU6joeuAT/u0DCPCqgpTVm21FXtDFKXomsxZIbExnPRqkgJaYrQTm7j3WMETqgHfrB3FCr4wwaBv/QqUv6m2TRdKipa6/04Jcq7MDbV0ZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085870; c=relaxed/simple;
	bh=0G+I3c0Pg8cHwOd0VecZ7VBvGXB61xkoIzM6EDO/Cdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECYDkwGNuQJQvluz+18kMcedwXgXyQDAYCSj+gpQzXG8aecnUI6wP33nw6Xi5KEP8pJq0LQOvgCVGN1bTQ5GNkbci49L0tFZcPYeyCf6z+g3OE+CQuHPG1gAxDKomABtlsWKUR/66/MLa4d9C3KXJqjgTMXEs5o8d0HJfsYzFSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa2kuVOm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa2kuVOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A245C32782;
	Mon, 19 Aug 2024 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724085869;
	bh=0G+I3c0Pg8cHwOd0VecZ7VBvGXB61xkoIzM6EDO/Cdc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qa2kuVOmNsoMjly4sJPkmUlFxqvz2ql8gOs69eSGu/27AWafojnoVIYRl9D9AbYeH
	 VQO8quuMsdQqWRCQGAsLE0EXuw+5+JEGp+o0jgRIh56CBxQVvF+oYoshKsSgFCg7dk
	 oxdVSJzlmHlMUKVfTX5sO6l5QQStL9mclPi61Cth/69lZp5VOK1l3MOOfn0ZpMsInQ
	 1mSXbzU9Z1cVtXlOIfHz9o40LB5aacPFMbyYSTaMxr2p33NY5lA6ZUjzqCneZmanTz
	 /7pljE88Eq6N2xxUhs5MdmTaJUTv0+Yo++TAHXnUBLyW4fyUksKNJkdXxIUFhSDRh6
	 B4eEJ+jWTtyFg==
Message-ID: <d99e6231-e612-4890-8e86-acda40c9c25a@kernel.org>
Date: Mon, 19 Aug 2024 18:44:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 00/12] mptcp: pm: fix re-re-create the ID 0
 endpoint
Content-Language: en-GB
To: mptcp@lists.linux.dev
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
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
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 16/08/2024 13:01, Matthieu Baerts (NGI0) wrote:
> Even more fixes for the in-kernel PM :)
> 
> There are a few Squash-to patches fist:
> 
> - a partial revert for a previous Squash-to patch: probably fine not to
>   block the send of the original patch then.
> 
> - improve code coverage
> 
> - use the right ID with __mark_subflow_endp_available()
> 
> - small fix for the fullmesh case when re-adding the ID 0 endpoint
> 
> - set the ID for __mark_subflow_endp_available()

As discussed on IRC with Mat, I just applied 3 of these Squash-to
patches, to be able to send some patches upstream:

New patches for t/upstream-net and t/upstream:
- 5bc9b44ceee6: "squashed" patch 1/12 in "mptcp: pm: re-using ID of
unused removed ADD_ADDR"
- cdf9299d9049: "squashed" patch 3/12 in "mptcp: pm: only mark 'subflow'
endp as available"
- 09ed0d2ad732: "squashed" patch 5/12 in "mptcp: pm: fix RM_ADDR ID for
the initial subflow"
- Results: 2fda2724156a..1abc61ec2c0d (export-net)
- Results: a3cc6d5a9b3f..fa810ad2128f (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/d7dd870a1134787d390aa69db7ced0885136a864/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/4fc5ed8e59b495fb79d651028681d4eca5354284/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

