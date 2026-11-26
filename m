Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712090;
	b=XQ65hux55D/GKYHmJi1wdNVfYE3cCUrcpilLCpsYeWvOy5y+ulXtGROhlZG1O+TSH4zh
	 Rb0lE7Bfd/cGYiwk9FwDb9lbZoZD7AJlmNLMt/w95OWfpG/wqEZNuevZF2uhGt0kKChbV
	 +DMpwy6SXv1g/NKMetFZLpY/3jveXy7+WMTVtWRD74z4uW3CKnqVK4blcDtLgzFKICCOZ
	 tjfkHku2Aih0wYcmOrZg3Fbljp6j/1Q9ceqZnm3OgUG9AayaAZUJozSI+tjqAyT6hM/J1
	 JdHy1WSDYifrV+iAh2hRHQtKCDupcsPQIqxIOaDxEYWhm1d3cwGUDWx8H3Enz5oLIjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712090;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FoyEK8bQSgz+ER6xs2i5yO+LP3VUbpY4J9vorYoZunk=;
	b=vIuLchAzugqb1XO4SKAVWZAZb3X8DGP9f5F+252kgLlTuyVkz35zCTzQ9IrsU+uaXQhb
	 t2aGG/hUIc1dKAmRaWlXhlf5TwocIum0pUuu0GzT2M9LccitqjRbDByqNUsemI0jV2rKi
	 MthDzNCHNzKEzWCgAvgTTVdzI9J62FBUvvvaGJGMiBn91C2aca9Hi0GD8MMDPZoOrAVnx
	 Wffa7G6NZWmmTb09JYpS8VrvXLjicC0/RrZc9Sx8qSb1lSXol6XTdad0lP4WWZK034o+2
	 8oDqIUjfnJDjpmsx/fwmhI00NDd36cbMGo93fymjF3aOYNDfijCugWDVbuu/0NQfV5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFNPTp+g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427D606A31E
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFNPTp+g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ED21F000CF;
	Thu, 26 Nov 2026 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795712089;
	bh=FoyEK8bQSgz+ER6xs2i5yO+LP3VUbpY4J9vorYoZunk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OFNPTp+gvOKX2J7f+dq/O6D2uquUaYGjVQwHlgBtNzdEb7XP1xZ36nZT25KdM3uuV
	 6ZJqv5SIdx1xz+aRy21jI37DmBI4tAe9NihYx7+B4EvbyHOCaZmuCbXsMadbUc+rky
	 XFAy9gyDFoSdkocH+fFug+BqaDP4ww1hMIlUOzyDznvBuT9geCQrJCbVdto0gUukVr
	 AYgpXhGYCjoSC3OgakhDG4cObFAwXR9ds8/4m7dlHmrBWvyQ4pOjdFwXmZaBGND6kB
	 XEIkCcpZSo+JxCs9VIABfFBBKfeSXrSApNIdnaFMLrWsXel4QpUlEf7iP45Kj+zD0f
	 R0uKvlD36V71g==
Message-ID: <431fc4b6-897f-462e-a9fe-9cdb72550e94@kernel.org>
Date: Thu, 26 Nov 2026 17:54:46 +0100
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
Subject: Re: [PATCH mptcp-net v3 00/50] mptcp: misc fixes
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: Chris Mason <mason@kernel.org>, Kyuwon Cho <kyuwoncho18@gmail.com>,
 Josef Bacik <josef@toxicpanda.com>, MPTCP Linux <mptcp@lists.linux.dev>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
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
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 24/11/2026 22:59, Matthieu Baerts (NGI0) wrote:
> Here are various fixes, some from Chris Mason and Josef Bacik:

In order to help to trim this series down, and avoid blocking other ones
for too long, I suggest applying the 37 first patches. So up to "mptcp:
continue the last mapping after a fallback", which is the last patch
from Chris.

I applied Mat and Clashiko's comments (minor tweaks in the commit
messages and comments), and I will send a v4 with the rest.

Of course, I can always change patches applied in our tree with
squash-to patches, and add RvB tags.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

