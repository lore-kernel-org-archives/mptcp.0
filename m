Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862A1B86FB
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721299768; cv=none; b=EMhm+CjjaEfx8KniUaq2N/+K8kEifde65M4g6/HRlVBjWsjaBRHNI/028a+s5wqJnOneckRAFWPeHp1WzhiNJo4HK51jUC27rJBSkvahU1CXfmw1S5pcbYnZGiSu646ZZG7DKJ9xb182iGWCwNNvC5SL12+/1ajlmZDll966g7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721299768; c=relaxed/simple;
	bh=9d0nz90Uh40ZLwx/VrlRJz0SHbK4osKpI1c+NKkmhOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qD4OOdL3V/qMf1RWl9F5Y4DCgY1NMjpgECIBmrPGfhjmKk9Ck5CfIH2e+np0O8F4mcWFE1hP31jFBpvYnt2BtasV3Fql5utu9f5Fadjn2rRbpbhkvyPLfNtOnKGTgzDdJCfaw6YAMG3dKPTzZMp0FK39IygzhsxWHOgFBQCwvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYbJogH9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYbJogH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD3DC116B1;
	Thu, 18 Jul 2024 10:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721299767;
	bh=9d0nz90Uh40ZLwx/VrlRJz0SHbK4osKpI1c+NKkmhOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gYbJogH98S9uqVkV2k9nTln7OYzBvjGCXkw8D+SaxSX8r8Tzg9XZTMU+V9UArf5N8
	 YOAhS/qRQlB6G8LuRYWzLMYT2I9YjJV0nMbmnvLGBrnLX6IIkyUJlPyuf6RnMysd7n
	 1/3aneT1o10bCbeZQ3cKBojHA8Sp1APGFKZUG3bFZo3so7t54YtWX3+wRejHGj0Tp5
	 JW8g/elYp0vPKp2es9z8NzheZ8+LxcvgSpjovVZqTT1rtf+idp0DIXIe4IRtonMOBW
	 N8q3xQPU4uysyIzNig7uW5gX8GIJwQKl7ullpF61DdyzucI1B4idnGZUTMbFT9ZLoN
	 KVjbcgyNo0VwQ==
Message-ID: <2d595359-0b6f-4a4d-966a-17f1193ffe30@kernel.org>
Date: Thu, 18 Jul 2024 12:49:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 06/17] selftests: mptcp: join: ability to
 invert ADD_ADDR check
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
 <20240715-mptcp-pm-avail-v2-6-fc5153bd1f6e@kernel.org>
 <f62e151f743c4e6358f8745f2ba9bfbc746f6bab.camel@kernel.org>
 <9b98925b-addc-4be9-ab27-d9054ebc51fe@kernel.org>
 <17e90e599ab42cf21d31951af3737595416737b8.camel@kernel.org>
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
In-Reply-To: <17e90e599ab42cf21d31951af3737595416737b8.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 17/07/2024 05:53, Geliang Tang wrote:
> On Tue, 2024-07-16 at 10:12 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> Thank you for this review!
>>
>> On 16/07/2024 05:20, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> On Mon, 2024-07-15 at 12:09 +0200, Matthieu Baerts (NGI0) wrote:
>>>> In the following commit, the client will initiate the ADD_ADDR,
>>>> instead
>>>> of the server. We need to way to verify the ADD_ADDR have been
>>>> correctly
>>>> sent.
>>>>
>>>> Note: the default expected counters for when the port number is
>>>> given
>>>> are never changed by the caller, no need to accept them as
>>>> parameter
>>>> then.
>>>>
>>>> The 'Fixes' tag here below is the same as the one from the
>>>> previous
>>>> commit: this patch here is not fixing anything wrong in the
>>>> selftests,
>>>> but it validates the previous fix for an issue introduced by this
>>>> commit
>>>> ID.
>>>>
>>>> Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still
>>>> available for each msk")
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> ---
>>>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 40
>>>> ++++++++++++++++---------
>>>>  1 file changed, 26 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> index 55d84a1bde15..55ccc4fdf18a 100755
>>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> @@ -1415,18 +1415,28 @@ chk_add_nr()
>>>>  	local add_nr=$1
>>>>  	local echo_nr=$2
>>>>  	local port_nr=${3:-0}
>>>> -	local syn_nr=${4:-$port_nr}
>>>> -	local syn_ack_nr=${5:-$port_nr}
>>>> -	local ack_nr=${6:-$port_nr}
>>>> -	local mis_syn_nr=${7:-0}
>>>> -	local mis_ack_nr=${8:-0}
>>>
>>> nit: How about moving the code that reduces arguments into a
>>> separate
>>> patch?
>>
>> I prefer not to in this case. If the patch was for net-next, that
>> would
>> have been a good idea. Here, it is for -net, and backporting shell
>> scripts is a pain: there might not be any conflicts, but the script
> 
> How about this, send all these selftests patches in this set to net-
> next, and the rest to -net. After all, these selftests patches are not
> fixes, and selftests in -net can run normally without them, right?

That could simplify things, but I think it is important to attach the
tests to the fixes: it helps the reviewers to understand what was wrong,
and helps testers and maintainers to validate the new fixes, and make
sure there are no new regressions later. These commits should be
backported, but we should not spend too much time on that if there are
conflicts.

I could move this patch 6/17 to -next only, but that would make thing
even more complicated.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

