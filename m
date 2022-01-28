Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3929CA
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 06:38:17 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so4216672pjb.5
        for <mptcp@lists.linux.dev>; Thu, 27 Jan 2022 22:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SYpu0JpzxtC0QpDHn9r0cCAk2S34lyMRx/VjORbojGM=;
        b=ES0gXtudWeIx8ecWcZ6b1+8oEwbU2+v3hbpskyPGm87XabacBflfZurN3q74N7GzbL
         Wg3XNqBk7CEXgfo9+AMy2Z/y1/WNck9Gl3V0Xn71oVo5EnJAboh4trMMUhhFioyrDUSF
         aZ66FHxZYaS8/lhLds/GGKqIDLzyalJ3H7w7FSi10XBiTGtgQZcdTodYyifXju53dCoR
         HoZl6BijVxluRtmqst8+x3RXoRXfALLSRUir92uWjMIIqGbEDH4Fo71Tuzlh1bq5FwpY
         0DsWTr4qN/0AIzI2leuEokJMg+/nF8qg/+jcF9svsVNyO1m9DB9JMo5TlJrwjDXJZihg
         +Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SYpu0JpzxtC0QpDHn9r0cCAk2S34lyMRx/VjORbojGM=;
        b=wOAnkXpDDzB8yuxWVd7C01tjy2dX4FgBL4f45t25YQek2v51hI4Gqrx5ZWJo5IaTXe
         HG2P7SAk0snC2g4m/GuEnglkDR3sde7/KhVjFVMepjDHKeit4z1xX8D2L6AvcKFpjAox
         Bn/Y6uXV9dGiD8Vb20M9c9lOK4S4QV5lkxI0PmNbUqompUFi/MhJrfViSKudSBIEKFuY
         Nc3yGmVUiaYiJ+KbxS39tszHl8oIEhD8T6fhKkNYFs2DCCLvXhTTN9Tqu8smAgbor9Z2
         T4ZngBosytn49pGgKjzu5nHF3LcJMuuKyrRRkQroMTu5pJL4CYy16+FgLr/EUZNU9HVq
         jAlA==
X-Gm-Message-State: AOAM531bNTQL5/gMepgqpnOdC2VwBejrzK4WgF6FlbcyGVo209U/HP8k
	NV13sUYHpK17EiYBARIMYsds1wOTl9reoMIG9ZIxcYn61D/OmIXd
X-Google-Smtp-Source: ABdhPJzBK7I/P/VLnTOVlS1lqSHN8crd+ow7h8LjA7X9v+XFTzBwNRab7/r9kkonPtmvByeNCK1HNND+On+cffG1TFU=
X-Received: by 2002:a17:902:ab43:: with SMTP id ij3mr6952632plb.25.1643351897115;
 Thu, 27 Jan 2022 22:38:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220128003836.2732694-1-kishen.maloor@intel.com> <20220128003836.2732694-2-kishen.maloor@intel.com>
In-Reply-To: <20220128003836.2732694-2-kishen.maloor@intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 28 Jan 2022 14:38:26 +0800
Message-ID: <CA+WQbws7UHpc0LA3kd7wSqB_k-6aEN9HLm_JbeNSi0XzsPw=Gg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v3 01/14] mptcp: add sysctl param to limit
 userspace PM activity
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kishen,

Kishen Maloor <kishen.maloor@intel.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=94 08:39=E5=86=99=E9=81=93=EF=BC=9A
>
> This change adds a new configurable param userspace_pm_local_addr_max
> to set a limit on the number of local addresses that may be recorded
> by a userspace path manager in the context of any MPTCP connection.
> Consequently, it also limits the # of subflows, i.e. to as many that
> could be established via the bounded set of local addresses.
>
> The patch also ensures that other stats inside struct mptcp_pm_data
> that are updated along kernel code paths exercised by userspace PMs
> remain untouched for userspace PM managed sockets.
>
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  net/mptcp/ctrl.c       | 17 +++++++++++++++++
>  net/mptcp/pm.c         |  4 +++-
>  net/mptcp/pm_netlink.c |  3 +++
>  net/mptcp/protocol.h   |  1 +
>  4 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index ae20b7d92e28..dffc2da6d713 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -19,6 +19,7 @@ static int mptcp_pernet_id;
>
>  #ifdef CONFIG_SYSCTL
>  static int mptcp_pm_type_max =3D __MPTCP_PM_TYPE_MAX;
> +static int mptcp_max_addrs =3D MPTCP_PM_MAX_ADDR_ID;
>  #endif
>
>  struct mptcp_pernet {
> @@ -32,6 +33,7 @@ struct mptcp_pernet {
>         u8 checksum_enabled;
>         u8 allow_join_initial_addr_port;
>         u8 pm_type;
> +       u8 userspace_pm_local_addr_max;
>  };
>
>  static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
> @@ -69,6 +71,11 @@ int mptcp_get_pm_type(const struct net *net)
>         return mptcp_get_pernet(net)->pm_type;
>  }
>
> +unsigned int mptcp_get_userspace_pm_local_addr_max(const struct net *net=
)
> +{
> +       return mptcp_get_pernet(net)->userspace_pm_local_addr_max;
> +}
> +
>  static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>  {
>         pernet->mptcp_enabled =3D 1;
> @@ -77,6 +84,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pern=
et *pernet)
>         pernet->allow_join_initial_addr_port =3D 1;
>         pernet->stale_loss_cnt =3D 4;
>         pernet->pm_type =3D MPTCP_PM_TYPE_KERNEL;
> +       pernet->userspace_pm_local_addr_max =3D 10;
>  }
>
>  #ifdef CONFIG_SYSCTL
> @@ -128,6 +136,14 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
>                 .extra1       =3D SYSCTL_ZERO,
>                 .extra2       =3D &mptcp_pm_type_max
>         },
> +       {
> +               .procname =3D "userspace_pm_local_addr_max",
> +               .maxlen =3D sizeof(u8),
> +               .mode =3D 0644,
> +               .proc_handler =3D proc_dou8vec_minmax,
> +               .extra1       =3D SYSCTL_ONE,
> +               .extra2       =3D &mptcp_max_addrs
> +       },
>         {}
>  };
>
> @@ -149,6 +165,7 @@ static int mptcp_pernet_new_table(struct net *net, st=
ruct mptcp_pernet *pernet)
>         table[3].data =3D &pernet->allow_join_initial_addr_port;
>         table[4].data =3D &pernet->stale_loss_cnt;
>         table[5].data =3D &pernet->pm_type;
> +       table[6].data =3D &pernet->userspace_pm_local_addr_max;
>
>         hdr =3D register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
>         if (!hdr)
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index e5d5cb847209..24839cd7025c 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -182,7 +182,9 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *m=
sk, const struct sock *ssk,
>         bool update_subflows;
>
>         update_subflows =3D (ssk->sk_state =3D=3D TCP_CLOSE) &&
> -                         (subflow->request_join || subflow->mp_join);
> +                         (subflow->request_join || subflow->mp_join) &&
> +                         READ_ONCE(pm->pm_type) =3D=3D MPTCP_PM_TYPE_KER=
NEL;

How about using mptcp_pm_is_userspace() instead for all the
MPTCP_PM_TYPE_KERNEL type check in this series?

Thanks,
-Geliang

> +
>         if (!READ_ONCE(pm->work_pending) && !update_subflows)
>                 return;
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 126cc961a4fd..882988e43d76 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -933,6 +933,9 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mpt=
cp_sock *msk,
>                 if (!removed)
>                         continue;
>
> +               if (READ_ONCE(msk->pm.pm_type) !=3D MPTCP_PM_TYPE_KERNEL)
> +                       continue;
> +
>                 if (rm_type =3D=3D MPTCP_MIB_RMADDR) {
>                         msk->pm.add_addr_accepted--;
>                         WRITE_ONCE(msk->pm.accept_addr, true);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 30006735afb7..6cfa8ec26482 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -852,6 +852,7 @@ unsigned int mptcp_pm_get_add_addr_signal_max(struct =
mptcp_sock *msk);
>  unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
>  unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
>  unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
> +unsigned int mptcp_get_userspace_pm_local_addr_max(const struct net *net=
);
>
>  void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
>  void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)=
;
> --
> 2.31.1
>
>
