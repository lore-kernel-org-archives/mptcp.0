Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074080;
	b=WrFp755tUijnoAPLShT1W1v/HYwqQUjXTnjiuL7PtgkRx/5Bvo9vjBwxHQRfVwLmQdK1
	 Sd1glL3Vk+AxmTYpG0vXWm3I56eoU4iPPkIvEyjCuegsAr5SEufJJJCXUpW2LOCNhwMxL
	 8w1DQb0YDRGrcPpJTh1AtFkBebEQRQmwalEhh5HmWBcAVfC2h6FZinUeSYKHOEhiHNK9y
	 gWZdvRvtUxPZtUnL8p+wQ9KiV33E9h424Bse9QNsp/bfc8LVHXIBFGZDT7uFb44XfuGiP
	 NoXoaR5ONTMB4nSYZuv8A0xTMrKRadwXu4PIVk7rl8zmwCM6OW1vpUmC29MPkew/qQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074080;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9KMh1Ol0YboSRROsqrznspqvAtHoutzOY/JAi2TItWk=;
	b=W291Agh9U8NschwsWEy0j4cu5cugxakFssKkkTkzjLJ6wWMyFp1rRORVIfOZpTM/tOus
	 3TB8+YPVceI0VJaHSmTh2fuA2lyNJI9h3NgBhj+1kQ25vh4GMN66Ea0jOEYyoWpvD7Ob3
	 jkQ4K1Wz0ha/Igm6hXKagmohqa4yI+iprMHBBWFGgrwyOUlze1gEA+0xbQlbqlCb94uTU
	 +/YRMyHe45hJ6jRIXrSJ+kat+O9iKjZbQds6rzup2MSTgBHw70Dz5wDQmPSZ/3B+EA/ib
	 L9ZxK9cDGUXDE0y1mB7Qzh9quDUnAUZaIrtokfQOXVLHHlFqh2TD4k2uPbmmYurZz4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3S4kQ61;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C696D606A324
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3S4kQ61
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA341F000D0
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 07:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795074080;
	bh=9KMh1Ol0YboSRROsqrznspqvAtHoutzOY/JAi2TItWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=c3S4kQ61lFvDdnbbhOwkim36Ctr5U7Uj6k7jddUUo1egsq+PO3qPhuuK2g/4ezR63
	 21ZcWvQ2bL+WlOTF0XDJZQrStnH9whgl3+C4yAzQT7SyedSkbqACzpC3Cqqj99Lm+Z
	 pGLALNfJnuqbY0m0vDandP2qBGzkKu2OHlzQOvyQk2Nst4MiYuZWmRmuN4foLOIxm9
	 9eTLpDx/BkiJvdtUjn6rGp3/AZv9WonbSaydmHRMMfF9KDNuALp54y62JM7oUKj32D
	 lYIqAFGQ5ieegLSEfxxiV4POk7/4eebE+FW0OCV1kAFT1+sf5qP2ra9bf1+8wN4duO
	 MiHLLobHsSW0w==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-71ac9e15640so1074806eaf.3
        for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 23:41:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHdc1PeHG2BbjzAz85/o4ICdCRqEz9/9ejrYhsC58PaJ3uue+iawcKesdONLf+dukyj942U8g==@lists.linux.dev
X-Gm-Message-State: APuU4Z+8HEmMZLNgRcoPExv+5Rt5SsmDo/4XQH3p70t3pkHxgsiuBn38
	NHIY5qQBsrfxu6KPmAQzv66j9xsuUGAvvsLbJq5PrKffqauY41xOKBXf9zlorviIXgfTG7IPziO
	lWpRoi1mH2XKS+MlMRb9kV6Icy1udKRA=
X-Received: by 2002:a05:6820:4dc3:b0:71a:f082:3c7c with SMTP id
 006d021491bc7-71b1855c67dmr4338379eaf.26.1795074079764; Wed, 18 Nov 2026
 23:41:19 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119071649.374106-1-kuniyu@google.com> <20261119071649.374106-5-kuniyu@google.com>
In-Reply-To: <20261119071649.374106-5-kuniyu@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 19 Nov 2026 08:41:07 +0100
X-Gmail-Original-Message-ID: <CAL4Wiir04_QoWU185Gjqw4EF--UK6LcENzL3F7=dj-G=6tLiVw@mail.gmail.com>
X-Gm-Features: AclHuK-pSNmwVtCkhv-wcdwk7_bs1Xkn1gEBke3ZV2tAB-_3Br5UwggZdXNHRk0
Message-ID: <CAL4Wiir04_QoWU185Gjqw4EF--UK6LcENzL3F7=dj-G=6tLiVw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 4/7] tcp: Skip collapsing if collapsed skb is less-dense.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 19 nov. 2026 =C3=A0 08:17, Kuniyuki Iwashima <kuniyu@google.com> a =
=C3=A9crit :
>
> Once tcp_collapse() finds a collapsible skb, it collapses
> consecutive bloated skbs.
>
> However, the end result could be the same or larger than
> as is in some cases:
>
>   1. skb is already minimum
>
>      If SKB_HEAD_ALIGN(len) <=3D SKB_SMALL_HEAD_CACHE_SIZE,
>      skb is allocated from skbuff_small_head, and skb->truesize
>      never changes.
>
>   2. SKB_HEAD_ALIGN() and kmalloc_size_roundup() in alloc_skb()
>
>      Assume two bloated skbs with len =3D 1448 B (truesize =3D
>      2304 B, scaling_ratio =3D 160) and len =3D 300 B (truesize =3D
>      896 B, scaling_ratio =3D 85), whose total truesize is
>      3200 B.
>
>      Collapsing them calls alloc_skb(1748), which rounds up
>      SKB_HEAD_ALIGN(1748) =3D 2112 B to 4096 B and allocates a
>      new skb with truesize =3D 4352 B (+1152 B!).
>
> Even worse, in case 1, such a skb is reallocated repeatedly
> by every tcp_collapse() in vain.
>
> Let's calculate the final collapsed truesize before collapsing
> skbs and skip the range if it does not shrink.
>
> We could allocate skbs first and calculate the new truesize,
> but given tcp_collapse() is called under memory pressure,
> we want to avoid unnecessary allocation.
>
> Note that kmalloc_reserve_size() uses __always_inline so that
> this change does not affect non-FDO builds, and returns 0 when
> skb_small_head_cache is used, similar to kmalloc_pfmemalloc().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
