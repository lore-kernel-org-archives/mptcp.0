Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126461FBE
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 03:55:58 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id u5so1024788ple.3
        for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 19:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uNSbLvL7nnaW+IiMaJZOz4xygZw5V4iLSj9Ycg8R3NQ=;
        b=mpu4kbtTIvQu0T+wrqGzirupHNqFu0lPcC3bHTNduH/Zz31AX+Nqf73+Ou4kEdv8Rq
         QUji5kfTksQ8W5ioopmDmA3VU1DvQU7X4SR4/V25UpMg+kANtZzTwhKSPSILfL1ayhjt
         KrQOjGfL8MmVaFz7GF7GEZkg+ex5vSbBuYPxjVhy36OBZ0oJlr4i1JsipOLEsW78oCzD
         8FHJoI8Ou5bbjLRMPFCTGs/pMoO7YVn0xmrYncJ+IwyNRm+EEGoqpmzC1jtb3Z6XS9K3
         j+zZX+ITaeTyEt2dvHJ/eSGijsdjPu2EXeDE8jgjcBgabA3Rl3rZvgJZnhVBWfz4aI0g
         8iUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uNSbLvL7nnaW+IiMaJZOz4xygZw5V4iLSj9Ycg8R3NQ=;
        b=B/bYV5wtyDUwpBYeEoza6CA1ZZZ0Qthirk/Tsu6wL7KRIVRS+B96Ce+KH+NtkfBhQ8
         R6dK/dda70T85lRwuZyk71naPfWdmJvALgtJvoveQ7xWYRlTBtm/zMsUq0LwrGsC5Buo
         btLOegTyFSf6FPkBhrnWmjdMsu75g+XqsRHSrl2KAFySqsWOcRGujJ5ziaR5X+wJrsq5
         hkitUNb4lWjTgwAafFTCt4IsXj2xvaOcQQ1Q89bMyMQ0e1x91FyJXGONqlTQ+DaF90Y8
         WlILmfBLO7+EnwiX1QfN4BEdet42uypwNNNSlUo1Vle8HmvYR89Busn/jrbYDvDvvd4R
         oVtQ==
X-Gm-Message-State: AOAM531blIQxm+mzrI9uftQCEkzvWghse9TN3PKRkvQlLMD9uUYkrM8I
	bGs01MWxL78v4SlbOo0kbfzHpIFz8mK4BA/BpE9emvwcbhdNdkef
X-Google-Smtp-Source: ABdhPJz4c2ZfczbmweaTjbr6YirYLQSFFYfwK0kTZvL0/JpvTsVKEwsIuypnm5itjU1MaDfXmhPmrLGMjM9lqk1mYAw=
X-Received: by 2002:a17:902:a381:b0:14f:43ba:32c5 with SMTP id
 x1-20020a170902a38100b0014f43ba32c5mr479182pla.171.1644983758334; Tue, 15 Feb
 2022 19:55:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220203072508.3072309-1-kishen.maloor@intel.com> <20220203072508.3072309-7-kishen.maloor@intel.com>
In-Reply-To: <20220203072508.3072309-7-kishen.maloor@intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 16 Feb 2022 11:56:25 +0800
Message-ID: <CA+WQbwu+mVPO2D7==_7GOeAqd=VdK0SSsS+k10bmbbHyj5A-FA@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v5 6/8] mptcp: netlink: store lsk ref in mptcp_pm_addr_entry
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kishen,

Kishen Maloor <kishen.maloor@intel.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=883=
=E6=97=A5=E5=91=A8=E5=9B=9B 15:25=E5=86=99=E9=81=93=EF=BC=9A
>
> This change updates struct mptcp_pm_addr_entry to store a
> listening socket (lsk) reference, i.e. a pointer to a reference
> counted structure containing the lsk (struct socket *) instead
> of the lsk itself. Code blocks that previously operated on
> the lsk in struct mptcp_pm_addr_entry have been updated to work
> with the lsk ref instead, utilizing new helper functions.
>
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
> v2: fixed formatting
> v3: added helper lsk_list_find_or_create(), updated
> mptcp_pm_nl_create_listen_socket() to take struct net* as param
> v4: call lsk_list_find() after a failed lsk_list_find_or_create()
> for a chance to retrieve a recently created lsk by a simultaneous
> call
> v5: fixed implicit declaration error
> ---
>  net/mptcp/pm_netlink.c | 83 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 62 insertions(+), 21 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 3d6251baef26..a4fb9acbba51 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -35,7 +35,7 @@ struct mptcp_pm_addr_entry {
>         struct mptcp_addr_info  addr;
>         u8                      flags;
>         int                     ifindex;
> -       struct socket           *lsk;
> +       struct mptcp_local_lsk  *lsk_ref;
>  };
>
>  struct mptcp_pm_add_entry {
> @@ -66,6 +66,10 @@ struct pm_nl_pernet {
>  #define MPTCP_PM_ADDR_MAX      8
>  #define ADD_ADDR_RETRANS_MAX   3
>
> +static int mptcp_pm_nl_create_listen_socket(struct net *net,
> +                                           struct mptcp_pm_addr_entry *e=
ntry,
> +                                           struct socket **lsk);
> +
>  static bool addresses_equal(const struct mptcp_addr_info *a,
>                             const struct mptcp_addr_info *b, bool use_por=
t)
>  {
> @@ -157,6 +161,33 @@ static void lsk_list_release(struct pm_nl_pernet *pe=
rnet,
>         }
>  }
>
> +static struct mptcp_local_lsk *lsk_list_find_or_create(struct net *net,
> +                                                      struct pm_nl_perne=
t *pernet,
> +                                                      struct mptcp_pm_ad=
dr_entry *entry,
> +                                                      int *createlsk_err=
)
> +{
> +       struct mptcp_local_lsk *lsk_ref;
> +       struct socket *lsk;
> +       int err;
> +
> +       lsk_ref =3D lsk_list_find(pernet, &entry->addr);
> +
> +       if (!lsk_ref) {
> +               err =3D mptcp_pm_nl_create_listen_socket(net, entry, &lsk=
);
> +
> +               if (createlsk_err)
> +                       *createlsk_err =3D err;
> +
> +               if (lsk)
> +                       lsk_ref =3D lsk_list_add(pernet, &entry->addr, ls=
k);
> +
> +               if (lsk && !lsk_ref)
> +                       sock_release(lsk);
> +       }
> +
> +       return lsk_ref;
> +}
> +
>  static bool address_zero(const struct mptcp_addr_info *addr)
>  {
>         struct mptcp_addr_info zero;
> @@ -999,8 +1030,9 @@ static int mptcp_pm_nl_append_new_local_addr(struct =
pm_nl_pernet *pernet,
>         return ret;
>  }
>
> -static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> -                                           struct mptcp_pm_addr_entry *e=
ntry)
> +static int mptcp_pm_nl_create_listen_socket(struct net *net,
> +                                           struct mptcp_pm_addr_entry *e=
ntry,
> +                                           struct socket **lsk)
>  {
>         int addrlen =3D sizeof(struct sockaddr_in);
>         struct sockaddr_storage addr;
> @@ -1009,12 +1041,12 @@ static int mptcp_pm_nl_create_listen_socket(struc=
t sock *sk,
>         int backlog =3D 1024;
>         int err;
>
> -       err =3D sock_create_kern(sock_net(sk), entry->addr.family,
> -                              SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
> +       err =3D sock_create_kern(net, entry->addr.family,
> +                              SOCK_STREAM, IPPROTO_MPTCP, lsk);
>         if (err)
>                 return err;
>
> -       msk =3D mptcp_sk(entry->lsk->sk);
> +       msk =3D mptcp_sk((*lsk)->sk);
>         if (!msk) {
>                 err =3D -EINVAL;
>                 goto out;
> @@ -1046,7 +1078,8 @@ static int mptcp_pm_nl_create_listen_socket(struct =
sock *sk,
>         return 0;
>
>  out:
> -       sock_release(entry->lsk);
> +       sock_release(*lsk);
> +       *lsk =3D NULL;
>         return err;
>  }
>
> @@ -1095,7 +1128,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk=
, struct sock_common *skc)
>         entry->addr.port =3D 0;
>         entry->ifindex =3D 0;
>         entry->flags =3D 0;
> -       entry->lsk =3D NULL;
> +       entry->lsk_ref =3D NULL;
>         ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
>         if (ret < 0)
>                 kfree(entry);
> @@ -1304,18 +1337,25 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *=
skb, struct genl_info *info)
>
>         *entry =3D addr;
>         if (entry->addr.port) {
> -               ret =3D mptcp_pm_nl_create_listen_socket(skb->sk, entry);
> -               if (ret) {
> -                       GENL_SET_ERR_MSG(info, "create listen socket erro=
r");
> +               entry->lsk_ref =3D lsk_list_find_or_create(sock_net(skb->=
sk), pernet, entry, &ret);
> +
> +               if (!entry->lsk_ref)
> +                       entry->lsk_ref =3D lsk_list_find(pernet, &entry->=
addr);
> +
> +               if (!entry->lsk_ref) {
> +                       GENL_SET_ERR_MSG(info, "can't create/allocate lsk=
");
>                         kfree(entry);
> +                       ret =3D (ret =3D=3D 0) ? -ENOMEM : ret;
>                         return ret;
>                 }
>         }
> +

Blank lines aren't necessary here,

>         ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
> +

and here.

Thanks,

Geliang
SUSE

>         if (ret < 0) {
>                 GENL_SET_ERR_MSG(info, "too many addresses or duplicate o=
ne");
> -               if (entry->lsk)
> -                       sock_release(entry->lsk);
> +               if (entry->lsk_ref)
> +                       lsk_list_release(pernet, entry->lsk_ref);
>                 kfree(entry);
>                 return ret;
>         }
> @@ -1418,10 +1458,11 @@ static int mptcp_nl_remove_subflow_and_signal_add=
r(struct net *net,
>  }
>
>  /* caller must ensure the RCU grace period is already elapsed */
> -static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *en=
try)
> +static void __mptcp_pm_release_addr_entry(struct pm_nl_pernet *pernet,
> +                                         struct mptcp_pm_addr_entry *ent=
ry)
>  {
> -       if (entry->lsk)
> -               sock_release(entry->lsk);
> +       if (entry->lsk_ref)
> +               lsk_list_release(pernet, entry->lsk_ref);
>         kfree(entry);
>  }
>
> @@ -1503,7 +1544,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *sk=
b, struct genl_info *info)
>
>         mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry=
->addr);
>         synchronize_rcu();
> -       __mptcp_pm_release_addr_entry(entry);
> +       __mptcp_pm_release_addr_entry(pernet, entry);
>
>         return ret;
>  }
> @@ -1559,7 +1600,7 @@ static void mptcp_nl_remove_addrs_list(struct net *=
net,
>  }
>
>  /* caller must ensure the RCU grace period is already elapsed */
> -static void __flush_addrs(struct list_head *list)
> +static void __flush_addrs(struct pm_nl_pernet *pernet, struct list_head =
*list)
>  {
>         while (!list_empty(list)) {
>                 struct mptcp_pm_addr_entry *cur;
> @@ -1567,7 +1608,7 @@ static void __flush_addrs(struct list_head *list)
>                 cur =3D list_entry(list->next,
>                                  struct mptcp_pm_addr_entry, list);
>                 list_del_rcu(&cur->list);
> -               __mptcp_pm_release_addr_entry(cur);
> +               __mptcp_pm_release_addr_entry(pernet, cur);
>         }
>  }
>
> @@ -1592,7 +1633,7 @@ static int mptcp_nl_cmd_flush_addrs(struct sk_buff =
*skb, struct genl_info *info)
>         spin_unlock_bh(&pernet->lock);
>         mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
>         synchronize_rcu();
> -       __flush_addrs(&free_list);
> +       __flush_addrs(pernet, &free_list);
>         return 0;
>  }
>
> @@ -2242,7 +2283,7 @@ static void __net_exit pm_nl_exit_net(struct list_h=
ead *net_list)
>                  * other modifiers, also netns core already waited for a
>                  * RCU grace period.
>                  */
> -               __flush_addrs(&pernet->local_addr_list);
> +               __flush_addrs(pernet, &pernet->local_addr_list);
>         }
>  }
>
> --
> 2.31.1
>
>
