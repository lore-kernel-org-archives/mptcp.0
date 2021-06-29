Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26542168
	for <mptcp@lists.linux.dev>; Tue, 29 Jun 2021 05:58:26 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id mn20-20020a17090b1894b02901707fc074e8so1334298pjb.0
        for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 22:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+m49d1DmFOOVbZlKyaM2rIE4Lf6yrPNMdSgzsmvcDx8=;
        b=miPAu6UFsLiF1DQlJedeuHVCi1IMXtt9h5UbFPb+UaB0zKBj5qrLkivvl4QyhIRmdX
         GjdxiufXgtWiKWndfjwEcWlH7WaPMC9fhvtht2CwnIuOYw4ANL/JthdpKGZKoDA8C41h
         C0dztfwacWYyM4N++WTcxKvbavNNwvHVAbZ8PG9YusEHV8KNAb2kkhkOqh8dRznxs5n0
         qgbwsTgy/pCrylit/ESb7Ox2nwVuyA55ZHSpdsJWG+K/xU3HRH3Fw12g1y0bK6WozbEt
         mIKz+ByfVNisEttTnfNVv9pJaP6lbis4FUq2M48JG1nIabxytXHMA1cBB1PKiv2+EkFV
         6woA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+m49d1DmFOOVbZlKyaM2rIE4Lf6yrPNMdSgzsmvcDx8=;
        b=rmqjbMvVIAJA/6VD3Ipb+y6QGlgAc99ph450C2YMzSStR/MpJ/CEB970X0PfUTxIaX
         ixhBio7Vhh/YyrKVI+Cv4DeOtRsFUXA62FbTxZ/BiyqIbmV37pjJelkRXq7x8TcUU01/
         iMTfzibBGgIEs+JXnFaUgznRw0bHn9aeY3rBlvyCg7uA0rdzUZ6HWL0M1sU6cCcKu/wi
         RxhCXlBl0oYCJZdRNdgf4EJHyWn/xXD69tUgIz6hm4TA70OG6J18HCzicL6xHZa105AP
         pQqJ/YRuxB4Mfc9BR0YkSYsMG6CI1QGpJxZ4v8IewxsreD6kQyajxewIaw4pDFzRmpwc
         OQdw==
X-Gm-Message-State: AOAM532BjQ7ztR3xPAzpo3ClHDaqHBB6jJ6DSKZCroMHLIajOvEuUcbi
	xP2rR6eui6lIDj5r/uLiAAH4NXS5tB2sFJKk/b4=
X-Google-Smtp-Source: ABdhPJxQRTNkTl1U9ERHlC3AOURhgpuyeKOnmO+9JJiWuyXh6E9VjvtqVGdAPw+Q7CGp5i9IqGyDrw/FvDweDsj4O3E=
X-Received: by 2002:a17:90b:33c6:: with SMTP id lk6mr42228691pjb.6.1624946305588;
 Mon, 28 Jun 2021 22:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1624930899-99623-1-git-send-email-liyonglong@chinatelecom.cn> <1624930899-99623-4-git-send-email-liyonglong@chinatelecom.cn>
In-Reply-To: <1624930899-99623-4-git-send-email-liyonglong@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 29 Jun 2021 13:58:13 +0800
Message-ID: <CA+WQbwvCWgCog4jxVjpQxvJ0_ojms8ND=gP1WJUA=0B-zGB-=A@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:42=E5=86=99=E9=81=93=EF=BC=
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
>  net/mptcp/options.c  | 65 +++++++++++++++++++++++++++++++---------------=
------
>  net/mptcp/pm.c       | 33 +++++++++++---------------
>  net/mptcp/protocol.h | 23 ++++++++++++-------
>  4 files changed, 69 insertions(+), 55 deletions(-)
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
> index 1aec016..1707bec 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -655,13 +655,15 @@ static bool mptcp_established_options_add_addr(stru=
ct sock *sk, struct sk_buff *
>         struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
>         bool drop_other_suboptions =3D false;
>         unsigned int opt_size =3D *size;
> -       bool echo;
> -       bool port;
> -       int len;
> +       u8 add_addr, flags =3D 0xff;
> +       int len =3D 0;
>
> -       if ((mptcp_pm_should_add_signal_ipv6(msk) ||
> -            mptcp_pm_should_add_signal_port(msk) ||
> -            mptcp_pm_should_add_signal_echo(msk)) &&
> +       if (!mptcp_pm_add_addr_signal(msk, opts, &add_addr))
> +               return false;

This add_addr argument is useless, let's drop it.

And here add back mptcp_pm_should_add_signal check here. The original code
called mptcp_pm_should_add_signal twice for double check, once out of pm
lock, once under pm lock. We should keep it.

> +
> +       if ((mptcp_pm_should_add_signal_echo(msk) ||
> +            (mptcp_pm_should_add_signal_addr(msk) &&
> +             (opts->local.family =3D=3D AF_INET6 || opts->local.port))) =
&&
>             skb && skb_is_tcp_pure_ack(skb)) {
>                 pr_debug("drop other suboptions");
>                 opts->suboptions =3D 0;
> @@ -671,11 +673,17 @@ static bool mptcp_established_options_add_addr(stru=
ct sock *sk, struct sk_buff *
>                 drop_other_suboptions =3D true;
>         }
>
> -       if (!mptcp_pm_should_add_signal(msk) ||
> -           !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &echo=
, &port)))
> -               return false;
>
> -       len =3D mptcp_add_addr_len(opts->addr.family, echo, port);
> +       if (mptcp_pm_should_add_signal_echo(msk)) {
> +               flags =3D (u8)~BIT(MPTCP_ADD_ADDR_ECHO);
> +       } else {
> +               opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
> +                                                    msk->remote_key,
> +                                                    &opts->local);

Keep this ahmac generating code after opts->suboptions set just like the
original code, since ahmac is the more expensive to populate. If remaining
length isn't enough, no need to set ahmac.

> +               flags =3D (u8)~BIT(MPTCP_ADD_ADDR_SIGNAL);
> +       }
> +
> +       len =3D mptcp_add_addr_len(opts);
>         if (remaining < len)
>                 return false;
>
> @@ -683,13 +691,14 @@ static bool mptcp_established_options_add_addr(stru=
ct sock *sk, struct sk_buff *
>         if (drop_other_suboptions)
>                 *size -=3D opt_size;
>         opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> -       if (!echo) {
> -               opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
> -                                                    msk->remote_key,
> -                                                    &opts->addr);
> -       }
> -       pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
> -                opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port)=
);
> +
> +       spin_lock_bh(&msk->pm.lock);
> +       WRITE_ONCE(msk->pm.addr_signal, flags & msk->pm.addr_signal);
> +       spin_unlock_bh(&msk->pm.lock);

addr_signal has been set in mptcp_pm_add_addr_signal in patch 1, no need to
set it again. I thinks this trunk and all the flags set above should be
dropped.

> +
> +       pr_debug("addr_signal:%x, echo=3D%d, local_addr_id=3D%d, ahmac=3D=
%llu, local_port=3D%d, remote_addr_id=3D%d, remote_port=3D%d",
> +                add_addr, (opts->ahmac =3D=3D 0), opts->local.id,
> +                opts->ahmac, ntohs(opts->local.port), opts->remote.id, n=
tohs(opts->remote.port));
>
>         return true;
>  }

The whole function is something like this:
'''
        struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
        struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
        bool drop_other_suboptions =3D false;
        unsigned int opt_size =3D *size;
        int len;

        if (!mptcp_pm_should_add_signal(msk) ||
            !mptcp_pm_add_addr_signal(msk, remaining, opts))
                return false;

        if ((mptcp_pm_should_add_signal_echo(msk) ||
             (mptcp_pm_should_add_signal_addr(msk) &&
              (opts->local.family =3D=3D AF_INET6 || opts->local.port))) &&
            skb && skb_is_tcp_pure_ack(skb)) {
                pr_debug("drop other suboptions");
                opts->suboptions =3D 0;
                opts->ext_copy.use_ack =3D 0;
                opts->ext_copy.use_map =3D 0;
                remaining +=3D opt_size;
                drop_other_suboptions =3D true;
        }

        len =3D mptcp_add_addr_len(opts);
        if (remaining < len)
                return false;

        *size =3D len;
        if (drop_other_suboptions)
                *size -=3D opt_size;
        opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
        if (mptcp_pm_should_add_signal_addr(msk)) {
                opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
                                                     msk->remote_key,
                                                     &opts->local);
        }

        pr_debug("addr_signal:%x, echo=3D%d, local_addr_id=3D%d,
ahmac=3D%llu, local_port=3D%d, remote_addr_id=3D%d, remote_port=3D%d",
                 msk->pm.addr_signal, (opts->ahmac =3D=3D 0), opts->local.i=
d,
                 opts->ahmac, ntohs(opts->local.port),
opts->remote.id, ntohs(opts->remote.port));

        return true;
'''

> @@ -1229,15 +1238,19 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
>
>  mp_capable_done:
>         if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> +               struct mptcp_addr_info *addr =3D &opts->remote;

We can simplify it like this:
         struct mptcp_addr_info *addr =3D opts->ahmac ? &opts->local :
&opts->remote;

>                 u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
>                 u8 echo =3D MPTCP_ADDR_ECHO;
>
> +               if (opts->ahmac)
> +                       addr =3D &opts->local;

And this trunk can be dropped.

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
> @@ -1246,25 +1259,25 @@ void mptcp_write_options(__be32 *ptr, const struc=
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
> index cf873e9..9c621293 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -253,32 +253,25 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 =
bkup)
>
>  /* path manager helpers */
>
> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remai=
ning,
> -                             struct mptcp_addr_info *saddr, bool *echo, =
bool *port)
> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_out_o=
ptions *opts,
> +                             u8 *add_addr)

Drop this add_addr argument.

>  {
> -       u8 add_addr;
> -       int ret =3D false;
> -
>         spin_lock_bh(&msk->pm.lock);
>
> -       /* double check after the lock is acquired */
> -       if (!mptcp_pm_should_add_signal(msk))
> -               goto out_unlock;

Keep this double check code.

> -
> -       *echo =3D mptcp_pm_should_add_signal_echo(msk);
> -       *port =3D mptcp_pm_should_add_signal_port(msk);
> -
> -       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *=
port))
> -               goto out_unlock;

Keep this length double check code too.

> +       if (!mptcp_pm_should_add_signal(msk)) {
> +               spin_unlock_bh(&msk->pm.lock);
> +               return false;
> +       }
>
> -       *saddr =3D msk->pm.local;
> -       add_addr =3D msk->pm.addr_signal & ~(BIT(MPTCP_ADD_ADDR_SIGNAL) |=
 BIT(MPTCP_ADD_ADDR_ECHO));
-       WRITE_ONCE(msk->pm.addr_signal, add_addr);

This code is just added in patch 1, I think we should keep it. And no need
to write addr_signal again in mptcp_established_options_add_addr.

> -       ret =3D true;
> +       opts->local =3D msk->pm.local;
> +       opts->remote =3D msk->pm.remote;
> +       *add_addr =3D msk->pm.addr_signal;
>
> -out_unlock:
>         spin_unlock_bh(&msk->pm.lock);
> -       return ret;

Keep this out_unlock code.

> +
> +       if ((mptcp_pm_should_add_signal_echo(msk)) && (mptcp_pm_should_ad=
d_signal_addr(msk)))
> +               mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);

Could we use mptcp_pm_add_addr_send_ack here instead of open coding?

I'm no sure why we need this two lines, and why you use '&&' here. Do you
mean set MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO at the same time?

> +       return true;
>  }

The whole function is something like this:
'''
        int ret =3D false;
        u8 add_addr;

        spin_lock_bh(&msk->pm.lock);

        /* double check after the lock is acquired */
        if (!mptcp_pm_should_add_signal(msk))
                goto out_unlock;

        if (remaining < mptcp_add_addr_len(opts))
                goto out_unlock;

        opts->local =3D msk->pm.local;
        opts->remote =3D msk->pm.remote;
        if (mptcp_pm_should_add_signal_echo(msk))
                add_addr =3D msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO=
);
        else
                add_addr =3D msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGN=
AL);
        WRITE_ONCE(msk->pm.addr_signal, add_addr);
        ret =3D true;

out_unlock:
        spin_unlock_bh(&msk->pm.lock);
        if (ret && mptcp_pm_should_add_signal_echo(msk) &&
mptcp_pm_should_add_signal_addr(msk))
                mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
        return ret;
'''

>
>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remain=
ing,
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index a0b0ec0..0bfbbdef 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -737,16 +737,23 @@ static inline bool mptcp_pm_should_rm_signal(struct=
 mptcp_sock *msk)
>         return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL)=
;
>  }
>
> -static inline unsigned int mptcp_add_addr_len(int family, bool echo, boo=
l port)
> +static inline unsigned int mptcp_add_addr_len(struct mptcp_out_options *=
opts)
>  {
> -       u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> +       u8 len =3D 0;
> +       struct mptcp_addr_info *addr =3D &opts->remote;

We can simplify it like this:
         struct mptcp_addr_info *addr =3D opts->ahmac ? &opts->local :
&opts->remote;

And keep the orignal code unchanged.

>
> -       if (family =3D=3D AF_INET6)
> -               len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> -       if (!echo)
> +       if (opts->ahmac) {
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

The whole function is something like this:
'''
        struct mptcp_addr_info *addr =3D opts->ahmac ? &opts->local :
&opts->remote;
        u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;

        if (addr->family =3D=3D AF_INET6)
                len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
        if (opts->ahmac)
                len +=3D MPTCPOPT_THMAC_LEN;
        /* account for 2 trailing 'nop' options */
        if (addr->port)
                len +=3D TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIGN;

        return len;
'''

Thanks.
-Geliang

> @@ -760,8 +767,8 @@ static inline int mptcp_rm_addr_len(const struct mptc=
p_rm_list *rm_list)
>         return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) +=
 1;
>  }
>
> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remai=
ning,
> -                             struct mptcp_addr_info *saddr, bool *echo, =
bool *port);
> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_out_o=
ptions *opts,
> +                             u8 *add_addr);
>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remain=
ing,
>                              struct mptcp_rm_list *rm_list);
>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *sk=
c);
> --
> 1.8.3.1
>
>
