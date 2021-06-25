Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8A177
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 10:02:06 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id c7-20020a17090ad907b029016faeeab0ccso7668358pjv.4
        for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pGv6RKhxQnw/hGMRrk/dP3dYhF21XbZbExqYr+dDo2M=;
        b=PcVt2Q7dJgu61cQY8g755AArnkxueb12V4ZXn53Rmx49p7rwuVf7D/k1vjOUPNt7mS
         OUXDlNutEbajfCgbcmlz7vXxlklJqzsVh7cLKCGpcZmDuZDPtPCXsJ8DoHz4py9kVjji
         PqqAZZAD4A3u7dCqB5jJKOFV3SpJ/yPXcQBaUk2GFzk0mxIuGLTjAyR3BTyRvMcuR76g
         qQ8WBDoAg2o2xzZto3UXdu7zaHJLCKEGQLbdC5J+5YCIHY/zmqu2iQWZeZI9y9yNpeIO
         kHXnA1YvfB2qPlHUGv9ndKZgE+SYO4xmfS5LPb40c/9pg+VV2dbu3arMTB9V2tHY5nam
         Fk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pGv6RKhxQnw/hGMRrk/dP3dYhF21XbZbExqYr+dDo2M=;
        b=cju1XuFDayLBQjO14gxLS2BLhOjyX60WeBe5ekS2MHufg9bEI2ZFj09t2D/JM7HVjc
         68jpt3UP5TKa3ysbkqwop9gMZAPtTUPHd+pAI6p9/5Zo/YyH3judChSTAlP9+uh1brWT
         DzQUrRg5M5xViTztF5hxPTJNz7hBUzxQKEFvuSKqcD3cUFl8UZROslqekNKuFHGu8RFA
         JZtsDZN8IQXAP9u5QZzgaUiEXt0jCt9w3nsS2TMYf2reOzVk5sYyE9zR1RB7KRCwp9xN
         /lmeMTJXNdyXUOMewqtW+cRTmL6u/Ajk5pCI+82bMwIlbV1Wa0icU9D9SDor1W3Adw0e
         zfNA==
X-Gm-Message-State: AOAM530B13/OuedOP2tnMNH6fhIEvLjC5z3EkcNFheLJ5Ro/hhSFAvWU
	n44i1Ej8m7nYfIYYZiy1fFD2JWRade3o9Ud/CkA=
X-Google-Smtp-Source: ABdhPJzWnJI3ujQeSn6yGtur/knLq86kGQuHo0qUsB1FlurtPvoO05D9S0g55snbI0yB5MxITyqAqjF5H4DAtR59Y24=
X-Received: by 2002:a17:90b:3449:: with SMTP id lj9mr20889199pjb.123.1624615326033;
 Fri, 25 Jun 2021 03:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1624337135-149084-1-git-send-email-liyonglong@chinatelecom.cn> <1624337135-149084-5-git-send-email-liyonglong@chinatelecom.cn>
In-Reply-To: <1624337135-149084-5-git-send-email-liyonglong@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 25 Jun 2021 18:01:54 +0800
Message-ID: <CA+WQbwvEu+7BUyumARc57QLcye5sYdzZxavSq72-BFCfzy9Jaw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mptcp: remove MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=8822=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8812:46=E5=86=99=E9=81=93=EF=BC=
=9A
>
> there not need MPTCP_ADD_ADDR_PORT and MPTCP_ADD_ADDR_PORT, we can
> get these info from pm.addr or pm.remote

There's no pm.addr, do you mean pm.local?


>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  net/mptcp/pm.c         |  4 ----
>  net/mptcp/pm_netlink.c |  6 ++----
>  net/mptcp/protocol.h   | 12 ------------
>  3 files changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index a62d4a5..f051e48 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -35,10 +35,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>                 msk->pm.local =3D *addr;
>                 add_addr |=3D BIT(MPTCP_ADD_ADDR_SIGNAL);
>         }
> -       if (addr->family =3D=3D AF_INET6)
> -               add_addr |=3D BIT(MPTCP_ADD_ADDR_IPV6);
> -       if (addr->port)
> -               add_addr |=3D BIT(MPTCP_ADD_ADDR_PORT);
>         WRITE_ONCE(msk->pm.addr_signal, add_addr);
>         return 0;
>  }
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 0f302d2..bfa9d6d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -543,10 +543,8 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *ms=
k)
>                 bool slow;
>
>                 spin_unlock_bh(&msk->pm.lock);
> -               pr_debug("send ack for %s%s%s",
> -                        mptcp_pm_should_add_signal(msk) ? "add_addr" : "=
rm_addr",
> -                        mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6]"=
 : "",
> -                        mptcp_pm_should_add_signal_port(msk) ? " [port]"=
 : "");
> +               pr_debug("send ack for %s",
> +                        mptcp_pm_should_add_signal(msk) ? "add_addr" : "=
rm_addr");
>
>                 slow =3D lock_sock_fast(ssk);
>                 tcp_send_ack(ssk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 90fb532..71e747c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -176,8 +176,6 @@ enum mptcp_pm_status {
>  enum mptcp_addr_signal_status {
>         MPTCP_ADD_ADDR_SIGNAL,
>         MPTCP_ADD_ADDR_ECHO,
> -       MPTCP_ADD_ADDR_IPV6,
> -       MPTCP_ADD_ADDR_PORT,
>         MPTCP_RM_ADDR_SIGNAL,
>  };
>
> @@ -723,16 +721,6 @@ static inline bool mptcp_pm_should_add_signal_echo(s=
truct mptcp_sock *msk)
>         return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_ECHO);
>  }
>
> -static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *ms=
k)
> -{
> -       return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6);
> -}
> -
> -static inline bool mptcp_pm_should_add_signal_port(struct mptcp_sock *ms=
k)
> -{
> -       return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_PORT);
> -}
> -
>  static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
>  {
>         return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL)=
;
> --
> 1.8.3.1
>
