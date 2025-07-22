Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBAE264625
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197879; cv=none; b=Gl33ao1y9yiJ4mkIQG6kTPaKsdYRkfcaWFCaj3Xz1XIrCYF+cjuFHKWld9JekcvVd5E2b+JYu24ScZufeVVmcyuive5RCmYZsykRUWZrE6WqsFDX4XaYP3+CR35wK4ORnPDz0FBGoPm5WQx2a6VhlIDOmxEkAPT7xT7/4a9YLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197879; c=relaxed/simple;
	bh=kV049ZvyH8bug7lCu3rLwoNDHgKCSKmx4BYFWbO1B34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLh2vIbGNu5j+nmINvLC6HrDbkAhBgvORyL1hNP4yY9HE/VUK/FroOo2rMqabPCkVDxQm/43NjyoKSiZgYnaInirk2CrhTzR450+ClLuI2xs+4ONg/iFx1X3+BrNFzheTQJfCQBQdEp7RWaqtLegiTSsgSxEFR0w7Bq4LXs+cTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRuGQSo8; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRuGQSo8"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab53fce526so80949011cf.2
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753197875; x=1753802675; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV049ZvyH8bug7lCu3rLwoNDHgKCSKmx4BYFWbO1B34=;
        b=HRuGQSo8HsF+n7DidTgBlQ6UUyMoV0BJpYFkT3UTKrsy0W15QLwVU6DcpIO3vykfM7
         pbhs3ftj+N3CwIwP/AmLHdAuzDnEJPW4FRSHZpBPKQ1dk59e3HoJPUn0vPAlne70zvtQ
         17Izc6VTvXBPJlNCvUZvyyaGTR8lRAMdG+CvjoPp4Jjl4SJnlL00VIMgAGW0cxA7ICYw
         KVeyQpFPZC6FzR1yW0ovPyava+y0tj2pHCJs1UoqDzcpMHWyTTyHB7W+5K3tb28vthEe
         t9nPr4U0AeOf1K0KehgHTTV//9i8iwiUDotfL8UNArwFinI/dbAqDApUWSGaZvpEbquX
         FCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197875; x=1753802675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kV049ZvyH8bug7lCu3rLwoNDHgKCSKmx4BYFWbO1B34=;
        b=OlO0ak6O/u10b+3Ullh5qwOuwONJit4G0mIs/3aFqrzjS3+4go5BG3Jnvik6S7/BGb
         avKJs0+98R7UIB9eCoDoh5vtHsrp+yeTC4AZuz3LIXBGVcs/YdHJkLfIta9fWVW1Co1Z
         5i4OR/Znr5T6FE5gZ7qb0iwxgvmT15xsbkXaiiwqr1l2DnB+RjPM+Ow9RNUeg8WiZFxn
         LF4MGzslF6RZ2msYeGYQCY14EJFrkSBMABlHmbsfN8SQk1qFvF4jO2zP2/hreYw7Zz7N
         nd7MNt8+xpPmraXao9WtJVHoNyRvTsTqfYFBesSLmW/tCYq/q/kJDTGWizeXDMOkBmyk
         j80A==
X-Forwarded-Encrypted: i=1; AJvYcCVgkneEbhg9p7NrtigV8exlA0Pmf+0v+1mbmnx6olcRFNMn9rJJrMZT7Q1aeS58WzWx9N57kQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwR18eSgH6TzCtUUsy/V+DGV6t7zcxA5Dj8Dx1RoHq90petOP9U
	U0Tp8yHEAdFPuBxOGKoB7TaaDC7HOrcwynZlqlW884Bz5J5rQCI8Pz7z8AYxYPg4Nv+q8rz8+RY
	yl3zLLmfgsaLodGGcPNUaQgThj5ioH/HyrBqbAo1n
X-Gm-Gg: ASbGnctYNjqGcKs1s3VArYyfeX+6MFVispaN7DPE+s9rAm0fXVXYz5Ynkc+KNDGxeQT
	FaFpDYHGJNXspN47f4l2/GIxiRRmoDS9mLUJDIdXf0c4fEsu3eoLNzuqe1al1J9yRshjemPR7Q6
	pUPBK8/4aMHPk1Gvi01P+h0GY6nv09idNkD1M3JfZWjFEDK9yI6TF3faqkvZKpzV6lhc/5dtzbz
	AhOVw==
X-Google-Smtp-Source: AGHT+IGNqove+d9nqBnprWFval+F465BdR48MaFKPBz3i7+j2sNb0kdf1AFXSoxhiABjI4x2NGpy1yAogO5YUQ5F9ng=
X-Received: by 2002:ac8:5a0e:0:b0:4ae:6b72:2ae9 with SMTP id
 d75a77b69052e-4ae6b724070mr1666271cf.43.1753197874316; Tue, 22 Jul 2025
 08:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
In-Reply-To: <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 08:24:23 -0700
X-Gm-Features: Ac12FXwavIrX7g0teLwhtLsjBkoK2NrttJzG5Br2HWJz_qCsAQMuVk1ahKeyT1Q
Message-ID: <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
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

On Tue, Jul 22, 2025 at 8:14=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima wrote:
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
> >
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
> >
>
> Sorry but the above is not reasonable. On a multi-tenant system no
> workload should be able to opt out of memcg accounting if isolation is
> needed. If a workload can opt out then there is no guarantee.

Deployment issue ?

In a multi-tenant system you can not suddenly force all workloads to
be TCP memcg charged. This has caused many OMG.

Also, the current situation of maintaining two limits (memcg one, plus
global tcp_memory_allocated) is very inefficient.

If we trust memcg, then why have an expensive safety belt ?

With this series, we can finally use one or the other limit. This
should have been done from day-0 really.

>
> In addition please avoid adding a per-memcg knob. Why not have system
> level setting for the decoupling. I would say start with a build time
> config setting or boot parameter then if really needed we can discuss if
> system level setting is needed which can be toggled at runtime though
> there might be challenges there.

Built time or boot parameter ? I fail to see how it can be more convenient.
