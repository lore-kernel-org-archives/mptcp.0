Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C8510F3
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 01:03:55 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id d15so320207pll.10
        for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 18:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RKE6JOX6lmKR4yZOA7ql4+jl1Q0XaF9+SbUYu/NrjCc=;
        b=klFazsZh26h++FTmlJg7XD2QP/nZUjV1BXyUDYV9Tf92bbDREKCwR9GdiyzblEvDIe
         PlCpIC1tUE+XmpJBqUOVkhUBEZjsxcIlCJdSUH0uT9R2LKK/oSe1eLSWzr9Z4UsaS6ID
         LNrTtyZH+sfRWy1cI69WHwgWLL4QVdQ+HrmhvgTs1rsxZ28OWZIArSeH6mhp5F0wV8r9
         CohVcU3B0jVhpslQsXxn9vFZmYirmkGwO6eqPyc3rXML4s+mQ3s6JdCEj5QpRnOjjjoP
         /hVStSsFFbb/g/pICMcELxhbZ85tC/t1QFPcu1H6LmYxfEK7yZuY4fqmSRzYns+DmxzS
         jxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RKE6JOX6lmKR4yZOA7ql4+jl1Q0XaF9+SbUYu/NrjCc=;
        b=JLhIWeqiK5p+qAiVgau3TWWL6Q+Pr3zlkkuFQop/YJc27iwy3BFbtgFsu9rOBGrLVo
         rm8xPUwE/YgD241KzbxTj3Mp2zcD+Nf+cJRSY3gKuO6BWxSxL2BC246AKc9MdpqvrTmr
         UBww8UabTrUic3Ih/p9EhmgpukhmRUEIDQiVVPnb31PjBdPhbmJMrxsNyCoGqszOF8D8
         nR70lTjx9xryJDcEe1YM58WJk5rUcfe5IAXEUxCPrUQA4k81t7d6MqVC0tmwgiR7LFiw
         lmOtCJWEYRNZLLlUBnqVZS6Bod1oOCV1JttcBa/36fXpQzpUmST5fahhh3NGTuHZlJDF
         90Cg==
X-Gm-Message-State: AOAM531iAtzXdpsdQzn1RxbCJwTbNa+Kj3ZZ6L1Iv4MJDd/2m9Xf8PGO
	bOKVoRSxPdK8uBki5uquu9HEW0wbm0ovDM22Aog=
X-Google-Smtp-Source: ABdhPJxexQVrAKJsLdE0LN+k9MHogOdu79qLznkudbsIT8ZRbZrvDeXqcDtekP1ayJxgszanbe+OwBVSjQuEcxwJxRk=
X-Received: by 2002:a17:902:d488:b0:158:e7d1:fc16 with SMTP id
 c8-20020a170902d48800b00158e7d1fc16mr18196112plg.171.1650416634443; Tue, 19
 Apr 2022 18:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220419230340.2263545-1-kishen.maloor@intel.com> <20220419230340.2263545-2-kishen.maloor@intel.com>
In-Reply-To: <20220419230340.2263545-2-kishen.maloor@intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 20 Apr 2022 09:04:10 +0800
Message-ID: <CA+WQbwsQ-R95+GjEnBG-bJukLbiXuzjozOe5kCJQaON6gQfu8g@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 1/3] Squash-to: mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kishen,

Kishen Maloor <kishen.maloor@intel.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=B8=89 07:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  net/mptcp/pm_userspace.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index fce61530fe9e..fca3e4bdf5d4 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -127,11 +127,11 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, stru=
ct genl_info *info)
>         struct mptcp_pm_addr_entry addr_val;
>         struct mptcp_sock *msk;
>         u32 token_val;
> -       int err;
> +       int err =3D -EINVAL;

This breaks the "reversed XMas tree" order.

Thanks,
-Geliang

>
>         if (!addr || !token) {
>                 GENL_SET_ERR_MSG(info, "missing required inputs");
> -               return -EINVAL;
> +               return err;
>         }
>
>         token_val =3D nla_get_u32(token);
> @@ -139,29 +139,29 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, stru=
ct genl_info *info)
>         msk =3D mptcp_token_get_sock(sock_net(skb->sk), token_val);
>         if (!msk) {
>                 NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token")=
;
> -               return -EINVAL;
> +               return err;
>         }
>
>         if (!mptcp_pm_is_userspace(msk)) {
>                 GENL_SET_ERR_MSG(info, "invalid request; userspace PM not=
 selected");
> -               return -EINVAL;
> +               goto announce_err;
>         }
>
>         err =3D mptcp_pm_parse_entry(addr, info, true, &addr_val);
>         if (err < 0) {
>                 GENL_SET_ERR_MSG(info, "error parsing local address");
> -               return err;
> +               goto announce_err;
>         }
>
>         if (addr_val.addr.id =3D=3D 0 || !(addr_val.flags & MPTCP_PM_ADDR=
_FLAG_SIGNAL)) {
>                 GENL_SET_ERR_MSG(info, "invalid addr id or flags");
> -               return -EINVAL;
> +               goto announce_err;
>         }
>
>         err =3D mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
>         if (err < 0) {
>                 GENL_SET_ERR_MSG(info, "did not match address and id");
> -               return err;
> +               goto announce_err;
>         }
>
>         lock_sock((struct sock *)msk);
> @@ -175,7 +175,10 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struc=
t genl_info *info)
>         spin_unlock_bh(&msk->pm.lock);
>         release_sock((struct sock *)msk);
>
> -       return 0;
> +       err =3D 0;
> + announce_err:
> +       sock_put((struct sock *)msk);
> +       return err;
>  }
>
>  int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
> --
> 2.31.1
>
>
