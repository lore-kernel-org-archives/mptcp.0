Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9074171
	for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 08:06:43 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id n12so4770065pgs.13
        for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 01:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=halFB6jg+zdrjtndvNa+YjiqOKmbjJAOKf8fjD/Fwrg=;
        b=LCns4HmCeWK1KXgbxgXsZzywfnMWtkbDDOhA7pbjQXLDpbg2IKr3X0zA/k2JSmVCnn
         8WvwppVOinBiHrGqxGFockHBxNfFzvM9FwerjtdIlqMSMSlSIp9/gThCw9x6816cQhH8
         UVrrpSS5kkiinhtjxY0m1CsETQy7Sov5pnpvB7n3pGqfgW8IT3kAzkSFcRtTmEDWU2Tc
         D7vivOLSFUC9YiyJYVantgEo3BOLbqMjQ9qN1ZVxhupxvGBunitrFFKF6JhR9MupOPbG
         JiJZN79TzHGnv1TG6bLZ0fGl65yXipm8u6QrKRmpR3cAZreJYV9zKRwRUqMUTriloEJh
         jZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=halFB6jg+zdrjtndvNa+YjiqOKmbjJAOKf8fjD/Fwrg=;
        b=Zuz6h5v98HklnaO0suAMfZms4daH5EiRb2BSsi2BVblGMPPqh3ErqPhXaKhctNOAS/
         8Hjqjgt7nftNvdWE5ILPtJexfBkVuWqNrht9W6GKZWCp11YGsaYRHQJZQGwFkcuaWCND
         +IJypyvDp3yk1h4TBgs4bk+JpChhFIpMxsqccKc69SVdlYrdVP8upn5/+ou/d1xkmhML
         ZOlJ4p12CEOt9f9npZTzWPPjstCdD46A47YOXXe4fR9s/5ccK7ODB/UeyRYAqOvu2P55
         HsY4uTIOxD1gYahn1wH9wEyq9IbPfET8hNCsL3DzdlvYG2fKoMqd8dzALISFNF6oyX9P
         5I8Q==
X-Gm-Message-State: AOAM5323rVHhangpPaKykindMUgxbHGVoEzqtKE5nzgxBaashQMJbKh4
	9OhUqSMhTUf4Ubzs1NX9kTJps7qjkQdhZQ+yzQU=
X-Google-Smtp-Source: ABdhPJwBfFT3RVz5X4GzUOb3Hgx7rkngFsy535Rlqiw7Ry7GtSYenDiBIlhPbd4fsSWHiuyA9DNxwFGo84NiIjhQ7+Q=
X-Received: by 2002:aa7:824a:0:b029:2ec:89ee:e798 with SMTP id
 e10-20020aa7824a0000b02902ec89eee798mr18469804pfn.12.1624262803110; Mon, 21
 Jun 2021 01:06:43 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1624004309-54480-1-git-send-email-liyonglong@chinatelecom.cn>
 <1624004309-54480-4-git-send-email-liyonglong@chinatelecom.cn>
 <CA+WQbwsSmzxw5c-pPJNYndQ99FKmFXSuKD6kxpQgwJGe9Q2kpQ@mail.gmail.com>
 <85720e69-d6d4-4a9b-9f1c-0898a1cf5009@chinatelecom.cn> <CA+WQbwt0adACAC0HB_KteK8MtHbNjwV2GPfkn1s_DsWJL1pgqQ@mail.gmail.com>
 <aeccceca-b3e4-004f-2f7d-1ff221583141@chinatelecom.cn> <CA+WQbwuVygGQhZ+Dnx9hEr3j7YH4AU_7+Jvr4XW9jJgdmhoVTQ@mail.gmail.com>
 <a81f19a0-bbc7-b032-f757-ec7b8b16ee2f@chinatelecom.cn>
In-Reply-To: <a81f19a0-bbc7-b032-f757-ec7b8b16ee2f@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 21 Jun 2021 16:06:31 +0800
Message-ID: <CA+WQbwtKU0as1SWczK04CBxn04r9LdUngCP=yo1o4MQ_aO2MVQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	qitiepeng@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:50=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
>
> On 2021/6/21 15:39, Geliang Tang wrote:
> > Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=
=8821=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:16=E5=86=99=E9=81=93=
=EF=BC=9A
> >>
> >>
> >>
> >> On 2021/6/21 14:42, Geliang Tang wrote:
> >>> Hi Yonglong,
> >>>
> >>> Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=
=9C=8821=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8811:52=E5=86=99=E9=81=
=93=EF=BC=9A
> >>>>
> >>>>
> >>>> On 2021/6/18 19:20, Geliang Tang wrote:
> >>>>> Hi Yonglong,
> >>>>>
> >>>>> Thanks for v4!
> >>>>>
> >>>>> Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=
=9C=8818=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:19=E5=86=99=E9=81=
=93=EF=BC=9A
> >>>>>> according MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO flag build
> >>>>>> ADD_ADDR/echo-ADD_ADDR option
> >>>>>>
> >>>>>> add a suboptions type OPTION_MPTCP_ADD_ECHO to mark as echo option
> >>>>>>
> >>>>>> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> >>>>>> ---
> >>>>>>  net/mptcp/options.c  | 124 +++++++++++++++++++++++++++++++-------=
-------------
> >>>>>>  net/mptcp/pm.c       |  30 ++++---------
> >>>>>>  net/mptcp/protocol.h |  13 +++---
> >>>>>>  3 files changed, 92 insertions(+), 75 deletions(-)
> >>>>>>
> >>>>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> >>>>>> index 1aec016..43e3241 100644
> >>>>>> --- a/net/mptcp/options.c
> >>>>>> +++ b/net/mptcp/options.c
> >>>>>> @@ -655,41 +655,64 @@ static bool mptcp_established_options_add_ad=
dr(struct sock *sk, struct sk_buff *
> >>>>>>         struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> >>>>>>         bool drop_other_suboptions =3D false;
> >>>>>>         unsigned int opt_size =3D *size;
> >>>>>> -       bool echo;
> >>>>>> -       bool port;
> >>>>>> +       struct mptcp_addr_info remote;
> >>>>>> +       struct mptcp_addr_info local;
> >>>>>> +       u8 add_addr, flags =3D 0xff;
> >>>>>>         int len;
> >>>>>>
> >>>>>> -       if ((mptcp_pm_should_add_signal_ipv6(msk) ||
> >>>>>> -            mptcp_pm_should_add_signal_port(msk) ||
> >>>>>> -            mptcp_pm_should_add_signal_echo(msk)) &&
> >>>>>> -           skb && skb_is_tcp_pure_ack(skb)) {
> >>>>>> -               pr_debug("drop other suboptions");
> >>>>>> -               opts->suboptions =3D 0;
> >>>>>> -               opts->ext_copy.use_ack =3D 0;
> >>>>>> -               opts->ext_copy.use_map =3D 0;
> >>>>>> -               remaining +=3D opt_size;
> >>>>>> -               drop_other_suboptions =3D true;
> >>>>>> -       }
> >>>>>> -
> >>>>>> -       if (!mptcp_pm_should_add_signal(msk) ||
> >>>>>> -           !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr=
, &echo, &port)))
> >>>>>> -               return false;
> >>>>>> -
> >>>>>> -       len =3D mptcp_add_addr_len(opts->addr.family, echo, port);
> >>>>>> -       if (remaining < len)
> >>>>>> +       if (!mptcp_pm_should_add_signal(msk))
> >>>>>>                 return false;
> >>>>>>
> >>>>>> -       *size =3D len;
> >>>>>> -       if (drop_other_suboptions)
> >>>>>> -               *size -=3D opt_size;
> >>>>>> -       opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> >>>>>> -       if (!echo) {
> >>>>>> +       *size =3D 0;
> >>>>>> +       mptcp_pm_add_addr_signal(msk, &local, &remote, &add_addr);
> >>>>>> +       if (mptcp_pm_should_add_signal_echo(msk)) {
> >>>>>> +               if (skb && skb_is_tcp_pure_ack(skb)) {
> >>>>> '''
> >>>>>> +                       pr_debug("drop other suboptions");
> >>>>>> +                       opts->suboptions =3D 0;
> >>>>>> +                       opts->ext_copy.use_ack =3D 0;
> >>>>>> +                       opts->ext_copy.use_map =3D 0;
> >>>>>> +                       remaining +=3D opt_size;
> >>>>>> +                       drop_other_suboptions =3D true;
> >>>>> '''
> >>>>>
> >>>>>> +               }
> >>>>>> +               len =3D mptcp_add_addr_len(remote.family, true, !!=
remote.port);
> >>>>>> +               if (remaining < len)
> >>>>>> +                       return false;
> >>>>>> +               remaining -=3D len;
> >>>>>> +               *size +=3D len;
> >>>>>> +               opts->remote =3D remote;
> >>>>>> +               flags =3D (u8)~BIT(MPTCP_ADD_ADDR_ECHO);
> >>>>>> +               opts->suboptions |=3D OPTION_MPTCP_ADD_ECHO;
> >>>>>> +               pr_debug("addr_id=3D%d, echo=3D1, port=3D%d addr_s=
ignal:%x",
> >>>>>> +                        opts->remote.id, ntohs(opts->remote.port)=
, add_addr);
> >>>>>> +       } else if (mptcp_pm_should_add_signal_addr(msk)) {
> >>>>>> +               if ((local.family =3D=3D AF_INET6 || local.port) &=
& skb &&
> >>>>>> +                   skb_is_tcp_pure_ack(skb)) {
> >>>>> '''
> >>>>>> +                       pr_debug("drop other suboptions");
> >>>>>> +                       opts->suboptions =3D 0;
> >>>>>> +                       opts->ext_copy.use_ack =3D 0;
> >>>>>> +                       opts->ext_copy.use_map =3D 0;
> >>>>>> +                       remaining +=3D opt_size;
> >>>>>> +                       drop_other_suboptions =3D true;
> >>>>> '''
> >>>>>
> >>>>> I think this "drop other suboptions" trunk here is still duplicated=
. Can
> >>>>> we just use one "drop other suboptions" trunk only?
> >>>>>
> >>>>> Thanks.
> >>>>> -Geliang
> >>>>>
> >>>> Hi Geliang, Thanks for you replay.
> >>>>
> >>>> The commit "07f8252fe0e3c2b6320eeff18bdc5b7fb8845cb3" Davide said "e=
cho-ed ADD_ADDR
> >>>> carried over pure TCP ACKs, so there is no need to add a DSS element=
 that would fit
> >>>> only ADD_ADDR with IPv4 address.Drop the DSS from echo-ed ADD_ADDR, =
regardless of the
> >>>> IP version."
> >>>> ADD_ADDR option can add with DSS if the addr is IPv4. So I think it =
is more clear
> >>>> to decide "drop other suboptions" in two trunk.
> >>> Could we change it like this:
> >>>
> >>> '''
> >>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> >>> index e77b5d532fb8..8b4cb0581a49 100644
> >>> --- a/net/mptcp/options.c
> >>> +++ b/net/mptcp/options.c
> >>> @@ -673,15 +673,20 @@ static bool
> >>> mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
> >>>
> >>>         *size =3D 0;
> >>>         mptcp_pm_add_addr_signal(msk, &local, &remote, &add_addr);
> >>> +
> >>> +       if ((mptcp_pm_should_add_signal_echo(msk) ||
> >>> +           (mptcp_pm_should_add_signal_addr(msk) &&
> >>> +           (local.family =3D=3D AF_INET6 || local.port))) &&
> >>> +           skb && skb_is_tcp_pure_ack(skb)) {
> >>> +               pr_debug("drop other suboptions");
> >>> +               opts->suboptions =3D 0;
> >>> +               opts->ext_copy.use_ack =3D 0;
> >>> +               opts->ext_copy.use_map =3D 0;
> >>> +               remaining +=3D opt_size;
> >>> +               drop_other_suboptions =3D true;
> >>> +       }
> >>> +
> >>>         if (mptcp_pm_should_add_signal_echo(msk)) {
> >>> -               if (skb && skb_is_tcp_pure_ack(skb)) {
> >>> -                       pr_debug("drop other suboptions");
> >>> -                       opts->suboptions =3D 0;
> >>> -                       opts->ext_copy.use_ack =3D 0;
> >>> -                       opts->ext_copy.use_map =3D 0;
> >>> -                       remaining +=3D opt_size;
> >>> -                       drop_other_suboptions =3D true;
> >>> -               }
> >>>                 len =3D mptcp_add_addr_len(remote.family, true, !!rem=
ote.port);
> >>>                 if (remaining < len)
> >>>                         return false;
> >>> @@ -693,15 +698,6 @@ static bool
> >>> mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
> >>>                 pr_debug("addr_id=3D%d, echo=3D1, port=3D%d addr_sign=
al:%x",
> >>>                          opts->remote.id, ntohs(opts->remote.port), a=
dd_addr);
> >>>         } else if (mptcp_pm_should_add_signal_addr(msk)) {
> >>> -               if ((local.family =3D=3D AF_INET6 || local.port) && s=
kb &&
> >>> -                   skb_is_tcp_pure_ack(skb)) {
> >>> -                       pr_debug("drop other suboptions");
> >>> -                       opts->suboptions =3D 0;
> >>> -                       opts->ext_copy.use_ack =3D 0;
> >>> -                       opts->ext_copy.use_map =3D 0;
> >>> -                       remaining +=3D opt_size;
> >>> -                       drop_other_suboptions =3D true;
> >>> -               }
> >>>                 len =3D mptcp_add_addr_len(local.family, false, !!loc=
al.port);
> >>>                 if (remaining < len)
> >>>                         return false;
> >>> '''
> >>> WDYT?
> >> Thanks for your advice.
> >>
> >> Because MPTCP_ADD_ADDR_ECHO and MPTCP_ADD_ADDR_SIGNAL can be set at th=
e same time. So as your advice we should
> >> change like this(still I think it not clear than before):
> >>
> >>         mptcp_pm_add_addr_signal(msk, &local, &remote, &add_addr);
> >> +       if ((mptcp_pm_should_add_signal_echo(msk) ||
> >> +           (!mptcp_pm_should_add_signal_echo(msk) &&
> >> +           mptcp_pm_should_add_signal_addr(msk) &&
> >> +           (local.family =3D=3D AF_INET6 || local.port))) &&
> >> +           skb && skb_is_tcp_pure_ack(skb)) {
> >> +               pr_debug("drop other suboptions");
> >> +               opts->suboptions =3D 0;
> >> +               opts->ext_copy.use_ack =3D 0;
> >> +               opts->ext_copy.use_map =3D 0;
> >> +               remaining +=3D opt_size;
> >> +               drop_other_suboptions =3D true;
> >> +       }
> >> +
> >>         if (mptcp_pm_should_add_signal_echo(msk)) {
> >> -               if (skb && skb_is_tcp_pure_ack(skb)) {
> >>
> >>
> >>>
> >>>>>
> >>>>>> +               }
> >>>>>> +               len =3D mptcp_add_addr_len(local.family, false, !!=
local.port);
> >>>>>> +               if (remaining < len)
> >>>>>> +                       return false;
> >>> And here, I think "remaining -=3D len;" is missing.
> >>>
> >>> Thanks,
> >>> -Geliang
> >>>
> >> "remaining" is not being used in the flowing code. So "remaining -=3Dl=
en;" is not necessary. But you remindme that the "remaining -=3D len;" can =
be removed in the first trunk.
> >
> > I think we should keep this 'remaining -=3D len;', remaining can be use=
d
> > in tcp_established_options.
> >
> Thanks for your review.
> I think "remaining" will not use in tcp_established_options. "size" is us=
ed by tcp_established_options.

You're right, we should drop this 'remaining -=3D len;' in this function.

>
> >>
> >> I will send v5 as your advice.
> >>
> >
