Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5B312DD93
	for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539761; cv=none; b=PDetc/f/K8xbYrmBmADqh6LWiuB+txUhGQYI3bQTGJqBWh4XWe95I2TmXtRJtxEOcjRhx6vtFJYyaYBnH1RB9ej3abd3pRm7jRXL7eL4v1wKx4ssA7KU0ak4o+QcsfS6oCbNZbh+XJ1xJe4ypDs/AtlB6ksfZAeh5/JAVv5eX9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539761; c=relaxed/simple;
	bh=GCeoUX3g3YB6exg3tXg+0t9UN4UCcP0WyvRyIY1eJJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOXRQVw96YJu2/OkEJncrnrDEkidvugCYa8RMNth99vhO5JKZy13dGh2VCd0yCtRBKdpz/nRAGy5wGzVIYk1PrOcjEEmLz7hOEb1EiyNR7lFV7lBnTXb128S/iJfs2QWukVfbvVEP3QS0NqYUEo6U5lgSXmik3EC5tOiKHKMg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3GVK7Yf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3GVK7Yf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87255C072AA;
	Fri, 19 Apr 2024 15:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713539760;
	bh=GCeoUX3g3YB6exg3tXg+0t9UN4UCcP0WyvRyIY1eJJM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e3GVK7Yf6ep5iWUA+H+v4kovf7W7HV41w08IoXd7YqsIl3OaldyQnx1IS/EwmYai0
	 OhpZiLeXPj2RAbLPbszjuL4SVH3BeJ44fJpmaTBMApMPatnRRWWv9wkXEdemcb7bSo
	 Zk0t40V2BccJLkLm0nj5hIHQG2tdMvjKKj2Zlg3KfCAWe469SLKT0/agUNV5ogtoj8
	 mX1t98LsUMyl2mGH9918i8uaVFJ6KvORJuUAh1R8b1xPud7g07WI7CpyauNdjm37uC
	 0NWuliMvMAuMYkfkUjhke0dXKcM7FNYrvooOmtwQTtDjRMHlQ1WX3MkueeuFfAS2/K
	 nSKpTYrw8zm7w==
Message-ID: <f979f4ba-d075-4ec7-95b9-3edfa0fb354b@kernel.org>
Date: Fri, 19 Apr 2024 17:15:57 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3] mptcp: ensure snd_nxt is properly
 initialized on connect
To: Paolo Abeni <pabeni@redhat.com>
Cc: Christoph Paasch <cpaasch@apple.com>, mptcp@lists.linux.dev,
 Mat Martineau <martineau@kernel.org>
References: <3b0ca23eaa8906f967a841f55bafed48d0f895cb.1713367699.git.pabeni@redhat.com>
Content-Language: en-GB
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
In-Reply-To: <3b0ca23eaa8906f967a841f55bafed48d0f895cb.1713367699.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat, Christoph,

On 18/04/2024 09:44, Paolo Abeni wrote:
> Christoph reported a splat hinting at a corrupted snd_una:
Thank you for the patch, the review, and the bug report + test.

I forgot to send a notification after I applied this patch. In between,
the CI already validated this, and both the build for export and
export-net have the same issue with Packetdrill (fastopen):

- export:

> not ok 32 packetdrill: mptcp/fastopen/server-TCP_FASTOPEN-cookie-req.pkt (ipv4-mapped-v6)
> # server-TCP_FASTOPEN-cookie-req.pkt:23: error handling packet: live packet field ipv4_total_length: expected: 48 (0x30) vs actual: 64 (0x40)
> # script packet:  0.660855 . 1:1(0) ack 1 <dss dack4 3007449510 flags: A>
> # actual packet:  0.651162 . 1:1(0) ack 1 win 256 <dss dack4 3007449509 dsn8 4250179620018965011 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>

 https://github.com/multipath-tcp/mptcp_net-next/actions/runs/8752422517

- export-net:

> not ok 32 packetdrill: mptcp/fastopen/server-TCP_FASTOPEN-cookie-req.pkt (ipv4-mapped-v6)
> # server-TCP_FASTOPEN-cookie-req.pkt:23: error handling packet: live packet field ipv4_total_length: expected: 48 (0x30) vs actual: 64 (0x40)
> # script packet:  0.667029 . 1:1(0) ack 1 <dss dack4 3007449510 flags: A>
> # actual packet:  0.665988 . 1:1(0) ack 1 win 256 <dss dack4 3007449509 dsn8 4812888791396531368 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>

 https://github.com/multipath-tcp/mptcp_net-next/actions/runs/8752426856

Do you think this is linked?


New patches for t/upstream-net and t/upstream:
- b3584792f65e: mptcp: ensure snd_nxt is properly initialized on connect
- Results: 428f275bfbb0..e065a4657da5 (export-net)
- Results: b88f530f98b9..47bb272bba61 (export)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

