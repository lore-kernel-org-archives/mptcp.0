Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043F070
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1626277795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4NFl1MChfL6tyawRH2zKgCqPkGuOecKyjgFwjfvwVsU=;
	b=ZTBAnUm5gqc4TfqZwqW5miE3a25hDeoAKVczJ3reVbfCPghHA+y4Aat/YNeQShmTzqllYq
	I68fD8NsQAxag0xyk3BWIIGHtvFHSIHpTAvYZap3jKH6Ql9IDl5+YS82feiMuHt1Dv700z
	UK/t4yem9r9MRQ/R2nkxhY/AdtKzhNQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-SgQCohsUOtatIeR4FslALw-1; Wed, 14 Jul 2021 11:49:52 -0400
X-MC-Unique: SgQCohsUOtatIeR4FslALw-1
Received: by mail-wr1-f69.google.com with SMTP id 5-20020a0560001565b029013fe432d176so1695623wrz.23
        for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 08:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4NFl1MChfL6tyawRH2zKgCqPkGuOecKyjgFwjfvwVsU=;
        b=XdBieMLCcKBwjRO+Np/0FUde3I0RDP9x4hzxtvSNZBHoB0EkGH1CsYXpGlpBYwzx3y
         Cyce9mJR3bDLvT50ZTHdPxoK/mw8t9YU+VU/3sPrAyy+Dw1dbMLoaBEXtxk2DPoXGK8V
         bW61fQ957LFHGF8PtLxDk0LcGTqxszm5iEhjGgrMRGwvkoXznOGupryvimBgLK+rfvNL
         R30ZQLNmUFGNo+iNH416Qy3IddecD9bA+2AgL1/CPx7kKvs8OD42rA5/g5IR82zXU4e1
         lliAoRYp3dmm1GPx+aNJZqJNpze5c/P0gsuhl8PY2oRuuVZ8AiFC88OvCSmdPnZlBK2t
         P3ew==
X-Gm-Message-State: AOAM533HgP+/9caCWWpFj1rIKSBgxwqOpsyOcyIZVxyqc8QR6tq2ySMa
	Zx++6/mZSjwQZGfJHEHs5tTnho0y//5xL3CohmbRym/aWUdu03C2sZF34RLGCpgr7iA4cMdeJRo
	c1PraB8oVPL8woas=
X-Received: by 2002:a5d:4573:: with SMTP id a19mr14023934wrc.346.1626277791529;
        Wed, 14 Jul 2021 08:49:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7u/ugqVp0LqhPsRIDA0ONLoRgJkyTfLDxJLuY5DZykoSfk6WBcfsqvH6p2XMpY2OewfyEzw==
X-Received: by 2002:a5d:4573:: with SMTP id a19mr14023914wrc.346.1626277791287;
        Wed, 14 Jul 2021 08:49:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-126-220.dyn.eolo.it. [146.241.126.220])
        by smtp.gmail.com with ESMTPSA id f26sm2443991wmc.29.2021.07.14.08.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:49:50 -0700 (PDT)
Message-ID: <8166dbe9c65a722a342e455ef9a0088da16f4da7.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v3 mptcp-next 1/8] mptcp: MP_FAIL suboption
 sending
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
Date: Wed, 14 Jul 2021 17:49:49 +0200
In-Reply-To: <CA+WQbwt_76G1hVXmPUwbZXfraa=2KqBQAv1sYF17Bf=+V_mYSQ@mail.gmail.com>
References: <cover.1624854005.git.geliangtang@gmail.com>
	 <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com>
	 <be269ef04813ede9084094b62f24d1fdcd7b91d0.camel@redhat.com>
	 <CA+WQbwt_76G1hVXmPUwbZXfraa=2KqBQAv1sYF17Bf=+V_mYSQ@mail.gmail.com>
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

On Wed, 2021-07-14 at 17:16 +0800, Geliang Tang wrote:
> Paolo Abeni <pabeni@redhat.com> 于2021年7月14日周三 下午4:45写道：
> > On Mon, 2021-06-28 at 12:28 +0800, Geliang Tang wrote:
> > > This patch added the MP_FAIL suboption sending support.
> > > 
> > > Add a new flag named send_mp_fail in struct mptcp_subflow_context. If
> > > this flag is set, send out MP_FAIL suboption.
> > > 
> > > Add a new member fail_seq in struct mptcp_out_options to save the data
> > > sequence number to put into the MP_FAIL suboption.
> > > 
> > > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > > ---
> > >  include/net/mptcp.h  |  1 +
> > >  net/mptcp/options.c  | 54 ++++++++++++++++++++++++++++++++++++++++++--
> > >  net/mptcp/protocol.h |  4 ++++
> > >  3 files changed, 57 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > > index cb580b06152f..f48d3b5a3fd4 100644
> > > --- a/include/net/mptcp.h
> > > +++ b/include/net/mptcp.h
> > > @@ -72,6 +72,7 @@ struct mptcp_out_options {
> > >       u32 nonce;
> > >       u64 thmac;
> > >       u32 token;
> > > +     u64 fail_seq;
> > 
> > Since we can't have both a valid mapping and MP_FAIL in the same
> > packet, it would be better to avoid increasing the 'mptcp_out_options'
> > size, e.g. re-using some ext_copy field, or unioning with some other
> > field.
> 
> The RFC says an MP_FAIL option could be included in a RST or on the
> subflow-level ACK. So I think we can't re-using the ext_copy field if it's
> on the subflow-level ACK.
> 
> How about unioning this fail_seq field with ahmac field?
> 
> > mptcp_out_options has grown quite a bit and we should really look into
> > shrinking it.
> > 
> > >       u8 hmac[20];
> > >       struct mptcp_ext ext_copy;
> > >  #endif
> > > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > > index b5850afea343..b78defe1aed9 100644
> > > --- a/net/mptcp/options.c
> > > +++ b/net/mptcp/options.c
> > > @@ -771,6 +771,28 @@ static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_bu
> > >       opts->reset_reason = subflow->reset_reason;
> > >  }
> > > 
> > > +static bool mptcp_established_options_mp_fail(struct sock *sk,
> > > +                                           unsigned int *size,
> > > +                                           unsigned int remaining,
> > > +                                           struct mptcp_out_options *opts)
> > > +{
> > > +     struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> > > +
> > > +     if (!subflow->send_mp_fail)
> > > +             return false;
> > > +
> > > +     if (remaining < TCPOLEN_MPTCP_FAIL)
> > > +             return false;
> > > +
> > > +     *size = TCPOLEN_MPTCP_FAIL;
> > > +     opts->suboptions |= OPTION_MPTCP_FAIL;
> > > +     opts->fail_seq = subflow->fail_seq;
> > > +
> > > +     pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
> > > +
> > > +     return true;
> > > +}
> > > +
> > >  bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> > >                              unsigned int *size, unsigned int remaining,
> > >                              struct mptcp_out_options *opts)
> > > @@ -787,15 +809,29 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> > >               return false;
> > > 
> > >       if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
> > > -             mptcp_established_options_rst(sk, skb, size, remaining, opts);
> > > +             if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> > > +                     *size += opt_size;
> > > +                     remaining -= opt_size;
> > > +             }
> > > +             mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts);
> > > +             *size += opt_size;
> > > +             remaining -= opt_size;
> > >               return true;
> > >       }
> > > 
> > >       snd_data_fin = mptcp_data_fin_enabled(msk);
> > >       if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, remaining, opts))
> > >               ret = true;
> > > -     else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts))
> > > +     else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts)) {
> > >               ret = true;
> > > +             if (opts->ext_copy.use_ack) {
> > 
> > Is the extra check on 'opts->ext_copy.use_ack' necessary? can we just
> > look for mp_fail?
> > 
> 
> I added this check since the RFC says an MP_FAIL option could be included
> on the subflow-level ACK:
> 
> '''
> In this case, if a receiver identifies a checksum failure when there is
> only one path, it will send back an MP_FAIL option on the subflow-level
> ACK, referring to the data-level sequence number of the start of the
> segment on which the checksum error was detected.
> '''
> 
> Do I understand right?

Not a big deal, but I read the above as follow:

the MP_FAIL is included into the next subflow packet/

subflow-level ACK really means TCP-level ACK, I think. Since the
subflow is established (at TCP level) each TCP packet will carry an
ack.

All in all the ' if (opts->ext_copy.use_ack) {' check looks unneeded to
me.

Cheers,

Paolo

