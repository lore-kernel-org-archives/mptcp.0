Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2C570
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 07:27:47 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id c3so14731803pfo.3
        for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 00:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j3gphxEO3K44yZimo3m5TVXYyIQOmzIHufQTX/EFytg=;
        b=FvOZHkVRbOtOc53IgI6KKpRJoddC6XJaZW5GT3FitfM430hS5QP3HSewftr5qMXB/M
         yihLJ62y7Tq78oeedtgKpx3QGfPa3nF+LtDITTIlnXuQ8j3jf01C6UGSBOtq/mPUiSXi
         aOTPAH5wfrPgoqqsynOqHnPhUZTV9Zz41dk2SI2bMKKjb7YUUEz+eXJzy0AQr0jx+Gnt
         8NNdyMvcWzsGYtpIImw7Vjbv/I0jXFp5LVLJMaxCne9BCKdG1Sl2u/FLnbQocUWgeVLp
         UX9T3PqQ5cOj91PI4tY/rhLLMt/mBrbUcJRmdfCwThyrBccC+ldBg2pWhED27Xt9bqqA
         D99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j3gphxEO3K44yZimo3m5TVXYyIQOmzIHufQTX/EFytg=;
        b=bHFkXZh2+VCP68XS9GfazF4tdl+17DhrIIOJELGTmOf71h7quvND9TQmw373fq38yD
         wUAMHmSKbGfc3P19rQwPq9otKSOAwMCOoWgwwnol1mBqW+gdtMs9xhBmWbx8aW5bG3kG
         QHJHaH/ggzNDrlkt2SUn3STDt2YgFadPSJr99R0jzsYb77KaLa16h/Inwsh+t9rEraun
         AdGFwisuILctLkZ8TRqwCn62IEHY6UgXgSP5yEOrmZ8I2vCa9rfAPOIPBJbL9vB619ES
         fLkqvZU1+a2dM8fd2AA9O+xZCdLbhjYThUKfI5tvq8ibb7h1bJ55cz02TmElceagnpo3
         eG8g==
X-Gm-Message-State: AOAM532Q7NsLuUXQXiy0Uq5xamjI/y21fjb1XYX7ermqUXuWENZWVZQM
	KbeFT4VKkRSvogatLEnl2fKTCs/Cwlax61qBfOk=
X-Google-Smtp-Source: ABdhPJxIcR+4h4O37eVvn/T4sAng9aRzbeFJTT1w9yRY6EWtOXXf9vEpkJyROnY+S0QqINJ2uf0SM+O0hFarsl3TfSE=
X-Received: by 2002:a65:468d:: with SMTP id h13mr2436583pgr.373.1619162866737;
 Fri, 23 Apr 2021 00:27:46 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <bbe531db-6d59-d341-16ed-f48b1fd43d2a@163.com> <CA+WQbwvpviu3FAE06bO3CO2azAegzMi8YUXcQPPMBYM8nW7_cg@mail.gmail.com>
 <1b50d699-45ec-e747-983a-1966f64f8e1c@163.com> <CA+WQbwvzabuhsbKKHeWwa3raOfCh270sccdg6=18ytgPjjkaVw@mail.gmail.com>
In-Reply-To: <CA+WQbwvzabuhsbKKHeWwa3raOfCh270sccdg6=18ytgPjjkaVw@mail.gmail.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 23 Apr 2021 15:27:35 +0800
Message-ID: <CA+WQbwuSDvyJH+MT00Qvi73MhGoWcrg-AkZfPR56Zfaks2s1uQ@mail.gmail.com>
Subject: Re: [PATCH] mptcp: create listening socket only if signal flag is set on
To: Jianguo Wu <wujianguo106@163.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Geliang Tang <geliangtang@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=883:17=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Jianguo,
>
> Jianguo Wu <wujianguo106@163.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:39=E5=86=99=E9=81=93=EF=BC=9A
> >
> >
> >
> > On 2021/4/23 12:33, Geliang Tang wrote:
> > > Hi Jianguo,
> > >
> > > Thanks for your patch.
> > >
> > > Jianguo Wu <wujianguo106@163.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8822=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:30=E5=86=99=E9=81=93=EF=BC=
=9A
> > >>
> > >> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> > >>
> > >> PM announces address to remote host when signal flag is set,
> > >> so create listening socket only if signal flag is set.
> > >
> > > This check has done in the user-space, here are these lines in pm_nl_=
ctl.c:
> > >
> > > 274                 } else if (!strcmp(argv[arg], "port")) {
> > > 275                         u_int16_t port;
> > > 276
> > > 277                         if (++arg >=3D argc)
> > > 278                                 error(1, 0, " missing port value"=
);
> > > 279                         if (!(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
> > > 280                                 error(1, 0, " flags must be signa=
l
> > > when using port");
> > >
> >
> > Hi Geliang, Thanks for point out this, I was use 'ip mptcp' to add addr=
ess, It doesn't seem to have done that check.
> > Is it worth to do check in kernel to make sure there is a signal flag b=
efore create listening socket?
>
> I think it's better to check this in the user-space, you can write a patc=
h
> to iproute2 to add this check in 'ip mptcp'.

Or add this check in mptcp_pm_parse_addr, something like:

$ git diff net/mptcp/pm_netlink.c
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6ba040897738..9cd4a4180a2a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -971,8 +971,14 @@ static int mptcp_pm_parse_addr(struct nlattr
*attr, struct genl_info *info,
        if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
                entry->flags =3D nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);

-       if (tb[MPTCP_PM_ADDR_ATTR_PORT])
+       if (tb[MPTCP_PM_ADDR_ATTR_PORT]) {
+               if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+                       NL_SET_ERR_MSG_ATTR("");
+                       return -EINVAL;
+               }
+
                entry->addr.port =3D
htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
+       }

        return 0;
 }

WDYT?

-Geliang


>
> Thanks.
>
> -Geliang
>
> >
> > > -Geliang
> > >
> > >>
> > >> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new por=
t")
> > >> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> > >> ---
> > >>  net/mptcp/pm_netlink.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > >> index becc32b..dbd6910 100644
> > >> --- a/net/mptcp/pm_netlink.c
> > >> +++ b/net/mptcp/pm_netlink.c
> > >> @@ -1025,7 +1025,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buf=
f *skb, struct genl_info *info)
> > >>         }
> > >>
> > >>         *entry =3D addr;
> > >> -       if (entry->addr.port) {
> > >> +       if (entry->addr.port && (entry->flags & MPTCP_PM_ADDR_FLAG_S=
IGNAL)) {
> > >>                 ret =3D mptcp_pm_nl_create_listen_socket(skb->sk, en=
try);
> > >>                 if (ret) {
> > >>                         GENL_SET_ERR_MSG(info, "create listen socket=
 error");
> > >> --
> > >> 1.8.3.1
> > >>
> > >>
> >
