Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF7F15AF1
	for <mptcp@lists.linux.dev>; Thu,  9 May 2024 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265550; cv=none; b=L+K87EvcLQYdadvX8iBM3LwMLiyVkKZUSN2Onex3ZBL/flVWCGcWo11UaMRvt+kb2IT3A0TifPOP5UUk1WqWcDu7qlqQ3adpF2GEEHUPxYX5hQAC82mJjfotTeiJDoyOzAT7VW7Pn+BNg8gB3wqWu6IHguRQs+77++lFWho23mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265550; c=relaxed/simple;
	bh=F2rM6FnBqmVCqtVn0JCk+NWhBWaPzNfMcxgwjshhm/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fD4z5UaI2oK1YEB50Qt6Y2hfK6XQHHIDaUPCF000RoMk/Z1RXFJvuw6ofsjNYSm6XKqk/HYMY3t84CT9Tj/M1yDtcJ5u8f5wo/q6JQ5jS27qq4Hv2DifiBxt1nTZnF5LOUJGsE8FQmdB0mpffZmotxsbOuaFklG6+d7FEPIG7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubUCj+M4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubUCj+M4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7920CC116B1;
	Thu,  9 May 2024 14:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715265549;
	bh=F2rM6FnBqmVCqtVn0JCk+NWhBWaPzNfMcxgwjshhm/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ubUCj+M4uxR+A8dSw8QWh6UwEXVkKrfbNjkDSX+thIaymVVKD9KiF6Ax+4izz/rM4
	 lh/rDIrjEYIoPdb1eNWk7s1Yc9NUQ4h6fjiwqJWz1aJBivr2CnFraE7J5n8zbJSOCE
	 nQvnofbTf7Eo1VCeDZJL8hrR4SPqoU44rfLL8lBv5hhI+1ut0MGjtMccJu42PyE/yQ
	 fURh39dJcGTTX6BvTWrLcN5lB4+AZhewA6uSOYejWKFyUvB5zmkrf0WEWECt/0xawb
	 BLjJL51Hv80tcEPBYJ8SdUjpdHVywV5FH4RES2NJvHguXaG8v6KSQCXRzmkh72ptrV
	 O4guz9Ti6bk8A==
Message-ID: <89dc0020-6bd8-4cce-8b8c-8b73c22c386e@kernel.org>
Date: Thu, 9 May 2024 16:39:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: new MPTCP subflow subtest &
 improvements
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
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
In-Reply-To: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

(only with MPTCP ML in cc)

On 07/05/2024 12:53, Matthieu Baerts (NGI0) wrote:
> In this series from Geliang, modifying MPTCP BPF selftests, we have:
> 
> - SIGINT support
> 
> - A new macro to reduce duplicated code
> 
> - A new MPTCP subflow BPF program setting socket options per subflow: it
>   looks better to have this old test program in the BPF selftests to
>   track regressions and to serve as example.
> 
>   Note: Nicolas is no longer working for Tessares, but he did this work
>   while working for them, and his email address is no longer available.
> 
> - A new MPTCP BPF subtest validating the new BPF program.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Geliang Tang (3):
>       selftests/bpf: Handle SIGINT when creating netns

Regarding this patch, do you mind looking for a new version that is
generic as requested by Alexei, please?

I guess he meant adding a new helper in network_helpers.c doing "ip
netns add" + "signal(SIGINT)" + "open_netns()", and using it everywhere
"ip netns add" + "open_netns()" are used. (I guess you will need another
helper to "close_netns()" + "ip netns del" + remove the signal handler
or the netns name.)
Be careful that sometimes, more than one netns is used.

>       selftests/bpf: Add RUN_MPTCP_TEST macro
>       selftests/bpf: Add mptcp subflow subtest
> 
> Nicolas Rybowski (1):
>       selftests/bpf: Add mptcp subflow example

For your information, I modified our tree to apply comments from Alexei:

New patches for t/upstream:
- 12609b68c8d9: tg:msg: clarify the commit message
- a4ad7c6dee6a: Revert "selftests/bpf: Add RUN_MPTCP_TEST macro"
- f457d8911a38: conflict in t/selftests-bpf-Add-mptcp-subflow-subtest
- 5072ff915f8d: Revert "selftests/bpf: Handle SIGINT when creating netns"
- 9df135860724: conflict in t/selftests-bpf-Add-bpf-scheduler-test
- 8ef1339edc8a: conflict in t/selftests-bpf-add-bpf_first-scheduler
- 2f5ced304cc1: conflict in t/selftests-bpf-Add-bpf_bkup-scheduler
- e9bafe786620: conflict in t/selftests-bpf-Add-bpf_rr-scheduler
- dca93e3c7e9a: conflict in t/selftests-bpf-Add-bpf_red-scheduler
- 5349d85a8c73: conflict in t/selftests-bpf-Add-bpf_burst-scheduler
- Results: 304693999ba6..b74adae98e0d (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/715c505a46ae8394e40fdeb54e0ecea27f95dc5d/checks

I will also modify the tree not to remove MPTCP_SCHED_TEST() macro as
asked by Alexei.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

