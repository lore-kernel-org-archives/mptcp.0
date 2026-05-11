Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A171E834E
	for <mptcp@lists.linux.dev>; Mon, 11 May 2026 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495343; cv=none; b=jmDAEQSGxqhROL8wvIeDdeD9nQj0nBPzPCQmqXfCbFVsAfhYdY8lGGO8pAw/qzbhfWvpjp5LZeD0Xpjtm+yvNPzXxYDF0oJ5C2VPXlQBmum6KZnMWq1gIjWi2srIVhFZ8iSPkfcVCfED8+rk/WDhLBZHfT8QjeoiA2HZHtlWNsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495343; c=relaxed/simple;
	bh=Wg+71e/aNG/xpNEotw1GJ4TbLOD+/QV2mej0Hx0FS1I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sbWOvN9NitLQ9y/q4s9KcJM0WfgTHIP9bAH2JYs3xZL39XZEk9a2xEtCjuLVTGnGlCWJPLs2Jn6fpZj+KFr+wX13/OjCaYcQtMQHS742aZWURCBpHQMc3KDyVE2W0LrwmABieFLDLuh8rTbOKFGTJ/T9ARSWeDe6z2fx3eyI6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHGGIedi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHGGIedi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B42C2BCB0;
	Mon, 11 May 2026 10:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778495343;
	bh=Wg+71e/aNG/xpNEotw1GJ4TbLOD+/QV2mej0Hx0FS1I=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=AHGGIediLCco56W0oZGtJaBS6PL06fsjm3L3R+mIl/DYH80OxljOsZIFG9tRnDaFF
	 oYb3wpXhr+TgdZ2pbR4ATHNR0zBZ75OSnUhtQ+QRBjsTcFW5eOpCJVS0SmLy+EPCbM
	 iyVjtci4iH6sY9NUyfChl4Wd84D+H/Sqrql3+QZJgIl9W0G9ETCnmmEgnWOLZNWdFW
	 xcC70S8zEIvyUDC97E1S1R+3K1IWO0TnUjzJXDSfQPAZYcpW/2hN7OwVLOX0x0FojL
	 VMzVNaU5TNvkAf9f55+3Dw69DE6/UmNWaQSB/oq/reUKtDDTJ/O8SqVva/kTniuK/S
	 fhvAbhmTT97Og==
Message-ID: <429816d1-c207-4829-9c06-c7c2c0b59c3b@kernel.org>
Date: Mon, 11 May 2026 12:29:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v5 01/12] mptcp: do not drop partial packets
Content-Language: fr
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <cover.1778446731.git.pabeni@redhat.com>
 <2a88c5905617e57f9523a7a47c9f4e49e80ec81f.1778446731.git.pabeni@redhat.com>
 <7a0a1b9c-dc6b-4053-b5dd-e927019ccdfc@kernel.org>
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
In-Reply-To: <7a0a1b9c-dc6b-4053-b5dd-e927019ccdfc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/05/2026 12:14, Matthieu Baerts wrote:
> Hi Paolo, Shardul,
> 
> On 10/05/2026 23:03, Paolo Abeni wrote:
>> From: Shardul Bankar <shardul.b@mpiricsoftware.com>
>>
>> When a packet arrives with map_seq < ack_seq < end_seq, the beginning
>> of the packet has already been acknowledged but the end contains new
>> data.  Currently the entire packet is dropped as "old data," forcing
>> the sender to retransmit.
>>
>> Instead, skip the already-acked bytes by adjusting the skb offset and
>> enqueue only the new portion.  Update bytes_received and ack_seq to
>> reflect the new data consumed.
>>
>> A previous attempt at this fix (commit 1d2ce718811a ("mptcp: do not
>> drop partial packets"), reverted in commit bf39160c4218 ("Revert
>> "mptcp: do not drop partial packets"")) also added a zero-window
>> check and changed rcv_wnd_sent initialization, which caused test
>> regressions.  This version addresses only the partial packet handling
>> without modifying receive window accounting.
>>
>> Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/600
>> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
>> [pabeni@redhat.com: update map]
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v2 -> v3:
>>   - update map_seq, too
>> v2: https://lore.kernel.org/mptcp/20260422143931.43281-1-shardul.b@mpiricsoftware.com/
> 
> Thank you for this new version!
> 
> I suggest already applying this patch to our tree, so I can send it soon
> to netdev.

I forgot:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Now in our tree:

New patches for t/upstream-net and t/upstream:
- 7c4bbb8f4f28: mptcp: do not drop partial packets
- Results: 43f725eb6425..c7817ca73dd1 (export-net)
- Results: 31aef5b7fcb7..335465cfffb4 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/fe2e6c368bb7e0eaf46b51f4f7fa03a8223b9ea5/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/52f68f13d42a1c3752de7a776b6f873988f48401/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

