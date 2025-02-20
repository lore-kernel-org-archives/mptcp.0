Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5751FF7BB
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075292; cv=none; b=qSf9+Wa4QeLuhw+SoZK3jGXZyjbTfvisNbzJud3IVqMQKf51A4QYNH6GZ4kF/f9X472RQTX10JZhsn4FbhRcJ5qP77iR8JT0MShJKqoDFAkA8kR0PEmouHQneq6bTsK1OT7xPOGp+fk6t/9Mwkfs/drZcL6cmonkIaxYpPV1mtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075292; c=relaxed/simple;
	bh=bS7X9nSJJUqvu0Oaa06ApP5O0txVwhR/mJrfq9O9cXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCO6ugA9mXUjjCRr80nezmkyrZ8cJJnnPgGAQZhQK/pTQm7RlLUzbrEClVBVTsXR6S1su6rGIxb8ioQfg/idb6FcBWuHYcf5FmhJgcqJcQbwQ/CZUhWxLfhrLGT7zLQre004SSly7E308+kLeWwrrUnbSZ471Ka1h/q0pk/MF7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocWwrmj/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocWwrmj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E045DC4CED1;
	Thu, 20 Feb 2025 18:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740075291;
	bh=bS7X9nSJJUqvu0Oaa06ApP5O0txVwhR/mJrfq9O9cXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ocWwrmj/x1ibpEbewuOmU0xoGEUAx1nsslCTdY7AwVHhh1McMqM1SmKUlQ5C1qldx
	 dilX+GfY7XHBBf1r+aBXg4BDOJICP1reomMA24jVQYZUXgJ3OxoTWJZ3oHZ4CG6swl
	 tMzuiyFQlwY5hypDYlCfhNS3xxJ/HZ1bILifjI+aAYXgqj+EG2YxMt+rEPKYngCyRv
	 mdgEnVVH4lV+N9fmh0uSw98kfIzTKwEnfDAZFJ1ig9pEoC4mKvsUd/vz1GoiMzEmRI
	 jP/j7bdWp8vZi+iLT13xvoKSkmBNhclLTdFbo1lYFn4FoFr4/x0nvnZ4T9YqI0nSTv
	 /MdXEx3RZ3yZw==
Message-ID: <5a89d8ed-fc1f-4513-8d51-5e3647cbe8fc@kernel.org>
Date: Thu, 20 Feb 2025 19:14:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/3] Squash to "bpf: Add mptcp_subflow
 bpf_iter"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
 Mat Martineau <martineau@kernel.org>
References: <cover.1737714424.git.tanggeliang@kylinos.cn>
 <af7dca496d83aaf6fd7163f767ef1bd1abbab59a.1737714424.git.tanggeliang@kylinos.cn>
 <3667814e-4e76-45df-90b0-2e3af7a081c8@kernel.org>
 <50c69cd42e32452a46029fb0e93f6fb55e332d7a.camel@kernel.org>
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
In-Reply-To: <50c69cd42e32452a46029fb0e93f6fb55e332d7a.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 02/02/2025 06:04, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for your review.
> 
> On Fri, 2025-01-24 at 16:04 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> (+cc Mat who reviewed the previous versions)
>>
>> On 24/01/2025 11:28, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> Drop the NULL check as Martin suggested.
>>>
>>> Use the "struct sock *sk" instead of "struct mptcp-sock *msk" as
>>> the
>>> argument in the bpf_iter_mptcp_subflow_new as Martin suggested.
>>>
>>> Use msk_owned_by_me().
>>
>> Regarding this, do you mind checking my question on the thread
>> initially
>> sent to the BPF mailing please?
>>
>>>> This set is only showing the cg sockopt bpf prog but missing the
>>>> major
>>>> struct_ops piece. It is hard to comment. I assumed the lock
>>>> situation is
>>>> the same for the struct_ops where the lock will be held before
>>>> calling
>>>> the struct_ops prog?
>>>
>>> Can we restrict the use of this helper only for some specific
>>> callbacks?
>>> Or for only some specific struct_ops?
>>>
>>> Last time I looked, I thought that you could only restrict it like
>>> that:
>>> "this helper can be used by (any) struct_ops". But then does it
>>> mean
>>> this helper could be called from a TCP BPF CC ops or another
>>> unrelated
>>> one for example? How can we avoid that?
>> Because with the suggested modification, there is no more checks
>> regarding the lock situation: it is probably fine now with
>> [gs]etsockopt(), but what about later with struct_ops? Can we
>> restrict
>> this kfunc to be used only in some contexts? e.g. a part or all the
>> MPTCP struct_ops, but not the other ones?
> 
> We use register_btf_kfunc_id_set() to allow these kfuncs to be used in
> struct_ops:
> 
> register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>                           &bpf_mptcp_common_kfunc_set);

OK so if I understand correctly, it means that the kfunc that are part
of this 'mptcp_common' set can be used from any struct ops, right? Or in
other words, the new MPTCP kfunc could be used from the TCP BPF CC
struct ops for example, right?

If yes, it might be clearer to ask BPF maintainers how we should design
the new kfunc that are supposed to be used only in the context of the
new BPF packet scheduler, e.g. should we check who own the msk socket.

I can ask this question if you prefer.

> And we also check if the protocol of the socket is MPTCP in
> bpf_iter_mptcp_subflow_new(). So this mptcp_subflow bpf_iter is
> restricted to be used for MPTCP. Other struct_ops likes a TCP BPF CC
> ops can't use it.

I see. For the bpf_iter case, these restrictions should be fine. Maybe
not for the kfunc needed for the scheduler part.

> Do you think this restriction is enough?
> 
> Another way to restrict kfuncs is to set get_func_proto of struct
> bpf_verifier_ops. But this way has not been applied to other BPF iters.

No, I guess for bpf_iter, we don't need that. Probably best to see them
as a "generic thing" and have the previous checks we already have.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

