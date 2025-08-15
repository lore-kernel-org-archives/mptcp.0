Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D31FB3
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216371; cv=none; b=crUkLEdZdysTGqKYF4LELZAZw4SX61jlats7big++eByEZz8Wta9PLg/tnZMbtRQVW+bcBnD2dytpCmPDBQEsu1prWjKuj3OHYeu6VhDLyosje1GhxiAucNaE+KFIjVy+IbVQ321vZjtFdUe43jUH6gUO7f9e4EZeAQBR0X7XIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216371; c=relaxed/simple;
	bh=tOOWispR6Ea6ciZ3YMCAEhq3ARekCONZh3ZONXZA0hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nk5ex2/1Hh5g816OK7E1jMdGISbO++6CkvwCCx2iZwm4Sw6FMXm2WqiH/ZNSR+3H6cc4SXm+dG0KlyzKlGn1cODD0gi+4WlOEzn8t4QJ9Dndz9Uooq6Qu9PdTnWK1PA6VsZ/No4rHnJIFGKPfUIKJulS0Xcxr8gADYpLCLj+8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w/WR1xcg; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w/WR1xcg"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4716fb320cso1210466a12.0
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 17:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216368; x=1755821168; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3g7azcGA34tDaaYjObSrLKH+WoZLGsOWxePbsNLSk8=;
        b=w/WR1xcgh5iRXJIoknYi7PPd4n+iMBon6waHtqAC7YuHiqeHzVxfFU2e5DnMCxe3zZ
         RljHco1qE/0nmF7b4YpyC2KgvMEwWvXTiOtknOpdbl6izV72i9UyKtToVIg8KwkztY/d
         Y6mDjMBzR4SE8Ma2Cy24dhO+Z2OK2dAANDZZPeyztAT5XdMav4Zv1JRxYTRrQb2dDSVR
         uq+y6kjTfu+2cvBrgROA8kQxaVkEO+SqFKoXRR0QcCQNYr7wvQXvM1eYI1Ft03D1FYf9
         55dVRC58m2I6zVdolpnFepiyYzm8NYq13OxyE0NCHLY3ooh3JKAiUEgfX+oGb7xab8xo
         Iaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216368; x=1755821168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3g7azcGA34tDaaYjObSrLKH+WoZLGsOWxePbsNLSk8=;
        b=amFLr++jud15P3Km3EUgz8dWb+wf/vNGAI87nIbLXgMp9647cqrIuwajRREnKm4FNK
         fx2SLqaVI5K2tEnsLcU082mINT7ivSWtxiqs4t50xcZ1ei4DiScdIGSq6hKyEC66MlUc
         7RvNmLexnKLkN9F23+39nCYW4Jh08AmDjiQ8yUvhtP8apeYF2DE0VCRU+wWFH4JJpNql
         qQ6QlZXm3ok9gf7vWJyCBqxwdmy//NtnPFX6lxn2RigHdEVFTi4QbBfB2JL4b6Gecvr1
         3YT05ez8ZPNOT1GTghthb5U8el206KsRKp0UFoCGwQTb61oES0JbrGAluL0M0+s8R6in
         gffg==
X-Forwarded-Encrypted: i=1; AJvYcCUknWoHnNyFp5fVPjMGXww4C95N9VJ0R6TVqJ7VW0H0C6Cu70f1NDCtzIN+hXTwsyHwvL6lHw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw18CTjxtzx6pZ1cPudAwHPRq5jMFnO9fT1tXgkzFwb07IHgxW5
	52+xUmk5sNqUB54BJkNaLV9EPs2TMNq+gYuhWNr86ojQO/SzuBP8749Wa+JI+anXG6Mfg41acvC
	Z+VxLhrA/U+Uf5D5C43JXlFZwDkKVIEq5gqlRBmB+
X-Gm-Gg: ASbGncsLDraC89JEQlcLSmZiHPOnAl4bGIeMqyJIhNB53sWkavdTiWY8vYls2jKrv/9
	9l7H0heBC7wUHfFamyd28fbbLYPQNYa1Kp+hguAN6vUg09c1s81chV6tiubNqf+dgrCeisJTCtX
	CyBvkhN47e9KpZ1LcEmPrpbm9yOxGjVYvaqD5OKPDizn8V95w+tl441mlAjORzm2Oimrwxms7WH
	UvwsMPxmpM/L62MO2Yq3SZjitALw6WMd2HGtNUp31cTP703sUTFvFZX
X-Google-Smtp-Source: AGHT+IEFX5W+lUoDE7ZvmQhutvrW9vD5G/rFOFnR+zH+RlJzruuwGalQl9EbNrgSF6pYF7LAALbUj/uy+KXE1fNSEc8=
X-Received: by 2002:a17:902:dac1:b0:234:d778:13fa with SMTP id
 d9443c01a7336-2446d866269mr1258465ad.26.1755216368013; Thu, 14 Aug 2025
 17:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com> <20250814200912.1040628-2-kuniyu@google.com>
 <cs5uvm72eyzqljcxtmienkmmth54pqqjmlyya5vf3twncbp7u5@jfnktl43r5se>
 <CAAVpQUDyy9f7=LNZc2ka2RiOhR3_eOhEb+Nih37HnF0_cdrJqA@mail.gmail.com> <r3czpatkdegf7aoo3ezvrvzuqkixsb557okybueig4fcuknku3@jkgzexpt7dnq>
In-Reply-To: <r3czpatkdegf7aoo3ezvrvzuqkixsb557okybueig4fcuknku3@jkgzexpt7dnq>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 14 Aug 2025 17:05:56 -0700
X-Gm-Features: Ac12FXwONNleDf8vaBVKCNkrBAioUhawdr6ixCRQttfFCFdFsOrwwMIEvBAgFfE
Message-ID: <CAAVpQUAx9SyA96b_UYofbhM2TPgAGSqq_=-g6ERqmbCZP04-PA@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 01/10] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 4:46=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Aug 14, 2025 at 04:27:31PM -0700, Kuniyuki Iwashima wrote:
> > On Thu, Aug 14, 2025 at 2:44=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Thu, Aug 14, 2025 at 08:08:33PM +0000, Kuniyuki Iwashima wrote:
> > > > When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
> > > > sk->sk_memcg based on the current task.
> > > >
> > > > MPTCP subflow socket creation is triggered from userspace or
> > > > an in-kernel worker.
> > > >
> > > > In the latter case, sk->sk_memcg is not what we want.  So, we fix
> > > > it up from the parent socket's sk->sk_memcg in mptcp_attach_cgroup(=
).
> > > >
> > > > Although the code is placed under #ifdef CONFIG_MEMCG, it is buried
> > > > under #ifdef CONFIG_SOCK_CGROUP_DATA.
> > > >
> > > > The two configs are orthogonal.  If CONFIG_MEMCG is enabled without
> > > > CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not charged
> > > > correctly.
> > > >
> > > > Let's wrap sock_create_kern() for subflow with set_active_memcg()
> > > > using the parent sk->sk_memcg.
> > > >
> > > > Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgrou=
p")
> > > > Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > ---
> > > >  mm/memcontrol.c     |  5 ++++-
> > > >  net/mptcp/subflow.c | 11 +++--------
> > > >  2 files changed, 7 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index 8dd7fbed5a94..450862e7fd7a 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -5006,8 +5006,11 @@ void mem_cgroup_sk_alloc(struct sock *sk)
> > > >       if (!in_task())
> > > >               return;
> > > >
> > > > +     memcg =3D current->active_memcg;
> > > > +
> > >
> > > Use active_memcg() instead of current->active_memcg and do before the
> > > !in_task() check.
> >
> > Why not reuse the !in_task() check here ?
> > We never use int_active_memcg for socket and also
> > know int_active_memcg is always NULL here.
> >
>
> If we are making mem_cgroup_sk_alloc() work with set_active_memcg()
> infra then make it work for both in_task() and !in_task() contexts.

Considering e876ecc67db80, then I think we should add
set_active_memcg_in_task() and active_memcg_in_task().

or at least we need WARN_ON() if we want to place active_memcg()
before the in_task() check, but this looks ugly.

        memcg =3D active_memcg();
        if (!in_task() && !memcg)
                return;
        DEBUG_NET_WARN_ON_ONCE(!in_task() && memcg))
