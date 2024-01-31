Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C6269D39
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699578; cv=none; b=sFln8Njc5YRq17yLzWqn9MkLF22Fl7+jO+omJkg13GUIadfLaxHeUEdqWPZQ+a8ym3jWR4ftf4k5Uo7vXrn0gp0tLSsPyLZ56fwUHDrxgtyLjKScggfutmfl8WI9qEfqWP7lT6jllDJBXJzfXtFbvCUn+ER0vhbAo0jX6NR1MzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699578; c=relaxed/simple;
	bh=tEOBy/Wdn8oHi3sr0IWHYknQLM1yVJ7ADq9IGVUkJp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bFZL2RtI16gW7dyJBYfBeDrIym2UfvdkPEN5Z7UAmuR1ih0GzSJ1aTI9IOWLevYiW7+K2kuhGREALRqzWLlaNeBq1njhemfLbThJWVYuEaj80J3tv7lWggEDrwS5sJe7eKLUM1ycqfrGOJe0kOdDxKGS4XQi5WX6tHM6uinUkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuSQeVTu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuSQeVTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B657FC43390;
	Wed, 31 Jan 2024 11:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706699578;
	bh=tEOBy/Wdn8oHi3sr0IWHYknQLM1yVJ7ADq9IGVUkJp0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=UuSQeVTuG32TwXA8uPemK/GBUoq/xSyNK+jpDahVlKd5lIHPo+l0+NgaaFIh6Hh1I
	 UlEhIq7O9T01lC5qaKW+2QqCj3GaHXwK+d1AJ2xv5LW/tdUMF6OgJqOw+asBxYgVH+
	 +13AGkOIwgzTakDyFSFUNXW+HvYxNy0rUM9dESxBxsCdR+DZUZmKWaKjmDTxM7ZuEj
	 Os7/Ps9NmSbEGhm2moDcKezfbYwg2f4LBw6AgwAvBX3lOSIU14HAT8YjQbwoTgYbuL
	 FAUF25X06hc8lclOdiItTVbZbHyvvb1351BpR3ZzF1ponp2+gbp3Kj/Zg/i1u4ful+
	 ECppeJ9gpuoqg==
Message-ID: <08f4ba4e-e17b-40fd-874d-d4428a2c0b68@kernel.org>
Date: Wed, 31 Jan 2024 12:12:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: fix data re-injection from stale subflow
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com>
 <39a0fa5f-03e2-4ef3-90b7-decd8971905b@kernel.org>
 <195dfb64e0e8ecfac60c8f29df9e61c1c7cfea17.camel@redhat.com>
 <762d499c-1f90-470e-8e3f-b26eafd519dc@kernel.org>
 <aaeedb759fc5fe5ebd9704df58b0c89169dc1428.camel@redhat.com>
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
In-Reply-To: <aaeedb759fc5fe5ebd9704df58b0c89169dc1428.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 30/01/2024 19:53, Paolo Abeni wrote:
> On Tue, 2024-01-30 at 18:52 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> Thank you for your reply!
>>
>> On 30/01/2024 16:12, Paolo Abeni wrote:
>>> On Tue, 2024-01-30 at 12:59 +0100, Matthieu Baerts wrote:
>>>> Hi Paolo, Mat,
>>>>
>>>> On 23/01/2024 22:03, Paolo Abeni wrote:
>>>>> When the MPTCP PM detects that a subflow is stale, all the packet
>>>>> scheduler must re-inject all the mptcp-level unacked data. To avoid
>>>>> acquiring unneeded locks, it first try to check if any unacked data
>>>>> is present at all in the RTX queue, but such check is currently
>>>>> broken, as it uses TCP-specific helper on an MPTCP socket.
>>>>>
>>>>> Funnily enough fuzzers and static checkers are happy, as the accessed
>>>>> memory still belongs to the mptcp_sock struct, and even from a
>>>>> functional perspective the recovery completed successfully, as
>>>>> the short-cut test always failed.
>>>>>
>>>>> A recent unrelated TCP change - commit d5fed5addb2b ("tcp: reorganize
>>>>> tcp_sock fast path variables") - exposed the issue, as the tcp field
>>>>> reorganization makes the mptcp code always skip the re-inection.
>>>>>
>>>>> Fix the issue dropping the bogus call: we are on a slow path, the early
>>>>> optimization proved once again to be evil.
>>>>>
>>>>> Fixes: 1e1d9d6f119c ("mptcp: handle pending data on closed subflow")
>>>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/468
>>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>>
>>>> Thank you for the patch and the review!
>>>>
>>>> Any ideas how to prevent such issues? Changing the signature of the
>>>> TCP-specific functions? Adding a custom check for our CI on our side?
>>>
>>> I guess we could add debug-only code in mptcp_sk() and in tcp_sk()
>>> checking that the argument pointer belongs to the relevant slab, see
>>> kfree():
>>>
>>> https://elixir.bootlin.com/linux/v6.8-rc2/source/mm/slub.c#L4407
>>>
>>> we could fetch slab->slab_cache and check it vs
>>> mptcp_v6_prot.slab/mptcp_prot.slab/tcp_prot.slab/tcpv6_prot.slab.
>>>
>>> The main downside is that such code is heavily mm-dependent and may
>>> change/break when upstream progresses.
>>
>> Good idea!
>>
>> If you think it is too fragile, maybe we could add a new entry in
>> "struct inet_connection_sock" (or "struct sock"?) -- e.g. is_msk --, set
>> it in mptcp_init_sock(), and check it in mptcp_sk() and in tcp_sk().
> 
> Nice! that would be much more robust! Thinking again about it, we could
> simply check:
> 
> sk->sk_prot == mptcp_prot || sk->sk_prot == mptcp_v6_prot

Nice!

What about adding this in tcp_sk():

  WARN_ON(sk->sk_protocol != IPPROTO_TCP);

and this in mptcp_sk():

  WARN_ON(sk->sk_protocol != IPPROTO_MPTCP);

But then I suppose we will need to have these two helpers inlined when
we want to use this debug option. They are no longer inlined since:

- e9d9da91548b ("tcp: preserve const qualifier in tcp_sk()")
- 403a40f2304d ("mptcp: preserve const qualifier in mptcp_sk()")

>> We can do that only if KASAN kconfig is set (or another one?).
> 
> A possible option could be DEBUG_NET, but such option currently enables
> almost no-overhead things. I think we can use it, if we opt for
> checking sk_prot.

Sounds good to me!

Do you think this kind of patch could even be upstreamed? We can suggest
it and see.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
