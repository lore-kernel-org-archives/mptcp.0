Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D215383B
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744942; cv=none; b=pxsMyaFjJCMBJVrBaqPRwsg65vUlMP/GKsaALAlA7B2pST2EIWSU6X6x74oiiUN+KnQFGTviW0E/ti7IzUOWu9AUDb/sCmR6d2CRHkIzLUzQbSsAQLNI7qrguZ1gyyJ3zin0WSn6yn9dM+Mt1wGuocsZZNkjc5T6lgBbgyh6GxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744942; c=relaxed/simple;
	bh=ih+V+Ul3jEDm6FCJn1+typvfq/z/+ScHaQBPIdQE5PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEhdupCdj7osVAgEa3lfv+1KOtDr5YEP8qiTfVuGhfLYIAm2QVwKHLaqFhrsGX/7TU08rxldzHoVL94akIDQJ4/UgSgVn+lEq16iQHDO7hqtUs/k9rVB6jUTH+gp1gYtJ5pBP3IaClEZYKNuOkEWAqrU1nSROdjnXIvDkDGWDNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4GO0HrV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4GO0HrV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2857AC4AF0A;
	Tue, 23 Jul 2024 14:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721744941;
	bh=ih+V+Ul3jEDm6FCJn1+typvfq/z/+ScHaQBPIdQE5PM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s4GO0HrVVu2IwCdsCbVp+EjKdKChEYRhaTaUtdI5pth/nnRiiNToqBvmZ7npBF/rC
	 4IYHUN18dAs6o/8ASVLhKHRMPJ7eLMm1OAbuu2jhNb8MChegcn7vI+MZY4BpKSPnJn
	 5laXxDrr9pB9RXHs9Q4GHUmKW1tNB9JfouJ3wy2JV5xeQYVzrIyidk5nvGfmU+EDev
	 F2fS8F5cF6hyhRDObgZNYfyV+7NHp+dlFEKNAYBz7Az4l5/EAmh1VbdOuD12MGk6bl
	 Bh/cfuR0gkhhLjoux1gcTAyGEzmM0pC1wH0i61v9FfkLnbBE0utZisACl9aIXmTBm+
	 ysziltE6qErZA==
Message-ID: <1227f975-6a4c-45aa-b5af-bc1fc5fb6552@kernel.org>
Date: Tue, 23 Jul 2024 16:28:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3 0/9] mptcp: fix inconsistent backup usage
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
 <a59b9b6a-0c6b-0918-415e-378a482b3d6b@kernel.org>
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
In-Reply-To: <a59b9b6a-0c6b-0918-415e-378a482b3d6b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 23/07/2024 02:24, Mat Martineau wrote:
> On Thu, 18 Jul 2024, Matthieu Baerts (NGI0) wrote:
> 
>> In all the backup tests we have, the backup flag is set on one side, and
>> the expected behaviour is to have both sides respecting this decision.
>>
>> On the scheduler side, only the 'backup' field is checked, which is
>> supposed to be set only if the other peer flagged a subflow as backup.
>> But in various places, this flag is set when the local host flagged the
>> subflow as backup.
>>
>> One last thing that has been fixed is the backup flag in 'signal'
>> endpoints: it was working only when setting the backup flag while the
>> connection was already opened. That's what the MPJ selftests were doing
>> to check that the signal endpoint were supporting the backup flag (on
>> purpose I guess, because the support was broken in MP_JOIN...).
>>
>> The last two patches adapt the BPF selftests to mimic what is now done
>> by the in-kernel packets scheduler.
>>
>> Note that the Packetdrill tests need to be updated because the behaviour
>> has been changed / fixed:
>>
>>  https://github.com/multipath-tcp/packetdrill/pull/152
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Changes in v3:
>> - Small fixes in patch 1 and 5: see the individual ChangeLog
>> - Use a new dedicated helper in patch 6: see the individual ChangeLog
>> - Link to v2: https://lore.kernel.org/r/20240716-mptcp-backup-mpj-
>> v2-0-4d50247405fb@kernel.org
>>
> 
> Hi Matthieu -
> 
> v3 LGTM. I'm not sure if the new MIBs are best targeted for net-next,
> they do help with testing but don't seem critical for -stable.
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 9d426c00aef4: mptcp: sched: check both directions for backup
- cba82af312b3: mptcp: distinguish rcv vs sent backup flag in requests
- 1ed597db4a47: mptcp: pm: only set request_bkup flag when sending MP_PRIO
- 887ecb0faf1d: mptcp: mib: count MPJ with backup flag
- 5e248a08f195: selftests: mptcp: join: validate backup in MPJ
- 237a12154c8f: mptcp: pm: fix backup support in signal endpoints
- 34b6d5cac1f0: selftests: mptcp: join: check backup support in signal endp
- Results: 159097cdb0e8..001fe004e8be (export-net)
- Results: 140ff27ee472..939ca15e71e2 (export)

New patches for t/upstream:
- b4a459e0fd62: "squashed" patch 8/9 in "selftests/bpf: Add bpf_bkup
scheduler & test"
- ec4acb003f8a: "squashed" patch 9/9 in "selftests/bpf: Add bpf_burst
scheduler & test"
- Results: 939ca15e71e2..f0f02c71ff0d (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/293546bf79b70ea127af87026d99cfb91eacb77b/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/b601d6da52375e9a0a078ec38af104b5243c4658/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

