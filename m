Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AD72
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 03:41:17 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id s22so13198669pgk.6
        for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 20:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3R0QqLrtgo+EYd9Iw+JXKnewa0DRhe+Y+HzicdeoyfI=;
        b=XX5DPFdmR/7uBVoSHZo3FGh8GnF2vtoXjQgXc8qEI9xAYIyKYdPPZSDLw3Mp/Y0A22
         YgBdP9g6tfJBoY5x3hwK1MCHySYkF0uZJX7vd8z83ihSWylWe8KKz7WOp/HhO0zVL6EJ
         TCI3KfWD3gl0wovxZdgi3qus3qZo5Qty1R5qLwscFZxw6/zP+EFwsRS+ezzf14zUjjxZ
         j62g8hsPUP8EBWJe5urYhv7feCk3/OHHDKcoEUYJiWptRYKvrphz9F2m5ri11YpW8W0H
         5nVxAyOBS/fGqKcgwURIxnTYBBhpoHt81+5wN92FPLGxU3VP1ITAaSvLRpKKzjdzvMNR
         pBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3R0QqLrtgo+EYd9Iw+JXKnewa0DRhe+Y+HzicdeoyfI=;
        b=RbVT1xSuVmXl0i1FEUCqRkLmASd+rvTt+LUq1GOyp7ART2SRnB/Vku8Hk+SlUNbqBP
         psrzS/d3eNUg/ywjQ0i1PXADZ76Y2omy7UA0Y94KChBMLv0sHg3784UA3cghC0gAtq7A
         aMueigIOfe3cDmzkgCNafQ02Hh3jQpAtBoO6qm1FM0ng2XmgL+W4PylF0eggyebRy0T+
         3meL3LEbrysJI/3zrJy+dcZO2Q/gKt0AMq4+mRvyGJOIkwKtEnDbFlfeajDh6e+wl73A
         8I+1dAFgA3k3v64/aaed1aG/Yck4Iw4M5ORQuyyvdKdh9bWd3hAaDe3lTNGkMAsdCv3E
         IT3w==
X-Gm-Message-State: AOAM533HCpDtz9xYx1ws5SbV9ZhuNzB5UNknBPRBjy7mhMb2bL8Bg7MD
	ksPM+pFAlA7eyp+OPh+2dYlQUw05oqTj1xkj+HU=
X-Google-Smtp-Source: ABdhPJxQBWpb2n2otb2yRFT/G1a3TOjCNeDtoJqTy46u+9gzDtdSwKl73ZJwrcH5H+9lfuxKinyGcrcY50MLbTP4DFQ=
X-Received: by 2002:a65:468d:: with SMTP id h13mr1761409pgr.373.1619149276771;
 Thu, 22 Apr 2021 20:41:16 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1619035356.git.pabeni@redhat.com> <dc70316d43c4344da0e78616d9a9f23640e22c78.1619035356.git.pabeni@redhat.com>
In-Reply-To: <dc70316d43c4344da0e78616d9a9f23640e22c78.1619035356.git.pabeni@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 23 Apr 2021 11:41:05 +0800
Message-ID: <CA+WQbwtYA1khkXRZfiCEeTXGDASg+yTv0_S-dwHXVqW9YUApFQ@mail.gmail.com>
Subject: Re: [PATCH v3 mptcp-next 08/21] Squash-to "mptcp: send out checksum
 for DSS"
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8822=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:21=E5=86=99=E9=81=93=EF=BC=9A
>
> Account for csum len in mptcp_established_options_dss()
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/options.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 01caff4cdd25..f8430415a954 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -553,15 +553,17 @@ static bool mptcp_established_options_dss(struct so=
ck *sk, struct sk_buff *skb,
>         mpext =3D skb ? mptcp_get_ext(skb) : NULL;
>
>         if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
> -               unsigned int map_size;
> +               unsigned int map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLE=
N_MPTCP_DSS_MAP64;
>
> -               map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_M=
AP64;

I want to keep these lines unchanged.

> +               if (mpext) {
> +                       if (READ_ONCE(msk->csum_enabled))

I want to use 'if (opts->csum_reqd)' here instead.

> +                               map_size +=3D TCPOLEN_MPTCP_DSS_CHECKSUM;
>
> -               remaining -=3D map_size;
> -               dss_size =3D map_size;
> -               if (mpext)
>                         opts->ext_copy =3D *mpext;
> +               }
>
> +               dss_size =3D map_size;
> +               remaining -=3D map_size;

And change these two lines as the original order:

               remaining -=3D map_size;
               dss_size =3D map_size;

WDYT?

Thanks.


-Geliang

>                 if (skb && snd_data_fin_enable)
>                         mptcp_write_data_fin(subflow, skb, &opts->ext_cop=
y);
>                 ret =3D true;
> --
> 2.26.2
>
