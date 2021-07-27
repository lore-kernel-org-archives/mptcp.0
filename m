Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4088570
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 04:34:05 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so2336720pjb.3
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 21:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wiEQ/1s/D9pzScgOxU1luTH7p21lz1ZXL6bXmgYkrMY=;
        b=TxjGeTG5kVcmPLzjRkv++qeKocTnDV3iFT4RSsHEqaGU3MMGRDhzR+PB9Z+vDW7aO5
         AJNkZbnoxcrNFHFqpVf2zIAaRoBiiY3TbL5sqtSN5p1DoGvG6bKPfxSp7PIZBpH+pWAg
         hOFRkM/Nfxerlu9ta5VRmGhCKJHv6hG6h1biBp9pOF1wamYitGrq29ltojriNCMPpXEG
         0M3XG8lvzYnlIKJ0hOxWv+Kv8BhC9F+4zbvuJMpGOZWe99u4fNg5jIRHtI7ikLngBkHU
         wKTJEA5Mdl3DJw9v1+mThXgbIt74SEweip6JcS70UDN2U7GE9e+P2Mfw9zZYKwx/fHB7
         8wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wiEQ/1s/D9pzScgOxU1luTH7p21lz1ZXL6bXmgYkrMY=;
        b=mvNj+Let1v1inLiTexbgh2DQ9dbdWCKjkpdGSORt+SZRyPVp7g3OwfaLqoQKfr92bY
         0Tv1LhxlUXbY/+K6IUj+n5PXmFfFTH6EVNTLu1sOgSNA84gefsnHVEAFaGhTwd90NUKY
         2i5zNocKaMz6B65ahc2eEqII3kzCYUFmiSzEG6O+VziI/JD65uTe3/jhG/8hg+MmuNQI
         lmTiMewlSAEqbnCgd+CTtrSZrGlNmhYbVo90COB0+wbS6QpgPCf35U3YUypmW89A4eoj
         K64DM7DKJW8D0scDmwnl/IgLjp4P3aXAaxeVbf3D4ZOX5SJ0KpGqXtMlvF+iuI9xVjCw
         LjHQ==
X-Gm-Message-State: AOAM530RvaGHeWKSy/uW8TuVFXhtJyIbqRvO38z0AwroZT5FQ4AuPVZf
	YXEdYFx62FwKynHHE89eOM0R9QB6xWuUwheahVU=
X-Google-Smtp-Source: ABdhPJxwmNy3Crm3x3AdM1lffWnG2iPVHttyr6sYXCFNL7tZWZeAk3TvefY0225SVCG571grTXyN3yy5gWmY4CSaOV0=
X-Received: by 2002:aa7:874c:0:b029:39a:56d1:6d42 with SMTP id
 g12-20020aa7874c0000b029039a56d16d42mr7404234pfo.58.1627360444689; Mon, 26
 Jul 2021 21:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1627296764.git.pabeni@redhat.com> <31938eaa6cd1d45c22d184c1df7970f904785500.1627296764.git.pabeni@redhat.com>
In-Reply-To: <31938eaa6cd1d45c22d184c1df7970f904785500.1627296764.git.pabeni@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 27 Jul 2021 12:33:53 +0800
Message-ID: <CA+WQbwsNTPBrVQB24V6gEYSvTw8AwS9xr1cBM-_s-L2vCz4-jg@mail.gmail.com>
Subject: Re: [PATCH v3 mptcp-next 2/3] mptcp: optimize out option generation
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8826=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=886:55=E5=86=99=E9=81=93=EF=BC=9A
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
> v1 -> v2:
>  - moved the pm.c chunk into the previous patch
>  - avoid changing 'len' type - Geliang
>  - add a comment describing why we need to clear ahmac field
>  - don't clear ext_copy fields anymore in mptcp_pm_add_addr_signal()
>    not needed and confusing
>
> side node: we could probably optimize the conditionals in
> mptcp_established_options()
> ---
>  net/mptcp/options.c  | 227 +++++++++++++++++++++++--------------------
>  net/mptcp/protocol.h |   1 +
>  2 files changed, 120 insertions(+), 108 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index eafdb9408f3a..c14314268b36 100644
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
> @@ -682,8 +684,13 @@ static bool mptcp_established_options_add_addr(struc=
t sock *sk, struct sk_buff *
>         if (drop_other_suboptions) {
>                 pr_debug("drop other suboptions");
>                 opts->suboptions =3D 0;
> -               opts->ext_copy.use_ack =3D 0;
> -               opts->ext_copy.use_map =3D 0;
> +
> +               /* note that e.g. DSS could have written into the memory
> +                * aliased by ahmac, we must reset the field here
> +                * to avoid appending the hmac even for ADD_ADDR echo
> +                * options
> +                */
> +               opts->ahmac =3D 0;
>                 *size -=3D opt_size;
>         }
>         opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> @@ -735,7 +742,12 @@ static bool mptcp_established_options_mp_prio(struct=
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
> @@ -1198,7 +1210,73 @@ static u16 mptcp_make_csum(const struct mptcp_ext =
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
> @@ -1246,10 +1324,31 @@ void mptcp_write_options(__be32 *ptr, const struc=
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

This will conflict with: (Squash to "Squash-to: mptcp: build ADD_ADDR/
echo-ADD_ADDR option according pm.add_signal"), since this line is removed
in it.

Thanks,
-Geliang

>                 u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
>                 u8 echo =3D MPTCP_ADDR_ECHO;
> @@ -1308,6 +1407,19 @@ void mptcp_write_options(__be32 *ptr, const struct=
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
> @@ -1328,107 +1440,6 @@ void mptcp_write_options(__be32 *ptr, const struc=
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
