Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793273373;
	b=HWf4v7PklfJ9caVq1vU8pz3IYSXBkCjyjuhAuPpX4Q1T+Ob2t14jn5TSHLsLmZzGW+b6
	 eN9ts6G/fb48st2x9Vaz7iYWq+R1J1sXx0i4cnXUEjFcDYjFVp5GMHXcL3bVzn+fHjhhQ
	 RIKNf6atKc362arBvbw0UjXMSA3quJGlw36436ILVIpWwLT97ywac9DHwfUxTJlsrihpB
	 Tj2vLwReJM68ZHQVUI6xwrOS3XEDc1H7MJCHGzL7TwKKTeFXfVyiDTMgnKv3Poo3xRDap
	 FSWCs8CgTzE7exk4m6POmTf2nLkrIuVYlrx+rLD5ssJx3ikLPk86ske4tTvhcgzXQVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273373;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=f4e5hAdUQ0cQSG0pWxfsfPDpF4I/CUJyLA7vOXgQpYU=;
	b=v5tmkZiArxdegVKdHq155F511P3Oc4bwB3Eiw/A8BXcEnV8lhD5b3BjB6X+OmIxz64Ri
	 K0SCCnYjglBosYZBDh1XW+rAwQOUZeyakGYmoEgiJKUKVY6Rg5LVzhAADE2So1zeij9Ln
	 APP2CbUHXEDFsHYdYIO2ag2s4wbvPmzo1KcOZHZGRb8gMYvlOGbbQo4m8I7jpBmbOvOXC
	 LB0mMIgv3fzpLGOUv47pQM9K/OfGyOyIM4llXflN5MNhb2UVqWD4BqiWCV6zmNqUk+dxC
	 B/LVwwMDbnaa7NzAWHC4D8LiHI8bhJmAaNZzdYGv8yraTKRXq5PrwfkCJumm/0DXKAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOXRNtMg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FBC606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOXRNtMg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05B51F01828;
	Thu, 29 Oct 2026 11:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793273372;
	bh=f4e5hAdUQ0cQSG0pWxfsfPDpF4I/CUJyLA7vOXgQpYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DOXRNtMgCB5SWloockxZrsG0KCZNyZIEUN9+eqiglzo7Sfup7LGsW1qG8y/oLMisb
	 lhS0pT7KVhqOTAaccXeliUve+CBBC4uM7YvXhH4muYTxfd2f2F+shM+Cfw3Ng3s9TP
	 YL6K1Isp7I/K42m88/doelACc5wgEfYOA3Yt3Ogxywcr3W+zfxCX7HWcBcS6enNiId
	 Iv5aIwaizncRovCWISBNE7cQ68cY/rc1S8iMeKyexopuadjdxhLqaqm/b30+9ZLczt
	 Mihh7Sm+BabLUwIkx+Fic9FHGOaQEZxJ4cSS5cKEe9cQHB/Ce0At/PpaaqAiDWFrqN
	 7fLm2IC9BwamA==
Message-ID: <8c832d96-4470-481a-8772-cf2bfc8d1fc0@kernel.org>
Date: Thu, 29 Oct 2026 12:29:27 +0100
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
Subject: Re: [RFC net-next v10] mptcp: normalize seq numbers reported in
 mptcp_info
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp <mptcp@lists.linux.dev>, martineau <martineau@kernel.org>,
 pabeni <pabeni@redhat.com>, Mpiric Private Limited <janak@mpiric.us>,
 Shardul B <shardul.b@mpiricsoftware.com>,
 Kalpanjani009 <kalpanjani009@gmail.com>
References: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com>
 <20261027095410.3675317-1-kalpan.jani@mpiricsoftware.com>
 <ad0f8a94-09b8-46d4-b807-94f1f52f1d1d@kernel.org>
 <1a17d565bd7.51ae4f93484769.4801857719496061627@mpiricsoftware.com>
 <1ec0c2b5-a0fa-44e8-9ae8-dca9b7f90ec6@kernel.org>
 <495a89c5-40ca-4758-8366-6c4c28e28112@kernel.org>
 <1a18212dbaf.7594e0f1624805.5831653841901931656@mpiricsoftware.com>
 <199b6eb5-0705-4c65-a6c2-402484e204c2@kernel.org>
 <1a1871ef80b.413e22cb735353.2237627450065761496@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1a1871ef80b.413e22cb735353.2237627450065761496@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 29/10/2026 11:05, Kalpan Jani wrote:
> Following up on the V11 patch, I've proceeded with the runtime
> validation of the submitted approach.

Thanks, good to know it can be an alternative.

> Could V11 be considered a candidate fix for this issue, subject to
> your review? If you think the current approach is suitable, I'd be
> happy to proceed with the next steps.

For me, the goal is still the same: the main goal here is not to show
the seq counters to everybody. This can be done either by adding an
offset -- i.e. starting from 0 or something else -- or by not presenting
them to some users. It seems better to normalise them, than reporting 0,
especially when looking at the v11 RFC modifying code a bit everywhere
"just for MPTCP": other net maintainers might not accept that.

So as mentioned before: try the normalisation/offset first, then if that
causes more troubles, hide the value to non-CAP_NET_ADMIN users but
that's more a workaround that might be hard to backport.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

