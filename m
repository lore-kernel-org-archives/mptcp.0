Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C7C29CA
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 04:34:01 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id h20so24636650plr.4
        for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 21:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g4CaEyluxm62JNXXB2psqWmTruHCEitfPz5fn25YENM=;
        b=AGdVWRvmixjZIXrABgMdLxkqKz6RSQBoDvL4IH18xMttgdYP8J/JxEYHZWItwEg0yr
         IEWg018T1jrOil3ciGXxAyQrSG2e9dmZkzXWptWXMDvN0bT+2a2vbVhL7afkNanzOXFY
         EogmUpo7w7UyuveGjVNtx/P0s1YetTl9KApHVCslNIcKNNhPlqPzG9JzZOUvqF4/oYH2
         DkXxrRc+5So5FQEYkN9A5orj9dHP4xXudxnzPayQSRUkGJ9TPGeRtR2HaT04N2hZHn0c
         ELmUkQ0A+3N8GMsI28W4/wa0ZfqbNbe1+PEuBRizpL3sidmw78lpxUqL23G8ZpBxoxrd
         f7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g4CaEyluxm62JNXXB2psqWmTruHCEitfPz5fn25YENM=;
        b=MBXEz3dreZzT+CgeKOEONSETIydFr2GJAdUjp5/YhVBCxhbsDxJ5fLCRddtIAS5YUT
         a/4GArfTemEYf+0dl5MYltzk+xkWURniuHqugeyUTaJCGJWNtfuTB08Gck9CnWfmjpwX
         q4zte29xTo1g20hVbPYwFLU0qz5zpgB4szMCM3c8cVgpcfvwziOh5q68oyHKLuzA3Nlx
         5HbxdoYVJKN0UFXACk8MQ/HgMDH9eqZVFMVbPCmyOljn76U8RWVusCBjuRJVKWdHc804
         07BLS9+OdVzKdl6JmyvMkPnk5lmhp2b2WbxtozEvDo0r9/NdAwOHJ9vl9jmeBvMA8nUn
         2RMw==
X-Gm-Message-State: AOAM532tUze3Ukb2x30jTfDiWRG5CDqIpxKapdFYlpQUadGd0J6a0Xpo
	fuQXR2g7fKpGmy0LCVpX5hVrrbMrSvT72JwIbo96AlFWUJ0=
X-Google-Smtp-Source: ABdhPJzOf70JwwmR33xrHx9VTXEBr07BJeIvNd7OUQK6A6V4QtAmBv5BjtH5Tg3/BxBZ+8MYYD5PGXdW91gNpUAf+zg=
X-Received: by 2002:a17:90b:180b:: with SMTP id lw11mr3673859pjb.6.1619152441040;
 Thu, 22 Apr 2021 21:34:01 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <bbe531db-6d59-d341-16ed-f48b1fd43d2a@163.com>
In-Reply-To: <bbe531db-6d59-d341-16ed-f48b1fd43d2a@163.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 23 Apr 2021 12:33:49 +0800
Message-ID: <CA+WQbwvpviu3FAE06bO3CO2azAegzMi8YUXcQPPMBYM8nW7_cg@mail.gmail.com>
Subject: Re: [PATCH] mptcp: create listening socket only if signal flag is set on
To: Jianguo Wu <wujianguo106@163.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jianguo,

Thanks for your patch.

Jianguo Wu <wujianguo106@163.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8822=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:30=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>
> PM announces address to remote host when signal flag is set,
> so create listening socket only if signal flag is set.

This check has done in the user-space, here are these lines in pm_nl_ctl.c:

274                 } else if (!strcmp(argv[arg], "port")) {
275                         u_int16_t port;
276
277                         if (++arg >=3D argc)
278                                 error(1, 0, " missing port value");
279                         if (!(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
280                                 error(1, 0, " flags must be signal
when using port");

-Geliang

>
> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
>  net/mptcp/pm_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index becc32b..dbd6910 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1025,7 +1025,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *sk=
b, struct genl_info *info)
>         }
>
>         *entry =3D addr;
> -       if (entry->addr.port) {
> +       if (entry->addr.port && (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL=
)) {
>                 ret =3D mptcp_pm_nl_create_listen_socket(skb->sk, entry);
>                 if (ret) {
>                         GENL_SET_ERR_MSG(info, "create listen socket erro=
r");
> --
> 1.8.3.1
>
>
