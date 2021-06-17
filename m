Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8C71
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 12:37:52 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id n12so4837300pgs.13
        for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=16T2p4iKE+HrCJruB+yqpNpgtsjdDmroWJ2VHh/OMjw=;
        b=fpKoQhaKcJmp6MqA1iUW2/dIM02Qaa2oS2bmOpmyAB48rG9BKlix+LC/kDNJMPvhR+
         6h6Sc5KIJFTqFElnxlLzm4XEuO3RzPCUsaNiHmBfv8l9lz+P5gSaede6sDTwMHJ3U1Qi
         PFo3FZBznMaTT8RastCh49bybPsfk2NEZ2a95Z8xP6SNoc/PUv4pU3LOnQjOgMZaEzAb
         UKI7mfIrEn7cENxYnjTN65u0xfwRtxpvpjeJ37xEk+t5pLHd7bHvUF6udF9X0orOm+zn
         nTnK2o8pUxKWGSxxuJUuRDSDzNztE7igHs39HCxiJ8uxHmezHtgK5cXE1Q1iSXruKLgC
         ub/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=16T2p4iKE+HrCJruB+yqpNpgtsjdDmroWJ2VHh/OMjw=;
        b=OLCUADglD0OyC2YOWKzxy8PZnjVbZeh0ldu+ijl9v2ZHmN6Vqzb8+LOC8/lO8jS41s
         99XZhW0qTP3OiUSTBUG7FaLdvM2dF9boTUHeBnLBkNif3yp1q+2ja+WLkQBmv7vs+WlQ
         KYsLX3DqpHhKeT2hS3ofqtu8jXtzYznegnnlR7fdhiduRxLnc4oOslucXB4HrGrxBOBU
         VSSDV7dqeSZBtZxvrzbuVWTKlx7SApWV7WBeyg9/AgyvQ0Wu8ugV64z203UUIj+O/OrL
         bR0TYPfYGnz7VhEXN7iIChHMwgNNTJz7KIYHlsqHMoNogSs1+CMCkBIVPxYJHdnWVrs3
         5glQ==
X-Gm-Message-State: AOAM533uEbNi1FbxncoXnvBIQshu42dsBpzxlf/G9iZyy6IZXhENIGna
	vWAtjw92KAUD581CAeDNDXBkBq3fVjEnZbCOqNo=
X-Google-Smtp-Source: ABdhPJzl76bLERYWd+QnniuwVxln1+/DWB9Udboa4IdoQ38w74DEoxqlEPdcUyy7qL0LKCM+3cX/3T0/pcaqFNVuA10=
X-Received: by 2002:a63:1824:: with SMTP id y36mr4782465pgl.331.1623933471612;
 Thu, 17 Jun 2021 05:37:51 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1623921276-97178-1-git-send-email-liyonglong@chinatelecom.cn> <1623921276-97178-4-git-send-email-liyonglong@chinatelecom.cn>
In-Reply-To: <1623921276-97178-4-git-send-email-liyonglong@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 17 Jun 2021 20:37:40 +0800
Message-ID: <CA+WQbwsweV92fEpK2bMBt5fzdh=aJExtkDaV4xh7hSxS62mzdg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yonglong,

Thanks for this patch set.

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=8817=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:15=E5=86=99=E9=81=93=EF=BC=
=9A
>
> according MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO flag build
> ADD_ADDR/echo-ADD_ADDR option
>
> add a suboptions type OPTION_MPTCP_ADD_ECHO to mark as echo option
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  net/mptcp/options.c  | 161 +++++++++++++++++++++++++++++++++------------=
------
>  net/mptcp/pm.c       |  30 +++-------
>  net/mptcp/protocol.h |  13 +++--
>  3 files changed, 122 insertions(+), 82 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 1aec016..3ecf2c6 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -655,43 +655,72 @@ static bool mptcp_established_options_add_addr(stru=
ct sock *sk, struct sk_buff *
>         struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
>         bool drop_other_suboptions =3D false;
>         unsigned int opt_size =3D *size;
> -       bool echo;
> -       bool port;
> +       struct mptcp_addr_info remote;
> +       struct mptcp_addr_info local;
> +       int ret =3D false;
> +       u8 add_addr, flags;
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
> -               return false;
> -
> -       *size =3D len;
> -       if (drop_other_suboptions)
> -               *size -=3D opt_size;
> -       opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> -       if (!echo) {
> +       if (!mptcp_pm_should_add_signal(msk))
> +               goto out;
> +
> +       *size =3D 0;
> +       mptcp_pm_add_addr_signal(msk, &local, &remote, &add_addr);
> +       if (mptcp_pm_should_add_signal_echo(msk)) {
> +               if (skb && skb_is_tcp_pure_ack(skb)) {
> +                       pr_debug("drop other suboptions");
> +                       opts->suboptions =3D 0;
> +                       opts->ext_copy.use_ack =3D 0;
> +                       opts->ext_copy.use_map =3D 0;
> +                       remaining +=3D opt_size;
> +                       drop_other_suboptions =3D true;
> +               }
> +               len =3D mptcp_add_addr_len(remote.family, true, !!remote.=
port);
> +               if (remaining < len && mptcp_pm_should_add_signal_addr(ms=
k))
> +                       goto add_addr;
> +               else if (remaining < len)
> +                       goto out;
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
> +add_addr:
> +               if ((local.family =3D=3D AF_INET6 || local.port) && skb &=
&
> +                   skb_is_tcp_pure_ack(skb)) {
> +                       pr_debug("drop other suboptions");
> +                       opts->suboptions =3D 0;
> +                       opts->ext_copy.use_ack =3D 0;
> +                       opts->ext_copy.use_map =3D 0;
> +                       remaining +=3D opt_size;
> +                       drop_other_suboptions =3D true;
> +               }
> +               len =3D mptcp_add_addr_len(local.family, false, !!local.p=
ort);
> +               if (remaining < len)
> +                       goto out;
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

There are some duplicate codes here between the
mptcp_pm_should_add_signal_echo(msk) trunk and the
mptcp_pm_should_add_signal_addr(msk) trunk, could you please simply them
into one trunk?

> -       pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
> -                opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port)=
);
>
> -       return true;
> +       if (drop_other_suboptions)
> +               *size -=3D opt_size;
> +       spin_lock_bh(&msk->pm.lock);
> +       WRITE_ONCE(msk->pm.addr_signal, flags | msk->pm.addr_signal);
> +       spin_unlock_bh(&msk->pm.lock);
> +       ret =3D true;
> +
> +out:
> +       return ret;
>  }
>
>  static bool mptcp_established_options_rm_addr(struct sock *sk,
> @@ -1230,21 +1259,18 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
>  mp_capable_done:
>         if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
>                 u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> -               u8 echo =3D MPTCP_ADDR_ECHO;
> +               u8 echo =3D 0;
>
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>                 if (opts->addr.family =3D=3D AF_INET6)
>                         len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>  #endif
>
> +               len +=3D sizeof(opts->ahmac);
> +
>                 if (opts->addr.port)
>                         len +=3D TCPOLEN_MPTCP_PORT_LEN;
>
> -               if (opts->ahmac) {
> -                       len +=3D sizeof(opts->ahmac);
> -                       echo =3D 0;
> -               }
> -
>                 *ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
>                                       len, echo, opts->addr.id);
>                 if (opts->addr.family =3D=3D AF_INET) {
> @@ -1259,30 +1285,55 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
>  #endif
>
>                 if (!opts->addr.port) {
> -                       if (opts->ahmac) {
> -                               put_unaligned_be64(opts->ahmac, ptr);
> -                               ptr +=3D 2;
> -                       }
> +                       put_unaligned_be64(opts->ahmac, ptr);
> +                       ptr +=3D 2;
>                 } else {
>                         u16 port =3D ntohs(opts->addr.port);
> +                       u8 *bptr =3D (u8 *)ptr;
>
> -                       if (opts->ahmac) {
> -                               u8 *bptr =3D (u8 *)ptr;
> +                       put_unaligned_be16(port, bptr);
> +                       bptr +=3D 2;
> +                       put_unaligned_be64(opts->ahmac, bptr);
> +                       bptr +=3D 8;
> +                       put_unaligned_be16(TCPOPT_NOP << 8 |
> +                                          TCPOPT_NOP, bptr);
>
> -                               put_unaligned_be16(port, bptr);
> -                               bptr +=3D 2;
> -                               put_unaligned_be64(opts->ahmac, bptr);
> -                               bptr +=3D 8;
> -                               put_unaligned_be16(TCPOPT_NOP << 8 |
> -                                                  TCPOPT_NOP, bptr);
> +                       ptr +=3D 3;
> +               }
> +       }
>
> -                               ptr +=3D 3;
> -                       } else {
> -                               put_unaligned_be32(port << 16 |
> -                                                  TCPOPT_NOP << 8 |
> -                                                  TCPOPT_NOP, ptr);
> -                               ptr +=3D 1;
> -                       }
> +       if (OPTION_MPTCP_ADD_ECHO & opts->suboptions) {
> +               u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> +               u8 echo =3D MPTCP_ADDR_ECHO;
> +
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +               if (opts->remote.family =3D=3D AF_INET6)
> +                       len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> +#endif
> +
> +               if (opts->remote.port)
> +                       len +=3D TCPOLEN_MPTCP_PORT_LEN;
> +
> +               *ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> +                                     len, echo, opts->remote.id);
> +               if (opts->remote.family =3D=3D AF_INET) {
> +                       memcpy((u8 *)ptr, (u8 *)&opts->remote.addr.s_addr=
, 4);
> +                       ptr +=3D 1;
> +               }
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +               else if (opts->remote.family =3D=3D AF_INET6) {
> +                       memcpy((u8 *)ptr, opts->remote.addr6.s6_addr, 16)=
;
> +                       ptr +=3D 4;
> +               }
> +#endif
> +
> +               if (opts->remote.port) {
> +                       u16 port =3D ntohs(opts->remote.port);
> +
> +                       put_unaligned_be32(port << 16 |
> +                                          TCPOPT_NOP << 8 |
> +                                          TCPOPT_NOP, ptr);
> +                       ptr +=3D 1;
>                 }
>         }

And the same here between the OPTION_MPTCP_ADD_ADDR trunk and the
OPTION_MPTCP_ADD_ECHO trunk.

Thanks.
-Geliang

>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 74be6d7..a62d4a5 100644
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
> -       add_addr =3D msk->pm.addr_signal & BIT(MPTCP_RM_ADDR_SIGNAL);
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
