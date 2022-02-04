Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340042F21
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 13:51:43 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so6167280pjb.5
        for <mptcp@lists.linux.dev>; Fri, 04 Feb 2022 05:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ib1G/4n/XKefHPdbgvMAF+obPwgNXwVI4DBuE16F6RU=;
        b=nSXG0g3/LWYj1wEz3m5HngobmH+2P+cW0IASW75V0kjchyMvjMy2polJbTj7qqaCxS
         kUTnky6nnwQ8BYvOlYrtA3b7MXmgo3obyl/iNjx88NrfhM1CAYH83m2HHSkbB6/FVJ7o
         vJWpZQmdrLzh+PUnGv6RL+drPhe/XDRRiHgR6gibwIjA/OVYyiXuG1l1qkgQjrOttfTA
         sBijvi3Z9jEdEtxJxnMTtcWyaOUQiU+FZ44Q8WmpxGbeGD4DX7epNLUNcnCcO71rWvd0
         YNdd+hB2IalEAULH/48VUzoPnJqyLV1uLd0tU1IZ1HKBoUVsevWHEUcRLQDky5qxSylz
         sZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ib1G/4n/XKefHPdbgvMAF+obPwgNXwVI4DBuE16F6RU=;
        b=Mf5dPHGo60DjTJvt8bF10VdR9NG+AvzBbPFk45IjUrZPleVWXDBVuYnO0m5weHOSro
         Co8+pgDZ3RUT1K4P28n9J/HaV4UQORJkk0g5qqepxyfXODJguouqoypF9/VvI+VKqR30
         rSWmdRLv95eo5zlAwtUMVyDdDzq5DuaiDDS9g2H5Oj0DpHT8FihOUJbhWA6meL9JZxhE
         NP87s8fTdreUmnJFVLSiPeYLpVeQV2EweijZR4gkP4HyfTvIikFHrIMuWwl0xt6Kufxs
         p7G6IL1oWoONJ5sw/oF7sL4AetCz7Eb1/gL7Tj7oB/dHtnUXdnf8vWssA5s3sjoFdo7F
         dCMw==
X-Gm-Message-State: AOAM532ps8K1IQZ3gZyqbtZ+S63WK8gGfvHsDNqxbUUcQkvJPbNr0LEM
	ibudGK3gSkjjYCviJE4fjQHSq6m6baw1oz0+rHA=
X-Google-Smtp-Source: ABdhPJwPBUPsI8IQra3qu2OV/q3N9G+BIUo4JoNN6F6n5Oi8B/P5eAWsnmf1tL6w8C0A5YjS1E81nKRZpbOitGtL+78=
X-Received: by 2002:a17:90a:bf16:: with SMTP id c22mr3163351pjs.126.1643982702605;
 Fri, 04 Feb 2022 05:51:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220203072508.3072309-1-kishen.maloor@intel.com> <20220203072508.3072309-8-kishen.maloor@intel.com>
In-Reply-To: <20220203072508.3072309-8-kishen.maloor@intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 4 Feb 2022 21:52:00 +0800
Message-ID: <CA+WQbwtDRGipHoUi+v95gYzr84qDc83gWV=Jz4iVE_G7XgtWjQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v5 7/8] mptcp: attempt to add listening sockets
 for announced addrs
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kishen Maloor <kishen.maloor@intel.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=883=
=E6=97=A5=E5=91=A8=E5=9B=9B 15:25=E5=86=99=E9=81=93=EF=BC=9A
>
> When ADD_ADDR announcements use the port associated with an
> active subflow, this change ensures that a listening socket is bound
> to the announced addr+port in the kernel for subsequently receiving
> MP_JOINs. But if a listening socket for this address is already held
> by the application then no action is taken.
>
> A listening socket is created (when there isn't a listener)
> just prior to the addr advertisement. If it is desired to not create
> a listening socket in the kernel for an address, then this can be
> requested by including the MPTCP_PM_ADDR_FLAG_NO_LISTEN flag
> with the address.
>
> When a listening socket is created, it is stored in
> struct mptcp_pm_add_entry and released accordingly.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/203
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
> v2: fixed formatting
> v3: added new addr flag MPTCP_PM_ADDR_FLAG_NO_LISTEN to skip creating a
> listening socket in the kernel during an ADD_ADDR request, use this flag
> along the in-kernel PM flow for ADD_ADDR requests (Note: listening socket=
s
> are always created for port-based endpoints as before), use the
> lsk_list_find_or_create() helper
> v4: call lsk_list_find() after a failed lsk_list_find_or_create()
> for a chance to retrieve a recently created lsk by a simultaneous
> call
> ---
>  include/uapi/linux/mptcp.h |  1 +
>  net/mptcp/pm_netlink.c     | 46 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 45 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index f106a3941cdf..265cabc0d7aa 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -81,6 +81,7 @@ enum {
>  #define MPTCP_PM_ADDR_FLAG_SUBFLOW                     (1 << 1)
>  #define MPTCP_PM_ADDR_FLAG_BACKUP                      (1 << 2)
>  #define MPTCP_PM_ADDR_FLAG_FULLMESH                    (1 << 3)
> +#define MPTCP_PM_ADDR_FLAG_NO_LISTEN                   (1 << 4)
>
>  enum {
>         MPTCP_PM_CMD_UNSPEC,
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index a4fb9acbba51..9b3d871d3712 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -43,6 +43,7 @@ struct mptcp_pm_add_entry {
>         struct mptcp_addr_info  addr;
>         struct timer_list       add_timer;
>         struct mptcp_sock       *sock;
> +       struct mptcp_local_lsk  *lsk_ref;
>         u8                      retrans_times;
>  };
>
> @@ -469,7 +470,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>  }
>
>  static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
> -                                    struct mptcp_pm_addr_entry *entry)
> +                                    struct mptcp_pm_addr_entry *entry,
> +                                    struct mptcp_local_lsk *lsk_ref)
>  {
>         struct mptcp_pm_add_entry *add_entry =3D NULL;
>         struct sock *sk =3D (struct sock *)msk;
> @@ -489,6 +491,10 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_so=
ck *msk,
>         add_entry->addr =3D entry->addr;
>         add_entry->sock =3D msk;
>         add_entry->retrans_times =3D 0;
> +       add_entry->lsk_ref =3D lsk_ref;
> +
> +       if (lsk_ref)
> +               lsk_list_add_ref(lsk_ref);
>
>         timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
>         sk_reset_timer(sk, &add_entry->add_timer,
> @@ -501,8 +507,11 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
>  {
>         struct mptcp_pm_add_entry *entry, *tmp;
>         struct sock *sk =3D (struct sock *)msk;
> +       struct pm_nl_pernet *pernet;
>         LIST_HEAD(free_list);
>
> +       pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
> +
>         pr_debug("msk=3D%p", msk);
>
>         spin_lock_bh(&msk->pm.lock);
> @@ -511,6 +520,8 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
>
>         list_for_each_entry_safe(entry, tmp, &free_list, list) {
>                 sk_stop_timer_sync(sk, &entry->add_timer);
> +               if (entry->lsk_ref)
> +                       lsk_list_release(pernet, entry->lsk_ref);
>                 kfree(entry);
>         }
>  }
> @@ -615,7 +626,9 @@ lookup_id_by_addr(struct pm_nl_pernet *pernet, const =
struct mptcp_addr_info *add
>  }
>
>  static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *ms=
k)
> +       __must_hold(&msk->pm.lock)
>  {
> +       struct mptcp_local_lsk *lsk_ref =3D NULL;
>         struct sock *sk =3D (struct sock *)msk;
>         struct mptcp_pm_addr_entry *local;
>         unsigned int add_addr_signal_max;
> @@ -652,12 +665,34 @@ static void mptcp_pm_create_subflow_or_signal_addr(=
struct mptcp_sock *msk)
>                 local =3D select_signal_address(pernet, msk);
>
>                 if (local) {
> -                       if (mptcp_pm_alloc_anno_list(msk, local)) {
> +                       if (!(local->flags & MPTCP_PM_ADDR_FLAG_NO_LISTEN=
) &&
> +                           !local->addr.port) {
> +                               local->addr.port =3D
> +                                       ((struct inet_sock *)inet_sk
> +                                        ((struct sock *)msk))->inet_spor=
t;

How about putting them in one line:
local->addr.port =3D ((struct inet_sock *)inet_sk(sk))->inet_sport;

> +
> +                               spin_unlock_bh(&msk->pm.lock);
> +
> +                               lsk_ref =3D lsk_list_find_or_create(sock_=
net(sk), pernet,
> +                                                                 local, =
NULL);
> +
> +                               spin_lock_bh(&msk->pm.lock);
> +
> +                               if (!lsk_ref)
> +                                       lsk_ref =3D lsk_list_find(pernet,=
 &local->addr);
> +
> +                               local->addr.port =3D 0;
> +                       }
> +
> +                       if (mptcp_pm_alloc_anno_list(msk, local, lsk_ref)=
) {
>                                 __clear_bit(local->addr.id, msk->pm.id_av=
ail_bitmap);
>                                 msk->pm.add_addr_signaled++;
>                                 mptcp_pm_announce_addr(msk, &local->addr,=
 false);
>                                 mptcp_pm_nl_addr_send_ack(msk);
>                         }
> +
> +                       if (lsk_ref)
> +                               lsk_list_release(pernet, lsk_ref);
>                 }
>         }
>
> @@ -749,6 +784,7 @@ static unsigned int fill_local_addresses_vec(struct m=
ptcp_sock *msk,
>  }
>
>  static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> +       __must_hold(&msk->pm.lock)
>  {
>         struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
>         struct sock *sk =3D (struct sock *)msk;
> @@ -1389,11 +1425,17 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct n=
et *net, unsigned int id,
>  static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
>                                       struct mptcp_addr_info *addr)
>  {
> +       struct sock *sk =3D (struct sock *)msk;
>         struct mptcp_pm_add_entry *entry;
> +       struct pm_nl_pernet *pernet;
> +
> +       pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
>
>         entry =3D mptcp_pm_del_add_timer(msk, addr, false);
>         if (entry) {
>                 list_del(&entry->list);
> +               if (entry->lsk_ref)
> +                       lsk_list_release(pernet, entry->lsk_ref);
>                 kfree(entry);
>                 return true;
>         }
> --
> 2.31.1
>
>
