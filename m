Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8A21C0DD1
	for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165300; cv=none; b=YFsosj820ju2LXI8ZqH+5pP59W6p/IYD5TLVswR0QfCJmDUE+nbDH/l0QElestOHfxGV2ni+Iug6B94I5jeF3yQ4pHyXs8fwWngUPvwmGxrgWg2cJmLs6QRqGL2vw4I+cmGVhbXvl/W1WJU9brjJh5c495GbbOuiXz5hZFHbKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165300; c=relaxed/simple;
	bh=p/gq/CW9SsZCWw/rFyaYSuBTd6L5vMoAbxTuysSTuuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRZrmrttbKgUw9wiNaQ82UfSl5sFU/5U15LHPgmKWqI6Fig8br6Ee+lFhppw8fCl5jpF+nu8ldiglaflE3SHrvN7JgVo0idnaWzkFC+bKJuDE99YdIsVTEBuLBpenVApYMwpiT59aJfTLQoN3HahlXiMlOndBN+J6Irgj1MEOgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMo5v32J; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMo5v32J"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4581cec6079so40031cf.0
        for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726165298; x=1726770098; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppRney/4jGQpW6a37DhJ8+kAp0WczyW6xnrNGRl/XJw=;
        b=fMo5v32Jy9w4YlYf6m0Bsu35UgZqK+5HjdKQIhTh/8/6dRMbVtieFesqrOVjRa6GPn
         oTxQg+oWe/OheHJmIpdY6hQR49OPhDnpK3+dkvSkcQZaFR0X0zxlFDxh3TWtaG0mI0fS
         GlKcjtS5g18VemHrxA/AKuvwjLyJIwEw0IgpjEeAPmr/dhoMzkXBhj9GOynY5w6L7HnE
         AI5YbuKXLpzY9oPHnFGjRVa33wkDBMdEWFmIdw03lhHFuWdLFkIvTdDXKLfsFj3QkLXX
         JEseiC/nboykju81VGapEwIpYyuiY8O28TjZdJJJP6wL73j0YRptXdCbjUEaOi2DHhq3
         4KQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726165298; x=1726770098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppRney/4jGQpW6a37DhJ8+kAp0WczyW6xnrNGRl/XJw=;
        b=MnDWie9zffszt43C6eRKNicAeGakvPAUwSp6h84z16ZLdQdoRT1nsAlamBW89SgNR2
         7DnFZ38TWknpTYItKMpzIZejDEGq0h7TPbNfsfHqEXizi367Nlf3mRyRR9TNrRsjeb5i
         2ur/EF84oz/mfYOHP9ObmrlEvE1QqjdLJkSY7vOoTG/GHkwDVfjrZ8TlXQ+i/KR7ie1E
         IjcDyvcStEs47cv39hT0qVcudAOOYDBoRAsAHnYz7EFYBLHrMM4IfkvWLejW3BGn0E0b
         +b+/KRB/MDD4fLwTM4pQCOT/cUPKNEyCkTQUWxIA61vdS3qfcCAp/YMX7aY1zmmSg/e2
         cHCw==
X-Gm-Message-State: AOJu0YwmnLkqFGWYNvt5OeXHI4OKzXn8Um6nr4YD0S4UxWRzaoHcFlW2
	+ez8EgSnFyQ3kk2WFYHM4tNaGwufjQNZLVXyhDMYMsM7oMDuHUbnzsrlUtMDj7hNF++5BJh3/Gh
	cvU1dgBsRyJ3JJQDh+Iqm4CcX/6Lmibjiim5p
X-Google-Smtp-Source: AGHT+IEiDUGqxZVfqgS2lhZx6D//y9/VnB7axc7qguCSr867pXQTVePOCTRxp3C6vdlwPdINoIgDAIvmR9uxhpniHM4=
X-Received: by 2002:a05:622a:24f:b0:456:7d9f:2af8 with SMTP id
 d75a77b69052e-458645121e9mr3751071cf.7.1726165297692; Thu, 12 Sep 2024
 11:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240912-net-next-fix-get_netdev_rx_queue_index-v1-1-d73a1436be8c@kernel.org>
 <CAHS8izOkpnLM_Uev79skrmdQjdOGwy_oYWV7xb3hNpSb=yYZ6g@mail.gmail.com> <73a104e0-d73f-4836-92fd-4bef415900d4@kernel.org>
In-Reply-To: <73a104e0-d73f-4836-92fd-4bef415900d4@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Sep 2024 11:21:23 -0700
Message-ID: <CAHS8izMEzug_c+LYG3=tPq6ARQjsXQqCwkO+t0hPpWiivxTB1A@mail.gmail.com>
Subject: Re: [PATCH net-next] memory-provider: fix compilation issue without SYSFS
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 8:26=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Mina,
>
> Thank you for your reply!
>
> On 12/09/2024 14:49, Mina Almasry wrote:
> > On Thu, Sep 12, 2024 at 3:25=E2=80=AFAM Matthieu Baerts (NGI0)
> > <matttbe@kernel.org> wrote:
> >>
> >> When CONFIG_SYSFS is not set, the kernel fails to compile:
> >>
> >>      net/core/page_pool_user.c:368:45: error: implicit declaration of =
function 'get_netdev_rx_queue_index' [-Werror=3Dimplicit-function-declarati=
on]
> >>       368 |                 if (pool->slow.queue_idx =3D=3D get_netdev=
_rx_queue_index(rxq)) {
> >>           |                                             ^~~~~~~~~~~~~~=
~~~~~~~~~~~
> >>
> >> When CONFIG_SYSFS is not set, get_netdev_rx_queue_index() is not defin=
ed
> >> as well. In this case, page_pool_check_memory_provider() cannot check
> >> the memory provider, and a success answer can be returned instead.
> >>
> >
> > Thanks Matthieu, and sorry about that.
> >
> > I have reproduced the build error and the fix resolves it. But...
> >
> >> Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> ---
> >>  net/core/page_pool_user.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> >> index 48335766c1bf..a98c0a76b33f 100644
> >> --- a/net/core/page_pool_user.c
> >> +++ b/net/core/page_pool_user.c
> >> @@ -353,6 +353,7 @@ void page_pool_unlist(struct page_pool *pool)
> >>  int page_pool_check_memory_provider(struct net_device *dev,
> >>                                     struct netdev_rx_queue *rxq)
> >>  {
> >> +#ifdef CONFIG_SYSFS
> >>         struct net_devmem_dmabuf_binding *binding =3D rxq->mp_params.m=
p_priv;
> >>         struct page_pool *pool;
> >>         struct hlist_node *n;
> >> @@ -372,6 +373,9 @@ int page_pool_check_memory_provider(struct net_dev=
ice *dev,
> >>         }
> >>         mutex_unlock(&page_pools_lock);
> >>         return -ENODATA;
> >> +#else
> >> +       return 0;
> >
> > ...we can't assume success when we cannot check the memory provider.
> > The memory provider check is somewhat critical; we rely on it to
> > detect that the driver does not support memory providers or is not
> > doing the right thing, and report that to the user. I don't think we
> > can silently disable the check when the CONFIG_SYSFS is disabled.
> > Please return -ENODATA or some other error here.
>
> I initially returned 0 to have the same behaviour as when
> CONFIG_PAGE_POOL is not defined. But thanks to your explanations, I
> understand it seems better to return -ENODATA here. Or another errno, to
> let the userspace understanding there is a different error? I can send a
> v2 after the 24h rate-limit period if you are OK with that.
>

Yes, -EOPNOTSUPP would be my preference here. I think it makes sense,
we should not support memory-providers on configs where core can't
verify that the driver did the right thing.

[...]

> > However, I'm looking at the definition of get_netdev_rx_queue_index()
> > and at first glance I don't see anything there that is actually
> > dependent on CONFIG_SYSFS. Can we do this instead? I have build-tested
> > it and it resolves the build issue as well:
> >
> > ```
> > diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queu=
e.h
> > index ac34f5fb4f71..596836abf7bf 100644
> > --- a/include/net/netdev_rx_queue.h
> > +++ b/include/net/netdev_rx_queue.h
> > @@ -45,7 +45,6 @@ __netif_get_rx_queue(struct net_device *dev, unsigned=
 int rxq)
> >         return dev->_rx + rxq;
> >  }
> >
> > -#ifdef CONFIG_SYSFS
> >  static inline unsigned int
> >  get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
> >  {
> > @@ -55,7 +54,6 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *que=
ue)
> >         BUG_ON(index >=3D dev->num_rx_queues);
> >         return index;
> >  }
> > -#endif
> >  ```
>
> I briefly looked at taking this path when I saw what this helper was
> doing, but then I saw all operations related to the received queues were
> enabled only when CONFIG_SYSFS is set, see commit a953be53ce40
> ("net-sysfs: add support for device-specific rx queue sysfs
> attributes"). I understood from that it is better not to look at
> dev->_rx or dev->num_rx_queues when CONFIG_SYSFS is not set. I'm not
> very familiar to that part of the code, but it feels like removing this
> #ifdef might be similar to the "return 0" I suggested: silently
> disabling the check, no?
>
> I *think* it might be clearer to return an error when SYSFS is not set.
>

FWIW it looks like commit e817f85652c1 ("xdp: generic XDP handling of
xdp_rxq_info") reverted almost all the CONFIG_SYSFS checks set by
commit a953be53ce40 ("net-sysfs: add support for device-specific rx
queue sysfs attributes"), at least from a quick look.

But I understand your CI is probably very annoyed by the build
failure. I would be happy to reviewed-by a patch with just the change
to the error return value, and I can look into making this work with
CONFIG_SYSFS after the merge window.


--=20
Thanks,
Mina
