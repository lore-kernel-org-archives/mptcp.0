Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7332C6E
	for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 04:02:36 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id u9so24809756ejj.7
        for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 21:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ud53a8NTOH0FejyhXWVnnyX2i2mDzwRVT8SKiF41R3g=;
        b=Vhp488ZPo2tnDmtfHus7WF9yCwoEa/FqC4lisVNkm7XkNGJmlQCy1gP8LwBKxiL121
         RRcoeYMkxDbZaVr9wvz8F2FZTbknhXzy0Fgh/Mc6sapnQZV1BhWG5I16+RHT65pun7e+
         8xSEmvO/CFRokTtPjTQNCnkOA+gITL767Zm7aV4+5VIpREjXUMgJIneWPvGwhugMKaDQ
         wbfB5O0yV2tiayvSJJAnYJnzx50e5KWdPyRM911O+jEcT59NphrTN0uIii9tNTXFeqKZ
         dtBmQGY8fve8xuvtMUoC7XjTd1k4VKZ2qycr2Z/TTXlgRm9jLfbFz+yygqMKzdFXm+OM
         zf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ud53a8NTOH0FejyhXWVnnyX2i2mDzwRVT8SKiF41R3g=;
        b=q5DYb09Y+Pd5NVo2Ay2iaXI7toE8f6j1ZEfCw8qYBg96zas33gUVc18Ci7A5w0o/e0
         jMfraTuThge5GYqD9jvSDFqB8fCkAZWlWAj6S2Z/BSJPsvxbcnWTUXPKI7P/+Dk4kq59
         dS25QGMPzm9fDsbhhkYgtkYWZhOfAynOZY+apQUi3bVeLUBQIVKgDgvXCSGvPSoQnyBJ
         AEfG0Jytb79Vt3Kk+kiIZ/sX2sBmNGGrrtejWb3jT0GqeKYJV+6LByNbhUzS4gwuDRAY
         ZaiWa3CO6hHV0GbQa7Oa7fXWfJLMu+sCF5RA+JfZMr4Lg7VVEZclDxS77ZBtEAgjEW+x
         Tk5g==
X-Gm-Message-State: AOAM530/Rz5af3k1pTY7t5U5YT9UL/xvycZNPzSHZrsL2mC/AaLuxikr
	aKbbT8x6obC88wFw0ExngPLQUeBKofuE7kKiL6OwShjESKYW0w==
X-Google-Smtp-Source: ABdhPJwgpqTy30x3fdEShSi2UE9kICIkt4z9vrYI0E4nqLV8q/giZxEE6DKyy6pSbijbkN+5BwA4TSZFwbuSOrjbaYM=
X-Received: by 2002:a17:907:77d4:: with SMTP id kz20mr2897990ejc.93.1616472155015;
 Mon, 22 Mar 2021 21:02:35 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20210322162132.2471823-1-matthieu.baerts@tessares.net> <20210322162132.2471823-2-matthieu.baerts@tessares.net>
In-Reply-To: <20210322162132.2471823-2-matthieu.baerts@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 23 Mar 2021 12:02:23 +0800
Message-ID: <CA+WQbwvbHa_KxteV=2LTS2m5uBez9cxKa0WnHUDRAvo6D18JWQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 2/3] Squash to "mptcp: use mptcp_addr_info in mptcp_options_received"
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, mptcp <mptcp@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Please update the commit log too:

---
Since the port number became as a big-endian order now, use ntohs to
convert it before printing it out.
---

 ->

---
Since the port number became big-endian now, use htons to convert the
incoming port number to it. Also use ntohs to convert it when passing
it to add_addr_generate_hmac or printing it out.
---

Thanks.

-Geliang

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B43=E6=
=9C=8823=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8812:21=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Fix issues reported by sparse because we were doing non explicit casting
> from __be16 to u16 and the opposite.
>
>   net/mptcp/options.c:251:51: warning: incorrect type in assignment (diff=
erent base types)
>   net/mptcp/options.c:251:51:    expected restricted __be16 [usertype] po=
rt
>   net/mptcp/options.c:251:51:    got unsigned short
>   net/mptcp/options.c:261:51: warning: incorrect type in assignment (diff=
erent base types)
>   net/mptcp/options.c:261:51:    expected restricted __be16 [usertype] po=
rt
>   net/mptcp/options.c:261:51:    got unsigned short
>   net/mptcp/options.c:998:59: warning: incorrect type in argument 5 (diff=
erent base types)
>   net/mptcp/options.c:998:59:    expected unsigned short [usertype] port
>   net/mptcp/options.c:998:59:    got restricted __be16 [usertype] port
>   net/mptcp/options.c:1004:60: warning: incorrect type in argument 5 (dif=
ferent base types)
>   net/mptcp/options.c:1004:60:    expected unsigned short [usertype] port
>   net/mptcp/options.c:1004:60:    got restricted __be16 [usertype] port
>
> Before the mentioned commit, we were using port in u16 in
> mptcp_options_received, everything was OK.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  net/mptcp/options.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 7fd40512df7f..43b85f2a5be1 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -248,7 +248,7 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
>                         ptr +=3D 4;
>                         if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_PORT ||
>                             opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_BASE_POR=
T) {
> -                               mp_opt->addr.port =3D get_unaligned_be16(=
ptr);
> +                               mp_opt->addr.port =3D cpu_to_be16(get_una=
ligned_be16(ptr));
>                                 ptr +=3D 2;
>                         }
>                 }
> @@ -258,7 +258,7 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
>                         ptr +=3D 16;
>                         if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_PORT ||
>                             opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE_PO=
RT) {
> -                               mp_opt->addr.port =3D get_unaligned_be16(=
ptr);
> +                               mp_opt->addr.port =3D cpu_to_be16(get_una=
ligned_be16(ptr));
>                                 ptr +=3D 2;
>                         }
>                 }
> @@ -995,13 +995,13 @@ static bool add_addr_hmac_valid(struct mptcp_sock *=
msk,
>                 hmac =3D add_addr_generate_hmac(msk->remote_key,
>                                               msk->local_key,
>                                               mp_opt->addr.id, &mp_opt->a=
ddr.addr,
> -                                             mp_opt->addr.port);
> +                                             be16_to_cpu(mp_opt->addr.po=
rt));
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>         else
>                 hmac =3D add_addr6_generate_hmac(msk->remote_key,
>                                                msk->local_key,
>                                                mp_opt->addr.id, &mp_opt->=
addr.addr6,
> -                                              mp_opt->addr.port);
> +                                              be16_to_cpu(mp_opt->addr.p=
ort));
>  #endif
>
>         pr_debug("msk=3D%p, ahmac=3D%llu, mp_opt->ahmac=3D%llu\n",
> --
> 2.30.2
>
