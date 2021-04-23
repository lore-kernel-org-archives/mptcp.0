Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A0871
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 10:15:49 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id t22so24677520ply.1
        for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 03:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nZwNDemqEO8gwFaXrQ0HQ+cdIVnh9KyiZJVSmV/XqMQ=;
        b=pIZGyZzvLtnNhW1mIZ2Po13pxTgVFj1jWNgxn1WWD3jPM3IaARx0e1aDQuiQbjd1ic
         AoxOkXNfg5gqJNMKbQN5jlm3Kqa6Jt4FnvZmI+ogR58ZrK6ln767ICHQVbmAku0PuJRH
         XrB1s5rRl2G5cOsIOSypchxLiyPZDzit+N52Nc5uNuPAGr63mu7TcquSy9GS0CQon9sq
         oBuYZst+B7/YG+jySa2D5iYqGzXZtVsnhniygAleuLgWiNi6D5O6ZzyLrPsmIafbzSmg
         MQNO22180I5GkDIUQNzEM13Qekam1j6mkXj0mqByQxzHGdG8zM4xXFMDOGwIich9ysOq
         tKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nZwNDemqEO8gwFaXrQ0HQ+cdIVnh9KyiZJVSmV/XqMQ=;
        b=ggoCesbvm8MwP6NIfjSrfZjlwOYOYh2h9Kl8Qy3ifDPiOD1umsDbMP8/6+NiqlCo8S
         6rz2QIDTZrlaazpq9oeYsm0osAt8r85yZl8OU/a/svQuRPTKXGv9PIUABLVY23Eo2+mb
         qqBB5oLUsjbz7JtfGyl3+5PkC3hQHFIn8DGZXHfhNI1DrJQgAiOLIYkAGlnFNhWLIzI5
         JAUhFs2o97z0jDvTd9oV8xAG8r/gw++doXk+CTC4tt6h8RD9jbBlTkkRy5BQ2q9763NM
         1u2JZV1sYGSowWiFPrKEEUzJpz1yylK1L7Si61LSfE6Vk2lWc8BvHaZGwpACmvLV2KLL
         mUQQ==
X-Gm-Message-State: AOAM531j+6wrRTlmpQ0VqUSt8QBAyU41RFMs5/Hp4tvIclrvLcO2kjvR
	oY9DquaE9YLSNWgtBwkZQCguL8NswpDgPJlMC2c=
X-Google-Smtp-Source: ABdhPJwSHmkAUpwarVgOhjdONYwzF7vHcJFJAKyrrNsED0kjTab78hX9kAYQqB3y4BG5bjg3bLJp9Q9ov27SxuZVmGo=
X-Received: by 2002:a17:90a:f3d1:: with SMTP id ha17mr5069521pjb.123.1619172949327;
 Fri, 23 Apr 2021 03:15:49 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0d970926-7dfa-d518-50ae-0d4ed4db9706@163.com>
In-Reply-To: <0d970926-7dfa-d518-50ae-0d4ed4db9706@163.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 23 Apr 2021 18:15:38 +0800
Message-ID: <CA+WQbwsgOi9qNHXtnSNemYdir8oCAovpwqi+dfHLvAg2BKZMCg@mail.gmail.com>
Subject: Re: [PATCH] mptcp: make sure flag signal is set when add addr with port
To: Jianguo Wu <wujianguo106@163.com>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jianguo,

Jianguo Wu <wujianguo106@163.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:12=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>
> When add address with port, it is mean to create a listening socket,
> and send an ADD_ADDR to remote, so it must have flag signal set,
> add this check in mptcp_pm_parse_addr().
>
> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")

Fixes this one:

a77e9179c7651 ("mptcp: deal with MPTCP_PM_ADDR_ATTR_PORT in PM netlink")

> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
>  net/mptcp/pm_netlink.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index becc32b..90bba32 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -971,8 +971,14 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, =
struct genl_info *info,
>         if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
>                 entry->flags =3D nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]=
);
>
> -       if (tb[MPTCP_PM_ADDR_ATTR_PORT])
> +       if (tb[MPTCP_PM_ADDR_ATTR_PORT]) {
> +               if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
> +                       NL_SET_ERR_MSG_ATTR(info->extack, attr,
> +                                           "flags must have signal when =
using port");
> +                       return -EINVAL;
> +               }
>                 entry->addr.port =3D htons(nla_get_u16(tb[MPTCP_PM_ADDR_A=
TTR_PORT]));
> +       }
>
>         return 0;
>  }
> --
> 1.8.3.1
>
>
