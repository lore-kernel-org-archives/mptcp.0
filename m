Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253502D5955
	for <mptcp@lists.linux.dev>; Tue, 14 Oct 2025 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436170; cv=none; b=VZYCRcSjYLXgNRvz6/9wsayxhAJ9JDC20ypMKlGYyc57h26IeuvMIMhqZO60eybvnYtFmQHzlFiDNvkrvPsg7MqHf9Ts8c6aAuVCYcO9wAtSkgbrvtp2GU8OzevsgtzCLszMMSQGOPBO6xji+Gd7pd6NAEy4iZdgS3Wasggc2tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436170; c=relaxed/simple;
	bh=o5suRA15Ttq59eytwHVR8xQwX4f95yhp9sX0BGOu9Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L+wnNsroR1m/N9CNN+XvfOeLfbdXYd0tTGFfOMofy25Sxi3x4TNa2S56a26F6Io8XX2mdmnVficIoNi0G2EiuPuHDXLCqsmyIdpRh9AEPDJm0vTo3yuwMwCrOfOF4KkbmCA0OdPuKXv5cMHQo/cSqB7jtZrjBHAbHHJHBCvgSn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwrayuQV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwrayuQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42495C4CEE7;
	Tue, 14 Oct 2025 10:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760436169;
	bh=o5suRA15Ttq59eytwHVR8xQwX4f95yhp9sX0BGOu9Sk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=FwrayuQVU9noiMxwbx8kCk56O5S14+9NMMi6U7XTOcs0tpHfv8N1493sy1z9pYotH
	 rzaHE+mG6R8Pydw/Ih1iSA/CR89FJbPL3lFgt1CBWe82VmO7kz9XWg5K28rHlkxFS8
	 4tLrz+d1WRoFXjVI0OfrRdEz07r/q6OCPJT4W7k6JrRLIX0TqiMBzxI/9WaN5uqcld
	 EuRJCIqtXr9PRcYIolY1IGxKGHq8QKKMqBJPwKYzCapcorfV0fntmq55m8Ug6GzVHD
	 jqsz0bdmZb1o6ULVSrRfyKstnDYA3Wf7gbrqzY7NQ6wVpR6KiDKX0A8CX1M9li8VL9
	 4OgUuyfGwzJuw==
Message-ID: <7fd7973d-e45f-4177-90cd-b65ac4547c04@kernel.org>
Date: Tue, 14 Oct 2025 12:02:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 6/7] mptcp: pm: in-kernel: record fullmesh endp
 nb
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
 <20251008-c-flag-add-addr-delay-v1-6-c624eb3bf10d@kernel.org>
 <e7340af8302a2dc98c41580423c0663954db8523.camel@kernel.org>
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
In-Reply-To: <e7340af8302a2dc98c41580423c0663954db8523.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 14/10/2025 09:20, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for this patch.
> 
> On Wed, 2025-10-08 at 16:00 +0200, Matthieu Baerts (NGI0) wrote:
>> Instead of iterating over all endpoints, under RCU read lock, just to
>> check if one of them as the fullmesh flag, we can keep a counter of
>> fullmesh endpoint, similar to what is done with the other flags.
>>
>> This counter is now checked, before iterating over all endpoints.
>>
>> Similar to the other counters, this new one is also exposed. A
>> userspace
>> app can then know when it is being used in a fullmesh mode, with
>> potentially (too) many subflows.

(...)

>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index df2bc36593d0..054d85045381 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c

(...)

>> @@ -603,9 +612,12 @@ fill_local_addresses_vec(struct mptcp_sock *msk,
>> struct mptcp_addr_info *remote,
>>  	int i;
>>  
>>  	/* If there is at least one MPTCP endpoint with a fullmesh
>> flag */
>> -	i = fill_local_addresses_vec_fullmesh(msk, remote, locals,
>> c_flag_case);
>> -	if (i)
>> -		return i;
>> +	if (mptcp_pm_get_endp_fullmesh_max(msk)) {
>> +		i = fill_local_addresses_vec_fullmesh(msk, remote,
>> locals,
>> +						      c_flag_case);
>> +		if (i)
>> +			return i;
>> +	}
> 
> I'm not sure if endp_fullmesh_max needs to be checked in
> fill_remote_addresses_vec() too, something like:
> 
>    if (mptcp_pm_get_endp_fullmesh_max(msk))
>            return fill_remote_addresses_fullmesh(msk, local, addrs);

No, it doesn't need to be used with fill_remote_addresses_fullmesh(),
because this helper is only called if the local endpoint has the
fullmesh flag, see fill_remote_addresses_vec().


In other words, when calling fill_remote_(...), we have the local
endpoint (where the fullmesh flag might be set), and we need the remote
addresses. When calling fill_local_(...), it is the opposite: we have a
remote address, and we need to find local endpoint(s). It is only in
this case we need to know in advance if there are any "fullmesh" local
endpoints.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

