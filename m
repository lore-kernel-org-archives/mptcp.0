Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB9722578D
	for <mptcp@lists.linux.dev>; Thu, 20 Mar 2025 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491923; cv=none; b=nyTXvEVysg4TeozEYvtioVNjXAtzVReQYh+JAYz/VDtL/dmFDyRV+cGESVt2l8LAPfeRXDTetg+gmtI7Mqc6UOEoTLOSjgxwUVY7sYq8F6aD3xgoAVzOahe6ToRllqgQFmxm2RzGTPLh/A3ubfQ21IajOu6Zk/2N9uQcfJiMaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491923; c=relaxed/simple;
	bh=8h1whxgMqOpRoMdYWE2AeLxThKwo1UGbD9kF9kuYWsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0Ajx7RRx1scspjqBkdPovxsCKoydPSTrKiqTQAcjqV/NB8a+tVEj/CbcxGyJdEzQfFkbfCeh+WlWGIPNZKvFoHhKwpg5H+1kEbNg1TdrpxQGikuc5FsotSC/1w/7g2/iq6C7Zcan8fZOW3agdmIdn7z+giEkUVYDI6GqMac52M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMQzFXRX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMQzFXRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CD5C4CEE8;
	Thu, 20 Mar 2025 17:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742491922;
	bh=8h1whxgMqOpRoMdYWE2AeLxThKwo1UGbD9kF9kuYWsA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DMQzFXRXljzeEr98brYkwBdLLUQ7YEs+WDvAksb5SNYR+APL5+JQn3YRLSAUm8cCq
	 0OtqKG6nfxD2iZ0yxL7am9qkdv6rCIz6/0Nhw6pYh/9QHN/9uqJgMA9rU78dz/KHRo
	 SSMpBHULhQm9L1897Gu6C5IRl+bMtgL7Qk3HoxDxgUlWBBSqObzUihdmFRMIR/fPnu
	 zrJenpZtz1V7fOzWoCffme9VNQDU9vt9XyGUooSIXvSpit7XrsMwbr2IDS+3BsMQFW
	 y6IlDfkvIpjJ/qCpaz3lre1pruS00gfafOAgRWZFMT1cXIpIGfNubkKZ04Ly+LoFSp
	 VafOLMvIi5unA==
Message-ID: <e00f32de-81f1-4429-b9d4-7b1a0f6507d8@kernel.org>
Date: Thu, 20 Mar 2025 18:31:59 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v1 0/8] cleanups for bpf schedulers
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1741226722.git.tanggeliang@kylinos.cn>
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
In-Reply-To: <cover.1741226722.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 06/03/2025 03:15, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> 1. Add validate_scheduler.
> 2. Drop mptcp_sched_find in bpf_mptcp_sched_init_member.
> 3. Drop mptcp_sock_type and mptcp_subflow_type.
> 4. Move netns_new() out of sched_init().
> 5. Use .struct_ops.link instead of .struct_ops.

Thank you for this series and the reviews!

Now in our tree (feat. for net-next for the first patch):

New patches for t/upstream:
- d4c306a43b3f: mptcp: add mptcp_validate_scheduler helper
- Results: f919d66019d7..3401ddbacc79 (export)

- 59ab4747927b: "squashed" patch 2/8 in "bpf: Add bpf_mptcp_sched_ops"
- 38fdfd5cba1b: tg:msg: adapt 'bpf: Add mptcp packet scheduler struct_ops'

- a1aaa0e29d01: "squashed" patch 3/8 in "selftests/bpf: Add bpf
scheduler test"
- 99b384565fb2: return directly as suggested by Mat

- 354174f5423a: "squashed" patch 4/8 in "selftests/bpf: Add bpf_first
scheduler & test"
- 7f16e3788029: "squashed" patch 5/8 in "selftests/bpf: Add bpf_bkup
scheduler & test"
- 8d85ef2f3be9: "squashed" patch 6/8 in "selftests/bpf: Add bpf_rr
scheduler & test"
- 72ecea93b815: "squashed" patch 7/8 in "selftests/bpf: Add bpf_red
scheduler & test"
- 16789699fd1b: "squashed" patch 8/8 in "selftests/bpf: Add bpf_burst
scheduler & test"
- Results: 3401ddbacc79..35f3f56f1201 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/0404035380f85690b46bcb554e872f638ca9ee56/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

