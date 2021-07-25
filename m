Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8259173
	for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 13:50:49 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id e5so6571427pld.6
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 06:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2lnEnaCAsn5sppEftO4jlsmfaghVM+SRDErLiTXP08I=;
        b=LXYHCIhZFBbdsDtFDcYLLPzhJ2tRmjseGI2IlgXqqR/jM03VpyXbmxOO9n5Y6Y8lwQ
         rV43B8tcao4WzA++tqmKZi0MNZbH4sNMvcGThaZzgfP53QdK7gidS8g9AH2VhXhQC+G0
         KPKFOwXu8GQ6HunFiJ66XgdObKFDlAkSw1o+nGYuTZU3+2PA5EUPIEgVWaIl4JH33D/e
         Xw1zsO8p0Vq/Uwj8QnhY5oGOV0iSMVQE2gc30YE5wl2D0zVRYMfBjaRTqBVNMzuZ0bNP
         VqnCG2xwt4/STE4oQebyh3CsYioH+I9Lg/XKV+JruIfGupOnRwa8pTiPFD2ozGdAClpW
         sAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=2lnEnaCAsn5sppEftO4jlsmfaghVM+SRDErLiTXP08I=;
        b=HcXA4ZHORmeUP1HCVeohOcwhH5kXjadEBXaw00nMd5sc3YLZbDoXoFfO1WkyWei866
         qA0MWadq2F5Osaj9ezjc1XQyBw6Uzg1SlXsctizjQAnsmQbK8gvBcrTR8Vxr3iZgKTIw
         gAi0tsdnK/qGFvlJaV7DrkBH9oc9AO3JyTV2mQbuy7WSPWAtBaq06i1r7QeUbFUVz5up
         hao3Fxr9f0JTSQYS2E+pac2yzFQR0DgIE2Y/1MmlURk+HFBuqu9u9MY1C+gbHMZiFPc5
         Q0vN4XOPr0Iq7zdqgHQJuQKpRhCR0dYkEham2SOIyhoWakkTnrdirSkKeHc7D9MZgbrn
         sBpQ==
X-Gm-Message-State: AOAM532eoAbTpcMnkdf5otYsbroIIHWpw8ZesPD5ziAClhErkwhrvWKK
	+DrOOjActAnVZQd7WUu4AHa6eNeJvVblnw1DezfG3EHgK+rASA==
X-Google-Smtp-Source: ABdhPJyPZZrODFBX0GhbcfynwU2neHoiytYolNWtgM8FNmpioqCy5r9KWQiY/L5PBt5xmyFc3s+tQj+IUInhzyedA3U=
X-Received: by 2002:a63:ef12:: with SMTP id u18mr13723189pgh.331.1627221049215;
 Sun, 25 Jul 2021 06:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <313195dff50905ec809b66b2f195340dd80d68ff.1627219500.git.geliangtang@xiaomi.com>
In-Reply-To: <313195dff50905ec809b66b2f195340dd80d68ff.1627219500.git.geliangtang@xiaomi.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Sun, 25 Jul 2021 21:50:38 +0800
Message-ID: <CA+WQbwuYPTqNh0UmyE-vWhJ=iJdeVuoXKSpm3fbf2OGieOxM0Q@mail.gmail.com>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "Squash-to: mptcp: build
 ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Geliang Tang <geliangtang@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8825=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=889:41=E5=86=99=E9=81=93=EF=BC=9A
>
> Paolo's patch (Squash-to: "mptcp: build ADD_ADDR/echo-ADD_ADDR option
> according pm.add_signal") reverts back to a single 'addr' field in struct
> mptcp_addr_info.
>
> Then no need to change the argument of mptcp_pm_add_addr_signal and no
> need to modify the code in mptcp_write_options now, the original code is
> fine.
>
> So this patch reverts back more code.
>
> And the commit log needs to be updated:
>
> '''
> According to the MPTCP_ADD_ADDR_SIGNAL or MPTCP_ADD_ADDR_ECHO flag, build
> the ADD_ADDR/ADD_ADDR_ECHO option.
>
> In mptcp_pm_add_addr_signal(), use opts->remote or opts->local to save th=
e
> announced ADD_ADDR or ADD_ADDR_ECHO address.
> '''

Please update the commit log to:
'''
According to the MPTCP_ADD_ADDR_SIGNAL or MPTCP_ADD_ADDR_ECHO flag, build
the ADD_ADDR/ADD_ADDR_ECHO option.

In mptcp_pm_add_addr_signal(), use opts->addr to save the announced
ADD_ADDR or ADD_ADDR_ECHO address.
'''

>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  net/mptcp/options.c  | 25 ++++++++++++-------------
>  net/mptcp/pm.c       |  6 +++---
>  net/mptcp/protocol.h |  2 +-
>  3 files changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index eafdb9408f3a..cb29a5605776 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -668,7 +668,7 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
>         int len;
>
>         if (!mptcp_pm_should_add_signal(msk) ||
> -           !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts=
,
> +           !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &opt=
s->addr,
>                     &echo, &port, &drop_other_suboptions))
>                 return false;
>
> @@ -692,8 +692,8 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
>                                                      msk->remote_key,
>                                                      &opts->addr);
>         }
> -       pr_debug("addr_id=3D%d, addr_port=3D%d, ahmac=3D%llu, echo=3D%d",
> -                opts->addr.id, ntohs(opts->addr.port), opts->ahmac, echo=
);
> +       pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
> +                opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port)=
);
>
>         return true;
>  }
> @@ -1250,16 +1250,15 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
>
>  mp_capable_done:
>         if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> -               struct mptcp_addr_info *addr =3D &opts->addr;
>                 u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
>                 u8 echo =3D MPTCP_ADDR_ECHO;
>
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -               if (addr->family =3D=3D AF_INET6)
> +               if (opts->addr.family =3D=3D AF_INET6)
>                         len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>  #endif
>
> -               if (addr->port)
> +               if (opts->addr.port)
>                         len +=3D TCPOLEN_MPTCP_PORT_LEN;
>
>                 if (opts->ahmac) {
> @@ -1268,25 +1267,25 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
>                 }
>
>                 *ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> -                                     len, echo, addr->id);
> -               if (addr->family =3D=3D AF_INET) {
> -                       memcpy((u8 *)ptr, (u8 *)&addr->addr.s_addr, 4);
> +                                     len, echo, opts->addr.id);
> +               if (opts->addr.family =3D=3D AF_INET) {
> +                       memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_addr, =
4);
>                         ptr +=3D 1;
>                 }
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -               else if (addr->family =3D=3D AF_INET6) {
> -                       memcpy((u8 *)ptr, addr->addr6.s6_addr, 16);
> +               else if (opts->addr.family =3D=3D AF_INET6) {
> +                       memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16);
>                         ptr +=3D 4;
>                 }
>  #endif
>
> -               if (!addr->port) {
> +               if (!opts->addr.port) {
>                         if (opts->ahmac) {
>                                 put_unaligned_be64(opts->ahmac, ptr);
>                                 ptr +=3D 2;
>                         }
>                 } else {
> -                       u16 port =3D ntohs(addr->port);
> +                       u16 port =3D ntohs(opts->addr.port);
>
>                         if (opts->ahmac) {
>                                 u8 *bptr =3D (u8 *)ptr;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 5fe3805af02a..781da0885f98 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -257,7 +257,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bk=
up)
>
>  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *sk=
b,
>                               unsigned int opt_size, unsigned int remaini=
ng,
> -                             struct mptcp_out_options *opts, bool *echo,
> +                             struct mptcp_addr_info *saddr, bool *echo,
>                               bool *port, bool *drop_other_suboptions)
>  {
>         int ret =3D false;
> @@ -286,10 +286,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *ms=
k, struct sk_buff *skb,
>                 goto out_unlock;
>
>         if (*echo) {
> -               opts->addr =3D msk->pm.remote;
> +               *saddr =3D msk->pm.remote;
>                 add_addr =3D msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_EC=
HO);
>         } else {
> -               opts->addr =3D msk->pm.local;
> +               *saddr =3D msk->pm.local;
>                 add_addr =3D msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SI=
GNAL);
>         }
>         WRITE_ONCE(msk->pm.addr_signal, add_addr);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index b54335857b6e..099e3e6a4c89 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -801,7 +801,7 @@ static inline int mptcp_rm_addr_len(const struct mptc=
p_rm_list *rm_list)
>
>  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *sk=
b,
>                               unsigned int opt_size, unsigned int remaini=
ng,
> -                             struct mptcp_out_options *opts, bool *echo,
> +                             struct mptcp_addr_info *saddr, bool *echo,
>                               bool *port, bool *drop_other_suboptions);
>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remain=
ing,
>                              struct mptcp_rm_list *rm_list);
> --
> 2.31.1
>
