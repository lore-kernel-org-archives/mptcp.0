Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC574183963
	for <mptcp@lists.linux.dev>; Thu, 30 May 2024 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059996; cv=none; b=BTBjEj0yL7iv1AWdnGLS8RdBwwCVotlB4yaBjCTI9fz1u9hg5OTCJVlSHOFxfUEHKNHjGscFqdbKCbkeP7w0HPsfOFR/LytcbI2Gc2A91qxNW8LcEVyYzUUYbrvJFMcON5F0FcYKsHQzzOO5u8N93XqR3Y7fpTp/Bl3jcyVI9do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059996; c=relaxed/simple;
	bh=ba/IY/VrUnRVrdfqhJxml6pgkBc6Yx+uQxuJkAdbc8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJAPOpWlUaQoV/k3BzjAh1Ge6Z9MizGUZzSNFlISmle3FcbVUvbFXARE8CQeDoU+b3wpay4Y/jcmz7zNVUHRA95DKo/h4RkE8QLYF2TwWQObHSUQAQrtFFixegbKN4eziesmIvhpePj0B6ZcWbk81gGZ/287iSVNCfAjpxRZy10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2takebf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2takebf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC9CC3277B;
	Thu, 30 May 2024 09:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717059995;
	bh=ba/IY/VrUnRVrdfqhJxml6pgkBc6Yx+uQxuJkAdbc8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t2takebfDmEFE0dSJ05bo7IrY6SnkK8EMSUBMTHXkc/xf3ihH8NVQNYOyaEPTUzlI
	 BF5WOWbYCzZEa0uz+nkzOiW+E06xuzabWZSfMRWCAwaujxfEHtFdtTAxN1n+H6tXhr
	 J5NDB5uDo+rI48Yme/ZbXNjC6wCXK8Lez57rSCl4VfGmcspvc6CMtAbeu5tmcg6NoA
	 B8mgWNjJ+D1gnkyI9eE9Y62uvlq3EJYomzzFyW7/v9impomfOB88Kqht5QeTayNYbF
	 JxwIXRH9oWXzvBprVr77WTN0SiEPqvS/k4dGEdtzAL9ytBc41MCx3T47gPAcaeYfpp
	 gx25UBNg7uNfw==
Message-ID: <eb6508f3-baee-47e4-b414-27d66a9cebb4@kernel.org>
Date: Thu, 30 May 2024 11:06:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 0/2] fixes for create_netns
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1715848543.git.tanggeliang@kylinos.cn>
 <b95540e8de3d657cca95a3e0bd39cda40a712368.camel@kernel.org>
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
In-Reply-To: <b95540e8de3d657cca95a3e0bd39cda40a712368.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 30/05/2024 08:53, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, 2024-05-16 at 16:38 +0800, Geliang Tang wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> Since create_netns() is updated in "bpf-next add netns helpers"
>> series,
>> some mptcp bpf patches need to be updated.
>>
>> This series epends on "bpf-next add netns helpers" series.
> 
> The series "bpf-next: add netns helpers" has not been accepted yet,
> and I guess it will take a long time.

Thank you for the update!

> I suggest to send v3 of
> "selftests/bpf: new MPTCP subflow subtest" to bpf-next first. Don't
> wait for the series "bpf-next: add netns helpers" anymore.

This 'new MPTCP subflow subtest' series is not urgent, nor blocking
anything: I'm sure it is fine to wait. We have ~6 weeks before the
future v6.10 release. Do you think the "add netns helpers" will not be
accepted before?

> I changed this series "fixes for create_netns" from "Awaiting Upstream"
> to "Changes Requested" on patchwork.

Thanks!

Cheers,
Matt

> 
> Thanks,
> -Geliang
> 
>>
>> Based-on: <cover.1715821541.git.tanggeliang@kylinos.cn>
>>
>> v3:
>>  - add based-on tag.
>>
>> v2:
>>  - drop patch 1. Now netns is deleted first before adding it in
>> "selftests/bpf: Export create_netns helper", no need to use SIGINT
>> to delete it anymore.
>>
>> Geliang Tang (2):
>>   Squash to "selftests/bpf: Add mptcp subflow subtest"
>>   Squash to "selftests/bpf: Add bpf scheduler test"
>>
>>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

