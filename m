Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336627E1C8
	for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005917; cv=none; b=a5nAb4qYPK7ohqrzbrMfwIR1hxrvgkn21W6ONuOOayavfi8CfFdawUaifw603MZ6T7Or/AdRgJUM7eeIrly5DxkLcN/9ovBPSEIH2BOdmyFnrZp/BJgqZ3urXqNV1FtLFwSxaPwuyc0Q3voDzNz1ybk6ULFHIbA8ln3IoMR2VUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005917; c=relaxed/simple;
	bh=TsBYoTolo2tufsEqEbhWRrPEmFDJFyPBTlMs+f63jG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmIryd0xbOOPcx301ie32q7OJQAH0Q4KlV1mbgT86XV251fVFoHe+JvOJSn38+BNMUm2R3/2j9zcYN175Esp738vegOOu6x+P83wZ9BKm8nqoe+Tch79skAA6B66frVGG2nmpXXWHkvK5gp9O6DrL2rdFnvUs6pIGj9LwxFF+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sd2V1WDD; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sd2V1WDD"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31f28d0495fso1600609a91.1
        for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 16:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754005915; x=1754610715; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1pY4t9vVS5jlHwuXly55Cv9xSzwUaUm6zW230XbJ2A=;
        b=Sd2V1WDDHQAhUIPtDwrmlrjzc9+KDIYyJR5wqfQi9dtYnyvB/we/4BdNogDY5Mbi1O
         5o5h6+Wz1JD9NmzTVxs6zFzlSU2wyudc6DotsPX0V2H/4S0u4eAq8mR+tkkAENwTgKID
         W9EmfKDOzNiomf8N6I1mO2TbClTM4TNw5Hgl/mUD2I8WnRy4oGd6kwjy+rzVGJgpjTNx
         XQQRCmo9puI6u7ECyWdw9sKdrYzPVXQOF/5hsKi6V+zLzxCZmc4BXhvq5iQ9N1VJaw8c
         l9oyYu6Ize9rEB2rsgHvM1xsjl7dbWaKgcKjs6DL68ncS4Vpopr5DJtxdOHr/hAzcP/6
         X01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754005915; x=1754610715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1pY4t9vVS5jlHwuXly55Cv9xSzwUaUm6zW230XbJ2A=;
        b=XGWgvNxQ6XNWqNneFYeNYyLTk33UmLv1dmIAdy3IiKQ6yqSPXiYuD25zHbBt7Hm5ie
         5vHPm2bQQLpkK990l4UjzfHL2MTWvPDA5OKsIzFJttAyiGf0lqrV0DZGAd0velNGGrJq
         LdKCJaQCuUahzsjYmlDKMNr5hPAEyrcXwoktkDRIr2okkx4Ult/vw87JEP/RzlnaR7wY
         81sbX5uCF0FD7CDrx20RuiOKRumy+IRGSRIo4UcT0nT9YopK9lV+5VG+ZpAZHk1zrlQ1
         v3qzpkQEcvRUnutqWKG1yT3RXaXERMHkUcY+gVzJacfxK8J0sBX+dLlzxYaOjVti+ebf
         7qog==
X-Forwarded-Encrypted: i=1; AJvYcCXUmO/ub79tX2rjkc7yFVbi+gxoV5qK9IqS3yR1nWE9Ys6DEIvP/utRqZRppmndEAYMfcPBDg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzuw+plwnjCxQ4BQRkL7L7oy7gXB9CHNSWI97xzS46b7Nq79d24
	Fg7/MQW5izm0OfO2RFHNU8xj9Ttz9VYna7QirzCqBRbD23lWl1x2kr3VIUe88A61be2Zt0dU26d
	WqWXD6M9VeNX7KLhdMw+hsZi8YoXMElU0dqU9Vo7Q
X-Gm-Gg: ASbGncvQZzUaXg81+U1zEIgLuMO+etMkKwxg0/u060xqVv+IMV+khOv9j4AkCzJDDT3
	tf/onhfQVM5IJLtdvz0u6SS/oKe4stYBQag1x4Rl+maHBmKzdjoHl3YIAvEI9zg6RI9B4wEds+e
	l/jmrmR6AG+xtibj6M75dNqUNkq6axx+EhoAco9b6e9cxdgYAB38rReR0/sh3hs252M2ffs/ukg
	c7UWZsqyAaeTS0IdoYl2fb7Z1z4BMN3H7BcZ7a+N00UDOQg
X-Google-Smtp-Source: AGHT+IGMdr5+ZltYc/B0msRqSn8S05vopIUSrPrZpbCyE1ibrXKKkFxzUCv9+aOryf0B15tqU6r7DGOpYwl+1TOpJ8U=
X-Received: by 2002:a17:90b:3952:b0:31e:ec58:62e2 with SMTP id
 98e67ed59e1d1-31f5de4197dmr12628654a91.19.1754005914820; Thu, 31 Jul 2025
 16:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <fq3wlkkedbv6ijj7pgc7haopgafoovd7qem7myccqg2ot43kzk@dui4war55ufk>
In-Reply-To: <fq3wlkkedbv6ijj7pgc7haopgafoovd7qem7myccqg2ot43kzk@dui4war55ufk>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 31 Jul 2025 16:51:43 -0700
X-Gm-Features: Ac12FXyRo64aj2tAOXgVRHN2Olp9-pPfFQKxGBKy5bgLlQjCQOCZQOdKisc5o28
Message-ID: <CAAVpQUAFAsmPPF0gRMqDNWJmktegk6w=s1TPS9hGJpHQzXT-sg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 6:39=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> > buffers and charge memory to per-protocol global counters pointed to by
> > sk->sk_proto->memory_allocated.
> >
> > When running under a non-root cgroup, this memory is also charged to th=
e
> > memcg as sock in memory.stat.
> >
> > Even when memory usage is controlled by memcg, sockets using such proto=
cols
> > are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
>
> IIUC the envisioned use case is that some cgroups feed from global
> resource and some from their own limit.
> It means the admin knows both:
>   a) how to configure individual cgroup,
>   b) how to configure global limit (for the rest).
> So why cannot they stick to a single model only?
>
> > This makes it difficult to accurately estimate and configure appropriat=
e
> > global limits, especially in multi-tenant environments.
> >
> > If all workloads were guaranteed to be controlled under memcg, the issu=
e
> > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> >
> > In reality, this assumption does not always hold, and a single workload
> > that opts out of memcg can consume memory up to the global limit,
> > becoming a noisy neighbour.
>
> That doesn't like a good idea to remove limits from possibly noisy
> units.
>
> > Let's decouple memcg from the global per-protocol memory accounting.
> >
> > This simplifies memcg configuration while keeping the global limits
> > within a reasonable range.
>
> I think this is a configuration issue only, i.e. instead of preserving
> the global limit because of _some_ memcgs, the configuration management
> could have a default memcg limit that is substituted to those memcgs so
> that there's no risk of runaways even in absence of global limit.

Doesn't that end up implementing another tcp_mem[] which now
enforce limits on uncontrolled cgroups (memory.max =3D=3D max) ?
Or it will simply end up with the system-wide OOM killer ?
