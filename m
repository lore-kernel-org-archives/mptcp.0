Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975E63D1AAA
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126201; cv=none; b=mSRlfAt03TcG3ROMUdLWjX784aNOrS0ZKBf/P8SyMXZSiy4EZn+eH9BEm6ejJjKe0irUvcpbqv+eP74BeHUWEp+12+1XeeYuQOtOy4mN09R+fgTugk/wSQFebMmJxpr+i0estAtjE1w/vMShWmTm6z/B3eH9cKUhBbWWK8izQXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126201; c=relaxed/simple;
	bh=MW4Zknh8Rdyexe5FZThl0fXi8Af1Kv81tpCNLVAf4hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c1Z5Iox39FpYYPuubCoPEVwZft3IRlFrOBMwvP57Kv4DcTbM61Zcl8aFpWBmH2S2Lk3Z3fwsxMmBicyuqcfXhHpuQ5U+F1U2O7jxtJyOU2mBFIKx+0IofdhRKtTZzrhvf4Ceg2O2TeakvZ/jNpTwZqsky1VhQsOwsK5sT1TIvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvuyKGGD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvuyKGGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B800C1F000E9;
	Wed, 19 Aug 2026 07:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787126200;
	bh=gp7YfV/cuNoC0Cac4ydoAx0xP1GK6LjArxGpW8bAfls=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=QvuyKGGDFPyvPrPyb0yfVOR8n/sc2ZyjXcWeF7QwJnKshA7MOgght/aMuUafukRvT
	 6PGgCpK5IlKAdnouGnY3Qi7YNbWbRpS7w5hzSw1szcFGHAMDnQLQ4UgTUhJH0LlH8v
	 aerfwgRC1oyxrM32PTlz0hw/24Az12eWQrxzMnG/NkmN5PrInXuZRblk8l9eX9Xefz
	 tReeJW6/Q99+8hIHee0fUgF77LDX4Bi0biihhTLZia/u/kUBVSx/sWLHfs7IdPzHj1
	 XJuLpmHH0m27eyEhLHDjLadGvmYDbwUcFKgLLJxUm9tuZLrWchbEgpIT96mUBY5QCh
	 Cc/Cxpr4sld1w==
Message-ID: <b1710700-0755-4f74-a6db-cfaa7f28a057@kernel.org>
Date: Wed, 19 Aug 2026 09:56:37 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3 2/8] mptcp: pm: userspace: lookup: match port
 in priority
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
 <20260807-mptcp-pm-userspace-id0-case-v3-2-de9088549924@kernel.org>
 <7bf7a43655610da952266aa7bfbec76a1dcb5f22.camel@kernel.org>
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
In-Reply-To: <7bf7a43655610da952266aa7bfbec76a1dcb5f22.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for the review and suggestion!

On 19/08/2026 09:23, Geliang Tang wrote:
> Hi Matt,
> 
> On Fri, 2026-08-07 at 10:41 +0200, Matthieu Baerts (NGI0) wrote:
>> In the local address list, there can be entries with the port set to
>> 0
>> -- corresponding to the source port used by the initial subflow --
>> and
>> others with a specific port.
>>
>> When performing a lookup, it is important to compare the ports to
>> pick
>> the right entry: when a specific port is given, then try to match it
>> first. If no match is found, try to find entries with the port set to
>> 0.
>>
>> Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> v3: new (Sashiko)
>> ---
>>  net/mptcp/pm_userspace.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>> index 663cbeb79548..3f1471ec3fc7 100644
>> --- a/net/mptcp/pm_userspace.c
>> +++ b/net/mptcp/pm_userspace.c
>> @@ -33,10 +33,22 @@ mptcp_userspace_pm_lookup_addr(struct mptcp_sock
>> *msk,
>>  {
>>  	struct mptcp_pm_addr_entry *entry;
>>  
>> +	/* Compare ports when set in addr */
>>  	mptcp_for_each_userspace_pm_addr(msk, entry) {
>> -		if (mptcp_addresses_equal(&entry->addr, addr,
>> false))
>> +		if (mptcp_addresses_equal(&entry->addr, addr, addr-
>>> port != 0))
>>  			return entry;
>>  	}
>> +
>> +	if (addr->port == 0)
>> +		return NULL;
>> +
>> +	/* Check only wildcard ports if no exact match with the port
>> */
>> +	mptcp_for_each_userspace_pm_addr(msk, entry) {
>> +		if (entry->addr.port == 0 &&
>> +		    mptcp_addresses_equal(&entry->addr, addr,
>> false))
>> +			return entry;
>> +	}
>> +
>>  	return NULL;
>>  }
> 
> Personally, I think a single-pass lookup is better than a two-pass one.

Indeed, I initially thought the code wouldn't be very readable, but
maybe worth it.

> I've implemented a version and it passed the tests:
> 
> static struct mptcp_pm_addr_entry *
> mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
>                                const struct mptcp_addr_info *addr)
> {
>     struct mptcp_pm_addr_entry *entry, *wildcard = NULL;
>     struct mptcp_addr_info match;
> 
>     mptcp_for_each_userspace_pm_addr(msk, entry) {
>         match = entry->addr;

Mmh, but now there is a copy for each entry. Not sure what's better.

>         if (match.port == 0 && addr->port != 0)

(Would it not work to add this condition to the last argument of
mptcp_addresses_equal()? → EDIT: no, see below)

>             match.port = addr->port;

It feels wrong: entry->addr.port == 0 should mean "same port as the msk"
(inet_sk((struct sock *)msk)->inet_sport). But this "addr->port" is
possibly yet another port.

In other words, I think doing that here means accepting the first
wildcard one. An example: ID0 is now the first entry, if there is
another IP with another specific port, it should be picked in priority.
With this code here, I don't think that will be the case: the ID0 entry
will be picked instead, no?

(I think we should have a test with the userspace PM announcing the same
address but with another port + doing the listen for this port manually,
and checking the IDs being used: shouldn't be 0)

>         if (mptcp_addresses_equal(&match, addr, addr->port != 0)) {

What if we always call mptcp_addresses_equal without the port check, and
do that "manually" here below?

-> Return if the port is the same, then save it as wildcard if one of
them has no port set.

Even there, it feels like the comparison should be stricter: if one port
is 0, either the other one is 0 (port is the same, already checked then)
or equal to the msk one. I think I quickly tried this at some points,
and it was causing issues, but I didn't investigate. Maybe the tests are
wrong (mixing up IDs) or there is another bug somewhere... Do you mind
looking at this if you have the opportunity, please?

>             if (addr->port == 0 || entry->addr.port != 0)
>                 return entry;
> 
>             if (!wildcard)
>                 wildcard = entry;
>         }
>     }
> 
>     return wildcard;
> }
> 
> What do you think of this approach?
> 
> Also, this series has conflicts with the current export branch and
> needs a rebase.
Yes indeed. But let's focus on this case above, and wait a bit longer to
have a review on the other patches as well.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

