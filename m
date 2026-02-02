Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A191A9F88
	for <mptcp@lists.linux.dev>; Mon,  2 Feb 2026 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028085; cv=none; b=D/vVbBIrHoyu0VaXDuhRr/wdNP/rxk6cmUXUuc1j/p6wUTry5TIUgcKaHA8QNfBZ7SQrkHOVzLUIddsTWjWxzmhUV56FXb01mJIyKoTGmkQT/ErHLNWlY5DQRc3jZhsB/QYFVwsvE3m2ammcgWhQxPKHiVTL/qNsfNBbfmmss68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028085; c=relaxed/simple;
	bh=TGeuuK7fOYRfoe6a8DhpoHdMGzI2E5kOAf8iKFMGuSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qm4uRe/nuIwtwTsAMfzJST+8S3u2UeOLai2CE4d3RdLSx0OjJbExc5cmb9LczkcJi5MwQWPm8qu9a9JMfUDSWqabNLjG+deiDgvEOZtgwmOWRZof/MxT8f52fWct7hjxScquvyWgVAhTyaF9vGWASBgbhvemA8EPxY7BErnKe04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVKGVbUo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVKGVbUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B59C116C6;
	Mon,  2 Feb 2026 10:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770028084;
	bh=TGeuuK7fOYRfoe6a8DhpoHdMGzI2E5kOAf8iKFMGuSA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fVKGVbUoamI24K6bILks02TU1ztDe91CfyI1uqXi3t2/v4Q5twR5AopI02D93u3t/
	 r1JGb0/mEBUn3oIOZg/SFnXw3GAmiEB6TA/Z8AgKuyOe0yF9vifINv3AUErRT5uT1L
	 UzZjYYzibsvT2/BOq2axZX/t4lSkm0+AhMpIaOj/wrjMTwwCfbg+FsDiRuOqkM3WSS
	 R6m3+p2qvxMNnKtyB5hDvJXKywAhA1IkxgQ+7ss2INSV/VMuOP2ziG9lJ2ByTUIDrN
	 wXCRWjREseOXEOwuL9AhTP0nmZQA+PMr65/zQwOcfcLDBKS6U9P8r3FEqEAOjT81VK
	 fnOy7NKU5l1HQ==
Message-ID: <2cf2897c-00dd-4f1a-aceb-404959a8eb4c@kernel.org>
Date: Mon, 2 Feb 2026 11:28:01 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mptcp-next] mptcp: support MSG_EOR in mptcp_sendmsg
Content-Language: en-GB, fr-BE
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
References: <20260202040916.626066-1-gang.yan@linux.dev>
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
In-Reply-To: <20260202040916.626066-1-gang.yan@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 02/02/2026 05:09, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> This patch adds support for the MSG_EOR flag in MPTCP's sendmsg path,
> ensuring that data fragments marked with MSG_EOR are properly handled
> to prevent coalescing with subsequent data.
> 
> Key changes:
> 1. Added an 'eor' field to struct mptcp_data_frag to track MSG_EOR marking
> 2. Initialize the eor field to 0 in mptcp_carve_data_frag()
> 3. In mptcp_sendmsg_frag(), when sending the last chunk of a data fragment
>    that has MSG_EOR set, mark the corresponding skb with TCP_SKB_CB(skb)->eor = 1
>    to prevent coalescing with subsequent data
> 4. Modified mptcp_sendmsg() to:
>    - Preserve MSG_EOR flag in msg_flags filtering
>    - Mark the last pending data fragment with eor = 1 when MSG_EOR is set
>      in the message flags
> 
> This ensures that applications using MSG_EOR to indicate record boundaries
> have their intent preserved across MPTCP subflows, maintaining proper
> message segmentation semantics.

Thank you for looking at this.

> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
> 
> Notes:
>     Hi Matt,
>     
>     I create two packetdrill scripts to test the 'MSG_EOR' in
>     single/multi subflow(s). The link is attached below:
>     https://github.com/multipath-tcp/packetdrill/compare/mptcp-net-next...Dwyane-Yan:packetdrill:mptcp-net-next
>     
>     Please ignore the indent problems, I will fix them when
>     the 'MSG_EOR' patch is accepted.

I think it is better to be able to review the tests at the same time as
the implementation. Can you then fix the indent problems and open a PR
please?

In the meantime, it looks like checkpatch is complaining here:

> WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
> #14: 
>    that has MSG_EOR set, mark the corresponding skb with TCP_SKB_CB(skb)->eor = 1
> 
> WARNING: line length of 107 exceeds 80 columns
> #95: FILE: net/mptcp/protocol.h:270:
> +	u8 eor;					/* Is MSG_EOR marked? Prevents coalescing with next frag */
> 
> total: 0 errors, 2 warnings, 0 checks, 54 lines checked

Can you look at that, please?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

