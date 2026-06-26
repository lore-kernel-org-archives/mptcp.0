Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A443E5589
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782465260; cv=none; b=Edd/0lRDq8tByKXIj/V0HWxTqpC5MiuumqIKYYTzuB19ElLiBiB8VqyFP4PiA1J96MPFQi3fHdfmjFT7qVL42ndZaKG+ehVxvtPZGry5WFXMRF+GMw/sHvmGQrH3O3U/2UtOoniTT1S8PxmETW1x2De7fafTsFiqJjxQvokKZos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782465260; c=relaxed/simple;
	bh=Wd489oJ4Ts/f14E4pVMe54wWwpBtsKoKdzFQ3W1Xr64=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fBI23hvYFOh0ggaOscWVIeqgPKkhxVvLWyjWm/S71NKIewcxnDWOgHE29J8qmwYboZ6KjB4xBLy6gIjSQP0LNX0pe4HABOXWSW/wDD+98d9xnsRBZviCgzZ8XOcOs+ptLmIVdpJOjrZbie5aZ6V7uCnA0I5F8XvO3KxEwe5UhNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJuBvJrW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJuBvJrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF40E1F000E9;
	Fri, 26 Jun 2026 09:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782465259;
	bh=jkBYe7Ogtuyt/xzlf6XKmp2uAUsv4Xu7Hbc8avzdGsw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=KJuBvJrW7LnS8HHRP9vQK3kHVWKWaRqZ3Yp0XhUq/W6GIlHR1/eu2eettFGMNotgn
	 JPWQCVTcSfGVZ3ICt6ypfLjTdZeISb4cK5wHnDXwRNoU7SC2NBZQSvkd6bsK8CH30a
	 UF9OBcleHZf9n89QG1O6qev1l5I5G2iawnYRdPT9dagQT9F/5IYY9WhawMAwsOp8Zm
	 uTmpuiqFdmM1W2SujzeR0tm8A43ldN422iikidPnSsuUdeboZZRyRP7HyQq9cBoITy
	 kqHOsNzxoNmSu0MZfSHVENGEVbPgsE0yl7xWdKq0KZa7x7NFsLast5wNdBzz4mYj1J
	 o/HNGbm3ryDqA==
Message-ID: <9245c477-8609-4263-82dc-49d8af1aec2c@kernel.org>
Date: Fri, 26 Jun 2026 11:14:15 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v4] mptcp: fix stale skb->sk reference on subflow
 close
From: Matthieu Baerts <matttbe@kernel.org>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, shardul.b@mpiricsoftware.com, janak@mpiric.us,
 kalpanjani009@gmail.com, shardulsb08@gmail.com,
 Paolo Abeni <pabeni@redhat.com>, syzkaller <syzkaller@googlegroups.com>
References: <20260601083010.924938-1-kalpan.jani@mpiricsoftware.com>
 <f644447b-87de-4e9f-81de-d43811f39a4e@kernel.org>
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
In-Reply-To: <f644447b-87de-4e9f-81de-d43811f39a4e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 25/06/2026 10:39, Matthieu Baerts wrote:
> Hi Kalpan,
> 
> On 01/06/2026 10:30, Kalpan Jani wrote:
>> The backlog list is updated by mptcp_data_ready() under
>> mptcp_data_lock(). The cleanup of backlog references to a closing
>> subflow, however, was performed in mptcp_close_ssk(), before
>> __mptcp_close_ssk() acquires the ssk lock, and while holding neither
>> the ssk lock nor mptcp_data_lock().

(...)

>> Tested with the MPTCP kernel selftests on the patched kernel:
>> - tools/testing/selftests/net/mptcp/mptcp_join.sh: all tests pass
>> - tools/testing/selftests/net/mptcp/mptcp_connect.sh: 68/68 pass
> 
> Note that you don't need to specify this: for MPTCP patches, we assume
> all kernel selftests and packetdrill tests are passing. If you did other
> "unusual" tests -- e.g. running many times a reproducer mentioned in the
> issue -- then that's interesting to add that in the commit message.

I just got a note saying that's the kind of phrase an LLM agent adds. If
that's correct, please don't forget to add the required "Assisted-by:"
trailer when you rely on an LLM agent. (That would also avoid me
possible issues when upstreaming these patches.) Also, in this case, it
is often useful for the reviewers to explain what you as a human did. See:

  https://docs.kernel.org/process/generated-content.html
  https://docs.kernel.org/process/coding-assistants.html

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

