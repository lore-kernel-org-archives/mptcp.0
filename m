Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F42F80
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 15:40:20 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id y62so11370271pfg.4
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+5koqXM8bCgUD9NfoTXurDz5pcS31/f5MRuX7L5vvtY=;
        b=i+X29Cg++K4OFKzBlvcp/UfKW9+RaGEBwx8JzHR/7iqwyZtrEdpYqcuT1JD3XokWhO
         A6EiJXaS1MfZhedEUdS6SZ7C1fSMG8ZKDzmEiYS9T7A+dCvTZMiD/lFERIvclDzbHtUZ
         9h/YXuK/J/SeNKvw6+/37I2k3FH+LArWX76p0QTBqqZZunjhCBxBZrnLPfZx3/U8M3Y/
         h9za+hGpX8tNSrGPjFnLbumDJNo0Gr3IwsO7DaCjHAVzMuQJUOITIJ7c9JRgK8r4gzYM
         pHAZFf+eKfCl2bxRB0PlfEgKwdxdNQmp2aM7wZrg7JfCz1W/x6jZOu8iQ31fFCf/B6Ua
         fz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+5koqXM8bCgUD9NfoTXurDz5pcS31/f5MRuX7L5vvtY=;
        b=JEqKjcdMAz+UBq+6FAscTNqSZndtsOYbicdsbHZ/DbqZcsArpyemhd5gBpVr2uhUYh
         4U3yy+6XsHpYjCuyTkTWKtLb8+wQQKvtn19ibWb/u8WJVT9LQlGRyGgXwq/Zb9bBZsL4
         QFlfJ9VELmWBXeC/f73VzyTuRUb/4izAGtVziO2hcf5VirfaPjr14ltGZHy3KPIarYC5
         vgWivKPhj0Ulq1D/3I3X9qgV3IVjN9Yl/RXxG+t4TAYXf+CC6r0qV2JKuiw6LVwF6p34
         Aq5hGifiaiLS5LMycKTcfimSUv8+7UM3/OIarUp43dygsTXnnY12rhSqwCKzONvGHh5U
         RbvA==
X-Gm-Message-State: AOAM530io7XNVzyRNspp7v5v4x8xVQUNwlz5PkPgXxKPyCqDksk3+XEA
	yEiFfuVQdMda0dJFDrQlUsoVfEPxKaWfjXM1GZELOya6
X-Google-Smtp-Source: ABdhPJzFpKNZzo0h38GwUGbNGCtoCbdie/OCJ/vRUmc6BQIf69AqN0VQHlNExa+pYB8ENpI3Ci2XG4bjcBhLK/WOS2M=
X-Received: by 2002:a62:6544:0:b029:261:14cc:b11d with SMTP id
 z65-20020a6265440000b029026114ccb11dmr28500211pfb.12.1619624420475; Wed, 28
 Apr 2021 08:40:20 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1619592361.git.geliangtang@gmail.com> <51758a7f629764dc91186acbf09665992e5b8e69.1619592361.git.geliangtang@gmail.com>
 <20210428094043.GC975@breakpoint.cc>
In-Reply-To: <20210428094043.GC975@breakpoint.cc>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 28 Apr 2021 23:40:09 +0800
Message-ID: <CA+WQbwv2CQBrL4QhntQK9TjMLOGAW1ZP8wk72=mx_G0XC02Qkw@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v2 mptcp-next 1/4] mptcp: add sysctl allow_join_initial_addr_port
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Florian Westphal <fw@strlen.de> =E4=BA=8E2021=E5=B9=B44=E6=9C=8828=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Geliang Tang <geliangtang@gmail.com> wrote:
> > diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> > index 96ba616f59bf..3b963a25d5a8 100644
> > --- a/net/mptcp/ctrl.c
> > +++ b/net/mptcp/ctrl.c
> > @@ -19,6 +19,7 @@ struct mptcp_pernet {
> >
> >       int mptcp_enabled;
> >       unsigned int add_addr_timeout;
> > +     int allow_join_initial_addr_port;
>
> u8 allow_join_initial_addr_port;
>
> >  static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
> > @@ -36,6 +37,11 @@ unsigned int mptcp_get_add_addr_timeout(struct net *=
net)
> >       return mptcp_get_pernet(net)->add_addr_timeout;
> >  }
> >
> > +int mptcp_is_allow_join_id0(struct net *net)
> > +{
> > +     return mptcp_get_pernet(net)->allow_join_initial_addr_port;
> > +}
> > +
> >  static struct ctl_table mptcp_sysctl_table[] =3D {
> >       {
> >               .procname =3D "enabled",
> > @@ -52,6 +58,12 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
> >               .mode =3D 0644,
> >               .proc_handler =3D proc_dointvec_jiffies,
> >       },
> > +     {
> > +             .procname =3D "allow_join_initial_addr_port",
> > +             .maxlen =3D sizeof(int),
>
> sizeof(u8),
>
> > +             .mode =3D 0644,
> > +             .proc_handler =3D proc_dointvec,
>
> .proc_handler   =3D proc_dou8vec_minmax,
> .extra1         =3D SYSCTL_ZERO,
> .extra2         =3D SYSCTL_ONE

Updated in v3, thanks.

-Geliang
