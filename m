Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680411;
	b=t8NQ3T2lF2CedyPq6zbIccntHlOuuS4lBCi30aiSbvBQY7d0yAX/26AO5EuY2UIV0DX2
	 Vn848pbzEoRPwpJ5wC7MGeMu1ne0zDBk3BRc7OLQKZLXvvHLgP0eXAmLgEjIJSPX44NOo
	 BmzPcmqqvAT9AsuDrMozPqiqpB4zEJX3wSE/g73pY6P9WoFYHrlDuRtA4MFB57PoOeAli
	 XlQ9JYOJbjk3WxKvSZr4vgnoq4waYmBj0O7ORCojxSvlrZxcSAhRsRYfBPoOFmDul1jLz
	 4d+gbZmb6HU87DoRwaEhnBAYmXnlQLFyAo+0ek6779+nHc5hZvcsB2G/ReZUsCSLYRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680411;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=LYk9aLxQnOu/bvDfPUNB6csOP2HH0Y/ZASDygmFPqEs=;
	b=oncQKY8B1KjSf/EzldJ7n/YrXJ3KTcBxiRR8kUzRkYKHyK0cJjJqNWS/tVjjHGkGbBh3
	 cYAL5NF8X18mfUlwvqd+wwoq7n8w0lVrUVnxUnmYzln1ex+2G6V1uBC5ZwKm/sYEi+5Dw
	 +CmHNzEiQX7p+kRuQMM0L19hYnWTlmEm4+9t6OLNCFGZDF/gTPYFh+nusJMgF5FXtNYfw
	 ou5g+I2QIoWqhhxV3+j/LdU1QRa6mA9ZuYM5Ig6f86Y51jIJkjkXv2J8Xu8wo9lgOkWgP
	 PtmXBFubFPgQmnfJicQV+fSgdiqDNVOM3yhXMFe9dJP5TAvL6mlmWQCJ7n1fgQTBdHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFB4OnRi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DACD606A323
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFB4OnRi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C321D1F000C4;
	Thu, 26 Nov 2026 08:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795680410;
	bh=LYk9aLxQnOu/bvDfPUNB6csOP2HH0Y/ZASDygmFPqEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NFB4OnRiqj7SzqGRwYDXceEMNtTseL/wYtip74UEp6u9cY/RMXghwpDtJq2jeglGX
	 KXe2cyOs9OL5nmG1rDdkoHTswmZemkgQ9Lwxc+nwLK959XV2pKQKN9wmMy/kMOYfsJ
	 IyCXSAGG3ju2nfs37Lia0/5WlJB91Qupm79TDR+DXfrzxiyd6h3HixPHVUc6POBA17
	 obB+LUSTuoRCKudOzx5pTsIaw9exd66v3lNLpz1qdxwKNRlPprHbZ9P0Ca10+3WqTK
	 nwmMC6zszBDyLwVeec5730Pg1539uTDmoL+6erOtyyuPw1XPWKlK6EjgDB/2eW9HAu
	 xiW2rictpkS1w==
Message-ID: <dfca6534-d547-4e50-bb6f-66985ead05d0@kernel.org>
Date: Thu, 26 Nov 2026 09:06:47 +0100
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
Subject: Re: [PATCH mptcp-net v3 04/50] mptcp: return EOF after a DATA_FIN, as
 TCP does
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
 <20261124-mptcp-cmason-fixes-v3-4-416c0920c73f@kernel.org>
 <39c8abe7-1af4-7e26-a394-f7cf0b5d86d8@kernel.org>
 <229f98a10259d919820fd8ef31fbf21f9e0dbfeb.camel@kernel.org>
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
In-Reply-To: <229f98a10259d919820fd8ef31fbf21f9e0dbfeb.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

Thank you for the reviews!

On 26/11/2026 03:59, Geliang Tang wrote:
> Hi Matt, Mat,
> 
> On Wed, 2026-11-25 at 17:57 -0800, Mat Martineau wrote:
>> On Tue, 24 Nov 2026, Matthieu Baerts (NGI0) wrote:
>>
>>> Once an MPTCP socket has received a DATA_FIN, recv() returns the
>>> remaining data, then EOF. But if the connection was then reset, e.g. by
>>> an MP_FASTCLOSE, recv() returned an error after the data, e.g. EPIPE,
>>> instead of EOF as TCP does. A proxy resetting the other connection on
>>> read errors then dropped the data it still had to forward.
>>>
>>> As TCP does with a FIN, set SOCK_DONE when processing the DATA_FIN, and
>>> check it before the socket error in recvmsg(). With an MP_FASTCLOSE, the
>>> data still in the backlog is moved first, not to miss the DATA_FIN.
>>> After a fallback, a DATA_FIN is also emulated after a reset: only set
>>> SOCK_DONE after a FIN, not to hide a reset behind an EOF. This FIN is
>>> cleared when the first subflow is disconnected: process this DATA_FIN
>>> before.
>>>
>>> This was reported on GitHub, and is validated with new Packetdrill
>>> tests: data and a DATA_FIN are received, then an MP_FASTCLOSE; and
>>> after a fallback, data, a FIN and a reset. Without this patch, the
>>> second read() returned EPIPE in both cases:
>>>
>>>  receive_fastclose_after_data_fin.pkt:27: runtime error in read call: Expected result 0 but got -1 with errno 32 (Broken pipe)
>>>  v1_connect_tcpfallback_fin_reset.pkt:19: runtime error in read call: Expected result 0 but got -1 with errno 32 (Broken pipe)
>>>
>>> Note for the backports: the issue with an MP_FASTCLOSE comes from commit
>>> 69800e516e96 ("mptcp: propagate fastclose error"), in v6.1. Before that,
>>> the modifications in mptcp_check_fastclose() and mptcp_disconnect() are
>>> not needed.
>>>
>>> Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
>>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/647
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
> 
> Thanks for adding this SOCK_DONE patch; it is very helpful for my work on
> modifying mptcp_inq_hint(). mptcp_inq_hint() should check SOCK_DONE, just like
> tcp_inq_hint() does.
> 
>     Acked-by: Geliang Tang <geliang@kernel.org>
> 
> I'm wondering whether this patch should come before patch 1, because patch 1
> checks SOCK_DONE, but SOCK_DONE isn't set at that point.

Yes, maybe. I mean: this patch 4 fixes an issue that got discovered when
working on patch 1. We could but if there are no objections, I would
prefer to keep this like that: the 6 first patches are likely to be sent
together, and both patches 1 and 4 should be backported to v5.15. So no
for extra work here?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

