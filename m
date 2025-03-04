Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B26623B0
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080179; cv=none; b=SC3Wr4IYWUMweuxaSTMjtyfZAJa0jJXLU8WLFv3x3TVrXRVuZZ3GqWP3GJyAnNoeEFMnmAPlDksuCUdITGEJiaPdBQqZJmnE49owUIJg0GzJwmsdNyhM+ZStL+SGxCcVLsrz9fjWYx9bh0lLEhhl6OHyEDqvJtSeaY4JKNQPv4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080179; c=relaxed/simple;
	bh=361I39bLgRtDXvbBC7o17ROeO1gauiRjFGRyQKIGtfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFaehpGv5dAN+ov/p/TMXhbCUSgLipp3+wlpfOvDsgKbzPRgubzM8t/cKCC5CwKqMkO+w5r4uOmyNDdTKxXxBbrQn9yj6ZZD3I+iCEBCCPhFjMEVZ0pDQNmWbDt1DWjOezU3w7ND9r6jA7/pi8Z2Uu06r3MsHd+kZORjM8i4R0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvLUvWR1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvLUvWR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD330C4CEE9;
	Tue,  4 Mar 2025 09:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741080178;
	bh=361I39bLgRtDXvbBC7o17ROeO1gauiRjFGRyQKIGtfM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JvLUvWR1axnX9l6VXBRr63z17FISOG/qybuh75wgX1eGPdg6YNo51iXwEGZjBYK9u
	 q8bEUC9IQKvbHa97JkVyD1YEx87GbrQZW6NCTRAlqtRPQLwTA9JWDb4thfyCci0s2s
	 bwVu/p8gzxmd1Q8Aq5wgTyHOTc08g3g79j3nbc6eC83uxOciKeix4NGFYvzOQXNzEx
	 EH/c4HQQ7gFuROpQqa9q5zrj7bdzPHLIUNEwSvQt/XFQf+87fhuN3j2IBBBp9xH/Gq
	 D0/kSQMIoPYwjmzQdD6fineGPos/e5AxF+hecSmZQhTNyuC7WXD1foZ93nk4t6VclH
	 q2XMmcNF0jMCQ==
Message-ID: <ee5929b0-ddec-4f75-bab6-9164f896f7d8@kernel.org>
Date: Tue, 4 Mar 2025 10:22:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] Squash to "bpf: Add mptcp_subflow bpf_iter"
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20250226180727.2499531-2-matttbe@kernel.org>
 <9f669869ee804aeb6dbe7fd1511034b0ca9bf8c4.camel@kernel.org>
 <97e5dc17-d23a-496e-830c-982cf6ab9424@kernel.org>
 <bdf769b3-d787-63fe-47ed-5cb8c85a6602@kernel.org>
 <bd3c2f86-a6e2-4452-9694-1cdfb0298ddd@kernel.org>
 <38a21708-c57f-e69f-e1cd-af7767fd7568@kernel.org>
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
In-Reply-To: <38a21708-c57f-e69f-e1cd-af7767fd7568@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 04/03/2025 02:42, Mat Martineau wrote:
> On Sat, 1 Mar 2025, Matthieu Baerts wrote:
> 
>> Hi Mat,
>>
>> On 01/03/2025 02:37, Mat Martineau wrote:
>>> On Thu, 27 Feb 2025, Matthieu Baerts wrote:
>>>
>>>> Hi Geliang, Mat,
>>>>
>>>> On 27/02/2025 03:03, Geliang Tang wrote:
>>>>> Hi Matt,
>>>>>
>>>>> On Wed, 2025-02-26 at 19:07 +0100, Matthieu Baerts (NGI0) wrote:
>>>>>> From what we understood, when being used from a CG [gs]etsockopt
>>>>>> hook,
>>>>>> the socket lock will be held. It seems that the BPF infra will make
>>>>>> sure
>>>>>> in this case. Mat will try to get the confirmation.
>>>>>>
>>>>>> The idea is then to add this msk_owned_by_me() check to make sure the
>>>>>> assumption is correct, and will continue to be: the new selftest
>>>>>> should
>>>>>> complain if not when used with a debug kconfig. In other words, if
>>>>>> the
>>>>>> tests continue to pass with this patch, the Squash-to series can
>>>>>> probably be applied.
>>>>>>
>>>>>> Note that this is just a debug check, hoping that the selftest will
>>>>>> cover all cases. We can then not use this check to return an error if
>>>>>> it
>>>>>> is not held.
>>>>>>
>>>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>>>
>>>>> Thanks for updating this for me.
>>>>>
>>>>> LGTM!
>>>>>
>>>>> Reviewed-by: Geliang Tang <geliang@kernel.org>
>>>>
>>>> Thank you for the review!
>>>>
>>>>>> ---
>>>>>> Based-on: <cover.1740368110.git.tanggeliang@kylinos.cn>
>>>>>
>>>>> I changed the state of this set, Squash to "Add mptcp_subflow bpf_iter
>>>>> support" v4, together with this squash-to patch, as "Queued".
>>>>
>>>> Thank you. If that's OK, I will wait for Mat's green light before
>>>> applying the patches, because he wanted to look at the BPF code to make
>>>> sure our assumption was correct.
>>>>
>>>
>>> Ok, I did miss it before but in the cases of setsockopt/getsockopt, the
>>> socket lock is acquired by the bpf wrapper code:
>>>
>>> https://elixir.bootlin.com/linux/v6.14-rc4/source/kernel/bpf/
>>> cgroup.c#L1955
>>>
>>> That's why the test passes. There's still the general issue that the
>>> iterator could be used in any bpf code that can pass a valid msk
>>> pointer. The existing lock checks in the export branch check that the
>>> socket is locked, but it could be locked by some other owner.
>>
>> Thank you for having looked! Because these new kfuncs are currently only
>> tied to BPF_PROG_TYPE_CGROUP_SOCKOPT, can we apply all these squash-to
>> patches and send this to BPF maintainers?
> 
> Hi Matthieu -
> 
> I think once the squash-to patches are accepted into our repo (a few
> more changes are needed), it would be ok to upstream them to the BPF
> maintainers.

Thank you for your reply! But I admit I'm a bit lost: which changes are
you talking about?

In the "Add mptcp_subflow bpf_iter support" series we sent to the BPF
maintainers, this support is only added to CG [gs]etsockopt where the sk
lock is owned, so no need to have extra checks for the moment, no? Then
the "Squash to "Add mptcp_subflow bpf_iter support"" v4 (not the last
one you looked at, the v5) should be enough, no?

My understanding is that setting "msk->bpf_XXX" to "current" will only
be needed when mptcp_subflow bpf_iter will be allowed to be used with
struct_ops, no? If yes, better to keep this complexity for later, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

