Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D670280A51
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208334; cv=none; b=eGqZrinxUrs4Ce0g0hzrJIMkarlzATerawyCAGjQVu41v8xpSQdk2b51KLjdstWLcFIRsRZzY7zYDKTPSLn6SrKJ1TR2EuMtN3UBvGMsxzAHXylRY0moO7JbujHUddvu5e6MogsTMNbGGHRzNkMEnZNkC90Ld2LTPBO7HFojV8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208334; c=relaxed/simple;
	bh=wMPyc3xg/v1/2MZcFZfv3REvzTQgytthyXxvlrsEu5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoVQXjqkgl67R1nU1Ttgne4r0fQEJZWuBLbDBb0hanw0Ck1IwRuCFu9ssiZuEOGEdVkdEiVAmLedEPXus1lCYNkHraL+5NaR/3mqR/LUjaUeQTZuuqaIQK477SpVCzg2kD/9LwyWVmKKB6GCYqUN6/jR0jjNYJl7+Y4Lp6vvlh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GvGw60jV; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvGw60jV"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso4720613a12.3
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 11:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753208333; x=1753813133; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMYTSLLBkiKddq/FquIPU9bbzQYOdbjhg+lBLqMyOag=;
        b=GvGw60jVR05RsHPg3NHElBIUR+0+JTzq5vsB3GaPm4Sfuk53WiFxl1l4tWO5urj/Us
         fwTpuK2MlMLnhM3YGTCrwkkfzkxy/AIHxV719nyE8EEYrEEgCD/zPDW4q18IE91qnBVi
         IbmTxk+WxInpgGx36WJ/fBh6kEQwPMT+UKF+lo/hBtb8z1zc4fTJVz2ad0QqoxL79G5M
         jlj2FEMyk20iTrXYSYEIUdTXsut9J66wcNexd3ROMUsklJ9DcE4LmoPwSH0DGRrw7lSO
         mGN11lrOLg1L1x+58w7KWczQdEv0/7tPYqauxGkKP+DEl4ke2/uyGeuMRrt++BXuomMl
         aIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208333; x=1753813133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMYTSLLBkiKddq/FquIPU9bbzQYOdbjhg+lBLqMyOag=;
        b=GAhrMD57U6kfkZnblDTvEJgO3UMFs0KyKqDUZTPT51D/1ktsLw2ylbnQFWC/YGHv4s
         yOsdneFCl3N95HaAz6DfF2AgXUE5IDa/Um3Oy6T+khMncB3E4uM34ZpV+sMyLKncq2rJ
         C6B6aU8toTJsRR7SORP/iBjyBtT9eyZY7LIT5zK29szrBhQolXeBtKOP/LUc1DJrGGII
         gMWZNI6Xm1Nmb9k6x/jMOMoPMOCwO9HzoCiSqW5WftC56kUeTQr+W0EsE9Uj2eTrsfOp
         bs0jx103IdKFI1W6HKXHZtX8ZHYr8OCHcaSa46GE2l7kLJfHiDquIXvewKw8Vmv8NENo
         RomA==
X-Forwarded-Encrypted: i=1; AJvYcCVjeKvLNN09QMVcWVlaf6Y7lxYdfm12Bhf5rPWxbKJCT9MzkDTRp+PRXmFmkvpnQ135HI2N2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKRXrG4qbLZnvOfPAU7anlVfjKtQLZSSycM4QD/IuuSGs5UWnn
	ctBbcyqCw+kQ7EYSKA3JT22I/r21KYo+OIuodGFT/UdnzOM7vILqMeJ3YE4ZEucJaOq6W5VarDb
	7wV319Df5UxZkrpW9jk0Nx+PYBVOHF95IGlxzsjvF
X-Gm-Gg: ASbGnctGWvOzQgingqpfsjf/yeCBS8NO93aLU4yMq7kMHEwb1pfuHv8ytoPhyYB9oya
	slvRdeTkJZ4h3Vtnu2KrVdUSurwcjscX2YragUugdIdxgKMWkIDW+Ldr51DcTOuos9uEM1sPW/H
	0GOD6o+LNp2PvnhLTDMqa0MiPlg0XVwfuawu3Zgk6H/OtsvKYbir5Ccd3GR8ydWHDl1h9DrsYcu
	gJbZmkemFCpP1JFw3inannwlnxQljqfeIDbFw==
X-Google-Smtp-Source: AGHT+IElD1kikSWPb5qZUh/ZHziKPEue1huHVJC1qTZlxH2csGDvjAg3/+9RMCHo3B1QUGheaFDPmjpYlxgxHDS4A9I=
X-Received: by 2002:a17:90b:2f8b:b0:312:db8:dbd2 with SMTP id
 98e67ed59e1d1-31e507c49c4mr448802a91.19.1753208332393; Tue, 22 Jul 2025
 11:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
 <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com> <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
In-Reply-To: <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 11:18:40 -0700
X-Gm-Features: Ac12FXzC5_as3QVdk60aGP4lct3yePOviOeUXVs_xi0EDMGbnYX0I8xvyKuP3Lc
Message-ID: <CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com>
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

On Tue, Jul 22, 2025 at 8:52=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Jul 22, 2025 at 08:24:23AM -0700, Eric Dumazet wrote:
> > On Tue, Jul 22, 2025 at 8:14=E2=80=AFAM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima wrote:
> > > > Some protocols (e.g., TCP, UDP) implement memory accounting for soc=
ket
> > > > buffers and charge memory to per-protocol global counters pointed t=
o by
> > > > sk->sk_proto->memory_allocated.
> > > >
> > > > When running under a non-root cgroup, this memory is also charged t=
o the
> > > > memcg as sock in memory.stat.
> > > >
> > > > Even when memory usage is controlled by memcg, sockets using such p=
rotocols
> > > > are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_me=
m).
> > > >
> > > > This makes it difficult to accurately estimate and configure approp=
riate
> > > > global limits, especially in multi-tenant environments.
> > > >
> > > > If all workloads were guaranteed to be controlled under memcg, the =
issue
> > > > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> > > >
> > > > In reality, this assumption does not always hold, and a single work=
load
> > > > that opts out of memcg can consume memory up to the global limit,
> > > > becoming a noisy neighbour.
> > > >
> > >
> > > Sorry but the above is not reasonable. On a multi-tenant system no
> > > workload should be able to opt out of memcg accounting if isolation i=
s
> > > needed. If a workload can opt out then there is no guarantee.
> >
> > Deployment issue ?
> >
> > In a multi-tenant system you can not suddenly force all workloads to
> > be TCP memcg charged. This has caused many OMG.
>
> Let's discuss the above at the end.
>
> >
> > Also, the current situation of maintaining two limits (memcg one, plus
> > global tcp_memory_allocated) is very inefficient.
>
> Agree.
>
> >
> > If we trust memcg, then why have an expensive safety belt ?
> >
> > With this series, we can finally use one or the other limit. This
> > should have been done from day-0 really.
>
> Same, I agree.
>
> >
> > >
> > > In addition please avoid adding a per-memcg knob. Why not have system
> > > level setting for the decoupling. I would say start with a build time
> > > config setting or boot parameter then if really needed we can discuss=
 if
> > > system level setting is needed which can be toggled at runtime though
> > > there might be challenges there.
> >
> > Built time or boot parameter ? I fail to see how it can be more conveni=
ent.
>
> I think we agree on decoupling the global and memcg accounting of
> network memory. I am still not clear on the need of per-memcg knob. From
> the earlier comment, it seems like you want mix of jobs with memcg
> limited network memory accounting and with global network accounting
> running concurrently on a system. Is that correct?

Correct.


>
> I expect this state of jobs with different network accounting config
> running concurrently is temporary while the migrationg from one to other
> is happening. Please correct me if I am wrong.

We need to migrate workload gradually and the system-wide config
does not work at all.  AFAIU, there are already years of effort spent
on the migration but it's not yet completed at Google.  So, I don't think
the need is temporary.

>
> My main concern with the memcg knob is that it is permanent and it
> requires a hierarchical semantics. No need to add a permanent interface
> for a temporary need and I don't see a clear hierarchical semantic for
> this interface.

I don't see merits of having hierarchical semantics for this knob.
Regardless of this knob, hierarchical semantics is guaranteed
by other knobs.  I think such semantics for this knob just complicates
the code with no gain.


>
> I am wondering if alternative approches for per-workload settings are
> explore starting with BPF.
>
>
>
