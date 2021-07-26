Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B94472
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 03:22:01 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id mt6so11076702pjb.1
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 20:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+CyzlG4LxoYrEqqaV+nRTQcWaJv2DhMyYbfCqty4f/4=;
        b=M0aLM2wGEmcuG0VPViKAD/zizwwmDZ5g7QXV8cKI6tbvPBchwjOld9vPN+jGwJRDEl
         lvdW2cmh0L2daynN1s2w+MlyzuiefY5yjWXMQArCRR+DM9Wea1U+P+k/V+l7+ls/bcvH
         frH8BeOR4TcS6Bdnt3XymcQ6ka1KMFvIMSnKOutxNdeLWwDz6vvNchnZh6f4rzI1qSzF
         +cUzgVcA44jo3x/nU9MsFgDzkHD2c4acReTxBiZxdxhCOanv6p2U8dG2kOslLT+LImFs
         doR2bGZvko+B3TN8MMBM/bhOy0ZfxfhyhCWdiDFhq9LBqxgTEIu/BiWJ2fzdnsnTTu7t
         yvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+CyzlG4LxoYrEqqaV+nRTQcWaJv2DhMyYbfCqty4f/4=;
        b=Aw88egn2r2pUYTCcR787KDh8QhOuZ/j4PxvLYitoDuQmf2XJSkN2DfF9k7Wky0osEm
         ejqQfNGuH/s6sAQhI9fHhiaheJLgJHHciTsrbgr1dJtUlPgvPq8SYbNaT2aCB/tN6ZYA
         vlDPcIqo1liVQPS+Xjt8WpgpLAoCIgSKD7t/KaRiByVYMLG/wzt+enX8v8y4t46mfJey
         /6qfzlAjz7BkQyM1Uj4/X4nmyESDkaXhINOlRJXuvP3r5hIr1o8kcDJ4Hck1sXt9UPcY
         /Aa2VJttCsXzsjjQK0CRflnPcS8K5yK6LDAlUp2vpzS7ViHhu9vyTKmgKaDk8ljkfGMP
         4E4g==
X-Gm-Message-State: AOAM531cNQAG4GVE6c7O+GlB+R59bXky92qIzKJq7nsxJI+yw/+XSGU6
	KTbkcogAqrk4e4Pm0jrIva4FVUcf75pbY4L2ihk=
X-Google-Smtp-Source: ABdhPJxjgekMNyFVzYmNYwbw+0+BD+O1sqeeI7QTuTfSU9tPnCIFimOyBUaOtUu9j8Ho78TaxfNlh0obJnGou0wNgvY=
X-Received: by 2002:a17:90a:17a1:: with SMTP id q30mr14995422pja.190.1627269720902;
 Sun, 25 Jul 2021 20:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1627059686.git.pabeni@redhat.com> <b886e46981b5f02c726f92655fabd054f4dc9217.1627059686.git.pabeni@redhat.com>
In-Reply-To: <b886e46981b5f02c726f92655fabd054f4dc9217.1627059686.git.pabeni@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 26 Jul 2021 11:21:49 +0800
Message-ID: <CA+WQbwsKBpXVVqDX32EDROX8kjo1efcgoPd10kDOt9hCHHNvdA@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: optimize out option generation
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thanks for this patchset, and I have some small comments.

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8824=E6=97=A5=
=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Currently we have several protocol contraint on MPTCP option
> generation (e.g. MPC and MPJ subopt are mutually exclusive)
> and some additionall ones required by our implementation
> (e.g. almost all ADD_ADDR variant are mutually exclusive with
> everything else).
>
> We can leverage the above to optimize the out option generation:
> we check DSS/MPC/MPJ presencence in a mutually exclusive way,
> avoiding many unneeded conditionals in the common case.
>
> Additionally extend the existing constraint on ADD_ADDR opt on
> all subvariant, so that it become fully mutually exclusive with
> the above and we can skip another conditional statement the common
> case.
>
> This change is also need by the next patch.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> --
> side node: we could probably optimize the conditionals in
> mptcp_established_options()
> ---
>  net/mptcp/options.c  | 225 ++++++++++++++++++++++---------------------
>  net/mptcp/pm.c       |   9 +-
>  net/mptcp/protocol.h |   1 +
>  3 files changed, 122 insertions(+), 113 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index eafdb9408f3a..38f324667761 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -592,6 +592,7 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
>                 dss_size =3D map_size;
>                 if (skb && snd_data_fin_enable)
>                         mptcp_write_data_fin(subflow, skb, &opts->ext_cop=
y);
> +               opts->suboptions =3D OPTION_MPTCP_DSS;
>                 ret =3D true;
>         }
>
> @@ -615,6 +616,7 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
>                 opts->ext_copy.ack64 =3D 0;
>         }
>         opts->ext_copy.use_ack =3D 1;
> +       opts->suboptions =3D OPTION_MPTCP_DSS;
>         WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
>
>         /* Add kind/length/subtype/flag overhead if mapping is not popula=
ted */
> @@ -663,9 +665,9 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *

I think no need to modify the code in mptcp_established_options_add_addr.

>         struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
>         bool drop_other_suboptions =3D false;
>         unsigned int opt_size =3D *size;
> +       unsigned int len;
>         bool echo;
>         bool port;
> -       int len;

I prefer to keep the type of len unchanged.

>
>         if (!mptcp_pm_should_add_signal(msk) ||
>             !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts=
,
> @@ -687,11 +689,12 @@ static bool mptcp_established_options_add_addr(stru=
ct sock *sk, struct sk_buff *
>                 *size -=3D opt_size;
>         }
>         opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> -       if (!echo) {
> +       if (!echo)
>                 opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
>                                                      msk->remote_key,
>                                                      &opts->addr);
> -       }
> +       else
> +               opts->ahmac =3D 0;

opts->ahmac had been set to zero in mptcp_get_options, no need to clear it
again.

>         pr_debug("addr_id=3D%d, addr_port=3D%d, ahmac=3D%llu, echo=3D%d",
>                  opts->addr.id, ntohs(opts->addr.port), opts->ahmac, echo=
);
>
> @@ -735,7 +738,12 @@ static bool mptcp_established_options_mp_prio(struct=
 sock *sk,
>  {
>         struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
>
> -       if (!subflow->send_mp_prio)
> +       /* can't send MP_PRIO with MPC, as they share the same option spa=
ce:
> +        * 'backup'. Also it makes no sense at all
> +        */
> +       if (!subflow->send_mp_prio ||
> +            ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
> +              OPTION_MPTCP_MPC_ACK) & opts->suboptions))
>                 return false;
>
>         /* account for the trailing 'nop' option */
> @@ -1198,7 +1206,73 @@ static u16 mptcp_make_csum(const struct mptcp_ext =
*mpext)
>  void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>                          struct mptcp_out_options *opts)
>  {
> -       if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
> +       /* RST is mutually exclusive with everything else */
> +       if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
> +               *ptr++ =3D mptcp_option(MPTCPOPT_RST,
> +                                     TCPOLEN_MPTCP_RST,
> +                                     opts->reset_transient,
> +                                     opts->reset_reason);
> +               return;
> +       }
> +
> +       /* DSS, MPC, MPJ and ADD_ADDR are mutually exclusive, see
> +        * mptcp_established_options*()
> +        */
> +       if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
> +               struct mptcp_ext *mpext =3D &opts->ext_copy;
> +               u8 len =3D TCPOLEN_MPTCP_DSS_BASE;
> +               u8 flags =3D 0;
> +
> +               if (mpext->use_ack) {
> +                       flags =3D MPTCP_DSS_HAS_ACK;
> +                       if (mpext->ack64) {
> +                               len +=3D TCPOLEN_MPTCP_DSS_ACK64;
> +                               flags |=3D MPTCP_DSS_ACK64;
> +                       } else {
> +                               len +=3D TCPOLEN_MPTCP_DSS_ACK32;
> +                       }
> +               }
> +
> +               if (mpext->use_map) {
> +                       len +=3D TCPOLEN_MPTCP_DSS_MAP64;
> +
> +                       /* Use only 64-bit mapping flags for now, add
> +                        * support for optional 32-bit mappings later.
> +                        */
> +                       flags |=3D MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
> +                       if (mpext->data_fin)
> +                               flags |=3D MPTCP_DSS_DATA_FIN;
> +
> +                       if (opts->csum_reqd)
> +                               len +=3D TCPOLEN_MPTCP_DSS_CHECKSUM;
> +               }
> +
> +               *ptr++ =3D mptcp_option(MPTCPOPT_DSS, len, 0, flags);
> +
> +               if (mpext->use_ack) {
> +                       if (mpext->ack64) {
> +                               put_unaligned_be64(mpext->data_ack, ptr);
> +                               ptr +=3D 2;
> +                       } else {
> +                               put_unaligned_be32(mpext->data_ack32, ptr=
);
> +                               ptr +=3D 1;
> +                       }
> +               }
> +
> +               if (mpext->use_map) {
> +                       put_unaligned_be64(mpext->data_seq, ptr);
> +                       ptr +=3D 2;
> +                       put_unaligned_be32(mpext->subflow_seq, ptr);
> +                       ptr +=3D 1;
> +                       if (opts->csum_reqd) {
> +                               put_unaligned_be32(mpext->data_len << 16 =
|
> +                                                  mptcp_make_csum(mpext)=
, ptr);
> +                       } else {
> +                               put_unaligned_be32(mpext->data_len << 16 =
|
> +                                                  TCPOPT_NOP << 8 | TCPO=
PT_NOP, ptr);
> +                       }
> +               }
> +       } else if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
>              OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
>                 u8 len, flag =3D MPTCP_CAP_HMAC_SHA256;
>
> @@ -1246,10 +1320,31 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
>                                            TCPOPT_NOP << 8 | TCPOPT_NOP, =
ptr);
>                 }
>                 ptr +=3D 1;
> -       }
>
> -mp_capable_done:
> -       if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> +               /* MPC is additionally mutually exclusive with MP_PRIO */
> +               goto mp_capable_done;
> +       } else if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
> +               *ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
> +                                     TCPOLEN_MPTCP_MPJ_SYN,
> +                                     opts->backup, opts->join_id);
> +               put_unaligned_be32(opts->token, ptr);
> +               ptr +=3D 1;
> +               put_unaligned_be32(opts->nonce, ptr);
> +               ptr +=3D 1;
> +       } else if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
> +               *ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
> +                                     TCPOLEN_MPTCP_MPJ_SYNACK,
> +                                     opts->backup, opts->join_id);
> +               put_unaligned_be64(opts->thmac, ptr);
> +               ptr +=3D 2;
> +               put_unaligned_be32(opts->nonce, ptr);
> +               ptr +=3D 1;
> +       } else if (OPTION_MPTCP_MPJ_ACK & opts->suboptions) {
> +               *ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
> +                                     TCPOLEN_MPTCP_MPJ_ACK, 0, 0);
> +               memcpy(ptr, opts->hmac, MPTCPOPT_HMAC_LEN);
> +               ptr +=3D 5;
> +       } else if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
>                 struct mptcp_addr_info *addr =3D &opts->addr;
>                 u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
>                 u8 echo =3D MPTCP_ADDR_ECHO;
> @@ -1308,6 +1403,19 @@ void mptcp_write_options(__be32 *ptr, const struct=
 tcp_sock *tp,
>                 }
>         }
>
> +       if (OPTION_MPTCP_PRIO & opts->suboptions) {
> +               const struct sock *ssk =3D (const struct sock *)tp;
> +               struct mptcp_subflow_context *subflow;
> +
> +               subflow =3D mptcp_subflow_ctx(ssk);
> +               subflow->send_mp_prio =3D 0;
> +
> +               *ptr++ =3D mptcp_option(MPTCPOPT_MP_PRIO,
> +                                     TCPOLEN_MPTCP_PRIO,
> +                                     opts->backup, TCPOPT_NOP);
> +       }
> +
> +mp_capable_done:
>         if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
>                 u8 i =3D 1;
>
> @@ -1328,107 +1436,6 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
>                 }
>         }
>
> -       if (OPTION_MPTCP_PRIO & opts->suboptions) {
> -               const struct sock *ssk =3D (const struct sock *)tp;
> -               struct mptcp_subflow_context *subflow;
> -
> -               subflow =3D mptcp_subflow_ctx(ssk);
> -               subflow->send_mp_prio =3D 0;
> -
> -               *ptr++ =3D mptcp_option(MPTCPOPT_MP_PRIO,
> -                                     TCPOLEN_MPTCP_PRIO,
> -                                     opts->backup, TCPOPT_NOP);
> -       }
> -
> -       if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
> -               *ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
> -                                     TCPOLEN_MPTCP_MPJ_SYN,
> -                                     opts->backup, opts->join_id);
> -               put_unaligned_be32(opts->token, ptr);
> -               ptr +=3D 1;
> -               put_unaligned_be32(opts->nonce, ptr);
> -               ptr +=3D 1;
> -       }
> -
> -       if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
> -               *ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
> -                                     TCPOLEN_MPTCP_MPJ_SYNACK,
> -                                     opts->backup, opts->join_id);
> -               put_unaligned_be64(opts->thmac, ptr);
> -               ptr +=3D 2;
> -               put_unaligned_be32(opts->nonce, ptr);
> -               ptr +=3D 1;
> -       }
> -
> -       if (OPTION_MPTCP_MPJ_ACK & opts->suboptions) {
> -               *ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
> -                                     TCPOLEN_MPTCP_MPJ_ACK, 0, 0);
> -               memcpy(ptr, opts->hmac, MPTCPOPT_HMAC_LEN);
> -               ptr +=3D 5;
> -       }
> -
> -       if (OPTION_MPTCP_RST & opts->suboptions)
> -               *ptr++ =3D mptcp_option(MPTCPOPT_RST,
> -                                     TCPOLEN_MPTCP_RST,
> -                                     opts->reset_transient,
> -                                     opts->reset_reason);
> -
> -       if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
> -               struct mptcp_ext *mpext =3D &opts->ext_copy;
> -               u8 len =3D TCPOLEN_MPTCP_DSS_BASE;
> -               u8 flags =3D 0;
> -
> -               if (mpext->use_ack) {
> -                       flags =3D MPTCP_DSS_HAS_ACK;
> -                       if (mpext->ack64) {
> -                               len +=3D TCPOLEN_MPTCP_DSS_ACK64;
> -                               flags |=3D MPTCP_DSS_ACK64;
> -                       } else {
> -                               len +=3D TCPOLEN_MPTCP_DSS_ACK32;
> -                       }
> -               }
> -
> -               if (mpext->use_map) {
> -                       len +=3D TCPOLEN_MPTCP_DSS_MAP64;
> -
> -                       /* Use only 64-bit mapping flags for now, add
> -                        * support for optional 32-bit mappings later.
> -                        */
> -                       flags |=3D MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
> -                       if (mpext->data_fin)
> -                               flags |=3D MPTCP_DSS_DATA_FIN;
> -
> -                       if (opts->csum_reqd)
> -                               len +=3D TCPOLEN_MPTCP_DSS_CHECKSUM;
> -               }
> -
> -               *ptr++ =3D mptcp_option(MPTCPOPT_DSS, len, 0, flags);
> -
> -               if (mpext->use_ack) {
> -                       if (mpext->ack64) {
> -                               put_unaligned_be64(mpext->data_ack, ptr);
> -                               ptr +=3D 2;
> -                       } else {
> -                               put_unaligned_be32(mpext->data_ack32, ptr=
);
> -                               ptr +=3D 1;
> -                       }
> -               }
> -
> -               if (mpext->use_map) {
> -                       put_unaligned_be64(mpext->data_seq, ptr);
> -                       ptr +=3D 2;
> -                       put_unaligned_be32(mpext->subflow_seq, ptr);
> -                       ptr +=3D 1;
> -                       if (opts->csum_reqd) {
> -                               put_unaligned_be32(mpext->data_len << 16 =
|
> -                                                  mptcp_make_csum(mpext)=
, ptr);
> -                       } else {
> -                               put_unaligned_be32(mpext->data_len << 16 =
|
> -                                                  TCPOPT_NOP << 8 | TCPO=
PT_NOP, ptr);
> -                       }
> -               }
> -       }
> -
>         if (tp)
>                 mptcp_set_rwin(tp);
>  }
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 4d1828fd2482..baf2d6e524bd 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -266,10 +266,11 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *ms=
k, struct sk_buff *skb,
>         if (!mptcp_pm_should_add_signal(msk))
>                 goto out_unlock;
>
> -       if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
> -            ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
> -             (msk->pm.local.family =3D=3D AF_INET6 || msk->pm.local.port=
))) &&
> -           skb && skb_is_tcp_pure_ack(skb)) {
> +       /* always drop every other options for pure ack ADD_ADDR; this is
> +        * plain dup-ack from TCP perspective. The other MPTCP-relevant i=
nfo,
> +        * if any, will be carried by the other pure ack
> +        */
> +       if (skb && skb_is_tcp_pure_ack(skb)) {
>                 remaining +=3D opt_size;
>                 *drop_other_suboptions =3D true;
>         }

This part in pm.c should be squashed to the patch "mptcp: move
drop_other_suboptions check under pm lock".

WDYT?

Thanks,
-Geliang

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 34ad1c4bc29f..d960d8b8a8ce 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -26,6 +26,7 @@
>  #define OPTION_MPTCP_FASTCLOSE BIT(8)
>  #define OPTION_MPTCP_PRIO      BIT(9)
>  #define OPTION_MPTCP_RST       BIT(10)
> +#define OPTION_MPTCP_DSS       BIT(11)
>
>  /* MPTCP option subtypes */
>  #define MPTCPOPT_MP_CAPABLE    0
> --
> 2.26.3
>
>
