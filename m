Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360712D6E76
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578233; cv=none; b=XLiUalWC24mjsHbKNIEC6dla6ujcMxWy0KWCUCXVOeak2nGlEF83tL7GLh6j0/JffIP446RTkNMg7VVG4L5alakn10pwoS+HKhJ3nwOKPouIkKHtjmULmVRjC/Ce1uZWh6sJ6cNjFsCiwy+IUOWSeWF7WWnbKVucTidt0KmBdmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578233; c=relaxed/simple;
	bh=gQIfAO52H8PZl2V+wff9rGPkCAPuOLK4Af9TKIWsYMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vD2VZrZUucojjqXyh7KU54tknT+s7EBHojaC5AboxCAokKELl6eur8YPIy1r7I2CCrZxW0QRV1aIUyInW5Wvu5nGkc/PuuiQc6hYEThXSU5dHEjnjym11usItvMrZz5ce7PzpTDnLySVkAZnVFon9dZsmZ3bADkJ8k0w+U/pmWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwcPRdfO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwcPRdfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1C4C4CEF5;
	Thu, 11 Sep 2025 08:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757578232;
	bh=gQIfAO52H8PZl2V+wff9rGPkCAPuOLK4Af9TKIWsYMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BwcPRdfOWW/jpC0DtAJRBPyH99aksjJZnvaEgt6DeX6WlM95x2ADnWA2bOvT5fnGW
	 Fmz/GscFxsEGZK9loqGflrAi692+KMAFMKNIbexcBFR+0128k3TovLEWS2fMlYGV8l
	 9z4h2n40g2P3x+ESu0AWU9UZtHvT79cWsLpIsQz7w891ivKpGiujePpOQrXpQ30z11
	 6azoeszNYJLEiRMskzbj1H95sfHipjPgFWDowU6pzcAfeN6MzRFYyobAUrcrRb7Dk9
	 G781cp02ONaVWb2xZsOn/fguJWaVE//EPc6+csTBtndZnKz7t0w0cewkv7DXNVbrqh
	 XfHVpg2R7alaA==
Message-ID: <520496c9-afdf-448b-ae81-087ebcbd034c@kernel.org>
Date: Thu, 11 Sep 2025 10:10:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 0/5] mptcp: pm: nl: announce deny-join-id0
 attribute
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 Donald Hunter <donald.hunter@gmail.com>,
 Marek Majkowski <marek@cloudflare.com>
References: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
 <ced8a24b-14ed-745a-13e2-b0b805116863@kernel.org>
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
In-Reply-To: <ced8a24b-14ed-745a-13e2-b0b805116863@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 10/09/2025 20:17, Mat Martineau wrote:
> On Tue, 9 Sep 2025, Matthieu Baerts (NGI0) wrote:
> 
>> During the connection establishment, a peer can tell the other one that
>> it cannot establish new subflows to the initial IP address and port by
>> setting the 'C' flag [1]. Doing so makes sense when the sender is behind
>> a strict NAT, operating behind a legacy Layer 4 load balancer, or using
>> anycast IP address for example.
>>
>> When this 'C' flag is set, the path-managers must then not try to
>> establish new subflows to the other peer's initial IP address and port.
>> The in-kernel PM has access to this info, but the userspace PM didn't,
>> not letting the userspace daemon able to respect the RFC8684.
>>
>> Here are a few fixes related to this 'C' flag (aka 'deny-join-id0'):
>>
>> - Patch 1: fix a small typo in if-idx type. A fix for v5.10.
>>
>> - Patch 2: add remote_deny_join_id0 info on passive connections. A fix
>>  for v5.14.
>>
>> - Patch 3: let the userspace PM daemon know about the deny_join_id0
>>  attribute, so when set, it can avoid creating new subflows to the
>>  initial IP address and port. A fix for v5.19.
>>
>> - Patch 4: a validation for the previous commit.
>>
>> - Patch 5: record the deny_join_id0 info when TFO is used. A fix for
>>  v6.2.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Changes in v2:
>> - Former patches 4-6 have been already applied
>> - Former patch 2 has been dropped (Christoph)
>> - Patch 1 is new, not linked to deny-join-id0
>> - Patch 3 replaces former patch 2, and was linked to former patch 7, but
>>  now using 'flags' instead of a new dedicated attribute (Mat)
>> - Notes: changes for net-next, and the deprecation of server-flags will
>>  be part of another series.
>> - Link to v1: https://lore.kernel.org/r/20250829-mptcp-pm-user-c-flag-
>> v1-0-78b25dda7708@kernel.org
>>
> 
> Hi Matthieu -
> 
> v2 full series LGTM, thanks for reworking to use the existing 'flags'
> attribute. Agree with the plans for net-next and deprecation of server-
> flags.
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 0da1c0ce6ea6: mptcp: pm: netlink: fix if-idx type
- 02cda1074a73: mptcp: set remote_deny_join_id0 on SYN recv
- a09491ca4e0f: mptcp: pm: nl: announce deny-join-id0 flag
- 6eae6b2bd22f: selftests: mptcp: userspace pm: validate deny-join-id0 flag
- 401a4e407eaa: mptcp: tfo: record 'deny join id0' info
- Results: c3bb5aa20b8e..28a9147c96c2 (export-net)
- Results: 6ff9d54223e3..9d5b2844a3ca (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/1bb915f2a5144a56b8fa183b1141d05268ac0f97/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/42b19ffa9551df01889230fa9e6228e61b18bffc/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

