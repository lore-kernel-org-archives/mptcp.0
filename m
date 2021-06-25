Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4972FB8
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 04:44:20 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id d1so3455673plg.6
        for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 21:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4EoPW5CttNa9LUpDN7kNVSwLOUUJdW2ArPFyyIjBcAU=;
        b=ntoLSosOhBtZTJQKWnObfi2hpSW0wFraWf7Rs23usc4XWNO7O9fL41jYCjbXQAeMnH
         zhYLwtQsDDiYzPLU4Q8YxJ0OC+C0IH4ts+LF5SormTc8rOEk/VOsUjqJKXXbaLJkiTee
         0MDwMZCMCVUlHdSPTBBNVOj3ewgqlWFeXFe7YjZ5bfMwywkLu72iBERBE4L3i8SYNUoY
         4Ed1p5YOdoVtnRjMUQcZsWH1qq4/Qp9VaFXx8RpYKNYonlxd9IC6URSRNVUfmvUh5wDN
         97LV6HTlzLSTGiEEhI8sXaB7k1tNtLoQbVr6x78wFx8bApGbG39Ur+1Ug1TsRtRF29mf
         NVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4EoPW5CttNa9LUpDN7kNVSwLOUUJdW2ArPFyyIjBcAU=;
        b=uh9wvvs5q5rVpYQBrvCBzT/i0+HjLIEi8FsuOQ6LUkI6zvqP7nrPBjY9oIu34+ce4S
         7YUvnBkxHgulBtL9wVm+SB6Pe5m2zlmdJaS/DIEb8u5RfrIZqH5uNMk71AI6cf0WwM3W
         WTQ0k0PrBRnaME0Worp/VIYNXuCKcGJWijDsqDtQJ1KXmyJj4v5Y4a7/dkwdPa7dWljG
         OHwLi+xDUiEkPZvnSCKpmk6Ix13dKIvMueOOMvj+ueprTBkEiEVEc6TaAdICNtpUURUo
         7FC7eLV+mliYBVPKRrGIFSDzqhfvH5QRSRzMgRM4rnxs/gvbzGTZ2iNqsdKMvWtE5Uw4
         XLHA==
X-Gm-Message-State: AOAM532PKwQxaqU/SvkKZhHHKsAlrbybu5vEd+Q4foo3tOyE9UwgfFsH
	N/yziXOYvC/a3d+qPylakf+D/NJ1CfJg2LFyW0M=
X-Google-Smtp-Source: ABdhPJysrC7PWISm+/AGtdhT4OfwV83lM4E2oXowJ3j33q2OXPXx5wNJKCVPgFNwi9J0FW/Cz3hlepjQhTf2cicUlJE=
X-Received: by 2002:a17:90b:33c6:: with SMTP id lk6mr19240636pjb.6.1624596260210;
 Thu, 24 Jun 2021 21:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1624337135-149084-1-git-send-email-liyonglong@chinatelecom.cn> <1624337135-149084-4-git-send-email-liyonglong@chinatelecom.cn>
In-Reply-To: <1624337135-149084-4-git-send-email-liyonglong@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 25 Jun 2021 12:44:08 +0800
Message-ID: <CA+WQbwuiewnKr8NeKrGLTq-e4FYE1SGqS7GpHZLMz0kB2db-Sw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yonglong,

Thank you for this new patch!

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=8822=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8812:46=E5=86=99=E9=81=93=EF=BC=
=9A
>
> according MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO flag build
> ADD_ADDR/echo-ADD_ADDR option
>
> add a suboptions type OPTION_MPTCP_ADD_ECHO to mark as echo option
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  include/net/mptcp.h  |   2 +-
>  net/mptcp/options.c  | 105 ++++++++++++++++++++++++++++++---------------=
------
>  net/mptcp/pm.c       |  30 +++++----------
>  net/mptcp/protocol.h |  13 ++++---
>  4 files changed, 80 insertions(+), 70 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 637e90b..d2c6ebe 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -61,7 +61,7 @@ struct mptcp_out_options {
>         u64 sndr_key;
>         u64 rcvr_key;
>         u64 ahmac;
> -       struct mptcp_addr_info addr;
> +       struct mptcp_addr_info local;
>         struct mptcp_addr_info remote;
>         struct mptcp_rm_list rm_list;
>         u8 join_id;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 1aec016..a1fafed 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -655,13 +655,19 @@ static bool mptcp_established_options_add_addr(stru=
ct sock *sk, struct sk_buff *
>         struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
>         bool drop_other_suboptions =3D false;
>         unsigned int opt_size =3D *size;
> -       bool echo;
> -       bool port;
> -       int len;
> +       struct mptcp_addr_info remote;
> +       struct mptcp_addr_info local;
> +       u8 add_addr, flags =3D 0xff;
> +       int len =3D 0;
>
> -       if ((mptcp_pm_should_add_signal_ipv6(msk) ||
> -            mptcp_pm_should_add_signal_port(msk) ||
> -            mptcp_pm_should_add_signal_echo(msk)) &&
> +       if (!mptcp_pm_should_add_signal(msk))
> +               return false;
> +
> +       mptcp_pm_add_addr_signal(msk, &local, &remote, &add_addr);

Could we check the return value of mptcp_pm_add_addr_signal as the original
code:

       if (!mptcp_pm_should_add_signal(msk) ||
           !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr,
&echo, &port)))
               return false;

> +       if ((mptcp_pm_should_add_signal_echo(msk) ||
> +            (!mptcp_pm_should_add_signal_echo(msk) &&
> +             mptcp_pm_should_add_signal_addr(msk) &&
> +             (local.family =3D=3D AF_INET6 || local.port))) &&
>             skb && skb_is_tcp_pure_ack(skb)) {
>                 pr_debug("drop other suboptions");
>                 opts->suboptions =3D 0;
> @@ -671,25 +677,35 @@ static bool mptcp_established_options_add_addr(stru=
ct sock *sk, struct sk_buff *
>                 drop_other_suboptions =3D true;
>         }
>
> -       if (!mptcp_pm_should_add_signal(msk) ||
> -           !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &echo=
, &port)))
> -               return false;
> -
> -       len =3D mptcp_add_addr_len(opts->addr.family, echo, port);
> -       if (remaining < len)
> -               return false;
> +       if (mptcp_pm_should_add_signal_echo(msk)) {
> +               len =3D mptcp_add_addr_len(remote.family, true, !!remote.=
port);

Could we pass 'opts' as the only argument to mptcp_add_addr_len, and use
mptcp_pm_should_add_signal_echo in mptcp_add_addr_len to check whether
it's a ADD_ADDR_ECHO?

> +               if (remaining < len)
> +                       return false;

Then we can move these lines out of the if... else... trunk.

> +               opts->remote =3D remote;
> +               flags =3D (u8)~BIT(MPTCP_ADD_ADDR_ECHO);
> +               opts->suboptions |=3D OPTION_MPTCP_ADD_ECHO;

I prefer to change the order of these three lines to:

              opts->remote =3D remote;
              opts->suboptions |=3D OPTION_MPTCP_ADD_ECHO;
              flags =3D (u8)~BIT(MPTCP_ADD_ADDR_ECHO);

> +       } else {
> +               len =3D mptcp_add_addr_len(local.family, false, !!local.p=
ort);
> +               if (remaining < len)
> +                       return false;
> +               opts->local =3D local;
> +               opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
> +                                                    msk->remote_key,
> +                                                    &opts->local);
> +               opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> +               flags =3D (u8)~BIT(MPTCP_ADD_ADDR_SIGNAL);

And here I prefer to use the same order as the if trunk:

              opts->local =3D local;
              opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
              opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
                                                   msk->remote_key,
                                                   &opts->local);
              flags =3D (u8)~BIT(MPTCP_ADD_ADDR_SIGNAL);

> +       }
>
>         *size =3D len;
>         if (drop_other_suboptions)
>                 *size -=3D opt_size;
> -       opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> -       if (!echo) {
> -               opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
> -                                                    msk->remote_key,
> -                                                    &opts->addr);
> -       }
> -       pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
> -                opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port)=
);
> +       spin_lock_bh(&msk->pm.lock);
> +       WRITE_ONCE(msk->pm.addr_signal, flags & msk->pm.addr_signal);
> +       spin_unlock_bh(&msk->pm.lock);
> +
> +       pr_debug("addr_signal:%x, echo=3D%d, local_addr_id=3D%d, ahmac=3D=
%llu, local_port=3D%d, remote_addr_id=3D%d, remote_port=3D%d",
> +                add_addr, mptcp_pm_should_add_signal_echo(msk), opts->lo=
cal.id,
> +                opts->ahmac, ntohs(opts->local.port), opts->remote.id, n=
tohs(opts->remote.port));
>
>         return true;
>  }
> @@ -1228,45 +1244,51 @@ void mptcp_write_options(__be32 *ptr, const struc=
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
> +                       addr_info =3D &opts->local;
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
> @@ -1275,7 +1297,6 @@ void mptcp_write_options(__be32 *ptr, const struct =
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

Could we keep the return value as bool here?

And pass 'opts' as an argument of this function, instead of using two
arguments 'saddr' and 'daddr'.

>  {
> -       u8 add_addr;
> -       int ret =3D false;
> -
>         spin_lock_bh(&msk->pm.lock);
>
> -       /* double check after the lock is acquired */
> -       if (!mptcp_pm_should_add_signal(msk))
> -               goto out_unlock;

Could we keep these double check codes here?

> -
> -       *echo =3D mptcp_pm_should_add_signal_echo(msk);
> -       *port =3D mptcp_pm_should_add_signal_port(msk);
> -
> -       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *=
port))
> -               goto out_unlock;
> -
>         *saddr =3D msk->pm.local;

Use 'opts->local =3D msk->pm.local' here...

> -       add_addr =3D msk->pm.addr_signal & ~(BIT(MPTCP_ADD_ADDR_SIGNAL) |=
 BIT(MPTCP_ADD_ADDR_ECHO));
> -       WRITE_ONCE(msk->pm.addr_signal, add_addr);
> -       ret =3D true;
> +       *daddr =3D msk->pm.remote;

And 'opts->remote =3D msk->pm.remote' here.

WDYT?

-Geliang

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
