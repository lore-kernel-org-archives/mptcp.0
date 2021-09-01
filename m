Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9BC3FC1
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 16:02:29 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id v26so3938436ybd.9
        for <mptcp@lists.linux.dev>; Wed, 01 Sep 2021 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0K3Oyq5eTmkdoN2xYNtCvvot7voY0qHtA/Ba90V0kts=;
        b=HjiiGKx103VY/SJhoVDzvuGUO+raoSLhUeJaASZftY6NXzdlXoRkXi3MImBbpnVgML
         JxiKhvCKwVniNSh+THyacwEE3b23wLiKY7bE9HNCnOS0XooBAEjrhyJw8nYIANVDvUR3
         OKP3uMPr/kVONQixycUYirMvycX2cOg8lgDh3r4p/R/7tIm2rxyZdiRTqOyg/ArnR2PA
         gFtvIk8teUELlNqja7STeXCBhsisCYVcH1qXEDek18GtIt187x8Lnpojlr6jiwq5/RJ2
         us3dQ+L3AkhpM8wjgDxqz9e+5g4PS0OR2LwfFXM1ZJBzkPvQ0rHYIn9Xy2+Jn6Mu6ijq
         l2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0K3Oyq5eTmkdoN2xYNtCvvot7voY0qHtA/Ba90V0kts=;
        b=e2h8p2b++68bSqH710FnMdkiCiTX2bkqKY1K+AyXvS7lHX6pEZr+AIQB0uip/td2Jv
         TEi4L/G5CJiF24whNTX5J+RERMt9XdAzcxB9vDBtsBm5FNNFap3zQhtO0d0y8yt7XVJH
         /9dacU6ydinaiUQZIRv0B8X8Qb9jCcMs7zlecfvCObzvuRYahJp9CF0wGtJJebBc61JE
         k6sw9McnNoupLlekCkPX86/d56YVlQ/Sml7LVqratqR5fMwoCQkYZ0oYcsc9LfeZ42rR
         zI1CjkU9qRlts4lGNyptz74gRqyR63kr5WE50Fbxtm/HSNq0nxHd+IDSU77l2NlotBsx
         +5Dg==
X-Gm-Message-State: AOAM532rdHhmQlx/PYHF/QsAWJFs4tSObNc5DV6mo0I1ddA7N52elicd
	QXzn3COJ7j0k+T0YrqDckC+gskTlyrzUvYJG1fOwnw==
X-Google-Smtp-Source: ABdhPJzKeORwXLC+ic8sTU3fSxHjhp9H+f/v8Ki8LzInVyMdQYglGhw9+1JThSy0dN1uo8r8jBQoxxMwMCeIeNozQdo=
X-Received: by 2002:a25:6994:: with SMTP id e142mr277447ybc.364.1630512147758;
 Wed, 01 Sep 2021 09:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1630492744-60396-1-git-send-email-linyunsheng@huawei.com>
 <9c9ef2228dfcb950b5c75382bd421c6169e547a0.camel@redhat.com>
 <CANn89iJFeM=DgcQpDbaE38uhxTEL6REMWPnVFt7Am7Nuf4wpMw@mail.gmail.com>
 <CANn89iKbgtb84Lb4UOxUCb_WGrfB6ZoD=bVH2O06-Mm6FBmwpg@mail.gmail.com>
 <c40a178110ee705b2be32272b9b3e512a40a4cae.camel@redhat.com> <59ad13bb312805bb1d183c5817d5f7b6fd6a90dd.camel@redhat.com>
In-Reply-To: <59ad13bb312805bb1d183c5817d5f7b6fd6a90dd.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Sep 2021 09:02:16 -0700
Message-ID: <CANn89iJ-Vx9V2_N6PRysNuK0W7TshMNo_crYtnEzrw=crF6OOg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add tcp_tx_skb_cache_key checking in sk_stream_alloc_skb()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>, netdev <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linuxarm@openeuler.org, 
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 1, 2021 at 9:01 AM Paolo Abeni <pabeni@redhat.com> wrote:
>

>
> I think the easiest way and the one with less code duplication will
> require accessing the tcp_mark_push() and skb_entail() helpers from the
> MPTCP code, making them not static and exposing them e.g. in net/tcp.h.
> Would that be acceptable or should I look for other options?
>

I think this is fine, really.
