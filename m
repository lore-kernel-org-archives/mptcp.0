Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D43A7F7E
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766432; cv=none; b=Fy3jixLMLqc5K3249M9wm77Ur3DeBWW/lzd/NZjJkTrdsQKhRENBYWYfdoUjsmShsxSWov+njQT+5T0P8s7xf7+8oztiTsXWE2akuaMp6X4Fe6o+M02bVtVJgOlGz4beSwJdzHqohxCFRVcgmcK8vXnO4Dk3kF5msrqwHwJUiJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766432; c=relaxed/simple;
	bh=d4qK/+ua3THUEdbvbmVjmYt1/AaIf7nYtcIhCoA8/RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CdSbbs7O2Fjq8KxU9qHdolgUdB5D4mdUVnrQVVN9T8/CGiab4lOeY+zAWicDUAbwN8l3Q2JdcZecP1HbToqJoDtWxqhRkElxc/WufhpR5WnlJbDUdXCOvO/P5K94qubFZiZTKKFPCj9HDYD6y4j6YkQ0giwGfr8RPAekIVIQTPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFZlPVOZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFZlPVOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890731F000E9;
	Wed, 26 Aug 2026 17:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766427;
	bh=pdNbgxOZjpbB96YDqCe9WGQsFOKOYlGGR15JXwodXHk=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=LFZlPVOZDAZy2eIji7mKZmjQ8KvOrucNQI0KuzF6JyMFEcfjLPg77OvPi29WZuUM4
	 I0DRiwki/atblOzG0U/3O1L0ur9Bl/VVT+eWfnI+jBYjTiQq6vv6AzjU5uFKH+hLXP
	 VSRHG9aZlngSkusMzji8K1sWOaP9GIwMfAN6SuenFCRVsrAWjytCBK6BpIKpzv+VDu
	 NOe0UlQ3NEgP7n1WFWIxLpLpTKJQpu8q/24EcSWnZf2r/7FQgUb9Q/U2HH+Bv7trdR
	 7TFAekKIrkr/iHoGFo3iN5ARtiG4UsXBO5c4T4UjCWxBHZridcvkLVM6R7AkXxdP5X
	 CtQeF/3Qu5l5w==
Message-ID: <bda5cfa7-1c42-433c-981c-ae0f2afd3068@kernel.org>
Date: Wed, 26 Aug 2026 19:47:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 2/2] Squash-to: "mptcp: do not reschedule the
 RTX timer for fallback sockets"
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <f1e8ffe44c3756195391a25ecf60e56e02e0f34f.1787739122.git.pabeni@redhat.com>
 <3d8a1534a8b0609c6ddcd593f4ed8957be019657.1787739122.git.pabeni@redhat.com>
 <5c2cc035-02ae-4ed3-886c-d20dd799b0b4@kernel.org>
 <b6687f58-df51-4785-9451-0900f055a24a@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: fr
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
In-Reply-To: <b6687f58-df51-4785-9451-0900f055a24a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/08/2026 16:38, Paolo Abeni wrote:
> On 8/26/26 2:38 PM, Matthieu Baerts wrote:
>> On 26/08/2026 12:13, Paolo Abeni wrote:
>>> Sashiko noted that the 'RTX disabled' status is carried over
>>> across connect() failures, potentially to subsequent successful connect()
>>> or listen().
>>>
>>> Explicitly control the RTX enabling status across the whole msk life-cycle.
>>> To make the code more straight forward switch the newly introduced flag
>>> semantic.
>>
>> Thank you for looking at this!
>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>>  net/mptcp/protocol.c | 8 +++++---
>>>  net/mptcp/protocol.h | 2 +-
>>>  2 files changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 1e7e59d497c5..db745d9dde59 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>
>> (...)
>>
>>> @@ -3363,7 +3363,7 @@ void mptcp_set_state(struct sock *sk, int state)
>>>  		 */
>>>  		break;
>>>  	case TCP_CLOSE:
>>> -		set_bit(MPTCP_RTX_DISABLED, &mptcp_sk(sk)->flags);
>>> +		clear_bit(MPTCP_RTX_ENABLED, &mptcp_sk(sk)->flags);
>>
>> Could this be moved to mptcp_disconnect()? Or we prefer not, to stop
>> ASAP for some cases? (but I guess most of these cases switch to close
>> before transitioning to ESTABLISHED, no?)
> Why do you want to move the above to mptcp_disconnect()? It's better to
> prevent the rtx timer from taking action after the msk moved to close
> for any reason. IIRC we had a few syzkaller splat in the past without
> such check.

I was wondering if it could go with the other variables that are reset
there, but I also understand we want this bit set ASAP/in all cases when
switching to CLOSE. So this flag is particular, and it makes sense to
keep it there. Nothing to modify for this.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

