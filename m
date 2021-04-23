Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2271
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 09:17:08 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id p2so19333782pgh.4
        for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 02:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sBOWjN2Wewpxi/J+ZJFUSdb50TT6ehUKDuE3hJSUb9U=;
        b=npLdfc7DbW/JZJlR7yLj4UkbI7BhwUd+yjSvf3IJCa0hyeaVprvwD3RwS2Azhtayrs
         AQ8H4K4YIjyvHPaWkSJR87s1TsRM6C0NPTqvXLeG7VTcOADfZVxpRLEd/M0Yw4NLtG9H
         /0tUQqqAYc4VLzC1p+52uwlptEKb97AndAXanRGGQUboE6HFSx08xjkDbncu1Hg6DaH1
         UDsM4u3JJP7yMLdy4BGTYpi6uZhq+BgpnCNbYFD7elvwMoQj8gYevUVb/CLrKhPu/WRE
         RoPbXw8cMaZw3M6B1+5sAxV1WqSVixs4f/8dt+NglzfoAgliAjnPZARQhrGqbc7uBQkv
         J3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sBOWjN2Wewpxi/J+ZJFUSdb50TT6ehUKDuE3hJSUb9U=;
        b=q8cadv/uVZl2Q5cSp1qNjyCw5BrxrE1lbqi5Bq5rPjJoW+fmys3RAuKZeGjNvMkMZw
         io7muMot1IpXqBHLCrMQ0gWes0PTIpZPdANFE1KSf+O6ICqubt/XW0n7kiLe6wHqrdCL
         lnOt8yqyOZkSjgY3WyCfFZpfU1aHM6fd2X1gQ45vVR5ZoWDr1apNtKo8rKRzdPX3b4pX
         5TMVrD+wEzNBXNOlHpX9Cw+++cKZqEutMVlAVsVnlY7/ezBDgjpRVeBaUBmPYS8xmSS6
         RgszzgmbBu4TwyJZ4nVeu/KpHJrseyWpZ2p7xrEIguNNwd7ARGCbYCbQPOaXfW5c2jCU
         DOyw==
X-Gm-Message-State: AOAM5334KmDeabJYrd6UXSWnSvUPqHOsL+bHjdOpq4lpNFj14FtqF/cw
	Gb37f2iayar107CHjqmht31Xsl+XKtFMZDuNgGUjS5ICgSo=
X-Google-Smtp-Source: ABdhPJzhAZuBHSjFpSkP8hHVe/lfDB9t9I8qpFEO8kATm6AgsbHEEcrEKosStRDi4fTLhnlnTbu14I+5czWwRlKCbSI=
X-Received: by 2002:a65:468d:: with SMTP id h13mr2761377pgr.373.1619169427965;
 Fri, 23 Apr 2021 02:17:07 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1619035356.git.pabeni@redhat.com> <77387e8589417f2ccb445136c74d16ed44a344d1.1619035356.git.pabeni@redhat.com>
 <CA+WQbws0LhacR_RqaRBSasgwpFO8fwk57AzMHXHK52KBNL6bUQ@mail.gmail.com> <3c5d904e6e4da06c4066955f7a7f714cccc1f207.camel@redhat.com>
In-Reply-To: <3c5d904e6e4da06c4066955f7a7f714cccc1f207.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 23 Apr 2021 17:16:56 +0800
Message-ID: <CA+WQbwsNGZQHPKhpN=xRMi12=gRCtAX93YAoYZ6_MZbrBSsCpw@mail.gmail.com>
Subject: Re: [PATCH v3 mptcp-next 12/21] Squash-to: "mptcp: receive checksum
 for MP_CAPABLE with data"
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8823=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:52=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 2021-04-23 at 11:17 +0800, Geliang Tang wrote:
> > Hi Paolo,
> >
> > Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8822=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:20=E5=86=99=E9=81=93=EF=BC=9A
> > > always parse any csum/nocsum combination and delay the
> > > presence check to later code, to allow reset if missing.
> > >
> > > Additionally, in the TX path, use the newly introduce ext
> > > field to avoid MPTCP csum recomputation on tcp retransmission
> > > and unneeded csum update on when setting the data fin_flag.
> > >
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > >  include/net/mptcp.h  |  3 ++-
> > >  net/mptcp/options.c  | 32 ++++++++++++++++++++------------
> > >  net/mptcp/protocol.h |  2 ++
> > >  3 files changed, 24 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > > index 8f86c05ddbfd..bd272c34b53c 100644
> > > --- a/include/net/mptcp.h
> > > +++ b/include/net/mptcp.h
> > > @@ -32,7 +32,8 @@ struct mptcp_ext {
> > >                         mpc_map:1,
> > >                         frozen:1,
> > >                         reset_transient:1;
> > > -       u8              reset_reason:4;
> > > +       u8              reset_reason:4,
> > > +                       csum_reqd:1;
> >
> > I want to move these lines to the patch ([PATCH v3 mptcp-next 03/21]
> > Squash-to: "mptcp: generate the data checksum") in the next version.
>
> The 'csum_reqd' bit is used a validity status for the parsed csum: we
> know a csum was present in the parsed DSS if and only if csum_reqd !=3D
> 0. I think it needs to stay here.

If we keep this csum_reqd in this patch ...

>
> > >  };
> > >
> > >  #define MPTCP_RM_IDS_MAX       8
> > > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > > index cd205ad09c00..83a981684bbf 100644
> > > --- a/net/mptcp/options.c
> > > +++ b/net/mptcp/options.c
> > > @@ -39,8 +39,6 @@ static void mptcp_parse_option(const struct sock *s=
k,
> > >                 if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
> > >                         if (skb->len > tcp_hdr(skb)->doff << 2) {
> > >                                 expected_opsize =3D TCPOLEN_MPTCP_MPC=
_ACK_DATA;
> > > -                               if (READ_ONCE(msk->csum_enabled))
> > > -                                       expected_opsize +=3D TCPOLEN_=
MPTCP_DSS_CHECKSUM;
> > >                         } else {
> > >                                 expected_opsize =3D TCPOLEN_MPTCP_MPC=
_ACK;
> > >                         }
> >
> > I'll drop these braces '{}' too, it looks like:
> >
> >                          if (skb->len > tcp_hdr(skb)->doff << 2)
> >                                  expected_opsize =3D TCPOLEN_MPTCP_MPC_=
ACK_DATA;
> >                          else
> >                                  expected_opsize =3D TCPOLEN_MPTCP_MPC_=
ACK;
>
> Agreed.
>
> > > @@ -50,7 +48,20 @@ static void mptcp_parse_option(const struct sock *=
sk,
> > >                         else
> > >                                 expected_opsize =3D TCPOLEN_MPTCP_MPC=
_SYN;
> > >                 }
> > > -               if (opsize !=3D expected_opsize)
> > > +
> > > +               /* Cfr RFC 8684 Section 3.3.0:
> > > +                * If a checksum is present but its use had
> > > +                * not been negotiated in the MP_CAPABLE handshake, t=
he receiver MUST
> > > +                * close the subflow with a RST, as it is not behavin=
g as negotiated.
> > > +                * If a checksum is not present when its use has been=
 negotiated, the
> > > +                * receiver MUST close the subflow with a RST, as it =
is considered
> > > +                * broken
> > > +                * We parse even option with mismatching csum presenc=
e, so that
> > > +                * later in subflow_data_ready we can trigger the res=
et.
> > > +                */
> > > +               if ((opsize !=3D expected_opsize) &&
> > > +                   (expected_opsize !=3D TCPOLEN_MPTCP_MPC_ACK_DATA =
||
> > > +                    opsize !=3D TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM))
> > >                         break;
> > >
> > >                 /* try to be gentle vs future versions on the initial=
 syn */
> > > @@ -72,11 +83,6 @@ static void mptcp_parse_option(const struct sock *=
sk,
> > >                  * host requires the use of checksums, checksums MUST=
 be used.
> > >                  * In other words, the only way for checksums not to =
be used
> > >                  * is if both hosts in their SYNs set A=3D0."
> > > -                *
> > > -                * Section 3.3.0:
> > > -                * "If a checksum is not present when its use has bee=
n
> > > -                * negotiated, the receiver MUST close the subflow wi=
th a RST as
> > > -                * it is considered broken."
> > >                  */
> > >                 mp_opt->csum_reqd =3D READ_ONCE(msk->csum_enabled);
> > >                 if (flags & MPTCP_CAP_CHECKSUM_REQD)
> > > @@ -103,8 +109,9 @@ static void mptcp_parse_option(const struct sock =
*sk,
> > >                         mp_opt->data_len =3D get_unaligned_be16(ptr);
> > >                         ptr +=3D 2;
> > >                 }
> > > -               if (opsize =3D=3D TCPOLEN_MPTCP_MPC_ACK_DATA + TCPOLE=
N_MPTCP_DSS_CHECKSUM) {
> > > +               if (opsize =3D=3D TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM) {
> > >                         mp_opt->csum =3D (__force __sum16)get_unalign=
ed_be16(ptr);
> > > +                       mp_opt->csum_reqd =3D 1;
> > >                         ptr +=3D 2;
> > >                 }
> > >                 pr_debug("MP_CAPABLE version=3D%x, flags=3D%x, optlen=
=3D%d sndr=3D%llu, rcvr=3D%llu len=3D%d csum=3D%u",
> > > @@ -353,7 +360,6 @@ void mptcp_get_options(const struct sock *sk,
> > >         mp_opt->mp_prio =3D 0;
> > >         mp_opt->reset =3D 0;
> > >         mp_opt->csum_reqd =3D 0;
> > > -       mp_opt->csum =3D 0;
> >
> > I want to keep this "mp_opt->csum =3D 0;" here.
>
> No, this is not needed. zeoring the csum is not needed. The csum should
> be accessed if and only if csum_reqd !=3D 0, and in that case 'csum' will
> always be initialized.
>
> > >         length =3D (th->doff * 4) - sizeof(struct tcphdr);
> > >         ptr =3D (const unsigned char *)(th + 1);
> > > @@ -543,7 +549,8 @@ static void mptcp_write_data_fin(struct mptcp_sub=
flow_context *subflow,
> > >                 ext->data_len++;
> > >
> > >                 /* the pseudo header has changed, update the csum acc=
ordingly */
> > > -               csum_replace2(&ext->csum, ext->data_len - 1, ext->dat=
a_len);
> > > +               if (ext->csum_reqd)
> > > +                       csum_replace2(&ext->csum, ext->data_len - 1, =
ext->data_len);
> >
> > And I want to move these lines to the patch ([PATCH v3 mptcp-next 03/21=
]
> > Squash-to: "mptcp: generate the data checksum") too.
>
> Agreed.

... we need to keep these lines in this patch too.

Is that right?

>
> Side note: I can send the relevant changes, n.p.

Please send the changes for me, thanks.

-Geliang

>
> /P
>
