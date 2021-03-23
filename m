Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF406E
	for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 04:01:07 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id b7so24824363ejv.1
        for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 21:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MV9pNNKoFSnclKlBWY0t0WJd9tvNnfJPLN2Qzj9sbn0=;
        b=haRtESAcaM3RKXT4GGC8STUHQOo9X58OKFUwT49Iy9KMduvOrqc3iTrtuuoW3vDgq+
         9g8gIPxBMXB6FmO2xi2n2eix6Y82mHQzJU+0KwZsxHASrI0rw2fsKtSlNrltQWZhE3Lc
         C4Pgd2GAc2fOKV5rjxFTulygW9qGRIVmlpLkibaw4ECKSSPqN/3BDXoWuobIH+YPoz+/
         ARhZoCaHHuoQ/P5pM/y4TTn+J8U0/AuvBEgsxgJyHwJ/eMpwuR9iEnoh/ALWr6n6XI4V
         EYxbn7cQ7OfQlZMXT6G5ysi9zN4H7hjmPWXQAg3t+F6FayhaUKQQmJLld8UgciGx6MrV
         pBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MV9pNNKoFSnclKlBWY0t0WJd9tvNnfJPLN2Qzj9sbn0=;
        b=smIYvgKUo+ioy/2dpGLmolG+vGk7crHI9dD3z8FHc7MP5ymiIBoqzevN5BW4m29fW5
         cxUB7EnYrZsUmGT16xDhvqPCLZGJE4UNpwElnb2fFpDcNR8fOuBdTah77iJFEFiU4+P0
         Vfmv7CbEQAkBMvBfC80SG2WclrjsamDeUoAKX6i3PJ4PQ5D6+L1DvCeML+I/1h7XaOBL
         ZOQdND8xUBiDiJQTYqjiGzcczLjcpKLisPq0yopB0bl0Bz//5twgicUOPUVIS1axD9JV
         ZsAxbEjDdjrIBqQALGZEbHlLsDQErZQUMAOe6ysy+4mWq3YrwZdyanWjFctorLB8hdzT
         fcHw==
X-Gm-Message-State: AOAM5323Otk4UcNYtG3nnYLZ/u9DhA/SXOwmGeDYWuu+EXKDxA8+/5ab
	uqrfGeLhiHqzkBKv2uP1xF7v4jVUKpBP5s0jre0=
X-Google-Smtp-Source: ABdhPJyNhDbh7l9Eq6Kr4sznNsopKSUUUwqYZZvpDG6sJcRJ36rNj1FAuTUclvxi144PtzybqwI67m8St3cWkrUwb+o=
X-Received: by 2002:a17:907:216d:: with SMTP id rl13mr2838886ejb.362.1616472065991;
 Mon, 22 Mar 2021 21:01:05 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20210322162132.2471823-1-matthieu.baerts@tessares.net>
In-Reply-To: <20210322162132.2471823-1-matthieu.baerts@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 23 Mar 2021 12:00:54 +0800
Message-ID: <CA+WQbwsLSnoVm_L-34DmEqgBLNkZpVQSX3tkiSLSiFnNL1_9mw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 1/3] Squash to "mptcp: use mptcp_addr_info in mptcp_out_options"
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
Since the port number became big-endian now, use ntohs to convert it
before sending it out with the ADD_ADDR suboption. Also convert it
when passing it to add_addr_generate_hmac or printing it out.
---

Thanks.

-Geliang

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B43=E6=
=9C=8823=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8812:21=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Fix issues reported by sparse because we were doing non explicit casting
> from __be16 to u16.
>
>   net/mptcp/options.c:662:72: warning: incorrect type in argument 5 (diff=
erent base types)
>   net/mptcp/options.c:662:72:    expected unsigned short [usertype] port
>   net/mptcp/options.c:662:72:    got restricted __be16 [usertype] port
>   net/mptcp/options.c:673:73: warning: incorrect type in argument 5 (diff=
erent base types)
>   net/mptcp/options.c:673:73:    expected unsigned short [usertype] port
>   net/mptcp/options.c:673:73:    got restricted __be16 [usertype] port
>   net/mptcp/options.c:1244:62: warning: incorrect type in argument 1 (dif=
ferent base types)
>   net/mptcp/options.c:1244:62:    expected unsigned short [usertype] val
>   net/mptcp/options.c:1244:62:    got restricted __be16 [usertype] port
>   net/mptcp/options.c:1253:62: warning: restricted __be16 degrades to int=
eger
>
> Before the mentioned commit, we were using port in u16 in
> mptcp_out_options, everything was OK.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  net/mptcp/options.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 7e01f44ed885..03019a6d5059 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -659,7 +659,7 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
>                                                              msk->remote_=
key,
>                                                              opts->addr.i=
d,
>                                                              &opts->addr.=
addr,
> -                                                            opts->addr.p=
ort);
> +                                                            be16_to_cpu(=
opts->addr.port));
>                 }
>         }
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> @@ -670,7 +670,7 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
>                                                               msk->remote=
_key,
>                                                               opts->addr.=
id,
>                                                               &opts->addr=
.addr6,
> -                                                             opts->addr.=
port);
> +                                                             be16_to_cpu=
(opts->addr.port));
>                 }
>         }
>  #endif
> @@ -1238,10 +1238,12 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
>                                 ptr +=3D 2;
>                         }
>                 } else {
> +                       u16 port =3D be16_to_cpu(opts->addr.port);
> +
>                         if (opts->ahmac) {
>                                 u8 *bptr =3D (u8 *)ptr;
>
> -                               put_unaligned_be16(opts->addr.port, bptr)=
;
> +                               put_unaligned_be16(port, bptr);
>                                 bptr +=3D 2;
>                                 put_unaligned_be64(opts->ahmac, bptr);
>                                 bptr +=3D 8;
> @@ -1250,7 +1252,7 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
>
>                                 ptr +=3D 3;
>                         } else {
> -                               put_unaligned_be32(opts->addr.port << 16 =
|
> +                               put_unaligned_be32(port << 16 |
>                                                    TCPOPT_NOP << 8 |
>                                                    TCPOPT_NOP, ptr);
>                                 ptr +=3D 1;
> --
> 2.30.2
>
