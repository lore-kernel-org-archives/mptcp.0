Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0A2F21
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 13:47:27 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id t9so2975164plg.13
        for <mptcp@lists.linux.dev>; Fri, 04 Feb 2022 05:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6PkxPN8rr5DXrn1BetGGD1J81frKaa+D2o/xMnHu5Rs=;
        b=osxIcd7cxcY5bF74AJCRmq9jg3RpXLxwZGi9WK/uXBBWDVaEFbevwGGdpwhY/EKVKM
         HCjo2uNHGeJ8nqtsNH9Y55LfNflacydQkYuOasNiyWr+1NqHvGlrS5TkUBRJxjfkFRRm
         wKOExCQxcDO1QDuIqFV4wQrFo0AfoO5cmGdcJZgPq3T2VK8S1uvK0IaVulR1d0Or44sv
         aXNibDJMxxwplEi7Ex5iSHuAt8GlE2u0UHkjhySRnzRgH08kZAqDh4KdiKIOEUp8hblO
         1xfdpnq1ko8VOQnYG6YFcFI8Z+JGeUDifljJ0DGSLN6tgFkKNdu/cg7Z+wR4+ddvDyCu
         WVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6PkxPN8rr5DXrn1BetGGD1J81frKaa+D2o/xMnHu5Rs=;
        b=UyDlWQ5UD2qBknq7lOv96oYJNB+pt0abK8gLcSpHQyBG0e4DA6ou2vrUEjOXFw1wW9
         x7N0VijoXtbEorXYtxGJGUOj6PteAUFT2tMWkUyYUFfsduyziPXNEzX/WeUppswgyKJ5
         rXGuvIwczIOnFTYCi69M9OHui7rlPIy4TCSLxDKCTbFjDJvwimoNs9Im8UlM0By205xp
         IPLsrJagyxH/AzVPmKQevvTkerSLgG5Xn3vkHn8OgRpNU54YoTJE1ruQxUWlh74D3VZJ
         xLakcctmINnfPYnjlhDVMwTlXMWSYzRXN1NXbA3vhdk7P1MwfcJP1/d4EqH6rw1YQa4J
         Kadg==
X-Gm-Message-State: AOAM532LagJydCMgGiwOtDZbK2Y0JqtvULaWVY1NnE5CB8gaDQ8f4g26
	JSzZehP4YhZF+ZlenRKuNXYG4KnE4X1VEsePf5mca1GeQVttJg==
X-Google-Smtp-Source: ABdhPJyIeXEOuyt4LWfjiYaXfl2XDbXnIBliI61E8GS3D0zSqvhWyvN10zVbd8t41GArWfKo2gn+XuOomThWNDCEbtg=
X-Received: by 2002:a17:902:e851:: with SMTP id t17mr3058245plg.102.1643982447151;
 Fri, 04 Feb 2022 05:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220203031403.2996549-1-kishen.maloor@intel.com> <20220203031403.2996549-4-kishen.maloor@intel.com>
In-Reply-To: <20220203031403.2996549-4-kishen.maloor@intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 4 Feb 2022 21:47:45 +0800
Message-ID: <CA+WQbwuM6sK5nnp6B3swJsxdnHXAxA_41H52ztPX0k-KHJHOEA@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v4 03/13] mptcp: read attributes of addr
 entries managed by userspace PMs
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kishen Maloor <kishen.maloor@intel.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=883=
=E6=97=A5=E5=91=A8=E5=9B=9B 11:14=E5=86=99=E9=81=93=EF=BC=9A
>
> This change introduces a parallel path in the kernel for retrieving
> the local id, flags, if_index for an addr entry in the context of
> an MPTCP connection that's being managed by a userspace PM. The
> userspace and in-kernel PM modes deviate in their procedures for
> obtaining this information.
>
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  net/mptcp/pm_netlink.c | 97 ++++++++++++++++++++++++++++--------------
>  net/mptcp/protocol.h   |  2 +-
>  net/mptcp/subflow.c    |  2 +-
>  3 files changed, 67 insertions(+), 34 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index ac5d152fbb77..7058d55e3a0a 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1230,31 +1230,47 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *m=
sk, struct sock_common *skc)
>
>         pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet=
_id);
>
> -       rcu_read_lock();
> -       list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> -               if (addresses_equal(&entry->addr, &skc_local, entry->addr=
.port)) {
> -                       ret =3D entry->addr.id;
> -                       break;
> -               }
> -       }
> -       rcu_read_unlock();
> -       if (ret >=3D 0)
> -               return ret;
> -
>         /* address not found, add to local list */

I think this comment should be moved into 'if (mptcp_pm_is_kernel(msk))' to=
o.

> -       entry =3D kmalloc(sizeof(*entry), GFP_ATOMIC);
> -       if (!entry)
> -               return -ENOMEM;
> -
> -       entry->addr =3D skc_local;
> -       entry->addr.id =3D 0;
> -       entry->addr.port =3D 0;
> -       entry->ifindex =3D 0;
> -       entry->flags =3D 0;
> -       entry->lsk_ref =3D NULL;
> -       ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
> -       if (ret < 0)
> -               kfree(entry);
> +       if (mptcp_pm_is_kernel(msk)) {
> +               rcu_read_lock();
> +               list_for_each_entry_rcu(entry, &pernet->local_addr_list, =
list) {
> +                       if (addresses_equal(&entry->addr, &skc_local, ent=
ry->addr.port)) {
> +                               ret =3D entry->addr.id;
> +                               break;
> +                       }
> +               }
> +               rcu_read_unlock();
> +
> +               if (ret >=3D 0)
> +                       return ret;
> +
> +               entry =3D kmalloc(sizeof(*entry), GFP_ATOMIC);
> +               if (!entry)
> +                       return -ENOMEM;
> +
> +               entry->addr =3D skc_local;
> +               entry->addr.id =3D 0;
> +               entry->addr.port =3D 0;
> +               entry->ifindex =3D 0;
> +               entry->flags =3D 0;
> +               entry->lsk_ref =3D NULL;
> +               ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
> +               if (ret < 0)
> +                       kfree(entry);
> +       } else if (mptcp_pm_is_userspace(msk)) {
> +               struct mptcp_pm_addr_entry new_entry;
> +               __be16 msk_sport =3D  ((struct inet_sock *)
> +                                    inet_sk((struct sock *)msk))->inet_s=
port;
> +
> +               memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry))=
;
> +               new_entry.addr =3D skc_local;
> +               new_entry.addr.id =3D 0;
> +
> +               if (new_entry.addr.port =3D=3D msk_sport)
> +                       new_entry.addr.port =3D 0;
> +
> +               ret =3D mptcp_userspace_pm_append_new_local_addr(msk, &ne=
w_entry);
> +       }
>
>         return ret;
>  }
> @@ -1488,22 +1504,39 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *=
skb, struct genl_info *info)
>         return 0;
>  }
>
> -int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int i=
d,
> +int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigne=
d int id,
>                                          u8 *flags, int *ifindex)
>  {
> -       struct mptcp_pm_addr_entry *entry;
> +       struct mptcp_pm_addr_entry *entry, *match =3D NULL;
> +       struct sock *sk =3D (struct sock *)msk;
> +       struct net *net =3D sock_net(sk);
>
>         *flags =3D 0;
>         *ifindex =3D 0;
>
>         if (id) {
> -               rcu_read_lock();
> -               entry =3D __lookup_addr_by_id(net_generic(net, pm_nl_pern=
et_id), id);
> -               if (entry) {
> -                       *flags =3D entry->flags;
> -                       *ifindex =3D entry->ifindex;
> +               if (mptcp_pm_is_kernel(msk)) {
> +                       rcu_read_lock();
> +                       entry =3D __lookup_addr_by_id(net_generic(net, pm=
_nl_pernet_id), id);
> +                       if (entry) {
> +                               *flags =3D entry->flags;
> +                               *ifindex =3D entry->ifindex;
> +                       }
> +                       rcu_read_unlock();
> +               } else {
> +                       mptcp_data_lock(sk);
> +                       list_for_each_entry(entry, &msk->local_addr_list,=
 list) {
> +                               if (id =3D=3D entry->addr.id) {
> +                                       match =3D entry;
> +                                       break;
> +                               }
> +                       }
> +                       mptcp_data_unlock(sk);
> +                       if (match) {
> +                               *flags =3D match->flags;
> +                               *ifindex =3D match->ifindex;
> +                       }
>                 }
> -               rcu_read_unlock();
>         }
>
>         return 0;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 6b7e51a2bd09..b6af57d5ff5b 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -771,7 +771,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>  struct mptcp_pm_add_entry *
>  mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
>                                 struct mptcp_addr_info *addr);
> -int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int i=
d,
> +int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigne=
d int id,
>                                          u8 *flags, int *ifindex);
>
>  int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d3691b95401a..19df5293334f 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1416,7 +1416,7 @@ int __mptcp_subflow_connect(struct sock *sk, const =
struct mptcp_addr_info *loc,
>                 local_id =3D err;
>         }
>
> -       mptcp_pm_get_flags_and_ifindex_by_id(sock_net(sk), local_id,
> +       mptcp_pm_get_flags_and_ifindex_by_id(msk, local_id,
>                                              &flags, &ifindex);
>         subflow->remote_key =3D msk->remote_key;
>         subflow->local_key =3D msk->local_key;
> --
> 2.31.1
>
>
