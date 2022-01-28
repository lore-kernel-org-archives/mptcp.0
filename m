Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9180D29CA
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 08:18:45 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id i30so5461850pfk.8
        for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K4+/a9z4vQmLJDdkZedymc3VudaZchiRBds4Off36/U=;
        b=LAOst5RkqhvfpwiZ5nBCexf5tRLYo6glvNH6mlBqr0ZorrWmkL7ZmAJYFaUE83Hndi
         88lvltVAOpRrmBCLXGOch0jL/GOjN00Fw39+Mplo5/6L5Ecj9rWyVykBf0jq5I3Ht0BS
         8mL7GowyLpKOc9AQNVhp8NTC2Z2hspP8nvOgpkWNmz5W+0I9LjsyHdAh9HKuXKQcn0XM
         FkeD77Y+u+j50ec04b8OM+t/3Kwh7o5c25zqEAXw165+wiPcViUbGU/T6xbhEnpKyJ05
         v6evzDL2/ZXmPsZfAvaGP3xIDI+PZChSg/M0RtOV7wm6aVIMz4y3xj12Ky5XSFTFUVbe
         iECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K4+/a9z4vQmLJDdkZedymc3VudaZchiRBds4Off36/U=;
        b=RbAuGrwFPyJsQa0mTC8deX6SOT4YAoVnpxKejxL6B13SxMAkkBrZUZ35d6OJo6j6MO
         6KWiDHCD+99BV6A2odaRlWDUPFknYfrWXzxf7JYaPVodN9b7mDpFn1Yz6h8aX+mkDTrO
         QV2QUR8kHUkgki3TeeHQPv9NIQETUGH54KHRG103o1Y0xKxM8bU2ymnFd5InB6tscwRf
         huNlDgm7WrRAEW/cVd6cbAIddH1omLRmTFxyCkFB44XXmoRad8RGbodxJMrveBE/pKxW
         NVj8TctRCMJdHuEkQjk2S1YInv2rLSTG/b+ZZLExzEGIHjtNCBA6lQot2QuElAIZtxbp
         LFhA==
X-Gm-Message-State: AOAM532ML7P1fHy0686NB1danK4orAlyTXw+jrrW2XmxttN05oZrBfAJ
	5Hes4kK3yWRenYc2uQejLkv/Yo9xt+lbv1cP+RY=
X-Google-Smtp-Source: ABdhPJz5LUAZs0zXem8xzEMWVJM8G+MHgm1HUpj32Bczm5fkdMfx87wK33peyyE4fZ7FqKhlDd06qFAyUUjMTesTAQc=
X-Received: by 2002:a05:6a00:ccc:: with SMTP id b12mr7064624pfv.10.1643357924820;
 Fri, 28 Jan 2022 00:18:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220128003746.2732527-1-kishen.maloor@intel.com> <ba1702d-2951-132b-7fda-4ed1045dcd@linux.intel.com>
In-Reply-To: <ba1702d-2951-132b-7fda-4ed1045dcd@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 28 Jan 2022 16:18:54 +0800
Message-ID: <CA+WQbwvVGsbkdZc9wNkC5DB2YLFnBqzv5hw3nDR_NTBZkqC5vg@mail.gmail.com>
Subject: Re: [PATCH mptcp-net v3] mptcp: netlink: process IPv6 addrs in
 creating listening sockets
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Kishen Maloor <kishen.maloor@intel.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2022=E5=B9=B41=
=E6=9C=8828=E6=97=A5=E5=91=A8=E4=BA=94 10:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 27 Jan 2022, Kishen Maloor wrote:
>
> > This change updates mptcp_pm_nl_create_listen_socket() to create
> > listening sockets bound to IPv6 addresses (where IPv6 is supported).
> >
> > Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")

Acked-by: Geliang Tang <geliang.tang@suse.com>

> > Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> > ---
> > net/mptcp/pm_netlink.c | 8 ++++++--
> > 1 file changed, 6 insertions(+), 2 deletions(-)
> >
>
> Looks good for the export branch:
>
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 5eac5bde5b49..93800f32fcb6 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -925,6 +925,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct=
 pm_nl_pernet *pernet,
> > static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> >                                           struct mptcp_pm_addr_entry *e=
ntry)
> > {
> > +     int addrlen =3D sizeof(struct sockaddr_in);
> >       struct sockaddr_storage addr;
> >       struct mptcp_sock *msk;
> >       struct socket *ssock;
> > @@ -949,8 +950,11 @@ static int mptcp_pm_nl_create_listen_socket(struct=
 sock *sk,
> >       }
> >
> >       mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
> > -     err =3D kernel_bind(ssock, (struct sockaddr *)&addr,
> > -                       sizeof(struct sockaddr_in));
> > +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > +     if (entry->addr.family =3D=3D AF_INET6)
> > +             addrlen =3D sizeof(struct sockaddr_in6);
> > +#endif
> > +     err =3D kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
> >       if (err) {
> >               pr_warn("kernel_bind error, err=3D%d", err);
> >               goto out;
> >
> > base-commit: 05854a699d27b11d8fb3217ec2e0dbf28ecb58e8
> > --
> > 2.31.1
> >
> >
> >
>
> --
> Mat Martineau
> Intel
>
