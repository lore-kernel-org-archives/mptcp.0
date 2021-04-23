Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547472
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 03:17:53 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id g16so7699126plq.3
        for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 20:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eSTofpgOm7aLrxC+TqT9oXQ6IrZHSDiXKfsVP5Q0EFY=;
        b=AMilgtfvTruKkf3CwqFvKD76HWNf6/HhiaOF7mxYGUCd5OdmDaVceJEu4UQtsnBEAK
         7oSiC/wKZHfF6uT1+Zr+Qwm0AkTmMQs3a7ngGav8bA9kSlQ3wqmJGl0lM4HsjQ+w5fLE
         MglnH0VmF2497S1CW1WdjAxt5i+A20t4pGUa1u8d0lW4l+xzHoY24v0R4dQ7PEBIdXB7
         hKMtoCnq2jWeIReD1XBrzfAkJmZkpP7CSaR/o+3KEC/EoDkQMp/+UJ7H8FdZCVy3rjr8
         fex0ijlqXKdILcFHVTV+lmw952k4lRPfxmlFBIskiQqd8zd1khjiefCF6mZryUzf2QOa
         MrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eSTofpgOm7aLrxC+TqT9oXQ6IrZHSDiXKfsVP5Q0EFY=;
        b=UGaD7CLWhaUzARfUvRbFGddCOyusy0e6uFzVqZM/Mb0w7vNsAer5cbxKif/pICnPn6
         xpQ7U2nVHw4C4SiHvm+PECTgGiaPRw4/3X6u4A3Aacy+32kXr++ojzSJADnu/UF9nPER
         COYIYgrl2/paY7QcuSsxMhxsSF+eGh6vMc3csC/8ULcVYFi90l4pqQIifChYaXxuYlrv
         QY/JZiG2CL78RLXgMuxNL9IacCzXwN74D+cXZM9S6cWpWEfprvOX7j59JxzZPLhXGsbl
         lkSsPDjiHdZP7qvI0Sf+ccq6Arhnvd3Pz7XyOZtKfopVW57KPtYZj55RaCaXhpnAz9A/
         AEKA==
X-Gm-Message-State: AOAM531J7CIM6guMLriIovyWKJEwXalH1rv7IYZ9ZNIW8cdZbqolHM7H
	t4t8N2sbKDkiIsAVlTQdQhwGRXnO4GbslAKwMSw=
X-Google-Smtp-Source: ABdhPJzdIPRXkEm6vNGGz81shCs/M02LiXdwwtYVoeLSb8uwTykblYtHHmoFPNsPo7zX2/p6sj051kxDu+f0lIHdpt0=
X-Received: by 2002:a17:902:8693:b029:eb:53f:1336 with SMTP id
 g19-20020a1709028693b02900eb053f1336mr1694624plo.52.1619147873178; Thu, 22
 Apr 2021 20:17:53 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1619035356.git.pabeni@redhat.com> <77387e8589417f2ccb445136c74d16ed44a344d1.1619035356.git.pabeni@redhat.com>
In-Reply-To: <77387e8589417f2ccb445136c74d16ed44a344d1.1619035356.git.pabeni@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 23 Apr 2021 11:17:41 +0800
Message-ID: <CA+WQbws0LhacR_RqaRBSasgwpFO8fwk57AzMHXHK52KBNL6bUQ@mail.gmail.com>
Subject: Re: [PATCH v3 mptcp-next 12/21] Squash-to: "mptcp: receive checksum
 for MP_CAPABLE with data"
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8822=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:20=E5=86=99=E9=81=93=EF=BC=9A
>
> always parse any csum/nocsum combination and delay the
> presence check to later code, to allow reset if missing.
>
> Additionally, in the TX path, use the newly introduce ext
> field to avoid MPTCP csum recomputation on tcp retransmission
> and unneeded csum update on when setting the data fin_flag.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  include/net/mptcp.h  |  3 ++-
>  net/mptcp/options.c  | 32 ++++++++++++++++++++------------
>  net/mptcp/protocol.h |  2 ++
>  3 files changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 8f86c05ddbfd..bd272c34b53c 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -32,7 +32,8 @@ struct mptcp_ext {
>                         mpc_map:1,
>                         frozen:1,
>                         reset_transient:1;
> -       u8              reset_reason:4;
> +       u8              reset_reason:4,
> +                       csum_reqd:1;

I want to move these lines to the patch ([PATCH v3 mptcp-next 03/21]
Squash-to: "mptcp: generate the data checksum") in the next version.

>  };
>
>  #define MPTCP_RM_IDS_MAX       8
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cd205ad09c00..83a981684bbf 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -39,8 +39,6 @@ static void mptcp_parse_option(const struct sock *sk,
>                 if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
>                         if (skb->len > tcp_hdr(skb)->doff << 2) {
>                                 expected_opsize =3D TCPOLEN_MPTCP_MPC_ACK=
_DATA;
> -                               if (READ_ONCE(msk->csum_enabled))
> -                                       expected_opsize +=3D TCPOLEN_MPTC=
P_DSS_CHECKSUM;
>                         } else {
>                                 expected_opsize =3D TCPOLEN_MPTCP_MPC_ACK=
;
>                         }

I'll drop these braces '{}' too, it looks like:

                         if (skb->len > tcp_hdr(skb)->doff << 2)
                                 expected_opsize =3D TCPOLEN_MPTCP_MPC_ACK_=
DATA;
                         else
                                 expected_opsize =3D TCPOLEN_MPTCP_MPC_ACK;

> @@ -50,7 +48,20 @@ static void mptcp_parse_option(const struct sock *sk,
>                         else
>                                 expected_opsize =3D TCPOLEN_MPTCP_MPC_SYN=
;
>                 }
> -               if (opsize !=3D expected_opsize)
> +
> +               /* Cfr RFC 8684 Section 3.3.0:
> +                * If a checksum is present but its use had
> +                * not been negotiated in the MP_CAPABLE handshake, the r=
eceiver MUST
> +                * close the subflow with a RST, as it is not behaving as=
 negotiated.
> +                * If a checksum is not present when its use has been neg=
otiated, the
> +                * receiver MUST close the subflow with a RST, as it is c=
onsidered
> +                * broken
> +                * We parse even option with mismatching csum presence, s=
o that
> +                * later in subflow_data_ready we can trigger the reset.
> +                */
> +               if ((opsize !=3D expected_opsize) &&
> +                   (expected_opsize !=3D TCPOLEN_MPTCP_MPC_ACK_DATA ||
> +                    opsize !=3D TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM))
>                         break;
>
>                 /* try to be gentle vs future versions on the initial syn=
 */
> @@ -72,11 +83,6 @@ static void mptcp_parse_option(const struct sock *sk,
>                  * host requires the use of checksums, checksums MUST be =
used.
>                  * In other words, the only way for checksums not to be u=
sed
>                  * is if both hosts in their SYNs set A=3D0."
> -                *
> -                * Section 3.3.0:
> -                * "If a checksum is not present when its use has been
> -                * negotiated, the receiver MUST close the subflow with a=
 RST as
> -                * it is considered broken."
>                  */
>                 mp_opt->csum_reqd =3D READ_ONCE(msk->csum_enabled);
>                 if (flags & MPTCP_CAP_CHECKSUM_REQD)
> @@ -103,8 +109,9 @@ static void mptcp_parse_option(const struct sock *sk,
>                         mp_opt->data_len =3D get_unaligned_be16(ptr);
>                         ptr +=3D 2;
>                 }
> -               if (opsize =3D=3D TCPOLEN_MPTCP_MPC_ACK_DATA + TCPOLEN_MP=
TCP_DSS_CHECKSUM) {
> +               if (opsize =3D=3D TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM) {
>                         mp_opt->csum =3D (__force __sum16)get_unaligned_b=
e16(ptr);
> +                       mp_opt->csum_reqd =3D 1;
>                         ptr +=3D 2;
>                 }
>                 pr_debug("MP_CAPABLE version=3D%x, flags=3D%x, optlen=3D%=
d sndr=3D%llu, rcvr=3D%llu len=3D%d csum=3D%u",
> @@ -353,7 +360,6 @@ void mptcp_get_options(const struct sock *sk,
>         mp_opt->mp_prio =3D 0;
>         mp_opt->reset =3D 0;
>         mp_opt->csum_reqd =3D 0;
> -       mp_opt->csum =3D 0;

I want to keep this "mp_opt->csum =3D 0;" here.

>
>         length =3D (th->doff * 4) - sizeof(struct tcphdr);
>         ptr =3D (const unsigned char *)(th + 1);
> @@ -543,7 +549,8 @@ static void mptcp_write_data_fin(struct mptcp_subflow=
_context *subflow,
>                 ext->data_len++;
>
>                 /* the pseudo header has changed, update the csum accordi=
ngly */
> -               csum_replace2(&ext->csum, ext->data_len - 1, ext->data_le=
n);
> +               if (ext->csum_reqd)
> +                       csum_replace2(&ext->csum, ext->data_len - 1, ext-=
>data_len);

And I want to move these lines to the patch ([PATCH v3 mptcp-next 03/21]
Squash-to: "mptcp: generate the data checksum") too.

WDYT?

Thanks.

-Geliang

>         }
>  }
>
> @@ -1129,8 +1136,9 @@ void mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb)
>                 }
>                 mpext->data_len =3D mp_opt.data_len;
>                 mpext->use_map =3D 1;
> +               mpext->csum_reqd =3D mp_opt.csum_reqd;
>
> -               if (READ_ONCE(msk->csum_enabled))
> +               if (mpext->csum_reqd)
>                         mpext->csum =3D mp_opt.csum;
>         }
>  }
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d2b00f8c4040..3ac61b8178fd 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -68,6 +68,8 @@
>  #define TCPOLEN_MPTCP_FASTCLOSE                12
>  #define TCPOLEN_MPTCP_RST              4
>
> +#define TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM        (TCPOLEN_MPTCP_DSS_CHECKS=
UM + TCPOLEN_MPTCP_MPC_ACK_DATA)
> +
>  /* MPTCP MP_JOIN flags */
>  #define MPTCPOPT_BACKUP                BIT(0)
>  #define MPTCPOPT_HMAC_LEN      20
> --
> 2.26.2
>
