Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55C72
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 09:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627292674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BdTfPJSdSssEr80ca1BC+hhXLafUC2SoXOJIEt96EZ8=;
	b=PInlZXVofINrGtxB4PpLRSuhP5D5qHhz9N3vN9tk5Ql6Gi4SQDo97EyQHVy6+7FvMTYnUQ
	U10XoA7SDOYmc4YUYTP4muhjE6zwzrlNKkz/8IuxclCLsgrR/X4ltQEfYQEgJD+xzmH7hl
	4Ro22/K6fD1Mm6TIwpf+t+QZOXF2rGI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-E_5j7byAOYu2A_wQzMgprg-1; Mon, 26 Jul 2021 05:44:32 -0400
X-MC-Unique: E_5j7byAOYu2A_wQzMgprg-1
Received: by mail-wr1-f71.google.com with SMTP id r17-20020adfda510000b02901526f76d738so4549436wrl.0
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 02:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BdTfPJSdSssEr80ca1BC+hhXLafUC2SoXOJIEt96EZ8=;
        b=kKLfr3Y4i1TR1K4xAAubm9gEpjz6N8Hm9O+gly/hkGoWUyjL/pZVom3/tQNk5y7fAg
         AnjTj0hy5+E0ARsEbXwiehEKI27Qf1LTF6YZ88PSwG/TVu1lSeSAqWhoAqvNlalMu7EK
         /i4BHelJm9YJsdrE84dQezl38mkHg85nRcL7hFmS7GMplFdZ503aMW48H1j+5z3YsWpg
         1KirfmfryuDGKH9mXevO8cpUlnu9xFLsGNP5k6gBVBTO6coKpH1+mB5EzYfjwW6G6Zzz
         0pfjUV5/X443NuEPMurYBTaJpE/xp7II9wARWDgzei9V+RqR/MKH0OLKy9Z8dcAvpoEi
         +akg==
X-Gm-Message-State: AOAM532SLFUHeUZU41euiRtMbmTPP8DJg5Lc8TcExYd+BRpfSiZe3U4O
	iksuR+ncxnNst1y+wEk82lhQQR//j+gg25023zloZYuFWsY/uBlAfdxpUYtN6bxlBSgNoGrKi44
	SQVA1rBjC0am6fyk=
X-Received: by 2002:adf:f68c:: with SMTP id v12mr18399802wrp.360.1627292671117;
        Mon, 26 Jul 2021 02:44:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwijVY4ysDl5UZeTWGHDs5WTlBpJW58AJowdn2QiK6zZI5cDOm6tYKPPFJPf46dvOUK1/lZ9w==
X-Received: by 2002:adf:f68c:: with SMTP id v12mr18399785wrp.360.1627292670881;
        Mon, 26 Jul 2021 02:44:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id v2sm42603517wro.48.2021.07.26.02.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 02:44:30 -0700 (PDT)
Message-ID: <a816ed1d1be07abcd7fa55efe167141cd425426c.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: optimize out option generation
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 26 Jul 2021 11:44:29 +0200
In-Reply-To: <CA+WQbwsKBpXVVqDX32EDROX8kjo1efcgoPd10kDOt9hCHHNvdA@mail.gmail.com>
References: <cover.1627059686.git.pabeni@redhat.com>
	 <b886e46981b5f02c726f92655fabd054f4dc9217.1627059686.git.pabeni@redhat.com>
	 <CA+WQbwsKBpXVVqDX32EDROX8kjo1efcgoPd10kDOt9hCHHNvdA@mail.gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2021-07-26 at 11:21 +0800, Geliang Tang wrote:
> Hi Paolo,
> 
> Thanks for this patchset, and I have some small comments.
> 
> Paolo Abeni <pabeni@redhat.com> 于2021年7月24日周六 上午1:06写道：
> > Currently we have several protocol contraint on MPTCP option
> > generation (e.g. MPC and MPJ subopt are mutually exclusive)
> > and some additionall ones required by our implementation
> > (e.g. almost all ADD_ADDR variant are mutually exclusive with
> > everything else).
> > 
> > We can leverage the above to optimize the out option generation:
> > we check DSS/MPC/MPJ presencence in a mutually exclusive way,
> > avoiding many unneeded conditionals in the common case.
> > 
> > Additionally extend the existing constraint on ADD_ADDR opt on
> > all subvariant, so that it become fully mutually exclusive with
> > the above and we can skip another conditional statement the common
> > case.
> > 
> > This change is also need by the next patch.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > --
> > side node: we could probably optimize the conditionals in
> > mptcp_established_options()
> > ---
> >  net/mptcp/options.c  | 225 ++++++++++++++++++++++---------------------
> >  net/mptcp/pm.c       |   9 +-
> >  net/mptcp/protocol.h |   1 +
> >  3 files changed, 122 insertions(+), 113 deletions(-)
> > 
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index eafdb9408f3a..38f324667761 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -592,6 +592,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
> >                 dss_size = map_size;
> >                 if (skb && snd_data_fin_enable)
> >                         mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
> > +               opts->suboptions = OPTION_MPTCP_DSS;
> >                 ret = true;
> >         }
> > 
> > @@ -615,6 +616,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
> >                 opts->ext_copy.ack64 = 0;
> >         }
> >         opts->ext_copy.use_ack = 1;
> > +       opts->suboptions = OPTION_MPTCP_DSS;
> >         WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
> > 
> >         /* Add kind/length/subtype/flag overhead if mapping is not populated */
> > @@ -663,9 +665,9 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
> 
> I think no need to modify the code in mptcp_established_options_add_addr.
> 
> >         struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> >         bool drop_other_suboptions = false;
> >         unsigned int opt_size = *size;
> > +       unsigned int len;
> >         bool echo;
> >         bool port;
> > -       int len;
> 
> I prefer to keep the type of len unchanged.

OK.

> 
> >         if (!mptcp_pm_should_add_signal(msk) ||
> >             !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts,
> > @@ -687,11 +689,12 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
> >                 *size -= opt_size;
> >         }
> >         opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
> > -       if (!echo) {
> > +       if (!echo)
> >                 opts->ahmac = add_addr_generate_hmac(msk->local_key,
> >                                                      msk->remote_key,
> >                                                      &opts->addr);
> > -       }
> > +       else
> > +               opts->ahmac = 0;
> 
> opts->ahmac had been set to zero in mptcp_get_options, no need to clear it
> again.

This is for the output path, mptcp_get_options() is not invoked. 'ops'
has been cleared by the TCP caller. Sice a few fields are aliased, and
the add_addr is added after the DSS, the latter could have already
modified the underlaying memory.

Without this assignment we will end-up appending the hmac even for
add_addr 'echo', and a bunch of tests will fail.

Perhaps is better adding some comments explaining why such set
operation is needed...
> 
> >         pr_debug("addr_id=%d, addr_port=%d, ahmac=%llu, echo=%d",
> >                  opts->addr.id, ntohs(opts->addr.port), opts->ahmac, echo);
> > 
> > @@ -735,7 +738,12 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
> >  {
> >         struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> > 
> > -       if (!subflow->send_mp_prio)
> > +       /* can't send MP_PRIO with MPC, as they share the same option space:
> > +        * 'backup'. Also it makes no sense at all
> > +        */
> > +       if (!subflow->send_mp_prio ||
> > +            ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
> > +              OPTION_MPTCP_MPC_ACK) & opts->suboptions))
> >                 return false;
> > 
> >         /* account for the trailing 'nop' option */
> > @@ -1198,7 +1206,73 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
> >  void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> >                          struct mptcp_out_options *opts)
> >  {
> > -       if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
> > +       /* RST is mutually exclusive with everything else */
> > +       if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
> > +               *ptr++ = mptcp_option(MPTCPOPT_RST,
> > +                                     TCPOLEN_MPTCP_RST,
> > +                                     opts->reset_transient,
> > +                                     opts->reset_reason);
> > +               return;
> > +       }
> > +
> > +       /* DSS, MPC, MPJ and ADD_ADDR are mutually exclusive, see
> > +        * mptcp_established_options*()
> > +        */
> > +       if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
> > +               struct mptcp_ext *mpext = &opts->ext_copy;
> > +               u8 len = TCPOLEN_MPTCP_DSS_BASE;
> > +               u8 flags = 0;
> > +
> > +               if (mpext->use_ack) {
> > +                       flags = MPTCP_DSS_HAS_ACK;
> > +                       if (mpext->ack64) {
> > +                               len += TCPOLEN_MPTCP_DSS_ACK64;
> > +                               flags |= MPTCP_DSS_ACK64;
> > +                       } else {
> > +                               len += TCPOLEN_MPTCP_DSS_ACK32;
> > +                       }
> > +               }
> > +
> > +               if (mpext->use_map) {
> > +                       len += TCPOLEN_MPTCP_DSS_MAP64;
> > +
> > +                       /* Use only 64-bit mapping flags for now, add
> > +                        * support for optional 32-bit mappings later.
> > +                        */
> > +                       flags |= MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
> > +                       if (mpext->data_fin)
> > +                               flags |= MPTCP_DSS_DATA_FIN;
> > +
> > +                       if (opts->csum_reqd)
> > +                               len += TCPOLEN_MPTCP_DSS_CHECKSUM;
> > +               }
> > +
> > +               *ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
> > +
> > +               if (mpext->use_ack) {
> > +                       if (mpext->ack64) {
> > +                               put_unaligned_be64(mpext->data_ack, ptr);
> > +                               ptr += 2;
> > +                       } else {
> > +                               put_unaligned_be32(mpext->data_ack32, ptr);
> > +                               ptr += 1;
> > +                       }
> > +               }
> > +
> > +               if (mpext->use_map) {
> > +                       put_unaligned_be64(mpext->data_seq, ptr);
> > +                       ptr += 2;
> > +                       put_unaligned_be32(mpext->subflow_seq, ptr);
> > +                       ptr += 1;
> > +                       if (opts->csum_reqd) {
> > +                               put_unaligned_be32(mpext->data_len << 16 |
> > +                                                  mptcp_make_csum(mpext), ptr);
> > +                       } else {
> > +                               put_unaligned_be32(mpext->data_len << 16 |
> > +                                                  TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> > +                       }
> > +               }
> > +       } else if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
> >              OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
> >                 u8 len, flag = MPTCP_CAP_HMAC_SHA256;
> > 
> > @@ -1246,10 +1320,31 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> >                                            TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> >                 }
> >                 ptr += 1;
> > -       }
> > 
> > -mp_capable_done:
> > -       if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> > +               /* MPC is additionally mutually exclusive with MP_PRIO */
> > +               goto mp_capable_done;
> > +       } else if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
> > +               *ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
> > +                                     TCPOLEN_MPTCP_MPJ_SYN,
> > +                                     opts->backup, opts->join_id);
> > +               put_unaligned_be32(opts->token, ptr);
> > +               ptr += 1;
> > +               put_unaligned_be32(opts->nonce, ptr);
> > +               ptr += 1;
> > +       } else if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
> > +               *ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
> > +                                     TCPOLEN_MPTCP_MPJ_SYNACK,
> > +                                     opts->backup, opts->join_id);
> > +               put_unaligned_be64(opts->thmac, ptr);
> > +               ptr += 2;
> > +               put_unaligned_be32(opts->nonce, ptr);
> > +               ptr += 1;
> > +       } else if (OPTION_MPTCP_MPJ_ACK & opts->suboptions) {
> > +               *ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
> > +                                     TCPOLEN_MPTCP_MPJ_ACK, 0, 0);
> > +               memcpy(ptr, opts->hmac, MPTCPOPT_HMAC_LEN);
> > +               ptr += 5;
> > +       } else if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> >                 struct mptcp_addr_info *addr = &opts->addr;
> >                 u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
> >                 u8 echo = MPTCP_ADDR_ECHO;
> > @@ -1308,6 +1403,19 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> >                 }
> >         }
> > 
> > +       if (OPTION_MPTCP_PRIO & opts->suboptions) {
> > +               const struct sock *ssk = (const struct sock *)tp;
> > +               struct mptcp_subflow_context *subflow;
> > +
> > +               subflow = mptcp_subflow_ctx(ssk);
> > +               subflow->send_mp_prio = 0;
> > +
> > +               *ptr++ = mptcp_option(MPTCPOPT_MP_PRIO,
> > +                                     TCPOLEN_MPTCP_PRIO,
> > +                                     opts->backup, TCPOPT_NOP);
> > +       }
> > +
> > +mp_capable_done:
> >         if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
> >                 u8 i = 1;
> > 
> > @@ -1328,107 +1436,6 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> >                 }
> >         }
> > 
> > -       if (OPTION_MPTCP_PRIO & opts->suboptions) {
> > -               const struct sock *ssk = (const struct sock *)tp;
> > -               struct mptcp_subflow_context *subflow;
> > -
> > -               subflow = mptcp_subflow_ctx(ssk);
> > -               subflow->send_mp_prio = 0;
> > -
> > -               *ptr++ = mptcp_option(MPTCPOPT_MP_PRIO,
> > -                                     TCPOLEN_MPTCP_PRIO,
> > -                                     opts->backup, TCPOPT_NOP);
> > -       }
> > -
> > -       if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
> > -               *ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
> > -                                     TCPOLEN_MPTCP_MPJ_SYN,
> > -                                     opts->backup, opts->join_id);
> > -               put_unaligned_be32(opts->token, ptr);
> > -               ptr += 1;
> > -               put_unaligned_be32(opts->nonce, ptr);
> > -               ptr += 1;
> > -       }
> > -
> > -       if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
> > -               *ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
> > -                                     TCPOLEN_MPTCP_MPJ_SYNACK,
> > -                                     opts->backup, opts->join_id);
> > -               put_unaligned_be64(opts->thmac, ptr);
> > -               ptr += 2;
> > -               put_unaligned_be32(opts->nonce, ptr);
> > -               ptr += 1;
> > -       }
> > -
> > -       if (OPTION_MPTCP_MPJ_ACK & opts->suboptions) {
> > -               *ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
> > -                                     TCPOLEN_MPTCP_MPJ_ACK, 0, 0);
> > -               memcpy(ptr, opts->hmac, MPTCPOPT_HMAC_LEN);
> > -               ptr += 5;
> > -       }
> > -
> > -       if (OPTION_MPTCP_RST & opts->suboptions)
> > -               *ptr++ = mptcp_option(MPTCPOPT_RST,
> > -                                     TCPOLEN_MPTCP_RST,
> > -                                     opts->reset_transient,
> > -                                     opts->reset_reason);
> > -
> > -       if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
> > -               struct mptcp_ext *mpext = &opts->ext_copy;
> > -               u8 len = TCPOLEN_MPTCP_DSS_BASE;
> > -               u8 flags = 0;
> > -
> > -               if (mpext->use_ack) {
> > -                       flags = MPTCP_DSS_HAS_ACK;
> > -                       if (mpext->ack64) {
> > -                               len += TCPOLEN_MPTCP_DSS_ACK64;
> > -                               flags |= MPTCP_DSS_ACK64;
> > -                       } else {
> > -                               len += TCPOLEN_MPTCP_DSS_ACK32;
> > -                       }
> > -               }
> > -
> > -               if (mpext->use_map) {
> > -                       len += TCPOLEN_MPTCP_DSS_MAP64;
> > -
> > -                       /* Use only 64-bit mapping flags for now, add
> > -                        * support for optional 32-bit mappings later.
> > -                        */
> > -                       flags |= MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
> > -                       if (mpext->data_fin)
> > -                               flags |= MPTCP_DSS_DATA_FIN;
> > -
> > -                       if (opts->csum_reqd)
> > -                               len += TCPOLEN_MPTCP_DSS_CHECKSUM;
> > -               }
> > -
> > -               *ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
> > -
> > -               if (mpext->use_ack) {
> > -                       if (mpext->ack64) {
> > -                               put_unaligned_be64(mpext->data_ack, ptr);
> > -                               ptr += 2;
> > -                       } else {
> > -                               put_unaligned_be32(mpext->data_ack32, ptr);
> > -                               ptr += 1;
> > -                       }
> > -               }
> > -
> > -               if (mpext->use_map) {
> > -                       put_unaligned_be64(mpext->data_seq, ptr);
> > -                       ptr += 2;
> > -                       put_unaligned_be32(mpext->subflow_seq, ptr);
> > -                       ptr += 1;
> > -                       if (opts->csum_reqd) {
> > -                               put_unaligned_be32(mpext->data_len << 16 |
> > -                                                  mptcp_make_csum(mpext), ptr);
> > -                       } else {
> > -                               put_unaligned_be32(mpext->data_len << 16 |
> > -                                                  TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> > -                       }
> > -               }
> > -       }
> > -
> >         if (tp)
> >                 mptcp_set_rwin(tp);
> >  }
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 4d1828fd2482..baf2d6e524bd 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -266,10 +266,11 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
> >         if (!mptcp_pm_should_add_signal(msk))
> >                 goto out_unlock;
> > 
> > -       if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
> > -            ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
> > -             (msk->pm.local.family == AF_INET6 || msk->pm.local.port))) &&
> > -           skb && skb_is_tcp_pure_ack(skb)) {
> > +       /* always drop every other options for pure ack ADD_ADDR; this is
> > +        * plain dup-ack from TCP perspective. The other MPTCP-relevant info,
> > +        * if any, will be carried by the other pure ack
> > +        */
> > +       if (skb && skb_is_tcp_pure_ack(skb)) {
> >                 remaining += opt_size;
> >                 *drop_other_suboptions = true;
> >         }
> 
> This part in pm.c should be squashed to the patch "mptcp: move
> drop_other_suboptions check under pm lock".
> 
> WDYT?

I was wondering if that chunk would deserve a separate patch. 

Squashing the change in another patch would still mix multiple intens
in a single change, but the modifications are indeed related. Overall
agreed ;)

/P



