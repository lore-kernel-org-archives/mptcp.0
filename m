Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007C72
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 12:36:50 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id m1so17539318pjv.2
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 05:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IEForLWb8ubYpQqBBinSYAvwYvBAzCNml+j+8eLcEyY=;
        b=fMZgD/29+WRTPEC7W/9Cs3qy5zpj//WbeYMuibMQWwWu8iZGU+WM3aEGvwE8GRIR9O
         V9VivZNYKy0lPWendzfi2ZIi8jY+J3l9s54EET6iSvfPlPlW8t3YYIfmK6yuNcKRNkQy
         GAKfR2Vd09hEvs1rNOM2FkWa3K5FE/M3ndFYP5YEGw43d960CAmVkX571rR7BRzu6rbR
         aLxKH/u2hcyfgVPuNmAx2bBg3e0F7Y06J2alk+2Wo0T52QBTEBk15yK+W9rvNFuEejDN
         68J7QrDYSe667ZWx5cfOuqcPhcbPhEshZJI3c29H4bjatnZ+k7D0apE+wU6MkuCbhhqh
         /H/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IEForLWb8ubYpQqBBinSYAvwYvBAzCNml+j+8eLcEyY=;
        b=mW5lPpcxZM5+itylhX1jWIM9G8a5fvhbubhgxKoF1JoigUPwFK4aHhrw9/1lcXYXry
         7DUSM4sykQvmfJLaZkUHMWyKjlVFWGmIFuwKAr746Pt76mPRyb9oQ3Jpf90Ao+I0Ci6w
         H/1FgbD3ZzdSJgHp0YTNAoMyHxBfBz5BXGsB0sfE1WjkoU4j682tcELxW3hpcmI5bJCb
         p7BcJqadEmQ6nFa3PyrjTsYtyL1UI4K6wm7R/iuSvGolsT+L0p58CMouwF2ERLQb5eMP
         siUVBO/CIpW8CDAMJ0HxLxjV48tdSXw4w2evIRQgYHvV69Pt2jKTXZJAYp4LFYY1bVxJ
         YgzQ==
X-Gm-Message-State: AOAM530dVJP1IM3O6h5UnURJA365uJndDKtuR/Th0Mk8YEqTgurorLFQ
	0AF9iL6t4g2UyE6GCV67diRxkE9LVpPWa++lO+M=
X-Google-Smtp-Source: ABdhPJw0FEGN8u3NbmL7ETIxtELFK9mwGlG4HZJqadrOBu1dirbYZWZwqgZZE1Be5+ZICyfLmfqashOkmzwFgZD3EBQ=
X-Received: by 2002:a63:34a:: with SMTP id 71mr23326047pgd.289.1627389410438;
 Tue, 27 Jul 2021 05:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1627372396.git.geliangtang@xiaomi.com> <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com>
 <ca9473da6544d61bc5f0271fbab57fc113b6020d.camel@redhat.com>
In-Reply-To: <ca9473da6544d61bc5f0271fbab57fc113b6020d.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 27 Jul 2021 20:36:39 +0800
Message-ID: <CA+WQbwuo4LaKoiEYS51r6jgaFFM24AaFMfvkhS=FjUPWA-mX1g@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v5 mptcp-next 1/5] mptcp: remote addresses fullmesh
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8827=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> On Tue, 2021-07-27 at 15:58 +0800, Geliang Tang wrote:
> > From: Geliang Tang <geliangtang@xiaomi.com>
> >
> > This patch added and managed a new per endpoint flag, named
> > MPTCP_PM_ADDR_FLAG_FULLMESH.
> >
> > In mptcp_pm_create_subflow_or_signal_addr(), if such flag is set, inste=
ad
> > of:
> >
> >         remote_address((struct sock_common *)sk, &remote);
> >
> > fill a temporary allocated array of all known remote address. After
> > releaseing the pm lock loop on such array and create a subflow for each
> > remote address from the given local.
> >
> > Note that the we could still use an array even for non 'fullmesh'
> > endpoint: with a single entry corresponding to the primary MPC subflow
> > remote address.
> >
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> > ---
> >  include/uapi/linux/mptcp.h |  1 +
> >  net/mptcp/pm_netlink.c     | 80 +++++++++++++++++++++++++++++++++++---
> >  2 files changed, 76 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> > index 7b05f7102321..f66038b9551f 100644
> > --- a/include/uapi/linux/mptcp.h
> > +++ b/include/uapi/linux/mptcp.h
> > @@ -73,6 +73,7 @@ enum {
> >  #define MPTCP_PM_ADDR_FLAG_SIGNAL                    (1 << 0)
> >  #define MPTCP_PM_ADDR_FLAG_SUBFLOW                   (1 << 1)
> >  #define MPTCP_PM_ADDR_FLAG_BACKUP                    (1 << 2)
> > +#define MPTCP_PM_ADDR_FLAG_FULLMESH                  (1 << 3)
> >
> >  enum {
> >       MPTCP_PM_CMD_UNSPEC,
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index ba0e1d71504d..2259c424485f 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -158,6 +158,27 @@ static bool lookup_subflow_by_daddr(const struct l=
ist_head *list,
> >       return false;
> >  }
> >
> > +static bool lookup_subflow_by_addrs(const struct list_head *list,
> > +                                 struct mptcp_addr_info *saddr,
> > +                                 struct mptcp_addr_info *daddr)
> > +{
> > +     struct mptcp_subflow_context *subflow;
> > +     struct mptcp_addr_info local, remote;
> > +     struct sock_common *skc;
> > +
> > +     list_for_each_entry(subflow, list, node) {
> > +             skc =3D (struct sock_common *)mptcp_subflow_tcp_sock(subf=
low);
> > +
> > +             local_address(skc, &local);
> > +             remote_address(skc, &remote);
> > +             if (addresses_equal(&local, saddr, saddr->port) &&
> > +                 addresses_equal(&remote, daddr, daddr->port))
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
>
> I'm sorry for not noticing this earlier, do we need this function and
> the related check in fill_remote_addresses_vec()?
>
> 'saddr' is the return value of select_local_address(), so existing
> subflows is bound to such address.

I'll drop lookup_subflow_by_addrs() in v6.

>
> > +
> >  static struct mptcp_pm_addr_entry *
> >  select_local_address(const struct pm_nl_pernet *pernet,
> >                    struct mptcp_sock *msk)
> > @@ -410,6 +431,53 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *ms=
k)
> >       }
> >  }
> >
> > +static bool lookup_address_in_vec(struct mptcp_addr_info *addrs, unsig=
ned int nr,
> > +                               struct mptcp_addr_info *addr)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < nr; i++) {
> > +             if (addresses_equal(&addrs[i], addr, addr->port))
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
> > +                                           struct mptcp_pm_addr_entry =
*local,
> > +                                           struct mptcp_addr_info *add=
rs)
> > +{
> > +     struct sock *sk =3D (struct sock *)msk, *ssk;
> > +     struct mptcp_subflow_context *subflow;
> > +     struct mptcp_addr_info remote =3D { 0 };
>
> Minor nit: no need to initialize the 'remote' variable

This id filed of 'remote' need to initialize, otherwise it will be a random
number.

>
> Cheers,
>
> Paolo
>
