Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3BF1D5ABF
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394505; cv=none; b=eFz2CJ2Kv6hJPRZd6sxCo2a9cTRZuoukQ8iQe7u9lCOQQXLhMVR0ME+0FdtNw4VzZmiE3EHe1rJU4ISrMfrnI0+PvdBKmGkbSePhrQdYpHvgwzh8oD45N64Dax0fBP4/0TXrojtNvgdRXxWwmJiEW93Gx4I8X2PPcQdOgGM1Vck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394505; c=relaxed/simple;
	bh=miaVT8AGDtVUp3uun7nRKdoULdwDA8GWACJM5FsxMoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtDgiU3LuZfOqULRoFljmVzwRRfqkGETIX7wmoWcM2IDH2kCUpeD3BPjWiuORO3MAgFBzh6en0cENbt3yGrwe0cnefukjN6qHNbEbArhkyobTGTM3eE7W5Ip/SqMbgukstB4RiKrAAUDpImxQX+fY/CZGEmogFiK6eq0ghFoxoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNSvpOah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNSvpOah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2674C4CED1;
	Thu,  5 Dec 2024 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733394504;
	bh=miaVT8AGDtVUp3uun7nRKdoULdwDA8GWACJM5FsxMoU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZNSvpOahfTw7klUe7opNpCne+VyohsFeqMTylN6P3xlZyi3cq7iN2T/tmEDDtm/cZ
	 RfaoT1pRx/zOgtJ70j7UkFTo8YB0RY3IDN+/rjXbpkOBIhJ5m/F2VjOyEswnDOk92p
	 izzQdA70Dl8OJ6Q5UcdzmrLBeDvk1VpJeNHimc4tKwgmpwVnYSWT16bDJEYYmVn4Pc
	 yHKQBsKOhpUxU3tV70DdoxlIdzQmKOS0IPqIDF/b7gT33cBDpM95+kgmAASkQGVES9
	 26dVB1H2b8iIRqqZd+6vukzE0Ffy7Gns1i3zGGy8CZpJNUpRz0lHJ4m6fCoafOjrBp
	 3agQpQ9iM9zlw==
Message-ID: <afb5b4bd-30e7-4f23-a567-5981c1d9a8df@kernel.org>
Date: Thu, 5 Dec 2024 11:28:21 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 2/3] Squash to "bpf: Add mptcp_subflow
 bpf_iter"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
 Mat Martineau <martineau@kernel.org>
References: <cover.1732181419.git.tanggeliang@kylinos.cn>
 <c98deccb13e527c3fc120e9f6f6627db3b3cf6ab.1732181419.git.tanggeliang@kylinos.cn>
 <b149e886-179e-4111-b0bc-0e944b1ed011@kernel.org>
 <a8edc8b7d34db222a39879df4c23adfb532d5279.camel@kernel.org>
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
In-Reply-To: <a8edc8b7d34db222a39879df4c23adfb532d5279.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

We briefly talked about this patch yesterday with Mat.

On 27/11/2024 03:20, Geliang Tang wrote:
> Hi Matt,
> 
> On Fri, 2024-11-22 at 11:02 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 21/11/2024 10:36, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> Address Martin's comments in v1:
>>>
>>> - bpf_iter_mptcp_subflow_new returns -EINVAL when msk socket lock
>>> isn't
>>>   held.
>>>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> ---
>>>  net/mptcp/bpf.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
>>> index 02038db59956..89a7a482368d 100644
>>> --- a/net/mptcp/bpf.c
>>> +++ b/net/mptcp/bpf.c
>>> @@ -252,7 +252,10 @@ bpf_iter_mptcp_subflow_new(struct
>>> bpf_iter_mptcp_subflow *it,
> 
> Other bpf_iter have added "sizeof" and "alignof" checks, I think
> mptcp_subflow bpf_iter also needs to add them too:
> 
>       BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_subflow_kern) !=
>                    sizeof(struct bpf_iter_mptcp_subflow));
>       BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_subflow_kern) !=
>                    __alignof__(struct bpf_iter_mptcp_subflow));

If it is something that is done with other bpf_iter, I guess we should
indeed do that, especially for a check done at build time!

>>>  	if (!msk)
>>>  		return -EINVAL;
>>>  
>>> -	msk_owned_by_me(msk);
>>> +#ifdef CONFIG_LOCKDEP
>>> +	if (!lockdep_sock_is_held((const struct sock *)msk))
>>> +		return -EINVAL;
>>
>> This feels wrong: lockdep is a debugging tool, the goal is usually to
>> WARN in case of issue, not to take a different path.
>>
>> Maybe you want to use spin_is_locked(), but still, I'm not sure
>> whether
> 
> spin_is_locked() doesn't work, since this msk socket lock isn't a
> spinlock, right?

(I was talking about sk->sk_lock.slock, but while not being sure that's
what you need here)

>> that's the direction to take: it means the msk always needs to be
>> locked
>> when iterating over the different subflow → is it always the case?
>> Maybe
>> yes if it is used only to modify update it?
>>
>> (If not, maybe you just need to check the sk_refcnt as a safety
>> measure?
>> But that's maybe not enough for all cases.)
> 
> I think the answer is no, sometimes locking is not necessary when
> iterating over the different subflows. Does this mean we can simply
> drop msk_owned_by_me() here?

I guess it is safer to add a check here, to avoid random BPF programs
calling this kfunc in other context that could cause issues.

At the meeting yesterday, it was not clear what would be best: in the
context of the packet scheduler and path-manager, do you know if this
helper will always be called when the msk is locked? (And owned by the
user?) If it is a hook to modify msk or subflows, I guess yes, but there
are many hooks, we didn't check everything.

So if the msk is locked (and owned by the user?), then that's good to
add such check. (If we don't need the lock, maybe we don't need bpf_iter
because we only need to read stuff?)

In this case, maybe enough to look around sock_owned_by_user_nocheck()
and/or spin_is_locked(&sk->sk_lock.slock) helpers? (We didn't check if
they were making sense in this context, to be checked first!)

Also, we were wondering what was done in other cases with BPF. If a
check is needed to verify a lock is held, how can the verifier make sure
the lock is held by the same context. For example, how can it make sure
it is not going to be released during the kfunc operation. (Maybe that's
more a question for BPF maintainers)

>> Did you check what was being done for the BPF TCP CA? I guess they
>> need
>> a way to prevent calling some kfunc without the required locks or
>> refcount, no?
> 
> Not found in BPF TCP CA.

Strange, I wonder what safeguards they have then.

Or maybe it is possible to say that some kfunc can only be called with a
specific struct ops?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

