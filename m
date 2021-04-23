Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD3271
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 08:59:27 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so907791pjv.1
        for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 01:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oaf5Sq4WlkX1csGh+YjddK77GbbkKKfWczAywUtT3MA=;
        b=moD6YwDKA4JKMo9lIfBh9dZ2w+G+pakfRV7D7TDlyOkDcbyd5e/2n9RXZcYxmYyfPo
         HxNXqzAUg8VUDBdLVVQLPFjK1WdFfb8waHm9Ab4DtdKrMBM5UaGyDUkR/GNEbRFXnw1w
         z77nEwbgbxwWXPHxkqeUmimQ0Up90nYi6NGwBoSVhBMc+39s1enc1PVFbNUnLVjjFzcD
         jvS2RIuElOQ15CvXvQma0XynDNKaUrz6DU5y1zzvW3pRk5HQbKxJALEqWpQtyHFrglvM
         6Ovy6Z0fEDque4UxHKLnQoCyefE1B3Nn+tyqmwYFQNyB76ITzjJ87ixwmpLTy7OAbWJ2
         maZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oaf5Sq4WlkX1csGh+YjddK77GbbkKKfWczAywUtT3MA=;
        b=tPeln93Q9r02GdyebiMCIc/48UuPd3gfthg2uNfHEsxV8b00Pdq53qySDxXbVqex8I
         hKTZzwoUBiYXsZiXoS2JUXRUMe+PEJUNPwJ6NG4QT8WKvzgWfDB4FqAgicV6qKdzFsSy
         SKHS0DAL48ofa3xzoRfN9NDPNrSHhc6sIU8LtMp9g/gV1QOmienzLNEVLiuB8tF3LX7e
         q2qex87Fb/OmsVaJWK8enDQuuFMalpRs+QXE+Wcl8aGWlWito8hty+xoRoCXPVgq/Tan
         /lEKucYopsPu1mqpCefGXlq5NEHLa8JK1ypfE9QARdTABNEwLfd82VuxEGFvsfv7vJTI
         OUMw==
X-Gm-Message-State: AOAM531I6jWmWIy4rPKduuYtityV9OV48yJ88soCI8PXLYKfl6EXQ7Ai
	+sBhPfKTXJ6ubyVMMjz+KV/v7RzjrEg3tZZMaBk=
X-Google-Smtp-Source: ABdhPJzRsu31BUcXmpomp9MWtoJjiTelZyYa8BmeX5z+fbtU1GWnc2WanZnqWBpOGXGZIMWd3R/5BwZ+XmSDfvJhApI=
X-Received: by 2002:a17:90b:180b:: with SMTP id lw11mr4655047pjb.6.1619168366920;
 Fri, 23 Apr 2021 01:59:26 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <bbe531db-6d59-d341-16ed-f48b1fd43d2a@163.com> <CA+WQbwvpviu3FAE06bO3CO2azAegzMi8YUXcQPPMBYM8nW7_cg@mail.gmail.com>
 <1b50d699-45ec-e747-983a-1966f64f8e1c@163.com> <CA+WQbwvzabuhsbKKHeWwa3raOfCh270sccdg6=18ytgPjjkaVw@mail.gmail.com>
 <CA+WQbwuSDvyJH+MT00Qvi73MhGoWcrg-AkZfPR56Zfaks2s1uQ@mail.gmail.com>
 <681e0810-fbbc-daaf-054a-0e83038b4d12@163.com> <3c3cf25d-aa4c-d522-102b-ebdd3b767cc0@tessares.net>
In-Reply-To: <3c3cf25d-aa4c-d522-102b-ebdd3b767cc0@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 23 Apr 2021 16:59:15 +0800
Message-ID: <CA+WQbwsPfUzejWRriaTR4t4wJctCXpS-T4Byf1LFG438MC5ZEw@mail.gmail.com>
Subject: Re: [PATCH] mptcp: create listening socket only if signal flag is set on
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B44=E6=
=9C=8823=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:21=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Jianguo, Geliang,
>
> Thank you for the patches and reviews!
>
> On 23/04/2021 09:41, Jianguo Wu wrote:
> >
> >
> > On 2021/4/23 15:27, Geliang Tang wrote:
> >> Geliang Tang <geliangtang@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=882=
3=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=883:17=E5=86=99=E9=81=93=EF=BC=
=9A
> >>>
> >>> Hi Jianguo,
> >>>
> >>> Jianguo Wu <wujianguo106@163.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:39=E5=86=99=E9=81=93=EF=BC=
=9A
> >>>>
> >>>>
> >>>>
> >>>> On 2021/4/23 12:33, Geliang Tang wrote:
> >>>>> Hi Jianguo,
> >>>>>
> >>>>> Thanks for your patch.
> >>>>>
> >>>>> Jianguo Wu <wujianguo106@163.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=882=
2=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:30=E5=86=99=E9=81=93=EF=BC=
=9A
> >>>>>>
> >>>>>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> >>>>>>
> >>>>>> PM announces address to remote host when signal flag is set,
> >>>>>> so create listening socket only if signal flag is set.
> >>>>>
> >>>>> This check has done in the user-space, here are these lines in pm_n=
l_ctl.c:
> >>>>>
> >>>>> 274                 } else if (!strcmp(argv[arg], "port")) {
> >>>>> 275                         u_int16_t port;
> >>>>> 276
> >>>>> 277                         if (++arg >=3D argc)
> >>>>> 278                                 error(1, 0, " missing port valu=
e");
> >>>>> 279                         if (!(flags & MPTCP_PM_ADDR_FLAG_SIGNAL=
))
> >>>>> 280                                 error(1, 0, " flags must be sig=
nal
> >>>>> when using port");
> >>>>>
> >>>>
> >>>> Hi Geliang, Thanks for point out this, I was use 'ip mptcp' to add a=
ddress, It doesn't seem to have done that check.
> >>>> Is it worth to do check in kernel to make sure there is a signal fla=
g before create listening socket?
> >>>
> >>> I think it's better to check this in the user-space, you can write a =
patch
> >>> to iproute2 to add this check in 'ip mptcp'.
> >>
> >> Or add this check in mptcp_pm_parse_addr, something like:
> >>
> >> $ git diff net/mptcp/pm_netlink.c
> >> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> >> index 6ba040897738..9cd4a4180a2a 100644
> >> --- a/net/mptcp/pm_netlink.c
> >> +++ b/net/mptcp/pm_netlink.c
> >> @@ -971,8 +971,14 @@ static int mptcp_pm_parse_addr(struct nlattr
> >> *attr, struct genl_info *info,
> >>         if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
> >>                 entry->flags =3D nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLA=
GS]);
> >>
> >> -       if (tb[MPTCP_PM_ADDR_ATTR_PORT])
> >> +       if (tb[MPTCP_PM_ADDR_ATTR_PORT]) {
> >> +               if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
> >> +                       NL_SET_ERR_MSG_ATTR("");
> >> +                       return -EINVAL;
> >> +               }
> >> +
> >>                 entry->addr.port =3D
> >> htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
> >> +       }
> >>
> >>         return 0;
> >>  }
> >>
> >> WDYT?
> >>
> >
> > I think this is better, we can't assume that all user-space tools works=
 correctly.
>
> I was thinking a bit about that. With the proposed modifications, it
> means that a server will have to send an ADD_ADDR if it wants to accept
> subflows on another port. I guess there will be use-cases where we will
> not want to send ADD_ADDR because we are in a controlled environment or
> we don't want to announce a public ADD_ADDR+port on a specific network.
>
> Do we have to support that? Maybe safer to restrict actions for now and
> allow that later if there are needs, no?
>
> In other words, I guess we should accept the proposed modifications.
> Any other points of view? :)

I think the proposed modifications is not enough.

If the port is set with non-signal flag (like subflow), we should not only
stop creating listening socket, but also stop appending this address.

Since our code can't deal with the ADD_SUBFLOW+port case (like
"pm_nl_ctl add 10.0.0.1 flag subflow port 1000"). Local address's port will
re-set as the main socket's port number in our code. So set port to a local
address is useless, we should add the flag check to avoid this case.

I think the flag check should be added both in mptcp_pm_parse_addr and in
'ip mptcp'. Let's waiting for Jianguo's new patches.

Thanks.

-Geliang

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
