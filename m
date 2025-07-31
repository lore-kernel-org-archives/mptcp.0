Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652062C3273
	for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969153; cv=none; b=uURiVvITpBlDiK/yE53WTiP8xDbomPHFk35FE16bovJ4hCU3nG2nZbTSxsAxBMREqC1/e0dnx+a82fM14mzzFSb/XMYHWHQm2bYVqpmT6cFbjcd2H1EQYh4bNXcXRJGFfmSDsc7rszDuRYyXTHlOiBmVodHHUuoGqVkaqlrF0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969153; c=relaxed/simple;
	bh=b0p3P4TSj0m67jYyynFdzfNgF0dMZsVUy/M9Sl8OXsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN5vHHD9ragZZ/RNVAOpJPuSPuUqsjjprq0BH5QoFTXGAZupJOOA7AVxZDOIGm1OxddNXAWqmCPcWIMSms5934EfRhW2R/a4e+PzEseRUH5itmH5vVpjWdKoQh0jqsF6k61CopwXARl7JUMrLDK7IVT12eKlzUrFlliRFSaM6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vipnpdei; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vipnpdei"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b78bca0890so679670f8f.3
        for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753969150; x=1754573950; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTMiwDI5I7ZpdDu7u29+O3OSLlyCf5CWJBCKHAd19vQ=;
        b=Vipnpdei9dm+WGS9UMixQWUQmRBTeVK8ZZQAmB8WSpq0eu4Zyww7LbqBikzigw33XV
         x/whGO7FHhuRf1fPqfZV/t+FNXIMRqA6BBetmXivsq38s+lRFYsyzGI8Ul2m32Qsgg9O
         pFc06sYG4YhXKXjchYGXda4+ftU1L+KKG4lgiZ+Rt2doDHDlIJ9Kk99yR55sRYr6yQz7
         ubvXC196VmxpGg+zS6mg/VnNDdsiDnSUBSfpqQJF1GkPG3l/WKWsrEKffNqtEghfKd9J
         lIfwuEkA6xdtc1xGCQN2pYKZ/roYe+QhX7uuq548CpfB5eQLV+Hol1P2QO/yZCUE42wQ
         jkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753969150; x=1754573950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTMiwDI5I7ZpdDu7u29+O3OSLlyCf5CWJBCKHAd19vQ=;
        b=hA/C5e3CECkxJuduZoJOEUkEXz2x47K67j5OsxeXm47akuFfeNTo+A2vm989AT+svb
         XXHHBna0hcep0+oo1CBGxeCo7rd+M6Hh2Nl+hZBJSSfIred6pMxHLJVLKm/x/JtTZ0sP
         xxMYmyjqfGLALEI7gc75cItTG4Wxk+JfOvJ2VhOMIoRGHH06fXG6iVbfrNYYGMojzmpq
         pmZGdLHX7CNOqozSYNlX3Qg5hCxM9XG8Yna5JaHogb3rjvkY4wKmO9zNuxIWezO+/lbH
         9aorOYbVM+bXaw1NYEpZJJi6k0L9yIKCEhjHIK1J4NOZNPC/jJoWok8Q9HTPSx2LGLMD
         o+0g==
X-Forwarded-Encrypted: i=1; AJvYcCU5pUab2GevynFSpZ9oEWYZcRGPEBI+QrMPuAawQOxWx8dRnCiod+lwvuWmuMTvvUrZqJiVJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBC32VudCC2czr/1jIu4lfRoa9uwCK6AigmeqHrD5E+1aPb4RV
	26LRn1fITXE1epZWNgNdFTqMiAchrrgVtzYHG9+GjDLWtcepXXtP0hUswhG+RZ9WbDQ=
X-Gm-Gg: ASbGncv+C6V8AxqXTp0tLFa713muEksLOCioZGojOPmuhKSUjPjlCHIs6nxKTJ8PIXf
	0cUt3IotbWHBpGCFiSyeuVJhAKr6G7VunnBr/EooB+rtwCNteSucBpJ+hP8R/Kj1volUkGxM0tb
	/KhyeYljfwn5HfsQ4FEpRWWrIEj3YFERwYMZM20jDHtNTClln1jy0dxRciYNGdbNz9BPA0eAAK3
	HA61s9UzAPRUcj7c66H/ET3WBU7NaLp1KuwgkfhqXI28Hqw5YCBVs8eqsZlH32+u3xFzwXXyhQc
	8c21eu8mT4TRDGaCb6Fbg0XFsnb+y3xwNUV8pcd0wsQmkZnXY2jXEE7wPAB3vnW/eKHnVzt64/W
	f8eURjStWwXsl9drz1qICiyO9aVG63OCBorN5esn5svoIlsXzvXVs
X-Google-Smtp-Source: AGHT+IHYvsEIX5itHKow1mLcVDqvWDuNXSbVTG7QQc1tvuwHoyl4F7TOUm51Nd1pmo+PXsqydNAs+w==
X-Received: by 2002:a05:6000:40c9:b0:3b7:7c3b:1073 with SMTP id ffacd0b85a97d-3b794fffcd7mr6922320f8f.52.1753969149579;
        Thu, 31 Jul 2025 06:39:09 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4532c4sm2448753f8f.36.2025.07.31.06.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 06:39:08 -0700 (PDT)
Date: Thu, 31 Jul 2025 15:39:06 +0200
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
Subject: Re: [PATCH v1 net-next 11/13] net-memcg: Add memory.socket_isolated
 knob.
Message-ID: <pvygtpy4b7napeudlk5dtbacgvqf6j4lrr5nhye6obrwv2ss2o@ubxpyqwf56pz>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-12-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wvv7vwafoorhn7v5"
Content-Disposition: inline
In-Reply-To: <20250721203624.3807041-12-kuniyu@google.com>


--wvv7vwafoorhn7v5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 net-next 11/13] net-memcg: Add memory.socket_isolated
 knob.
MIME-Version: 1.0

Hello  Kuniyuki.

On Mon, Jul 21, 2025 at 08:35:30PM +0000, Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1878,6 +1878,22 @@ The following nested keys are defined.
>  	Shows pressure stall information for memory. See
>  	:ref:`Documentation/accounting/psi.rst <psi>` for details.
> =20
> +  memory.socket_isolated
> +	A read-write single value file which exists on non-root cgroups.
> +	The default value is "0".

Such attributes don't fit well into hierarchy.
What are expectations in non-root non-leaf cgroups?

Also the global limit is not so much different from a memcg limit
configured on ancestors. This provision thus looks like handling only
one particular case.

> +
> +	Some networking protocols (e.g., TCP, UDP) implement their own memory
> +	accounting for socket buffers.
> +
> +	This memory is also charged to a non-root cgroup as sock in memory.stat.
> +
> +	Since per-protocol limits such as /proc/sys/net/ipv4/tcp_mem and
> +	/proc/sys/net/ipv4/udp_mem are global, memory allocation for socket
> +	buffers may fail even when the cgroup has available memory.
> +
> +	Sockets created with socket_isolated set to 1 are no longer subject
> +	to these global protocol limits.

What happens when it's changed during lifetime of cgroup?

Thanks,
Michal

--wvv7vwafoorhn7v5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaItx+AAKCRB+PQLnlNv4
CKBoAQCcPd3B8EVlIuJkCxAatf+KBj5iSIWjGLHkL/wZBSIiOAD/Td1vVJkjNLj+
ooVS07G9ZINI6535eRR8nUFbbc4lGwI=
=8P5/
-----END PGP SIGNATURE-----

--wvv7vwafoorhn7v5--
