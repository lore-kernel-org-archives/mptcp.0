Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB25F3FC1
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630512070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ELi0qf4aK3uP7dRRYETNlOTJbJ5D1N+KxdPfGPTw4A=;
	b=Jbkd5aCdwER7JjR8SXRvROSV0oNlZiJRzhbKZijHYIFE9vCNKUIb6PD521gcNGMNQLl3g4
	1liSShC/V4rcUl6VbSPGBZYyUSGrxS1NPvohX/y4PoYVRqU7LyKF+dnq6h1xkBqdWf1IhQ
	046Tu/yiCSVeTZHADaA/x6s4LnMJr7E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-7wu6AF0nMq-xBQyCda-YtA-1; Wed, 01 Sep 2021 12:01:07 -0400
X-MC-Unique: 7wu6AF0nMq-xBQyCda-YtA-1
Received: by mail-wm1-f69.google.com with SMTP id p5-20020a7bcc85000000b002e7563efc4cso6224wma.4
        for <mptcp@lists.linux.dev>; Wed, 01 Sep 2021 09:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0ELi0qf4aK3uP7dRRYETNlOTJbJ5D1N+KxdPfGPTw4A=;
        b=G7TanYM2aci/XDALhNqV9j+77Zy50bfbsDAZchZL+ORW44VxoFEHttLIlg4kDQZUTP
         iCq0V5ts45FLUDhAnP66ZA0UaDU1mgHofdCFI5qGherRlTcrY53GBnLIu0+lW22egkoB
         pUVTbpjGG7ay7TTWdKRmRnDb/xQzlNwm0o1CvifluhEl5jIziDfdPBF0YAuxT0wPDsb6
         ESIWzGJ3Ptn9eNEEpthH4ZGDS/fSOT91SYrdI76H/AO2WSWEARHXat3/lA7VguxKbHgt
         499eJkbVwYY/GB11b4j31JqwseqSQ99BR1hqzjTXNUQS4nnRkPKUnyJqhKECOer9h+dX
         kbiQ==
X-Gm-Message-State: AOAM5302wYFFPtAFGYMlLbFalEfUd+oq8CRPAwtN73RJo/xGlStmob+6
	ZOa5g5EJAMMucf9EUcpDpe39iLo6VL0E7URUIxqBMy57BMRXnX2lGb1Tj7M+6Fa3uiVhkuNETQo
	1fZP90NXs/P1uSOs=
X-Received: by 2002:a1c:3542:: with SMTP id c63mr148681wma.68.1630512065068;
        Wed, 01 Sep 2021 09:01:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz//bcO1LgzAECo7e8PoJZgBJq8fM+kTkmrO6ASs7HDmNmYuidKFDlOTnbPgfVTlShl2wHLA==
X-Received: by 2002:a1c:3542:: with SMTP id c63mr148631wma.68.1630512064673;
        Wed, 01 Sep 2021 09:01:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id d124sm847wmd.2.2021.09.01.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 09:01:04 -0700 (PDT)
Message-ID: <59ad13bb312805bb1d183c5817d5f7b6fd6a90dd.camel@redhat.com>
Subject: Re: [PATCH net-next] tcp: add tcp_tx_skb_cache_key checking in
 sk_stream_alloc_skb()
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, David Miller
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>, netdev <netdev@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>,  linuxarm@openeuler.org, Hideaki YOSHIFUJI
 <yoshfuji@linux-ipv6.org>, David Ahern <dsahern@kernel.org>
Date: Wed, 01 Sep 2021 18:01:03 +0200
In-Reply-To: <c40a178110ee705b2be32272b9b3e512a40a4cae.camel@redhat.com>
References: <1630492744-60396-1-git-send-email-linyunsheng@huawei.com>
	 <9c9ef2228dfcb950b5c75382bd421c6169e547a0.camel@redhat.com>
	 <CANn89iJFeM=DgcQpDbaE38uhxTEL6REMWPnVFt7Am7Nuf4wpMw@mail.gmail.com>
	 <CANn89iKbgtb84Lb4UOxUCb_WGrfB6ZoD=bVH2O06-Mm6FBmwpg@mail.gmail.com>
	 <c40a178110ee705b2be32272b9b3e512a40a4cae.camel@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2021-09-01 at 17:25 +0200, Paolo Abeni wrote:
> On Wed, 2021-09-01 at 08:16 -0700, Eric Dumazet wrote:
> > On Wed, Sep 1, 2021 at 8:06 AM Eric Dumazet <edumazet@google.com> wrote:
> > > On Wed, Sep 1, 2021 at 3:52 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > > > On Wed, 2021-09-01 at 18:39 +0800, Yunsheng Lin wrote:
> > > > > Since tcp_tx_skb_cache is disabled by default in:
> > > > > commit 0b7d7f6b2208 ("tcp: add tcp_tx_skb_cache sysctl")
> > > > > 
> > > > > Add tcp_tx_skb_cache_key checking in sk_stream_alloc_skb() to
> > > > > avoid possible branch-misses.
> > > > > 
> > > > > Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> > > > 
> > > > Note that MPTCP is currently exploiting sk->sk_tx_skb_cache. If we get
> > > > this patch goes in as-is, it will break mptcp.
> > > > 
> > > > One possible solution would be to let mptcp usage enable sk-
> > > > > sk_tx_skb_cache, but that has relevant side effects on plain TCP.
> > > > 
> > > > Another options would be re-work once again the mptcp xmit path to
> > > > avoid using sk->sk_tx_skb_cache.
> > > > 
> > > 
> > > Hmmm, I actually wrote a revert of this feature but forgot to submit
> > > it last year.
> > > 
> > > commit c36cfbd791f62c0f7c6b32132af59dfdbe6be21b (HEAD -> listener_scale4)
> > > Author: Eric Dumazet <edumazet@google.com>
> > > Date:   Wed May 20 06:38:38 2020 -0700
> > > 
> > >     tcp: remove sk_{tr}x_skb_cache
> > > 
> > >     This reverts the following patches :
> > > 
> > >     2e05fcae83c41eb2df10558338dc600dc783af47 ("tcp: fix compile error
> > > if !CONFIG_SYSCTL")
> > >     4f661542a40217713f2cee0bb6678fbb30d9d367 ("tcp: fix zerocopy and
> > > notsent_lowat issues")
> > >     472c2e07eef045145bc1493cc94a01c87140780a ("tcp: add one skb cache for tx")
> > >     8b27dae5a2e89a61c46c6dbc76c040c0e6d0ed4c ("tcp: add one skb cache for rx")
> > > 
> > >     Having a cache of one skb (in each direction) per TCP socket is fragile,
> > >     since it can cause a significant increase of memory needs,
> > >     and not good enough for high speed flows anyway where more than one skb
> > >     is needed.
> > > 
> > >     We want instead to add a generic infrastructure, with more flexible per-cpu
> > >     caches, for alien NUMA nodes.
> > > 
> > >     Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > 
> > > I will update this commit to also remove the part in MPTCP.
> > > 
> > > Let's remove this feature and replace it with something less costly.
> > 
> > Paolo, can you work on MPTP side, so that my revert can be then applied ?
> 
> You are way too fast, I was still replying to your previous email,
> asking if I could help :)
> 
> I'll a look ASAP. Please, allow for some latency: I'm way slower!

I think the easiest way and the one with less code duplication will
require accessing the tcp_mark_push() and skb_entail() helpers from the
MPTCP code, making them not static and exposing them e.g. in net/tcp.h.
Would that be acceptable or should I look for other options?

Thanks!

Paolo

