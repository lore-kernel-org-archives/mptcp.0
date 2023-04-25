Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7FC7B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 08:07:27 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f1957e80a2so104046335e9.1
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 01:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682410045; x=1685002045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSpb1zaBURviR2pyI194TKhII7GDMZV30WmBQ1uUAmQ=;
        b=SqvgO5l+w4QbHvVhqovp6or4Q2ueJRBs6br1LwiiVLkRodMbLKknUBH5VECmXPlSrH
         arbku8+fY6Ge0RMgNopnGqUuEEgljOilBzBzm5hm/38l4okfsp/21M8AMpONGXKGBB9C
         qQlBzityBrKQe12LJleUV8JrxR9YDMhJ5m0MKQRKpKgGHZJnFQ2F+UTe3A91nWgrJluH
         9Wgp5NcFoelkirDQUCqOWDjiQRNVWqReh5Qn9Yen/azSz5FmqOJ1Sr6utic4MaJX+pnO
         TUofijeM6SB8PsJR84N72lv9ervXTIsFraX/qW+IoPKVsj8xlEOgs28Uq+p7MS+ak65l
         lEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682410045; x=1685002045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSpb1zaBURviR2pyI194TKhII7GDMZV30WmBQ1uUAmQ=;
        b=IWvEOJubRGH9qNsTeTtJtZUdK3RCYcD+flv4gdN5yiUrSaMgGDZXdW+F3yPXi+mmQ7
         EfSjOoKOjEBuPBPHsTj1H0YHJ6vYNS52klmfE3UUhZM0O7982E0Y7Kjjbq3v9u1N0XUj
         X+dtVATuzQst5HyvmcLpy6DaB3a24hdp7DxArusV0FF9KLoDrzblRXo777GZK/8XKLCb
         hrkPxBBcvAw44Y+ybuXcCCSKlmdziFzmB5FT+SBXDhagus3NSM8VhXoqJjvMtYzpsxvq
         GhL1r7XtHe+aTn9XhuBabd9+7JXBFrP43KCDRUL1E/8YpOaMa2EoOALHpyp7fzCARMW2
         UXRw==
X-Gm-Message-State: AAQBX9dqg/4WBZW4x2mHvpAjkZvFivqgKLLZMe1sviFAVmGn4k/zYd73
	aW3eJgFrKfDdNSfrvH7tijU22KyKLzmlmq2W0ds=
X-Google-Smtp-Source: AKy350Ydu3a+1OE4GmmDKq8kULH32jFDjNfsNld8Y8vkkr9u116WIQ4QNqKex9JOEI5gHUF1xXWxU2ngGIl7sBXlIbQ=
X-Received: by 2002:a05:600c:1e08:b0:3f1:7b29:ab38 with SMTP id
 ay8-20020a05600c1e0800b003f17b29ab38mr9691910wmb.11.1682410045116; Tue, 25
 Apr 2023 01:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1681960259.git.geliang.tang@suse.com> <15a683ff3b3bd04870b0739854ffdd8c01067a76.1681960259.git.geliang.tang@suse.com>
 <812a0ac7-5a13-bf1d-762e-3946b4532ea9@tessares.net>
In-Reply-To: <812a0ac7-5a13-bf1d-762e-3946b4532ea9@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 25 Apr 2023 16:07:17 +0800
Message-ID: <CA+WQbws7h+AYMx_WFWEN5W1_k7fcskcP=Hva-xrKzGzp3Uo+6Q@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v8 4/5] mptcp: add addr into pm anno_list
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
> > Pass addr parameter to mptcp_pm_alloc_anno_list() instead of entry.
> >
> > Export remove_anno_list_by_saddr().
> >
> > Add address into pm anno_list in mptcp_nl_cmd_sf_create(). Remove
> > it when connecting fails.
>
> I'm sorry to insist but here you only described what the new code is
> doing but you didn't explain why you did that: is it to fix an issue?
>
> Please add a "Fixes" and a "Link" like in the previous patch.

Updated in v9.

>
> Also, I think it was fine (and even better) to pass addr parameter to
> mptcp_pm_alloc_anno_list() instead of entry in a dedicated commit. What
> was missing was the reason, e.g. this is needed for the following commit
> to be able to (...)

This mptcp_pm_alloc_anno_list() code is dropped now.

>
> >
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  net/mptcp/pm_netlink.c   | 12 ++++++------
> >  net/mptcp/pm_userspace.c | 15 ++++++++++++++-
> >  net/mptcp/protocol.h     |  4 +++-
> >  3 files changed, 23 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index bb237abb99bb..d03c60f54085 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -342,7 +342,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> >  }
> >
> >  bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
> > -                           const struct mptcp_pm_addr_entry *entry)
> > +                           const struct mptcp_addr_info *addr)
> >  {
> >       struct mptcp_pm_add_entry *add_entry =3D NULL;
> >       struct sock *sk =3D (struct sock *)msk;
> > @@ -350,7 +350,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *ms=
k,
> >
> >       lockdep_assert_held(&msk->pm.lock);
> >
> > -     add_entry =3D mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
> > +     add_entry =3D mptcp_lookup_anno_list_by_saddr(msk, addr);
> >
> >       if (add_entry) {
> >               if (mptcp_pm_is_kernel(msk))
> > @@ -367,7 +367,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *ms=
k,
> >
> >       list_add(&add_entry->list, &msk->pm.anno_list);
> >
> > -     add_entry->addr =3D entry->addr;
> > +     add_entry->addr =3D *addr;
> >       add_entry->sock =3D msk;
> >       add_entry->retrans_times =3D 0;
> >
> > @@ -574,7 +574,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(=
struct mptcp_sock *msk)
> >                       return;
> >
> >               if (local) {
> > -                     if (mptcp_pm_alloc_anno_list(msk, local)) {
> > +                     if (mptcp_pm_alloc_anno_list(msk, &local->addr)) =
{
> >                               __clear_bit(local->addr.id, msk->pm.id_av=
ail_bitmap);
> >                               msk->pm.add_addr_signaled++;
> >                               mptcp_pm_announce_addr(msk, &local->addr,=
 false);
> > @@ -1399,8 +1399,8 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct m=
ptcp_sock *msk, unsigned int id
> >       return 0;
> >  }
> >
> > -static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
> > -                                   const struct mptcp_addr_info *addr)
> > +bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
> > +                            const struct mptcp_addr_info *addr)
> >  {
> >       struct mptcp_pm_add_entry *entry;
> >
> > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > index a1f8d2fab08d..8c050c118ba9 100644
> > --- a/net/mptcp/pm_userspace.c
> > +++ b/net/mptcp/pm_userspace.c
> > @@ -169,7 +169,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, stru=
ct genl_info *info)
> >       lock_sock((struct sock *)msk);
> >       spin_lock_bh(&msk->pm.lock);
> >
> > -     if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
> > +     if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
> >               mptcp_pm_announce_addr(msk, &addr_val.addr, false);
> >               mptcp_pm_nl_addr_send_ack(msk);
> >       }
> > @@ -307,12 +307,25 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, s=
truct genl_info *info)
> >               goto create_err;
> >       }
> >
> > +     spin_lock_bh(&msk->pm.lock);
> > +     if (!mptcp_pm_alloc_anno_list(msk, &addr_l)) {
> > +             spin_unlock_bh(&msk->pm.lock);
> > +             goto create_err;
> > +     }
> > +     spin_unlock_bh(&msk->pm.lock);
> > +
> >       lock_sock(sk);
> >
> >       err =3D __mptcp_subflow_connect(sk, &addr_l, &addr_r);
> >
> >       release_sock(sk);
> >
> > +     if (err) {
> > +             spin_lock_bh(&msk->pm.lock);
> > +             remove_anno_list_by_saddr(msk, &addr_l);
> > +             spin_unlock_bh(&msk->pm.lock);
> > +     }
> > +
> >   create_err:
> >       sock_put((struct sock *)msk);
> >       return err;
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 1a2772902e9d..b3942d15ade7 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -822,7 +822,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock =
*msk,
> >                                struct mptcp_addr_info *rem,
> >                                u8 bkup);
> >  bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
> > -                           const struct mptcp_pm_addr_entry *entry);
> > +                           const struct mptcp_addr_info *addr);
> >  void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
> >  bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct =
sock *sk);
> >  struct mptcp_pm_add_entry *
> > @@ -837,6 +837,8 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mpt=
cp_sock *msk,
> >  int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *=
msk,
> >                                                  unsigned int id,
> >                                                  u8 *flags, int *ifinde=
x);
> > +bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
>
> Please prefix the newly exported function with mptcp_pm_

Updated in v9.

>
> Also, can you not declare it in the middle of the userspace ones?
> Maybe around mptcp_pm_alloc_anno_list() or between
> mptcp_pm_get_flags_and_ifindex_by_id() and
> mptcp_pm_remove_addrs_and_subflows()?

Updated in v9.

>
> Cheers,
> Matt
>
> > +                            const struct mptcp_addr_info *addr);
> >  int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token=
,
> >                                struct mptcp_pm_addr_entry *loc,
> >                                struct mptcp_pm_addr_entry *rem, u8 bkup=
);
>
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
