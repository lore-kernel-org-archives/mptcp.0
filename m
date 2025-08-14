Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D728751A
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755214065; cv=none; b=Lsha5CI/HUBNsFlrh5kk7WU5p86zVI79Pw8oD8PdkZ/hx84OSsnG/LVZAzFhZUqb7H7J/UF/FXrMuD3BaAxg9GZFXHRbvVWNo4Y2coXBoyXrhkUiENyo8UaCDbS2nKkiSTIYjkUi9fupIF7tLMpk8vFB4iBaKLfEIcjFfQvVL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755214065; c=relaxed/simple;
	bh=cNrWzSWBbJ3DFgnD1h7xjqM4iq2jyeXReFXRG/RQUaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1M0F8Zsemg3SnROWgrieqW5QZ/8SZSEA2ESxSbYfVdRlpC/lZ7PMP6M2LcDTtVtf5u3HalTYnvCvxET4oLhiRlXJo5xrtV/b5dtfiesUz9jBMUeyEZm7Aa9rqsbJ3dolUfLlHvuWZIAf5JcB9TwybR7RmucTy7RWZNKXRk/AwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a9vUSna/; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a9vUSna/"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4716fb8e74so1231628a12.0
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 16:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755214064; x=1755818864; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJte4ardeN85Du6oFLbjV2pOyfXJ8yitINHiZm+Srao=;
        b=a9vUSna/yV7wSpv0v56NGezvqpDn4aKjbjaTSqJ+EuclPheIPX53H9Z87rxfxSuSDm
         X3XLMby/rQZLaX3x7pQ8UAVBZjH8VJ5dCmJng7jnAAdlQBFJP+e+IncA89WmCsgjFRuL
         VrKC7nD2z2qllsGgKlnyMsCkN5zYXdwD1sVn1xsv8T1v8qvimhiUvEhRDiDg+0nzmTqp
         f+f96E9hUhxPW8XjhFAMyMJDnGO0ZOnwUGL2tAYtoT+Juob5EbFlJwKRIs8cJaHBzuuf
         U6Yy1CnCm8bjqi58G9CUmr+kNWSEtPiogzoWR/ct/kcvSb47o1zYU3XhhkFDRYREWy3C
         0wIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755214064; x=1755818864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJte4ardeN85Du6oFLbjV2pOyfXJ8yitINHiZm+Srao=;
        b=XZ30bg2vNULLxQnHJCrIPbRsCd7XOPLwSj8F4DDWOOKZmL657OpPTFTYaQFy+5H6s1
         nhvQ8ISHLT5hU+TOagSJCJ+nXEf6CMC+xmcrF28GqVbS9zrjzzZ7U+BMShxaaU38byCK
         spVu/LxxqNyJchoFj8fGcT1X268V2VOvu66oTi/tjOjBx3ZPCFkv1ZGKnUfO5kx1/97o
         9VWo2NaZx4KukTCyoloWIXdScBQDgv/jTNpsd3epvc8AALhDYT7rMKhH1SoNEIh1TgIW
         X5jDenO64nH6QwVf/Y/ROlsBNPFrwqyt25oU03Ctz6me9vyg6tXzSitX+PBjEUE+8eaJ
         UY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXD8vM9YHj0Lbk0SHMVepcEoJFZ4Pp+AK56R6aiCFqD7kgfIEp9TuEG+PhI1YxpGTiFHzHSfw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0VWZid4EMDaeQ6ZUXJkGsIsshVj2TUbDA3xhCg6SS6g6GTYUs
	eOV2JWNX47kLOD4bDP9FZgdp07c8N7Ek3MuUTVNwdHKGk/uPziRdaoB2JEJf/cCirzfzMixVDdM
	kEifSv+YQnDLcjrUl5VPTweCyAG42ySxHS4swbQfZ
X-Gm-Gg: ASbGnctbCmdYQoEh181WOl9UIKonxvzFo9kIR1Krr5EA6b+CyxtJhr4YqT5lt95q2RY
	VUHxJpQTTet3NZd1UFS3JN8rXfQ+2IWUtTDJX7Xmtbhw6RqiZYCLHIiANEgPbGSkEdOPsFzYrrL
	DyMgKMHwfHBQoXcBWKY6pptIB3bZQ1XUpafS9pGesYIrgoVeoMu8RIA3VeoM31gNawKRKjLC/sb
	WxVWJOs4wFJ7l2DR6lswVG6/GX+cAWF7brC1WbGnzimPA==
X-Google-Smtp-Source: AGHT+IEHit+6v/zQOrDIYEMP+S59QKYaphBAhA88+cWD0rCmrcxwlIgGARBzu1jGkGqvO/cZmUpqkxnAjxS8w/4Lc8g=
X-Received: by 2002:a17:902:e78e:b0:235:f078:4746 with SMTP id
 d9443c01a7336-244586dbef9mr70544725ad.42.1755214063557; Thu, 14 Aug 2025
 16:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com> <20250814200912.1040628-2-kuniyu@google.com>
 <cs5uvm72eyzqljcxtmienkmmth54pqqjmlyya5vf3twncbp7u5@jfnktl43r5se>
In-Reply-To: <cs5uvm72eyzqljcxtmienkmmth54pqqjmlyya5vf3twncbp7u5@jfnktl43r5se>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 14 Aug 2025 16:27:31 -0700
X-Gm-Features: Ac12FXwI-hCJioucwxG326FRr7yD4nkwLO0ruxEaSqR9_-vI1XwEMNZdtXGsZVw
Message-ID: <CAAVpQUDyy9f7=LNZc2ka2RiOhR3_eOhEb+Nih37HnF0_cdrJqA@mail.gmail.com>
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

On Thu, Aug 14, 2025 at 2:44=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Aug 14, 2025 at 08:08:33PM +0000, Kuniyuki Iwashima wrote:
> > When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
> > sk->sk_memcg based on the current task.
> >
> > MPTCP subflow socket creation is triggered from userspace or
> > an in-kernel worker.
> >
> > In the latter case, sk->sk_memcg is not what we want.  So, we fix
> > it up from the parent socket's sk->sk_memcg in mptcp_attach_cgroup().
> >
> > Although the code is placed under #ifdef CONFIG_MEMCG, it is buried
> > under #ifdef CONFIG_SOCK_CGROUP_DATA.
> >
> > The two configs are orthogonal.  If CONFIG_MEMCG is enabled without
> > CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not charged
> > correctly.
> >
> > Let's wrap sock_create_kern() for subflow with set_active_memcg()
> > using the parent sk->sk_memcg.
> >
> > Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgroup")
> > Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  mm/memcontrol.c     |  5 ++++-
> >  net/mptcp/subflow.c | 11 +++--------
> >  2 files changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 8dd7fbed5a94..450862e7fd7a 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5006,8 +5006,11 @@ void mem_cgroup_sk_alloc(struct sock *sk)
> >       if (!in_task())
> >               return;
> >
> > +     memcg =3D current->active_memcg;
> > +
>
> Use active_memcg() instead of current->active_memcg and do before the
> !in_task() check.

Why not reuse the !in_task() check here ?
We never use int_active_memcg for socket and also
know int_active_memcg is always NULL here.


>
> Basically something like following:
>
>         memcg =3D active_memcg();
>         /* Do not associate the sock with unrelated interrupted task's me=
mcg. */
>         if (!in_task() && !memcg)
>                 return;
