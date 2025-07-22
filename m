Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F427FD59
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221587; cv=none; b=Qb9rOTAZnAZH+Y5JeztKNdX1cMHA7EH1XK/ZEg6faxsj0CXqnbg6pVCUShouWH/7gNNBUJ2Jq9vRB2NNg5Wafyz0LbTVd2l6AYzCarMVijgymdmEItojbgDgEtKSeUo0VmD1lqY0RgaDymsCRSJowRuhs46JB88DHX9q4eKmW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221587; c=relaxed/simple;
	bh=YoMww1yB9xL7737rRls4KAJNoyTQPq+obet9oG8SrFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olPYjYPzJoYCHd/oPEv8ubJBxxf+jYRimNoxzP2MZTSlAeBrfrmkDtvSXy4XVLlmg9qVMrh2cSQHoxuxQkJNNtdw1+Wu7r7OhqYVWtR+pEbxnKFwZrs8sWiw1ARTGt2zj+A90ugDQ6jqOHYGchSwmG7vMpb9AAhTTvCMx4fsLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHoTK0ST; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHoTK0ST"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313a188174fso252191a91.1
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 14:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753221585; x=1753826385; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LldVhMiyy8Uo7zeXym650NXpGCC96+eEkfNEoQyfQ7Q=;
        b=EHoTK0ST+0JqEO7QgMUF/HvxCQhVwXrDkmx0V6rKtGG8mWSyH5HunxBgJlArPgU5//
         ptBRZUI0cVXLTLg2Bees9NZszSNzZUg5EM9Fct6F4/rMzlfXJ4QGB+/wCGtiFq3niMec
         waAuKSJZ9/tWqDcnIXomHgZaKl5p25ehPSqkrsyI13crIK+DgNVgACuLpEPCtdEnb21/
         APZimNJ12prv/OyyDoQsLilvPG9sy+V3eMOpWQc8gO6JgWrw/XIRSbTs0OpGYyclBqmZ
         Nbu+sSxj8Rfcdp/NtuH694BeHSXns3swcFkvwyif6+4tfItF6K3G2YVPpO2o6gYRdQg1
         ee5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221585; x=1753826385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LldVhMiyy8Uo7zeXym650NXpGCC96+eEkfNEoQyfQ7Q=;
        b=ZNCGhGRf77OL0UY0qbHTJLWE8UCHu14rOMtck22j6+ZmUu/i84YoEo/9duFlFygqC8
         ZZ8DpQwD0Usc/I4s4aFPgY2PJAtb0d0FbH3oe+u2B8OgxsHefZ65b9KUAVWMv/MkVZzG
         QcGr6bDJtp/UdAz+aXVCjZW+JCC2xOXbsxi5GAsZJwBNPJdojq6zVLCpb02qxGzidg/N
         9zW3T/0xBFeBmNYgmkV6vRCb2kRleKjVbUlZnTU4U6jNbCZS63Ct4F8lqaARFd7IfvDJ
         dQcRwQ5jy+qfWLm81+nMYVRNyPrH3z3Ad4ntlhWZgmLfkX2hZCnc9MeNvvL5TMzXo9Wd
         lM0w==
X-Forwarded-Encrypted: i=1; AJvYcCUWjUAl8Hcz9UY5oUUXhNmqyF2whq+j6keIfUpESLt4ck4ZIqq66iOcnN3g5FJEwtdI1ZhLsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcQFh4JEsatmuNA5XHSfe5Cy0ifdd3P/Q8ltgbQAPzFfYvGthP
	w5nn0FrnTkNGkBgIEW8m5UkZWLwUMFo0UIETPWNNHBfDKUogczNQYdnkKYFleXQRo/ylurhqbRh
	0iMzvLnM8csESjSFKGD9AlugtSzWIeuYvk+QZmyuA
X-Gm-Gg: ASbGnculORrsURRev5JKU0LTT1ZZ00PMD8UupRT5+xE2r+0PP/scpgbzcHgD2FM/Zff
	uAZqfti1cASHoSSX6p5LkL/yU7MXlEqXNpRLxmr3Ec+CbmJYPsFuDM5UBcwmwWV61I37ef6JrVP
	gzV/IIDIRdp0l985McnNhTzUz9rBbOfkmWwbOKOxGUO0azYBnOKyFn4ctaBtC6yKePra68l3CMa
	VSJalFhbRErtXSsNacqpzy9XHjFoO++dwsEcw==
X-Google-Smtp-Source: AGHT+IFnCzaQCuLRDF3T0KDY0acjrNgQBMDeia5n8p9ebzIE1pRoGMSM83/YyDyRP/0W/eit+e8D1RvW/dQ4YjOCLbk=
X-Received: by 2002:a17:90b:4c4f:b0:313:d7ec:b7b7 with SMTP id
 98e67ed59e1d1-31e3e1f0b58mr7413618a91.13.1753221584666; Tue, 22 Jul 2025
 14:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
 <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
 <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
 <CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com>
 <p4fcser5zrjm4ut6lw4ejdr7gn2gejrlhy2u2btmhajiiheoax@ptacajypnvlw>
 <CAAVpQUAk4F__D7xdWpt0SEE4WEM_-6V1P7DUw9TGaV=pxZ+tgw@mail.gmail.com> <xjtbk6g2a3x26sqqrdxbm2vxgxmm3nfaryxlxwipwohsscg7qg@64ueif57zont>
In-Reply-To: <xjtbk6g2a3x26sqqrdxbm2vxgxmm3nfaryxlxwipwohsscg7qg@64ueif57zont>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 14:59:33 -0700
X-Gm-Features: Ac12FXzmS2q9uiW4v2Mh3ddunncGvq7rXqTatxuc1vnyDKWf2gVdVrW60Nf_-Q8
Message-ID: <CAAVpQUAL09OGKZmf3HkjqqkknaytQ59EXozAVqJuwOZZucLR0Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 12:56=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Jul 22, 2025 at 12:03:48PM -0700, Kuniyuki Iwashima wrote:
> > On Tue, Jul 22, 2025 at 11:48=E2=80=AFAM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Tue, Jul 22, 2025 at 11:18:40AM -0700, Kuniyuki Iwashima wrote:
> > > > >
> > > > > I expect this state of jobs with different network accounting con=
fig
> > > > > running concurrently is temporary while the migrationg from one t=
o other
> > > > > is happening. Please correct me if I am wrong.
> > > >
> > > > We need to migrate workload gradually and the system-wide config
> > > > does not work at all.  AFAIU, there are already years of effort spe=
nt
> > > > on the migration but it's not yet completed at Google.  So, I don't=
 think
> > > > the need is temporary.
> > > >
> > >
> > > From what I remembered shared borg had completely moved to memcg
> > > accounting of network memory (with sys container as an exception) yea=
rs
> > > ago. Did something change there?
> >
> > AFAICS, there are some workloads that opted out from memcg and
> > consumed too much tcp memory due to tcp_mem=3DUINT_MAX, triggering
> > OOM and disrupting other workloads.
> >
>
> What were the reasons behind opting out? We should fix those
> instead of a permanent opt-out option.
>
> > >
> > > > >
> > > > > My main concern with the memcg knob is that it is permanent and i=
t
> > > > > requires a hierarchical semantics. No need to add a permanent int=
erface
> > > > > for a temporary need and I don't see a clear hierarchical semanti=
c for
> > > > > this interface.
> > > >
> > > > I don't see merits of having hierarchical semantics for this knob.
> > > > Regardless of this knob, hierarchical semantics is guaranteed
> > > > by other knobs.  I think such semantics for this knob just complica=
tes
> > > > the code with no gain.
> > > >
> > >
> > > Cgroup interfaces are hierarchical and we want to keep it that way.
> > > Putting non-hierarchical interfaces just makes configuration and setu=
p
> > > hard to reason about.
> >
> > Actually, I tried that way in the initial draft version, but even if th=
e
> > parent's knob is 1 and child one is 0, a harmful scenario didn't come
> > to my mind.
> >
>
> It is not just about harmful scenario but more about clear semantics.
> Check memory.zswap.writeback semantics.

zswap checks all parent cgroups when evaluating the knob, but
this is not an option for the networking fast path as we cannot
check them for every skb, which will degrade the performance.

Also, we don't track which sockets were created with the knob
enabled and how many such sockets are still left under the cgroup,
there is no way to keep options consistent throughout the hierarchy
and no need to try hard to make the option pretend to be consistent
if there's no real issue.


>
> >
> > >
> > > >
> > > > >
> > > > > I am wondering if alternative approches for per-workload settings=
 are
> > > > > explore starting with BPF.
> > > > >
> > >
> > > Any response on the above? Any alternative approaches explored?
> >
> > Do you mean flagging each socket by BPF at cgroup hook ?
>
> Not sure. Will it not be very similar to your current approach? Each
> socket is associated with a memcg and the at the place where you need to
> check which accounting method to use, just check that memcg setting in
> bpf and you can cache the result in socket as well.

The socket pointer is not writable by default, thus we need to add
a bpf helper or kfunc just for flipping a single bit.  As said, this is
overkill, and per-memcg knob is much simpler.


>
> >
> > I think it's overkill and we don't need such finer granularity.
> >
> > Also it sounds way too hacky to use BPF to correct the weird
> > behaviour from day0.
>
> What weird behavior? Two accounting mechanisms. Yes I agree but memcgs
> with different accounting mechanisms concurrently is also weird.

Not that weird given the root cgroup does not allocate sk->sk_memcg
and are subject to the global tcp memory accounting.  We already have
a mixed set of memcgs.

Also, not every cgroup sets memory limits.  systemd puts some
processes to a non-root cgroup by default without setting memory.max.
In such a case we definitely want the global memory accounting to take
place.

Having to set memory.max to every non-root cgroup is less flexible
and too restricted.
