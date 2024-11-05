Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6E18F2F7
	for <mptcp@lists.linux.dev>; Tue,  5 Nov 2024 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801100; cv=none; b=DobWcfJLetj1tuMOB5MZEfa+hGJFa/AdiPFA/00Tt8VJiBDjE8akQZ5e+KcJIV2uQ7Psrnzyrc2yE6vBg/UQ2VJ2i7/++dJXDrQCvM/54WcEDMkCZQKBMGcvk+yB6UwwufOGdt5KECqA1Bk0Ghl+fVmvUsTqFg+YPe1cMorspA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801100; c=relaxed/simple;
	bh=twFpbNsZ97t+qxz2dQG0sfb8fvSzK4g4HK6UjWkd7a8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FaUGqY2arM/51yVhlBPkPibrz70a5QT4+wPJn1E88qJ4KW7itKTmztx1wI/zaM6G9Ck7Fg+TpHFuG+JCEbecQT4twwYbcnloWtld/sfeHKrdrVSqD+4y4KEkmf85mERhxEbL7FBKzpsm4ht/H0KD3/3erJIkA0j/54EbEAQ6jgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fArGh8BY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fArGh8BY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D4BC4CECF;
	Tue,  5 Nov 2024 10:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730801099;
	bh=twFpbNsZ97t+qxz2dQG0sfb8fvSzK4g4HK6UjWkd7a8=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=fArGh8BYdbut53Usj0QHUsEdxAgm6lxDKAJPuAQikcEEVFZBIK6iCPbyHFVv1fbui
	 5TjK1/K4J1G+Y42txC1L3Lmf1V27YQrKtERMseP4T/Ezhywq1XUHOinjs0+2NO25Y6
	 7dsV62D9Jz63lUAltONYm/byCORUkJgsZMqfJ2zuyXcCMDZbQ+VdsU0FO+s60YSULH
	 YxhwgUUuDrlL65nlfUnqYBdbTSXFOvCqwwW+3ra3tCe8VhHx65XIf+ei4m3IGbQRSx
	 LZsLpSSH2ECYIoIFM0CzUJ1EDQhcgphBruikKLkQX+VjLbbURHArxWUJ6lMW2gKw5N
	 AADCj0hM3tKMg==
Message-ID: <43488f69d72f7c8e2d9f3ab2e8f6620992275e7e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "DO-NOT-MERGE: mptcp: improve code
 coverage for CI"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Tue, 05 Nov 2024 18:04:55 +0800
In-Reply-To: <21137b33-9b79-403a-8032-6aec174e91f2@kernel.org>
References: 
	<ab62e7d2f50512594416acb973dcaf3d4ec85fe3.1730708911.git.geliang@kernel.org>
	 <26b229f0-9b4d-43ca-b06d-0d2ff1271c6c@kernel.org>
	 <21137b33-9b79-403a-8032-6aec174e91f2@kernel.org>
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

Hi Matt,

On Mon, 2024-11-04 at 13:07 +0100, Matthieu Baerts wrote:
> On 04/11/2024 12:58, Matthieu Baerts wrote:
> > Hi Geliang,
> > 
> > On 04/11/2024 09:28, Geliang Tang wrote:
> > > When our bpf_selftests are re-built, this error occurs:
> > > 
> > >  make[1]: *** No rule to make target 'atomics.lskel.h',
> > > 			needed by '.../atomics.test.o'.  Stop.
> > >  make[1]: *** Waiting for unfinished jobs....
> > >  make[1]: Leaving directory 'tools/testing/selftests/bpf'
> > >  make: *** [Makefile:259: install] Error 2
> > >  make: Leaving directory 'tools/testing/selftests'
> > 
> > Ah yes, I already noticed that when checking some stuffs, but I
> > didn't
> > investigate. Thank you for having looked at this!
> > 
> > > In this case, I had to remove the cache directory .virtme and
> > > recompile it
> > > again. This was very time-consuming.
> > 
> > You don't need to remove the whole ".virtme" directory, you can
> > remove
> > ".virtme/build*" instead, so you still have CCache (from
> > ".virtme/ccache*").
> > 
> > > A workaround patch for this is found in [1]. I don't know why
> > > this patch
> > > has not been upstreamed, but it's in BPF CI environment. I think
> > > it's
> > > necessary to synchronize this modification to MPTCP CI
> > > environment as well.
> > 
> > It looks like another version has been applied in bpf-next, even if
> > it
> > is a fix:
> > 
> >  
> > https://lore.kernel.org/bpf/20240916195919.1872371-2-ihor.solodrai@pm.me/
> > 
> > Do you mind checking it please?
> 
> Just in case, their bpf-next/master branch has been rewritten in
> between. The last ref I have is:
> 
>   fd4a0e67838c ("selftests/bpf: Set vpath in Makefile to search for
> skels")
> 
> > If it works, I can backport it to our tree, and ask BPF maintainers

It works. And "selftests/bpf: Set vpath in Makefile to search for
skels" is in our tree now. So no need to apply this squash-to patch
anymore.

I changed this squash-to patch as "Rejected" in patchwork.

Thanks,
-Geliang

> > if
> > they can add these two patches in 'bpf' (fix) instead, because this
> > issue is present in v6.12, but only fixed in next (v6.13).
> > 
> > Cheers,
> > Matt
> 
> Cheers,
> Matt

