Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01EE3FFD
	for <mptcp@lists.linux.dev>; Wed, 23 Jul 2025 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293988; cv=none; b=IjygWDfO7qnihBZTuuwiA69QbsI8OA8/5lwc1xNPn5eaODL+wrw/+pHnFOFs3Pugcr+rFlQgSluf2hmRWOXQVGee3vKK+U1XKjL9Q7bEBLPBGgk7X/Gfdt/sI0T7OL/NApMFBwirofEMB0bsSotKV2esEiC85sT7mIuN3hn+TFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293988; c=relaxed/simple;
	bh=AtQqA6F/45yFU5BVQolqTbs8/m2tj/q1zoYsWyGZ/7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwwK2/QQYBFI9iGdPwv2w1TL80iWCeBB4eBfc/SBApIzcxcP2i5xahTypZaEA5ntcFnLCqSnjHXzQuaxR/nVAdxstwW+A76aDGo+KJ3Oui4ijWW6XxfrESedZKojDkkqzugsqKsxa54nptSXmzu0ll+5Wu8EVDTYLY+bDQA1HGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tlb3qW+3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tlb3qW+3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23649faf69fso989595ad.0
        for <mptcp@lists.linux.dev>; Wed, 23 Jul 2025 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753293986; x=1753898786; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRVhbn5cd2Y+Qqs2piA5lEzyVD0l4Fs2Eu31USQDCPI=;
        b=tlb3qW+3POe1L9Bp1jm3Zd2QnIk3JJlWoo0L8SodYU44OAr+VJgboRKrLr4nZBQ8rs
         Lp4n6kGJHoaZFji6s1g4AD+Uf7Sfq4ncydob5DlczWKohyjO0GR45tqh9Qv1Ll7ygbOF
         PUqizu/7wkV503zHwMSvdcKy15E9nl67PBrm6LI9sLAPCV1Hl3ucLEQWTpf1Uz8Ix2aH
         /RXvNehczBE9a+/IAiKTSz1fCqCjnkLd2rvDFKgFTXT0CMKp7GjK2mehCyYgMpqtujVa
         tP6L0ucurttx1hpOTc8CQUDXYNC2uLVbgVu+e7O4PzaQp53GKmjPYx4ttePZhpsUjEwU
         sTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753293986; x=1753898786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRVhbn5cd2Y+Qqs2piA5lEzyVD0l4Fs2Eu31USQDCPI=;
        b=r6R+HXa0Oa5yv2w0DWyYJ8ReFUhh4ffwA7uYQwT9hXSOHTGMLFrPVzGCthOH+tuzYc
         20vl2mXM/FeYC01UXkUzcOR1/kY/f7m9EK+HBrsKNqwbM0Kr56QKC8jjz3xwWDW40BaN
         4m/N1DyH96Lr5xT9QHfaPKOe4l8DZNAhE+JOdLtogi7EDL0AOaASIyAspB3hxWLRG0EZ
         mTLeKwtP9PdEhTNguASm/wVWXfiOWCZiHZRf2FU6JhPtRltz2BeF0nsn7SFQZ6x7Ff79
         Twfyb/ztgL/Lusq9fEOlD2YxEtzYXSFN1XaZxZ4OU5mmb5DrcSMaZjCJkNgZJswA97qp
         Wo1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgIJmWSfWColkafyjczBzkO5oxYuVI8YhlMc0/QYO1ODsw/0gc9EJBDaETkhAK9qMZOKAIUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywh7tVMImUzfuH0eCeda0eaQaiVJoW4dSxN0hEN1B3p+6ManiQf
	MyBumy1mYhn7mZW1DTHeo/8hipc1mlFhllK/ReVAlP3zRP1+J+C4F/ObyPQnDhIdJG6yftkd2z0
	HFn95ZJhoK/DCqkFrpPPP3z2fEdra36xbEa78W1zg
X-Gm-Gg: ASbGncuNgRcAvzdUbEoL4Iz2CSXaWxgkSE0M4sN7NfrF2Y3nEKp5w6Ek2fOLaV7JDWL
	YUQvC4og2UCmtk/KLpnOlVFPbShXjc3ybN2+GuUQW/VF+wT5a+/9skKrXC/RAVrz5fWt+8mFZaB
	eBTxfUAMUuOC11+3sSKZNW7sa7rhMkuAyVGtL6fiDS2E9v5HuoMzdYq595A+ie8paaTWPQrUxRX
	6gBAU0ceH4mxnmzPhbFXR9n7kHJ6mIouj/BPg==
X-Google-Smtp-Source: AGHT+IGAS9GFi3JlMJlvgpwfxagLVOLIDfr/dpIzxSNzxoDY3Xq3bIbZBTFy9IfSvS1aU0XN3So/jgdBQSoP4rQIooc=
X-Received: by 2002:a17:903:fab:b0:23c:7b65:9b08 with SMTP id
 d9443c01a7336-23f9813aa74mr61580225ad.1.1753293986127; Wed, 23 Jul 2025
 11:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
 <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
 <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
 <CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com>
 <p4fcser5zrjm4ut6lw4ejdr7gn2gejrlhy2u2btmhajiiheoax@ptacajypnvlw>
 <CAAVpQUAk4F__D7xdWpt0SEE4WEM_-6V1P7DUw9TGaV=pxZ+tgw@mail.gmail.com>
 <xjtbk6g2a3x26sqqrdxbm2vxgxmm3nfaryxlxwipwohsscg7qg@64ueif57zont>
 <CAAVpQUAL09OGKZmf3HkjqqkknaytQ59EXozAVqJuwOZZucLR0Q@mail.gmail.com>
 <jmbszz4m7xkw7fzolpusjesbreaczmr4i64kynbs3zcoehrkpj@lwso5soc4dh3>
 <CAAVpQUCv+CpKkX9Ryxa5ATG3CC0TGGE4EFeGt4Xnu+0kV7TMZg@mail.gmail.com> <e6qunyonbd4yxgf3g7gyc4435ueez6ledshde6lfdq7j5nslsh@xl7mcmaczfmk>
In-Reply-To: <e6qunyonbd4yxgf3g7gyc4435ueez6ledshde6lfdq7j5nslsh@xl7mcmaczfmk>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 23 Jul 2025 11:06:14 -0700
X-Gm-Features: Ac12FXw7kOY6uM_dMo2JVrN3O4hsJfpqzeP9Oi1ZMcHl-QMNLbwpvpTS0-tYcwk
Message-ID: <CAAVpQUDMj_1p6sVeo=bZ_u34HSX7V3WM6hYG3wHyyCACKrTKmQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Eric Dumazet <edumazet@google.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 10:28=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> Cc Tejun & Michal to get their opinion on memcg vs cgroup vs BPF
> options.
>
> On Tue, Jul 22, 2025 at 07:35:52PM -0700, Kuniyuki Iwashima wrote:
> [...]
> > >
> > > Running workloads in root cgroup is not normal and comes with a warni=
ng
> > > of no isolation provided.
> > >
> > > I looked at the patch again to understand the modes you are introduci=
ng.
> > > Initially, I thought the series introduced multiple modes, including =
an
> > > option to exclude network memory from memcg accounting. However, if I
> > > understand correctly, that is not the case=E2=80=94the opt-out applie=
s only to
> > > the global TCP/UDP accounting. That=E2=80=99s a relief, and I apologi=
ze for the
> > > misunderstanding.
> > >
> > > If I=E2=80=99m correct, you need a way to exclude a workload from the=
 global
> > > TCP/UDP accounting, and currently, memcg serves as a convenient
> > > abstraction for the workload. Please let me know if I misunderstood.
> >
> > Correct.
> >
> > Currently, memcg by itself cannot guarantee that memory allocation for
> > socket buffer does not fail even when memory.current < memory.max
> > due to the global protocol limits.
> >
> > It means we need to increase the global limits to
> >
> > (bytes of TCP socket buffer in each cgroup) * (number of cgroup)
> >
> > , which is hard to predict, and I guess that's the reason why you
> > or Wei set tcp_mem[] to UINT_MAX so that we can ignore the global
> > limit.
>
> No that was not the reason. The main reason behind max tcp_mem global
> limit was it was not needed

but the global limit did take place thus you had to set tcp_mem
to unlimited.

> as memcg should account and limit the
> network memory.
> I think the reason you don't want tcp_mem global limit
> unlimited now is

memcg has been subject to the global limit from day 0.

And note that not every process is under memcg with memory.max
configured.


> you have internal feature to let workloads opt out of
> the memcg accounting of network memory which is causing isolation
> issues.
>
> >
> > But we should keep tcp_mem[] within a sane range in the first place.
> >
> > This series allows us to configure memcg limits only and let memcg
> > guarantee no failure until it fully consumes memory.max.
> >
> > The point is that memcg should not be affected by the global limits,
> > and this is orthogonal with the assumption that every workload should
> > be running under memcg.
> >
> >
> > >
> > > Now memcg is one way to represent the workload. Another more natural,=
 at
> > > least to me, is the core cgroup. Basically cgroup.something interface=
.
> > > BPF is yet another option.
> > >
> > > To me cgroup seems preferrable but let's see what other memcg & cgrou=
p
> > > folks think. Also note that for cgroup and memcg the interface will n=
eed
> > > to be hierarchical.
> >
> > As the root cgroup doesn't have the knob, these combinations are
> > considered hierarchical:
> >
> > (parent, child) =3D (0, 0), (0, 1), (1, 1)
> >
> > and only the pattern below is not considered hierarchical
> >
> > (parent, child) =3D (1, 0)
> >
> > Let's say we lock the knob at the first socket creation like your
> > idea above.
> >
> > If a parent and its child' knobs are (0, 0) and the child creates a
> > socket, the child memcg is locked as 0.  When the parent enables
> > the knob, we must check all child cgroups as well.  Or, we lock
> > the all parents' knobs when a socket is created in a child cgroup
> > with knob=3D0 ?  In any cases we need a global lock.
> >
> > Well, I understand that the hierarchical semantics is preferable
> > for cgroup but I think it does not resolve any real issue and rather
> > churns the code unnecessarily.
>
> All this is implementation detail and I am asking about semantics. More
> specifically:
>
> 1. Will the root be non-isolated always?

Yes, because the root cgroup doesn't have memcg.
Also, the knob has CFTYPE_NOT_ON_ROOT.


> 2. If a cgroup is isolated, does it mean all its desendants are
>    isolated?

No, but this is because we MUST think about how we handle
the scenario above that (parent, child) =3D (0,0) becomes (1, 0).

We cannot think about the semantics without implementation
detail.  And if we allow such scenario, the hierarchical semantics
is fake and has no meaning.


> 3. Will there ever be a reasonable use-case where there is non-isolated
>    sub-tree under an isolated ancestor?

I think no, but again, we need to think about the scenario above,
otherwise, your ideal semantics is just broken.

Also, "no reasonable scenario" does not always mean "we must
prevent the scenario".

If there's nothing harmful, we can just let it be, especially if such
restriction gives nothing andrather hurts performance with no
good reason.


>
> Please give some thought to the above (and related) questions.

Please think about the implementation detail and if its trade-off
(just keeping semantics vs code churn & perf regression) makes
really sense.


>
> I am still not convinced that memcg is the right home for this opt-out
> feature. I have CCed cgroup folks to get their opinion as well.
