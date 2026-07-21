Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA7D3E49EF
	for <mptcp@lists.linux.dev>; Tue, 21 Jul 2026 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655852; cv=none; b=RR6SaEj19vJk0BgyryDZbL8916D4gXXngCWv6DfHKeyqOXb7lBwMa2KYdiD8HjKk6d3OIRPmWxhaDyvosUPxHS8RGwpYC3ejkM52vVhtiT9n8Pe9JwUcFpj/D/Db2MEYhtGE8ZwevVdpXDA7Vrsw9eCKsVE1Y8gS2pOvtnpyLww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655852; c=relaxed/simple;
	bh=riOloDyTxY/85C2hiT1xoqmuVNoe/5TBFzrh3ZPg/yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/eaQN/s3K73qkINe7KeyvgJVA0kLQnclIyH0tU/bQKG716tCz+K9LpykgQZk9eerimhXQB0fq8w+xSuSIAwiyxa/RRedX8p2SgRoUGS6m/YepmGUjeAGd5RLAQMMLAYYn1DHfW2Dr7fQuSc/EQ+EqkvqDVcSNz7asKA6LG4mdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qyu9aRiv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qyu9aRiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB29C1F000E9;
	Tue, 21 Jul 2026 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784655850;
	bh=3WxDFGPiu2T4+UAaYYGx9wlBUqX7mKevZJcsgyszGE0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Qyu9aRiv1IVGgA9Q7MKsrNLIf3lSJGgscq2q/qhz8Lbo0HXTPLySxsUuIZtddtnVq
	 n4atV/sP9fK+3X4DBi1dc4dvD5BaJe2X3WsIceOrm3qhNP6/N63staw4BqjWp5EGSV
	 hvDdLwD57IEw6nj9otuoLVsHYnrnRMa3EuaTIlZAS4zkdoE8wCyOEfvPLvipBYPWfh
	 dBnpWNcvhEhm9PN31wa8f6yycMF6UBL/NKwKQyS1HHKzYayB8PCR34qzcztmmPh9g1
	 nK3LcTBqo1uT1FCHyruEoQrN6naJFIVdfL876O0dT+w/C1QE0Qx6/2mQQZ2tXGQ9+g
	 wXQdJkFqsp3jQ==
Message-ID: <e4babe34-97a6-48aa-a564-a11da1136384@kernel.org>
Date: Tue, 21 Jul 2026 19:44:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: pm: userspace: fix use-after-free in
 get_local_id
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, GangYan <gang.yan@linux.dev>
References: <4e50adfde3b80f433e13b86919596be229045edc.1782799876.git.tanggeliang@kylinos.cn>
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
In-Reply-To: <4e50adfde3b80f433e13b86919596be229045edc.1782799876.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/06/2026 08:11, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In mptcp_pm_userspace_get_local_id(), the address entry is looked up under
> spinlock, but its id is read after dropping the lock. A concurrent deletion
> can free the entry between the unlock and the read, leading to UAF.
> 
> Fix by copying the id into a local variable while still holding the lock,
> and use -1 as a "not found" sentinel.

Thank you for the fix, it looks good to me!

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

I hope that's OK, but I added Xuanqiang Luo's Tested-by tag, as he sent
almost the same patch recently (BTW, thank you Gang for spotting that):

  https://lore.kernel.org/20260713074722.47921-1-xuanqiang.luo@linux.dev

While at it, I also added the KASAN report in the commit message, that's
helpful to prove this issue can happen and was tested.

New patches for t/upstream-net and t/upstream:
- 6b5c6ac1e2fe: mptcp: pm: userspace: fix use-after-free in get_local_id
- Results: 08c6392dbaf1..fef06e990c6c (export-net)
- Results: ea196b8ada26..f984839d1257 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/05643696039e56609f35092206657c6cdb725baf/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/97ce11d2793f114ca652a565a8d2795c085d8ff1/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

