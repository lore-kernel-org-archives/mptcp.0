Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1BE70
	for <mptcp@lists.linux.dev>; Wed,  4 Aug 2021 11:31:17 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso3111130pjo.1
        for <mptcp@lists.linux.dev>; Wed, 04 Aug 2021 04:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DadLYseGks/M/E+SukNuSK1sTS7XL1UZHJDvI6ex8d0=;
        b=TR3vPuo/wZi/H0qvEAbv4M5MSDVroVf4VKfSlD6HfgVmgfpLLUXacksKU8JlZGEnBT
         ca0J3ylglohz2ILf2eG+8w+r2aSe9j0WbEqwHMh6YfGhTaXFscm7rA0StByXTWmoN4lx
         KidoHMFfA+T6B3RGQ0hPfBMmALuji5On/OUt4lGc747Op7H2XX64YXHMyGt+0Cx4zR4M
         KF0E693h1k0umLu1rWdmtcUbBT06AAxKXBVJV2Bis7U3lDoLpgc3c3xXp45wb7mbiyz1
         jzWHs08qd1/gtfzsXu6FxGYpROWM4moEAhYmpXINFiFOJRHf6x27Gp1ltvwvK/lg6slr
         7oxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DadLYseGks/M/E+SukNuSK1sTS7XL1UZHJDvI6ex8d0=;
        b=CCULyo9Zg4Z9bqH1S2zIfVJU05v++4Fynb6y6/VlKhnhWBNT2aTSX/V+FS6LrVGCSz
         7ZtqAjjB9eM1mvAWV4NR68ShDS+Qlf4aESo+XiIm6CMpqqIBxsDl9YIAbVfs/YfmY/xY
         uOWF4a7JyY7lyBtXR1wuZFSEP5UHKi0SZ/EAa4avEu82KLLGVnbVu9y/REeYEg3/oJH2
         A6KPsUIbwSYTZlIBKmqKH0703J8lJ2zzp4xh2BOWOxCYJXFVg8GObZHVS40EkPF81b2S
         0+KeAEv5py5InjmAgqVEjV/MM6DZ+VWWwoXwhUP1PDy7ajBsuTInaFlnnRGIX5fROuqA
         8TcQ==
X-Gm-Message-State: AOAM531wjXeb2h5rrQu+eRZqnvT8nrRJvmxhKx2vLrwArwl+FsQqzUVU
	ulMxK8EEJuI5mkUsu3UGuKR9LW7ZhoC6EjF/F6k=
X-Google-Smtp-Source: ABdhPJxqV2Lg+TFhC7XQBy15r5TrEgsrk0MAE/6la0jhfxqLtDTuYWAdb9cv9j2571Q0F1HCbr2sky9kDQTnxumJ5rQ=
X-Received: by 2002:aa7:98c2:0:b029:3c2:fd63:2759 with SMTP id
 e2-20020aa798c20000b02903c2fd632759mr10913175pfm.58.1628076676868; Wed, 04
 Aug 2021 04:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20210804073710.681267-1-matthieu.baerts@tessares.net>
In-Reply-To: <20210804073710.681267-1-matthieu.baerts@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 4 Aug 2021 19:31:05 +0800
Message-ID: <CA+WQbwvhXX+T+tm2G9Jyi67Pd4sXDfhUn3dgKL_5eQ014tD8gw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: remote addresses fullmesh"
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, Jenkins Tessares <kernel-dev@tessares.net>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thanks for fixing this.

Acked-by: Geliang Tang <geliangtang@xiaomi.com>

-Geliang

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B48=E6=
=9C=884=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:37=E5=86=99=E9=81=93=
=EF=BC=9A
>
> This fixes 'unused-but-set-variable' warning.
>
> Jenkins Tessares reported [1] this error:
>
>   net/mptcp/pm_netlink.c: In function 'fill_remote_addresses_vec':
>   net/mptcp/pm_netlink.c:435:23: error: variable 'pernet' set but not  us=
ed [-Werror=3Dunused-but-set-variable]
>     435 |  struct pm_nl_pernet *pernet;
>         |                       ^~~~~~
>   cc1: all warnings being treated as errors
>
> Indeed, this variable is defined and set but not used. We can remove it.
>
> [1] https://github.com/multipath-tcp/mptcp_net-next/actions/runs/10965682=
75
>
> Reported-by: Jenkins Tessares <kernel-dev@tessares.net>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>
> Notes:
>     to be squashed in "mptcp: remote addresses fullmesh"
>
>  net/mptcp/pm_netlink.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index cbef50fff6e8..29ff454411b1 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -432,11 +432,9 @@ static unsigned int fill_remote_addresses_vec(struct=
 mptcp_sock *msk, bool fullm
>         struct sock *sk =3D (struct sock *)msk, *ssk;
>         struct mptcp_subflow_context *subflow;
>         struct mptcp_addr_info remote =3D { 0 };
> -       struct pm_nl_pernet *pernet;
>         unsigned int subflows_max;
>         int i =3D 0;
>
> -       pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
>         subflows_max =3D mptcp_pm_get_subflows_max(msk);
>
>         /* Non-fullmesh endpoint, fill in the single entry
> --
> 2.31.1
>
>
