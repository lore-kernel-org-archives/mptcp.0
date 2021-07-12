Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D5D168
	for <mptcp@lists.linux.dev>; Mon, 12 Jul 2021 10:34:14 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id q10so15941879pfj.12
        for <mptcp@lists.linux.dev>; Mon, 12 Jul 2021 03:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xp0Z4Uykxh1Z0yW/nwiLC5dIQ0+GryL0T0eu6r+bQt0=;
        b=c8GSfHeC4urvlZFl2bVTTnzKg5w5mcuvcyVlRbolUZs7PMv15s+hKgOZYE4wd+KmUR
         18m4R81qFkYJYHM8V87sidY/9r8MotS4K16KTCpOIsmDaXe5ge/lml46bpodya228xvY
         bTgm3BG9AoQnfuTQ+2M+SAPaUQQVgayFDQVi6fU7F3dW8qK9l204FKs9JM2I1I5lO8Xh
         Pm8UNn8OKclRuTG9zTKzMuBj/5lkI9KQcdYWTTrz2HP2Zm9jTmX0Cw+TOKltkdxBRQya
         t/fPdu/uIgt2VrnunJ04xM5uo6Z5PR8mwi8Kzi9GLY/h94HzJffW3/0NergmIBWkLBgg
         AjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xp0Z4Uykxh1Z0yW/nwiLC5dIQ0+GryL0T0eu6r+bQt0=;
        b=mANvIClOomSceWiL5hSpFTOGcF7Eb5lsMoWrRL3LgbpCmtlAJ5xnaWKwxHuyp0aXn3
         6nv53kXB+CS7+ERvrB5A+K9HsWLhckSkwJP4IA8Opij3VdAF9QA9TGEY2rPzbi01OY9/
         XCL8GKuok3aFBBLEGXZHaqvG1Uu1Jf6JhPbokM5sCBc4m+MA/yGHcjy9XX+7+wPQwpGZ
         JTsEwPV+gq0qu0JHw9Ypuufw25ZtOBSSXDAOB9YwJHrcpDhBJYlTIxyIqY8PL5bpDtvR
         655Ht6+Ox2UXbyZZJwLTKUkp6Hxt1eIiicHQxlN6C1N0HBFtcPM1rA5O1pBx+KCvhSqp
         bpTg==
X-Gm-Message-State: AOAM533M14WgNxpu95sm+MipGov4e2QIE8DOc2Sa4LsYvksLUgQiiBri
	5o4VpEkB+URu94sbm98IZgN6fxXnljE3mV4IUdQ=
X-Google-Smtp-Source: ABdhPJwELWwlvQaa/qboF4D6whtX1xUjYCgY1RQKAYEzLzUhNSr3v8rzDyGoLMFGK3pPD7rMGIANTtGWwxORgoYvZIg=
X-Received: by 2002:a63:f751:: with SMTP id f17mr52734046pgk.373.1626086054360;
 Mon, 12 Jul 2021 03:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <9365b79b245b8a87af18ca458c67820d47de2515.1626016228.git.geliangtang@gmail.com>
 <80fa33a249c2ecc7edd9d0047dd84f163307cee7.1626016292.git.geliangtang@gmail.com>
 <347f6214-cc6b-2af2-c1e7-d9ac7f77f87e@chinatelecom.cn> <CA+WQbwuTFxxzsbDdeiWgMN7iqUp9e-ubAmsLa7JpaZbQ+WSBBw@mail.gmail.com>
 <4f790fa7-f99e-401e-d266-8fd85921204a@chinatelecom.cn> <CA+WQbwsuJTtVZ_hW1K25a4YOkSs7DGKOnjt=escT66QQg8WjRQ@mail.gmail.com>
 <3f3c3065-8a08-fc0c-da8b-0e210097b136@chinatelecom.cn> <CA+WQbwsq0LcQLxpbr+9adu68ButC2v5HhMpLyEy93FtKKOjD7w@mail.gmail.com>
 <847db51e-2941-776a-025a-874157c791d6@chinatelecom.cn>
In-Reply-To: <847db51e-2941-776a-025a-874157c791d6@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 12 Jul 2021 18:34:02 +0800
Message-ID: <CA+WQbwuFU9oLG7iFnOv1UeB0qT-3t0J8A+z=556hJqzia_zmDQ@mail.gmail.com>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: build
 ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B47=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:44=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
>
> On 2021/7/12 17:29, Geliang Tang wrote:
> > Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8812=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:14=E5=86=99=E9=81=93=
=EF=BC=9A
> >>
> >>
> >>
> >> On 2021/7/12 16:44, Geliang Tang wrote:
> >>> Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B47=E6=
=9C=8812=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:07=E5=86=99=E9=81=
=93=EF=BC=9A
> >>>>
> >>>>
> >>>>
> >>>> On 2021/7/12 15:33, Geliang Tang wrote:
> >>>>> Hi Yonglong,
> >>>>>
> >>>>> Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B47=E6=
=9C=8812=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=889:34=E5=86=99=E9=81=
=93=EF=BC=9A
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2021/7/11 23:15, Geliang Tang wrote:
> >>>>>>> I think there're still some issues in v8:
> >>>>>>>
> >>>>>>> The remaining value is incorrect since "remaining +=3D opt_size;"=
 in the
> >>>>>>> "drop other suboptions" checks has been called twice in
> >>>>>>> mptcp_pm_add_addr_signal and mptcp_established_options_add_addr.
> >>>>>>>
> >>>>>> I think "remaining" in mptcp_pm_add_addr_signal does not touch "re=
maining" in
> >>>>>> mptcp_established_options_add_addr.
> >>>>>>
> >>>>>>> opts->local and opts->remote in mptcp_pm_add_addr_signal need be
> >>>>>>> populate after the length chech, not before the check.]
> >>>>>>>
> >>>>>>> The squash-to patch keeped the more orignal code unchanged, and j=
ust do
> >>>>>>> the least, necessary modifications.
> >>>>>>>
> >>>>>> Agree opts->local and opts->remote should be asigned after the len=
gth check.
> >>>>>> But if keep the length check out of mptcp_pm_add_addr_signal (out =
of pm lock )
> >>>>>> as orignal code, there is a race that:
> >>>>>>
> >>>>>> =3D=3D> a add addr event (pm.addr_signal =3D=3D MPTCP_ADD_ADDR_SIG=
NAL)
> >>>>>> =3D=3D> call mptcp_pm_add_addr_signal
> >>>>>> =3D=3D> a echo add addr event trigger (pm.addr_signal =3D=3D MPTCP=
_ADD_ADDR_ECHO|MPTCP_ADD_ADDR_SIGNAL)
> >>>>>> =3D=3D> at this time opts->remote is empty and the length is incor=
rect.
> >>>>>>
> >>>>>
> >>>>> What will happen in v8 when this race occurs? How dose v8 deal with=
 the
> >>>>> race?
> >>>> Hi Geliang, thinks for your patience.
> >>>>
> >>>> I think v8 doesn't have this issue:
> >>>> =3D=3D> a add addr event (pm.addr_signal =3D=3D MPTCP_ADD_ADDR_SIGNA=
L)
> >>>> =3D=3D> call mptcp_pm_add_addr_signal, save pm.addr_signal to add_ad=
dr and save addr in opts under pm.lock
> >>>> =3D=3D> a echo add addr event trigger (pm.addr_signal =3D=3D MPTCP_A=
DD_ADDR_ECHO), but add_addr doesn't changed.
> >>>> =3D=3D> use add_addr and opts to check length.
> >>>> =3D=3D> next send ack process will deal with MPTCP_ADD_ADDR_ECHO eve=
nt.
> >>>
> >>> Thanks for your explanation.
> >>>
> >>> I think this squash-to patch did the same thing:
> >>>
> >>> =3D=3D> an add addr event (pm.addr_signal =3D=3D MPTCP_ADD_ADDR_SIGNA=
L)
> >>> =3D=3D> call mptcp_pm_add_addr_signal, save echo bit of pm.addr_signa=
l to
> >>> 'echo' (echo =3D false), save the port number to 'port', and save add=
r
> >>> in opts under pm.lock
> >>> =3D=3D> an echo add addr event trigger (pm.addr_signal =3D=3D
> >>> MPTCP_ADD_ADDR_ECHO), but 'echo' and 'port' don't changed.
> >>> =3D=3D> use 'echo' to get the address family, use 'family', 'echo' an=
d
> >>> 'port' to check length.
> >>> =3D=3D> next send ack process will deal with MPTCP_ADD_ADDR_ECHO even=
t.
> >>>
> >>> Do you think so?
> >> yep. In this case the squash-to patch is ok. But I think between "drop=
 other suboptions" checks and
> >> mptcp_pm_add_addr_signal the race still exist.
> >>
> >
> > I think this is easy to fix:
> >
> > Add a new argument "drop_other_suboptions" for mptcp_pm_add_addr_signal=
,
> > move this "drop other suboptions" check code into mptcp_pm_add_addr_sig=
nal,
> > I'll sent a v2 later.
>
> Thanks. And the v8 do the same thing. Why not use v8 directly :)
>

You'll see the difference later. :)

> >
> > Thanks,
> > -Geliang
> >
> >> =3D=3D> an add addr event (pm.addr_signal =3D=3D MPTCP_ADD_ADDR_SIGNAL=
)
> >> =3D=3D> "drop other suboptions" checks will use MPTCP_ADD_ADDR_SIGNAL =
to check
> >> =3D=3D> an echo add addr event trigger (pm.addr_signal =3D=3D MPTCP_AD=
D_ADDR_SIGNAL | MPTCP_ADD_ADDR_ECHO )
> >> =3D=3D> call mptcp_pm_add_addr_signal, MPTCP_ADD_ADDR_ECHO will be cle=
ar in pm.addr_signal
> >> =3D=3D> process MPTCP_ADD_ADDR_ECHO event.
> >>
> >> WDYT?
> >>
> >>>
> >>>>
> >>>>>
> >>>>>> So I think the orignal code is incorrect. WDYT?
> >>>>>>
> >>>>>>> Drop the "drop other suboptions" check in mptcp_pm_add_addr_signa=
l.
> >>>>>>>
> >>>>>>> Change arguments of mptcp_pm_add_addr_signal.
> >>>>>>>
> >>>>>>> Keep mptcp_add_addr_len unchanged.
> >>>>>>>
> >>>>>>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> >>>>>>> ---
> >>>>>>>  net/mptcp/options.c  | 35 +++++++++++++++++------------------
> >>>>>>>  net/mptcp/pm.c       | 23 +++++++++--------------
> >>>>>>>  net/mptcp/protocol.h | 27 +++++++++------------------
> >>>>>>>  3 files changed, 35 insertions(+), 50 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> >>>>>>> index 5c0ad9b90866..93ad7b134f74 100644
> >>>>>>> --- a/net/mptcp/options.c
> >>>>>>> +++ b/net/mptcp/options.c
> >>>>>>> @@ -663,16 +663,14 @@ static bool mptcp_established_options_add_a=
ddr(struct sock *sk, struct sk_buff *
> >>>>>>>       struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> >>>>>>>       bool drop_other_suboptions =3D false;
> >>>>>>>       unsigned int opt_size =3D *size;
> >>>>>>> -     u8 add_addr;
> >>>>>>> +     bool echo;
> >>>>>>> +     bool port;
> >>>>>>> +     u8 family;
> >>>>>>>       int len;
> >>>>>>>
> >>>>>>> -     if (!mptcp_pm_should_add_signal(msk) ||
> >>>>>>> -         !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining=
, opts, &add_addr))
> >>>>>>> -             return false;
> >>>>>>> -
> >>>>>>> -     if (((add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) ||
> >>>>>>> -          ((add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
> >>>>>>> -           (opts->local.family =3D=3D AF_INET6 || opts->local.po=
rt))) &&
> >>>>>>> +     if ((mptcp_pm_should_add_signal_echo(msk) ||
> >>>>>>> +          (mptcp_pm_should_add_signal_addr(msk) &&
> >>>>>>> +           (msk->pm.local.family =3D=3D AF_INET6 || msk->pm.loca=
l.port))) &&
> >>>>>>>           skb && skb_is_tcp_pure_ack(skb)) {
> >>>>>>>               pr_debug("drop other suboptions");
> >>>>>>>               opts->suboptions =3D 0;
> >>>>>>> @@ -682,7 +680,12 @@ static bool mptcp_established_options_add_ad=
dr(struct sock *sk, struct sk_buff *
> >>>>>>>               drop_other_suboptions =3D true;
> >>>>>>>       }
> >>>>>>>
> >>>>>>> -     len =3D mptcp_add_addr_len(opts, add_addr);
> >>>>>>> +     if (!mptcp_pm_should_add_signal(msk) ||
> >>>>>>> +         !mptcp_pm_add_addr_signal(msk, remaining, &opts->local,=
 &opts->remote, &echo, &port))
> >>>>>>> +             return false;
> >>>>>>> +
> >>>>>>> +     family =3D echo ? opts->remote.family : opts->local.family;
> >>>>>>> +     len =3D mptcp_add_addr_len(family, echo, port);
> >>>>>>>       if (remaining < len)
> >>>>>>>               return false;
> >>>>>>>
> >>>>>>> @@ -690,15 +693,14 @@ static bool mptcp_established_options_add_a=
ddr(struct sock *sk, struct sk_buff *
> >>>>>>>       if (drop_other_suboptions)
> >>>>>>>               *size -=3D opt_size;
> >>>>>>>       opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> >>>>>>> -     if (!(add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) &&
> >>>>>>> -         (add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL))) {
> >>>>>>> +     if (!echo) {
> >>>>>>>               opts->ahmac =3D add_addr_generate_hmac(msk->local_k=
ey,
> >>>>>>>                                                    msk->remote_ke=
y,
> >>>>>>>                                                    &opts->local);
> >>>>>>>       }
> >>>>>>> -     pr_debug("addr_signal:%x, echo=3D%d, local_addr_id=3D%d, ah=
mac=3D%llu, local_port=3D%d, remote_addr_id=3D%d, remote_port=3D%d",
> >>>>>>> -              add_addr, (opts->ahmac =3D=3D 0), opts->local.id, =
opts->ahmac,
> >>>>>>> -              ntohs(opts->local.port), opts->remote.id, ntohs(op=
ts->remote.port));
> >>>>>>> +     pr_debug("local_id=3D%d, local_port=3D%d, remote_id=3D%d, r=
emote_port=3D%d, ahmac=3D%llu, echo=3D%d",
> >>>>>>> +              opts->local.id, ntohs(opts->local.port), opts->rem=
ote.id,
> >>>>>>> +              ntohs(opts->remote.port), opts->ahmac, echo);
> >>>>>>>
> >>>>>>>       return true;
> >>>>>>>  }
> >>>>>>> @@ -1253,13 +1255,10 @@ void mptcp_write_options(__be32 *ptr, con=
st struct tcp_sock *tp,
> >>>>>>>
> >>>>>>>  mp_capable_done:
> >>>>>>>       if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> >>>>>>> -             struct mptcp_addr_info *addr =3D &opts->remote;
> >>>>>>> +             struct mptcp_addr_info *addr =3D opts->ahmac ? &opt=
s->local : &opts->remote;
> >>>>>>>               u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> >>>>>>>               u8 echo =3D MPTCP_ADDR_ECHO;
> >>>>>>>
> >>>>>>> -             if (opts->ahmac)
> >>>>>>> -                     addr =3D &opts->local;
> >>>>>>> -
> >>>>>>>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> >>>>>>>               if (addr->family =3D=3D AF_INET6)
> >>>>>>>                       len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> >>>>>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> >>>>>>> index 264f522af530..399b59cb7563 100644
> >>>>>>> --- a/net/mptcp/pm.c
> >>>>>>> +++ b/net/mptcp/pm.c
> >>>>>>> @@ -253,12 +253,13 @@ void mptcp_pm_mp_prio_received(struct sock =
*sk, u8 bkup)
> >>>>>>>
> >>>>>>>  /* path manager helpers */
> >>>>>>>
> >>>>>>> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_=
buff *skb,
> >>>>>>> -                           unsigned int opt_size, unsigned int r=
emaining,
> >>>>>>> -                           struct mptcp_out_options *opts,  u8 *=
add_addr)
> >>>>>>> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned i=
nt remaining,
> >>>>>>> +                           struct mptcp_addr_info *saddr, struct=
 mptcp_addr_info *daddr,
> >>>>>>> +                           bool *echo, bool *port)
> >>>>>>>  {
> >>>>>>>       int ret =3D false;
> >>>>>>>       u8 add_addr;
> >>>>>>> +     u8 family;
> >>>>>>>
> >>>>>>>       spin_lock_bh(&msk->pm.lock);
> >>>>>>>
> >>>>>>> @@ -266,21 +267,15 @@ bool mptcp_pm_add_addr_signal(struct mptcp_=
sock *msk, struct sk_buff *skb,
> >>>>>>>       if (!mptcp_pm_should_add_signal(msk))
> >>>>>>>               goto out_unlock;
> >>>>>>>
> >>>>>>> -     opts->local =3D msk->pm.local;
> >>>>>>> -     opts->remote =3D msk->pm.remote;
> >>>>>>> -     *add_addr =3D msk->pm.addr_signal;
> >>>>>>> +     *echo =3D mptcp_pm_should_add_signal_echo(msk);
> >>>>>>> +     *port =3D !!(*echo ? msk->pm.remote.port : msk->pm.local.po=
rt);
> >>>>>>>
> >>>>>>> -     if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
> >>>>>>> -          ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
> >>>>>>> -           (msk->pm.local.family =3D=3D AF_INET6 || msk->pm.loca=
l.port))) &&
> >>>>>>> -         skb && skb_is_tcp_pure_ack(skb)) {
> >>>>>>> -             remaining +=3D opt_size;
> >>>>>>> -     }
> >>>>>>> -
> >>>>>>> -     if (remaining < mptcp_add_addr_len(opts, *add_addr))
> >>>>>>> +     family =3D *echo ? msk->pm.remote.family : msk->pm.local.fa=
mily;
> >>>>>>> +     if (remaining < mptcp_add_addr_len(family, *echo, *port))
> >>>>>>>               goto out_unlock;
> >>>>>>>
> >>>>>>>       *saddr =3D msk->pm.local;
> >>>>>>> +     *daddr =3D msk->pm.remote;
> >>>>>>>       add_addr =3D READ_ONCE(msk->pm.addr_signal);
> >>>>>>>       if (mptcp_pm_should_add_signal_echo(msk))
> >>>>>>>               add_addr &=3D ~BIT(MPTCP_ADD_ADDR_ECHO);
> >>>>>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> >>>>>>> index 937e0309e340..4b63cc6079fa 100644
> >>>>>>> --- a/net/mptcp/protocol.h
> >>>>>>> +++ b/net/mptcp/protocol.h
> >>>>>>> @@ -766,25 +766,16 @@ static inline bool mptcp_pm_should_rm_signa=
l(struct mptcp_sock *msk)
> >>>>>>>       return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_S=
IGNAL);
> >>>>>>>  }
> >>>>>>>
> >>>>>>> -static inline unsigned int mptcp_add_addr_len(struct mptcp_out_o=
ptions *opts,
> >>>>>>> -                                           u8 add_addr)
> >>>>>>> +static inline unsigned int mptcp_add_addr_len(int family, bool e=
cho, bool port)
> >>>>>>>  {
> >>>>>>> -     struct mptcp_addr_info *addr =3D &opts->remote;
> >>>>>>> -     u8 len =3D 0;
> >>>>>>> +     u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> >>>>>>>
> >>>>>>> -     if (!(add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) &&
> >>>>>>> -         (add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL))) {
> >>>>>>> -             addr =3D &opts->local;
> >>>>>>> +     if (family =3D=3D AF_INET6)
> >>>>>>> +             len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> >>>>>>> +     if (!echo)
> >>>>>>>               len +=3D MPTCPOPT_THMAC_LEN;
> >>>>>>> -     }
> >>>>>>> -
> >>>>>>> -     if (addr->family =3D=3D AF_INET6)
> >>>>>>> -             len +=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> >>>>>>> -     else
> >>>>>>> -             len +=3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> >>>>>>> -
> >>>>>>>       /* account for 2 trailing 'nop' options */
> >>>>>>> -     if (addr->port)
> >>>>>>> +     if (port)
> >>>>>>>               len +=3D TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_POR=
T_ALIGN;
> >>>>>>>
> >>>>>>>       return len;
> >>>>>>> @@ -798,9 +789,9 @@ static inline int mptcp_rm_addr_len(const str=
uct mptcp_rm_list *rm_list)
> >>>>>>>       return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1=
, 4) + 1;
> >>>>>>>  }
> >>>>>>>
> >>>>>>> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_=
buff *skb,
> >>>>>>> -                           unsigned int opt_size, unsigned int r=
emaining,
> >>>>>>> -                           struct mptcp_out_options *opts,  u8 *=
add_addr);
> >>>>>>> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned i=
nt remaining,
> >>>>>>> +                           struct mptcp_addr_info *saddr, struct=
 mptcp_addr_info *daddr,
> >>>>>>> +                           bool *echo, bool *port);
> >>>>>>>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned in=
t remaining,
> >>>>>>>                            struct mptcp_rm_list *rm_list);
> >>>>>>>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_co=
mmon *skc);
> >>>>>>>
> >>>>>>
> >>>>>> --
> >>>>>> Li YongLong
> >>>>>
> >>>>
> >>>> --
> >>>> Li YongLong
> >>>
> >>>
> >>
> >> --
> >> Li YongLong
> >
>
> --
> Li YongLong
