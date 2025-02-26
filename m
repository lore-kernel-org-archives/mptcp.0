Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA5221547
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587754; cv=none; b=SiweCOgUavmA5IUkAMLJvGLgrbF5zxrydN4mIOGkRVzQiPM4Nc1NXKjFx0JtzA9D3ZaXBeVFjWz0oxnHoEMGuxPKpvcpI2qfYdYC78MYHCVn2lphSqhm8mEidNhVsOdneQKrlvrjjocf4xov8sAGNks0ErWxFbOUiaMwFASZQAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587754; c=relaxed/simple;
	bh=ejonzWJFlIwn0F/2nqN7+gsZV7LppfTRbR0W7so4SHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAEDLV3o4OMiCVO3ShwYnx8M7DtaBXkknGVq+pfwR7q8rmRHBLhKQ2CUFORUxBBUGXQ3RQwrwsY2mrkhsFcaRSbOr7za24DQyTpHzyUxAEN9+KPMKUkxaReD7NVTEIHixTnkpndgLCJxjH7UrFMGqxZep94m4ZpUQoFrJcX0LoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7GbUp4/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7GbUp4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DB1C4CED6;
	Wed, 26 Feb 2025 16:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740587753;
	bh=ejonzWJFlIwn0F/2nqN7+gsZV7LppfTRbR0W7so4SHM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k7GbUp4/kFGZa6nPz5PM/EdGVO83PvC7d1ugxDJB19vdm3FFCXpiRUABHfieYwtGI
	 WjAjh4UEo9auYD9gawE4DlPM8KwyZgsCzs3vYfHpfIW54lzMorXTKq0L4MPPUn6msm
	 /PYtbtHOJCIWChhkVeye5FjzElM9mLxX14gFKQtj9lX1CdYxKQ9cxIwEfL8lBU16os
	 Y84vWRJ3y9mAkbLpVXm/fVWVvVkBHeIhEvADKLN8w8CIK2jFLmcYNteLnuPzQ1ViB2
	 6ymi5H4TWSaFOrzWZe+10vN1tVsDelSzIRxj1DMTeR83JOj0Rr2+szhp5zfHnpJ8Zy
	 AF/GxXQ/cxu3Q==
Message-ID: <6330f8c9-2760-4215-9fbd-8fa26e1763da@kernel.org>
Date: Wed, 26 Feb 2025 17:35:48 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add a test for
 mptcp_diag_dump_one"
Content-Language: en-GB
To: Gang Yan <gang_yan@foxmail.com>
Cc: mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>
References: <20250224-mptcp-sft-diag-squash-v1-1-81eb3843fa53@kernel.org>
 <tencent_859D9F20AC0E314A5E590923E9A45EE68F05@qq.com>
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
In-Reply-To: <tencent_859D9F20AC0E314A5E590923E9A45EE68F05@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang Yan,

On 25/02/2025 05:43, Gang Yan wrote:
> On Tus, Feb 25, 2025 at 09:51:93AM +0800, Gang Yan wrote:
>> On Mon, Feb 24, 2025 at 08:03:05PM +0100, Matthieu Baerts (NGI0) wrote:
>> - sdiag_protocol: avoid compilation warning:
>>
>>   mptcp_diag.c: In function 'send_query':
>>   mptcp_diag.c:77:43: warning: unsigned conversion from 'int' to 'unsigned char' changes value from '262' to '6' [-Woverflow]
>>      77 |                         .sdiag_protocol = IPPROTO_MPTCP,
>>         |                                           ^~~~~~~~~~~~~
>>
>>   => the real protocol is passed via INET_DIAG_REQ_PROTOCOL.
> Thank you for making the modification here. I'm sorry I overlooked this
> point when submitting the patch.
>>
>> - printf: follow the same format as ss: hexa only for the token + flags.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Tested-by: Gang Yan <yangang@kylinos.cn>

No problem, thank you for having checked!

New patches for t/upstream:
- 699dad3cb771: Squash to "selftests: mptcp: add a test for
mptcp_diag_dump_one"
- Results: 3635c12a532c..16bc369672e8 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/e4a8ba485b99c5eaed76adfadfbd6b4fda26bbac/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

