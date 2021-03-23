Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355115F
	for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 12:55:31 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id z1so23358461edb.8
        for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 05:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=awyUtqJwfxvZiJ9T9rlruzlGzjCDhUYBItsdCKimTUk=;
        b=KSFKci1E9bGufZf+IGlg/mWz2Mvzt7SuWkL+DUEpQ1EpHAFerlSUugdzupZ5V/tTYV
         yyX4a5xkkGaYjQOvBI+x2kdXY6MJEqcGbsPBl9Reah6moFx5nZPwAQffbLMlAPrDqaYo
         6RwFs6FHRwa7aoxWun3Y0WMqW3GziUfngovyDMBswMyfg5dHpwUHs0sWz01af6Tgro5i
         n0QhTehFJKyOjXkDiTtqBsWecifN3vTq6BSuuRMMKEzxFEtzz6Y2JgvLdvLItxAqypMw
         VJw48S4s6ZAW5tjSKVdqdfR8WnxxlZrY04Yt2I45ai9P0WbHpL7rcA7uh7+d6yi7zz97
         kzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=awyUtqJwfxvZiJ9T9rlruzlGzjCDhUYBItsdCKimTUk=;
        b=IG4n92tMXTqMwUddYqMMMUF5orvrRJ0z+dZnE0tZkYTv89+caGV5X4744BeUOuVe1Q
         GumVcEFisdt95GixM1QktIZnelKmFrp71lHa3+K7tRFpbtq+HgbCQTU21wy8BT8OZLY9
         zaGCCkAtBjlXhVmA/nliiXfACaafXP/u7C6CrBC6lj8XtIKiuh5K8G4PXg10y2lMTGfE
         IdB6UTcRV/Ey4OIix67yaQ7hmAlLgWkt6+gWJbPWqGhkGP0+OO708TxUNKAdggV4zkI7
         4dgh7ZfHDbVkx6GJd1BT5p0O4a012ALX0agVOYrhclnTjqGiDBUCN1DmHvEh3EryCyMD
         ycwg==
X-Gm-Message-State: AOAM533OAKWAQBGtxah3d9ekJcHNCogsPdnRIXUlN/JjRZf5zKsThfCl
	xfA1ZoI4MRSmP3Ez09nmXkxEeS2MH9MrYqteiAw=
X-Google-Smtp-Source: ABdhPJy0mvps5Xf3wYyhoE4fq1+lsdA+zRGjK5DlDqCifCeSDf2SxJqe/SDSNBdPXA3B9zGkVHoshlkXvYzvTx0e+Ew=
X-Received: by 2002:a05:6402:181a:: with SMTP id g26mr4417704edy.225.1616504129659;
 Tue, 23 Mar 2021 05:55:29 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1616412490.git.geliangtang@gmail.com> <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com>
 <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com>
 <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com>
 <643a31ae30f00dd0d1d49834f6e996b3fe637c47.1616412490.git.geliangtang@gmail.com>
 <7762b80e2310ae0f1a09ec5a4324293d8e9943eb.1616412490.git.geliangtang@gmail.com>
 <5cff4d79-a754-c99d-976f-ea2a89541781@linux.intel.com>
In-Reply-To: <5cff4d79-a754-c99d-976f-ea2a89541781@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 23 Mar 2021 20:55:16 +0800
Message-ID: <CA+WQbwucpkpczKvvLhrjt_2NivwTbitD-Y1DREjrSEUdCtsZgw@mail.gmail.com>
Subject: Re: [MPTCP][PATCH mptcp-next 5/6] mptcp: add the DSS checksum receiving
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp <mptcp@lists.01.org>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=B43=
=E6=9C=8823=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=887:40=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Mon, 22 Mar 2021, Geliang Tang wrote:
>
> > This patch added a new member csum in struct mptcp_options_received. In
> > mptcp_parse_option, parse the checksum value from the receiving DSS, an=
d
> > save it in mp_opt->csum. In mptcp_incoming_options, pass it to
> > mpext->csum.
> >
> > In validate_mapping, use the new function validate_dss_csum to validata
> > the DSS checksum.
> >
> > In validate_dss_csum, if the data has been split in different packets,
> > skip validating.
> >
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > ---
> > net/mptcp/options.c  | 13 +++++++++++--
> > net/mptcp/protocol.h |  1 +
> > net/mptcp/subflow.c  | 37 +++++++++++++++++++++++++++++++++++++
> > 3 files changed, 49 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 69eb15ef9385..ed89f6c2ed49 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -206,9 +206,14 @@ static void mptcp_parse_option(const struct sk_buf=
f *skb,
> >                       mp_opt->data_len =3D get_unaligned_be16(ptr);
> >                       ptr +=3D 2;
> >
> > -                     pr_debug("data_seq=3D%llu subflow_seq=3D%u data_l=
en=3D%u",
> > +                     if (opsize =3D=3D expected_opsize + TCPOLEN_MPTCP=
_DSS_CHECKSUM) {
>
> Now that more of the checksum code has been added, I think that
> expected_opsize should be set to the exact value that is needed - either
> expect the checksum, or don't expect the checksum.
>
> RFC 6824 said: "If a checksum is present, but its use had not been
> negotiated in the MP_CAPABLE handshake, the checksum field MUST be
> ignored."
>
> RFC 8684 says: "If a checksum is present but its use had
> not been negotiated in the MP_CAPABLE handshake, the receiver MUST
> close the subflow with a RST, as it is not behaving as negotiated.
> If a checksum is not present when its use has been negotiated, the
> receiver MUST close the subflow with a RST, as it is considered
> broken."
>
> There's some old RFC 6824-based code earlier in the function:
>
>                 if (opsize !=3D expected_opsize &&
>                     opsize !=3D expected_opsize + TCPOLEN_MPTCP_DSS_CHECK=
SUM)
>                         break;
>
> That needs to be changed to:
>
>                 if (opsize !=3D expected_opsize)
>                         break;
>
> and expected_opsize should include TCPOLEN_MPTCP_DSS_CHECKSUM only if the
> checksum is enabled.
>
> > +                             mp_opt->csum =3D get_unaligned_be16(ptr);
> > +                             ptr +=3D 2;
> > +                     }
> > +
> > +                     pr_debug("data_seq=3D%llu subflow_seq=3D%u data_l=
en=3D%u csum=3D%u",
> >                                mp_opt->data_seq, mp_opt->subflow_seq,
> > -                              mp_opt->data_len);
> > +                              mp_opt->data_len, mp_opt->csum);
> >               }
> >
> >               break;
> > @@ -339,6 +344,7 @@ void mptcp_get_options(const struct sk_buff *skb,
> >       mp_opt->mp_prio =3D 0;
> >       mp_opt->reset =3D 0;
> >       mp_opt->csum_reqd =3D 0;
> > +     mp_opt->csum =3D 0;
> >
> >       length =3D (th->doff * 4) - sizeof(struct tcphdr);
> >       ptr =3D (const unsigned char *)(th + 1);
> > @@ -1124,6 +1130,9 @@ void mptcp_incoming_options(struct sock *sk, stru=
ct sk_buff *skb)
> >               }
> >               mpext->data_len =3D mp_opt.data_len;
> >               mpext->use_map =3D 1;
> > +
> > +             if (READ_ONCE(msk->csum_reqd))
> > +                     mpext->csum =3D mp_opt.csum;
> >       }
> > }
> >
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index f62cea8635f0..51ef3173a2e5 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -123,6 +123,7 @@ struct mptcp_options_received {
> >       u64     data_seq;
> >       u32     subflow_seq;
> >       u16     data_len;
> > +     u16     csum;
> >       u16     mp_capable : 1,
> >               mp_join : 1,
> >               fastclose : 1,
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 9fec1a273100..2eeea7d527f0 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -799,10 +799,45 @@ static bool skb_is_fully_mapped(struct sock *ssk,=
 struct sk_buff *skb)
> >                                         mptcp_subflow_get_map_offset(su=
bflow);
> > }
> >
> > +static bool validate_dss_csum(struct sock *ssk, struct sk_buff *skb)
> > +{
> > +     struct csum_pseudo_header header;
> > +     struct mptcp_ext *mpext;
> > +     __wsum csum;
> > +
> > +     if (!skb)
> > +             goto out;
> > +
> > +     mpext =3D mptcp_get_ext(skb);
> > +     if (!mpext || !mpext->use_map || !mpext->csum ||
> > +         mpext->data_len !=3D skb->len)
> > +             goto out;
> > +
> > +     header.data_seq =3D mpext->data_seq;
> > +     header.subflow_seq =3D mpext->subflow_seq;
> > +     header.data_len =3D mpext->data_len;
> > +     header.csum =3D mpext->csum;
> > +
> > +     csum =3D skb_checksum(skb, 0, skb->len, 0);
>
> The checksum isn't calculated using the data from a single skb, it
> requires the complete reassembled data for the current mapping. If we're
> lucky, GRO has placed everything in one skb. But that can't be assumed.
>
> The checksum can be calculated incrementally as skbs arrive, but checksum
> verification will require changes to data reassembly and MPTCP-level
> acknowledgements, and will delay movement of data to the msk until the
> checksum is verified. Also review my comments on the MP_FAIL RFC patch:

I need some help here.

How can I get the reassembled data for the current mapping? And in which
function to calculate the skbs checksum and where to verify them? Could
you please give me more detail?

Thanks.

-Geliang

>
> https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/message/KSEEB5Q4N=
D3GKOW7S3FZ32PHCWWON5QC/
>
>
> Thanks for the patch set!
>
> Mat
>
>
> > +     csum =3D csum_partial(&header, sizeof(header), csum);
> > +
> > +     if (csum_fold(csum)) {
> > +             pr_err("DSS checksum error! data_seq=3D%llu subflow_seq=
=3D%u data_len=3D%u csum=3D%u %u",
> > +                    header.data_seq, header.subflow_seq, header.data_l=
en,
> > +                    header.csum, csum_fold(csum));
> > +
> > +             return false;
> > +     }
> > +
> > +out:
> > +     return true;
> > +}
> > +
> > static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
> > {
> >       struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> >       u32 ssn =3D tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
> > +     struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> >
> >       if (unlikely(before(ssn, subflow->map_subflow_seq))) {
> >               /* Mapping covers data later in the subflow stream,
> > @@ -817,6 +852,8 @@ static bool validate_mapping(struct sock *ssk, stru=
ct sk_buff *skb)
> >               warn_bad_map(subflow, ssn + skb->len);
> >               return false;
> >       }
> > +     if (READ_ONCE(msk->csum_reqd))
> > +             validate_dss_csum(ssk, skb);
> >       return true;
> > }
> >
> > --
> > 2.30.2
>
> --
> Mat Martineau
> Intel
