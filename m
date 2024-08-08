Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564AD146A7B
	for <mptcp@lists.linux.dev>; Thu,  8 Aug 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112341; cv=none; b=l0X3yUsFqhatiuh0749vAZNQ0txz4fQErZHUuoDpXE4u0wfRzrqq3d0kklx/4Z9NOCMo7T6gHX9aMVRQWGeZP0VQgviiPjzw2f7agljB7FRjdtErM6H1bMVzziOA0X7Nhk6KLhq5nlnffFMR4gtXJlBQU/wSA2Wu4AdzBxJ91ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112341; c=relaxed/simple;
	bh=rcgA3E79uC7wuXcfIx/F1AZTAqfPmRHk0tHzTkgHUE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PdYarySHdpwnIgHIevyeL96lQ8/KT1y8MRt0GoXvDBQAEtum0CeP4q/2ECvPBMngQ9aOX7xu5foNF+Y1qlTS0xKqVvZ0kkrxGq8zg+Vk/TDb+qyENkqncb1ImiZrWF6OuMPIORzlbHskTiENi4jfg+917slGr+jsyuoc2/+GPWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gqwo9F7R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gqwo9F7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351C1C32782;
	Thu,  8 Aug 2024 10:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723112341;
	bh=rcgA3E79uC7wuXcfIx/F1AZTAqfPmRHk0tHzTkgHUE0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Gqwo9F7RZ35fKA5dD6hxBX59WV6042gpmNOO7hubG/RNGojoNZSuiFqoFsgqd+6Ga
	 F95iW/IWx8SoN/WFC2W+wx8KwDAfa1BAxDPSwghrO3aRSarxKRrobwVOqlaITbd5ap
	 ASYRMsP7KlvYuw1w+GC679v6T+HT6PPmroQKmMetDIdb366X3tJVgtFxl8YfNP3np4
	 1irCG6T3lu9KkWSbXksKb8epJc++hByM1QXpvZEoG3eRwFFwHrDn8Gx0LiOG908kJe
	 UJEsas4mwfZ2VZDVaL07LcCr5KC/qknNhYigJz79L7ajofdqtc4I4tTNSQvALnWnTs
	 tkMgU3KYCxpqw==
Message-ID: <39ca5a97-ee5b-4a0c-9748-3caad7c21744@kernel.org>
Date: Thu, 8 Aug 2024 12:18:57 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 2/8] mptcp: MIB counters for sent MP_JOIN
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
 <20240806-mptcp-join-tx-mib-v3-2-c3b54d2099e9@kernel.org>
 <88fa2fcc26d43988d897b306df39df5c3b41afd6.camel@kernel.org>
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
In-Reply-To: <88fa2fcc26d43988d897b306df39df5c3b41afd6.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 08/08/2024 04:46, Geliang Tang wrote:
> On Tue, 2024-08-06 at 13:18 +0200, Matthieu Baerts (NGI0) wrote:
>> Recently, a few issues have been discovered around the creation of
>> additional subflows. Without these counters, it was difficult to
>> point
>> out the reason why some subflows were not created as expected.
>>
>> These counters should have been added earlier, because there is no
>> other
>> simple ways to extract such information from the kernel, and
>> understand
>> why subflows have not been created.
>>
>> While at it, some pr_debug() have been added, just in case the errno
>> needs to be printed.

(...)

>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index a7fb4d46e024..fdeb7df8b095 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -1575,12 +1575,17 @@ int __mptcp_subflow_connect(struct sock *sk,
>> const struct mptcp_pm_local *local,
>>  	u32 remote_token;
>>  	int addrlen;
>>  
>> +	/* The userspace PM sent the request too early? */
>>  	if (!mptcp_is_fully_established(sk))
>>  		goto err_out;
>>  
>>  	err = mptcp_subflow_create_socket(sk, local->addr.family,
>> &sf);
>> -	if (err)
>> +	if (err) {
>> +		MPTCP_INC_STATS(sock_net(sk),
>> MPTCP_MIB_JOINSYNTXCREATSKERR);
>> +		pr_debug("msk=%p local=%d remote:%d create sock
>> error: %d\n",
> 
> It's better to use "remote=%d" instead of "remote:%d" I guess. Same
> below.

Indeed, I see we usually use '=', I can do the modification when
applying the patches if there is nothing bigger to fix.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

