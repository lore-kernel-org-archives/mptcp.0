Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E42372
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 03:10:16 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so757162pjo.3
        for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 20:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5INmK1afJ2peKmPGWp7RJXeuE+2njHlFeXTESgBTE3w=;
        b=uuiuX9WheDKw9dlRpj2ts0NMnPivgOspmGHDKzuk9rBftrnPrDbBGIcxlzXOrzLpdR
         cwP4k15DDP6PYwiuTeO71kk2YH0tAxf8vIMO22SPxSwTbgKhcOeBSkJIyeEhuCJWWXdw
         08pK6VaWzHU3VCdH7W/2uubDRk/xxbIf0dlBteG6Zvb13z1ItC2If+UW4zCw69PgqI6Q
         zMqXHm/usYDjEsURgEghFjuCqAAbVWzOgKtlqAdnp+cRZlWOB1rndvJQHz3h68I23WFF
         CBMi+f4nm1jGj4x6Gi3HJjZ9Rm5tL+xMk4NXrvxCXhc42Fr34l0Mlu5Tcdl09dZYaGu7
         brkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5INmK1afJ2peKmPGWp7RJXeuE+2njHlFeXTESgBTE3w=;
        b=lYcTPmFFi9LLt8nXs9CEmYfiQCt9Qm7jRNUDk/1NYpU70d963O9/B/Vi2Ht1G+THmw
         Ke0HkHvaCCRjE2e9a0X2omdwJRAOp7bSL+mlKLVvZfE2pBNktf4EHf5x1F4sEjL5Miot
         5ZuhhfdM3F2MJfO/MdPFeC+de43Nd7+ESQdUSGg+vNl9mJB8FkZb04moUuf9Lxj+GL6u
         pSYYhaHVXEgexFTKhhkYtABJNY92K07S2IJ2nhW7BzD4/eabkHdgkCMsMu/7f5tRmGLE
         rzQiox05xy02a/rOXxQDZY7/UdtFqpQMSuPPVxZPWkufbfXpRZgSdjbbFcjVa5dA397C
         bOVQ==
X-Gm-Message-State: AOAM533oL1hY5UoOWt4QSkSUF0G4NHJdP7VsFrKjHgcM462qySg9ZhPV
	QRxYwQaWOlWPYLIQSrmWKdK72aS1oNX5etW6gJQ=
X-Google-Smtp-Source: ABdhPJwMsQH673frOho8yx8OYZwemGFh/lGvlwSXXGOMbPMaUpS+Pq6Rik8osuNHAo1JFrCb34H1Es48f1MvYq4COuY=
X-Received: by 2002:a17:90a:7843:: with SMTP id y3mr7452305pjl.190.1626232215735;
 Tue, 13 Jul 2021 20:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <756dcceaa255c54b7bd195c719ede1f7ae791eb3.1626158100.git.geliangtang@gmail.com>
 <7eaa18f3391aa9862bb8274f6288ed1888af8f72.1626158161.git.geliangtang@gmail.com>
 <1e219d3d-9ea5-26ec-ae2c-dac4563bd345@chinatelecom.cn>
In-Reply-To: <1e219d3d-9ea5-26ec-ae2c-dac4563bd345@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 14 Jul 2021 11:10:04 +0800
Message-ID: <CA+WQbwtK0expftc6LPrLY701iippBZ3f7EMoTKR=WTu5p1qxjg@mail.gmail.com>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: remove
 MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT"
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yonglong,

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B47=E6=9C=8813=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:30=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
>
> On 2021/7/13 14:44, Geliang Tang wrote:
> > Keep the debug info for "send ack".
> >
> > Don't drop mptcp_pm_should_add_signal_ipv6() and
> > mptcp_pm_should_add_signal_port().
> >
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > ---
> >  net/mptcp/pm_netlink.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 3e35720317ae..2cd6caaedb08 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -543,8 +543,11 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *=
msk)
> >               bool slow;
> >
> >               spin_unlock_bh(&msk->pm.lock);
> > -             pr_debug("send ack for %s",
> > -                      mptcp_pm_should_add_signal(msk) ? "add_addr" : "=
rm_addr");
> > +             pr_debug("send ack for %s%s%s",
> > +                      mptcp_pm_should_add_signal_addr(msk) ? "add_addr=
" :
> > +                      (mptcp_pm_should_add_signal_echo(msk) ? "add_ech=
o" : "rm_addr"),
> > +                      mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6]"=
 : "",
> > +                      mptcp_pm_should_add_signal_port(msk) ? " [port]"=
 : "");
> >
> >               slow =3D lock_sock_fast(ssk);
> >               tcp_send_ack(ssk);
> >
> Hi Geliang,
>
> I think the debug log will be incorrect if add_addr and add_echo events t=
rigger at the same time.
> WDYT?

Yes, how about moving this pr_debug line under the pm lock, just swap this
pr_debug line with the spin_unlock_bh line?

If so, no need to use READ_ONCE() in mptcp_pm_should_add_signal_ipv6/port
too.


I had tested this squash-to patches all night yesterday. And I got this
error in the debug log:

add_signal error, add_addr=3D2, echo=3D1

This means the race occurs, right?

Does it mean that this version cannot deal with the race either? I'm not
sure.

Could you please share your test scripts to me?

Thanks,
-Geliang



>
> --
> Li YongLong
