Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBCB219ED
	for <mptcp@lists.linux.dev>; Fri,  1 Aug 2025 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754031634; cv=none; b=F8JNYSHxYP/tV/UdKO1XhraGs2SicAwxzJem+LinFwYOEUSgIFy22s/d+4147lHPry+yyiTZLIygiBr4sdJMKBZWumSKmwgix67uyqZoeUv/SfV+ojzgaOfSOCteHQoXCrH1v4mzSyOiOmKjZx4ONX/5MBQRelemv+EGIe5bIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754031634; c=relaxed/simple;
	bh=lOdACm39398ZkN2lU2UZXEP/gEQUsiO20iyEfrmnlog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl8BOPOIL7t6cvgx4FHs4Rv6kqi9Btc2IYWsMlI3VbT4AtN38nux2CDLMOl6kTm53SGk6E1WzT+G2kXjgx75oMdCy0YU0P83JfVFlRECCVF/1vqFQW4/WhC/YfIf+6pS+fiK/6FfvAUBobkAlvOHHmB2fE/MluXQbUmazKHHlm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YSe/YAFY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YSe/YAFY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso9375235e9.2
        for <mptcp@lists.linux.dev>; Fri, 01 Aug 2025 00:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754031631; x=1754636431; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lOdACm39398ZkN2lU2UZXEP/gEQUsiO20iyEfrmnlog=;
        b=YSe/YAFY66qQeUIv+rSB6HE+MZsCdgzu/SaCdH7pLBdPuTPJl5TaDFFbHJzZDqGTBm
         D8111kkjVKPhzkYqbU9j/KmBinBMop6v1PC674LUB1ffQO2tU8jJKJf9xKKzQ+vVQWOA
         HgxmfIotV9ES7hamTC8Uwe9jBdZpGAGpO1EyKamRTZrw4ufLWRf6rJ0m/QcOUJm0rmuy
         +KcCTnAhpiT3iB7O0pWGh+jVq218al9uvaS/KIvZU5fh/5sTOhOOXOPTrT4fmiTyK7VO
         1yK9F6q5JcguuWvtlog7PnsJsC7QuZXlY9fT8D2o0vieyMSUnohE/Oq8Z66QNvzdk5xy
         X9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754031631; x=1754636431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOdACm39398ZkN2lU2UZXEP/gEQUsiO20iyEfrmnlog=;
        b=vlnqG55eaToas8E8J1/O7VFvOnPpupnvLtEjpQw/9Y3fm+msz/AhZUJ3n+ONcjm/Uh
         6B55Ban73mdAtNah5mWZpR1K36mNw5E+D8Bz+MfK4Glnt2wQwG/6L4IHsM3+eApXy23p
         veYVEq4IGLODQYrJEQ08EObILz+n3QR7U4xfmHyQce8NmxTHDKqq4fX5eCPy2IqgnUH+
         a1e+5t0Yo/XZBpVJ0gQ/oR2cnbPTNfWjlSIgcF/Gi+H0lDqQSxq0IkQonGOndUvr9wKW
         CgFrl/QW+F8xRlJSZtUx0QXUWdqV82gLGWQQh6jfOce5yLxjXuwEikT3Efcr8TGz+fh0
         hhBw==
X-Forwarded-Encrypted: i=1; AJvYcCXUWgD+aB9zkVZ9zrRDjq5uKpmygLnAzXVWHtApI7Wo/yQMo/zA59CNAF2ZzDOrikt0RX8nSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNJxUCx/YOuFZdma61bWlpi35jrt/K0rkfnZ/5EwFc8H+Z/+pY
	iiLBBXn+AxogRYIXCZtB5VzzAX4hi0XkSBIEXB7G3zARrWbUhFV0MRVYjl8H34lFp1k=
X-Gm-Gg: ASbGncsQ7Cf4A7zoz2HqIMvV0v7JvvUv2b3pGd3rIWTMCj8rqKo/cMTRi1mT+b2xlot
	5TN7Ifi5PjiIu61Pu82yLTYkvv3KaJjlNOIZLuMiUv9EMaVQI7AljQuy45nTaFG/gQzEqiJ+XMP
	i8cTCVsUKmk51Coz+pSDs3VDkz7TztdWxFLWrU2BzveiRWsQtv6bqvn0/aCLUsTCZjn4V0SWkB8
	AyRS4BXc4KGuB66+GxN77tkwIf4VrEap5hBHcuGPZCZNsqoiMJWBPIzkcbcVe5Ws0qbeWcC1hJB
	j3eXVCaIx8C7FzPUImLOfVthXTJarfyT1XbLtwbiQpYXBoLifn0rav9RrUMg/EUTMmh9q3Imu1F
	hILE+fR2OeMqDHwNk2oKAQsd7vpxyIkt1bQ47QfDMzg==
X-Google-Smtp-Source: AGHT+IGpo7vCBRl1+3LNZgziFjvZCIsV7Fz+AW0zycTpGAfpOewwiyDA2ffkkvBUhcmMNKx/L1CjEA==
X-Received: by 2002:a05:6000:4212:b0:3b5:dc07:50a4 with SMTP id ffacd0b85a97d-3b794fbeb87mr9254839f8f.2.1754031630614;
        Fri, 01 Aug 2025 00:00:30 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47ae8esm4762632f8f.61.2025.08.01.00.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 00:00:29 -0700 (PDT)
Date: Fri, 1 Aug 2025 09:00:27 +0200
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
Message-ID: <ekte46qtwawpvdijdmoqhl2pcwtfhxgl6ubxjkgkiitrtfnvpu@5n7kwkj4fs2t>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-14-kuniyu@google.com>
 <fq3wlkkedbv6ijj7pgc7haopgafoovd7qem7myccqg2ot43kzk@dui4war55ufk>
 <CAAVpQUAFAsmPPF0gRMqDNWJmktegk6w=s1TPS9hGJpHQzXT-sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x3o5euvcxbwgpnyi"
Content-Disposition: inline
In-Reply-To: <CAAVpQUAFAsmPPF0gRMqDNWJmktegk6w=s1TPS9hGJpHQzXT-sg@mail.gmail.com>


--x3o5euvcxbwgpnyi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
MIME-Version: 1.0

On Thu, Jul 31, 2025 at 04:51:43PM -0700, Kuniyuki Iwashima <kuniyu@google.com> wrote:
> Doesn't that end up implementing another tcp_mem[] which now
> enforce limits on uncontrolled cgroups (memory.max == max) ?
> Or it will simply end up with the system-wide OOM killer ?

I meant to rely on use the exisiting mem_cgroup_charge_skmem(), i.e.
there'd be always memory.max < max (ensured by the configuring agent).
But you're right the OOM _may_ be global if the limit is too loose.

Actually, as I think about it, another configuration option would be to
reorganize the memcg tree and put all non-isolated memcgs under one
ancestor and set its memory.max limit (so that it's shared among them
like the global limit).

HTH,
Michal

--x3o5euvcxbwgpnyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaIxl9AAKCRB+PQLnlNv4
CJZtAQDyxJKYOwR+G5PupdcFpWcem+e2vcVjekmcUSnAefb9SwEAmlcDbWaK+JWZ
zsvVOKp5n3NQmuq9ouqRPxwf+gbdlAs=
=J+oe
-----END PGP SIGNATURE-----

--x3o5euvcxbwgpnyi--
