Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D9772
	for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 11:53:45 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id b1so1639179pls.3
        for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6qxQDZBwrkuQr3wl9I8NCYkbHVdx28ldz76bXpJuzuU=;
        b=TJ/8v08RecItXZ0amDMAEuJgbNHJkpIhJgq/7UP3hZr44dApelOjnIm4xIq/jgeOZM
         qM+BteaasvcVcPMEsxkQSBbggWs444WlhDICFeR14HaZMY0FTyU0jhvaBMUSAho/9Obe
         u+v+IPYN0ieS0bpLDQeVRalO5WHPgDWeJqoHoqYD8TV+C16cylgjRt4i8qKv0dAULfq3
         Bj7bvswfyFQZNzCDjjPd9QcqRG2hC759ys/kJJUokBQfJI43qMAf35l3q7PdtmVqC5Ay
         RY/y9QP1X0SMikUyRNbMdRKVAmMAto4YZJNHWrhygm6Tw5xz+zkRfn6jt9Ek7oTVStU1
         UOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6qxQDZBwrkuQr3wl9I8NCYkbHVdx28ldz76bXpJuzuU=;
        b=ei7lnWddVWKtgFLuIECRmY2la/Is+ok0cuPUJLSzds0tmUbNfXwWY0DbVcqRZ/YePU
         Z2AMUj1QCqo+CrmJQQ8EH1LbWvsegz4loJacLAZS5L1FxMTFDs/MkaWYA/FCC+gBMu9n
         Wt1NoKod61clqubUds2NBNNs71woZdYTtdp9QEq1z2YeHUAdEEdK6/9qareqsDuSTlsZ
         y2IJHD01ewWRe2xOY/V8LSsyOcWLIRRzYm16P+skW4dTR5dSj/K9T01ff/5k6U90Kbd0
         0eY42yDY9pPjyWjPLrCU7xCsr/F8m3QytxkH570KfNgbHS1+7LXDhcmX7y2ygwvFb8qR
         Lmag==
X-Gm-Message-State: AOAM53117/IYU7VcYLSRpA3eR6R3JW4bQ9OVl5jwmupp/eKieJJOsroi
	l8s6pkGrSIaKs25RsOa9QxS2SPpc1rOqcfFf+IQ=
X-Google-Smtp-Source: ABdhPJyVGW6Mtpm/t9Uq/PCeq6F2j8/P5ZeGSK4Njh1pgrjUiX9VLviciXQ462HUy1H3TbWu4cqdJWbu4qa+Ypq8CeI=
X-Received: by 2002:a17:90b:33c6:: with SMTP id lk6mr38307384pjb.6.1624276424648;
 Mon, 21 Jun 2021 04:53:44 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1615378283.git.geliangtang@gmail.com> <cc7e44b081dc7b02f9b7b9d14175acad361ea18e.1615378283.git.geliangtang@gmail.com>
 <dfa64550c8ae54a3d831998f048f7b6b74db8d16.1615378283.git.geliangtang@gmail.com>
 <974f96db-7160-793e-6d9a-ca919cb74a8@linux.intel.com>
In-Reply-To: <974f96db-7160-793e-6d9a-ca919cb74a8@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 21 Jun 2021 19:53:33 +0800
Message-ID: <CA+WQbwt=S6KurwVa5zjTjq5XU-KLYsHgdp1d-sxAYLWJyGPtnA@mail.gmail.com>
Subject: Re: [MPTCP] [MPTCP][RFC PATCH 2/2] mptcp: add MP_FAIL support
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Christoph Paasch <cpaasch@apple.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=B43=
=E6=9C=8820=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=889:35=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Wed, 10 Mar 2021, Geliang Tang wrote:
>
> > Add handling for sending and receiving MP_FAIL suboption.
> >
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/52
> >
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > ---
> > include/net/mptcp.h  |  1 +
> > net/mptcp/options.c  | 61 +++++++++++++++++++++++++++++++++++++++++++-
> > net/mptcp/protocol.h |  5 ++++
> > net/mptcp/subflow.c  |  4 +++
> > 4 files changed, 70 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index de88f38e60b1..6635689ce03f 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -64,6 +64,7 @@ struct mptcp_out_options {
> >       u32 nonce;
> >       u64 thmac;
> >       u32 token;
> > +     u64 fail_seq;
> >       u8 hmac[20];
> >       struct mptcp_ext ext_copy;
> > #endif
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 9df26291cf9a..1b5aaab80ba0 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -318,6 +318,17 @@ static void mptcp_parse_option(const struct sk_buf=
f *skb,
> >               flags =3D *ptr++;
> >               mp_opt->reset_transient =3D flags & MPTCP_RST_TRANSIENT;
> >               mp_opt->reset_reason =3D *ptr;
> > +             pr_debug("RST: reset_reason=3D%u", mp_opt->reset_reason);
> > +             break;
> > +
> > +     case MPTCPOPT_MP_FAIL:
> > +             if (opsize !=3D TCPOLEN_MPTCP_FAIL)
> > +                     break;
> > +
> > +             ptr +=3D 2;
> > +             mp_opt->mp_fail =3D 1;
> > +             mp_opt->fail_seq =3D get_unaligned_be64(ptr);
> > +             pr_debug("MP_FAIL: data_seq=3D%llu", mp_opt->fail_seq);
> >               break;
> >
> >       default:
> > @@ -344,6 +355,7 @@ void mptcp_get_options(const struct sk_buff *skb,
> >       mp_opt->mp_prio =3D 0;
> >       mp_opt->reset =3D 0;
> >       mp_opt->csum =3D 0;
> > +     mp_opt->mp_fail =3D 0;
> >
> >       length =3D (th->doff * 4) - sizeof(struct tcphdr);
> >       ptr =3D (const unsigned char *)(th + 1);
> > @@ -787,6 +799,28 @@ static noinline void mptcp_established_options_rst=
(struct sock *sk, struct sk_bu
> >       opts->reset_reason =3D subflow->reset_reason;
> > }
> >
> > +static bool mptcp_established_options_mp_fail(struct sock *sk,
> > +                                           unsigned int *size,
> > +                                           unsigned int remaining,
> > +                                           struct mptcp_out_options *o=
pts)
> > +{
> > +     struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> > +
> > +     if (!subflow->send_mp_fail)
> > +             return false;
> > +
> > +     if (remaining < TCPOLEN_MPTCP_FAIL)
> > +             return false;
> > +
> > +     *size =3D TCPOLEN_MPTCP_FAIL;
> > +     opts->suboptions |=3D OPTION_MPTCP_FAIL;
> > +     opts->fail_seq =3D subflow->map_seq;
> > +
> > +     pr_debug("MP_FAIL fail_seq=3D%llu", opts->fail_seq);
> > +
> > +     return true;
> > +}
> > +
> > bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> >                              unsigned int *size, unsigned int remaining=
,
> >                              struct mptcp_out_options *opts)
> > @@ -803,7 +837,13 @@ bool mptcp_established_options(struct sock *sk, st=
ruct sk_buff *skb,
> >               return false;
> >
> >       if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
> > -             mptcp_established_options_rst(sk, skb, size, remaining, o=
pts);
> > +             if (mptcp_established_options_mp_fail(sk, &opt_size, rema=
ining, opts)) {
> > +                     *size +=3D opt_size;
> > +                     remaining -=3D opt_size;
> > +             }
> > +             mptcp_established_options_rst(sk, skb, &opt_size, remaini=
ng, opts);
> > +             *size +=3D opt_size;
> > +             remaining -=3D opt_size;
> >               return true;
> >       }
> >
> > @@ -1120,6 +1160,11 @@ void mptcp_incoming_options(struct sock *sk, str=
uct sk_buff *skb)
> >               mp_opt.mp_prio =3D 0;
> >       }
> >
> > +     if (mp_opt.mp_fail) {
> > +             /* TODO */
>
> It's not clear to me what RFC 8684 requires here.
>
> If Peer A detects the bad checksum, it sends MP_FAIL with fail_seq
> matching subflow->map_seq for the mapping being received (which the code
> above does).
>
> The RFC says the recipient of the option (Peer B) must discard data after
> fail_seq - but it's the transmitter of the data? It's very confusingly
> worded. I looked at the multipath-tcp.org kernel and the MP_FAIL sequence
> number appears to be ignored by the receiver.

After comparing RFC 8684 with RFC 6824, I think I have found the answer to
this question. It should be 'peer A must discard the data, not peer B'.

When multiple subflows are in use, if peer A detects the bad checksum, it
sends MP_FAIL+RST to close this subflow, and it discards data after
fail_seq.

Then peer B receives this MP_FAIL+RST, just ignore the MP_FAIL sequence
number, and do nothing. The fail_seq is only used in the single subflow
case, to send the infinite mapping. In the multiple subflows case, just
ignore the fail_seq.

I think the MP_FAIL logic should be like this:

 * Peer B send a DSS to peer A, and the data has been modify by the
middleboxes, then peer A detects the bad checksum.

 * In the multiple subflows case, peer A sends MP_FAIL+RST back to peer B,
and peer A discards the data following the bad data sequence number. Peer
B receives this MP_FAIL+RST, and close this subflow.

 * In the single subflow case, using the simple implementation, peer A
sends MP_FAIL back to peer B, and peer A fallback to a regular TCP. Peer
B receives this MP_FAIL, and fallback to a regular TCP.

I don't know if I understood right?

-Geliang

>
> So, maybe this is the right thing to do:
>
>   * When checksums are enabled, do not send DATA_ACK for received data
> until the full mapping is received and the checksum is verified. This
> allows retransmission of any data that's part of the bad checksum.
>
>   * When a bad checksum is detected, send the MP_FAIL and watch for the
> MP_FAIL reply. I'm not sure of the conditions for resending MP_FAIL.
>
>   * When MP_FAIL is received, send MP_FAIL+RST for the mapping currently
> being received on that subflow and fallback if the in-order-single-subflo=
w
> conditions in the RFC are met.
>
> Christoph, is that on the right track? (If so, is it time for an errata
> submission? :) )
>
>
> - Mat
>
>
>
> > +             mp_opt.mp_fail =3D 0;
> > +     }
> > +
> >       if (mp_opt.reset) {
> >               subflow->reset_seen =3D 1;
> >               subflow->reset_reason =3D mp_opt.reset_reason;
> > @@ -1329,6 +1374,20 @@ void mptcp_write_options(__be32 *ptr, const stru=
ct tcp_sock *tp,
> >                                     opts->backup, TCPOPT_NOP);
> >       }
> >
> > +     if (OPTION_MPTCP_FAIL & opts->suboptions) {
> > +             const struct sock *ssk =3D (const struct sock *)tp;
> > +             struct mptcp_subflow_context *subflow;
> > +
> > +             subflow =3D mptcp_subflow_ctx(ssk);
> > +             subflow->send_mp_fail =3D 0;
> > +
> > +             *ptr++ =3D mptcp_option(MPTCPOPT_MP_FAIL,
> > +                                   TCPOLEN_MPTCP_FAIL,
> > +                                   0, 0);
> > +             put_unaligned_be64(opts->fail_seq, ptr);
> > +             ptr +=3D 2;
> > +     }
> > +
> >       if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
> >               *ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
> >                                     TCPOLEN_MPTCP_MPJ_SYN,
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 24b4e1f6d23f..ab8f92c49029 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -27,6 +27,7 @@
> > #define OPTION_MPTCP_FASTCLOSE        BIT(9)
> > #define OPTION_MPTCP_PRIO     BIT(10)
> > #define OPTION_MPTCP_RST      BIT(11)
> > +#define OPTION_MPTCP_FAIL    BIT(12)
> >
> > /* MPTCP option subtypes */
> > #define MPTCPOPT_MP_CAPABLE   0
> > @@ -68,6 +69,7 @@
> > #define TCPOLEN_MPTCP_PRIO_ALIGN      4
> > #define TCPOLEN_MPTCP_FASTCLOSE               12
> > #define TCPOLEN_MPTCP_RST             4
> > +#define TCPOLEN_MPTCP_FAIL           12
> >
> > /* MPTCP MP_JOIN flags */
> > #define MPTCPOPT_BACKUP               BIT(0)
> > @@ -135,6 +137,7 @@ struct mptcp_options_received {
> >               add_addr : 1,
> >               rm_addr : 1,
> >               mp_prio : 1,
> > +             mp_fail : 1,
> >               family : 4,
> >               echo : 1,
> >               backup : 1;
> > @@ -162,6 +165,7 @@ struct mptcp_options_received {
> >       u16     port;
> >       u8      reset_reason:4;
> >       u8      reset_transient:1;
> > +     u64     fail_seq;
> > };
> >
> > static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
> > @@ -428,6 +432,7 @@ struct mptcp_subflow_context {
> >               mpc_map : 1,
> >               backup : 1,
> >               send_mp_prio : 1,
> > +             send_mp_fail : 1,
> >               rx_eof : 1,
> >               can_ack : 1,        /* only after processing the remote a=
 key */
> >               disposable : 1;     /* ctx can be free at ulp release tim=
e */
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index b597811a2f8d..059c1a0ef25b 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -823,12 +823,16 @@ static bool validate_dss_csum(struct sock *ssk, s=
truct sk_buff *skb)
> >
> >               if (csum_fold(csum)) {
> >                       pr_err("%s DSS checksum error csum=3D%u!", __func=
__, csum_fold(csum));
> > +                     subflow->send_mp_fail =3D 1;
> > +                     subflow->reset_reason =3D MPTCP_RST_EMIDDLEBOX;
>
> This is sending a MP_FAIL not MP_TCPRST, so a reason isn't used.
>
> > +                     tcp_send_active_reset(ssk, GFP_ATOMIC);
>
> The subflow socket must be closed to. Does it work to call
> mptcp_subflow_reset() instead?
>
> I don't think there should be data cleanup to do because the data can't b=
e
> pushed up to the msk until the entire mapping is received.
>
>
> Mat
>
> >                       return true; //false;
> >               }
> >               pr_debug("%s DSS checksum done", __func__);
> >       }
> >
> > out:
> > +     subflow->send_mp_fail =3D 0;
> >       return true;
> > }
> >
> > --
> > 2.29.2
>
> --
> Mat Martineau
> Intel
