Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27403156CA
	for <mptcp@lists.linux.dev>; Tue, 29 Jul 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818075; cv=none; b=A2e0aQLjyHVMaZaOh+cQACYe31jO4pXxv48VLOerSN8ldyK6Q7x5eZmV1dhPNBUY2Ir1KsVQyWj8Ptj8KHJYgFwZWEDL+V4PTlOLkzdUykTA3iuFWJ3DHPS/lhs3LUvJ/F6FKZyO66WVV/YrvnqdfqOvF4/I7/N0mNChdIJGypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818075; c=relaxed/simple;
	bh=8ILIxFhPqV6sWJ6sNqcz7HYLvW2rtv0z1EwnknIclp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6dt8Dui1V+DVEA3dx/nyTkTcN6lQKIDmE0sKekyqUXXrYW5aERhwxa0asZTlPaTrIH49wEea1qKwip2lqVcrAmCdmXVY/6Oa6ie9NUkHxfT+c2knf6cp6Z4Lv/KKZvwbCI6CP9li6h1QbHFosvir22wn80bIVr2PNJUA6biWtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IDxaUG0/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDxaUG0/"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso5712492a91.3
        for <mptcp@lists.linux.dev>; Tue, 29 Jul 2025 12:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753818073; x=1754422873; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m37FqMDYXmj2Dv7ygO9Vcvff4CeQGMY//ilXkgwqiPk=;
        b=IDxaUG0/xXNYDlF2AVcCkvg7DChir09CbAAm9+gejNslytqtGjDdU8lNBK38ETaYdV
         kXgOhTD+DHQdTkHELumlwJSuQlvJaTmiwFq3msBePslQNjWyUNievddlLWDssPMio+y3
         lRAq6ge5yMUsO1ttDHOvMrMOxZOdxoeM/LU5evwfCsF11abHUQD6E6kYzqV+z5BXwkIs
         Z5n5S4vljaadus4FwwVzycnoP9RzKOlkK/oUxWnRnhdquvlBFLcgqSw6muO2koqEjRdr
         zBLB8h0bS/prHNbUouFVFXx1SaNk3EvrBeXIAQfDsANQSxvBL97Zp4OwE42PY+iHq6CT
         +OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753818073; x=1754422873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m37FqMDYXmj2Dv7ygO9Vcvff4CeQGMY//ilXkgwqiPk=;
        b=TsUUZqIO9ufHn1qf7VpYIWwZnyfQrIBU1Jh2PyMSfwcdFIOpbxBwWBDRC1+HwV2KQ/
         tCg3uAn2YhYiPBPEpz925/Pl6mXisNm7iKMn4OpgGS5UQANxBqkCKg41P81+US4apwJY
         J25r2K09NZGlOJYyPu3K68Nwb8b8v12UpNT7LOcTbekdqnEYv6V4JpBtzxpv1DlRsKG9
         K+/kWKy7Rqup9IJTYZ/MMMOHw2P43nKMV18b1JFuH+1kcpo8ghvz1FimtfZ5ePgLGV+1
         V1yAhIIsJpcQv+FU0GhfKc0kachVlKYd1EK/UJsgsbojR9dw7ID0WvmzBOm94NqJ9oE7
         bN8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOmj8YMJdeKpFtO38Hq2/9/Guh8rIL0R3ziMEZ+mUCLqbFnUgIANumZ+Sq/tejq0p+qQ87Iw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDfRKqBPd21s6O9ucFALmrRVAmVxfydXMJ+G4pWZMJcAebuhvs
	eW+WAC8tQAbFLkAZlxepIUkMKtCbSNtqNZutgnwt9KXbSNBORgPlN+AGSips0Uc4Dhfj7JiHuPR
	WHv6ZKrGLLdLBlfC7iDe7Fs7nStBFr5+WB5nsjk6K
X-Gm-Gg: ASbGncvhOl/1ICOQNlTtBXn4B3h5QRx4ab3KOOZpSitFIl6aeMbdo3UjPQ54fpG6kNX
	yQWLLi+6/MaE816repDSUX0/j1sOZtJe1R0xYf7PEXJAUQXrg5b/gwTpI3YxlUNX0Yx7wLBi5E/
	Wwe+SYJ7j5TrqtqmKdCdCvMITZ6LOCbMDM1OekqWfMbZTZ/xNEd5X25qZwa8d9Uj3cuD/C6mXl+
	AIravnrmGFzEkZjYdftJvOCbbxaa2GgHF4+1Q==
X-Google-Smtp-Source: AGHT+IFHi+K2rngfQJNaDXh6Q/65dPesMfdw/U4rG+5b3JOuqTwCXpXEA1k+tUMK8fVxHUmx8u+LcYENLMSlBCx6eI4=
X-Received: by 2002:a17:90b:3c8c:b0:313:db0b:75db with SMTP id
 98e67ed59e1d1-31f5de7ba65mr947421a91.33.1753818073104; Tue, 29 Jul 2025
 12:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <20250728160737.GE54289@cmpxchg.org> <CAAVpQUBYsRGkYsvf2JMTD+0t8OH41oZxmw46WTfPhEprTaS+Pw@mail.gmail.com>
 <20250729142246.GF54289@cmpxchg.org>
In-Reply-To: <20250729142246.GF54289@cmpxchg.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 29 Jul 2025 12:41:01 -0700
X-Gm-Features: Ac12FXzISgl-tZJ7iKnC87dk4hDowx1goc7Bk3yppQBdjG6RkAfnE8zuKgCifMo
Message-ID: <CAAVpQUDRccLyZyaz1iKABHNaw5rHfTBHtrOypmHheOJSaVORLQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 7:22=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Jul 28, 2025 at 02:41:38PM -0700, Kuniyuki Iwashima wrote:
> > On Mon, Jul 28, 2025 at 9:07=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima wrote:
> > > > Some protocols (e.g., TCP, UDP) implement memory accounting for soc=
ket
> > > > buffers and charge memory to per-protocol global counters pointed t=
o by
> > > > sk->sk_proto->memory_allocated.
> > > >
> > > > When running under a non-root cgroup, this memory is also charged t=
o the
> > > > memcg as sock in memory.stat.
> > > >
> > > > Even when memory usage is controlled by memcg, sockets using such p=
rotocols
> > > > are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_me=
m).
> > > >
> > > > This makes it difficult to accurately estimate and configure approp=
riate
> > > > global limits, especially in multi-tenant environments.
> > > >
> > > > If all workloads were guaranteed to be controlled under memcg, the =
issue
> > > > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> > > >
> > > > In reality, this assumption does not always hold, and a single work=
load
> > > > that opts out of memcg can consume memory up to the global limit,
> > > > becoming a noisy neighbour.
> > >
> > > Yes, an uncontrolled cgroup can consume all of a shared resource and
> > > thereby become a noisy neighbor. Why is network memory special?
> > >
> > > I assume you have some other mechanisms for curbing things like
> > > filesystem caches, anon memory, swap etc. of such otherwise
> > > uncontrolled groups, and this just happens to be your missing piece.
> >
> > I think that's the tcp_mem[] knob, limiting tcp mem globally for
> > the "uncontrolled" cgroup.  But we can't use it because the
> > "controlled" cgroup is also limited by this knob.
>
> No, I was really asking what you do about other types of memory
> consumed by such uncontrolled cgroups.
>
> You can't have uncontrolled groups and complain about their resource
> consumption.

Only 10% of physical memory is allowed to be used globally for TCP.
How is it supposed to work if we don't enforce limits on uncontrolled
cgroups ?
