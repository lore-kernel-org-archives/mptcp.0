Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24F2C9E
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 07:44:55 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id k4so9632656pgb.8
        for <mptcp@lists.linux.dev>; Sun, 05 Dec 2021 23:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bf90JyY17mz0lDe1G2c1xsgh5si5CPXlMga6Msc5ALc=;
        b=q2r8qmmtH0y5iKWSD1iayhXSgsuwsbReQ4AOGDkTP6VuixVG8rCkE4RV3EaTjiXnQY
         GNupNvf8PoiDr6DRuaEXP9dNGG33lu3Hh4D2mqh5f2INhJxLPnhKaHZ9EM6VzkolK7yX
         G8jbUpPgDdMnKjUIgjxIxJbT9y9OkDuj1liWP/whmKVFaO5Blz01OBsySBVkTPCuFxbG
         WFLHjZAJbKOQIO67VeRGTcsArvYsypFOVnU0UW9h0BWZN/QlwLXrYykmCDhyj2uJAx0H
         yGgbCeG6L00+n0uN+c9OYMdlrpEmccUpxjEORkytpo0giywfe98xQDkTJZQG3dUmK+jb
         3/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bf90JyY17mz0lDe1G2c1xsgh5si5CPXlMga6Msc5ALc=;
        b=RvlsMnF3KH4As1BtQu92GaX/iWUb3j/LLNUXYDSQ9d5KoNzPUuc9mnvY7shD8AatOm
         NoCkRSmVnFWl9p40IuxxB5WDZPsfMcQgb2cFal2JwcIs4Cs3IpAjx2QEZr1NY+n2+qDr
         l4CkbNGidUHT8SumnqHWujCI4c9IIaMNFZ5zaR5lcNjKti8T+DJ7JVMgO3scWAvWDuYA
         XAaBZRvwlzgLcCfWyWYNh6eQena6tzEk+Z0S00H/5Tk9Z4eLHGP9OaDs+5OZ85VoUVeB
         iUeJXqEJT2q9v0f2kRkqpvwqe23jMPJ/csamzoUDV/a25S/nsV8+c5+ybVyvQZ+OtJS5
         n3VQ==
X-Gm-Message-State: AOAM533fFwLKu28FukF0Un1WnX9BnVz4evK9tacf/bshBXv4a6d97Ncs
	diImI9P6V9iGlAfflXEQ4OIQdhXNtUwvHeI9T+E=
X-Google-Smtp-Source: ABdhPJxCrMZWYAzQiqsO8nsM33r6LwFzeDTVhl4BwvWQZNv28aS/Y5M/+TR5e44N8jfXz5NhkPvgQfEQ/FCAtOEm6rU=
X-Received: by 2002:a05:6a00:148d:b0:49f:def7:9cfe with SMTP id
 v13-20020a056a00148d00b0049fdef79cfemr35953019pfu.69.1638776694746; Sun, 05
 Dec 2021 23:44:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20211202005216.154787-1-mathew.j.martineau@linux.intel.com> <20211202005216.154787-6-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20211202005216.154787-6-mathew.j.martineau@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 6 Dec 2021 15:44:45 +0800
Message-ID: <CA+WQbwvkmk+0wgDsqFnr3WKWVM_xKP28nRKx+TKgM1OxTv0CfQ@mail.gmail.com>
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


 12 +                  !!mptcp_pm_get_local_addr_max(msk) && subflows_allow=
ed ||
 13 +                  !!mptcp_pm_get_add_addr_signal_max(msk) &&
pm_type =3D=3D MPTCP_PM_TYPE_KERNEL);


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
