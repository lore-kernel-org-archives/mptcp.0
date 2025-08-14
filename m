Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB22DA758
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174628; cv=none; b=F5OwQOGxxlQ7aP3msviEoo8bt9AuNXtS8+idGzZ9PRyUWQeaZd1XLLH7zM8xs9fEBCd8iCCzYHxWlw5Y/9bPJaUxcR4JYyh6FZX3zZ0B5TYgfyuctS9AoLXih+t6GyPS28Zt00WsLg/CCwEG6sUZRUesIKMGEHc/p7xZLs5CnSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174628; c=relaxed/simple;
	bh=1PE9vqqyAAJHt2b4anvd33upg87s7/sb4TrxyKMVNKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sK2e8xOfQZKWoIML5zCCPZ2XLyEMi2e5FztzSPQN5ZbhRC0x7RjeB7A1QQDmpR12ats1RBeVpLarAtr9VqeYTk3vyFJ2/HLGL6AlSsle61Ou82iGlKWayLhUWLDqqIKariDazZ3NNTxTti6TOTc18YQnpgHCXfnKT3HQQ2Hcp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V00ZauvQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V00ZauvQ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9dc56ff66so435592f8f.1
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 05:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755174625; x=1755779425; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ1w1vX016HZnhf51EVaJqwNMCPhdOvsodT4l6hbFIE=;
        b=V00ZauvQYbLvwEjVX7WIh6E//5KywuOSoJia7b5smDUejiL7bqPbQWx0GwKYvt8NXv
         rSyZe7C6VImyakYQ7i+6FmaYvOz6nFS49+E1UqsOY5yTDwB+iT6izy5aSz0rt3+cX8fq
         xuvgXNInVt9ZLt4vVjgja8bGMQFLi5GW9nbIw1vi300F3Z8maZQejCsMiqepMx7apdtN
         r6o7lybt9lIFjOIGLbJerjrVoOno9SKEqe72ez0XoPuV5E7A/Nm3UU2dJ4E8JqJcssd9
         nF5lr5+TCVrBXOx4MPzzgh3CLLgrPaS8n34+CKV2QhC1AFgQHFVE4Ug9W7KehPZNAIg6
         Rh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755174625; x=1755779425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJ1w1vX016HZnhf51EVaJqwNMCPhdOvsodT4l6hbFIE=;
        b=xDijYS8Toz1G8WzB/Fm40kr/4pNegv2HHWvx/sNzfBbaXKYiHBCR2/0/hlWDXg8MCv
         sZdImVLAyA4sWcW5zmUGKOG06EaCUBWo2Mj0gJtet8LHJoC7AlX/euK86byDmQ7D/UK1
         j3z68FDF0zmbjaH9Bu9OPfxlOdt1fuI+B/p4EWcseyRf9lIMNL1/rJHBixp/2klmSKp1
         mQ/KNE2TWAClWAuaNJ8BFwanJ1SCQKA2gmeXZtRzMjx9QAvWrIZU6uHj1pgO74u7gdt/
         K3vRZUn0v6h0zGBa9wCVMm2pyTKRU+o2RQHCmjEU1Va9u+AjDgFn7QCqwXPcFyMARNOJ
         FIKw==
X-Forwarded-Encrypted: i=1; AJvYcCUFspiSz9yePejgC158jYrZvyYmVPvxfD8wWGPcXVHSbJEU52mQJUQ73L8tWK2btDtnkMSMbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YykNPaPvY6Ef/LvkPrwBfv1b0znfcNaEgAHqei4WQpJhk24wF5I
	3YfxeuOWEm36W1rLnaWDEndn3xk/1sa6LbKYr4cEbDvyH162kGxL1e/98cR07/B0EGU=
X-Gm-Gg: ASbGncvHo+MC2jPjHF+gOHC4m4AD8Ctf1CHYaMl8+KU8HGikSYb4uMKHHkpBfqch3RL
	3A7dgA1IGck2H1jzrrtGLOCidC5XncyRVxORzUIK5pqqU8USK6uvVioy3M5ziX6okN7fiyR6jPE
	3CWEN9bVAML72pP5r9+/5/z4uXvaXie2ec7Y66JKn6v5/zr3bqp9/WakYlTAGoXlwtEnfew2uqS
	c6Tonrw1Or65cYQSVwL6vjgjjZuul8wbJN/Ext4QAauKkCgcnDl+aHdBKl1IYR/k8o0K8ZnJpSc
	8H2oeH+NxZ+PLj67FozGkz/MuiBRCe6nHA/MbordfoOLYcruW8umtbawSOD9tIPSCYOruT/xKH8
	Xu0lCaEVkVfSszkb7GllFBIj99He2JbrEwpqG2suA2w==
X-Google-Smtp-Source: AGHT+IEcamlanLgHj4e3UiHXnuoZFx6EM5i/6/BHJ22GOTsUGejY8ezIfKRRmd/gWCi23iogf+4+lg==
X-Received: by 2002:a05:6000:3111:b0:3b7:974d:5359 with SMTP id ffacd0b85a97d-3b9fc359a99mr2276811f8f.32.1755174624685;
        Thu, 14 Aug 2025 05:30:24 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0fb4asm348329055ad.60.2025.08.14.05.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 05:30:23 -0700 (PDT)
Date: Thu, 14 Aug 2025 14:30:05 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 net-next 01/12] mptcp: Fix up subflow's memcg when
 CONFIG_SOCK_CGROUP_DATA=n.
Message-ID: <ukfrq6ybrbb2yds5duyj2ms6i7xgssjsywzgknxctfgkpzupor@tjxbuiil5ptt>
References: <20250812175848.512446-1-kuniyu@google.com>
 <20250812175848.512446-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xhbunld2ijovocqb"
Content-Disposition: inline
In-Reply-To: <20250812175848.512446-2-kuniyu@google.com>


--xhbunld2ijovocqb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 net-next 01/12] mptcp: Fix up subflow's memcg when
 CONFIG_SOCK_CGROUP_DATA=n.
MIME-Version: 1.0

Hello.

On Tue, Aug 12, 2025 at 05:58:19PM +0000, Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
> sk->sk_memcg based on the current task.
>=20
> MPTCP subflow socket creation is triggered from userspace or
> an in-kernel worker.

I somewhat remembered
d752a4986532c ("net: memcg: late association of sock to memcg")

but IIUC this MPTCP codepath, the socket would never be visible to
userspace nor manipulated from a proper process context, so there is no
option to defer the association in similar fashion, correct?

Then, I wonder whether this isn't a scenario for
	o =3D set_active_memcg(sk->sk_memcg);
	newsk =3D  sk_alloc();
	...
	set_active_memcg(o);

i.e. utilize the existing remote charging infra instead of introducing
specific mem_cgroup_sk_inherit() helper.

Regards,
Michal

--xhbunld2ijovocqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJ3WwQAKCRB+PQLnlNv4
CAoVAQCrDITNqluusq0b12YFFhfY1gKK4Q8uAHs/KsISm9RelwD+JxaqxOrcmstY
zyqaWiykc0r7xJAjUUU3so6cKm+/lQg=
=6bNw
-----END PGP SIGNATURE-----

--xhbunld2ijovocqb--
