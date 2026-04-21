Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD346373BF6
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787956; cv=none; b=FTJDY4aiVLI/kZw+OqAmbSZmVMm1Q9kSitWLuwYHFYkSc7MW5FmqhIrjy06p+rcmftSj1Z3g4q/0H4mJ5Zc0n7Mqjg8BJt0e1Vy94wj0ufMBnW/FRqiArVnNYn4eWKDl3c5sVqbpwUeI6tkDQDeftmrB77h10qJWbFX1ueVRxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787956; c=relaxed/simple;
	bh=QnLGJYp6YZoBtIJS4m9UFD4y67urr2fqhbDUt22dsbo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cCs8I5cu9WWeHhhW/TDwr08jwQt24aAJImXmRdxECaiHK/In5b748K5dBS9YRA3G280yKUhVengGW+9m5CqatzT1S+cM2Inn9ecmHuzk/E/N1Oyr2HVOSHvAJwBFrpyOM3OP1PANQzqpFfBkxINHmskXAX2RIVHUWZBVd6tMRhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REkUNy3m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REkUNy3m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EED9C2BCB0;
	Tue, 21 Apr 2026 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776787956;
	bh=QnLGJYp6YZoBtIJS4m9UFD4y67urr2fqhbDUt22dsbo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=REkUNy3mebEFyOPyi3sXtxc0zjyPIaVwDezVCKf/bL1wYp0mUrGpF+JKBDyb0vGD/
	 AGFy9kvf17J4DPraTBoLwx1JGkm0X/MlAlUGdvDMojp2WodHpJEBCjr6w9wyxqDe9/
	 wCtNvmnRFYwD9FAhmOkxh11kwy9cBhbxHTci9MGyBbklprLzTbO5N1Z7rDP5LxjOX+
	 esMSBblX7Qbt3Tqy6aHcW5jc81NlqOhcYRDDrHW8wso+E8v0qsYhGk9DdEFirBVsW2
	 EXWqD+p8IFCGiSEdqCBI1lqFxhIpXKbna+3uNRL67ZZ4IiVm6TOc089NluYAiSolct
	 jNwd3qPYMPiow==
Message-ID: <bbc40289-5b21-4c8c-8864-c37f9738cbcb@kernel.org>
Date: Tue, 21 Apr 2026 18:12:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: sockopt: set timestamp flags on subflow
 socket, not msk
Content-Language: fr
From: Matthieu Baerts <matttbe@kernel.org>
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
References: <20260420093343.16443-1-gang.yan@linux.dev>
 <0709c747-463f-4f5f-995b-156764f35da3@kernel.org>
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
In-Reply-To: <0709c747-463f-4f5f-995b-156764f35da3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 20/04/2026 11:46, Matthieu Baerts wrote:
> Hi Gang,
> 
> On 20/04/2026 11:33, Gang Yan wrote:
>> From: Gang Yan <yangang@kylinos.cn>
>>
>> Both mptcp_setsockopt_sol_socket_tstamp() and
>> mptcp_setsockopt_sol_socket_timestamping() iterate over subflows,
>> acquire the subflow socket lock, but then erroneously pass the MPTCP
>> msk socket to sock_set_timestamp() / sock_set_timestamping() instead
>> of the subflow ssk. As a result, the timestamp flags are set on the
>> wrong socket and have no effect on the actual subflows.
>>
>> Pass ssk instead of sk to both helpers.
> 
> Good catch! How did you find the issue? It would be good to add a test
> for that, but not sure how.
> 
>> Fixes: 3f4f958c3a3c ("mptcp: sockopt: propagate timestamp request to subflows")
> 
> It looks like this commit doesn't exist in the 'export' or 'export-net'
> branches. I guess you meant to use 9061f24bf82e instead?
> 
> When you do a git blame, do not use branches from the TopGit tree. Use
> 'net', 'net-next', or the 'export' ones.
> 
>> Fixes: 6c9a0a0f2333 ("mptcp: setsockopt: convert to mptcp_setsockopt_sol_socket_timestamping()")
>> Assisted-by: GLM-5.1
> 
> Thank you for using this tag!
> 
> Apart from the above, it looks good to me:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> I will wait for the CI, but I can also fix the SHA (if correct) when
> applying the patch.
I'm going to apply the patch, but I noticed sashiko mentioned a possible
other existing issue:

  https://sashiko.dev/#/patchset/20260420093343.16443-1-gang.yan@linux.dev

Do you mind checking if what was reported is correct, please?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

