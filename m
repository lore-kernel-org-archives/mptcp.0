Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101078;
	b=QSXAxmFYCzg69d/V1ha7mmh30D/VpgO0nan1RE+Gna4fNxsS+CJfXnmOtpYbLmqE0ud+
	 dzESc+RjbaxHPGx2/Jq5cktmpNDZnNoXOQqDqaq3PRLyKOGIrlEZdo7YAfYe5KUXrap48
	 c5UM0TFdcuaeSgTVYrLgJZBcG/B2/C8s74mAJ/rvxssvAohpODe2ihunZDW681Ivcoqep
	 nM9F5e92iRFvo08/CBJ4r/amuk4ZUc4dFKuQ5fvO7yyR1lYD5dNzhIPwuTOZg2iGjR0tA
	 12tyAYhfAZn20NpKaTnqkr0AlxLGJQepA9whhiSEp57I9Quk7JX9qFtqtzwz1ewcfpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101078;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=uOA0iJPw4gs7KK7S9jPjhTmkmZxUL4CUjhO0yKV8uxs=;
	b=dKMA5wJ4Vkjs9G9Izy7WZAiVyadc0LtWxSeAS+TnRjzRnjAz6re2bhjBZ7WncCyzDEec
	 yflNwaPVWTl9589wGy1PrLSZSvFHIeMPYDwtMsXYmsCOrFRBKtIhsXamYqUX3uUDe+ABM
	 +7UKJ5jwUmTxOs+P9zBRO1rpisdGPVKU7v2XG9Kt7rfDU2FLfxSjQc01VNLokgg7ccBh8
	 4Sl+vEu0erxBU8sGoU9xo1gC4gm2lENCrx4tEIlsbadPMsu537ZKLeiV54phe+5Mc8Wa8
	 PIbQkw+X2NUpw1LAwZJ3CiAY2qYZcCxdxmimIohQbn78IWG/zaa6NF/ds3/NEK8eHhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnA8Ms1Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CC8606A31B
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnA8Ms1Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5421F01828;
	Tue, 27 Oct 2026 11:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793101077;
	bh=uOA0iJPw4gs7KK7S9jPjhTmkmZxUL4CUjhO0yKV8uxs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XnA8Ms1Qcl+k6U7BjpBECvsZ9Mxj29H+W1Mk0oeT9iznlRfJQtj34mp5BE6AbcDTX
	 Pl7rr+5ERewEUQpo62fAlWaSzx0p0Zio9l7Y8xMvLsp3VebN9YxaRdK3ZLTo4A1K4I
	 KsD7Bvs1HNr29VXndzP2DPzRG5glO5JXyFVM4PttlWt/XRoVAP7OkkLwCodm2Z7wH4
	 GbpEuKqlVulOZTEMQOm4SRTadXvWXV/dSYGtz7K2qhHidpcJHFVAJ75miHZBrlHmSc
	 rLmT5+xV5Z8SmZ1jsgsYqTdCg2c5ARM81BsWh2Cz4iQ4fMwBGDSZJWiNeNmSyyexAh
	 jKj/spe8eq6+w==
Message-ID: <076d9826-4441-4098-9d35-c568d38ccfc6@kernel.org>
Date: Tue, 27 Oct 2026 12:37:52 +0100
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
Subject: Re: [PATCH net] mptcp: protect listener backlog reads in diagnostics
Content-Language: fr
To: gang.yan@linux.dev, Cen Zhang <zzzccc427@gmail.com>
Cc: martineau@kernel.org, geliang@kernel.org, mptcp@lists.linux.dev
References: <pm-mptcp-objects-candidate-0066-v3-73df72b7a543d4cada0e@gmail.com>
 <CAL4WiiqEHwZRhSRXqFOtF3OYsX_v3519Ey8AEknbaZKFNogeJA@mail.gmail.com>
 <CAFRLqsU2QHD2Ta2aL_qSVr9nVFrn6mXV_nZ987+oqHUbCa7ZSw@mail.gmail.com>
 <f88992ae9b2dc51fd3a0ba2f9c23a29a91660877@linux.dev>
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
In-Reply-To: <f88992ae9b2dc51fd3a0ba2f9c23a29a91660877@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gang, Cen,

On 27/10/2026 11:41, gang.yan@linux.dev wrote:
> October 26, 2026 at 10:44 PM, "Cen Zhang" <zzzccc427@gmail.com mailto:zzzccc427@gmail.com?to=%22Cen%20Zhang%22%20%3Czzzccc427%40gmail.com%3E > wrote:
> 
> 
>>
>> Hi Eric,
>>
>> Eric Dumazet <edumazet@kernel.org> 于2026年10月26日周一 20:38写道：
>>
>>>
>>> Adding these stack traces without symbols is not really nice.
>>>
>>>  Time to use scripts/decode_stacktrace.sh
>>>
>> Sorry about that, v2 carries the report decoded with
>> scripts/decode_stacktrace.sh and trimmed to the relevant frames.
>>
>>>
>>> msk->first is a TCP socket: TCP listeners have SOCK_RCU_FREE, and
>>>  tcp_prot / tcpv6_prot use SLAB_TYPESAFE_BY_RCU. Reading two integers
>>>  under rcu_read_lock() is safe, and stale values are fine for diag.
>>>
>> Thanks for the suggestions.
> 
> Hi Cen,
> 
> Basically this looks fine to me, I don't see any issue with the overall
> approach.

@Gang: Thank you for your review! (Don't hesitate to send a
Reviewed-by/Acked-by on the v2 then ;) )

> Also, could you send v3 separately to the MPTCP mailing list? It seems the
> CI checks were not triggered this time. I guess it might be because the
> patch was not based on the export branch of the mptcp repo on GitHub, so
> you can generate the patch based on that branch
> (multipath-tcp/mptcp_net-next, branch export).

It's not clear to me why the CI got an issue to apply the v2:

  Applying: mptcp: protect listener backlog reads in diagnostics
  error: corrupt patch at line 38
  error: could not build fake ancestor

(Not sure what this "line 38" corresponds to)

https://patchew.org/MPTCP/pm-mptcp-objects-candidate-0066-v5-4d1b83d62fcde2d57e8d@gmail.com/logs/git/

But I manually applied the patch and asked the CI to validate it.

@Cen: just to be clear: don't send a v3 just to fix the CI issue, except
if a reviewer asks you too.

> Two notes for next time (Important):
> 1. For MPTCP-only patches, it is enough to send them to the MPTCP list
>    only, no need to CC netdev.

Small note: for "urgent" patches, it is fine to send them to Netdev as
well, following what's in the MAINTAINERS file. For new features and
non-urgent fixes, it is better to send them to the MPTCP list only to
reduce the traffic on the Netdev list.

> 2. If a new version is needed, please wait 24 hours before sending it.

(or more: wait for the Netdev Sashiko review)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

