Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19A72627
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755269859; cv=none; b=uVKDO3hyidEwIvapxOlkxlQYWtAJf1LzKjRoumR4HqRnMC6PcQy0jqNFydVsVgUTbE0kefSuVR/c58LFL8tT1t5NWep+NE8f/Fk3ACQ6XoGNd7KB0EJYyNnShwOJK2vaxblP4mXJEGU0Rwp41OF/Vs6PrPdlosKVm1oU3MEoiyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755269859; c=relaxed/simple;
	bh=+Ig6xkelRGNdEcATvO2/+fGY0YbSqCc1RGYNzHV+KSs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZKSjcZb2wGtnBh0Ns1R7jtbqWePuzcf5eT1GIRdVgqy+WhCghssRsy0GYf2dF5BPyaweaE7lWOv+SYXpSAbfeZekhfUKDimcsunFf9fymC8GBbI6L2sxqn1zN1PPysD3NSBA4ofJGSF6LbEijtzdO9rQ1jBpFl8ZiM+wXMTI1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqlywjjE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqlywjjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D38CC4CEEB;
	Fri, 15 Aug 2025 14:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755269856;
	bh=+Ig6xkelRGNdEcATvO2/+fGY0YbSqCc1RGYNzHV+KSs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=pqlywjjExHl4uCXcW6wLqyN/uc6XZBZxrhMEZ7U8rBdwN1G3QEkl5gu0gjlSumxVZ
	 hQGVcvLoFOAJqC93FuDdbHckNWQtBrAGW5/u8BqAfl75N0v5pq+tD6DDeSGZDh2Z/Z
	 27HQ32SxoTJsZrHSGp1km807Z1g8gJKcIaoq5e5B9eX9WKp+7GxgkJJaktfDBk5VrA
	 Sm0VDwpd5/nzbVjty9dwHCly1VenHchXqUUe677wlKXO3p0T5gogG9NS2FtdeyuM1/
	 3GbRdJVWa/ve4dPDR59Xc922WOrt3g6RvBuZEf+hkadIvfU9LhwmR56RbyWbzZ+vOd
	 TRjqXkmGHbsWA==
Message-ID: <355d1b7b-07bd-4cc2-81ae-235dd0835f41@kernel.org>
Date: Fri, 15 Aug 2025 16:57:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 0/3] mptcp: disable add_addr retrans
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1754534416.git.tanggeliang@kylinos.cn>
 <13f5d33c-1404-4252-8d7d-e64cfa6f066c@kernel.org>
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
In-Reply-To: <13f5d33c-1404-4252-8d7d-e64cfa6f066c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 13/08/2025 16:19, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 07/08/2025 04:44, Geliang Tang wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> v2:
>>  - move "remove duplicate sk_reset_timer call" into this set.
>>  - check add_addr timeout value in mptcp_pm_alloc_anno_list() too.
>>
>> This series enhances MPTCP's ADD_ADDR retransmission mechanism by:
>>
>> 1. Adding support for disabling retransmissions when add_addr_timeout
>> is set to 0
>> 2. Modifying the self-tests to leverage this new capability
>>
>> The first patch implements the core functionality change in the MPTCP
>> subsystem, while the second patch updates the selftests to use this
>> feature for stabilizing a specific test case.
>>
>> These changes provide more control over ADD_ADDR behavior and improve
>> test reliability by eliminating race conditions caused by unexpected
>> retransmissions.
>>
>> Patch 1: Remove duplicate sk_reset_timer call
>> Patch 2: When add_addr_timeout is 0, skip retransmission entirely
>> Patch 3: Disable retransmissions in "delete re-add signal" test
> 
> Thank you for the new version. It looks good to me:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> I will just check with Mat if we consider this as a fix or not. I think
> it is, but the behaviour is slightly changed, even if it is to avoid a
> buggy one. I will then apply these patches after the next bi-weekly meeting.

Applied to our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 144959b26e16: mptcp: remove duplicate sk_reset_timer call
- 5ca4045882f9: mptcp: disable add_addr retransmission when timeout is 0
- 230c29e8aa90: selftests: mptcp: disable add_addr retrans in endpoint_tests
- Results: 3f23a1fbaa6a..077ce244fe7b (export-net)
- Results: 7c14230bb733..186cac2c4d81 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/097661ebac60d8cf1b143a91f6f11c71ef9fc5f5/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/576e85a3c313b3b1ea09f8369458e2c31784b99b/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

