Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BD21632C8
	for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 05:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063190; cv=none; b=ijrePvVchv3JhrgR22JD3/s9g4LO59s2FfLTveq/s/nvBPBYre1apwsyYOlmYktpRn8NJXG7S5NAoaQHeTudUNRRdCVd0l/g4lR0xlHUeIAPi0deT7LzQu4JosNaFbMuxYbz07HNCp4acJD7+qoSyhZmWoawOO3GyB4IBzvtXSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063190; c=relaxed/simple;
	bh=IHOoxSB2XGC97/Fvbsx3+kWd5jPNAgc8qjq/viGFh94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDWLmueuMxSajAzSkslYy9D2awBZUgIBaDgx5XtBakuEKDYuqoPW1QFrYszW7d9alqyoknf/pFKmO4kDQz0KG9UDn7PNmZ0BJbr3QxfoGzoT+D2pfN6VIiGuKFuZB8NO/YZbW8oz+qgVr/ja7H7R24dtMFHQim9a+TaQ8IFdQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o1MgF1I9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1MgF1I9"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31f017262d9so4977978a91.1
        for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 22:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755063188; x=1755667988; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd5Hzu0+89GoFhfPNDsRG3A11ZVeQEs8/UJ+qwaOXUU=;
        b=o1MgF1I9OM+pj/O4EL163hNDeMDcXCTUNqEd5tPgLKgUEv1wnD7k4I4Kn49sCGWTwV
         FsyVQpjVzvt5ik04xwmZk8pyUlPnm3cce5t65evapsP2FQjgz+J1BtFAZBg7GP0JbydG
         9p8tL0+rE/Fj6/IUaQHP8jMlV/74P1IBm/kJQa0Vfz3wm6b7P8sFXqdkDlLir0i/XTiY
         5b8p1Ytv4apx8z0mYsshuKHSPhoHTBLQYq9EoSNxadXgBmkwJuFIbfhDKWYn2b+7F2TD
         LjCmsdhzVrGQbU54RfE31BqvQKsZlG7K7LXxsES5/VUsuXQM650yYCrCg5fLZ/hixJaM
         uPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755063188; x=1755667988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd5Hzu0+89GoFhfPNDsRG3A11ZVeQEs8/UJ+qwaOXUU=;
        b=KwOr/jQnVkZ2chwIOOrUNZ/tllB/QunvNH2w30kkKWAXVyWoXvGBihxfVCzd9JEfCs
         wFu0udA7H11qoKHasyhOuSNsv5uEhnJ0swRnCGezYM0qcf9jLlgAFrTGOrReiPrM4EmZ
         qTT6yq+z8JjxK7bY6EvODGb+TohBmKpULQWo3Qgl9Oj/6XvbMUnro9GU9EtGkfGo+sXe
         Hta3FwPO2z0P70Utqc87uo7ub2t82H2gfuVaiNEJlJ7l9zkDKovnPSCVf/6nULSkbNGW
         N4kJV6rtYC3S/J5LGXSRtmJ9+/jKRNSybdj8Icb3qZs55KBaYTtyJhNRjMM0NgstE7MV
         345A==
X-Forwarded-Encrypted: i=1; AJvYcCXgxv/7Id7JuLU51sWlMsOqjiWJEvNebIFqd3EGwUenPkIgHF87ZQC5pHESty6e9feNHqDHvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YztexHNQcbzLzNOtolg0RcWL7RS6EABhNEXtDc/+5pnd3sRYTT4
	lunMB1q7NqfaQVTeRABEXmwyqK7zDRd9H9Kg0hKFqgpnltknmxQYkaBUDgivK3XigbRtZ1FLRzn
	zToFvR3ileJXCopGAsdskYNtSboF6XjVyAKQt1x83
X-Gm-Gg: ASbGncv16BqBemzeXjd2asrUfYoKrJdO9QIG8wwshn31LI5Qi/MTVFy43+fVqiypXlX
	e8zRGEqa/3eblrGM1EG2r9pGieT46FylQbO3YMMTE9scpJwBBCFgddLkNKKZ3C3dQBkG/J21Enf
	SJEnni1IEim1+3duyEwEA6gAfSkbrbY40zkm5u82lBHovfhQ54gLl8bQ7/kSDXcvWRORUc2N5gY
	WS9ZEHre99lq+uQXeZfG3FS53SV+CpjFZeuGTjGZknCsSyt4YM=
X-Google-Smtp-Source: AGHT+IH3Ow5heN5Ax2cYKZiN1J5uErCtHiipF//JGUZalAKyO1nKABn3UiGzqPqVAQOS02PYRiux0Wll/uHc1/Zh/PU=
X-Received: by 2002:a17:90b:3c08:b0:321:c567:44bf with SMTP id
 98e67ed59e1d1-321d0eb0f49mr2505895a91.29.1755063188104; Tue, 12 Aug 2025
 22:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com> <20250812175848.512446-13-kuniyu@google.com>
 <87ldnooue4.fsf@linux.dev>
In-Reply-To: <87ldnooue4.fsf@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 12 Aug 2025 22:32:56 -0700
X-Gm-Features: Ac12FXzONwUY1or--rg6Ax98ZVLm-UmE3bBgmXpdqTrH-hTrcJWYQJLYQ9n4lIg
Message-ID: <CAAVpQUDZ_8RN_VxQWH_wipRd_Ge++YZU5SQC9535CR8W6m-JnQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 6:58=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Kuniyuki Iwashima <kuniyu@google.com> writes:
>
> > Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> > buffers and charge memory to per-protocol global counters pointed to by
> > sk->sk_proto->memory_allocated.
> >
> > When running under a non-root cgroup, this memory is also charged to th=
e
> > memcg as "sock" in memory.stat.
> >
> > Even when a memcg controls memory usage, sockets of such protocols are
> > still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
> >
> > This makes it difficult to accurately estimate and configure appropriat=
e
> > global limits, especially in multi-tenant environments.
> >
> > If all workloads were guaranteed to be controlled under memcg, the issu=
e
> > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> >
> > In reality, this assumption does not always hold, and processes that
> > belong to the root cgroup or opt out of memcg can consume memory up to
> > the global limit, becoming a noisy neighbour.
> >
> > Let's decouple memcg from the global per-protocol memory accounting if
> > it has a finite memory.max (!=3D "max").
>
> I think you can't make the new behavior as the new default, simple becaus=
e
> it might break existing setups. Basically anyone who is using memory.max
> will suddenly have their processes being opted out of the net memory
> accounting. Idk how many users are actually relying on the network
> memory accounting, but I believe way more than 0.
>
> So I guess a net sysctl/some other knob is warranted here, with the old
> behavior being the default.

I think we don't need a knob to change the behaviour because
the affected case must have a broken assumption.

There are 3 possible cases below.

1) memory.max =3D=3D "max"

2) memory.max !=3D "max" and tcp_mem does not suppress
   memory allocation

3) memory.max !=3D "max" and tcp_mem suppresses memory
   allocation

1) is not affected, and 2) is not affected too because decoupling
does not change the situation.

Then, for 3), this change will allow more memory than ever,
but it's still limited by memory.max, which is configured by
the sys admin.

If this could be a problem, then the total amount of all memcg's
memory.max should exceed the amount of system memory,
which is unlikely if configured properly.

Also, in the 3) case, TCP has quite bad performance and the
sys admin should have raised the tcp_mem limit and moved
to 2) like our unlimited tcp_mem setting.

What do you think ?
