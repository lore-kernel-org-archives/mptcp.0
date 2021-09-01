Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A292FAF
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 15:07:05 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id c206so5651819ybb.12
        for <mptcp@lists.linux.dev>; Wed, 01 Sep 2021 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kAtBgHF0gcwAmOsoBYgbtR9s6UnHjuUv/WK3PPaU+Vk=;
        b=wOCETBUhws2xVptafq9Ls+XIFtkF/TtQ2NwqJrghoobiNV0wgCNZIl8Se6VuLJrvL2
         riPy9GCBMi6LH+XjVfa8cpbaQ3OgWKeLmmMGU0A4rYHYv6Kjrcs4/NraerKnYO4ZKm9+
         cm7zrI0NZDW0QS/NAzAgGoGubAqsnkISCCChMNg7hIGxqwwVCnsjD9FeSfbJ/i8wFGBH
         N0ygzBLZtV2Xp8udATxzWD9KsNVSQ0IiIwv1w2o/nbyAfOIjo1FRwyKRVaS2p7ERJE4+
         RikJiBpdE9JsxudSJQI+9PwcNvZOiRWZ7avjd6DieJYJzaSmwOUcn0Hph7gyWQSBhRQ6
         Sj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAtBgHF0gcwAmOsoBYgbtR9s6UnHjuUv/WK3PPaU+Vk=;
        b=ia8hG6sztLvLE0h8fcW7PnxpPnwdny/8nH7mcrIJ/elwt3gV0x/jNSWlrCXNyzzJ2Y
         wVmSEoASyiCNSIBxkKdnMMM8aE+ISiljGpERpxu5IJU2t+7xsSwHGzNPL2Cp/90T+lan
         mgI+MbEaaVma21QB/JpsU2tcV4+5lRXtsGGBLR/Hgam9LsUNBh8deOe0fNqYF8mglTMX
         4RXhhCiqP5GQlUsf/9vv4+fD1KcBownKLt++/kIdEzKb0y5CN8f1m7WKSGcCBrgT+0YX
         b3AcGEBIeOsuzfrpDW4H9HdZNGGG9DzhrswSoePlvISa9l1oJ0wXCT3Q3jqp+7l99Hg+
         5fYg==
X-Gm-Message-State: AOAM533jM6TLoKYSIScT3cII/MOKFLRmdsMcj0c6IaT3Z0LzEC7qJJkz
	2II6a9n2EnraoIYxv4kq2fWVxjK/7bJ53noL4F4sZw==
X-Google-Smtp-Source: ABdhPJw81YE1nSp7A2a5fybL82s8uxTBaubafVneXY32MJGi/egWWr7wMBfIA0/7dYRW7ZXq/Wuh0rwZ1wZ0693gKUo=
X-Received: by 2002:a25:444:: with SMTP id 65mr38851184ybe.520.1630508824013;
 Wed, 01 Sep 2021 08:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1630492744-60396-1-git-send-email-linyunsheng@huawei.com> <9c9ef2228dfcb950b5c75382bd421c6169e547a0.camel@redhat.com>
In-Reply-To: <9c9ef2228dfcb950b5c75382bd421c6169e547a0.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Sep 2021 08:06:52 -0700
Message-ID: <CANn89iJFeM=DgcQpDbaE38uhxTEL6REMWPnVFt7Am7Nuf4wpMw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add tcp_tx_skb_cache_key checking in sk_stream_alloc_skb()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>, netdev <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linuxarm@openeuler.org, 
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 1, 2021 at 3:52 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Wed, 2021-09-01 at 18:39 +0800, Yunsheng Lin wrote:
> > Since tcp_tx_skb_cache is disabled by default in:
> > commit 0b7d7f6b2208 ("tcp: add tcp_tx_skb_cache sysctl")
> >
> > Add tcp_tx_skb_cache_key checking in sk_stream_alloc_skb() to
> > avoid possible branch-misses.
> >
> > Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>
> Note that MPTCP is currently exploiting sk->sk_tx_skb_cache. If we get
> this patch goes in as-is, it will break mptcp.
>
> One possible solution would be to let mptcp usage enable sk-
> >sk_tx_skb_cache, but that has relevant side effects on plain TCP.
>
> Another options would be re-work once again the mptcp xmit path to
> avoid using sk->sk_tx_skb_cache.
>

Hmmm, I actually wrote a revert of this feature but forgot to submit
it last year.

commit c36cfbd791f62c0f7c6b32132af59dfdbe6be21b (HEAD -> listener_scale4)
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed May 20 06:38:38 2020 -0700

    tcp: remove sk_{tr}x_skb_cache

    This reverts the following patches :

    2e05fcae83c41eb2df10558338dc600dc783af47 ("tcp: fix compile error
if !CONFIG_SYSCTL")
    4f661542a40217713f2cee0bb6678fbb30d9d367 ("tcp: fix zerocopy and
notsent_lowat issues")
    472c2e07eef045145bc1493cc94a01c87140780a ("tcp: add one skb cache for tx")
    8b27dae5a2e89a61c46c6dbc76c040c0e6d0ed4c ("tcp: add one skb cache for rx")

    Having a cache of one skb (in each direction) per TCP socket is fragile,
    since it can cause a significant increase of memory needs,
    and not good enough for high speed flows anyway where more than one skb
    is needed.

    We want instead to add a generic infrastructure, with more flexible per-cpu
    caches, for alien NUMA nodes.

    Signed-off-by: Eric Dumazet <edumazet@google.com>

I will update this commit to also remove the part in MPTCP.

Let's remove this feature and replace it with something less costly.
