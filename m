Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171C71
	for <mptcp@lists.linux.dev>; Fri, 18 Jun 2021 11:20:13 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id o10-20020a17090aac0ab029016e92770073so5667005pjq.5
        for <mptcp@lists.linux.dev>; Fri, 18 Jun 2021 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W7VZ+MDHx5zBwxk6oFIXH7AO9FZbT4OSVXLt9sPCZ6g=;
        b=cTnduhjAoHCT9pHG/hfj9LxZON4mt6Q97bwgqhjizxPcmPm0XPS43hhRylQlb6Q+Hc
         GmgI8mT6SXUXILHAEwwZUjnjNuqYU5PeVPat2Dqi+UKLyLFeZVjbTeAIjEUh8UOJHJOr
         UNgztlkNmf9fSHojKeLGoaJ2ntXioSk0G5vB3MpPElxOwn6ilteftHvx+7nVkkJWd49r
         P/uJnuS/a4SPkaBZG/jBenqlyycZOJ5+5UUiz9e33M34X0FYGE/UCtAc3li4wUqyTueS
         aSp+z6dxewUqAFES8jPV9zHQuFAnfKKpLzv1lneRWDQfQMmlbs4G14ZnRolxHIF7kfiG
         faxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W7VZ+MDHx5zBwxk6oFIXH7AO9FZbT4OSVXLt9sPCZ6g=;
        b=VudO/gomHeO3/aYh+LG0b+zRgAN1ZSM2yWEGGLvcZhvJk/Gbcb4D/gK6ngxMPerVQ/
         ySWkJqoldkT5xsFGDMXb4Ff/2E3XGzSe7aJDSKH2dCpuySuugLPEr+chFxfMyQHjCHKc
         PxkqDH+2brusQ4jTK9ACDUuOZ4TZucUcJZllWTJxEAIJ11uPm9WA2TDe5beOtzhIVUld
         PO17CG7h88QP+K0oINn5vnCkrSe3XR3f1NYEpEbiTe7ds7kkeWUb5z5mp4b9dXZOAcbu
         ik5dOdgAPsuH4AAlnfnHvewUEA1QxNSsiz9BNI5PpecvMTbiKmz5sAPq1GUbr9MJaUmM
         puVQ==
X-Gm-Message-State: AOAM5322+AxIgTANqdUGUBBcGwy3+ty9zngPaV6rMsgR+lqoTRmvWHMo
	JoFeNKo/qZWHkFPNHtD4G+1S2jKzJWd19kJ/HXk=
X-Google-Smtp-Source: ABdhPJzGQapUYUvP5450SqNQTN4He68HsDs2UfDIv7TLY8NFMWkuZyGMiHNiWMTtvZGrx53bXTTI58PR/o4O8YduHnA=
X-Received: by 2002:a17:90a:7843:: with SMTP id y3mr7896056pjl.190.1624015213008;
 Fri, 18 Jun 2021 04:20:13 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1624004309-54480-1-git-send-email-liyonglong@chinatelecom.cn> <1624004309-54480-4-git-send-email-liyonglong@chinatelecom.cn>
In-Reply-To: <1624004309-54480-4-git-send-email-liyonglong@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 18 Jun 2021 19:20:01 +0800
Message-ID: <CA+WQbwsSmzxw5c-pPJNYndQ99FKmFXSuKD6kxpQgwJGe9Q2kpQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	qitiepeng@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yonglong,

Thanks for v4!

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=8818=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:19=E5=86=99=E9=81=93=EF=BC=
=9A
>
> according MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO flag build
> ADD_ADDR/echo-ADD_ADDR option
>
> add a suboptions type OPTION_MPTCP_ADD_ECHO to mark as echo option
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  net/mptcp/options.c  | 124 +++++++++++++++++++++++++++++++--------------=
------
>  net/mptcp/pm.c       |  30 ++++---------
>  net/mptcp/protocol.h |  13 +++---
>  3 files changed, 92 insertions(+), 75 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 1aec016..43e3241 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -655,41 +655,64 @@ static bool mptcp_established_options_add_addr(stru=
ct sock *sk, struct sk_buff *
>         struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
>         bool drop_other_suboptions =3D false;
>         unsigned int opt_size =3D *size;
> -       bool echo;
> -       bool port;
> +       struct mptcp_addr_info remote;
> +       struct mptcp_addr_info local;
> +       u8 add_addr, flags =3D 0xff;
>         int len;
>
> -       if ((mptcp_pm_should_add_signal_ipv6(msk) ||
> -            mptcp_pm_should_add_signal_port(msk) ||
> -            mptcp_pm_should_add_signal_echo(msk)) &&
> -           skb && skb_is_tcp_pure_ack(skb)) {
> -               pr_debug("drop other suboptions");
> -               opts->suboptions =3D 0;
> -               opts->ext_copy.use_ack =3D 0;
> -               opts->ext_copy.use_map =3D 0;
> -               remaining +=3D opt_size;
> -               drop_other_suboptions =3D true;
> -       }
> -
> -       if (!mptcp_pm_should_add_signal(msk) ||
> -           !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &echo=
, &port)))
> -               return false;
> -
> -       len =3D mptcp_add_addr_len(opts->addr.family, echo, port);
> -       if (remaining < len)
> +       if (!mptcp_pm_should_add_signal(msk))
>                 return false;
>
> -       *size =3D len;
> -       if (drop_other_suboptions)
> -               *size -=3D opt_size;
> -       opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> -       if (!echo) {
> +       *size =3D 0;
> +       mptcp_pm_add_addr_signal(msk, &local, &remote, &add_addr);
> +       if (mptcp_pm_should_add_signal_echo(msk)) {
> +               if (skb && skb_is_tcp_pure_ack(skb)) {

'''
> +                       pr_debug("drop other suboptions");
> +                       opts->suboptions =3D 0;
> +                       opts->ext_copy.use_ack =3D 0;
> +                       opts->ext_copy.use_map =3D 0;
> +                       remaining +=3D opt_size;
> +                       drop_other_suboptions =3D true;
'''

> +               }
> +               len =3D mptcp_add_addr_len(remote.family, true, !!remote.=
port);
> +               if (remaining < len)
> +                       return false;
> +               remaining -=3D len;
> +               *size +=3D len;
> +               opts->remote =3D remote;
> +               flags =3D (u8)~BIT(MPTCP_ADD_ADDR_ECHO);
> +               opts->suboptions |=3D OPTION_MPTCP_ADD_ECHO;
> +               pr_debug("addr_id=3D%d, echo=3D1, port=3D%d addr_signal:%=
x",
> +                        opts->remote.id, ntohs(opts->remote.port), add_a=
ddr);
> +       } else if (mptcp_pm_should_add_signal_addr(msk)) {
> +               if ((local.family =3D=3D AF_INET6 || local.port) && skb &=
&
> +                   skb_is_tcp_pure_ack(skb)) {

'''
> +                       pr_debug("drop other suboptions");
> +                       opts->suboptions =3D 0;
> +                       opts->ext_copy.use_ack =3D 0;
> +                       opts->ext_copy.use_map =3D 0;
> +                       remaining +=3D opt_size;
> +                       drop_other_suboptions =3D true;
'''

I think this "drop other suboptions" trunk here is still duplicated. Can
we just use one "drop other suboptions" trunk only?

Thanks.
-Geliang



> +               }
> +               len =3D mptcp_add_addr_len(local.family, false, !!local.p=
ort);
> +               if (remaining < len)
> +                       return false;
> +               *size +=3D len;
> +               opts->addr =3D local;
>                 opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
>                                                      msk->remote_key,
>                                                      &opts->addr);
> +               opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> +               flags =3D (u8)~BIT(MPTCP_ADD_ADDR_SIGNAL);
> +               pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D0, port=3D%d=
, addr_signal:%x",
> +                        opts->addr.id, opts->ahmac, ntohs(opts->addr.por=
t), add_addr);
>         }
> -       pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
> -                opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port)=
);
> +
> +       if (drop_other_suboptions)
> +               *size -=3D opt_size;
> +       spin_lock_bh(&msk->pm.lock);
> +       WRITE_ONCE(msk->pm.addr_signal, flags & msk->pm.addr_signal);
> +       spin_unlock_bh(&msk->pm.lock);
>
>         return true;
>  }
> @@ -1228,45 +1251,51 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
>         }
>
>  mp_capable_done:
> -       if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> -               u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> -               u8 echo =3D MPTCP_ADDR_ECHO;
> +       if ((OPTION_MPTCP_ADD_ADDR | OPTION_MPTCP_ADD_ECHO) & opts->subop=
tions) {
> +               struct mptcp_addr_info *addr_info;
> +               u8 len =3D 0;
> +               u8 echo =3D 0;
> +
> +               if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> +                       len +=3D sizeof(opts->ahmac);
> +                       addr_info =3D &opts->addr;
> +               } else {
> +                       echo =3D MPTCP_ADDR_ECHO;
> +                       addr_info =3D &opts->remote;
> +               }
>
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -               if (opts->addr.family =3D=3D AF_INET6)
> -                       len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> +               if (addr_info->family =3D=3D AF_INET6)
> +                       len +=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> +               else
>  #endif
> +                       len +=3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
>
> -               if (opts->addr.port)
> +               if (addr_info->port)
>                         len +=3D TCPOLEN_MPTCP_PORT_LEN;
>
> -               if (opts->ahmac) {
> -                       len +=3D sizeof(opts->ahmac);
> -                       echo =3D 0;
> -               }
> -
>                 *ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> -                                     len, echo, opts->addr.id);
> -               if (opts->addr.family =3D=3D AF_INET) {
> -                       memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_addr, =
4);
> +                                     len, echo, addr_info->id);
> +               if (addr_info->family =3D=3D AF_INET) {
> +                       memcpy((u8 *)ptr, (u8 *)&addr_info->addr.s_addr, =
4);
>                         ptr +=3D 1;
>                 }
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -               else if (opts->addr.family =3D=3D AF_INET6) {
> -                       memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16);
> +               else if (addr_info->family =3D=3D AF_INET6) {
> +                       memcpy((u8 *)ptr, addr_info->addr6.s6_addr, 16);
>                         ptr +=3D 4;
>                 }
>  #endif
>
> -               if (!opts->addr.port) {
> -                       if (opts->ahmac) {
> +               if (!addr_info->port) {
> +                       if (!echo) {
>                                 put_unaligned_be64(opts->ahmac, ptr);
>                                 ptr +=3D 2;
>                         }
>                 } else {
> -                       u16 port =3D ntohs(opts->addr.port);
> +                       u16 port =3D ntohs(addr_info->port);
>
> -                       if (opts->ahmac) {
> +                       if (!echo) {
>                                 u8 *bptr =3D (u8 *)ptr;
>
>                                 put_unaligned_be16(port, bptr);
> @@ -1275,7 +1304,6 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
>                                 bptr +=3D 8;
>                                 put_unaligned_be16(TCPOPT_NOP << 8 |
>                                                    TCPOPT_NOP, bptr);
> -
>                                 ptr +=3D 3;
>                         } else {
>                                 put_unaligned_be32(port << 16 |
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 107a5a2..a62d4a5 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -22,7 +22,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>
>         lockdep_assert_held(&msk->pm.lock);
>
> -       if (add_addr) {
> +       if (add_addr &
> +           (echo ? BIT(MPTCP_ADD_ADDR_ECHO) : BIT(MPTCP_ADD_ADDR_SIGNAL)=
)) {
>                 pr_warn("addr_signal error, add_addr=3D%d", add_addr);
>                 return -EINVAL;
>         }
> @@ -252,32 +253,19 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 =
bkup)
>
>  /* path manager helpers */
>
> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remai=
ning,
> -                             struct mptcp_addr_info *saddr, bool *echo, =
bool *port)
> +void mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_addr_=
info *saddr,
> +                             struct mptcp_addr_info *daddr, u8 *add_addr=
)
>  {
> -       u8 add_addr;
> -       int ret =3D false;
> -
>         spin_lock_bh(&msk->pm.lock);
>
> -       /* double check after the lock is acquired */
> -       if (!mptcp_pm_should_add_signal(msk))
> -               goto out_unlock;
> -
> -       *echo =3D mptcp_pm_should_add_signal_echo(msk);
> -       *port =3D mptcp_pm_should_add_signal_port(msk);
> -
> -       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *=
port))
> -               goto out_unlock;
> -
>         *saddr =3D msk->pm.local;
> -       add_addr =3D msk->pm.addr_signal & ~(BIT(MPTCP_ADD_ADDR_SIGNAL) |=
 BIT(MPTCP_ADD_ADDR_ECHO));
> -       WRITE_ONCE(msk->pm.addr_signal, add_addr);
> -       ret =3D true;
> +       *daddr =3D msk->pm.remote;
> +       *add_addr =3D msk->pm.addr_signal;
>
> -out_unlock:
>         spin_unlock_bh(&msk->pm.lock);
> -       return ret;
> +
> +       if ((mptcp_pm_should_add_signal_echo(msk)) && (mptcp_pm_should_ad=
d_signal_addr(msk)))
> +               mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
>  }
>
>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remain=
ing,
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index a0b0ec0..90fb532 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -22,10 +22,11 @@
>  #define OPTION_MPTCP_MPJ_SYNACK        BIT(4)
>  #define OPTION_MPTCP_MPJ_ACK   BIT(5)
>  #define OPTION_MPTCP_ADD_ADDR  BIT(6)
> -#define OPTION_MPTCP_RM_ADDR   BIT(7)
> -#define OPTION_MPTCP_FASTCLOSE BIT(8)
> -#define OPTION_MPTCP_PRIO      BIT(9)
> -#define OPTION_MPTCP_RST       BIT(10)
> +#define OPTION_MPTCP_ADD_ECHO  BIT(7)
> +#define OPTION_MPTCP_RM_ADDR   BIT(8)
> +#define OPTION_MPTCP_FASTCLOSE BIT(9)
> +#define OPTION_MPTCP_PRIO      BIT(10)
> +#define OPTION_MPTCP_RST       BIT(11)
>
>  /* MPTCP option subtypes */
>  #define MPTCPOPT_MP_CAPABLE    0
> @@ -760,8 +761,8 @@ static inline int mptcp_rm_addr_len(const struct mptc=
p_rm_list *rm_list)
>         return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) +=
 1;
>  }
>
> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remai=
ning,
> -                             struct mptcp_addr_info *saddr, bool *echo, =
bool *port);
> +void mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_addr_=
info *saddr,
> +                             struct mptcp_addr_info *daddr, u8 *add_addr=
);
>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remain=
ing,
>                              struct mptcp_rm_list *rm_list);
>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *sk=
c);
> --
> 1.8.3.1
>
