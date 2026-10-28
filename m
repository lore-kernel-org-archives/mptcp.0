Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184101;
	b=fXOG8pmvgI5G2SRrzDRCgTJQhNM3+d4ZDi9Vq2DadifUsEeenghHfru0PlX9CewAZFSS
	 45RZlKlI3bmZ0WCkL8PqNuUcCPqJvofwyfJxxGQ9c94gG3Bdq71FdGxyjiSt1geGzXfni
	 jTShQe1D0GsBNXBdGoEy1c9lAnfUtmPAUMmyPttOUboVZK6Ww8D7KkHggevWQ/NVXjdXX
	 x+4PIZq69K094NdLZ9LZVst0G1dxcNQlsNFldO6E0BUAZsF1AOscs42ITW+rkMhSJdWP5
	 SNkqs1Gja4BoaEj8d3lJ7wev5uHnbswpLFEORARBE+939/9Zx6DEHV44SzctqZY5iww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184101;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vWlJIXGN2mCWIfMvySKczN8C2rDEInKxc0fQbbz0h/M=;
	b=2YVqC66V/nk/HohYZpN7KCdhPjrr/ziulMFQKUebDlVawhdB9RvZQ6nca2ptaSxPU3V3
	 T4fnYdT9Y5A4DzzXH4jA1SiCn8ETXChjwjU02sHg48CNMEh0V2Swbq9nlkdCL+lMUJsIQ
	 dBWRq/ANG1sGrHv4MaD7QpauPVwR/hcfjA/Yiwo6OFMtSgfUVvVIuLbg6x4PShIX4yBZs
	 6r+4qgd2eCK+PufjuwU4WdCNMsm6ECeTCny7IMCELwO41Leev3yT+OnbjZLXt2wzVEUBq
	 Ghj4ufvBCcXvUJIEszN/yw0z6TrjJmWQMsYiK2PmpAyg54uQ237OCcsays9L52Lk0rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Souzgep8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC49606A31A
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Souzgep8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F631F01825;
	Wed, 28 Oct 2026 10:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793184101;
	bh=vWlJIXGN2mCWIfMvySKczN8C2rDEInKxc0fQbbz0h/M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Souzgep8+lUlwXElnVSlIfDyZTYMbZDsfMRmLYu2qV2rONa7Cv5tKJFKQB+54/J3g
	 zsX0iBUHMp9LmiKqu1+pV7CwomVoQt/8dYbleUMBAPY1ufUunUNV88+w6sozhdu/em
	 gSItP9DRI+nZvGdqzzx5RWsg99bWz0QJWgBdPUqnZGqe2wRjQe02FBGkA8uZSQis3D
	 oN3GOHepkm+IrwXwX7ukAM9Clq0ENvsLPtwDK41Hq1hW2+4Jitb2SjhitE1Rj7Cppo
	 Aqrlr8Qr6HKlJHrLyKGCX9+yPKOKrnWG0yO83OeDf9MSWdZFxrOjtH1sNMq9kZ9V7R
	 2a2XMLaAjIi9w==
Message-ID: <199b6eb5-0705-4c65-a6c2-402484e204c2@kernel.org>
Date: Wed, 28 Oct 2026 11:41:38 +0100
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
 pabeni <pabeni@redhat.com>
References: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com>
 <20261027095410.3675317-1-kalpan.jani@mpiricsoftware.com>
 <ad0f8a94-09b8-46d4-b807-94f1f52f1d1d@kernel.org>
 <1a17d565bd7.51ae4f93484769.4801857719496061627@mpiricsoftware.com>
 <1ec0c2b5-a0fa-44e8-9ae8-dca9b7f90ec6@kernel.org>
 <495a89c5-40ca-4758-8366-6c4c28e28112@kernel.org>
 <1a18212dbaf.7594e0f1624805.5831653841901931656@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1a18212dbaf.7594e0f1624805.5831653841901931656@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/10/2026 11:33, Kalpan Jani wrote:> No, I haven't tried the
msk-address offset approach yet.
> 
> I sent RFC v11 with the alternative approach of hiding the sequence
> fields from users without CAP_NET_ADMIN, based on your previous
> message. I did not mean to imply that the pointer-offset approach had
> been tried and found not to work.
> 
> The two patches applied and built successfully against my local mptcp/
> net-next tree, and both passed checkpatch. However, I haven't done a
> runtime test of the access restriction or tested the pointer-offset
> approach.

Always better to have a runtime validation, especially here where you
Cc'ed netdev and the net maintainers ;)
(BTW, I think we can wait to settle on a working design before involving
them.)

> I'll look into the pointer-offset option before deciding whether
> another revision is needed. Since v11 has already been sent, I'll
> wait for your feedback before posting any further changes.

If this approach works, we could eventually consider that as a fix and
backport that.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

