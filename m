Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3F770
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 07:48:09 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id p16so20875022plf.12
        for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 00:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nnlD4dPC9HtxWQU9FN+gVd+ky9uk+lrAYiUESbXx2bo=;
        b=eA3Let/pjrCuvXOExJdwvM1eCSbNZymcQCniNYorA6WH2rMvLNIeiBHfeRgeEJCArx
         ine4lblarnJayPtHq3kPk71BMmO57s80GG4FXyNiekoTCglVrMw5rJzp+6M5wIYPWEgA
         y74uFCIhFjKgm6QsXMyyaePv3/oK9DKGuoMLj8nETZMNk6mRhbDQVswzjvVTdxKmII3t
         4QTGwryd+IS7fs5cZSHDg04WpblBqaHxXsVdvqXLoG6i+08U7U6MEaUJvegNsUanvCPc
         RZBGGHopTMHw/DxbQDbu1FPUIMKo3RO3FkOafQMn4ZQi7MW/X4bXizuCpyhN39Rzq2/O
         3TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nnlD4dPC9HtxWQU9FN+gVd+ky9uk+lrAYiUESbXx2bo=;
        b=N50kMvdKxKhjc8ocJuJhtby8vqIxSlcN9yq91SguZHKJ49A2D1N/pzF6D/5Qbt/jP0
         eLo1t5zP6519JXqfCK/R6Itmi/9M6FTeOAHR0ewT5qI/u/xTNjCZSgrwBPcKa3tnms+5
         pjAXfG9ZiCDvFhHWHpSklqDMx6dTUtITVYAWma0M3w60aQJpgSIMEATRycG1m56bQ0fI
         TL0jGWEy2cYymrBuu1EwEjYw5lSI+RbXPDsnqKBSm+hede45MC5ejwr0wyFZQDdaSMU/
         kudgzmeSYcwchiKQ8VHIutCoxdpbqJPUoYMvzorswyHs4YGiXGXLmOkBr6H6IjNOc1Ej
         xozw==
X-Gm-Message-State: AOAM532u0VtFUl85mszvLTItdOiAmx/xyskwHDlFrp0vJxvMN+6hemoP
	mIdnRcu0qEflflpqB6bpEMLvMshyfMoeVSrdYtiAoNmBM1k=
X-Google-Smtp-Source: ABdhPJw5cnso3e3mxHB+vQT1y1Ub8sSGDtwpV449MBho85FFduZ/66eLPd/Zd6jsK5cEUdrTUGDkJEfl2gQsmIoJhHY=
X-Received: by 2002:a17:90a:1610:: with SMTP id n16mr3027920pja.190.1619164089279;
 Fri, 23 Apr 2021 00:48:09 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <bbe531db-6d59-d341-16ed-f48b1fd43d2a@163.com> <CA+WQbwvpviu3FAE06bO3CO2azAegzMi8YUXcQPPMBYM8nW7_cg@mail.gmail.com>
 <1b50d699-45ec-e747-983a-1966f64f8e1c@163.com> <CA+WQbwvzabuhsbKKHeWwa3raOfCh270sccdg6=18ytgPjjkaVw@mail.gmail.com>
 <CA+WQbwuSDvyJH+MT00Qvi73MhGoWcrg-AkZfPR56Zfaks2s1uQ@mail.gmail.com> <681e0810-fbbc-daaf-054a-0e83038b4d12@163.com>
In-Reply-To: <681e0810-fbbc-daaf-054a-0e83038b4d12@163.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 23 Apr 2021 15:47:58 +0800
Message-ID: <CA+WQbwsfM_DtYk-q1BFy_Ver2z-=-v96yh4xAt_h2ukNmGKJTg@mail.gmail.com>
Subject: Re: [PATCH] mptcp: create listening socket only if signal flag is set on
To: Jianguo Wu <wujianguo106@163.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jianguo Wu <wujianguo106@163.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=883:41=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2021/4/23 15:27, Geliang Tang wrote:
> > Geliang Tang <geliangtang@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=883:17=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >> Hi Jianguo,
> >>
> >> Jianguo Wu <wujianguo106@163.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:39=E5=86=99=E9=81=93=EF=BC=
=9A
> >>>
> >>>
> >>>
> >>> On 2021/4/23 12:33, Geliang Tang wrote:
> >>>> Hi Jianguo,
> >>>>
> >>>> Thanks for your patch.
> >>>>
> >>>> Jianguo Wu <wujianguo106@163.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8822=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:30=E5=86=99=E9=81=93=EF=BC=
=9A
> >>>>>
> >>>>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> >>>>>
> >>>>> PM announces address to remote host when signal flag is set,
> >>>>> so create listening socket only if signal flag is set.
> >>>>
> >>>> This check has done in the user-space, here are these lines in pm_nl=
_ctl.c:
> >>>>
> >>>> 274                 } else if (!strcmp(argv[arg], "port")) {
> >>>> 275                         u_int16_t port;
> >>>> 276
> >>>> 277                         if (++arg >=3D argc)
> >>>> 278                                 error(1, 0, " missing port value=
");
> >>>> 279                         if (!(flags & MPTCP_PM_ADDR_FLAG_SIGNAL)=
)
> >>>> 280                                 error(1, 0, " flags must be sign=
al
> >>>> when using port");
> >>>>
> >>>
> >>> Hi Geliang, Thanks for point out this, I was use 'ip mptcp' to add ad=
dress, It doesn't seem to have done that check.
> >>> Is it worth to do check in kernel to make sure there is a signal flag=
 before create listening socket?
> >>
> >> I think it's better to check this in the user-space, you can write a p=
atch
> >> to iproute2 to add this check in 'ip mptcp'.
> >
> > Or add this check in mptcp_pm_parse_addr, something like:
> >
> > $ git diff net/mptcp/pm_netlink.c
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 6ba040897738..9cd4a4180a2a 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -971,8 +971,14 @@ static int mptcp_pm_parse_addr(struct nlattr
> > *attr, struct genl_info *info,
> >         if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
> >                 entry->flags =3D nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAG=
S]);
> >
> > -       if (tb[MPTCP_PM_ADDR_ATTR_PORT])
> > +       if (tb[MPTCP_PM_ADDR_ATTR_PORT]) {
> > +               if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
> > +                       NL_SET_ERR_MSG_ATTR("");
> > +                       return -EINVAL;
> > +               }
> > +
> >                 entry->addr.port =3D
> > htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
> > +       }
> >
> >         return 0;
> >  }
> >
> > WDYT?
> >
>
> I think this is better, we can't assume that all user-space tools works c=
orrectly.

You can add this check both in mptcp_pm_parse_addr and in 'ip mptcp'.

-Geliang

>
> > -Geliang
> >
> >
> >>
> >> Thanks.
> >>
> >> -Geliang
> >>
> >>>
> >>>> -Geliang
> >>>>
> >>>>>
> >>>>> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new po=
rt")
> >>>>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> >>>>> ---
> >>>>>  net/mptcp/pm_netlink.c | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> >>>>> index becc32b..dbd6910 100644
> >>>>> --- a/net/mptcp/pm_netlink.c
> >>>>> +++ b/net/mptcp/pm_netlink.c
> >>>>> @@ -1025,7 +1025,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_bu=
ff *skb, struct genl_info *info)
> >>>>>         }
> >>>>>
> >>>>>         *entry =3D addr;
> >>>>> -       if (entry->addr.port) {
> >>>>> +       if (entry->addr.port && (entry->flags & MPTCP_PM_ADDR_FLAG_=
SIGNAL)) {
> >>>>>                 ret =3D mptcp_pm_nl_create_listen_socket(skb->sk, e=
ntry);
> >>>>>                 if (ret) {
> >>>>>                         GENL_SET_ERR_MSG(info, "create listen socke=
t error");
> >>>>> --
> >>>>> 1.8.3.1
> >>>>>
> >>>>>
> >>>
>
>
