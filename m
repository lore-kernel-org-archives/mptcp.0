Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08581586FE
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677236; cv=none; b=RYVgydtRj/cTVL4U7hBk/1PNsH2KCfHblQKmx9McyTlRe+TdUN3KC0K4VvE4btNHBRYQ0Lulqc/eyGYnHkAGlQeBrrhk4TTSBYNBGj4B5LaIHBhYIev7/V2R7av1QYEn9gxP0Hstfl0WJS5+LX3KVihXeLpLGGqxTPl9CziONY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677236; c=relaxed/simple;
	bh=N1rc/hJgTtSfu8qJxr1b+5GPe3NbgAX7Gny1oQACdh0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rmfXwzeZmkHEtwlcSuTlVsHxCXaKjhGYIaXIfq2XiSK3pIXs9kcbxwWRNRYSezui5Ss+3Zg8qAyRRb3X4jnBbWYIhfV98RGJY5tA/mLxgsE2uPun2FgsFdkmUb/9WpStcKPoDYeYkjNDZP5nkoiDczXmquDDh7QPOrzdWImBLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXJcO1Wj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXJcO1Wj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D5AC4CEC6;
	Wed, 23 Oct 2024 09:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729677235;
	bh=N1rc/hJgTtSfu8qJxr1b+5GPe3NbgAX7Gny1oQACdh0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lXJcO1WjhVs9QQL8ImWwyZyz4Ap38E5RLvf0qApjFoVqTuOj72Z8LrHXs8/gs/3wr
	 XqP31rXjzkNeONXXQUH4uEoIbznHXO+4WCTgv7UEtMEaBT2npuCmKYVGoN9ygyXvmx
	 ZL+j2avp4JI3ZQhx1XCO8YLSJGnXP3GnYvbkBwmx4JUlMINFJzmqjyiHByEEiBoqM2
	 AzoOEMrKQgNBciVzTJ6ZxIWrQFZjGq2VtoOCISUDF/ZK1ijIw42dOSDKiuN1LOpJNx
	 1M1PJY4HjusKQfurevdEqv/LZOUtb7kMxwXr9sgZzqw/MoYc0JDiGWspnTVZmIDj+g
	 rvR4HYTxakmdA==
Message-ID: <f598dd28d78b0d28a0df6ec16ac2d364cfc483b3.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 01/36] mptcp: drop else in
 mptcp_pm_addr_families_match
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 23 Oct 2024 17:53:50 +0800
In-Reply-To: <f7bc8980-37b1-414b-9f1f-4e9d46979916@kernel.org>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
	 <2274e7768f2534184f675b86b61c2f434290f98a.1729588019.git.tanggeliang@kylinos.cn>
	 <f7bc8980-37b1-414b-9f1f-4e9d46979916@kernel.org>
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

Thanks for your review.

On Tue, 2024-10-22 at 19:01 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 22/10/2024 11:14, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The helper mptcp_pm_addr_families_match() uses "if-else" to handle
> > IPv6
> > and IPv4 addresses separately. But the last line of "if" code block
> > is
> > a "return" statement. In this case, no need to use an "else"
> > statement.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/pm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 16c336c51940..f3d354a72c94 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -495,9 +495,8 @@ bool mptcp_pm_addr_families_match(const struct
> > sock *sk,
> >  		return !loc_is_v4 && !rem_is_v4;
> >  
> >  	return loc_is_v4 == rem_is_v4;
> > -#else
> > -	return mptcp_is_v4 && loc->family == AF_INET && rem-
> > >family == AF_INET;
> >  #endif
> > +	return mptcp_is_v4 && loc->family == AF_INET && rem-
> > >family == AF_INET;
> 
> I think some static analytic tools will complain because if
> CONFIG_MPTCP_IPV6 is enabled, the code will look like this:
> 
>   return loc_is_v4 == rem_is_v4;
>   return mptcp_is_v4 && (...)
> 
> Two 'return' in a row, the 2nd return is never used, there will be a
> warning somewhere.
> 
> Also, I don't it is worth it, and it looks clearer with the #else. Is
> it
> OK to drop this patch when applying the series?

Let's drop it then. It has nothing to do with the entire BPF path
manager set, and other patches have no dependencies on it too.

Thanks,
-Geliang

> 
> >  }
> >  
> >  void mptcp_pm_data_reset(struct mptcp_sock *msk)
> 
> Cheers,
> Matt

