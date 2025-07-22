Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA8817E4
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211042; cv=none; b=TN6S1yuYVj0EDo8Vh7xhhHXmmGLYiuEZYsxn5BLMCkCcEpNtdRFYc6RcxSbVFAq3ZmS4ItAEnffd4nolN7WNF2bVBls1rGhEDlZWeBCpxJVzXBDOZZd7rkVff5hTRw+dJ9XlUCwKwefxqwwvhzfxp6tF/DvOlda5Wmt01mnWS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211042; c=relaxed/simple;
	bh=DXIhcMM2WS826QQBNmEnnmJpIAj0rucxfdLc90w06iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0l/ZEchQip4/8cNn2JV1tU02eN45X/iOJOH96NSQOHB3VOCuRullqQ3jcNL1eiGJRioL4IeyGlF9y89fcBCEBKpypUewopVVYlsYHxf5uNXVWE/FbibSwu3YOuHcTUGbziNcxqKgZNB89tWosH6kWY0ja949Imi6hhpIb18Dko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j563uICG; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j563uICG"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so4610501a12.0
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 12:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753211040; x=1753815840; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiA8Ffhznoaz71o6X2Lhv1DU3VKSS1u8j+C6Sx2f3R4=;
        b=j563uICG4zT6q2dSeGAh2ABFQy0d7/OmyaN35QT8FPIxSKkaKLrJHjxIzvm7BdjhRH
         Cn08xVg25/F8qACarsqZp5ByBX1Om0RV2RSa284Y9nuSq6AosS74jhv+88qCJof0wOay
         EPFtm+MOzJWNF2x3PlzHqOFJAWIOc8YbGWgjhBNx/IK7HDwWO6P/5hQx1UL3CQ2/y7Fz
         pcDwjVlRoCghiaLr3MXzgo5WolRI05AFdna2Uo5W6LRqWqj4hIunObT7PxTEJJcSiG4E
         kf9GyGPoQIWDoejbpMy8mTDXHEEkxiehWrwgGYdPiFXqAK+FUypSU1he5pE+coYSXnf5
         8C0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753211040; x=1753815840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiA8Ffhznoaz71o6X2Lhv1DU3VKSS1u8j+C6Sx2f3R4=;
        b=mIrg8u6Y1+tOD8CYMz0eYKPVjsvuZ1CqLSUFMsY4/KLIXWwDELoOlXc8nk3hEm72BW
         cF44NGMH9ej6Q16v3I6xpUuDiv21ZxGx0Fbi26gGPX+LVsYBthrBP9Xsy7Rm6FHt8i2c
         HTNYUtXcm7yCLzJnkR5uqcbI76SJvIOyTukRMG5MWnXf1y+joVHwdMB8yIprnxV4nVta
         /wUfuQKrk5YNpk8k7SjAbgXOlky6/ubh5lGXTE+5ZHSR1qnOR/tgcl1zuSwc1eB2F5AS
         S8OFowbq5N8AQrtS46FiowhRFIAfcu0HcLtJ7oO8TIO2S1LApX7j5xtY3Yi/aQNH4OVb
         dkUg==
X-Forwarded-Encrypted: i=1; AJvYcCWFhXiNz2BNJ86juhqooi06hmTfIAuUCU2NI1mZLBVA6nR4db+JRQl/hFbamSrRTvVRYn37xw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjxolfkKIGwH0HtxoFvXOqVvHB4rzvU3RPwXSiOAbEY7W3TVrB
	KdPNG4CEapI2UgRGQc7NGHSEHfopoK8lqkBGEC4LPTV9WRHHfBljEEONs3vYQb/7GukAOQ0FCBl
	oko27rIqCnuo+coC32d2Xk4WDGsUXSuMbxzbggj1Y
X-Gm-Gg: ASbGncuZKPFx3//XKr09Najb/s7h2V6Om3wuVBz7UwX0EVFfzXnO6FsDWpqhhOjMhhr
	Llj4lHURth0/yIvscfmS8YexQh0r52Yv6i+uXChPG5AHJ58zsRUH7Uw/1TU8XdRbxQ2+uIJGfw/
	lzayPqzAMUSO6pc0ezGnnuSjylq19fsstXqMdQ4rgfgf+LamLWkcq2gvVrJadPJ2bZ3nS+miPQ6
	SrqpLSEdwnEu8Eh5hWFvoVEW5aye/lHRN8LEQ==
X-Google-Smtp-Source: AGHT+IGYBGaRF4+4yiskF7ML1G3zkbt1R2dprHwARsZQ44k60mvIUIP4kGdlv2eHeVBIwzBUJ7cUV3igAXlin7CBAhg=
X-Received: by 2002:a17:90b:35d1:b0:313:176b:7384 with SMTP id
 98e67ed59e1d1-31e5076981fmr533620a91.11.1753211040076; Tue, 22 Jul 2025
 12:04:00 -0700 (PDT)
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
 <CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com> <p4fcser5zrjm4ut6lw4ejdr7gn2gejrlhy2u2btmhajiiheoax@ptacajypnvlw>
In-Reply-To: <p4fcser5zrjm4ut6lw4ejdr7gn2gejrlhy2u2btmhajiiheoax@ptacajypnvlw>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 12:03:48 -0700
X-Gm-Features: Ac12FXzbgoBRyeJ7XxGUPxk-8v86WqDVVO-Vj_Jc8u00Jp12117hni6mqwz8B-U
Message-ID: <CAAVpQUAk4F__D7xdWpt0SEE4WEM_-6V1P7DUw9TGaV=pxZ+tgw@mail.gmail.com>
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

On Tue, Jul 22, 2025 at 11:48=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Jul 22, 2025 at 11:18:40AM -0700, Kuniyuki Iwashima wrote:
> > >
> > > I expect this state of jobs with different network accounting config
> > > running concurrently is temporary while the migrationg from one to ot=
her
> > > is happening. Please correct me if I am wrong.
> >
> > We need to migrate workload gradually and the system-wide config
> > does not work at all.  AFAIU, there are already years of effort spent
> > on the migration but it's not yet completed at Google.  So, I don't thi=
nk
> > the need is temporary.
> >
>
> From what I remembered shared borg had completely moved to memcg
> accounting of network memory (with sys container as an exception) years
> ago. Did something change there?

AFAICS, there are some workloads that opted out from memcg and
consumed too much tcp memory due to tcp_mem=3DUINT_MAX, triggering
OOM and disrupting other workloads.

>
> > >
> > > My main concern with the memcg knob is that it is permanent and it
> > > requires a hierarchical semantics. No need to add a permanent interfa=
ce
> > > for a temporary need and I don't see a clear hierarchical semantic fo=
r
> > > this interface.
> >
> > I don't see merits of having hierarchical semantics for this knob.
> > Regardless of this knob, hierarchical semantics is guaranteed
> > by other knobs.  I think such semantics for this knob just complicates
> > the code with no gain.
> >
>
> Cgroup interfaces are hierarchical and we want to keep it that way.
> Putting non-hierarchical interfaces just makes configuration and setup
> hard to reason about.

Actually, I tried that way in the initial draft version, but even if the
parent's knob is 1 and child one is 0, a harmful scenario didn't come
to my mind.


>
> >
> > >
> > > I am wondering if alternative approches for per-workload settings are
> > > explore starting with BPF.
> > >
>
> Any response on the above? Any alternative approaches explored?

Do you mean flagging each socket by BPF at cgroup hook ?

I think it's overkill and we don't need such finer granularity.

Also it sounds way too hacky to use BPF to correct the weird
behaviour from day0.  We should have more generic way to
control that.  I know this functionality is helpful for some workloads
at Amazon as well.
