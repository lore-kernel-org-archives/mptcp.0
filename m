Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104BC2CA6
	for <mptcp@lists.linux.dev>; Wed,  7 Sep 2022 08:59:40 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id j12so1511078pfi.11
        for <mptcp@lists.linux.dev>; Wed, 07 Sep 2022 01:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mKARXm2kMQBJjCoMq1zHo4f6Vijr8sVnvDkYWq/yY00=;
        b=JyzYTnj4Jo1BhJLatgnyH3qO4uNfq7eYWswaPviDRn6zx52TDlV0p+EXjU0/Fj0fBp
         M26YLiYs0SQDzb221bpFX45l30bIjt4i97wrGCR2gHdPUrD8HjxO/WD5gOTMiXWBPr7T
         NBnSINLZz7XpDL0XyMVuWoD7KEY7VEXdKvCxDr1ujie3p4uvgNV9GqLv1WrJ8RhQLxI7
         m8u8O860aneQz74CickxPrLWsfzQfLMHKWnxK9criXkbM7wRbOcYrTMHw+3sBXCaMpj0
         Emt57oBDZZAVyG0XMaXOk6CQHkTX5B8Y2LBvIV4TPOzahoTWXK168Pam0ZfLgG7E82be
         OztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mKARXm2kMQBJjCoMq1zHo4f6Vijr8sVnvDkYWq/yY00=;
        b=tVWi36WjpZvIKo1tUWu81e7+ooygp4QufX8ijxsK836GfyufChtSu+rQ1W/9H0Lm34
         upOoMuNfffgEtKLns1aaVQcdEMmLkyJWE15fLn79BnRXZZ9BpgXcGRnq90pdrLnNVY5u
         qNcTWeZNh7Hk8fI70Sy62shu7Tzjn4nMuRMYxU8wzJw2Wwmo73ug2LUNZKaZOaPNVtvM
         gR9LpA1ZMwiDCXGmL90Wfg5xcMgOs+Xm3iIAqxeiMRuYw9/ak5t9Lzu9A2vGV36n3IRm
         QtNGwz3z7QS8O/3F38Q4F7d3deyF3dOtCZv4bKOm4xr3JiKC/S/W0DuDmm1scWYSN4PP
         bqYQ==
X-Gm-Message-State: ACgBeo2NevyyLGp3C6lFR5pdeDm/CQoVPNJjVqR9FWJ8ZGBOZ4Fdrusv
	EknX7/wW9hLY3hE7mSKuSX3W+TOdePhN9FL0LxI=
X-Google-Smtp-Source: AA6agR7ugy96b6qwQ050Ysi1QiI6Gbohgqoj15UIwkoRiZqKNeVKVVYF3ex9FrK9aiSxRamzOtC48nmR7WaTNe2dVjM=
X-Received: by 2002:a05:6a00:1307:b0:53a:9663:1bd6 with SMTP id
 j7-20020a056a00130700b0053a96631bd6mr2779063pfu.55.1662541180552; Wed, 07 Sep
 2022 01:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220907083304.605526-1-imagedong@tencent.com> <873298fe-7fc2-4417-2852-5180f81f94aa@tessares.net>
In-Reply-To: <873298fe-7fc2-4417-2852-5180f81f94aa@tessares.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 7 Sep 2022 16:59:29 +0800
Message-ID: <CADxym3YQCjpVXs8EZr_B7iJDdbjOv53kqiqZqZmJ4fh3KUbzrg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: mptcp: fix unreleased socket in accept queue
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: pabeni@redhat.com, mathew.j.martineau@linux.intel.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, fw@strlen.de, 
	peter.krystad@linux.intel.com, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>, 
	Jiang Biao <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 7, 2022 at 4:51 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Menglong,
>
> On 07/09/2022 10:33, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > The mptcp socket and its subflow sockets in accept queue can't be
> > released after the process exit.
> >
> > While the release of a mptcp socket in listening state, the
> > corresponding tcp socket will be released too. Meanwhile, the tcp
> > socket in the unaccept queue will be released too. However, only init
> > subflow is in the unaccept queue, and the joined subflow is not in the
> > unaccept queue, which makes the joined subflow won't be released, and
> > therefore the corresponding unaccepted mptcp socket will not be released
> > to.
>
> Thank you for the patch!
>
> (...)
>
> > ---
> >  net/mptcp/protocol.c | 13 +++++++++----
> >  net/mptcp/subflow.c  | 33 ++++++++-------------------------
> >  2 files changed, 17 insertions(+), 29 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index d398f3810662..fe6b7fbb145c 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2796,13 +2796,12 @@ static void __mptcp_destroy_sock(struct sock *sk)
> >       sock_put(sk);
> >  }
> >
> > -static void mptcp_close(struct sock *sk, long timeout)
> > +void mptcp_close_nolock(struct sock *sk, long timeout)
>
> I didn't look at it into details but like the previous previous, I don't
> think this one compiles without errors: you define this (non static)
> function here in protocol.c but you don't "expose" it in protocol.h ...
> (see below)
>

Oops...I forgot to commit the protocol.h :)

> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index c7d49fb6e7bd..cebabf2bb222 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
>
> (...)
>
> > @@ -1765,11 +1740,19 @@ void mptcp_subflow_queue_clean(struct sock *listener_ssk)
> >               struct sock *sk = (struct sock *)msk;
> >               bool slow;
> >
> > +             sock_hold(sk);
> >               slow = lock_sock_fast_nested(sk);
> >               next = msk->dl_next;
> >               msk->first = NULL;
> >               msk->dl_next = NULL;
> > +
> > +             /* mptcp_close_nolock() will put a extra reference on sk,
> > +              * so we hold one here.
> > +              */
> > +             sock_hold(sk);
> > +             mptcp_close_nolock(sk, 0);
>
> ... I guess the compiler will complain if you try to use it here from
> subflow.c, no?
>

Hmm...The compiler didn't, as I modified protocol.h locally. That
's why I didn't find this mistake :)

> Also, did you have the opportunity to run the different MPTCP selftests
> with this patch?
>

Not yet. I'll do it before the next version.

Thanks!
Menglong Dong

> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
