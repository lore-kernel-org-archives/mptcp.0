Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1443F4C0
	for <mptcp@lists.linux.dev>; Thu, 24 Sep 2026 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238405; cv=pass; b=fZOlOYG7BRGojUZM8j+2sWMZfVNT5v80VASsMSzYMIPpb+EHm14N1+EQ73cDKNdTYNzvJR6AU0MXVWfyaWK5sUqPooYYp/qigHjXrCLH7lfhRw9FraQSRp7fnHLB5qvhSdLlrZF3VDvV4GMh3UNkl9jQIZ/xqSiSsNto5SeYdX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238405; c=relaxed/simple;
	bh=svx/lXpxbyRvC5hg9Mf7leQZBgztlGdMd/1meLurTMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b87Ru1Ws/Wkp7iHulekoNBbc45w6G3Tc6/sOECLVx8E/jgGEOieWiXtqmFKDmp6KmOIQkdu+9EoImUA6oOPVIoRwIHo3EdWzBSiKhM3B7mVu4CZI8u6/H7vW6IhjOnyn+b1yQI5BozuSYSprl/wuHw4CzvGC1rCSfpDzQzSG6j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LqgHe0Mi; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqgHe0Mi"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb767cc71so15441491cf.1
        for <mptcp@lists.linux.dev>; Thu, 24 Sep 2026 01:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790238399; cv=none;
        d=google.com; s=arc-20260327;
        b=na0Bw3d2hCLRFGwu3kHqm5Rofqs4z7h3vEJD7lph83CCyEmY9iHIo1Qm3FmLPJr1nO
         D3QPwJo9SFyqa4L+/9JqV10imZxgtTTL4sCyjWBNWKZBguJ9wTi96tO33qLSJE3Yn7JW
         ASzFrAeMrQ9/WmaOY/mP674EsyPhtPt8Ryrgj6P+UDe66udgXGZxStm+FxP5kRsOWETD
         kz9bwl9Pf733nl+DS3qA0Ya8lplV4oiNKOzj/EMLMyIINuyELOWk48qaabum5Iw6rj6e
         UTWv7ogtg6zKpEBN307HIzOSiK+BPkF/CzLc4rQP5Lt6sUG7KSn6KFLCa2BJA3T/0z2O
         lmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Djx86NYnyz/9RFz/5fi7+M66lo0Fi/FSUEqHr4nGVIo=;
        fh=98pnUiNaYnBI8EdcWmIn7z4cFOeRVgNukuLZoTmsYwc=;
        b=kBiOmjRD/KOsqH9fQb7/kA5qh2SIQSwbpmaWN2rmdt2nP9RPfbp5lwEi7TIXnOjT55
         v9UZjWQj6WEaFOlI92AwWVi46oD5kGoBVFlXC11zzQ1SdRani6OeyIQWGVyCSQwSSulb
         bKHeAVyQUwE8pzCSoQem8meUmh6zZqq4XsVJm2WE/m4y7S46HlBayYt5xxTzXUd95BNi
         EnTTtOq/TgizPpq8a8lPt5beiqX+b14DYu0ayKuPXww6PNujIa/IdeHt0vb/cXv6bpVy
         +hmVh36tFQz0vhuVQ09bt0zXIjWiWBFxXJAhcJ6mly2HA0nEZ5fLl+9ZZ/r+5jsbxHga
         ALfw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790238399; x=1790843199; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Djx86NYnyz/9RFz/5fi7+M66lo0Fi/FSUEqHr4nGVIo=;
        b=LqgHe0Mif9Y/Tgor+96NeQhXJg2T+IJBAL30ArfcKRHRA5jBvfLl8zGefE01KWCqvn
         e9+gYQOmM3B3nr0Vx5aQppZAtAhFm4z2JjR9ydAflp7IPRJRohC9fquazwDyaYfTvPyH
         QaNRfQ0KBYE0sBJcDDisiS/9+5d82rBjLJngs1vB+/aBVpjuwQwp3lfjZbV3sjBXnTrB
         NfM5bG+hqBlynsrzm/RdqzdO3M2t1h1c8dtFtTylQKTtUPqQFa/kfuaS48Qtjs+ks4Mb
         95GmyB3LgLNj86948Bo3PABWiXH+BW+Y6DOmJnTgQWK+UvS2rVGJYniuQu1x0b8sUSeK
         992Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238399; x=1790843199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Djx86NYnyz/9RFz/5fi7+M66lo0Fi/FSUEqHr4nGVIo=;
        b=znEpJAoU/vTkR1wyv9c797/PQGoKNoVly4Y7+4KGJZraFxOdqSi05vUZhPJ2bznJtl
         obCMJjWM2VivC9I+2MgjQNhuNUVztGKzbYjB+NlkcyDRyLg+KUBX46RULfdR8i78n9zu
         4iVnRd5YBspPRJMSIn4DYgNalKR4XaF50pSSODyJLeEJejjzeySzRGe8Q0vfyjEI7Bks
         bJCjISKnATjPpetdLoeb9tGDfn05gooBKYHvF4VH1lEYVylrOEjVxhF7Ac+qNGMXLkkG
         +cJKs3zujfvI0C7Y03JlgaidYwIdGdilOWaSmAAcXVgG7kGp1mHRu2lLCrC6LvRWuipp
         ot4w==
X-Forwarded-Encrypted: i=1; AKwUvBwu1iyHeCR+Nir3tElSaPJG2k+V1xWMX7k+l16ruuOaTiN7ji6DUAdjhvnCTBFnYRbK18yowg==@lists.linux.dev
X-Gm-Message-State: AFuF++ni+YmbWVB956k1R7NMTBh7NJ8Hf6JZ0hZxTxMJIxMpvb13eFJn
	sBjbB0XcErNdxPWi0+M1Pw/MKtlal8Relr5lYp2F2sp15z85XnJ204DQwpyyzJnvSlHC3nfWyeS
	Pwdk3ZMQGij/D0TLS3zZwnELSK6yKNwdQUvg4QWph
X-Gm-Gg: AYBFou0Vd4Cudz0ijrIjuKSdWJ+OUTiQ5zgMNwX8yDusLJ5iM7VpF0OgHNfowZYTW4b
	gCO4MpyfEUYK6Rzyc7ZHgSHqSuT8w6RijyflQmmxt4sdk5c6AyBM37LRcjnlXFvDfLYN/0nJRA+
	L4lyYTOu/7veupc/NlaulvFR5wDUc2FYkx71T9kU8E2DlXC8JI+VPcDE4VDOyRIn/126hBC4dl1
	cxwpnKyeI+ihOu0sIe71kyRHV/2k9GawxHF8DpoWo7K07pwy9aos/0rrcCMpwkXQt2lfYCyg/RX
	AMSSzm1kGQftVH217qZqZ2dYrNEYOd7Ra0fRYNvw24Pwj7/pcNKWAqd6kN+hDQsEAy1DutdKamL
	ufPbDEXov1dWUyFumwwLlVpze+lLPoIJRJOcyclIAAomkN2SbpU648zPZjyHHGOXBppAc
X-Received: by 2002:a05:622a:4185:b0:532:d0ab:f3cb with SMTP id
 d75a77b69052e-532feb52734mr11578341cf.59.1790238398107; Thu, 24 Sep 2026
 01:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260924080219.1036588-1-caixinchen1@huawei.com>
In-Reply-To: <20260924080219.1036588-1-caixinchen1@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Sep 2026 10:26:25 +0200
X-Gm-Features: AclHuK9XSbyZhfSiccnO7XKdYo-g6nGD7WSG7r9j6ZGeEHZyUxcT2PFsdbnfwn4
Message-ID: <CANn89iJVGmYwQerOixGurH6vw-GtvSAQq6u6zSNZoyZrcEx6Jw@mail.gmail.com>
Subject: Re: [PATCH RFC -next 0/5] net: charge socket memory budget to memcg upfront
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, kuniyu@google.com, 
	pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org, 
	horms@kernel.org, ncardwell@google.com, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 9:36=E2=80=AFAM Cai Xinchen <caixinchen1@huawei.com=
> wrote:
>
> The memcg socket accounting currently charges pages to the memory
> cgroup per grant (__sk_mem_schedule() publishing forward allocation)
> and refunds them later from skb destructors.  The refund side folds
> per-skb "was this charged" snapshots back into the socket balance
> under concurrent lockless RMW, and races there can drive the memcg
> socket balance negative, ending with:
>
>     page_counter underflow
>     WARNING: ... mm/page_counter.c ... page_counter_cancel()
>
> This series flips the model: a socket is charged its whole memory
> budget (sk_sndbuf + sk_rcvbuf + sk_reserved_mem) to its memcg when the
> budget is established or grows, and refunded when the budget shrinks
> or the socket dies.  Grants and per-skb charge/uncharge stop touching
> the memcg entirely, so the racy refund pairing has no code left to go
> wrong: refunds can never exceed charges and the balance cannot
> underflow by construction.
>
> Tested: full arm64 build with 0 warnings; each intermediate state
> compiles (bisectable); tools/testing/selftests/cgroup builds clean.
> Runtime validation on the workload that used to trigger the underflow
> is pending.
>


Charging sk_sndbuf + sk_rcvbuf upfront to memory.current is not
viable, especially for servers handling large numbers of connections
(e.g. 1 million TCP sockets):

We specifically went in the exact opposite direction in commit
4890b686f408 ("net: keep sk->sk_forward_alloc as small as possible")
to make sure idle sockets hold zero forward-allocated memory and
non-idle sockets hold less than one page (4 KB) in sk_forward_alloc.


1. Massive phantom memory charges and false OOMs:
   With default sysctl_tcp_wmem[1] (16 KB) and sysctl_tcp_rmem[1]
   (128 KB), 1 million completely idle TCP sockets immediately charge
   144 GB to the cgroup's memory.current while holding 0 bytes of
   actual packet buffers.
   Worse, once TCP autotuning grows sk_rcvbuf / sk_sndbuf during a
   short burst (up to tcp_rmem[2] =3D 6 MB and tcp_wmem[2] =3D 4 MB by
   default), TCP does not shrink sk_rcvbuf or sk_sndbuf when the queues
   drain and the connection becomes idle again. 1 million long-lived,
   mostly-idle connections would permanently pin hundreds of GBs (up to
   several TBs) of non-existent memory in memory.current, forcing the
   memcg into constant reclaim thrashing of real page cache/anon pages
   and triggering premature memcg OOM kills.

2. Overcommitted caps vs. physical reservations:
   sk_sndbuf and sk_rcvbuf are per-socket upper bounds that are heavily
   overcommitted across sockets, not reservations (unlike SO_RESERVE_MEM).
   Comparing this to vm_committed_as is flawed: vm_committed_as tracks
   virtual address space overcommit globally and is never charged to
   memcg's memory.current for the exact same reason.

3. Broken memcg limit enforcement (memory.max bypass):
   __sk_mem_raise_allocated() drops mem_cgroup_sk_charge() completely,
   while sk_memcg_budget_sync() ignores charge failures ("the new budget
   is used uncharged"). When a cgroup reaches memory.max,
   sk_memcg_budget_sync() fails in sock_init_data_uid(), tcp_init_sock(),
   setsockopt(SO_SNDBUF/SO_RCVBUF), or autotuning, yet sk_sndbuf and
   sk_rcvbuf are still raised. Subsequent skb allocations in
   __sk_mem_schedule() will then allocate real physical memory without
   charging the memcg at all.

4. Unnecessary struct sock bloat and hot-path overhead:
   - Adds 8 bytes (sk_memcg_budget + sk_memcg_budget_lock) to struct sock
     (even when !CONFIG_MEMCG).
   - Acquires spin_lock_bh(&sk->sk_memcg_budget_lock) inside
     sk_mem_reclaim().
   - Every TCP socket creation charges rmem_default + wmem_default
     (416 KB) in sock_init_data_uid() and immediately uncharges 272 KB
     in tcp_init_sock().

If you are hitting a page_counter underflow race in socket memcg
accounting, please share the exact race / stack trace and fix the
underlying accounting bug rather than charging uncommitted buffer limits.
