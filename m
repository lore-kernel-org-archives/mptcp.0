Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB06173
	for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 13:40:25 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so15874932pja.5
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 06:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=28IdUrn/kz37qq/E262swCtjSltV57XBwtcAsYzfnak=;
        b=jCMceOkmYlXq44CRNLnHRQ5H/UaLr/JiovGc2dEw+tbR8RD9WQ/BsTsQElTnazkdb2
         rJGM1wv8dNhxJaEOP6fhGKpbhAkxkWAOifk19wGANJxMqDZHNswQrDK5xGn0ddMV43PJ
         icoyW5TIEYbx0tGzaPDPVGk69iPs1yEJHcElVfdlYY7M/sGaCWCJp7EZdrxUvi7KqLr+
         eTKJ/6x2PVesUmtak2yYWRNkDK79VfTia91SFyQQO336t9NivNZs2xt/3CfZBjrSOnVc
         Jj1XDF3M4juth9KPN18LDOCFGjx3csIckjYR1tgEMS2XPdYNGZkGptmutaKEPyQ0/hFy
         uj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=28IdUrn/kz37qq/E262swCtjSltV57XBwtcAsYzfnak=;
        b=U165SDSOjvHHmp/Vq443p/JMLrBDbq4XbQJGM7qP7w/7AZf6cz7ZHK7WD1dttXG71R
         26y5JLrE+nDiW7KFP3eR59HXpQEwgKrpxhEp1tETWVITeYJn6IT4o0osxaJHV6+bnbel
         fbbPQFnmMtibIIP1xSNcYmsHLrrS6EGcmjjQ69zKEg4E7loOCRuaQYmVCusyQsGx0CKH
         nTi5PSFSV18T1jx58JppEHfw5MngASDF3KgdYIhZTCtB5h/32vjUkfGrOYtC/2IX/rZF
         YeyJxyRcXR0PWwA0Mgfo8oLAYE6lFME98JBRsdU/4zvdrWrBdfVrN28xEdS3BC0x4tff
         JC5A==
X-Gm-Message-State: AOAM530NWPWFN79LWqbI+IwQC1hOi0SHwq45FRmd3GBCkeuMa+0WfLVV
	ZWYKfaheDNk+JIadYqf9Es+PC77qGNg13DfPlj8=
X-Google-Smtp-Source: ABdhPJw77bspuB0srmSNzuhDatzbsl6M34QIc23uEueyF2v0Lmtuu/TDBbk/QHPWmTPj9cORuToU+wO7Rt+lQ8Ix8TM=
X-Received: by 2002:aa7:8387:0:b029:395:a683:a0e6 with SMTP id
 u7-20020aa783870000b0290395a683a0e6mr2139075pfm.12.1627220424665; Sun, 25 Jul
 2021 06:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <4206e5473ed255fa08af48a7b5bc0edd00abb99d.1627047074.git.pabeni@redhat.com>
In-Reply-To: <4206e5473ed255fa08af48a7b5bc0edd00abb99d.1627047074.git.pabeni@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Sun, 25 Jul 2021 21:40:13 +0800
Message-ID: <CA+WQbwvLoHcihvPs8pVvTuOXTrVenPFOMR=wy1E0KrT1ur4yFg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: build ADD_ADDR/echo-ADD_ADDR
 option according pm.add_signal"
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Yonglong Li <liyonglong@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8823=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:31=E5=86=99=E9=81=93=EF=BC=9A

>
> We don't need to add a 2nd mptcp_addr_info inside out_options:
> it's quite huge and only one of local or remote is used.
>
> revert back to a single 'addr' field.

Acked-and-tested-by: Geliang Tang <geliangtang@gmail.com>

I think more code needs to be revert too, no need to change the argument
of mptcp_pm_add_addr_signal and no need to modify the code in
mptcp_write_options. And the commit log need to update.

I'll sent another squash-to patch to do these cleanups.

Thanks,
-Geliang

>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  include/net/mptcp.h |  3 +--
>  net/mptcp/options.c | 13 +++++--------
>  net/mptcp/pm.c      |  4 ++--
>  3 files changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index d0b9e4a7121f..8b5af683a818 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -61,8 +61,7 @@ struct mptcp_out_options {
>         u64 sndr_key;
>         u64 rcvr_key;
>         u64 ahmac;
> -       struct mptcp_addr_info local;
> -       struct mptcp_addr_info remote;
> +       struct mptcp_addr_info addr;
>         struct mptcp_rm_list rm_list;
>         u8 join_id;
>         u8 backup;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 6803de5d4209..eafdb9408f3a 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -665,7 +665,6 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
>         unsigned int opt_size =3D *size;
>         bool echo;
>         bool port;
> -       u8 family;
>         int len;
>
>         if (!mptcp_pm_should_add_signal(msk) ||
> @@ -675,8 +674,7 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
>
>         if (drop_other_suboptions)
>                 remaining +=3D opt_size;
> -       family =3D echo ? opts->remote.family : opts->local.family;
> -       len =3D mptcp_add_addr_len(family, echo, port);
> +       len =3D mptcp_add_addr_len(opts->addr.family, echo, port);
>         if (remaining < len)
>                 return false;
>
> @@ -692,11 +690,10 @@ static bool mptcp_established_options_add_addr(stru=
ct sock *sk, struct sk_buff *
>         if (!echo) {
>                 opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
>                                                      msk->remote_key,
> -                                                    &opts->local);
> +                                                    &opts->addr);
>         }
> -       pr_debug("local_id=3D%d, local_port=3D%d, remote_id=3D%d, remote_=
port=3D%d, ahmac=3D%llu, echo=3D%d",
> -                opts->local.id, ntohs(opts->local.port), opts->remote.id=
,
> -                ntohs(opts->remote.port), opts->ahmac, echo);
> +       pr_debug("addr_id=3D%d, addr_port=3D%d, ahmac=3D%llu, echo=3D%d",
> +                opts->addr.id, ntohs(opts->addr.port), opts->ahmac, echo=
);
>
>         return true;
>  }
> @@ -1253,7 +1250,7 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
>
>  mp_capable_done:
>         if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> -               struct mptcp_addr_info *addr =3D opts->ahmac ? &opts->loc=
al : &opts->remote;
> +               struct mptcp_addr_info *addr =3D &opts->addr;
>                 u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
>                 u8 echo =3D MPTCP_ADDR_ECHO;
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 692614c1f552..4d1828fd2482 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -282,10 +282,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *ms=
k, struct sk_buff *skb,
>                 goto out_unlock;
>
>         if (*echo) {
> -               opts->remote =3D msk->pm.remote;
> +               opts->addr =3D msk->pm.remote;
>                 add_addr =3D msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_EC=
HO);
>         } else {
> -               opts->local =3D msk->pm.local;
> +               opts->addr =3D msk->pm.local;
>                 add_addr =3D msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SI=
GNAL);
>         }
>         WRITE_ONCE(msk->pm.addr_signal, add_addr);
> --
> 2.26.3
>
