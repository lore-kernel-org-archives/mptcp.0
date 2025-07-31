Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EAB2D0C76
	for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969144; cv=none; b=VHkXBv8l4ZJsgrwKGX25mDrJ+q4hFzI8g+8Xejx2zsUGsV3kiRgg7X3V357/xsd2aNkfBr3j0/vmUXG1NIDc0m8fWVtoKleUcKzO5KZd5c33wgP8R7fSS7s5aNx0qQdGEnc0j1KET+ei3cqI0wgDV/i7fj0IkdWhjcCczEh9d5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969144; c=relaxed/simple;
	bh=kOpGIhGHdpLiDUIPN5tfSWZvVyiUegYsJVHK2hDz4Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kL3bRTsbe/3wfM9gZ1v8YBNCnekVTeoWuT3zFsuhyya2kows7+/jipJv9uPoHQLEoDxeu3N56JV5Oi8KMfV5dtBzrOKahkqT1vMsESuRdu57crD9MrzJxEfKDx2/v2knP/8eZgZX4S4dsgAsUMi+Kbv3YghqYFeHOQk8ty8SF9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CkrAz40Z; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CkrAz40Z"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45617887276so5503635e9.2
        for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753969140; x=1754573940; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnez6DValapR3ZUUqRysmzvL+YRs62blvNyrOJaANrI=;
        b=CkrAz40ZNFctsQsK9JVB2/7WqQRKBD95KHEajfljrNog9JKLj7XiSrw7IUqemyBycJ
         N7RRjC3hCclPZHO6IJkix27OW4k5pJZlaP0x7XmUa6y26r5ikvCGGh0JqMu7HmAFOgZq
         0uNfdO/ms14ipyoZ0c8Bos1sgA0mzzpekgmJl+7EClDYfFNulegwN40/g61CvzIEnxkV
         obxWe6HLSb+CQMjxFKHU+jthgrH5hVVwMigdGgMsTTyNnM83DlESZxbfUaMKkoXSv7a5
         hvO94uF/08m2fCPsuhWatxUhoviMImvgiLWl3iLxI2iHHf/zTVQvYYV0J5Cla/2cLfzI
         n+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753969140; x=1754573940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnez6DValapR3ZUUqRysmzvL+YRs62blvNyrOJaANrI=;
        b=nfpYpqfrOuRMunn4qNfpziHejV1Yqe8jqUxwuVyrDdM6voROUsgjZb6hTXHmXfl+FJ
         wRvjq2s1Lm0F/7bL+3pGm6M76CDyr8y9nztId0P3KRvpEh17WJEhTGPqr0puao2F/8c2
         wUO5wjHe6cMMd7lAx3bHPiuD73KsGJIxImfNz5Sl+7ZDTNX6RJugV5MIpuz6Nyb5pmnT
         mgZK1iXvNCh/uR6BMeKFNuZr+Dnzp9TuaXR366nBM5wFHbXQj7IWxnC6ACIiopT1uF5X
         SpiGOtXyRWb1bW4aaHkTKZJYsOO0leKmcy/ZHWI7D49uip4acTE06EHGgRuhIqjt5wSp
         vTfw==
X-Forwarded-Encrypted: i=1; AJvYcCVYjcMZTrDTGkwkVHTJjooRB2/YTsF5Ox0rg/NHV4D1QAWNIGcQsDQHfV6hE1C33tTknCt3JQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxG34aVCX2MKhMYF8MwBuHwdidopuUrlT5hqyUIm4MUsSkQvZj8
	hNqC5z0n7bcrNX8K3MzkvoIirmbNeQXaKOmt3CfvMVthz82Lg3oBz2ac/gIFCs6eQ9Q=
X-Gm-Gg: ASbGncsI0PXmqNX3BZ97YOsCVwE74ZDkbBiZZTqQeL8yM1LpC8IMAk9PzRV3tRgLPRz
	MrwEZTbwDAgSbDM5JLpXYmS9PuGJPIxOjx1DVw/J2R0hZBpjNt8BkahvVNo1Fzae8esHlQ+Yh2V
	pAMew+/JoB++BvNZ3iiSLQJN5AU9uGF8XNzdxxla93CtxoHksXIIrMPGyoG3eHSHRJabj7fal+Y
	gDq9AXwXd5MqOI4VMab3Oe1B/AMZ2pFUa86JKtmFZL3osDWHiWOIbVsMKb0wqsKYd4Fm2i1Bhg7
	MfdUCKY8C765wjAJw4Ijq1buxCmt6yZIqLLjOLuGG2T6X3FwOGfio5hX5GdwJ+WL9sJZxmn+rQM
	N8OxBsr9dXVT4k8/0Xo0GOenCUMeV7JdXwOlEFcCVBQ==
X-Google-Smtp-Source: AGHT+IFFm9zky0SxbktFrrzQ+NTv6G8i6eERwaMpUiFW2QYSxbmEiN7oSr8vkltvo3nUOZWrxX7dIw==
X-Received: by 2002:a05:600c:8114:b0:456:23aa:8c8 with SMTP id 5b1f17b1804b1-45892b9e4bcmr69774445e9.13.1753969140187;
        Thu, 31 Jul 2025 06:39:00 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4534b3sm2409107f8f.47.2025.07.31.06.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 06:38:59 -0700 (PDT)
Date: Thu, 31 Jul 2025 15:38:57 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
Message-ID: <fq3wlkkedbv6ijj7pgc7haopgafoovd7qem7myccqg2ot43kzk@dui4war55ufk>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-14-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2gxvsfqre7jriys5"
Content-Disposition: inline
In-Reply-To: <20250721203624.3807041-14-kuniyu@google.com>


--2gxvsfqre7jriys5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
MIME-Version: 1.0

On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> buffers and charge memory to per-protocol global counters pointed to by
> sk->sk_proto->memory_allocated.
>=20
> When running under a non-root cgroup, this memory is also charged to the
> memcg as sock in memory.stat.
>=20
> Even when memory usage is controlled by memcg, sockets using such protoco=
ls
> are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).

IIUC the envisioned use case is that some cgroups feed from global
resource and some from their own limit.
It means the admin knows both:
  a) how to configure individual cgroup,
  b) how to configure global limit (for the rest).
So why cannot they stick to a single model only?

> This makes it difficult to accurately estimate and configure appropriate
> global limits, especially in multi-tenant environments.
>=20
> If all workloads were guaranteed to be controlled under memcg, the issue
> could be worked around by setting tcp_mem[0~2] to UINT_MAX.
>=20
> In reality, this assumption does not always hold, and a single workload
> that opts out of memcg can consume memory up to the global limit,
> becoming a noisy neighbour.

That doesn't like a good idea to remove limits from possibly noisy
units.

> Let's decouple memcg from the global per-protocol memory accounting.
>=20
> This simplifies memcg configuration while keeping the global limits
> within a reasonable range.

I think this is a configuration issue only, i.e. instead of preserving
the global limit because of _some_ memcgs, the configuration management
could have a default memcg limit that is substituted to those memcgs so
that there's no risk of runaways even in absence of global limit.

Regards,
Michal

--2gxvsfqre7jriys5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaItx7wAKCRB+PQLnlNv4
COjkAP0UcZBWkhc+vB0FfA1p+pH/BzzZDKA27tR3sA4T4P3PBQEAyknqdHl6GIJ5
yIxBX8DBx92ijoCOGSF1vaocgD203AQ=
=iTKX
-----END PGP SIGNATURE-----

--2gxvsfqre7jriys5--
