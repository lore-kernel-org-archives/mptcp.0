Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983DF13D291
	for <mptcp@lists.linux.dev>; Thu, 23 May 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456406; cv=none; b=c9yE3BkomqD2ZQaI03icHeHSwLfusuBy5Q+uTSUovNche9LH4GWUXyGwpEELarfV5GgDg0ZDoIv7DzweFSUGrZsHgDjzouXWVjjcvPaSFKVkKqySdLT0Ip8XIefXyhHUDJWSAnHm9WQzUJQPv95s3Yl3IEsPBxK6ogsDuroxXQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456406; c=relaxed/simple;
	bh=s7MVYU0EKzpKW84XdrzozY4AR6rQrSnEgREZyVdbhdI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nD+KZR+lk6xsU91p0rMMtMltE+yjl8leHda2et17QPQLTNDBppHqXCkZkqGHt+TzbISJyeTcf7NZPyIY+KAL8Ke383rtX8P4miUyxlNWqgHhGop8qLZA1ozff5/hRx+dYu+cjS5xltnGfBnJtJls8VXkQn17bz9XzdkobLk6qcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKbmAMTv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKbmAMTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF94C2BD10;
	Thu, 23 May 2024 09:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716456405;
	bh=s7MVYU0EKzpKW84XdrzozY4AR6rQrSnEgREZyVdbhdI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UKbmAMTvqeAGbevo0CPhWqsqXJ7pS6xNUeCVZ5MFadN+STnMkXOZij8AhjcXUolve
	 tUceOW4xil/di3mcc3CKAaVTtmuCkLa7nH8UiLxcfauk/NUjVt8cxG8ySFYMJaL5KT
	 4pXlTDZTrox6kg2vjDP/MSZPlq3AQPK3p1cpixmULc0wRGRnlWN4SOctsFs2pTYHEB
	 3lyJH5IhKY7JPEKBSxk40qtP+DI1YFxPz1LXkkhGIzbn2ckalV27Ox/nJJg4QkfWqV
	 92zEYe6lRqitLTzODPShRiPfflImpnLns5rPCJNmt5WV+s/fTeLhjRUJsrhbZsor8k
	 6rYJDtWRO0LDQ==
Message-ID: <ee6ae6878137687a0734cd7ea6767a86a8fb21a3.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/4] selftests: mptcp: use setup_ns helper
 in lib.sh
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 23 May 2024 17:26:40 +0800
In-Reply-To: <4fe52b77-75af-42ff-9079-fc61fb2509d8@kernel.org>
References: <cover.1716451525.git.tanggeliang@kylinos.cn>
	 <644ac151204efcd05b047d4e9b1545747ba785f1.1716451525.git.tanggeliang@kylinos.cn>
	 <4fe52b77-75af-42ff-9079-fc61fb2509d8@kernel.org>
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
 Px+2P2cKc7LXXedb/qQ3MuQINBGWKTg4BEADJxiOtR4SC7EHrUDVkp/pJCQC2wxNVEiJOas/q7H62
 BTSjXnXDc8yamb+HDO+Sncg9SrSRaXIh+bw9G3rvOiC2aQKB6EyIWKMcuDlD7GbkLJGRoPCA5nSfH
 Szht2PdNvbDizODhtBy8BOQA6Vb21XOb1k/hfD8Wy6OnvkA4Er61cf66BzXeTEFrvAIW+eUeoYTBA
 eOOc2m4Y0J28lXhoQftpNGV5DxH9HSQilQZxEyWkNj8oomVJ6Db7gSHre0odlt5ZdB7eCJik12aPI
 dK5W97adXrUDAclipsyYmZoC1oRkfUrHZ3aYVgabfC+EfoHnC3KhvekmEfxAPHydGcp80iqQJPjqn
 eDJBOrk6Y51HDMNKg4HJfPV0kujgbF3Oie2MVTuJawiidafsAjP4r7oZTkP0N+jqRmf/wkPe4xkGQ
 Ru+L2GTknKtzLAOMAPSh38JqlReQ59G4JpCqLPr00sA9YN+XP+9vOHT9s4iOu2RKy2v4eVOAfEFLX
 q2JejUQfXZtzSrS/31ThMbfUmZsRi8CY3HRBAENX224Wcn6IsXj3K6lfYxImRKWGa/4KviLias917
 DT/pjLw/hE8CYubEDpm6cYpHdeAEmsrt/9dMe6flzcNQZlCBgl9zuErP8Cwq8YNO4jN78vRlLLZ5s
 qgDTWtGWygi/SUj8AUQHyF677QARAQABiQI7BBgBCgAmFiEEZiKd+VhdGdcosBcafnvtNTGKqCkFA
 mWKTg4CGwwFCRLMAwAACgkQfnvtNTGKqCkpsw/2MuS0PVhl2iXs+MleEhnN1KjeSYaw+nLbRwd2Sd
 XoVXBquPP9Bgb92T2XilcWObNwfVtD2eDz8eKf3e9aaWIzZRQ3E5BxiQSHXl6bDDNaWJB6I8dd5TW
 +QnBPLzvqxgLIoYn+2FQ0AtL0wpMOdcFg3Av8MEmMJk6s/AHkL8HselA3+4h8mgoK7yMSh601WGrQ
 AFkrWabtynWxHrq4xGfyIPpq56e5ZFPEPd4Ou8wsagn+XEdjDof/QSSjJiIaenCdDiUYrx1jltLmS
 lN4gRxnlCBp6JYr/7GlJ9Gf26wk25pb9RD6xgMemYQHFgkUsqDulxoBit8g9e0Jlo0gwxvWWSKBJ8
 3f22kKiMdtWIieq94KN8kqErjSXcpI8Etu8EZsuF7LArAPch/5yjltOR5NgbcZ1UBPIPzyPgcAmZl
 AQgpy5c2UBMmPzxco/A/JVp4pKX8elTc0pS8W7ne8mrFtG7JL0VQfdwNNn2R45VRf3Ag+0pLSLS7W
 OVQcB8UjwxqDC2t3tJymKmFUfIq8N1DsNrHkBxjs9m3r82qt64u5rBUH3GIO0MGxaI033P+Pq3BXy
 i1Ur7p0ufsjEj7QCbEAnCPBTSfFEQIBW4YLVPk76tBXdh9HsCwwsrGC2XBmi8ymA05tMAFVq7a2W+
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2024-05-23 at 11:18 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 23/05/2024 10:08, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch includes lib.sh into mptcp_lib.sh, uses setup_ns()
> > helper
> > defined in lib.sh to set up namespaces in mptcp_lib_ns_init(). Then
> > for
> > each namespace in NS_LIST, run all sysctl commands. This can drop
> > some
> > duplicate code.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 19 +++++++--------
> > ----
> >  1 file changed, 7 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > index ad2ebda5cb64..59eb77e7813d 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> 
> 
> (...)
> 
> > @@ -412,20 +414,13 @@ mptcp_lib_check_tools() {
> >  }
> >  
> >  mptcp_lib_ns_init() {
> > -	local sec rndh
> > -
> > -	sec=$(date +%s)
> > -	rndh=$(printf %x "${sec}")-$(mktemp -u XXXXXX)
> > +	setup_ns "${@}"
> >  
> >  	local netns
> > -	for netns in "${@}"; do
> > -		eval "${netns}=${netns}-${rndh}"
> > -
> > -		ip netns add "${!netns}" || exit ${KSFT_SKIP}
> > -		ip -net "${!netns}" link set lo up
> > -		ip netns exec "${!netns}" sysctl -q
> > net.mptcp.enabled=1
> > -		ip netns exec "${!netns}" sysctl -q
> > net.ipv4.conf.all.rp_filter=0
> > -		ip netns exec "${!netns}" sysctl -q
> > net.ipv4.conf.default.rp_filter=0
> > +	for netns in $NS_LIST; do
> 
> Could you add {} (${NS_LIST}), to keep the same style (and usually
> recommended in order to avoid typos, etc.)
> 
> Also, I wonder if it is a good idea to use '${NS_LIST}': it might
> contain existing netns. e.g. with your patch 3/4, in mptcp_connect,
> mptcp_lib_ns_init will be called twice, modifying the first netns
> twice.
> 
> What if you keep:
> 
>   for netns in "${@}"; do
> 
> and use "${!netns}" instead?

We don't know the name of ns now because "mktemp -u XXXXXX" is executed
within setup_ns(). So we have to use $NS_LIST.

> 
> 
> > +		ip netns exec "${netns}" sysctl -q
> > net.mptcp.enabled=1
> > +		ip netns exec "${netns}" sysctl -q
> > net.ipv4.conf.all.rp_filter=0
> > +		ip netns exec "${netns}" sysctl -q
> > net.ipv4.conf.default.rp_filter=0
> >  	done
> >  }
> >  
> 
> Cheers,
> Matt

