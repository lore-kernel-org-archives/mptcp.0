Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAA32DECD6
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991174; cv=none; b=jO6iBuAReH5BPeSaxll8tIAiuUjCV7ewm44doRy0PmjW4s51z0su869zoMPosJC1Eb+leGL/df1Nz/mRyzSYKCNsldEPbKnBl5YfKYsTq34UCgB/npuZh+KfLiqRt5RH7L6TneA+EDE1w3s+Huckrwnu8qYmH0Raa16SmW2HjtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991174; c=relaxed/simple;
	bh=4f8yjgAtTTfbmio2yZdZXXaX/i4qv1YrwQXcVG9QhzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCqCs8Zm50DZKTIvvIYPQvvTmjj+HUKL7w4wQa93CoICGWUY4p43gZWS4DWC9AJFJUPxydWOhN3/LDtWh8o+mqI8FfNIyAMaLlsrfLHURVgFjIeQIHUayFvWyPSxhasaemz0nJUL5oD1BsDLgZCOSrWixTjEE9MCN4yayZOy4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOqGPWnk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOqGPWnk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE0CC4CEF0;
	Tue, 12 Aug 2025 09:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754991173;
	bh=4f8yjgAtTTfbmio2yZdZXXaX/i4qv1YrwQXcVG9QhzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UOqGPWnklZ43WPawI6XihstpFsyhzMyRo7QbJ5ynvZov+0ViTf1R2wS8UClIqQSvg
	 pwyrLlc0nibwr0OWPKu11cWM/HnijJbq5ZenFfKAZhZC4pG12+hcQ2EbpJID0bgweZ
	 yxDq5WsCynI+5CrvT7lrbcwU2shlmKZt0jZ1dfxyVM92sewOPiGxfMtrHXOgJJIz73
	 +Ppqc1so2aTJo5cHlkWnJ8TGJImYI5t5pMD1chgg+XBGVOeW0y91ZSQqsra6uakKgO
	 HqomNz6s0rVgPBIjl901eRC1/eqxbSlld0h+syuy4Ymd+pfDp/sIjVRwAmPlzHfIhT
	 8reQOmOBOz5MA==
Message-ID: <dd9b0ae8-581e-4306-b575-1a3dc07eef67@kernel.org>
Date: Tue, 12 Aug 2025 11:32:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: make ADD_ADDR retransmission
 timeout adaptive
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, Christoph Paasch <cpaasch@openai.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1754449947.git.tanggeliang@kylinos.cn>
 <c559f29eea1e019b6d25a35f05bbeb85fdd578e1.1754449947.git.tanggeliang@kylinos.cn>
 <eb6c0e4d-938c-4712-83b2-ee12bd70aa12@kernel.org>
 <f42defcb7fe7db02283fed5def29623cbc6a24d7.camel@kernel.org>
 <b0a4ebe8-0dfd-4c15-89bf-98c4f7cfebc0@kernel.org>
 <78799855faff1bb19cdec5210ca5edf302d39974.camel@kernel.org>
 <5d4dfa60-7604-4b45-becf-8df8bd0667ed@kernel.org>
 <CADg4-L8iLwmp6GCscWCq9vwPTyavgi54i5KSjLPneULQHvwB9Q@mail.gmail.com>
 <1e636ef3-6756-4638-89ab-2a013df9454a@kernel.org>
 <2c6f89d333cb88760c566f85f843b6fa56b00152.camel@kernel.org>
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
In-Reply-To: <2c6f89d333cb88760c566f85f843b6fa56b00152.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 12/08/2025 11:20, Geliang Tang wrote:
> On Tue, 2025-08-12 at 10:39 +0200, Matthieu Baerts wrote:
>> On 11/08/2025 17:34, Christoph Paasch wrote:

(...)

>>> Why wouldn't icsk_rto not be good enough ? We just need a
>>> reasonable
>>> number here.
>>
>> I didn't have time to investigate in between, but is icsk_rto not
>> updated only when needed (@Geliang: did you check?). So could it be
>> possible that at the beginning of the connection, the value is not
>> correct?
>>
>> If yes, why not using __tcp_set_rto()?
>>
>>> And, I must say that 2 x __tcp_set_rto() seems a bit
>>> arbitrary. Let's just use icsk_rto. Does it really matter that it
>>> is
>>> not updated very frequently ?
>>
>> Maybe yes.
>>
>> @Geliang: but before sending a new version, please check my comment:
>>
>>   https://github.com/multipath-tcp/packetdrill/pull/166
>>
>> Especially this part:
>>
>>> 0.65s looks a lot to me: The 3rd ACK at line 15 should be injected
>>> with a delay of 0.01s.
>>>
>>> What are the values of icsk->icsk_rto, tp->srtt_us, tp->rttvar_us,
>>> __tcp_set_rto(tp) and the one you set for the timer when scheduling
>>> each retransmissions and when running this test?
>>>
>>> (for the rto value in jiffies, please convert them to usec like the
>>> others → jiffies_to_usecs())
>>
>> Sharing such info when running the packetdrill tests using a non
>> debug
>> kernel (and ideally also sharing the output of packetdrill, when
>> running
>> it with the extra -vvvv), would help better understand the situation
>> here.
> 
> Here is the debug patch based on v4:

(...)

Thank you for having checked! I suggest discussing the logs on the
packetdrill ticket where I just asked you to check when not all the
packetdrill tests are executed in parallel, certainly taking all CPU
resources:

  https://github.com/multipath-tcp/packetdrill/pull/166
> In this test, __tcp_set_rto(tp) is the same as icsk->icsk_rto.

That's interesting. Then maybe we can simply use icsk_rto if that's easier.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

