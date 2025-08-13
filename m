Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A90527AC3D
	for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109185; cv=none; b=dYA/4+ZHambwaacECr9+evSC4wHfSVZQdCA6RcCZ7lD5Z1cXusp5pCZNmfUTob7dOKkwMKUypePBZdCavnTshbx/p4uAkK3Ua63ZVNM8elce+Kgo2fj2EQ6foSK4/3vqAPd486DojqgZ0YFZSajKYH1pscPNjXWxuBeuXn2zG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109185; c=relaxed/simple;
	bh=fw5JApDG6E7HdeFzFi4vjxwW75IQ4aLteld4LCnG/oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGhV9VbdjWQz9YVv7jv4tqwu7ch51Ajz3xyMw/gXBqIfMR5VrSG61inFuwFwfeFvhT6MTQVWdgQYpIYpRjNiZzVvuOoLqT2tz+oe9uN9zYbePJbxwq9M6lwcYDYoFfzji/3SMxtSqaMTEtu8/7qm+hC4S1sw2ODK8vqBoYZNTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E8NhjTAM; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8NhjTAM"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4716f46a2eso37438a12.0
        for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 11:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755109183; x=1755713983; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rspvbHj5HBwP8PT/Z2YHbQFfZn6hZPQOR0l2xh5UztM=;
        b=E8NhjTAMMK+MMMrfK7kR4M+Lj1BpWCUSas3c/YXUpBpzQA2HaNbLN1dpfOCPutzoYC
         Dmw49UdlV+LQbGsQBn1h1nvAWxwBSCTSp7P+Lo4lEx5+JoouBjgzaZPrJTh3Vo3sEUq9
         0tieFs2F3Vj3oe7qIN65pNh0vbo8lHQukSbr9fLuwsPxlJiVdOEjfy/T7MKN3T4EyCaI
         ttpz7MI6J8RMyFNWf/3sORRJ+dDgTqwZHHq2zaZL46YfKC5KkUPp2zlyP0BL5VWkMwT3
         XbxIPp7fnKboBlDE5hzcXGuAWle125JPbwbRufAWsH5xzI1KZ3iejRpTSgr0rcVpWmlw
         aPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755109183; x=1755713983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rspvbHj5HBwP8PT/Z2YHbQFfZn6hZPQOR0l2xh5UztM=;
        b=bK2eSckuQ4XrfKCZYzYbrgUpxf9No/WRN1kX6bxAEI+K3rxwz275IlyZeSEfUwa+bN
         JyM3V43+pe9pINAyWf+8vozcKb1gfb0hrihcVhjnQCZcWRI6uqzSMECUaebqfSi9JwkW
         dyu43paL7jrGvf3zbzoWMwXie5K8tSZhrqiVNWzyCGUjVTtVCnOZ06HFWWC/kQRVljjB
         xznkDVBhymPCoAQPuFN6WVMUQaB3NkHu+qW5DS78n+P7XTibtr2NW9s9ht2N1bSMuBPt
         02llmChvSlN8l7c6UEAIq9fuB7kid5IdbR5dqmIS5E7gUJ9S7XN3hmRMNQ6dgUiYaKgK
         AmPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzlRu6TdbVa5Kpi6TlFQL4D70aKHqjlN77pz7CNQlOsLLbIVFG17u9cVKitla0pdc8HS4m3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyC9AGdrheZzW/t6Pxtj3PrVsxJRdTlm4WzL2JonoaVBuiXfycU
	56gDPXHELo8ai+WA0iVsWLcH2nhTf5t+VfS4W7tOmfF3usrUH1ZXwT7nMecTOMMxv+nXNFOZ8+Q
	AD1QthsR2z67qYku3V8v/a/kNWZ/P6e4Tt+Xy3i4O
X-Gm-Gg: ASbGncuhTSjUzBZ+ae7NqMIieDGY9corJTxaRdKaLK4R/ip7BjNVYE3hoyYzlZZAgUc
	TAjVpLd+DkMDPiKmzyg3K8A+SriwSLcD8BNjtw4LYfNaTcLTm7ISowYQ2hJOOfQb35+VUcZ3tSA
	pPjW/8mbr7Rz4l4Rez3kEmYiw4nyMJwnyFzgmlXgv2OdftmnwWBAUDEb1XkxK/tSCBGLjPjYIye
	lXohF9SV3HhaLTg7yGa96qDkLZ1PLVkhlxxUKVBq0SyKU4qDTI=
X-Google-Smtp-Source: AGHT+IGBb76+41F2pHvydMm/JGXdMlN/mBnhrFNW+ic56J+9RYUnTBwRHsVejTU0pmtbS8GUNrvPI/xlIhdPGk+iHk0=
X-Received: by 2002:a17:903:ac7:b0:240:e9d:6c54 with SMTP id
 d9443c01a7336-244586d44bcmr733595ad.48.1755109182900; Wed, 13 Aug 2025
 11:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com> <20250812175848.512446-13-kuniyu@google.com>
 <w6klr435a4rygmnifuujg6x4k77ch7cwoq6dspmyknqt24cpjz@bbz4wzmxjsfk>
In-Reply-To: <w6klr435a4rygmnifuujg6x4k77ch7cwoq6dspmyknqt24cpjz@bbz4wzmxjsfk>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 13 Aug 2025 11:19:31 -0700
X-Gm-Features: Ac12FXzLogDC6UGMQNMWDnDL9De9KnuUUW31y0FBm57RPEyjApbQulTgV6dTnyM
Message-ID: <CAAVpQUCU=VJxA6NKx+O1_zwzzZOxUEsG9mY+SNK+bzb=dj9s5w@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
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

On Wed, Aug 13, 2025 at 12:11=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Aug 12, 2025 at 05:58:30PM +0000, Kuniyuki Iwashima wrote:
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
>
> Processes running in root memcg (I am not sure what does 'opt out of
> memcg means')

Sorry, I should've clarified memory.max=3D=3Dmax (and same
up to all ancestors as you pointed out below) as opt-out,
where memcg works but has no effect.


> means admin has intentionally allowed scenarios where

Not really intentionally, but rather reluctantly because the admin
cannot guarantee memory.max solely without tcp_mem=3DUINT_MAX.
We should not disregard the cause that the two mem accounting are
coupled now.


> noisy neighbour situation can happen, so I am not really following your
> argument here.

So basically here I meant with tcp_mem=3DUINT_MAX any process
can be noisy neighbour unnecessarily.


>
> >
> > Let's decouple memcg from the global per-protocol memory accounting if
> > it has a finite memory.max (!=3D "max").
>
> Why decouple only for some? (Also if you really want to check memcg
> limits, you need to check limits for all ancestors and not just the
> given memcg).

Oh, I assumed memory.max will be inherited to descendants.


>
> Why not start with just two global options (maybe start with boot
> parameter)?
>
> Option 1: Existing behavior where memcg and global TCP accounting are
> coupled.
>
> Option 2: Completely decouple memcg and global TCP accounting i.e. use
> mem_cgroup_sockets_enabled to either do global TCP accounting or memcg
> accounting.
>
> Keep the option 1 default.
>
> I assume you want third option where a mix of these options can happen
> i.e. some sockets are only accounted to a memcg and some are accounted
> to both memcg and global TCP.

Yes because usually not all memcg have memory.max configured
and we do not want to allow unlimited TCP memory for them.

Option 2 works for processes in the root cgroup but doesn't for
processes in non-root cgroup with memory.max =3D=3D max.

A good example is system processes managed by systemd where
we do not want to specify memory.max but want a global seatbelt.

Note this is how it works _now_, and we want to _preserve_ the case.
Does this make sense  ? > why decouple only for some


> I would recommend to make that a followup
> patch series. Keep this series simple and non-controversial.

I can separate the series, but I'd like to make sure the
Option 2 is a must for you or Meta configured memory.max
for all cgroups ?  I didn't think it's likely but if there's a real
use case, I'm happy to add a boot param.

The only diff would be boot param addition and the condition
change in patch 11 so simplicity won't change.
