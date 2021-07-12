Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEFB70
	for <mptcp@lists.linux.dev>; Mon, 12 Jul 2021 07:33:39 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id d9-20020a17090ae289b0290172f971883bso11640804pjz.1
        for <mptcp@lists.linux.dev>; Mon, 12 Jul 2021 00:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7Sh+h6xFe9fsQjTevX3qwGUYiLc4Ut7CHIr/kXG2o4g=;
        b=duPzKUvXAO7YvNXP6cB7KKoZTF9A/ZQ3dbCmsY3jMnnJLM9QK0Z7n/PJabj6J8IXF2
         lO26WQLIgynWHQO5ukZKQw8DhV7Wjj8Vfw7b16fxG4CANT2G1ldrVG7T7IavDqGBrGWD
         +ZEcBZf7mxVT30GjEKsE7K3Mera4emjEb9Ti+JBKdvsJYWWu4COMl5Y4WWInv2GEb+ah
         SWx4CFwgNwKpHYe37OHbZ5jivlbTPCNUvBCYWQf0Jwfv//XkdFYZ4I10aD4sJEjv5Use
         Y7vGS5jFzDKDc27mM+FVdsW9dSVoTnM+WL44dPWGEuDHQzF5VSRpaJe3tWeru7Nz9BZx
         aZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7Sh+h6xFe9fsQjTevX3qwGUYiLc4Ut7CHIr/kXG2o4g=;
        b=O4DMNPZUMBa4l0aL5KzePpNGVlzGzjJOmYnhYLf9/hBfGU8qQTUDJQLFWLbJOftep7
         arpbOfep5w1GiO3Q4rDYe6h1yqToBwi22RgwAsqZfPU5MQLXCHWDvRVsuCj8LglHFTsm
         N2Lx09lX4mLXHvcQBqp6/FTf4WQD2PNBC7BggDlUscO5yFUs+mPsCAgR1Wm2vG4PwPyn
         vAIRDcdrXdmWprpWCeQsr9nv5q2yafpAjB4ZwDgFRAoPeBmQ/HEepaJ+7acoXmpYJe2X
         05Obbx1Zqr37k0AD35i804Fm2H3i8D5ykm72o3IAto4CdxGE9VoRU1/JuPhl4xdxEP0M
         YGBg==
X-Gm-Message-State: AOAM5301krBOUmq5JpddMy2fXTWiq3LBG6c3LUprJ+uH2ExiVL7+zzsn
	O2LcHqnTzCc0eXDXsbIBH2p8tEk6ZAvyoMB2aNg=
X-Google-Smtp-Source: ABdhPJw9qB1+osExx355dfe39nCCNicvp9su0DBrhoC5volOsOiTWWXor02fvfAtr62arCD+FJaSkFdf1u75axVWLzc=
X-Received: by 2002:a17:90a:7843:: with SMTP id y3mr51102231pjl.190.1626075219204;
 Mon, 12 Jul 2021 00:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <9365b79b245b8a87af18ca458c67820d47de2515.1626016228.git.geliangtang@gmail.com>
 <80fa33a249c2ecc7edd9d0047dd84f163307cee7.1626016292.git.geliangtang@gmail.com>
 <347f6214-cc6b-2af2-c1e7-d9ac7f77f87e@chinatelecom.cn>
In-Reply-To: <347f6214-cc6b-2af2-c1e7-d9ac7f77f87e@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 12 Jul 2021 15:33:28 +0800
Message-ID: <CA+WQbwuTFxxzsbDdeiWgMN7iqUp9e-ubAmsLa7JpaZbQ+WSBBw@mail.gmail.com>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: build
 ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yonglong,

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B47=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=889:34=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
>
> On 2021/7/11 23:15, Geliang Tang wrote:
> > I think there're still some issues in v8:
> >
> > The remaining value is incorrect since "remaining +=3D opt_size;" in th=
e
> > "drop other suboptions" checks has been called twice in
> > mptcp_pm_add_addr_signal and mptcp_established_options_add_addr.
> >
> I think "remaining" in mptcp_pm_add_addr_signal does not touch "remaining=
" in
> mptcp_established_options_add_addr.
>
> > opts->local and opts->remote in mptcp_pm_add_addr_signal need be
> > populate after the length chech, not before the check.]
> >
> > The squash-to patch keeped the more orignal code unchanged, and just do
> > the least, necessary modifications.
> >
> Agree opts->local and opts->remote should be asigned after the length che=
ck.
> But if keep the length check out of mptcp_pm_add_addr_signal (out of pm l=
ock )
> as orignal code, there is a race that:
>
> =3D=3D> a add addr event (pm.addr_signal =3D=3D MPTCP_ADD_ADDR_SIGNAL)
> =3D=3D> call mptcp_pm_add_addr_signal
> =3D=3D> a echo add addr event trigger (pm.addr_signal =3D=3D MPTCP_ADD_AD=
DR_ECHO|MPTCP_ADD_ADDR_SIGNAL)
> =3D=3D> at this time opts->remote is empty and the length is incorrect.
>

What will happen in v8 when this race occurs? How dose v8 deal with the
race?

> So I think the orignal code is incorrect. WDYT?
>
> > Drop the "drop other suboptions" check in mptcp_pm_add_addr_signal.
> >
> > Change arguments of mptcp_pm_add_addr_signal.
> >
> > Keep mptcp_add_addr_len unchanged.
> >
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > ---
> >  net/mptcp/options.c  | 35 +++++++++++++++++------------------
> >  net/mptcp/pm.c       | 23 +++++++++--------------
> >  net/mptcp/protocol.h | 27 +++++++++------------------
> >  3 files changed, 35 insertions(+), 50 deletions(-)
> >
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 5c0ad9b90866..93ad7b134f74 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -663,16 +663,14 @@ static bool mptcp_established_options_add_addr(st=
ruct sock *sk, struct sk_buff *
> >       struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> >       bool drop_other_suboptions =3D false;
> >       unsigned int opt_size =3D *size;
> > -     u8 add_addr;
> > +     bool echo;
> > +     bool port;
> > +     u8 family;
> >       int len;
> >
> > -     if (!mptcp_pm_should_add_signal(msk) ||
> > -         !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts=
, &add_addr))
> > -             return false;
> > -
> > -     if (((add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) ||
> > -          ((add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
> > -           (opts->local.family =3D=3D AF_INET6 || opts->local.port))) =
&&
> > +     if ((mptcp_pm_should_add_signal_echo(msk) ||
> > +          (mptcp_pm_should_add_signal_addr(msk) &&
> > +           (msk->pm.local.family =3D=3D AF_INET6 || msk->pm.local.port=
))) &&
> >           skb && skb_is_tcp_pure_ack(skb)) {
> >               pr_debug("drop other suboptions");
> >               opts->suboptions =3D 0;
> > @@ -682,7 +680,12 @@ static bool mptcp_established_options_add_addr(str=
uct sock *sk, struct sk_buff *
> >               drop_other_suboptions =3D true;
> >       }
> >
> > -     len =3D mptcp_add_addr_len(opts, add_addr);
> > +     if (!mptcp_pm_should_add_signal(msk) ||
> > +         !mptcp_pm_add_addr_signal(msk, remaining, &opts->local, &opts=
->remote, &echo, &port))
> > +             return false;
> > +
> > +     family =3D echo ? opts->remote.family : opts->local.family;
> > +     len =3D mptcp_add_addr_len(family, echo, port);
> >       if (remaining < len)
> >               return false;
> >
> > @@ -690,15 +693,14 @@ static bool mptcp_established_options_add_addr(st=
ruct sock *sk, struct sk_buff *
> >       if (drop_other_suboptions)
> >               *size -=3D opt_size;
> >       opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> > -     if (!(add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) &&
> > -         (add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL))) {
> > +     if (!echo) {
> >               opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
> >                                                    msk->remote_key,
> >                                                    &opts->local);
> >       }
> > -     pr_debug("addr_signal:%x, echo=3D%d, local_addr_id=3D%d, ahmac=3D=
%llu, local_port=3D%d, remote_addr_id=3D%d, remote_port=3D%d",
> > -              add_addr, (opts->ahmac =3D=3D 0), opts->local.id, opts->=
ahmac,
> > -              ntohs(opts->local.port), opts->remote.id, ntohs(opts->re=
mote.port));
> > +     pr_debug("local_id=3D%d, local_port=3D%d, remote_id=3D%d, remote_=
port=3D%d, ahmac=3D%llu, echo=3D%d",
> > +              opts->local.id, ntohs(opts->local.port), opts->remote.id=
,
> > +              ntohs(opts->remote.port), opts->ahmac, echo);
> >
> >       return true;
> >  }
> > @@ -1253,13 +1255,10 @@ void mptcp_write_options(__be32 *ptr, const str=
uct tcp_sock *tp,
> >
> >  mp_capable_done:
> >       if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> > -             struct mptcp_addr_info *addr =3D &opts->remote;
> > +             struct mptcp_addr_info *addr =3D opts->ahmac ? &opts->loc=
al : &opts->remote;
> >               u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> >               u8 echo =3D MPTCP_ADDR_ECHO;
> >
> > -             if (opts->ahmac)
> > -                     addr =3D &opts->local;
> > -
> >  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> >               if (addr->family =3D=3D AF_INET6)
> >                       len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 264f522af530..399b59cb7563 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -253,12 +253,13 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u=
8 bkup)
> >
> >  /* path manager helpers */
> >
> > -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *=
skb,
> > -                           unsigned int opt_size, unsigned int remaini=
ng,
> > -                           struct mptcp_out_options *opts,  u8 *add_ad=
dr)
> > +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int rem=
aining,
> > +                           struct mptcp_addr_info *saddr, struct mptcp=
_addr_info *daddr,
> > +                           bool *echo, bool *port)
> >  {
> >       int ret =3D false;
> >       u8 add_addr;
> > +     u8 family;
> >
> >       spin_lock_bh(&msk->pm.lock);
> >
> > @@ -266,21 +267,15 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *=
msk, struct sk_buff *skb,
> >       if (!mptcp_pm_should_add_signal(msk))
> >               goto out_unlock;
> >
> > -     opts->local =3D msk->pm.local;
> > -     opts->remote =3D msk->pm.remote;
> > -     *add_addr =3D msk->pm.addr_signal;
> > +     *echo =3D mptcp_pm_should_add_signal_echo(msk);
> > +     *port =3D !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
> >
> > -     if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
> > -          ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
> > -           (msk->pm.local.family =3D=3D AF_INET6 || msk->pm.local.port=
))) &&
> > -         skb && skb_is_tcp_pure_ack(skb)) {
> > -             remaining +=3D opt_size;
> > -     }
> > -
> > -     if (remaining < mptcp_add_addr_len(opts, *add_addr))
> > +     family =3D *echo ? msk->pm.remote.family : msk->pm.local.family;
> > +     if (remaining < mptcp_add_addr_len(family, *echo, *port))
> >               goto out_unlock;
> >
> >       *saddr =3D msk->pm.local;
> > +     *daddr =3D msk->pm.remote;
> >       add_addr =3D READ_ONCE(msk->pm.addr_signal);
> >       if (mptcp_pm_should_add_signal_echo(msk))
> >               add_addr &=3D ~BIT(MPTCP_ADD_ADDR_ECHO);
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 937e0309e340..4b63cc6079fa 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -766,25 +766,16 @@ static inline bool mptcp_pm_should_rm_signal(stru=
ct mptcp_sock *msk)
> >       return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL)=
;
> >  }
> >
> > -static inline unsigned int mptcp_add_addr_len(struct mptcp_out_options=
 *opts,
> > -                                           u8 add_addr)
> > +static inline unsigned int mptcp_add_addr_len(int family, bool echo, b=
ool port)
> >  {
> > -     struct mptcp_addr_info *addr =3D &opts->remote;
> > -     u8 len =3D 0;
> > +     u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> >
> > -     if (!(add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) &&
> > -         (add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL))) {
> > -             addr =3D &opts->local;
> > +     if (family =3D=3D AF_INET6)
> > +             len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> > +     if (!echo)
> >               len +=3D MPTCPOPT_THMAC_LEN;
> > -     }
> > -
> > -     if (addr->family =3D=3D AF_INET6)
> > -             len +=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> > -     else
> > -             len +=3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> > -
> >       /* account for 2 trailing 'nop' options */
> > -     if (addr->port)
> > +     if (port)
> >               len +=3D TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIG=
N;
> >
> >       return len;
> > @@ -798,9 +789,9 @@ static inline int mptcp_rm_addr_len(const struct mp=
tcp_rm_list *rm_list)
> >       return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) +=
 1;
> >  }
> >
> > -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *=
skb,
> > -                           unsigned int opt_size, unsigned int remaini=
ng,
> > -                           struct mptcp_out_options *opts,  u8 *add_ad=
dr);
> > +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int rem=
aining,
> > +                           struct mptcp_addr_info *saddr, struct mptcp=
_addr_info *daddr,
> > +                           bool *echo, bool *port);
> >  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int rema=
ining,
> >                            struct mptcp_rm_list *rm_list);
> >  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *=
skc);
> >
>
> --
> Li YongLong
