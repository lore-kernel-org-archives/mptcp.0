Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CE470
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 07:17:45 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id lr7so6505043pjb.2
        for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 00:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k7q93qqAcVtm0RhdndTJfSp6FBG4+K/TkMTnUNA8spI=;
        b=toKfeF2LEilWcv3a0hrYMjaHXZFJF3aqoRVa/Qil1kKFPbACDrOLNpG7QWLaGojabb
         bRXQGIIWa4CSSicTcS1DvLZKdYVBYqxy3mjcudVN1i4kaqA57irxVrhbrG7alY7aT2Wh
         KtqvknMao7AM1iHrtqZ2PvnA3IKEhvrzJHBvWSCh0wC5eC1dhu4QLtSlEBPW3JctBq9P
         ceouREod7kb7iSq3RC4dIpyN/UC688KplrJGuFLaM1S8wV8UksKVOobJPTMH+7/LG6Vv
         OpBWtV7aQVGYvoxUx7uRaIPiO9DDmfuLo9kAfglU5uZa9Rpz4Wtr7YPUtM58S3DkpQYb
         X+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k7q93qqAcVtm0RhdndTJfSp6FBG4+K/TkMTnUNA8spI=;
        b=FBJL6RbLze3NdJWw2n3RfZoKLW5HqoKQaMQC5xrFOfetmJqA6MIxumBgIZJnDWC18y
         Vh/w6hoAkLP7SFmujgHuM2bwsNP0C6COsPWbswGQK4eKEzNxBcDQh1Aonv0z6aruegwg
         4jEs2dZ1yeRFmyBjzuxmwyysjsQxMgZmw2KQyWmd1XPlZ/iGX5ImKTW23Z/rc32L8TOM
         VhvSk+VcNZWQ4zUCws9scqGEtOrBBhlIg8VCxW/RpdQccOGUagauHlaGHhWnRpLJLwoD
         xG5FXy/R7gQ4PrWWrNNVGH+DbwgoKCA39fR9LTfymatdJCSMeBVNeoHMV5dwGX2HThXZ
         NKHw==
X-Gm-Message-State: AOAM532QGUaom2MRL7b3b9ov+Uia7enCFKbMCdUgU8HJnF059u7RggpD
	kWhOEKfUrkaXpa8Wjs2RNU8C4yzvS+J1Ywfc4KY=
X-Google-Smtp-Source: ABdhPJy0fJXu9AOczfmRTXfPWlA9qyV4xatq2wM+XOXjoYwaAOz0zUNMlnDFHlGzoE50PqVrW4+2FL+78FEeZPTf3pU=
X-Received: by 2002:a17:902:263:b029:ec:a39a:419b with SMTP id
 90-20020a1709020263b02900eca39a419bmr2431475plc.84.1619162264890; Fri, 23 Apr
 2021 00:17:44 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <bbe531db-6d59-d341-16ed-f48b1fd43d2a@163.com> <CA+WQbwvpviu3FAE06bO3CO2azAegzMi8YUXcQPPMBYM8nW7_cg@mail.gmail.com>
 <1b50d699-45ec-e747-983a-1966f64f8e1c@163.com>
In-Reply-To: <1b50d699-45ec-e747-983a-1966f64f8e1c@163.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 23 Apr 2021 15:17:33 +0800
Message-ID: <CA+WQbwvzabuhsbKKHeWwa3raOfCh270sccdg6=18ytgPjjkaVw@mail.gmail.com>
Subject: Re: [PATCH] mptcp: create listening socket only if signal flag is set on
To: Jianguo Wu <wujianguo106@163.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jianguo,

Jianguo Wu <wujianguo106@163.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:39=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2021/4/23 12:33, Geliang Tang wrote:
> > Hi Jianguo,
> >
> > Thanks for your patch.
> >
> > Jianguo Wu <wujianguo106@163.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8822=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:30=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> >>
> >> PM announces address to remote host when signal flag is set,
> >> so create listening socket only if signal flag is set.
> >
> > This check has done in the user-space, here are these lines in pm_nl_ct=
l.c:
> >
> > 274                 } else if (!strcmp(argv[arg], "port")) {
> > 275                         u_int16_t port;
> > 276
> > 277                         if (++arg >=3D argc)
> > 278                                 error(1, 0, " missing port value");
> > 279                         if (!(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
> > 280                                 error(1, 0, " flags must be signal
> > when using port");
> >
>
> Hi Geliang, Thanks for point out this, I was use 'ip mptcp' to add addres=
s, It doesn't seem to have done that check.
> Is it worth to do check in kernel to make sure there is a signal flag bef=
ore create listening socket?

I think it's better to check this in the user-space, you can write a patch
to iproute2 to add this check in 'ip mptcp'.

Thanks.

-Geliang

>
> > -Geliang
> >
> >>
> >> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port"=
)
> >> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> >> ---
> >>  net/mptcp/pm_netlink.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> >> index becc32b..dbd6910 100644
> >> --- a/net/mptcp/pm_netlink.c
> >> +++ b/net/mptcp/pm_netlink.c
> >> @@ -1025,7 +1025,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff =
*skb, struct genl_info *info)
> >>         }
> >>
> >>         *entry =3D addr;
> >> -       if (entry->addr.port) {
> >> +       if (entry->addr.port && (entry->flags & MPTCP_PM_ADDR_FLAG_SIG=
NAL)) {
> >>                 ret =3D mptcp_pm_nl_create_listen_socket(skb->sk, entr=
y);
> >>                 if (ret) {
> >>                         GENL_SET_ERR_MSG(info, "create listen socket e=
rror");
> >> --
> >> 1.8.3.1
> >>
> >>
>
