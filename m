Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882670
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 09:16:51 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id x16so1197088plg.3
        for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 02:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9lfB8Xo7jh8da5jb7+UVB+AVLGzlkw2Gyi8LmtSS+4k=;
        b=R1leJDfskuxjcCWACGMNz21AVYL7PdI8PTHAEve7IjxWGMfd4aH1PhTV5r07WZe4vd
         2HpefMR6lgaNJHneEYXiqJRRtlL7MEBS48pjgpSkuJyw9kYq+xxq0BB3TQSwWOm3htO+
         qPvlVOJnseD3tPVsnI+16NwXAScxTTJcrjefeM3sm+g9e/eOqqXGlX8YNi06R9RsGxyW
         wqep9iNx5mjdIFgBwgh4XlXusZ3lwK3hXPrut6NuIB+uzT0zRpbPqaPlU8GfJv9tLBBh
         JlJ/47vZM5s3vuLV5WAAULKqqS2nKujqQ9CqcEO63avjFHoEW74V/FebIJl9Vqp6ucH/
         uB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9lfB8Xo7jh8da5jb7+UVB+AVLGzlkw2Gyi8LmtSS+4k=;
        b=WiZRV+Jn89ASL1DaRtJdA8OUu0+cJagrVRaM6JzTbByyAhfkdQV9y9/Ec16EG64Thq
         IEheRc1Do2PUFYqcrubazk6ZNA/SB9KPA5l2dqNvw2c5tA5Z5YIoFHizjkNEHqENIOwl
         wnZ9Tj7RQthOUi1k6d5IM4b6WLJcO8ItNYcSi04onJaXq9oScYSVxCEZ/dh6dnWJMsy6
         gB+SiyroMIwdnG5KW4TBawVW6tss0pEM8I/CKG/xr4n9w3Ek6foqdRZnKwVOnRSr5BEb
         US39Kw3E6SS3eT4v9fnkzPoARmQskBHkGX6eARi9Ogn0YREkvRRJ2MzZ/dBXRzNcXStI
         ddEA==
X-Gm-Message-State: AOAM531H0GP9C2apLkELeasG0c1AeCk3eA2nd2sRLnNQ6zLk9ccqRMG3
	Ax1E61d+lt1zw+3Bw27sNDzFChNxcBmWDp96jj8=
X-Google-Smtp-Source: ABdhPJyY633B7A3N55V3zGxTSXvz0S6/DmYoBZFTbVRqzHdHQ93IydyeF2jYimaAqxEpvh2FMysQXyMX7WxOZ9jKwYI=
X-Received: by 2002:a17:90b:957:: with SMTP id dw23mr2942798pjb.123.1626254210603;
 Wed, 14 Jul 2021 02:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1624854005.git.geliangtang@gmail.com> <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com>
 <be269ef04813ede9084094b62f24d1fdcd7b91d0.camel@redhat.com>
In-Reply-To: <be269ef04813ede9084094b62f24d1fdcd7b91d0.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 14 Jul 2021 17:16:39 +0800
Message-ID: <CA+WQbwt_76G1hVXmPUwbZXfraa=2KqBQAv1sYF17Bf=+V_mYSQ@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v3 mptcp-next 1/8] mptcp: MP_FAIL suboption sending
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thanks for your review!

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:45=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 2021-06-28 at 12:28 +0800, Geliang Tang wrote:
> > This patch added the MP_FAIL suboption sending support.
> >
> > Add a new flag named send_mp_fail in struct mptcp_subflow_context. If
> > this flag is set, send out MP_FAIL suboption.
> >
> > Add a new member fail_seq in struct mptcp_out_options to save the data
> > sequence number to put into the MP_FAIL suboption.
> >
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > ---
> >  include/net/mptcp.h  |  1 +
> >  net/mptcp/options.c  | 54 ++++++++++++++++++++++++++++++++++++++++++--
> >  net/mptcp/protocol.h |  4 ++++
> >  3 files changed, 57 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index cb580b06152f..f48d3b5a3fd4 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -72,6 +72,7 @@ struct mptcp_out_options {
> >       u32 nonce;
> >       u64 thmac;
> >       u32 token;
> > +     u64 fail_seq;
>
> Since we can't have both a valid mapping and MP_FAIL in the same
> packet, it would be better to avoid increasing the 'mptcp_out_options'
> size, e.g. re-using some ext_copy field, or unioning with some other
> field.

The RFC says an MP_FAIL option could be included in a RST or on the
subflow-level ACK. So I think we can't re-using the ext_copy field if it's
on the subflow-level ACK.

How about unioning this fail_seq field with ahmac field?

>
> mptcp_out_options has grown quite a bit and we should really look into
> shrinking it.
>
> >       u8 hmac[20];
> >       struct mptcp_ext ext_copy;
> >  #endif
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index b5850afea343..b78defe1aed9 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -771,6 +771,28 @@ static noinline void mptcp_established_options_rst=
(struct sock *sk, struct sk_bu
> >       opts->reset_reason =3D subflow->reset_reason;
> >  }
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
> > +     opts->fail_seq =3D subflow->fail_seq;
> > +
> > +     pr_debug("MP_FAIL fail_seq=3D%llu", opts->fail_seq);
> > +
> > +     return true;
> > +}
> > +
> >  bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> >                              unsigned int *size, unsigned int remaining=
,
> >                              struct mptcp_out_options *opts)
> > @@ -787,15 +809,29 @@ bool mptcp_established_options(struct sock *sk, s=
truct sk_buff *skb,
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
> >       snd_data_fin =3D mptcp_data_fin_enabled(msk);
> >       if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size=
, remaining, opts))
> >               ret =3D true;
> > -     else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &op=
t_size, remaining, opts))
> > +     else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &op=
t_size, remaining, opts)) {
> >               ret =3D true;
> > +             if (opts->ext_copy.use_ack) {
>
> Is the extra check on 'opts->ext_copy.use_ack' necessary? can we just
> look for mp_fail?
>

I added this check since the RFC says an MP_FAIL option could be included
on the subflow-level ACK:

'''
In this case, if a receiver identifies a checksum failure when there is
only one path, it will send back an MP_FAIL option on the subflow-level
ACK, referring to the data-level sequence number of the start of the
segment on which the checksum error was detected.
'''

Do I understand right?

Thanks,
-Geliang


>
> > +                     if (mptcp_established_options_mp_fail(sk, &opt_si=
ze, remaining, opts)) {
> > +                             *size +=3D opt_size;
> > +                             remaining -=3D opt_size;
> > +                             ret =3D true;
> > +                     }
> > +             }
> > +     }
> >
> >       /* we reserved enough space for the above options, and exceeding =
the
> >        * TCP option space would be fatal
> > @@ -1334,6 +1370,20 @@ void mptcp_write_options(__be32 *ptr, const stru=
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
> > index 426ed80fe72f..007af5e4ba3d 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -26,6 +26,7 @@
> >  #define OPTION_MPTCP_FASTCLOSE       BIT(8)
> >  #define OPTION_MPTCP_PRIO    BIT(9)
> >  #define OPTION_MPTCP_RST     BIT(10)
> > +#define OPTION_MPTCP_FAIL    BIT(11)
> >
> >  /* MPTCP option subtypes */
> >  #define MPTCPOPT_MP_CAPABLE  0
> > @@ -67,6 +68,7 @@
> >  #define TCPOLEN_MPTCP_PRIO_ALIGN     4
> >  #define TCPOLEN_MPTCP_FASTCLOSE              12
> >  #define TCPOLEN_MPTCP_RST            4
> > +#define TCPOLEN_MPTCP_FAIL           12
> >
> >  #define TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM      (TCPOLEN_MPTCP_DSS_CHECKS=
UM + TCPOLEN_MPTCP_MPC_ACK_DATA)
> >
> > @@ -417,6 +419,7 @@ struct mptcp_subflow_context {
> >               mpc_map : 1,
> >               backup : 1,
> >               send_mp_prio : 1,
> > +             send_mp_fail : 1,
> >               rx_eof : 1,
> >               can_ack : 1,        /* only after processing the remote a=
 key */
> >               disposable : 1;     /* ctx can be free at ulp release tim=
e */
> > @@ -431,6 +434,7 @@ struct mptcp_subflow_context {
> >       u8      reset_seen:1;
> >       u8      reset_transient:1;
> >       u8      reset_reason:4;
> > +     u64     fail_seq;
> >
> >       long    delegated_status;
> >       struct  list_head delegated_node;   /* link into delegated_action=
, protected by local BH */
>
