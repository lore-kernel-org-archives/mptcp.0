Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41DB18BC30
	for <mptcp@lists.linux.dev>; Fri, 25 Oct 2024 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845286; cv=none; b=i9SjoVmkGZZde/QvIngpCuTdY06PZTZayWOswCePdz+ziQS3mLZVCD4cBHsfx9jDFmNn3iFvSadDQm4VeiuCX/qZxpPGE90IbBSUqDXreqwBpUsDiRiYWiidSf5ATIPvJu9i0cogN6ShTRMMJlOR904Sn1Ry3wxqrEJDq3GdaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845286; c=relaxed/simple;
	bh=UmZpYcF5+2erLErpVIGwvhuwX3utzX53oC3xkkw/x5s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rE5/5LGuFJ2QBIBXIzzMB2DVZQmYWnK6+6l7bWdWcF09Blxsnwr+/JfBsTzAh7FjNWJTiEzDtiyvEM/Hi21J2bzPOq3XW18ZxmOl46xzAd/3A8Bs1EQqasnGHVYRnSz9LuWWbvehgjVoL0tmjCqAf6bTUDFKxyC609IASQH8r1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJj8VnEk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJj8VnEk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC6BC4CEC3;
	Fri, 25 Oct 2024 08:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729845285;
	bh=UmZpYcF5+2erLErpVIGwvhuwX3utzX53oC3xkkw/x5s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZJj8VnEkfitLzHGJJmE+08KfQvH6wqHXni0LQw6WjsFYCHtlKRHpOeeb/eFdm9/8K
	 3TuxiLk3vFlBaeEJ21cx9xvDBLtMeomWBsVc6YEJaKF3mJBIbP4/yE/P/H7vHGqHbr
	 BjHngx65N/Ii1prrvOzavgCmEyAXE57vnGLBWpifWnRyx9vwcGTP5cjG/3MUpcsDw4
	 Ajb2Mh5D68uJuu9YSj0ouE4a8LMN7mxwkfiklrcn6OUEQED69cb8aR2GtyXa/kanlp
	 +jqBk6Ac/gaP5ux3hRFsR7zw1i8coyEx7iJjJ1VXHLDla27Ew6ghfOGjKobdeBH7P7
	 84Krz6AuT6jiw==
Message-ID: <36cf3dd953c4abbb0df082b2594566e598ab48ed.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 0/3] Fixes for "use bpf_iter in bpf
 schedulers" v8
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 25 Oct 2024 16:34:42 +0800
In-Reply-To: <cover.1729765157.git.tanggeliang@kylinos.cn>
References: <cover.1729765157.git.tanggeliang@kylinos.cn>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBGWKTg4BEAC/Subk93zbjSYPahLCGMgjylhY/s/R2ebALGJFp13MPZ9qWlbVC8O+X
 lU/4reZtYKQ715MWe5CwJGPyTACILENuXY0FyVyjp/jl2u6XYnpuhw1ugHMLNJ5vbuwkc1I29nNe8
 wwjyafN5RQV0AXhKdvofSIryqm0GIHIH/+4bTSh5aB6mvsrjUusB5MnNYU4oDv2L8MBJStqPAQRLl
 P9BWcKKA7T9SrlgAr0VsFLIOkKOQPVTCnYxn7gfKogH52nkPAFqNofVB6AVWBpr0RTY7OnXRBMInM
 HcjVG4I/NFn8Cc7oaGaWHqX/yHAufJKUsldieQVFd7C/SI8jCUXdkZxR0Tkp0EUzkRc/TS1VwWHav
 0x3oLSy/LGHfRaIC/MqdGVqgCnm6wapUt7f/JHloyIyKJBGBuHCLMpN6n/kNkSCzyZKV7h6Vw1OL5
 18p0U3Optyakoh95KiJsKzcd3At/eftQGlNn5WDflHV1+oMdW2sRgfVDPrYeEcYI5IkTc3LRO6ucp
 VCm9/+poZSHSXMI/oJ6iXMJE8k3/aQz+EEjvc2z0p9aASJPzx0XTTC4lciTvGj62z62rGUlmEIvU2
 3wWH37K2EBNoq+4Y0AZsSvMzM+CcTo25hgPaju1/A8ErZsLhP7IyFT17ARj/Et0G46JRsbdlVJ/Pv
 X+XIOc2mpqx/QARAQABtCVHZWxpYW5nIFRhbmcgPGdlbGlhbmcudGFuZ0BsaW51eC5kZXY+iQJUBB
 MBCgA+FiEEZiKd+VhdGdcosBcafnvtNTGKqCkFAmWKTg4CGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBY
 CAwECHgECF4AACgkQfnvtNTGKqCmS+A/9Fec0xGLcrHlpCooiCnNH0RsXOVPsXRp2xQiaOV4vMsvh
 G5AHaQLb3v0cUr5JpfzMzNpEkaBQ/Y8Oj5hFOORhTyCZD8tY1aROs8WvbxqvbGXHnyVwqy7AdWelP
 +0lC0DZW0kPQLeel8XvLnm9Wm3syZgRGxiM/J7PqVcjujUb6SlwfcE3b2opvsHW9AkBNK7v8wGIcm
 BA3pS1O0/anP/xD5s5L7LIMADVB9MqQdeLdFU+FFdafmKSmcP9A2qKHAvPBUuQo3xoBOZR3DMqXIP
 kNCBfQGkAx5tm1XYli1u3r5tp5QCRbY5LSkntMNJJh0eWLU8I+zF6NWhqNhHYRD3zc1tiXlG5E0ob
 pX02Dy25SE2zB3abCRdAK30nCI4lMyMCcyaeFqvf6uhiugLiuEPRRRdJDWICOLw6KOFmxWmue1F71
 k08nj5PQMWQUX3X2K6jiOuoodYwnie/9NsH3DBHIVzVPWASFd6JkZ21i9Ng4ie+iQAveRTCeCCF6V
 RORJR0R8d7mI9+1eqhNeKzs21gQPVf/KBEIpwPFDjOdTwS/AEQQyhB+5ALeYpNgfKl2p30C20VRfJ
 GBaTc4ReUXh9xbUx5OliV69iq9nIVIyculTUsbrZX81Gz6UlbuSzWc4JclWtXf8/QcOK31wputde7
 Fl1BTSR4eWJcbE5Iz2yzgQu0IUdlbGlhbmcgVGFuZyA8Z2VsaWFuZ0BrZXJuZWwub3JnPokCVAQTA
 QoAPhYhBGYinflYXRnXKLAXGn577TUxiqgpBQJlqclXAhsDBQkSzAMABQsJCAcCBhUKCQgLAgQWAg
 MBAh4BAheAAAoJEH577TUxiqgpaGkP/3+VDnbu3HhZvQJYw9a5Ob/+z7WfX4lCMjUvVz6AAiM2atD
 yyUoDIv0fkDDUKvqoU9BLU93oiPjVzaR48a1/LZ+RBE2mzPhZF201267XLMFBylb4dyQZxqbAsEhV
 c9VdjXd4pHYiRTSAUqKqyamh/geIIpJz/cCcDLvX4sM/Zjwt/iQdvCJ2eBzunMfouzryFwLGcOXzx
 OwZRMOBgVuXrjGVB52kYu1+K90DtclewEgvzWmS9d057CJztJZMXzvHfFAQMgJC7DX4paYt49pNvh
 cqLKMGNLPsX06OR4G+4ai0JTTzIlwVJXuo+uZRFQyuOaSmlSjEsiQ/WsGdhILldV35RiFKe/ojQNd
 4B4zREBe3xT+Sf5keyAmO/TG14tIOCoGJarkGImGgYltTTTM6rIk/wwo9FWshgKAmQyEEiSzHTSnX
 cGbalD3Do89YRmdG+5eP7HQfsG+VWdn8IH6qgIvSt8GOw6RfSP7omMXvXji1VrbWG4LOFYcsKTN+d
 GDhl8LmU0y44HejkCzYj/b28MvNTiRVfucrmZMGgI8L5A4ZwQ3Inv7jY13GZSvTb7PQIbqMcb1P3S
 qWJFodSwBg9oSw21b+T3aYG3z3MRCDXDlZAJONELx32rPMdBva8k+8L+K8gc7uNVH4jkMPkP9jPnV
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-10-24 at 18:22 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v2:
>  - Use mptcp_stream_memory_free instead of using
> tcp_stream_memory_free.

Sorry, I made a mistake. The parameter of sk_stream_memory_free() is
ssk (subsocket), not sk (mptcp socket). We should use
tcp_stream_memory_free() here, not mptcp_stream_memory_free().

This set is deprecated and rolled back to the previous version (v1):

https://patchwork.kernel.org/project/mptcp/cover/cover.1729738008.git.tanggeliang@kylinos.cn/

Thanks,
-Geliang

> 
> Fix mptcp_join.sh (22) and packetdrill errors in "use bpf_iter in bpf
> schedulers" (v8) reported by CI.
> 
> Depends on:
>  - "use bpf_iter in bpf schedulers" v8
> 
> Based-on: <cover.1729676320.git.tanggeliang@kylinos.cn>
> 
> Geliang Tang (3):
>   Squash to "mptcp: check sk_stream_memory_free in loop"
>   Squash to "bpf: Export mptcp packet scheduler helpers"
>   Squash to "selftests/bpf: Add bpf_burst scheduler & test"
> 
>  net/mptcp/bpf.c                                     | 7 ++++++-
>  net/mptcp/protocol.c                                | 5 +++--
>  tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 9 +++++----
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 

