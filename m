Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793273520;
	b=NFVNcjnGGSOI5oVjyAg6LIb+Tvi7U0Xmos8UApThiz8cJYXQ+8xs6olFGi9XpxoOovZK
	 ibF+/fL3dDWpDHV82fudn5yRmYpOVCaD1v0j0WldbtN+JwUzSFVrl1cIrJUwkt69QzX7D
	 O9O1yvcLNOFO5c7Ofqt0V63A93egNw9heQwUENNvC5Yu510can1pVH/JE0C1nJPiE2nD+
	 zH1HZYZcI6qHydvtDAuDelSATY4m6XHlwumKYk5Ihe7Nn8yyeu4vgiuaS0tYz+Olpu3P0
	 Zl3ms2QWbYJiNPE2HXikBT2QIj9CsWZ8wTkk2ZbyetKixlUWxs0ZF5C2+4H3vsOICJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273520;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:From:To:Cc:References:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vr49/uDUdrrPdW59aSLQ9rQWq28XKupxTJhlHHY0qNo=;
	b=g1stzKtF5O1Edm6OEsJ82UZCH3OJKezf5bZRgirHtVNdiIH7Yi5lSMWHAwBhxHhTQjoQ
	 /4PINoI42ixK1DfNj0P5ixI7K5X+o7ilqRzCdap/h0QPoSeFN6vlyOkp8Tl4Nxsi3RzS8
	 ofFQ8s+KLbBJvtPj7/SFtT1uTvTtQ+5AWQkHWlION2+cB0SlGuZRkhUJ0UfoNzcuZ8Jjc
	 RtkE66jPepI3FpS8Ox8vIOQGDzJvYmXZOkmE8M06w5M5V1CVX1jleB/QAgyAahZU9uyTP
	 Pa1ZgCzT+dR/C7ryumXywh3G+zlbl9GnJF5/KUXiAKgHgfxEbkqqMYO5Cl0y/XqAgqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOeD6W3v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6D5606A31D
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOeD6W3v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB57B1F01825;
	Thu, 29 Oct 2026 11:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793273519;
	bh=vr49/uDUdrrPdW59aSLQ9rQWq28XKupxTJhlHHY0qNo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=DOeD6W3vVwMj+SnX7sEDWx4G7OrIy0tKOBPy+Myr1PhlDL8fZrG1uX2OKdcQpoD2x
	 XHTqXBHZk0j7eUqTB8MUHh2myXloidxSDXtz5Jr9zY2LbXuVQiyLSejXO23+11U07n
	 hSPmdK/VhbXvUWjdkZ3MjclmlfqZW27n9OPJr1+NHcttfF9rIMAbKvtTysXUPrzgS2
	 ux1xRk19OMYIITE6gnS/hllOd/4IPx7pRRLiPuVR3YnNzMXiMwtnegIyC7mQTo8OoT
	 JBfbyjEKQ9zKJuvO06D6HF5QQCXAyO1NHdpS5su7Bi7gfOK29KB9z1zlRU4qrSOytS
	 psZkHw+auC0sw==
Message-ID: <25c89b55-e853-4340-b44b-8593f1d18171@kernel.org>
Date: Thu, 29 Oct 2026 12:31:56 +0100
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
From: Matthieu Baerts <matttbe@kernel.org>
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
 <8c832d96-4470-481a-8772-cf2bfc8d1fc0@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8c832d96-4470-481a-8772-cf2bfc8d1fc0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2026 12:29, Matthieu Baerts wrote:
> Hi Kalpan,
> 
> On 29/10/2026 11:05, Kalpan Jani wrote:
>> Following up on the V11 patch, I've proceeded with the runtime
>> validation of the submitted approach.
> 
> Thanks, good to know it can be an alternative.
> 
>> Could V11 be considered a candidate fix for this issue, subject to
>> your review? If you think the current approach is suitable, I'd be
>> happy to proceed with the next steps.
> 
> For me, the goal is still the same: the main goal here is not to show
> the seq counters to everybody. This can be done either by adding an
> offset -- i.e. starting from 0 or something else -- or by not presenting
> them to some users. It seems better to normalise them, than reporting 0,
> especially when looking at the v11 RFC modifying code a bit everywhere
> "just for MPTCP": other net maintainers might not accept that.
> 
> So as mentioned before: try the normalisation/offset first, then if that

Just to make sure that's clear: the normalisation (i.e. starting from 0)
seems more complex than initially thought, plus it seems that we need to
store more counters just for that. Using the msk address pointer as
offset seems easier, but we will see once there is a PoC.

> causes more troubles, hide the value to non-CAP_NET_ADMIN users but
> that's more a workaround that might be hard to backport.
> 
> Cheers,
> Matt

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

