Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1209C7B
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 14:34:23 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso5179922pjb.1
        for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PL1hA1cWlzrMHOX9/OqaJzvzCCdjm/vGCjB4w1PlRq0=;
        b=Rp3OcU02fO4zqM68mA1AYU78YFBewcuw9uwO1+NjvuzwyuTizND9+KBfW2b8hjZTqq
         UI1fjAXtqJbGX43AbB3sFueQaDLwrTKeX0FGRO4EmUtpTySxkSypxvwA1S1scLbB+NFf
         xJIi/xUS7RrjK0orVjR9NqfLXEYurJW3bJNL2oDlTUEHqTUP90n13yl6RyOPSdO4zGrA
         ev7nml0DBG/ptxEn4gTMueIasnv7c96G1UB+h0QyZYOnOncwwEicVQbWkJI7jx5D5RFl
         jHGrb5WfnWYWw7rId2VaS/41ycdDGjZgGLqB7bq8kj/haXBIOvZ4bVOr4754WkRSNj6u
         soOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PL1hA1cWlzrMHOX9/OqaJzvzCCdjm/vGCjB4w1PlRq0=;
        b=yAXA9o3jgX4tp2vBh3MIEVno7RyEactFyMuILKQ4OrJ1P7bVibDLodQ04inJJKPkJg
         VQFVCs0Z2XF9PeHi97Mozdy0Cpp9xgu8/YcBXS3AS5xePke+25KeEWjt/+NAxTRYSk9Z
         V62ieKqSfurmxHa+WyjRcm+Gc/wuRf9At059prcf35NHRJww5Enjse/WDPJrQZ9dLBWe
         O2RPdwefInNySAdO3WjHoe5rXKCI8oNUXXuE+I3oYB6MsT0Mazk9EWr0td/JBezcfGY6
         EYhdUz3KrUYfFgV44RAZa/gWVdDsE8YTmWg+65PA5fp8Tvj5imD4fPJYLP1veybcBE0T
         5jrA==
X-Gm-Message-State: AOAM530HhSA21UdN04yKEOt6UYWzNv7XnENxkO1EIbblVaIPVyThgKz1
	X3xuR6odUPL7hfVNoVx9+GQ1ZYGnTaVJniqwnS0=
X-Google-Smtp-Source: ABdhPJwBdbbLmuN0tpD/UUV3QY3QgISfRWrkA+9GXwll7A0aN89VFyHn2/Tp9Lx13SnLCch9MdJlVf98tEr2BIwrhKo=
X-Received: by 2002:a17:902:be08:b0:15d:2297:f294 with SMTP id
 r8-20020a170902be0800b0015d2297f294mr12991396pls.171.1651070063135; Wed, 27
 Apr 2022 07:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1651024344.git.geliang.tang@suse.com> <f69a828ffffa6b0a57d8913a273d84a9150cc860.1651024344.git.geliang.tang@suse.com>
 <d0234513a342a1c3e833c73663feac656d935cfc.camel@redhat.com>
In-Reply-To: <d0234513a342a1c3e833c73663feac656d935cfc.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 27 Apr 2022 22:34:41 +0800
Message-ID: <CA+WQbwt-gm1yqNVqvX4pFfTyj7kmJV5sts+PGHQ4YQn=4WQcgg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v16 5/8] mptcp: add get_subflow wrapper
To: Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang.tang@suse.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thanks for your review!

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=8827=E6=97=A5=
=E5=91=A8=E4=B8=89 16:27=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> First of all I'm sorry for the very late feedback: I had some
> difficulties to allocate time to follow this development.
>
> On Wed, 2022-04-27 at 09:56 +0800, Geliang Tang wrote:
> > This patch defines a new wrapper mptcp_sched_get_subflow(), invoke
> > get_subflow() of msk->sched in it. Use the wrapper instead of using
> > mptcp_subflow_get_send() directly.
> >
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  net/mptcp/protocol.c |  9 ++++-----
> >  net/mptcp/protocol.h | 16 ++++++++++++++++
> >  2 files changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 7590e2d29f39..c6e963848b18 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1515,7 +1515,6 @@ static struct sock *mptcp_subflow_get_send(struct=
 mptcp_sock *msk)
> >       subflow->avg_pacing_rate =3D div_u64((u64)subflow->avg_pacing_rat=
e * wmem +
> >                                          READ_ONCE(ssk->sk_pacing_rate)=
 * burst,
> >                                          burst + wmem);
> > -     msk->last_snd =3D ssk;
> >       msk->snd_burst =3D burst;
> >       return ssk;
> >  }
>
> This breaks "mptcp: really share subflow snd_wnd": When the MPTCP-level
> cwin is 0, we want to do 0-window probe (so mptcp_subflow_get_send()
> return a 'valid' subflow) but we don't want to start a new burst for
> such 0 win probe (so mptcp_subflow_get_send() clears last_snd).
>
> With this change, when MPTCP-level cwin is 0, 'last_send' is not
> cleared anymore.
>
> A simple sulution would be:
>
> ---
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 653757ea0aca..c20f5fd04cad 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1507,7 +1507,7 @@ static struct sock *mptcp_subflow_get_send(struct m=
ptcp_sock *msk)
>         burst =3D min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - =
msk->snd_nxt);
>         wmem =3D READ_ONCE(ssk->sk_wmem_queued);
>         if (!burst) {
> -               msk->last_snd =3D NULL;
> +               msk->snd_burst =3D 0;
>                 return ssk;
>         }
> ---

I think it's better to add back "msk->last_snd =3D ssk;" in
mptcp_subflow_get_send(), keep the original mptcp_subflow_get_send()
unchanged. And set msk->last_snd in the get_subflow() of the
scheduler, the same as v12:

https://patchwork.kernel.org/project/mptcp/patch/396f8edcbf8e4f65a1d76c228d=
c3d12aa4dd2f11.1650430389.git.geliang.tang@suse.com/

>
> Probably a better solution would be adding 'snd_burst' to struct
> mptcp_sched_data, and let mptcp_sched_get_subflow() update msk-
> >snd_burst as specified by the scheduler. With this latter change the
> 'msk' argument in mptcp_sched_ops->schedule() could be const.
>
> > @@ -1575,7 +1574,7 @@ void __mptcp_push_pending(struct sock *sk, unsign=
ed int flags)
> >                       int ret =3D 0;
> >
> >                       prev_ssk =3D ssk;
> > -                     ssk =3D mptcp_subflow_get_send(msk);
> > +                     ssk =3D mptcp_sched_get_subflow(msk, false);
> >
> >                       /* First check. If the ssk has changed since
> >                        * the last round, release prev_ssk
> > @@ -1644,7 +1643,7 @@ static void __mptcp_subflow_push_pending(struct s=
ock *sk, struct sock *ssk)
> >                        * check for a different subflow usage only after
> >                        * spooling the first chunk of data
> >                        */
> > -                     xmit_ssk =3D first ? ssk : mptcp_subflow_get_send=
(mptcp_sk(sk));
> > +                     xmit_ssk =3D first ? ssk : mptcp_sched_get_subflo=
w(mptcp_sk(sk), false);
> >                       if (!xmit_ssk)
> >                               goto out;
> >                       if (xmit_ssk !=3D ssk) {
> > @@ -2489,7 +2488,7 @@ static void __mptcp_retrans(struct sock *sk)
> >       mptcp_clean_una_wakeup(sk);
> >
> >       /* first check ssk: need to kick "stale" logic */
> > -     ssk =3D mptcp_subflow_get_retrans(msk);
> > +     ssk =3D mptcp_sched_get_subflow(msk, true);
> >       dfrag =3D mptcp_rtx_head(sk);
> >       if (!dfrag) {
> >               if (mptcp_data_fin_enabled(msk)) {
> > @@ -3154,7 +3153,7 @@ void __mptcp_check_push(struct sock *sk, struct s=
ock *ssk)
> >               return;
> >
> >       if (!sock_owned_by_user(sk)) {
> > -             struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk=
(sk));
> > +             struct sock *xmit_ssk =3D mptcp_sched_get_subflow(mptcp_s=
k(sk), false);
> >
> >               if (xmit_ssk =3D=3D ssk)
> >                       __mptcp_subflow_push_pending(sk, ssk);
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 22f3f41e1e32..91512fc25128 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -633,6 +633,22 @@ int mptcp_init_sched(struct mptcp_sock *msk,
> >                    struct mptcp_sched_ops *sched);
> >  void mptcp_release_sched(struct mptcp_sock *msk);
> >
> > +static inline struct sock *mptcp_sched_get_subflow(struct mptcp_sock *=
msk, bool reinject)
> > +{
> > +     struct mptcp_sched_data data =3D {
> > +             .sock           =3D msk->first,
> > +             .call_again     =3D 0,
> > +     };
>
> It's not clear to me:
> - why we need the 'sock' argument, since the scheduler already get
> 'msk' as argument?

sock is the selected subflow to return in the scheduer.

> - why we need to initialize it (looks like an 'output' argument ?!?)

Yes, it's an output argument. No need to init it.

> - what is the goal/role of the 'call_again' argument. It looks like we
> just ignore it?!?

call_again is for supporting a "redundant" packet scheduler in the
future indicate that get_subflow() function needs to be called again.

>
> Side note: perhaps we should move the following chunk:
>
> ---
>        sock_owned_by_me(sk);
>
>         if (__mptcp_check_fallback(msk)) {
>                 if (!msk->first)
>                         return NULL;
>                 return sk_stream_memory_free(msk->first) ? msk->first : N=
ULL;
>         }
> ---
>
>   out of mptcp_subflow_get_send() into mptcp_sched_get_subflow(), so
> that every scheduler will not have to deal with fallback sockets.
>
> > +
> > +     msk->sched ? INDIRECT_CALL_INET_1(msk->sched->get_subflow,
> > +                                       mptcp_get_subflow_default,
> > +                                       msk, reinject, &data) :
> > +                  mptcp_get_subflow_default(msk, reinject, &data);
>
> With this we have quite a lot of conditionals for the default
> scheduler. I think we can drop the INDIRECT_CALL_INET_1() wrapper, and
> rework the code so that msk->sched is always NULL with the default
> scheduler.

So I need to drop patch 2 (2/8 mptcp: register default scheduler) in
this series, right?

>
> And sorry to bring the next topic so late, but why a 'reinject'
> argument instead of an additional mptcp_sched_ops op? the latter option
> will avoid another branch in fast-path.

How about keeping th 'reinject' argument like this:

----
static inline struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
{
        struct mptcp_sched_data data;

        sock_owned_by_me((struct sock *)msk);

        /* the following check is moved out of mptcp_subflow_get_send */
        if (__mptcp_check_fallback(msk)) {
                if (!msk->first)
                        return NULL;
                return sk_stream_memory_free(msk->first) ? msk->first : NUL=
L;
        }

        if (!msk->sched)
                return mptcp_subflow_get_send(msk);

        msk->sched->get_subflow(msk, false, &data);

        return data.sock;
}

static inline struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
{
        struct mptcp_sched_data data;

        sock_owned_by_me((const struct sock *)msk);

        if (__mptcp_check_fallback(msk))
                return NULL;

        if (!msk->sched)
                return mptcp_subflow_get_retrans(msk);

        msk->sched->get_subflow(msk, true, &data);

        return data.sock;
}
-----

Thanks,
-Geliang

>
> Thanks!
>
> Paolo
>
>
