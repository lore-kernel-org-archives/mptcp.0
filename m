Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B14192D97
	for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110609; cv=none; b=KEyyoXNYOHe6/lIoGpdg+HOMkoQs8h+HSRsWsWdptgEbfqWpSUNM8nZxVfvJOpjwJ1TtbJHgBWF/RCUaxCwDtogtIzXbrKMLaHCZldoQyiK3xW3yZNe/78FYFuvXm31G73VjKrokmO19c7CMYcPie8GFRtNHWIdqOestC5VrThg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110609; c=relaxed/simple;
	bh=peKhyYh5erOKsru1vnv61mgnhKM9DzH+xoHN6mevgvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSWRWxIiJlfO0Ax6LsUFDLYsLBd0P8ELu8KWdb0UEn+UZ1fiOHbmTcBF2GhqXyPiNUosOIaSyAZUHX2/LMphTSdTBp7VAz8Mlga0wBeCUe1KT2C7eHY5pSakjuPkiCK6dquTKRcWaL7uOB8YmhO/Rg3kyOCHM8KUXDRWCAWaSb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2C5Jpv8o; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2C5Jpv8o"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2445806df50so652775ad.1
        for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755110607; x=1755715407; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9BzIik8ItZsQbt/3YanXJu26q0lEOJnE+a73ddJFdE=;
        b=2C5Jpv8ooH6xPmyvfmprkvEBQSOGn31ejLp6xJ78EM8CO/fctNF/Hm92HW7nWUBNX0
         VpoDIRUj4lDmnor7hUM8GtEQd6RlXCrgOZcix31Lc8pAXi17sBrbqiEWL7/zdDIvTWlU
         6knrCu7+9dOhoOELjYM8RDjVq2V3t5kNCgj1eZmUQxNzNilFc2OkyfNRKUehZlbQd3+W
         hkKDhPFYp6wEjECjVa9rpTu77U89+2DpIgFYsiH4Xc1dtQskhlwb44SuuTFa4MrXQxhH
         h05faZ8Xlg/DwIe/DdpWFmhLR4jEmwOY2voHuAPiT8QlIlwaSjyDIMYelJfuVoZmxXfK
         Plew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755110607; x=1755715407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9BzIik8ItZsQbt/3YanXJu26q0lEOJnE+a73ddJFdE=;
        b=uGt5xqeyK7r5XcvFqd31FZMPZLIkVCBSOHggIWf5pMWh/aw2rgH+sXu7JENW6LO8bZ
         25Q+EBq5UK7ftjb3cgGWYPfpSFXFGpeMJIZsDlyAhgDwYQmrEIFQoOoGpu4vsPs9JGA5
         xku5fh7ptbZxz4E9guW0EMxDv0o15MsLXv1v6AmouwY0+6qKZieLxZLjHHoE68WDcALv
         ouChyzbvAGsrnZmk5ateKQHoSBiIE2j0Uqavsy39Y7zVyLRV8pnDUSKJLToy0nJf3dqw
         pVIpSfDZ6EPoy8j/Os/42Nxmvm2cJmRmbH+GEmscQXT4jK1oH+sov+2RVl5F8XYlQr5k
         Cbdw==
X-Forwarded-Encrypted: i=1; AJvYcCXqQq6gG3zzCS0Wi2kOi5BiI0soiq+KW5JHlRss+wYASkQA0P0uqsSO/5CGzay40vcevbXH/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5elh2hniVtGB8WCPxhvVBfmfEgfZX4PHEYu5iSLfEiV7z9cmI
	AIur6/WN1vPLlVSfx/jdXAVTikAIcYco0Aqwe8xybLm8npQngjLwnIayQkSno5c8fuwtSlQfU48
	h9HGK608CqhMEwMHqObyb2P93xaHlqEJR4ZVRS2Nr
X-Gm-Gg: ASbGnctXf9bNKJfciSxvM7ncffH0VfgVXL5lvfyntOQmL4Cq8OBGkU1URGkAIHDWKSS
	2jboexx8NWfJ8iMS5oH5wL9VkkcAJJcPYIesNqKy+GaAIjQbNMMn57tJ9EVj9HcL6L6ipsHFu8g
	41pHzIIieOsas4+cgmobogbFSIY0ms48LHI6+BfSbQSQi4hM2xTqkAagu5Z9HqHR62XmaqhT35S
	Jdwp+AsbNH7W5wwfEHpIlIJ5jmsA10VEiDkyqLm
X-Google-Smtp-Source: AGHT+IE+OAJLh0cA0JpKkD0/B+CsZDY5rBp0+LgetnTu3qP/aHmx8+dnnAhaX3xyY/0hlQtXLDaeU8b5ZnPRaXFlw7U=
X-Received: by 2002:a17:903:22d2:b0:240:3915:99ba with SMTP id
 d9443c01a7336-244584af6a2mr1990405ad.5.1755110607235; Wed, 13 Aug 2025
 11:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com> <20250812175848.512446-13-kuniyu@google.com>
 <20250813130009.GA114408@cmpxchg.org>
In-Reply-To: <20250813130009.GA114408@cmpxchg.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 13 Aug 2025 11:43:15 -0700
X-Gm-Features: Ac12FXzkQNJfJzM_zFO5RI8--6tu5_zAqIX6wf49jOuR7WukQGz1HzzF1Da6JMs
Message-ID: <CAAVpQUB-xnx_29Hw-_Z4EbtJKkJT1_BCfXcQM7OpCO09goF+ew@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:00=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Aug 12, 2025 at 05:58:30PM +0000, Kuniyuki Iwashima wrote:
> > If all workloads were guaranteed to be controlled under memcg, the issu=
e
> > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> >
> > In reality, this assumption does not always hold, and processes that
> > belong to the root cgroup or opt out of memcg can consume memory up to
> > the global limit, becoming a noisy neighbour.
>
> As per the last thread, this is not a supported usecase. Opting out of
> memcg coverage for individual cgroups is a self-inflicted problem and
> misconfiguration. There is *no* memory isolation *at all* on such
> containers.

I think the commit message needs to be improved, but could
you read throughout the patch again ?  I think you have the
same misunderstanding that Shakeel had and corrected here.
https://lore.kernel.org/netdev/jmbszz4m7xkw7fzolpusjesbreaczmr4i64kynbs3zco=
ehrkpj@lwso5soc4dh3/

---8<---
Initially, I thought the series introduced multiple modes, including an
option to exclude network memory from memcg accounting. However, if I
understand correctly, that is not the case=E2=80=94the opt-out applies only=
 to
the global TCP/UDP accounting. That=E2=80=99s a relief, and I apologize for=
 the
misunderstanding.
---8<---

This patch does NOT change how memcg is applied to sockets
but changes how _another_ memory accounting in the networking
layer is applied to sockets.

Currently, memcg AND the other mem accounting are applied
to socket buffers.

With/without this patch, memcg is _always_ applied to socket
buffers.

Also, there is _no_ behavioural change for _uncontrolled
containers_ that have been subject to the two memory
accounting.  This behaviour hasn't been changed since
you added memcg support for the networking stack in
e805605c72102, and we want to _preserve_ this behaviour.

This change stop double-charging by opting out of _the
networking layer one_ because it interferes with memcg
and complicates configuration of memory.max and the
global networking limit.


> Maybe their socket buffers is the only thing that happens
> to matter to *you*, but this is in no way a generic, universal,
> upstreamable solution. Knob or auto-detection is not the issue.
>
> Nacked-by: Johannes Weiner <hannes@cmpxchg.org>

Please let me know if this nack still applies with the
explanation above.
