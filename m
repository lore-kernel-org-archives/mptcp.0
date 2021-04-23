Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB14A71
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 10:28:46 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id w6so19255863pfc.8
        for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 03:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yDoiOlV9MJeZnHdXY5UOiOOGtCUDABtuo/u3ndijJbs=;
        b=BlscbE3gCCZwFATQw4A6E/nEMo/StjhHt3P12h4CUv3gGms8WTretkIz0lK1V0bV4B
         lDu0+yGY5GNSp29rbhVFmprNErMNc/ANFf5AjBn4ZyghMeedHMfXshVBqwCaEIgy/Baq
         yEkcKkE3/FM9n0KQM9sL6JZyhicESfB18Tqmw0NPsnCFwx5TCQ+Im7EdkxlUFvhptdvf
         s0xjQd3vCxOv/8j6ePSBB5Ka2h5tnVjKSB4sCA88W16kuZxtlw7t2hksfxrVUTlqwQe4
         Htl222YbjwU6jTOWwKWHkCgyaahvBiyOIcWFETJO4AbtjRSMNszXSa9DVkwzqsq1iMs/
         8+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yDoiOlV9MJeZnHdXY5UOiOOGtCUDABtuo/u3ndijJbs=;
        b=b1XKf3GG1KA6UbwifZ9qAkyPK/cEgJlnEdwCAvUqmfH0LAny5org4DkBqhS5lFTniV
         k2GgEWFRCj5eWaipoBU0oQ6stPKpuRWSvwnuPEjjouyTBcDkt8CK0tWyVmpkuBlVFbKf
         7rkTj/gW0GkZRhjqmYd3/cnStmDS2EtJ4ZzP/QV9La7TXvKePcMPkm2ZeUQ47+s6crn+
         dkHI8KgoZpWJGbplj9HswIX0YKKz+v3bkTQFBeHGjW8hGAmFLzBPX8k7a1LWhi28AB68
         TaN4n+lIAXydkLh+oGstIpJDufFAw2mc3RZEMCIc+9w9EOC6bViQ0gTDK0Ebk8ZLLBR7
         5hzA==
X-Gm-Message-State: AOAM532XFcx6POH0lbcQrDmW5RxN002HSuTUFmEJPA8WCDJhoHS69TUz
	UbpkXgqJ7+9NkI214M/44ijFBSC9Xcu7yXD8Xw0=
X-Google-Smtp-Source: ABdhPJwCReObGuUl6KfWtY2+rUiutmDBUX+bB5LxkD3OFAvshO4NFZHMf47TB7tkYtywPVzbCInTirjDakPDKJCH70c=
X-Received: by 2002:a65:6282:: with SMTP id f2mr3020966pgv.289.1619173726498;
 Fri, 23 Apr 2021 03:28:46 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <c388d556-530c-ee11-3ab1-a8019fb2eb6f@163.com>
In-Reply-To: <c388d556-530c-ee11-3ab1-a8019fb2eb6f@163.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 23 Apr 2021 18:28:35 +0800
Message-ID: <CA+WQbws5Ehw0BvLoQqT145icXKGTOBMqLUnNdd9qWNkBzU29Ew@mail.gmail.com>
Subject: Re: [PATCH v2] mptcp: make sure flag signal is set when add addr with port
To: Jianguo Wu <wujianguo106@163.com>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jianguo,

Jianguo Wu <wujianguo106@163.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:26=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>
> When add address with port, it is mean to create a listening socket,
> and send an ADD_ADDR to remote, so it must have flag signal set,
> add this check in mptcp_pm_parse_addr().
>
> Fixes: a77e9179c7651 ("mptcp: deal with MPTCP_PM_ADDR_ATTR_PORT in PM net=
link")
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

LGTM.

Acked-by: Geliang Tang <geliangtang@gmail.com>

-Geliang

> --
> 1.8.3.1
>
>
