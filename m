Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586070
	for <mptcp@lists.linux.dev>; Thu, 15 Jul 2021 03:17:53 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id s18so4593764pgq.3
        for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 20:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RB5UdF/oiL+P/aPkxZCIC+yoXamHE09r9gsuuuPj1O0=;
        b=FY2+Lneti7Ve+jF6yCAT8gGCFIM9XuQSHdtiQlZM/+IoHa5tgbtIWqsPRSIX4W35Nz
         46lcEARh4cPf+XIYOAVDjH29A/urFSWExwMG7CgV/IW8YQQyytSL+h1mVt26NbxjaTVd
         suzm8kYiMobsWj+OonmXPfxYVBhJTZEGrMlEsBawmpWozEK+L0MDmb76tvabCoBlMcyT
         7/q4w0OK15UVZ0DEbWwo51F0xChTStM24ZRpSnmGHJI4Lm4wzU6QVyTqcm0rP8kZGaJP
         FWd8p1j4h8Cnat+ojkqXGOH4VY5rqpnhPserTkYWMeuFskQOpEvhyDznfA/M2dtKQzEm
         mGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RB5UdF/oiL+P/aPkxZCIC+yoXamHE09r9gsuuuPj1O0=;
        b=s87tOjAt5xYj9196tp6QnjRLCsnAz9JMHlpZ7aPmkzkggirNGBcA5BkUCgM+zGj2yr
         NA+RBY4G7rY70kXRoGZk0YwMxfHZ1lcltINM2V3oYWZk5+7+YsKuq2Xunn9Esz33r63n
         E6CNfU09x74W2cYSi3sRygqUKCy88tlc2EXyk9aAT2DnG2dbQVp8xXY58wVXHP/zXBP1
         n7ez37e41d3Ev686UN+wkvaBVJJtSDAvqCQmCAD9CDLi5oJ9nq0pMhu4jNK/9rafgy94
         tozK8snHRRy3BoCGsX6jhK5sPb33DVyP3EL//r2F14sgfj6cmBL9i9b8i//UHyZr1SgJ
         xVNw==
X-Gm-Message-State: AOAM531fVTVxwaHQQveqCIrRt56P7NeJM9SLxaZmOk4gY56zxPgl7+Ap
	QqUh+SPIeG16F8fCHY83GhZ3M3eKTyjev+MAo+k=
X-Google-Smtp-Source: ABdhPJwzF/6MzfcMbkuVtQ3wWIRZqBnSXPXk/Qrwxa7wj+ukcQWptVR9nusbSXy9PDM+TxZXcou3Ng3DeBotN+haaDw=
X-Received: by 2002:a62:3344:0:b029:25e:a0a8:1c51 with SMTP id
 z65-20020a6233440000b029025ea0a81c51mr1707741pfz.58.1626319073083; Wed, 14
 Jul 2021 20:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <756dcceaa255c54b7bd195c719ede1f7ae791eb3.1626158100.git.geliangtang@gmail.com>
 <f0920ba1126ff81aa1acbff47e805e5573c64abc.1626158123.git.geliangtang@gmail.com>
 <CA+WQbwtGmfH7JtZUAUN7deZwVwJ=9o_7dZCk=7gC7h63sQMMZA@mail.gmail.com> <656b5aa6-f697-a35-2aa6-53ec2aec2cfc@linux.intel.com>
In-Reply-To: <656b5aa6-f697-a35-2aa6-53ec2aec2cfc@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 15 Jul 2021 11:17:41 +0800
Message-ID: <CA+WQbwu7s3B2pjpbpfcDYV_215=j=7c59A8M1XxG4m0xVOsAWg@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: build
 ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=B47=
=E6=9C=8814=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=884:39=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Tue, 13 Jul 2021, Geliang Tang wrote:
>
> > This squash-to patch will conflict with "mptcp: remove
> > MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT":
> >
> > Auto-merging net/mptcp/protocol.h
> > CONFLICT (content): Merge conflict in net/mptcp/protocol.h
> > Auto-merging net/mptcp/pm.c
> > error: could not apply bf1fec79a2bf... mptcp: remove
> > MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT
> >
> > Please fix it like this:
> >
> > <<<<<<< HEAD
> > static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *m=
sk)
> > {
> >         return (mptcp_pm_should_add_signal_addr(msk) &&
> > msk->pm.local.family =3D=3D AF_INET6) ||
> >                 (mptcp_pm_should_add_signal_echo(msk) &&
> > msk->pm.remote.family =3D=3D AF_INET6);
> > }
> >
> > static inline bool mptcp_pm_should_add_signal_port(struct mptcp_sock *m=
sk)
> > {
> >         return (mptcp_pm_should_add_signal_addr(msk) && msk->pm.local.p=
ort) ||
> >                 (mptcp_pm_should_add_signal_echo(msk) && msk->pm.remote=
.port);
> > }
> >
> > =3D=3D=3D=3D=3D=3D=3D
> > >>>>>>> bf1fec79a2bf (mptcp: remove MPTCP_ADD_ADDR_IPV6 and
> > MPTCP_ADD_ADDR_PORT)
> > static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
> > {
> >         return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNA=
L);
> > }
> >
> > ->
> >
> > static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *m=
sk)
> > {
> >         return (mptcp_pm_should_add_signal_addr(msk) &&
> > msk->pm.local.family =3D=3D AF_INET6) ||
> >                 (mptcp_pm_should_add_signal_echo(msk) &&
> > msk->pm.remote.family =3D=3D AF_INET6);
> > }
> >
> > static inline bool mptcp_pm_should_add_signal_port(struct mptcp_sock *m=
sk)
> > {
> >         return (mptcp_pm_should_add_signal_addr(msk) && msk->pm.local.p=
ort) ||
> >                 (mptcp_pm_should_add_signal_echo(msk) && msk->pm.remote=
.port);
> > }
> >
> > static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
> > {
> >         return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNA=
L);
> > }
> >
> >
>
> Well, it looks like I gave my Reviewed-by tag too soon. I think it would
> be easier to get the correct results by posting more revisions of the
> patch set - don't want to introduce mistakes when trying to resolve these
> conflicts when applying to mptcp_net-next repo!
>
> Geliang and Yonglong, what do you think about posting v9, possibly with
> co-developed-by tags?
>

Sounds good. I'll send a v9, with my co-developed-by tags, and keep Yonglon=
g
as the author, when the code is ready and the test passes.

Thanks,
-Geliang

>
> --
> Mat Martineau
> Intel
