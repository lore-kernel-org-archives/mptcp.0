Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570D72BDC2E
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225082; cv=none; b=vBOxVPoqMiwnLB9JyZ9royToTOKxIsZGptVOIlPKlsE7q9zLB8UTTn1ktoAxkubEQ9E+6Wxovq3Uon05X3ztoMQiqlmfcoZRE3tzvLI22hGMk8dh56TkJGmsCa9lVzS1iwGjC2g1e7FCixaYc3TKWxwePxjRYHDmA8I2FAvDEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225082; c=relaxed/simple;
	bh=qT2uL3TSbpLxV1OGxvbcmHAxQOjkb9fdYhdqFdG7X4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2Tb/dMrIzOQ5Xl9B7a0YCBT30zimYE3sIhFEOkIi6RARhCoB+wHZF7QNTAiB8A/0iExeYPjamLNFRTht1waayv1b1yFYRJUiB8q32ndOsaKv2GCMhCgEKTs4QqhfmRkBJmIoUu+BaVyzMzEKv2H6FKoERipNg3arSNB56DhYgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yo03yUeR; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yo03yUeR"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b472da8ff0eso17844a12.3
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 19:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755225079; x=1755829879; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwJrICMvn5YZZg5OvFRoWR/jD5Y72+/VemdMMNlTNAY=;
        b=Yo03yUeRIAMpK3N6yXJ5BkE6i6IENiVzCiMnF6Jl6w8byrN6FFjNn7llC085gZ6rsW
         0VZ3uIL0stls0Jj5o8WuloX9gKB0ki/LZMz9jNp3XPDjBMpJnQXh4C0Lq7lMqLvJ14aK
         +2khRWe9tNFr2HTQ2riWD35Bhmmfwh9EJl78lhkABgsXNmrWpVbjV8oxshZh4tpEhJhb
         9FauIu6M/AOhlqaEfxJiMM+Nq89ZPRVU8gK82KuARPMwBywic5Id+JSmYQEzre2d7vlb
         T+mo1uambCWc2vN2BpqOMCFc5QkoD3HPLAeR9hKgBw3RNqUfoU1CDAycl053DzH9rWJM
         AsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755225079; x=1755829879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwJrICMvn5YZZg5OvFRoWR/jD5Y72+/VemdMMNlTNAY=;
        b=ep5g7UxzBAprdCayNFkkM1ru590S7dhXBmfQm8xkogF55myV4JyFUoj3elDDbIqhrL
         sCc2KKQH0Z8YjIzUMnWwPafXCToOGSynIO6n6/gH0381h5BoUIrkLDCt7PcKZM8oBgHV
         jLmKCJ9fMlNizJD+llBX0AsxFde5cw+1TKuRRzfxQjJzNYulgeTPFH8bW7UtgavNzNLI
         9CPD3rCacerA1mXJsKBG19lnbAIruQuKjSXuWux9SIjJX9psuEHrkAYl5Iv2fdj4tjoy
         IHKs1FKCz8a6YVI41ae7AksjP0p3usLzA+tL+n6v6dPntwkqBP8J4FHCvPVriWqMGB5Z
         Acvw==
X-Forwarded-Encrypted: i=1; AJvYcCXh3OXwvWn2NCs+RRgACjYyBUbMMGbJcEAhwi/LXvFnTX+wn26iiuwJ6LYyqXtI/s8crq6AOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyt9NmohrtmZ3u0RDrWIv4LtJNqSZe91hRonaLEj8feyqBf9tv5
	1lqOa7a4VAAAOa8cGXpsVosE7fxNG4kM304/stHAvT3qGEqJouWe7xxv7CkgZUR4B5SG1aC6S+8
	vjfFrKX08fV0QlqaWp4kPb1i+Sis916MSaBrTGkb4
X-Gm-Gg: ASbGnctPB/7GfKmJVxBoUoWVdxkPZjR/t2Scgm+doUAS42HiyMSFqYq1A1INQypEKI4
	bqPSiQKz7ON/bwwc0elXPSET7KHBpw6XIBdJiPjSMo4TuTOCUQUT3272BAt9gmtT/XU9tc1EbB5
	gEG+Y0sc69p3xwvqtjPWSAQaCxpboy+2USaDO8emznqEt+gVFT7uGHby5kwm8jZgGZn8iX/4T6I
	R+UsF7nqi3hc2zxB9uXyShGOJeOP+h295pQwhmjPc6TpwPLwqj6iYRg
X-Google-Smtp-Source: AGHT+IEwYQ5eDN0UwWpz8ZWif2tlMoHHE0vvfDGyA+lewx7O9B0FGbBkW3rn66Hd2jfvfyy3r38VK778LZowgwK8wBM=
X-Received: by 2002:a17:902:cec4:b0:235:c9a7:d5f5 with SMTP id
 d9443c01a7336-2446d71ea77mr6091625ad.13.1755225079199; Thu, 14 Aug 2025
 19:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com> <20250814200912.1040628-2-kuniyu@google.com>
 <cs5uvm72eyzqljcxtmienkmmth54pqqjmlyya5vf3twncbp7u5@jfnktl43r5se>
 <CAAVpQUDyy9f7=LNZc2ka2RiOhR3_eOhEb+Nih37HnF0_cdrJqA@mail.gmail.com>
 <r3czpatkdegf7aoo3ezvrvzuqkixsb557okybueig4fcuknku3@jkgzexpt7dnq>
 <CAAVpQUAx9SyA96b_UYofbhM2TPgAGSqq_=-g6ERqmbCZP04-PA@mail.gmail.com> <kr6cv3njfdjzc2wcrixudszd2szzcso7ikpm6d5xsxe7rfppjs@5bvfwpelgj6f>
In-Reply-To: <kr6cv3njfdjzc2wcrixudszd2szzcso7ikpm6d5xsxe7rfppjs@5bvfwpelgj6f>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 14 Aug 2025 19:31:08 -0700
X-Gm-Features: Ac12FXx0oP3F9dx8jnlPn8DV0XXtg4bMkD2eiCckKKtAFl_RyUY4z0YgVFHXtPQ
Message-ID: <CAAVpQUCMcm8sKbNqW9o6Ov1MtC67Z--NTv9me1xcYgCkbJxK5g@mail.gmail.com>
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

On Thu, Aug 14, 2025 at 6:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Aug 14, 2025 at 05:05:56PM -0700, Kuniyuki Iwashima wrote:
> > On Thu, Aug 14, 2025 at 4:46=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Thu, Aug 14, 2025 at 04:27:31PM -0700, Kuniyuki Iwashima wrote:
> > > > On Thu, Aug 14, 2025 at 2:44=E2=80=AFPM Shakeel Butt <shakeel.butt@=
linux.dev> wrote:
> > > > >
> > > > > On Thu, Aug 14, 2025 at 08:08:33PM +0000, Kuniyuki Iwashima wrote=
:
> > > > > > When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
> > > > > > sk->sk_memcg based on the current task.
> > > > > >
> > > > > > MPTCP subflow socket creation is triggered from userspace or
> > > > > > an in-kernel worker.
> > > > > >
> > > > > > In the latter case, sk->sk_memcg is not what we want.  So, we f=
ix
> > > > > > it up from the parent socket's sk->sk_memcg in mptcp_attach_cgr=
oup().
> > > > > >
> > > > > > Although the code is placed under #ifdef CONFIG_MEMCG, it is bu=
ried
> > > > > > under #ifdef CONFIG_SOCK_CGROUP_DATA.
> > > > > >
> > > > > > The two configs are orthogonal.  If CONFIG_MEMCG is enabled wit=
hout
> > > > > > CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not char=
ged
> > > > > > correctly.
> > > > > >
> > > > > > Let's wrap sock_create_kern() for subflow with set_active_memcg=
()
> > > > > > using the parent sk->sk_memcg.
> > > > > >
> > > > > > Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent c=
group")
> > > > > > Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > ---
> > > > > >  mm/memcontrol.c     |  5 ++++-
> > > > > >  net/mptcp/subflow.c | 11 +++--------
> > > > > >  2 files changed, 7 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > > index 8dd7fbed5a94..450862e7fd7a 100644
> > > > > > --- a/mm/memcontrol.c
> > > > > > +++ b/mm/memcontrol.c
> > > > > > @@ -5006,8 +5006,11 @@ void mem_cgroup_sk_alloc(struct sock *sk=
)
> > > > > >       if (!in_task())
> > > > > >               return;
> > > > > >
> > > > > > +     memcg =3D current->active_memcg;
> > > > > > +
> > > > >
> > > > > Use active_memcg() instead of current->active_memcg and do before=
 the
> > > > > !in_task() check.
> > > >
> > > > Why not reuse the !in_task() check here ?
> > > > We never use int_active_memcg for socket and also
> > > > know int_active_memcg is always NULL here.
> > > >
> > >
> > > If we are making mem_cgroup_sk_alloc() work with set_active_memcg()
> > > infra then make it work for both in_task() and !in_task() contexts.
> >
> > Considering e876ecc67db80, then I think we should add
> > set_active_memcg_in_task() and active_memcg_in_task().
> >
> > or at least we need WARN_ON() if we want to place active_memcg()
> > before the in_task() check, but this looks ugly.
> >
> >         memcg =3D active_memcg();
> >         if (!in_task() && !memcg)
> >                 return;
> >         DEBUG_NET_WARN_ON_ONCE(!in_task() && memcg))
>
> You don't have to use the code as is. It is just an example. Basically I
> am asking if in future someone does the following:
>
>         // in !in_task() context
>         old_memcg =3D set_active_memcg(new_memcg);
>         sk =3D sk_alloc();
>         set_active_memcg(old_memcg);
>
> mem_cgroup_sk_alloc() should work and associate the sk with the
> new_memcg.
>
> You can manually inline active_memcg() function to avoid multiple
> in_task() checks like below:

Will do so, thanks!


>
> void mem_cgroup_sk_alloc(struct sock *sk)
> {
>         struct mem_cgroup *memcg;
>
>         if (!mem_cgroup_sockets_enabled)
>                 return;
>
>         if (!in_task()) {
>                 memcg =3D this_cpu_read(int_active_memcg);
>
>                 /*
>                  * Do not associate the sock with unrelated interrupted
>                  * task's memcg.
>                  */
>                 if (!memcg)
>                         return;
>         } else {
>                 memcg =3D current->active_memcg;
>         }
>
>         rcu_read_lock();
>         if (likely(!memcg))
>                 memcg =3D mem_cgroup_from_task(current);
>         if (mem_cgroup_is_root(memcg))
>                 goto out;
>         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg1_tcpmem_a=
ctive(memcg))
>                 goto out;
>         if (css_tryget(&memcg->css))
>                 sk->sk_memcg =3D memcg;
> out:
>         rcu_read_unlock();
> }
>
