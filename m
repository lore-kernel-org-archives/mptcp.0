Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64DAA2C
	for <mptcp@lists.linux.dev>; Sat, 10 Sep 2022 04:22:14 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id l65so3448140pfl.8
        for <mptcp@lists.linux.dev>; Fri, 09 Sep 2022 21:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8Nmhv0k23ytQxg6l4ld7N7wkJt08RaB9CsGELSG+3jA=;
        b=c4VsnmtAnBhaaUChRmwuXTlaOI3XSojTaPj05TIbHELFcfMMQgEZa8WB7SNIiAKpQ0
         OrEruuv9lTAeW4Hgyt8ctbHZjDF5fC30U++HjpIjgheqQjTlBAOyQwt3SFtp2RKVuBr/
         BWaU9naBmryzoCxLLrLw/P1JvT3938Gd8EmbEK9rUd8f9Y/G/1rve04ePjUe/fJvzlDb
         II5cFmKtWfD+MoHDW8znErjy6tLA2qAZ+4c9tXkE4O8gtyrJvazdlf7hWEzso/3RyigV
         NCWuXWMmiBGcs3MH5QSt7AyQArcJECXVWoa7M0LetUgc3KY0iMhFFljmxQEHJINxrMmR
         LjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8Nmhv0k23ytQxg6l4ld7N7wkJt08RaB9CsGELSG+3jA=;
        b=jg8LuE4JLMcthsGEPktwDbV9SIZ3laFx3GyOyap4D/rlZGRfLOg1ahQ7Ll6FpEFlAs
         aA9GcEx7umEM1MCsvPltC5ZV9u35626hXrTUrzHrRsBfZjWOvJ4NLQR65RbajSjkutNz
         GkFH0FWSkepQv7SC4cp0Tt2AsxULtb6h5coIOoVri1S40VEE2nAgg5x1j6I06AFCW0P/
         GeTudpg1ba6haeX1istdluGUIRcUoP5Q2i2tJo/yO6YSShMNYx9vO6feV9DNYieBbcHO
         dcPhwm+2a7TG5GkFzUfHvpfmHQ8Wg23sIZAuGbU11kzVbGS1v7Ool5jHamZia9ASEIgD
         w+/w==
X-Gm-Message-State: ACgBeo12GdxQeesl5klZlw8ukqjwPAx8MAsitPU5zIpat11n/5NhVb7h
	voU14b5IF7EjYQe/PD0doMK6kJ1PMywQHLar3Kw=
X-Google-Smtp-Source: AA6agR7RuQ7crHdKDlCUHnQhHPJH4MeGjKPZBDOckbHhyPSVWOYOrBZd8h6TDnNzNU2j9YIcjyimtYq4SDTOdMGo6xY=
X-Received: by 2002:a05:6a00:1688:b0:53b:4239:7c5c with SMTP id
 k8-20020a056a00168800b0053b42397c5cmr17508585pfc.81.1662783734319; Fri, 09
 Sep 2022 21:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220909054932.246221-1-imagedong@tencent.com>
 <20220909054932.246221-2-imagedong@tencent.com> <e5ccdd9584523641866dbbe906cd7ad4e2f1c43f.camel@redhat.com>
In-Reply-To: <e5ccdd9584523641866dbbe906cd7ad4e2f1c43f.camel@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 10 Sep 2022 12:22:03 +0800
Message-ID: <CADxym3YXL0+xePN_X7v1ZNNbLtmoNgViJRxZVzbeKnN=_aBxEQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/3] net: mptcp: factor out __mptcp_close() without
 socket lock
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>, 
	Jiang Biao <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 9, 2022 at 3:32 PM Paolo Abeni <pabeni@redhat.com> wrote:
>
> Hello,
>
> overall the series LGTM, but there are a few small cosmetic changes I
> I'd  like to suggest, see below and the other patches for the details.
>
> On Fri, 2022-09-09 at 13:49 +0800, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > Factor out __mptcp_close() from mptcp_close(). The caller of
> > __mptcp_close() should hold the socket lock, and cancel mptcp work when
> > __mptcp_close() return true.
> >
> > This function will be used in the next commit.
> >
> > Reviewed-by: Jiang Biao <benbjiang@tencent.com>
> > Reviewed-by: Mengen Sun <mengensun@tencent.com>
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> >  net/mptcp/protocol.c | 19 ++++++++++++++-----
> >  net/mptcp/protocol.h |  1 +
> >  2 files changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index d398f3810662..1cfb4f1ff4e4 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2796,13 +2796,12 @@ static void __mptcp_destroy_sock(struct sock *sk)
> >       sock_put(sk);
> >  }
> >
> > -static void mptcp_close(struct sock *sk, long timeout)
> > +bool __mptcp_close(struct sock *sk, long timeout)
> >  {
> >       struct mptcp_subflow_context *subflow;
> >       struct mptcp_sock *msk = mptcp_sk(sk);
> >       bool do_cancel_work = false;
> >
> > -     lock_sock(sk);
> >       sk->sk_shutdown = SHUTDOWN_MASK;
> >
> >       if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
> > @@ -2833,7 +2832,6 @@ static void mptcp_close(struct sock *sk, long timeout)
> >       }
> >       sock_orphan(sk);
> >
> > -     sock_hold(sk);
>
> If you don't remove this line you can avoid adding a sock_hold(sk) in
> mptcp_close() and an additional one in patch 3. The diff will be
> smaller and the patch clearer.

I thought about it before, and I was a little afraid that
it would make the function hard to understand.

>
> >       pr_debug("msk=%p state=%d", sk, sk->sk_state);
> >       if (mptcp_sk(sk)->token)
> >               mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
> > @@ -2844,10 +2842,21 @@ static void mptcp_close(struct sock *sk, long timeout)
> >       } else {
> >               mptcp_reset_timeout(msk, 0);
> >       }
> > +
> > +     return do_cancel_work;
> > +}
> > +
> > +static void mptcp_close(struct sock *sk, long timeout)
> > +{
> > +     bool cancel_work;
>
> I think this variable name is a bit confusing, as we already have a
> global function with the same name. I think 'do_cancel_work' will be
> better (and again will produce a smaller diff and a clearer patch).
>

Sounds nice!

(BTW, Happy Mid-Autumn Festival~ )

Thanks!
Menglong Dong

>
> Thanks,
>
> Paolo
>
