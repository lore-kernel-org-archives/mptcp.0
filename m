Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997111;
	b=tuuglmIe3GHydCq0Ac34seopQ0P0PykWjLim/RVorxYgRWtMImyiNVaM2ey1Uh3V9jUB
	 lWIYADyy7CLvE2oHUdHx6kDbH8by0IbSvFI0wMWYNxUyQwTukHD3t1SxhkRK8Q1QSgka7
	 XG/OPldrwtiyXOQteLClru1M8yOHvdsh2HBYfLGUTixY/fIFlqPv3QF98HPDGKTw2brzI
	 747LHO0HJJ0DjpnfufUT+339iVg02sqSGilxYs8PyOhhm76558bm9tfzz48nfSUsMVBmZ
	 RUJ9TSpSwBGGX0nUnxlqVJoxIW7SM10C6TnVY0NOmIxwMnvQFiNVvlc4gxtthaZTNnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997111;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=fXItq9GGroIycGnu7b0OzPVvdIkBKPoNJa40AjB5LJ8=;
	b=ZJ3jlbrE0NF2i10yOWRl7hbArbQJamJN2/gAaVjHW4hHGcWI8Fe1i5K6pRh07OSha6pb
	 QmecBOnMBWd11jCwJr44RMzQ0rH4hdK7bvYWU3Z8iJeQNQmZYEtD4kiTqQKDgpiWD8wCW
	 gjMSoSzWzVEE5bG9BKWCilZarGvrQChdSIDdDjBDQwzp6SwnaPfHjwpR0oKfurcBcvtc5
	 viJf8xxUOl0VJaGtn2P7hRUnBopXW2qCo03huIdl10XodrvQCrRTTJ3wyrAyedWuZwKX1
	 xq7rQ06k5+1J7qUC5H2V0GzeFUWWLH2ibThYa8yDmIkUnLHnrllyxwSEOCyZjWC/Qtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmNw3AR0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C2606A31C
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmNw3AR0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08121F000C4;
	Wed, 18 Nov 2026 10:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794997111;
	bh=fXItq9GGroIycGnu7b0OzPVvdIkBKPoNJa40AjB5LJ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hmNw3AR0TBDp98ktD7AvBslmPYSC4yvsvX872BbhnHYd7lFFWPL4HQEr+z040T926
	 GyangioH+b3PFKq8Hb1ThW44AyaWUP0IdMkW68LXSfp0Ahh/C2WvG48frfTTwrqiQE
	 FVmoDytJFLNfoupJN9mZVh53t174T+5Vua5LEzSZ8K/yOOMmc9KGBADBgXrjCs49/w
	 1LydaDKCEwOxluAFc7iCKIOKl4R1mDPurwJqzZSBWS3FhwZYwQzquIEzpGvX3W9/uK
	 fuwMu+gyk1HkgRUu+DhOpGcDUjTEWicZUHz0RP99mfsUSblLwShbaaYLLzQ+pejvkE
	 Ma2WNAQBhSwTQ==
Message-ID: <e78c7751-80ca-4026-a3b1-a782d82e09af@kernel.org>
Date: Wed, 18 Nov 2026 11:18:27 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Gentle Reminder: Review Request for MPTCP Issue #349 (v5 Patch
 Series)
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: Mptcp <mptcp@lists.linux.dev>, pabeni <pabeni@redhat.com>,
 "shardul.b" <shardul.b@mpiricsoftware.com>,
 Mpiric Private Limited <janak@mpiric.us>,
 kalpanjani009 <kalpanjani009@gmail.com>
References: <1a1e7f71a64.801c4dc0528499.8854228492193794083@mpiricsoftware.com>
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
In-Reply-To: <1a1e7f71a64.801c4dc0528499.8854228492193794083@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 17/11/2026 06:24, Kalpan Jani wrote:
> I would like to kindly follow up on my v5 patch series for Issue #349.
> 
> Link: https://lore.kernel.org/all/20260915093506.465110-1-
> kalpan.jani@mpiricsoftware.com/

Thank you for your reminder, and for your patience. On my side, my plan
is to finish all the series I have in progress, especially the fixes
ones, but I will try to do some reviews in between.

> The patch series has passed the Sashiko tests and CI runs. I would
> appreciate it if you could take a look whenever you get a chance.

When you have a chance, do you mind rebasing it, and re-sending the last
version? In between we got netdev sashiko doing some more advanced
cross-reviews, and we don't want to be blocked by items it would find
when sending this series upstream later on.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

