Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794207198;
	b=GdP545qt6dkDaVq2H15wZSDsMMQo4/L3J3kUS13ihDILkvooMrPDLPiY/ekdDy5PRpm/
	 wj7BWY4i8i076xjJrHdLV1KnLLxNkOQgVmdFrG7MszolRFBAz/s8OX9GIoZuDlIo6+VPe
	 Vv354tiF+EzY0uYxRkkf5OTHradeR4vOHXv/O8YnCgKOjsTvwmlUE6elFMsjyEX96hmeJ
	 CPRknTO3zQM5gJGYN4OxwEZeKqjg0Ke8gD/vrc9CN7IqpjPcpI/FB3Mq5j8ctr0SqqxCp
	 ynecPL1J0BqMD9JGIvnx0IMzpMt+9jsmEPispVI9ZCZXKfYojbCedALc2n5gTiARkpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
	b=WeUi4hXGC39ULHaqc6ddNEGAakQ6D9JihuatpT4x27m17bfMqQAOYi1jZtarFEA+p5SS
	 VcOaT0OxwLL0wTsnzBjGNECaJrXHiW6YOXdG8uY6Iw+igIQuLPFu0QF7xSTkAUHpiTb03
	 ikl9Xn36d8BgYlqNBVcINvbMgACISMDmzt8uGZDhaWp2Ohh6ExjlxORbwW3E/wYXDWhlT
	 XP2oLJatG4mz3osBEYQAdIYulpvm0KMkf9ZLQaqoT3iqiiG7Tw9DGaSbO62WRLn8M15/o
	 HmmRPcIj1ZiDa6qHcuB5degoITU1J0yr9x2Ad9tuNI8XFjFtR9Wb4s2MtrU/rrSCbVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jwZsm69V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581A4606A326
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 06:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 581A4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jwZsm69V
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5c1465bbbdaso302613e87.3
        for <mptcp@lists.linux.dev>; Sun, 08 Nov 2026 22:53:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794207196; cv=none;
        d=google.com; s=arc-20260327;
        b=L+M3fZAOdG8REQkst0/8ca9V+EQjB44EYjHJRV4jjCgnk0+zgDOIILY1Ryag4uZPB2
         1ekshFBicn04aeq/WGllXG1g7/h8sUsjUzrQbXOO1PaMaMUYrri3nym1s7DvvrdojOIe
         dBPVO/mLjUh4IsOV9lA7wqfhDNbCqWEIYmVF+cMwjH+zuugm0tvuITMnmLEzfzPdnTd1
         D16DSrSxx7XD68YAVmuW159eJXKuEJqh4zELfoL8WMPd5oduVOnpD+b4kHg+TX2YLGTO
         GddtK9zdNpPv0BrAwzX4EfjoxwxpIfoQzqJmQXr9Gri6CqWaILCyux/rXAuLvyYo8rP2
         JqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
        fh=3Tb/E96pV0TvYIyN3X7xis3lUIiY6X1u0kXfjofqWOI=;
        b=Zi9nZ90mgRu04kTH89QBsUftjFBv9xKDNcpx2+PUKUJENc2ZQlcLT7eR1N2Taj8C8u
         myoeADtkEoNOn9vvEfpxZfi2sA1I1TOw+aZaf0mUPmMU57Eds8ycd4g/5wlID8DO242m
         WPXJe/evrFM5PC25UHzbFTT7G2AUOK4Yr0lvHy+xckHMDv+eCP47OAMwNdaNwHcnsKR1
         SG0CvbXptjqsYWsp8QpfOc2O6Aq1bFmvDdacLXQl4AQtq8IA4Joui4GIB6RCvoOKOYQ8
         d6xiGgyVRFOM/NIsOx6zsn3FWI8WObIOAbE11vognujl+2DwUFBOVDdL6xyz3yR8W8Ju
         PYLQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794207196; x=1794811996; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
        b=jwZsm69Vie8MWjnuOP9ZiOX3kkiqsYcSbCNUpGAbUt3MobsPki0/qYyqUv2vDyeCmf
         om/XCSsQKxOvsUsvO7YGdc1H9PQgWLTJoVj7LlnNJjy+JKvsgl+XWkHVfvSnLUKYXmvL
         lAKoEpJHTo/qFvLJMw8aGQaktRw+R9OsS2yE06PhEaM8rAaQLVPwq3Xe4jvXvA0xan/6
         rqya2ldQgPl24h6Jx3Wod45vNZNMxXifqq2n4Sxcu9S9oFZnbogLt9Og60NpCpzHd2UU
         MNoWCNSUgTLnOy3KIdZMiBkV5R2z5S+cIKPvE8Y/hCw393QAIs1K7JzuPFupC0cTwQO3
         w5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794207196; x=1794811996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
        b=h8yIjmmsTkaeYTBnaZyQZ0SR0Gnqqf/JJY+9haphMcBrer6fpbH3sQ9Yh50vr3HdR/
         BVLrJtt99jXW6HEtWMBtaftEnYRe21LC8VXoLkWgAjxhnIxLeT74D9gf1aZvYp6WEcUN
         gpSyXNXdpIDuTJYELO6+ZKKWasQ0QJhE1PND4x1wdTqqotuMCrVcYqTcTQyOkv5XdSnM
         2pL77SQnmkal2p0si+NuOghinDaHI18ln0IaiGH7xqMPc71zAkFV9OKMzmZbNyxY/XZp
         oPgvVbmzOS8o66ivS/DleNxfFsQjyoyWvluEAToNTp4QX9K1mr21P+yepClyoU+GNEGr
         SLTg==
X-Forwarded-Encrypted: i=1; AL+hErH9wB5RC7gWnZ3FAeTLVaSygBDqwPRC4GItZA7Yc3d6Mfy32/a9fMv6apCVi4ItEKXuDez7xg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9hOh7ZmQxrV6h3VkfSihdec5TfstUT191tJ5wnm/czXGNTBoD2
	1w6FeIffiEyGYTR+bqEgf74yikCOQHA5VabCQJSt7XzSH1PGxRkqQvpyQ7j/DRs+J2M3YGfjJ7B
	p93AjMWIDCh8e3R/MgD/fXlPgt7O+/3s=
X-Gm-Gg: AYBFou04dNXjagNyasPdlUdEoMxs8vIxsHTpkvXL6tJBO9TOIJd/utciHG6f2+qswYG
	R01O3MTCIJnj4lXkiLfVnbgo45UM+uYceypUIF9iFy9dkM4qmuFszPD+k5MhjdufOZjMGStRXvB
	L8/toG7w9KGGgvMoezIy6qZWPKzHogZy0lAWSmNaG+yIDlF6R91xAk/hycYKdVdInv3zIA1Pf8j
	Fm/Yr8Lrww1WCsIEMImzy33pBMJ8LB3zYGPw+v2cgivOJRTf4eRLPqFc7pDtWXMqY3h3eySeOyN
	vdqu4IzWVzzsFWQcVyFPCIGYHeojWCcznS5WFuxMfno8+xsjvP/vD1XrovRJat2SQu8HJ1PUTOP
	mYe5Z4osUSdFdHV+AL5H4vBXtwpWlW1fBCLArw7iNFndNiIEkf95ZH51kbG0esJnbi7MzGknJ5F
	8iBnaXjR4eeVTyuRDvkOHDM2l5NLfeUbBeLL62ajUIzabQc8+z5RI=
X-Received: by 2002:a05:6512:3e1c:b0:5c1:4a48:c2db with SMTP id
 2adb3069b0e04-5c14c01f805mr810751e87.43.1794207196170; Sun, 08 Nov 2026
 22:53:16 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261109025425.328445-1-jiayuan.chen@linux.dev>
 <CAL+tcoDvFNAZubOjw9+Z1eyaVeiBzt_Xg3KMNucY879bg-ZLow@mail.gmail.com> <dbdb9385-89cd-4e4f-bfb8-b72510e8801b@linux.dev>
In-Reply-To: <dbdb9385-89cd-4e4f-bfb8-b72510e8801b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 9 Nov 2026 14:52:37 +0800
X-Gm-Features: AclHuK9hO_h4FFhel_M7AacjBweA615sygy6vgIfEMNG5ukVHhzyCYoysXzMOxw
Message-ID: <CAL+tcoA6_gROiprd7YgxvwbaiuzEUPfuWTNMjKu6vDkbUJ5KPw@mail.gmail.com>
Subject: Re: [PATCH net-next 00/14] net: annotate data-races around sysctl knobs
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, Nikolay Aleksandrov <razor@blackwall.org>, Paul Moore <paul@paul-moore.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Julian Anastasov <ja@ssi.bg>, Allison Henderson <achender@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bridge@lists.linux.dev, 
	linux-security-module@vger.kernel.org, mptcp@lists.linux.dev, 
	lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 11:33=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 11/9/26 11:11 AM, Jason Xing wrote:
> > On Mon, Nov 9, 2026 at 10:55=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linu=
x.dev> wrote:
> >> While testing the recent sysctl range fixes I noticed that a lot of ou=
r
> >> sysctl knobs are read with plain loads while the handlers update them
> >> with WRITE_ONCE() and no lock, so KCSAN reports them as data races. I
> >> then used an LLM to go through every ctl_table under net/ and list the
> >> readers that were left behind. This series annotates them with
> >> READ_ONCE(), and adds WRITE_ONCE() to a few custom handlers and netlin=
k
> >> paths that store to the same fields with plain writes. Most of it is a
> >> plain READ_ONCE() at each read; where a function reads the same knob
> >> twice to make one decision, it now reads it once into a local, so the
> >> comparison and the value it acts on cannot come from two different
> >> writes.
> >>
> >> There are no Fixes tags. Done one knob per patch this would be well ov=
er
> >> a hundred commits, so I grouped them by subsystem and feature instead =
to
> >> keep the review manageable. If maintainers prefer, I can split it up
> >> further with a Fixes tag on each one, as several smaller series.
> > Over the last year, I've been thinking about the annotation stuff
> > especially around sysctls, which, I suppose, shouldn't actually affect
> > the real workload but does affect the outcome of the syzbot.
> >
> > Out of sheer curiosity, my question would be what is the point of
> > trying to change all of them? Or what kind of benefits can we get from
> > the big series?
>
>
> Three things:
>
> 1. A plain load may be emitted twice by the compiler. ip_error() compares
> peer->rate_tokens against ip_rt_error_cost and then subtracts it again;
> if the sysctl changes in between, the u32 wraps. A few readers have that
> shape and now read the knob once into a local.
>
> 2. Tearing is not involved here, all the fields are at most word sized.
>
> 3. The rest is the memory model: a lockless read of a field written with
> WRITE_ONCE() is a data race unless it is marked
> (tools/memory-model/Documentation/access-marking.txt). That is what KCSAN
> reports, and why most of the series is plain READ_ONCE().
>
>
> I think the benefit is doing it in one pass.
>
>

I was curious about the REAL impact. If this thing really matters, we
have a lot of work to do even not only in the networking subsystem.
Sorry, I still think none of those points are convincing enough, but
that doesn't mean I object to this series. Anyway, it's just my
2-cents.

Thanks,
Jason
