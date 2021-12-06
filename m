Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD32C9E
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 07:56:17 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id o4so9370687pfp.13
        for <mptcp@lists.linux.dev>; Sun, 05 Dec 2021 23:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jQT+GngSD6HlyXmhS/omjadGSDae6kGX5qHeLiR971Y=;
        b=F5YoIbW4CrQ8r877gQvUjaJ8RU/YReJ6a0BBk38tnmzFtF+GSmlHKAKK1m4E1ACOCP
         PN2MHSlBKY5hkJ83aSGGY4ySqKeWyVWF2c/gHe8i8jmtHujlA9hHZNj+IXArUqmBKbkw
         03OAkrteFOii1CmyDROQjgsVIr5nTbU1cfegOOEDOw5brQBRUMJcnpejHyP8xEC09cOK
         NpOKyed5Bkv+EBEjxSFjk3Q2Xkj6Uri7CpuVvM8TjhWLVkq9SGSpvjp4BsKc7R4ZNFGS
         kT8H47O6TycvGy0fBqr5y95fUYBcrDB/GhHS5b31y8gzyKanPus/fnqqwlGNIPFxE/Ib
         rcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jQT+GngSD6HlyXmhS/omjadGSDae6kGX5qHeLiR971Y=;
        b=npVE/6Qo9pWkwwbqNCBcMwl5osIkVpTfMdaPtu1qTXH/GY3U4Hx8IJ4HZmNeU11YSY
         zrDvNTYSdOaLSQfSY/qUsTC1zM2zFNyyVKZZ0ce4FFYgWZ7UmJrmf2+TeIs6V37ps86J
         mGJA7cQy2vRM9edj6PEsBqImW8tml4N0wv9Vd478JrgWgHTPccfoSFCuq2cDypSZpWrh
         Y1H1OZ3sdlk2Ko7NuulST6yuMQsl6Eyuzk1fakK2LjisHPVYhDLAHjRT/Tbesc+CzEvv
         HT05+Ztk6U8ShEpHFbTFVmjo/bYWp1TqZ2JG7msSNLxrASonXkPMFtylIsYZ2Nc25MFD
         OZzg==
X-Gm-Message-State: AOAM5304RiJrH3Nkb6JaFU+/wnu2psuD7UPzDnK2iLZgw1WuDXjt/vgq
	/c799OicDtM69xtA/1HptEAcJi9ICU18yl/c3SM=
X-Google-Smtp-Source: ABdhPJxO5t2y7vOb+fiA6fVhTTK9gpUHF4w19nB8v8XGadGe6vAYGfVBj2w47swII4LwwhMwtD9csqllBy/zlM7zy20=
X-Received: by 2002:a63:903:: with SMTP id 3mr17706012pgj.356.1638777376908;
 Sun, 05 Dec 2021 23:56:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20211202005216.154787-1-mathew.j.martineau@linux.intel.com> <20211202005216.154787-6-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20211202005216.154787-6-mathew.j.martineau@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 6 Dec 2021 15:56:10 +0800
Message-ID: <CA+WQbwuwfq0E-JQj_7cDf0R+NuMJ44uq+_6VYVceAfrwjYA8BQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2 5/6] mptcp: Add a per-namespace sysctl to
 set the default path manager type
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=B412=
=E6=9C=882=E6=97=A5=E5=91=A8=E5=9B=9B 08:52=E5=86=99=E9=81=93=EF=BC=9A
>
> The new net.mptcp.pm_type sysctl determines which path manager will be
> used by each newly-created MPTCP socket.
>
> v2: Handle builds without CONFIG_SYSCTL
>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  Documentation/networking/mptcp-sysctl.rst | 18 ++++++++++++++++++
>  net/mptcp/ctrl.c                          | 21 +++++++++++++++++++++
>  net/mptcp/pm.c                            | 13 +++++++++----
>  net/mptcp/protocol.h                      |  1 +
>  4 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/ne=
tworking/mptcp-sysctl.rst
> index b0d4da71e68e..e263dfcc4b40 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -46,6 +46,24 @@ allow_join_initial_addr_port - BOOLEAN
>
>         Default: 1
>
> +pm_type - INTEGER
> +
> +       Set the default path manager type to use for each new MPTCP
> +       socket. In-kernel path management will control subflow
> +       connections and address advertisements according to
> +       per-namespace values configured over the MPTCP netlink
> +       API. Userspace path management puts per-MPTCP-connection subflow
> +       connection decisions and address advertisements under control of
> +       a privileged userspace program, at the cost of more netlink
> +       traffic to propagate all of the related events and commands.
> +
> +       This is a per-namespace sysctl.
> +
> +       * 0 - In-kernel path manager
> +       * 1 - Userspace path manager
> +
> +       Default: 0
> +
>  stale_loss_cnt - INTEGER
>         The number of MPTCP-level retransmission intervals with no traffi=
c and
>         pending outstanding data on a given subflow required to declare i=
t stale.
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 8b235468c88f..ae20b7d92e28 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -16,6 +16,11 @@
>  #define MPTCP_SYSCTL_PATH "net/mptcp"
>
>  static int mptcp_pernet_id;
> +
> +#ifdef CONFIG_SYSCTL
> +static int mptcp_pm_type_max =3D __MPTCP_PM_TYPE_MAX;
> +#endif
> +
>  struct mptcp_pernet {
>  #ifdef CONFIG_SYSCTL
>         struct ctl_table_header *ctl_table_hdr;
> @@ -26,6 +31,7 @@ struct mptcp_pernet {
>         u8 mptcp_enabled;
>         u8 checksum_enabled;
>         u8 allow_join_initial_addr_port;
> +       u8 pm_type;
>  };
>
>  static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
> @@ -58,6 +64,11 @@ unsigned int mptcp_stale_loss_cnt(const struct net *ne=
t)
>         return mptcp_get_pernet(net)->stale_loss_cnt;
>  }
>
> +int mptcp_get_pm_type(const struct net *net)
> +{
> +       return mptcp_get_pernet(net)->pm_type;
> +}
> +
>  static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>  {
>         pernet->mptcp_enabled =3D 1;
> @@ -65,6 +76,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pern=
et *pernet)
>         pernet->checksum_enabled =3D 0;
>         pernet->allow_join_initial_addr_port =3D 1;
>         pernet->stale_loss_cnt =3D 4;
> +       pernet->pm_type =3D MPTCP_PM_TYPE_KERNEL;
>  }
>
>  #ifdef CONFIG_SYSCTL
> @@ -108,6 +120,14 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
>                 .mode =3D 0644,
>                 .proc_handler =3D proc_douintvec_minmax,
>         },
> +       {
> +               .procname =3D "pm_type",
> +               .maxlen =3D sizeof(u8),
> +               .mode =3D 0644,
> +               .proc_handler =3D proc_dou8vec_minmax,
> +               .extra1       =3D SYSCTL_ZERO,
> +               .extra2       =3D &mptcp_pm_type_max
> +       },
>         {}
>  };
>
> @@ -128,6 +148,7 @@ static int mptcp_pernet_new_table(struct net *net, st=
ruct mptcp_pernet *pernet)
>         table[2].data =3D &pernet->checksum_enabled;
>         table[3].data =3D &pernet->allow_join_initial_addr_port;
>         table[4].data =3D &pernet->stale_loss_cnt;
> +       table[5].data =3D &pernet->pm_type;
>
>         hdr =3D register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
>         if (!hdr)
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 451948b11030..f1fc08d89c20 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -365,8 +365,12 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_s=
ock *msk, struct sock *ssk)
>
>  void mptcp_pm_data_reset(struct mptcp_sock *msk)
>  {
> -       bool subflows_allowed =3D !!mptcp_pm_get_subflows_max(msk);
> +       u8 pm_type =3D mptcp_get_pm_type(sock_net((struct sock *)msk));
>         struct mptcp_pm_data *pm =3D &msk->pm;
> +       bool subflows_allowed;
> +
> +       subflows_allowed =3D !!mptcp_pm_get_subflows_max(msk) &&
> +               pm_type =3D=3D MPTCP_PM_TYPE_KERNEL;
>
>         pm->add_addr_signaled =3D 0;
>         pm->add_addr_accepted =3D 0;
> @@ -374,13 +378,14 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
>         pm->subflows =3D 0;
>         pm->rm_list_tx.nr =3D 0;
>         pm->rm_list_rx.nr =3D 0;
> -       WRITE_ONCE(pm->pm_type, MPTCP_PM_TYPE_KERNEL);
> +       WRITE_ONCE(pm->pm_type, pm_type);
>         /* pm->work_pending must be only be set to 'true' when
>          * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
>          */
>         WRITE_ONCE(pm->work_pending,
> -                  (!!mptcp_pm_get_local_addr_max(msk) && subflows_allowe=
d) ||
> -                  !!mptcp_pm_get_add_addr_signal_max(msk));
> +                  pm_type =3D=3D MPTCP_PM_TYPE_KERNEL &&
> +                  ((!!mptcp_pm_get_local_addr_max(msk) && subflows_allow=
ed) ||
> +                   !!mptcp_pm_get_add_addr_signal_max(msk)));

I think pm_type =3D=3D MPTCP_PM_TYPE_KERNEL is somehow duplicate here, how
about use this code instead:

        WRITE_ONCE(pm->work_pending,
                   (!!mptcp_pm_get_local_addr_max(msk) && subflows_allowed)=
 ||
                   (!!mptcp_pm_get_add_addr_signal_max(msk) && pm_type
=3D=3D MPTCP_PM_TYPE_KERNEL));

Thanks,
-Geliang

>         WRITE_ONCE(pm->addr_signal, 0);
>         WRITE_ONCE(pm->accept_addr,
>                    !!mptcp_pm_get_add_addr_accept_max(msk) && subflows_al=
lowed);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 478abe18b9e9..e4c2b39b029c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -579,6 +579,7 @@ unsigned int mptcp_get_add_addr_timeout(const struct =
net *net);
>  int mptcp_is_checksum_enabled(const struct net *net);
>  int mptcp_allow_join_id0(const struct net *net);
>  unsigned int mptcp_stale_loss_cnt(const struct net *net);
> +int mptcp_get_pm_type(const struct net *net);
>  void mptcp_subflow_fully_established(struct mptcp_subflow_context *subfl=
ow,
>                                      struct mptcp_options_received *mp_op=
t);
>  bool __mptcp_retransmit_pending_data(struct sock *sk);
> --
> 2.34.1
>
>
