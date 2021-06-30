Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177A4168
	for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 11:14:13 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id e20so1952086pgg.0
        for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 04:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4N2FcdXR+s78FL5aN9yU7nifJpMXZLHNEmiIumC68RU=;
        b=Mbv49194NwJUmvt5N7YdWQC3swzGYHkLnGiGxTfr5zjofXqL0OsmVvGOv5BJtd4rQf
         784W/0j7knW9NUopoOsuMcMv++eX4mVreQIFvJWVB9EoiLImokzZ8wPlmABV/wjEnshT
         SUxC0Twdt98YLP32KmwMY0AELDL1tJ8fy35OWjEceMEy9E5LjWHXVlqspF5K2nY3K9kE
         nJ07i7Bdx2Vj7bIfNiUJvLXCDBSeDqDCx6dC6NuxItZPW9iknPd+3JtpxZhsRCQlG1z7
         H71D+zCT20/BWpSMqTyF9Hc4a3jHB0iStRz/F2XKM1lkHnrhp+i71DTB0xmpC9YJ554F
         e9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4N2FcdXR+s78FL5aN9yU7nifJpMXZLHNEmiIumC68RU=;
        b=LKxwCmL38ziDk/Va1AbOM9VKZEybTUE5wCXWnOPbuv+DjotRRRt8F0QUTMhI122j1d
         d33vvV9SqYub2PjW1nS7bJYzs4T00G9WlSpzDCnF9Q0Q1a3tWW5WiKohxNf2rLxlgQy1
         VSBf7Fq+TlqrSkcdcZViKNmPz/oWyldgi+HCfGy1XpD2R/6hLoG8mxyUItbUOvibRvbB
         kLrujxMt7N+fJfAKc6R3aEhSZ46sZ2OpK5sGvlEUAtuinGN2UHh51gajpvs59zLDxuk9
         ximnkLJ/22RGxHHSKC6sxwl3tfi6EmfFX1jeok6mSDSjP60I9tx1n7XHsT3bSh+f5Mvr
         6aZg==
X-Gm-Message-State: AOAM530vbHWc+FWdl26N7KTMGxSlEX6OkdClXN6ZhVLELJCIojsMTrUr
	OvikADKWttLbNOZOAL4EnwfkGvMSBMB1evNmBQk=
X-Google-Smtp-Source: ABdhPJw8QFjtqmMTM+novWc6J90Ty+5ZoHSOYqFvHjNgIbAGaR/on4mRjz7EHUHbdgDIhrMhqlzxBieIUNpB+oKAJbo=
X-Received: by 2002:a62:3344:0:b029:25e:a0a8:1c51 with SMTP id
 z65-20020a6233440000b029025ea0a81c51mr35495904pfz.58.1625051652585; Wed, 30
 Jun 2021 04:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1625048653-6825-1-git-send-email-liyonglong@chinatelecom.cn> <1625048653-6825-4-git-send-email-liyonglong@chinatelecom.cn>
In-Reply-To: <1625048653-6825-4-git-send-email-liyonglong@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 30 Jun 2021 19:14:01 +0800
Message-ID: <CA+WQbws0e9dkYy_VDimHQkuXF-fyAz1z1SGWYHcLFycNykaZrA@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yonglong,

Thank you for this new patch!

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=8830=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:24=E5=86=99=E9=81=93=EF=BC=
=9A
>
> according MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO flag build
> ADD_ADDR/echo-ADD_ADDR option
>
> add a suboptions type OPTION_MPTCP_ADD_ECHO to mark as echo option
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  include/net/mptcp.h  |  3 ++-
>  net/mptcp/options.c  | 54 +++++++++++++++++++++++++++++-----------------=
------
>  net/mptcp/pm.c       | 35 +++++++++++++++++++++++-----------
>  net/mptcp/protocol.h | 25 ++++++++++++++++--------
>  4 files changed, 73 insertions(+), 44 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index d61bbbf..d2c6ebe 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -61,7 +61,8 @@ struct mptcp_out_options {
>         u64 sndr_key;
>         u64 rcvr_key;
>         u64 ahmac;
> -       struct mptcp_addr_info addr;
> +       struct mptcp_addr_info local;
> +       struct mptcp_addr_info remote;
>         struct mptcp_rm_list rm_list;
>         u8 join_id;
>         u8 backup;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 1aec016..cceff0a 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -655,13 +655,16 @@ static bool mptcp_established_options_add_addr(stru=
ct sock *sk, struct sk_buff *
>         struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
>         bool drop_other_suboptions =3D false;
>         unsigned int opt_size =3D *size;
> -       bool echo;
> -       bool port;
> -       int len;
> +       u8 add_addr;
> +       int len =3D 0;
>
> -       if ((mptcp_pm_should_add_signal_ipv6(msk) ||
> -            mptcp_pm_should_add_signal_port(msk) ||
> -            mptcp_pm_should_add_signal_echo(msk)) &&
> +       if (!mptcp_pm_should_add_signal(msk) ||
> +           !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts=
, &add_addr))
> +               return false;
> +
> +       if (((add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) ||
> +            ((add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
> +             (opts->local.family =3D=3D AF_INET6 || opts->local.port))) =
&&
>             skb && skb_is_tcp_pure_ack(skb)) {
>                 pr_debug("drop other suboptions");
>                 opts->suboptions =3D 0;
> @@ -671,11 +674,7 @@ static bool mptcp_established_options_add_addr(struc=
t sock *sk, struct sk_buff *
>                 drop_other_suboptions =3D true;
>         }
>
> -       if (!mptcp_pm_should_add_signal(msk) ||
> -           !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &echo=
, &port)))
> -               return false;
> -
> -       len =3D mptcp_add_addr_len(opts->addr.family, echo, port);
> +       len =3D mptcp_add_addr_len(msk, opts);
>         if (remaining < len)
>                 return false;
>
> @@ -683,13 +682,16 @@ static bool mptcp_established_options_add_addr(stru=
ct sock *sk, struct sk_buff *
>         if (drop_other_suboptions)
>                 *size -=3D opt_size;
>         opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> -       if (!echo) {
> +       if (!(add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) &&
> +           (add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL))) {
>                 opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
>                                                      msk->remote_key,
> -                                                    &opts->addr);
> +                                                    &opts->local);
>         }
> -       pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
> -                opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port)=
);
> +

Drop this blank line.

> +       pr_debug("addr_signal:%x, echo=3D%d, local_addr_id=3D%d, ahmac=3D=
%llu, local_port=3D%d, remote_addr_id=3D%d, remote_port=3D%d",
> +                add_addr, (opts->ahmac =3D=3D 0), opts->local.id,
> +                opts->ahmac, ntohs(opts->local.port), opts->remote.id, n=
tohs(opts->remote.port));
>
>         return true;
>  }
> @@ -1229,15 +1231,19 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
>
>  mp_capable_done:
>         if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> +               struct mptcp_addr_info *addr =3D &opts->remote;
>                 u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
>                 u8 echo =3D MPTCP_ADDR_ECHO;
>
> +               if (opts->ahmac)
> +                       addr =3D &opts->local;
> +
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -               if (opts->addr.family =3D=3D AF_INET6)
> +               if (addr->family =3D=3D AF_INET6)
>                         len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>  #endif
>
> -               if (opts->addr.port)
> +               if (addr->port)
>                         len +=3D TCPOLEN_MPTCP_PORT_LEN;
>
>                 if (opts->ahmac) {
> @@ -1246,25 +1252,25 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
>                 }
>
>                 *ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> -                                     len, echo, opts->addr.id);
> -               if (opts->addr.family =3D=3D AF_INET) {
> -                       memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_addr, =
4);
> +                                     len, echo, addr->id);
> +               if (addr->family =3D=3D AF_INET) {
> +                       memcpy((u8 *)ptr, (u8 *)&addr->addr.s_addr, 4);
>                         ptr +=3D 1;
>                 }
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -               else if (opts->addr.family =3D=3D AF_INET6) {
> -                       memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16);
> +               else if (addr->family =3D=3D AF_INET6) {
> +                       memcpy((u8 *)ptr, addr->addr6.s6_addr, 16);
>                         ptr +=3D 4;
>                 }
>  #endif
>
> -               if (!opts->addr.port) {
> +               if (!addr->port) {
>                         if (opts->ahmac) {
>                                 put_unaligned_be64(opts->ahmac, ptr);
>                                 ptr +=3D 2;
>                         }
>                 } else {
> -                       u16 port =3D ntohs(opts->addr.port);
> +                       u16 port =3D ntohs(addr->port);
>
>                         if (opts->ahmac) {
>                                 u8 *bptr =3D (u8 *)ptr;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 0dc9021..9c5b15c 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -253,11 +253,11 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 =
bkup)
>
>  /* path manager helpers */
>
> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remai=
ning,
> -                             struct mptcp_addr_info *saddr, bool *echo, =
bool *port)
> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *sk=
b,
> +                             unsigned int opt_size, unsigned int remaini=
ng,
> +                             struct mptcp_out_options *opts,  u8 *add_ad=
dr)
>  {
> -       int ret =3D false;
> -       u8 add_addr;
> +       int ret =3D false, len;
>
>         spin_lock_bh(&msk->pm.lock);
>
> @@ -265,18 +265,31 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *ms=
k, unsigned int remaining,
>         if (!mptcp_pm_should_add_signal(msk))
>                 goto out_unlock;
>
> -       *echo =3D mptcp_pm_should_add_signal_echo(msk);
> -       *port =3D mptcp_pm_should_add_signal_port(msk);
> +       opts->local =3D msk->pm.local;
> +       opts->remote =3D msk->pm.remote;
> +       *add_addr =3D msk->pm.addr_signal;
> +
> +       if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
> +            ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
> +             (msk->pm.local.family =3D=3D AF_INET6 || msk->pm.local.port=
))) &&
> +           skb && skb_is_tcp_pure_ack(skb)) {
> +               remaining +=3D opt_size;
> +       }

Move it back to mptcp_established_options_add_addr, if so, no need to
add the opt_size argument too.

>
> -       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *=
port))
> +       len =3D mptcp_add_addr_len(msk, opts);
> +       if (remaining < len)
>                 goto out_unlock;
>
> -       *saddr =3D msk->pm.local;
> -       add_addr =3D msk->pm.addr_signal & ~(BIT(MPTCP_ADD_ADDR_SIGNAL) |=
 BIT(MPTCP_ADD_ADDR_ECHO));
> -       WRITE_ONCE(msk->pm.addr_signal, add_addr);
> -       ret =3D true;
> +       if ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)))
> +               WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BI=
T(MPTCP_ADD_ADDR_ECHO));
> +       else
> +               WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BI=
T(MPTCP_ADD_ADDR_SIGNAL));
>

Drop this blank line.

> +       ret =3D true;
>  out_unlock:
> +       if ((mptcp_pm_should_add_signal_echo(msk)) && (mptcp_pm_should_ad=
d_signal_addr(msk)))
> +               mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
> +

Again, why we need these two lines?

>         spin_unlock_bh(&msk->pm.lock);
>         return ret;
>  }
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index a0b0ec0..caa4a60 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -737,16 +737,24 @@ static inline bool mptcp_pm_should_rm_signal(struct=
 mptcp_sock *msk)
>         return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL)=
;
>  }
>
> -static inline unsigned int mptcp_add_addr_len(int family, bool echo, boo=
l port)
> +static inline unsigned int mptcp_add_addr_len(struct mptcp_sock *msk,
> +                                             struct mptcp_out_options *o=
pts)
>  {
> -       u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> +       u8 len =3D 0;
> +       struct mptcp_addr_info *addr =3D &opts->remote;

Use the reverse xmas tree order.

Thanks,
-Geliang

>
> -       if (family =3D=3D AF_INET6)
> -               len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> -       if (!echo)
> +       if (mptcp_pm_should_add_signal_addr(msk)) {
> +               addr =3D &opts->local;
>                 len +=3D MPTCPOPT_THMAC_LEN;
> +       }
> +
> +       if (addr->family =3D=3D AF_INET6)
> +               len +=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> +       else
> +               len +=3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> +
>         /* account for 2 trailing 'nop' options */
> -       if (port)
> +       if (addr->port)
>                 len +=3D TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIG=
N;
>
>         return len;
> @@ -760,8 +768,9 @@ static inline int mptcp_rm_addr_len(const struct mptc=
p_rm_list *rm_list)
>         return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) +=
 1;
>  }
>
> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remai=
ning,
> -                             struct mptcp_addr_info *saddr, bool *echo, =
bool *port);
> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *sk=
b,
> +                             unsigned int opt_size, unsigned int remaini=
ng,
> +                             struct mptcp_out_options *opts,  u8 *add_ad=
dr);
>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remain=
ing,
>                              struct mptcp_rm_list *rm_list);
>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *sk=
c);
> --
> 1.8.3.1
>
