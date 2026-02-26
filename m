Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2564B2D7386
	for <mptcp@lists.linux.dev>; Thu, 26 Feb 2026 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092160; cv=none; b=JzWgfrtQ2goh9nzAkMch5MtkYyrnf9+FvJ76kC5aXtq73qlNb065SGsMqOPAoa9WC5hQiuEhiBG8kj7/03kjd5aDcNP53s+5DoayBnYBZG27ZO+F6WhfB8KJ758GUDJ/Sn8pdWvVm4L8KjNU60cOsW30pmwxCqXECzl0UkxrKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092160; c=relaxed/simple;
	bh=tSDNPz4GK2M5XZA2cHemuypbhX43Xp4n1LWw2aKwSXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RO636O/Z8dFTurvOB2rPFC0AQLB3hYurI6vB1IsC5afkqjqMjhSzDbdMRtK5knnO8mfMFFrgnfTlAF+eIKpHpGQ6mEpoEytx+qL80pcr86bGnLMwU2PiXIyRb79gL0L8Sn+0nZ2bn8idQNe6/fwUf86IeFhtZ6/cA7Wy+jAKDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArjLGrj/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArjLGrj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BED3C19422;
	Thu, 26 Feb 2026 07:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772092159;
	bh=tSDNPz4GK2M5XZA2cHemuypbhX43Xp4n1LWw2aKwSXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ArjLGrj/3AKM0gEfU4t3tJIBDJTlUL9P2fi2uoYCXuuaWplmdPd4lJnAwrt4veu1u
	 /9MsqfPqErbT3YHUPNF4EZ2p1VJ4HIWFOjJPU8Bxv+p8tLVFtCA/GNsVW8m67tep/y
	 Lh/qWPalIke0T481Gy+fz3LmAjFwNMqKpbP1r9QTfongBeDuPXrc35eGw3pKlPJbts
	 Dut0T1JSIJBF7LQW3DnSeUgaIquD93NThIXmrckiYyjX6TX4r9wHA9anjBkBt8gyvz
	 ofJI0+93X7H0WQmnMlkytRGjL/SdZDy9DZqpbpQKklVhJaZvGrHIsNB7LAHDLBzvHJ
	 3h0YQ7k9UJs3g==
Message-ID: <9bed7905-af41-4ba0-86b7-a6801c6d7c59@kernel.org>
Date: Thu, 26 Feb 2026 08:49:17 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: pm: in-kernel: always mark
 signal+subflow endp as used
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20260218-mptcp-issue-613-v1-1-f8e9adb12010@kernel.org>
 <bffe9f3d-298b-1142-7cbe-e8bb768e9b38@kernel.org>
 <847f7e20-3c94-45a1-8c42-392701be8464@kernel.org>
 <0316ea8e-38e0-6cc5-6d02-4defed40772b@kernel.org>
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
In-Reply-To: <0316ea8e-38e0-6cc5-6d02-4defed40772b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 25/02/2026 19:46, Mat Martineau wrote:
> On Wed, 25 Feb 2026, Matthieu Baerts wrote:
> 
>> Hi Mat,
>>
>> Thank you for the review!
>>
>> On 25/02/2026 18:50, Mat Martineau wrote:
>>> On Wed, 18 Feb 2026, Matthieu Baerts (NGI0) wrote:
>>>
>>>> Syzkaller managed to find a combination of actions that was generating
>>>> this warning:
>>
>> (...)
>>
>>>> Note that signal_and_subflow variable is reset to false when the limits
>>>> and the c-flag case allows subflows creation. Also, local_addr_used is
>>>> only incremented for non ID0 subflows.
>>
>> (...)
>>
>>>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>>>> index 87e37c729f81..2710abcd4065 100644
>>>> --- a/net/mptcp/pm_kernel.c
>>>> +++ b/net/mptcp/pm_kernel.c
>>>> @@ -418,6 +418,15 @@ static void
>>>> mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>>>>     }
>>>>
>>>> exit:
>>>> +    /* If an endpoint has both the signal and subflow flags, but it
>>>> is not
>>>> +     * possible to create subflows because of the limits or the c-
>>>> flag case,
>>>> +     * then still mark the endp as used, which is the case. This
>>>> avoids
>>>> +     * issues later when removing the endpoint and calling
>>>> +     * __mark_subflow_endp_available(), which expects the increment
>>>> here.
>>>> +     */
>>>> +    if (signal_and_subflow && local.addr.id != msk->mpc_endpoint_id)
>>>> +        msk->pm.local_addr_used++;
>>>> +
>>>
>>> Looking at the code above, signal_and_subflow == TRUE is an indicator
>>> that the body of the while loop never executed. Please add a comment
>>> above this code in the while loop:
>>>
>>>         if (signal_and_subflow)
>>>             signal_and_subflow = false;
>>>
>>> to point out that the code at the "exit:" label is assuming that
>>> signal_and_subflow is always false if the loop body runs.
>>
>> That's a good idea, but I'm hesitating to add that: adding such comment
>> might cause more conflicts. Plus, the use of this variable is quite
>> limited I think: init to false, set only in one case, and reset after
>> use. Do you think this comment is helpful there? Or should I add
>> something else here at the end of the function?
>>
> 
> True, it does run the risk of the comment and the code below getting out
> of sync and it's pointless to say "if you change the value of the
> variable it affects other code using that variable" (of course it does!).
> 
> I agree with you, and suggest updating the comment in the patch similar
> to "If an endpoint has both the signal and subflow flags and the 'while'
> loop body above never executed, ..."

Good idea, I just updated this comment before applying the patch:

/* If an endpoint has both the signal and subflow flags, but it is not
 * possible to create subflows -- the 'while' loop body above never
 * executed --  then still mark the endp as used, which is somehow the
 * case. This avoids issues later when removing the endpoint and calling
 * __mark_subflow_endp_available(), which expects the increment here.
 */

New patches for t/upstream-net and t/upstream:
- 402de2bca118: mptcp: pm: in-kernel: always mark signal+subflow endp as
used
- e8f38bbd8b67: selftests: mptcp: join: check removing signal+subflow endp
- Results: 652750a9d6a6..eefe19f1a175 (export-net)
- Results: d3854ef490c9..c0858783271a (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/ca3a60dc7df9f019289be14d7ca6898f8431381e/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/866d58409123388cf9032de57af875fbe418a642/checks


Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

