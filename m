Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17635A2C
	for <mptcp@lists.linux.dev>; Sat, 10 Sep 2022 04:22:39 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id i19so48892pgi.1
        for <mptcp@lists.linux.dev>; Fri, 09 Sep 2022 21:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UUwFUZL+VXUyKvjIIJY7AFHuyE9V4NyQjldWLp5LWlA=;
        b=OgQdiftI7LWz/ZPlDZCPNwWcf794Lvr244S+AQki5En6BWWqN+WkOhuM6ZhsZnWlvh
         lTXEFBVKM2pQGjtY0JLSvZylfybExbHMM5Zgpi25h0sEi6c+0/PN6NBzbr6exIr+UXJM
         Ju2ZhhF3ZZXL76Y+oWPOlsUUPKvkrn5pPs1MN1QIC3NofIJmQZSE860VzGY40HeO01vN
         OfWV9TShOrz3T55XWYKdVGzcph1iMpmVYmKQm+GuoKQAJaMzwTpfk852OA+6tO1pixlK
         bC4vUZ33EQJjp2XFL+QFPANoqKSBFNA2rbVPVtSyaJW/pRk8dkQepVCPjMgKE6sCaj5B
         9IRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UUwFUZL+VXUyKvjIIJY7AFHuyE9V4NyQjldWLp5LWlA=;
        b=huM3jp+lp/uK53IXXGVVWEwunB5gS3Ne6qHCfcDs6H0jDVyzaUmdRy2z598PCMWjk3
         DCTb+r1+zBHI5MhopMFF3Wt3isEdxBT9yKQPSZ2Ra0fVaibqoZF0eufAewVkenv/04Ss
         D4gETvZMmO5nBhuGEnj0XJLapPdQBB/ioC4AxjFtGvfloedGcayGGSRnw7zWOUM4VQW4
         t/qBe01c+TzM1z1YzPgLw7M8/MufEZ2OWpdleByaQ/ATW77Las4LLMgiquw3YPnFEj2y
         3CExbzj+DMz4T5jHKNF/3BiLbjJRr1g800AvDMLwjTugkLM/6fXBHi8Kg6U3so0rt7cg
         toCQ==
X-Gm-Message-State: ACgBeo3UBRlT0xyJDru2SR1THqALVhWYpPlxNRRSHLB+W7skz8fRp4mg
	VB4HSiif8rIQwBD5o1mwTM6uvDYXgoLbaGpMr4E=
X-Google-Smtp-Source: AA6agR4wa/bISViz/W8sZnfxZkh6OUlqCHwxiTVilG5WMZP6WOEFCuo3rLMTpMdyXexUTikvwlHSCLaBNNbvZyfd6vo=
X-Received: by 2002:a65:4202:0:b0:42b:d734:51e2 with SMTP id
 c2-20020a654202000000b0042bd73451e2mr14748834pgq.621.1662783759527; Fri, 09
 Sep 2022 21:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220909054932.246221-1-imagedong@tencent.com>
 <20220909054932.246221-3-imagedong@tencent.com> <f200db2b725c1d453d3cc68e4dbeb0883a5d9f4f.camel@redhat.com>
In-Reply-To: <f200db2b725c1d453d3cc68e4dbeb0883a5d9f4f.camel@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 10 Sep 2022 12:22:28 +0800
Message-ID: <CADxym3bZDwDC32f6qf4o1WDpDJ+Wvi=pZEob5dWzor54oYSokA@mail.gmail.com>
Subject: Re: [PATCH net v4 2/3] net: mptcp: move mptcp_cancel_work() to protocol.h
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>, 
	Jiang Biao <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 9, 2022 at 3:33 PM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Fri, 2022-09-09 at 13:49 +0800, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > mptcp_cancel_work() is simple enough and we can make it as inline and
> > move it to protocol.h. mptcp_cancel_work() will be used in subflow.c
> > in the next commit.
> >
> > Reviewed-by: Jiang Biao <benbjiang@tencent.com>
> > Reviewed-by: Mengen Sun <mengensun@tencent.com>
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> >  net/mptcp/protocol.c | 8 --------
> >  net/mptcp/protocol.h | 8 ++++++++
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 1cfb4f1ff4e4..d6eb033e93b9 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2656,14 +2656,6 @@ static void __mptcp_clear_xmit(struct sock *sk)
> >               dfrag_clear(sk, dfrag);
> >  }
> >
> > -static void mptcp_cancel_work(struct sock *sk)
>
> I think it's better to just drop the 'static' scope and the function
> declaration to the header.
>
> This is not critical/fast path, so it's better to keep the generated
> code smaller vs. possibly avoiding a function call due to inlining.
>

Okay!

> Thanks,
>
> Paolo
>
