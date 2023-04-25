Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7F7B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 08:05:46 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f173af665fso34905715e9.3
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 01:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682409944; x=1685001944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+3Bs92YO2iMg60U3k13/Wp0Gn0kKczlE9e/o7PYt9c=;
        b=qrHrkaT7mj/fzqQFw54EAXhgjZ6X2DRyD7YKxkibDRmLWrRz/vjRSjMfVZjlGohgko
         BEZwN1Fv5Czd7gozoHH+w+scaxWweuZku6VVBgIGHdLS0AAChyo7pgThF2nXkh/mnSQ5
         a/2wgTrnHrYBHb+At7x4fyR3pb0qsua6lrFeFUUh2qbp6XG4330M4QIK6ATqBf2+SV5o
         tgMMCqNCz6dNls5JZnHHXo9hmCwi/d0E+QhLlbl2l/fqJTrKhesFCpfA6AnY+v8eiI00
         +dm0k8iJ28p4Cd+kQgdazMjzu0M5M7wT17nxw4A8chw4wWiwVkoMPwIKKItTdEA61UGr
         TxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682409944; x=1685001944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+3Bs92YO2iMg60U3k13/Wp0Gn0kKczlE9e/o7PYt9c=;
        b=LpB+y2KMw5qhFjN8IlxWOpOFhY0jo25gaxdIEDW6GSv7MixLdcEs7OAg7tyru7IjGB
         MDDD4JdOQm6SL3sFXiDz4OuklAWAyahqnno9pHUhLRaVZscmMDviFl6shpYk1DVzcZ9o
         GmCkW+BeFolF9u/79Au5efbR5UxDCFg6Gei9F/9ge9UttPOP0Bzd3yLpa4rYmru9mGjI
         JKik7VhAhTwlEU/m05NF8c6ar7LtSA2Nh7OC30yId5cX7mJyxvnEQlkg9OEOjkDdzSyZ
         knT2Bo5tBU0eT4TgGL0Y9Js9Dx4l/S1/HSofd2jnBsXSLAHTIHT8NThbg8Zjo1xre/8y
         0ycg==
X-Gm-Message-State: AAQBX9dLkg1ofbmXFjg943269VJS6/FZUaEkNAoZrooxCdJEOJg7kLZm
	yjJgbZlVX9gBdLGs2TY6WQKa+7UfnrHrHirARgqDJG1x9Sc=
X-Google-Smtp-Source: AKy350auTWheaUxKRJxMlAJ3rwFNGlRhiSU2xFed6x5NX4faw7/BiJAhCJJIfM2A64SqwoJCfZH5m1Is4+aJiLB1KaA=
X-Received: by 2002:a05:600c:3657:b0:3f0:4734:bef8 with SMTP id
 y23-20020a05600c365700b003f04734bef8mr9257410wmq.39.1682409944188; Tue, 25
 Apr 2023 01:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1681960259.git.geliang.tang@suse.com> <9c4298af79bfbf37412a96f945ff75466c45d010.1681960259.git.geliang.tang@suse.com>
 <e5ba4db7-9fd0-40eb-f549-795ee29d8d4a@tessares.net>
In-Reply-To: <e5ba4db7-9fd0-40eb-f549-795ee29d8d4a@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 25 Apr 2023 16:05:36 +0800
Message-ID: <CA+WQbwseXZ_6-TbbfuQ3gcnM3swz6kdnS54JqLN7eXCEE0kr4Q@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v8 3/5] mptcp: add addr into userspace pm list
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B44=E6=
=9C=8821=E6=97=A5=E5=91=A8=E4=BA=94 22:17=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 20/04/2023 05:11, Geliang Tang wrote:
> > Add the address into userspace_pm_local_addr_list when the subflow is
> > created. And delete it in mptcp_nl_cmd_sf_destroy().
>
> I'm sorry to insist but can you explain the reason(s) why you need to
> add addresses into the list? Is it to be able to send a RM_ADDR for a
> previously used subflow?
>
>   By doing that, the "REMOVE" command also works with subflows that have
>   been created via the "SUB_CREATE" command instead of restricting to
>   the addresses that have been announced via the "ANNOUNCE" command.
>
>   (...)
>
>   Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
>   Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379

Updated in v9.

>
> > A non-zero address id is needed in this case. So don't clear the addr
> > id in mptcp_userspace_pm_get_local_id(), clear it in
> > mptcp_pm_nl_get_local_id() instead.
>
> >
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  net/mptcp/pm_netlink.c   |  2 +-
> >  net/mptcp/pm_userspace.c | 19 ++++++++++++++++++-
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index d85649bc27e2..bb237abb99bb 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -1055,8 +1055,8 @@ static int mptcp_pm_nl_create_listen_socket(struc=
t sock *sk,
> >
> >  int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_commo=
n *skc)
> >  {
> > +     struct mptcp_addr_info skc_local =3D { 0 };
> >       struct mptcp_pm_addr_entry *entry;
> > -     struct mptcp_addr_info skc_local;
> >       struct mptcp_addr_info msk_local;
> >       struct pm_nl_pernet *pernet;
> >       int ret =3D -1;
> > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > index 6beadea8c67d..a1f8d2fab08d 100644
> > --- a/net/mptcp/pm_userspace.c
> > +++ b/net/mptcp/pm_userspace.c
> > @@ -113,7 +113,6 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_so=
ck *msk,
> >
> >       memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
> >       new_entry.addr =3D *skc;
> > -     new_entry.addr.id =3D 0;
> >       new_entry.flags =3D MPTCP_PM_ADDR_FLAG_IMPLICIT;
> >
> >       if (new_entry.addr.port =3D=3D msk_sport)
> > @@ -302,6 +301,12 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, st=
ruct genl_info *info)
> >               goto create_err;
> >       }
> >
> > +     err =3D mptcp_userspace_pm_get_local_id(msk, &addr_l);
>
> The name is not very clear: It adds the address into
> userspace_pm_local_addr_list, right?
> If yes, please add a comment above (or rename the function).
>
> Why can you not call mptcp_userspace_pm_append_new_local_addr() directly?

Yes, mptcp_userspace_pm_append_new_local_addr is much better. Updated in v9=
.

>
> > +     if (err < 0) {
> > +             GENL_SET_ERR_MSG(info, "did not match address and id");
> > +             goto create_err;
> > +     }
> > +
> >       lock_sock(sk);
> >
> >       err =3D __mptcp_subflow_connect(sk, &addr_l, &addr_r);
>
> In case of error, I guess you should remove the entry from the list, no?
>
> And when the subflow is deleted from the other side, no?

Updated in v9.

>
> > @@ -420,6 +425,18 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, s=
truct genl_info *info)
> >       ssk =3D mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
> >       if (ssk) {
> >               struct mptcp_subflow_context *subflow =3D mptcp_subflow_c=
tx(ssk);
> > +             struct mptcp_pm_addr_entry *entry, *tmp;
> > +
> > +             spin_lock_bh(&msk->pm.lock);
> > +             list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_p=
m_local_addr_list, list) {
> > +                     if (mptcp_addresses_equal(&entry->addr, &addr_l, =
false) &&
> > +                         msk->pm.subflows =3D=3D 1) {
>
> Why did you add "msk->pm.subflows =3D=3D 1"? It looks like a workaround b=
ut
> not a proper solution :)
>
> Should you not instead add a refcount in "struct mptcp_pm_addr_entry"?

I still use this workaround in v9. Let's add the recount in future.

>
> > +                             list_del_rcu(&entry->list);
> > +                             kfree(entry);
> > +                             break;
> > +                     }
> > +             }
> > +             spin_unlock_bh(&msk->pm.lock);
> >
> >               mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTD=
OWN);
> >               mptcp_close_ssk(sk, ssk, subflow);
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
