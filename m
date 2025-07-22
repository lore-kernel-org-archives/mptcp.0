Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2731B27817F
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198457; cv=none; b=PZOBrm3E6Rx1oJykRuowVZcY/JWh4fOkUUp+3pgtLG0sW5SlX7Cdr+niTQnJdKwA1oJ4vx22XaFMhZhQgSCE4IKEmeQDUHoChwWH7I9WH4ZABkgp4YDuUUBhkv4LTAa9yK3QPRcDZ5funMyvtbpyjfnlSLEVAD9FlkRKQ4qZ/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198457; c=relaxed/simple;
	bh=6huNDu8PBiF4Td2REk21Di2p4ZXL2OnE0DDZsCTZnFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSIA2hv4GE/lylNmR8mZesrUHclZK2mHGIFP5GSqbx5PupKG6kOo1NMmyW5JmM5+Ph1HOrJyAWZK585eEJKAX3LzzJ9sR4003sxOEGWi/EV6YtXtiaNWajngs+R1QvRudMgmxxIRE0cr2pkg4nQhngpuJ44xQk/CpAqqxHTDEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eW29gmQI; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eW29gmQI"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4aba1bc7f44so37401cf.0
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753198454; x=1753803254; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6huNDu8PBiF4Td2REk21Di2p4ZXL2OnE0DDZsCTZnFE=;
        b=eW29gmQIfou1/FkSvjslJpf0ftS3prE6xNcewHzYaj+U7mjS7ngdxD8q/AmlCsvdJN
         yETTe2LDrf/O1S4wtGnRZf/t5AoF1vPfKXwtRIpjCrbiUMbKYKDk34h0M6oMoWIzg2rH
         3rTvJqp1jpXjxtAPooYVdoBV5PKBWxUyqrzNmi8M0DVFxWwSjSrsmtqZ/WXupytwyTFS
         9wZm9uXmUCFq+FKfxrtyyy3kjm4TU8K8CBjBFxVS1fRaEwGd1U7wkrlYQl/xLOG0rMlQ
         63KtRM0hKKk7Yo6RGNaLVSbIN5RZCornoH9wmtCBdaitAfPcKImkiy+kPbm7DGAepKFN
         lN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753198454; x=1753803254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6huNDu8PBiF4Td2REk21Di2p4ZXL2OnE0DDZsCTZnFE=;
        b=XaXSFUTURO8mzsDDsy/xv6pkusWf7vHmJDFkLVk9ke9Yaf5uO7IA00TF3JPX81KlB4
         lbOLUzHVVDkdpp+O43xMxTus+9U5ze7MxsAumnQN5YL5xTvLQL7eQTDb6HEcfhgDdGT9
         MAAd9NFBjpx5DqGnCBEWMA7KUbc7iIZqOF90W8ycShE+YNRtWosbcYD5K7pEnN70IOwn
         DbRxee4YvpwZca/4OkJ6IqwuR7Dg0EcJCmld2OJfP9eLyPLuoa1FejUNahFtN58y+0Kl
         apJJYJYEuUFrVwI/zyUn5ViwZPL7A7d6lQC6klOYVLhwAAYdgHPriy0FkVqwaw+LS/Bm
         zXow==
X-Forwarded-Encrypted: i=1; AJvYcCUoCfKxgyXLvSprEQLOHlOBDAfljrTdRWmXw7NOL3tOgt2PSxvd8XslrPHkbPM2vD9C6IvQ6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDteMCysYP1DqQjEGI8FEhwIV0VnmO9YCQVY4ENWZNMbRlzzLr
	h3Tupz3o/Eiz+S1czCWAjtM4MnbK9plGj+emdfH5K6uDbirmNuJeKPZzzzkGJ1jjc/oJdKzcidy
	IqgxoPruyObKefOKRT6q1v5CsLUYw3ivhz2vNofsi
X-Gm-Gg: ASbGncuH03Bm5kqTuog2SHXWyPtqLp88bgsof0CPArsoCJNzCbYQqp++5i0JEknAbuy
	Kqq6xYYzv+PkCKJU2xEy5Brfnr9axWwy2cmYy7H7joLclPotXks74KrIM/UQ43lNxnICJffC9A2
	VWrs39Elztp5PsKc5EGsrEzlSZpDfpThUzmSnWP9SBEvSe1sFV64fkUbOno5rJdSnwQrzv4wKuf
	5LBkw==
X-Google-Smtp-Source: AGHT+IHT/XoMTVLR/CLnQtYrPx5F5saubWGu+acQeXgnXHryN0gYdGmeEzUDX46mVUnYlwqL4F5dGGyi/ToV0NINlD4=
X-Received: by 2002:a05:622a:549a:b0:4ab:c0d5:6f63 with SMTP id
 d75a77b69052e-4ae5b68cda6mr48360891cf.4.1753198453672; Tue, 22 Jul 2025
 08:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <vokpyz3p5pbv7ja4ltipxapq4xjemqmv26gayezeekcyq7llyq@6kahz7tldhfz>
In-Reply-To: <vokpyz3p5pbv7ja4ltipxapq4xjemqmv26gayezeekcyq7llyq@6kahz7tldhfz>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 08:34:02 -0700
X-Gm-Features: Ac12FXzA4jvGkBqd2_ryawomXPZvKp3tJLaT4sW3pMPuwr_h2pU1RQnRsS7pTbc
Message-ID: <CANn89iK0zqP0OYa4S=5-X4seUG6wAsK+-qGEpbpXQgSzNJQaog@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 00/13] net-memcg: Allow decoupling memcg from sk->sk_prot->memory_allocated.
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

On Tue, Jul 22, 2025 at 8:04=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Jul 21, 2025 at 08:35:19PM +0000, Kuniyuki Iwashima wrote:
> > Some protocols (e.g., TCP, UDP) has their own memory accounting for
> > socket buffers and charge memory to global per-protocol counters such
> > as /proc/net/ipv4/tcp_mem.
> >
> > When running under a non-root cgroup, this memory is also charged to
> > the memcg as sock in memory.stat.
> >
> > Sockets using such protocols are still subject to the global limits,
> > thus affected by a noisy neighbour outside cgroup.
> >
> > This makes it difficult to accurately estimate and configure appropriat=
e
> > global limits.
> >
> > If all workloads were guaranteed to be controlled under memcg, the issu=
e
> > can be worked around by setting tcp_mem[0~2] to UINT_MAX.
> >
> > However, this assumption does not always hold, and a single workload th=
at
> > opts out of memcg can consume memory up to the global limit, which is
> > problematic.
> >
> > This series introduces a new per-memcg know to allow decoupling memcg
> > from the global memory accounting, which simplifies the memcg
> > configuration while keeping the global limits within a reasonable range=
.
>
> Sorry, the above para is confusing. What is per-memcg know? Or maybe it
> is knob. Also please go a bit in more detail how decoupling helps the
> global limits within a reasonable range?

The intent is to no longer have to increase tcp_mem[0..2] just to
allow a big job to use 90 % of physical memory all for TCP sockets and
buffers.

Leave the linux default values. They have been considered reasonable
for decades.

They will only be used by applications not using memcg to limit TCP
memory usage.
