Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C464972
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 10:02:58 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id e14so10969550plh.8
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 03:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bnthbpjAin+knzCJs28gXBjbRp+FfGQpU4QMmsW4/Zw=;
        b=IAFo89Gv/66SSkR8nFrGSP4FkX3YJUAWP6FO9k0nutNUSLdrGpK3ue3oGYPLKljXxs
         OIO0Ps39uQbkRdo0wjoxE5xyDcYS/hP0w0aEmlm4za0PU91WbbayFvtIBpY23eeJ7qrp
         mmHGeL3hyQHa0y/XV+U2g7vvGhkw4Xthu2AmZFvC2AsijNxScAwFXB+fqYWgTdnvM+gM
         ctYypuLAGJcbFG3Fa8dv74VGraxhNLpdyQtMH3lJHSLZdpmpPGMRYlfR/eX4vS6Ji+sm
         R+Rw4VJZO4I9MADquYuccIwzN2QUQnJw0iQZM4kmqPvs6i0+wTX087YlFVdK5+XfQtVW
         TKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bnthbpjAin+knzCJs28gXBjbRp+FfGQpU4QMmsW4/Zw=;
        b=o2qxl3ggn/CFgIM+a3pUNM3qmgUAlfFK4BdnPIXw5GQiFwTK5vToVapi8B4xMVi1j2
         a9oI3sLcwNHAx2jsczD0NH5Bz2l0Je9sE2g+2s5UhlfUm8dOIqg+dwu1X8BkYScwyW8r
         ecejVJweLoKZTtQjs7gyR62AH49kKgcPxpsKy+/OD7P19Xy4dSxXWqjuiBOOVhDqybVV
         wsiBq8En36SSbZ5I9JsxRp46TwWeQ5V2gww+RkLUUH1aZeVZMGd2tp+2zzAtkHZwBX2W
         /CudAYiHtQmvdtsUYzRgfj1d0E3IpvgkrLM7AbWV9JZWF9b+wKTpLj7NKjlX8SxkZqIB
         dk7Q==
X-Gm-Message-State: AOAM530g5YqBP1k/sDHabAL6pXTZSJtbcvN6OypcmDsESTRkNQfKb6k0
	BL1LWvUzOtU4ZFNFJWZn1gBNqlb/PSCY6VpOH1I=
X-Google-Smtp-Source: ABdhPJyqnKjkcmElgU9j0Ir9x/+xzeyAl9oZ21SpNesxMBoTCErItDa9EmEwCOGZqGHU+QOO6ViHOVrkUVVM2/gl3U8=
X-Received: by 2002:a63:2bcf:: with SMTP id r198mr7291804pgr.373.1627293778289;
 Mon, 26 Jul 2021 03:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1627059686.git.pabeni@redhat.com> <b886e46981b5f02c726f92655fabd054f4dc9217.1627059686.git.pabeni@redhat.com>
 <CA+WQbwsKBpXVVqDX32EDROX8kjo1efcgoPd10kDOt9hCHHNvdA@mail.gmail.com> <a816ed1d1be07abcd7fa55efe167141cd425426c.camel@redhat.com>
In-Reply-To: <a816ed1d1be07abcd7fa55efe167141cd425426c.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 26 Jul 2021 18:02:47 +0800
Message-ID: <CA+WQbwuG7MTs9iv7K5eCwRpi1X9ioRoMMugCasHejmPnY5K-SA@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: optimize out option generation
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8826=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 2021-07-26 at 11:21 +0800, Geliang Tang wrote:
> > Hi Paolo,
> >
> > Thanks for this patchset, and I have some small comments.
> >
> > Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8824=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:06=E5=86=99=E9=81=93=EF=BC=9A
> > > Currently we have several protocol contraint on MPTCP option
> > > generation (e.g. MPC and MPJ subopt are mutually exclusive)
> > > and some additionall ones required by our implementation
> > > (e.g. almost all ADD_ADDR variant are mutually exclusive with
> > > everything else).
> > >
> > > We can leverage the above to optimize the out option generation:
> > > we check DSS/MPC/MPJ presencence in a mutually exclusive way,
> > > avoiding many unneeded conditionals in the common case.
> > >
> > > Additionally extend the existing constraint on ADD_ADDR opt on
> > > all subvariant, so that it become fully mutually exclusive with
> > > the above and we can skip another conditional statement the common
> > > case.
> > >
> > > This change is also need by the next patch.
> > >
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > --
> > > side node: we could probably optimize the conditionals in
> > > mptcp_established_options()
> > > ---
> > >  net/mptcp/options.c  | 225 ++++++++++++++++++++++-------------------=
--
> > >  net/mptcp/pm.c       |   9 +-
> > >  net/mptcp/protocol.h |   1 +
> > >  3 files changed, 122 insertions(+), 113 deletions(-)
> > >
> > > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > > index eafdb9408f3a..38f324667761 100644
> > > --- a/net/mptcp/options.c
> > > +++ b/net/mptcp/options.c
> > > @@ -592,6 +592,7 @@ static bool mptcp_established_options_dss(struct =
sock *sk, struct sk_buff *skb,
> > >                 dss_size =3D map_size;
> > >                 if (skb && snd_data_fin_enable)
> > >                         mptcp_write_data_fin(subflow, skb, &opts->ext=
_copy);
> > > +               opts->suboptions =3D OPTION_MPTCP_DSS;
> > >                 ret =3D true;
> > >         }
> > >
> > > @@ -615,6 +616,7 @@ static bool mptcp_established_options_dss(struct =
sock *sk, struct sk_buff *skb,
> > >                 opts->ext_copy.ack64 =3D 0;
> > >         }
> > >         opts->ext_copy.use_ack =3D 1;
> > > +       opts->suboptions =3D OPTION_MPTCP_DSS;
> > >         WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk)=
);
> > >
> > >         /* Add kind/length/subtype/flag overhead if mapping is not po=
pulated */
> > > @@ -663,9 +665,9 @@ static bool mptcp_established_options_add_addr(st=
ruct sock *sk, struct sk_buff *
> >
> > I think no need to modify the code in mptcp_established_options_add_add=
r.
> >
> > >         struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> > >         bool drop_other_suboptions =3D false;
> > >         unsigned int opt_size =3D *size;
> > > +       unsigned int len;
> > >         bool echo;
> > >         bool port;
> > > -       int len;
> >
> > I prefer to keep the type of len unchanged.
>
> OK.
>
> >
> > >         if (!mptcp_pm_should_add_signal(msk) ||
> > >             !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, =
opts,
> > > @@ -687,11 +689,12 @@ static bool mptcp_established_options_add_addr(=
struct sock *sk, struct sk_buff *
> > >                 *size -=3D opt_size;
> > >         }
> > >         opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> > > -       if (!echo) {
> > > +       if (!echo)
> > >                 opts->ahmac =3D add_addr_generate_hmac(msk->local_key=
,
> > >                                                      msk->remote_key,
> > >                                                      &opts->addr);
> > > -       }
> > > +       else
> > > +               opts->ahmac =3D 0;
> >
> > opts->ahmac had been set to zero in mptcp_get_options, no need to clear=
 it
> > again.
>
> This is for the output path, mptcp_get_options() is not invoked. 'ops'

Sorry, my fault.

> has been cleared by the TCP caller. Sice a few fields are aliased, and
> the add_addr is added after the DSS, the latter could have already
> modified the underlaying memory.
>
> Without this assignment we will end-up appending the hmac even for
> add_addr 'echo', and a bunch of tests will fail.
>
> Perhaps is better adding some comments explaining why such set
> operation is needed...

Yes, that's helpful.

> >
> > >         pr_debug("addr_id=3D%d, addr_port=3D%d, ahmac=3D%llu, echo=3D=
%d",
> > >                  opts->addr.id, ntohs(opts->addr.port), opts->ahmac, =
echo);
> > >
> > > @@ -735,7 +738,12 @@ static bool mptcp_established_options_mp_prio(st=
ruct sock *sk,
> > >  {
> > >         struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(s=
k);
> > >
> > > -       if (!subflow->send_mp_prio)
> > > +       /* can't send MP_PRIO with MPC, as they share the same option=
 space:
> > > +        * 'backup'. Also it makes no sense at all
> > > +        */
> > > +       if (!subflow->send_mp_prio ||
> > > +            ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
> > > +              OPTION_MPTCP_MPC_ACK) & opts->suboptions))
> > >                 return false;
> > >
> > >         /* account for the trailing 'nop' option */
> > > @@ -1198,7 +1206,73 @@ static u16 mptcp_make_csum(const struct mptcp_=
ext *mpext)
> > >  void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> > >                          struct mptcp_out_options *opts)
> > >  {
> > > -       if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
> > > +       /* RST is mutually exclusive with everything else */
> > > +       if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
> > > +               *ptr++ =3D mptcp_option(MPTCPOPT_RST,
> > > +                                     TCPOLEN_MPTCP_RST,
> > > +                                     opts->reset_transient,
> > > +                                     opts->reset_reason);
> > > +               return;
> > > +       }
> > > +
> > > +       /* DSS, MPC, MPJ and ADD_ADDR are mutually exclusive, see
> > > +        * mptcp_established_options*()
> > > +        */
> > > +       if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
> > > +               struct mptcp_ext *mpext =3D &opts->ext_copy;
> > > +               u8 len =3D TCPOLEN_MPTCP_DSS_BASE;
> > > +               u8 flags =3D 0;
> > > +
> > > +               if (mpext->use_ack) {
> > > +                       flags =3D MPTCP_DSS_HAS_ACK;
> > > +                       if (mpext->ack64) {
> > > +                               len +=3D TCPOLEN_MPTCP_DSS_ACK64;
> > > +                               flags |=3D MPTCP_DSS_ACK64;
> > > +                       } else {
> > > +                               len +=3D TCPOLEN_MPTCP_DSS_ACK32;
> > > +                       }
> > > +               }
> > > +
> > > +               if (mpext->use_map) {
> > > +                       len +=3D TCPOLEN_MPTCP_DSS_MAP64;
> > > +
> > > +                       /* Use only 64-bit mapping flags for now, add
> > > +                        * support for optional 32-bit mappings later=
.
> > > +                        */
> > > +                       flags |=3D MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN6=
4;
> > > +                       if (mpext->data_fin)
> > > +                               flags |=3D MPTCP_DSS_DATA_FIN;
> > > +
> > > +                       if (opts->csum_reqd)
> > > +                               len +=3D TCPOLEN_MPTCP_DSS_CHECKSUM;
> > > +               }
> > > +
> > > +               *ptr++ =3D mptcp_option(MPTCPOPT_DSS, len, 0, flags);
> > > +
> > > +               if (mpext->use_ack) {
> > > +                       if (mpext->ack64) {
> > > +                               put_unaligned_be64(mpext->data_ack, p=
tr);
> > > +                               ptr +=3D 2;
> > > +                       } else {
> > > +                               put_unaligned_be32(mpext->data_ack32,=
 ptr);
> > > +                               ptr +=3D 1;
> > > +                       }
> > > +               }
> > > +
> > > +               if (mpext->use_map) {
> > > +                       put_unaligned_be64(mpext->data_seq, ptr);
> > > +                       ptr +=3D 2;
> > > +                       put_unaligned_be32(mpext->subflow_seq, ptr);
> > > +                       ptr +=3D 1;
> > > +                       if (opts->csum_reqd) {
> > > +                               put_unaligned_be32(mpext->data_len <<=
 16 |
> > > +                                                  mptcp_make_csum(mp=
ext), ptr);
> > > +                       } else {
> > > +                               put_unaligned_be32(mpext->data_len <<=
 16 |
> > > +                                                  TCPOPT_NOP << 8 | =
TCPOPT_NOP, ptr);
> > > +                       }
> > > +               }
> > > +       } else if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
> > >              OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
> > >                 u8 len, flag =3D MPTCP_CAP_HMAC_SHA256;
> > >
> > > @@ -1246,10 +1320,31 @@ void mptcp_write_options(__be32 *ptr, const s=
truct tcp_sock *tp,
> > >                                            TCPOPT_NOP << 8 | TCPOPT_N=
OP, ptr);
> > >                 }
> > >                 ptr +=3D 1;
> > > -       }
> > >
> > > -mp_capable_done:
> > > -       if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> > > +               /* MPC is additionally mutually exclusive with MP_PRI=
O */
> > > +               goto mp_capable_done;
> > > +       } else if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
> > > +               *ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
> > > +                                     TCPOLEN_MPTCP_MPJ_SYN,
> > > +                                     opts->backup, opts->join_id);
> > > +               put_unaligned_be32(opts->token, ptr);
> > > +               ptr +=3D 1;
> > > +               put_unaligned_be32(opts->nonce, ptr);
> > > +               ptr +=3D 1;
> > > +       } else if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
> > > +               *ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
> > > +                                     TCPOLEN_MPTCP_MPJ_SYNACK,
> > > +                                     opts->backup, opts->join_id);
> > > +               put_unaligned_be64(opts->thmac, ptr);
> > > +               ptr +=3D 2;
> > > +               put_unaligned_be32(opts->nonce, ptr);
> > > +               ptr +=3D 1;
> > > +       } else if (OPTION_MPTCP_MPJ_ACK & opts->suboptions) {
> > > +               *ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
> > > +                                     TCPOLEN_MPTCP_MPJ_ACK, 0, 0);
> > > +               memcpy(ptr, opts->hmac, MPTCPOPT_HMAC_LEN);
> > > +               ptr +=3D 5;
> > > +       } else if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> > >                 struct mptcp_addr_info *addr =3D &opts->addr;
> > >                 u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> > >                 u8 echo =3D MPTCP_ADDR_ECHO;
> > > @@ -1308,6 +1403,19 @@ void mptcp_write_options(__be32 *ptr, const st=
ruct tcp_sock *tp,
> > >                 }
> > >         }
> > >
> > > +       if (OPTION_MPTCP_PRIO & opts->suboptions) {
> > > +               const struct sock *ssk =3D (const struct sock *)tp;
> > > +               struct mptcp_subflow_context *subflow;
> > > +
> > > +               subflow =3D mptcp_subflow_ctx(ssk);
> > > +               subflow->send_mp_prio =3D 0;
> > > +
> > > +               *ptr++ =3D mptcp_option(MPTCPOPT_MP_PRIO,
> > > +                                     TCPOLEN_MPTCP_PRIO,
> > > +                                     opts->backup, TCPOPT_NOP);
> > > +       }
> > > +
> > > +mp_capable_done:
> > >         if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
> > >                 u8 i =3D 1;
> > >
> > > @@ -1328,107 +1436,6 @@ void mptcp_write_options(__be32 *ptr, const s=
truct tcp_sock *tp,
> > >                 }
> > >         }
> > >
> > > -       if (OPTION_MPTCP_PRIO & opts->suboptions) {
> > > -               const struct sock *ssk =3D (const struct sock *)tp;
> > > -               struct mptcp_subflow_context *subflow;
> > > -
> > > -               subflow =3D mptcp_subflow_ctx(ssk);
> > > -               subflow->send_mp_prio =3D 0;
> > > -
> > > -               *ptr++ =3D mptcp_option(MPTCPOPT_MP_PRIO,
> > > -                                     TCPOLEN_MPTCP_PRIO,
> > > -                                     opts->backup, TCPOPT_NOP);
> > > -       }
> > > -
> > > -       if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
> > > -               *ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
> > > -                                     TCPOLEN_MPTCP_MPJ_SYN,
> > > -                                     opts->backup, opts->join_id);
> > > -               put_unaligned_be32(opts->token, ptr);
> > > -               ptr +=3D 1;
> > > -               put_unaligned_be32(opts->nonce, ptr);
> > > -               ptr +=3D 1;
> > > -       }
> > > -
> > > -       if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
> > > -               *ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
> > > -                                     TCPOLEN_MPTCP_MPJ_SYNACK,
> > > -                                     opts->backup, opts->join_id);
> > > -               put_unaligned_be64(opts->thmac, ptr);
> > > -               ptr +=3D 2;
> > > -               put_unaligned_be32(opts->nonce, ptr);
> > > -               ptr +=3D 1;
> > > -       }
> > > -
> > > -       if (OPTION_MPTCP_MPJ_ACK & opts->suboptions) {
> > > -               *ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
> > > -                                     TCPOLEN_MPTCP_MPJ_ACK, 0, 0);
> > > -               memcpy(ptr, opts->hmac, MPTCPOPT_HMAC_LEN);
> > > -               ptr +=3D 5;
> > > -       }
> > > -
> > > -       if (OPTION_MPTCP_RST & opts->suboptions)
> > > -               *ptr++ =3D mptcp_option(MPTCPOPT_RST,
> > > -                                     TCPOLEN_MPTCP_RST,
> > > -                                     opts->reset_transient,
> > > -                                     opts->reset_reason);
> > > -
> > > -       if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
> > > -               struct mptcp_ext *mpext =3D &opts->ext_copy;
> > > -               u8 len =3D TCPOLEN_MPTCP_DSS_BASE;
> > > -               u8 flags =3D 0;
> > > -
> > > -               if (mpext->use_ack) {
> > > -                       flags =3D MPTCP_DSS_HAS_ACK;
> > > -                       if (mpext->ack64) {
> > > -                               len +=3D TCPOLEN_MPTCP_DSS_ACK64;
> > > -                               flags |=3D MPTCP_DSS_ACK64;
> > > -                       } else {
> > > -                               len +=3D TCPOLEN_MPTCP_DSS_ACK32;
> > > -                       }
> > > -               }
> > > -
> > > -               if (mpext->use_map) {
> > > -                       len +=3D TCPOLEN_MPTCP_DSS_MAP64;
> > > -
> > > -                       /* Use only 64-bit mapping flags for now, add
> > > -                        * support for optional 32-bit mappings later=
.
> > > -                        */
> > > -                       flags |=3D MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN6=
4;
> > > -                       if (mpext->data_fin)
> > > -                               flags |=3D MPTCP_DSS_DATA_FIN;
> > > -
> > > -                       if (opts->csum_reqd)
> > > -                               len +=3D TCPOLEN_MPTCP_DSS_CHECKSUM;
> > > -               }
> > > -
> > > -               *ptr++ =3D mptcp_option(MPTCPOPT_DSS, len, 0, flags);
> > > -
> > > -               if (mpext->use_ack) {
> > > -                       if (mpext->ack64) {
> > > -                               put_unaligned_be64(mpext->data_ack, p=
tr);
> > > -                               ptr +=3D 2;
> > > -                       } else {
> > > -                               put_unaligned_be32(mpext->data_ack32,=
 ptr);
> > > -                               ptr +=3D 1;
> > > -                       }
> > > -               }
> > > -
> > > -               if (mpext->use_map) {
> > > -                       put_unaligned_be64(mpext->data_seq, ptr);
> > > -                       ptr +=3D 2;
> > > -                       put_unaligned_be32(mpext->subflow_seq, ptr);
> > > -                       ptr +=3D 1;
> > > -                       if (opts->csum_reqd) {
> > > -                               put_unaligned_be32(mpext->data_len <<=
 16 |
> > > -                                                  mptcp_make_csum(mp=
ext), ptr);
> > > -                       } else {
> > > -                               put_unaligned_be32(mpext->data_len <<=
 16 |
> > > -                                                  TCPOPT_NOP << 8 | =
TCPOPT_NOP, ptr);
> > > -                       }
> > > -               }
> > > -       }
> > > -
> > >         if (tp)
> > >                 mptcp_set_rwin(tp);
> > >  }
> > > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > > index 4d1828fd2482..baf2d6e524bd 100644
> > > --- a/net/mptcp/pm.c
> > > +++ b/net/mptcp/pm.c
> > > @@ -266,10 +266,11 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock=
 *msk, struct sk_buff *skb,
> > >         if (!mptcp_pm_should_add_signal(msk))
> > >                 goto out_unlock;
> > >
> > > -       if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
> > > -            ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
> > > -             (msk->pm.local.family =3D=3D AF_INET6 || msk->pm.local.=
port))) &&
> > > -           skb && skb_is_tcp_pure_ack(skb)) {
> > > +       /* always drop every other options for pure ack ADD_ADDR; thi=
s is
> > > +        * plain dup-ack from TCP perspective. The other MPTCP-releva=
nt info,
> > > +        * if any, will be carried by the other pure ack
> > > +        */
> > > +       if (skb && skb_is_tcp_pure_ack(skb)) {
> > >                 remaining +=3D opt_size;
> > >                 *drop_other_suboptions =3D true;
> > >         }
> >
> > This part in pm.c should be squashed to the patch "mptcp: move
> > drop_other_suboptions check under pm lock".
> >
> > WDYT?
>
> I was wondering if that chunk would deserve a separate patch.

Sure, a separate patch is fine.

Thanks,
-Geliang

>
> Squashing the change in another patch would still mix multiple intens
> in a single change, but the modifications are indeed related. Overall
> agreed ;)
>
> /P
>
>
>
